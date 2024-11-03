Return-Path: <linux-kernel+bounces-393641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B79BA383
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DBB21D67
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 01:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A246F099;
	Sun,  3 Nov 2024 01:57:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091C1CAAC
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730599027; cv=none; b=DE2QtsoxMp6paHGbsnM8siX2UlXJuGYH5jGZGXvtb2XioA0y1tpgZM3KPh4uaJebQukJLCtZ20Nz/FTY8+5c8KdDpigSswaQ/mY/QpCmTQ0v5zKMEcLs+z1Zs/1ftEdQOoR+x8BOeUbvwKvfPvOw7Xk7e3CS6xOXU+xA6JNwBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730599027; c=relaxed/simple;
	bh=LU5netj2YyF6BMrxeVKuu5HmJDtFuqUFgHv7V0fwg2c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JQC3OGABIuU3+hk79z0ExZf9Yz0D59uE0FCwkOA182OS6bc82yyxrYgw7qnjRkc24rTBlcz1t/Mz73czOEzdDDwYcjSr7qCuKMGjCwIt5di7nGcMsG67YbBy39oAUzK8mj15esip8RDmKNgpIJZ0SjnOHPwALKKDwixceszfsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ae0af926dso313721639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 18:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730599024; x=1731203824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDnFegwnz+gAMVt3jUYxDfkOm1MB3L3uSf7CLV3sfAs=;
        b=Sxt6WN5DPfWg/fokdLBuNqO2XtK6ZfN7mTCXM7ysfaRbV80wzllSj+RQDMrTKO+Xm7
         h01sCSvaIzwekQ/J0DPuZZ2kB4ZlZMTjbKSJc0ERLS4UPc5waaLWA326q+Av2UIuYJjn
         od3CiZwgfS+t4kd6R/I+pQlmmKxOx0r2nTbKALENb4NJgxk2SVCbALjzLtu+P/2lRsJQ
         M20SGhW5/Un23+WEH9S/6c9sFoJBnMY0IwMwpig4D6nKYMt77tWd4C8OCO1JMfa3IWQk
         TquJ7OrGL5kqIwTDztay5XrnQW9fOUBLnunt13jpm7zt8Fw/BNyzTMOsTtYt/O1iZn6V
         kaKA==
X-Forwarded-Encrypted: i=1; AJvYcCWDPJPDyNF8pjNrlLsQEOEGd9DqecI+qXTszMUX6WtL5JHqEz+DVIZmP5lL1ocAUfdCZy8yYI4eyqNJllc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJR9U8uiNMl7ge6odtcE0EudjgK4Y7bq7j4VTzxcQjJfOOvHR
	lrIZW2GciZEmLS89chBDiofGGOskKAZcWhTrXW8p36fUmBAfiu5I7SYrHFqVTSGr6AdR54kr7+D
	icrj8TZWvr7+RkDbYKWMHhlO+W9+DwoR/XpdxqBOxd2gBTCp2eU8trjI=
X-Google-Smtp-Source: AGHT+IE7jXY2CdsQrWvOuZ6DqOM8EWL60d5ytYUMha0S705eN/W3IwxDnHUT6SNcDanPsotPryHe92t42qh2SCmleZloghjVL2Eo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a6b035dc3emr77795845ab.21.1730599024674; Sat, 02 Nov 2024
 18:57:04 -0700 (PDT)
Date: Sat, 02 Nov 2024 18:57:04 -0700
In-Reply-To: <tencent_8D33119E281B5D4B6A1BAD2543BA98BBB808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726d870.050a0220.35b515.018e.GAE@google.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
From: syzbot <syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in mark_buffer_dirty

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6436 at fs/buffer.c:1177 mark_buffer_dirty+0x2e5/0x520 fs/buffer.c:1177
Modules linked in:
CPU: 0 UID: 0 PID: 6436 Comm: syz.0.76 Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:mark_buffer_dirty+0x2e5/0x520 fs/buffer.c:1177
Code: 89 df e8 fe 82 db ff 48 8b 3b be 20 00 00 00 5b 41 5e 41 5f 5d e9 fb e8 fb ff e8 26 c4 71 ff e9 73 ff ff ff e8 1c c4 71 ff 90 <0f> 0b 90 e9 61 fd ff ff e8 0e c4 71 ff 90 0f 0b 90 e9 88 fd ff ff
RSP: 0018:ffffc9000d30eb50 EFLAGS: 00010293
RAX: ffffffff82231604 RBX: ffff8880459fea01 RCX: ffff88803d044880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82231361 R09: 1ffff11003542579
R10: dffffc0000000000 R11: ffffed100354257a R12: 000000000000000a
R13: dffffc0000000000 R14: ffff88801aa12bc8 R15: ffff88804553b200
FS:  00007fda86b986c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0fe3329fe4 CR3: 000000004a36e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bfs_move_block fs/bfs/file.c:47 [inline]
 bfs_move_blocks fs/bfs/file.c:60 [inline]
 bfs_get_block+0x8be/0xb40 fs/bfs/file.c:129
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2121
 block_write_begin+0x8f/0x120 fs/buffer.c:2231
 bfs_write_begin+0x35/0xd0 fs/bfs/file.c:182
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4054
 generic_file_write_iter+0xae/0x310 mm/filemap.c:4181
 __kernel_write_iter+0x42a/0x940 fs/read_write.c:616
 __kernel_write+0x120/0x180 fs/read_write.c:636
 __dump_emit+0x237/0x360 fs/coredump.c:807
 writenote+0x221/0x3b0 fs/binfmt_elf.c:1463
 write_note_info fs/binfmt_elf.c:1941 [inline]
 elf_core_dump+0x37ba/0x4770 fs/binfmt_elf.c:2108
 do_coredump+0x2162/0x2ec0 fs/coredump.c:758
 get_signal+0x13fc/0x1740 kernel/signal.c:2902
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x79/0x280 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8c0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fda85d7e721
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:ffffffffffffffe0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fda85f36058 RCX: 00007fda85d7e719
RDX: 0000000000000000 RSI: ffffffffffffffe0 RDI: 0000000004008011
RBP: 00007fda85df132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fda85f36058 R15: 00007ffe98382878
 </TASK>


Tested on:

commit:         11066801 Merge tag 'linux_kselftest-fixes-6.12-rc6' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12280d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f51a2a34984e4d8888fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152e6987980000


