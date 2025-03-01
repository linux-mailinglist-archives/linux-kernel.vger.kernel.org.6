Return-Path: <linux-kernel+bounces-540146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE191A4AE61
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 00:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2816F2B7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F01DE2B5;
	Sat,  1 Mar 2025 23:42:46 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435B1D63E1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740872566; cv=none; b=Gf/EB3KcEo3epbzLD1/WuTkP0c2t70qYLd+vzp2HvEy3bzIaqWNQGbcuyxF6ICAHs5yxkZjK0ym+1l6n0YPl+nCcQkm2I/YmkGI3H2bzQeB5dLQSZw8zYne6wuSbd0xybH5kzxmBqnOGS0fJ26+ptEl2PML1XjTeB6SFR4RRn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740872566; c=relaxed/simple;
	bh=CPzAXfmab4Y3sxL5bWqWkwAx2PvvCf7JXcILW1YZxg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHmJfiqYwwddNAOzQ+qSErRYgPrj39lRVjclV38ettUWmzzePgX9/+d4uqyNClCwmaeL9tkwnRMZQgSll5N3IrOySBe8x55knIq1VA4RBQwrrIYRnRR6UZ6Fg4BWpaymkLR5UHz4cQeG8LHxY9mbDdIbeZMHngWUD7WAABQ81f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([61.141.101.248])
	by sina.com (10.185.250.21) with ESMTP
	id 67C39AD700005CF7; Sat, 2 Mar 2025 07:40:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7909233408239
X-SMAIL-UIID: AF0716336E1348D7A05097F0E70EBEE2-20250302-074010-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in try_to_unmap_one
Date: Sun,  2 Mar 2025 07:40:01 +0800
Message-ID: <20250301234002.2893-1-hdanton@sina.com>
In-Reply-To: <67c38d10.050a0220.dc10f.016d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 01 Mar 2025 14:41:20 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e5d3fd687aac Add linux-next specific files for 20250218
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12faf7f8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb86166504f57eff29d7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725/disk-e5d3fd68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vmlinux-e5d3fd68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eadfc9520358/bzImage-e5d3fd68.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com
> 
>  evict+0x4e8/0x9a0 fs/inode.c:806
>  __dentry_kill+0x20d/0x630 fs/dcache.c:660
>  dput+0x19f/0x2b0 fs/dcache.c:902
>  __fput+0x60b/0x9f0 fs/file_table.c:472
>  task_work_run+0x24f/0x310 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:1858!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 6053 Comm: syz.4.27 Not tainted 6.14.0-rc3-next-20250218-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:try_to_unmap_one+0x3d0d/0x3fa0 mm/rmap.c:1858
> Code: c7 c7 80 93 c3 8e 48 89 da e8 ef f3 19 03 e9 68 ca ff ff e8 b5 12 ab ff 48 8b 7c 24 20 48 c7 c6 80 17 36 8c e8 94 d2 f5 ff 90 <0f> 0b e8 9c 12 ab ff 48 8b 7c 24 18 48 c7 c6 40 1c 36 8c e8 7b d2
> RSP: 0018:ffffc9000b1be9c0 EFLAGS: 00010246
> RAX: 367eb4645686ad00 RBX: 00000000f4000000 RCX: ffffc9000b1be503
> RDX: 0000000000000004 RSI: ffffffff8c2aaf60 RDI: ffffffff8c8156e0
> RBP: ffffc9000b1bedf0 R08: ffffffff903da477 R09: 1ffffffff207b48e
> R10: dffffc0000000000 R11: fffffbfff207b48f R12: 8000000053c008e7
> R13: dffffc0000000000 R14: ffffea00014f0000 R15: ffffea00014f0030
> FS:  00007f4d2783e6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c465fa1 CR3: 000000002a1f6000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __rmap_walk_file+0x420/0x5f0 mm/rmap.c:2774
>  try_to_unmap+0x219/0x2e0
>  unmap_folio+0x183/0x1f0 mm/huge_memory.c:3053
>  __folio_split+0x849/0x16d0 mm/huge_memory.c:3696
>  truncate_inode_partial_folio+0x9b1/0xdc0 mm/truncate.c:234
>  shmem_undo_range+0x82f/0x1820 mm/shmem.c:1143

Given folio_test_hugetlb(folio) [1], what is weird is hugetlb page in a
shmem mapping.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/mm/rmap.c?id=e5d3fd687aac#n1851

>  shmem_truncate_range mm/shmem.c:1237 [inline]
>  shmem_fallocate+0x431/0xf20 mm/shmem.c:3663
>  vfs_fallocate+0x623/0x7a0 fs/open.c:338
>  madvise_remove mm/madvise.c:1034 [inline]
>  madvise_vma_behavior mm/madvise.c:1263 [inline]
>  madvise_walk_vmas mm/madvise.c:1505 [inline]
>  madvise_do_behavior+0x1ec6/0x3b90 mm/madvise.c:1657
>  do_madvise mm/madvise.c:1755 [inline]
>  __do_sys_madvise mm/madvise.c:1763 [inline]
>  __se_sys_madvise mm/madvise.c:1761 [inline]
>  __x64_sys_madvise+0x11b/0x140 mm/madvise.c:1761
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

