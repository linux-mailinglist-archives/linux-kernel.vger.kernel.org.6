Return-Path: <linux-kernel+bounces-259893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7230939F01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820C3281F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4114F108;
	Tue, 23 Jul 2024 10:52:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716A3D6A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731924; cv=none; b=YpjyEc2QV7WjwRjmbTOdzkOjrXkxbrsApvu0f04tBXHOb52NiPjxV3cajMWSeI51KQ99H7MAcLrWP5YXsAdH1m0AI3aSP3o2/d0u+C5Kf1gLSgCYsVQi/o18x42ypXy7IP083EXGH/WoznVNfavXmhy4cLzM6VH51F8sLn7gbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731924; c=relaxed/simple;
	bh=rP8iciVyS5sB2RFcmdkmQihf9EAX7SFZByF253sfXng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B66ICUqIXQ4oRTHnkp29zNcz0hTjN2C0G3eI9sx118ObKYrv4gP874EjwLHyN7iDm8ujRGzdy5h4630Sog9AoLr+cpxA/shb+rLC2SzaBmPWYWP71BcQI+LXDw0iBPUlAB8aE0G26zkbnvPCUZbJXkJpcGwSeJjlC+dwJRkmw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3962d4671c7so87328225ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721731922; x=1722336722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VquS13cvl3kn4DVHUuxTpNinmQwV5wMYpQd+R5DPaeo=;
        b=C7h/RvzyT6vgVfx52ILA6PMLJc+q1glave0P9xj6P/6Yqp6msjxNZQY9UfBQMlGzeo
         FNNSeaZCdttHlefPhFqwOWmTOKVTNL/R599VkjXWpJt14A65fkn5FvYLhNebuIvpUm+D
         e4BsDKp24q01iRlkLhBaM44UPpEdTUyzf3WldqfukdWGIARbfKkTuXhNpB86InMZyEoo
         UlsXGzwhAOKn8zEhlDiBu3fw8SqnQxBSxmitFHBTcC8LBTSAuK7qaN5OMSvI78VM7EOj
         x/Dg39wKHZRmluUIsygU6YPVxTKr4KqxXaicP9qV066RWGvt5VyIsZ1X+Mapy9Vnvrop
         08HA==
X-Forwarded-Encrypted: i=1; AJvYcCUKrOSyuXQd0GqijwzrEUuqZXu7bvk1KMKuOaLDWaiqcoR3pFsv/WDT/Fr+DuA4Z+FEbEU7m7rr//GTCZZr1yAOnQjM2t1iS9w9vMbC
X-Gm-Message-State: AOJu0YzWdBk0ld5cFPHhl3mKE8+kxPt/JrC2o9lfgWUAgOKIj6MeZttH
	gO49IqeKFxe8FRSL0Hrl7mNmKD68XbmQyeGwivc5eRLYxs2obLFLA+bD0hpiWxZhbSHEWyUB9JC
	Dr2BSUx3k06iKku1KqADRFOWwTTat71NKEcRiMpaPfLDO7dLNrXvd5bQ=
X-Google-Smtp-Source: AGHT+IGlLQAUiiW/HRZomg4aJxndbfSLXLVMrZGUCUXkvTyYxDp6zBMOKeKHiVHHm4rTpJJzq8RlrQ5s8Qh0DK87U8LpSLyRKk+S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-398e19960demr6447875ab.0.1721731921748; Tue, 23 Jul 2024
 03:52:01 -0700 (PDT)
Date: Tue, 23 Jul 2024 03:52:01 -0700
In-Reply-To: <20240723103734.1909-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009835a7061de7f358@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
From: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad page map

