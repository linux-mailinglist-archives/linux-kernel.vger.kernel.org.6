Return-Path: <linux-kernel+bounces-186515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA678CC520
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BB3282E46
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10CC1422B4;
	Wed, 22 May 2024 16:49:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818B1420B8
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396589; cv=none; b=o3/nqK0QV0FcjRBXlodxGPzfnj5Sg2pCImQHaM0Ty9/TGZUvzdRpOECiRMqXWojneFC7YYfLEjXcTGalKs5izqqP33xQSqMkSnOnuYYxGxORn3TU04kJtMAEL5znr8zMXKMgZ0DHPBR9RKrU7tHY+46UfEVIvEmf59Q3hJtYoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396589; c=relaxed/simple;
	bh=l9Z6DFgD29WeqBvjguG0hgppQw2bePbeYrC8d3jD1M4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gZejMCy8QSAAdIMzalkHnnaJgj0kVxemoYXdGouAFxGjP42WP3cVYfetxHxajUQoV726/8WZLx/qI6na85wJLUZg51AfMdfBSyUBdD+yeXCtuFYSrjzbx1e2ivEPdAyd+J3GvfWFEbPZPF8XPmLy0Y9YkVPBLTSz7wy8ZVmtUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0840AC2BBFC;
	Wed, 22 May 2024 16:49:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9pAe-00000006HQb-0MLX;
	Wed, 22 May 2024 12:50:32 -0400
Message-ID: <20240522165031.944088388@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:49:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] eventfs: Cleanup permissions in creation of inodes
References: <20240522164942.590663963@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The permissions being set during the creation of the inodes was updating
eventfs_inode attributes as well. Those attributes should only be touched
by the setattr or remount operations, not during the creation of inodes.
The eventfs_inode attributes should only be used to set the inodes and
should not be modified during the inode creation.

Simplify the code and fix the situation by:

 1) Removing the eventfs_find_events() and doing a simple lookup for
    the events descriptor in eventfs_get_inode()

 2) Remove update_events_attr() as the attributes should only be used
    to update the inode and should not be modified here.

 3) Add update_inode_attr() that uses the attributes to determine what
    the inode permissions should be.

 4) As the parent_inode of the eventfs_root_inode structure is no longer
    needed, remove it.

Now on creation, the inode gets the proper permissions without causing
side effects to the ei->attr field.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 90 ++++++++++------------------------------
 1 file changed, 23 insertions(+), 67 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4af6380eb236..7673532b5a5e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -37,7 +37,6 @@ static DEFINE_MUTEX(eventfs_mutex);
 
 struct eventfs_root_inode {
 	struct eventfs_inode		ei;
-	struct inode			*parent_inode;
 	struct dentry			*events_dir;
 };
 
@@ -229,27 +228,6 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return ret;
 }
 
-static void update_events_attr(struct eventfs_inode *ei, struct super_block *sb)
-{
-	struct eventfs_root_inode *rei;
-	struct inode *parent;
-
-	rei = get_root_inode(ei);
-
-	/* Use the parent inode permissions unless root set its permissions */
-	parent = rei->parent_inode;
-
-	if (rei->ei.attr.mode & EVENTFS_SAVE_UID)
-		ei->attr.uid = rei->ei.attr.uid;
-	else
-		ei->attr.uid = parent->i_uid;
-
-	if (rei->ei.attr.mode & EVENTFS_SAVE_GID)
-		ei->attr.gid = rei->ei.attr.gid;
-	else
-		ei->attr.gid = parent->i_gid;
-}
-
 static const struct inode_operations eventfs_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
 	.setattr	= eventfs_set_attr,
@@ -303,60 +281,30 @@ void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
 	}
 }
 
-/* Return the evenfs_inode of the "events" directory */
-static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
+static void update_inode_attr(struct inode *inode, umode_t mode,
+			      struct eventfs_attr *attr, struct eventfs_root_inode *rei)
 {
-	struct eventfs_inode *ei;
-
-	do {
-		// The parent is stable because we do not do renames
-		dentry = dentry->d_parent;
-		// ... and directories always have d_fsdata
-		ei = dentry->d_fsdata;
-
-		/*
-		 * If the ei is being freed, the ownership of the children
-		 * doesn't matter.
-		 */
-		if (ei->is_freed)
-			return NULL;
-
-		// Walk upwards until you find the events inode
-	} while (!ei->is_events);
-
-	update_events_attr(ei, dentry->d_sb);
-
-	return ei;
-}
-
-static void update_inode_attr(struct dentry *dentry, struct inode *inode,
-			      struct eventfs_attr *attr, umode_t mode)
-{
-	struct eventfs_inode *events_ei = eventfs_find_events(dentry);
-
-	if (!events_ei)
-		return;
-
-	inode->i_mode = mode;
-	inode->i_uid = events_ei->attr.uid;
-	inode->i_gid = events_ei->attr.gid;
-
-	if (!attr)
-		return;
-
-	if (attr->mode & EVENTFS_SAVE_MODE)
+	if (attr && attr->mode & EVENTFS_SAVE_MODE)
 		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
+	else
+		inode->i_mode = mode;
 
-	if (attr->mode & EVENTFS_SAVE_UID)
+	if (attr && attr->mode & EVENTFS_SAVE_UID)
 		inode->i_uid = attr->uid;
+	else
+		inode->i_uid = rei->ei.attr.uid;
 
-	if (attr->mode & EVENTFS_SAVE_GID)
+	if (attr && attr->mode & EVENTFS_SAVE_GID)
 		inode->i_gid = attr->gid;
+	else
+		inode->i_gid = rei->ei.attr.gid;
 }
 
 static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_attr *attr,
 				       umode_t mode,  struct eventfs_inode *ei)
 {
+	struct eventfs_root_inode *rei;
+	struct eventfs_inode *pei;
 	struct tracefs_inode *ti;
 	struct inode *inode;
 
@@ -368,7 +316,16 @@ static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_att
 	ti->private = ei;
 	ti->flags |= TRACEFS_EVENT_INODE;
 
-	update_inode_attr(dentry, inode, attr, mode);
+	/* Find the top dentry that holds the "events" directory */
+	do {
+		dentry = dentry->d_parent;
+		/* Directories always have d_fsdata */
+		pei = dentry->d_fsdata;
+	} while (!pei->is_events);
+
+	rei = get_root_inode(pei);
+
+	update_inode_attr(inode, mode, attr, rei);
 
 	return inode;
 }
@@ -805,7 +762,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	// Note: we have a ref to the dentry from tracefs_start_creating()
 	rei = get_root_inode(ei);
 	rei->events_dir = dentry;
-	rei->parent_inode = d_inode(dentry->d_sb->s_root);
 
 	ei->entries = entries;
 	ei->nr_entries = size;
-- 
2.43.0



