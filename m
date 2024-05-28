Return-Path: <linux-kernel+bounces-191731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894AD8D1336
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DA51C20F55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E99B199B9;
	Tue, 28 May 2024 04:10:28 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC8179AA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869427; cv=none; b=V4vjmoCQTfmPFcPOgFgWKkVRi76qO0/bYyaxwCTLExWRbYe4wpsk4W845xZ/L+4VmQwTQzqNWG0Rl9pLaTrBnLoFY/Es+79GmB6tBG8hC3qD5GSB2OXKDEbTDo3+hceKSIe6icyxmGsCzgJtd6T+NAsF0oIvl29BXuj+4xE6Ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869427; c=relaxed/simple;
	bh=6BMnFEuWeGChFxSyDZ2OuFR5UZxhXp82Y+Rh+dHsGMw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F6z+4h4mPE9e7fXS1FeYhnSYkhpXg95R8ryWlabOK1ZTJFGSivY2A1bwzT/Ho6QLVmQFbBCb9kk/QQ3K8cLX1rtdM+GAzqsRsMhehJwJX1jibiZ0sCpXUGd4nB5RfYORwX2o9POvO7yei5ddqqHwCH8UHdDUbv7+HIpYQPREHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-37375e83ee8so3791435ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716869425; x=1717474225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rT5Pl0xEGoFaDE9obYD33/VWqvAuRBEYSXPf3W0FSjc=;
        b=TohuVxaAw3Po4mNXgqpIyyb3pFtieym8nOBTRWrMl/q/IkkuX99ZsMPDt1+hQePg4C
         2aRcfjMuKWWk1oYVGKxmvF1aLPGVvpCvRRk05mj3elY1ylCTfhVxgXhPBtWfPal65U5E
         ewpaIbZqbMipAEJAfGU7kbOFjNxlyT5sIjKLTHwplSAKdwq2rIvMJhtsbhsix3ywQSPV
         OgYYucM6fUTvScvZZXT6SLQ/fUC4QhtWx1yUwkVa++BqTRRvvgS2KsbLTesNPLfw7pfS
         J4GNdel7382DRq0Qptc5TqGKuuyGUGZCF+y6Dk3bcEwsONXJe1iLMHsMQQ3pSaz7N4GN
         29rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPNT8XKcDSosdnUJdov3hJAwC2Qk/1+4U3+CTfRTErRX/Hebt5OyCZswjpdzi+VaqsVjyKB9eehwCB53iWEqgpqy3CsHpaADzccT+0
X-Gm-Message-State: AOJu0YwFRgOCHXZn1bkDYYOXTtju+gEpC8wsBXNroPiJWIxK5fO2ISZE
	+YiAUtQFMxB2zbwcrX6dhrH+jAKvpLRNr6gqQQvBJkfDATccE7LgoIA0tj9lVFEVgQoy6XF03Ng
	TPLDaRcZY9q1iVdsTGSZk3X/AQn4tmSbHXMmgHCNHzLNDOg3G5HNE39s=
X-Google-Smtp-Source: AGHT+IFHAJBp+FvS2XWXhjiH8pyko7EJ8ajwhNX85Bdt17F3NcGlR0vnwqUakmjvzjez6+hkWtMra1rD3D0frfcY7MtdAdB3mr+K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c566:0:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-3737b31cb5fmr8147455ab.3.1716869425391; Mon, 27 May 2024
 21:10:25 -0700 (PDT)
Date: Mon, 27 May 2024 21:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039f54b06197bd063@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in xattr_cmp_key
From: syzbot <syzbot+915b205d9237d1182095@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1279b784980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=915b205d9237d1182095
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+915b205d9237d1182095@syzkaller.appspotmail.com

bcachefs (loop1): going read-write
bcachefs (loop1): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in xattr_cmp_key+0x2f3/0x390 fs/bcachefs/xattr.c:49
 xattr_cmp_key+0x2f3/0x390 fs/bcachefs/xattr.c:49
 bch2_hash_lookup_in_snapshot fs/bcachefs/str_hash.h:178 [inline]
 bch2_hash_lookup fs/bcachefs/str_hash.h:202 [inline]
 bch2_acl_chmod+0xaa2/0x1590 fs/bcachefs/acl.c:423
 bch2_setattr_nonsize+0x12ef/0x1830 fs/bcachefs/fs.c:797
 bch2_setattr+0x264/0x2f0 fs/bcachefs/fs.c:886
 notify_change+0x1a07/0x1af0 fs/attr.c:497
 chmod_common+0x3b8/0x630 fs/open.c:650
 do_fchmodat fs/open.c:698 [inline]
 __do_sys_fchmodat fs/open.c:717 [inline]
 __se_sys_fchmodat fs/open.c:714 [inline]
 __x64_sys_fchmodat+0x160/0x2b0 fs/open.c:714
 x64_sys_call+0x1d6f/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3994
 __do_kmalloc_node mm/slub.c:4027 [inline]
 __kmalloc_node+0xb10/0x10c0 mm/slub.c:4046
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 btree_bounce_alloc fs/bcachefs/btree_io.c:118 [inline]
 bch2_btree_node_read_done+0x4e68/0x75e0 fs/bcachefs/btree_io.c:1185
 btree_node_read_work+0x8a5/0x1eb0 fs/bcachefs/btree_io.c:1324
 bch2_btree_node_read+0x3d42/0x4b50
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1748 [inline]
 bch2_btree_root_read+0xa6c/0x13d0 fs/bcachefs/btree_io.c:1772
 read_btree_roots+0x454/0xee0 fs/bcachefs/recovery.c:457
 bch2_fs_recovery+0x7b6a/0x93e0 fs/bcachefs/recovery.c:785
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1043
 bch2_fs_open+0x152a/0x15f0 fs/bcachefs/super.c:2105
 bch2_mount+0x90d/0x1d90 fs/bcachefs/fs.c:1906
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1779
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 x64_sys_call+0x2bf4/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 7935 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

