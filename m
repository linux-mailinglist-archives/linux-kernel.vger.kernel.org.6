Return-Path: <linux-kernel+bounces-188050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9718CDC40
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFC21C20982
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308B127E22;
	Thu, 23 May 2024 21:43:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B26101E2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500616; cv=none; b=ILo8pv5YUSkCMzEJVXAbr7GlvCQV73NZJ5CAWkX8WqSg0uEvnQCOdPEWCe/I2JxS/+WkvzwaElPZYN9aC1O72aVh0q/baWs9gNuPJRC4R2JiFcQCegYfmV4ToIVkKB+BOctGdC8MFYovK9KQ42yJxtTeW/6xQq6IveIPKJYEprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500616; c=relaxed/simple;
	bh=mqSXq2SOODtmeeZOJoJ2rQIOgvP7jiztGQl9wKxaMEI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tbZUSoLn0ANB5aKiZkYakeTjNXrvHdf8hU9pp5bHUU9g1jggKh+1Ry0dokDDKbiiDI5y2qN57U4wLbFjsdlm8wkYSHlwU0dhFVecITuwqW12lUUjBsfhUd3NUMDwbzaqStY6zqrd/INWLItpXKEKnKhGfVB53l+ksRGLsaT6Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C39AC2BD10;
	Thu, 23 May 2024 21:43:35 +0000 (UTC)
Date: Thu, 23 May 2024 17:44:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: [GIT PULL] tracefs/eventfs: Fixes and cleanups for v6.10
Message-ID: <20240523174419.1e5885a5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

[
  At the beginning of this week, Masahiro Yamada reported a regression
  again in running the ownership selftest where the first run would
  succeed but a subsequent run would fail. This was fixed before but
  another fix broke it again (I've sent a patch to run that test twice by
  default to prevent the regression from happening again).

  In the process of debugging it, I spent a lot of time cleaning up the
  eventfs permission code, removing functions and simplifying it. Then when
  I finally found the bug, it had nothing to do with the code I was working
  on.

  The first 4 commits fix the bug, but because I actually like the clean
  ups made while debugging it as it made it simpler and removed code, where
  the diffstat of the last 4 commits is:

    1 file changed, 46 insertions(+), 126 deletions(-)

  I decided to include it in this pull request. But I admit, this work was
  started on the second week of the merge window. I'll let you decide if
  you want to take this merge request or not. If not, I'll happily create a
  new tag with only the first 4 commits and save this for the next merge
  window. But honestly, I feel more comfortable with the new changes than
  the existing code.
]

tracefs/eventfs fixes and updates for v6.10:

Bug fixes:

- The eventfs directories need to have unique inode numbers. Make sure that
  they do not get the default file inode number.

- Update the inode uid and gid fields on remount.
  When a remount happens where a uid and/or gid is specified, all the tracefs
  files and directories should get the specified uid and/or gid. But this
  can be sporadic when some uids were assigned already. There's already
  a list of inodes that are allocated. Just update their uid and gid fields
  at the time of remount.