BUG: Bad page cache in process syz.0.15  pfn:4b63a
page: refcount:4 mapcount:1 mapping:000000003ee7caca index:0x0 pfn:0x4b63a
memcg:f4f00000060ad000
aops:shmem_aops ino:401
flags: 0x1ffc0000004002d(locked|referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002d ffffc1ffc01a0988 ffffc1ffc01a2fc8 f1f00000070f2470
raw: 0000000000000000 0000000000000000 0000000400000000 f4f00000060ad000
page dumped because: still mapped when deleted
CPU: 1 PID: 3851 Comm: syz.0.15 Not tainted 6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 filemap_unaccount_folio+0x118/0x278 mm/filemap.c:167
 __filemap_remove_folio+0x3c/0x178 mm/filemap.c:231
 filemap_remove_folio+0x48/0xa8 mm/filemap.c:264
 truncate_inode_folio+0x30/0x4c mm/truncate.c:195
 shmem_undo_range+0x208/0x620 mm/shmem.c:1012
 shmem_truncate_range mm/shmem.c:1125 [inline]
 shmem_evict_inode+0x130/0x2dc mm/shmem.c:1253
 evict+0xb4/0x198 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput fs/inode.c:1767 [inline]
 iput+0x100/0x1b8 fs/inode.c:1753
 dentry_unlink_inode+0xc0/0x188 fs/dcache.c:404
 __dentry_kill+0x7c/0x1d4 fs/dcache.c:607
 dput.part.0+0x30/0xbc fs/dcache.c:849
 dput+0x4c/0x50 fs/dcache.c:860
 __fput+0x110/0x2d4 fs/file_table.c:430
 ____fput+0x10/0x1c fs/file_table.c:450
 task_work_run+0x78/0xd0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x134/0x164 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xc8/0xf8 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page cache in process syz.0.15  pfn:468bf
page: refcount:4 mapcount:1 mapping:000000003ee7caca index:0x1 pfn:0x468bf
memcg:f4f00000060ad000
aops:shmem_aops ino:401
flags: 0x1ffc0000004002d(locked|referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002d ffffc1ffc02d8e88 ffffc1ffc02d7448 f1f00000070f2470
raw: 0000000000000001 0000000000000000 0000000400000000 f4f00000060ad000
page dumped because: still mapped when deleted
CPU: 1 PID: 3851 Comm: syz.0.15 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 filemap_unaccount_folio+0x118/0x278 mm/filemap.c:167
 __filemap_remove_folio+0x3c/0x178 mm/filemap.c:231
 filemap_remove_folio+0x48/0xa8 mm/filemap.c:264
 truncate_inode_folio+0x30/0x4c mm/truncate.c:195
 shmem_undo_range+0x208/0x620 mm/shmem.c:1012
 shmem_truncate_range mm/shmem.c:1125 [inline]
 shmem_evict_inode+0x130/0x2dc mm/shmem.c:1253
 evict+0xb4/0x198 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput fs/inode.c:1767 [inline]
 iput+0x100/0x1b8 fs/inode.c:1753
 dentry_unlink_inode+0xc0/0x188 fs/dcache.c:404
 __dentry_kill+0x7c/0x1d4 fs/dcache.c:607
 dput.part.0+0x30/0xbc fs/dcache.c:849
 dput+0x4c/0x50 fs/dcache.c:860
 __fput+0x110/0x2d4 fs/file_table.c:430
 ____fput+0x10/0x1c fs/file_table.c:450
 task_work_run+0x78/0xd0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x134/0x164 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xc8/0xf8 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page map in process syz.0.15  pte:6000004b63a8c3 pmd:800000043b9a003
page: refcount:1 mapcount:-1 mapping:0000000000000000 index:0x0 pfn:0x4b63a
memcg:f4f00000060ad000
flags: 0x1ffc0000004002c(referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002c ffffc1ffc0325848 ffffc1ffc01a2fc8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001fffffffe f4f00000060ad000
page dumped because: bad pte
addr:00000000209a0000 vm_flags:400000f9 anon_vma:0000000000000000 mapping:fcf00000033edda8 index:0
file:dmabuf fault:udmabuf_vm_fault mmap:dma_buf_mmap_internal read_folio:0x0
CPU: 1 PID: 3851 Comm: syz.0.15 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 print_bad_pte+0x1c8/0x258 mm/memory.c:538
 zap_present_folio_ptes mm/memory.c:1508 [inline]
 zap_present_ptes mm/memory.c:1564 [inline]
 zap_pte_range mm/memory.c:1606 [inline]
 zap_pmd_range mm/memory.c:1724 [inline]
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0x904/0x1190 mm/memory.c:1795
 unmap_single_vma.constprop.0+0x4c/0x84 mm/memory.c:1841
 unmap_vmas+0x7c/0x170 mm/memory.c:1885
 exit_mmap+0xc0/0x288 mm/mmap.c:3341
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page map in process syz.0.15  pte:600000468bf8c3 pmd:800000043b9a003
page: refcount:1 mapcount:-1 mapping:0000000000000000 index:0x1 pfn:0x468bf
memcg:f4f00000060ad000
flags: 0x1ffc0000004002c(referenced|uptodate|lru|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004002c ffffc1ffc02d8e88 ffffc1ffc02d7448 0000000000000000
raw: 0000000000000001 0000000000000000 00000001fffffffe f4f00000060ad000
page dumped because: bad pte
addr:00000000209a1000 vm_flags:400000f9 anon_vma:0000000000000000 mapping:fcf00000033edda8 index:1
file:dmabuf fault:udmabuf_vm_fault mmap:dma_buf_mmap_internal read_folio:0x0
CPU: 1 PID: 3851 Comm: syz.0.15 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 print_bad_pte+0x1c8/0x258 mm/memory.c:538
 zap_present_folio_ptes mm/memory.c:1508 [inline]
 zap_present_ptes mm/memory.c:1564 [inline]
 zap_pte_range mm/memory.c:1606 [inline]
 zap_pmd_range mm/memory.c:1724 [inline]
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0x904/0x1190 mm/memory.c:1795
 unmap_single_vma.constprop.0+0x4c/0x84 mm/memory.c:1841
 unmap_vmas+0x7c/0x170 mm/memory.c:1885
 exit_mmap+0xc0/0x288 mm/mmap.c:3341
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page state in process syz.0.15  pfn:4b63a
page: refcount:0 mapcount:-1 mapping:0000000000000000 index:0x0 pfn:0x4b63a
flags: 0x1ffc0000004000c(referenced|uptodate|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004000c dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
page dumped because: nonzero mapcount
Modules linked in:
CPU: 1 PID: 3851 Comm: syz.0.15 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 bad_page+0x84/0x11c mm/page_alloc.c:498
 free_page_is_bad_report+0x98/0xa4 mm/page_alloc.c:904
 free_page_is_bad mm/page_alloc.c:914 [inline]
 free_pages_prepare mm/page_alloc.c:1085 [inline]
 free_unref_folios+0x4c0/0x624 mm/page_alloc.c:2637
 folios_put_refs+0x108/0x284 mm/swap.c:1024
 free_pages_and_swap_cache+0x14c/0x164 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0x4c/0xdc mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x54/0xe4 mm/mmu_gather.c:373
 zap_pte_range mm/memory.c:1685 [inline]
 zap_pmd_range mm/memory.c:1724 [inline]
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0xab0/0x1190 mm/memory.c:1795
 unmap_single_vma.constprop.0+0x4c/0x84 mm/memory.c:1841
 unmap_vmas+0x7c/0x170 mm/memory.c:1885
 exit_mmap+0xc0/0x288 mm/mmap.c:3341
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
BUG: Bad page state in process syz.0.15  pfn:468bf
page: refcount:0 mapcount:-1 mapping:0000000000000000 index:0x1 pfn:0x468bf
flags: 0x1ffc0000004000c(referenced|uptodate|swapbacked|node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
raw: 01ffc0000004000c dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000001 0000000000000000 00000000fffffffe 0000000000000000
page dumped because: nonzero mapcount
Modules linked in:
CPU: 1 PID: 3851 Comm: syz.0.15 Tainted: G    B              6.10.0-rc7-syzkaller-00266-g4d145e3f830b-dirty #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x94/0xec arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:114
 dump_stack+0x18/0x24 lib/dump_stack.c:123
 bad_page+0x84/0x11c mm/page_alloc.c:498
 free_page_is_bad_report+0x98/0xa4 mm/page_alloc.c:904
 free_page_is_bad mm/page_alloc.c:914 [inline]
 free_pages_prepare mm/page_alloc.c:1085 [inline]
 free_unref_folios+0x4c0/0x624 mm/page_alloc.c:2637
 folios_put_refs+0x108/0x284 mm/swap.c:1024
 free_pages_and_swap_cache+0x14c/0x164 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0x4c/0xdc mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x54/0xe4 mm/mmu_gather.c:373
 zap_pte_range mm/memory.c:1685 [inline]
 zap_pmd_range mm/memory.c:1724 [inline]
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0xab0/0x1190 mm/memory.c:1795
 unmap_single_vma.constprop.0+0x4c/0x84 mm/memory.c:1841
 unmap_vmas+0x7c/0x170 mm/memory.c:1885
 exit_mmap+0xc0/0x288 mm/mmap.c:3341
 __mmput+0x3c/0x170 kernel/fork.c:1346
 mmput+0x50/0x5c kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x270/0x98c kernel/exit.c:863
 do_group_exit+0x34/0x90 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 pid_child_should_wake+0x0/0x5c kernel/exit.c:1034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:150
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598


Tested on:

commit:         4d145e3f Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12ff8265980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b5a15443200e31
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160af2b1980000


