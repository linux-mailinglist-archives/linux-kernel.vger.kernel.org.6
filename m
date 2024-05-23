Return-Path: <linux-kernel+bounces-188022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41588CDBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625C21F2453D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4298128801;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023C128366
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499401; cv=none; b=s756IR6gBTeJvYYHZ21IfvaorYnhcleHG6T1agkc29t3dZtyCZOFoGFWpzqa5ah3t7vHF0sB5kRvAHDsI5yFqW9ookewl4JAHR3mWcLujedWQPSLF3QPJ2F1JGXLuJgMhMCokL5I4Y4zOzl3+DsBhjgpvD4ZX+HryFDpYrHqcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499401; c=relaxed/simple;
	bh=+siZ2Hk8ib7KD+12oMbnGGoyuW6XrOeayeGP5/JEG+8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qG1Bk7pin0aOeIlvU8mMWKyPVK0AO4iJ8RRp2olavCF7NNEWD7Kw9MGQyfAa53LD4c4aliRrtaRYcaOFc/Rv/nHe7MfI2KWC1Nd9puAxr+RwcuAD1ta8yWqh3jlQEb+V4GjiQGPO2ZPf9FL5N+g3quWynkIlYACEy8qywXuXnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FC0C32789;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAFuw-00000006lAB-3g8s;
	Thu, 23 May 2024 17:24:06 -0400
Message-ID: <20240523212406.736741267@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 17:23:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 5/8] eventfs: Consolidate the eventfs_inode update in eventfs_get_inode()
References: <20240523212258.883756004@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

To simplify the code, create a eventfs_get_inode() that is used when an
eventfs file or directory is created. Have the internal tracefs_inode
updated the appropriate flags in this function and update the inode's
mode as well.

Link: https://lore.kernel.org/lkml/20240522165031.624864160@goodmis.org

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 42 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 129d0f54ba62..92987b5c8d9d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -412,6 +412,25 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 		inode->i_gid = attr->gid;
 }
 
+static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_attr *attr,
+				       umode_t mode,  struct eventfs_inode *ei)
+{
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (!inode)
+		return NULL;
+
+	ti = get_tracefs(inode);
+	ti->private = ei;
+	ti->flags |= TRACEFS_EVENT_INODE;
+
+	update_inode_attr(dentry, inode, attr, mode);
+
+	return inode;
+}
+
 /**
  * lookup_file - look up a file in the tracefs filesystem
  * @parent_ei: Pointer to the eventfs_inode that represents parent of the file
@@ -432,7 +451,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 				  void *data,
 				  const struct file_operations *fop)
 {
-	struct tracefs_inode *ti;
 	struct inode *inode;
 
 	if (!(mode & S_IFMT))
@@ -441,13 +459,11 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return ERR_PTR(-EIO);
 
-	inode = tracefs_get_inode(dentry->d_sb);
+	/* Only directories have ti->private set to an ei, not files */
+	inode = eventfs_get_inode(dentry, attr, mode, NULL);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	/* If the user updated the directory's attributes, use them */
-	update_inode_attr(dentry, inode, attr, mode);
-
 	inode->i_op = &eventfs_file_inode_operations;
 	inode->i_fop = fop;
 	inode->i_private = data;
@@ -455,9 +471,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	/* All files will have the same inode number */
 	inode->i_ino = EVENTFS_FILE_INODE_INO;
 
-	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
-
 	// Files have their parent's ei as their fsdata
 	dentry->d_fsdata = get_ei(parent_ei);
 
@@ -477,28 +490,19 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	struct eventfs_inode *pei, struct eventfs_inode *ei)
 {
-	struct tracefs_inode *ti;
 	struct inode *inode;
+	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 
-	inode = tracefs_get_inode(dentry->d_sb);
+	inode = eventfs_get_inode(dentry, &ei->attr, mode, ei);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	/* If the user updated the directory's attributes, use them */
-	update_inode_attr(dentry, inode, &ei->attr,
-			  S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
-
 	inode->i_op = &eventfs_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
 	/* All directories will have the same inode number */
 	inode->i_ino = eventfs_dir_ino(ei);
 
-	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
-	/* Only directories have ti->private set to an ei, not files */
-	ti->private = ei;
-
 	dentry->d_fsdata = get_ei(ei);
 
 	d_add(dentry, inode);
-- 
2.43.0



