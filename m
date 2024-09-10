Return-Path: <linux-kernel+bounces-323787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F9974377
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE8A1C24A16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460DB1A4F03;
	Tue, 10 Sep 2024 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ltOlOC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1B1A2567
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996437; cv=none; b=OPyVjLhkp4c8WTmJ9JL/5FA0Di0WUXh+cB1eFzlqCmEnMbqZcMhStp284wsDgY3ALV8vO6xNqLf+9NGKmBbAZQYp2SEW9kMHrWb+YvGYGCsWgRl2WGkZxkzFUQcmrQZlZBOvCuvNaAwsWKzu1TQu8IWSOj3Zc5a1wfDsRDtdT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996437; c=relaxed/simple;
	bh=hKxpolh4BsF65S6a/TZng83PWiuXizdSWd+hwRXu+5E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIQfHVl3DRiwn2Ym6c4hni2AhJSJdWJusis5BNHkVtLIVzy5CMsR6+CqBdvaebHveXLg+FZ+CBQCXLa/2uEXE7JkHQB7NHKtVCO6TXNPfUz47+ZzESbJ3G1IN7uWJZcX4KyKxXzNzUkAlV6YuAnFFBjb1HD7GTlKjyK7R6cPAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/ltOlOC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2068a7c9286so55771825ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725996434; x=1726601234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pWUoHOiY2u5V/YKrfd3XC0Jjufow98r2p7nkxpf/st8=;
        b=T/ltOlOCZ1NOo74KDiAnuz8n/8Z1aKaKWeYNnoO9AQ7vE/7afOPhYAe89EJAQHjhvi
         SB12aG5JvRRpGV7+cJLfSvkzE3Ao2qBvMPhPPsK9cLC7XXiwXWHfhBFLB7CGGM8dTUTW
         xZ9KJIpDgtSa/W5d3rBgc9pFJwZCHQGPTGym1lZW2N3h1S5tlKx5hThtQ/1bUvk7Fwr2
         MamlqbOQfls7fEh2HCoJ4Iwk6mc8KRkJ5dlqUX9GNwoBeOOo00IvvoOwaH6K/fwtHVC9
         eprtlumxzBQ3omUt6Zehg2ijd3qm+BrbVN4w4x0dvtJctBtl7CbFGQg9Z3QLi53rAl78
         2lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725996434; x=1726601234;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWUoHOiY2u5V/YKrfd3XC0Jjufow98r2p7nkxpf/st8=;
        b=b+Q3i2UVsv11gziBdjEfPDiCkaxvgZmIwLX4RJvLBr/sE7wYp5S/pDH9R0PW0oSizD
         MVOTbdtbzsApxwghu5Tz6jCcWAjcTMkuB3vgrK/suCUJSTqrMwrLbDgFDbqltWPWmXqr
         qyIkHYcpdRLWk3jVsYj0skr3dzaH9dNg2fAt2EJ2wu5mA1uXsvk/2xk+am0sWuR0gLjk
         QAJ8C1D3mRmGxTQvA6JAEmM4Pjd4shMjh8xhNwbDW6fNrkp6Kg8UOHB4eNcFcY77M2vl
         TnmrCVhQaPkJCP4ztIansw6yeekekDx0kxNmZqoTdL6oUokmbi4uOUa9u54/B+LRb1du
         zs7w==
X-Forwarded-Encrypted: i=1; AJvYcCXC9Eva1oZ6HfOIKvVeXoJ4wy+gUHFB/f9rwgTa8h1lI6bvil6W0jUePeIJ2ZtWkOlA2vXhagNO2nPaP6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9lNsj2Q2y/Ws1WiZ545TL5NP8KtCwcRqSgbfp1VeQbgpbL1q+
	Sb2UDGqHjGKW6jtaVCSf/FAVr7WbY3qU2NMEUphd2mdzI1yd1kLH6O+OeQ==
X-Google-Smtp-Source: AGHT+IGBUg5RdsApc+aJFRVzYOV+EJ7jG2APsK2TaVWde4ZBLolIPBUmmg4alY9dJcCBRaxMRV/L0A==
X-Received: by 2002:a17:903:230c:b0:202:38d8:173 with SMTP id d9443c01a7336-2074c612f58mr28279945ad.29.1725996433986;
        Tue, 10 Sep 2024 12:27:13 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc009f91sm8942763a91.16.2024.09.10.12.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:27:13 -0700 (PDT)
