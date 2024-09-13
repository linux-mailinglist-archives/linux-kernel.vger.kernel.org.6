Return-Path: <linux-kernel+bounces-328128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6D7977F38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5710E1F22375
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A91D86EC;
	Fri, 13 Sep 2024 12:05:07 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B031BFDF6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229106; cv=none; b=V2FrDzk5OAAcdSY/MoYETN/UjCyzIwEPUTMXVox5i4ePBs6tHtxZzWPkcs6Y0/X3KRuX7k+4RvN0uiI0OnJKaA6G5FnpZpuXeARRK+RJtLV5cF9KTgPOIJcVgVK2i4MrtDzwVuUUZYO0BYtitWMnfkJjnU5EM+fZKDyU8mQSYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229106; c=relaxed/simple;
	bh=exU9QjcC2w7AaH/pFu+GZ3Kx35YAg/CVUswqVPBr4rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGt2ErygfXgGSNCGqSBZrQeLy+JCx5y3KFM9pYcIsB0evXvQra9x63NBKaofMwEbd9KGpXDdv9a0jEIe8w00DB+qejXtJLjjR5zken/d5IvCr3UsqYcDDqTWQ1f2vdCnBVh9ZbOW0GGJkqS3+IOdTCQGDXyw6PRkZKzGVhI4Z10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp80t1726228995tadjm1cv
X-QQ-Originating-IP: tO6Pm2ZGZpIxpmvjd2OnTANIzqJww01Z/x1AjQXFl1s=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 20:03:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17033916743743762727
Date: Fri, 13 Sep 2024 20:02:41 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Subject: Re: [PATCH 1/2] powerpc/entry: convert to common and generic entry
Message-ID: <F81D1486B7B82141+ZuQp4YQkAA2cB9Rw@HX09040029.powercore.com.cn>
References: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
 <fc509bcd-5ca0-4dc2-962e-766a01cbe4fb@csgroup.eu>
 <153FD6B5CE4F97D9+ZuOYDQ-iHIIwJjbh@HX09040029.powercore.com.cn>
 <95ced963-b584-4ccf-ba34-8f2ba99172f4@csgroup.eu>
 <0332BAE1905768B6+ZuPsBvgv0nwmFAjW@HX09040029.powercore.com.cn>
 <854eef54-4779-4233-a958-0c98ae5fcb7e@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <854eef54-4779-4233-a958-0c98ae5fcb7e@csgroup.eu>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

