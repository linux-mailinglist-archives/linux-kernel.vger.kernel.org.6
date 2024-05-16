Return-Path: <linux-kernel+bounces-181322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C928C7A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DC41F2234B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3879E4;
	Thu, 16 May 2024 16:33:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357DC63BF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877231; cv=none; b=mx/mJR+zbe/me66AiSq/rPz2bxAHTqhDuBNBm0Z7SXCfkpsmvGxasCwtWseytUBaEcrI1kkFH0HfBNxOGQ2yb020Sdt1Q8Y8JxCmmAw/eOP2CjN4+HIncQTS8UX85gEC1zvcJhdC7CEFHJ0WCww10DxpSSYLstb6tglb0as8bOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877231; c=relaxed/simple;
	bh=TKa2BFpOcJzNM2WCakr46UXPsFJ6lrdeUWrLHFHLwCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UNDc0cG6uzXZWOE7q8KhjIlqiJ7chexb7Yr2DksaU67QMP8RPTkP+1JqLrs8NbIwcvcwqsRtAeGztLcMQyw6EmYu21Ts8edffUL7MtxbLOxGg2WOBUWg0YT8LvbWZOXyoIqUT4/gvjUAAkS0ix3q9HhWT4ZSyVKgNDGPauc9xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62186C4AF0C;
	Thu, 16 May 2024 16:33:50 +0000 (UTC)
Date: Thu, 16 May 2024 12:33:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Mike
 Rapoport <rppt@kernel.org>
Subject: [GIT PULL] tracing/ring-buffer: Updates for v6.10
Message-ID: <20240516123348.1feacd26@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing ring buffer updates for v6.10:

- Add ring_buffer memory mappings

  The tracing ring buffer was created based on being mostly used with the
  splice system call. It is broken up into page ordered sub-buffers and the
  reader swaps a new sub-buffer with an existing sub-buffer that's part
  of the write buffer. It then has total access to the swapped out
  sub-buffer and can do copyless movements of the memory into other mediums
  (file system, network, etc).

  The buffer is great for passing around the ring buffer contents in the
  kernel, but is not so good for when the consumer is the user space task
  itself.

  A new interface is added that allows user space to memory map the ring
  buffer. It will get all the write sub-buffers as well as reader sub-buffer
  (that is not written to). It can send an ioctl to change which sub-buffer
  is the new reader sub-buffer.

  The ring buffer is read only to user space. It only needs to call the
  ioctl when it is finished with a sub-buffer and needs a new sub-buffer
  that the writer will not write over.

  A self test program was also created for testing and can be used as
  an example for the interface to user space. The libtracefs (external
  to the kernel) also has code that interacts with this, although it is
  disabled until the interface is in a official release. It can be enabled
  by compiling the library with a special flag. This was used for testing
  applications that perform better with the buffer being mapped.

  Memory mapped buffers have limitations. The main one is that it can not be
  used with the snapshot logic. If the buffer is mapped, snapshots will be
  disabled. If any logic is set to trigger snapshots on a buffer, that
  buffer will not be allowed to be mapped.

- Changes since last pull request:
    https://lore.kernel.org/all/20240315122934.1d3231ce@gandalf.local.home/

  All the pages of the ring buffer are mapped at the mmap() system call
  instead of paging them in when they are accessed. The VMA page flags
  have been updated and the mappings are done via vm_insert_pages().
  I'd like to thank both Mike Rapoport and  David Hildenbrand for their
  review of these patches to make sure they are doing things correctly
  from a memory management point of view.


Please pull the latest trace-ringbuffer-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ringbuffer-v6.10

Tag SHA1: 61407f35944db217cadb6a520906d52668d6d212
Head SHA1: b9c6820f029abaabbc37646093866aa730ca0928


Steven Rostedt (Google) (2):
      ring-buffer: Have mmapped ring buffer keep track of missed events
      ring-buffer: Add cast to unsigned long addr passed to virt_to_page()

Vincent Donnefort (5):
      ring-buffer: Allocate sub-buffers with __GFP_COMP
      ring-buffer: Introducing ring-buffer mapping functions
      tracing: Allow user-space mapping of the ring-buffer
      Documentation: tracing: Add ring-buffer mapping
      ring-buffer/selftest: Add ring-buffer mapping test

----
 Documentation/trace/index.rst                  |   1 +
 Documentation/trace/ring-buffer-map.rst        | 106 ++++++
 include/linux/ring_buffer.h                    |   6 +
 include/uapi/linux/trace_mmap.h                |  48 +++
 kernel/trace/ring_buffer.c                     | 471 ++++++++++++++++++++++++-
 kernel/trace/trace.c                           | 104 +++++-
 kernel/trace/trace.h                           |   1 +
 tools/testing/selftests/ring-buffer/.gitignore |   1 +
 tools/testing/selftests/ring-buffer/Makefile   |   8 +
 tools/testing/selftests/ring-buffer/config     |   2 +
 tools/testing/selftests/ring-buffer/map_test.c | 294 +++++++++++++++
 11 files changed, 1026 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/.gitignore
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c
---------------------------

