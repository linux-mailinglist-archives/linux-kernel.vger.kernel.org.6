Return-Path: <linux-kernel+bounces-526913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13636A4050E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D790422332
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395971E4110;
	Sat, 22 Feb 2025 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRusFYj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0B78F4E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740190373; cv=none; b=QAiCWcsmOahaXHVh8vtbuBGV45EZIrV+soaar6/r+927+IpmMnBptGkO8SnRoZZRSV/WVNp5ZZPO1auS89K02Fgfz9/8Mn+RIg/4ECDnmNyRBvfG7p9QeyZpmkSiv5dMMLWWYE4aXArypT/HkJ82k/NxezXEy9C3ki7Uy87NTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740190373; c=relaxed/simple;
	bh=gqWtBO96ejQbGxv2sc5o83IQ8N2UbxAPKZEi6xJX9so=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DqM8DueurGt3jKV20ZCrtGKjuzUWsIo332iUpUzJaMiVl+CKpEkea4AI29YOW6jIphuu027A+G6kUfY0shvXc2/hLkb4EHplQIKs1Wi9zIXBN1iCEkq5kl1PmqWg93lxqSA2T547PwmCHPEpAAA+2lLFvvUAtq4gPfRnjQqltFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRusFYj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D11C4CED6;
	Sat, 22 Feb 2025 02:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740190373;
	bh=gqWtBO96ejQbGxv2sc5o83IQ8N2UbxAPKZEi6xJX9so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aRusFYj2ILSDBI312x0XjpmyRQZRygG5Gi66qU3KUR31GeB1LLIF99qUDKEHFp/sY
	 o+QiGDNVg2qxUqNkb213fnVTFQXeSHgPKdKGlPWV4DLXC3i6bH8oUgBtd3+2QrEGHc
	 4SI1MntUTYW++KlFaUCeAvYr7n2Degms2Xj/ZoKHEnOJAU3uynENfpi/lTS0aRQigH
	 +5CLb7t0zWuT4z2kJC2AkD9zsKRTpBqfYEyo5307C4qigWcPbAwmBe++P37qiUdW55
	 LGjmCDuiKpjf5ySudkFP5y5eDfyHO1gKLu9kl2e7ATduJTHsUcz5OkllsMwBkHXDBq
	 pPygwfI2aY0Vg==
Date: Sat, 22 Feb 2025 11:12:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] hung_task: Dump the blocking task stacktrace
Message-Id: <20250222111249.70db403097e5b5ff0e1fc34d@kernel.org>
In-Reply-To: <174018957063.2754424.7449649863154821527.stgit@mhiramat.tok.corp.google.com>
References: <174018957063.2754424.7449649863154821527.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry, I forgot to update the output example. Please ignore this. 

On Sat, 22 Feb 2025 10:59:30 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of the dumping mutex blocker in hung_task
> message. The previous version is here;
> 
> https://lore.kernel.org/all/174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com/
> 
> This version fixes to add rcu_read_lock check, add braces for
> for_each_process_thread(), and change the message.
> 
> The hung_task detector is very useful for detecting the lockup.
> However, since it only dumps the blocked (uninterruptible sleep)
> processes, it is not enough to identify the root cause of that
> lockup.
> 
> For example, if a process holds a mutex and sleep an event in
> interruptible state long time, the other processes will wait on
> the mutex in uninterruptible state. In this case, the waiter
> processes are dumped, but the blocker process is not shown
> because it is sleep in interruptible state.
> 
> This adds a feature to dump the blocker task which holds a mutex
> when detecting a hung task. e.g.
> 
>  INFO: task cat:113 blocked for more than 122 seconds.
>        Not tainted 6.14.0-rc3-00002-g6afe972e1b9b #152
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:cat             state:D stack:13432 pid:113   tgid:113   ppid:103    task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_preempt_disabled+0x54/0xa0
>   schedule+0xb7/0x140
>   ? __mutex_lock+0x51d/0xa50
>   ? __mutex_lock+0x51d/0xa50
>   schedule_preempt_disabled+0x54/0xa0
>   __mutex_lock+0x51d/0xa50
>   ? current_time+0x3a/0x120
>   read_dummy+0x23/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffe632b76c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffe632b7710 RDI: 0000000000000003
>  RBP: 00007ffe632b7710 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 000000003a8b63a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>
>  INFO: task cat:113 is blocked on a mutex owned by task cat:112.
>  task:cat             state:S stack:13432 pid:112   tgid:112   ppid:103    task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_timeout+0xa8/0x120
>   schedule+0xb7/0x140
>   schedule_timeout+0xa8/0x120
>   ? __pfx_process_timeout+0x10/0x10
>   msleep_interruptible+0x3e/0x60
>   read_dummy+0x2d/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffd69513748 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffd69513790 RDI: 0000000000000003
>  RBP: 00007ffd69513790 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 0000000029d8d3a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>
> 
> TBD:
> We can extend this feature to cover other locks like rwsem and rt_mutex,
> but rwsem requires to dump all the tasks which acquire and wait that
> rwsem. We can follow the waiter link but the output will be a bit
> different compared with mutex case.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       hung_task: Show the blocker task if the task is hung on mutex
>       samples: Add hung_task detector mutex blocking sample
> 
> 
>  include/linux/mutex.h               |    2 +
>  include/linux/sched.h               |    4 ++
>  kernel/hung_task.c                  |   36 +++++++++++++++++++
>  kernel/locking/mutex.c              |   14 +++++++
>  lib/Kconfig.debug                   |   10 +++++
>  samples/Kconfig                     |    9 +++++
>  samples/Makefile                    |    1 +
>  samples/hung_task/Makefile          |    2 +
>  samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++++++++
>  9 files changed, 144 insertions(+)
>  create mode 100644 samples/hung_task/Makefile
>  create mode 100644 samples/hung_task/hung_task_mutex.c
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

