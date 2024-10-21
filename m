Return-Path: <linux-kernel+bounces-374011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950EC9A6094
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B2B28100E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6361E376D;
	Mon, 21 Oct 2024 09:48:40 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C6198A0C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504119; cv=none; b=DOmztnyyx/mdyzxdsMaVALpniRBm3gCIv9df5tDWU6WmbME5Uolvs2qpZq9A/7bmjF/T2r/5DKfr/T0er2PGhioml9LD4Tzs9XYN0k1KIkUdGOhnpDGM2h7rqS0ak/GTtZTtL0LXbJ3vz7uNi8sGGOv6eoHQAKiRypGKdrqHKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504119; c=relaxed/simple;
	bh=WlasfIzrdwdmRFmYoxAQnRMw44by65kcpFlvXFxQ6ZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tOz0i61vVDW9C8Hwgnd8Qd4d2SLabLdzw+xIc58p4foI4uh9o6qLQBwUSyqsj0GcSYKvMylUCjj63E2+PfOT9nbFFrD+v7boy2bA83hBm4SdDocAKNHYMalo6zgIJSp/g3vXM18yhoy9Sa1imQyqmYcVUT3LbnQoS026WtDuqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso43416215ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504117; x=1730108917;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAk+FBZSQ2Rj8j6YsolBZryf7ITZaXmHRRT4gy57V5U=;
        b=VxFzJdXMS3+w0osNaAe+lG9OM6TGA9dHgccx6gwKQF4obilcr/UqwhES3JBgmIcwsS
         kUxQM0/KwKRrEKLnWRHkR9wEn4gTzmho7vCD6qE3ZZq6i2um8D3c9K/TPFcl8iLUfNJO
         vRX5CIue4bT/JNfnT+dfSvFNWmKgfoa5GTQk7FMZ8aG0zeTVnGE5pMVfFA+GqBntlzhs
         HHqrv19zRgsvN0RF8USM4S7k+xnzC8lobHOR/ySiu6RI5Ani8r6NHxnvxZWyupkB8W6U
         bK84H4Bt/0wbR0uRJuoP9S4BIbads4aNsH8/lOspjW5ilShN9/3GxRzcMVxpM3RghggK
         U3RA==
X-Forwarded-Encrypted: i=1; AJvYcCUTzjwcx0nBrac5/4nUU3FT5H91LY3zFnXzZzE3xTlgDrrV3A9c9Xwu5tr6fHbApPRy8wurtLBkmbXWBxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGplnYaRTNMZWHmSgEGLHKZZSUO5JWhb/WbaLFretHbL/XnXO
	J65kyDjOSv3a5oqcjcWO6fsAhnxe0fv71SQSjumoGsZqotwSJr6ikp31zCpLbg5/ix1QF3NdEnl
	O7/UA/2VcineDH7G2TXlLt0FWIfbRWAN0+bkQqwiNSHOitx4WuY5SkDQ=
X-Google-Smtp-Source: AGHT+IFzCM9KL02rlmENjVVm2HUojSpl5z+P36lytHeYZcOw89y6u2Z7kyknTj8HSSIKxyanTJnTGzv4fkBxoLmx/hLfGAM4JuE6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c9:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a3f40b7159mr76977225ab.23.1729504116703; Mon, 21 Oct 2024
 02:48:36 -0700 (PDT)
Date: Mon, 21 Oct 2024 02:48:36 -0700
In-Reply-To: <670cb3f6.050a0220.3e960.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67162374.050a0220.10f4f4.0045.GAE@google.com>
Subject: Re: [syzbot] [nilfs] [fs] kernel BUG in submit_bh_wbc (3)
From: syzbot <syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, konishi.ryusuke@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    42f7652d3eb5 Linux 6.12-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c66a40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=985ada84bf055a575c07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1541e430580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1181e0a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21f56ec05989/disk-42f7652d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d295ea00e68a/vmlinux-42f7652d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c4b95c7f67f/bzImage-42f7652d.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/709e6e32762f/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/6576d8861c23/mount_7.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/buffer.c:2785!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5235 Comm: syz-executor372 Not tainted 6.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
Code: 89 fa e8 dd 76 cc 02 e9 95 fe ff ff e8 73 85 74 ff 90 0f 0b e8 6b 85 74 ff 90 0f 0b e8 63 85 74 ff 90 0f 0b e8 5b 85 74 ff 90 <0f> 0b e8 53 85 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003b6f0d8 EFLAGS: 00010293
RAX: ffffffff82206235 RBX: 0000000000000154 RCX: ffff88802d490000
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: 0000000000000100 R08: ffffffff82205df9 R09: 1ffff1100ef571d0
R10: dffffc0000000000 R11: ffffed100ef571d1 R12: 0000000000000000
R13: ffff888077ab8e80 R14: 0000000000000000 R15: 1ffff1100ef571d0
FS:  0000555573f7e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbda422e00a CR3: 000000002fc1e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 submit_bh fs/buffer.c:2824 [inline]
 block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2451
 do_mpage_readpage+0x1a73/0x1c80 fs/mpage.c:317
 mpage_read_folio+0x108/0x1e0 fs/mpage.c:392
 filemap_read_folio+0x14b/0x630 mm/filemap.c:2367
 do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3825
 read_mapping_folio include/linux/pagemap.h:1011 [inline]
 nilfs_get_folio+0x4b/0x240 fs/nilfs2/dir.c:190
 nilfs_find_entry+0x13d/0x660 fs/nilfs2/dir.c:313
 nilfs_inode_by_name+0xad/0x240 fs/nilfs2/dir.c:394
 nilfs_lookup+0xed/0x210 fs/nilfs2/namei.c:63
 lookup_open fs/namei.c:3573 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x11a7/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbda41e54a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5e610168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbda41e54a9
RDX: 000000000000275a RSI: 0000000020000180 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 00000000000051a5 R09: 000000002000a440
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe5e61019c
R13: 0000000000000007 R14: 431bde82d7b634db R15: 00007ffe5e6101d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
Code: 89 fa e8 dd 76 cc 02 e9 95 fe ff ff e8 73 85 74 ff 90 0f 0b e8 6b 85 74 ff 90 0f 0b e8 63 85 74 ff 90 0f 0b e8 5b 85 74 ff 90 <0f> 0b e8 53 85 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003b6f0d8 EFLAGS: 00010293
RAX: ffffffff82206235 RBX: 0000000000000154 RCX: ffff88802d490000
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: 0000000000000100 R08: ffffffff82205df9 R09: 1ffff1100ef571d0
R10: dffffc0000000000 R11: ffffed100ef571d1 R12: 0000000000000000
R13: ffff888077ab8e80 R14: 0000000000000000 R15: 1ffff1100ef571d0
FS:  0000555573f7e380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd9cbff000 CR3: 000000002fc1e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

