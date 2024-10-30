Return-Path: <linux-kernel+bounces-388366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF49B5E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD280284074
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBEF1E2007;
	Wed, 30 Oct 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xiKVh8fA"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B51E1A36
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279507; cv=none; b=bxrRRG0h1Kmvxnav2ZoDP0Cpg3hQwsRh1JTZ3I5Moitd3rlxK0nhpTss+fIAhz7vnREvjzUwLXtRwxhiMItenPQ74J//PmrZN/+h6l80ULUSGM/E+NbAJw1Cql/SaXtBYFVtjm+/tyXOkirN86t2uISVDhBvjb2g66U/HTgxWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279507; c=relaxed/simple;
	bh=2xY069ofHmy4rNARHKYc+PQAGt8OAzWJhiOIbfatK6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6QKmqF1ZBU0R3twJwzV/3ZFhSZnDjk6H2bQ2kzAguyHSPyLzd18YIeXP5RrH8LeJBRD/Dhi7i4f+3CON6n3jd4YhfGgOEkcp7UoOtP1BmN4+nFBhi4wfcgYyQW3AFjmjOknOQMfR7Kr7I29PfstOXZ5Ej3nraZ9auXDr7r0WvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xiKVh8fA; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730279494; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B1Nj0TklQpMbeBFOiToWO0uWUZIy7wiCw7UL6E3FWT4=;
	b=xiKVh8fAuLlQoOJUIqs24xkE+EVMnxMsLsU+D1cw4WdnannAs90VsOdWEkoQ5lzPBbDLMmnQJrluEgBbNnM5EIgMevzQEDfquPZQrxLI/o/w9OS+JECuTjx+GhImgm2zNfep5gmYX76kShF+3QoXA20akFXsWfNavBeNEkt9T9A=
