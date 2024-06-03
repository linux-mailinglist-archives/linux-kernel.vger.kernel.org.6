Return-Path: <linux-kernel+bounces-198500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DE8D7957
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE461F21457
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A41C2D;
	Mon,  3 Jun 2024 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OYnoPBg6"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1917C9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374800; cv=none; b=UW/cykH+ww5TwmkmVCQ/7u9hI6yLVX8v+MxhQbSic+GivLGCJGJontV40inVsD50Iyo5FuWzeah+Ux7xT4RzCfsd34t75ghW35zxrZ9iaLg/c8VkbIzhIidrzeDjj4pwNWE0AoWivRB3ArPZ37cF9iGr+945LmQc9jhmWAf+yNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374800; c=relaxed/simple;
	bh=b6eKfCltzw8fypFAkdr1Zz9lFnS5//CV8ehAWpoGhn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZ7vQXndyyO7fQSauq/t8EPFCODKhWWrBEvmo5gSN4Fc2oiZWw7EnO+xtkMMShnMrGuBQdiVlQOAdSOBFXcmD/UtbF8C/ctpXAWR0HKPTCNS3ZzxdQbtzOYl4IsZQHxSXVktY9yFgQQkrvD1bkB+SezLsElQk2AJzn6zx3o4vW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OYnoPBg6; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717374795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IeBJ/5oPlb9g+ArFLQs0RP3mSJ+NwqtBpi4ZC0JDGNM=;
	b=OYnoPBg6pxl4poMMON/6TpyfKQJV7Y0DVjK8agLVjT7YDZCqb4rCj8ep3GjQBWBiuiRtg4
	Ns95sq0QeN0vY9KOWQC64MQt557Z7lPLZph/zJHTbjdEc6ecOLmWxzbN+kSfjyQVZKj94x
	wgefjmPwxUuC2053ufGXu/pdKgHimPM=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/5] sys_ringbuffer
Date: Sun,  2 Jun 2024 20:32:57 -0400
Message-ID: <20240603003306.2030491-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

New syscall for mapping generic ringbuffers for arbitary (supported)
file descriptors.

Ringbuffers can be created either when requested or at file open time,
and can be mapped into multiple address spaces (naturally, since files
can be shared as well).

Initial motivation is for fuse, but I plan on adding support to pipes
and possibly sockets as well - pipes are a particularly interesting use
case, because if both the sender and receiver of a pipe opt in to the
new ringbuffer interface, we can make them the _same_ ringbuffer for
true zero copy IO, while being backwards compatible with existing pipes.

the ringbuffer_wait and ringbuffer_wakeup syscalls are probably going
away in a future iteration, in favor of just using futexes.

In my testing, reading/writing from the ringbuffer 16 bytes at a time is
~7x faster than using read/write syscalls - and I was testing with
mitigations off, real world benefit will be even higher.

Kent Overstreet (5):
  darray: lift from bcachefs
  darray: Fix darray_for_each_reverse() when darray is empty
  fs: sys_ringbuffer
  ringbuffer: Test device
  ringbuffer: Userspace test helper

 MAINTAINERS                             |   7 +
 arch/x86/entry/syscalls/syscall_32.tbl  |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl  |   3 +
 fs/Makefile                             |   2 +
 fs/bcachefs/Makefile                    |   1 -
 fs/bcachefs/btree_types.h               |   2 +-
 fs/bcachefs/btree_update.c              |   2 +
 fs/bcachefs/btree_write_buffer_types.h  |   2 +-
 fs/bcachefs/fsck.c                      |   2 +-
 fs/bcachefs/journal_io.h                |   2 +-
 fs/bcachefs/journal_sb.c                |   2 +-
 fs/bcachefs/sb-downgrade.c              |   3 +-
 fs/bcachefs/sb-errors_types.h           |   2 +-
 fs/bcachefs/sb-members.h                |   3 +-
 fs/bcachefs/subvolume.h                 |   1 -
 fs/bcachefs/subvolume_types.h           |   2 +-
 fs/bcachefs/thread_with_file_types.h    |   2 +-
 fs/bcachefs/util.h                      |  28 +-
 fs/ringbuffer.c                         | 474 ++++++++++++++++++++++++
 fs/ringbuffer_test.c                    | 209 +++++++++++
 {fs/bcachefs => include/linux}/darray.h |  61 +--
 include/linux/darray_types.h            |  22 ++
 include/linux/fs.h                      |   2 +
 include/linux/mm_types.h                |   4 +
 include/linux/ringbuffer_sys.h          |  18 +
 include/uapi/linux/futex.h              |   1 +
 include/uapi/linux/ringbuffer_sys.h     |  40 ++
 init/Kconfig                            |   9 +
 kernel/fork.c                           |   2 +
 lib/Kconfig.debug                       |   5 +
 lib/Makefile                            |   2 +-
 {fs/bcachefs => lib}/darray.c           |  12 +-
 tools/ringbuffer/Makefile               |   3 +
 tools/ringbuffer/ringbuffer-test.c      | 254 +++++++++++++
 34 files changed, 1125 insertions(+), 62 deletions(-)
 create mode 100644 fs/ringbuffer.c
 create mode 100644 fs/ringbuffer_test.c
 rename {fs/bcachefs => include/linux}/darray.h (63%)
 create mode 100644 include/linux/darray_types.h
 create mode 100644 include/linux/ringbuffer_sys.h
 create mode 100644 include/uapi/linux/ringbuffer_sys.h
 rename {fs/bcachefs => lib}/darray.c (56%)
 create mode 100644 tools/ringbuffer/Makefile
 create mode 100644 tools/ringbuffer/ringbuffer-test.c

-- 
2.45.1


