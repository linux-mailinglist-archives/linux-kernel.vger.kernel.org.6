Return-Path: <linux-kernel+bounces-373084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9A9A5207
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C501C211C4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0224431;
	Sun, 20 Oct 2024 03:14:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF210F7
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394046; cv=none; b=nSHq1DSm0ynU9mKIJ2nFnwO8scjUvGBtKOzpcdUeDTKzFL5xGzwnJk9iXGgn5wZXPJQES9ffy44Cq6n8gl1XciIRqhF+Y+S+fo9yJmJ8mpI9v7qiiVwAmfo5IrxmnXHVjWdpUOosTsht7npi5yuw2igNvxIdB068wOrYDXjgN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394046; c=relaxed/simple;
	bh=97nX+JwtmWAong1vASDtGXC3KZSBHUbyOD9iFEyShiU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gKvGPPLCbTW3KBfNHscgLYTAl/SrNtSq5P8pCY+NayOCzeav2bYuuPxy0bFgSAnnLg0R9PkqvAdHlkdhjFbEYQXf7kodyjTVA4TA6Iafn8UMVrEkhuEowrM9fc5CbPpjMh9BUbvmkUdltQ+Ak6sbvPw96Hs0poAKl6LPaVYVKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so32459265ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729394043; x=1729998843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bx8tiWhvy5E223dYLjaagfUIUW1HJSQHNEl6V98884M=;
        b=TbXwD07ZCgMG4wqNVpCG6llOc3BRXSV2TIj0Cty2n5p26BdJTFTrXbA9/tPXx4aX/o
         cBsg0ZIC7x94CZ5//YAJhSUN63TjY6O1HAEnaPEhIeECMUdvXdwKfJqOSdrRIngysc/4
         16HUhGXpYulpmrB8WYPtYEyS1MQDt/AuYAzjh3Orfb1OfNPsQhxQtR+Xt0l6KCWwOSsA
         ebgGvveUC8Yy6uliBXNmLKeiYbDr0fTfEwCbMpVTBOQ8SVWNWjvM4gOd3Lma+5ceyJVf
         aOQLOw7tqmRSpMd5SK57cHznh3VU3vLwHq8OYu87oDDpiFiBrsKQgDz+ff/NIcZ9pUfM
         S0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHyweha/bI3Rb3wQoDhJlIjG0W+liXi+qYREgJ2kXrjdpO3aIa66uQH4KmDq3yyAArfoFTUTWImYNYucA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3edHYBDsGqbJsGyAGS486+7/rOcM4er3C9aZByAkFI10yINn+
	oLZZ+uU1Djd664DgvzuWotSbPQx6KaquUUuVAtT9uc6ntZcKyOtIsXMTIychjRa4u4mP+ZLAfi9
	iAWesSnrLzbMIYlp8WBvUvoJxw4Q6OQ+6n6GzX/GuqyTEyN6sR33+Uss=
X-Google-Smtp-Source: AGHT+IGhakiJW1kcZ6lTtL+hLCgA1uS4ylllkIF37Z9FbSgcgnjTJT2TiJf/ZgRMQuluvtGiOCtW0kP9/zH/vhVzJqerZvogZLXU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:3a1:a163:ba64 with SMTP id
 e9e14a558f8ab-3a3f404fa82mr56468595ab.3.1729394042845; Sat, 19 Oct 2024
 20:14:02 -0700 (PDT)
Date: Sat, 19 Oct 2024 20:14:02 -0700
In-Reply-To: <tencent_1756D762F77466DD937EA36E2960A3AD4405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714757a.050a0220.1e4b4d.0030.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in
 xfs_filestream_select_ag (2)
From: syzbot <syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in xfs_filestream_select_ag

