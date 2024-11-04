Return-Path: <linux-kernel+bounces-395611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D465D9BC080
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806231F22A91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343B1FDFA5;
	Mon,  4 Nov 2024 21:57:32 +0000 (UTC)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8461FCF68
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757451; cv=none; b=WGgOY492gl/H4rS9f3tJNPeYhDwn5jraTuz43mh7p0uHE4LnOrSxpVq23y6MNouOPuT0ueUQlk4WMAtMrqBS75TajqvdyMNrB7uhOwLg/VqQj9OTm60d9HG3wj9WC4ZnNGNSQeWD9FQRIxmJSWloQxn8spb58gtGads9pZDeTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757451; c=relaxed/simple;
	bh=BP6dM1u/QxuoZfkGqHfSI4KuCY1NkXDn1oXGb0K+0uE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h95keje6cvW0FSPh8QppIN5pwNL3yC0f/MtOads+uOCUZXLoosn4GCdhwfVDJKXpfU3grRliBTRyYuJtZchZoRWSXqgs0a9HRjj4eybYnln9lqrYeoP+S4VKtlCbDCO1+nqYoevfPDUypI/rnJR928TqGYu/O8RGqTsV9SJMcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7180ab6e01dso3951960a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757449; x=1731362249;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEYQ6Z8+FOvPGNiS0LpLO+B5sk3bgXloGhKuZU8+LRo=;
        b=FvOn1iPh++g/u5uiXUd7zYO8h/F8oPYx2TZIfmuKlWvd+gMpctTfP3tPUq34G8g/jr
         5a4MAidxLX7uqOWsOhSVBZNlYZI42BebAR9vVpkhBFM4c8evHr761MElO9FNSgueyWoH
         tayhLv9L4DkZzSbLWk9V/36+XwjHGl5LByiGjmv3RCnL1ys3cHiZfsU69clLIiTAYL4N
         +Uelk16J89aynJHSwNyOSNW2+6mS7cD1ztAV+sjW8IfyScE7T3vds2LkaGrSTOeQLT13
         jm51LiQsXZW9g8+BsRfK2KJg62Phg9/2zXPWuWKuF0KbDsBp/wQ5BXwY30UuyhBw7Psg
         YoWw==
X-Forwarded-Encrypted: i=1; AJvYcCU913cS3NwcqgHjMYtCLBHLVkz254b3yggZSlO4chh49k1sqp/xi8PCql7t2sn9N4jNCgGRZ59N70bOS98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1UpkK9j7ncL8rioa71XNClC8STogq9pXyaAPL2izSQ7+woHw
	Gm/0WW0Bp+hpOhlhvy60FeV+HLPWHkJH6ncAnvcBGOKnYxG+b9fgVkXeCQvRS7/BeLlLLX9hzbt
	NiGT81AmgJNCsV6oXpgjaQgBs7XTmVVwMereTAzi+H2OBLtD9jDGx7ZQ=
X-Google-Smtp-Source: AGHT+IH6GWMMyRYCUrmFuvKHAyTX70xzSTKMUta55MqNs9/wSLc1NSz8PEwuhlHwVaf7/xHeMfwzFGGMZvOEWpjWSnYoXYf22loH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:442b:b0:713:6f24:39b8 with SMTP id
 46e09a7af769-719ca1d3facmr9788600a34.19.1730757449275; Mon, 04 Nov 2024
 13:57:29 -0800 (PST)
Date: Mon, 04 Nov 2024 13:57:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67294349.050a0220.701a.0010.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in folio_update_gen
From: syzbot <syzbot+e5a74963d40b07387bdf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12634587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=e5a74963d40b07387bdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/disk-c88416ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinux-c88416ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/bzImage-c88416ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5a74963d40b07387bdf@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x250 mm/vmscan.c:3140
Modules linked in:
CPU: 0 UID: 0 PID: 85 Comm: kswapd0 Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:folio_update_gen+0x23d/0x250 mm/vmscan.c:3140
Code: 00 48 3b 4c 24 60 75 2a 48 c1 e8 29 83 e0 07 ff c8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 74 c0 bf ff 90 <0f> 0b 90 e9 91 fe ff ff e8 46 9f ee 09 66 0f 1f 44 00 00 90 90 90
RSP: 0018:ffffc900020deb40 EFLAGS: 00010293
RAX: ffffffff81d5fd8c RBX: 0000000000000000 RCX: ffff88801cbb8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900020dec00 R08: ffffffff81d5fc19 R09: 1ffff1100d562d00
R10: dffffc0000000000 R11: ffffed100d562d01 R12: 0000000000000003
R13: 1ffff9200041bd70 R14: ffffc900020deb80 R15: ffffea0001308000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7fecc34866 CR3: 00000000223a2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 walk_pmd_range_locked+0x92b/0xf90 mm/vmscan.c:3514
 walk_pmd_range mm/vmscan.c:3594 [inline]
 walk_pud_range+0x1f16/0x2310 mm/vmscan.c:3621
 walk_p4d_range mm/pagewalk.c:259 [inline]
 walk_pgd_range+0x4a9/0x17e0 mm/pagewalk.c:305
 __walk_page_range+0x15f/0x700 mm/pagewalk.c:412
 walk_page_range_mm+0x58f/0x7c0 mm/pagewalk.c:505
 walk_mm mm/vmscan.c:3665 [inline]
 try_to_inc_max_seq+0xdd9/0x13b0 mm/vmscan.c:3902
 get_nr_to_scan mm/vmscan.c:4740 [inline]
 try_to_shrink_lruvec+0xb30/0xc70 mm/vmscan.c:4783
 shrink_one+0x3b9/0x850 mm/vmscan.c:4832
 shrink_many mm/vmscan.c:4895 [inline]
 lru_gen_shrink_node mm/vmscan.c:4973 [inline]
 shrink_node+0x37cd/0x3e60 mm/vmscan.c:5954
 kswapd_shrink_node mm/vmscan.c:6783 [inline]
 balance_pgdat mm/vmscan.c:6975 [inline]
 kswapd+0x1ca9/0x3700 mm/vmscan.c:7244
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

