Return-Path: <linux-kernel+bounces-214069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E44907F01
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7648B228E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DD152E17;
	Thu, 13 Jun 2024 22:36:24 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668314D71E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318183; cv=none; b=HKKBzaO6tmYw734qm0QglLYILC+jbpSgZAJocTPwFi6lKQ0H4VQBBeXCYJzy1D9+UL8sBfybS0v54000aprCGzDu/ZtsGWTDd0TFmYt73UNBf1ZeptoSYLaaLqGIKWJDOwzx8T909x+2oXEq1xwO0+T0ZSmVk8sE9aaKYZ1tloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318183; c=relaxed/simple;
	bh=1rlJhm8XfFDlYNPef49r0Lsc1GGemY7mwX/gErlTvOo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bnzs/tH/GZxaWRNfyg37CK+x3YkLagzZ1W/27+R8jP4xrMLyL7myqzEvz+d//Nhg7LMOBuN1rHeRhw206xf6BhOuJea1cc6g5437MQfFQlo+u/5V2kdx+xU6MPYE1nfK3F7tUzonb20ER5HoRccIPHjIkCPmX00XGTpZCkn1Crg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ead7796052so155182339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718318181; x=1718922981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmL9EmDzoT/FffVUylekvSkt/eWgMXCYQLzogDs895U=;
        b=Rb2RAkhyvbtncp6OzjkBJFx6UDfQDNenZJpL8StuMri0uGWsz0AHkqVWwUw7ynUOXh
         3v50N0Bbap0BM3lw+Da5aU0a+JOPiWgW87H/N5Zqjo/yQgVcsLG87mL+e8ZFt5yw52GP
         aW+fq02VpgZDjmLkDGW9Q85jS9GDowixfBNOuT7tMK4BqZ6a573Hk18NipuYWpBPWa1x
         6YbnH771+zELm/YPlqvUNxABCDdJTo86nz2p2bsxiAXi0eEideIG23mgV4nWnmUMXZHl
         92mTdgejD2kB9ffiLR6s+R3Q+4tYbQkSfqBETxhaetpmI72ITB/vHkU16WF5/AMTfSCk
         L8cA==
X-Forwarded-Encrypted: i=1; AJvYcCUsCxCNb91vFX2tQ+bJT/E/iwGScImOXnEO03YBFSFVsOvkyoC+m1w0H4xhJ+fu2qZ/zgcmY1gFqJCzhpsKG2yjCihnyhCwns38Ppo6
X-Gm-Message-State: AOJu0YzyecxRKeiTYkiUdz8vIKmc4tXZmoeAG1MHkjwobxeuJJCR9y6s
	62sY/yMd3unAltF0nqiSi0Mcs4APRegN97EiMlkzJoWkWM9HBWik2NnAs6M/Bi5+PnNwuvJPL5A
	ctK0Uhpaw2DjtFPP5UV8CNsWkVRbfCIGnmcWv5Q0sB6QeCRfIX4zszSU=
X-Google-Smtp-Source: AGHT+IHfESRyiwMRF4uYQP4p5ws2hfeFBL9HOcZt/yP3wNAAv4sXhZfWAI9tRf3/xIhXCFNTnSe+fb+FVyk1UbtNZmkMMrotSWxk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c88:b0:7eb:7cf2:adb0 with SMTP id
 ca18e2360f4ac-7ebeb65adb5mr1537039f.4.1718318181421; Thu, 13 Jun 2024
 15:36:21 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:36:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0a6c8061acd2012@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bkey_val_invalid
From: syzbot <syzbot+6583a960ba94699a7da6@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108853ce980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=6583a960ba94699a7da6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6583a960ba94699a7da6@syzkaller.appspotmail.com

