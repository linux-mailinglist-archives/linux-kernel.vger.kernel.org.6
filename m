Return-Path: <linux-kernel+bounces-169269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EFD8BC5F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE031C21473
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F920405D8;
	Mon,  6 May 2024 02:56:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7222075
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964167; cv=none; b=NuX/1cpyY6b+AS+0W9EwbiwHwi2mA2qVLO50+JY0P2ZR4x3mgUxlPvzeE42hbhPz59Vqy67++s1KW1yr7Fok4FCdWipJX6BK5OghE7dPrntQMbQbNe49JgEv/fF48xF/BTGjU686scvc2N+jDFWECq/xlCa1RojD7t3mMgYGJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964167; c=relaxed/simple;
	bh=E8e2uaHo0/pu2vYR47OHAmIEMJE1knJa4vDYc9ZTnow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZ1fgO3h7fXEGk1bTN2wbcL2Wt5x9PwkDwvxBZOWx0yeeyAMWua/zgT/JQU60ty9a4k9fbICg7LvJjhYjVnwpkXAJP4Ex1kl0fYizXt7BG+QKAzvAc3zy2h+NNeSofWATpJ4M2u9NN4NZJ4E0dSXKjMWUMB84PTejsOh47n1TFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ded5e00bf0so195325939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 19:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714964165; x=1715568965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/0+D3zPUzC4BArkCkpX1Ncn0JeUG9bCbR2J6HzXBpA=;
        b=elS4Ehgng9wwDRGwn+I5c5oMy1Ad8nPiKS+ykZbajJwL3+JdRcsC/mqhKbF+72mfDM
         Ba4AI5XApDRyFiDAYwsTzpX1BUsEabJdZmSt5kx+eOBMI4kCm79KtR/gedli+K19oWtP
         JFsTlJ66lh19sx4lemms/csrdoPbxDCWEC+/w42cB/K5RzW+eqSpcSdSjbvpKg8h0cBv
         HtyBrqFJWNiCNddt90p0/sWfDov95SLXXxsvGSpakDlK5fwXqGEw4Vm3YcIk7nXB5Apm
         BNJv8jzhOjNbdRmx8kOhA9L8fV6K3yFzz0FY+OXqTvcAuI4GBgSXLhr1lGezjSiqnihE
         fbqA==
X-Gm-Message-State: AOJu0YzJ3ZSr7x9twqIBkIj+UeBvKmflDO/rYfn6crgV6JdBrlqqg0Dl
	Kemp6HNYV2CAq7jupOS72CpLGxNBlPz+8Ymj/vazo5EVT2QSSO+lW7cK/Igl9KJby4cpbZ6uuxc
	O08tsY1iK8gZeZSeTADCjucrUYdfuilM5FlMUHv97yn3euMdk6nUQm50=
X-Google-Smtp-Source: AGHT+IHxC9Sdw4oQaNMeq2MoEocMBqQI2pM5WNuyzUqDMa8zaKlS9MgcfF7x9G0LJoxm9uvhLQYvrTXebgLh9Gaa/eGgN0xRM4Ao
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d8a:b0:7da:67e8:9379 with SMTP id
 k10-20020a0566022d8a00b007da67e89379mr148761iow.4.1714964165336; Sun, 05 May
 2024 19:56:05 -0700 (PDT)