Received: from 30.166.35.5(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WIDTc5c_1730279491 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 17:11:32 +0800
Message-ID: <5be3b8a9-dbd9-4640-94ba-78f2c19fa264@linux.alibaba.com>
Date: Wed, 30 Oct 2024 17:11:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/eevdf: Force propagating min_slice of cfs_rq when a
 task changing slice
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 aubrey.li@linux.intel.com, yu.c.chen@intel.com,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>
References: <202410301535.14e0855c-lkp@intel.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <202410301535.14e0855c-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/30 16:18, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_enqueue_task_fair" on:
> 
> commit: e9b718a38463470cc388aaa3ff50f12bbe8c4279 ("[PATCH] sched/eevdf: Force propagating min_slice of cfs_rq when a task changing slice")
> url: https://github.com/intel-lab-lkp/linux/commits/Tianchen-Ding/sched-eevdf-Force-propagating-min_slice-of-cfs_rq-when-a-task-changing-slice/20241028-143410
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git d1fb8a78b2ff1fe4e9478c75b4fbec588a73c1b0
> patch link: https://lore.kernel.org/all/20241028063313.8039-2-dtcccc@linux.alibaba.com/
> patch subject: [PATCH] sched/eevdf: Force propagating min_slice of cfs_rq when a task changing slice
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20240923
> with following parameters:
> 
> 	runtime: 600s
> 
> 
> 
> config: x86_64-randconfig-014-20241028
> compiler: clang-19
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +------------------------------------------------------------------------------+------------+------------+
> |                                                                              | d1fb8a78b2 | e9b718a384 |
> +------------------------------------------------------------------------------+------------+------------+
> | BUG:KASAN:slab-use-after-free_in_enqueue_task_fair                           | 0          | 4          |
> | BUG:KASAN:slab-use-after-free_in_dequeue_entities                            | 0          | 1          |
> +------------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410301535.14e0855c-lkp@intel.com
> 
> 
> [ 117.822447][ T468] BUG: KASAN: slab-use-after-free in enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020)
> [  117.825270][  T468] Read of size 8 at addr ffff8881678c1c30 by task trinity-main/468
> [  117.826451][  T468]
> [  117.826941][  T468] CPU: 0 UID: 65534 PID: 468 Comm: trinity-main Not tainted 6.12.0-rc4-00025-ge9b718a38463 #1
> [  117.828330][  T468] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  117.829779][  T468] Call Trace:
> [  117.830339][  T468]  <TASK>
> [ 117.830865][ T468] dump_stack_lvl (lib/dump_stack.c:122)
> [ 117.831554][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020)
> [ 117.832327][ T468] print_report (mm/kasan/report.c:378)
> [ 117.833021][ T468] ? __virt_addr_valid (include/linux/rcupdate.h:337 include/linux/rcupdate.h:941 include/linux/mmzone.h:2043 arch/x86/mm/physaddr.c:65)
> [ 117.833768][ T468] ? __virt_addr_valid (arch/x86/include/asm/preempt.h:103 include/linux/rcupdate.h:964 include/linux/mmzone.h:2053 arch/x86/mm/physaddr.c:65)
> [ 117.834510][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020)
> [ 117.835304][ T468] ? kasan_complete_mode_report_info (mm/kasan/report_generic.c:179)
> [ 117.836192][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020)
> [ 117.836990][ T468] kasan_report (mm/kasan/report.c:603)
> [ 117.837670][ T468] ? enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020)
> [ 117.838449][ T468] __asan_report_load8_noabort (mm/kasan/report_generic.c:381)
> [ 117.839276][ T468] enqueue_task_fair (kernel/sched/fair.c:831 kernel/sched/fair.c:846 kernel/sched/fair.c:7020)
> [ 117.840026][ T468] enqueue_task (kernel/sched/core.c:2027)
> [ 117.840701][ T468] activate_task (kernel/sched/core.c:2069)
> [ 117.841383][ T468] wake_up_new_task (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/sched.h:185 kernel/sched/core.c:4829)
> [ 117.842104][ T468] kernel_clone (kernel/fork.c:2818)
> [ 117.842786][ T468] __x64_sys_clone (kernel/fork.c:2927)
> [ 117.843490][ T468] x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-014-20241028/./arch/x86/include/generated/asm/syscalls_64.h:161)
> [ 117.844198][ T468] do_syscall_64 (arch/x86/entry/common.c:?)
> [ 117.844861][ T468] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467)
> [ 117.845742][ T468] ? syscall_exit_to_user_mode (kernel/entry/common.c:221)
> [ 117.846571][ T468] ? do_syscall_64 (arch/x86/entry/common.c:102)
> [ 117.848374][ T468] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234)
> [ 117.849183][ T468] ? irqentry_exit (kernel/entry/common.c:367)
> [ 117.849897][ T468] ? exc_page_fault (arch/x86/mm/fault.c:1543)
> [ 117.850589][ T468] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  117.851487][  T468] RIP: 0033:0x7f97dcccc293
> [ 117.852155][ T468] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
> All code
> ========
>     0:	00 00                	add    %al,(%rax)
>     2:	00 00                	add    %al,(%rax)
>     4:	00 66 90             	add    %ah,-0x70(%rsi)
>     7:	64 48 8b 04 25 10 00 	mov    %fs:0x10,%rax
>     e:	00 00
>    10:	45 31 c0             	xor    %r8d,%r8d
>    13:	31 d2                	xor    %edx,%edx
>    15:	31 f6                	xor    %esi,%esi
>    17:	bf 11 00 20 01       	mov    $0x1200011,%edi
>    1c:	4c 8d 90 d0 02 00 00 	lea    0x2d0(%rax),%r10
>    23:	b8 38 00 00 00       	mov    $0x38,%eax
>    28:	0f 05                	syscall
>    2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>    30:	77 35                	ja     0x67
>    32:	89 c2                	mov    %eax,%edx
>    34:	85 c0                	test   %eax,%eax
>    36:	75 2c                	jne    0x64
>    38:	64                   	fs
>    39:	48                   	rex.W
>    3a:	8b                   	.byte 0x8b
>    3b:	04 25                	add    $0x25,%al
>    3d:	10 00                	adc    %al,(%rax)
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>     6:	77 35                	ja     0x3d
>     8:	89 c2                	mov    %eax,%edx
>     a:	85 c0                	test   %eax,%eax
>     c:	75 2c                	jne    0x3a
>     e:	64                   	fs
>     f:	48                   	rex.W
>    10:	8b                   	.byte 0x8b
>    11:	04 25                	add    $0x25,%al
>    13:	10 00                	adc    %al,(%rax)
> 	...
> [  117.854567][  T468] RSP: 002b:00007fff02a6b648 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [  117.855822][  T468] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f97dcccc293
> [  117.856993][  T468] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [  117.858049][  T468] RBP: 0000000000000000 R08: 0000000000000000 R09: 7fffffffffffffff
> [  117.859328][  T468] R10: 00007f97dcbf5a10 R11: 0000000000000246 R12: 0000000000000001
> [  117.860342][  T468] R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
> [  117.861176][  T468]  </TASK>
> [  117.861691][  T468]
> [  117.862096][  T468] Allocated by task 902:
> [ 117.862719][ T468] kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68)
> [ 117.863560][ T468] kasan_save_alloc_info (mm/kasan/generic.c:566)
> [ 117.864398][ T468] __kasan_kmalloc (mm/kasan/common.c:398)
> [ 117.865193][ T468] __kmalloc_cache_node_noprof (mm/slub.c:4308)
> [ 117.866038][ T468] alloc_fair_sched_group (include/linux/slab.h:? kernel/sched/fair.c:13312)
> [ 117.866871][ T468] sched_create_group (kernel/sched/core.c:8853)
> [ 117.867588][ T468] sched_autogroup_create_attach (include/linux/err.h:67 kernel/sched/autogroup.c:93 kernel/sched/autogroup.c:194)
> [ 117.868413][ T468] ksys_setsid (kernel/sys.c:?)
> [ 117.869079][ T468] __ia32_sys_setsid (kernel/sys.c:1269)
> [ 117.869767][ T468] x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-014-20241028/./arch/x86/include/generated/asm/syscalls_64.h:161)
> [ 117.870453][ T468] do_syscall_64 (arch/x86/entry/common.c:?)
> [ 117.871156][ T468] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  117.872032][  T468]
> [  117.872468][  T468] Freed by task 243:
> [ 117.873823][ T468] kasan_save_track (mm/kasan/common.c:48 mm/kasan/common.c:68)
> [ 117.874518][ T468] kasan_save_free_info (mm/kasan/generic.c:582)
> [ 117.875278][ T468] __kasan_slab_free (mm/kasan/common.c:271)
> [ 117.875923][ T468] kfree (mm/slub.c:4579)
> [ 117.876526][ T468] free_fair_sched_group (kernel/sched/fair.c:13278)
> [ 117.877340][ T468] sched_free_group (kernel/sched/core.c:8823)
> [ 117.878034][ T468] sched_free_group_rcu (kernel/sched/core.c:8831)
> [ 117.878758][ T468] rcu_core (kernel/rcu/tree.c:?)
> [ 117.879467][ T468] rcu_core_si (kernel/rcu/tree.c:2841)
> [ 117.880104][ T468] handle_softirqs (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:555)
> [ 117.880824][ T468] __irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639)
> [ 117.881526][ T468] irq_exit_rcu (kernel/softirq.c:651)
> [ 117.882185][ T468] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049)
> [ 117.883046][ T468] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702)
> [  117.883877][  T468]
> [  117.884299][  T468] The buggy address belongs to the object at ffff8881678c1c00
> [  117.884299][  T468]  which belongs to the cache kmalloc-rnd-07-1k of size 1024
> [  117.886238][  T468] The buggy address is located 48 bytes inside of
> [  117.886238][  T468]  freed 1024-byte region [ffff8881678c1c00, ffff8881678c2000)
> [  117.888235][  T468]
> [  117.888665][  T468] The buggy address belongs to the physical page:
> [  117.889558][  T468] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1678c0
> [  117.890880][  T468] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  117.892051][  T468] memcg:ffff88814cf29cc1
> [  117.892690][  T468] flags: 0x8000000000000040(head|zone=2)
> [  117.893467][  T468] page_type: f5(slab)
> [  117.894072][  T468] raw: 8000000000000040 ffff888100059b40 ffffea000479e610 ffff88810005a828
> [  117.896842][  T468] raw: 0000000000000000 00000000000a000a 00000001f5000000 ffff88814cf29cc1
> [  117.898038][  T468] head: 8000000000000040 ffff888100059b40 ffffea000479e610 ffff88810005a828
> [  117.899301][  T468] head: 0000000000000000 00000000000a000a 00000001f5000000 ffff88814cf29cc1
> [  117.900519][  T468] head: 8000000000000003 ffffea00059e3001 ffffffffffffffff 0000000000000000
> [  117.901731][  T468] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> [  117.903000][  T468] page dumped because: kasan: bad access detected
> [  117.903859][  T468] page_owner tracks the page as allocated
> [  117.904643][  T468] page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 194, tgid 194 ((sh)), ts 46703728016, free_ts 0
> [ 117.906952][ T468] post_alloc_hook (include/linux/page_owner.h:?)
> [ 117.907672][ T468] prep_new_page (mm/page_alloc.c:1547)
> [ 117.908338][ T468] get_page_from_freelist (mm/page_alloc.c:?)
> [ 117.909140][ T468] __alloc_pages_noprof (mm/page_alloc.c:4733)
> [ 117.909885][ T468] new_slab (mm/slub.c:?)
> [ 117.910539][ T468] ___slab_alloc (mm/slub.c:3819)
> [ 117.911291][ T468] __slab_alloc (mm/slub.c:3910)
> [ 117.911959][ T468] __kmalloc_cache_node_noprof (mm/slub.c:3961)
> [ 117.912775][ T468] alloc_fair_sched_group (include/linux/slab.h:? kernel/sched/fair.c:13312)
> [ 117.913582][ T468] sched_create_group (kernel/sched/core.c:8853)
> [ 117.914420][ T468] sched_autogroup_create_attach (include/linux/err.h:67 kernel/sched/autogroup.c:93 kernel/sched/autogroup.c:194)
> [ 117.915352][ T468] ksys_setsid (kernel/sys.c:?)
> [ 117.916031][ T468] __ia32_sys_setsid (kernel/sys.c:1269)
> [ 117.916779][ T468] x64_sys_call (kbuild/obj/consumer/x86_64-randconfig-014-20241028/./arch/x86/include/generated/asm/syscalls_64.h:161)
> [ 117.917631][ T468] do_syscall_64 (arch/x86/entry/common.c:?)
> [ 117.918407][ T468] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  117.919324][  T468] page_owner free stack trace missing
> [  117.920090][  T468]
> [  117.920515][  T468] Memory state around the buggy address:
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241030/202410301535.14e0855c-lkp@intel.com
> 
> 

Hmm... Should add a check about whether se node is on rb tree effectively.

Thanks for the report.


