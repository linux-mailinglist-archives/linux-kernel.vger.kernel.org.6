Return-Path: <linux-kernel+bounces-253154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77E931D84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A9AB222B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030A1411EB;
	Mon, 15 Jul 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlmMJ+dM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670E20DF4;
	Mon, 15 Jul 2024 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721085292; cv=none; b=PvP8onAddDty+PsXbXnxJHUunpb4m1QKBsUUNLLa21BP5n2EUFb1jVsM6g9MxQhEY+IOYJczODkg1FSbeIoLQVx+/FWrFoZPRXQstDqFKjejGN4Zq1hYjuYgZ+mmG24sGWM9X1M1B1N78y8xXxlbrLeV4eFcTt4+UjDCCperetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721085292; c=relaxed/simple;
	bh=ritWV+OYVcHsKyTDrpQbx04dlvrJNLYOqNN467NHmNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5+x8Xq18RR3UEKW+fmmr6L3BM6aXTa9WSmNNzHDTmuBBu+cFAtBYq9cfWTcnVQEVYKQ4kFcyrN1mPizgL/9XhFfdcAz+z7V5jnXYq/Hzw4NJpNxlun7nqDsUfbN5YS38MJAy98wYRIsfmxYt4axocj8Z9FtjYmMsi2/SPEBM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlmMJ+dM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E52CC4AF0C;
	Mon, 15 Jul 2024 23:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721085291;
	bh=ritWV+OYVcHsKyTDrpQbx04dlvrJNLYOqNN467NHmNA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OlmMJ+dMZeiZsplKWLrmbF3HUv2aBGYXEFtu5wDQgM4Hmsp2cIZJ00KqPVjGLwjmI
	 7dDqvqRd828pif2k2zgs8W5cPR5400RhsS3gUZvR81F4pVOsFw/1lGtLb8BUkcJpo8
	 0cKlPQkZrySmssUwk7kxotNB5glZMTLJ/Pp5RsUe6hvFMgMpnH1XqO3H6P9eVlSkSM
	 Jvgd9+hcbh3Op2dysmGVyLT282mb8aNAh0pPPXmHg2aSIpH39Rk16yRLrQQqR5mJvO
	 mFkodRqL3ob1R06uXKMKufr/cqnuxX1u0EOWdwrMS7uLTzqgSjCjPC4xNRrnKYk+Od
	 smQ6xPuV8HBiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 184A7CE134B; Mon, 15 Jul 2024 16:14:51 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:14:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [tip:timers/urgent] [timers/migration]  8cdb61838e:
 WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent
Message-ID: <68204aba-dc0a-47dc-902b-76d6553e17de@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202407101636.d9d4e8be-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407101636.d9d4e8be-oliver.sang@intel.com>

On Wed, Jul 10, 2024 at 04:37:00PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/time/timer_migration.c:#tmigr_connect_child_parent" on:
> 
> commit: 8cdb61838ee5c63556773ea2eed24deab6b15257 ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/urgent

For whatever it is worth, I am also seeing this on refscale runs on
recent -next.

The reproducer is to clone perfbook [1] in your ~/git directory
(as in ~/git/perfboot), then run this from your Linux source tree,
preferably on a system with few CPUs:

bash ~/git/perfbook/CodeSamples/defer/rcuscale.sh

The output will have "FAIL" in it, which indicates that the corresponding
guest OS splatted.  If it would be useful, I would be happy to produce
a one-liner that runs the guest OS only once and leaves the console
output around.  Otherwise, I will continue being lazy.  ;-)

							Thanx, Paul

[1] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git

> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
> 
> in testcase: filebench
> version: filebench-x86_64-22620e6-1_20240224
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: randomwrite.f
> 	cpufreq_governor: performance
> 
> 
> 
> compiler: gcc-13
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407101636.d9d4e8be-oliver.sang@intel.com
> 
> 
> [   16.306955][  T209] ------------[ cut here ]------------
> [ 16.312287][ T209] WARNING: CPU: 32 PID: 209 at kernel/time/timer_migration.c:1620 tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
> [   16.323148][  T209] Modules linked in:
> [   16.326901][  T209] CPU: 32 PID: 209 Comm: cpuhp/32 Not tainted 6.10.0-rc6-00002-g8cdb61838ee5 #1
> [ 16.335766][ T209] RIP: 0010:tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
> [ 16.341945][ T209] Code: c6 07 00 0f 1f 00 fb 66 90 0f b6 45 60 48 89 e2 48 89 ee 48 89 df 88 44 24 18 e8 ec fc ff ff 84 c0 75 09 48 83 7b 08 00 74 02 <0f> 0b 48 8b 44 24 20 65 48 2b 04 25 28 00 00 00 75 36 48 83 c4 28
> All code
> ========
>    0:	c6 07 00             	movb   $0x0,(%rdi)
>    3:	0f 1f 00             	nopl   (%rax)
>    6:	fb                   	sti    
>    7:	66 90                	xchg   %ax,%ax
>    9:	0f b6 45 60          	movzbl 0x60(%rbp),%eax
>    d:	48 89 e2             	mov    %rsp,%rdx
>   10:	48 89 ee             	mov    %rbp,%rsi
>   13:	48 89 df             	mov    %rbx,%rdi
>   16:	88 44 24 18          	mov    %al,0x18(%rsp)
>   1a:	e8 ec fc ff ff       	callq  0xfffffffffffffd0b
>   1f:	84 c0                	test   %al,%al
>   21:	75 09                	jne    0x2c
>   23:	48 83 7b 08 00       	cmpq   $0x0,0x8(%rbx)
>   28:	74 02                	je     0x2c
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
>   31:	65 48 2b 04 25 28 00 	sub    %gs:0x28,%rax
>   38:	00 00 
>   3a:	75 36                	jne    0x72
>   3c:	48 83 c4 28          	add    $0x28,%rsp
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
>    7:	65 48 2b 04 25 28 00 	sub    %gs:0x28,%rax
>    e:	00 00 
>   10:	75 36                	jne    0x48
>   12:	48 83 c4 28          	add    $0x28,%rsp
> [   16.361382][  T209] RSP: 0000:ffa0000007587da0 EFLAGS: 00010286
> [   16.367302][  T209] RAX: 0000000000000000 RBX: ff11002000b56b00 RCX: 0000000000010101
> [   16.375130][  T209] RDX: 0000000000010101 RSI: ff11002000b56b00 RDI: ff11002000b56b50
> [   16.382955][  T209] RBP: ff11002000b57500 R08: 0000000000000101 R09: ffa0000007587da0
> [   16.390782][  T209] R10: 0000000000000001 R11: 00000000c5672a10 R12: 0000000000000001
> [   16.398608][  T209] R13: ff11001084311240 R14: 0000000000000020 R15: 0000000000000002
> [   16.406433][  T209] FS:  0000000000000000(0000) GS:ff11001fffe00000(0000) knlGS:0000000000000000
> [   16.415213][  T209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.421650][  T209] CR2: 0000000000000000 CR3: 000000207de1c001 CR4: 0000000000771ef0
> [   16.429477][  T209] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   16.437301][  T209] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   16.445128][  T209] PKRU: 55555554
> [   16.448535][  T209] Call Trace:
> [   16.451680][  T209]  <TASK>
> [ 16.454479][ T209] ? __warn (kernel/panic.c:693) 
> [ 16.458405][ T209] ? tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
> [ 16.463980][ T209] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
> [ 16.468338][ T209] ? handle_bug (arch/x86/kernel/traps.c:239) 
> [ 16.472523][ T209] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
> [ 16.477055][ T209] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> [ 16.481936][ T209] ? tmigr_connect_child_parent (kernel/time/timer_migration.c:1620 (discriminator 7)) 
> [ 16.487507][ T209] tmigr_setup_groups+0x1e6/0x430 
> [ 16.492993][ T209] ? __pfx_tmigr_cpu_prepare (kernel/time/timer_migration.c:1727) 
> [ 16.498305][ T209] tmigr_cpu_prepare (kernel/time/timer_migration.c:1721 kernel/time/timer_migration.c:1737) 
> [ 16.502927][ T209] cpuhp_invoke_callback (kernel/cpu.c:194) 
> [ 16.507980][ T209] ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
> [ 16.513291][ T209] cpuhp_thread_fun (kernel/cpu.c:1092 (discriminator 1)) 
> [ 16.517910][ T209] smpboot_thread_fn (kernel/smpboot.c:164) 
> [ 16.522615][ T209] kthread (kernel/kthread.c:389) 
> [ 16.526367][ T209] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 16.530814][ T209] ret_from_fork (arch/x86/kernel/process.c:147) 
> [ 16.535088][ T209] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 16.539533][ T209] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [   16.544153][  T209]  </TASK>
> [   16.547039][  T209] ---[ end trace 0000000000000000 ]---
> [   16.562459][    T1] Timer migration setup failed
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240710/202407101636.d9d4e8be-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

