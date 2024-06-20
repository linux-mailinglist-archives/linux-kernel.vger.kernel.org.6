Return-Path: <linux-kernel+bounces-222242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F311E90FEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E0E1F229D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27717D8A6;
	Thu, 20 Jun 2024 08:23:27 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD617CA19
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871807; cv=none; b=eV8NFR+6fZDk6VHAk5/UZHiIzHDIhYDtpZne4QP1P1fcl7GIP3RcZ01W+03v2r04KdKej/BJQdWDIhg569q56a0BYsIGpWtAUCoEy1zkHzpVI+t8wOCaLAqr15uz2g4SynkTGpRKs38Rk+5YH6fhakxH4upYX/+EaCr+XaUwLWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871807; c=relaxed/simple;
	bh=csVDR8kg7NwtMi5YPusScgBP25EglVp+lgFvYNFqgpw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dQPnwS57rchKKrj9gamGnyG95OJv9kvdwG6L/kOKzDoqsSMBgmJgkmgTI/BbEJNJPhI+PAwyLi6AicKXWh64Ps0U5q9EzlJqfih8lAeh9NAYSoqnxDsYkpNDuz8ilKq0XIyKA6XWPy/FZBRdBRrEJOujrqgArix/RsEGIJHL8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ebe8016637so81329839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871804; x=1719476604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xjOp+wYL/pN3A6XRA46Brl74ey8lMmg1qP9IE4QUj0=;
        b=pDsQER2BsFdoQE5Vrnlld6kF+x/EF9KW55Sza+5e9epubnumzDxbCpHTCfaKm4pEFX
         DaDeH+aQBISrserSCgPJsLkz1J8SfA9AqXis66mhokyapfch4u4JvYUPecWSAYRhGbdV
         tDZxqThj7UmhuPUGW57bjlokqe9bY0Baql99ys+o/SxIjuOQySoYnqa5vy17uXZfdKLs
         /YJukIAh0cX2n0AjDLnmK9GzcO8PVZiH34RNModGbNvcy4NL7lXreL26ETmsuaqmPop6
         OLfABIvwTixstXBQDH0fcZ+L8ui6RJ4CFmdcDRQcysjSa4i3JPeBt4+NAUqYA1llYfN2
         virA==
X-Forwarded-Encrypted: i=1; AJvYcCXMhhlWgIXpgl52i2f1a3Y1s/RDEZqR5TA6uhq/vl/YuAcGXTG3m1qln/FTfoPpZf3hC9hGqZwy2mk4A7ECXT00fFYzYtbBQ83wSAUt
X-Gm-Message-State: AOJu0YyuScjj6+wQ4OP0gz1ELdwxqv+CtyClyiR7rAroyo+nENvNA4QO
	bGpe452/iYsdbZxW/LaH8B5TYLYcKw27zDxmXn0RiREKgaJfqVor9+z5ckqKtcg8Onwof8mgqKf
	qi7ThNaA4KnYRvtilNDITtqNo0+lqHGZlMmKfixzZ2YCz69LdjoUB1g4=
X-Google-Smtp-Source: AGHT+IFxcdE8rH+VsUhG08w8ApM4MKNQDyWCo5jAxthJeWhn0KrCbETlKmxGXB45wd2ZrHaBLOjASnpzJwfTzKlP/s3oMnWZRUb2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:a40f:97d1 with SMTP id
 e9e14a558f8ab-3761d74fc47mr3396555ab.4.1718871802662; Thu, 20 Jun 2024
 01:23:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 01:23:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000366469061b4e0781@google.com>
Subject: [syzbot] [ext4?] KCSAN: data-race in __d_instantiate / lookup_fast (7)
From: syzbot <syzbot+5757df85a1c108693de1@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5b3efbe1ab1 Merge tag 'probes-fixes-v6.10-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f67fca980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704451bc2941bcb0
dashboard link: https://syzkaller.appspot.com/bug?extid=5757df85a1c108693de1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aba434953b89/disk-e5b3efbe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c615db72106/vmlinux-e5b3efbe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec51cef20784/bzImage-e5b3efbe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5757df85a1c108693de1@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __d_instantiate / lookup_fast

read-write to 0xffff8881207d1d80 of 4 bytes by task 25805 on cpu 1:
 __d_instantiate+0x2cd/0x3c0 fs/dcache.c:1855
 d_instantiate_new+0x5c/0xf0 fs/dcache.c:1899
 ext4_mkdir+0x5e6/0x740 fs/ext4/namei.c:3047
 vfs_mkdir+0x1f4/0x320 fs/namei.c:4131
 do_mkdirat+0x12f/0x2a0 fs/namei.c:4154
 __do_sys_mkdir fs/namei.c:4174 [inline]
 __se_sys_mkdir fs/namei.c:4172 [inline]
 __x64_sys_mkdir+0x44/0x50 fs/namei.c:4172
 x64_sys_call+0x10d4/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:84
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881207d1d80 of 4 bytes by task 25807 on cpu 0:
 d_revalidate fs/namei.c:860 [inline]
 lookup_fast+0xd9/0x2a0 fs/namei.c:1641
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x403/0x810 fs/namei.c:2331
 path_lookupat+0x72/0x2b0 fs/namei.c:2492
 filename_lookup+0x127/0x300 fs/namei.c:2522
 user_path_at_empty+0x42/0x120 fs/namei.c:2929
 user_path_at include/linux/namei.h:58 [inline]
 path_setxattr+0x60/0x1a0 fs/xattr.c:666
 __do_sys_setxattr fs/xattr.c:687 [inline]
 __se_sys_setxattr fs/xattr.c:683 [inline]
 __x64_sys_setxattr+0x6d/0x80 fs/xattr.c:683
 x64_sys_call+0x2957/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:189
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00280040

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 25807 Comm: syz-executor.4 Tainted: G        W          6.10.0-rc4-syzkaller-00052-ge5b3efbe1ab1 #0
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

