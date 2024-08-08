Return-Path: <linux-kernel+bounces-279608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7D94BF89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950211C25B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9806F18E76D;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F35118A946
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126883; cv=none; b=OuRF58+p/Bee8YvvNCRFBSlvcGZ6jGCX+MugtCNtZRGxJJuRJfnY+ldIcIx0HC/PiMJ+YUmdo6uhi92ffRom06zq9PjQXl/RnJ/yNfBzB+79CryMlYraakoq7FG20JR43xpz6GECaXjYDQBcVLmxklHRsKC3fHvs1u7AyZxVGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126883; c=relaxed/simple;
	bh=DE96VL2n41W5AmdUNMwk8s7+m8O3EV15nuwMGNqZ46E=;
	h=Message-ID:Date:From:To:Cc:Subject; b=DTXVoecdI6WoVx8b50VfurNTDUtfyi8Lg7SUnrOOK/pXjkgFiKDHuqAouO1igNLdRrMIZnhY2bFZz7lwBDCUlfcmOx40xEjdRNZCeoU25BuztOgllQH8S4oItSMcaZ1chY+RiLy1neUUxOHdoTMsPJBcYFKh0c4ioQdBjbvP8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFD8C4AF0F;
	Thu,  8 Aug 2024 14:21:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc415-00000000BPM-2Ilz;
	Thu, 08 Aug 2024 10:21:23 -0400
Message-ID: <20240808142037.495820579@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/9] tracing: Fixes and cleanups for v6.11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing fixes for v6.11:

- Have reading of event format files test if the meta data still exists.
  When a event is freed, a flag (EVENT_FILE_FL_FREED) in the meta data is
  set to state that it is to prevent any new references to it from happening
  while waiting for existing references to close. When the last reference
  closes, the meta data is freed. But the "format" was missing a check to
  this flag (along with some other files) that allowed new references to
  happen, and a use-afte-free bug to occur.

- Have the trace event meta data use the refcount infrastructure instead
  of relying on its own atomic counters.

- Have tracefs inodes use alloc_inode_sb() for allocation instead of
  using kmem_cache_alloc() directly.

- Have eventfs_create_dir() return an ERR_PTR instead of NULL as
  the callers expect a real object or an ERR_PTR.

- Have release_ei() use call_srcu() and not call_rcu() as all the
  protection is on SRCU and not RCU.

- Fix ftrace_graph_ret_addr() to use the task passed in and not current.

- Fix overflow bug in get_free_elt() where the counter can overflow
  the integer and cause an infinite loop.

- Remove unused function ring_buffer_nr_pages()

- Have tracefs freeing use the inode RCU infrastructure instead of
  creating its own. When the kernel had randomize structure fields
  enabled, the rcu field of the tracefs_inode was overlapping the
  rcu field of the inode structure, and corrupting it. Instead,
  use the destroy_inode() callback to do the initial cleanup of
  the code, and then have free_inode() free it.

Jianhui Zhou (1):
      ring-buffer: Remove unused function ring_buffer_nr_pages()

Mathias Krause (3):
      tracefs: Fix inode allocation
      eventfs: Don't return NULL in eventfs_create_dir()
      eventfs: Use SRCU for freeing eventfs_inodes

Petr Pavlu (1):
      function_graph: Fix the ret_stack used by ftrace_graph_ret_addr()

Steven Rostedt (3):
      tracing: Have format file honor EVENT_FILE_FL_FREED
      tracing: Use refcount for trace_event_file reference counter
      tracefs: Use generic inode RCU for synchronizing freeing

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

----
 fs/tracefs/event_inode.c            |  4 ++--
 fs/tracefs/inode.c                  | 12 +++++------
 fs/tracefs/internal.h               |  5 +----
 include/linux/ring_buffer.h         |  1 -
 include/linux/trace_events.h        |  2 +-
 kernel/trace/fgraph.c               |  2 +-
 kernel/trace/ring_buffer.c          | 12 -----------
 kernel/trace/trace.h                | 23 +++++++++++++++++++++
 kernel/trace/trace_events.c         | 41 ++++++++++++++++++++++---------------
 kernel/trace/trace_events_hist.c    |  4 ++--
 kernel/trace/trace_events_inject.c  |  2 +-
 kernel/trace/trace_events_trigger.c |  6 +++---
 kernel/trace/tracing_map.c          |  6 +++---
 13 files changed, 66 insertions(+), 54 deletions(-)

