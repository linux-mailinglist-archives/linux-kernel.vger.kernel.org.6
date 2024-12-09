Return-Path: <linux-kernel+bounces-437075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A49E8ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AA62819E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD38215073;
	Mon,  9 Dec 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PXmO5jAB"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920EBA4B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736720; cv=none; b=pB43xI1RgLlZqBfA5Y/z7uWXS12nV8PQgc1Oh7Be5PczMOeUlkmBpZYOInDbsvaKSPPdxf+TU6kk3hVFgs4VBQDL5QcMKnniUCD5PLJvmOv6vpfQXKrGYC39eix8npLcRfzO/+nCEjUIc+fkDSAZttSI7Cpv+F3KZiqbffY+ylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736720; c=relaxed/simple;
	bh=Wlup6fX8WWsue/5absyzmSXk9I70WTr7pVBIErIu2Ac=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:Cc:In-Reply-To; b=e3EjqyrquXdYb4EdaMygtq0xkJq6FhusA5My/3l9y9wBIeJjHIrRaqqateaH2Pf5kf6PnyNiHo+iWqBRnd+lenbBvGvuBHboKH6Rjx3DaQounFncQmjLUTH+A240ytkuFdJTe6WmtJn2X5Xtfy3jNHQbcASNF0LJtiekmx/Kmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PXmO5jAB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7259d6ae0c8so3474536b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733736717; x=1734341517; darn=vger.kernel.org;
        h=in-reply-to:cc:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEASyrqmBPqNtRCBOmLLGOFznQqnSInxFmHt9ZU2mXo=;
        b=PXmO5jABO4sfgdYloVqxGuxZxAlbZm+uJ/lMseH0lQCGB8ojlJqM2TWy/S0inwkvxv
         JC1ktBC3uiT79HN19ad+eN7MKPJjmS127SlPm6NZsYNr8zzm1TXZFGgQZJafsKRhwgtd
         oEvPRM7U6ENxtjWLC5QbT3I5UAtklFTFWCpLQLLqVhLNCreZvNQtUQ1tXUQstogy/Ndv
         Hg1bgHMJCQBs2M+JEh9/hw/6CbTZda2f/YaSeCDFuGYgCsfIlFdwWT62T14T0mAWnk+w
         /vdvYq5bdW3+oUvoT/KnFiXxuajURdMv8k+AXK0dWrhBG+7WebFm/IBZaQr3i3PCYoRz
         OXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733736717; x=1734341517;
        h=in-reply-to:cc:from:references:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wEASyrqmBPqNtRCBOmLLGOFznQqnSInxFmHt9ZU2mXo=;
        b=T4RSgHb/nKl9kyHfvLbCZMOiRt4p2mMgoDTL8ejSC39A0Q+3+vOhJZN0kAi/EBjOWa
         OGEp50YAA/7lVD/Ao1i5OlI3MjHOiGKgEHkYtCMvePaQWtA84UrcVqNVrvvT274GDb1i
         XCSU3RnmSMeri465vg7RXqMuT1MlrXkBNfzyf4OoDM4ptBTKgdFZfPGpqv6wa49wS/tU
         9CeDSZbLIk7zijeAJzO08RLd/+Jt2WtG5zUKfcSui7QW1c2KVLZLboQcUak+hi7fIawr
         8klXXEqwNCqv4PawuLzSjVeN3Ue+Fp8j2xseCNfXYxYdZI/6V5y6uGcs3tvPcINwi++O
         Kg2A==
X-Forwarded-Encrypted: i=1; AJvYcCXS45jvFnnYnx31rK6CykoFJ4BvMlmPssEavJIY+BjOGQFKPpO2eu4i0hL/x8cEeAzZAzHjO/IPZgb3aEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+TA07dEFnT60Bz4bPTV82Kg+c8oI50zmjsv8Hfu27NwFitBx
	zF0sHSsruezkdpxmsi5lwk4cwBlMnufWDLBIgE6XPQkIJYzPCdu2DMvYXCMDydc=
X-Gm-Gg: ASbGncuNSgF/OZGYVAS6maAA8V3+/+RzuhPe9uxUH8yZ3WUKgFzkGhOJK98dDJdDu4T
	01zvobJp31oWddKEvSkMT6l3Sa2sEBorWE8worbUbjww0LQpUVf15LgJdCtzlCW5xVfL2zHpGTl
	inQvU9MwQcOLMwWiUfeASnzFtxZDtuqb6hmbWX9IyEvVnr+IZ+hgbXHUzgXExmyPhq5lqpCBVbs
	I6lHgIbd9EM0KMth7tTnt7fuEb76ukU5UslM2IquRdLM5HVkrqlA73lb3H7vqCRQDQdQlk6Nw==
