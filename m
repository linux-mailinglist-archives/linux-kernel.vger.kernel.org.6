Return-Path: <linux-kernel+bounces-516547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81485A373D7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B00816E9A7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678418DB0F;
	Sun, 16 Feb 2025 10:47:28 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A514B959
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739702847; cv=none; b=CnH0MRnraaxdTOUVcUKHzajkjzXyqVTTXJJy2nAnmHs2emv428cyW9DwUfbs4ddoD1Sxf+CdnE39Z8ts5LdGsnPV3ZZfTXVmpprl4wuz0kKM6nIr7Lk+EcIyUPED1BsKZIrM+AHIinVElf9RBgUx+LQ+C3SuEJ9u5MSMl5tEwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739702847; c=relaxed/simple;
	bh=5MmFb+s/3IH8CHgp3DbPAEYSYLgpz/LUKEtPYcn9r2k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+WVmNaRpcP1DKHf80wKOtnCn48LjGfrdfTalp1NGLVi2CVaJz4Q38TDsng9TRBlE9hqLIjnWWtqQ4b93g2307E8MLTqPJB9FzIqRJiO/CvPuGYAQy+6Tdo1pARDWDzhXNyQHKDP4wEh+6zB5CMaWsQ3Yxt1vM0oeodS624awKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d190258f86so20592035ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 02:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739702845; x=1740307645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1rC5yZD1Oj7xxoIUrL4EBv5WYlNr78NfBA7GYtJkCc=;
        b=XOFHziytzvsrQupEzLYzCezgAACTCc87G762ILSNjzIWHZ3jTUWSzPRhIXlrb7Me7j
         z4rD0oxP5C4xenJh4dcP38ZuLX23poZqJJ6e45P4gwMecGn7g2UfH+o4AAqNSwl9FhDr
         4a2FSkYCI7IllcrQE83PmVvzjL+NRW9RiSIUX1AL9Ul+p2ATrdRqK6T6iO6fS3CF0jAf
         Ozp+/b3g1Jb3vD5dhCH6OvfEkFY8Mr7HitS70ic5rnD2ukcY4h+uqWcK+R7k9L7q96Ua
         YnyAbF7kIVif+HzFPtmfqzHA/sB+O6QXQagF3hMZm4nxkDgS5vBu9JV1p8KZr38ZPpQh
         Hcuw==
X-Forwarded-Encrypted: i=1; AJvYcCX66Z2uhV6tikhtxZJVWIe9LIEDRX3zduGc3OY1GebIH6bXZJJ49EqtRZq/ubnA2Ejo3uWfuSWozGi9Ins=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsw/3q2EyVq8dN1C0mxmLNziIuQjgdIhUzvxyJtV2u74aVygY
	qMel/tXBYyoo7jXs1vm8lC6C+3B8jzwAZPsGPah+Z4fY28OJ0mTy5HlhQ9An+l820H2DSiiWpDO
	ZTczbyvk67GxiFb0Aqvl742jInTwcRZDwbtAMdik3ve7fuUfC/fizJk4=
X-Google-Smtp-Source: AGHT+IHJn51wBYnnnfHBFAbF++gEpzsR5TFBiMdzYfHmdQ0mIS5I4CP4444lkzfPvz3A3WgBtXVMouCb2o7EPqWqwhTQW4E4N2uZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:692:b0:3d1:4747:f387 with SMTP id
 e9e14a558f8ab-3d18c9b8f2dmr88866535ab.0.1739702845358; Sun, 16 Feb 2025
 02:47:25 -0800 (PST)
Date: Sun, 16 Feb 2025 02:47:25 -0800
In-Reply-To: <67476c0d.050a0220.253251.005e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b1c23d.050a0220.54b41.0007.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined
 (2)
From: syzbot <syzbot+65b594f491e4023728b0@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    496659003dac Merge tag 'i2c-for-6.14-rc3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c2d5a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=264db44f1897cdc3
dashboard link: https://syzkaller.appspot.com/bug?extid=65b594f491e4023728b0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161d2bf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172a97df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/96211a6dd5b7/disk-49665900.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28af00be6abb/vmlinux-49665900.xz
kernel image: https://storage.googleapis.com/syzbot-assets/250398195b35/bzImage-49665900.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/25c6d0c4b587/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65b594f491e4023728b0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_bkey_cmp_packed_inlined+0x8d0/0xd50 fs/bcachefs/bkey_cmp.h:115
 bch2_bkey_cmp_packed_inlined+0x8d0/0xd50 fs/bcachefs/bkey_cmp.h:115
 bch2_sort_keys_keep_unwritten_whiteouts+0xebd/0x1840 fs/bcachefs/bkey_sort.c:184
 __bch2_btree_node_write+0x3b3f/0x6870 fs/bcachefs/btree_io.c:2140
 bch2_btree_node_write_trans+0xd7/0x890 fs/bcachefs/btree_io.c:2357
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:816 [inline]
 btree_interior_update_work+0x3c02/0x48c0 fs/bcachefs/btree_update_interior.c:844
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4249
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4266
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_noprof+0xc96/0x1250 mm/slub.c:4300
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:662
 btree_node_data_alloc fs/bcachefs/btree_cache.c:156 [inline]
 __bch2_btree_node_mem_alloc+0x2be/0xa80 fs/bcachefs/btree_cache.c:201
 bch2_fs_btree_cache_init+0x4f0/0xb60 fs/bcachefs/btree_cache.c:655
 bch2_fs_alloc fs/bcachefs/super.c:919 [inline]
 bch2_fs_open+0x4d84/0x5ba0 fs/bcachefs/super.c:2064
 bch2_fs_get_tree+0x98a/0x24e0 fs/bcachefs/fs.c:2190
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 3010 Comm: kworker/u8:7 Not tainted 6.14.0-rc2-syzkaller-00281-g496659003dac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: btree_update btree_interior_update_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