bcachefs (loop1): shutting down
bcachefs (loop1): going read-only
bcachefs (loop1): finished waiting for writes to stop
bcachefs (loop1): flushing journal and stopping allocators, journal seq 12
=====================================================
BUG: KMSAN: uninit-value in bch2_backpointer_invalid+0x59d/0x630 fs/bcachefs/backpointers.c:56
 bch2_backpointer_invalid+0x59d/0x630 fs/bcachefs/backpointers.c:56
 bch2_bkey_val_invalid+0x24f/0x380 fs/bcachefs/bkey_methods.c:140
 bset_key_invalid fs/bcachefs/btree_io.c:831 [inline]
 validate_bset_keys+0x12d8/0x25d0 fs/bcachefs/btree_io.c:904
 validate_bset_for_write+0x1dd/0x340 fs/bcachefs/btree_io.c:1945
 __bch2_btree_node_write+0x4777/0x67c0 fs/bcachefs/btree_io.c:2138
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x4d0/0x640 fs/bcachefs/btree_trans_commit.c:229
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:238
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:553
 journal_flush_done+0x156/0x3f0 fs/bcachefs/journal_reclaim.c:809
 bch2_journal_flush_pins+0x1a1/0x3b0 fs/bcachefs/journal_reclaim.c:839
 bch2_journal_flush_all_pins fs/bcachefs/journal_reclaim.h:76 [inline]
 __bch2_fs_read_only+0x1b9/0x750 fs/bcachefs/super.c:277
 bch2_fs_read_only+0xcb4/0x1540 fs/bcachefs/super.c:357
 __bch2_fs_stop+0x112/0x6f0 fs/bcachefs/super.c:622
 bch2_put_super+0x3c/0x50 fs/bcachefs/fs.c:1791
 generic_shutdown_super+0x194/0x4c0 fs/super.c:641
 bch2_kill_sb+0x3d/0x70 fs/bcachefs/fs.c:2015
 deactivate_locked_super+0xe0/0x3f0 fs/super.c:472
 deactivate_super+0x14f/0x160 fs/super.c:505
 cleanup_mnt+0x6c6/0x730 fs/namespace.c:1267
 __cleanup_mnt+0x22/0x30 fs/namespace.c:1274
 task_work_run+0x268/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:511 [inline]
 bkey_p_copy fs/bcachefs/bkey.h:46 [inline]
 bch2_sort_keys+0x1b4d/0x2cb0 fs/bcachefs/bkey_sort.c:194
 __bch2_btree_node_write+0x3acd/0x67c0 fs/bcachefs/btree_io.c:2100
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x4d0/0x640 fs/bcachefs/btree_trans_commit.c:229
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:238
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:553
 journal_flush_done+0x156/0x3f0 fs/bcachefs/journal_reclaim.c:809
 bch2_journal_flush_pins+0x1a1/0x3b0 fs/bcachefs/journal_reclaim.c:839
 bch2_journal_flush_all_pins fs/bcachefs/journal_reclaim.h:76 [inline]
 __bch2_fs_read_only+0x1b9/0x750 fs/bcachefs/super.c:277
 bch2_fs_read_only+0xcb4/0x1540 fs/bcachefs/super.c:357
 __bch2_fs_stop+0x112/0x6f0 fs/bcachefs/super.c:622
 bch2_put_super+0x3c/0x50 fs/bcachefs/fs.c:1791
 generic_shutdown_super+0x194/0x4c0 fs/super.c:641
 bch2_kill_sb+0x3d/0x70 fs/bcachefs/fs.c:2015
 deactivate_locked_super+0xe0/0x3f0 fs/super.c:472
 deactivate_super+0x14f/0x160 fs/super.c:505
 cleanup_mnt+0x6c6/0x730 fs/namespace.c:1267
 __cleanup_mnt+0x22/0x30 fs/namespace.c:1274
 task_work_run+0x268/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
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

CPU: 1 PID: 5068 Comm: syz-executor.1 Tainted: G        W          6.9.0-syzkaller-02707-g614da38e2f7a #0
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

