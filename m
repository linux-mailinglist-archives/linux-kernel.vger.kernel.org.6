Return-Path: <linux-kernel+bounces-190609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CAE8D0068
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C9A1F23B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9115E5A9;
	Mon, 27 May 2024 12:50:27 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E244D5A2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814227; cv=none; b=R/ey8AiYjACugvEvaJpW1FgUjsmFEgjJRoAn57DpU+RMTEWMCOD2/GPRhb0bebyY45MP9g8DKwKXKmsWIaXXCAbBD/jD/bPiPS4/7yIw+NTCU0UR9sS8ypPKoStkj2aZc+Eepk9qcwknDhU6y/iK2sg6L2WbTM92SyfukqPZDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814227; c=relaxed/simple;
	bh=ggQLRdvyIp6N/f80ZonFwGJ3sy3mjFhzvaUS6XQMFKc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bap7uDLJm2rwSJQwMJyQU7mO0aLBg64fROkxmSzYEvnl5ggLAItpYvRHkORc/raQ0LfDpDKkXnBW6eaZWOe/LwiLPry2RXB+mXtwgx0qBsTSpjj/iDMjxS0G7vNqLs43+9Jv2ucokC8i/ki/UyDMyOObUgiX0utszu7ydO0F5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e261e3e1beso582122539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814224; x=1717419024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4rr0TG+i5LX4PfU3talh8egAEvYin6Xr/tjehsK1oU=;
        b=sfRHv+nZ1lD59H9xGeJZ2y/N15PgjRE63WIAqHhbJ5cVFgESyAJG1BiirAXkyWF+au
         PaGxU8P0HPmfei4mFqJmFRUd9ibONj8giX0UbNyx4d7aOyKwCUYyTjz5as9tvK8ogkFG
         JLDDMWonKLs6MMHElwi8/qoWfnkUNboA91xTazDowe02FtWVxeBG4Rw4e3MmgXD2EDD/
         B9UFmfMg/pU9Aay46GWOBIUhR9NB5vZtnLQGwBGRL02WuObhI+NhdmOsa9vyue4OphxX
         2jIxnzHVJsilu5CrqxIZdTndOtgYepT2PdJOm2Dy+u6cFgOfJm0gnjRFjo6bK9HrKbB+
         O+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXbkuIRJ8paPfqL6z3dVtCSQUZDKa7Lkt/lPZ3uv0/+CQkAVT/B2YO/4nlfjMXzZsay2OZJphTOTreKEoXgwm93bQHKA3oilZz7z0sV
X-Gm-Message-State: AOJu0Yz/6FVqeLLyyx5+TqRp7WvBe49KtmA1X2Jhoae0sHLqSPGEDNWM
	9TmZafyhJ12FuIcRE7xXONuU1LWQ252yb6soPGrHnaAQDSnGQTfR0RH4ipxu0RKUPEv4zKrxmqP
	w08ZCJdYU2R+Uk8p30EEaoQZmgyOz98/A4u3idJdZm0YQqZxdgtcQvgw=
X-Google-Smtp-Source: AGHT+IHrYCSzjwuIz4BBsit2eZXeQ2IdrTlMXtkUa8A3f0AhpBCRjRDBUykINqGYUHrizzMmMr5Q9DWGdwRA6o34VHCqddlMi+2n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:374:5b18:28c8 with SMTP id
 e9e14a558f8ab-3745b182b34mr2012815ab.3.1716814224113; Mon, 27 May 2024
 05:50:24 -0700 (PDT)
Date: Mon, 27 May 2024 05:50:24 -0700
In-Reply-To: <0000000000004096100617c58d54@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9561b06196ef5b3@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c114aa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17770d72980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10db1592980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000028031 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 00007f64830b0035 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
kernel BUG at mm/hugetlb.c:813!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5089 Comm: syz-executor179 Not tainted 6.9.0-syzkaller-12071-g66ad4829ddd0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:region_abort mm/hugetlb.c:813 [inline]
RIP: 0010:__vma_reservation_common+0x795/0x7d0 mm/hugetlb.c:2835
Code: 21 65 8e 09 e8 8c a3 9e ff 90 0f 0b e8 84 a3 9e ff 90 0f 0b e8 7c a3 9e ff 90 0f 0b e8 74 a3 9e ff 90 0f 0b e8 6c a3 9e ff 90 <0f> 0b e8 64 a3 9e ff 90 0f 0b e8 5c a3 9e ff 90 0f 0b e8 54 a3 9e
RSP: 0018:ffffc900035ff1c0 EFLAGS: 00010293
RAX: ffffffff81f77114 RBX: 0000000000000000 RCX: ffff88801ff90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900035ff290 R08: ffffffff81f76c26 R09: fffff520006bfe28
R10: dffffc0000000000 R11: fffff520006bfe28 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88802ce84c08 R15: ffff88802ce84c00
FS:  00005555950a7380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6483099c40 CR3: 00000000746f4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_add_reservation mm/hugetlb.c:2898 [inline]
 __unmap_hugepage_range+0x125d/0x2350 mm/hugetlb.c:5772
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1891
 unmap_region+0x1ec/0x350 mm/mmap.c:2355
 do_vmi_align_munmap+0x1122/0x18c0 mm/mmap.c:2673
 do_vmi_munmap+0x24e/0x2d0 mm/mmap.c:2741
 mmap_region+0x72f/0x2070 mm/mmap.c:2792
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6483066d39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff7dc97c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fff7dc97c80 RCX: 00007f6483066d39
RDX: 0000000000000000 RSI: 00000000001fffff RDI: 0000000020000000
RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000028031 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 00007f64830b0035 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:region_abort mm/hugetlb.c:813 [inline]
RIP: 0010:__vma_reservation_common+0x795/0x7d0 mm/hugetlb.c:2835
Code: 21 65 8e 09 e8 8c a3 9e ff 90 0f 0b e8 84 a3 9e ff 90 0f 0b e8 7c a3 9e ff 90 0f 0b e8 74 a3 9e ff 90 0f 0b e8 6c a3 9e ff 90 <0f> 0b e8 64 a3 9e ff 90 0f 0b e8 5c a3 9e ff 90 0f 0b e8 54 a3 9e
RSP: 0018:ffffc900035ff1c0 EFLAGS: 00010293
RAX: ffffffff81f77114 RBX: 0000000000000000 RCX: ffff88801ff90000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900035ff290 R08: ffffffff81f76c26 R09: fffff520006bfe28
R10: dffffc0000000000 R11: fffff520006bfe28 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88802ce84c08 R15: ffff88802ce84c00
FS:  00005555950a7380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6483099c40 CR3: 00000000746f4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

