Return-Path: <linux-kernel+bounces-387734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759C49B5578
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B012823EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6690C209F48;
	Tue, 29 Oct 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JciJpLqF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25420969F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239418; cv=none; b=Qw1V6KwP/aO70oII1t0lpM66tjoA0M5BP+rC1V1nIwr3F1KDYJNWciZuSs6ZnYV1xiKZHVKBkgOEwrDNaCJxuSH5OQQV5fSj6BoO5dOdAR6XC/xOlK1GbXaldD02oVHrKK7WhmaxBhyonxMuwTB4Bj0alo94F5Nj6OxWLQfIHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239418; c=relaxed/simple;
	bh=OKur0tdRNSv1kcfVt5eHl7raaUg1HOgMM8h+WHlFFUs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=uGKCMyglG9dWUkUTkS/diF1KOvb3EsSPicRRancFzKL7mzZPC1Q2YivTMbGkQCmaLugYXlfgQ+U2ZevzPV/xvGJHlwMsBp58oL79xUk2YN4q30g+HmREl/AP6f9RBJUV+84ncTMDpbYS1KXCRBXZVxWWkihCYZzPWFdh/qzTSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JciJpLqF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730239415; x=1761775415;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=OKur0tdRNSv1kcfVt5eHl7raaUg1HOgMM8h+WHlFFUs=;
  b=JciJpLqFDdOwtuAU+9LSua2uuKdiPIh6hirZfXXtIp5Zm3mwNdN7be8j
   8yn5BpzJvkJWHdnOJBOCHmbi0UOcCv5S5Gxy3GI3PLFhrfxfw/dkxorYo
   E4dcUgUDWIVvLUmiNSP0HyDKgmppqIQhcQmc0XUroVdKgphRkbjhnFTmT
   X2zm6zl09INKZlHgIcngRAUZeXdhQnluoNGolm1hUvSxcBUbsQ6Pdx+ZB
   dtAbLHAMt32ixLx+VLNAmzVVzVIhY6HI0Yp+Xai4LQz6+P9AHilTTLeCL
   /XsrIWcBUXxU7OiKZzDeGAo1CrG8Gft4rRxEkjxngnXqlGrTJwP2HwkIK
   w==;
X-CSE-ConnectionGUID: 3wvukIDfRZeu7LSKcJ5ixA==
X-CSE-MsgGUID: MRmXOshtQWSLeTdR9V+MZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="17552588"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="17552588"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:03:34 -0700
X-CSE-ConnectionGUID: izK7RfufQ8a/Ew21mHaTcg==
X-CSE-MsgGUID: HT2uvycNQ+OTyAbfTa96/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="87231036"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.62]) ([10.125.108.62])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:03:34 -0700
Message-ID: <1cf7b0dbfa4190eeaf0b3401bf7a991b8db59a59.camel@linux.intel.com>
Subject: BUG: Stall on adding/removing wokers into workqueue pool
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Doug
 Nelson <doug.nelson@intel.com>, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com,  mingo@redhat.com, syzkaller-bugs@googlegroups.com,
 x86@kernel.org
Date: Tue, 29 Oct 2024 15:03:33 -0700
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tejun,

Forwarding this task hung seen by my colleague Doug Nelson. He tested
the 6.12-rc4 kernel with an OLTP workload running on a 2 socket with
Granite Rapids CPU that has 86 cores per socket. The traces=C2=A0
seem to indicate that the acquisition=C2=A0
of wq_pool_attach_mutex stalled in idle_cull_fn() when removing worker from
the pool. Doug hit this problem occasionally in his tests.

Searching through the bug reports, there's a similar report by szybot on th=
e
6.12-rc2 kernel. Szybot reported similar task hung when attaching workers t=
o
the pool: https://lore.kernel.org/all/6706c4ba.050a0220.1139e6.0008.GAE@goo=
gle.com/T/
So we suspect that the problem is not GNR CPU specific.

Wonder if this problem is a known one?

Thanks.

Tim


[Fri Oct 25 18:24:12 2024] rcu: INFO: rcu_preempt detected stalls on CPUs/t=
asks:
[Fri Oct 25 18:26:31 2024] INFO: task kworker/46:0H:300 blocked for more th=
an 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/46:0H   state:D stack:0     pid:300=
   tgid:300   ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue:  0x0 (events_highpri)
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  worker_attach_to_pool+0x1f/0xd0
[Fri Oct 25 18:26:31 2024]  create_worker+0xfa/0x1f0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x19c/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/R-kbloc:2466 blocked for more=
 than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/R-kbloc state:D stack:0     pid:246=
