Return-Path: <linux-kernel+bounces-183613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8B8C9B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F128251C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D85029E;
	Mon, 20 May 2024 10:33:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25453E47B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201225; cv=none; b=CDQJAWshb+0G32IaUzvM8KYpgNpknidfd0uEOu7vLCcsYOoXxR7u3mDcwL3g39IaBtGE1n7I99JfHPNaYAbz/7UA+OFAW/WrnG/+UleJtP+4CcFqgTPMZ+gY1/nbpXB+6uioLM+R76sYDholAYsQOtCLTbjrYqCtyafjGNhNG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201225; c=relaxed/simple;
	bh=PopYd5qh/dfm0K0DInyxb2G58irqB87afaXNZxISg64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNOPg0E4rh+rIhm3TUuDqxw9kkD84fvf+E9bQJDn3oXvOK4zq4rqy0x/eQpg2Oxew2S3Rs0SJ1hpk+1fByhnRVCVYPX/fXsZWTTtwA3zprWuioAPmYrSRaUTbmCf3ZzxbVafk0kfGD14zEJ3bNwciQ0+di0uvwvcnpYu5BPaK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE937339;
	Mon, 20 May 2024 03:34:05 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE65C3F766;
	Mon, 20 May 2024 03:33:39 -0700 (PDT)
Date: Mon, 20 May 2024 11:33:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com,
	xieyuanbin1@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, nixiaoming@huawei.com,
	wangbing6@huawei.com, douzhaolei@huawei.com, liaohua4@huawei.com,
	lijiahuan5@huawei.com, wangfangpeng1@huawei.com
Subject: Re: [PATCH] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
Message-ID: <ZksnARrLkKHcX4C_@J2N7QTR9R3>
References: <1715955208-17109-1-git-send-email-xiaojiangfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715955208-17109-1-git-send-email-xiaojiangfeng@huawei.com>

On Fri, May 17, 2024 at 10:13:28PM +0800, Jiangfeng Xiao wrote:
> I'm using the latest linux kernel mainline code,
> with the default arm64 configuration:
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig,
> and set CONFIG_EXPERT=y, CONFIG_DEBUG_BUGVERBOSE=n,
> CONFIG_PANIC_ON_OOPS=y.
> 
> Loading the following kernel module will cause kernel panic.
> 
> The call stack is as follows:
> 
> root@(none):/# /root/insmod hello.ko
> [    6.035003] hello: loading out-of-tree module taints kernel.
> [    6.039129] ------------[ cut here ]------------
> [    6.039287] hello
> [    6.039704] Unexpected kernel BRK exception at EL1
> [    6.040059] Internal error: BRK handler: 00000000f2000800 [#1] PREEMPT SMP
> [    6.040457] Modules linked in: hello(O+)
> [    6.041311] CPU: 0 PID: 50 Comm: insmod Tainted: G           O       6.9.1 #8
> [    6.041755] Hardware name: linux,dummy-virt (DT)
> [    6.042238] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    6.042594] pc : buginit+0x18/0x1000 [hello]
> [    6.043601] lr : buginit+0x18/0x1000 [hello]
> [    6.043852] sp : ffff800080533ae0
> [    6.044121] x29: ffff800080533ae0 x28: 0000000000000000 x27: 0000000000000000
> [    6.044523] x26: ffffaba8c4e70510 x25: ffff800080533c30 x24: ffffaba8c4a28a58
> [    6.044961] x23: 0000000000000000 x22: 0000000000000000 x21: ffff3947c0eab3c0
> [    6.045503] x20: ffffaba8c4e3f000 x19: ffffaba846464000 x18: 0000000000000006
> [    6.046124] x17: 0000000000000000 x16: ffffaba8c2492834 x15: 0720072007200720
> [    6.046387] x14: 0720072007200720 x13: ffffaba8c49b27c8 x12: 0000000000000312
> [    6.046829] x11: 0000000000000106 x10: ffffaba8c4a0a7c8 x9 : ffffaba8c49b27c8
> [    6.047293] x8 : 00000000ffffefff x7 : ffffaba8c4a0a7c8 x6 : 80000000fffff000
> [    6.047739] x5 : 0000000000000107 x4 : 0000000000000000 x3 : 0000000000000000
> [    6.047955] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff3947c0eab3c0
> [    6.048366] Call trace:
> [    6.048653]  buginit+0x18/0x1000 [hello]
> [    6.048922]  do_one_initcall+0x80/0x1c8
> [    6.049333]  do_init_module+0x60/0x218
> [    6.049475]  load_module+0x1ba4/0x1d70
> [    6.049755]  __do_sys_init_module+0x198/0x1d0
> [    6.049959]  __arm64_sys_init_module+0x1c/0x28
> [    6.050160]  invoke_syscall+0x48/0x114
> [    6.050334]  el0_svc_common.constprop.0+0x40/0xe0
> [    6.050468]  do_el0_svc+0x1c/0x28
> [    6.050635]  el0_svc+0x34/0xd8
> [    6.050852]  el0t_64_sync_handler+0x120/0x12c
> [    6.051088]  el0t_64_sync+0x190/0x194
> [    6.051433] Code: d0ffffe0 910003fd 91000000 9400000b (d4210000)
> [    6.052212] ---[ end trace 0000000000000000 ]---
> [    6.052473] Kernel panic - not syncing: BRK handler: Fatal exception
> 
> The kernel module source code is as follows:
> ```
> 
> static int __init buginit(void)
> {
> 	WARN(1, "hello\n");
> 	return 0;
> }
> 
> static void __exit bugexit(void)
> {
> }
> 
> module_init(buginit);
> module_exit(bugexit);
> MODULE_LICENSE("GPL");
> ```
> 
> When CONFIG_DEBUG_BUGVERBOSE macro is disabled,
> the size of "__bug_table" section in hello.ko
> is only 6 bytes instead of the expected 8 bytes.
> As a result,
> mod->num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry) = 6 / 8 = 0
> calculated in module_bug_finalize when the kernel loads ko is incorrect.
> 
> When running `WARN()`, the following backtrace is triggered:
> 
> module_find_bug() at lib/bug.c
> find_bug() at lib/bug.c
> __report_bug() at lib/bug.c
> report_bug() at lib/bug.c
> call_break_hook() at arch/arm64/kernel/debug-monitors.c
> brk_handler() at arch/arm64/kernel/debug-monitors.c
> 
> It will return -EFAULT because hello.ko's mod->num_bugs is 0.
> Finally, the kernel OOPS is triggered.
> 
> Add .align 2 to the end of __BUG_ENTRY
> to make the object layout generated by the assembly code
> consistent with that of the C struct bug_entry.
> 
> Fixes: 9fb7410f955f ("arm64/BUG: Use BRK instruction for generic BUG traps")
> 
> Signed-off-by: Yuanbin Xie <xieyuanbin1@huawei.com>
> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
> ---
>  arch/arm64/include/asm/asm-bug.h | 1 +
>  1 file changed, 1 insertion(+)

