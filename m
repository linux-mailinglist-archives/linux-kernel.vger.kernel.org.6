Return-Path: <linux-kernel+bounces-396271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DE9BCA7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55D4283C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5E1D26F6;
	Tue,  5 Nov 2024 10:33:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B41632DD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802809; cv=none; b=YcHe1PN2zikD/Bb9eswWWWzTIuO5ttxTkLASrCGLWnSUoDFEi9KfEqhCLMi4Cy6EkDUNDIUC58e9Zzw46xXudvYkP0RjvgUXhb7RUaiI6aWDo239AJOKXTmThIU8vDdVmweoTmfK4ypwf8XaYpuq2nhdGAulqYeysACulSB4uXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802809; c=relaxed/simple;
	bh=vcd+8MKaNjr617nFfMj/CbuJ6Hv611apvau7lKEKT8A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bwxYrgMHgvqjL0f9y9V0SwwdGabP87yNw39qnwrnf1kdPqjdk9T6QHKXC/MsEKl1XFjpyEA8afBCe4lkx9Xx+8o/5+n4oAi+N4Jib8oXrKeRvWUsGo9uACni155Eg2RoXQJO3TBUYWJFJAv+mDdHRz7UgCaHlgBh2rxZ6KzO0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e80ccd1bso44632015ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802805; x=1731407605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ps4accwK8MFyZS7r31HFFEbLnDLlSD2Hu+txT1zlB+U=;
        b=EWd4m8JFZc4hSQ+SjcS1JpKt0T4oY0TaSr3aWkzB5XWDxUDMDC8yqw8zm5W4gIxSzY
         xZtMFqICpqsiRYjTmS+DpqG1kKR2g9R5hGJ4gR6ZQTZzGwW7NsVCwiX/m5gHiyeWo9Sf
         GV6t4R8wGh4Aibl8/NZZjCxb22I2cidLJ+D3qn6j9HLmVFXYvvdG6zmo9Y9BBjaFVVR9
         Bwrhj8R0FvVI5hz5HA3xODis0tzSJktgbcN9UMKmqbhqVQVfCzklnS0QrEYrWrFiqEdg
         Ixt/DyilzWmRgzdymo8twlMUGNDV19kOWg8rSFx0voItnGWD6Px2BsnJXRnJcN5NrkzT
         Jzpg==
X-Forwarded-Encrypted: i=1; AJvYcCWZermyZu0LmkBQbloIyUXP22i7fpJr0vFHX7mFk4jJRjda+EYM+O0hfWKQCtyhMvCPRmTnh2ZuGfpnp0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8rMtv1r2Tw+uD27knzGzfgF+rwz15uuRvffhkh1DzZr1oMxq
	H9jVMiA901YKEWBzexZ3Cc5icIJ/rHvIevPBtqsAS6ZjSXj+GeHrHl1JUCdnoGSILYM8HLZhsR+
	MZHd9ZC634ZlnQI3T5lg4nn6jY525ptElW2/R6+wlYnLB8UCsc55hFsQ=
X-Google-Smtp-Source: AGHT+IHW1uJPuhL0bulrnJa0+OmryR5+l4xo8SvYAX5TKiDHcUk+kZekmVk8dShkvTIbWeT5WfrOCmsxpZk91o73QgxMZAyVWFlB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c009:0:b0:3a6:ca09:6d3c with SMTP id
 e9e14a558f8ab-3a6ca0970e1mr58918205ab.23.1730802805428; Tue, 05 Nov 2024
 02:33:25 -0800 (PST)
Date: Tue, 05 Nov 2024 02:33:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729f475.050a0220.701a.0019.GAE@google.com>
Subject: [syzbot] [mm?] BUG: Bad page state in kvm_coalesced_mmio_init
From: syzbot <syzbot+e985d3026c4fd041578e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59b723cd2adb Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17996587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=e985d3026c4fd041578e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/202d791be971/disk-59b723cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9bfa02908d87/vmlinux-59b723cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93c8c8740b4d/bzImage-59b723cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e985d3026c4fd041578e@syzkaller.appspotmail.com

BUG: Bad page state in process syz.5.504  pfn:61f45
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61f45
flags: 0xfff00000080204(referenced|workingset|mlocked|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000080204 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 8443, tgid 8442 (syz.5.504), ts 201884660643, free_ts 201499827394
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
 kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
 kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5488 [inline]
 kvm_dev_ioctl+0x12dc/0x2240 virt/kvm/kvm_main.c:5530
 __do_compat_sys_ioctl fs/ioctl.c:1007 [inline]
 __se_compat_sys_ioctl+0x510/0xc90 fs/ioctl.c:950
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
page last free pid 8399 tgid 8399 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc40 mm/mmap.c:1926
 __mmput+0x115/0x390 kernel/fork.c:1348
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 8442 Comm: syz.5.504 Not tainted 6.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
 kvm_destroy_vm virt/kvm/kvm_main.c:1327 [inline]
 kvm_put_kvm+0xc75/0x1350 virt/kvm/kvm_main.c:1386
 kvm_vcpu_release+0x54/0x60 virt/kvm/kvm_main.c:4143
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __ia32_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 ia32_sys_call+0x2624/0x2630 arch/x86/include/generated/asm/syscalls_32.h:253
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf745d579
Code: Unable to access opcode bytes at 0xf745d54f.
RSP: 002b:00000000f75afd6c EFLAGS: 00000206 ORIG_RAX: 00000000000000fc
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000ffffff9c RDI: 00000000f744cff4
RBP: 00000000f717ae61 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

