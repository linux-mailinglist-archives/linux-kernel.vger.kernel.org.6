Return-Path: <linux-kernel+bounces-186514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3A8CC51E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6821C217E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556811420C8;
	Wed, 22 May 2024 16:49:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359F7D3EF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396588; cv=none; b=sAhDUGsklcYXfIyEhcShtUJuqkQ/D/ijpWs6xBdwP1Q7qcPcgBm6m7csGdpb2e/IzbyqBvWp3ElzdR/Gg/Kno75Wd0nm1j+fzts4c9FVnmMe/k4KPZr72YaLIGNCg07uGgDmUueJDfSIDhAbMyQ8MseiT8pNDLW1eRbmb3S4FKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396588; c=relaxed/simple;
	bh=/KhFpgQrMtYdBgS18PjEezGY4NB0p3+yEjpcCoJWZLY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VQP4GMlEZS4aHcPcGuaazhFA99ub4bi5K6SHS6O9lPPp5E32nVU7oBmKzjPTu9/tM7FStxYYC6krSSIDuTnjFbuC9CD4nNhkY/3HnKM43+gdeWHE2lbdfmOwJoVo6MxQ3ohhYrGQ+ia3EUcwG56EJipaAlVQMZkQy7jNIO0AFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91392C2BD11;
	Wed, 22 May 2024 16:49:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9pAd-00000006HPd-3C9y;
	Wed, 22 May 2024 12:50:31 -0400
Message-ID: <20240522165031.624864160@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:49:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] eventfs: Consolidate the eventfs_inode update in eventfs_get_inode()
References: <20240522164942.590663963@goodmis.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 42 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5dfb1ccd56ea..fb0fcd419805 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -394,6 +394,25 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
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
@@ -414,7 +433,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 				  void *data,
 				  const struct file_operations *fop)
 {
-	struct tracefs_inode *ti;
 	struct inode *inode;
 
 	if (!(mode & S_IFMT))
@@ -423,13 +441,11 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
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
@@ -437,9 +453,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	/* All files will have the same inode number */
 	inode->i_ino = EVENTFS_FILE_INODE_INO;
 
-	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
-
 	// Files have their parent's ei as their fsdata
 	dentry->d_fsdata = get_ei(parent_ei);
 
@@ -459,28 +472,19 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
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



