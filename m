Return-Path: <linux-kernel+bounces-284956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46F950752
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87161281A68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C12619DFA7;
	Tue, 13 Aug 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cENiMq50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402419DF97
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558434; cv=none; b=EpnQU9zsVCL3ViZzDG1kYqGOIXE0NMJEzpgg++gOZaHDBi2b8ZlfIG5vSGTXwj7T5TujgUUt8m0NMhkuNw+sEo5xF1JkkjhoJ2yKPDrpd2EYM0MMaZF/9CjMPtFTZ1m6dAs7np5dctZybm3YzlYQn5d9bq9YGpotrFgH1dcBNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558434; c=relaxed/simple;
	bh=zSV7Y8/YinzwLLmItU/Jrj8HlYLGg1vRnshuh+Net40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKm0tiIlighF345ptb19maY1570RaPrq0L4FBHYL0vz3z7pPSyfVITaYiubJ2Uyc22VSrykqP3B02beX/jFGINa9rqfQ8RTK4GYwcYMTOwqmXWDQ0NjeZierzXWLEMXAA+enxFhuBG6uC+7Dd6nDxoDw7ymvo+R3wYdftoFQ1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cENiMq50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06D3C4AF09;
	Tue, 13 Aug 2024 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558434;
	bh=zSV7Y8/YinzwLLmItU/Jrj8HlYLGg1vRnshuh+Net40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cENiMq50qkOxvacUzSIJQ0H3mYQZqwrwZCRVGoYN/NYxAR4585QmwPv2X6oIP25Ab
	 +B76atRtnt0i0vPyV7ey+Chz74u3vxo+tQq8F0t1Qe4xkPzWm3Q1mfOutV+68ZHGfL
	 gL3LAax+IAfoYEUZrQJds2PqTvQDUgxE6F4KPVpR6JhwYjPtXgX52lpn8OTmbbqsHZ
	 IWI+Ak0DCF4/y0cNtJ3ssz4YxBbN0FfnDQwRKH129F8CMspElDySjW1R+AThPzK9Gn
	 i8EdSn8PIad5ggpkQmwCoImIan/FSUPZrogTJO1c6XfIUmXgDv6iWJ0lPsUMtg6z9y
	 1skICs8iQDGcg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 6/9] f2fs: convert f2fs_do_write_meta_page() to use folio
Date: Tue, 13 Aug 2024 22:13:28 +0800
Message-Id: <20240813141331.417067-6-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>
References: <20240813141331.417067-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/segment.c    | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f3d22b8ef2ff..d73d4d05313e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -362,7 +362,7 @@ static int __f2fs_write_meta_page(struct page *page,
 	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
 		goto redirty_out;
 
-	f2fs_do_write_meta_page(sbi, page, io_type);
+	f2fs_do_write_meta_page(sbi, page_folio(page), io_type);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5800ac90a5f7..c29ed8b6eea6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3732,7 +3732,7 @@ bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 struct page *f2fs_get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno);
 void f2fs_update_meta_page(struct f2fs_sb_info *sbi, void *src,
 					block_t blk_addr);
-void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
+void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct folio *folio,
 						enum iostat_type io_type);
 void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio);
 void f2fs_outplace_write_data(struct dnode_of_data *dn,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 741e46f9d0fd..2d1965bed443 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3822,7 +3822,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		f2fs_up_read(&fio->sbi->io_order_lock);
 }
 
-void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
+void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct folio *folio,
 					enum iostat_type io_type)
 {
 	struct f2fs_io_info fio = {
@@ -3831,20 +3831,20 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 		.temp = HOT,
 		.op = REQ_OP_WRITE,
 		.op_flags = REQ_SYNC | REQ_META | REQ_PRIO,
-		.old_blkaddr = page->index,
-		.new_blkaddr = page->index,
-		.page = page,
+		.old_blkaddr = folio->index,
+		.new_blkaddr = folio->index,
+		.page = folio_page(folio, 0),
 		.encrypted_page = NULL,
 		.in_list = 0,
 	};
 
-	if (unlikely(page->index >= MAIN_BLKADDR(sbi)))
+	if (unlikely(folio->index >= MAIN_BLKADDR(sbi)))
 		fio.op_flags &= ~REQ_META;
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 	f2fs_submit_page_write(&fio);
 
-	stat_inc_meta_count(sbi, page->index);
+	stat_inc_meta_count(sbi, folio->index);
 	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE);
 }
 
-- 
2.40.1


