Return-Path: <linux-kernel+bounces-313352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F197896A465
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB343286CED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838818BBAD;
	Tue,  3 Sep 2024 16:31:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E918B483
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381085; cv=none; b=nL4RdQd48t2k4gTeef0CVm7mek4beNaTFcn0EAX5hStkXwrqjfDKPapNCZ1nlrTGKin2epeMwCqpypGnapYESA49pa8WO9kBAXX57xng7klpn/3MjalqUTyr7FoDagsy2ie4PA0ZNG7xXunzX4bhv7HVV+xb9LIT+vRnfxrYOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381085; c=relaxed/simple;
	bh=rwQd/DSFU1cEYpx3DrJS3YCXoJLRbG5wKH+cWotf/Dg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t/JFE/QElaVUKzVatzYgPi85mDGfqLRHTGzfigW0hUyalun4FayBGfPqAvA0J9M4w6MiHfc3NyOII4766MLpE4Wy4ulJ4H2ddhQGICZ14W2zNkhFJ8OhyONEomL/HbtxLlQaWeg9Zy50d8PLz/NL1k39xjvkCjwMc/rCgoC7xjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a217cec1fso608077539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 09:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381082; x=1725985882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9lUmc8PiwX7tT/XiNStv4jDeB7DqXTRrZAaapqeB+I=;
        b=Xd9l+wvUbihhD7/KvW8wj5KrJwdFWZRwwGLkrdPKdhl5p+6g3jmEwUMo3LayBPsZ/L
         mc74kyOzjMuheI3X0i2A+7gdZXeW+7VZ611pa/3C6zRxFT5brCePt+uNg4Vqy3eeFQuC
         4YTz+nULW0LSBnhq9ENzOV+GU6VhrNmPwgunzfIvJUqKL16RyBCbgn37IOpVFgbhLGPv
         Qwh0ikTKzn3t3CqYbEuknSmne8b5QKtjwDp8CSFEVWqYKdWwLoW8r2MsUuVmLmQGMloe
         5lViSOg8qVpe9mQHomlv9qrSodobEp2PqKiWvL35sqHFZGlYOHcwRc391qjDDUIOjFOp
         GxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbDk+2TlFCDRuLzxTCEeWwpZWtpqrs0imtpN4UN9WjkolL+6YaPzFwlIy/rWo/nlVRx8Fis/Hp0n52qiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISjoyCKYm5aEU4RQLgVXniHa/A381wqKHXfaehleoUmOjSGUe
	lc4EUuuhQviKzDunrfIzDs4uI2QQeOVSH2qDfqupbR+a2QMGeFjk1u+YVCgoq2+h2rqTdmcaXKp
	2qyoQJcSiYD9rqBwTFfjXHvD1sNVqTc6BIxADg0WoTs9F7Y6GnQxYabc=
X-Google-Smtp-Source: AGHT+IFvt6a9z5CbS0nBsvE+5AmrxqWO9GD1nGainp1nUikyXm4oJXPg131bxZBddkWNKSz/valcMeZ2AXwtYGHo3WD3ovGusqNl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4f:b0:39a:eb81:ffa8 with SMTP id
 e9e14a558f8ab-39f410c647bmr9079985ab.6.1725381082258; Tue, 03 Sep 2024
 09:31:22 -0700 (PDT)
Date: Tue, 03 Sep 2024 09:31:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082af9706213996da@google.com>
Subject: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_file_release
From: syzbot <syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c44115980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=8c652f14a0fde76ff11d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b64a9c98b9a/disk-20371ba1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74a875ea9e00/vmlinux-20371ba1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f49f7039e331/bzImage-20371ba1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5991 Comm: syz.2.92 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:975
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1288
 __lock_acquire+0xf0/0x2040 kernel/locking/lockdep.c:5019
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 ntfs_file_release+0x13d/0x210 fs/ntfs3/file.c:1252
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f240d179ef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeea9a7848 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001fffc RCX: 00007f240d179ef9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f240d317a80 R08: 0000000000000001 R09: 00007ffeea9a7b3f
R10: 00007f240d000000 R11: 0000000000000246 R12: 000000000002071e
R13: 00007ffeea9a7950 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner = 0xffff88801d798000, curr 0xffff88801d798000, list not empty
WARNING: CPU: 0 PID: 5991 at kernel/locking/rwsem.c:1364 __up_write kernel/locking/rwsem.c:1364 [inline]
WARNING: CPU: 0 PID: 5991 at kernel/locking/rwsem.c:1364 up_write+0x412/0x590 kernel/locking/rwsem.c:1632
Modules linked in:
CPU: 0 UID: 0 PID: 5991 Comm: syz.2.92 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__up_write kernel/locking/rwsem.c:1364 [inline]
RIP: 0010:up_write+0x412/0x590 kernel/locking/rwsem.c:1632
Code: c7 c7 a0 c8 ea 8b 48 c7 c6 80 ca ea 8b 48 89 da 48 8b 4c 24 20 4c 8b 44 24 30 4c 8b 4c 24 28 50 e8 63 9c e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 b6 fc ff ff 90 0f 0b 90 e9 2a fd ff ff 48 89 5c 24
RSP: 0018:ffffc90009567c40 EFLAGS: 00010292
RAX: 148f1a2880685e00 RBX: 0000000000000001 RCX: ffff88801d798000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90009567d20 R08: ffffffff8155b212 R09: 1ffff920012acf28
R10: dffffc0000000000 R11: fffff520012acf29 R12: ffff88805e500198
R13: ffff88805e500140 R14: 1ffff920012acf90 R15: dffffc0000000000
FS:  000055556ace1500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd10841fac CR3: 0000000063b70000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_file_release+0x18a/0x210 fs/ntfs3/file.c:1258
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f240d179ef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeea9a7848 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001fffc RCX: 00007f240d179ef9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f240d317a80 R08: 0000000000000001 R09: 00007ffeea9a7b3f
R10: 00007f240d000000 R11: 0000000000000246 R12: 000000000002071e
R13: 00007ffeea9a7950 R14: 0000000000000032 R15: ffffffffffffffff
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

