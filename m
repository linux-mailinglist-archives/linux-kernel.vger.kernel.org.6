Return-Path: <linux-kernel+bounces-413943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC99D20CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2989281CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7A14A619;
	Tue, 19 Nov 2024 07:33:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384313B2B6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001602; cv=none; b=B/wMsQmPTfodDszeIYXihD+3at3pmu+4eY9CgIsFemvhKF1qCJgziELupd/Ok7Jw7g3MPbApOyM9JG9/C58l8OOitaeP4XeIg7LIn1grNmQseeMwIgQeMKWRB5gXJ9N6RqWVFqIPMg0H3l8M+jGCCToVW9wLiXoJ3k7JEW/aCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001602; c=relaxed/simple;
	bh=LI4CZCv7LZHHPjSVgpwDKu+9QX0d8S2Pn3MI9nS59Kw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i/YUCyJvGD3dwilNwJJq/quYaFrrsnfrRS6eZPyvQJFv4/WG85dqAgIOABhAhjTuNyvPfbCzSqXMQQwr5wT75kbhXwFd1QqeEVBIVJJ3bysxXo6iiw0cCFO0A/eaLG8CQEqPgBTRO5Zb/5IW6V0DnZiagoMkMPx7sXHZinwYlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a777d47a8eso8030525ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732001600; x=1732606400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qe4C8L8siLuAPI4TU9XpGu4NrjhFVwZTk1y4mvK5/fQ=;
        b=IhlMad77tWeh1NagKx4fnUEobChDqjZNM6J5Ivv4pnPuaqlrsL9e9Bh5bHSQ9EU7iE
         J2B+dPeCLg8rg8+8kb21yGr9+qsWK7gcj53+6oeuHtuw/GqLJtckVSZ1nySb871JaByr
         kO3DFWXyHbRLActtPirvmNYM1nuN3HZT1ZLqAWxmKhQPlP2q5VqfAZgJ2c79PC8b5CmM
         HRGMAv7VpEJyq+o+noISc7ImLcL3lNjxWI2FLSCaAytKFl6aAGNd0JVRXgKD9ww3EFLw
         m/Id6nnzdInLM0mapSqPokF1jpdHnQ0EfGOwMqtvffPy7irTVNK922F9KVeZt4wJmXIM
         PCBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+5mycD1p0nKdqIvxjJ034nGYKpZ+vUDt0uIJlac5WWconx2ND/xEAHD8I8sfR7w+SA7Kk6yagz81J/6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60CAtkLiVCtxikEmSVLyZt9nOaGwf+M7zTZYq2H7CusJZpgoW
	Jnt1kmwvhoxoJosp/O3gmDErx7UC4YVPq5bC5DxrUO4FxW4qnglH9G019eNvs/NWPJrE9YbbNga
	0uChb4lQh8+b7SK47muAmr2cZ+8p0J5epzGGV+S4+4fkfuRkWMehN0HM=
X-Google-Smtp-Source: AGHT+IGXnw8N5jCl/uCuVHALFev25whTCDAiTjRXWmC7gFFlTsrVaB7zivkFesUUCXGkfuqg7vMCgpeXZzAGG+3fR+RGHxE1il3e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219a:b0:3a7:6ee9:2b0d with SMTP id
 e9e14a558f8ab-3a76ee92de4mr57739005ab.23.1732001600418; Mon, 18 Nov 2024
 23:33:20 -0800 (PST)
Date: Mon, 18 Nov 2024 23:33:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673c3f40.050a0220.87769.006a.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_v3_validate
From: syzbot <syzbot+3cd97352d16f0e6066d9@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11eb6b5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=3cd97352d16f0e6066d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1469b1a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110bdcc0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c694b6090aa/disk-cfaaa7d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/981b31e0fb3c/vmlinux-cfaaa7d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a4df6af9c5c6/bzImage-cfaaa7d0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f8181b3bb66a/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3cd97352d16f0e6066d9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_inode_v3_validate+0x481/0x5a0 fs/bcachefs/inode.c:508
 bch2_inode_v3_validate+0x481/0x5a0 fs/bcachefs/inode.c:508
 bch2_bkey_val_validate+0x2b5/0x440 fs/bcachefs/bkey_methods.c:143
 bset_key_validate fs/bcachefs/btree_io.c:841 [inline]
 validate_bset_keys+0x1531/0x2080 fs/bcachefs/btree_io.c:910
 validate_bset_for_write+0x142/0x290 fs/bcachefs/btree_io.c:1942
 __bch2_btree_node_write+0x53df/0x6830 fs/bcachefs/btree_io.c:2152
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2284
 btree_node_write_if_need fs/bcachefs/btree_io.h:151 [inline]
 __btree_node_flush+0x606/0x680 fs/bcachefs/btree_trans_commit.c:252
 bch2_btree_node_flush1+0x38/0x60 fs/bcachefs/btree_trans_commit.c:266
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:565
 __bch2_journal_reclaim+0xda8/0x1670 fs/bcachefs/journal_reclaim.c:698
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:740
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:393 [inline]
 bkey_p_copy fs/bcachefs/bkey.h:47 [inline]
 bch2_sort_keys_keep_unwritten_whiteouts+0x1797/0x19d0 fs/bcachefs/bkey_sort.c:187
 __bch2_btree_node_write+0x3ae8/0x6830 fs/bcachefs/btree_io.c:2095
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2284
 btree_node_write_if_need fs/bcachefs/btree_io.h:151 [inline]
 __btree_node_flush+0x606/0x680 fs/bcachefs/btree_trans_commit.c:252
 bch2_btree_node_flush1+0x38/0x60 fs/bcachefs/btree_trans_commit.c:266
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:565
 __bch2_journal_reclaim+0xda8/0x1670 fs/bcachefs/journal_reclaim.c:698
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:740
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4219
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4236
 __do_kmalloc_node mm/slub.c:4252 [inline]
 __kmalloc_node_noprof+0x9d6/0xf50 mm/slub.c:4270
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:658
 btree_bounce_alloc fs/bcachefs/btree_io.c:124 [inline]
 btree_node_sort+0x78a/0x1d30 fs/bcachefs/btree_io.c:323
 bch2_btree_post_write_cleanup+0x1b0/0xf20 fs/bcachefs/btree_io.c:2248
 bch2_btree_node_write+0x21c/0x2e0 fs/bcachefs/btree_io.c:2289
 btree_node_write_if_need fs/bcachefs/btree_io.h:151 [inline]
 __btree_node_flush+0x606/0x680 fs/bcachefs/btree_trans_commit.c:252
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:261
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:565
 __bch2_journal_reclaim+0xda8/0x1670 fs/bcachefs/journal_reclaim.c:698
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:740
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 0 UID: 0 PID: 5854 Comm: bch-reclaim/loo Not tainted 6.12.0-rc7-syzkaller-00125-gcfaaa7d010d1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================


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

