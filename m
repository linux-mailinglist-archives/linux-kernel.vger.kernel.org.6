Return-Path: <linux-kernel+bounces-431912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FB9E42B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5B4169F75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B820E011;
	Wed,  4 Dec 2024 17:36:31 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5F20C49E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333790; cv=none; b=Y34jOjT1A4iNW97TU06LZ7a4tODR0zgzggl/fz00Af15RzSgjUJQVD/97NnWqldCvpAt7COQ1anuSWw+7+7CWzacfKlLWHkEuZavEwwlnLR1O+BJmWPTsVa2upE1oeJHk2al3nPSOA8Bfpxy0przmw36gIBf0mvg3SA266aSgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333790; c=relaxed/simple;
	bh=87Uz9v9JJ6DslyjML4gLubclgrwt9ldu3BxIZ6Xcqeo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AWlKr8KwSAhTb7JQ5RqDCwcT5kZ7dTbhFeIZLzGKKTxAWCx4kMvU/Hvcjmh3VJdpO0GQbbBsUJLk8z/cn3TJpxtIKGQaMEAcj/RKGU552RmzghJ/zaKqmHpqz+vYaDAmyg3YYRUJSA+xV4wzRE4r0yFKZGifS9BUVr9OtHsOf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so90405355ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333786; x=1733938586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUkFI9X8SLau/9Fl9DwdCg9i0KX/msOoKXlwZJ+bZ+c=;
        b=upkE+XoJ9Ls2UL7WHCNumx7Kn6ebwd4gWF2d2MpwjrKg1VkRKzL/vveFHt0v/BE1fX
         QAnG/JYW5cRNNqKOKSPf8HxfcbOnz69jTYnGiG9sELaXxIl2+PWoyVGgQsGMfSWCYP36
         sFL0r2RdeRmObuxOIp93WVCbUGKVG8SDlExogjg6cnf2PusWLy7XykitHmqPUG63TTeC
         MJ+TrKYMfC5qZ2/ZnuJgNgq5QClCYMHNq2ASBQnRfIp0RO+s69C7sw+gg+vDxI+hZa8d
         5kS5vFWEF/6vz2ehHEfxfFdvGvjkXLtRmQwdbOGp+dWMo8bXII0K+wP4Eo0ykD8y1yHR
         OdNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn3khO7mxsa4v3K11CTqEordJbrRI8qCycbVllcrqbc++5n+pQzaBHuQeFJlCWvrsBRt+DbdIBmFpLFWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+f3N2nlsx1/Sb5UxbPRjlQKUcvBdQ/InOjmCx0sUoALxgx7xj
	MN4i4UYI0l182xGjpt6BgLxZtt7uxnHM9hhAw8CU1R0CVVo77M6M6Eh5yzu2AJ1tz/iYdc9TYI/
	ZFMFzhcGu1lbzGaOCqpdA4VVgJrO1TRevV5RdRlzckC5MPVVFXEaOhxI=
X-Google-Smtp-Source: AGHT+IHT0cTC2vLXH6ShprqhjeD9fwJaaZ1qbxB25+aO2Pnm0Vd0orVhL3fnrtdkZnU4d/4l3HwLBNTqoiwgNBLw7rYaM6r7PZRF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:3a7:c5b1:a55e with SMTP id
 e9e14a558f8ab-3a7f99be040mr83051885ab.0.1733333786222; Wed, 04 Dec 2024
 09:36:26 -0800 (PST)
Date: Wed, 04 Dec 2024 09:36:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6750931a.050a0220.17bd51.0071.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dev_freespace_init
From: syzbot <syzbot+aa2232cb0e5de0c0b56f@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ba9f676d0a2 Merge tag 'drm-next-2024-11-29' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127f3bc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b131ba4658863ffa
dashboard link: https://syzkaller.appspot.com/bug?extid=aa2232cb0e5de0c0b56f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43bff3f0073a/disk-2ba9f676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0683b9881a99/vmlinux-2ba9f676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37c30742afb0/bzImage-2ba9f676.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa2232cb0e5de0c0b56f@syzkaller.appspotmail.com

bcachefs (loop4): marking superblocks
bcachefs (loop4): initializing freespace
=====================================================
BUG: KMSAN: uninit-value in bch2_alloc_to_v4 fs/bcachefs/alloc_background.h:235 [inline]
BUG: KMSAN: uninit-value in bch2_dev_freespace_init+0x1044/0x1eb0 fs/bcachefs/alloc_background.c:2232
 bch2_alloc_to_v4 fs/bcachefs/alloc_background.h:235 [inline]
 bch2_dev_freespace_init+0x1044/0x1eb0 fs/bcachefs/alloc_background.c:2232
 bch2_fs_freespace_init+0x599/0xb30 fs/bcachefs/alloc_background.c:2304
 bch2_fs_initialize+0x2140/0x35d0 fs/bcachefs/recovery.c:1082
 bch2_fs_start+0x77d/0xbd0 fs/bcachefs/super.c:1038
 bch2_fs_get_tree+0x13ea/0x22d0 fs/bcachefs/fs.c:2170
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:4034
 ia32_sys_call+0x260e/0x4180 arch/x86/include/generated/asm/syscalls_32.h:22
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4238
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_noprof+0xc96/0x1250 mm/slub.c:4289
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:650
 btree_node_data_alloc fs/bcachefs/btree_cache.c:153 [inline]
 __bch2_btree_node_mem_alloc+0x2be/0xa80 fs/bcachefs/btree_cache.c:198
 bch2_fs_btree_cache_init+0x4e4/0xb50 fs/bcachefs/btree_cache.c:653
 bch2_fs_alloc fs/bcachefs/super.c:917 [inline]
 bch2_fs_open+0x4d3a/0x5b40 fs/bcachefs/super.c:2065
 bch2_fs_get_tree+0x983/0x22d0 fs/bcachefs/fs.c:2157
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:4034
 ia32_sys_call+0x260e/0x4180 arch/x86/include/generated/asm/syscalls_32.h:22
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 6020 Comm: syz.4.18 Not tainted 6.12.0-syzkaller-11677-g2ba9f676d0a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

