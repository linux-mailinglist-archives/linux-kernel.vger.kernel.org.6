Return-Path: <linux-kernel+bounces-214876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BF908B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEC21C22A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E51990CD;
	Fri, 14 Jun 2024 12:16:23 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B627E574
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367383; cv=none; b=Ron7aQ7f5biPWbmJtGIgQ8lrR9ghPmjoPPg8Hgnd0NMoJjb+DhiiXlM7AZcyh474GJXDKIoPDoiEMccV6JVA3ngQHm+j6H1llA1q2sQ72UHAR3VvIfDr7nXgGcJwKtluwfmVEqKX+LXOdcz2EHbzGUyDyLBJ8r+9vLA43HrOCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367383; c=relaxed/simple;
	bh=U8YWLxmPHt5Hzr/gUvcjRRL+ThBnjct/4VL62UVYJeo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nw9LdbeLIyCo2RvRVTQZ7A8A+u3bP5DWy23E5FcL+xUaX22R7qa5tkJLpSTtP0MdIo3DMxb5JdI6JwdGe2ZPh41nPdJAJ+vNv3qB1Nltmlc8wA9uzUT+3FdXmnfXkEeVdKZhX04Q1sLtVggunzaHOaGh5+xibo54RQuJY/F1bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-375e45a4110so6161015ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367381; x=1718972181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+dI/iBtYvYG57frDDmvIwI4ngnHcMQbLtHXu3/qXnA=;
        b=IF8vh0prnHq7R05q9BxkKZ5CgSdcyWjlzwXi8Q0HhDbx8UyTBUBLx2gSgm/I0YufQZ
         bNT+ZuK7RFH9wv+rPhf+O0AUzCwdWchaT9Y61EFOjMLEP/R5glQ6A0Sv00lt6zyK7hqi
         B9IVWH+6kx+RUf8QtMtRya0kP+5hngKd28edwT1unNnIqO0ZMUj8pHqzspMzb5yyC0Kt
         ZeR+oOTCUdQGM1bhNuiT0WRbXLBHvBJNXggWRT/uzoWBBQ1HpV+1TcPj7WzIa7Zx4iBA
         qJNzjLbKovrAWoyvJWGxEKEk8l1vbknPInqERGuxLZLvl7gMtlzrtmxYF3xQdAYt5l1G
         fX2g==
X-Forwarded-Encrypted: i=1; AJvYcCXN09pCJIAVq6deemBr5xaFchrVy5myBp+3BNVHudk14gIaFvOKgzzpmcfy07fu3OFe1IP3hcf/qfbCxG0aglYPaLmeY21UFKx6Zuqd
X-Gm-Message-State: AOJu0Yytq5lzPHtbavfyyQd7jfPuDNl/Cf4zciPYx+9j8x/Bkf8eNPkU
	UQXyHw/wI2SjzZ/jcPpKUL4JHf2bWFZPPNf261oEz+NtWxKNAHPw5nqRgvZZdzWZVcq0Cn070UX
	FHxkLRGnX+unWtFNI2HhneKp+cMgsauOzFbuL22l6OXomsWkH5E+KLLU=
X-Google-Smtp-Source: AGHT+IHD+LQvL5CaBGJGu/9sgUT8gCJ5Ym9xdoCgM/kAwzi9aM1Uw6yhF96jJSrvTq8cL1NHa96B5wGdYw/a0Crk7p+qJwtlewwk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a85:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-375e10df572mr1037025ab.6.1718367380815; Fri, 14 Jun 2024
 05:16:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 05:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053e574061ad89521@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_fs_read_write_early
From: syzbot <syzbot+4366624c0b5aac4906cf@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1689a256980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=4366624c0b5aac4906cf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110cda0e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164f91fe980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c40c1cd990d2/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2a94050804e/bzImage-2ccbdf43.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a79f654b4644/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4366624c0b5aac4906cf@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 10 at fs/bcachefs/super.c:525 bch2_fs_read_write_early+0x8a/0xa0 fs/bcachefs/super.c:525
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: bcachefs_write_ref bch2_delete_dead_snapshots_work
RIP: 0010:bch2_fs_read_write_early+0x8a/0xa0 fs/bcachefs/super.c:525
Code: ac b8 76 fd 48 8d bb 78 02 00 00 be ff ff ff ff e8 0b cd d0 06 31 ff 89 c5 89 c6 e8 90 b3 76 fd 85 ed 75 c7 e8 87 b8 76 fd 90 <0f> 0b 90 eb bc 48 c7 c7 58 a2 e4 8f e8 c5 8b d2 fd eb 9b 0f 1f 00
RSP: 0018:ffffc900000d7910 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888041080000 RCX: ffffffff84172cc0
RDX: ffff888017e90000 RSI: ffffffff84172cc9 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 1ffffffff272c7ee R12: ffff8880410801a8
R13: ffff888041080ae0 R14: 0000000000000001 R15: ffff88801f971800
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555581085788 CR3: 0000000025a9e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_delete_dead_snapshots+0xfdc/0x4e50 fs/bcachefs/snapshot.c:1569
 bch2_delete_dead_snapshots_work+0x20/0x160 fs/bcachefs/snapshot.c:1690
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

