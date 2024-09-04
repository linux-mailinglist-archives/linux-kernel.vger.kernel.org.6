Return-Path: <linux-kernel+bounces-314156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CA96AF75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD8B1F25C01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406A42047;
	Wed,  4 Sep 2024 03:33:08 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991901EB21
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420787; cv=none; b=MRU+M49yWVyte4sH/QT730xJUHnhUF6wCZMFsWvpwDpM6DhSLehCqWdiO6TF+MEOcjuWyPsKBExNVUifCiUfkvFulBRGhkm0llEvgj8BF3HiHtTzkGZmK3TvTKhl0TCbj/HJZIP46oHvEGLfspA/iaaRgDVcre05oYahMpyjwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420787; c=relaxed/simple;
	bh=BrXi8U7NlSh2i+QmHJdYL5m7UR+3g4i/PouEe6qHgqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dKAtN9gr/YBESDDrg/HDkjbWSCihCWsvbd2q/I3sVXVrNLuRqiEZ8FZRrycZ1E+JIQzOjJSJN2YNwrVjnBIQWpxH+CzdlabFwLu+lrLZsf8tMGd2UVly8xEl93EQFHvti/psB+n3oZu13q//Z73rA2nd3oE+CkMI0TCeFbVB9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wz7Md6fzWz1P7yH;
	Wed,  4 Sep 2024 11:31:57 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E4E141400FD;
	Wed,  4 Sep 2024 11:32:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 11:32:54 +0800
