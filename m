Return-Path: <linux-kernel+bounces-383033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72CE9B165D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A71F22333
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239B18B484;
	Sat, 26 Oct 2024 09:03:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A01217F5E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933417; cv=none; b=q81ZQV0+G0+529eKeZCvUh+NxUbzrIy0nei2/WJzF/vOfWp+uN/Y6ndJjc3r2Dc+RQgCI/DbVgB5WPwcH4TPP3149ttCqVK11bm9+GyV8lvI/SEiFA4ODCyOiop3lah3m76hLSqku9JTGhZe9kojCD2oylCI/+u09599Z3SiIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933417; c=relaxed/simple;
	bh=n3dxpKG7PDkSS9e5CRBKiQl4a3wBwQYi6KjpObJ+6rw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gF+hPNRcuYgN2JIkoJUSwY7f7BIjNq8HEonk7GeU6TGNKrnvM+2+Umxltd6jDz5RI43sVEPQktmQ7XIYBVhM2a22O3+PISUY7ELIQYxOsBHiy+ZeXYVNdwNLWZGo9gBQlxmtJFDeypna3/UKRfQW1tuLn+PggDPHAIremIsqq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so18518965ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 02:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729933414; x=1730538214;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sG4XHlnzN5DUAEd5svBFUxtWwwypD6csEbi2+gJVVc=;
        b=lQ/4fQptORFyPsBL71HwosiNkdfeANeyl9B0FChfmzCkMXQrrXUoysLXKGEqsG5bQk
         U+yX2IpweTHyfUDeyntnfOHxt3i0W+l72Bbw7HyHujFBh7KlADA/M8eEw1yzl0JHyha9
         cwjsYX8K/Nn+Jl1+zB8laoVjpEcUi5GXN4OT68A2v3S+l6NquUgLp0eeED8JHgCjOuB6
         a5Qm1WQ/Jrszwh8BSEfb8oyCn8/KYjG5Zx/hcSuiSTc5colyoECpTDpL4j3fdulMyIG6
         RMiJv+W3UtfaG+9/EfJHUA4i9WELUFzNR2vFeYXlwr2QEe/uIl+zrT+FTQvkPBCB7VIW
         oONg==
X-Forwarded-Encrypted: i=1; AJvYcCXEQG/FXYDSh6aBkp4YIIGwS3jJrQumdHyo7b2v3BYtRNtdG7K+kfYKQmU/I9ogPDQN/tR3cD27dUKcUic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWwRpJ1qvoF8tW0Q9EfJE1r71WUx3gwE5fMg0Y/wkqdyVVnxZ
	0ZP4UXWmbV3jLjSRUuQj6CKWbJjxaCTHikGIiOh5RJt+iGjmQGlUblJd7lFREjbIZpQr+XlvpCx
	4owqkuYOA0D1IgzbB3unHEy7de+YgBj4fmg3QOdQiTqauGr1g8j6imfA=
X-Google-Smtp-Source: AGHT+IGm3vsLeh9Xz6GAGhL7gXfotLh21h1w7dvfVIJpH0ihvHBy2sRb2Wxfrfpldqe+HWEJUvgCzqvhyVh/O0bSQuQ11vT9xaRI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:3a0:9c20:8070 with SMTP id
 e9e14a558f8ab-3a4ed2f6686mr17340985ab.20.1729933414571; Sat, 26 Oct 2024
 02:03:34 -0700 (PDT)
Date: Sat, 26 Oct 2024 02:03:34 -0700
In-Reply-To: <66fc2239.050a0220.f28ec.04b8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671cb066.050a0220.2fdf0c.0227.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in p9pdu_vwritef
From: syzbot <syzbot+94b73a3e8ea625efcd05@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c71f8fb4dc91 Merge tag 'v6.12-rc4-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1604d65f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=94b73a3e8ea625efcd05
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1104d65f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149284a7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c71f8fb4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a47500c947a2/vmlinux-c71f8fb4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8ce30ea9c33/bzImage-c71f8fb4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94b73a3e8ea625efcd05@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb06f03c42c
R13: 0000000000000010 R14: 00007fff482ff820 R15: 00007fff482ff908
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5322 at lib/iov_iter.c:255 _copy_from_iter+0x35b/0x1e70 lib/iov_iter.c:255
Modules linked in:
CPU: 0 UID: 0 PID: 5322 Comm: syz-executor360 Not tainted 6.12.0-rc4-syzkaller-00256-gc71f8fb4dc91 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:_copy_from_iter+0x35b/0x1e70 lib/iov_iter.c:255
Code: 84 24 20 01 00 00 0f 85 8e 1a 00 00 48 8b 44 24 18 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 26 12 da fc 90 <0f> 0b 90 eb 17 e8 1b 12 da fc 4c 89 e8 4c 89 6c 24 18 e9 f8 fd ff
RSP: 0018:ffffc9000cf8ebe0 EFLAGS: 00010293
RAX: ffffffff84bad84a RBX: 0000000000000000 RCX: ffff8880009d8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000cf8ed50 R08: ffffffff84bad5af R09: 1ffffd400028a680
R10: dffffc0000000000 R11: fffff9400028a681 R12: ffff8880514d0017
R13: 0000000000007fec R14: ffff88801e217562 R15: 1ffff920019f1d90
FS:  00007fb06ef636c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000042bac000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 copy_from_iter include/linux/uio.h:219 [inline]
 copy_from_iter_full include/linux/uio.h:236 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x1c75/0x29e0 net/9p/protocol.c:614
 p9_client_prepare_req+0xa8d/0xf50 net/9p/client.c:651
 p9_client_rpc+0x19d/0xac0 net/9p/client.c:691
 p9_client_write+0x328/0x7a0 net/9p/client.c:1645
 v9fs_issue_write+0xfd/0x1c0 fs/9p/vfs_addr.c:59
 netfs_do_issue_write fs/netfs/write_issue.c:233 [inline]
 netfs_issue_write fs/netfs/write_issue.c:260 [inline]
 netfs_advance_write+0x972/0xbd0 fs/netfs/write_issue.c:301
 netfs_write_folio+0x12fb/0x2070 fs/netfs/write_issue.c:485
 netfs_writepages+0x8aa/0xb80 fs/netfs/write_issue.c:581
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 file_write_and_wait_range+0x195/0x280 mm/filemap.c:788
 v9fs_file_fsync+0xf3/0x1d0 fs/9p/vfs_file.c:418
 generic_write_sync include/linux/fs.h:2871 [inline]
 netfs_file_write_iter+0x36d/0x3f0 fs/netfs/buffered_write.c:487
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb06efb6b39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb06ef63148 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb06ef63150 RCX: 00007fb06efb6b39
RDX: 000000000000fdef RSI: 0000000020000100 RDI: 0000000000000007
RBP: 0000000000000002 R08: 00007fb06ef62ee6 R09: 0000000000003933
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb06f03c42c
R13: 0000000000000010 R14: 00007fff482ff820 R15: 00007fff482ff908
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

