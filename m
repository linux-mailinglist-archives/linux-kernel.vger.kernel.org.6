Return-Path: <linux-kernel+bounces-214581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3F9086BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C551F238D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2871922FB;
	Fri, 14 Jun 2024 08:49:21 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134221922F1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354960; cv=none; b=OXKrdh73O2tmWnCphThC6bcd49440XstXojIMZY31b7gTrJ11QlFo4BeJV0v+ky5zSIGcXLCh0QajXAgR3A98ECtNxZX5/kflQHqrnP62Pv20tUIHo3AwSDD7efB4fAUOwjvBdWFwhzldkYvvpAwCeatU+MU+IoFcFbvjqP84EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354960; c=relaxed/simple;
	bh=lCxLZ1jhfYeUr3/B5XOog1WjeFt0legx4YYkJ+//xEg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eD6OklgRYC/3yAUUfOXxup2SLnTTB+gxdQ/9oJ76/yxNbCQ5KrqMkeJpqYjFJ8wId6pVWbeu1O0g3ZM5YjU3OA2LPXcXL89JrjXAmZ1K022iJNu0ViNYPSP4eQrj6KPjD/iPNJBEC/9iEagJHDa9hVVKrTIHjM3T0BNtnK5TU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-375e4d55457so4141005ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718354958; x=1718959758;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aoh0lWoZWyMKOCiZ/GkjoLIjSvrckR8nhdbcjZfH2ME=;
        b=AFyK3aGcVAcGZdZzD9mVchgdlQZ2omHjd/qJg5CZ2vPI18bJOLgk+pcbU56LUX/sh2
         P+Su9417o3tQI4sE6n2L0R5z7M6sWf4fm/URmJqbjFTp7WWwOMnTqI4nh7vL5CBSe4r5
         U7bm7eZfeV5tSV3DQZ5+fOk21MjIbIE1KPCF/4R3BOI9+QgGwTmLSR6LPNgp28EZAjWK
         Numk1JtXNrlM/hT+n0lmo5+ewSGHN/rD8B4L3iA+nCeBn0i1vHNwOeFfdGGTBeubZbV3
         gT3iQ0HEmu8l0T3SOMV4/2u6neWr7zYGqmx74jAe9I9NIXm3Wr/NVcfP6yNat6uR25w0
         k9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWhcB1ilRWIfK2PQnj9xQy9BGvwg3iXw/+pHyqFjJKqry5aM+0YuTfd6k3gD2DYhx+pE+Suisi3JcdnHAumovP5lwuDwghtBxSjzEo5
X-Gm-Message-State: AOJu0YzbClE0XnIFvYYqTy857PczMLTVpAD1wYZwjT28gmwDiwZ3ez8E
	Wp8EolEbtkdJ+cwcqioGO6Jf9O68Blw02zYWsGuiGO3aW3lexunlFe3aXWS1j6+SMmJh/AGVKYd
	M66bkrUwKQigevtuzKwxDO/HxAnTAKuomw6hGi9sthhpku3AhNqrQVzU=
X-Google-Smtp-Source: AGHT+IE9Jf1o8s2Vvpg7dmjepygj8kG5e7Grhjv6Aqp+Fs4Uk4hoy281Zo9keAYoqiCLq9ShzM8HDjTb8Lz/SqnsatDbhl76d8U2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:cbad:7b48 with SMTP id
 e9e14a558f8ab-375e0ca71a0mr1198255ab.0.1718354958203; Fri, 14 Jun 2024
 01:49:18 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:49:18 -0700
