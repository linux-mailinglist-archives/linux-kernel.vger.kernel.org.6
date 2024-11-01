Return-Path: <linux-kernel+bounces-392723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B39B977E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA761C20BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D91CEEB9;
	Fri,  1 Nov 2024 18:28:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB41CEAC0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485704; cv=none; b=OIldP8y4d7pPd2JY82KWmfyNE/gVG8C5C6YwS8HNA3xvHdgWpM5zw+jy4A9/rEiG8GWSnCJqYYdJ6/h8lNFgafYLYTsW9r2SHrQchk9EyvB1EOXpuwL6RNcKDD5IUUs3RVOu7dARTc+2BZAz5LKob2kJPWomfhbNWi5l/mvtpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485704; c=relaxed/simple;
	bh=pW3qXkbWGUFzPIjxfSbxX2jWgDSa40g2Tbzbt+cupVs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j5t1JEGXwEnMFEGG0neiCtF1RYKFA2rzg4bL5LV9MQE2DXFc/dsCXxkvKM4H2YAzF32R2Wgnj/S9YMHn2M4ymFjB22kp8lm1QqA7If6bEuaJyvBfnoJv7bSosdkDdFRuWghY8UXovdDhDNqBeonslLERHexj+0jvSSnHvYfdH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so2062065ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485702; x=1731090502;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qr5PrxxpcSCCN/ve4I5Y+TPzDVyUgau5IKcyU93gwVY=;
        b=LzFHEzDP16+snOLef6svGso4nWK51QS7brmwMYXJZ8YFhz4T0IISg3z8bhlqCBtoJn
         LH3nzbTqPUerunESv+Antj22RnfIXIZ9eyzU9snnvOmh+b+I3Gek80g0mnwyZu2r1gtv
         HDb5FmjKmfJtblAxHRWDZUB807+7tap5yc1PGAFTcVhCUsMGujhFbJe47c9BkUjpyMst
         Pn/RK01oKQHk89QLBm1/AT2ZNUDPY8YupofI9tXN+M+KSTHaDEqqTVdBmXQiwjRgPnbE
         Uzk/B2HfKToZK2dXS0rqP+9LQ8Fh2vw8rwoC0omYRs+FiPX5pUu/H/mlE3DFEiJvmRkw
         XdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM/rM/vEr11cJFKXmPC/KpBVt4C0k6YIIj1SFcBCFGf3xNTs4azXsJ10phymkJMNjSCcbOdDinMa1cQWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2DgB3PORxslWB55tAt73fjrx2Zo6HBsuSynE2t5sFI1ANMia
	2w0P5PSr9XxyfVc5+/yrJCp7jsehtCS93osuVSf7jdju+i2toWK+yOzXmeAA3vLOTYZtsdtE9RK
	SdLII48kxQmhlWcWjPISjdX08/w0AN1/ZUGtyVnLf36ThioH7tUMWRMo=
X-Google-Smtp-Source: AGHT+IFfte6fTWWePS81iiiB8sdFCYMufPFb204VtI0vGE3j/iAIGoBXNnjLaKeO9S4wIXEZEJu4h8tK8cK3xyb38zdVeXGffl+H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3a3:40f0:cb8c with SMTP id
 e9e14a558f8ab-3a61752b08cmr89721895ab.17.1730485702228; Fri, 01 Nov 2024
 11:28:22 -0700 (PDT)
Date: Fri, 01 Nov 2024 11:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67251dc6.050a0220.529b6.015e.GAE@google.com>
Subject: [syzbot] [kernfs?] WARNING: locking bug in kernfs_path_from_node
From: syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17a0a187980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea37e2e6ffccf41a7e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13119340580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d56630580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
-----------------------------
strace-static-x/5846 is trying to lock:
ffffffff8eac8698 (kernfs_rename_lock){....}-{3:3}, at: kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229
other info that might help us debug this:
context-{5:5}
3 locks held by strace-static-x/5846:
 #0: ffff8880b873e598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
 #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2381
 #2: ffff88802f7129e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:208 [inline]
 #2: ffff88802f7129e0 (&mm->mmap_lock){++++}-{4:4}, at: stack_map_get_build_id_offset+0x431/0x870 kernel/bpf/stackmap.c:157
stack backtrace:
CPU: 1 UID: 0 PID: 5846 Comm: strace-static-x Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
 kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229
 kernfs_path include/linux/kernfs.h:598 [inline]
 cgroup_path include/linux/cgroup.h:599 [inline]
 get_mm_memcg_path+0xb9/0x380 mm/mmap_lock.c:82
 __mmap_lock_do_trace_acquire_returned+0x9f/0x2f0 mm/mmap_lock.c:102
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:209 [inline]
 stack_map_get_build_id_offset+0x84d/0x870 kernel/bpf/stackmap.c:157
 __bpf_get_stack+0x8da/0xad0 kernel/bpf/stackmap.c:483
 ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
 bpf_get_stack+0x33/0x50 kernel/bpf/stackmap.c:496
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1933 [inline]
 bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1923
 bpf_prog_ec3b2eefa702d8d3+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2340 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2381
 trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x77a/0xa70
 context_switch kernel/sched/core.c:5311 [inline]
 __schedule+0x10c7/0x4c30 kernel/sched/core.c:6707
 __schedule_loop kernel/sched/core.c:6784 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6799
 do_wait+0x2a5/0x560 kernel/exit.c:1696
 kernel_wait4+0x2a7/0x3e0 kernel/exit.c:1850
 __do_sys_wait4 kernel/exit.c:1878 [inline]
 __se_sys_wait4 kernel/exit.c:1874 [inline]
 __x64_sys_wait4+0x134/0x1e0 kernel/exit.c:1874
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x4d6ad6
Code: Unable to access opcode bytes at 0x4d6aac.
RSP: 002b:00007ffc879cddd8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004d6ad6
RDX: 0000000040000000 RSI: 00007ffc879cddfc RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000017 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000001b15d400
R13: 00007ffc879cddfc R14: 000000001b157ce0 R15: 000000000063f160
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