pag: 0000000000000000, xfs_filestream_pick_ag
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 UID: 0 PID: 6564 Comm: syz.0.31 Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:xfs_filestream_select_ag+0xfd0/0x1d60 fs/xfs/xfs_filestream.c:377
Code: 24 08 49 83 c4 18 4c 89 e0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 e7 e8 5f 3c a7 fe 49 8b 1c 24 48 83 c3 08 48 89 d8 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 bb 07 00 00 8b 1b 48 8b 94 24 a0 00 00 00
RSP: 0018:ffffc900043eeb58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff88802ea13c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174af9c R09: 1ffff9200087dd08
R10: dffffc0000000000 R11: fffff5200087dd09 R12: ffffc900043eeda8
R13: dffffc0000000000 R14: ffffc900043eefe0 R15: ffffc900043eed90
FS:  00007f847f8b96c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd5ac27b378 CR3: 0000000024938000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfs_bmap_btalloc_filestreams fs/xfs/libxfs/xfs_bmap.c:3657 [inline]
 xfs_bmap_btalloc fs/xfs/libxfs/xfs_bmap.c:3774 [inline]
 xfs_bmapi_allocate+0x162d/0x3450 fs/xfs/libxfs/xfs_bmap.c:4189
 xfs_bmapi_convert_one_delalloc fs/xfs/libxfs/xfs_bmap.c:4697 [inline]
 xfs_bmapi_convert_delalloc+0x9a0/0x1970 fs/xfs/libxfs/xfs_bmap.c:4752
 xfs_map_blocks+0x7b7/0x1050 fs/xfs/xfs_aops.c:363
 iomap_writepage_map_blocks fs/iomap/buffered-io.c:1816 [inline]
 iomap_writepage_map fs/iomap/buffered-io.c:1964 [inline]
 iomap_writepages+0xd49/0x2ac0 fs/iomap/buffered-io.c:2018
 xfs_vm_writepages+0xfc/0x150 fs/xfs/xfs_aops.c:477
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 file_write_and_wait_range+0x195/0x280 mm/filemap.c:788
 xfs_file_fsync+0x1d3/0xa80 fs/xfs/xfs_file.c:138
 generic_write_sync include/linux/fs.h:2871 [inline]
 xfs_file_buffered_write+0x9a8/0xac0 fs/xfs/xfs_file.c:829
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f847eb7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f847f8b9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f847ed36208 RCX: 00007f847eb7dff9
RDX: 0000000000000048 RSI: 0000000020020cc0 RDI: 0000000000000004
RBP: 00007f847ebf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f847ed36208 R15: 00007fff16fee758
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:xfs_filestream_select_ag+0xfd0/0x1d60 fs/xfs/xfs_filestream.c:377
Code: 24 08 49 83 c4 18 4c 89 e0 48 c1 e8 03 80 3c 28 00 74 08 4c 89 e7 e8 5f 3c a7 fe 49 8b 1c 24 48 83 c3 08 48 89 d8 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 bb 07 00 00 8b 1b 48 8b 94 24 a0 00 00 00
RSP: 0018:ffffc900043eeb58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff88802ea13c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8174af9c R09: 1ffff9200087dd08
R10: dffffc0000000000 R11: fffff5200087dd09 R12: ffffc900043eeda8
R13: dffffc0000000000 R14: ffffc900043eefe0 R15: ffffc900043eed90
FS:  00007f847f8b96c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f17012ff000 CR3: 0000000024938000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	24 08                	and    $0x8,%al
   2:	49 83 c4 18          	add    $0x18,%r12
   6:	4c 89 e0             	mov    %r12,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  11:	74 08                	je     0x1b
  13:	4c 89 e7             	mov    %r12,%rdi
  16:	e8 5f 3c a7 fe       	call   0xfea73c7a
  1b:	49 8b 1c 24          	mov    (%r12),%rbx
  1f:	48 83 c3 08          	add    $0x8,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 bb 07 00 00    	jne    0x7f1
  36:	8b 1b                	mov    (%rbx),%ebx
  38:	48 8b 94 24 a0 00 00 	mov    0xa0(%rsp),%rdx
  3f:	00


Tested on:

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14deb240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=4125a3c514e3436a02e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157a0c87980000


