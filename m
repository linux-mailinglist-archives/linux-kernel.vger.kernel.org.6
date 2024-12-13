Return-Path: <linux-kernel+bounces-444660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FBE9F0A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6A6188A78E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BD1D0E20;
	Fri, 13 Dec 2024 11:11:26 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822F1CD1EA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088286; cv=none; b=IM6EMJ6CE8VXe4scFVMTdm24vdVLZkPVZzH68E+kTLuGmwRxELQhqJisZvWKMyZ0izs1rhxc9rYkeQLDhzl23tVcafwr2gIKhDkjIduZkMIEEN2vVGApzQn2oXhXcHnCst4iby7MAsPbT0seq+WWetGnxsTnmaAY7pudgfrU+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088286; c=relaxed/simple;
	bh=MOOKxfmActURoqpSt/rMdhbSSt+smN2K1hpvPRBS85k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S5NsBOT4VAyC/OxgwF5SbXPy+gsakbK98lnZCPCSh9uU5MaoXftT3gcmWt0p9TeYTgskCYfhaCRxegycF1bveiBx1IUCnsVb96/ASZrd3VHU2r0c1otFlgfmq06XM/StrQmI/BAei85G1fx82ycO2p1NzeevLBMeKfDnQ47bKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844d02766ebso129563939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088283; x=1734693083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQjYnieclg71ht2eON5kKXaSbM7auxwW5GWSqjs6NI0=;
        b=jqHjXFkOYKb+xumfWwhUrR0lue6YVz5dk0NfsRfVDInhUcURpiJMRIrRHND9/0w6Nu
         XTJVQWXRuhA8CieqJ8Yqur4n+cWx9GOTPJizDSbT7Ie3R0JJ9+KVV8MwEcvC2d8Jsa+x
         b3FVoH+CzyK+duUDaaPykshzBhva1dl+Im05n6QyOfRe01IuHhI0SLdiIYioNhtxabUt
         Jro6UbB63lPWyTIGHbahrgExeltzbwWy3VaQ/2IECVzBi8EB3jzh5E/mwQqRk/owCK2b
         V46PP55ie5y9FANwLD4SqF/uBXMKu3MpfenJI2FA9LT8kPSPQdIqN2nOxTLgXQAkTMqZ
         KLAg==
X-Forwarded-Encrypted: i=1; AJvYcCUX2CNYT7xfM0p9fdmE5HNK854WtWrzGRXW4k8NfAuZScj6CJOi+gQCEw6PS5g41CVbs516pgepKv7bVrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPe7MZdjkZwkaaJfzQahHeIn+YO4obh/ebIIRFb1QEkpUUjr/f
	S7+pHDig55/7V40fWv5mjimjrt1Rq8yHVfjl0JscioyY00ZiVF/jVZTz4ZXXHOTibfwOFsNejLw
	xsnreUsRWNXNB8Ckp1BGrN54zuBBvOcLMYUcTsXMqt1tC2ngkZmvpgOM=
X-Google-Smtp-Source: AGHT+IF0f64JG62e05+TrkDGXEOPfsDKmncCE2MraFsy7qr+AHqys0LhBGrKyVmR/uO0mqB8TdvYNpJLi9SaJ4sPL1gr3fKAwDYT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:3a7:7ded:521b with SMTP id
 e9e14a558f8ab-3aff800f100mr19403225ab.17.1734088283734; Fri, 13 Dec 2024
 03:11:23 -0800 (PST)
Date: Fri, 13 Dec 2024 03:11:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c165b.050a0220.17d782.000a.GAE@google.com>
Subject: [syzbot] [io-uring?] KCSAN: data-race in io_recv / io_wq_free_work
From: syzbot <syzbot+a697a4754324488bacd7@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    150b567e0d57 Merge tag 'net-6.13-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1013cd44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1fe4854f351e948c
dashboard link: https://syzkaller.appspot.com/bug?extid=a697a4754324488bacd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05e47d657c7d/disk-150b567e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/568329a94d6e/vmlinux-150b567e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eab7b6a3d180/bzImage-150b567e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a697a4754324488bacd7@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in io_recv / io_wq_free_work

write to 0xffff88814248b848 of 8 bytes by task 22395 on cpu 1:
 io_recv+0x661/0xa70
 io_issue_sqe+0x150/0xc10 io_uring/io_uring.c:1736
 io_poll_issue+0x1a/0x20 io_uring/io_uring.c:1767
 io_poll_check_events io_uring/poll.c:289 [inline]
 io_poll_task_func+0x205/0x7c0 io_uring/poll.c:316
 io_handle_tw_list+0xe3/0x200 io_uring/io_uring.c:1053
 tctx_task_work_run+0x6e/0x1c0 io_uring/io_uring.c:1117
 tctx_task_work+0x40/0x80 io_uring/io_uring.c:1135
 task_work_run+0x13a/0x1a0 kernel/task_work.c:239
 io_run_task_work+0x1b1/0x200 io_uring/io_uring.h:343
 io_cqring_wait io_uring/io_uring.c:2594 [inline]
 __do_sys_io_uring_enter io_uring/io_uring.c:3434 [inline]
 __se_sys_io_uring_enter+0x14f5/0x1ba0 io_uring/io_uring.c:3325
 __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3325
 x64_sys_call+0xb5e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88814248b848 of 8 bytes by task 22396 on cpu 0:
 req_ref_put_and_test io_uring/refs.h:22 [inline]
 io_wq_free_work+0x24/0x1b0 io_uring/io_uring.c:1776
 io_worker_handle_work+0x4cb/0x9d0 io_uring/io-wq.c:604
 io_wq_worker+0x286/0x820 io_uring/io-wq.c:655
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x0000000085584038 -> 0x0000000085184138

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 22396 Comm: iou-wrk-22395 Not tainted 6.13.0-rc2-syzkaller-00130-g150b567e0d57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


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

