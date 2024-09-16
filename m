Return-Path: <linux-kernel+bounces-330104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A999799C7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F296B283A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152A947A;
	Mon, 16 Sep 2024 01:24:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE328FD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726449867; cv=none; b=Q7Y5Fu0HqW7eSNyLKMkSuUoq085RU5RATIn6I4CU6phvUakHQ9eiYp5h/vUSHWYi43VO+xTafRVUZrXGkNWJYmKKsF7+x0ggIFF+/AGqgf991N6jeyh8jiM4iVEji5odN2i0R52vIVmgJ4ooav3Om/AYUFZUF7kA9YDvI57Kw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726449867; c=relaxed/simple;
	bh=HMcTlkxRiNmJ9vl1vyU++C0a9NxzpTKKt+IC25EwReA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IxIhxQVOMzOW7Z7KnsyE0Wm1N5IorWkrziFGE9miRPtbR8o2r2TlXJcUKO2eqc5Y13XbOUBBCtgWK2LRq0V6bX9dqQHm5ggXFFdd4fEi6g7N2x91idjAttfwfWiqlLZWaK1HRu7+E4icSG5rQ9fjI/87LDWH/yue65ePMXM7MNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ced069d94so931824539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726449865; x=1727054665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGWQzV5Vm4a1RYkO1X9dZLApElpq2f+UThBNZEBb32U=;
        b=kfnl2SxmrWpLW+Yqm+UHS88j1aiHZ9IFPmntQmORRLpsycstRuodLwQ2be4YG9HDQt
         XJazqh+tIZWGqUfQL+TeOrdB/xxGOu8RWJ8ztMSKrsVCX4O1ItPH9Fna+/Oa9UehpmzE
         MSsgGSEqVwedMy0M94Vdp+S3r2fS7dEHGmlbVH/y9AwfmXLzOQbunZXp1pKcsxQODtiI
         zYEcFPCaM0oMa5LNhvufIlKL1uK5nLsOJFdpK1btMTYhJSPJn5RE+qqitqNszLFBzYJ/
         UG38curiC+Ky2nvYq7Ltbo1hS8IkKbyJ9MqerMk4VrQUpJkB2+p1Fj+yQAum8xPRSS5Y
         7xDw==
X-Forwarded-Encrypted: i=1; AJvYcCWgyD1EHWi0QfOtMX0Hm77w45Yfg9ayhwuowDjw7NenfLVN3fJGYy57VA+B4g0ujljnzeW6EiaPSC2kbA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuTrIjvz0a/lHRP+UX7m3zGPouOOhLHyTbZofxm0V+udgWmLcY
	Idpep2VkW/18740nYUAm6bRCSCqI5k/NUirIwAZFWMWhVUqTLC17xEkZDFTkXq6p+TAOEwBl2JE
	e/HLUB0UKfiXOviuYWw65PxcGLHKkFvjtChyCnyiqQ/PFthnheOyWwbw=
X-Google-Smtp-Source: AGHT+IF3wpvEd8oH6J2Q/IwNxAKo4ctYzlkrN7IFPFVB3z2tPpXBoRRzhEg+U/qM896HTNMFyuckhCuhHJAfEJrmQaOQcF/PhhRJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:9013:83f0 with SMTP id
 e9e14a558f8ab-3a09013878amr67672095ab.3.1726449864677; Sun, 15 Sep 2024
 18:24:24 -0700 (PDT)
Date: Sun, 15 Sep 2024 18:24:24 -0700
In-Reply-To: <0000000000003c68f3061fd2c285@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e82e420622326e3f@google.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in dev_free
From: syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID cons..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10a96200580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
dashboard link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1297cc07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1217c8a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c69290425359/disk-68d42091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4f26a3e85/vmlinux-68d42091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3acdec4b62e6/bzImage-68d42091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
Free of addr ffff8881066f9240 by task syz-executor254/3953

CPU: 1 UID: 0 PID: 3953 Comm: syz-executor254 Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 poison_slab_object+0x135/0x160 mm/kasan/common.c:232
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x10b/0x380 mm/slub.c:4598
 dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x16e/0x2c0 drivers/usb/gadget/legacy/raw_gadget.c:473
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2b30 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffa254cedf9
Code: Unable to access opcode bytes at 0x7ffa254cedcf.
RSP: 002b:00007fffc9f7d918 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffa254cedf9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007ffa255583b0 R08: ffffffffffffffb0 R09: 00007fffc9f7d9a0
R10: 00007fffc9f7d9a0 R11: 0000000000000246 R12: 00007ffa255583b0
R13: 0000000000000000 R14: 00007ffa2555c1e0 R15: 00007ffa25499680
 </TASK>

Allocated by task 3955:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4162 [inline]
 __kmalloc_node_track_caller_noprof+0x1ff/0x3e0 mm/slub.c:4181
 memdup_user+0x2a/0xd0 mm/util.c:226
 raw_ioctl_ep_enable drivers/usb/gadget/legacy/raw_gadget.c:847 [inline]
 raw_ioctl+0xbca/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1318
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 3954:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x10b/0x380 mm/slub.c:4598
 dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x16e/0x2c0 drivers/usb/gadget/legacy/raw_gadget.c:473
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8881066f9240
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 16-byte region [ffff8881066f9240, ffff8881066f9250)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1066f9
anon flags: 0x200000000000000(node=0|zone=2)
page_type: 0xfdffffff(slab)
raw: 0200000000000000 ffff888100041640 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000800080 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 4772382410, free_ts 0
 create_dummy_stack mm/page_owner.c:94 [inline]
 register_dummy_stack+0x8a/0xd0 mm/page_owner.c:100
 init_page_owner+0x48/0xbe0 mm/page_owner.c:118
 invoke_init_callbacks mm/page_ext.c:148 [inline]
 page_ext_init+0x725/0xbf0 mm/page_ext.c:497
 mm_core_init+0x202/0x240 mm/mm_init.c:2673
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881066f9100: 00 05 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 ffff8881066f9180: 00 00 fc fc 00 00 fc fc 00 00 fc fc fa fb fc fc
>ffff8881066f9200: 00 00 fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
                                           ^
 ffff8881066f9280: 00 00 fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff8881066f9300: 00 00 fc fc 00 05 fc fc fa fb fc fc 00 00 fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

