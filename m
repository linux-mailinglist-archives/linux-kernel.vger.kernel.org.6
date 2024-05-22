Return-Path: <linux-kernel+bounces-186516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472CE8CC521
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C875A282D70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AA1422C6;
	Wed, 22 May 2024 16:49:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B261420CA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396589; cv=none; b=s5Q5VQK1C+RhRi8QWMLaJMwNrxoIXWMMJk5tnd3kq1PRKu2/fMX+48tUgKSLT3VTpqRxXbZjG3JZHn5jz+rg7WbRAElP1mSVT6LxcbJx/6XsN8WJzPpYkK+3cxrXx4peLxzhUDU4C0PCuOHTa1NUOm8VsRNN8D9Q3Pyp7kRRpgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396589; c=relaxed/simple;
	bh=V145cZNiWNCtXZ8E8drCo4cEY4Xy3jDEou2pmLZ7cPc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ovok/7NvlMkw4U/P2L6ObK1ie5g23/e3X0p4If+g3yC2zbJoHPSx9Du/DNWDmpAvtafNyimap7Qep+XpFZUDLnAvp57nOrSiqUD14epCQflm4UD9w3vtmnn9EKLZwv5SDaSUL5yYJ5WWqpPR3jZdFOb7wXjeGKbb1pIBKcMkrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF53CC4AF08;
	Wed, 22 May 2024 16:49:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9pAd-00000006HQ7-3s4t;
	Wed, 22 May 2024 12:50:31 -0400
Message-ID: <20240522165031.782066021@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:49:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/4] eventfs: Remove getattr and permission callbacks
References: <20240522164942.590663963@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that inodes have their permissions updated on remount, the only other
places to update the inode permissions are when they are created and in
the setattr callback. The getattr and permission callbacks are not needed
as the inodes should already be set at their proper settings.

Remove the callbacks, as it not only simplifies the code, but also allows
more flexibility to fix the inconsistencies with various corner cases
(like changing the permission of an instance directory).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fb0fcd419805..4af6380eb236 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -250,49 +250,9 @@ static void update_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 		ei->attr.gid = parent->i_gid;
 }
 
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
-- 
2.43.0



