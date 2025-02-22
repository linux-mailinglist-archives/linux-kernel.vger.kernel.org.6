Return-Path: <linux-kernel+bounces-526908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C5A40505
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5FF707ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EE31E3DED;
	Sat, 22 Feb 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phqlLgne"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81011250EC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740189576; cv=none; b=ukEYhslj6QcrXAikRGqGq09HKIGxaDpBaCbBKxB4E/6UUdPyocJvnfOMzUy9v5ZQQpkRtOZ4PCUZ5shFx9t0AtA7w9lAD1DIev3fxtKvwAWQr8a2gsMdZAx4PEARii8BOWCPxRpCysoSHoiGy4OP0k02249rehxbxNjURClkSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740189576; c=relaxed/simple;
	bh=fEv/Q0O3RbsP2hU79ncp1CJKaoCqjxFDgU7McqA4jAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+xGzTWCgua81dAoTONPe346Oh7+NhwfBGWjALKCCqfzSwZCTm43enVfXxvomxN7+A7DeCfu/E137QanUmkxyDCZ+mUnojSsfEvtp/BBDWJ/QmhxjNozsOHsZHCD5kZXb/PDWInLij1/QTEWYD7Zx5mikjn4uVWolEG54tTUYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phqlLgne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEE7C4CED6;
	Sat, 22 Feb 2025 01:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740189575;
	bh=fEv/Q0O3RbsP2hU79ncp1CJKaoCqjxFDgU7McqA4jAY=;
	h=From:To:Cc:Subject:Date:From;
	b=phqlLgnerjDencUXlMkJsfHfqFwRMnyyYZa67WsnhYIaeX8iBETky7kxO0vNpZwlZ
	 IGs19lTKIEEsMaIkW/T/JD0okhEFFI6ECIRvvOqkchq+AFFpefFQ+oZygwltW91WbD
	 jIPp68fhKqSOoPasi4VF9HViJTOv8q702+84ciYlazTsL6zBHv2LEfhmGhlGwFqWyi
	 PCT6ByO+Nv+rxnVl3W1bvN1MDcgOzZoI8BFB9XZM70350rUVbMqk83lst9LHOV2m0u
	 05Jfcj9d/jQYhXTs9I9SNuxUs+vs25U/uvBiK7QEEmMqKT1eujVY4pmm7Cn2HHhsCd
	 WfbnrUl+cW3dw==
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
Subject: [PATCH v3 0/2] hung_task: Dump the blocking task stacktrace
Date: Sat, 22 Feb 2025 10:59:30 +0900
Message-ID:  <174018957063.2754424.7449649863154821527.stgit@mhiramat.tok.corp.google.com>
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

Here is the 3rd version of the dumping mutex blocker in hung_task
message. The previous version is here;

https://lore.kernel.org/all/174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com/

This version fixes to add rcu_read_lock check, add braces for
for_each_process_thread(), and change the message.

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
 kernel/hung_task.c                  |   36 +++++++++++++++++++
 kernel/locking/mutex.c              |   14 +++++++
 lib/Kconfig.debug                   |   10 +++++
 samples/Kconfig                     |    9 +++++
 samples/Makefile                    |    1 +
 samples/hung_task/Makefile          |    2 +
 samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++++++++
 9 files changed, 144 insertions(+)
 create mode 100644 samples/hung_task/Makefile
 create mode 100644 samples/hung_task/hung_task_mutex.c

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

