Return-Path: <linux-kernel+bounces-264806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4A693E89A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAEE2813DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D84DA13;
	Sun, 28 Jul 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psZWwkNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CEA35;
	Sun, 28 Jul 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722184485; cv=none; b=DFxKM/7QCNwwxRXeeLPq9TFWKfS9LRJdzXOeCRXPJfPYsBAgGVkUbYnfn7BEoefc8OUT1HcJT/PPJsUJcvu6+J66ZhpyJbAJvcY3MPSd1bsZFh+XlX5K31CA/cV3OmCz9CDFiUs/XeIWpsFM/TMiOUt+UeGiyfpbZAorC4rY+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722184485; c=relaxed/simple;
	bh=ofb1nSJ0RL/j+KBYl6x8fMvCbBUsX1OAVlBXjganODg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDVj/4mqByZgYhBqPlEqLF8fQdwqyfZd2LoGoQslNMrlCUvYkWDC59ZY28NK6wF3jOAVGDzDtDmlPwzHnjNaKHObAhSERzGi0crxvtR/prtgRwI2YQcKyTz4T5nihV/cb+Q6xzzQQZUsDgETMboWdu2lcD5IkIQAyf/VslXZ3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psZWwkNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CE9C116B1;
	Sun, 28 Jul 2024 16:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722184485;
	bh=ofb1nSJ0RL/j+KBYl6x8fMvCbBUsX1OAVlBXjganODg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=psZWwkNOvhJwsJiOXiWpSagIhDWZ3U99X2wUuT8Yl/N7+M/dSH3Bm0WAM+/M1OI6o
	 nlVn4AtWkC3QSJYwpmscpXD8f6W2cdOz+/yWyqmAV2VmGNm82+siDW3k0DwF6fBJT+
	 ldKlM3BaEQ2yQAVTsqXHWPnrpNoW0PBYsD4WBsZE0xPjjlwJ8fMEsOc+OGAMVV7eY0
	 epMwuCUiiaeVLidTcb2BiMMmZuRJ8VAexkunIKyqJ1jnQcCbADKlQ7uc7D9eClS2cW
	 BUZ1Dln9WAm1NCR/S8P4C43dpuRF0WiBL80jeI8FcEQrrXKpiVkEvrbbpH6qt5yzks
	 uyC39h5ojVkJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 937A0CE0A6E; Sun, 28 Jul 2024 09:34:44 -0700 (PDT)
Date: Sun, 28 Jul 2024 09:34:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.07.17a] [EXP rcuscale] 9e146da3f3:
 WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload
Message-ID: <20ca1e96-6b79-4533-96a9-41932f997679@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202407251351.f65c33a0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407251351.f65c33a0-lkp@intel.com>

On Thu, Jul 25, 2024 at 02:49:28PM +0800, kernel test robot wrote:
> 
> hi, Paul E. McKenney,
> 
> we noticed in commit message "Not for mainline in its current form".
> 
> we saw below commits in the branch:
> cdd5ddaa17fe fixup! EXP rcuscale: Dump debug info
> 4f60b8b679fd squash! EXP rcuscale: Dump debug info
> 
> but we still observed same issue on the branch tip:
> fe09f037acf7 (dev.2024.07.17a) rcuscale: Make rcu_scale_writer() tolerate repeated GFP_KERNEL failure
> 
> at the same time, we noticed there is no same title commit in newer branch:
> dev.2024.07.18a
> 
> just still made below formal report to you since we are not sure if it could
> supply any useful information. if not, please just ignore. Thanks!

I believe that I have fixed this in the current "dev" branch by fusing
a half-fix with the remainder of the fix.  Please let me know if I am
mistaken, and thank you for your testing work!

							Thanx, Paul

