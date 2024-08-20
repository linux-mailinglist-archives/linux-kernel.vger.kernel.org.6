Return-Path: <linux-kernel+bounces-294177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA5958A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D068D28AD23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6BA194A42;
	Tue, 20 Aug 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN4P0Ef4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621D1946B3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165727; cv=none; b=UpXBOJb6Q14nV+x3/9/VTvrNGyqSVAEZZ90SWj4IPaGOmMSv88FhXnSZaGSZOhefMMdFfEom+Nk+nrEXaM/Ne4lkypOZHFXG1K7P2yJxzNXExKc5yoNMrK6u7Z5QccHkcN294h9EbHEtBCTzRLCbyhII4LGdd6hUvlLg3VoMQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165727; c=relaxed/simple;
	bh=kXH69VauKPWX1aj+cT6JMgD13fkLJ9/JjHzU17y6Nko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYup2ZJ9WP+j2OMFAIpJrl/5mUsNm69hxe676TCQTsDA3rq2gkENJ7LP2Y3fljHJaulAKj5cfRmP0tHFFGDXLL3JdkwHEra6//9Dkte/HSC2fzKpHpVB9CWwoeN6wSPkxTqhhw4igSfykmJmFlXeaP4xD8x4XO3OKjGLN2a8OVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN4P0Ef4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB95C4AF0C;
	Tue, 20 Aug 2024 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165727;
	bh=kXH69VauKPWX1aj+cT6JMgD13fkLJ9/JjHzU17y6Nko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN4P0Ef4pPnjn9ejoENvDu9FM0V+enTyCspFPJWLIT4LKUb3GcpxjsAYw3QgCqThA
	 +nX4KS1qmKRzcE0CHHxtb3PiiSqh9A8op00Ds2q2chD8XiLCDRZLRT/dunXFXwbVKA
	 9oYaAuQcRbba7Fvv+W68f0ujunEQiI9m6ikedBxRaYM0hOw1RYEh8WCxNVuxWU7AHf
	 ds/U9HR8WcF4wwqiay3iGJSmhG+v5oxQ79UQmvJpvrraQ1L9fY9WUJN9VazP9IlBkB
	 vnEMxAABWw9PqHEnIlzYoV4iromWWUSypEtAQnsbTYxYPOM1XsvqxT/kwphd9nEMT+
	 RMTvffIDcOMGA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 7/9] f2fs: convert __write_node_page() to use folio
Date: Tue, 20 Aug 2024 22:55:05 +0800
Message-Id: <20240820145507.1372905-7-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
References: <20240820145507.1372905-1-chao@kernel.org>
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
 fs/f2fs/node.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7beaa3690e03..aeda3eecc9e2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1608,6 +1608,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 				enum iostat_type io_type, unsigned int *seq_id)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
+	struct folio *folio = page_folio(page);
 	nid_t nid;
 	struct node_info ni;
 	struct f2fs_io_info fio = {
@@ -1624,15 +1625,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	};
 	unsigned int seq;
 
-	trace_f2fs_writepage(page_folio(page), NODE);
+	trace_f2fs_writepage(folio, NODE);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		/* keep node pages in remount-ro mode */
 		if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
 			goto redirty_out;
-		ClearPageUptodate(page);
+		folio_clear_uptodate(folio);
 		dec_page_count(sbi, F2FS_DIRTY_NODES);
-		unlock_page(page);
+		folio_unlock(folio);
 		return 0;
 	}
 
@@ -1646,7 +1647,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
-	f2fs_bug_on(sbi, page->index != nid);
+	f2fs_bug_on(sbi, folio->index != nid);
 
 	if (f2fs_get_node_info(sbi, nid, &ni, !do_balance))
 		goto redirty_out;
@@ -1660,10 +1661,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	/* This page is already truncated */
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
-		ClearPageUptodate(page);
+		folio_clear_uptodate(folio);
 		dec_page_count(sbi, F2FS_DIRTY_NODES);
 		f2fs_up_read(&sbi->node_write);
-		unlock_page(page);
+		folio_unlock(folio);
 		return 0;
 	}
 
@@ -1684,7 +1685,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 			*seq_id = seq;
 	}
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 
 	fio.old_blkaddr = ni.blk_addr;
 	f2fs_do_write_node_page(nid, &fio);
@@ -1697,7 +1698,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		submitted = NULL;
 	}
 
-	unlock_page(page);
+	folio_unlock(folio);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_write(sbi, NODE);
@@ -1711,7 +1712,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	return 0;
 
 redirty_out:
-	redirty_page_for_writepage(wbc, page);
+	folio_redirty_for_writepage(wbc, folio);
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-- 
2.40.1


