Return-Path: <linux-kernel+bounces-212382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB7905F46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDECE1C2151A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5912C53B;
	Wed, 12 Jun 2024 23:35:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB84A34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235306; cv=none; b=k9HytmwTHsCc9Ls1S0wgl0sebLwNtJSA4NMtU7KpI0P9SSG8HG+/7KQpXadqclhLD3Qz8+CB4PT8Lg9X9iapjbHu0Kehj1PkC+5fAhvinf/IZR1YI5bVzSOvij85xf+6bAnqvrSuFVrr6TqtXXQRjQmFPPzlUHkR2FuQXQzPN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235306; c=relaxed/simple;
	bh=1n34/2Nldb7JkJweUBw0bwWVBNzfa8v6AxL4XOv9dGo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i8APhrsAwyUx3tyVl9Aym3L94edgc5e5VqdRD1My+LZxYfLMjldQlMFDOspXDMF+Hxx1X5JE6qMEsL+VoWEhodNn1BAsGWHA/bAvI6EeoOz+QAga4BWQvlCo4dNR1wpwQ44rPra4p1GJrB5X2H+COpAjSy7IwUsGsXEqo3JddJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-374b7648ab3so4107625ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718235304; x=1718840104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F61U9nTPnNQw4QUiQKEon5LqAou6s/lSWGpJkbh7Hhw=;
        b=sMWWt2ZYrumzQc0e1maqJlaN/hwAOt7BO1LzItXXAyjGoItIVLn7t7AgA7WBvHIXSM
         izCLrF2V9yLHwGvlVjQaRNa5K5EozUwfIrXV96HeGuuCux4eNJL5vOvphVZ/5PH4w13m
         QIPaSNEaMzfnE9av+Lm9uIy8P5sEnhr9yL6WusfqN81VFJeQraM9DNv0F7AoslQjwTpB
         eGvsifE+6bIpwmthRynwf6ZLssDsjWfCxNYfYOXy4sImUBf6JmOQDQ/CSf34s66iw94M
         2PzUNX6uV3a/KR9hCXeYAoMWJN8SkN3eGjmr2UGT73AYYhgXpDDGPwoF11mUFwr4chc4
         sGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7igF1wwj7L89aVzBYOM4RE3nZdFpk5fntOlk34YHcdAzkUzLmYywnIHEADltklhpebGN50N0ukul8ZQZj06tP9qogWvCaOrd5qMCy
X-Gm-Message-State: AOJu0YwGjPCZtJ1Q8yCiCudzUr8bGT4GZgiixF4isHGX6vdcCdy5vu44
	NBg0gHGFrkFluUDb3EguwEydACrycOqb+x5BJ/wlUcY0mQp8JqpozHJwumZzKtKmFvw5tXIv0TT
	sjcpJI0cp/FAtgdzKVhCttyBrC3b8Fms44WsYF+0FM8aL6dAqiajLs4w=
X-Google-Smtp-Source: AGHT+IFuVJ6ZzkEztiTVQfqiGRw8ISVAU/fWg9itTiaxe4FAgxDCg+LVaB/9TiC9Rys9Go9+ODJOU2P+oMMLO0n40wt3vpecQ+Wp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca49:0:b0:374:a422:bb7 with SMTP id
 e9e14a558f8ab-375cd0c6459mr2115245ab.2.1718235303868; Wed, 12 Jun 2024
 16:35:03 -0700 (PDT)
Date: Wed, 12 Jun 2024 16:35:03 -0700
In-Reply-To: <20240612231634.2311-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed9441061ab9d4dc@google.com>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
VFS: Busy inodes after unmount (use-after-free)

Buffer I/O error on dev loop0, logical block 1020, lost sync page write
NILFS (loop0): unable to write superblock: err=-5
Buffer I/O error on dev loop0, logical block 1, lost sync page write
NILFS (loop0): unable to write superblock: err=-5
VFS: Busy inodes after unmount of loop0 (nilfs2)
------------[ cut here ]------------
kernel BUG at fs/super.c:650!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 5332 Comm: syz-executor Not tainted 6.10.0-rc3-syzkaller-gcea2a26553ac-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:generic_shutdown_super+0x31b/0x3d0 fs/super.c:650
Code: 28 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 aa 00 00 00 48 8b 55 00 48 8d b3 68 06 00 00 48 c7 c7 40 2c 3d 8b e8 36 5e 74 ff 90 <0f> 0b e8 de c2 ef ff e9 2f fd ff ff e8 d4 c2 ef ff e9 02 fd ff ff
RSP: 0018:ffffc900037efd90 EFLAGS: 00010282
RAX: 0000000000000030 RBX: ffff888034e72000 RCX: ffffffff816e69b9
RDX: 0000000000000000 RSI: ffffffff816ef706 RDI: 0000000000000005
RBP: ffffffff8e268620 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888034e729c0
R13: ffff888034e72780 R14: 0000000000000000 R15: ffff888026ba4900
FS:  0000555556270480(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b072ff000 CR3: 0000000015ff6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_block_super+0x3b/0x90 fs/super.c:1676
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b1047e217
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc7e659328 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000064 RCX: 00007f7b1047e217
RDX: 0000000000000200 RSI: 0000000000000009 RDI: 00007ffc7e65a4d0
RBP: 00007f7b104c8336 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000202 R12: 00007ffc7e65a4d0
R13: 00007f7b104c8336 R14: 0000555556270430 R15: 0000000000000005
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:generic_shutdown_super+0x31b/0x3d0 fs/super.c:650
Code: 28 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 aa 00 00 00 48 8b 55 00 48 8d b3 68 06 00 00 48 c7 c7 40 2c 3d 8b e8 36 5e 74 ff 90 <0f> 0b e8 de c2 ef ff e9 2f fd ff ff e8 d4 c2 ef ff e9 02 fd ff ff
RSP: 0018:ffffc900037efd90 EFLAGS: 00010282
RAX: 0000000000000030 RBX: ffff888034e72000 RCX: ffffffff816e69b9
RDX: 0000000000000000 RSI: ffffffff816ef706 RDI: 0000000000000005
RBP: ffffffff8e268620 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888034e729c0
R13: ffff888034e72780 R14: 0000000000000000 R15: ffff888026ba4900
FS:  0000555556270480(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc7e658b78 CR3: 0000000015ff6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         cea2a265 mailmap: Add my outdated addresses to the map..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15c16d7a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13182c0e980000


