Return-Path: <linux-kernel+bounces-329150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7498978E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6EB1C2219B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C52E419;
	Sat, 14 Sep 2024 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HQQjtWya"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F6137747
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293060; cv=none; b=cU8doRfJR3el9ADNHbiwp0W5eQxGWSRUwsc7A0aUHW9H8eeVykkxX6byCTPa2ZilpoN3fGVjOYJi3B5Hfe1WYGxulfmuXPLP8XaI+POygN3x9+SVEZKx6W7k3Cu/+H0C0dn/O85lPvARAOkRe+7NCdVip0DMJ07v/6sLiCXVVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293060; c=relaxed/simple;
	bh=3eMBJ8a08f5PJEXL5Mb9Kss/mQ5OYW6J4sTufTKkV3M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gn5PVaPlmDX0mLkzFmJC5BDsNxtdVG4jhOyM6Vm6GlR1aA9Wv6aABxdjDFYkaT+sIz1WyENF4LCNKD3Qp/uL6JR39ACvo95YneYBv6U78rPw35ddbf+po8hT/9Ia4j+XPT+Lz18hybioLwi0sxawdipNkTIWLtdICgrxJzzYSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HQQjtWya; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726293053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veer4suTA4uXburfEOYW87zRBwIexKtFYVv/nsFIZeU=;
	b=HQQjtWya1zoyIVZIxt3WIG4ScuvPl5zdhCOUT7ymDxwuAkLrjCP7SK0DfI4Be0vnMbCiP6
	kTM2MimgRc1SZmZ/5hk92o+2HT4Yk+sNs9X9YS5K/LWdN0AXHrA1F3PIvTCRT9h+3/ymAz
	7FHsQsoOVgE+htv0Fi0Y72JTRn3FvVk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
 (2)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <66e09d91.170a0220.16fb63.1454@mx.google.com>
Date: Sat, 14 Sep 2024 13:50:10 +0800
Cc: syzbot <syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B2E5B76-8FC6-49EA-B0B3-2452ED6ABC5D@linux.dev>
References: <00000000000067c20b06219fbc26@google.com>
 <0CCD30A0-6EB0-4019-90B3-9418A179EADD@linux.dev>
 <66df6348.650a0220.1267b3.ac7e@mx.google.com>
 <66e09d91.170a0220.16fb63.1454@mx.google.com>