> Hello,
> 
> kernel test robot noticed "WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload" on:
> 
> commit: 9e146da3f351c0eaf66756cc3a6c6a5845b81187 ("EXP rcuscale: Dump debug info")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2024.07.17a
> 
> in testcase: rcuscale
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	scale_type: tasks-tracing
> 
> 
> 
> compiler: gcc-13
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-----------------------------------------------------+------------+------------+
> |                                                     | e136892a8e | 9e146da3f3 |
> +-----------------------------------------------------+------------+------------+
> | WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload | 0          | 12         |
> | EIP:alloc_tag_module_unload                         | 0          | 12         |
> +-----------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407251351.f65c33a0-lkp@intel.com
> 
> 
> [  439.356638][ T1799] ------------[ cut here ]------------
> [  439.357183][ T1799] kernel/rcu/rcuscale.c:1037 module rcuscale func:rcu_scale_init has 8 allocated at module unload
> [ 439.357225][ T1799] WARNING: CPU: 0 PID: 1799 at lib/alloc_tag.c:168 alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
> [  439.358903][ T1799] Modules linked in: rcuscale(-) torture [last unloaded: rcuscale]
> [  439.359632][ T1799] CPU: 0 PID: 1799 Comm: rmmod Not tainted 6.10.0-rc5-00110-g9e146da3f351 #1 308a8ed8688556473cf6c28b678fa76bc00dc1d7
> [  439.360679][ T1799] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 439.361546][ T1799] EIP: alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
> [ 439.361993][ T1799] Code: 92 ff ff ff 8b 55 e8 8b 45 e4 85 d2 75 04 85 c0 74 21 52 50 ff 73 0c ff 73 08 ff 73 04 ff 73 10 68 d8 2f cb c2 e8 ec 39 9f ff <0f> 0b c6 45 d3 00 83 c4 1c 8d 45 d4 e8 2e fc ff ff 89 c3 eb b2 8a
> All code
> ========
>    0:	92                   	xchg   %eax,%edx
>    1:	ff                   	(bad)
>    2:	ff                   	(bad)
>    3:	ff 8b 55 e8 8b 45    	decl   0x458be855(%rbx)
>    9:	e4 85                	in     $0x85,%al
>    b:	d2 75 04             	shlb   %cl,0x4(%rbp)
>    e:	85 c0                	test   %eax,%eax
>   10:	74 21                	je     0x33
>   12:	52                   	push   %rdx
>   13:	50                   	push   %rax
>   14:	ff 73 0c             	push   0xc(%rbx)
>   17:	ff 73 08             	push   0x8(%rbx)
>   1a:	ff 73 04             	push   0x4(%rbx)
>   1d:	ff 73 10             	push   0x10(%rbx)
>   20:	68 d8 2f cb c2       	push   $0xffffffffc2cb2fd8
>   25:	e8 ec 39 9f ff       	call   0xffffffffff9f3a16
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	c6 45 d3 00          	movb   $0x0,-0x2d(%rbp)
>   30:	83 c4 1c             	add    $0x1c,%esp
>   33:	8d 45 d4             	lea    -0x2c(%rbp),%eax
>   36:	e8 2e fc ff ff       	call   0xfffffffffffffc69
>   3b:	89 c3                	mov    %eax,%ebx
>   3d:	eb b2                	jmp    0xfffffffffffffff1
>   3f:	8a                   	.byte 0x8a
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	c6 45 d3 00          	movb   $0x0,-0x2d(%rbp)
>    6:	83 c4 1c             	add    $0x1c,%esp
>    9:	8d 45 d4             	lea    -0x2c(%rbp),%eax
>    c:	e8 2e fc ff ff       	call   0xfffffffffffffc3f
>   11:	89 c3                	mov    %eax,%ebx
>   13:	eb b2                	jmp    0xffffffffffffffc7
>   15:	8a                   	.byte 0x8a
> [  439.363599][ T1799] EAX: 00000000 EBX: efbf9040 ECX: 00000000 EDX: 00000000
> [  439.364218][ T1799] ESI: c4215290 EDI: ebdfdedc EBP: ebdfdee8 ESP: ebdfde9c
> [  439.364818][ T1799] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00210246
> [  439.365471][ T1799] CR0: 80050033 CR2: b71fd210 CR3: 04026300 CR4: 000406b0
> [  439.366083][ T1799] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  439.366676][ T1799] DR6: fffe0ff0 DR7: 00000400
> [  439.367170][ T1799] Call Trace:
> [ 439.367451][ T1799] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
> [ 439.367803][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
> [ 439.368264][ T1799] ? __warn (kernel/panic.c:693) 
> [ 439.368604][ T1799] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
> [ 439.368992][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
> [ 439.369435][ T1799] ? exc_overflow (arch/x86/kernel/traps.c:252) 
> [ 439.369807][ T1799] ? handle_bug (arch/x86/kernel/traps.c:239) 
> [ 439.370162][ T1799] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
> [ 439.370549][ T1799] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
> [ 439.371024][ T1799] ? exc_overflow (arch/x86/kernel/traps.c:252) 
> [ 439.371397][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
> [ 439.371843][ T1799] ? exc_overflow (arch/x86/kernel/traps.c:252) 
> [ 439.372238][ T1799] ? alloc_tag_module_unload (lib/alloc_tag.c:168 (discriminator 1)) 
> [ 439.372693][ T1799] codetag_unload_module (lib/codetag.c:238 (discriminator 1)) 
> [ 439.373112][ T1799] free_module (kernel/module/main.c:1266) 
> [ 439.373470][ T1799] __do_sys_delete_module+0x1b9/0x206 
> [ 439.373968][ T1799] __ia32_sys_delete_module (kernel/module/main.c:700) 
> [ 439.374397][ T1799] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-061-20240719/./arch/x86/include/generated/asm/syscalls_32.h:130) 
> [ 439.374780][ T1799] do_int80_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:339 (discriminator 1)) 
> [ 439.375225][ T1799] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
> [  439.375611][ T1799] EIP: 0xb7f79092
> [ 439.375910][ T1799] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
> All code
> ========
>    0:	00 00                	add    %al,(%rax)
>    2:	00 e9                	add    %ch,%cl
>    4:	90                   	nop
>    5:	ff                   	(bad)
>    6:	ff                   	(bad)
>    7:	ff                   	(bad)
>    8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
>    e:	68 30 00 00 00       	push   $0x30
>   13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
>   18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
>   1e:	66 90                	xchg   %ax,%ax
> 	...
>   28:	cd 80                	int    $0x80
>   2a:*	c3                   	ret		<-- trapping instruction
>   2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>   38:	8b 1c 24             	mov    (%rsp),%ebx
>   3b:	c3                   	ret
>   3c:	8d                   	.byte 0x8d
>   3d:	b4 26                	mov    $0x26,%ah
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	c3                   	ret
>    1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>    e:	8b 1c 24             	mov    (%rsp),%ebx
>   11:	c3                   	ret
>   12:	8d                   	.byte 0x8d
>   13:	b4 26                	mov    $0x26,%ah
> 	...
> [  439.377475][ T1799] EAX: ffffffda EBX: 00e4333c ECX: 00000800 EDX: 00484939
> [  439.378043][ T1799] ESI: 00e43300 EDI: 00e43300 EBP: bfbcdc46 ESP: bfbcccc4
> [  439.378610][ T1799] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200202
> [  439.379237][ T1799] irq event stamp: 5473
> [ 439.379574][ T1799] hardirqs last enabled at (5483): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2746 kernel/printk/printk.c:3065) 
> [ 439.380336][ T1799] hardirqs last disabled at (5494): console_unlock (kernel/printk/printk.c:339 (discriminator 3) kernel/printk/printk.c:2746 (discriminator 3) kernel/printk/printk.c:3065 (discriminator 3)) 
> [ 439.381023][ T1799] softirqs last enabled at (5142): handle_softirqs (kernel/softirq.c:401 (discriminator 2) kernel/softirq.c:582 (discriminator 2)) 
> [ 439.381726][ T1799] softirqs last disabled at (5133): __do_softirq (kernel/softirq.c:589) 
> [  439.382384][ T1799] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240725/202407251351.f65c33a0-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