Date: Sun, 05 May 2024 19:56:05 -0700
In-Reply-To: <20240506023617.1309937-1-luyun@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0b4630617c0356d@google.com>
Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luyun@kylinos.cn, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in sys_mkdirat

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-...D } 2672 jiffies s: 2029 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5458 Comm: syz-executor.0 Not tainted 6.9.0-rc7-syzkaller-gdd5a440a31fa-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:122 [inline]
RIP: 0010:lock_release+0x125/0x9f0 kernel/locking/lockdep.c:5767
Code: 7e 85 c0 0f 85 23 05 00 00 65 48 8b 04 25 c0 d3 03 00 48 89 44 24 18 48 8d 98 d4 0a 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 38 <84> c0 0f 85 d8 05 00 00 83 3b 00 0f 85 f1 04 00 00 4c 8d b4 24 b0
RSP: 0018:ffffc90000a08a20 EFLAGS: 00000017
RAX: 0000000000000000 RBX: ffff888026abe4d4 RCX: ffffffff81728e30
RDX: 0000000000000000 RSI: ffffffff8c1f89c0 RDI: ffffffff8c1f8980
RBP: ffffc90000a08b50 R08: ffffffff8fa9faef R09: 1ffffffff1f53f5d
R10: dffffc0000000000 R11: fffffbfff1f53f5e R12: 1ffff92000141150
R13: ffffffff84b6f924 R14: ffffc90000a08b80 R15: dffffc0000000000
FS:  00005555763c6480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffe1c6dbf8 CR3: 0000000022fe4000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
 _raw_spin_unlock_irqrestore+0x79/0x140 kernel/locking/spinlock.c:194
 debug_object_activate+0x3e4/0x510 lib/debugobjects.c:726
 debug_hrtimer_activate kernel/time/hrtimer.c:423 [inline]
 debug_activate kernel/time/hrtimer.c:478 [inline]
 enqueue_hrtimer+0x30/0x3c0 kernel/time/hrtimer.c:1090
 __run_hrtimer kernel/time/hrtimer.c:1709 [inline]
 __hrtimer_run_queues+0x6d5/0xd50 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:kmem_cache_free+0x15/0x2c0 mm/slub.c:4339
Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 57 41 56 41 55 41 54 53 48 83 ec 10 48 89 f3 <65> 48 8b 04 25 28 00 00 00 48 89 44 24 08 e8 a8 02 00 00 48 85 c0
RSP: 0018:ffffc900042972b8 EFLAGS: 00000286
RAX: ffffffff825d0aa6 RBX: ffff88807794e820 RCX: ffff888026abda00
RDX: 0000000000000000 RSI: ffff88807794e820 RDI: ffff8880193dac80
RBP: ffffc900042974b0 R08: ffffffff825d0a81 R09: 1ffffffff1f53f5d
R10: dffffc0000000000 R11: fffffbfff1f53f5e R12: ffff88802f56c000
R13: ffff88807794e8a0 R14: ffffc90004297720 R15: 0000000000000001
 ext4_mb_new_blocks+0x2ab4/0x4bf0 fs/ext4/mballoc.c:6250
 ext4_ext_map_blocks+0x1c74/0x77b0 fs/ext4/extents.c:4317
 ext4_map_blocks+0xa5e/0x1d20 fs/ext4/inode.c:623
 ext4_getblk+0x1fa/0x850 fs/ext4/inode.c:833
 ext4_bread+0x2e/0x180 fs/ext4/inode.c:889
 ext4_append+0x327/0x5c0 fs/ext4/namei.c:83
 ext4_init_new_dir+0x33e/0xa30 fs/ext4/namei.c:2977
 ext4_mkdir+0x4f7/0xcf0 fs/ext4/namei.c:3023
 vfs_mkdir+0x2fb/0x4b0 fs/namei.c:4123
 do_mkdirat+0x264/0x3a0 fs/namei.c:4146
 __do_sys_mkdirat fs/namei.c:4161 [inline]
 __se_sys_mkdirat fs/namei.c:4159 [inline]
 __x64_sys_mkdirat+0x89/0xa0 fs/namei.c:4159
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0aef87c967
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe1c6f498 EFLAGS: 00000202 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fffe1c6f520 RCX: 00007f0aef87c967
RDX: 00000000000001ff RSI: 00007fffe1c6f520 RDI: 00000000ffffff9c
RBP: 00007fffe1c6f4fc R08: 0000000000000004 R09: 00007fffe1c6f236
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000032
R13: 000000000001cfb4 R14: 000000000001cfab R15: 0000000000000004
 </TASK>


Tested on:

commit:         dd5a440a Linux 6.9-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1298931f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=448b220a4abc599a
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125a2ca8980000