Message-ID: <66e09d91.170a0220.16fb63.1454@mx.google.com>
X-Google-Original-Message-ID: <ZuCdjtP_iW6qO8cX@DESKTOP-DUKSS9G.>
Date: Tue, 10 Sep 2024 12:27:10 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: syzbot <syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
 (2)
References: <00000000000067c20b06219fbc26@google.com>
 <0CCD30A0-6EB0-4019-90B3-9418A179EADD@linux.dev>
 <66df6348.650a0220.1267b3.ac7e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="H5SgWbEn7EJ+G1lf"
Content-Disposition: inline
In-Reply-To: <66df6348.650a0220.1267b3.ac7e@mx.google.com>


--H5SgWbEn7EJ+G1lf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2024 at 02:06:13PM -0700, Vishal Moola wrote:
> On Mon, Sep 09, 2024 at 05:57:52PM +0800, Muchun Song wrote:
> > 
> > 
> > > On Sep 9, 2024, at 02:23, syzbot <syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com> wrote:
> > > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    88fac17500f4 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13291d97980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2dab93857ee95f2eeb08
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/6dfa1c637f53/disk-88fac175.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/7a322b491698/vmlinux-88fac175.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/edc9184a3a97/bzImage-88fac175.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com
> > > 
> > > ==================================================================
> > > BUG: KASAN: slab-use-after-free in __vma_shareable_lock include/linux/hugetlb.h:1278 [inline]
> > 
> > This is accessing vma structure.
> > 
> > > BUG: KASAN: slab-use-after-free in hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
> > > BUG: KASAN: slab-use-after-free in hugetlb_no_page mm/hugetlb.c:6380 [inline]
> > > BUG: KASAN: slab-use-after-free in hugetlb_fault+0xfaf/0x3770 mm/hugetlb.c:6485
> > > Read of size 8 at addr ffff88807c17f9d0 by task syz.0.4558/26998
> > > 
> > > CPU: 1 UID: 0 PID: 26998 Comm: syz.0.4558 Not tainted 6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> > > Call Trace:
> > > <TASK>
> > > __dump_stack lib/dump_stack.c:93 [inline]
> > > dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
> > > print_address_description mm/kasan/report.c:377 [inline]
> > > print_report+0x169/0x550 mm/kasan/report.c:488
> > > kasan_report+0x143/0x180 mm/kasan/report.c:601
> > > __vma_shareable_lock include/linux/hugetlb.h:1278 [inline]
> > > hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
> > 
> > I think vma is freed before this call of hugetlb_vma_unlock_read()
> > but after hugetlb_vma_lock_read() in hugetlb_fault(). I found a
> > possible scenario to cause this problem.
> > 
> > hugetlb_no_page()
> > 	ret = vmf_anon_prepare()
> > 		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > 			if (!mmap_read_trylock(vma->vm_mm)) {
> > 				vma_end_read(vma);
> > 				// VMA lock is released, which could be freed before the call of hugetlb_vma_unlock_read().
> > 				return VM_FAULT_RETRY;
> > 			}
> > 		}
> > 	if (unlikely(ret))
> > 		goto out;
> > out:
> > 	hugetlb_vma_unlock_read(vma); // UAF of VMA
> 
> Thanks for catching this, it indeed looks like the problem. I don't
> think its easy to reproduce since we would have to unmap the vma while
> a fault is being handled (and failing).
> 
> This same issue should be present in hugetlb_wp() as well, so I'm thinking
> the best fix would be to make another function similar to
> vmf_anon_prepare() that doesn't release the vma lock. Then wait to drop
> the lock until hugetlb_vma_unlock_read() is called.
> 
> I'll have that fix out tomorrow.

The 2 attached patches should fix this.

