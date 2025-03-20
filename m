Return-Path: <linux-kernel+bounces-569122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6FDA69ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376EC4621BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C6207DE2;
	Thu, 20 Mar 2025 03:28:30 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137241EBA03
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441309; cv=none; b=uTrTdcHDQyylhkZaee97Z+g1p8AHiKZo8TfNH4Su+6viYEwRrT2tMRKN9kU9bxgfddPlTPubwHNBhdLquEZtur8c0QZz1Al3/RgzIhBidbiYeaNTNkgnDnc7Eup9mB/QnURqt3VnlIim78+lDah7o37qWNmQNVyYaGLCuS2n4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441309; c=relaxed/simple;
	bh=JLOL9AJQ2cnSXdz2CMf8N5vWGfKJ6GmWRVN03fA85Hk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wa2ta0/G41VT/VdXy6OUKQfgTMaXbNfaczp4gAQ4N6H6ojbvUoghqqW5DKo0KswJxi2YQ1AqwKT15VqGNhl99TjPBsLYzT2rqZP0kA+IjwaclbSErB9s92uj+PsptxHimezPb+m5c79kPXQ6H8EeJH/a4QyxE3NRD/WBOKDS/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b3a62e3e5so73211839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742441307; x=1743046107;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hecAEkEpOupHb2oLD0Zh2B0utuBtVCK9YGIDBVlwllE=;
        b=GB01Jpbh2tThAnDRRJzWrI5ORXDuhErGM+6V8WCkpLelU4u31m4Q58aC5ihA1v511F
         aDw6t6L1HCqT3bzoh4SQHsP5WNQoyBhkTLeGIDXXP9yxdmqvnw7b5aVNGJpaJdTA41Z+
         vG83PmVgV7j1tch/Wc1eIox6hhfRQF3DFBlsrenS0QPsr6IyG0lfp71Fe4RUW2kZ7u0B
         Ti0gltoBvZIaH+UzDJ3B00N55jpRSWDlNn0z9dO3gJy3bbvc5oIJniC6GowXb3kTQxZ0
         CMb5L+lbxji38+4++JhD+GgHcbCudz27MtbHSEzP0h9iNr/JM3+h2pOufkHIIMm2uXWC
         crSA==
X-Forwarded-Encrypted: i=1; AJvYcCWQMX1xi0cMfe4FkvXg1QkZekwhwELfdvHH+Eb7CIekCtNWn1AvSVHsEEEjxHFZ1jGDfWCHUTB3an4xaoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1JupkMGQQNFGT5o3MBoEHvhqDzSpPnrlAzXdbN3MCgAfllEZ
	FeAH/vaEfIg6JUaMZWJtHuVx5F3IXDL8REMoux3u6JnPeaAJxXm2ki03cyvkM4PLIrVWBg2fM0u
	aUH6FPUQNRVKU9QdHEHpnkBr9zEY+UaZald1bAZhx1xSQpH8JtiLNLOs=
X-Google-Smtp-Source: AGHT+IH2FH63ihr7KH8PHX4OwIbTm0+zipnw7sTZ8BDsGMrxsR8sA4b5DdQfTomhyQTgDAln6rbz9JOtu9oWrogpobyrchcjdtaD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d586b40c24mr59334145ab.7.1742441307205; Wed, 19 Mar 2025
 20:28:27 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:28:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67db8b5b.050a0220.31a16b.0001.GAE@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in __lookup_mnt / __se_sys_pivot_root (6)
From: syzbot <syzbot+de8b27abd23eac60e15f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a7f2e10ecd8f Merge tag 'hwmon-fixes-for-v6.14-rc8/6.14' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166a383f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33d372c4021745
dashboard link: https://syzkaller.appspot.com/bug?extid=de8b27abd23eac60e15f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/614aabc71b48/disk-a7f2e10e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d47dd90a010a/vmlinux-a7f2e10e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/418d8cf8782b/bzImage-a7f2e10e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de8b27abd23eac60e15f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __lookup_mnt / __se_sys_pivot_root

write to 0xffff888118782d98 of 8 bytes by task 20163 on cpu 0:
 unhash_mnt fs/namespace.c:1030 [inline]
 __do_sys_pivot_root fs/namespace.c:4456 [inline]
 __se_sys_pivot_root+0x850/0x1090 fs/namespace.c:4388
 __x64_sys_pivot_root+0x31/0x40 fs/namespace.c:4388
 x64_sys_call+0x1abf/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:156
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888118782d98 of 8 bytes by task 20164 on cpu 1:
 __lookup_mnt+0xa0/0xf0 fs/namespace.c:839
 __follow_mount_rcu fs/namei.c:1592 [inline]
 handle_mounts fs/namei.c:1622 [inline]
 step_into+0x426/0x820 fs/namei.c:1952
 walk_component fs/namei.c:2120 [inline]
 link_path_walk+0x50e/0x830 fs/namei.c:2479
 path_lookupat+0x72/0x2b0 fs/namei.c:2635
 filename_lookup+0x150/0x340 fs/namei.c:2665
 user_path_at+0x3c/0x120 fs/namei.c:3072
 __do_sys_pivot_root fs/namespace.c:4404 [inline]
 __se_sys_pivot_root+0x10e/0x1090 fs/namespace.c:4388
 __x64_sys_pivot_root+0x31/0x40 fs/namespace.c:4388
 x64_sys_call+0x1abf/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:156
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888106a31d80 -> 0xffff8881004dccc0

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 20164 Comm: syz.0.5594 Tainted: G        W          6.14.0-rc7-syzkaller-00074-ga7f2e10ecd8f #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