To: Vishal Moola <vishal.moola@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 11, 2024, at 03:27, Vishal Moola <vishal.moola@gmail.com> =
wrote:
>=20
> On Mon, Sep 09, 2024 at 02:06:13PM -0700, Vishal Moola wrote:
>> On Mon, Sep 09, 2024 at 05:57:52PM +0800, Muchun Song wrote:
>>>=20
>>>=20
>>>> On Sep 9, 2024, at 02:23, syzbot =
<syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com> wrote:
>>>>=20
>>>> Hello,
>>>>=20
>>>> syzbot found the following issue on:
>>>>=20
>>>> HEAD commit:    88fac17500f4 Merge tag 'fuse-fixes-6.11-rc7' of =
git://git...
>>>> git tree:       upstream
>>>> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D13291d97980000
>>>> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3D660f6eb11f9c7dc5
>>>> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3D2dab93857ee95f2eeb08
>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils =
for Debian) 2.40
>>>>=20
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>=20
>>>> Downloadable assets:
>>>> disk image: =
https://storage.googleapis.com/syzbot-assets/6dfa1c637f53/disk-88fac175.ra=
w.xz
>>>> vmlinux: =
https://storage.googleapis.com/syzbot-assets/7a322b491698/vmlinux-88fac175=
.xz
>>>> kernel image: =
https://storage.googleapis.com/syzbot-assets/edc9184a3a97/bzImage-88fac175=
.xz
>>>>=20
>>>> IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
>>>> Reported-by: syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com
>>>>=20
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> BUG: KASAN: slab-use-after-free in __vma_shareable_lock =
include/linux/hugetlb.h:1278 [inline]
>>>=20
>>> This is accessing vma structure.
>>>=20
>>>> BUG: KASAN: slab-use-after-free in hugetlb_vma_unlock_read =
mm/hugetlb.c:281 [inline]
>>>> BUG: KASAN: slab-use-after-free in hugetlb_no_page =
mm/hugetlb.c:6380 [inline]
>>>> BUG: KASAN: slab-use-after-free in hugetlb_fault+0xfaf/0x3770 =
mm/hugetlb.c:6485
>>>> Read of size 8 at addr ffff88807c17f9d0 by task syz.0.4558/26998
>>>>=20
>>>> CPU: 1 UID: 0 PID: 26998 Comm: syz.0.4558 Not tainted =
6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 08/06/2024
>>>> Call Trace:
>>>> <TASK>
>>>> __dump_stack lib/dump_stack.c:93 [inline]
>>>> dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>>>> print_address_description mm/kasan/report.c:377 [inline]
>>>> print_report+0x169/0x550 mm/kasan/report.c:488
>>>> kasan_report+0x143/0x180 mm/kasan/report.c:601
>>>> __vma_shareable_lock include/linux/hugetlb.h:1278 [inline]
>>>> hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
>>>=20
>>> I think vma is freed before this call of hugetlb_vma_unlock_read()
>>> but after hugetlb_vma_lock_read() in hugetlb_fault(). I found a
>>> possible scenario to cause this problem.
>>>=20
>>> hugetlb_no_page()
>>> ret =3D vmf_anon_prepare()
>>> if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
>>> if (!mmap_read_trylock(vma->vm_mm)) {
>>> vma_end_read(vma);
>>> // VMA lock is released, which could be freed before the call of =
hugetlb_vma_unlock_read().
>>> return VM_FAULT_RETRY;
>>> }
>>> }
>>> if (unlikely(ret))
>>> goto out;
>>> out:
>>> hugetlb_vma_unlock_read(vma); // UAF of VMA
>>=20
>> Thanks for catching this, it indeed looks like the problem. I don't
>> think its easy to reproduce since we would have to unmap the vma =
while
>> a fault is being handled (and failing).
>>=20
>> This same issue should be present in hugetlb_wp() as well, so I'm =
thinking
>> the best fix would be to make another function similar to
>> vmf_anon_prepare() that doesn't release the vma lock. Then wait to =
drop
>> the lock until hugetlb_vma_unlock_read() is called.
>>=20
>> I'll have that fix out tomorrow.
>=20
> The 2 attached patches should fix this.

Hi Vishal,

Would you mind sending it as a separated patch instead of an
attachment?

Thanks.