> > The culprit commit should be
> > 	
> > 	7c43a553792a1 ("hugetlb: allow faults to be handled under the VMA lock").
> > 
> > I will take a closer look at the solution tomorrow. And Cc the author of the
> > above commit, maybe have some comments on this.
> > 
> > Muchun,
> > Thanks.
> > 
> > > hugetlb_no_page mm/hugetlb.c:6380 [inline]
> > > hugetlb_fault+0xfaf/0x3770 mm/hugetlb.c:6485
> > > handle_mm_fault+0x1901/0x1bc0 mm/memory.c:5830
> > > do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
> > > handle_page_fault arch/x86/mm/fault.c:1481 [inline]
> > > exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
> > > asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> > > RIP: 0033:0x7f2b63744998
> > > Code: fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 c5
> > > RSP: 002b:00007f2b63a5fb88 EFLAGS: 00010206
> > > RAX: 00000000200002c0 RBX: 0000000000000004 RCX: 00676e7277682f76
> > > RDX: 000000000000000b RSI: 7277682f7665642f RDI: 00000000200002c0
> > > RBP: 00007f2b63937a80 R08: 00007f2b63600000 R09: 0000000000000001
> > > R10: 0000000000000001 R11: 0000000000000009 R12: 000000000014aa5e
> > > R13: 00007f2b63a5fc90 R14: 0000000000000032 R15: fffffffffffffffe
> > > </TASK>
> > > 
> > > Allocated by task 27000:
> > > kasan_save_stack mm/kasan/common.c:47 [inline]
> > > kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > > unpoison_slab_object mm/kasan/common.c:312 [inline]
> > > __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
> > > kasan_slab_alloc include/linux/kasan.h:201 [inline]
> > > slab_post_alloc_hook mm/slub.c:3988 [inline]
> > > slab_alloc_node mm/slub.c:4037 [inline]
> > > kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
> > > vm_area_alloc+0x24/0x1d0 kernel/fork.c:471
> > > mmap_region+0xc3d/0x2090 mm/mmap.c:2944
> > > do_mmap+0x8f9/0x1010 mm/mmap.c:1468
> > > vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
> > > ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1514
> > > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > Freed by task 26255:
> > > kasan_save_stack mm/kasan/common.c:47 [inline]
> > > kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > > kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
> > > poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
> > > __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
> > > kasan_slab_free include/linux/kasan.h:184 [inline]
> > > slab_free_hook mm/slub.c:2252 [inline]
> > > slab_free mm/slub.c:4473 [inline]
> > > kmem_cache_free+0x145/0x350 mm/slub.c:4548
> > > rcu_do_batch kernel/rcu/tree.c:2569 [inline]
> > > rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
> > 
> > VMA structure is freed via rcu, so it is really a UAF problem.
> > 
> > > handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
> > > do_softirq+0x11b/0x1e0 kernel/softirq.c:455
> > > __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
> > > spin_unlock_bh include/linux/spinlock.h:396 [inline]
> > > __fib6_clean_all+0x327/0x4b0 net/ipv6/ip6_fib.c:2277
> > > rt6_sync_down_dev net/ipv6/route.c:4908 [inline]
> > > rt6_disable_ip+0x164/0x7e0 net/ipv6/route.c:4913
> > > addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3856
> > > addrconf_notify+0x3cb/0x1020
> > > notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
> > > call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
> > > call_netdevice_notifiers net/core/dev.c:2046 [inline]
> > > dev_close_many+0x33c/0x4c0 net/core/dev.c:1587
> > > unregister_netdevice_many_notify+0x50b/0x1c40 net/core/dev.c:11327
> > > unregister_netdevice_many net/core/dev.c:11414 [inline]
> > > default_device_exit_batch+0xa0f/0xa90 net/core/dev.c:11897
> > > ops_exit_list net/core/net_namespace.c:178 [inline]
> > > cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
> > > process_one_work kernel/workqueue.c:3231 [inline]
> > > process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> > > worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
> > > kthread+0x2f0/0x390 kernel/kthread.c:389
> > > ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > 
> > > Last potentially related work creation:
> > > kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
> > > __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
> > > __call_rcu_common kernel/rcu/tree.c:3106 [inline]
> > > call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
> > > remove_vma mm/mmap.c:189 [inline]
> > > remove_mt mm/mmap.c:2415 [inline]
> > > do_vmi_align_munmap+0x155c/0x18c0 mm/mmap.c:2758
> > > do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
> > > mmap_region+0x72f/0x2090 mm/mmap.c:2881
> > > do_mmap+0x8f9/0x1010 mm/mmap.c:1468
> > > vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
> > > ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1514
> > > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > The buggy address belongs to the object at ffff88807c17f9b0
> > > which belongs to the cache vm_area_struct of size 184
> > > The buggy address is located 32 bytes inside of
> > > freed 184-byte region [ffff88807c17f9b0, ffff88807c17fa68)
> > > 
> > > The buggy address belongs to the physical page:
> > > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c17f
> > > memcg:ffff888028997401
> > > anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > > page_type: 0xfdffffff(slab)
> > > raw: 00fff00000000000 ffff88801bafdb40 ffffea0001f89e00 000000000000000d
> > > raw: 0000000000000000 0000000000100010 00000001fdffffff ffff888028997401
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 26741, tgid 26741 (dhcpcd-run-hook), ts 1341391347767, free_ts 1341166373745
> > > set_page_owner include/linux/page_owner.h:32 [inline]
> > > post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
> > > prep_new_page mm/page_alloc.c:1501 [inline]
> > > get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
> > > __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
> > > __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
> > > alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
> > > alloc_slab_page+0x5f/0x120 mm/slub.c:2321
> > > allocate_slab+0x5a/0x2f0 mm/slub.c:2484
> > > new_slab mm/slub.c:2537 [inline]
> > > ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
> > > __slab_alloc+0x58/0xa0 mm/slub.c:3813
> > > __slab_alloc_node mm/slub.c:3866 [inline]
> > > slab_alloc_node mm/slub.c:4025 [inline]
> > > kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
> > > vm_area_dup+0x27/0x290 kernel/fork.c:486
> > > dup_mmap kernel/fork.c:695 [inline]
> > > dup_mm kernel/fork.c:1672 [inline]
> > > copy_mm+0xc7b/0x1f30 kernel/fork.c:1721
> > > copy_process+0x187a/0x3dc0 kernel/fork.c:2374
> > > kernel_clone+0x226/0x8f0 kernel/fork.c:2781
> > > __do_sys_clone kernel/fork.c:2924 [inline]
> > > __se_sys_clone kernel/fork.c:2908 [inline]
> > > __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
> > > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > page last free pid 26730 tgid 26718 stack trace:
> > > reset_page_owner include/linux/page_owner.h:25 [inline]
> > > free_pages_prepare mm/page_alloc.c:1094 [inline]
> > > free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
> > > __folio_put+0x2c8/0x440 mm/swap.c:128
> > > migrate_folio_move mm/migrate.c:1330 [inline]
> > > migrate_pages_batch+0x2a76/0x3560 mm/migrate.c:1818
> > > migrate_pages_sync mm/migrate.c:1884 [inline]
> > > migrate_pages+0x1f59/0x3460 mm/migrate.c:1993
> > > do_mbind mm/mempolicy.c:1388 [inline]
> > > kernel_mbind mm/mempolicy.c:1531 [inline]
> > > __do_sys_mbind mm/mempolicy.c:1605 [inline]
> > > __se_sys_mbind+0x1490/0x19f0 mm/mempolicy.c:1601
> > > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > Memory state around the buggy address:
> > > ffff88807c17f880: fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00
> > > ffff88807c17f900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
> > >> ffff88807c17f980: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
> > >                                                 ^
> > > ffff88807c17fa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
> > > ffff88807c17fa80: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
> > > ==================================================================
> > > 
> > > 
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > 
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > 
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > > 
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > > 
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > > 
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > 