6  tgid:2466  ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  worker_attach_to_pool+0x1f/0xd0
[Fri Oct 25 18:26:31 2024]  rescuer_thread+0x111/0x3b0
[Fri Oct 25 18:26:31 2024]  ? __pfx_rescuer_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ? __pfx_rescuer_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/46:1H:3592 blocked for more t=
han 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/46:1H   state:D stack:0     pid:359=
2  tgid:3592  ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue: kblockd blk_mq_timeout_work
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_timeout+0x283/0x2c0
[Fri Oct 25 18:26:31 2024]  ? sched_balance_rq+0xe5/0xd90
[Fri Oct 25 18:26:31 2024]  ? __prepare_to_swait+0x52/0x80
[Fri Oct 25 18:26:31 2024]  wait_for_completion_state+0x173/0x1d0
[Fri Oct 25 18:26:31 2024]  __wait_rcu_gp+0x121/0x150
[Fri Oct 25 18:26:31 2024]  synchronize_rcu_normal.part.63+0x3a/0x60
[Fri Oct 25 18:26:31 2024]  ? __pfx_call_rcu_hurry+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ? __pfx_wakeme_after_rcu+0x10/0x10
[Fri Oct 25 18:26:31 2024]  synchronize_rcu_normal+0x9a/0xb0
[Fri Oct 25 18:26:31 2024]  blk_mq_timeout_work+0x142/0x1a0
[Fri Oct 25 18:26:31 2024]  process_scheduled_works+0xa3/0x3e0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x117/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/u1377:1:38000 blocked for mor=
e than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/u1377:1 state:D stack:0     pid:380=
00 tgid:38000 ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue: events_unbound idle_cull_fn
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  idle_cull_fn+0x3b/0xe0
[Fri Oct 25 18:26:31 2024]  process_scheduled_works+0xa3/0x3e0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x117/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/u1377:3:46111 blocked for mor=
e than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/u1377:3 state:D stack:0     pid:461=
11 tgid:46111 ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue: events_unbound idle_cull_fn
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  ? ttwu_do_activate+0x6a/0x210
[Fri Oct 25 18:26:31 2024]  idle_cull_fn+0x3b/0xe0
[Fri Oct 25 18:26:31 2024]  process_scheduled_works+0xa3/0x3e0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x117/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/u1377:5:46411 blocked for mor=
e than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/u1377:5 state:D stack:0     pid:464=
11 tgid:46411 ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue: events_unbound idle_cull_fn
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  ? try_to_wake_up+0x22e/0x690
[Fri Oct 25 18:26:31 2024]  idle_cull_fn+0x3b/0xe0
[Fri Oct 25 18:26:31 2024]  process_scheduled_works+0xa3/0x3e0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x117/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/u1379:6:53043 blocked for mor=
e than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/u1379:6 state:D stack:0     pid:530=
43 tgid:53043 ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue: events_unbound idle_cull_fn
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  idle_cull_fn+0x3b/0xe0
[Fri Oct 25 18:26:31 2024]  process_scheduled_works+0xa3/0x3e0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x117/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/u1377:7:53460 blocked for mor=
e than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/u1377:7 state:D stack:0     pid:534=
60 tgid:53460 ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue: events_unbound idle_cull_fn
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  idle_cull_fn+0x3b/0xe0
[Fri Oct 25 18:26:31 2024]  process_scheduled_works+0xa3/0x3e0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x117/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/u1377:6:67016 blocked for mor=
e than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/u1377:6 state:D stack:0     pid:670=
16 tgid:67016 ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue:  0x0 (events_unbound)
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  worker_attach_to_pool+0x1f/0xd0
[Fri Oct 25 18:26:31 2024]  create_worker+0xfa/0x1f0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x19c/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] INFO: task kworker/u1379:4:67681 blocked for mor=
e than 122 seconds.
[Fri Oct 25 18:26:31 2024]       Tainted: G S         OE      6.12.0-rc4-di=
s_fgs #1
[Fri Oct 25 18:26:31 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s" disables this message.
[Fri Oct 25 18:26:31 2024] task:kworker/u1379:4 state:D stack:0     pid:676=
81 tgid:67681 ppid:2      flags:0x00004000
[Fri Oct 25 18:26:31 2024] Workqueue: events_unbound idle_cull_fn
[Fri Oct 25 18:26:31 2024] Call Trace:
[Fri Oct 25 18:26:31 2024]  <TASK>
[Fri Oct 25 18:26:31 2024]  __schedule+0x347/0xd70
[Fri Oct 25 18:26:31 2024]  schedule+0x36/0xc0
[Fri Oct 25 18:26:31 2024]  schedule_preempt_disabled+0x15/0x30
[Fri Oct 25 18:26:31 2024]  __mutex_lock.isra.14+0x431/0x690
[Fri Oct 25 18:26:31 2024]  ? try_to_wake_up+0x22e/0x690
[Fri Oct 25 18:26:31 2024]  idle_cull_fn+0x3b/0xe0
[Fri Oct 25 18:26:31 2024]  process_scheduled_works+0xa3/0x3e0
[Fri Oct 25 18:26:31 2024]  worker_thread+0x117/0x240
[Fri Oct 25 18:26:31 2024]  ? __pfx_worker_thread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  kthread+0xcf/0x100
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork+0x31/0x40
[Fri Oct 25 18:26:31 2024]  ? __pfx_kthread+0x10/0x10
[Fri Oct 25 18:26:31 2024]  ret_from_fork_asm+0x1a/0x30
[Fri Oct 25 18:26:31 2024]  </TASK>
[Fri Oct 25 18:26:31 2024] Future hung task reports are suppressed, see sys=
ctl kernel.hung_task_warnings
[oracle@bhs-1 GNR startup_scripts]$ uname -a
Linux bhs-1 6.12.0-rc4-dis_fgs #1 SMP PREEMPT_DYNAMIC Fri Oct 25 07:26:06 P=
DT 2024 x86_64 x86_64 x86_64 GNU/Linux

