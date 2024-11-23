Return-Path: <linux-kernel+bounces-418984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AFF9D680D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E22B21F53
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A715CD78;
	Sat, 23 Nov 2024 07:31:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A37537171
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732347084; cv=none; b=m9aqY6e2+VlPkGOFeIVOOGsdYLv48gmuOph1a5mpGvIRwVCs+AoNC1Wolu+WdzyT5AWHIQHZZdmd2/6aRtjf8O2aEPdsgOChiT8pH26jv2SW0q8plKaFSzA85V278p44JGvSIDlt56ttNdE1DwXXTvb9qvePtIvlD7pE9IKoPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732347084; c=relaxed/simple;
	bh=9ndpZ5aYR/+veH4YsyXXThr90GjHWQ0Nh+YsqyjSKL0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nGJlvnQQ1gsE86sbwVxtnTEEyXYvpWc4oSZo8dfI3Yli5bKfvrzHTAcuqUm8YHlP2xbspqz28R3FNg2gBUgiSPYO+i6acxl6K/AVHE7TihM4jTbcKxJcJict+WWGx6e69xHSFZ7PzV02dEqgE7bRichKABztFmf486UMcHmzUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abb164a4fso294764339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 23:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732347081; x=1732951881;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zICGF2+KMMvo9BkIgzLX27t49joGlreJ9/FdOa4fDmY=;
        b=SoJaTv09u/wYjs76oi8Y3zFqWCogsAXY2jQ60PAM0fJNtYwlPwapT4ZheT5+cTVfbf
         nb0/gxfzWF8subxsGQ8q96GyTuHXYrk0uJ9mW1ErFWGNUr4bMghx97UqWGzPU0gTBxn+
         GVf9J1Euvrq/TC6/iytu4RERGbcObbCGk2rRStVhIxtUJsTUEr6rt3heJmxACL9+K3iq
         uhCz3HCaFDtO/+dy6iX7rhNad/3nS1Xlq/t9wdi3Nix6iXTyKjKIUvHDAHu/eN9OWrSI
         15s02ZDaxsK8dU3YspI+tbLenR5aZVnNaS4ES07wt/INPyPxn7qPJfWt4ZWgMgx458vz
         300A==
X-Forwarded-Encrypted: i=1; AJvYcCWe7rVzUJ5VFc8jc46OB1fDl/Q8ypGgjoZsZsxKKLG71MGTV045r/nL2IKBbZlPLUl5dO6I+RqBmzYAFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwEE/BLm1DF1JF9vo9yG8fn2SXyFcmPI22TSgCGkOGH3dfGDd
	+LYOuZBHEIBwivpq70luzHYKGYzC0C/6sjAkEAyNm8MX1719VsMBGxn488FhKLSxbQIVO5i/S/g
	kafv+5X5y9lZ9mS1sRKYFvOulMFvUwZR4rQnYHY8jZkXseUwPGe0Gjus=
X-Google-Smtp-Source: AGHT+IEgCKLgoc8f5JMr97CXN36CrTTIHTn7Pdj9YNoEmeZ8v3GwoYD5/8XPnNSWY8/0A+SYbm6gWj2UT/gDS/7tQmHKEivryLdg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3a79ad100fcmr77444135ab.1.1732347081612; Fri, 22 Nov 2024
 23:31:21 -0800 (PST)
Date: Fri, 22 Nov 2024 23:31:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674184c9.050a0220.1cc393.0001.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9fb2cfa4635a Merge tag 'pull-ufs' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10042930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ff2e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c0c61a15f60/disk-9fb2cfa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3363d84eeb74/vmlinux-9fb2cfa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b1a270af550/bzImage-9fb2cfa4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com

 madvise_pageout_page_range mm/madvise.c:609 [inline]
 madvise_pageout+0x326/0x820 mm/madvise.c:636
 madvise_vma_behavior+0x58c/0x19e0 mm/madvise.c:1045
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1274
 do_madvise+0x29d/0x700 mm/madvise.c:1461
 __do_sys_madvise mm/madvise.c:1477 [inline]
 __se_sys_madvise mm/madvise.c:1475 [inline]
 __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1475
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:309!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 7269 Comm: syz.1.183 Not tainted 6.12.0-syzkaller-00233-g9fb2cfa4635a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flags.h:309
Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
FS:  00007f08b31bc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0025ff000 CR3: 00000000341ce000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_test_locked include/linux/page-flags.h:509 [inline]
 next_uptodate_folio+0xac/0x4b0 mm/filemap.c:3505
 filemap_map_pages+0x1c6/0x16a0 mm/filemap.c:3647
 do_fault_around mm/memory.c:5255 [inline]
 do_read_fault mm/memory.c:5288 [inline]
 do_fault mm/memory.c:5431 [inline]
 do_pte_missing+0xdae/0x3e70 mm/memory.c:3965
 handle_pte_fault mm/memory.c:5766 [inline]
 __handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
 faultin_page mm/gup.c:1187 [inline]
 __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
 __get_user_pages_locked mm/gup.c:1751 [inline]
 get_dump_page+0xfb/0x220 mm/gup.c:2269
 dump_user_range+0x135/0x8c0 fs/coredump.c:943
 elf_core_dump+0x2766/0x3840 fs/binfmt_elf.c:2121
 do_coredump+0x2c42/0x4160 fs/coredump.c:758
 get_signal+0x237c/0x26d0 kernel/signal.c:2903
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x1000
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 002b:000000000000010c EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007f08b41363b8 RCX: 00007f08b3f7e759
RDX: ffffffffff600000 RSI: 0000000000000104 RDI: 8000000000000000
RBP: 00007f08b3ff175e R08: 0000000100000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f08b41363b8 R15: 00007fff7656a008
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flags.h:309
Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
FS:  00007f08b31bc6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff76568ff8 CR3: 00000000341ce000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

