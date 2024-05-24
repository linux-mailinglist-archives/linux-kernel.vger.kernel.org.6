Return-Path: <linux-kernel+bounces-188351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0048CE0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC011F21E90
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7457B127E34;
	Fri, 24 May 2024 06:18:29 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17F44C6E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716531509; cv=none; b=RDXWV8xjpBBh39Lpn+WupSqDOwMaH9CMjPSsV0YfOjCyew7CHp3WjJpq3+jJl7PNV6HMORHzWvgHTr4YeN+VQ4s/0uLH+ddbtrkQrJxfSGjkNEdTAqihrnEZNqJPp7+VDLTc5CA/pvPJmJd7W6+eOEciTJQ13ZyXZOUMDRNtbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716531509; c=relaxed/simple;
	bh=1s1BWPfkrWwqcxTCUmiRYigcKpmViP8RKSyWEeyEcwE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FALT/Nqcfufwsqkw1ImKbyVMF36TILppDMrtz2s8z8UzCNEHAmX7malEW05wI9k3utoDKNsSkIK/w9GoZRvz03BN+SGBNzCAkQOISBywANSP8Kyiid0h3Oz9Klgc5HTx0+ZUO0Ze4f4Sequal3sVhO9IAQsLigb4a6Y2JXHs3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-37128f4b7f9so28146355ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716531506; x=1717136306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RrFb12gbkLxmMgRGm2nf1bRqPGN6rOAZGz4/1nNHxI=;
        b=TsN/XIcvs1JW1IWZoEFDT4X/i60J0hJoF08H5ntqqz7OM4qj+0R8PnYrasu2bWf0VG
         56p8E1gAsW50Tr20CFUV5BHmd3vCvLsdLLxzN5w+NW56rV96fDD+st3Bdqu4QR5Ma8WH
         WAtP58RC4CFIaClq0wVyH24jI9lo4MAhYE9v/qgbAc0Hz+rMV1fzaAWuqO/4w9IAsa6K
         E1f80F63O4WlOAuQ4KSrdEDjBoZA7MAP5Qdrn0FQMVCF7nGTrKfFONofFXTIfQejRf9W
         ppa2b11N8rSIQFEN2rt6rt4qw17S+IEbsNHLmy/V38f8DoLvWnWMfMCP+z6z3giB4XKr
         q/ew==
X-Forwarded-Encrypted: i=1; AJvYcCVhQkZWVv0JJnFooXByEO3Rcw7gmqyQR3pu48Bm6P6UqE0RA8kFLGJo07YByVIVsxvHri2UFPE/4BINncRITU+gWe8kniAebrMA+4yu
X-Gm-Message-State: AOJu0Yw5XtfT8wz289LVpnaZoOiHRkbRlKvsYP1Nt3ia359S5/eXNY2M
	ZcRbglhtyRcCulwyzHAlZwY6CsG5ZYmNaDSp3IUIlIDUlYea3n91b7TOuUUFGJh/FJRZ1U3qX6s
	9h6CjMLuyBrsfWiYfo6/WSI22WoKiYa4wWU99bj9CdoR2O8PLjPdYkPI=
X-Google-Smtp-Source: AGHT+IFS+VmAnmtIMK6DHu0QoepSfrJaF8oau+10m8Qn9AqBUrCc0gs7iR7OeIB1KkbiUqkpv9n77Qj+1ICnIwWrK7yRNOd9rzB6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:36c:2981:a85a with SMTP id
 e9e14a558f8ab-3737b2053d1mr1019895ab.0.1716531506757; Thu, 23 May 2024
 23:18:26 -0700 (PDT)
Date: Thu, 23 May 2024 23:18:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4d66d06192d22d4@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_dirent_lookup_trans
From: syzbot <syzbot+b09b7a89937134dc8f93@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12866ab2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=b09b7a89937134dc8f93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b09b7a89937134dc8f93@syzkaller.appspotmail.com

bcachefs (loop4): snapshots_read... done
bcachefs (loop4): journal_replay... done
bcachefs (loop4): resume_logged_ops... done
bcachefs (loop4): going read-write
bcachefs (loop4): done starting filesystem
=====================================================
BUG: KMSAN: uninit-value in dirent_is_visible fs/bcachefs/dirent.c:85 [inline]
BUG: KMSAN: uninit-value in is_visible_key fs/bcachefs/str_hash.h:159 [inline]
BUG: KMSAN: uninit-value in bch2_hash_lookup_in_snapshot fs/bcachefs/str_hash.h:177 [inline]
BUG: KMSAN: uninit-value in bch2_hash_lookup fs/bcachefs/str_hash.h:202 [inline]
BUG: KMSAN: uninit-value in bch2_dirent_lookup_trans+0x652/0xfb0 fs/bcachefs/dirent.c:482
 dirent_is_visible fs/bcachefs/dirent.c:85 [inline]
 is_visible_key fs/bcachefs/str_hash.h:159 [inline]
 bch2_hash_lookup_in_snapshot fs/bcachefs/str_hash.h:177 [inline]
 bch2_hash_lookup fs/bcachefs/str_hash.h:202 [inline]
 bch2_dirent_lookup_trans+0x652/0xfb0 fs/bcachefs/dirent.c:482
 bch2_unlink_trans+0x505/0x2190 fs/bcachefs/fs-common.c:264
 __bch2_unlink+0x3e5/0x9c0 fs/bcachefs/fs.c:529
 bch2_unlink+0x128/0x1d0 fs/bcachefs/fs.c:563
 vfs_rmdir+0x5b1/0x790 fs/namei.c:4214
 do_rmdir+0x630/0x8b0 fs/namei.c:4273
 __do_sys_rmdir fs/namei.c:4292 [inline]
 __se_sys_rmdir fs/namei.c:4290 [inline]
 __x64_sys_rmdir+0x78/0xb0 fs/namei.c:4290
 x64_sys_call+0x3a8e/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:85
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

CPU: 1 PID: 6831 Comm: syz-executor.4 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
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