--H5SgWbEn7EJ+G1lf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-Change-vmf_anon_prepare-to-__vmf_anon_prepare.patch"

From 734dde34151c2951b86f16cc554e0eed671d340d Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Tue, 10 Sep 2024 10:39:46 -0700
Subject: [PATCH 1/2] mm: Change vmf_anon_prepare() to __vmf_anon_prepare()

Some callers of vmf_anon_prepare() may not want us to release the
per-VMA lock ourselves. Rename vmf_anon_prepare() to
__vmf_anon_prepare() and let the callers drop the lock when desired.

Also, make vmf_anon_prepare() a wrapper that releases the per-VMA lock
itself for any callers that don't care.

This is in preparation to fix this bug reported by syzbot:
https://lore.kernel.org/linux-mm/00000000000067c20b06219fbc26@google.com/

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/internal.h | 11 ++++++++++-
 mm/memory.c   |  8 +++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 44c8dec1f0d7..93083bbeeefa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -320,7 +320,16 @@ static inline void wake_throttle_isolated(pg_data_t *pgdat)
 		wake_up(wqh);
 }
 
-vm_fault_t vmf_anon_prepare(struct vm_fault *vmf);
+vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf);
+static inline vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+{
+	vm_fault_t ret = __vmf_anon_prepare(vmf);
+
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vmf->vma);
+	return ret;
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
diff --git a/mm/memory.c b/mm/memory.c
index 36f655eb66c4..d564737255f8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3262,7 +3262,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 }
 
 /**
- * vmf_anon_prepare - Prepare to handle an anonymous fault.
+ * __vmf_anon_prepare - Prepare to handle an anonymous fault.
  * @vmf: The vm_fault descriptor passed from the fault handler.
  *
  * When preparing to insert an anonymous page into a VMA from a
@@ -3276,7 +3276,7 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
  * Return: 0 if fault handling can proceed.  Any other value should be
  * returned to the caller.
  */
-vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
@@ -3284,10 +3284,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 	if (likely(vma->anon_vma))
 		return 0;
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		if (!mmap_read_trylock(vma->vm_mm)) {
-			vma_end_read(vma);
+		if (!mmap_read_trylock(vma->vm_mm))
 			return VM_FAULT_RETRY;
-		}
 	}
 	if (__anon_vma_prepare(vma))
 		ret = VM_FAULT_OOM;
-- 
2.45.0


--H5SgWbEn7EJ+G1lf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-mm-hugetlb.c-Fix-UAF-of-vma-in-hugetlb-fault-pathway.patch"

From f3a9fd823fa187c57ddd4482d3f089911c912e5c Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Tue, 10 Sep 2024 10:24:24 -0700
Subject: [PATCH 2/2] mm/hugetlb.c: Fix UAF of vma in hugetlb fault pathway

Syzbot reports a UAF in hugetlb_fault(). This happens because
vmf_anon_prepare() could drop the per-VMA lock and allow the current VMA
to be freed before hugetlb_vma_unlock_read() is called.

We can fix this by using a modified version of vmf_anon_prepare() that
doesn't release the VMA lock on failure, and then release it ourselves
after hugetlb_vma_unlock_read().

Reported-by: syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/00000000000067c20b06219fbc26@google.com/
Fixes: 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of anon_vma_prepare()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c77defad295..190fa05635f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5915,7 +5915,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 * When the original hugepage is shared one, it does not have
 	 * anon_vma prepared.
 	 */
-	ret = vmf_anon_prepare(vmf);
+	ret = __vmf_anon_prepare(vmf);
 	if (unlikely(ret))
 		goto out_release_all;
 
@@ -6114,7 +6114,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		}
 
 		if (!(vma->vm_flags & VM_MAYSHARE)) {
-			ret = vmf_anon_prepare(vmf);
+			ret = __vmf_anon_prepare(vmf);
 			if (unlikely(ret))
 				goto out;
 		}
@@ -6245,6 +6245,14 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	folio_unlock(folio);
 out:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * We must check to release the per-VMA lock. __vmf_anon_prepare() is
+	 * the only way ret can be set to VM_FAULT_RETRY.
+	 */
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vma);
+
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	return ret;
 
@@ -6466,6 +6474,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * We must check to release the per-VMA lock. __vmf_anon_prepare() in
+	 * hugetlb_wp() is the only way ret can be set to VM_FAULT_RETRY.
+	 */
+	if (unlikely(ret & VM_FAULT_RETRY))
+		vma_end_read(vma);
+
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
-- 
2.45.0


--H5SgWbEn7EJ+G1lf--

