Return-Path: <linux-kernel+bounces-449719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA39F5536
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E181898775
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11A41FA15B;
	Tue, 17 Dec 2024 17:47:23 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6061F9F4C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457643; cv=none; b=DU4boDiliSlb6StR5IeJ8RAgjAMxP7EO8dhhlAJ/vWLHSoTZKNexYW2ABvkB0VT4JUMCUakEXXjd+ytd7fpFO5gMZriK4AfqgC9jd2dumh/n2/y9io4Qxr3hRbeszv0kmUBsqZFzq4PX9YYQukJ2k9a099oiC0r8f7qY2rJyxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457643; c=relaxed/simple;
	bh=rOMzSUbdv/gveRhTm2I2F7wnf7DGWlfucxbI3WoU1Hw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OWKWzmsw/7A4WVDS6/tqnF7quTjV29ahRhuTsL1m2wdSPwBo2OGl/c1t6FYCxY1RdHIe479U9ftGu2st+guLnsOqZ3TYBQ0HmOJ3WrodM4piJx3u9FIDIPzIeQOpluezQFRyIdDkJPVqyZl+ILnjQPNxcfEzY1JlVaiWF7YFRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a91a13f63fso54226345ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457641; x=1735062441;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IMCIZzAb/VwYOZoArVtfVey0hVqHrFpA05KWEERMbo=;
        b=LEQRQTeAsK4f8X0U/3CzvY0zVGh1V0JpB2tD/e4Xz6zcuAoblP15nOlAHmxYiTOY5Z
         z6Td5HC6J5AzWP3xBgNgkcl2NOLp++qT+GA3CeIRZV/VaU5cxlYN3O2ev9C+osk3Vpaa
         rBGEO/6wv37POMfQLXG9/fYh/rJuI2/1NKTTgLQfujN9a1KpoRuy9PO81IGdPGmolyKp
         tqllDaG9HRJKqV4Xqhs8K5zzKbCNv4buiK/TLU4ej5V+bNVEuefCtEardlhW4xCC7N1d
         xl2tY+jTan7e3svLYEeqXC9MxpamIMAQp4TaEm0EVLrwqMEQi/JZKHpEPpIy4IL9djKg
         BwGA==
X-Forwarded-Encrypted: i=1; AJvYcCW867ppkfCp1ettdsskpEVs2m4Q1pqcA2ZpHb+UVV2Vl0I6FTe8Wp/E50BlemI1TbhftXrnXLgsSJfLEO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbDsw83yWIqD7Sy2V8F0+xU1wC6kVYzsmSq3FC1pooibUiGBG
	/BGpenlC10Z5pt5BdSJKg63wWeuuQqv7mGI+ty3O98ectJskD77aCtFb/fSc+wx8fkmX++KdbWr
	ef3UVBFBu0gYK+pcD7jgt6R06e1nF/ubv83jxjKn+O2ObzGNRA4qv9lo=
X-Google-Smtp-Source: AGHT+IH5n14YjZ3FJypP+k/nHQvu8mjBqqTDefHjaHRFpfcFSgn7bHNBWUWC1o7dn12wubjiifbNJ/iDGv692gRzCa3pVO4Os9Im
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:3ab:71d2:9bd9 with SMTP id
 e9e14a558f8ab-3aff800ee22mr167151215ab.16.1734457640882; Tue, 17 Dec 2024
 09:47:20 -0800 (PST)
Date: Tue, 17 Dec 2024 09:47:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761b928.050a0220.29fcd0.006e.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_timeout (2)
From: syzbot <syzbot+fc4b5b2477d4ca272907@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129d5730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f282df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127e4744580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8be4151807d/disk-f44d154d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5f22853d301/vmlinux-f44d154d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7a4a78964e0/bzImage-f44d154d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc4b5b2477d4ca272907@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5856 at net/bluetooth/hci_conn.c:567 hci_conn_timeout+0xfb/0x290 net/bluetooth/hci_conn.c:567
Modules linked in:
CPU: 1 UID: 0 PID: 5856 Comm: kworker/u9:7 Not tainted 6.13.0-rc3-syzkaller-00017-gf44d154d6e3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: hci4 hci_conn_timeout
RIP: 0010:hci_conn_timeout+0xfb/0x290 net/bluetooth/hci_conn.c:567
Code: 4c 89 f7 e8 07 c2 09 00 eb 07 e8 70 55 e5 f6 b0 13 0f b6 f0 4c 89 f7 5b 41 5c 41 5e 41 5f 5d e9 5b b3 fe ff e8 56 55 e5 f6 90 <0f> 0b 90 eb 8f 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 36 ff ff ff 48
RSP: 0018:ffffc90003177b90 EFLAGS: 00010293
RAX: ffffffff8aba1e9a RBX: ffff8880310048e8 RCX: ffff888034bf1e00
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff8aba1e03 R09: 1ffff11006200802
R10: dffffc0000000000 R11: ffffed1006200803 R12: dffffc0000000000
R13: ffffffff8168ee96 R14: ffff888031004000 R15: 0000000002400000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cfa32a588 CR3: 00000000338ec000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

