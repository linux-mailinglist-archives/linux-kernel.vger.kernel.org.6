Return-Path: <linux-kernel+bounces-421075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822E9D8660
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C13286E15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA81AB53A;
	Mon, 25 Nov 2024 13:27:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232E2B9B7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541246; cv=none; b=fr+VelnDiDxjDBCXl8QjfLMKqzNmQ7U2nDoieaMsrfoapAu/EPvYVhmLW6JYZ3PneP3KnydJJwrcgBT3xhCQzWV7aIHANBoknV0Uu4H0iDveEdAWZSyACy9Nw/J4jDo34dCVysR2P2xJ5uh+zGUS8bUeFd/35kGzKPhX7Cy1cJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541246; c=relaxed/simple;
	bh=0ww076H2CGonDTkoaXuzsGNUHdl/ZgJ9/dRwhAd+GHY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s1Mup7wNuMwl18eSD2bj9IYR/MC2OSeY2xpxVzT5QYHPc79hZtOU78d8/HIqYO1OXnCPtmP0wZQ/5Dy26H7lXaZ/BNF+hxyAvBnxGqnU3QNYd+2wdT5xey9Xi5zM+IN3GceMmKXYu6ZHuqIHj8yRVEtlEVk9EcUXKUJVOO9VXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so45241185ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732541244; x=1733146044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sd6yKQRvi4CJFVM+Fq9Iju0idSQ7cJnPjPcdRX8HOng=;
        b=nUa1U0G1Lt3UdDWhltab+LD2F8VeIqm90UQJMFMbpU7yQMfk4B1i9NelYJ5c6VG9On
         obRSvysJfBTO06hspsPRo5JicZTEZxyFwSo8DSvW/MUC1VbqU68WKP1Jp5Vc27kVi6AT
         NMHmk7FMx+FPOD04ze+PFLUkj2V1T5sVF9a7BoJtr/q6tZ0UFJOS9uv9C59pXRZY2G1P
         LVOa3Gk8Bkg5HDEpqxEAU+t1JgddeJ4fnNvvj90q9+bF+WS7ukObyu7effciqk0sS3b/
         QTzeflmyDTbtK3KL/sOnkKyfkD10qLEPNCCeJzgI3PbIuXdzqy4wwk9bBH5/pVSyzMSM
         Y5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUtGWdNblD5gyG2MeaVWlF7azFK7qjJLw3ufv1AdedTCp1Jk5pohmfoSma0fs/Kflqb8++4yh86+Xqlktk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnka5Yofx1yUWgzHUfpVWIqbLBHbVL6bqgZ9Cdt4ouO2ZBRzdO
	S3y35CAIxiGR5a3u2/YlRAyZOQYl7jK9acRJ3kVkha538iA1vGnbRq75QLAuG0H4TLitWmRqCpD
	Ev8QZWrH57Gxeub9Q/O4Tr6ipfaI9YUzVqBFDMtSA/UCySqrfmNIfnZc=
X-Google-Smtp-Source: AGHT+IHkQz3pitB9cEGRgbY0zXUKf2FapFkdMGtLjpQPw8vGv0H9xvQsJ6DlfMItu5L+kKtZrfXPC591fC9tWCAP1IvB2tz4UDgD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:3a7:2194:fd3d with SMTP id
 e9e14a558f8ab-3a79aead6bemr100973875ab.14.1732541244417; Mon, 25 Nov 2024
 05:27:24 -0800 (PST)
Date: Mon, 25 Nov 2024 05:27:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67447b3c.050a0220.1cc393.0083.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_mmap (3)
From: syzbot <syzbot+4c456547958bb6d24648@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171fb75f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7393f07275e8e571
dashboard link: https://syzkaller.appspot.com/bug?extid=4c456547958bb6d24648
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157c2778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119ba530580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa5603c86f1c/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30a61d0bbce7/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80c2dc322de7/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c456547958bb6d24648@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...0: (1 GPs behind) idle=61ac/1/0x4000000000000000 softirq=11463/11464 fqs=2100
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:        0          0            0   ==> 52500(ms)
rcu: 	(detected by 1, t=10505 jiffies, g=4921, q=654 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5856 Comm: syz-executor211 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:arch_atomic_try_cmpxchg arch/x86/include/asm/atomic.h:107 [inline]
RIP: 0010:raw_atomic_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:2170 [inline]
RIP: 0010:atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1302 [inline]
RIP: 0010:queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
RIP: 0010:do_raw_spin_lock+0x131/0x2c0 kernel/locking/spinlock_debug.c:116
Code: 00 00 48 89 df be 04 00 00 00 c7 44 24 28 00 00 00 00 e8 d2 be 85 00 be 04 00 00 00 48 8d 7c 24 28 e8 c3 be 85 00 8b 44 24 28 <ba> 01 00 00 00 89 44 24 04 f0 0f b1 13 0f 85 95 00 00 00 65 44 8b
RSP: 0018:ffffc90000007d98 EFLAGS: 00000097
RAX: 0000000000000000 RBX: ffff8880b862ca00 RCX: ffffffff816be07d
RDX: fffff52000000fb8 RSI: 0000000000000004 RDI: ffffc90000007dc0
RBP: 1ffff92000000fb4 R08: 0000000000000001 R09: fffff52000000fb8
R10: 0000000000000003 R11: 0000000000000005 R12: ffff8880b862ca08
R13: ffff8880b862ca10 R14: ffff8880b862ca00 R15: ffffffff8931b920
FS:  00007fd30f46c6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd30f46cd58 CR3: 000000007b330000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1743 [inline]
 __hrtimer_run_queues+0x2be/0xae0 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire.part.0+0x155/0x380 kernel/locking/lockdep.c:5814
Code: b8 ff ff ff ff 65 0f c1 05 d0 16 97 7e 83 f8 01 0f 85 d0 01 00 00 9c 58 f6 c4 02 0f 85 e5 01 00 00 48 85 ed 0f 85 b6 01 00 00 <48> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00 00 00 00 48 c7
RSP: 0018:ffffc9000362f510 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 1ffff920006c5ea3 RCX: ffffffff816a7e9e
RDX: 0000000000000001 RSI: ffffffff8b6ce1e0 RDI: ffffffff8bd0e980
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff2dc9398
R10: ffffffff96e49cc7 R11: 0000000000000004 R12: 0000000000000000
R13: ffff888074629b58 R14: 0000000000000000 R15: 0000000000000000
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __pte_offset_map_lock+0xf1/0x300 mm/pgtable-generic.c:402
 pte_offset_map_lock include/linux/mm.h:3025 [inline]
 filemap_map_pages+0x35c/0x16b0 mm/filemap.c:3656
 do_fault_around mm/memory.c:5280 [inline]
 do_read_fault mm/memory.c:5313 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing+0xdab/0x3e70 mm/memory.c:3979
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault+0x103c/0x2a40 mm/memory.c:5944
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
 faultin_page mm/gup.c:1187 [inline]
 __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
 populate_vma_page_range+0x27f/0x3a0 mm/gup.c:1923
 __mm_populate+0x1d6/0x380 mm/gup.c:2026
 mm_populate include/linux/mm.h:3385 [inline]
 vm_mmap_pgoff+0x293/0x360 mm/util.c:593
 ksys_mmap_pgoff+0x7d/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd30f4d6e89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd30f46c208 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fd30f561418 RCX: 00007fd30f4d6e89
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007fd30f561410 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 00007fd30f56141c
R13: 00007fd30f52d87c R14: 0000000800000003 R15: b635773f06ebbeee
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

