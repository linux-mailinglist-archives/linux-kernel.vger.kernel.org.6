Return-Path: <linux-kernel+bounces-428377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC29E0D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AAAB2709F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24C1DED63;
	Mon,  2 Dec 2024 21:02:01 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88653A94A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173321; cv=none; b=QEqdY2Hx5zBc3/AUkuKzKSTxJ1agT5NMLfNThp0y++VRTaDChplF7RlzVBTqppxRQHQWHrvdDNzr1z2O0vQtJ4wsMeyH3XnB0r85jNsYhWw18J9Qr6bC4HG94xQ1c/1ddnC/k0wFnY+2hakyJQWG6f8v7VilLzKSjE6ZTwhr2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173321; c=relaxed/simple;
	bh=pm9/w1Qkcjm6tTtKJ1AJ/DFAv3V2PrHr/9ULzYyTMy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BV5dj/y5H0Py9cBCHs/s3ZGTJm21XMHqhJUdhbuBHN5S+nBzb3ZtQumDGVD8pZmoTguxeQwPCQwjANoGRZ/D7NeqqqAoKi7zVBbGOyEZhYrTYQmsrTXiCax9iA39LB9YXyzXIpQMF2MHuXsKWoKgwLIeyZOWLNt5y38OVGzoRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-843e5314c99so506833539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 13:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733173318; x=1733778118;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4srVLSDq9G4UPAichGwVCPveGZxFrIeZbFc6HhIDkhg=;
        b=Jy8buVaQ+lcCRNp1IpjaEaWru9bkL/9Ul80inYGK5eiX2xKi3r+xvGMgrFLkiXhBqD
         DSwHgJ+l+17KL4pHGumBR5kJpqc3i0O4hyUx1ip4oQDSsCJSZvp+rsxDbVBktUUwccZC
         GST3me6U6M8XkLK8dGBSES0tyOEqOzNJOoRikI6/EV2AGBW6cd2WQNvhJt37Vxsg3/Qm
         O3tDqaRON282LLnnR6NAOTLs9uqmdSgXNkayKhecMoGIibFm6HYznDssxDhB4his6Ba/
         wD4TyJoFnR9BkSNqYVLAt73HtKYoG3Pdbp81/31pNenGr6GyjncKETJDTIvlwZ0D4Rd4
         3gfA==
X-Gm-Message-State: AOJu0Yz3jiYkLSy2mEALuxCJoObzLRa7ymiJmXvnnv0odkBfB7U03k3U
	PaC05dqRjM4DzftpskDtQ3iZN8MQ5wPj7jLm1gHsEZS4ytVxzC3hpoDe3vcOc+Xz6uLXyv1pcT4
	FDfQ0VHFekKZxyANoed7ls1J+NMeLWyBXGL7OD67pWIYiq2eON/g45tURMw==
X-Google-Smtp-Source: AGHT+IEe13r+NryV1Rpgx3RnxfiEAyR2BL3My74bq6pisUKUWI5ewShmBlUfbb9EGlkse06KXErXnvoVcelDi6Bm18gDzAw+Cguj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c543:0:b0:3a4:eca2:95f1 with SMTP id
 e9e14a558f8ab-3a7c5542bebmr263413795ab.6.1733173318628; Mon, 02 Dec 2024
 13:01:58 -0800 (PST)
Date: Mon, 02 Dec 2024 13:01:58 -0800
In-Reply-To: <67475f25.050a0220.253251.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674e2046.050a0220.17bd51.003b.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_do
From: syzbot <syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_do
Author: bernd.schubert@fastmail.fm

#syz test: https://github.com/bsbernd/linux folio-syzbot-debug


On 11/27/24 19:04, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    445d9f05fa14 Merge tag 'nfsd-6.13' of git://git.kernel.org..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12733530580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
> dashboard link: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fd43c0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cf2f5f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9fd8dd2a6550/disk-445d9f05.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/af034d90afcb/vmlinux-445d9f05.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/07a713832258/bzImage-445d9f05.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in fuse_copy_do+0x183/0x320 fs/fuse/dev.c:809
> Write of size 5 at addr 0000000000000000 by task syz-executor159/5840
> 
> CPU: 0 UID: 0 PID: 5840 Comm: syz-executor159 Not tainted 6.12.0-syzkaller-09734-g445d9f05fa14 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  kasan_report+0xd9/0x110 mm/kasan/report.c:602
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
>  __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
>  fuse_copy_do+0x183/0x320 fs/fuse/dev.c:809
>  fuse_copy_one fs/fuse/dev.c:1065 [inline]
>  fuse_copy_args+0x1e6/0x770 fs/fuse/dev.c:1083
>  copy_out_args fs/fuse/dev.c:1966 [inline]
>  fuse_dev_do_write+0x1cc1/0x3720 fs/fuse/dev.c:2052
>  fuse_dev_write+0x14f/0x1e0 fs/fuse/dev.c:2087
>  new_sync_write fs/read_write.c:586 [inline]
>  vfs_write+0x5ae/0x1150 fs/read_write.c:679
>  ksys_write+0x12b/0x250 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa4c9df3c0f
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 89 5e 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 dc 5e 02 00 48
> RSP: 002b:00007fa4c9da71e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fa4c9e7f3e8 RCX: 00007fa4c9df3c0f
> RDX: 0000000000000015 RSI: 0000000020000540 RDI: 0000000000000003
> RBP: 00007fa4c9e7f3e0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007fa4c9e4c33c
> R13: 00007fa4c9e44027 R14: 00007fff3bcf2380 R15: 00007fa4c9e4a338
>  </TASK>
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


