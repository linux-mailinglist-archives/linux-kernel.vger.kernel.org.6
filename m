Return-Path: <linux-kernel+bounces-403413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DADA9C355F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94F71F21CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0979CD;
	Mon, 11 Nov 2024 00:28:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615DA29
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731284907; cv=none; b=B4AiZGxDVg0f3H9q+ZZzCoQEsw0As/ghMCiS2azX8frLLBZiTUrELS1Y4v0F8P0Dnp+erPjgfZwHDrfI6ViWgbzSPADtZ0H9jD6C9ko0bDeDR7Xp+RBjXek91gWyxBdAb7A2aJcCMevS+zPQSli2HP11kNQQK3a4qfn6pwqcIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731284907; c=relaxed/simple;
	bh=AtNX+PT3C/pdFDLVft8iEMdcEog8EYRw1rhTOm7Qq8o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OhM6dkbfLLtjibCA6rqWVFg7vByzLRCSRvbxe2ZFqG9Hm5CvbXgR/heMmjBT+lQ5Qlo7xMfkQ5ox+fYQdaRdRoiwAeXU51R3RxlAf/EVvU8u9BH0DyfmRkwaNztR+jamrwKJ0jyiFpLy+Nwb0yZCEixn/nDt0jwCbSqDfCF65pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6c427e1b0so49249635ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731284905; x=1731889705;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+sOcLHXW7oInXtyr92cpfXx3BsIK+2FEd/aTqcx/18=;
        b=U/HnRj6ek3obDonU7mE/UmEbH6+i5rGhrSpX9AC+VGylbY4xHasIND/6M3tw7aKoRK
         nvUK5/YEnogHvv6X/wUGWMFkO/fJiYExmIvPuSzfJlulTnyLZMgx2BaJ9HK6BQTEoy8W
         +S5msqzZoLA8TuopgmlVjqJxSrYe+PsS/pqN59Ft1We2zsrjedouXyY3SpfEliy16nfr
         euYms49HvVuYDq+qUbBZYiPblKDVkLmUhLMhYn36bPLkXpG5c/L3kbWoN0pl5kOL/Zi7
         Nvp5ynxKKxTcj+7puCSfPlHfoRUj0kF9T2liIJ9dEqgGZSrtzj5/OXdYYK3R+ocerS00
         Pqiw==
X-Forwarded-Encrypted: i=1; AJvYcCUwz+CJlTSgRknwix4zRqJC20vgQuT0INRMvJebUcNjd6TA+dNJiqoU90gXfai7pvV6EXkXlS7MIW3/9qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzEghoZlxtiPlJyWh+Sqr8R6Cr7wUFlUGkNVoAE5NiB1JI5+V
	5u+yhJid/x4TKR80jwxh4J7jdmt40X9t5NOYlT9BxRTBD8b6dBQyrRFx4NUwqlUaH3ysW78StDT
	NdbJ5AY4UjhDwuDtsSvOcBIDDCr3kRstYvIp1l8UCNbnpTWfYzPW8sew=
X-Google-Smtp-Source: AGHT+IHWZauRWWUQFOfns0ik8UhM7aT+2BQMB+2Rhj1pynJ0FwdgNaPTbpR6vDAzf1nrN2P1CXixPGo7SMpms1jBUW2/8P7Gkd13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:3a6:be9a:2144 with SMTP id
 e9e14a558f8ab-3a6f254c63dmr101892155ab.11.1731284904834; Sun, 10 Nov 2024
 16:28:24 -0800 (PST)
Date: Sun, 10 Nov 2024 16:28:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67314fa8.050a0220.138bd5.0057.GAE@google.com>
Subject: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_btree_node_check_topology
From: syzbot <syzbot+494bcd3631a9f6759f91@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7758b206117d Merge tag 'tracefs-v6.12-rc6' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e72e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=494bcd3631a9f6759f91
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a0df40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e1f6a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cff7adedd889/disk-7758b206.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c3babec78429/vmlinux-7758b206.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9de747183951/bzImage-7758b206.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c2654a9124db/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+494bcd3631a9f6759f91@syzkaller.appspotmail.com

BUG: KMSAN: uninit-value in bch2_btree_node_check_topology+0x12cc/0x2e40 fs/bcachefs/btree_update_interior.c:96
 bch2_btree_node_check_topology+0x12cc/0x2e40 fs/bcachefs/btree_update_interior.c:96
 btree_split_insert_keys+0x4fd/0x630 fs/bcachefs/btree_update_interior.c:1573
 btree_split+0xdc4/0x98e0 fs/bcachefs/btree_update_interior.c:1664
 bch2_btree_insert_node+0xaba/0x2810 fs/bcachefs/btree_update_interior.c:1837
 bch2_btree_node_rewrite+0x10f8/0x1930 fs/bcachefs/btree_update_interior.c:2164
 async_btree_node_rewrite_trans fs/bcachefs/btree_update_interior.c:2230 [inline]
 async_btree_node_rewrite_work+0x485/0x1710 fs/bcachefs/btree_update_interior.c:2243
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4219
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4236
 __do_kmalloc_node mm/slub.c:4252 [inline]
 __kmalloc_node_noprof+0x9d6/0xf50 mm/slub.c:4270
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:658
 btree_node_data_alloc fs/bcachefs/btree_cache.c:125 [inline]
 bch2_btree_node_mem_alloc+0xa68/0x2e30 fs/bcachefs/btree_cache.c:807
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:325 [inline]
 bch2_btree_reserve_get+0x37f/0x2290 fs/bcachefs/btree_update_interior.c:554
 bch2_btree_update_start+0x1af9/0x2d60 fs/bcachefs/btree_update_interior.c:1252
 bch2_btree_node_rewrite+0x1da/0x1930 fs/bcachefs/btree_update_interior.c:2142
 async_btree_node_rewrite_trans fs/bcachefs/btree_update_interior.c:2230 [inline]
 async_btree_node_rewrite_work+0x485/0x1710 fs/bcachefs/btree_update_interior.c:2243
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 0 UID: 0 PID: 3761 Comm: kworker/u8:13 Not tainted 6.12.0-rc6-syzkaller-00099-g7758b206117d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btree_node_rewrite async_btree_node_rewrite_work
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

