Return-Path: <linux-kernel+bounces-169506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD58BC9A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E2282A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D11422AC;
	Mon,  6 May 2024 08:37:24 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089E1420D4
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984643; cv=none; b=YKeewlIys8YV87SvMmdFbdCSBjFZynmh4yx3StfeAr/jXlxQr1R5tXRT6gUnpMyWxyf0/GR4hJ10x2xN7XKb8Ag/BoK8WbeDvD+gP6lV3g2xFk6jx1sSN1JPbjFE8AETArlSsAsYLnyvAYuhd5GqfM7mkms8hcEX8q4JCUrG6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984643; c=relaxed/simple;
	bh=+zVCcftOzn5T4MkIsQcfmiuakSBDKTqSpKJSJeyu74c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TBH+P67oV6BivOWdz217HK3qD+4c7rSe+j789WjvTTBvgk7Fvb2JC6sDn2/j0SlNy/fzm6Du7H6FMs5Dz18uJGNGkDv4WbDEmpUGPVrM98tI5YdsS5qh/e7LNcL8nUE0u58n7afMRznG+7QVBZC669ux5w3a+J9MGJUl8h4ZpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36c886e1c82so18997005ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714984641; x=1715589441;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+eF0opQ1JlMK818tuxLj//4ryA6xC+i3fSCg7M1Sas=;
        b=HwEHll3Ljr8nxouW+I/AMMlgiXpST+MZZbdEwZbqiwbFs7FA+i6sKthUii75X8pDrE
         DH79xmEa8xq7Atuv2egS8ScY8LkqEH225kQPhtA+IS2YoBjcZ8RE2+OM/Z5TyU4FpwnZ
         bXWmCOR+YOSqa6bf5vfC7+KbQLEaYBimdxaDU9RMjRIk0wyu0YLa3V+M7DhR0DJsITCI
         iMZRICKYIRqmQk3BZKf4u4h7rrsZSDm42IDQSkcP9m91Nv+TfnCdZtZZj7SzuWjEoOX0
         Cx5ch2wxkUNX0gu4emc+T8LyQzh2uf2nZNopOtrjgXPquTiBCgBdcj/OgoBX8cClVY3j
         lOyA==
X-Forwarded-Encrypted: i=1; AJvYcCUeokZpjXJY7sMnWaTR0z1Kw3032f0Bl220O5yC+bhKhW0JpKpeL38VWTrFcsC9/A7lHHqChXghXel7mHiMqTagxpMpDPOfadiITKwg
X-Gm-Message-State: AOJu0YwREvNt3J4nPEzPluYU8E6hivA87PqRUGDDgDpDq797YF7tWunr
	53+74/TvTskgsg4K2Nx7rjwOq+ZzeFrdMmzI6DW/190Fv7cE4PR0MdKour2bFDiRK0Tam7LJk92
	d8S/xhdXZ5eD/zSz28GIUrca3yIJHnekV8wbM9B1wukx+NcAg4gKypQ4=
X-Google-Smtp-Source: AGHT+IF3jf426PUkx/vd/hMJ61A7BslLrfp+jqQoD2fdAO/j3GCA74/PXyS9/sDUctSmxQ7kbA4mtMKmb8WfbD+VLD5tsSJ/Tg34
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd0c:0:b0:36c:8135:8d5f with SMTP id
 z12-20020a92cd0c000000b0036c81358d5fmr183048iln.2.1714984641306; Mon, 06 May
 2024 01:37:21 -0700 (PDT)
Date: Mon, 06 May 2024 01:37:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005736990617c4fa63@google.com>
Subject: [syzbot] [net?] WARNING in inet_csk_get_port (3)
From: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1694d080980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=2459c1b9fcd39be822b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126c6080980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11135520980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de8551177300/disk-977b1ef5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df9f007c8e65/vmlinux-977b1ef5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d48b59cf19ca/bzImage-977b1ef5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5149 at net/ipv4/inet_connection_sock.c:595 inet_csk_get_port+0xf82/0x2530 net/ipv4/inet_connection_sock.c:595
Modules linked in:
CPU: 0 PID: 5149 Comm: syz-executor413 Not tainted 6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:inet_csk_get_port+0xf82/0x2530 net/ipv4/inet_connection_sock.c:595
Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 11 15 00 00 48 8b 83 40 06 00 00 48 89 44 24 20 e9 c1 f2 ff ff e8 bf 13 4b f8 90 <0f> 0b 90 e9 10 f9 ff ff e8 b1 13 4b f8 49 8d 7f 48 e8 98 c5 5d 00
RSP: 0018:ffffc9000320fd38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888029c16e80 RCX: ffffffff89429509
RDX: ffff88807f641e00 RSI: ffffffff8942ae91 RDI: ffff88802a9dc720
RBP: ffff88802a9dc718 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000004e20
R13: ffff888029c16e80 R14: ffff88802a9dc080 R15: ffff88814a520168
FS:  000055555730c380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0bd1307150 CR3: 00000000208f6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet_csk_listen_start+0x15e/0x390 net/ipv4/inet_connection_sock.c:1281
 inet_dccp_listen+0x1c5/0x220 net/dccp/proto.c:951
 __sys_listen+0x19b/0x280 net/socket.c:1881
 __do_sys_listen net/socket.c:1890 [inline]
 __se_sys_listen net/socket.c:1888 [inline]
 __x64_sys_listen+0x53/0x80 net/socket.c:1888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0bd128cd29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfa5275e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0bd128cd29
RDX: ffffffffffffffb8 RSI: 0000000020000005 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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

