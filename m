Return-Path: <linux-kernel+bounces-567206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC5A68341
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4825319C6602
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33B24E4C3;
	Wed, 19 Mar 2025 02:43:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDAE4A0F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352187; cv=none; b=H8SsDkq9ezDqx29NSIZdPn8xoL1N5MY22n9LKI3cLD49c4+4AIu4Hxb9uV1AXrbqo2mJAMa2pCwN+CyFi/MdHjfvC2yuYiu23k1Y4FML0E6ldrzZvRnjaFzxRiZSloQDp9xHX23I+p++cInpNVZpGo1WmUSr5PbBw5VSmelLao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352187; c=relaxed/simple;
	bh=Hq/Vhv5CteLUsmJfOtPCv9cI2nrSftdnloJXxm2IWYg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=svnc5iY5YvkCug2zqvSnkbs56WZinu0nV3uPouOjgxB9uAEwH1otQJy5AmuYyHauTh8qP2g4KUDZlnINmQQ1+epR9XRQ0460DrB+EPNqJk8ksylWe9BGRWiWxT6GV4i70/AsU52FE+X9UMm8nnKF30MhZt9kz99ptn64Oaof+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43541a706so59103555ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352184; x=1742956984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqPrMZguEglFz6lxCyv8pjQMrg91j/nTFKmD84mO4no=;
        b=NaBtTR+U/Cx5Ykq76I1t2iXuW0w5EYJ1BnJcdnFLMW/k16vygNCMAdhuF2j2s4TS8H
         T0w0G6Pr73suI+1bCIFfdA+cDYBo+8BKD8To6c3WxVEobJ4JBjTzZYy7kXVUBYebmh1r
         hw5JEyJAMDm2i+eTEYm6UrS/LrW/5F4DeSz41HVE9PNUK27Gz/+bwsBqRt22QlMssP2b
         V5JZ6tJuu1HBxFQdJtjZKddvmYjW7K1capWqVdgY+ewKcfgHVJffVHPdzQSNaSKWrFbg
         ZZKuC8qWTCApbUvbUZ01HlX60KCSaQzmw/IerlV2+wStPLnCpds2yYRp13fbeTzP4dYQ
         cb/w==
X-Forwarded-Encrypted: i=1; AJvYcCXvApKV69diyJZk5bgWDU7R6NOxVibf3Tgp8sba8/SPkAv52MLOtQ6UQS54O12K5ScDCHBhgLsGdGUBAdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3zmHrtgFyuqEKWib78IkNqp0SczRz81GTXJ32AU/9+mwcRx7
	wSDzpGIGR1XkmSMEKsBYpKKsEL7kscEGd6hQLGn2HfLks79lfVb6EDgkgxA0AG4UBrl7ClU2BgO
	nGcR3HBxkbrtFQ+axDVDGOOdQxW/jqDEkXHkkB7SVfcy2Z+XyfbDLacE=
X-Google-Smtp-Source: AGHT+IFNYZiA45T5PGX9FP8pet//rcdlsxnHHtvGlYqtIK/i4PLdcO+PDOXsFgtAFpg08B/0hRgGj60jh/CIF7SbSJXGszmPv1vv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:3d3:fa64:c6ed with SMTP id
 e9e14a558f8ab-3d586b307bbmr11833885ab.7.1742352184115; Tue, 18 Mar 2025
 19:43:04 -0700 (PDT)
Date: Tue, 18 Mar 2025 19:43:04 -0700
In-Reply-To: <CAN-A22rSAtYqRNA_OtFUViY44fjV=sKRbnYHonEJtm2eSN8vyA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67da2f38.050a0220.3657bb.0135.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtDelete
From: syzbot <syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, leo.fthirata@gmail.com, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in jfs_evict_inode

------------[ cut here ]------------
kernel BUG at fs/jfs/inode.c:169!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5776 Comm: syz-executor Not tainted 6.14.0-rc7-syzkaller-g81e4f8d68c66-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jfs_evict_inode+0x434/0x440 fs/jfs/inode.c:169
Code: df e8 00 e8 d4 fe e9 1d fe ff ff e8 96 a8 6d fe 48 c7 c7 60 42 f5 8e 4c 89 ee e8 77 24 da 01 e9 92 fd ff ff e8 7d a8 6d fe 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900029ffab8 EFLAGS: 00010293
RAX: ffffffff83543803 RBX: ffff888042646f58 RCX: ffff88801f43c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880426472d0
RBP: ffffc900029ffc30 R08: ffffffff825ef183 R09: 1ffffffff28a9b2c
R10: dffffc0000000000 R11: ffffffff83541530 R12: ffff8880426472d0
R13: ffff888042647350 R14: dffffc0000000000 R15: ffff888042642ad0
FS:  00005555647e6500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555648015c8 CR3: 0000000058ab8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x4e8/0x9a0 fs/inode.c:796
 dispose_list fs/inode.c:845 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:899
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1413
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f885038e497
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffebd08a8a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f885040e08c RCX: 00007f885038e497
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffebd08a960
RBP: 00007ffebd08a960 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffebd08b9f0
R13: 00007f885040e08c R14: 000000000001eab0 R15: 00007ffebd08ba30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jfs_evict_inode+0x434/0x440 fs/jfs/inode.c:169
Code: df e8 00 e8 d4 fe e9 1d fe ff ff e8 96 a8 6d fe 48 c7 c7 60 42 f5 8e 4c 89 ee e8 77 24 da 01 e9 92 fd ff ff e8 7d a8 6d fe 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900029ffab8 EFLAGS: 00010293
RAX: ffffffff83543803 RBX: ffff888042646f58 RCX: ffff88801f43c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880426472d0
RBP: ffffc900029ffc30 R08: ffffffff825ef183 R09: 1ffffffff28a9b2c
R10: dffffc0000000000 R11: ffffffff83541530 R12: ffff8880426472d0
R13: ffff888042647350 R14: dffffc0000000000 R15: ffff888042642ad0
FS:  00005555647e6500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00987e000 CR3: 0000000058ab8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         81e4f8d6 Merge tag 'pmdomain-v6.14-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135c25e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=4f9c823a6f63d87491ba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171c644c580000


