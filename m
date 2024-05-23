Return-Path: <linux-kernel+bounces-188018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E928CDBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5365B1C22B81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FDB128368;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32F84A4A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499400; cv=none; b=Yy6j/n9CZ+MzjbKntosrcyc4/Hosj030rXd3vyGgDe3jA7lbFwjqHyxyJlDisSXIE/wkgfW9j5vzlqV3k1HbLlbzsxLnxdSr6DpMQHl6ojp7s5Ht47GrUTiocPRMjwQEkFlPo3pM3iton3tOpALi/Nr75sZY9B6PKw/TCNHrz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499400; c=relaxed/simple;
	bh=eCaK6AOtypjDuj8nL8hZhpELyVdnXnC1G45BHVX2z3c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=CU9F0ICmMQcIZ59VJpQ8xnfQ/b9Ggy3ho8QJ5l71qX4Dz07Jubm9ID6wD6pL0XicIT1ap/ac5qaIN42KK8+mWp8c7UU329BeRjh8SsZ3jdFYr/judtJeyx42rNzl4Hxql1Kc1jG+mNGM4HgT03a5VYcMp21znANWck8i9cVmx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71975C2BD10;
	Thu, 23 May 2024 21:23:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAFuw-00000006l7j-0Ha2;
	Thu, 23 May 2024 17:24:06 -0400
Message-ID: <20240523212258.883756004@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 17:22:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: [for-linus][PATCH 0/8] tracefs/eventfs: Fixes and cleanups for v6.10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


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

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
eventfs/urgent

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

