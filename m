Return-Path: <linux-kernel+bounces-525909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E5A3F745
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA9717A5B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41D20FA90;
	Fri, 21 Feb 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiQFTrOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478420B1EE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148196; cv=none; b=Q+Oj3MQlnv84pLjDf63nylJlBNrgnqtqTeIL+UnJsMeG2eN522OwiDF+8JILmdZ+nWr2WqyGGHYpyiyFqHMU3VY49Nm3PllF0D5oLqKeWs4r51FjnQlZXlEgOKZrZZgkPyOZFxY5IW2RqXQj16kHp1osQ68ccm5e3ABa++fhegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148196; c=relaxed/simple;
	bh=jiAtYkJ93H+bXGtd4GAtjs0YWd901kf8MHW9Qhn4ztk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F08dbjjYyqLtY5B2+fwRACf5bxuu7s18U4Rqyu5lLpqbiB6mv3i+w/10oe6b8uyOebxH57TortDO5BD1UfipPQMjM9AJwOCo9L3dm+qPHJB9kNLfhdtEWZpXxZVBfeKhU2sc2uRUoXT+mYvSSq+7NMhPtvnJgqehFVhN1vXSgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiQFTrOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC86C4CED6;
	Fri, 21 Feb 2025 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740148196;
	bh=jiAtYkJ93H+bXGtd4GAtjs0YWd901kf8MHW9Qhn4ztk=;
	h=From:To:Cc:Subject:Date:From;
	b=QiQFTrOxx6hu7gaU9+j36xYhUYNz073ryM1ZE+jGwt3tuvzhNIP8c9Nm2RXVH4O/s
	 3SZaliO5Tfe4+CGKQw8VDBOj3wLrnst/T6DjljjytsZ1ujo8/k3oaxwxyEr/h83ZKM
	 WUyVyzmklqkcs23E19OMjB/EwQuZhTZNC7b0wpLuEwOrcTqoRXNbkJqDgTgxGUat1G
	 Pyj3/9aAgujCCQxK2nZfXrtHaoVXtWX367KB2WZHQqT6ptdetSz26PApZfF3aJ5+qr
	 NzER9PqiUUnrE08Bc9F1vvY4+VI4IWV0f+ZX8B18T504UCbhc/rzJMFuo6DJ60MxR+
	 yx/C/KGNha3ow==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Lance Yang <ioworker0@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Yongliang Gao <leonylgao@tencent.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hung_task: Dump the blocking task stacktrace
Date: Fri, 21 Feb 2025 23:29:51 +0900
Message-ID:  <174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 2nd version of the dumping mutex blocker in hung_task
message. The previous version is here;

https://lore.kernel.org/all/173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com/

This version introduced CONFIG_DETECT_HUNG_TASK_BLOCKER and
save the mutex on task_struct as blocker_mutex field.

The hung_task detector is very useful for detecting the lockup.
However, since it only dumps the blocked (uninterruptible sleep)
processes, it is not enough to identify the root cause of that
lockup.

For example, if a process holds a mutex and sleep an event in
interruptible state long time, the other processes will wait on
the mutex in uninterruptible state. In this case, the waiter
processes are dumped, but the blocker process is not shown
because it is sleep in interruptible state.

This adds a feature to dump the blocker task which holds a mutex
when detecting a hung task. e.g.

 INFO: task cat:113 blocked for more than 122 seconds.
       Not tainted 6.14.0-rc3-00002-g6afe972e1b9b #152
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:cat             state:D stack:13432 pid:113   tgid:113   ppid:103    task_flags:0x400100 flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0x731/0x960
  ? schedule_preempt_disabled+0x54/0xa0
  schedule+0xb7/0x140
  ? __mutex_lock+0x51d/0xa50
  ? __mutex_lock+0x51d/0xa50
  schedule_preempt_disabled+0x54/0xa0
  __mutex_lock+0x51d/0xa50
  ? current_time+0x3a/0x120
  read_dummy+0x23/0x70
  full_proxy_read+0x6a/0xc0
  vfs_read+0xc2/0x340
  ? __pfx_direct_file_splice_eof+0x10/0x10
  ? do_sendfile+0x1bd/0x2e0
  ksys_read+0x76/0xe0
  do_syscall_64+0xe3/0x1c0
  ? exc_page_fault+0xa9/0x1d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x4840cd
 RSP: 002b:00007ffe632b76c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffe632b7710 RDI: 0000000000000003
 RBP: 00007ffe632b7710 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 000000003a8b63a0 R14: 0000000000000001 R15: ffffffffffffffff
  </TASK>
 INFO: task cat:113 is blocked on a mutex owned by task cat:112.
 task:cat             state:S stack:13432 pid:112   tgid:112   ppid:103    task_flags:0x400100 flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0x731/0x960
  ? schedule_timeout+0xa8/0x120
  schedule+0xb7/0x140
  schedule_timeout+0xa8/0x120
  ? __pfx_process_timeout+0x10/0x10
  msleep_interruptible+0x3e/0x60
  read_dummy+0x2d/0x70
  full_proxy_read+0x6a/0xc0
  vfs_read+0xc2/0x340
  ? __pfx_direct_file_splice_eof+0x10/0x10
  ? do_sendfile+0x1bd/0x2e0
  ksys_read+0x76/0xe0
  do_syscall_64+0xe3/0x1c0
  ? exc_page_fault+0xa9/0x1d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x4840cd
 RSP: 002b:00007ffd69513748 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffd69513790 RDI: 0000000000000003
 RBP: 00007ffd69513790 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 0000000029d8d3a0 R14: 0000000000000001 R15: ffffffffffffffff
  </TASK>

TBD:
We can extend this feature to cover other locks like rwsem and rt_mutex,
but rwsem requires to dump all the tasks which acquire and wait that
rwsem. We can follow the waiter link but the output will be a bit
different compared with mutex case.

Thank you,

---

Masami Hiramatsu (Google) (2):
      hung_task: Show the blocker task if the task is hung on mutex
      samples: Add hung_task detector mutex blocking sample


 include/linux/mutex.h               |    2 +
 include/linux/sched.h               |    4 ++
 kernel/hung_task.c                  |   31 ++++++++++++++++
 kernel/locking/mutex.c              |   14 +++++++
 lib/Kconfig.debug                   |   10 +++++
 samples/Kconfig                     |    9 +++++
 samples/Makefile                    |    1 +
 samples/hung_task/Makefile          |    2 +
 samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++++++++
 9 files changed, 139 insertions(+)
 create mode 100644 samples/hung_task/Makefile
 create mode 100644 samples/hung_task/hung_task_mutex.c

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

