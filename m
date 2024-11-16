Return-Path: <linux-kernel+bounces-411803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1289CFFC8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636E02884DF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D1183CCA;
	Sat, 16 Nov 2024 16:09:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA269D31
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773373; cv=none; b=LZNHhAjaH+jdqjejQLU3M73QJBWrtpzABJOuVS0On9+rDRc5Nv1F3TxCP/WcREiq0Z/eB0HR5cTND7XEZnVPgAVo33ApzrvNuUfuVCEaSSO1qIHudtgCmrdhqKc53/DeCJb/BfaHjC2Jnh9Oqq7I0/4362tFrQapZWVPF8ixJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773373; c=relaxed/simple;
	bh=tnBh3VlEBeT0ij8BsSW/LVAHLyPWZzYjLtDAP669CNU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZqELXCFJ362R6BIdKYwqVJWBPTh3OjH72CAejJjHgUCF8SoPXCJN+xTNQClUzUGSGroqTKhridAzaSQyF4Kudp2MtiVC9xTDrS90CPbPNLM9z1qSmaUg/tZH8h6PJxdOz261ffkSFyk1ZgxdUVmIV61bfPpIVDcBx0OFdTwZLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a760b00c86so923185ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731773371; x=1732378171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=961AfgVSCpqKg4yIam3zRM6MVE/rjEtbGlNdMPl7RXI=;
        b=fCD4hn+UL/dItcrzHcNZHvDRpVkNbC+dielIRgG4wZAEVTUkBs0tDgSTWpin+pBpNO
         x/lueJaYKNkNP1MhS/WEfJmhAnp/xgVe0gC1BFsXGtXsFFn8s0UbWhH/+xlamev1YXgP
         66grOXX7enFwfL3tB/zGcxcsQU3UBgMGLE7/yO0Kzc8H/3QrKounCfq15naB/Vkhl5Rs
         zW35HatOv9a96bMkeQJwhdSWBxq9oa84RiR/vCDp8BqzfKSwHb8Ce7Utl+31srr8ToNi
         JM3QyHZ01fPAjG+8LR9GCxUqnGktMoAIPRkbjH5RKTV3IiNLlZHLKsjDXpEnAuUSCORV
         dQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5yxBWGofzNl10rbf3sQA1y9KVBVyUe+xY+YUpL/bjT3C5pET39MsewRvVGoMWXvGJU0oWh25IHoFa2Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFNEiXfydtg2IXrIJqhdjmrd9ApQdsV2d02H80+e/vl1hPmgM
	UxFZPkJ3PoAvlmKwIYmJ6eBsTH1/8CvPTM1B8dNdY9N2dlfRWBJnkm+XNbI0gy+nXXQEBXBndbS
	xYRgCr0gZhhO9a70QzVofJft9j6Tgftv8beE4TSlTZS/S2tB6S/WKWmI=
X-Google-Smtp-Source: AGHT+IHxS2CeXL5l/Tfn73uJ3MCRzTvda8qoW3IQ6NKbzCY/ZWPdUtnRDAeDRx2eI2OEuqS4wp94jhaCmsvtZA8gX3q7HsojNyyD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca05:0:b0:3a6:c493:7395 with SMTP id
 e9e14a558f8ab-3a747ff8a50mr65767375ab.5.1731773370862; Sat, 16 Nov 2024
 08:09:30 -0800 (PST)
Date: Sat, 16 Nov 2024 08:09:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6738c3ba.050a0220.bb738.000d.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in get_random_u8
From: syzbot <syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14cb0ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4f9a43a9c78eaee04f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-rc6-next-20241108-syzkaller #0 Not tainted
-----------------------------
syz.4.319/7686 is trying to lock:
ffff8880b873a970 (batched_entropy_u8.lock){..-.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b873a970 (batched_entropy_u8.lock){..-.}-{3:3}, at: get_random_u8+0x1a0/0xaa0 drivers/char/random.c:551
other info that might help us debug this:
context-{2:2}
no locks held by syz.4.319/7686.
stack backtrace:
CPU: 1 UID: 0 PID: 7686 Comm: syz.4.319 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 get_random_u8+0x1bd/0xaa0 drivers/char/random.c:551
 get_random_u32_below include/linux/random.h:78 [inline]
 kfence_guarded_alloc+0x9c/0xcd0 mm/kfence/core.c:421
 __kfence_alloc+0x344/0x370 mm/kfence/core.c:1136
 kfence_alloc include/linux/kfence.h:129 [inline]
 slab_alloc_node mm/slub.c:4137 [inline]
 __kmalloc_cache_noprof+0x2dd/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 add_stack_record_to_list mm/page_owner.c:172 [inline]
 inc_stack_record_count mm/page_owner.c:214 [inline]
 __set_page_owner+0x55f/0x800 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3510
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4786
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
 kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 task_work_add+0xd9/0x490 kernel/task_work.c:77
 __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1223 [inline]
 run_posix_cpu_timers+0x6ac/0x810 kernel/time/posix-cpu-timers.c:1422
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x551/0xd50 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 ee 14 43 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 43 99 a6 f5 65 8b 05 64 f3 3c 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc900032efc60 EFLAGS: 00000206
RAX: 92c7e75658265800 RBX: 1ffff9200065df90 RCX: ffffffff9a3bf903
RDX: dffffc0000000000 RSI: ffffffff8c0ad880 RDI: 0000000000000001
RBP: ffffc900032efcf0 R08: ffffffff901c8877 R09: 1ffffffff203910e
R10: dffffc0000000000 R11: fffffbfff203910f R12: dffffc0000000000
R13: 1ffff9200065df8c R14: ffffc900032efc80 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 unlock_timer kernel/time/posix-timers.c:128 [inline]
 do_timer_settime+0x37f/0x3e0 kernel/time/posix-timers.c:908
 __do_sys_timer_settime kernel/time/posix-timers.c:928 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:914 [inline]
 __x64_sys_timer_settime+0x19e/0x240 kernel/time/posix-timers.c:914
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa02eb7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa02cff6038 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 00007fa02ed35f80 RCX: 00007fa02eb7e719
RDX: 0000000020000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00007fa02ebf1616 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa02ed35f80 R15: 00007ffd59aaea38
 </TASK>
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 ee 14 43 f6       	call   0xf6431502
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 52                	jne    0x6d
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 43 99 a6 f5       	call   0xf5a69972 <-- trapping instruction
  2f:	65 8b 05 64 f3 3c 74 	mov    %gs:0x743cf364(%rip),%eax        # 0x743cf39a
  36:	85 c0                	test   %eax,%eax
  38:	74 43                	je     0x7d
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


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

