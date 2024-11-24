Return-Path: <linux-kernel+bounces-419429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC8D9D6E06
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 12:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70424B21107
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0B4187858;
	Sun, 24 Nov 2024 11:26:19 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87A63B9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732447579; cv=none; b=NfV1MSXtxqkosFhU64UgKPiidG7jrO9GnrvJO32sgTV2hvzg2Kt21RHMgiK/plmnHsoYIf0/0KXul68nsQIGcSsS40DC2aCSa7jDWsZxDzFodeKyFFfeKmsk5gEJU+/+shvcVYJmVYTzQVv4hzbyVywE3hN6r8oNQ1dIPnDfjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732447579; c=relaxed/simple;
	bh=/UUrlz0Nmaf8zBrdqfwtUlxJLh/xjoo4cguqokMISSo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EXO43mZfqS9ae8sBUbmLryH3w8vUNPWtE/nP3EDw1UV9qVWhHdF3GLdAO4wrkvdWEdgohnS0vFU2qNYfKfg1lVTVzWP41r0B5aq7KQONNCHZ1cjHJWGIkh8lro0pvCbbd2GGP8dfzw3rl0RsqOkSPPwVCPGHqXclduHEepVExYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abb901672so425856139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 03:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732447577; x=1733052377;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfaIKxhiHsVdga9s5ErelusNL2T/MKvLviRqHsqXnoA=;
        b=XicvLVwmmVOrDweEYsejBqPGWz/g4uthlPrXoeC8qIWJA+XvdGrqldo6/yVJGvbaMA
         o/DkHh/uV0urAnRZBL+DApayAjK2AXFwR/w33soc2jJeKj8SbPiSnRTMEWIX9LDEDsFM
         3WQ0KCH6k7ql8JlFV6SufK87d5GYBvEAQxyHb9b3itGuZIDxcEQn3iY8cGusxLTq8+KE
         XwJA/Tko7RvwzlOnGa1cSVtEMTS4AgsY3e7gHft4phSwXABUXSVd78c9ulsvkwnkh4Zs
         x2RU3b7v7zPxeqA3O7XbovaQbjh/yVc3pmPXoiyCbWGYuYy80zVL2RrUQ6yuB6qtywIM
         Bd6A==
X-Forwarded-Encrypted: i=1; AJvYcCVaNTMwmgLE0NbJUh3wBD9a+avS9aZiyDt/EAgqgvlMh5wUnUhxJiznXPAhHn+wfbCudKCiRDRxXgi6nGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1Oxk0arl8DoNigmsPpp3B9WD7/Q3d9scGmOKNPlCCXdE0JeK
	SjcwYi7Kyfvmslv/B2d5YXOYjByuFN9wc7zs39cIRoQnFSZTD/ld9Hy40A1HftMjFxgUgbbPvKv
	uAIGfAuJHtry+3euC3C2cuJGcpzYcS0alPoy6M/pxKKAgO77ylCZrjeg=
X-Google-Smtp-Source: AGHT+IFCGbNGDWLMQrx9R5JlKyev+5zXgrjRQyAeZ3jFLwGTTWWNwGWQhZxAzpnp5PhFnYmX0KPXqs1h1wzeah69KsOh3NT0ZkNp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:3a7:87f2:b013 with SMTP id
 e9e14a558f8ab-3a79acfc43cmr94429545ab.4.1732447577126; Sun, 24 Nov 2024
 03:26:17 -0800 (PST)
Date: Sun, 24 Nov 2024 03:26:17 -0800
In-Reply-To: <6739af3b.050a0220.87769.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67430d59.050a0220.1cc393.003c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_btree_node_iter_init
 (2)
From: syzbot <syzbot+62f5ae3a10a9e97accd4@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ba8778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=197de11c5dba9f21
dashboard link: https://syzkaller.appspot.com/bug?extid=62f5ae3a10a9e97accd4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e219c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483d75f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d544df92b8b9/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cfb277b7148a/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9aeb9fe1f9d/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/623571bff0e8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62f5ae3a10a9e97accd4@syzkaller.appspotmail.com

bucket 0:127 gen 0 has wrong data_type: got free, should be sb, fixing
bucket 0:127 gen 0 data type sb has wrong dirty_sectors: got 0, should be 256, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
=====================================================
BUG: KMSAN: uninit-value in bkey_cmp_p_or_unp fs/bcachefs/bset.h:287 [inline]
BUG: KMSAN: uninit-value in bkey_iter_cmp_p_or_unp fs/bcachefs/bset.h:400 [inline]
BUG: KMSAN: uninit-value in bch2_bset_search_linear fs/bcachefs/bset.c:1189 [inline]
BUG: KMSAN: uninit-value in bch2_btree_node_iter_init+0x319a/0x51a0 fs/bcachefs/bset.c:1334
 bkey_cmp_p_or_unp fs/bcachefs/bset.h:287 [inline]
 bkey_iter_cmp_p_or_unp fs/bcachefs/bset.h:400 [inline]
 bch2_bset_search_linear fs/bcachefs/bset.c:1189 [inline]
 bch2_btree_node_iter_init+0x319a/0x51a0 fs/bcachefs/bset.c:1334
 __btree_path_level_init fs/bcachefs/btree_iter.c:615 [inline]
 bch2_btree_path_level_init+0x821/0xc80 fs/bcachefs/btree_iter.c:635
 btree_path_lock_root fs/bcachefs/btree_iter.c:769 [inline]
 bch2_btree_path_traverse_one+0x379d/0x47b0 fs/bcachefs/btree_iter.c:1183
 bch2_btree_path_traverse fs/bcachefs/btree_iter.h:247 [inline]
 flush_new_cached_update+0x296/0xad0 fs/bcachefs/btree_update.c:358
 bch2_trans_update_by_path+0x2493/0x2820 fs/bcachefs/btree_update.c:466
 bch2_trans_update+0xf45/0x2410 fs/bcachefs/btree_update.c:546
 bch2_journal_replay_key+0xe14/0x13f0 fs/bcachefs/recovery.c:232
 bch2_journal_replay+0x2d2e/0x4d30 fs/bcachefs/recovery.c:317
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:191 [inline]
 bch2_run_recovery_passes+0xaf9/0xf80 fs/bcachefs/recovery_passes.c:244
 bch2_fs_recovery+0x447b/0x5b00 fs/bcachefs/recovery.c:861
 bch2_fs_start+0x7b2/0xbd0 fs/bcachefs/super.c:1037
 bch2_fs_get_tree+0x13ea/0x22d0 fs/bcachefs/fs.c:2170
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
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4219
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4236
 __do_kmalloc_node mm/slub.c:4252 [inline]
 __kmalloc_node_noprof+0x9d6/0xf50 mm/slub.c:4270
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:658
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

CPU: 1 UID: 0 PID: 5805 Comm: syz-executor322 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

