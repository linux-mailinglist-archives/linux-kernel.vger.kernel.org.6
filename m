Return-Path: <linux-kernel+bounces-184522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09658CA7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D1D282297
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227447A48;
	Tue, 21 May 2024 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrV12VBQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CF4654D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272607; cv=none; b=MnHP2x3BUPCg1YxddWUaUpDjyKPuCFfX6gUPDHdxPGIeiLF0S7SMciXxcK8zsMft38MmCEbcyypqS99lbj18qGJiep+RjqGXdIXVubmwph0ybxrs0lODw8OCko45EXz7Gla0JAiRVfyEoiNqibPnkqBqn7SILS5v3F3TypWw1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272607; c=relaxed/simple;
	bh=z2zWkZoAbBUOoRu9L0FDN+Y3ekt5ZHAk9uTFd+2UwXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVDCCzWPIjJ+pq7H3QynMrZBrSd1fFMpFnpW6BjpPGRMfaJfXgwduCtd6qHlhHIjQgbdqey2JAx01ZT8foQ9NBzrHtjUw0JhmsmYPlGatjeWt0Ll2bacVOa/3iBnP8TJbJFkTxn+IFF18mwJJDGrDmIYUBn1PE9dB62+02hyOiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrV12VBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0FFC32782;
	Tue, 21 May 2024 06:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716272605;
	bh=z2zWkZoAbBUOoRu9L0FDN+Y3ekt5ZHAk9uTFd+2UwXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrV12VBQSRy9OjwkVc63XQXS0bxwX4JLnUtwb6jy/PGHhcZMG6TOww20NBtrsHR1D
	 o2e+exiAAT9ALlQK8+S6KRCfVI+k2smDOCk+f1QiE/7MSyg1tTEzz3R2tb752UudDx
	 oDI7On0GnQAz5d0dJsaI3HMUDfFPL1MRyRzErLHP3LvMLu8qzwBZj++z4X45vTvIFE
	 03QHRIg+9DhFWeu5g/JPmmYpOoaEgEbaDPUTSTELPTGJuLiNFhRVVn57fhZX//Va4w
	 hrYfqlRjtvXAJcHJ7Fao0/pTdmk9o6e7cbqc5VkHoRNJ7pFihbFm8AVtwnSZ1DonQx
	 AGr0Mg6PltR/A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to do sanity check on blocks for inline_data inode
Date: Tue, 21 May 2024 14:23:18 +0800
Message-Id: <20240521062318.976239-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521062318.976239-1-chao@kernel.org>
References: <20240521062318.976239-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode can be fuzzed, so it can has F2FS_INLINE_DATA flag and valid
i_blocks/i_nid value, this patch supports to do extra sanity check
to detect such corrupted state.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h   |  2 +-
 fs/f2fs/inline.c | 20 +++++++++++++++++++-
 fs/f2fs/inode.c  |  2 +-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1974b6aff397..f463961b497c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4149,7 +4149,7 @@ extern struct kmem_cache *f2fs_inode_entry_slab;
  * inline.c
  */
 bool f2fs_may_inline_data(struct inode *inode);
-bool f2fs_sanity_check_inline_data(struct inode *inode);
+bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage);
 bool f2fs_may_inline_dentry(struct inode *inode);
 void f2fs_do_read_inline_data(struct folio *folio, struct page *ipage);
 void f2fs_truncate_inline_inode(struct inode *inode,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 7638d0d7b7ee..0203c3baabb6 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -33,11 +33,29 @@ bool f2fs_may_inline_data(struct inode *inode)
 	return !f2fs_post_read_required(inode);
 }
 
-bool f2fs_sanity_check_inline_data(struct inode *inode)
+static bool inode_has_blocks(struct inode *inode, struct page *ipage)
+{
+	struct f2fs_inode *ri = F2FS_INODE(ipage);
+	int i;
+
+	if (F2FS_HAS_BLOCKS(inode))
+		return true;
+
+	for (i = 0; i < DEF_NIDS_PER_INODE; i++) {
+		if (ri->i_nid[i])
+			return true;
+	}
+	return false;
+}
+
+bool f2fs_sanity_check_inline_data(struct inode *inode, struct page *ipage)
 {
 	if (!f2fs_has_inline_data(inode))
 		return false;
 
+	if (inode_has_blocks(inode, ipage))
+		return false;
+
 	if (!support_inline_data(inode))
 		return true;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 791c06e159fd..4b39aebd3c70 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -344,7 +344,7 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
-	if (f2fs_sanity_check_inline_data(inode)) {
+	if (f2fs_sanity_check_inline_data(inode, node_page)) {
 		f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_data, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
-- 
2.40.1


