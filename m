Return-Path: <linux-kernel+bounces-197955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EECF8D713B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F551C20DBA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F415350F;
	Sat,  1 Jun 2024 16:53:28 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EA54650
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717260807; cv=none; b=dVryLxQ5KpmHhL8gk7XUBLDJd7uQ5VnCF35TwzpDUxdfIo5bZ1I43CZDjXy8dTsTN5jl2vrOw2Afcx2HW4uvi9lk77vZTlff7X0AobjzBU8xY2+R7TzaN1YzjgQbHH8tQ5kT0cCF55oT7cTAqtGmnpY00RcVszYT+tlghN3vaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717260807; c=relaxed/simple;
	bh=EI5V98SfrdDxXjbmswq+Eb8dWw40UJc3HX69LMU8KLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mma0GKoW4e9vdLTLJgNAZE5L8VqkcWvXbAMlVCu+y+LFqBZM1Ydny/i2e5KmMm2D0sLC1KK5+nTd+JbQCGP4r7zIjdQt1bSqNtNHxk0x6TpRnjLM0dhELmwnZGTQM12TIyDh/3RDAOZ8G9QQP9l1wv8jFojx8lm1ltR2ULXcwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-37491f6776dso6873915ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 09:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717260805; x=1717865605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaGx/UKrBFgc532qV4kt1S99j+btN1yUJUIVfqSBD+8=;
        b=Ce5keqVK8m7FrO8wRrN4U3wpxnvMy8NCNGOcB46Czj74U5BYBspyCxaO83n5LV9YG9
         3BjVVSX7nFk0jMrKyEcGOv7SGjQCYNHAHRNC1/Svyqhr6GTkWNXby/DPvPXey5NCxR0n
         w6rFn3aU3pM1+vScfhlli9xbDhwgzZWMS9CaJHqVJiXgZ2Ia0rZv5x0jRO+gtF52QrwF
         Coaw/24hbcq8qQiT4av4nC3lhEufcBCl0jwrKvtvaYM3XJ8R6jarmRm6pt0Hwxue+NOV
         IyFkQvgqvHkzNQU7xUXZ2yxMNRHTcqjLWREX2vzOf5v+l69/H/W0og9fpY+evw/oP3eP
         dlIA==
X-Forwarded-Encrypted: i=1; AJvYcCVUM72ZPVGkIH2xzMPJDXRGk25is+9GbaRp+QBCuEbz+TxyT1PRYYaSWEpMoENVV3XVFqawPtF35wH5tteLtcHR/P1AdWmXhdEoSXpV
X-Gm-Message-State: AOJu0YwVrdWZoKYzA4X0Gzhahh7PjivvpaL5vbRjKaOC+u+hnVUuo0Vn
	hVSdMiDB6Xy2a7rn3vIErljiuJtR2hgEUIecfzgG3GMUefzlsGaYaiivRbzz79UgOFmAaMhWvYN
	AJyXasuvc17uqgiBhrpleLpCVSPIiFC1hVxJy9ZCchQYqsA6mh15v6Vw=
X-Google-Smtp-Source: AGHT+IEuF0imbKJtnlnReAvou7s2jire7w0clWqqqEAn6XF0neRTQFpc1Y7K19ztSDdUa1jf7ElJ02ZVj12xwmckE3JjuOMOKfuU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fec:b0:373:8d34:4ad4 with SMTP id
 e9e14a558f8ab-3748ba27eefmr4402875ab.5.1717260805422; Sat, 01 Jun 2024
 09:53:25 -0700 (PDT)
Date: Sat, 01 Jun 2024 09:53:25 -0700
In-Reply-To: <000000000000633dce06194879ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b51430619d6f084@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_alloc_v4_invalid
From: syzbot <syzbot+3b2968fa4953885dd66a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15e19bd2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3b2968fa4953885dd66a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a7d616980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cfabd6980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f1976dcc68c4/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b2968fa4953885dd66a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bch2_alloc_v4_invalid+0x625/0x10f0 fs/bcachefs/alloc_background.c:247
 bch2_alloc_v4_invalid+0x625/0x10f0 fs/bcachefs/alloc_background.c:247
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
 __bch2_journal_reclaim+0xd88/0x1610 fs/bcachefs/journal_reclaim.c:685
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:727
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 memcpy_u64s_small fs/bcachefs/util.h:511 [inline]
 bkey_p_copy fs/bcachefs/bkey.h:46 [inline]
 bch2_sort_keys+0x1f34/0x2cb0 fs/bcachefs/bkey_sort.c:194
 __bch2_btree_node_write+0x3acd/0x67c0 fs/bcachefs/btree_io.c:2100
 bch2_btree_node_write+0xa5/0x2e0 fs/bcachefs/btree_io.c:2288
 btree_node_write_if_need fs/bcachefs/btree_io.h:153 [inline]
 __btree_node_flush+0x4d0/0x640 fs/bcachefs/btree_trans_commit.c:229
 bch2_btree_node_flush0+0x35/0x60 fs/bcachefs/btree_trans_commit.c:238
 journal_flush_pins+0xce6/0x1780 fs/bcachefs/journal_reclaim.c:553
 __bch2_journal_reclaim+0xd88/0x1610 fs/bcachefs/journal_reclaim.c:685
 bch2_journal_reclaim_thread+0x18e/0x760 fs/bcachefs/journal_reclaim.c:727
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

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

CPU: 0 PID: 5053 Comm: bch-reclaim/loo Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