Ouch; sorry about this.

I reckon we should spell out the reason for this a bit more; would you
be happy with the commit message below?

| When CONFIG_DEBUG_BUGVERBOSE=n, we fail to add necessary padding bytes
| to bug_table entries, and as a result the last entry in a bug table will
| be ignored, potentially leading to an unexpected panic(). All prior
| entries in the table will be handled correctly.
| 
| The arm64 ABI requires that struct fields of up to 8 bytes are
| naturally-aligned, with padding added within a struct such that struct
| are suitably aligned within arrays.
| 
| When CONFIG_DEBUG_BUGVERPOSE=y, the layout of a bug_entry is:
| 
| 	struct bug_entry {
| 		signed int      bug_addr_disp;	// 4 bytes
| 		signed int      file_disp;	// 4 bytes
| 		unsigned short  line;		// 2 bytes
| 		unsigned short  flags;		// 2 bytes
| 	}
| 
| ... with 12 bytes total, requiring 4-byte alignment.
| 
| When CONFIG_DEBUG_BUGVERBOSE=n, the layout of a bug_entry is:
| 
| 	struct bug_entry {
| 		signed int      bug_addr_disp;	// 4 bytes
| 		unsigned short  flags;		// 2 bytes
| 		< implicit padding >		// 2 bytes
| 	}
| 
| ... with 8 bytes total, with 6 bytes of data and 2 bytes of trailing
| padding, requiring 4-byte alginment.
| 
| When we create a bug_entry in assembly, we align the start of the entry
| to 4 bytes, which implicitly handles padding for any prior entries.
| However, we do not align the end of the entry, and so when
| CONFIG_DEBUG_BUGVERBOSE=n, the final entry lacks the trailing padding
| bytes.
| 
| For the main kernel image this is not a problem as find_bug() doesn't
| depend on the trailing padding bytes when searching for entries:
| 
| 	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
| 		if (bugaddr == bug_addr(bug))
| 			return bug;
| 
| However for modules, module_bug_finalize() depends on the trailing
| bytes when calculating the number of entries:
| 
| 	mod->num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
| 
| ... and as the last bug_entry lacks the necessary padding bytes, this entry
| will not be counted, e.g. in the case of a single entry:
| 	
| 	sechdrs[i].sh_size == 6
| 	sizeof(struct bug_entry) == 8;
| 
| 	sechdrs[i].sh_size / sizeof(struct bug_entry) == 0;
| 
| Consequently module_find_bug() will miss the last bug_entry when it does:
| 
| 	for (i = 0; i < mod->num_bugs; ++i, ++bug)
| 		if (bugaddr == bug_addr(bug))
| 			goto out;	
| 
| ... which can lead to a kenrel panic due to an unhandled bug.
| 
| This can be demonstrated with the following module:
| 
| 	static int __init buginit(void)
| 	{
| 		WARN(1, "hello\n");
| 		return 0;
| 	}
| 
| 	static void __exit bugexit(void)
| 	{
| 	}
| 
| 	module_init(buginit);
| 	module_exit(bugexit);
| 	MODULE_LICENSE("GPL");
| 
| ... which will trigger a kernel panic when loaded:
| 
| 	------------[ cut here ]------------
| 	hello
| 	Unexpected kernel BRK exception at EL1
| 	Internal error: BRK handler: 00000000f2000800 [#1] PREEMPT SMP
| 	Modules linked in: hello(O+)
| 	CPU: 0 PID: 50 Comm: insmod Tainted: G           O       6.9.1 #8
| 	Hardware name: linux,dummy-virt (DT)
| 	pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| 	pc : buginit+0x18/0x1000 [hello]
| 	lr : buginit+0x18/0x1000 [hello]
| 	sp : ffff800080533ae0
| 	x29: ffff800080533ae0 x28: 0000000000000000 x27: 0000000000000000
| 	x26: ffffaba8c4e70510 x25: ffff800080533c30 x24: ffffaba8c4a28a58
| 	x23: 0000000000000000 x22: 0000000000000000 x21: ffff3947c0eab3c0
| 	x20: ffffaba8c4e3f000 x19: ffffaba846464000 x18: 0000000000000006
| 	x17: 0000000000000000 x16: ffffaba8c2492834 x15: 0720072007200720
| 	x14: 0720072007200720 x13: ffffaba8c49b27c8 x12: 0000000000000312
| 	x11: 0000000000000106 x10: ffffaba8c4a0a7c8 x9 : ffffaba8c49b27c8
| 	x8 : 00000000ffffefff x7 : ffffaba8c4a0a7c8 x6 : 80000000fffff000
| 	x5 : 0000000000000107 x4 : 0000000000000000 x3 : 0000000000000000
| 	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff3947c0eab3c0
| 	Call trace:
| 	 buginit+0x18/0x1000 [hello]
| 	 do_one_initcall+0x80/0x1c8
| 	 do_init_module+0x60/0x218
| 	 load_module+0x1ba4/0x1d70
| 	 __do_sys_init_module+0x198/0x1d0
| 	 __arm64_sys_init_module+0x1c/0x28
| 	 invoke_syscall+0x48/0x114
| 	 el0_svc_common.constprop.0+0x40/0xe0
| 	 do_el0_svc+0x1c/0x28
| 	 el0_svc+0x34/0xd8
| 	 el0t_64_sync_handler+0x120/0x12c
| 	 el0t_64_sync+0x190/0x194
| 	Code: d0ffffe0 910003fd 91000000 9400000b (d4210000)
| 	---[ end trace 0000000000000000 ]---
| 	Kernel panic - not syncing: BRK handler: Fatal exception
| 
| Fix this by always aligning the end of a bug_entry to 4 bytes, which is
| correct regardless of CONFIG_DEBUG_BUGVERBOSE.
| 
| Fixes: 9fb7410f955f ("arm64/BUG: Use BRK instruction for generic BUG traps")
| Signed-off-by: Yuanbin Xie <xieyuanbin1@huawei.com>
| Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>
>
> 
> diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
> index c762038..6e73809 100644
> --- a/arch/arm64/include/asm/asm-bug.h
> +++ b/arch/arm64/include/asm/asm-bug.h
> @@ -28,6 +28,7 @@
>  	14470:	.long 14471f - .;			\
>  _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
>  		.short flags; 				\
> +		.align 2;				\
>  		.popsection;				\
>  	14471:
>  #else
> -- 
> 1.8.5.6
> 
> 

