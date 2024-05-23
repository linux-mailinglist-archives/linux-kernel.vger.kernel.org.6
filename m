Return-Path: <linux-kernel+bounces-188026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B86F38CDBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709331F2446B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D5129E66;
	Thu, 23 May 2024 21:23:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07C12838F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499401; cv=none; b=Ph2gUP8XV6bFM0FI9KSU5Y/npPuIxE5uapsw/gBYydQex6t+wTdUswsrf4sl5CRoB7Sdv53Ls36NOCtx7k62JSv7DZ27wz+R6GjcOzlfg1A6vXJZ8+eNIcIpfJPqNKg19wQkR67dfVtmfwmueEuC0UuZkj9eHH3zLj5r/YQe93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499401; c=relaxed/simple;
	bh=krRDAMZ6xTgFMUtD/RVVOB1jD17MwEJGX9YoC2sERuQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C3MTLLUYQnCHwY8EIvqyw7W7j3HA4jDFk2aPiOaE6tm3IYGPwElglXd8LjJ9JPfdjS9pZ9enk12HpaeWxrwuHYXNZuqEJmyui00aSR7YxtTqOQkZKSv+5R33nkhGVO5wvcBouI/gtXLj6stYaawTrf56NC/EKcD5nOc0IG2jWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496FBC4AF4D;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAFux-00000006lAf-08iV;
	Thu, 23 May 2024 17:24:07 -0400
Message-ID: <20240523212406.897870866@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 17:23:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 6/8] eventfs: Remove getattr and permission callbacks
References: <20240523212258.883756004@goodmis.org>
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

Link: https://lore.kernel.org/lkml/20240522165031.782066021@goodmis.org

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 92987b5c8d9d..f32c6f7eb29f 100644
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



