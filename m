Return-Path: <linux-kernel+bounces-244397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7B92A3BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F26B20D93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19C137C35;
	Mon,  8 Jul 2024 13:36:20 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902186A022
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445780; cv=none; b=oA6FUXaqzk3V9JQkX81PAPMS1/KKHm0GS4nwHyUl6habjQFaFe9d0alm3K3w+/BozdKxYkELwebrvaDPzefG3+eDhInuHyFkB7sdZ8sAR6cB12t/FgpKy6dBnz8z3oeu4F4maI/inpCSewnu22+UlWfO2LUBdo5Z0jy7BQHeruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445780; c=relaxed/simple;
	bh=N1ZWZ3bo5JoAmtuEnkMdV7IWB0Ho/PjH0hWmEJYK9J8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s9yw3AyJTA6d6f6B5AjwrREROR2vD+zu/zTJiC5GScod4Eoliq/CpCS2ISZ70WzBvDua+MJSNiqs0AGFuaTXC4IdrKXBLcwiq5tV0MIVFUwlxMPkJmjUY4TXmoWivZyzKiSMPjyXQM42tltily9DrhREad6z7qbePZDHYb5AUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-389cc381cdfso2341215ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 06:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445777; x=1721050577;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IHGena9P8FERgV/kb9IntFswJIG09J91rs9ZYDJEsI=;
        b=r+nX6D+CAkJKlyJbXO0474IGyIiWvbNrS0hlZZFk02vkWoNsBnaY+RRMlQLjVCOpi+
         3rkz3v3bZA/0O6nNcU76o4u4ErBNY5JylFmoj7MTSFIDtdh2+8/XeNn461Ly0VZe7N2e
         vfifXl0cyysoa76ce1XISv4PhQeHHAEJk4lW46WD/syiYWBkuOb3zd09vmUVzxDFW/sL
         1Hr3Jzx52aEprGpzXoT0rt0g75hFR4NYqZ7XrfifB2MuYiCr3BT2PP7WKrWe14ONewRl
         N3AUTtuLQXIqiA/Y2Biwc2hrJNH4+YQzVoywc8WT+siR0KNlHde4jubllsXVcyTZw+jw
         jQsw==
X-Forwarded-Encrypted: i=1; AJvYcCWlPOlE51t/Gmbfd4a2Du4n78kZ/974NsrslUPv2oIwQJtrWoXj3R4+V1qAmOJ0YVBJeMl8S3ykOV5rW9plvnwPCUVdBiHws2QcAAkA
X-Gm-Message-State: AOJu0YytJDrEIXczV5CShZ1B7SWNxXxGnABolgvfIJROuHHJFTST/Rby
	Wv7sPkkdD6WnnUth+4ghOxLdRALuMxYKgBrAUxvmClf8+riE2IFHYXtCL7FVOZvxMCf20nhprM0
	nnGTbqSa589dzGw9hzL6aCr+vxHdRuOQkabro0Ks8PGXDkop0uLzVuxo=
X-Google-Smtp-Source: AGHT+IF3dJFDKfP9CYz5J+z6tw+MQ+pqiBuZlukOFKMQXu5xy/FCrpq5LWbqSiPG4spRJ2eaW75ac6ywld1bkOfGWKRdBgH0PWAs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:382:2f47:a82e with SMTP id
 e9e14a558f8ab-383cb1332a5mr10177335ab.1.1720445777719; Mon, 08 Jul 2024
 06:36:17 -0700 (PDT)
Date: Mon, 08 Jul 2024 06:36:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fc563061cbc7f9c@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits
From: syzbot <syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14663285980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=e38d703eeb410b17b473
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/947727e7be17/disk-795c58e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8898920020bb/vmlinux-795c58e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9aed6052df98/bzImage-795c58e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:3023:47
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 PID: 7225 Comm: syz.0.177 Not tainted 6.10.0-rc6-syzkaller-00069-g795c58e4c7fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 dbFindBits+0x11a/0x1d0 fs/jfs/jfs_dmap.c:3023
 dbAllocDmapLev+0x1e9/0x4a0 fs/jfs/jfs_dmap.c:1983
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1823
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbDiscardAG+0x352/0xa10 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3713f75bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3714cd5048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f37141042c0 RCX: 00007f3713f75bd9
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000007
RBP: 00007f3713fe4aa1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f37141042c0 R15: 00007ffe646d6a68
 </TASK>
---[ end trace ]---


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

