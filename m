Return-Path: <linux-kernel+bounces-342388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18094988E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B41B282A52
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C195719DFAE;
	Sat, 28 Sep 2024 08:06:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54F19CCFC
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727510792; cv=none; b=RDSYSEz5XvYhC/TOM7AIwhfm7LBjqMiOnnRPcBXRfhO/1QNvZctvhBmmhd+SB+WT/jwoWZpiHkiL0yr/d5fu7tbXy8LmqTO9nZFGuMi+BTU2bIZPt/6dIOolVaVLNHtlb+OQXR64LLzotHDSS4hHdAMxo0Vy4dy49+pw9nfo64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727510792; c=relaxed/simple;
	bh=5HvKIToOpfvtVHl4/V8wqBxcCs21o8pslg/0WnReff8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FyFD1PhWIyCckaxdFLNm0vJtqkXov6m8yXD3FQ6kMQQYXJvisiRt5ccxzF5J/5iLeUdHmZEnK7lb4iEl0um4mlR/tWl+DOl8eTtLV61UySpetn0JN7r6pe2lAG7RzD9yoWXI+xjXHXfrRb5eKPyY3tLfFxFrydV1amYFY4gruHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82ce2629e40so275869739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727510790; x=1728115590;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptAZ5UsUbT/mI9XqcEKbMYqfXHPrppP/kswMc/D43Bg=;
        b=d1QX1qZx1XC+1WGMUAR9Q7yFV/Ck1TL7InnFLiGpToYBPuW5lJhXngFrZGC86REwQA
         qy31Jh/GN/g+i6uZKNATujBq+ZrlNI+80qtPMKzS7GcM6WDICTHsOBv0knidTE7/QkNE
         H+9Kk14w6I1pKwB/976LJaaQvTK+JvApV7hOWRja4sMKpM1e6i9TorWmi+41NETuoltT
         PgHTSgPsHiq6L8zdnrPMNt/jOaWwUKDTH4tf5ugCY5IFIUJAxculyi8FuMtEJoXth0q0
         87cQj3WUqPbccWMGgEwIGTMSvzbeaoQiqmFC2acBgK6Tdn+eht705y8eEraynj850vXP
         fu5g==
X-Forwarded-Encrypted: i=1; AJvYcCUo9SY6plLr2UI9oGboBgFF7B9CV1bcVzOt/2SY32m0pFXhr1JLt8jxgR1KL9y050NvvuRjn0PrWu3Wm9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsTsQhD9MH6F7YTEfp/9WKQGwrDMRIXFeCrC9vBCqUImQtWEP
	b019ygnmUTCu6YYKB4VSGtugMb+t39cr3/ST/JbJ4SfCuIngUELnO2fYCgHzKG4LsMkKNLDCj0o
	pt/bXYnY85IYoIhc7eXGuWWTdW30ltYd9e0SQ7r7bqvn9w+tut1dPuiM=
X-Google-Smtp-Source: AGHT+IE/owp9vwno2uuP6DYQ/HjHsVzeHfjrqDSYOlPk5TvRcu/BE0xMtSlGyp2w76dcC+fL7AgAn6jyNOoWYhUqIKRqUi9/bIRp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:3a0:be93:e8d5 with SMTP id
 e9e14a558f8ab-3a3451787cfmr50247495ab.11.1727510789982; Sat, 28 Sep 2024
 01:06:29 -0700 (PDT)
Date: Sat, 28 Sep 2024 01:06:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7b905.050a0220.46d20.0039.GAE@google.com>
Subject: [syzbot] [fuse?] WARNING in fuse_request_end (2)
From: syzbot <syzbot+554c4743d0f2d52d990d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d0326b60bb7 Add linux-next specific files for 20240924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=119dc99f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=441f6022e7a2db73
dashboard link: https://syzkaller.appspot.com/bug?extid=554c4743d0f2d52d990d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5461991c7c3f/disk-4d0326b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d44fd40ed13/vmlinux-4d0326b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25eeeb66df29/bzImage-4d0326b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+554c4743d0f2d52d990d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5282 at fs/fuse/dev.c:372 fuse_request_end+0x875/0xad0 fs/fuse/dev.c:372
Modules linked in:
CPU: 1 UID: 0 PID: 5282 Comm: kworker/1:6 Not tainted 6.11.0-next-20240924-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events close_work
RIP: 0010:fuse_request_end+0x875/0xad0 fs/fuse/dev.c:372
Code: 89 ef e8 4e ab e9 fe 48 8b 45 00 48 39 e8 74 0a e8 80 e9 7f fe e9 28 fc ff ff e8 76 e9 7f fe e9 79 fc ff ff e8 6c e9 7f fe 90 <0f> 0b 90 e9 a9 fa ff ff e8 5e e9 7f fe 90 0f 0b 90 e9 dd fa ff ff
RSP: 0018:ffffc90004297790 EFLAGS: 00010293
RAX: ffffffff8314f984 RBX: 000000000000028b RCX: ffff88806288da00
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000000
RBP: 0000000000000080 R08: ffffffff8314f428 R09: 1ffff110062c1738
R10: dffffc0000000000 R11: ffffed10062c1739 R12: ffff88803160b990
R13: 1ffff110062c1738 R14: ffff88803160b9c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f570e302d58 CR3: 000000002d052000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __fuse_request_send fs/fuse/dev.c:475 [inline]
 __fuse_simple_request+0xaad/0x1840 fs/fuse/dev.c:571
 fuse_simple_request fs/fuse/fuse_i.h:1156 [inline]
 fuse_flush+0x69d/0x950 fs/fuse/file.c:542
 close_work+0x89/0xb0 kernel/acct.c:206
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

