Return-Path: <linux-kernel+bounces-347369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4B98D1C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBDB1C215DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CCD1EC004;
	Wed,  2 Oct 2024 10:54:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCD1EBFFC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866469; cv=none; b=BuxFmJHTUZMwaZhBJNUIlio87Rep0pe0toUDyeRlHsfHrxLuQqXR3OeKVLCHGIatgLueEQ/Wm5NMbKQtxQ1KLwSD2D4ppHYjuyLyUMvLJyu2n8TaCEyCKlA3JxOuGn8PQ52ANGBXNf56wqeVxNqVje+SYY3VfRbSAvkz4KHLf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866469; c=relaxed/simple;
	bh=Jn2w8KbCtODWjc90Pe9cF1uEbew1QeRsgtJCVjrREZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s7jG7lp99MiLzs8AsHaXEsPO9iDfk+KZWCZpXz+6KW96F/CvinR1/lp9Nb49OgxAs999Wjl+EdmCV2KuQmL7bd/YIsDnc3rgcx38LfyHo7ot+TEPWRDrviMapkYU0Ph4QG4qwI9d0WyVonj8+EcQxQ56DBNvPnut78kNtAFG4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so92107695ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 03:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866467; x=1728471267;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoAmgCGX6l11CJrPMpadAIjDi4yqQdtg+my/4u5cLJc=;
        b=D/pO4OZzvDAwttsBDDTAJozAqBAJamzdMGjkOVoCwTGUFCTNNe4cnaQ8f11ZI1ptEW
         sjK3Xl8w8MZnwbe8DYGlfMKSeTRawE9cS3mbTWpnFaVFUbXf5dyTZH6Hsj3NOpb6K4Y0
         ujPaqN9RQTLukPbUSNyMuuE/w1WUwq0HzEiHQrk55pUNzuE9WXZZ9JbjqZ8Q5fFx+qPc
         OdnpCyeQtFuc5aV/itay+Da/pshh9dX3oppGlLRJYqmABaAU2r2BdpprdsOAb2v/N2/E
         g/fcqSfIhArZCqiFclRqImRXB6WcLXEwYIiG7yNc5sTWEqRh0M9EMU3FQ5cMIzC4eDS1
         yNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwnEMeWLw09TCnkItjYNGJva0LlRfhtVy7vMXeFwKIxMq3VOOR/Ttgk/xiTsM4OBpYhKAgl9l9uluNn4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjals7iFurUmCKH0fJeZ7ruOMEsyKSpI1iao97gE034B2dRJFe
	oQi7TM5TnUuAg3V0lJhAIyjViQgl16GgaoBdTJ+FhgFmJeblfDHGtsYV5JxVJ9T07/OvTCY7v+W
	zcX1GTOK3eYPhYvZTWlz/eqGRgTc5Sn6QDQ0NGYqnyvz82LkWfdfDSFU=
X-Google-Smtp-Source: AGHT+IFSdZLEVX0XsSeTY+JX4BnJvLpGs7RPfv1RodEHrYWIWyVQQLXTjxkqWD6LhGiDLU0sCvTv6ixUirPUevizRy6LNnoCk66+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180b:b0:39f:60d7:813b with SMTP id
 e9e14a558f8ab-3a365954717mr24003675ab.22.1727866467591; Wed, 02 Oct 2024
 03:54:27 -0700 (PDT)
Date: Wed, 02 Oct 2024 03:54:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fd2663.050a0220.f28ec.0510.GAE@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __btree_node_pinned
From: syzbot <syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b3d507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62086b2fd100a029
dashboard link: https://syzkaller.appspot.com/bug?extid=9f41e4b255897d99d4e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b69e80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1567c6a9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72b7539cbeb1/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73c9b9cebaf4/bzImage-ad46e8f9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/54e2032c8f9d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/btree_cache.c:198:18
shift exponent 227 is too large for 64-bit type 'unsigned long long'
CPU: 0 UID: 0 PID: 5109 Comm: read_btree_node Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 __btree_node_pinned+0x80b/0x850 fs/bcachefs/btree_cache.c:198
 __bch2_btree_node_hash_insert+0xcfd/0x13e0 fs/bcachefs/btree_cache.c:270
 bch2_btree_node_hash_insert fs/bcachefs/btree_cache.c:287 [inline]
 bch2_btree_node_fill+0x94e/0x1200 fs/bcachefs/btree_cache.c:932
 bch2_btree_node_get_noiter+0x9d5/0xf70 fs/bcachefs/btree_cache.c:1238
 found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
 try_read_btree_node fs/bcachefs/btree_node_scan.c:190 [inline]
 read_btree_nodes_worker+0x122c/0x20b0 fs/bcachefs/btree_node_scan.c:239
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 0 UID: 0 PID: 5109 Comm: read_btree_node Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 check_panic_on_warn+0x86/0xb0 kernel/panic.c:243
 ubsan_epilogue lib/ubsan.c:236 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3e7/0x420 lib/ubsan.c:468
 __btree_node_pinned+0x80b/0x850 fs/bcachefs/btree_cache.c:198
 __bch2_btree_node_hash_insert+0xcfd/0x13e0 fs/bcachefs/btree_cache.c:270
 bch2_btree_node_hash_insert fs/bcachefs/btree_cache.c:287 [inline]
 bch2_btree_node_fill+0x94e/0x1200 fs/bcachefs/btree_cache.c:932
 bch2_btree_node_get_noiter+0x9d5/0xf70 fs/bcachefs/btree_cache.c:1238
 found_btree_node_is_readable fs/bcachefs/btree_node_scan.c:85 [inline]
 try_read_btree_node fs/bcachefs/btree_node_scan.c:190 [inline]
 read_btree_nodes_worker+0x122c/0x20b0 fs/bcachefs/btree_node_scan.c:239
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

