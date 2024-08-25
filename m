Return-Path: <linux-kernel+bounces-300224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBF895E0CB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F99A1C20F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DBFBE49;
	Sun, 25 Aug 2024 03:15:21 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B625684
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724555721; cv=none; b=AnSLv42Hxmc2DbDGBnuAQCfVRMHt+Si6ssp95CYxMf5NPdMOrlt5XOTb67X5/BBBpLF4Zagr1GhCopOFRN1SVG6qbLqEtK2oQo6P3SIRXHY7ptHZA4HAy0TAbJ7h/bx/hyyOg/TU4n3UwFIleS72rs9LX7Mf/U7J/+xgQSU4yQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724555721; c=relaxed/simple;
	bh=RK5NfLsyx4eUhsXeDSvEl18nl5lCXp1CulpGwaImu5s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tu8a4N9OjpqRt06mVWngxOyYjR0wi2sh8zJu/f7Z6wPCJ3T0REqx3MHt/85fyXemfa6K4SqT7cnmM6WkUtzBjcW8V/nI4VLLt8NmQ4kZdOFPKKj3J2XFVPSUzR6kD925ScWUxR9Jp2dDdYfqW7mumpU9cXXzDEn4m4ni5NoJnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4cef7aa7so35459165ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 20:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724555719; x=1725160519;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWkUy50VSZCVMxhPPIPKFCnvvr9xmzUrWiRrVivNeWI=;
        b=nkN9ciwOoklif3ndW1oYJAseANgq3HwFXiWW/8qL+Y+PhPXlGuchsdfeLvvfnagM3n
         Yyli2hTguRxxqjS1pZ7OcIAYVYyoocLUAWpevvtVjTdtPT7xqw5ZFyYMCx0AfFhZPvGi
         /tSEdxgGqAaWyq5puarDwlw3MCN2I3A4Dv24ybINy66eFz2MgX9gezC/XpuRworcNkI4
         rzJ27aGVriirBoGNneHEDplCrjbym55Qn721q3GfhKhsd3DidWYy5f8xoIFQuDcRjWWp
         rldXl8jEcPVzmseHQJo/zivlOBETsH2BbXs2bVLbIK2iJQGhdaOiJihjgFWhU5tKF+j4
         skZg==
X-Forwarded-Encrypted: i=1; AJvYcCVXeuteSP5ji3XWxD6o6Dufv1fKC6ofjDLRCkCahou/ch24YKBf9e+gZm2BVlknahfYuH0r+oqPhWWVnEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQ9v8tW7Ga9Vw3faPMdkYo6eMKURymVQvehqWvbWzO6DWtQ1k
	zT+q3GL2Hfn2AdQxWMXDTdQRltLGzVcQOwnkjpa7iSKKk/SNdWrQAEm4PoaPrKcJ9oYSDuHlE4j
	b9U4DrOOg+c36MRYY1n4PrlQhcigwMTwmTQGRbeZeOpFulqg46HkEKdo=
X-Google-Smtp-Source: AGHT+IGPJdMqpneQMbl9tfnMnbyjtwds5MJLvjyeXxbxE3Dny2XA8kV5JhbaSqgM3LQ+7nMUmT0pcnuZ1zjbE5J1mPqWBiGO44eF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:39b:3c0c:c3a4 with SMTP id
 e9e14a558f8ab-39e3c985c48mr5170605ab.2.1724555718791; Sat, 24 Aug 2024
 20:15:18 -0700 (PDT)
Date: Sat, 24 Aug 2024 20:15:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003a7ed0620796b9d@google.com>
Subject: [syzbot] [io-uring?] WARNING in io_sq_thread
From: syzbot <syzbot+82e078bac56cae572bce@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bb1b0acdcd66 Add linux-next specific files for 20240820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1363f893980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49406de25a441ccf
dashboard link: https://syzkaller.appspot.com/bug?extid=82e078bac56cae572bce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ebc2ae824293/disk-bb1b0acd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f62bd0c0e25/vmlinux-bb1b0acd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddf6d0bc053d/bzImage-bb1b0acd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82e078bac56cae572bce@syzkaller.appspotmail.com

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff816d32e6>] prepare_to_wait+0x186/0x210 kernel/sched/wait.c:237
WARNING: CPU: 1 PID: 5335 at kernel/sched/core.c:8556 __might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
Modules linked in:
CPU: 1 UID: 0 PID: 5335 Comm: iou-sqp-5333 Not tainted 6.11.0-rc4-next-20240820-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8552
Code: 9d 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 3e 9d 97 00 48 8b 4d 00 48 c7 c7 c0 60 0a 8c 44 89 ee 48 89 ca e8 b8 01 f1 ff 90 <0f> 0b 90 90 eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
RSP: 0018:ffffc900041e7968 EFLAGS: 00010246
RAX: 11f47f6d1cba3d00 RBX: 1ffff110040802ec RCX: ffff888020400000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888020401760 R08: ffffffff8155acc2 R09: fffffbfff1cfa354
R10: dffffc0000000000 R11: fffffbfff1cfa354 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000249 R15: ffffffff8c0ab880
FS:  00007ffbe99d66c0(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffed4fbfdec CR3: 0000000024c2c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
 io_sq_thread+0x1310/0x1c40 io_uring/sqpoll.c:367
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

