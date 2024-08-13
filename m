Return-Path: <linux-kernel+bounces-284957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3828950753
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFAD1C22D29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38619E7F0;
	Tue, 13 Aug 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk2QQ8wP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9719E7DB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558436; cv=none; b=Iyebqaad/UsShAt2irogwouQxKFRkpdCUmmMAGnUAvkwMDne4jSCgLUFc/GED9RtPEY+qb9paiuASjViQpfv42XzCU+624rxLlV6YDz2KhF6hIYam8N1awUpu7mMO5Y8cRUNj30ANej8N+FDvBK4O5IRtDQtJwO0CgiJ97GTcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558436; c=relaxed/simple;
	bh=O7pw8vrwHsmRKsgyDC121Jnhb8Pog4l0udno2Rfx5N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwHotuM9X1Tw1/6+BFU6dFtm3mR3Er+hIVd2CkSHJsdIvzLYO5bGYmqQ5WSoJFUDJBBjOdfCcwDEa2xZ+K/aw0RaYx9xrCn31u0Tyd/nOQxJMYl+HvyASzmxNZ+3rctby88TSFNptlvhTuzK+Ngfy2qfDBcQR5P1WomRrk/28ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk2QQ8wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E4AC4AF15;
	Tue, 13 Aug 2024 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558436;
	bh=O7pw8vrwHsmRKsgyDC121Jnhb8Pog4l0udno2Rfx5N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dk2QQ8wPoosbvLg3UHkk0KZRRfPL+3OhTJB3QJvfzwZgmVX2wOIW2nDOmgCG/FfXH
	 22onUHZLrgYMlhhMUHd4lPUzN+wC9x30La1GVCGqIpd4fJbnNqm2Ep9zwgiecO+myb
	 9DievUR+BqDyjmwoOxV81W69bK0vaZKbtEG+8KWJN2t2ZoUQyfBbFf3lt3Wg5AtMAH
	 GWu4m2/nQpw8xT/JFxsKI64dB3bhgIk9UiA4g2/7oP/sNTNPfpNLF6+Br91lt+TU7f
	 89ApQROUK0Khm9dr3EIGLPTb2Zl2cn2AGCsKbl05axspxur/QHeQLcO15iqTqHJ2Nf
	 SJKKcx2Dnl0EQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 7/9] f2fs: convert __f2fs_write_meta_page() to use folio
Date: Tue, 13 Aug 2024 22:13:29 +0800
Message-Id: <20240813141331.417067-7-chao@kernel.org>
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
 fs/f2fs/checkpoint.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index d73d4d05313e..ffaf295a198a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -345,30 +345,31 @@ static int __f2fs_write_meta_page(struct page *page,
 				enum iostat_type io_type)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
+	struct folio *folio = page_folio(page);
 
-	trace_f2fs_writepage(page_folio(page), META);
+	trace_f2fs_writepage(folio, META);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 			dec_page_count(sbi, F2FS_DIRTY_META);
-			unlock_page(page);
+			folio_unlock(folio);
 			return 0;
 		}
 		goto redirty_out;
 	}
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
-	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
+	if (wbc->for_reclaim && folio->index < GET_SUM_BLOCK(sbi, 0))
 		goto redirty_out;
 
-	f2fs_do_write_meta_page(sbi, page_folio(page), io_type);
+	f2fs_do_write_meta_page(sbi, folio, io_type);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, META);
 
-	unlock_page(page);
+	folio_unlock(folio);
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		f2fs_submit_merged_write(sbi, META);
-- 
2.40.1


