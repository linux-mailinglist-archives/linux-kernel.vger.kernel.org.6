Return-Path: <linux-kernel+bounces-293209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C95957C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205FE2869E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536114A4EA;
	Tue, 20 Aug 2024 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/cCJGmq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD64149C55
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125634; cv=none; b=GPDG7aNPifzP9lXGo+jb3AE6+OoWZaT7D7cLqkLp4FTy11aDKCLUmMHAhYw62fS3VsIqVTBhHrRNFGG2HnKu2FvIeH0jPu9SnBEYocyWDzNYWfYTMxpVCy6BeF7lx+3jGjHjdczVcjKCNDhENqEMdcjFRBMUXPKXLbzeo0ntSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125634; c=relaxed/simple;
	bh=kXH69VauKPWX1aj+cT6JMgD13fkLJ9/JjHzU17y6Nko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IW3VD7ReUrtUeWjthir2I03Mscm/0EcotB8+IPavprjAwAg24CuxCmqW1b5Dgw53DcHsyxNkYv318wQWdZauC4DBAzP/2Y2coN0mqO8hCjpK/p8N2uALBciqdIiJFHQ2ClL5tdkZtfBuEU7h0Bn6WwvBz64bJIfymGh9vKmnmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/cCJGmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9104AC4AF0B;
	Tue, 20 Aug 2024 03:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724125634;
	bh=kXH69VauKPWX1aj+cT6JMgD13fkLJ9/JjHzU17y6Nko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/cCJGmqQ1oLhcscrEdTsDKuKu+hC+V6SkEVDcEpGJTTk9pW8rmGJF6pj8nX9VAim
	 +mWkyajtOxXLPdsBMIaTzt+Vqx9rKbi7l3pc1CXQHJsTcnMU4SLn6SwaX90PI6qeK3
	 BQK16sTOJnAle3+nkEboGXSIBqbt4ji2h77qbRQlgSHFteaOJnNa+MNZ5fHnmiNRIX
	 t6387ScKdnh2pqmjAh9JmUyQZY/Mjp3n1SZRztWAms+B7Lv2E71OEyV9niYxhN/iXz
	 CVjeJovRO75QSefMpznX2M6231txRQ/vXQe9oKz8s3b5vaf3be/NbwaICPkTuIEhez
	 Uia7WG1uPuuaw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 6/8] f2fs: convert __write_node_page() to use folio
Date: Tue, 20 Aug 2024 11:46:52 +0800
Message-Id: <20240820034654.698236-6-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820034654.698236-1-chao@kernel.org>
References: <20240820034654.698236-1-chao@kernel.org>
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


