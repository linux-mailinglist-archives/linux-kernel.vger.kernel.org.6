Return-Path: <linux-kernel+bounces-551201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24AA5695A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F004218995DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D1521ADB7;
	Fri,  7 Mar 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FlwrBN6U"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D621A459
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355386; cv=none; b=Vh07C1Z/qsXHbbrXX61mKqtoI5CdDbq3j5OoTghY6cZpTEpvZTWylPQ4bTpS+sPg+PVavKlesstnijpBaL0lERhcdv+lXYrbOguMK/1pBO7pOHBgVTwx+kLK99x5IAqaisTa1wq/eBVi5jKJ6DW7mtmVX7+B1G9N8aOiEpALnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355386; c=relaxed/simple;
	bh=iqUZqMNZwCs/gqnoYp7jDJzINAsGqfxLoyvMoVunZo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktFV0IfOxrBqUel9tEWfVOOM0kDRm+aYb0nSBjmH6HcBeOuActK+vOXUCvCdf42/LtsUofB44Iiv18GnDdcg0q8pDc0kDszPkM7viXpMWQdD028HYbk714NfHNySwy2FvtZJ3bjFTnejA36bptJhwyUMntCLmfD6ZAs66N7iEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FlwrBN6U; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741355381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AksTGtuR6KF8fONDLpLWWigfgzOmf10rgW9ti3SLMsM=;
	b=FlwrBN6UGcsnS6kJUccauG85YURzDDC9h7rg54vbqr91eMBIim7TtTTybqym9iAMY3rBRS
	SUo6cquTCarWdbRbwjvZxFF4shO1gJzhZf70OtP/cSVu363HsSBPjIvy6JQHS5ODj9gGoB
	bR0qot/hFPXXak/Zc+oZfC05NzDLDYU=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/7] fs: export invalidate_inodes()
Date: Fri,  7 Mar 2025 08:49:25 -0500
Message-ID: <20250307134933.1033872-2-kent.overstreet@linux.dev>
In-Reply-To: <20250307134933.1033872-1-kent.overstreet@linux.dev>
References: <20250307134933.1033872-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Needed in bcachefs for implementing blk_holder_ops.mark_dead, since we
can't use the standard fs holder ops (whicth assume a single block device
filesystem).

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/inode.c         | 1 +
 fs/internal.h      | 1 -
 include/linux/fs.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5587aabdaa5e..6364779a7006 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -939,6 +939,7 @@ void invalidate_inodes(struct super_block *sb)
 
 	dispose_list(&dispose);
 }
+EXPORT_SYMBOL_GPL(invalidate_inodes);
 
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..7cb515cede3f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -207,7 +207,6 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
  * fs-writeback.c
  */
 extern long get_nr_dirty_inodes(void);
-void invalidate_inodes(struct super_block *sb);
 
 /*
  * dcache.c
diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f..5196317598ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3251,6 +3251,7 @@ extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
 extern unsigned int get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);
+extern void invalidate_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
-- 
2.47.2


