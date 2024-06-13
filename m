Return-Path: <linux-kernel+bounces-213727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7049990798B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1411F23824
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399D1494DF;
	Thu, 13 Jun 2024 17:18:23 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22A130A73
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299102; cv=none; b=aNLc3him0ktFuMmuVNHE/4SMNj8f0AvL+Oda8u5B0grWJ471KRHNQ7dyga7qw3ecmKdlJp5fBD96JY9lKMmllS2YSooUQ0CRoQ7/8MyqlS1Yr18i8PTtlcJKlUZ73EvBbrNEQads+EsdzsjGhlpyMqJlGVdbZD74rL1NVDA2SCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299102; c=relaxed/simple;
	bh=7jW1Pjc0lYkk43DI+WoCur/w2gyoKI27QU6xxfYjpj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JsIi+NHGwP78gtOS7On9xVBkXFfogU09Qx+a9esVIYF8C/dvb6wQde2TuP59pTz4SiWNUqXrcd55NOBFHfZtSzQ3TZCr2Qf1EZbJfLsE1lJNKZSPtzrQsTjz/p9Dl09AJULG4hwPXTusAMHtxKt2YUwy0M5SrDTVBLxOTeVmibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3759b8709afso13605935ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718299100; x=1718903900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMgu8aQxVMZ+LMmv02oVIsIixRIQXNFQ7WAWbWC/Z2I=;
        b=SpeOMaejTz7jIpu6zamgQ7o5Oe07wzyUIrjaerhJyFEgyHCo1Vnu8A5vRJ+NdxKg8a
         sUuoFZbnwDpsXgJpXwrMebqFQGEAXKHFdQRvEHr4zvWkMYtFIX9395PbuzcgLEdZchnw
         yhr7s44+H3+mvdGqJzxVvp+9wWHAbwa0g3PC2Fn4x3hLXEbrBUbFsjeiamyZ/S+m6KLi
         qP+J86GhDpBQZj/Qlu30Ll5gwYcOPU1syfJNf/YZ48GAgNaJTjpwEXJT+25Mmg6PxfSv
         y9fzjEoq0mZPXS2gB9rs+1m9g9WsEE1jHSmJfVn/CDXDA1mlkzEJ9oMSET8Ih5I094Y8
         Xkpw==
X-Forwarded-Encrypted: i=1; AJvYcCXD16rQmRTVJYtcrFm9D2EWjf7+FF6JThGKIlIi6CENEEBESXYyKIEXQfeauKfQsYHCDdiSvEabh7VvixHGfPYqxhD60ST4knxbcAyc
X-Gm-Message-State: AOJu0YzjMH4wfp8mlWKB4mrGJf0LyQYct+h8Ewz9numbu4SFMlJbJqnY
	1x9SYAxKrhW3dz6u50RqPVKimJpmRK+hGk7Ke9rv1956brMmR0hWqJ8wFFUnYN8YWX/BpYRFfBy
	L48QnxsKTrKc89bN/GXlRAkKd0UFRUKyR7XJUzbfT4HRowltQRfEVFso=
X-Google-Smtp-Source: AGHT+IH2MxsFbswtsyJvkjbZKpQ/wbCZB871HvQ5mhsuwt1H+N0druZrE9vERzAJP64WWvL8YD9u95bAXThAlr7P3HAMal1VBBuW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194f:b0:375:9522:1831 with SMTP id
 e9e14a558f8ab-375e108aa71mr89975ab.4.1718299100493; Thu, 13 Jun 2024 10:18:20
 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:18:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080cb46061ac8afe3@google.com>
Subject: [syzbot] [io-uring?] KCSAN: data-race in io_worker_handle_work /
 io_wq_worker_cancel (3)
From: syzbot <syzbot+90b0e38244e035ec327c@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1408060e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68336ea4b6f4fc09
dashboard link: https://syzkaller.appspot.com/bug?extid=90b0e38244e035ec327c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26ed33651516/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c0b763ac146/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be99b90037ed/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90b0e38244e035ec327c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in io_worker_handle_work / io_wq_worker_cancel

read-write to 0xffff8881070473d8 of 4 bytes by task 24619 on cpu 0:
 __io_wq_worker_cancel io_uring/io-wq.c:993 [inline]
 io_wq_worker_cancel+0x70/0x140 io_uring/io-wq.c:1010
 io_wq_for_each_worker+0x116/0x200 io_uring/io-wq.c:874
 io_wq_cancel_running_work io_uring/io-wq.c:1080 [inline]
 io_wq_cancel_cb+0x10d/0x190 io_uring/io-wq.c:1111
 io_async_cancel_one io_uring/cancel.c:87 [inline]
 __io_async_cancel+0x176/0x270 io_uring/cancel.c:187
 __io_sync_cancel io_uring/cancel.c:261 [inline]
 io_sync_cancel+0x5a6/0x6d0 io_uring/cancel.c:325
 __io_uring_register io_uring/register.c:543 [inline]
 __do_sys_io_uring_register io_uring/register.c:616 [inline]
 __se_sys_io_uring_register+0x504/0x1190 io_uring/register.c:577
 __x64_sys_io_uring_register+0x55/0x70 io_uring/register.c:577
 x64_sys_call+0x2c2/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881070473d8 of 4 bytes by task 24621 on cpu 1:
 io_get_work_hash io_uring/io-wq.c:454 [inline]
 io_worker_handle_work+0x41a/0x9a0 io_uring/io-wq.c:591
 io_wq_worker+0x286/0x820 io_uring/io-wq.c:651
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 24621 Comm: iou-wrk-24619 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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

