Return-Path: <linux-kernel+bounces-352175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7E991B43
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7844F1F221A1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A71662EF;
	Sat,  5 Oct 2024 22:43:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7015AAC1
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728168203; cv=none; b=rMyLjAN+HERrJZa7EUFSyw2AZxF7+PhnVg5i1tsoxrAJs8vox3nUbz08xT6WoA4uiV7s8a3IxM/YcBGxF+CsO6s6fP/NuZr6PHiGAc15nGyIkHH7anpMnbQ5nJNQYadGYe5DXSLKPE+Iqih2lmrBE3RaLYloihVeERHpZ+rOmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728168203; c=relaxed/simple;
	bh=m/7+381k8oZp8Jlyg+DLJhTCF2UyUs1RawrKvdZx8/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tvTmBy3t3QO9m+OpSFKjUjTo4VxZ6VqkZ+XMbfqqeVg1B8xDZKYkklioNmAKZmjJtE3xmXv6Sw+3/5z1TzO3EvDxB5w3eJ9dTMDeaR/ua5wrDrsseutWRnExsp7AjG323LCSUQLUayeupvOIBhszK6SAm5EYNSNIHpLrmzXTvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a34205e146so43398645ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 15:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728168201; x=1728773001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+pYG4IJ9QOxdrXhRECn+ykRxVJf1RwDujYBszq3zp4=;
        b=QAMRLZ9zqLFH6M1GLCGCSfucQ0FR7toJktMCoMASA9hvR7Dv8YwslgmXO5EMNvZ3ll
         iwWqSBhw6ur6Li2Z3wjIhDk0evt994UkI0iy8IjvsdjdLqNQ2VbuSh1I9fsL/5D1mhpa
         SXJULk/2qczDgeWT1IC3eLSXiN8rhbk6sctkBWJ/iJqfaVw0upg8h9+yOq2j13E6veMC
         klUjc+MkpiAct4tYPmgsm/NX3OaWlA2QcXfmA1BA46VW6JrAmJuWUjusDyQZwsuhvYO7
         1n9zhJBkComWOc7kTI1k/Gf1RUMGA7JdlrGSri1GsQnCNb3ouj8Q3zodKFU1tm3L8wk1
         lFBA==
X-Forwarded-Encrypted: i=1; AJvYcCU45m7I9XEqLuckVKll9MfBYYlNPeT21dVfGQw5lbxtQRgYNkHaX0qJhPd8DQDFPGsQERwtblRhzqibUz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq7O+Hlpwv/12O1NcqxwySuiBfTTJI5bU4w6aHzIbeQpr4T1B
	4/EZ0bZRte7O/rJlLEohteQ3rBKZ3HxG0EsD/pIH6Kodt2AYyUTGm3BZNIN136n/el7CrGZwYNo
	Lowo2bcyaf+EGmOIKHsSJvi5rp3rNLHmG3Fdw5O8oQ1wxakwLi3bAcCE=
X-Google-Smtp-Source: AGHT+IFuyB1Q2GUZLLj7ApV+SXRkPmn718rYd67g/Q+gtSVRZOB60+J9/sVGcW9vQFIESYPYi8/F7VvchK50OSsUhWYTK4PIzoBx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a375994c89mr67981915ab.9.1728168200763; Sat, 05 Oct 2024
 15:43:20 -0700 (PDT)
Date: Sat, 05 Oct 2024 15:43:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6701c108.050a0220.49194.04ca.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING in ntfs_extend_initialized_size
From: syzbot <syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1201939f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f009dd80b3799c2
dashboard link: https://syzkaller.appspot.com/bug?extid=e37dd1dfc814b10caa55
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c8e927980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b7bdd0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08f3ba449e03/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17bcace1ab90/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da9183ac0145/bzImage-e32cde8d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0e40cc89da55/mount_0.gz

Bisection is inconclusive: the first bad commit could be any of:

220cf0498bbf fs/ntfs3: Simplify initialization of $AttrDef and $UpCase
2c2814d0dafc fs/ntfs3: Use macros NTFS_LABEL_MAX_LENGTH instead of hardcoded value

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138b539f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5234 at fs/ntfs3/file.c:181 ntfs_extend_initialized_size+0x907/0x950 fs/ntfs3/file.c:181
Modules linked in:
CPU: 1 UID: 0 PID: 5234 Comm: syz-executor337 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:ntfs_extend_initialized_size+0x907/0x950 fs/ntfs3/file.c:181
Code: 66 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 58 72 a7 fe 90 0f 0b 90 e9 ba f8 ff ff e8 4a 72 a7 fe 90 <0f> 0b 90 e9 cf f8 ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5a
RSP: 0018:ffffc90002eaf580 EFLAGS: 00010293
RAX: ffffffff82ed6916 RBX: 000000000000b5b3 RCX: ffff888029a61e00
RDX: 0000000000000000 RSI: 000000000000b5b3 RDI: 0000000000050000
RBP: ffffc90002eaf6b0 R08: ffffffff82ed61e0 R09: 1ffffffff2037745
R10: dffffc0000000000 R11: fffffbfff2037746 R12: ffff88802db18000
R13: dffffc0000000000 R14: 0000000000050000 R15: 0000000000000000
FS:  00007f62c31fa6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffee48b8dd8 CR3: 0000000076342000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_file_mmap+0x5f2/0x850 fs/ntfs3/file.c:368
 call_mmap include/linux/fs.h:2172 [inline]
 mmap_region+0x1add/0x2990 mm/mmap.c:1440
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62c32646b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f62c31fa208 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f62c330a658 RCX: 00007f62c32646b9
RDX: 00000000017ffff7 RSI: 0000000000600000 RDI: 0000000020000000
RBP: 00007f62c330a650 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000004002011 R11: 0000000000000246 R12: 00007f62c32d78c4
R13: 00007f62c32b80c0 R14: 007570637265705f R15: 0700000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

