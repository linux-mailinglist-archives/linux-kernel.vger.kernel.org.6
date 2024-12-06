Return-Path: <linux-kernel+bounces-434584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A89E68A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A91161AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693D1DF260;
	Fri,  6 Dec 2024 08:18:41 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1163D6B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473121; cv=none; b=q7otf94qYupZAO/8PWX+mE0iENP/u9aXDTrI3+IryMa63rCUcKhxm9kX9IJsG1UTrQHfm1xLqZbenn/dlwFeVUbsCbpme+gIgdz6XivEqoJ/qavuZ4pWOpItHctMd7WVFyq/0spHsfFjJT6vGcRnRajsHNJDP8ecA3HnixxEl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473121; c=relaxed/simple;
	bh=Gds3uh3VcCK7/jmuMhhoAuWfuydjpJ/S4YxeiosA2zw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IakYuWnmUSJGpJGDT/hZ5pmeMZ5vvHNp+sBXS+cIaKDrW9ohNTU2ZOJjyAP/lghMsCAI3aAGbH812t4uE8AjgMnZ/i/qKE89O0Vt2933FPELxCU3DPYE6n0efanRALGyFhD2bdrUWo4nxXWiqQGKLlOo74Uyz5ZB4Lq9d7dkjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7807feadfso15540045ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733473118; x=1734077918;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BPYFjgJWdxHj0q2rbOZfjpb8PyiVHmn8fvASAZzBwY=;
        b=CNbx6e9aYqLvOj45RU5Hyza06JHBW3xPzRLeXB/bCfJjWAlXqlLtMwHLAG+8KpuYf2
         ruVFCpTYzpOdAziUXQZMz9CfhpNKWYWW6DDfMoGAl/qAPxPvLakVuwopHFjCwO2BmEkw
         ex5p/qtpJvTqoUh/NVT7+lkSsflTtXGVeMduBkE2GT3b+pFO9PMV7tDcjWDp35yxMyoF
         o56+4AhlXJzzKVpzO9bezYBpPsrs9uiuBsJvjWTV+Dmq4JXQj6+qU+Pr5/bFSLA3DvvV
         0fLPj3uk+fyecGZ+AJ/UjfUOVhFZFh7mzL+w2oD3WQrYXz0I87Vv0K4CVXmwlSXffAiQ
         s4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1JYXflF6Tax0i2Kod6bsyZ+YgnRso9mpJP+1uuEYBSG5p52rGyn3GFdIS0ytxj4KupdVlK8S+64XB6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMosQarVZem8zTcGV+CgXLcw7o58LvQ52cFMufph/PMerkJFo
	N+k7mRmFLd4PA7adsMKNMpWkUiIJfJSqVUhP4z/1t5sZ/DeBXAK+uRv+9RoYakjiZWPhP6NvAHO
	l+t2As2HM6kbUUXGW/lO4B61bl1vC4oOiP3kj23cB5SMOhB5MfNZ3l7I=
X-Google-Smtp-Source: AGHT+IGZvmvCg/DTH7ww82Lxd6Mlo+wWuNJ47bVO0Os38JiJIcCt6iySK8LC39OiCERpbqqWRvWJexeRQEZ1qtBGgSnB1db4mTRI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:3a7:1dcb:d44b with SMTP id
 e9e14a558f8ab-3a811db73d7mr21146075ab.11.1733473118032; Fri, 06 Dec 2024
 00:18:38 -0800 (PST)
Date: Fri, 06 Dec 2024 00:18:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6752b35e.050a0220.171b20.00d0.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in rw_aux_tree_insert_entry
From: syzbot <syzbot+79f640f4f94cdd55a406@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130d90f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96ee18b6611821ab
dashboard link: https://syzkaller.appspot.com/bug?extid=79f640f4f94cdd55a406
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b31883c9ce49/disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd0fe66ddb61/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88e3455fb342/bzImage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79f640f4f94cdd55a406@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in rw_aux_tree_insert_entry+0x557/0x970 fs/bcachefs/bset.c:904
 rw_aux_tree_insert_entry+0x557/0x970 fs/bcachefs/bset.c:904
 bch2_bset_fix_lookup_table+0xecc/0x13e0
 bch2_bset_insert+0x1621/0x19f0 fs/bcachefs/bset.c:1015
 bch2_btree_bset_insert_key+0xf4e/0x2b60 fs/bcachefs/btree_trans_commit.c:217
 bch2_btree_insert_key_leaf+0x276/0x1050 fs/bcachefs/btree_trans_commit.c:300
 wb_flush_one fs/bcachefs/btree_write_buffer.c:186 [inline]
 bch2_btree_write_buffer_flush_locked+0x47c1/0x7090 fs/bcachefs/btree_write_buffer.c:379
 btree_write_buffer_flush_seq+0x2ec7/0x30b0 fs/bcachefs/btree_write_buffer.c:517
 bch2_btree_write_buffer_flush_going_ro+0x1a7/0x2d0 fs/bcachefs/btree_write_buffer.c:556
 __bch2_fs_read_only+0x1c6/0xb40 fs/bcachefs/super.c:275
 bch2_fs_read_only+0xd2c/0x15d0 fs/bcachefs/super.c:356
 __bch2_fs_stop+0xf0/0xf10 fs/bcachefs/super.c:621
 bch2_fs_stop+0x1e/0x30 fs/bcachefs/super.c:678
 bch2_fs_get_tree+0x1dff/0x22d0 fs/bcachefs/fs.c:2265
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3507
 path_mount+0x742/0x1f10 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x722/0x810 fs/namespace.c:4034
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

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
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4034
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 10623 Comm: syz.6.1178 Tainted: G        W          6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Tainted: [W]=WARN
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

