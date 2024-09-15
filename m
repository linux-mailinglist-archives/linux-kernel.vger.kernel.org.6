Return-Path: <linux-kernel+bounces-329821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98481979667
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8B41C21147
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98EA1C3F08;
	Sun, 15 Sep 2024 10:56:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1BD184E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726397789; cv=none; b=mcawFxDF/LU/0zIyAq/EGIyth3qKqXI7oNDjgMcL6dAE9fH31wN2rQ434TDVEEIN3ukBYasq6rNgUIkTiWM27hNPwi62CJuB91yqD0FDZLCAK/UYhVOU2xvhyq4kAZyFLCOVMouHPPVGPjG95jyZKDnhLioBn4Q4q7CdMYUadJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726397789; c=relaxed/simple;
	bh=ekkZSLgT8GBlupVzFvKzgHzMo6+PEhQJ4SayxBylpfE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uZOBu2rmV3pws+IasasenlqOQRMs8+LF7TU1esp0hyY1hvT3jye+9b+OFCdwAwzcYr2E8uKb4OLk1Iy0pAHZXuAWP8X7jWzWU/I7J1DPH1DEAMTKjLxkpFI6Ij3Kzz9+JSt5GHEGvsXo+4B5htL6CVtEzaEp3hXSnLq1X3svvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0980547efso34740465ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 03:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726397787; x=1727002587;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCoDL4bGqu6MNdtjog0pKzofOJnEE3mfH4E8N0Dflak=;
        b=Y5xfd84amQzsO7NrOy4hIPHho2aBfhO7uPYrg5mjaM6RAZ5O2TNK/ecuseG5sBHy9T
         jVgBMhQ6A2pcI7k8vC8VKrf17NWq7VRRC3PfdnEE+RJVzhETUShhZNyjs1825GIYoJHs
         gy1e/W/AoHTMuMxZ8zPu+h5y3JqL37oB4hsY12Z+gc0qf98h74zK78krIQyVJtR1b/kD
         UJO127aLSd8mQ9/SFnLN9GELlNp3ndOCWJN6Yz1E1Cu6A+daEOJzIjXk5G0H5QWc6quD
         udlEbOeRnq6G2Zks/ZK+bVwVYPyjShuqVOCAQFiqzQMtzln/NoZbh0xra+YTey/HdwXP
         6yoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzlWn3tFjmTMda1LdzPxQiZftKr6y5X5qTvvVMLPd3P0oQzPGZ4z0qoZ96/bLrUZ4RDK4bpQrldKTct+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfN2qFHcjSOvLBWI5CX73x+OG3amvn46cCZMwSpKaNeJGMn33p
	IVxZpuDbYfP+fUtn0K8X2fBLepORKnoFmusv9SVKj+OyG8XmJ1+Wk4zAQeaJ+sv9l4X39YjmfZv
	uSTz+NOmURGghSiTp9CoXPt5jUtiTKz0YQgjbpMG4IKufGSOc0Zb7fGI=
X-Google-Smtp-Source: AGHT+IE1Z8eMdn0P6e7EYxc8b2e0sVwR60adnak2pImyXJp+frv0RSaiKt98e8XAy3JOnrORYtdOJ4hECyq+ImicyzJaJgRT3kDR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3a0:4df2:52e2 with SMTP id
 e9e14a558f8ab-3a0848e8395mr124889465ab.4.1726397787028; Sun, 15 Sep 2024
 03:56:27 -0700 (PDT)
Date: Sun, 15 Sep 2024 03:56:27 -0700
In-Reply-To: <000000000000ea79f70621404a85@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d64ef20622264e82@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in z3fold_page_migrate
From: syzbot <syzbot+63f9ce7427394b75d9a3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178ae407980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=63f9ce7427394b75d9a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163fbc77980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-0babf683.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b153c86536a6/vmlinux-0babf683.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef8726833cde/bzImage-0babf683.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63f9ce7427394b75d9a3@syzkaller.appspotmail.com

 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4755
 shrink_one+0x3b9/0x850 mm/vmscan.c:4793
 shrink_many mm/vmscan.c:4856 [inline]
 lru_gen_shrink_node mm/vmscan.c:4934 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5914
 kswapd_shrink_node mm/vmscan.c:6742 [inline]
 balance_pgdat mm/vmscan.c:6934 [inline]
 kswapd+0x1cbc/0x3720 mm/vmscan.c:7203
------------[ cut here ]------------
kernel BUG at mm/z3fold.c:1293!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 29 Comm: kcompactd1 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:z3fold_page_migrate+0xafd/0xf50 mm/z3fold.c:1293
Code: ff 4c 89 f7 48 c7 c6 40 36 18 8c e8 9d 17 d7 ff 90 0f 0b e8 25 ba 8c ff 48 8b 7c 24 08 48 c7 c6 a0 36 18 8c e8 84 17 d7 ff 90 <0f> 0b f3 0f 1e fa 48 89 ee 48 81 e6 ff 0f 00 00 31 ff e8 dc be 8c
RSP: 0018:ffffc900004fed98 EFLAGS: 00010246
RAX: 2ac19587b3dc5700 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c0ad560 RDI: 0000000000000001
RBP: ffffea00012a6f80 R08: ffffffff9018766f R09: 1ffffffff2030ecd
R10: dffffc0000000000 R11: fffffbfff2030ece R12: dffffc0000000000
R13: ffffffff8c1834a8 R14: ffffea0001157580 R15: 1ffffd400022aeb0
FS:  0000000000000000(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000003793000 CR3: 0000000011e16000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 move_to_new_folio+0x99e/0x12e0 mm/migrate.c:999
 migrate_folio_move mm/migrate.c:1288 [inline]
 migrate_pages_batch+0x2527/0x3560 mm/migrate.c:1818
 migrate_pages_sync mm/migrate.c:1911 [inline]
 migrate_pages+0x262b/0x3460 mm/migrate.c:1993
 compact_zone+0x3404/0x4af0 mm/compaction.c:2671
 compact_node+0x2de/0x460 mm/compaction.c:2935
 kcompactd+0x788/0x1530 mm/compaction.c:3233
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:z3fold_page_migrate+0xafd/0xf50 mm/z3fold.c:1293
Code: ff 4c 89 f7 48 c7 c6 40 36 18 8c e8 9d 17 d7 ff 90 0f 0b e8 25 ba 8c ff 48 8b 7c 24 08 48 c7 c6 a0 36 18 8c e8 84 17 d7 ff 90 <0f> 0b f3 0f 1e fa 48 89 ee 48 81 e6 ff 0f 00 00 31 ff e8 dc be 8c
RSP: 0018:ffffc900004fed98 EFLAGS: 00010246
RAX: 2ac19587b3dc5700 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c0ad560 RDI: 0000000000000001
RBP: ffffea00012a6f80 R08: ffffffff9018766f R09: 1ffffffff2030ecd
R10: dffffc0000000000 R11: fffffbfff2030ece R12: dffffc0000000000
R13: ffffffff8c1834a8 R14: ffffea0001157580 R15: 1ffffd400022aeb0
FS:  0000000000000000(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000003cf5010 CR3: 000000001f032000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