On Fri, Sep 13, 2024 at 10:30:56AM +0200, Christophe Leroy wrote:
> 
> 
> Le 13/09/2024 à 09:38, Luming Yu a écrit :
> > On Fri, Sep 13, 2024 at 08:54:12AM +0200, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 13/09/2024 à 03:40, Luming Yu a écrit :
> > > > On Thu, Sep 12, 2024 at 12:23:29PM +0200, Christophe Leroy wrote:
> > > > > 
> > > > > 
> > > > > Le 12/09/2024 à 10:24, Luming Yu a écrit :
> > > > > > From: Yu Luming <luming.yu@gmail.com>
> > > > > > 
> > > > > > convert powerpc entry code in syscall and fault to use syscall_work
> > > > > > and irqentry_state as well as common calls from generic entry infrastructure.
> > > > > > 
> > > > > > Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> > > > > > ---
> > > > > >     arch/powerpc/Kconfig                   | 1 +
> > > > > >     arch/powerpc/include/asm/hw_irq.h      | 5 +++++
> > > > > >     arch/powerpc/include/asm/processor.h   | 6 ++++++
> > > > > >     arch/powerpc/include/asm/syscall.h     | 5 +++++
> > > > > >     arch/powerpc/include/asm/thread_info.h | 1 +
> > > > > >     arch/powerpc/kernel/syscall.c          | 6 +++++-
> > > > > >     arch/powerpc/mm/fault.c                | 5 +++++
> > > > > >     7 files changed, 28 insertions(+), 1 deletion(-)
> > > > > 
> > > > > There is another build problem:
> > > > > 
> > > > >     CC      kernel/entry/common.o
> > > > > kernel/entry/common.c: In function 'irqentry_exit':
> > > > > kernel/entry/common.c:335:21: error: implicit declaration of function
> > > > > 'regs_irqs_disabled'; did you mean 'raw_irqs_disabled'?
> > > > > [-Werror=implicit-function-declaration]
> > > > >     335 |         } else if (!regs_irqs_disabled(regs)) {
> > > > >         |                     ^~~~~~~~~~~~~~~~~~
> > > > >         |                     raw_irqs_disabled
> > > > > 
> > > > > 
> > > > > You have put regs_irqs_disabled() in a section dedicated to PPC64, so it
> > > > > fails on PPC32.
> > > > > 
> > > > > 
> > > > > After fixing this problem and providing an empty asm/entry-common.h it is
> > > > > now possible to build the kernel. But that's not enough, the board is stuck
> > > > > after:
> > > > > 
> > > > > ...
> > > > > [    2.871391] Freeing unused kernel image (initmem) memory: 1228K
> > > > > [    2.877990] Run /init as init process
> > > > 
> > > > Thanks for these questions. :-)
> > > > I haven't gotten chance to run it in ppc32 qemu.
> > > > the common syscall trace enter lost this hunk
> > > > -       if (!is_32bit_task())
> > > > -               audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
> > > > -                                   regs->gpr[5], regs->gpr[6]);
> > > > -       else
> > > > -               audit_syscall_entry(regs->gpr[0],
> > > > -                                   regs->gpr[3] & 0xffffffff,
> > > > -                                   regs->gpr[4] & 0xffffffff,
> > > > -                                   regs->gpr[5] & 0xffffffff,
> > > > -                                   regs->gpr[6] & 0xffffffff);
> > > > which I don't understand whether we need a arch callbacks for it.
> > > 
> > > I don't thing so.
> > > 
> > > As far as I can see, audit_syscall_entry() is called by
> > > syscall_enter_audit() in kernel/entry/common.c
> > > 
> > > And the masking of arguments based on is_32bit_task() is done in
> > > syscall_get_arguments() with is called by
> > > syscall_enter_audit() just before calling audit_syscall_entry() and which is
> > > an arch callback that does the same as the removed hunk.
> > so, syscall_get_arguments is the ppc arch callback. thanks. :-)
> > > > 
> > > > Before I sent out the RFC patch set, the very limited compile and boot test goes well with a ppc64 qemu VM. Surely, there will be a lot of test, debug and following up patch set update that is necessary to make it a complete convert.
> > > 
> > > Even on ppc64 it doesn't build, at the first place because
> > > arch/powerpc/include/asm/entry-common.h is missing in your patch. Did you
> > > forget to 'git add' it ?
> > oh, I forget that I was testing this patch on top of the early user notifier patch:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Flinuxppc%2Fissues%2Fissues%2F477&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C35a08ca9a81f4c6ff8ce08dcd3c73555%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638618099770810941%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=yCQWLIAXL%2BNHnzrh0e91WIBvF0c5WfF6pY6ZMHstocA%3D&reserved=0, https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinuxppc-dev%2Fpatch%2F1FD36D52828D2506%2B20231218031309.2063-1-luming.yu%40shingroup.cn%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C35a08ca9a81f4c6ff8ce08dcd3c73555%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638618099770819779%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=0WBSUlpAbL6EMdPEAtJv1HUHkbeUjjUcP98wYf9IxM4%3D&reserved=0
> > and the entry-common.h is as follows:
> > [root@localhost linux]# cat arch/powerpc/include/asm/entry-common.h
> > /* SPDX-License-Identifier: GPL-2.0 */
> > #ifndef ARCH_POWERPC_ENTRY_COMMON_H
> > #define ARCH_POWERPC_ENTRY_COMMON_H
> > 
> > #include <linux/user-return-notifier.h>
> > 
> > static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
> >                                                    unsigned long ti_work)
> > {
> >          if (ti_work & _TIF_USER_RETURN_NOTIFY)
> >                  fire_user_return_notifiers();
> > }
> > 
> > #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> > 
> > #endif
> > 
> > As you could see , it looks irrelevant.
> > > 
> > > And same as with PPC32, when I build PPC64 with an empty asm/entry-common.h,
> > > it doesn't work. So, I guess you had some needed code in that file and you
> > > have to send it.
> > 
> > please send me your kernel config and let me reproduce and double check
> > if there could be another bit of code make the difference. My test p8 64bit VM boots
> > an unmodified fedora 38 user space just fine with the patch.
> > After boot, the only difference is make install of kernel could hang for a while, that
> > I'm not sure how that could happen yet. and I plan to do some unit test for many common
> > features like : lockdep, ptrace, rcu, audit...
> > > 
> > 
> 
> 
> I tested with both ppc64_defconfig and ppc64le_defconfig. With those two
> configs QEMU remains stuck after the following lines. I use QEMU with
> machine pseries:
> 
> [    2.701874][    T1] Running code patching self-tests ...
> [    2.734007][    T1] registered taskstats version 1
> [    2.735891][    T1] Loading compiled-in X.509 certificates
> [    2.756472][    T1] Loaded X.509 cert 'Build time autogenerated kernel
> key: 003f25410c2285abf44b4685b6d63682a2dc9f11'
> [    2.784474][    T1] Demotion targets for Node 0: null
> [    2.784748][    T1] page_owner is disabled
> [    2.786795][    T1] Secure boot mode disabled
> [    2.787436][    T1] ima: No TPM chip found, activating TPM-bypass!
> [    2.787568][    T1] Loading compiled-in module X.509 certificates
> [    2.790854][    T1] Loaded X.509 cert 'Build time autogenerated kernel
> key: 003f25410c2285abf44b4685b6d63682a2dc9f11'
> [    2.791289][    T1] ima: Allocated hash algorithm: sha256
> [    2.796260][    T1] Secure boot mode disabled
> [    2.796448][    T1] Trusted boot mode disabled
> [    2.796560][    T1] ima: No architecture policies found
> [    2.799580][    T1] printk: legacy console [netcon0] enabled
> [    2.799696][    T1] netconsole: network logging started
> [    2.880282][    T1] Freeing unused kernel image (initmem) memory: 6528K
> [    2.884618][    T1] Checked W+X mappings: passed, no W+X pages found
> [    2.885366][    T1] rodata_test: all tests were successful
> [    2.885749][    T1] Run /init as init process
> [    3.214730][   T58] mount (58) used greatest stack depth: 28672 bytes
> left
> ...
> nothing happens after that.
reproduced with ppc64_defconfig
[    0.818972][    T1] Run /init as init process
[    5.851684][  T240] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
[    5.851742][  T240] kworker/u33:18 (240) used greatest stack depth: 13584 bytes left
[    5.860081][  T232] kworker/u33:16 (232) used greatest stack depth: 13072 bytes left
[    5.863145][  T210] kworker/u35:13 (210) used greatest stack depth: 12928 bytes left
[    5.865000][    T1] Failed to execute /init (error -8)
[    5.868897][    T1] Run /sbin/init as init process
[   10.891673][  T315] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
[   10.894036][    T1] Starting init: /sbin/init exists but couldn't execute it (error -8)
[   10.901455][    T1] Run /etc/init as init process
[   10.903154][    T1] Run /bin/init as init process
[   10.904747][    T1] Run /bin/sh as init process
[   15.931679][  T367] request_module: modprobe binfmt-4c46 cannot be processed, kmod busy with 50 threads for more than 5 seconds now
[   15.934689][    T1] Starting init: /bin/sh exists but couldn't execute it (error -8)
[   15.940766][    T1] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
[   15.946981][    T1] CPU: 13 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1 #24
[   15.950050][    T1] Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,git-3a259d hv:linux,kvm pSeries
[   15.955633][    T1] Call Trace:
[   15.956714][    T1] [c0000000080fbd20] [c0000000011811e8] dump_stack_lvl+0x6c/0x9c (unreliable)
[   15.959302][    T1] [c0000000080fbd50] [c00000000016b654] panic+0x178/0x424
[   15.961929][    T1] [c0000000080fbdf0] [c00000000001048c] kernel_init+0x19c/0x1a0
[   15.965310][    T1] [c0000000080fbe50] [c00000000000d394] ret_from_kernel_user_thread+0x14/0x1c
[   15.968494][    T1] --- interrupt: 0 at 0x0
[   15.989760][    T1] pstore: backend (nvram) writing error (-1)
qemu-system-ppc64: OS terminated: `
[root@localhost home]#
It would take some time to debug out from the issue. Stay tuned.
Thanks very much!
> 
> 
> For PPC32 I use pmac32_defconfig and QEMU machine mac99
> 
> Christophe
> 


