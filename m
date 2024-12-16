Return-Path: <linux-kernel+bounces-447128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158D9F2DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA351883949
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDDB202F90;
	Mon, 16 Dec 2024 10:02:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643B433B1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343366; cv=none; b=pyonqhmKlhvjqV248koXGREeBOMHHVzggMZooYcsWi5RyUT+wutB7aZ9wPI1qHC5yS4nlOeR6ecwrcbp8z0e/JZVK975Cv87rrSyALnv5e9D6l0Jq4fiq/8eMGE/lzVtnf7ROCL92EZq/mKuqoYerxW1IT8PiU2FHclPALT4cGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343366; c=relaxed/simple;
	bh=JI4//zBJfPQwYaorKuENhpUal7wvsVB+HLW976Yu0z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai6g33ba3th03VgJxMtxiaKEpJGClZ9H5EHto5rfWtkv3vMPr1nGpLBGrBBu/1ySS8OjAqcLJHqhLx9U9fXguTjOvK38P4eoC5YYKxYov6sGr/o8P6QLuaoChI3Mfyo8hxAbT+qMnuwU08yC/epZ8sFf4sTGrD+CJ0pxA8GKJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709BB113E;
	Mon, 16 Dec 2024 02:03:10 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CECB43F58B;
	Mon, 16 Dec 2024 02:02:40 -0800 (PST)
Date: Mon, 16 Dec 2024 10:02:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] arm64 fixes for 6.13-rc3
Message-ID: <Z1_6ukG_Lc5leG1o@J2N7QTR9R3>
References: <Z1xx0ha7lbKkdhRC@arm.com>
 <Z18MixiGByAqDYLC@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z18MixiGByAqDYLC@lappy>

On Sun, Dec 15, 2024 at 12:06:19PM -0500, Sasha Levin wrote:
> On Fri, Dec 13, 2024 at 05:41:38PM +0000, Catalin Marinas wrote:
> > - arm64 stacktrace: address some fallout from the recent changes to
> >  unwinding across exception boundaries
> 
> Hi Catalin, Mark,
> 
> It seems that kselftests can hit a warning that was addressed in the
> commit above:

I assume you're referring to commit:

  32ed1205682ec42a ("arm64: stacktrace: Skip reporting LR at exception boundaries")

... ?

That was intended to fix this specific issue, as explained in the commit
message (with a very similar splat from running the ftrace kselftests).

Am I missing something? i.e. are you saying it *doesn't* fix that?

Mark.

