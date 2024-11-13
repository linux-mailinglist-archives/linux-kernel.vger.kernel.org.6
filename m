Return-Path: <linux-kernel+bounces-407053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F59C67EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB59284C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E716EBE6;
	Wed, 13 Nov 2024 03:56:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAF3D97A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731470183; cv=none; b=CTAqcG75ONeIy2yO2jvRX4YzPGT4dy8LvPAn/w6/k1gFFoZZvazR6eSnr/VFWq4jtZCPqrPbDHiAZNKDg0I6e3bKtMfJM/XXsqO9tt9SOKJ/siO+iiHJBBqTp7ub/vmin+bG74hNj/PPmA5gtdBuDdbOVYY5ModA1C8np8Hsov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731470183; c=relaxed/simple;
	bh=QyeRiD2Zc5OmXZ+FV0onNiFhKgSWlgh3ixa+6QsyUvw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G/Bf9GBgGs7j2DO0PP9E3UFclcAMEOQwmDCX2NPNm3nycCYv1juBqkSnSd9hKwOFo025EgIiZB0Qs+O/+BK2QqXLMrauFQRTH6UTW30uFOfGLuAyr6ZUQaZPYEY1S5MHjTtpU3nyAa4ykaI6Z/ipBiXbCZKjfWScVS74Xld1rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so67733205ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731470181; x=1732074981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYtnAb/fwShogSs0U3bRjOeH6JXYU04J4UR3Tke7Sgs=;
        b=NgMtIelKumCwxZoN55faOw6EC9LYBldyi4sCXWeMOoPr9GNjfsAHPg+5nwCEVzN+1T
         YsyjT8uR4lMsHglbne6KdNkdgVAWFWXTpPNWQE4nC/McE5dYO+hwN9pF3FeFL+0f1Fax
         Z8gZ83f/FkphRUkkdDPaNRD2BAzQdV6r2nTwTe8VUEfDThYEM24f61jNzpwxI0byOiIs
         uIzE3GCkHEkZFRPSZCElcH6S7k9VXTTOXRT4ZYeHKxIiCPlRahDyR+fNFS6Z695AKPm0
         ObZImYu3fbiGjZok4LZE9Q57DZflMWGHXPor1ibAVI/Cdw/zhtMyKPn2g6c5GeMmqnle
         kBHA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUgm8fjUU8t54CwwaogZF4+N2Ab62oRNYYFd44ggw4HHFskdFF7jnCZt/MAsBZQu4TZGs62DftP1DOPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNFlrDnbZTMNnQ5lt0GgpiLMShv1emyq0Tn4F42UFDK9YQGkQ
	cLHgkq3YdAnAkgukSmMNXxDnU5HCHZK1lkwwVUXMwGJwt+Z4eDj0KHfnY1YV1dxqw252W3g9aVT
	GDX+Ibmd9YzsYU426gH8YjShsFg6l7DG+XxBiLPkENwB/G8FgyCoQX9w=
X-Google-Smtp-Source: AGHT+IGo9WdkMCFFeHbs38eL469iirk4Q9MdIU8puLrTz/ZqW8V+WR3IVuImHYPu44nkPugWWMnQDDxf8CNJ0bmuj92pc1QY1gn0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c07:b0:3a6:ab82:db58 with SMTP id
 e9e14a558f8ab-3a71578da60mr15489665ab.23.1731470181520; Tue, 12 Nov 2024
 19:56:21 -0800 (PST)
Date: Tue, 12 Nov 2024 19:56:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67342365.050a0220.1324f8.0003.GAE@google.com>
Subject: [syzbot] [xfs?] WARNING in mod_delayed_work_on (2)
From: syzbot <syzbot+3c653ce382d9a9b6fbc3@syzkaller.appspotmail.com>
To: cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1dce1f09380 Merge tag 'slab-for-6.12-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143eaea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=3c653ce382d9a9b6fbc3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/290169b0e6d0/disk-f1dce1f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e26fb82ee406/vmlinux-f1dce1f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d26ba056ed6b/bzImage-f1dce1f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c653ce382d9a9b6fbc3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8571 at kernel/workqueue.c:2498 __queue_delayed_work+0x212/0x250 kernel/workqueue.c:2498
Modules linked in:
CPU: 0 UID: 0 PID: 8571 Comm: syz-executor Not tainted 6.12.0-rc6-syzkaller-00192-gf1dce1f09380 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:__queue_delayed_work+0x212/0x250 kernel/workqueue.c:2498
Code: 0f 0b 90 e9 39 fe ff ff e8 8b 9f 37 00 90 0f 0b 90 e9 65 fe ff ff e8 7d 9f 37 00 90 0f 0b 90 e9 81 fe ff ff e8 6f 9f 37 00 90 <0f> 0b 90 e9 9f fe ff ff e8 61 9f 37 00 48 89 df 44 89 f6 eb ac 89
RSP: 0018:ffffc90002d5fac8 EFLAGS: 00010093
RAX: ffffffff815d3a91 RBX: ffffe8ffffc43440 RCX: ffff888028098000
RDX: 0000000000000000 RSI: ffff88805a2f1800 RDI: 0000000000000000
RBP: ffffe8ffffc43448 R08: ffffffff815d3c06 R09: 0000000000000000
R10: ffffc90002d5fb40 R11: fffff520005abf69 R12: 0000000000000001
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88805a2f1800
FS:  000055556c4f5500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdcb605fe07 CR3: 000000005d732000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mod_delayed_work_on+0x153/0x370 kernel/workqueue.c:2588
 xfs_inodegc_queue fs/xfs/xfs_icache.c:2158 [inline]
 xfs_inode_mark_reclaimable+0x7a6/0xf60 fs/xfs/xfs_icache.c:2194
 destroy_inode fs/inode.c:315 [inline]
 evict+0x7b5/0x9b0 fs/inode.c:756
 do_unlinkat+0x512/0x830 fs/namei.c:4540
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4579
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6b1bd7dcc7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4308da08 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6b1bd7dcc7
RDX: 00007ffe4308da30 RSI: 00007ffe4308dac0 RDI: 00007ffe4308dac0
RBP: 00007ffe4308dac0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffe4308ebb0
R13: 00007f6b1bdf123c R14: 00000000000380ee R15: 00007ffe43090d60
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

