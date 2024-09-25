Return-Path: <linux-kernel+bounces-339080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B098601A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0091C261B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12322198A0B;
	Wed, 25 Sep 2024 12:26:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360E184538
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267164; cv=none; b=b0txkJOskiuCsWeQMtUx8NmsXF0ScqDeyHyLxFEjD1KQz6Q2h3/w4K36vG5oDs/IUXG+W3gvMSQgcLtWO0P3Zp+ZdZ3WDgFC6veSeJuZMUV8tOeA6/DL3hQ/+nZoiZz6FZFY2COHtvEYmGk6P6xJxTsMHRrgTyQNLzHj4fC5k68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267164; c=relaxed/simple;
	bh=YdZzjXM/M0xtGoUGHxl5Ip3RI5sXrCy39dxbnwpmiZs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=okfa/QJ/FzR+Nf3Md1z43tZ5k1oiobYPxrMf/XLuHCa7uTueXzIkd3895HTl0u1UpxP3+NuS8YA+GdUWrAtBRTYlLIj+GOKkwjgtxOKs4Sku7ZaZZr3e7l78ryO3Imr8gti/YMj2x6W1g1OgHEbm08YFDbJ60bHFtN/HS89d41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a27329cec7so3445545ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267162; x=1727871962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DdLYc/S/0820UqSzQFn+8Cv6cBfTITWYkV50H5l7qs=;
        b=gNp/5fDRI4jMJkBiji4YctJAp+wcboX0Yetuk2aEPEyT4ksCUkKcaD1Q6nxcAo0R2L
         x7170/GeYdwPouwABlcUA9EM76CGNqe7YwsSugASotPJftUIPfF/s/X8ObEzH7DQ6Wcj
         k153N/zksVJj0rvAh0Ggu+aGSmC7W7JdjCAX2usrOsZQtZKE/S2OJ5wVSxxGvh9gpbn9
         2qAkEFnvdDgJEf+6cpQ3X2Bf6FEPuglRQZ3gQAluP475qISAt2LdZS5YJeqTYIvpbyvy
         ER26r5ALiT7DtM6M28769dLkjDAYem8ufvHh6mRMP6Gjzq9620Qy1YBB/RrWVil/6K9u
         k+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBp2uzcdU/WBlnt8F9CG7hItdR8ZDGwq38QIcqosTanh0KwZHq0kMa6nGFbSu+CNOvR/Cm1jDk14uFov4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztsY98azM9oop4rj27dCRY+aFDNvA8r7NAhLl1AA0RsI2kTl7J
	sWmkUpP9srccOBtgnXWb12fuHOtqNM3Winha9Oe7a4zboI+mzboC/yjzHJtfHtmaP47Uttl6Axj
	8e91sJkmW1cucdGps1GzH7coOI/zocANqQFyxzTgAfvfsUoqW6r7yE/8=
X-Google-Smtp-Source: AGHT+IGHKXuCmbV/0avBggeKU1RdVMTxL+BTNi2GaQYwf1k82yIAEKn8f9ZMqV8v245RJG0BwRaQUKfvUWi3VffXee47cW7VWr1e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3a0:4b2d:7371 with SMTP id
 e9e14a558f8ab-3a26d7c3f9dmr23288235ab.26.1727267162107; Wed, 25 Sep 2024
 05:26:02 -0700 (PDT)
Date: Wed, 25 Sep 2024 05:26:02 -0700
In-Reply-To: <tencent_11342DC56C149450EACEED06CE087BDE6F0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f4015a.050a0220.211276.0029.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in vfs_get_tree

bcachefs: bch2_fs_get_tree() ret: 1, sb: fffffffffffffff0, fc: ffff88804b373c00, fcroot: 0000000000000000, bch2_fs_get_tree
bcachefs: bch2_fs_get_tree() error: EPERM
Filesystem bcachefs get_tree() didn't set fc->root, returned 1
------------[ cut here ]------------
kernel BUG at fs/super.c:1810!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5758 Comm: syz.0.15 Not tainted 6.11.0-syzkaller-10547-g684a64bf32b6-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 92 98 af 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0000:ffffc90002ddfd08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef5ba40 RCX: 09535156e62e3f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100966e796 R08: ffffffff81746c8c R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88804b373c98 R15: ffff88804b373cb0
FS:  00007f939e8e66c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa76e92b000 CR3: 0000000058070000 CR4: 0000000000350ef0
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
RIP: 0033:0x7f939db7f69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f939e8e5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f939e8e5ef0 RCX: 00007f939db7f69a
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007f939e8e5eb0
RBP: 0000000020005d80 R08: 00007f939e8e5ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005dc0
R13: 00007f939e8e5eb0 R14: 0000000000005dcb R15: 0000000020000240
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 92 98 af 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0000:ffffc90002ddfd08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef5ba40 RCX: 09535156e62e3f00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100966e796 R08: ffffffff81746c8c R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88804b373c98 R15: ffff88804b373cb0
FS:  00007f939e8e66c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005615655e7000 CR3: 0000000058070000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         684a64bf Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1270d627980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd75e1a00004094f
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13834a80580000