- Update the eventfs_inodes on remount from the top level "events" descriptor.
  There was a bug where not all the eventfs files or directories where
  getting updated on remount. One fix was to clear the SAVED_UID/GID
  flags from the inode list during the iteration of the inodes during
  the remount. But because the eventfs inodes can be freed when the last
  referenced is released, not all the eventfs_inodes were being updated.
  This lead to the ownership selftest to fail if it was run a second
  time (the first time would leave eventfs_inodes with no corresponding
  tracefs_inode).

  Instead, for eventfs_inodes, only process the "events" eventfs_inode
  from the list iteration, as it is guaranteed to have a tracefs_inode
  (it's never freed while the "events" directory exists). As it has
  a list of its children, and the children have a list of their children,
  just iterate all the eventfs_inodes from the "events" descriptor and
  it is guaranteed to get all of them.

- Clear the EVENT_INODE flag from the tracefs_drop_inode() callback.
  Currently the EVENTFS_INODE FLAG is cleared in the tracefs_d_iput()
  callback. But this is the wrong location. The iput() callback is
  called when the last reference to the dentry inode is hit. There could
  be a case where two dentry's have the same inode, and the flag will
  be cleared prematurely. The flag needs to be cleared when the last
  reference of the inode is dropped and that happens in the inode's
  drop_inode() callback handler.

Clean ups:

- Consolidate the creation of a tracefs_inode for an eventfs_inode
  A tracefs_inode is created for both files and directories of the
  eventfs system. It is open coded. Instead, consolidate it into a
  single eventfs_get_inode() function call.

- Remove the eventfs getattr and permission callbacks.
  The permissions for the eventfs files and directories are updated
  when the inodes are created, on remount, and when the user sets
  them (via setattr). The inodes hold the current permissions so
  there is no need to have custom getattr or permissions callbacks
  as they will more likely cause them to be incorrect. The inode's
  permissions are updated when they should be updated. Remove the
  getattr and permissions inode callbacks.

- Do not update eventfs_inode attributes on creation of inodes.
  The eventfs_inodes attribute field is used to store the permissions
  of the directories and files for when their corresponding inodes
  are freed and are created again. But when the creation of the inodes
  happen, the eventfs_inode attributes are recalculated. The
  recalculation should only happen when the permissions change for
  a given file or directory. Currently, the attribute changes are
  just being set to their current files so this is not a bug, but
  it's unnecessary and error prone. Stop doing that.

- The events directory inode is created once when the events directory
  is created and deleted when it is deleted. It is now updated on
  remount and when the user changes the permissions. There's no need
  to use the eventfs_inode of the events directory to store the
  events directory permissions. But using it to store the default
  permissions for the files within the directory that have not been
  updated by the user can simplify the code.


Please pull the latest trace-tracefs-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tracefs-v6.10

Tag SHA1: 2d8ea7f64b455ec3d0eb2beb0b9e09e893c303f2
Head SHA1: 2dd00ac1d38afba1b59e439abc300a9b0ce696bf


Steven Rostedt (Google) (8):
      eventfs: Keep the directories from having the same inode number as files
      tracefs: Update inode permissions on remount
      eventfs: Update all the eventfs_inodes from the events descriptor
      tracefs: Clear EVENT_INODE flag in tracefs_drop_inode()
      eventfs: Consolidate the eventfs_inode update in eventfs_get_inode()
      eventfs: Remove getattr and permission callbacks
      eventfs: Cleanup permissions in creation of inodes
      eventfs: Do not use attributes for events directory

----
 fs/tracefs/event_inode.c | 223 ++++++++++++++++++-----------------------------
 fs/tracefs/inode.c       |  48 ++++++----
 2 files changed, 116 insertions(+), 155 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0256afdd4acf..5d88c184f0fc 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -37,7 +37,6 @@ static DEFINE_MUTEX(eventfs_mutex);
 
 struct eventfs_root_inode {
 	struct eventfs_inode		ei;
-	struct inode			*parent_inode;
 	struct dentry			*events_dir;
 };
 
@@ -50,8 +49,12 @@ static struct eventfs_root_inode *get_root_inode(struct eventfs_inode *ei)
 /* Just try to make something consistent and unique */
 static int eventfs_dir_ino(struct eventfs_inode *ei)
 {
-	if (!ei->ino)
+	if (!ei->ino) {
 		ei->ino = get_next_ino();
+		/* Must not have the file inode number */
+		if (ei->ino == EVENTFS_FILE_INODE_INO)
+			ei->ino = get_next_ino();
+	}
 
 	return ei->ino;
 }
@@ -207,7 +210,9 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * determined by the parent directory.
 	 */
 	if (dentry->d_inode->i_mode & S_IFDIR) {
-		update_attr(&ei->attr, iattr);
+		/* Just use the inode permissions for the events directory */
+		if (!ei->is_events)
+			update_attr(&ei->attr, iattr);
 
 	} else {
 		name = dentry->d_name.name;
@@ -225,70 +230,9 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
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
-static void set_top_events_ownership(struct inode *inode)
-{
-	struct tracefs_inode *ti = get_tracefs(inode);
-	struct eventfs_inode *ei = ti->private;
-
-	/* The top events directory doesn't get automatically updated */
-	if (!ei || !ei->is_events)
-		return;
-
-	update_events_attr(ei, inode->i_sb);
-
-	if (!(ei->attr.mode & EVENTFS_SAVE_UID))
-		inode->i_uid = ei->attr.uid;
-
-	if (!(ei->attr.mode & EVENTFS_SAVE_GID))
-		inode->i_gid = ei->attr.gid;
-}
-
-static int eventfs_get_attr(struct mnt_idmap *idmap,
-			    const struct path *path, struct kstat *stat,
-			    u32 request_mask, unsigned int flags)
-{
-	struct dentry *dentry = path->dentry;
-	struct inode *inode = d_backing_inode(dentry);
-
-	set_top_events_ownership(inode);
-
-	generic_fillattr(idmap, request_mask, inode, stat);
-	return 0;
-}
-
-static int eventfs_permission(struct mnt_idmap *idmap,
-			      struct inode *inode, int mask)
-{
-	set_top_events_ownership(inode);
-	return generic_permission(idmap, inode, mask);
-}
-
 static const struct inode_operations eventfs_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
 	.setattr	= eventfs_set_attr,
-	.getattr	= eventfs_get_attr,
-	.permission	= eventfs_permission,
 };
 
 static const struct inode_operations eventfs_file_inode_operations = {
@@ -301,84 +245,109 @@ static const struct file_operations eventfs_file_operations = {
 	.llseek		= generic_file_llseek,
 };
 
-/*
- * On a remount of tracefs, if UID or GID options are set, then
- * the mount point inode permissions should be used.
- * Reset the saved permission flags appropriately.
- */
-void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
+static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t uid,
+			      bool update_gid, kgid_t gid, int level)
 {
-	struct eventfs_inode *ei = ti->private;
+	struct eventfs_inode *ei_child;
 
-	if (!ei)
+	/* Update events/<system>/<event> */
+	if (WARN_ON_ONCE(level > 3))
 		return;
 
-	if (update_uid)
+	if (update_uid) {
 		ei->attr.mode &= ~EVENTFS_SAVE_UID;
+		ei->attr.uid = uid;
+	}
 
-	if (update_gid)
+	if (update_gid) {
 		ei->attr.mode &= ~EVENTFS_SAVE_GID;
+		ei->attr.gid = gid;
+	}
+
+	list_for_each_entry(ei_child, &ei->children, list) {
+		eventfs_set_attrs(ei_child, update_uid, uid, update_gid, gid, level + 1);
+	}
 
 	if (!ei->entry_attrs)
 		return;
 
 	for (int i = 0; i < ei->nr_entries; i++) {
-		if (update_uid)
+		if (update_uid) {
 			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
-		if (update_gid)
+			ei->entry_attrs[i].uid = uid;
+		}
+		if (update_gid) {
 			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
+			ei->entry_attrs[i].gid = gid;
+		}
 	}
+
 }
 
-/* Return the evenfs_inode of the "events" directory */
-static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
+/*
+ * On a remount of tracefs, if UID or GID options are set, then
+ * the mount point inode permissions should be used.
+ * Reset the saved permission flags appropriately.
+ */
+void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
 {
-	struct eventfs_inode *ei;
+	struct eventfs_inode *ei = ti->private;
 
-	do {
-		// The parent is stable because we do not do renames
-		dentry = dentry->d_parent;
-		// ... and directories always have d_fsdata
-		ei = dentry->d_fsdata;
+	/* Only the events directory does the updates */
+	if (!ei || !ei->is_events || ei->is_freed)
+		return;
 
-		/*
-		 * If the ei is being freed, the ownership of the children
-		 * doesn't matter.
-		 */
-		if (ei->is_freed)
-			return NULL;
+	eventfs_set_attrs(ei, update_uid, ti->vfs_inode.i_uid,
+			  update_gid, ti->vfs_inode.i_gid, 0);
+}
 
-		// Walk upwards until you find the events inode
-	} while (!ei->is_events);
+static void update_inode_attr(struct inode *inode, umode_t mode,
+			      struct eventfs_attr *attr, struct eventfs_root_inode *rei)
+{
+	if (attr && attr->mode & EVENTFS_SAVE_MODE)
+		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
+	else
+		inode->i_mode = mode;
 
-	update_events_attr(ei, dentry->d_sb);
+	if (attr && attr->mode & EVENTFS_SAVE_UID)
+		inode->i_uid = attr->uid;
+	else
+		inode->i_uid = rei->ei.attr.uid;
 
-	return ei;
+	if (attr && attr->mode & EVENTFS_SAVE_GID)
+		inode->i_gid = attr->gid;
+	else
+		inode->i_gid = rei->ei.attr.gid;
 }
 
-static void update_inode_attr(struct dentry *dentry, struct inode *inode,
-			      struct eventfs_attr *attr, umode_t mode)
+static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_attr *attr,
+				       umode_t mode,  struct eventfs_inode *ei)
 {
-	struct eventfs_inode *events_ei = eventfs_find_events(dentry);
+	struct eventfs_root_inode *rei;
+	struct eventfs_inode *pei;
+	struct tracefs_inode *ti;
+	struct inode *inode;
 
-	if (!events_ei)
-		return;
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (!inode)
+		return NULL;
 
-	inode->i_mode = mode;
-	inode->i_uid = events_ei->attr.uid;
-	inode->i_gid = events_ei->attr.gid;
+	ti = get_tracefs(inode);
+	ti->private = ei;
+	ti->flags |= TRACEFS_EVENT_INODE;
 
-	if (!attr)
-		return;
+	/* Find the top dentry that holds the "events" directory */
+	do {
+		dentry = dentry->d_parent;
+		/* Directories always have d_fsdata */
+		pei = dentry->d_fsdata;
+	} while (!pei->is_events);
 
-	if (attr->mode & EVENTFS_SAVE_MODE)
-		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
+	rei = get_root_inode(pei);
 
-	if (attr->mode & EVENTFS_SAVE_UID)
-		inode->i_uid = attr->uid;
+	update_inode_attr(inode, mode, attr, rei);
 
-	if (attr->mode & EVENTFS_SAVE_GID)
-		inode->i_gid = attr->gid;
+	return inode;
 }
 
 /**
@@ -401,7 +370,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 				  void *data,
 				  const struct file_operations *fop)
 {
-	struct tracefs_inode *ti;
 	struct inode *inode;
 
 	if (!(mode & S_IFMT))
@@ -410,13 +378,11 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
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
@@ -424,9 +390,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	/* All files will have the same inode number */
 	inode->i_ino = EVENTFS_FILE_INODE_INO;
 