> <12>[   74.172204] kselftest: Running tests in ftrace
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: ftrace: ftracetest-ktap
> # unlink: cannot unlink '/opt/kselftests/default-in-kernel/ftrace/logs/latest': No such file or directory
> # TAP version 13
> # 1..145
> # ok 1 Basic trace file check
> <4>[  108.427656] hrtimer: interrupt took 13044036 ns
> <4>[  161.249175] sched: DL replenish lagged too much
> <4>[  163.845977] ------------[ cut here ]------------
> <4>[  163.851787] WARNING: CPU: 1 PID: 31 at arch/arm64/kernel/stacktrace.c:141 arch_stack_walk+0x4a0/0x4b0
> <4>[  163.861012] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
> <4>[  163.890268] CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted 6.13.0-rc2 #1
> <4>[  163.897386] Hardware name: linux,dummy-virt (DT)
> <4>[  163.904217] Workqueue:  0x0 (mm_percpu_wq)
> <4>[  163.915526] pstate: 624020c9 (nZCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> <4>[  163.924218] pc : arch_stack_walk+0x4a0/0x4b0
> <4>[  163.930593] lr : arch_stack_walk+0x2bc/0x4b0
> <4>[  163.937101] sp : ffff80008000b920
> <4>[  163.942456] x29: ffff80008000b9d0 x28: fff00000ff6d9400 x27: fff00000ff6d9928
> <4>[  163.954275] x26: 0000000000000001 x25: 00000000000000c0 x24: ffffae003d389d40
> <4>[  163.967208] x23: 09cfae003ae216b4 x22: ffffae003ae2e4b0 x21: ffffae003ae35c70
> <4>[  163.978823] x20: ffff80008000ba10 x19: ffffae003ae216f0 x18: 0000000000000014
> <4>[  163.989751] x17: 0000000000000000 x16: ffff800080008000 x15: 00000000b5b23a12
> <4>[  164.000780] x14: 000000005865dcaf x13: 00000000b77eca6d x12: 0000959eae5a34e8
> <4>[  164.011592] x11: ffffae003d44a670 x10: ffff80008000b920 x9 : ffffae003ae2e4b0
> <4>[  164.022498] x8 : ffff800080043e00 x7 : fff00000c682c000 x6 : 00000000ffffffff
> <4>[  164.033396] x5 : fff00000c682c000 x4 : 0000000000000000 x3 : ffff80008000bda0
> <4>[  164.045100] x2 : ffffae003ae2e4b0 x1 : ffffae003ae2e4b0 x0 : ffffae003ae2e4b0
> <4>[  164.057084] Call trace:
> <4>[  164.061489]  arch_stack_walk+0x4a0/0x4b0 (P)
> <4>[  164.067225]  arch_stack_walk+0x2bc/0x4b0 (L)
> <4>[  164.073009]  profile_pc+0x44/0x80
> <4>[  164.078489]  profile_tick+0x50/0x80 (F)
> <4>[  164.085151]  tick_nohz_handler+0xcc/0x160 (F)
> <4>[  164.091427]  __hrtimer_run_queues+0x2c4/0x358 (F)
> <4>[  164.098138]  hrtimer_interrupt+0xf4/0x268 (F)
> <4>[  164.105401]  arch_timer_handler_phys+0x34/0x58 (F)
> <4>[  164.114958]  handle_percpu_devid_irq+0x8c/0x218 (F)
> <4>[  164.120914]  generic_handle_domain_irq+0x34/0x58 (F)
> <4>[  164.127570]  gic_handle_irq+0x54/0x128 (F)
> <4>[  164.135008]  do_interrupt_handler+0x58/0x98 (F)
> <4>[  164.140769]  el1_interrupt+0x34/0x68 (F)
> <4>[  164.146665]  el1h_64_irq_handler+0x18/0x28
> <4>[  164.151813]  el1h_64_irq+0x6c/0x70
> <4>[  164.160007]  _raw_spin_unlock_irq+0x28/0x58 (PF)
> <4>[  164.176292] ------------[ cut here ]------------
> <4>[  164.187816] WARNING: CPU: 1 PID: 31 at arch/arm64/kernel/stacktrace.c:141 dump_backtrace+0x620/0x660
> <4>[  164.209007] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
> <4>[  164.252638] CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted 6.13.0-rc2 #1
> <4>[  164.260491] Hardware name: linux,dummy-virt (DT)
> <4>[  164.266531] Workqueue:  0x0 (mm_percpu_wq)
> <4>[  164.275972] pstate: 624023c9 (nZCv DAIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> <4>[  164.282685] pc : dump_backtrace+0x620/0x660
> <4>[  164.288093] lr : dump_backtrace+0x410/0x660
> <4>[  164.293392] sp : ffff80008000b510
> <4>[  164.297983] x29: ffff80008000b5c0 x28: fff00000c08c91c0 x27: fff00000ff6d9928
> <4>[  164.309075] x26: ffff80008000bda0 x25: ffffae003cd0c000 x24: ffffae003cedfaa0
> <4>[  164.320534] x23: ffffae003cce90b8 x22: ffffae003ae35c70 x21: ffffae003ccd80a8
> <4>[  164.331352] x20: ffffae003cd1fd38 x19: fff00000c08c91c0 x18: 0000000000000006
> <4>[  164.343050] x17: 0000000000000000 x16: ffff800080008000 x15: ffff80008000af40
> <4>[  164.354100] x14: ffff80010000b0fa x13: ffff80008000b102 x12: ffffae003d410098
> <4>[  164.366177] x11: ffffae003d44a670 x10: ffff80008000b350 x9 : ffffae003ae2e4b0
> <4>[  164.378146] x8 : ffff800080043e00 x7 : fff00000c682c000 x6 : 00000000ffffffff
> <4>[  164.389041] x5 : fff00000c682c000 x4 : 0000000000000000 x3 : ffff80008000bda0
> <4>[  164.400262] x2 : ffffae003ae2e4b0 x1 : ffffae003ae2e4b0 x0 : ffffae003ae2e4b0
> <4>[  164.411526] Call trace:
> <4>[  164.415800]  dump_backtrace+0x620/0x660 (P)
> <4>[  164.421415]  dump_backtrace+0x410/0x660 (L)
> <4>[  164.427393]  show_regs+0x34/0x50 (F)
> <4>[  164.434342]  __warn+0x98/0x198 (F)
> <4>[  164.439610]  report_bug+0x1dc/0x200 (F)
> <4>[  164.444981]  bug_handler+0x2c/0x90
> <4>[  164.450151]  call_break_hook+0x6c/0x88 (F)
> <4>[  164.455802]  brk_handler+0x24/0x70 (F)
> <4>[  164.460935]  do_debug_exception+0x74/0x118 (F)
> <4>[  164.466742]  el1_dbg+0x70/0x90 (F)
> <4>[  164.471595]  el1h_64_sync_handler+0xd4/0x120
> <4>[  164.477225]  el1h_64_sync+0x6c/0x70
> <4>[  164.482730]  arch_stack_walk+0x4a0/0x4b0 (P)
> <4>[  164.488313]  arch_stack_walk+0x2bc/0x4b0 (L)
> <4>[  164.494329]  profile_pc+0x44/0x80
> <4>[  164.499430]  profile_tick+0x50/0x80 (F)
> <4>[  164.504776]  tick_nohz_handler+0xcc/0x160 (F)
> <4>[  164.511508]  __hrtimer_run_queues+0x2c4/0x358 (F)
> <4>[  164.519213]  hrtimer_interrupt+0xf4/0x268 (F)
> <4>[  164.525536]  arch_timer_handler_phys+0x34/0x58 (F)
> <4>[  164.531384]  handle_percpu_devid_irq+0x8c/0x218 (F)
> <4>[  164.537153]  generic_handle_domain_irq+0x34/0x58 (F)
> <4>[  164.543448]  gic_handle_irq+0x54/0x128 (F)
> <4>[  164.548744]  do_interrupt_handler+0x58/0x98 (F)
> <4>[  164.555359]  el1_interrupt+0x34/0x68 (F)
> <4>[  164.561123]  el1h_64_irq_handler+0x18/0x28
> <4>[  164.567261]  el1h_64_irq+0x6c/0x70
> <4>[  164.573197]  _raw_spin_unlock_irq+0x28/0x58 (PF)
> <4>[  164.580018] ---[ end trace 0000000000000000 ]---
> <4>[  164.585812] ---[ end trace 0000000000000000 ]---
> 
> -- 
> Thanks,
> Sasha
> 

