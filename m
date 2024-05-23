Return-Path: <linux-kernel+bounces-188023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C95E8CDBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE02A283502
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F116129E64;
	Thu, 23 May 2024 21:23:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90474128386
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499401; cv=none; b=PYxrCJYT2ilrro4wJ7SF2O5ooFkMKMJ9AJ9qrEEIkmC+P++g6rn8Rhg3SxJvm4Gkr/R6zI2gnBbFgnTLF6s/xRPnYW3CIKNP6YCLV3ypOpk4fiZ1NEkgMCooEkydBGz2/F/fBs3vfbPy8hCRzU5h6S3qtMVwit9mcLxk53KFOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499401; c=relaxed/simple;
	bh=85e7mQH4jt2WvuzuVD0ye023imHegS2wclDhhyvGB8A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IFu6DCOPgjmfiQCPzLwG2fyeN2ywGz2plO+tlOes1kYetY2ajeM7esVOp3u4xjkuipaSAj6ynA+DPOCM3GpUQGeQjvzdyf6A8Qxj2M0uRgeBKez1IgHeP31lgektriMF8yieA9wUdjYPX9nWt4Fou+b1573JX9QMI3Z70uc1cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD2CC4AF0F;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAFux-00000006lBd-1U2P;
	Thu, 23 May 2024 17:24:07 -0400
Message-ID: <20240523212407.210966757@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 17:23:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 8/8] eventfs: Do not use attributes for events directory
References: <20240523212258.883756004@goodmis.org>
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

Link: https://lore.kernel.org/lkml/20240522165032.104981011@goodmis.org

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 320e49056d3a..5d88c184f0fc 100644
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
@@ -789,14 +791,12 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
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