-	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
-
 	// Files have their parent's ei as their fsdata
 	dentry->d_fsdata = get_ei(parent_ei);
 
@@ -446,28 +409,19 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
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
@@ -828,7 +782,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	// Note: we have a ref to the dentry from tracefs_start_creating()
 	rei = get_root_inode(ei);
 	rei->events_dir = dentry;
-	rei->parent_inode = d_inode(dentry->d_sb->s_root);
 
 	ei->entries = entries;
 	ei->nr_entries = size;
@@ -838,14 +791,12 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	uid = d_inode(dentry->d_parent)->i_uid;
 	gid = d_inode(dentry->d_parent)->i_gid;
 
-	ei->attr.uid = uid;
-	ei->attr.gid = gid;
-
 	/*
-	 * When the "events" directory is created, it takes on the
-	 * permissions of its parent. But can be reset on remount.
+	 * The ei->attr will be used as the default values for the
+	 * files beneath this directory.
 	 */
-	ei->attr.mode |= EVENTFS_SAVE_UID | EVENTFS_SAVE_GID;
+	ei->attr.uid = uid;
+	ei->attr.gid = gid;
 
 	INIT_LIST_HEAD(&ei->children);
 	INIT_LIST_HEAD(&ei->list);
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index a827f6a716c4..7c29f4afc23d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -373,12 +373,21 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 
 		rcu_read_lock();
 		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
