Return-Path: <linux-kernel+bounces-241263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21992792C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3531289EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658221B1216;
	Thu,  4 Jul 2024 14:47:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC61AED55
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104440; cv=none; b=irmDoDkCnIooW95pOc1yUexws1zQ63IKjLs4NPahdc/ow6EbIpqPxQ5MDhF5ybCmS+4BY9qPC0Y62O6CNL2I2A2oTB2/IqJSGskWMMRAkYN93TqMLX1SqQtGMnR0C0jlTSHjPOqCS629evdiq/jjdZDadXlKx6c4hMe7yg8zmC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104440; c=relaxed/simple;
	bh=mKJEdtfgtNHLPNeIxF/yyJ+ok11uYMXQ52udbtEI/+g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TIH1EH4dGT3X0kLC0WSiZKtWOiGUxabMVeNSSiKejSVlt8IqGrrnJYPJ5DULKV9OUBY+Wpl5Dp4mv8sZbhT1vTM8T3L5Vs499UGf2bPPuig/Qzdj+Q6gW90gCauUKvlTpC2BKnIUh3wNgZe6celZuEniGJHpSc7drvqYB/mifTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso97493739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104438; x=1720709238;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohQa7n5+IzRxUzEylvcAfArBfXNj22/IRNDp4dw7rRE=;
        b=ij7hkqgHFv/JQiawv/jn8PYolPAhuFGnZPIRc5/fiyVorwb2j+/Ilr/OHXqQ/v4Ow+
         Xs/E02HjSQE4fih3bWW47KNHMvfkOJD4uyFTN8FIKBibCdinOBawLmAERAvjaCxatJ3R
         CxwcIyL7eduzqCyh5+I/1qTBTCC/EJmiPVMr7scUlSZm+i/0ojORI8MoFYcCZJfs/BdB
         IzTnK2LQudHjCkIBnFbJR/ODZEAaqJ2gDWOwEb9jgkWwEIGSfm9pv7kw7j8SQ5m0KVan
         jQ3Td+hj35ma2PEmIixdyu9EHKbRini9WwaUWoXpIy5i0xyPPImBfVvdIxKgFFN2jJzY
         dsDw==
X-Forwarded-Encrypted: i=1; AJvYcCUw3KfEncCzOaY/F1lgKPdKsZpdJx0mQb/3kxFEb9lM0gimifKIwj2G7RuBV6vFeKbkgkDxbYbVDikmpHdg9xotERfPVDDn9axYsdAs
X-Gm-Message-State: AOJu0Yzvkk1prqlefZkMrjOjTx27+N9AKnVl6sVk6aAWXGXzIXlUEC4u
	gEeuUzTz6QUQlIfb4Pi1m2OnWeUyRnnMmupyePSySsfhz62CTwtV3dQsb/n9wHFyYQOGTmktDkA
	7KZ/pqAoEDsK71fYvmA/qt8BhsJnozEJrqxhK7scLVPT86mGPyBxeWVw=
X-Google-Smtp-Source: AGHT+IHYzeX6YP1D/TbEoTKwu+pW63so33IHSgvCJvvTeeNV6+7E9Nq6yz9ecT6NpQCFbn3XcD3Qb1CTBNZ98ApSLEimx7IyUS8L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9825:b0:4b9:26f5:3632 with SMTP id
 8926c6da1cb9f-4bf622c0508mr119299173.6.1720104438611; Thu, 04 Jul 2024
 07:47:18 -0700 (PDT)
Date: Thu, 04 Jul 2024 07:47:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a4d6d061c6d0688@google.com>
Subject: [syzbot] [kernfs?] KCSAN: data-race in kernfs_iop_permission /
 kernfs_iop_permission (4)
From: syzbot <syzbot+4d9e77bc73d118c6dc78@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22a40d14b572 Linux 6.10-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140ac085980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b9537cd00be479e
dashboard link: https://syzkaller.appspot.com/bug?extid=4d9e77bc73d118c6dc78
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ebe2f3933faf/disk-22a40d14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7227032da0fe/vmlinux-22a40d14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a330dc1e107b/bzImage-22a40d14.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d9e77bc73d118c6dc78@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in kernfs_iop_permission / kernfs_iop_permission

write to 0xffff8881040ba060 of 8 bytes by task 11628 on cpu 0:
 inode_set_atime_to_ts include/linux/fs.h:1557 [inline]
 set_inode_attr fs/kernfs/inode.c:162 [inline]
 kernfs_refresh_inode fs/kernfs/inode.c:177 [inline]
 kernfs_iop_permission+0x118/0x220 fs/kernfs/inode.c:288
 do_inode_permission fs/namei.c:461 [inline]
 inode_permission+0x18c/0x300 fs/namei.c:528
 may_lookup fs/namei.c:1726 [inline]
 link_path_walk+0x1b8/0x810 fs/namei.c:2273
 path_lookupat+0x72/0x2b0 fs/namei.c:2492
 filename_lookup+0x127/0x300 fs/namei.c:2522
 user_path_at_empty+0x42/0x120 fs/namei.c:2929
 user_path_at include/linux/namei.h:58 [inline]
 ksys_umount fs/namespace.c:1916 [inline]
 __do_sys_umount fs/namespace.c:1924 [inline]
 __se_sys_umount fs/namespace.c:1922 [inline]
 __x64_sys_umount+0x88/0xe0 fs/namespace.c:1922
 x64_sys_call+0x3af/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:167
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff8881040ba060 of 8 bytes by task 11589 on cpu 1:
 inode_set_atime_to_ts include/linux/fs.h:1557 [inline]
 set_inode_attr fs/kernfs/inode.c:162 [inline]
 kernfs_refresh_inode fs/kernfs/inode.c:177 [inline]
 kernfs_iop_permission+0x118/0x220 fs/kernfs/inode.c:288
 do_inode_permission fs/namei.c:461 [inline]
 inode_permission+0x18c/0x300 fs/namei.c:528
 may_lookup fs/namei.c:1726 [inline]
 link_path_walk+0x1b8/0x810 fs/namei.c:2273
 path_parentat fs/namei.c:2540 [inline]
 __filename_parentat+0x13c/0x3c0 fs/namei.c:2564
 filename_parentat fs/namei.c:2582 [inline]
 do_unlinkat+0x9b/0x4c0 fs/namei.c:4382
 __do_sys_unlink fs/namei.c:4455 [inline]
 __se_sys_unlink fs/namei.c:4453 [inline]
 __x64_sys_unlink+0x30/0x40 fs/namei.c:4453
 x64_sys_call+0x28a3/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000030ac424b -> 0x0000000000a4528a

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 11589 Comm: syz-executor Not tainted 6.10.0-rc6-syzkaller #0
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

