Return-Path: <linux-kernel+bounces-444375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578059F05D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AAF28407C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106C19CC37;
	Fri, 13 Dec 2024 07:56:27 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA7192D9D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734076586; cv=none; b=AgBMRle3qLQ69yW7tB4sEuZaFxj8aDjv6meaNlAPVlrhvV4nqV7qGpIN+rWRbuxTtYDrU9q1hdIrL5xYIShnS2QapEiIw+vyLFydMv85s3d+N2x4NrCJ7Xig69MY9UKCWlY97gWK1NJM9ddpw/P0pONycibMxxLv2kZPu4AfCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734076586; c=relaxed/simple;
	bh=E+sHP6cSBjnIAGuA17qrCNHgFikP8U5MKiapM3lr9Po=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EFHAk8y/exktOKxYUr/DSNSt05ibn7auVOcQrui1mwNEzVcSgPvhUHkb3IP/qnxjI2tMC5eBpKXD+WSt9OG6AOEtfZ30QIhDAuhfCKUJ9a2f9ztR8r5U3yHdA4bPLpc7mg9xV1zRLzNHYun5OeMSWfUTKVtYH829JGBkP9lUCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso30698145ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734076584; x=1734681384;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WERhNotYR0HfaMQlhrkbWxX2S8zTbW3DR3gglDEKvXc=;
        b=gNwPC+di1PlIF/piYHevFavQHedav22rVk7hiW/nHzoBDgFxpGwnNxcpmUPQNACKmQ
         n0MXX+t6PfDiGhcIncjTN4WkQ6lDDF/ykHp/hy7e3PRbR1K37Ef+Rnt9swETYTFH0BJb
         lOT3f0U+J2Se70aZDX3gKb/AwkQDirz3WZLHJcF2bLPJg8nkFC0i4vvAvIBd3hOHozl3
         D8Hpug+05MnDc5C4D0c7v4pKegyzKfYHR5fPekuDkK68ZgYIOSW3sAycYRFYuS6Q0s8v
         I92myMwjdVh/iAyighL4/McGYrz3ZvAu5TohwX7ZPXlc1yhmx0cuygQCjkJPBJurGeY1
         CaLA==
X-Forwarded-Encrypted: i=1; AJvYcCUnUP6Fd0AmAxGV0curRI9pU5OiwI+hWlpXD6PdL+KeHYPsJ/fsYqFzBF4iuOJqH09X+UyGMs/hV5u4d7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZN0ZXYsOmPwpc6YTjCb4cqsKtihHp3mS7lWOJx/fuxomQNKw
	m1L05SB0Dqk/1V6Q+0eRlkV2O5dYyEc/aT5R610AKfVTYfPQyUjwwIPfVvdTLRsK+NBaPQ4ZNeE
	UNxuIX6NO1DhjW3Q3Zk9R/z5xfDLOgJAcg3TboL4HzLCemteR3QdvcCQ=
X-Google-Smtp-Source: AGHT+IGHkpOCzFWbpk0wh9XSWnkTwjwP6tl39Pitf2LRZhT+WxscEjEE/BII12vSwiweIqTfKGEPqESCYlXq1zPp6GuLC5CZf13I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3aff4613b80mr23007845ab.1.1734076584028; Thu, 12 Dec 2024
 23:56:24 -0800 (PST)
Date: Thu, 12 Dec 2024 23:56:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675be8a8.050a0220.1a2d0d.0003.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_xattr_validate
From: syzbot <syzbot+983249082bd062b1c4ef@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62b5a46999c7 Merge tag '6.13-rc1-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a42b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcc2c6db74766fbc
dashboard link: https://syzkaller.appspot.com/bug?extid=983249082bd062b1c4ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60049925b49e/disk-62b5a469.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4566aa70779/vmlinux-62b5a469.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ba7b00a199e/bzImage-62b5a469.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+983249082bd062b1c4ef@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_xattr_validate+0x3bb/0x720 fs/bcachefs/xattr.c:81
 bch2_xattr_validate+0x3bb/0x720 fs/bcachefs/xattr.c:81
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
 bch2_sort_keys_keep_unwritten_whiteouts+0x12d5/0x19d0 fs/bcachefs/bkey_sort.c:187
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
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4238
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_noprof+0xc96/0x1250 mm/slub.c:4289
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:650
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

CPU: 0 UID: 0 PID: 6046 Comm: bch-reclaim/loo Not tainted 6.13.0-rc1-syzkaller-00378-g62b5a46999c7 #0
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

