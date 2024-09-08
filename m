Return-Path: <linux-kernel+bounces-320438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180DD970A72
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 00:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AC81F21CAF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E813BAF1;
	Sun,  8 Sep 2024 22:22:21 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4630EACD
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725834141; cv=none; b=cKNYGFKfDF8YX/0qyC3jmUfa7ZfYJ7lU0eCjRrmUknXplBEVavg34VO1PKHDSSjwVV1uwoXhT1Su4AJm1RDh/7PND6+NHuV54LXJj+/MLj5kNiiG8tQLI1sBXE5Zzq1HFfNimhGuO1xo/K2mUVCMWmFtghHFGKreuuVkVxcg4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725834141; c=relaxed/simple;
	bh=Gu22NJgF0t9+P6PALfQ5duuC5VnkqfBe60Zdz+jgDyM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cIDmb0JG5q+uLb+JtGH6PzciF9xRPHzIdUFqZw5k7zbcL/pM3fAybi2HFSI3iqUZP0KL2vJt4Ll8V9GiH+n81IUWO7Gwnj3+oMgORH2KbhbVLoyalwEGLsDNQAaMYyknBpjdBcwgoNKl8H6DFtASxOoecxcAuTPjGOIXd0iC+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-82cea2c4e35so30136739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 15:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725834138; x=1726438938;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh5oNZ5xtl63hCGBYJVHqDB3fy4dXzbcdqu9y33lZvU=;
        b=BiX701qtqs1btvki5WFLZF2tPTWhLrEYrflSonCpOU5gALcRjRqeYjKNtP89VOKmnr
         eIrw0YnsMrqaysVM8yc48MNA8FyzXrrNlWEubCfD5FnB8N0waR4d94+L7iBK1VmncBMa
         lWZYgU9vKQNaunjx+IaBuxohXsELm+ZY3iFtsHCxQx9YGgVPLYcCp/L2C0boaWWxDD0K
         jjD1fVG+yHFkDozm012PdbNXIYG+gaM8c52yViyABkBaUZuhBJWnNpvkk4dpsAMG//1S
         KnVs9T9tgL/9mcE5JPKvFomWX95+TXtAOgoEXgT6NpCkP90mO2h/0B4VaoedISDnOwqQ
         2TxA==
X-Forwarded-Encrypted: i=1; AJvYcCXvY6VUCEZK7uC3Ho+kBg+HP3SFOANP4Nt4GCxJnqk2YNxz67DlrUK+Z8nkzLfomwClIVevOsq1mMgcCFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqYGahDPlgnD0O02pcUplUgY6zTzbh7S2fPjEXszdGGwZHLld
	MAyKQD9y8fZCDJJrfbantXoZhNBtIyjepCTRQEfGGvkJvRTKFCjpCplFr0gREI/+YHYqWfk9m7F
	okcSOdwsoncWXHmlIJ5AgwF4yvts1JZTB0sbAnRPEPCogV9HwjKdfRSM=
X-Google-Smtp-Source: AGHT+IF6kx0PAdTN8Lbit6QVfJgD4IpTS1FHWWQc8gLTlb2zubUoDyE2uKAOpb2AS7mP2Yb0SiXj7MGQE7weGSi2mc41/TBuBY3G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:342a:b0:82c:e990:7a55 with SMTP id
 ca18e2360f4ac-82ce9907f9bmr192697639f.11.1725834138659; Sun, 08 Sep 2024
 15:22:18 -0700 (PDT)
Date: Sun, 08 Sep 2024 15:22:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6b91e0621a312f4@google.com>
Subject: [syzbot] [mm?] BUG: corrupted list in add_to_unbuddied
From: syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89f5e14d05b4 Merge tag 'timers_urgent_for_v6.11_rc7' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164ed89f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=30eac43568e2b3d65728
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-89f5e14d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfc310daee41/vmlinux-89f5e14d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a92f22c06568/bzImage-89f5e14d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffffe8ffffc31c60), but was ffff888034ff6800. (next=ffff88801abf5000).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:31!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 2862 Comm: kworker/u4:12 Not tainted 6.11.0-rc6-syzkaller-00363-g89f5e14d05b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: zswap1 compact_page_work
RIP: 0010:__list_add_valid_or_report+0xd6/0xf0 lib/list_debug.c:29
Code: e8 2f 73 fc 06 90 0f 0b 48 c7 c7 20 90 60 8c e8 20 73 fc 06 90 0f 0b 48 c7 c7 80 90 60 8c 4c 89 e6 4c 89 f1 e8 0b 73 fc 06 90 <0f> 0b 48 c7 c7 00 91 60 8c 4c 89 f6 4c 89 e1 e8 f6 72 fc 06 90 0f
RSP: 0018:ffffc9000c3cfad0 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff88801abf5008 RCX: 332bd7343f331c00
RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
RBP: ffffe8ffffc31c60 R08: ffffffff817401bc R09: 1ffff92001879ef8
R10: dffffc0000000000 R11: fffff52001879ef9 R12: ffffe8ffffc31c60
R13: dffffc0000000000 R14: ffff88801abf5000 R15: ffff88801214c000
FS:  0000000000000000(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560d7f0a4dd8 CR3: 000000004108a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 add_to_unbuddied+0x2e4/0x4d0 mm/z3fold.c:550
 do_compact_page+0x924/0xc50 mm/z3fold.c:772
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xd6/0xf0 lib/list_debug.c:29
Code: e8 2f 73 fc 06 90 0f 0b 48 c7 c7 20 90 60 8c e8 20 73 fc 06 90 0f 0b 48 c7 c7 80 90 60 8c 4c 89 e6 4c 89 f1 e8 0b 73 fc 06 90 <0f> 0b 48 c7 c7 00 91 60 8c 4c 89 f6 4c 89 e1 e8 f6 72 fc 06 90 0f
RSP: 0018:ffffc9000c3cfad0 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff88801abf5008 RCX: 332bd7343f331c00
RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
RBP: ffffe8ffffc31c60 R08: ffffffff817401bc R09: 1ffff92001879ef8
R10: dffffc0000000000 R11: fffff52001879ef9 R12: ffffe8ffffc31c60
R13: dffffc0000000000 R14: ffff88801abf5000 R15: ffff88801214c000
FS:  0000000000000000(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560d7f0a4dd8 CR3: 000000004108a000 CR4: 0000000000350ef0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

