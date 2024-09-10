Return-Path: <linux-kernel+bounces-322633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CC9972BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1CD1F26490
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06D18F2DF;
	Tue, 10 Sep 2024 08:09:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690718A95B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955747; cv=none; b=tvz3YdhAFgVgKNwq6OUoeMuDFC0xZHGfbFS3CdJIKpfwQrwpMS8XS2Rpav4My9mAwWAgv+7zx+KnTwNpivmetlRjI8KQgve/LLuhKyPXab8ZTUJP4YOJ75NwSBIDqhKS34FVNfNF66+Im9pZDzeYKbSb88LsjSNDHErlQQY+9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955747; c=relaxed/simple;
	bh=aSu8YO+NP/wcxcjQDC3NDz2q3VOBwq8/y59BETcWydE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pg2Gsxp6OqBe0HD2EeuX/RiSXXkRQ2PzDWMhnK4k7jR09/zUOKRfc7qG6Ph6/fvHHcL6NblWasU1cmdhNXonEQYSzTvKmmfDSnUe+vEbq4U3peDCA9A9xoZ+J1sJeh8hULXjThErNRvnEFeb58DLOSpxY+0ZL/qnThbjTdyY4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cdb749559so532247839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955744; x=1726560544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgw8DoG1M7BZv9EqJyhvpfzCha2GwnjcVFpemJc3ogk=;
        b=p9aL7hlo8nAvjGJ2sYmS/3DVfkk42oQPfRXyot15WolbuPScRbFgMXEU/hYcIaeqQQ
         w1UfJ7sek5O5Fx8AzoKFuTlwkOmcPsjnn+FYWQm8RcG6G+7ESCmPXEWHbhpTex21UvxK
         X85PX36G7BzQgroRHFBm2dq/iZtPtdCvhYWvGAaYSmY/SzrnnKqj5X0LuX+D6Xo/i6kC
         V5FjDk6ShukpxfCvMMHG0IAVS0au12iNqzFbKT8XrL4ZGvVzjVvWtRX/8HQk9OOVRCeI
         7vwWYTaCDZjZX7nuLY57+FjWut6fieK2TAks81EMpbur7a0/PJP8T7qkLw6BC6AAkp0G
         WlBA==
X-Forwarded-Encrypted: i=1; AJvYcCX+4fS/zY31IcZY3t42411Ii+TAJzaaLQUaN2OAq3ppSfGIyArXzyY4QdDh8Mm5A/27UXC6zhQXzu0VVWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAvjGpmG7oi9prIf4zmzv3OHgqlzY8cyZ58cP1PspKV2h+9Jw
	pszqwDCkC0frsKeRZ5X036Sc8q58SIRR+ul6LT/lmLs1ThcdwBvItY2tI3vhQS6Sxdjt/+HbSuk
	QV1iRIpjvOSNwcuyd5rbiKi9nf5PrWczf13D8Iw+k5Ag2I6YtJm2mGIU=
X-Google-Smtp-Source: AGHT+IGMLW2Kb8tJqJZAMt0xk0D1CxQPYJJYMvEV0GqaDcsvU3EheCpfCN4ADCAxYpY9L31rwheu6DwUIQ+eJy9jGErYjjBDcyr9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6183:b0:82a:aba5:dd92 with SMTP id
 ca18e2360f4ac-82aaba5df35mr865113139f.8.1725955744611; Tue, 10 Sep 2024
 01:09:04 -0700 (PDT)
Date: Tue, 10 Sep 2024 01:09:04 -0700
In-Reply-To: <20240910071417.7632-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e53a60621bf6341@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_bh
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ntfs_read_bh

=====================================================
BUG: KMSAN: uninit-value in ntfs_fix_post_read fs/ntfs3/fsntfs.c:180 [inline]
BUG: KMSAN: uninit-value in ntfs_read_bh+0x1eb/0xde0 fs/ntfs3/fsntfs.c:1317
 ntfs_fix_post_read fs/ntfs3/fsntfs.c:180 [inline]
 ntfs_read_bh+0x1eb/0xde0 fs/ntfs3/fsntfs.c:1317
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1069
 indx_find+0xd12/0x1440 fs/ntfs3/index.c:1183
 indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2668
 ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3296
 ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3387
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1057
 write_inode fs/fs-writeback.c:1497 [inline]
 __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
 writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
 wb_writeback+0x4df/0xea0 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x40b/0x1940 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 ntfs_read_run_nb+0x786/0x1070 fs/ntfs3/fsntfs.c:1252
 ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1313
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1069
 indx_find+0xd12/0x1440 fs/ntfs3/index.c:1183
 indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2668
 ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3296
 ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3387
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1057
 write_inode fs/fs-writeback.c:1497 [inline]
 __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
 writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
 wb_writeback+0x4df/0xea0 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x40b/0x1940 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4723
 alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2263
 alloc_pages_noprof mm/mempolicy.c:2343 [inline]
 folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2350
 filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1008
 __filemap_get_folio+0xa05/0x14b0 mm/filemap.c:1950
 grow_dev_folio fs/buffer.c:1047 [inline]
 grow_buffers fs/buffer.c:1113 [inline]
 __getblk_slow fs/buffer.c:1139 [inline]
 bdev_getblk+0x2c9/0xab0 fs/buffer.c:1441
 __getblk include/linux/buffer_head.h:381 [inline]
 sb_getblk include/linux/buffer_head.h:387 [inline]
 ntfs_get_bh+0x605/0x1190 fs/ntfs3/fsntfs.c:1365
 indx_new+0x1bc/0x780 fs/ntfs3/index.c:957
 indx_insert_into_root+0x2fd1/0x37d0 fs/ntfs3/index.c:1725
 indx_insert_entry+0xe1d/0xee0 fs/ntfs3/index.c:1984
 ntfs_create_inode+0x4391/0x4df0 fs/ntfs3/inode.c:1694
 ntfs_mkdir+0x56/0x70 fs/ntfs3/namei.c:207
 vfs_mkdir+0x4a0/0x780 fs/namei.c:4210
 do_mkdirat+0x529/0x810 fs/namei.c:4233
 __do_sys_mkdirat fs/namei.c:4248 [inline]
 __se_sys_mkdirat fs/namei.c:4246 [inline]
 __x64_sys_mkdirat+0xc6/0x120 fs/namei.c:4246
 x64_sys_call+0x39e5/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:259
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 3128 Comm: kworker/u8:10 Not tainted 6.11.0-rc1-syzkaller-00017-g689ecd06ef8d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: writeback wb_workfn (flush-7:0)
=====================================================


Tested on:

commit:         689ecd06 fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1626f43b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dda45ca15df5ccb
dashboard link: https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163af43b980000


