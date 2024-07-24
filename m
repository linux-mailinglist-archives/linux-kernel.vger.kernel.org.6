Return-Path: <linux-kernel+bounces-261369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1993B66F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71CB1F23B26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24116C685;
	Wed, 24 Jul 2024 18:05:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC516A955
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844324; cv=none; b=LAwhgz/07sOcBIpFliOP7FkDNO/ArXD5jwJ7KFNLC+SkBv4zT7rp6wRYk69RAnbeh3kaBJK+bYU8mzpYiynwJpcUxc/g4+Loy9EX/SbY62nseN4HTOAyGy49ZBdf9uS3RRuIcbP0SqHEcuaM+cyussCkRY8Jso4KqzQDo/6O89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844324; c=relaxed/simple;
	bh=AYGehol+aeVlGQgJciYY5r7QNZI3q7QYtuhTKBuZ+9Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QD85xxFcrUWVyAzOMXH7NR+rSmG5t5DgwgfMRBM0OPpJZT6Wwwq1Rhq4VvCBYb3HPHys/Zg6UTAs3I2t/ktxiO7vaGhso6xrshWSq9KgnOKuKvwxqMaV0o6CWNgxAzSMtXeXcSEnkYcaR/9fx7bBWAcTutmLcaKZ0xSjPCtEczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a1ba36524so151145ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844322; x=1722449122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEoF0zVZhiq5H6p01VB2UQ3xDmiLnSL9RDzTN9njhVI=;
        b=xQlKdwxzPgmzPsMW6Ookcm3qwmXJQfZPCnikFBrReuSKF0gVflhXKwkEZAcUN2j7vZ
         uz2gMz9HLnEdMg2X3edW4ag1EO+nFpYGMl3Cx1VVhsT6Unug7AfdUPIXRaX1W9DxDEer
         kQehBa1mKUeOolkOZlO+YB/JyABt9m3b6STqUS4PEIRzh9+RVcd3gJGqfbVAoNqA+de4
         1dEuCCAjs+0TVskhdtV6A68z2AyGeji4Xs9sV/N4ZY1Y/DDSlMYMgRDSurUjwizIQgT+
         IGhhMgOQbRw1kLWGLiVvqY6Jyc6XZEFjKiBoAwXNoGg2BXkxq3f0SSRkdsSNtFLrciLK
         414g==
X-Forwarded-Encrypted: i=1; AJvYcCWUCbxA3UkSFi7J6fecoSyDQjcbF3l7e+Mn0svR8m6Uvp2wthmsiYKfMsswIMgQs+Com2PuUf/RYyG7Vc6E83EERShr55BcznmSOWcF
X-Gm-Message-State: AOJu0YxxL1CGnHG0AtnOtrJSYYL3U3qrgP7FiqkFucPd3wKsIl/GZSZ1
	GquRNq5/Mn4POMOyMSdPTaalBPAslt7vkjfff4M4vxuKX0IcUeOKcL7T/ShbulmnN8Nt2BAgPjN
	aUu2WxVuOOE4TthSxtBDnsJN6j2Ms7UMOvjsxULTStPxJJxKLMueqmBQ=
X-Google-Smtp-Source: AGHT+IHsVUCQhQIN404V07V2jB3iVrhLHqUph/Y69Ynxj4UsOfHPjt7poHUwgaAhW0Q8mOb2MFNsspii0XCpvAhUziDALw9Piwe9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152b:b0:397:35d4:3811 with SMTP id
 e9e14a558f8ab-39a21808fe4mr470825ab.3.1721844322226; Wed, 24 Jul 2024
 11:05:22 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:05:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f64da061e021fc2@google.com>
Subject: [syzbot] [jfs?] kernel BUG in jfs_unlink
From: syzbot <syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ffb6b5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=41b43444de86db4c5ed1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c29a41eae6b/disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/938da4f6bc30/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f9521f6c1ef/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com

BUG at fs/jfs/namei.c:513 assert(ip->i_nlink)
------------[ cut here ]------------
kernel BUG at fs/jfs/namei.c:513!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 9192 Comm: syz-executor Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:jfs_unlink+0xafd/0xb30 fs/jfs/namei.c:513
Code: e8 18 6f 6a 08 e8 53 c2 76 fe 48 c7 c7 e0 96 02 8c 48 c7 c6 a0 94 02 8c ba 01 02 00 00 48 c7 c1 20 97 02 8c e8 d4 6f 67 08 90 <0f> 0b e8 2c c2 76 fe 48 c7 c7 e0 96 02 8c 48 c7 c6 a0 94 02 8c ba
RSP: 0018:ffffc90003367be0 EFLAGS: 00010246
RAX: 000000000000002d RBX: 0000000000000000 RCX: f6009ee609a28400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003367d10 R08: ffffffff8173a15c R09: 1ffff9200066cf1c
R10: dffffc0000000000 R11: fffff5200066cf1d R12: 0000000000000000
R13: ffffc90003367c60 R14: 1ffff9200066cf8c R15: ffff88807a381fd8
FS:  000055558b529500(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f20933a178 CR3: 0000000065f88000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_unlink+0x365/0x650 fs/namei.c:4422
 do_unlinkat+0x4ae/0x830 fs/namei.c:4486
 __do_sys_unlink fs/namei.c:4534 [inline]
 __se_sys_unlink fs/namei.c:4532 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4532
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbcb13751a7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb18f8828 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbcb13751a7
RDX: 00007ffeb18f8850 RSI: 00007ffeb18f88e0 RDI: 00007ffeb18f88e0
RBP: 00007ffeb18f88e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffeb18f99d0
R13: 00007fbcb13e344c R14: 000000000005216e R15: 0000000000051cc6
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jfs_unlink+0xafd/0xb30 fs/jfs/namei.c:513
Code: e8 18 6f 6a 08 e8 53 c2 76 fe 48 c7 c7 e0 96 02 8c 48 c7 c6 a0 94 02 8c ba 01 02 00 00 48 c7 c1 20 97 02 8c e8 d4 6f 67 08 90 <0f> 0b e8 2c c2 76 fe 48 c7 c7 e0 96 02 8c 48 c7 c6 a0 94 02 8c ba
RSP: 0018:ffffc90003367be0 EFLAGS: 00010246
RAX: 000000000000002d RBX: 0000000000000000 RCX: f6009ee609a28400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003367d10 R08: ffffffff8173a15c R09: 1ffff9200066cf1c
R10: dffffc0000000000 R11: fffff5200066cf1d R12: 0000000000000000
R13: ffffc90003367c60 R14: 1ffff9200066cf8c R15: ffff88807a381fd8
FS:  000055558b529500(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcdd237ef0 CR3: 0000000065f88000 CR4: 00000000003506f0
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