X-Google-Smtp-Source: AGHT+IH7Onkc9F3ftAcoievpQWzIHNXDL0NrUuWyCt/riAu0qc8HBFCFvhIptkG8bZFwMV9IYBnGhA==
X-Received: by 2002:a05:6300:898d:b0:1e1:a68b:104a with SMTP id adf61e73a8af0-1e1a68b14efmr3079441637.42.1733736717479;
        Mon, 09 Dec 2024 01:31:57 -0800 (PST)
Received: from [10.84.148.23] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d2f4b31fsm3639327b3a.90.2024.12.09.01.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 01:31:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------nq0wyn5xAAw890Pk0QpWVj9G"
Message-ID: <ead9bcdc-0dbf-4b3b-adab-a5f37cd1a09f@bytedance.com>
Date: Mon, 9 Dec 2024 17:31:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_pages_pte
Content-Language: en-US
To: syzbot <syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com>
References: <67548279.050a0220.a30f1.015b.GAE@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 x86@kernel.org
In-Reply-To: <67548279.050a0220.a30f1.015b.GAE@google.com>

This is a multi-part message in MIME format.
--------------nq0wyn5xAAw890Pk0QpWVj9G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/8 01:14, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    af2ea8ab7a54 Add linux-next specific files for 20241205
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c4e8df980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
> dashboard link: https://syzkaller.appspot.com/bug?extid=1c58afed1cfd2f57efee
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133850f8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17be9330580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8af0861258fa/disk-af2ea8ab.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ffb38cf7a344/vmlinux-af2ea8ab.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6fbd2e50358a/bzImage-af2ea8ab.xz
> 
> The issue was bisected to:
> 
> commit 5b29c4156f5801fced2ec504b44ab98f60c480bf
> Author: Qi Zheng <zhengqi.arch@bytedance.com>
> Date:   Wed Dec 4 11:09:51 2024 +0000
> 
>      x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d344df980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15d344df980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d344df980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com
> Fixes: 5b29c4156f58 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64")
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5089
> Read of size 8 at addr ffff888034718978 by task syz-executor352/6070
> 
> CPU: 0 UID: 0 PID: 6070 Comm: syz-executor352 Not tainted 6.13.0-rc1-next-20241205-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:489
>   kasan_report+0x143/0x180 mm/kasan/report.c:602
>   __lock_acquire+0x78/0x2100 kernel/locking/lockdep.c:5089
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>   spin_lock include/linux/spinlock.h:351 [inline]
>   move_pages_pte+0x8aa/0x3400 mm/userfaultfd.c:1248
>   move_pages+0xe75/0x16a0 mm/userfaultfd.c:1754
>   userfaultfd_move fs/userfaultfd.c:1899 [inline]
>   userfaultfd_ioctl+0x5221/0x6840 fs/userfaultfd.c:2022
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fed8de85af9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fed8de40238 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fed8df10328 RCX: 00007fed8de85af9
> RDX: 0000000020000080 RSI: 00000000c028aa05 RDI: 0000000000000003
> RBP: 00007fed8df10320 R08: 00007fed8de406c0 R09: 00007fed8de406c0
> R10: 00007fed8de406c0 R11: 0000000000000246 R12: 00007fed8dedd334
> R13: 0000000000000010 R14: 00007ffc241241e0 R15: 00007ffc241242c8
>   </TASK>
> 
> Allocated by task 6070:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   unpoison_slab_object mm/kasan/common.c:319 [inline]
>   __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4104 [inline]
>   slab_alloc_node mm/slub.c:4153 [inline]
>   kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
>   ptlock_alloc+0x20/0x70 mm/memory.c:7026
>   ptlock_init include/linux/mm.h:2971 [inline]
>   pagetable_pte_ctor include/linux/mm.h:2998 [inline]
>   __pte_alloc_one_noprof include/asm-generic/pgalloc.h:73 [inline]
>   pte_alloc_one+0xd3/0x510 arch/x86/mm/pgtable.c:41
>   __do_huge_pmd_anonymous_page mm/huge_memory.c:1229 [inline]
>   do_huge_pmd_anonymous_page+0x2fb/0xb30 mm/huge_memory.c:1374
>   create_huge_pmd mm/memory.c:5737 [inline]
>   __handle_mm_fault mm/memory.c:5986 [inline]
>   handle_mm_fault+0x15a7/0x1bb0 mm/memory.c:6183
>   do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
>   handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>   exc_page_fault+0x459/0x8b0 arch/x86/mm/fault.c:1539
>   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> 
> Freed by task 6071:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2338 [inline]
>   slab_free mm/slub.c:4598 [inline]
>   kmem_cache_free+0x195/0x410 mm/slub.c:4700
>   pagetable_pte_dtor include/linux/mm.h:3009 [inline]
>   ___pte_free_tlb+0x2b/0x140 arch/x86/mm/pgtable.c:63
>   __pte_free_tlb arch/x86/include/asm/pgalloc.h:61 [inline]
>   free_pte+0x142/0x190 mm/pt_reclaim.c:31
>   zap_pte_range mm/memory.c:1780 [inline]
>   zap_pmd_range mm/memory.c:1822 [inline]
>   zap_pud_range mm/memory.c:1851 [inline]
>   zap_p4d_range mm/memory.c:1872 [inline]
>   unmap_page_range+0x4062/0x48d0 mm/memory.c:1893
>   zap_page_range_single+0x45c/0x630 mm/memory.c:2018
>   madvise_dontneed_single_vma mm/madvise.c:859 [inline]
>   madvise_dontneed_free mm/madvise.c:940 [inline]
>   madvise_vma_behavior mm/madvise.c:1270 [inline]
>   madvise_walk_vmas mm/madvise.c:1502 [inline]
>   do_madvise+0x2774/0x4d90 mm/madvise.c:1689
>   __do_sys_madvise mm/madvise.c:1705 [inline]
>   __se_sys_madvise mm/madvise.c:1703 [inline]
>   __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1703
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888034718960
>   which belongs to the cache page->ptl of size 64
> The buggy address is located 24 bytes inside of
>   freed 64-byte region [ffff888034718960, ffff8880347189a0)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34718
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff88801ac4f780 dead000000000122 0000000000000000
> raw: 0000000000000000 00000000802a002a 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5823, tgid 5823 (syz-executor352), ts 65548803787, free_ts 65433386693
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1549
>   prep_new_page mm/page_alloc.c:1557 [inline]
>   get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3475
>   __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4752
>   alloc_pages_mpol+0x30e/0x550 mm/mempolicy.c:2270
>   alloc_slab_page mm/slub.c:2408 [inline]
>   allocate_slab+0x8f/0x3a0 mm/slub.c:2574
>   new_slab mm/slub.c:2627 [inline]
>   ___slab_alloc+0xc27/0x14a0 mm/slub.c:3815
>   __slab_alloc+0x58/0xa0 mm/slub.c:3905
>   __slab_alloc_node mm/slub.c:3980 [inline]
>   slab_alloc_node mm/slub.c:4141 [inline]
>   kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4160
>   ptlock_alloc mm/memory.c:7026 [inline]
>   ptlock_init include/linux/mm.h:2971 [inline]
>   pmd_ptlock_init include/linux/mm.h:3078 [inline]
>   pagetable_pmd_ctor include/linux/mm.h:3116 [inline]
>   pmd_alloc_one_noprof include/asm-generic/pgalloc.h:141 [inline]
>   __pmd_alloc+0x10b/0x670 mm/memory.c:6436
>   pmd_alloc include/linux/mm.h:2862 [inline]
>   copy_pmd_range+0x7352/0x77a0 mm/memory.c:1241
>   copy_pud_range mm/memory.c:1298 [inline]
>   copy_p4d_range mm/memory.c:1322 [inline]
>   copy_page_range+0x99f/0xe90 mm/memory.c:1420
>   dup_mmap kernel/fork.c:751 [inline]
>   dup_mm kernel/fork.c:1693 [inline]
>   copy_mm+0x12d2/0x2060 kernel/fork.c:1742
>   copy_process+0x1845/0x3d80 kernel/fork.c:2393
>   kernel_clone+0x226/0x8e0 kernel/fork.c:2805
>   __do_sys_clone kernel/fork.c:2948 [inline]
>   __se_sys_clone kernel/fork.c:2932 [inline]
>   __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2932
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> page last free pid 6052 tgid 6051 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2658
>   __folio_put+0x2b3/0x360 mm/swap.c:112
>   __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
>   __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
>   tlb_remove_table_rcu+0x76/0xf0 mm/mmu_gather.c:282
>   rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>   rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
>   handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
>   __do_softirq kernel/softirq.c:595 [inline]
>   invoke_softirq kernel/softirq.c:435 [inline]
>   __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
>   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> 
> Memory state around the buggy address:
>   ffff888034718800: 00 00 00 00 fc fc fc fc 00 00 00 00 00 00 00 00
>   ffff888034718880: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
>> ffff888034718900: 00 00 00 00 00 00 00 00 fc fc fc fc fa fb fb fb
>                                                                  ^
>   ffff888034718980: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
>   ffff888034718a00: fc fc fc fc 00 00 00 00 00 00 00 00 fc fc fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git 
mm-unstable

