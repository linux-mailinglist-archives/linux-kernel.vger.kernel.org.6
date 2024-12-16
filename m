Return-Path: <linux-kernel+bounces-446991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A539F2BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF3E1883FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A81FFC4E;
	Mon, 16 Dec 2024 08:23:22 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDE1FF7C1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337401; cv=none; b=KdcY+hf91stItYBzkv5lLKwBgt/rVSJWDIxJKkalMfwsdG5d99OBtvOX9Ev8UAnlcukoMH8MkmoaRSsoKHq6pOqpeyJwR4GbqOeX3/AXlhVtsg5I0Fc1w64aEFgbE3fS9yCgNnNfVkytEGYirX4UlU/NBd2zKBfDqwzv7BeId+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337401; c=relaxed/simple;
	bh=O97EAk+bXbLnBnpBSvxqgDp1HZ8DE2vKvwYRBdPC6Fw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Svw5rz3fQfCqJ+LrPG3WdUVg2+aSAHqtTn9nV1vOG8yl8IrkfE/bRsBPmJ7Ny5Yg0oQAoAQAhKuYeqgsivqAdxl2xiZXmaHfjpb/7JImgun+5IPW+RtpeEZDIq3rtPCObkHVQKU+c+mu7OfvLrqg5QTdWXlfrul8HNw5g6ra7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ac005db65eso38374475ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337399; x=1734942199;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9n36S6z5mj0TWXJcEN9XIz0wzYr9wNoUoiN2ur/Mdg=;
        b=WBhGepIGcOhV1k+kjbNGTBHonT6tQrZaryrgLCRakpCWuihlBAx/HM+AQ1f6k7tkhT
         CiOQC67aCgAnsHgWSdAUemI+0WzrxwhDz0Ys4a6UMwR86tRt4YvKCMjFdOGPS9So934e
         my/Wy8rYUOSQ6Wud4uiUlmW6p5vanOQGm4Sg9C+YNOe9H96EgyBrk+8OZ8dfNoxFObPT
         LVkFW3OxlEKH3kbkzfQt0pfWj4uobG+XREaG9Lx9wIjVzei9YYbbWaEAhrbV0rcXRDLg
         QUodo5etS6R9VUCMBNd4vGzZceujbBmDZuGDraYdsJkL2Ls8ChwF4uT3PV9R2Bf/TLSY
         YDwg==
X-Forwarded-Encrypted: i=1; AJvYcCVy5wmsI6piCMCJWXeeuEPCTIlx/DxKvwHHhLDWdqu4anramSAAJYASVcIXouwuiTmkr2Q+7HUjHYAEz2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rXE2MMGPpQww/JdQ8CP5mBo6IozVu6lVstTzdLOwY9kyQijg
	JOOvYjjAHjV2RPHpyplT9bOLySd/Dl9ju4QH4infQr9i+hAdI4j6GPxMxmVNCYU9FmI9rCbUqLn
	i3HmyiPzeE5lF2A9Q3rrCfhSmAUfYbdd38up8zCnJdjLM9FTRcN0Wm4w=
X-Google-Smtp-Source: AGHT+IG2Gku6TbdLn2eGyjTmVVy+bU/HWnKvYD8DlwdVobR8f9bk7It46LQU2z1I9QYbW2mEszHARvmeSAbVZEqz8u8sVxx/Rxk0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:3a7:e8df:3fde with SMTP id
 e9e14a558f8ab-3aff756ee62mr107814635ab.9.1734337399206; Mon, 16 Dec 2024
 00:23:19 -0800 (PST)
Date: Mon, 16 Dec 2024 00:23:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fe377.050a0220.37aaf.011f.GAE@google.com>
Subject: [syzbot] [lsm?] WARNING in vfs_write
From: syzbot <syzbot+159f196c256dd235788b@syzkaller.appspotmail.com>
To: jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122b8d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=159f196c256dd235788b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a3fb30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1625ebe8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+159f196c256dd235788b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5824 at mm/page_alloc.c:4727 __alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Modules linked in:
CPU: 0 UID: 0 PID: 5824 Comm: syz-executor857 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Code: 24 2c 00 00 00 00 89 cd 0f 84 8b f9 ff ff 8b 34 24 48 89 da 8b 7c 24 08 e8 0e b3 fe ff e9 69 f9 ff ff c6 05 21 45 16 0e 01 90 <0f> 0b 90 31 db e9 9f f3 ff ff 89 14 24 e8 9f a2 0c 00 8b 14 24 e9
RSP: 0018:ffffc900038f79c8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 0000000000040cc0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000013
R13: 0000000000040cc0 R14: 1ffff9200071ef4d R15: 00000000ffffffff
FS:  000055555be00380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000779d8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4228
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_track_caller_noprof.cold+0x5/0x5f mm/slub.c:4302
 memdup_user_nul+0x2b/0x110 mm/util.c:305
 lockdown_write+0x2d/0x290 security/lockdown/lockdown.c:128
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc020062a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe51b53078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffe51b53258 RCX: 00007fbc020062a9
RDX: 00000000fffffdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fbc02079610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe51b53248 R14: 0000000000000001 R15: 0000000000000001
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

