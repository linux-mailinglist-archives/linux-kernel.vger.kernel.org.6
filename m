Return-Path: <linux-kernel+bounces-342187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D09988B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C2C1F2106D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286771C2435;
	Fri, 27 Sep 2024 20:33:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78A381B1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469208; cv=none; b=toAVmOh0cO3IJhb7DvlchqE3f0QptlX5fC0WC5fBDYONGU7HE/KhtPChl8qHRi17uzjRuiy0VtYahCjzXJn3EGWfmOV2wbs3NagWNZ5n2JDQqckHimM8YLvteHAj9rbFw4Ug6pnxaCRWTOGUtQXy8E0r0hWTBR1zWNoLZyaSQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469208; c=relaxed/simple;
	bh=EHrh+O/6DgWMqPLABd0sjZFqvsgzvxXXltfL5sejALs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gp7qFIxwJBBFLT2ymYSU3tGzBqm7/BmZoLVxI/+fcQ/5U1yQErUEbFECOm6BwzTSG6vfEE10uitARnXeX+xcp3UZ4huEocbgmr6pPvb+/YvlVF1ezakJ+Jua8e43VKAWJVNxAQPFHO6tlBaEJvJk49HU6xC0K7REAX9YeAOZhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19665ed40so22144515ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469206; x=1728074006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L3sz7SYzXM19fy4H0OpvL/I4Wuxe1aJGx7ONwc/qepc=;
        b=Ea2KqYEY+vssUnhI3cNjk1SfAul+oWw3hEERqWYgZe3ACe0gfu4U/UX5DB9ifQ4596
         OeenDyzP1e2KOzgzx1KsjePUv5r/wqyVS2JC/RjwDFxvJV2rD74TPnGqjHEGtqWvliLP
         /HGi14+Qrrd9AIobuuFpuAP09/v71zjfFONoZFqcrGZw5kfeP/OQfdY8S4vv8xEP+OOA
         3YQhSJhUuK8TuregsRhiZvBnPC7OByXLR5I3prEQw1spB0MTacUtHQ0t+aUi3/zkVMTx
         xuelUJjK0F7PDwNoxigEmzOS3DmXthWN7XfK9YBU+8lfEk+rKahMT68DOlrnQ7aHjKU2
         abrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUICwv9tNd5JM4hUvXWS/ckYhhvKQhh5ZBaLoZztCW8wF7H6zVzJVmkdoiNXNO+fdMuzQ5KkcrkmMTGNo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZSq5w75uaOXMB94piXawTpilS5dDf47p0Eyh1dN9NFU6EJMe
	qOL4wLRDiZvW3bhIJTjc9XvkG10LjGHHt08Kh17ZPXYZtutWkDb4QjJGHyb7qBZDT/BjTzzQkj9
	vUDrycDioD/fZVihqzl8UWPt3O/eOJff7+r8aIxctQGFEoobmEwL5R3Y=
X-Google-Smtp-Source: AGHT+IEU+NTsx+agdZWl96iwWYPGyiudRKG31bpfraoKre4j67dQY1Sn5j7zFcDQLQJbK2XI6PeFzDy57iFdAF8QQvlf68AbSH+f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cb:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a344640bbemr35475245ab.12.1727469206327; Fri, 27 Sep 2024
 13:33:26 -0700 (PDT)
Date: Fri, 27 Sep 2024 13:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f71696.050a0220.38ace9.0031.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in try_check_zero (2)
From: syzbot <syzbot+5769bce04b3a8294deda@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40e0c9d414f5 Add linux-next specific files for 20240927
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b186a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a311a9ffbda5a19f
dashboard link: https://syzkaller.appspot.com/bug?extid=5769bce04b3a8294deda
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea0d6ab93926/disk-40e0c9d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27d031093999/vmlinux-40e0c9d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f406836af354/bzImage-40e0c9d4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5769bce04b3a8294deda@syzkaller.appspotmail.com

------------[ cut here ]------------
Mixed NMI-safe readers for srcu_struct at 0xffffc900037148b8.
WARNING: CPU: 1 PID: 5286 at kernel/rcu/srcutree.c:456 srcu_readers_unlock_idx kernel/rcu/srcutree.c:455 [inline]
WARNING: CPU: 1 PID: 5286 at kernel/rcu/srcutree.c:456 srcu_readers_active_idx_check kernel/rcu/srcutree.c:468 [inline]
WARNING: CPU: 1 PID: 5286 at kernel/rcu/srcutree.c:456 try_check_zero+0x3b1/0x3e0 kernel/rcu/srcutree.c:1083
Modules linked in:
CPU: 1 UID: 0 PID: 5286 Comm: kworker/1:5 Not tainted 6.11.0-next-20240927-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: rcu_gp process_srcu
RIP: 0010:srcu_readers_unlock_idx kernel/rcu/srcutree.c:455 [inline]
RIP: 0010:srcu_readers_active_idx_check kernel/rcu/srcutree.c:468 [inline]
RIP: 0010:try_check_zero+0x3b1/0x3e0 kernel/rcu/srcutree.c:1083
Code: 8b 3d b3 1a 19 0d e8 ae f2 48 0a e9 e5 fd ff ff c6 05 9e 22 8c 0e 01 90 48 c7 c7 20 12 0c 8c 48 8b 74 24 18 e8 c0 33 db ff 90 <0f> 0b 90 90 e9 e7 fe ff ff 49 39 cf 0f 94 c0 48 83 c4 30 5b 41 5c
RSP: 0018:ffffc9000421fa58 EFLAGS: 00010246
RAX: 860e4f5d8e8ca000 RBX: ffffe8ffffd35720 RCX: ffff88802d52bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffe8ffffd35718 R08: ffffffff8155d402 R09: fffffbfff1cf9fd8
R10: dffffc0000000000 R11: fffffbfff1cf9fd8 R12: ffffc900037148c0
R13: 0000000000000002 R14: dffffc0000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002013c030 CR3: 0000000020f7c000 CR4: 00000000003526f0
DR0: 0000000000002800 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 srcu_advance_state kernel/rcu/srcutree.c:1691 [inline]
 process_srcu+0x122/0x1320 kernel/rcu/srcutree.c:1818
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
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

