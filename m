Return-Path: <linux-kernel+bounces-337831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACB984F84
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A69B20C28
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7135234;
	Wed, 25 Sep 2024 00:41:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2B256D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224865; cv=none; b=cHzFPuBYG+q4o23Cdls/2wEQ78emBPCbKVa+nyM41aEncA4cByMqujI4PqYhoHKGswzc2fNyW3qpXOXHqDJw+UE/AcwaW5sO/d0yFqWjSIw35+xLI4Cc7jx5dNsyI0Iyb51DibBBjSj9tW09cUHJpuSOP3ZwicOicegqG4mncEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224865; c=relaxed/simple;
	bh=k9F+wSuNaDKAcj8f/rBIi78V45BhWPZG9Kncf9MEhFg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vGUaq6U7dZWsOmYnHbyW5pkXsDDDTAl7M/kruKJpRAMVJA03lL/Y4gD+PA1gXcar38FCpqpq2OeBlTpd1dqvUVCxX7uKrcYXD15MGaJxIKloWsULMxC53eRF+X0nJ+2Od/R//JrOMiUBkRkWiXYoO8Gg6E2zziyGq8fqzPct+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0ce3a623eso37548165ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727224863; x=1727829663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwt70yxrLJR3jhjoz3sEmfHcBwj5epPFjuH1toIOYuE=;
        b=PKEG0x1lAAqQz9Bj+3YhhT3gLj2cXJWcPnmYHwsd1gis5+V+DdDIXO80T+QoWaRKAE
         5ZbTj2E+fpIckyuTZmFBKy3hFFo26E6vomlt644tP+yroP/vkAf2xnv1/5PC+RKZqXoO
         edcdkLACFFgwinYOsaKfJxbi4oUazzlxWZgBu9+05IKHG1B0YwPM4gobX7RX/EqicFoZ
         lNXzRP9PnvBKdJpeKpYovP/6FKZLv34+Hl+/tQlMkYLLUjhUTD8KwvgtzsKkD8d9aOEO
         g1znTDc5VwF4ZM8cjtumbL3ehImdX7tmEUnmhPN/5IhoSiFUcb1dTNQENVfFxZARMaPs
         KeKg==
X-Forwarded-Encrypted: i=1; AJvYcCVFvNz46LvjbqzkEyMPEOR4YZ5j6uUIFgB7u+7w05VcuH0bneRwWuJBbwajIqaYuDP/xt7goX0Gyz9psG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzux+499T7dUptZS5irVWCl0PcfSJpoQnr8asqzj6eGGVJTsSI4
	HXUAdTwwCxqwgGsI8SXQ2bDzA34DL8TPswJDGi55DqtjSVhRcZnltpGzFp/49no4mXTModBVI2Y
	yqf4L0K6vaU4M3CsbLqWHgk/ByA72wsffEIB7cUemu2Un9JPs25hUSuI=
X-Google-Smtp-Source: AGHT+IFK8XADoAiqleWuZsIz67W2brwZRke6XJkD0irPCGv8WmogAqFx5xlGbkHgbcxVkLAg3A9OXP/x85jkLZtzxNMoJOGshQs3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c9:b0:39e:68f8:43e5 with SMTP id
 e9e14a558f8ab-3a26d783e22mr12054245ab.9.1727224862898; Tue, 24 Sep 2024
 17:41:02 -0700 (PDT)
Date: Tue, 24 Sep 2024 17:41:02 -0700
In-Reply-To: <tencent_32A5A08D89123A5DB6DD8A19514F8B8DD107@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f35c1e.050a0220.30ac7d.0001.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in vfs_get_tree

bcachefs: bch2_fs_get_tree() error: EPERM
Filesystem bcachefs get_tree() didn't set fc->root, returned 1
------------[ cut here ]------------
kernel BUG at fs/super.c:1810!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5668 Comm: syz.0.15 Not tainted 6.11.0-syzkaller-10547-g684a64bf32b6-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 92 98 af 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90002f3fd08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef5ba40 RCX: 1e1b0d788f0b2200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100ab23e96 R08: ffffffff81746c8c R09: 1ffff920005e7f3c
R10: dffffc0000000000 R11: fffff520005e7f3d R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88805591f498 R15: ffff88805591f4b0
FS:  00007f6bb22e16c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbe68be1000 CR3: 000000004b5ae000 CR4: 0000000000350ef0
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
RIP: 0033:0x7f6bb157f69a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6bb22e0e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6bb22e0ef0 RCX: 00007f6bb157f69a
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007f6bb22e0eb0
RBP: 0000000020005d80 R08: 00007f6bb22e0ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005dc0
R13: 00007f6bb22e0eb0 R14: 0000000000005dcb R15: 0000000020000240
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1810
Code: 1e 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 c4 ec ff 48 8b 33 48 c7 c7 20 d4 18 8c 44 89 e2 e8 92 98 af 09 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90002f3fd08 EFLAGS: 00010246
RAX: 000000000000003e RBX: ffffffff8ef5ba40 RCX: 1e1b0d788f0b2200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff1100ab23e96 R08: ffffffff81746c8c R09: 1ffff920005e7f3c
R10: dffffc0000000000 R11: fffff520005e7f3d R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88805591f498 R15: ffff88805591f4b0
FS:  00007f6bb22e16c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00171dff8 CR3: 000000004b5ae000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         684a64bf Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162dc99f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd75e1a00004094f
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b2dd3b980000


