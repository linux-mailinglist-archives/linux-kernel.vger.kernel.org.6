Return-Path: <linux-kernel+bounces-421773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1CC9D9006
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FD1B2646F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F001171C;
	Tue, 26 Nov 2024 01:38:35 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562ED2FF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585114; cv=none; b=LjmNrxmw8729xsQoy0twlwWmoVC+F0HqpEIdYSyq0yfNYOqM/43RUGtLibndS4Ebb8DDQ7R/BvnyquTcRyZL4J5j7ICM1ZhyvF2tshF2AsOq5r9yxCJnLFfP5B9WmXBGsWOPRmLAdFUwTezdU+6atvqUyOR8ncfAs+xtjtiGyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585114; c=relaxed/simple;
	bh=gSsHLbX/xNRwyXFYmNEsWG1huu5G/yNkh92Z06JWT+s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gnQVl/3yMe4yZv/pnHn2kWG2qxlCaf/IwGNUcw7UogKxOaaRj9YuvgypTfIXqdUd49XgN4h/UKnH82nKe9SyZ435qjfEx6MTKB5LaDautMb5IEHJLl4LGOJ9K0dIDf1au5PfxaSpq/PXWNy8115XjHQLwbHQ0+EDXLMsRolwqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79088e7abso51749505ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585112; x=1733189912;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5t5qc153aYIy6iHNGMQOJ4dtj5pzbfdZipNeNrxgWY=;
        b=CH/5Pe19IeaX9MYBP6ZpP7ztBDK+uvM4dNbWcjMJbLa/lnVYiPzvbV2dvl39IJEYfY
         jnsQyum6/Nccy2MKHBJs6inabNdm9BmYyAU5lScyWwlKlvQrF3GPMKvD+WCy24U8FAHW
         FX7SytPGhQ8S71bNRKRB8AbzFAjg5e2hRqfTThypunrkvGiIzItZ16nIdMqrpp/KpkVA
         /LXQBR9xzucsBfGn1/0EyQTK3apDO52FF0iofuyikptfVgnq0FRcxqo1cJTlvns8wzCt
         JsNV0wyDxOOJ8Ttru+IEJcv2OEc0Oes+ViR5gZeG9a2vfyBWl64FMZyDO4UILfqW3tqR
         Kg2g==
X-Forwarded-Encrypted: i=1; AJvYcCVzSX/KmQXbGw+oeju5ej+r+hNWkUnl9RZFVWtvPcgpXnpuObo1xZfAXGPP6QPUtUzX6tGhNveNKCN9BkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6EtXdnxTC+ChqpfdDU0EF3wby1ELSnS+TOHU1yARCFS2KPH2
	epy4rPED1d50lBH06FAsFvYA0q1VEv59ecdS/V3nQMb3EowAhJNavWDSeZNld9dxYFBe7mYumHA
	8yd/IpPaogMbNl/TUlWj2C3oa90dNCkGZx4ScoTIuVxOvjamHCibSk8E=
X-Google-Smtp-Source: AGHT+IFvgGw8pfgm5EuLsokR+3XWArr6hO3UYLIjaBnu2/35s3NrlYfIR6xjAxkPYoI/AJb6gKMh8D3Upw7mgeAen6Ms7Gi5FJp3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2186:b0:3a6:cac0:1299 with SMTP id
 e9e14a558f8ab-3a79ae65220mr156675425ab.14.1732585112285; Mon, 25 Nov 2024
 17:38:32 -0800 (PST)
Date: Mon, 25 Nov 2024 17:38:32 -0800
In-Reply-To: <672b7604.050a0220.350062.0255.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67452698.050a0220.1286eb.000c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bucket_alloc_early
From: syzbot <syzbot+07d7911319bd613ba885@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13600f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce1e2eda2213557
dashboard link: https://syzkaller.appspot.com/bug?extid=07d7911319bd613ba885
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148215c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17600f5f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2fcdec73c0f3/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d4dc8d1847e1/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db0e04822d2c/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e5d1dbb2ef68/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07d7911319bd613ba885@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_alloc_to_v4 fs/bcachefs/alloc_background.h:235 [inline]
BUG: KMSAN: uninit-value in bch2_bucket_alloc_early+0x11c0/0x2520 fs/bcachefs/alloc_foreground.c:439
 bch2_alloc_to_v4 fs/bcachefs/alloc_background.h:235 [inline]
 bch2_bucket_alloc_early+0x11c0/0x2520 fs/bcachefs/alloc_foreground.c:439
 bch2_bucket_alloc_trans+0x8e6/0x3fb0 fs/bcachefs/alloc_foreground.c:649
 bch2_bucket_alloc_set_trans+0x959/0x1650 fs/bcachefs/alloc_foreground.c:808
 __open_bucket_add_buckets+0x1dec/0x3070 fs/bcachefs/alloc_foreground.c:1057
 open_bucket_add_buckets+0x328/0x530 fs/bcachefs/alloc_foreground.c:1101
 bch2_alloc_sectors_start_trans+0x1833/0x32b0
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:339 [inline]
 bch2_btree_reserve_get+0x9d6/0x2290 fs/bcachefs/btree_update_interior.c:549
 bch2_btree_update_start+0x1af9/0x2d60 fs/bcachefs/btree_update_interior.c:1247
 bch2_btree_split_leaf+0x120/0xc00 fs/bcachefs/btree_update_interior.c:1856
 bch2_trans_commit_error+0x1c0/0x1d60 fs/bcachefs/btree_trans_commit.c:942
 __bch2_trans_commit+0x210f/0xd190 fs/bcachefs/btree_trans_commit.c:1140
 bch2_trans_commit fs/bcachefs/btree_update.h:184 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:723 [inline]
 btree_interior_update_work+0x2080/0x4870 fs/bcachefs/btree_update_interior.c:861
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
 btree_node_data_alloc fs/bcachefs/btree_cache.c:153 [inline]
 bch2_btree_node_mem_alloc+0xa72/0x2ee0 fs/bcachefs/btree_cache.c:832
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:321 [inline]
 bch2_btree_reserve_get+0x37f/0x2290 fs/bcachefs/btree_update_interior.c:549
 bch2_btree_update_start+0x1af9/0x2d60 fs/bcachefs/btree_update_interior.c:1247
 bch2_btree_split_leaf+0x120/0xc00 fs/bcachefs/btree_update_interior.c:1856
 bch2_trans_commit_error+0x1c0/0x1d60 fs/bcachefs/btree_trans_commit.c:942
 __bch2_trans_commit+0x210f/0xd190 fs/bcachefs/btree_trans_commit.c:1140
 bch2_trans_commit fs/bcachefs/btree_update.h:184 [inline]
 bch2_journal_replay+0x2e3d/0x4d30 fs/bcachefs/recovery.c:317
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

CPU: 1 UID: 0 PID: 3546 Comm: kworker/u8:9 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btree_update btree_interior_update_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

