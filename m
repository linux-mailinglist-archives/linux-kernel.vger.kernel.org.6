Return-Path: <linux-kernel+bounces-216033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08708909A48
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 00:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800BD2820A6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 22:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD1E61FFE;
	Sat, 15 Jun 2024 22:48:23 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9743ADA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718491703; cv=none; b=bTsRTUsu4prJE8fpk0v9dWd1xW8a+DXctM4scQMyxvUytPQ3JYMsjX2WGYrUMFjLoZy0ZAsiPgv+L/2PJAY17EJ8kBxOtEwNs9b5W1vED1L3r7w1r/fP3a3UeZTD74ZwPrnANIu/eP6iQ16+SnYLKJ68yFF7CRk76m/ypymq9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718491703; c=relaxed/simple;
	bh=rhm758PccSnzbkDow89Tq2dRBwoZjlt9c0+MpO5CxGs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V4rwpzFXprRABoMcaWWncSJS6ktb05eAnzIpV8iKFvzRV8ZQGXEWmpAuW+h9qC6p2H5otn7WdmQ6ikeLh0fLKEcbIpGvj0zogL7HmspTytL1asQw8gyF/Alr/Cwjydjj6KJCDwrRoFqdibEhLFnlewRlkd6S9OMifrrWg0KDZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3737b3ee909so35105605ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 15:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718491701; x=1719096501;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHwmET3iNuTWW1g+bMh5XKabUJfdx8vXevnRMY8KMvU=;
        b=dYMyayrssHhYzfrDlhpbYKSRf+prVbOD21BYUk8fS1toHJ/i4o7gQfeBkOs7oxAjAF
         bLeOFuirtHAHzbS4max/5fEiIKc1tmRoTSqlvYkdg9g1l1ULSQnUbZZ0zVpDXpPD6+zm
         4DcETZ8TPECtE9If+JgEFcC4Nb0YcfUp7n9J9pD12wLO19BPuxtiB0woEpMZfQQJwzAI
         YKdPdYmnk49slZifaYXY/dR0vQ9VzTXhvAQZ6QmXgEH8T4BhZKlLlHDtdNQtQ5nUdYbI
         /YgHfMP3lPAJsCNGmPIXLXBLw8zVkk9VjQ3v+gA8zFmgzgCZoHNGi2PX59sxf1n2XB5P
         cMtw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ou0AkvWIHQAWhTsBGlHAHoXoatyKm9ilWmZqrL+aNdPHwGQ4mUhKyXh6QQWsnZot3OA6xS6qztw7BflZ0lYpMhK5b2UujQaa2Moo
X-Gm-Message-State: AOJu0Yx5ub7qSleWQOLShOrNcWKX1F7UGQW0OcqGGzjjxIHxbXsWzCaw
	FFKpY1mLT14AA7xEU61jIUgtc+jD0XRUfFb5T8PvPfPxVIzgFkmgWaym5APOHPyO4stTQjMixcX
	fdhjr7Wy5ti8/cb0ANZBdgQ7iYp98DhiN2QLD5/b7yixLxMuq3+4mrLI=
X-Google-Smtp-Source: AGHT+IGenEZR7V7Fmb2kOnMl/p2jAghCtQoSEMq4nbTv8RxSqbIuzPjNkKnaZOGF6UYX3g1vX5SPXXx0BD+SUEhLFyC7SrpKm0+Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d07:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-375e0ec60a2mr4444995ab.3.1718491701004; Sat, 15 Jun 2024
 15:48:21 -0700 (PDT)
Date: Sat, 15 Jun 2024 15:48:20 -0700
In-Reply-To: <0000000000000de83f06191f79ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000635dec061af5871b@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_btree_node_read_done
From: syzbot <syzbot+e6332ce6aa831184a0eb@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d55446980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=e6332ce6aa831184a0eb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176f05de980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f0cbb1980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c40c1cd990d2/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2a94050804e/bzImage-2ccbdf43.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7ea194fe115d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6332ce6aa831184a0eb@syzkaller.appspotmail.com

bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=crc64,background_compression=zstd,str_hash=crc32c,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 8
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/btree_types.h:770:13
shift exponent 114 is too large for 32-bit type 'unsigned int'
CPU: 3 PID: 5185 Comm: syz-executor270 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a5/0x480 lib/ubsan.c:468
 btree_node_type_is_extents fs/bcachefs/btree_types.h:770 [inline]
 bch2_btree_node_read_done.cold+0x7a/0x17e fs/bcachefs/btree_io.c:1093
 btree_node_read_work+0x567/0x1060 fs/bcachefs/btree_io.c:1345
 bch2_btree_node_read+0x8b3/0xe40 fs/bcachefs/btree_io.c:1730
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1769 [inline]
 bch2_btree_root_read+0x2ca/0x690 fs/bcachefs/btree_io.c:1793
 read_btree_roots fs/bcachefs/recovery.c:475 [inline]
 bch2_fs_recovery+0x1ba8/0x3db0 fs/bcachefs/recovery.c:803
 bch2_fs_start+0x2e9/0x600 fs/bcachefs/super.c:1035
 bch2_fs_open+0xfa0/0x1110 fs/bcachefs/super.c:2127
 bch2_mount+0xe2c/0x1230 fs/bcachefs/fs.c:1919
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fac2a06097a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed16b1868 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffed16b1880 RCX: 00007fac2a06097a
RDX: 0000000020005b00 RSI: 0000000020000040 RDI: 00007ffed16b1880
RBP: 0000000000000004 R08: 00007ffed16b18c0 R09: 0000000000005b2d
R10: 0000000000018080 R11: 0000000000000282 R12: 0000000000018080
R13: 00007ffed16b18c0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
---[ end trace ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

