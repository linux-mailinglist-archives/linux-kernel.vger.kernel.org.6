Return-Path: <linux-kernel+bounces-287480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7195283A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AC4286C69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086228DC1;
	Thu, 15 Aug 2024 03:20:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EA17578
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692007; cv=none; b=FRfEowBWoTkKla2cNAMeP1u2yKONPO/r2EB6dhTHWOpngVnNBrtyy5gUeaEQmm8efY6+b6LtLMo1yCLSFmwNTewb37IohYpPbPCwi2Gxf5Q+aj3TmgeU2T1pAUdPu3sEmYfBWUykpoT3Y1HlgfhEi95NIyoLpPJxC33nkjFeKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692007; c=relaxed/simple;
	bh=y0Yn2QfIx0obi8qKDupYL5PKbD1dfz23/0VUwm5qjsM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HvkcsOxIlKI25DzQjoWB833wMk3klt8/YOFsrLiF6mrrYPSl1VH7WjE/EDKJtv6KzqogIX2GVGq4eQpCick0f2spWC4HRTAr6iI95YrgwCBHJpl2tjKCoCQqC2Oj5tD26so49Vit2qpBVfsvqOSU8lwTda+AQcMaMvyCPZQhnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso157843039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692004; x=1724296804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oclIcwPIRwL0qUvuvDkNNQDwOdrjG6RSBXxlijx7ak=;
        b=JGRJLLe8FD8U0Hqd8ZPjn+1ga/K3kWRNnhh1ObVTX1e6e4lJAGvQgXSwgki/kLEWGV
         rVHqZt1eiBPFJb8Wu4fOyIXtdjA+aAw/Xqf6h4aae93kJMBk9PWZjzlWfWgpQHFuwJeG
         1hlyL8rHBvOeU29ufdsI+ycoMa+78XZ+0N1qteg2dzhmy2HEqm3/+HMlEIhtIUK40guW
         ubc/ULlv4x6CxSLPA+NFmXtFZUsifkKXTndVSV8L8Rfaup8YwlpNCx9F1tKKncVPXQRW
         pFrKYEnm7OfxDKe9nKiYgWuZ2tifrdnw5e9eRyD4IEMw49WYy4js6++JDsUj02cV6y/V
         DH2Q==
X-Gm-Message-State: AOJu0Ywoy2ixgoBrr6n3B3Go+OJQn1LkgFWQDbKJwki0iip68bji5IbA
	or9wthkeijzaHC66lX4iPjNZbfRLbqGdutDQVEZMet4jsgPQzqASrlCSUKl7J0hqXEODZ3zE7G8
	LRRLqUHK1DG9C34UOHofDQ52FyhEAVcpiqB5l+hXl99b03b/xqvLqxLY=
X-Google-Smtp-Source: AGHT+IFf1G49a+ft9MVhH7xqMNZrTefUKr4L3kxsS4F6KDranyMIvV5adUS45bZAiiOGOUa7oljHr6m55gAH//yZo7qN8QKaQvea
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:395:fa9a:3187 with SMTP id
 e9e14a558f8ab-39d1be81b9amr859775ab.3.1723692004619; Wed, 14 Aug 2024
 20:20:04 -0700 (PDT)
Date: Wed, 14 Aug 2024 20:20:04 -0700
In-Reply-To: <20240815030030.564798-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a34801061fb051c0@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
VFS: Busy inodes after unmount (use-after-free)

VFS: Busy inodes after unmount of 9p (9p)
------------[ cut here ]------------
kernel BUG at fs/super.c:650!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5814 Comm: syz-executor Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:generic_shutdown_super+0x31b/0x3d0 fs/super.c:650
Code: 28 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 aa 00 00 00 48 8b 55 00 48 8d b3 68 06 00 00 48 c7 c7 e0 5e 5d 8b e8 66 35 73 ff 90 <0f> 0b e8 4e e9 ef ff e9 2f fd ff ff e8 44 e9 ef ff e9 02 fd ff ff
RSP: 0018:ffffc900035a7d70 EFLAGS: 00010286
RAX: 0000000000000029 RBX: ffff888025fb4000 RCX: ffffffff816b0039
RDX: 0000000000000000 RSI: ffffffff816b9416 RDI: 0000000000000005
RBP: ffffffff8e438ce0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888025fb49c0
R13: ffff888025fb4780 R14: 0000000000000000 R15: ffff88801a1d3540
FS:  0000555587d56500(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587d715c8 CR3: 000000002c722000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_anon_super+0x3a/0x60 fs/super.c:1237
 v9fs_kill_super+0x3d/0xa0 fs/9p/vfs_super.c:193
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1373
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d0f3786e7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff76269ff8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5d0f3786e7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff7626a0b0
RBP: 00007fff7626a0b0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff7626b130
R13: 00007f5d0f3e4784 R14: 000000000001f21c R15: 00007fff7626b170
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x31b/0x3d0 fs/super.c:650
Code: 28 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 aa 00 00 00 48 8b 55 00 48 8d b3 68 06 00 00 48 c7 c7 e0 5e 5d 8b e8 66 35 73 ff 90 <0f> 0b e8 4e e9 ef ff e9 2f fd ff ff e8 44 e9 ef ff e9 02 fd ff ff
RSP: 0018:ffffc900035a7d70 EFLAGS: 00010286
RAX: 0000000000000029 RBX: ffff888025fb4000 RCX: ffffffff816b0039
RDX: 0000000000000000 RSI: ffffffff816b9416 RDI: 0000000000000005
RBP: ffffffff8e438ce0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888025fb49c0
R13: ffff888025fb4780 R14: 0000000000000000 R15: ffff88801a1d3540
FS:  0000555587d56500(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587d715c8 CR3: 000000002c722000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157a16d5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1347418d980000


