Return-Path: <linux-kernel+bounces-196886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6368D630A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3853FB253CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B64158DAD;
	Fri, 31 May 2024 13:32:23 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7411158DA6
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162343; cv=none; b=pKUGNRGEYTaeawvU8CThKlCcmM4b3tYo+HvrInHX/ZXn0ZuCltJGGIMPCbXsZN6RSaVRFpISGq4X+eY6T7dZcTFpABLFfQ17eDdDzXvLc7wfuNDk6u5WxzWXGAm+VwLYv+f7DJQOz+sLTPoVuPtZxIBlXa+x8U1pZYEbsVNWY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162343; c=relaxed/simple;
	bh=TNoq3w/g6a0BW1O3XVf1tsfhM7GQIaN5TdVMO0hNoJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=txxBGR6zCav1zYThtL0Ap0E3u+ABn7pEdDzFjgS91VdUlWZoHGMWMjNVTaW8eU2ScPbwn0bJ6anrpvYN1iXTstmMtdFrMk6cOQ6kXOaz7hIxyVdkfMr6Qm7L/fgYFsU2wgMY3IaS2dOElPaQ7mUPTq0+U5tgTw/Mk5deVjozjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eacf25a50aso166025239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162341; x=1717767141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI6fUVA5jW1yc646rk7kOha5R8+bTt8ymtCaSHBX/gs=;
        b=fC9lH5YNdrfB2Nc+2fEWGwQ4nfceB4zIwRYCv6qtzCZwHe+kptrDaYZFmC+96XpZLj
         Wh6B/4U3TkoEtM/DjBgw+74On5pkoBz4ShQ55E/y+/ntCZMSsL6vdCv4yX3G4rFHH25c
         4cNv+ZMcbB8TK1f/AwvA5eef5+vSKLYRWSt3snDVfgYxa/gOrljvBfI7xHBH2JXFoLdT
         P35uEwEaRcGEbq1Td7CPujJ/cZq5GHuTLGNGtsCXWqlDN5mw48XU0+9RN/1H31iEm4gB
         QUNo1sSBP+gl4DpvwzelVAoD+KMQKVMz73t2pcU7CbyFB6CtARoyRqGd3Cd69PmJntBJ
         ZY9g==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/DdMKVrF4v+UpxBB2D75HzKiKPdkQiseEGUgAZTVCpro6mOchOAlSZ0+wuxuQYOC9gNq0XVqHSc/Hyv7GsjhLXsoj0IUMcWqe6xr
X-Gm-Message-State: AOJu0Yxi9guhwDhsY9L28vEwN8/Wgb3S+wGv/MOUu59WkZIYf52mm3hs
	gZyrG12Dz0BjYPb7Tc9oJPNGEtqlKNU62N0Rdl6BJc1GH8YdLA8Wh/gG9w9jhUs1MnMyy91i8HN
	VUIBN6kT9Y0yvhwSkWCoGlu8V1oOnL+Y5kC7gYOHOTh4B7RkN2j7zcUk=
X-Google-Smtp-Source: AGHT+IEe45YazPeqfuWSjw5HegvS5j1FQfKL5FV7rTwPa4UbWd216LU8kwLHUfgOMwpEsyp69je7r0SfFjin3un6dN9cejkrvn2J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:c48a:0:b0:4b2:f895:c609 with SMTP id
 8926c6da1cb9f-4b5454dd504mr35516173.5.1717162340276; Fri, 31 May 2024
 06:32:20 -0700 (PDT)
Date: Fri, 31 May 2024 06:32:20 -0700
In-Reply-To: <00000000000064f7a40618158fd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000506cfe0619c00321@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_checksum_update
From: syzbot <syzbot+8d0e17030490d2299222@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1731aa4a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=8d0e17030490d2299222
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16412bd2980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c1b1c2980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d711157b6e8c/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d0e17030490d2299222@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc64_be+0x202/0x310 lib/crc64.c:59
 crc64_be+0x202/0x310 lib/crc64.c:59
 bch2_checksum_update+0x15e/0x1d0 fs/bcachefs/checksum.c:87
 bch2_checksum+0x3c5/0x7c0 fs/bcachefs/checksum.c:216
 __bch2_btree_node_write+0x528c/0x67c0 fs/bcachefs/btree_io.c:2151
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
 bch2_sort_keys+0x1b4d/0x2cb0 fs/bcachefs/bkey_sort.c:194
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

CPU: 0 PID: 5054 Comm: bch-reclaim/loo Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

