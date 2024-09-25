Return-Path: <linux-kernel+bounces-337886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AE9850AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FF4281E97
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663771482E5;
	Wed, 25 Sep 2024 01:42:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE38EEAE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228525; cv=none; b=grGeqosBkj/WWm6qJOgLzALmRsLgpbW0+YlBpLYtlt7gFIP/nYimxPKh2WwSEkE7s6Vn79GYY8LacMI35SFi+H2f1zPNZ+IFrIlwMWlRXXb6DzwfIV7mtv4E6Gi18Ce8IPuMdeXxmy/2Z28WPJN6zCeNzv8iv9/8P8nSy6Z8pQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228525; c=relaxed/simple;
	bh=CP12Iu5dYUUFRjmTJepDenkS+LoZ0HUDQQ4Q0nIFpdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y1NwuSSU9/r/MT2AS+FkWahNVB1PEsa/ikoQhnJhvRtkbhSiUZtgZjvqbtsy+qFCWXkwniZq8PhCZEsvLhdqgOciDehis4toVt15MizgdE9cGV+fcWHIHNZw1+4xHUjrBXCEvcvJuQTLDWtfOR3BwoW3ix3ToVPFHBbNNY8tYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso99024055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727228522; x=1727833322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaC2DDxJeTt0n/7vEBd76QpaRiiwBO9OoxRBydGg3B4=;
        b=SrJTGKbT8puGS1PSPgZvuna4nv6rCbu7JMlf+WT8FNy3o88630j5zuXR3nkfQltRYp
         c99lHDohgE6lj01Zw4Z185xjiDs/POz1JxUkNlzA6oP3RyE8xWUZn7pTWj0wnIM5Xuzd
         okmPT67ONaq2ZwXvv7oD591Mwv+O8VogMY1V87WcPnV2EotjOn3objBINdaMOz4m2eck
         mI4lfgIja3Ruty1gM/uTujLkm+JTsc5HoPYWw085Q2QYbRwEnU0JXT32l3kuSLrvUKpA
         275dpoYfoa8GEenfL1PXDg9KY0MlgKOLi76FlQpebVWHhQ4+/K7HrGY5CZbv+rYefsk3
         ZDmg==
X-Forwarded-Encrypted: i=1; AJvYcCXFEcWPWYnjEhBCB4fdO/0piJBczEcpd1KneMHDMdNaDAkTm5g5tBasn4w3/1Ze6zZuniTWHifGbXeQDCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuI/apcaGl1sv93jdMD40YW+aUidsJvi+QFt+R4yXD4KXbVygi
	1+0ZG3sJd3qRoiWedPlVXPmTDtpQM3J8URXB1xCyWFF1Mkr0Xu5+Wzn/6X0pmy0BACZBMNXbzdf
	tSuxh6Jwmzr3yJq1WDiFm4yGYO6NFCWdDJ07eiTRd7s6zu126rkv4TB8=
X-Google-Smtp-Source: AGHT+IF9la2/mWYH0iVbdrlZNURF+D+lf6fKHiR4sHVkHZfdOa95nJc0dbvILEFrrSRYqVY7VzFOtQNNJ4hhpGgf4d7s/exg4dTF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1848:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a26d7149e3mr13274605ab.7.1727228522520; Tue, 24 Sep 2024
 18:42:02 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:42:02 -0700
In-Reply-To: <tencent_08982ECAAEE20C9E67D106F812CF067E8906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f36a6a.050a0220.30ac7d.0006.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in vfs_get_tree

bcachefs: bch2_fs_get_tree() ret: 1, sb: fffffffffffffff0, fc: ffff8880537ad800, fcroot: 0000000000000000, bch2_fs_get_tree
bcachefs: bch2_fs_get_tree() error: EPERM
Filesystem bcachefs get_tree() didn't set fc->root, returned 1
------------[ cut here ]------------
kernel BUG at fs/super.c:1810!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5755 Comm: syz.0.15 Not tainted 6.11.0-syzkaller-10547-g684a64bf32b6-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 92 98 af 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc9000313fd08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef5ba00 RCX: cdd8394f8f48fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100a6f5b16 R08: ffffffff81746c8c R09: 1ffff92000627f3c
R10: dffffc0000000000 R11: fffff52000627f3d R12: 0000000000000001
R13: dffffc0000000000 R14: ffff8880537ad898 R15: ffff8880537ad8b0
FS:  00007fed01cdb6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ca2d7dd000 CR3: 00000000577b4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed00f7f69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed01cdae68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fed01cdaef0 RCX: 00007fed00f7f69a
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007fed01cdaeb0
RBP: 0000000020005d80 R08: 00007fed01cdaef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005dc0
R13: 00007fed01cdaeb0 R14: 0000000000005dcb R15: 0000000020000240
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 92 98 af 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc9000313fd08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef5ba00 RCX: cdd8394f8f48fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100a6f5b16 R08: ffffffff81746c8c R09: 1ffff92000627f3c
R10: dffffc0000000000 R11: fffff52000627f3d R12: 0000000000000001
R13: dffffc0000000000 R14: ffff8880537ad898 R15: ffff8880537ad8b0
FS:  00007fed01cdb6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c28ab5b47 CR3: 00000000577b4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         684a64bf Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143e8a80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd75e1a00004094f
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b3c99f980000


