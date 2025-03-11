Return-Path: <linux-kernel+bounces-556258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E5A5C33E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106B33A3B50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964625B674;
	Tue, 11 Mar 2025 14:06:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AD25A653
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701986; cv=none; b=Ei+iDenNo3JdkJOFUOrjRmZu7NPQ7vegP2JQ8w0kcDfgG7NjOJ0m+fviin2eLP4bmzEFBZRvZo4TEM4FlO6EDtnRyVaCb7QOQY9U3VV5wyN4fkl8GPfqCs2NYQ7/ZaMA1HVBm0JYKZ8bOmLucoBo1UhcD3VhLeEc04oCVq7DqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701986; c=relaxed/simple;
	bh=ZDwgVldp/dtR0sAQP/jrdO4x0Z5emH82grhthtbhCDc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EzToXESLoNDAX0urrjysZ4l/+440dMcm4v7WgojGzc/hOBWCp1/DzGsP/y9528W9ZwRXHAKGPCPEi2IDNuGR7oM1EFydxzj+BRm4Dv7X9GwW33CehDPsIZ7FHGe8qIqSvaGLdnsaf7v70GpZqWFTs87j5vU+4g3wWNqPZ5otQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d43d1df18bso44875285ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701984; x=1742306784;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qngm61D2P5O2wJvRP9JS9Q4K7MNXVw7PSsoQPHTFftA=;
        b=EFvxly7oBdm24cefkYDwQ6tNb+nr6TWPxli6deV3w1m8LOXUbjPqhyPxH0uaX4bdqL
         GZubnlE5MTU+eQt+oDyH2r/YjmHkeVb3EUn0+daIJuXIPmpRPud9e9N2UbhK6qYvMp4s
         gr5yyDWU/AmF2kzM+5tKlDY0Q5m4y37zRkFjyJ0UFvgNLpZAuxtyVDIx4+dKF4fH8z+K
         G7l4PNRRUYjna0FevQoUUK2fvgcyJQt4DcjJ1GW3wOo5mkg0GEX7ZajASUhohTWqBsGU
         mjpgQWGwRSkb9owqyTC2mH6AbAal2kdTADXSf8VK37WUv9rESpiRkGl73H1brzFk/Xa9
         XEug==
X-Forwarded-Encrypted: i=1; AJvYcCXZ12wdXD58tFhpyeetMzqVrhczXCusQ8SCoOWCR/4W1CaMcLKdpBA+IlemzCA+2xIa5ynFICKxJK0Pbl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BboyRAdjETUUG1zPek1Yo3LfeeP/v+lJKgRbFbFjfszfgMsy
	MRHCW+mk9Vn2W4rc80H1TNXt2ecWfmVIGxrbxSP0HrLaPxPqP/hza0o6nT/BiR1WhgQWaiz61Tt
	7Vk47emASttVV8xzQni6fgvUQjz+VOnBAMYe0JMr2Z+PDyf3J7iEx0Xo=
X-Google-Smtp-Source: AGHT+IHUWAme+Fs0K+gNOZ+nI9ty/+hj1BANz5GfZzVckJV8cLPKZ5CoSUXCkX8P9/InJLZifFh14jePR0KOrqJKMHuo7SnqpgNP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1848:b0:3d3:fa0a:7242 with SMTP id
 e9e14a558f8ab-3d441969734mr182111785ab.9.1741701984189; Tue, 11 Mar 2025
 07:06:24 -0700 (PDT)
Date: Tue, 11 Mar 2025 07:06:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d04360.050a0220.1939a6.000e.GAE@google.com>
Subject: [syzbot] [cgroups?] [mm?] KASAN: wild-memory-access Read in lookup_swap_cgroup_id
From: syzbot <syzbot+d26257274cf7b53db74a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848e07631744 Merge tag 'hid-for-linus-2025030501' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1247ca54580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2040405600e83619
dashboard link: https://syzkaller.appspot.com/bug?extid=d26257274cf7b53db74a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-848e0763.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c46426c0526b/vmlinux-848e0763.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d575feb1a7df/bzImage-848e0763.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d26257274cf7b53db74a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: wild-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: wild-memory-access in __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
BUG: KASAN: wild-memory-access in lookup_swap_cgroup_id+0x82/0xf0 mm/swap_cgroup.c:127
Read of size 4 at addr 0007c8805a01cd3c by task udevd/5306

CPU: 0 UID: 0 PID: 5306 Comm: udevd Not tainted 6.14.0-rc5-syzkaller-00039-g848e07631744 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe3/0x5b0 mm/kasan/report.c:524
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 __swap_cgroup_id_lookup mm/swap_cgroup.c:28 [inline]
 lookup_swap_cgroup_id+0x82/0xf0 mm/swap_cgroup.c:127
 swap_pte_batch+0x142/0x330 mm/internal.h:333
 zap_nonpresent_ptes mm/memory.c:1634 [inline]
 do_zap_pte_range mm/memory.c:1702 [inline]
 zap_pte_range mm/memory.c:1742 [inline]
 zap_pmd_range mm/memory.c:1834 [inline]
 zap_pud_range mm/memory.c:1863 [inline]
 zap_p4d_range mm/memory.c:1884 [inline]
 unmap_page_range+0x1bb5/0x4510 mm/memory.c:1905
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1995
 exit_mmap+0x283/0xd40 mm/mmap.c:1284
 __mmput+0x115/0x420 kernel/fork.c:1356
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9ad/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x168c/0x1720 kernel/signal.c:3036
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8b0 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x56281d3a39d0
Code: Unable to access opcode bytes at 0x56281d3a39a6.
RSP: 002b:00007ffd4e66dab0 EFLAGS: 00010246
RAX: 00007ffd4e66dac8 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00007ffd4e66dad8 RDI: 00007ffd4e66db10
RBP: 000056283b5a6980 R08: 0000000000000007 R09: a02c58fefe889121
R10: 00000000ffffffff R11: 0000000000000246 R12: 000056283b5a6980
R13: 00007ffd4e66db98 R14: 0000000000000000 R15: 000056281d3ae4df
 </TASK>
==================================================================


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

