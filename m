Return-Path: <linux-kernel+bounces-186517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C7A8CC522
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93674282E95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2641422D5;
	Wed, 22 May 2024 16:49:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B861422A1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396589; cv=none; b=mXvjQd+SF9VrsGVR3Z2Ht37nXr0Jn+WjB5HpVtVH/BYy/v72QkSDBS3eZYh/Khuc47J7O21p2FCDzk50ZhC/YbgBb588jeB03Q6VmoJN0rAWHGL+ZSSVMWaoJEGmWbaC6m5/Lx+R/Yyc0n06vw6TUehfqUNRb54FduKTl+JsmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396589; c=relaxed/simple;
	bh=uIxQswDa2bRMRBkm77tAVcu1ddz6P92wB9mR3/YA8tA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gmm0jqTPdU3RmiClto0qekstFSNHebuqvrzbX0pqFTMp2ZJzZz/2rOqesa8NNqgIQDTpIxJLvL9safvGrgX2M4koeVKNRi1VB2AiF1GQ5wSVpxs+0fAXxAZOfVbj7MMOfGlZLt5XToR2MLqwOEqy8beyX/3RjRNOWdfn+R8qkbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F680C4AF07;
	Wed, 22 May 2024 16:49:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9pAe-00000006HR5-11LF;
	Wed, 22 May 2024 12:50:32 -0400
Message-ID: <20240522165032.104981011@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:49:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] eventfs: Do not use attributes for events directory
References: <20240522164942.590663963@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The top "events" directory has a static inode (it's created when it is and
removed when the directory is removed). There's no need to use the events
ei->attr to determine its permissions. But it is used for saving the
permissions of the "events" directory for when it is created, as that is
needed for the default permissions for the files and directories
underneath it.

For example:

 # cd /sys/kernel/tracing
 # mkdir instances/foo
 # chown 1001 instances/foo/events

The files under instances/foo/events should still have the same owner as
instances/foo (which the instances/foo/events ei->attr will hold), but the
events directory now has owner 1001.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 7673532b5a5e..40277d3dbf73 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -210,7 +210,9 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * determined by the parent directory.
 	 */
 	if (dentry->d_inode->i_mode & S_IFDIR) {
-		update_attr(&ei->attr, iattr);
+		/* Just use the inode permissions for the events directory */
+		if (!ei->is_events)
+			update_attr(&ei->attr, iattr);
 
 	} else {
 		name = dentry->d_name.name;
@@ -771,14 +773,12 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
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
-- 
2.43.0