--------------nq0wyn5xAAw890Pk0QpWVj9G
Content-Type: text/plain; charset=UTF-8;
 name="0001-mm-pgtable-fix-UAF-of-ptdesc-ptl.patch"
Content-Disposition: attachment;
 filename="0001-mm-pgtable-fix-UAF-of-ptdesc-ptl.patch"
Content-Transfer-Encoding: base64

RnJvbSAyM2MyZmUzNzZhNzQzODU2ODAyMjg0NWIwMzc0YzE5NWUxZGI5YzRlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBRaSBaaGVuZyA8emhlbmdxaS5hcmNoQGJ5dGVkYW5j
ZS5jb20+CkRhdGU6IE1vbiwgOSBEZWMgMjAyNCAxNzoyODowMiArMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIG1tOiBwZ3RhYmxlOiBmaXggVUFGIG9mIHB0ZGVzYy0+cHRsCgpUaGUgc3l6Ym90
IHJlcG9ydGVkIHRoZSBmb2xsb3dpbmcgQlVHOgoKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CkJVRzogS0FTQU46
IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gX19sb2NrX2FjcXVpcmUrMHg3OC8weDIxMDAga2Vy
bmVsL2xvY2tpbmcvbG9ja2RlcC5jOjUwODkKUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZm
ODg4MDM0NzE4OTc4IGJ5IHRhc2sgc3l6LWV4ZWN1dG9yMzUyLzYwNzAKCkNQVTogMCBVSUQ6
IDAgUElEOiA2MDcwIENvbW06IHN5ei1leGVjdXRvcjM1MiBOb3QgdGFpbnRlZCA2LjEzLjAt
cmMxLW5leHQtMjAyNDEyMDUtc3l6a2FsbGVyICMwCkhhcmR3YXJlIG5hbWU6IEdvb2dsZSBH
b29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2ds
ZSAwOS8xMy8yMDI0CkNhbGwgVHJhY2U6CiA8VEFTSz4KIF9fZHVtcF9zdGFjayBsaWIvZHVt
cF9zdGFjay5jOjk0IFtpbmxpbmVdCiBkdW1wX3N0YWNrX2x2bCsweDI0MS8weDM2MCBsaWIv
ZHVtcF9zdGFjay5jOjEyMAogcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbiBtbS9rYXNhbi9y
ZXBvcnQuYzozNzggW2lubGluZV0KIHByaW50X3JlcG9ydCsweDE2OS8weDU1MCBtbS9rYXNh
bi9yZXBvcnQuYzo0ODkKIGthc2FuX3JlcG9ydCsweDE0My8weDE4MCBtbS9rYXNhbi9yZXBv
cnQuYzo2MDIKIF9fbG9ja19hY3F1aXJlKzB4NzgvMHgyMTAwIGtlcm5lbC9sb2NraW5nL2xv
Y2tkZXAuYzo1MDg5CiBsb2NrX2FjcXVpcmUrMHgxZWQvMHg1NTAga2VybmVsL2xvY2tpbmcv
bG9ja2RlcC5jOjU4NDkKIF9fcmF3X3NwaW5fbG9jayBpbmNsdWRlL2xpbnV4L3NwaW5sb2Nr
X2FwaV9zbXAuaDoxMzMgW2lubGluZV0KIF9yYXdfc3Bpbl9sb2NrKzB4MmUvMHg0MCBrZXJu
ZWwvbG9ja2luZy9zcGlubG9jay5jOjE1NAogc3Bpbl9sb2NrIGluY2x1ZGUvbGludXgvc3Bp
bmxvY2suaDozNTEgW2lubGluZV0KIG1vdmVfcGFnZXNfcHRlKzB4OGFhLzB4MzQwMCBtbS91
c2VyZmF1bHRmZC5jOjEyNDgKIG1vdmVfcGFnZXMrMHhlNzUvMHgxNmEwIG1tL3VzZXJmYXVs
dGZkLmM6MTc1NAogdXNlcmZhdWx0ZmRfbW92ZSBmcy91c2VyZmF1bHRmZC5jOjE4OTkgW2lu
bGluZV0KIHVzZXJmYXVsdGZkX2lvY3RsKzB4NTIyMS8weDY4NDAgZnMvdXNlcmZhdWx0ZmQu
YzoyMDIyCiB2ZnNfaW9jdGwgZnMvaW9jdGwuYzo1MSBbaW5saW5lXQogX19kb19zeXNfaW9j
dGwgZnMvaW9jdGwuYzo5MDYgW2lubGluZV0KIF9fc2Vfc3lzX2lvY3RsKzB4ZjUvMHgxNzAg
ZnMvaW9jdGwuYzo4OTIKIGRvX3N5c2NhbGxfeDY0IGFyY2gveDg2L2VudHJ5L2NvbW1vbi5j
OjUyIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4ZjMvMHgyMzAgYXJjaC94ODYvZW50cnkv
Y29tbW9uLmM6ODMKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YK
UklQOiAwMDMzOjB4N2ZlZDhkZTg1YWY5CkNvZGU6IDI4IDAwIDAwIDAwIDc1IDA1IDQ4IDgz
IGM0IDI4IGMzIGU4IGUxIDE4IDAwIDAwIDkwIDQ4IDg5IGY4IDQ4IDg5IGY3IDQ4IDg5IGQ2
IDQ4IDg5IGNhIDRkIDg5IGMyIDRkIDg5IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1IDw0OD4g
M2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggYzcgYzEgYjAgZmYgZmYgZmYgZjcgZDggNjQg
ODkgMDEgNDgKUlNQOiAwMDJiOjAwMDA3ZmVkOGRlNDAyMzggRUZMQUdTOiAwMDAwMDI0NiBP
UklHX1JBWDogMDAwMDAwMDAwMDAwMDAxMApSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAw
MDAwN2ZlZDhkZjEwMzI4IFJDWDogMDAwMDdmZWQ4ZGU4NWFmOQpSRFg6IDAwMDAwMDAwMjAw
MDAwODAgUlNJOiAwMDAwMDAwMGMwMjhhYTA1IFJESTogMDAwMDAwMDAwMDAwMDAwMwpSQlA6
IDAwMDA3ZmVkOGRmMTAzMjAgUjA4OiAwMDAwN2ZlZDhkZTQwNmMwIFIwOTogMDAwMDdmZWQ4
ZGU0MDZjMApSMTA6IDAwMDA3ZmVkOGRlNDA2YzAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIx
MjogMDAwMDdmZWQ4ZGVkZDMzNApSMTM6IDAwMDAwMDAwMDAwMDAwMTAgUjE0OiAwMDAwN2Zm
YzI0MTI0MWUwIFIxNTogMDAwMDdmZmMyNDEyNDJjOAogPC9UQVNLPgoKQWxsb2NhdGVkIGJ5
IHRhc2sgNjA3MDoKIGthc2FuX3NhdmVfc3RhY2sgbW0va2FzYW4vY29tbW9uLmM6NDcgW2lu
bGluZV0KIGthc2FuX3NhdmVfdHJhY2srMHgzZi8weDgwIG1tL2thc2FuL2NvbW1vbi5jOjY4
CiB1bnBvaXNvbl9zbGFiX29iamVjdCBtbS9rYXNhbi9jb21tb24uYzozMTkgW2lubGluZV0K
IF9fa2FzYW5fc2xhYl9hbGxvYysweDY2LzB4ODAgbW0va2FzYW4vY29tbW9uLmM6MzQ1CiBr
YXNhbl9zbGFiX2FsbG9jIGluY2x1ZGUvbGludXgva2FzYW4uaDoyNTAgW2lubGluZV0KIHNs
YWJfcG9zdF9hbGxvY19ob29rIG1tL3NsdWIuYzo0MTA0IFtpbmxpbmVdCiBzbGFiX2FsbG9j
X25vZGUgbW0vc2x1Yi5jOjQxNTMgW2lubGluZV0KIGttZW1fY2FjaGVfYWxsb2Nfbm9wcm9m
KzB4MWQ5LzB4MzgwIG1tL3NsdWIuYzo0MTYwCiBwdGxvY2tfYWxsb2MrMHgyMC8weDcwIG1t
L21lbW9yeS5jOjcwMjYKIHB0bG9ja19pbml0IGluY2x1ZGUvbGludXgvbW0uaDoyOTcxIFtp
bmxpbmVdCiBwYWdldGFibGVfcHRlX2N0b3IgaW5jbHVkZS9saW51eC9tbS5oOjI5OTggW2lu
bGluZV0KIF9fcHRlX2FsbG9jX29uZV9ub3Byb2YgaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ2Fs
bG9jLmg6NzMgW2lubGluZV0KIHB0ZV9hbGxvY19vbmUrMHhkMy8weDUxMCBhcmNoL3g4Ni9t
bS9wZ3RhYmxlLmM6NDEKIF9fZG9faHVnZV9wbWRfYW5vbnltb3VzX3BhZ2UgbW0vaHVnZV9t
ZW1vcnkuYzoxMjI5IFtpbmxpbmVdCiBkb19odWdlX3BtZF9hbm9ueW1vdXNfcGFnZSsweDJm
Yi8weGIzMCBtbS9odWdlX21lbW9yeS5jOjEzNzQKIGNyZWF0ZV9odWdlX3BtZCBtbS9tZW1v
cnkuYzo1NzM3IFtpbmxpbmVdCiBfX2hhbmRsZV9tbV9mYXVsdCBtbS9tZW1vcnkuYzo1OTg2
IFtpbmxpbmVdCiBoYW5kbGVfbW1fZmF1bHQrMHgxNWE3LzB4MWJiMCBtbS9tZW1vcnkuYzo2
MTgzCiBkb191c2VyX2FkZHJfZmF1bHQgYXJjaC94ODYvbW0vZmF1bHQuYzoxMzM4IFtpbmxp
bmVdCiBoYW5kbGVfcGFnZV9mYXVsdCBhcmNoL3g4Ni9tbS9mYXVsdC5jOjE0ODEgW2lubGlu
ZV0KIGV4Y19wYWdlX2ZhdWx0KzB4NDU5LzB4OGIwIGFyY2gveDg2L21tL2ZhdWx0LmM6MTUz
OQogYXNtX2V4Y19wYWdlX2ZhdWx0KzB4MjYvMHgzMCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9p
ZHRlbnRyeS5oOjYyMwoKRnJlZWQgYnkgdGFzayA2MDcxOgoga2FzYW5fc2F2ZV9zdGFjayBt
bS9rYXNhbi9jb21tb24uYzo0NyBbaW5saW5lXQoga2FzYW5fc2F2ZV90cmFjaysweDNmLzB4
ODAgbW0va2FzYW4vY29tbW9uLmM6NjgKIGthc2FuX3NhdmVfZnJlZV9pbmZvKzB4NDAvMHg1
MCBtbS9rYXNhbi9nZW5lcmljLmM6NTc2CiBwb2lzb25fc2xhYl9vYmplY3QgbW0va2FzYW4v
Y29tbW9uLmM6MjQ3IFtpbmxpbmVdCiBfX2thc2FuX3NsYWJfZnJlZSsweDU5LzB4NzAgbW0v
a2FzYW4vY29tbW9uLmM6MjY0CiBrYXNhbl9zbGFiX2ZyZWUgaW5jbHVkZS9saW51eC9rYXNh
bi5oOjIzMyBbaW5saW5lXQogc2xhYl9mcmVlX2hvb2sgbW0vc2x1Yi5jOjIzMzggW2lubGlu
ZV0KIHNsYWJfZnJlZSBtbS9zbHViLmM6NDU5OCBbaW5saW5lXQoga21lbV9jYWNoZV9mcmVl
KzB4MTk1LzB4NDEwIG1tL3NsdWIuYzo0NzAwCiBwYWdldGFibGVfcHRlX2R0b3IgaW5jbHVk
ZS9saW51eC9tbS5oOjMwMDkgW2lubGluZV0KIF9fX3B0ZV9mcmVlX3RsYisweDJiLzB4MTQw
IGFyY2gveDg2L21tL3BndGFibGUuYzo2MwogX19wdGVfZnJlZV90bGIgYXJjaC94ODYvaW5j
bHVkZS9hc20vcGdhbGxvYy5oOjYxIFtpbmxpbmVdCiBmcmVlX3B0ZSsweDE0Mi8weDE5MCBt
bS9wdF9yZWNsYWltLmM6MzEKIHphcF9wdGVfcmFuZ2UgbW0vbWVtb3J5LmM6MTc4MCBbaW5s
aW5lXQogemFwX3BtZF9yYW5nZSBtbS9tZW1vcnkuYzoxODIyIFtpbmxpbmVdCiB6YXBfcHVk
X3JhbmdlIG1tL21lbW9yeS5jOjE4NTEgW2lubGluZV0KIHphcF9wNGRfcmFuZ2UgbW0vbWVt
b3J5LmM6MTg3MiBbaW5saW5lXQogdW5tYXBfcGFnZV9yYW5nZSsweDQwNjIvMHg0OGQwIG1t
L21lbW9yeS5jOjE4OTMKIHphcF9wYWdlX3JhbmdlX3NpbmdsZSsweDQ1Yy8weDYzMCBtbS9t
ZW1vcnkuYzoyMDE4CiBtYWR2aXNlX2RvbnRuZWVkX3NpbmdsZV92bWEgbW0vbWFkdmlzZS5j
Ojg1OSBbaW5saW5lXQogbWFkdmlzZV9kb250bmVlZF9mcmVlIG1tL21hZHZpc2UuYzo5NDAg
W2lubGluZV0KIG1hZHZpc2Vfdm1hX2JlaGF2aW9yIG1tL21hZHZpc2UuYzoxMjcwIFtpbmxp
bmVdCiBtYWR2aXNlX3dhbGtfdm1hcyBtbS9tYWR2aXNlLmM6MTUwMiBbaW5saW5lXQogZG9f
bWFkdmlzZSsweDI3NzQvMHg0ZDkwIG1tL21hZHZpc2UuYzoxNjg5CiBfX2RvX3N5c19tYWR2
aXNlIG1tL21hZHZpc2UuYzoxNzA1IFtpbmxpbmVdCiBfX3NlX3N5c19tYWR2aXNlIG1tL21h
ZHZpc2UuYzoxNzAzIFtpbmxpbmVdCiBfX3g2NF9zeXNfbWFkdmlzZSsweGE2LzB4YzAgbW0v
bWFkdmlzZS5jOjE3MDMKIGRvX3N5c2NhbGxfeDY0IGFyY2gveDg2L2VudHJ5L2NvbW1vbi5j
OjUyIFtpbmxpbmVdCiBkb19zeXNjYWxsXzY0KzB4ZjMvMHgyMzAgYXJjaC94ODYvZW50cnkv
Y29tbW9uLmM6ODMKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YK
ClRvIGZpeCBpdCwgZnJlZSBwdGRlc2MtPnB0bCBieSBSQ1UuCgpSZXBvcnRlZC1ieTogc3l6
Ym90KzFjNThhZmVkMWNmZDJmNTdlZmVlQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KU2ln
bmVkLW9mZi1ieTogUWkgWmhlbmcgPHpoZW5ncWkuYXJjaEBieXRlZGFuY2UuY29tPgotLS0K
IGluY2x1ZGUvbGludXgvbW0uaCAgICAgICB8ICAyICstCiBpbmNsdWRlL2xpbnV4L21tX3R5
cGVzLmggfCAgOSArKysrKysrKy0KIG1tL21lbW9yeS5jICAgICAgICAgICAgICB8IDIyICsr
KysrKysrKysrKysrKystLS0tLS0KIG1tL3VzZXJmYXVsdGZkLmMgICAgICAgICB8ICA0ICsr
LS0KIDQgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5o
CmluZGV4IDk1YmZhZjViODVkOTAuLmI1MzI0MTVlZjU4NDEgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvbW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L21tLmgKQEAgLTI5ODgsNyArMjk4
OCw3IEBAIHZvaWQgcHRsb2NrX2ZyZWUoc3RydWN0IHB0ZGVzYyAqcHRkZXNjKTsKIAogc3Rh
dGljIGlubGluZSBzcGlubG9ja190ICpwdGxvY2tfcHRyKHN0cnVjdCBwdGRlc2MgKnB0ZGVz
YykKIHsKLQlyZXR1cm4gcHRkZXNjLT5wdGw7CisJcmV0dXJuICYocHRkZXNjLT5wdGwtPnB0
bCk7CiB9CiAjZWxzZSAvKiBBTExPQ19TUExJVF9QVExPQ0tTICovCiBzdGF0aWMgaW5saW5l
IHZvaWQgcHRsb2NrX2NhY2hlX2luaXQodm9pZCkKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbW1fdHlwZXMuaCBiL2luY2x1ZGUvbGludXgvbW1fdHlwZXMuaAppbmRleCBkMGU3MjBj
Y2VjZDcxLi43Yjk0ZWE0ZDBkMjZhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21tX3R5
cGVzLmgKKysrIGIvaW5jbHVkZS9saW51eC9tbV90eXBlcy5oCkBAIC00MzQsNiArNDM0LDEz
IEBAIEZPTElPX01BVENIKGZsYWdzLCBfZmxhZ3NfMmEpOwogRk9MSU9fTUFUQ0goY29tcG91
bmRfaGVhZCwgX2hlYWRfMmEpOwogI3VuZGVmIEZPTElPX01BVENICiAKKyNpZiBBTExPQ19T
UExJVF9QVExPQ0tTCitzdHJ1Y3QgcHRfbG9jayB7CisJc3BpbmxvY2tfdCBwdGw7CisJc3Ry
dWN0IHJjdV9oZWFkIHJjdTsKK307CisjZW5kaWYKKwogLyoqCiAgKiBzdHJ1Y3QgcHRkZXNj
IC0gICAgTWVtb3J5IGRlc2NyaXB0b3IgZm9yIHBhZ2UgdGFibGVzLgogICogQF9fcGFnZV9m
bGFnczogICAgIFNhbWUgYXMgcGFnZSBmbGFncy4gUG93ZXJwYyBvbmx5LgpAQCAtNDc4LDcg
KzQ4NSw3IEBAIHN0cnVjdCBwdGRlc2MgewogCXVuaW9uIHsKIAkJdW5zaWduZWQgbG9uZyBf
cHRfcGFkXzI7CiAjaWYgQUxMT0NfU1BMSVRfUFRMT0NLUwotCQlzcGlubG9ja190ICpwdGw7
CisJCXN0cnVjdCBwdF9sb2NrICpwdGw7CiAjZWxzZQogCQlzcGlubG9ja190IHB0bDsKICNl
bmRpZgpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1vcnkuYwppbmRleCA4M2Zk
MzVjMDM0ZDdhLi44MDJkYWUwNjAyYjMyIDEwMDY0NAotLS0gYS9tbS9tZW1vcnkuYworKysg
Yi9tbS9tZW1vcnkuYwpAQCAtNzAyMiwyNCArNzAyMiwzNCBAQCBzdGF0aWMgc3RydWN0IGtt
ZW1fY2FjaGUgKnBhZ2VfcHRsX2NhY2hlcDsKIAogdm9pZCBfX2luaXQgcHRsb2NrX2NhY2hl
X2luaXQodm9pZCkKIHsKLQlwYWdlX3B0bF9jYWNoZXAgPSBrbWVtX2NhY2hlX2NyZWF0ZSgi
cGFnZS0+cHRsIiwgc2l6ZW9mKHNwaW5sb2NrX3QpLCAwLAorCXBhZ2VfcHRsX2NhY2hlcCA9
IGttZW1fY2FjaGVfY3JlYXRlKCJwYWdlLT5wdGwiLCBzaXplb2Yoc3RydWN0IHB0X2xvY2sp
LCAwLAogCQkJU0xBQl9QQU5JQywgTlVMTCk7CiB9CiAKIGJvb2wgcHRsb2NrX2FsbG9jKHN0
cnVjdCBwdGRlc2MgKnB0ZGVzYykKIHsKLQlzcGlubG9ja190ICpwdGw7CisJc3RydWN0IHB0
X2xvY2sgKnB0X2xvY2s7CiAKLQlwdGwgPSBrbWVtX2NhY2hlX2FsbG9jKHBhZ2VfcHRsX2Nh
Y2hlcCwgR0ZQX0tFUk5FTCk7Ci0JaWYgKCFwdGwpCisJcHRfbG9jayA9IGttZW1fY2FjaGVf
YWxsb2MocGFnZV9wdGxfY2FjaGVwLCBHRlBfS0VSTkVMKTsKKwlpZiAoIXB0X2xvY2spCiAJ
CXJldHVybiBmYWxzZTsKLQlwdGRlc2MtPnB0bCA9IHB0bDsKKwlwdGRlc2MtPnB0bCA9IHB0
X2xvY2s7CiAJcmV0dXJuIHRydWU7CiB9CiAKK3N0YXRpYyB2b2lkIHB0bG9ja19mcmVlX3Jj
dShzdHJ1Y3QgcmN1X2hlYWQgKmhlYWQpCit7CisJc3RydWN0IHB0X2xvY2sgKnB0X2xvY2s7
CisKKwlwdF9sb2NrID0gY29udGFpbmVyX29mKGhlYWQsIHN0cnVjdCBwdF9sb2NrLCByY3Up
OworCWttZW1fY2FjaGVfZnJlZShwYWdlX3B0bF9jYWNoZXAsIHB0X2xvY2spOworfQorCiB2
b2lkIHB0bG9ja19mcmVlKHN0cnVjdCBwdGRlc2MgKnB0ZGVzYykKIHsKLQlrbWVtX2NhY2hl
X2ZyZWUocGFnZV9wdGxfY2FjaGVwLCBwdGRlc2MtPnB0bCk7CisJc3RydWN0IHB0X2xvY2sg
KnB0X2xvY2sgPSBwdGRlc2MtPnB0bDsKKworCWNhbGxfcmN1KCZwdF9sb2NrLT5yY3UsIHB0
bG9ja19mcmVlX3JjdSk7CiB9CiAjZW5kaWYKIApkaWZmIC0tZ2l0IGEvbW0vdXNlcmZhdWx0
ZmQuYyBiL21tL3VzZXJmYXVsdGZkLmMKaW5kZXggYmM5YTY2ZWM2YTZlNC4uNDUyN2MzODU5
MzViZSAxMDA2NDQKLS0tIGEvbW0vdXNlcmZhdWx0ZmQuYworKysgYi9tbS91c2VyZmF1bHRm
ZC5jCkBAIC0xMTg1LDggKzExODUsOCBAQCBzdGF0aWMgaW50IG1vdmVfcGFnZXNfcHRlKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tLCBwbWRfdCAqZHN0X3BtZCwgcG1kX3QgKnNyY19wbWQsCiAJ
fQogCiAJLyogU2FuaXR5IGNoZWNrcyBiZWZvcmUgdGhlIG9wZXJhdGlvbiAqLwotCWlmIChX
QVJOX09OX09OQ0UocG1kX25vbmUoKmRzdF9wbWQpKSB8fAlXQVJOX09OX09OQ0UocG1kX25v
bmUoKnNyY19wbWQpKSB8fAotCSAgICBXQVJOX09OX09OQ0UocG1kX3RyYW5zX2h1Z2UoKmRz
dF9wbWQpKSB8fCBXQVJOX09OX09OQ0UocG1kX3RyYW5zX2h1Z2UoKnNyY19wbWQpKSkgewor
CWlmIChwbWRfbm9uZSgqZHN0X3BtZCkgfHwgcG1kX25vbmUoKnNyY19wbWQpIHx8CisJICAg
IHBtZF90cmFuc19odWdlKCpkc3RfcG1kKSB8fCBwbWRfdHJhbnNfaHVnZSgqc3JjX3BtZCkp
IHsKIAkJZXJyID0gLUVJTlZBTDsKIAkJZ290byBvdXQ7CiAJfQotLSAKMi4yMC4xCgo=

--------------nq0wyn5xAAw890Pk0QpWVj9G--