In-Reply-To: <000000000000515313061a401ea1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1d227061ad5b0ff@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_lru_change
From: syzbot <syzbot+df3bf3f088dcaa728857@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166b0256980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=df3bf3f088dcaa728857
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13671b36980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138c060e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35e32e9073a7/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c6e34658d16/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4417e7ef76ed/bzImage-2ccbdf43.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/530a9caabe6f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df3bf3f088dcaa728857@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/lru.h:22!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5082 Comm: syz-executor251 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:lru_pos fs/bcachefs/lru.h:22 [inline]
RIP: 0010:__bch2_lru_set fs/bcachefs/lru.c:48 [inline]
RIP: 0010:bch2_lru_del fs/bcachefs/lru.c:54 [inline]
RIP: 0010:bch2_lru_change+0x65c/0x680 fs/bcachefs/lru.c:69
Code: 80 e1 07 38 c1 0f 8c 47 fd ff ff be 14 00 00 00 48 8b 7c 24 10 e8 84 e1 c4 fd e9 33 fd ff ff e8 fa 25 4a 07 e8 25 65 62 fd 90 <0f> 0b e8 1d 65 62 fd 90 0f 0b e8 15 65 62 fd 90 0f 0b e8 0d 65 62
RSP: 0018:ffffc90002e36c00 EFLAGS: 00010293
RAX: ffffffff8433c0eb RBX: 1ffff920005c6d96 RCX: ffff888023ab1e00
RDX: 0000000000000000 RSI: 5fcf000010000000 RDI: 0000ffffffffffff
RBP: ffffc90002e36d30 R08: ffffffff8433bc33 R09: ffffffff84012068
R10: 0000000000000003 R11: ffff888023ab1e00 R12: 0000ffffffffffff
R13: 1ffff920005c6d88 R14: 5fcf000010000000 R15: ffff000010000000
FS:  00005555744f0380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff302f2f28 CR3: 000000007bf7e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_trigger_alloc+0x1660/0x3bc0 fs/bcachefs/alloc_background.c:798
 bch2_key_trigger fs/bcachefs/bkey_methods.h:88 [inline]
 run_one_trans_trigger fs/bcachefs/btree_trans_commit.c:509 [inline]
 run_btree_triggers+0xbff/0x11d0 fs/bcachefs/btree_trans_commit.c:544
 bch2_trans_commit_run_triggers fs/bcachefs/btree_trans_commit.c:587 [inline]
 __bch2_trans_commit+0x574/0x88e0 fs/bcachefs/btree_trans_commit.c:1022
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 bch2_inode_delete_keys+0xae8/0x1440 fs/bcachefs/inode.c:845
 bch2_inode_rm+0x165/0xd40 fs/bcachefs/inode.c:874
 bch2_evict_inode+0x21c/0x3c0 fs/bcachefs/fs.c:1581
 evict+0x2a8/0x630 fs/inode.c:667
 do_unlinkat+0x512/0x830 fs/namei.c:4414
 __do_sys_unlink fs/namei.c:4455 [inline]
 __se_sys_unlink fs/namei.c:4453 [inline]
 __x64_sys_unlink+0x49/0x60 fs/namei.c:4453
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5ee8e4b17
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff302f36d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff5ee8e4b17
RDX: 00007fff302f3700 RSI: 00007fff302f3790 RDI: 00007fff302f3790
RBP: 00007fff302f3790 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007fff302f4880
R13: 00005555744f9700 R14: 0000000000000001 R15: 431bde82d7b634db
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lru_pos fs/bcachefs/lru.h:22 [inline]
RIP: 0010:__bch2_lru_set fs/bcachefs/lru.c:48 [inline]
RIP: 0010:bch2_lru_del fs/bcachefs/lru.c:54 [inline]
RIP: 0010:bch2_lru_change+0x65c/0x680 fs/bcachefs/lru.c:69
Code: 80 e1 07 38 c1 0f 8c 47 fd ff ff be 14 00 00 00 48 8b 7c 24 10 e8 84 e1 c4 fd e9 33 fd ff ff e8 fa 25 4a 07 e8 25 65 62 fd 90 <0f> 0b e8 1d 65 62 fd 90 0f 0b e8 15 65 62 fd 90 0f 0b e8 0d 65 62
RSP: 0018:ffffc90002e36c00 EFLAGS: 00010293
RAX: ffffffff8433c0eb RBX: 1ffff920005c6d96 RCX: ffff888023ab1e00
RDX: 0000000000000000 RSI: 5fcf000010000000 RDI: 0000ffffffffffff
RBP: ffffc90002e36d30 R08: ffffffff8433bc33 R09: ffffffff84012068
R10: 0000000000000003 R11: ffff888023ab1e00 R12: 0000ffffffffffff
R13: 1ffff920005c6d88 R14: 5fcf000010000000 R15: ffff000010000000
FS:  00005555744f0380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff302f2f28 CR3: 000000007bf7e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

