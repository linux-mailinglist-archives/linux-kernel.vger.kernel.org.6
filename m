Return-Path: <linux-kernel+bounces-311221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C304968642
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A64E281550
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0177186E5B;
	Mon,  2 Sep 2024 11:32:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B29195
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276747; cv=none; b=ngm+hvP9Nb6ffVvnqY6ZZJ12FbTyZIjCEb+7WhXp6bGbvdD/Kr0oHWKt/uj/M0rJ9jXoXqjO+0TAqe2wj/FtGec7E6gcHHgjFmWAOVhcJ593KsSaqo1XG9jR7fbTyjRhm7oaX4NG+tRE8bHC99g4qDHyBXmpVnsmRFXJsC21T1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276747; c=relaxed/simple;
	bh=p4Bp5xa5G055V/DdEVD5CHNMNJBjIwA7IUM+aXuzAus=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fBAOZyz6EItkAUZOkLFkpwhwTSDHF5ILAXbESp214n59ZmvozTiHq1rHvj3Bq1NKaBrNn5sEbWo1BWuHtRH8SHZIW9k3rjatNLY/Cu5lYEfBO26iWVZy1za15jZ/qf5NKjAActtzFNS4kUgWW5ANVzX0rat6cyS7JUh2MOzKRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a246af0aaso377004839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725276745; x=1725881545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfj7/unb5Y/8Jp60UCn4Zs1L6qkNzEH9kIrKvtPXpxo=;
        b=UgLrUNpOm+FsxAVPRR/LJGkn9ppwwiZ4+WH7VaKm5aiJtEarxtpY6Zr2m/LiMBpBKL
         D6Xkls/F+lx+3dS3uiqfMvmLF311JmiCr4oEr7Jxis2YwkJEg2Bg1D8XAhbvaLrkxv+G
         YUaNr/GJZKDvZDT6gfhicw2z4mQa+qY2SQAdY4ZY2CHzYh19A3MOINJsaGMeawf2XkVe
         n/3MAlxp9a9e68t2R9YK9pC3CEDeVX23EWEMzz/oppUkyA4kF2uFBnA/ltc37/bYIi/P
         aHoLbzBd01RbLfbgshcbkDCdWDIYye0EhSDmNCVRPBF9n3tlIcoDb5gDy+RHghyWUm0E
         jICQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbTQvloOLsYOKterKCHlGGGYuh7jlDsv19QZJTjlgZBzeYNSISpWvyp8H7aL48BZL+QBsoEAMykyxLY7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDqU6dWDtbcFKzFj6rvtjF6vGSG7oUSl+zKZNEaKpkiHx7Zj6
	VMTat/7mRslOzPERY+4bGA55kZSLTIZb/uZc65xUQWNlSD/PduqrnoNqMJ30Vz6ZXwmVqEXTI7u
	4YThp65YZFUHrYbzV92frni4vrvmNm/AJbIJ11C+BLcOCO689t7ELBTU=
X-Google-Smtp-Source: AGHT+IElG8hBzyo5uPdCfIWS6oEEBGj5NX8Uk/2PB7g5lFKv2FIwWq0BJ/ToiGDaqITTK3WP5vuDgN1Jsdc5w3pU75PIUvWXxTu/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15cd:b0:82a:133e:c3d2 with SMTP id
 ca18e2360f4ac-82a26122876mr31817739f.0.1725276744954; Mon, 02 Sep 2024
 04:32:24 -0700 (PDT)
Date: Mon, 02 Sep 2024 04:32:24 -0700
In-Reply-To: <0000000000002f64da061e021fc2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085c6cd0621214be6@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in jfs_unlink
From: syzbot <syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c9f016e72b5c Merge tag 'x86-urgent-2024-09-01' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14d09929980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8926d683f62db53e
dashboard link: https://syzkaller.appspot.com/bug?extid=41b43444de86db4c5ed1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106934fb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15617f2f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e47617e91522/disk-c9f016e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69d8aef7dff1/vmlinux-c9f016e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd5392c61560/bzImage-c9f016e7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7111d4efcae8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com

BUG at fs/jfs/namei.c:513 assert(ip->i_nlink)
------------[ cut here ]------------
kernel BUG at fs/jfs/namei.c:513!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5224 Comm: syz-executor204 Not tainted 6.11.0-rc6-syzkaller-00017-gc9f016e72b5c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:jfs_unlink+0xafd/0xb30 fs/jfs/namei.c:513
Code: e8 c8 5d 91 08 e8 83 f0 73 fe 48 c7 c7 20 9c 22 8c 48 c7 c6 e0 99 22 8c ba 01 02 00 00 48 c7 c1 60 9c 22 8c e8 64 5e 8e 08 90 <0f> 0b e8 5c f0 73 fe 48 c7 c7 20 9c 22 8c 48 c7 c6 e0 99 22 8c ba
RSP: 0018:ffffc9000344fbe0 EFLAGS: 00010246
RAX: 000000000000002d RBX: 0000000000000000 RCX: 44cfc770ad800100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000344fd10 R08: ffffffff8174016c R09: 1ffff92000689f1c
R10: dffffc0000000000 R11: fffff52000689f1d R12: 0000000000000000
R13: ffffc9000344fc60 R14: 1ffff92000689f8c R15: ffff888072c33248
FS:  0000555577bcd380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045bdd0 CR3: 000000007ab8a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_unlink+0x365/0x650 fs/namei.c:4422
 do_unlinkat+0x4ae/0x830 fs/namei.c:4486
 __do_sys_unlink fs/namei.c:4534 [inline]
 __se_sys_unlink fs/namei.c:4532 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4532
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f69ef25fad7
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4544dac8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f69ef25fad7
RDX: 00007fff4544daf0 RSI: 00007fff4544db80 RDI: 00007fff4544db80
RBP: 00007fff4544db80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007fff4544ec70
R13: 0000555577bd6700 R14: 0000000000000001 R15: 431bde82d7b634db
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jfs_unlink+0xafd/0xb30 fs/jfs/namei.c:513
Code: e8 c8 5d 91 08 e8 83 f0 73 fe 48 c7 c7 20 9c 22 8c 48 c7 c6 e0 99 22 8c ba 01 02 00 00 48 c7 c1 60 9c 22 8c e8 64 5e 8e 08 90 <0f> 0b e8 5c f0 73 fe 48 c7 c7 20 9c 22 8c 48 c7 c6 e0 99 22 8c ba
RSP: 0018:ffffc9000344fbe0 EFLAGS: 00010246
RAX: 000000000000002d RBX: 0000000000000000 RCX: 44cfc770ad800100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000344fd10 R08: ffffffff8174016c R09: 1ffff92000689f1c
R10: dffffc0000000000 R11: fffff52000689f1d R12: 0000000000000000
R13: ffffc9000344fc60 R14: 1ffff92000689f8c R15: ffff888072c33248
FS:  0000555577bcd380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045bdd0 CR3: 000000007ab8a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