Message-ID: <6295c921-7bfe-37d3-dcf6-28676a5b5e9e@huawei.com>
Date: Wed, 4 Sep 2024 11:32:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <87y1487bh2.ffs@tglx> <87msko739v.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87msko739v.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/4 6:58, Thomas Gleixner wrote:
> Module insertion invokes static_call_add_module() to initialize the static
> calls in a module. static_call_add_module() invokes __static_call_init(),
> which allocates a struct static_call_mod to either encapsulate the built-in
> static call sites of the associated key into it so further modules can be
> added or to append the module to the module chain.
> 
> If that allocation fails the function returns with an error code and the
> module core invokes static_call_del_module() to clean up eventually added
> static_call_mod entries.
> 
> This works correctly, when all keys used by the module were converted over
> to a module chain before the failure. If not then static_call_del_module()
> causes a #GP as it blindly assumes that key::mods points to a valid struct
> static_call_mod.
> 
> The problem is that key::mods is not a individual struct member of struct
> static_call_key, it's part of a union to save space:
> 
>         union {
>                 /* bit 0: 0 = mods, 1 = sites */
>                 unsigned long type;
>                 struct static_call_mod *mods;
>                 struct static_call_site *sites;
> 	};
> 
> key::sites is a pointer to the list of built-in usage sites of the static
> call. The type of the pointer is differentiated by bit 0. A mods pointer
> has the bit clear, the sites pointer has the bit set.
> 
> As static_call_del_module() blindly assumes that the pointer is a valid
> static_call_mod type, it fails to check for this failure case and
> dereferences the pointer to the list of built-in call sites, which is
> obviously bogus.
> 
> Cure it by checking whether the key has a sites or a mods pointer. 
> 
> If it is a sites pointer then the key is not to be touched. As the sites
> are walked in the same order as in __static_call_init() the site walk
> can be terminated because all subsequent sites have not been touched by
> the init code due to the error exit.
> 
> If it was converted before the allocation fail, then the inner loop which
> searches for a module match will find nothing.
> 
> A fail in the second allocation in __static_call_init() is harmless and
> does not require special treatment. The first allocation succeeded and
> converted the key to a module chain. That first entry has mod::mod == NULL
> and mod::next == NULL, so the inner loop of static_call_del_module() will
> neither find a module match nor a module chain. The next site in the walk
> was either already converted, but can't match the module, or it will exit
> the outer loop because it has a static_call_site pointer and not a
> static_call_mod pointer.
> 
> Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
> Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com
> ---
>  kernel/static_call_inline.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- a/kernel/static_call_inline.c
> +++ b/kernel/static_call_inline.c
> @@ -411,6 +411,17 @@ static void static_call_del_module(struc
>  
>  	for (site = start; site < stop; site++) {
>  		key = static_call_key(site);
> +
> +		/*
> +		 * If the key was not updated due to a memory allocation
> +		 * failure in __static_call_init() then treating key::sites
> +		 * as key::mods in the code below would cause random memory
> +		 * access and #GP. In that case all subsequent sites have
> +		 * not been touched either, so stop iterating.
> +		 */
> +		if (static_call_key_sites(key))
> +			break;
> +

Hi, Thomas,

This patch seems not solve the issue, with this patch, the below problem
also occurs when inject fault when modprobe amdgpu:

[  700.274277] name failslab, interval 1, probability 0, space 0, times 0
[  700.275147] CPU: 6 UID: 0 PID: 9846 Comm: modprobe Tainted: G
W          6.11.0-rc6+ #48
[  700.275662] Tainted: [W]=WARN
[  700.275856] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[  700.276332] Call Trace:
[  700.276479]  <TASK>
[  700.276614]  dump_stack_lvl+0xba/0xe0
[  700.276846]  should_fail_ex+0x4b1/0x5b0
[  700.277083]  should_failslab+0xc2/0x120
[  700.277315]  __kmalloc_cache_noprof+0x6b/0x350
[  700.277590]  ? __static_call_init.part.0+0x158/0x5d0
[  700.277893]  __static_call_init.part.0+0x158/0x5d0
[  700.278185]  ? amdgpu_gmc_fw_reg_write_reg_wait+0x3ad/0x430 [amdgpu]
[  700.279871]  static_call_module_notify+0x9b/0x3d0
[  700.280158]  notifier_call_chain+0xad/0x2f0
[  700.280407]  blocking_notifier_call_chain_robust+0xc8/0x150
[  700.280739]  ? __pfx_blocking_notifier_call_chain_robust+0x10/0x10
[  700.281104]  load_module+0x5026/0x63e0
[  700.281323]  ? generic_file_read_iter+0x269/0x3a0
[  700.281629]  ? __pfx_load_module+0x10/0x10
[  700.281896]  ? selinux_file_permission+0x118/0x4b0
[  700.282176]  ? security_kernel_post_read_file+0x8d/0xc0
[  700.282484]  ? kernel_read_file+0x3e7/0x660
[  700.282743]  ? __pfx_kernel_read_file+0x10/0x10
[  700.283009]  ? __pfx___lock_acquire+0x10/0x10
[  700.283272]  ? lock_acquire+0x19d/0x530
[  700.283500]  ? init_module_from_file+0xe6/0x150
[  700.283756]  init_module_from_file+0xe6/0x150
[  700.284011]  ? __pfx_init_module_from_file+0x10/0x10
[  700.284308]  idempotent_init_module+0x37c/0x690
[  700.284569]  ? __pfx_idempotent_init_module+0x10/0x10
[  700.284860]  ? __startup_64+0x190/0x330
[  700.285082]  ? security_capable+0x8d/0xc0
[  700.285316]  __x64_sys_finit_module+0xcc/0x130
[  700.285569]  do_syscall_64+0xc1/0x1d0
[  700.285783]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  700.286070] RIP: 0033:0x7efe8bfb6839
[  700.286274] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  700.287266] RSP: 002b:00007ffca29f00b8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[  700.287675] RAX: ffffffffffffffda RBX: 0000561a219bbca0 RCX:
00007efe8bfb6839
[  700.288064] RDX: 0000000000000000 RSI: 0000561a1dc1bc2e RDI:
0000000000000003
[  700.288447] RBP: 0000561a1dc1bc2e R08: 0000000000000000 R09:
0000561a219bbca0
[  700.288833] R10: 0000000000000003 R11: 0000000000000246 R12:
0000000000000000
[  700.289219] R13: 0000561a219bbe90 R14: 0000000000040000 R15:
0000561a219bbca0
[  700.289613]  </TASK>
[  700.289766] ------------[ cut here ]------------
[  700.290023] Failed to allocate memory for static calls
[  700.290048] WARNING: CPU: 6 PID: 9846 at
kernel/static_call_inline.c:456 static_call_module_notify+0x2d5/0x3d0
[  700.290899] Modules linked in: amdgpu(+) amdxcp drm_ttm_helper
drm_suballoc_helper [last unloaded: amdgpu]
[  700.291431] CPU: 6 UID: 0 PID: 9846 Comm: modprobe Tainted: G
W          6.11.0-rc6+ #48
[  700.291929] Tainted: [W]=WARN
[  700.292106] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[  700.292558] RIP: 0010:static_call_module_notify+0x2d5/0x3d0
[  700.292888] Code: 07 48 c7 c7 c0 94 ac 9d 41 bc 17 80 00 00 49 8d 34
07 e8 4e 2d d5 ff e8 d9 56 f1 ff 90 48 c7 c7 20 95 ac 9d e8 cc 3f bd ff
90 <0f> 0b 90 90 48 8b 7c 24 08 e8 6d ef ff ff 48 c7 c7 40 e6 a9 9e e8
[  700.293906] RSP: 0018:ff11000105437868 EFLAGS: 00010282
[  700.294207] RAX: 0000000000000000 RBX: 00000000fffffff4 RCX:
ffffffff9a16a61d
[  700.294595] RDX: ff1100010dad8000 RSI: 0000000000000004 RDI:
ff1100011ad28a08
[  700.295003] RBP: 00000000dcc77697 R08: 0000000000000001 R09:
ffe21c00235a5141
[  700.295388] R10: ff1100011ad28a0b R11: 0000000000000000 R12:
000000000000800d
[  700.295793] R13: dffffc0000000000 R14: ffffffff9e5f1808 R15:
ffffffffc1c9e325
[  700.296183] FS:  00007efe8c4a5540(0000) GS:ff1100011ad00000(0000)
knlGS:0000000000000000
[  700.296630] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  700.296966] CR2: 000055ec0729e838 CR3: 0000000114d16003 CR4:
0000000000771ef0
[  700.297366] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  700.297771] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  700.298162] PKRU: 55555554
[  700.298314] Call Trace:
[  700.298461]  <TASK>
[  700.298589]  ? show_regs+0x73/0x80
[  700.298816]  ? __warn+0xe5/0x330
[  700.299010]  ? static_call_module_notify+0x2d5/0x3d0
[  700.299290]  ? report_bug+0x2a3/0x380
[  700.299501]  ? static_call_module_notify+0x2d5/0x3d0
[  700.299794]  ? handle_bug+0x5e/0xc0
[  700.299999]  ? exc_invalid_op+0x25/0x60
[  700.300222]  ? asm_exc_invalid_op+0x1a/0x20
[  700.300466]  ? __warn_printk+0x15d/0x200
[  700.300707]  ? static_call_module_notify+0x2d5/0x3d0
[  700.300991]  ? static_call_module_notify+0x2d4/0x3d0
[  700.301270]  notifier_call_chain+0xad/0x2f0
[  700.301521]  blocking_notifier_call_chain_robust+0xc8/0x150
[  700.301848]  ? __pfx_blocking_notifier_call_chain_robust+0x10/0x10
[  700.302219]  load_module+0x5026/0x63e0
[  700.302437]  ? generic_file_read_iter+0x269/0x3a0
[  700.302747]  ? __pfx_load_module+0x10/0x10
[  700.302989]  ? selinux_file_permission+0x118/0x4b0
[  700.303268]  ? security_kernel_post_read_file+0x8d/0xc0
[  700.303559]  ? kernel_read_file+0x3e7/0x660
[  700.303812]  ? __pfx_kernel_read_file+0x10/0x10
[  700.304066]  ? __pfx___lock_acquire+0x10/0x10
[  700.304316]  ? lock_acquire+0x19d/0x530
[  700.304543]  ? init_module_from_file+0xe6/0x150
[  700.304823]  init_module_from_file+0xe6/0x150
[  700.305077]  ? __pfx_init_module_from_file+0x10/0x10
[  700.305370]  idempotent_init_module+0x37c/0x690
[  700.305631]  ? __pfx_idempotent_init_module+0x10/0x10
[  700.305936]  ? __startup_64+0x190/0x330
[  700.306163]  ? security_capable+0x8d/0xc0
[  700.306395]  __x64_sys_finit_module+0xcc/0x130
[  700.306654]  do_syscall_64+0xc1/0x1d0
[  700.306891]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  700.307180] RIP: 0033:0x7efe8bfb6839
[  700.307387] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  700.308395] RSP: 002b:00007ffca29f00b8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[  700.308828] RAX: ffffffffffffffda RBX: 0000561a219bbca0 RCX:
00007efe8bfb6839
[  700.309221] RDX: 0000000000000000 RSI: 0000561a1dc1bc2e RDI:
0000000000000003
[  700.309619] RBP: 0000561a1dc1bc2e R08: 0000000000000000 R09:
0000561a219bbca0
[  700.310034] R10: 0000000000000003 R11: 0000000000000246 R12:
0000000000000000
[  700.310434] R13: 0000561a219bbe90 R14: 0000000000040000 R15:
0000561a219bbca0
[  700.310867]  </TASK>
[  700.311002] irq event stamp: 65841
[  700.311200] hardirqs last  enabled at (65851): [<ffffffff9a2ef5b1>]
console_unlock+0x1b1/0x1c0
[  700.311678] hardirqs last disabled at (65860): [<ffffffff9a2ef596>]
console_unlock+0x196/0x1c0
[  700.312175] softirqs last  enabled at (65826): [<ffffffff9a184c32>]
handle_softirqs+0x512/0x770
[  700.312658] softirqs last disabled at (65805): [<ffffffff9a185824>]
irq_exit_rcu+0x94/0xc0
[  700.313130] ---[ end trace 0000000000000000 ]---
[  700.313418] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  700.314079] KASAN: null-ptr-deref in range
[0x0000000000000008-0x000000000000000f]
[  700.314505] CPU: 6 UID: 0 PID: 9846 Comm: modprobe Tainted: G
W          6.11.0-rc6+ #48
[  700.314994] Tainted: [W]=WARN
[  700.315169] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[  700.315627] RIP: 0010:static_call_del_module+0x145/0x210
[  700.315935] Code: 66 f1 ff 48 85 db 75 12 eb 5c e8 26 66 f1 ff 4d 85
e4 74 52 49 89 de 4c 89 e3 e8 16 66 f1 ff 48 8d 7b 08 48 89 f8 48 c1 e8
03 <80> 3c 28 00 75 6e 48 89 d8 48 8b 53 08 48 c1 e8 03 80 3c 28 00 75
[  700.317483] RSP: 0018:ff11000105437818 EFLAGS: 00010202
[  700.317928] RAX: 0000000000000001 RBX: 0000000000000001 RCX:
ffffffff9a5955aa
[  700.318377] RDX: ff1100010dad8000 RSI: 0000000000000004 RDI:
0000000000000009
[  700.318845] RBP: dffffc0000000000 R08: 0000000000000001 R09:
ffe21c00235a5141
[  700.319363] R10: ff1100011ad28a0b R11: 0000000000000000 R12:
ffffffffc1ad3cc0
[  700.319810] R13: ffffffffc1c9e1d1 R14: ffffffffc1ad3cc8 R15:
ffffffffc1c9e340
[  700.320279] FS:  00007efe8c4a5540(0000) GS:ff1100011ad00000(0000)
knlGS:0000000000000000
[  700.320800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  700.321189] CR2: 000055ec0729e838 CR3: 0000000114d16003 CR4:
0000000000771ef0
[  700.321638] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  700.322097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  700.322918] PKRU: 55555554
[  700.323389] Call Trace:
[  700.323796]  <TASK>
[  700.324168]  ? show_regs+0x73/0x80
[  700.324780]  ? die_addr+0x46/0xc0
[  700.325358]  ? exc_general_protection+0x161/0x2a0
[  700.326130]  ? asm_exc_general_protection+0x26/0x30
[  700.326888]  ? static_call_del_module+0x13a/0x210
[  700.327584]  ? static_call_del_module+0x145/0x210
[  700.328237]  ? static_call_del_module+0x13a/0x210
[  700.328910]  static_call_module_notify+0x2e3/0x3d0
[  700.329590]  notifier_call_chain+0xad/0x2f0
[  700.330179]  blocking_notifier_call_chain_robust+0xc8/0x150
[  700.330776]  ? __pfx_blocking_notifier_call_chain_robust+0x10/0x10
[  700.331443]  load_module+0x5026/0x63e0
[  700.331871]  ? generic_file_read_iter+0x269/0x3a0
[  700.332516]  ? __pfx_load_module+0x10/0x10
[  700.333060]  ? selinux_file_permission+0x118/0x4b0
[  700.333723]  ? security_kernel_post_read_file+0x8d/0xc0
[  700.334470]  ? kernel_read_file+0x3e7/0x660
[  700.335041]  ? __pfx_kernel_read_file+0x10/0x10
[  700.335442]  ? __pfx___lock_acquire+0x10/0x10
[  700.335992]  ? lock_acquire+0x19d/0x530
[  700.336959]  ? init_module_from_file+0xe6/0x150
[  700.338077]  init_module_from_file+0xe6/0x150
[  700.339172]  ? __pfx_init_module_from_file+0x10/0x10
[  700.340397]  idempotent_init_module+0x37c/0x690
[  700.341521]  ? __pfx_idempotent_init_module+0x10/0x10
[  700.342735]  ? __startup_64+0x190/0x330
[  700.343524]  ? security_capable+0x8d/0xc0
[  700.344082]  __x64_sys_finit_module+0xcc/0x130
[  700.345035]  do_syscall_64+0xc1/0x1d0
[  700.345813]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  700.346864] RIP: 0033:0x7efe8bfb6839
[  700.347581] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  700.351338] RSP: 002b:00007ffca29f00b8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[  700.352525] RAX: ffffffffffffffda RBX: 0000561a219bbca0 RCX:
00007efe8bfb6839
[  700.353354] RDX: 0000000000000000 RSI: 0000561a1dc1bc2e RDI:
0000000000000003
[  700.354195] RBP: 0000561a1dc1bc2e R08: 0000000000000000 R09:
0000561a219bbca0
[  700.355019] R10: 0000000000000003 R11: 0000000000000246 R12:
0000000000000000
[  700.355702] R13: 0000561a219bbe90 R14: 0000000000040000 R15:
0000561a219bbca0
[  700.356453]  </TASK>
[  700.356720] Modules linked in: amdgpu(+) amdxcp drm_ttm_helper
drm_suballoc_helper [last unloaded: amdgpu]
[  700.357844] Dumping ftrace buffer:
[  700.358243]    (ftrace buffer empty)
[  700.358721] ---[ end trace 0000000000000000 ]---
[  700.359241] RIP: 0010:static_call_del_module+0x145/0x210
[  700.359835] Code: 66 f1 ff 48 85 db 75 12 eb 5c e8 26 66 f1 ff 4d 85
e4 74 52 49 89 de 4c 89 e3 e8 16 66 f1 ff 48 8d 7b 08 48 89 f8 48 c1 e8
03 <80> 3c 28 00 75 6e 48 89 d8 48 8b 53 08 48 c1 e8 03 80 3c 28 00 75
[  700.361913] RSP: 0018:ff11000105437818 EFLAGS: 00010202
[  700.362603] RAX: 0000000000000001 RBX: 0000000000000001 RCX:
ffffffff9a5955aa
[  700.363374] RDX: ff1100010dad8000 RSI: 0000000000000004 RDI:
0000000000000009
[  700.364114] RBP: dffffc0000000000 R08: 0000000000000001 R09:
ffe21c00235a5141
[  700.365014] R10: ff1100011ad28a0b R11: 0000000000000000 R12:
ffffffffc1ad3cc0
[  700.365784] R13: ffffffffc1c9e1d1 R14: ffffffffc1ad3cc8 R15:
ffffffffc1c9e340
[  700.366458] FS:  00007efe8c4a5540(0000) GS:ff1100011ad00000(0000)
knlGS:0000000000000000
[  700.367325] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  700.368062] CR2: 000055ec0729e838 CR3: 0000000114d16003 CR4:
0000000000771ef0
[  700.368851] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  700.370439] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  700.371814] PKRU: 55555554
[  700.372292] Kernel panic - not syncing: Fatal exception
[  700.373772] Dumping ftrace buffer:
[  700.374235]    (ftrace buffer empty)
[  700.374707] Kernel Offset: 0x19000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  700.376056] Rebooting in 1 seconds..


>  		if (key == prev_key)
>  			continue;
>  