-			if (update_uid)
+			if (update_uid) {
 				ti->flags &= ~TRACEFS_UID_PERM_SET;
+				ti->vfs_inode.i_uid = fsi->uid;
+			}
 
-			if (update_gid)
+			if (update_gid) {
 				ti->flags &= ~TRACEFS_GID_PERM_SET;
-
+				ti->vfs_inode.i_gid = fsi->gid;
+			}
+
+			/*
+			 * Note, the above ti->vfs_inode updates are
+			 * used in eventfs_remount() so they must come
+			 * before calling it.
+			 */
 			if (ti->flags & TRACEFS_EVENT_INODE)
 				eventfs_remount(ti, update_uid, update_gid);
 		}
@@ -417,10 +426,26 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static int tracefs_drop_inode(struct inode *inode)
+{
+	struct tracefs_inode *ti = get_tracefs(inode);
+
+	/*
+	 * This inode is being freed and cannot be used for
+	 * eventfs. Clear the flag so that it doesn't call into
+	 * eventfs during the remount flag updates. The eventfs_inode
+	 * gets freed after an RCU cycle, so the content will still
+	 * be safe if the iteration is going on now.
+	 */
+	ti->flags &= ~TRACEFS_EVENT_INODE;
+
+	return 1;
+}
+
 static const struct super_operations tracefs_super_operations = {
 	.alloc_inode    = tracefs_alloc_inode,
 	.free_inode     = tracefs_free_inode,
-	.drop_inode     = generic_delete_inode,
+	.drop_inode     = tracefs_drop_inode,
 	.statfs		= simple_statfs,
 	.show_options	= tracefs_show_options,
 };
@@ -446,22 +471,7 @@ static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return !(ei && ei->is_freed);
 }
 
-static void tracefs_d_iput(struct dentry *dentry, struct inode *inode)
-{
-	struct tracefs_inode *ti = get_tracefs(inode);
-
-	/*
-	 * This inode is being freed and cannot be used for
-	 * eventfs. Clear the flag so that it doesn't call into
-	 * eventfs during the remount flag updates. The eventfs_inode
-	 * gets freed after an RCU cycle, so the content will still
-	 * be safe if the iteration is going on now.
-	 */
-	ti->flags &= ~TRACEFS_EVENT_INODE;
-}
-
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_d_iput,
 	.d_revalidate = tracefs_d_revalidate,
 	.d_release = tracefs_d_release,
 };