>=20
>>> The culprit commit should be
>>>=20
>>> 7c43a553792a1 ("hugetlb: allow faults to be handled under the VMA =
lock").
>>>=20
>>> I will take a closer look at the solution tomorrow. And Cc the =
author of the
>>> above commit, maybe have some comments on this.
>>>=20
>>> Muchun,
>>> Thanks.
>>>=20
>>>> hugetlb_no_page mm/hugetlb.c:6380 [inline]
>>>> hugetlb_fault+0xfaf/0x3770 mm/hugetlb.c:6485
>>>> handle_mm_fault+0x1901/0x1bc0 mm/memory.c:5830
>>>> do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
>>>> handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>>>> exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
>>>> asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>>>> RIP: 0033:0x7f2b63744998
>>>> Code: fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa =
7f 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 <48> =
89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 c5
>>>> RSP: 002b:00007f2b63a5fb88 EFLAGS: 00010206
>>>> RAX: 00000000200002c0 RBX: 0000000000000004 RCX: 00676e7277682f76
>>>> RDX: 000000000000000b RSI: 7277682f7665642f RDI: 00000000200002c0
>>>> RBP: 00007f2b63937a80 R08: 00007f2b63600000 R09: 0000000000000001
>>>> R10: 0000000000000001 R11: 0000000000000009 R12: 000000000014aa5e
>>>> R13: 00007f2b63a5fc90 R14: 0000000000000032 R15: fffffffffffffffe
>>>> </TASK>
>>>>=20
>>>> Allocated by task 27000:
>>>> kasan_save_stack mm/kasan/common.c:47 [inline]
>>>> kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>>> unpoison_slab_object mm/kasan/common.c:312 [inline]
>>>> __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>>>> kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>>> slab_post_alloc_hook mm/slub.c:3988 [inline]
>>>> slab_alloc_node mm/slub.c:4037 [inline]
>>>> kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
>>>> vm_area_alloc+0x24/0x1d0 kernel/fork.c:471
>>>> mmap_region+0xc3d/0x2090 mm/mmap.c:2944
>>>> do_mmap+0x8f9/0x1010 mm/mmap.c:1468
>>>> vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
>>>> ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1514
>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>=20
>>>> Freed by task 26255:
>>>> kasan_save_stack mm/kasan/common.c:47 [inline]
>>>> kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>>> kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>>>> poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>>>> __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>>>> kasan_slab_free include/linux/kasan.h:184 [inline]
>>>> slab_free_hook mm/slub.c:2252 [inline]
>>>> slab_free mm/slub.c:4473 [inline]
>>>> kmem_cache_free+0x145/0x350 mm/slub.c:4548
>>>> rcu_do_batch kernel/rcu/tree.c:2569 [inline]
>>>> rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
>>>=20
>>> VMA structure is freed via rcu, so it is really a UAF problem.
>>>=20
>>>> handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
>>>> do_softirq+0x11b/0x1e0 kernel/softirq.c:455
>>>> __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
>>>> spin_unlock_bh include/linux/spinlock.h:396 [inline]
>>>> __fib6_clean_all+0x327/0x4b0 net/ipv6/ip6_fib.c:2277
>>>> rt6_sync_down_dev net/ipv6/route.c:4908 [inline]
>>>> rt6_disable_ip+0x164/0x7e0 net/ipv6/route.c:4913
>>>> addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3856
>>>> addrconf_notify+0x3cb/0x1020
>>>> notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
>>>> call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>>>> call_netdevice_notifiers net/core/dev.c:2046 [inline]
>>>> dev_close_many+0x33c/0x4c0 net/core/dev.c:1587
>>>> unregister_netdevice_many_notify+0x50b/0x1c40 net/core/dev.c:11327
>>>> unregister_netdevice_many net/core/dev.c:11414 [inline]
>>>> default_device_exit_batch+0xa0f/0xa90 net/core/dev.c:11897
>>>> ops_exit_list net/core/net_namespace.c:178 [inline]
>>>> cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
>>>> process_one_work kernel/workqueue.c:3231 [inline]
>>>> process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>>>> worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
>>>> kthread+0x2f0/0x390 kernel/kthread.c:389
>>>> ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>>> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>>>=20
>>>> Last potentially related work creation:
>>>> kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>>>> __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
>>>> __call_rcu_common kernel/rcu/tree.c:3106 [inline]
>>>> call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
>>>> remove_vma mm/mmap.c:189 [inline]
>>>> remove_mt mm/mmap.c:2415 [inline]
>>>> do_vmi_align_munmap+0x155c/0x18c0 mm/mmap.c:2758
>>>> do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
>>>> mmap_region+0x72f/0x2090 mm/mmap.c:2881
>>>> do_mmap+0x8f9/0x1010 mm/mmap.c:1468
>>>> vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
>>>> ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1514
>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>=20
>>>> The buggy address belongs to the object at ffff88807c17f9b0
>>>> which belongs to the cache vm_area_struct of size 184
>>>> The buggy address is located 32 bytes inside of
>>>> freed 184-byte region [ffff88807c17f9b0, ffff88807c17fa68)
>>>>=20
>>>> The buggy address belongs to the physical page:
>>>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 =
pfn:0x7c17f
>>>> memcg:ffff888028997401
>>>> anon flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
>>>> page_type: 0xfdffffff(slab)
>>>> raw: 00fff00000000000 ffff88801bafdb40 ffffea0001f89e00 =
000000000000000d
>>>> raw: 0000000000000000 0000000000100010 00000001fdffffff =
ffff888028997401
>>>> page dumped because: kasan: bad access detected
>>>> page_owner tracks the page as allocated
>>>> page last allocated via order 0, migratetype Unmovable, gfp_mask =
0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 26741, =
tgid 26741 (dhcpcd-run-hook), ts 1341391347767, free_ts 1341166373745
>>>> set_page_owner include/linux/page_owner.h:32 [inline]
>>>> post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
>>>> prep_new_page mm/page_alloc.c:1501 [inline]
>>>> get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
>>>> __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
>>>> __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>>>> alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>>>> alloc_slab_page+0x5f/0x120 mm/slub.c:2321
>>>> allocate_slab+0x5a/0x2f0 mm/slub.c:2484
>>>> new_slab mm/slub.c:2537 [inline]
>>>> ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
>>>> __slab_alloc+0x58/0xa0 mm/slub.c:3813
>>>> __slab_alloc_node mm/slub.c:3866 [inline]
>>>> slab_alloc_node mm/slub.c:4025 [inline]
>>>> kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
>>>> vm_area_dup+0x27/0x290 kernel/fork.c:486
>>>> dup_mmap kernel/fork.c:695 [inline]
>>>> dup_mm kernel/fork.c:1672 [inline]
>>>> copy_mm+0xc7b/0x1f30 kernel/fork.c:1721
>>>> copy_process+0x187a/0x3dc0 kernel/fork.c:2374
>>>> kernel_clone+0x226/0x8f0 kernel/fork.c:2781
>>>> __do_sys_clone kernel/fork.c:2924 [inline]
>>>> __se_sys_clone kernel/fork.c:2908 [inline]
>>>> __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>> page last free pid 26730 tgid 26718 stack trace:
>>>> reset_page_owner include/linux/page_owner.h:25 [inline]
>>>> free_pages_prepare mm/page_alloc.c:1094 [inline]
>>>> free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
>>>> __folio_put+0x2c8/0x440 mm/swap.c:128
>>>> migrate_folio_move mm/migrate.c:1330 [inline]
>>>> migrate_pages_batch+0x2a76/0x3560 mm/migrate.c:1818
>>>> migrate_pages_sync mm/migrate.c:1884 [inline]
>>>> migrate_pages+0x1f59/0x3460 mm/migrate.c:1993
>>>> do_mbind mm/mempolicy.c:1388 [inline]
>>>> kernel_mbind mm/mempolicy.c:1531 [inline]
>>>> __do_sys_mbind mm/mempolicy.c:1605 [inline]
>>>> __se_sys_mbind+0x1490/0x19f0 mm/mempolicy.c:1601
>>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>=20
>>>> Memory state around the buggy address:
>>>> ffff88807c17f880: fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00
>>>> ffff88807c17f900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>>>>> ffff88807c17f980: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
>>>>                                                ^
>>>> ffff88807c17fa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>>>> ffff88807c17fa80: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>=20
>>>>=20
>>>> ---
>>>> This report is generated by a bot. It may contain errors.
>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>>=20
>>>> syzbot will keep track of this issue. See:
>>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>>=20
>>>> If the report is already addressed, let syzbot know by replying =
with:
>>>> #syz fix: exact-commit-title
>>>>=20
>>>> If you want to overwrite report's subsystems, reply with:
>>>> #syz set subsystems: new-subsystem
>>>> (See the list of subsystem names on the web dashboard)
>>>>=20
>>>> If the report is a duplicate of another one, reply with:
>>>> #syz dup: exact-subject-of-another-report
>>>>=20
>>>> If you want to undo deduplication, reply with:
>>>> #syz undup
>>>=20
> =
<0001-mm-Change-vmf_anon_prepare-to-__vmf_anon_prepare.patch><0002-mm-huge=
tlb.c-Fix-UAF-of-vma-in-hugetlb-fault-pathway.patch>


