Return-Path: <linux-kernel+bounces-530625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB3A435E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3453B5376
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A525742E;
	Tue, 25 Feb 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFo8sgWM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5219F495
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466949; cv=none; b=trR1mk6MFb9/L+Qwxr75Pl3lz5b7cspdvKJkNKR2Lq1xS25PxE6Mni4xcjq8WJZrWMfDm23l9l6ZTQRBAHoROqCpNRdForl9sxDJOo8gbyShTH7wSAB16XDocpjT0BiNunUXRgWY+bxk3JxrHHkQmo3NK2HEW7ngwZZlmKgFn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466949; c=relaxed/simple;
	bh=rBuOmr7mJuo+JGuOPB8lAXGXjZ8QXheEWrUKukCeIq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BfDGWFcBAIiSXlFgvIojCHnpxQw5TGREfo/jtqkK27dVdjm7mkUrvRNgw0+h/Q76U8wC1ou1l1rOVLWo8H2gow2XObhlT2H/4kjCewrV4jLSeHJh4s2wowfm2xCJ9pfmY+D/l5jjp143TkhNGpR7TkVxEVJFV0uZqqGr0DRhsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFo8sgWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A468BC4CEDD;
	Tue, 25 Feb 2025 07:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740466948;
	bh=rBuOmr7mJuo+JGuOPB8lAXGXjZ8QXheEWrUKukCeIq8=;
	h=From:To:Cc:Subject:Date:From;
	b=JFo8sgWM0iuZ+4iZUym+f8qNUpJIGi0JKq+i5W8ggNH3ly2Cg9ElpAJtEppsUkA2g
	 UOMNoBD4lutNbu3VAvTFGbXKF8NqHQzMXA220edB407IhNknppAEvR6r3ROknmpdxH
	 GYJUjy1PdTgjLB/eohJb11BDvyQ0C/jMM3Ccym6jDjotfjWsBbdKDycy3+L5LAuhuj
	 LfqPcNftUaYv2UlFEPHHehiDrJ3RJjP397VchrsAY3rrg7FCzu/Kd5Su+/c3vYipkH
	 oVf6pY5GvHVsJwuWIgNZVyfEEqdN0kVFYfwWLR71GSwxBYRE1D3ULAq+eH9R2LQBTR
	 NJVz4yVYgWDtA==
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
Subject: [PATCH v4 0/2] hung_task: Dump the blocking task stacktrace
Date: Tue, 25 Feb 2025 16:02:23 +0900
Message-ID:  <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
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

Here is the 4th version of the dumping mutex blocker in hung_task
message. The previous version is here;

https://lore.kernel.org/all/174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com/

This version makes CONFIG_DETECT_HUNG_TASK_BLOCKER depending
on !CONFIG_PREEMPT_RT.

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

 INFO: task cat:115 blocked for more than 122 seconds.
       Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:cat             state:D stack:13432 pid:115   tgid:115   ppid:106    task_flags:0x400100 flags:0x00000002
 Call Trace:
  <TASK>
  __schedule+0x731/0x960
  ? schedule_preempt_disabled+0x54/0xa0
  schedule+0xb7/0x140
  ? __mutex_lock+0x51b/0xa60
  ? __mutex_lock+0x51b/0xa60
  schedule_preempt_disabled+0x54/0xa0
  __mutex_lock+0x51b/0xa60
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
 RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
 RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
  </TASK>
 INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
 task:cat             state:S stack:13432 pid:114   tgid:114   ppid:106    task_flags:0x400100 flags:0x00000002
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
 RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
 RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
 RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
 R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
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
 lib/Kconfig.debug                   |   11 ++++++
 samples/Kconfig                     |    9 +++++
 samples/Makefile                    |    1 +
 samples/hung_task/Makefile          |    2 +
 samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++++++++
 9 files changed, 145 insertions(+)
 create mode 100644 samples/hung_task/Makefile
 create mode 100644 samples/hung_task/hung_task_mutex.c

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

