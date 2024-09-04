Return-Path: <linux-kernel+bounces-315444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61296C2CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03F31F219B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840A1DC1AD;
	Wed,  4 Sep 2024 15:47:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860D1CF7D8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464848; cv=none; b=OAMsRNA4GuFqp6+A/AhL6VnhCaaQJA5Vet3leLuPtaUvDXgNd7YPPz0GcMW/UoHygNo1NXGIdZmP8ik34FjhsbRSf7+LcGhdA5ECDfEfhd2UrE1Uea/+n3tnsg746IuI6bKS8JFqVHUTJpPOGwM6UeCE8QSSi0JZrbVfHdmZk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464848; c=relaxed/simple;
	bh=t/Ek2CqVYJsG1pI24wxFD8QVsM5fRHPwzZoU89cV2tg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OtQCF5MYhQ84/fwIC4fnECRRQt3cITBRwXp4UA3Flo5XOFjQd88zTxdxqL+c9+8r9w3voGyuJbzNBSr8XveIDnc50awc/KdGv8Zv/QnF0udS4Rd0rienxmh65Wuurv3YSBL19adt1IKjxNuTWOFMqdoZ9RP+Ad9cxr5anCYavuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a13f69336so933620839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464845; x=1726069645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJN+VEpj7Wp4Qoli3keuP/Xv5jDBrdasvpeI4f9NiJQ=;
        b=uqhCWW5j+OxtamQocEOWg/h6kZtBnbbLf7YgISGmElsbBUFdgnLY0J2g+GCqKqfJKb
         4r2F82U1XSXtDVUQWMwBxysbh2Wz2fQ0Ylv00pSccs+Q6L/90IYsuR9lGw8pyT/4Qo49
         digtDXmgylZWze1y51W5NAxX82/R6ZYwFyNRvkwbJD2rJs/TYlKH9UDwXncdwHc+V96u
         CA8l3kgeaRcQgNNBYd3rgjgZnNJ3sH9qvz4w1w+tRxQgxj9WuxBVdMxSR6HEsOfC9Bzo
         8R7cFQGpKv/CcruWyH/S23bXe5OhMgx6aa4dsUQmJo3eITlxk9LBFRgjorkDScxKW8pz
         7QDw==
X-Forwarded-Encrypted: i=1; AJvYcCUN3pTAw1Gu2zpnh+eWlmMfMEyi4gfajWOvtY2Q+QXnhRaQQ1D4611azel0QpGYmPfUHA16ydbF9MHOp6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNEgqD9yJWuvSCiCjxnzkmQ/+xvhMR5z1aiRjKDQtIgSvR//v
	pod+228QYr++z9tlnwmwDLX/BZD4NZYR3H3jueMQmNsR1BcI1+GfAqoT2yJBj0Nuz6EVZ2HKLqM
	4jS6DoIbPFdCl51aNOl2Og5rIUjr60dd/Umw/rSsoiRM+3iGLT0HmogQ=
X-Google-Smtp-Source: AGHT+IGZj6gKcbfa5+o7FjDYVqQlFqVO8wJe365IzlcesbH2IST+c+X4Xo89N5IRMRyi8wxUdlMdeRLeOU9WtR3AuFc+zr8L4eai
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8704:b0:4b9:6c10:36a9 with SMTP id
 8926c6da1cb9f-4d017d74e82mr1348966173.1.1725464845632; Wed, 04 Sep 2024
 08:47:25 -0700 (PDT)
Date: Wed, 04 Sep 2024 08:47:25 -0700
In-Reply-To: <000000000000b3424a062114aaa3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003258e906214d1722@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_bh
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    88fac17500f4 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16802d63980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168f8f0b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1466d5b7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6e5a9ba13ba0/disk-88fac175.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/229238ec073e/vmlinux-88fac175.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64327bdcda24/bzImage-88fac175.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b6db4a705ad8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ntfs_fix_post_read fs/ntfs3/fsntfs.c:180 [inline]
BUG: KMSAN: uninit-value in ntfs_read_bh+0x1eb/0xde0 fs/ntfs3/fsntfs.c:1317
 ntfs_fix_post_read fs/ntfs3/fsntfs.c:180 [inline]
 ntfs_read_bh+0x1eb/0xde0 fs/ntfs3/fsntfs.c:1317
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
 indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181
 indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666
 ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301
 ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052
 write_inode fs/fs-writeback.c:1497 [inline]
 __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
 writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018
 wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129
 wb_check_background_flush fs/fs-writeback.c:2199 [inline]
 wb_do_writeback fs/fs-writeback.c:2287 [inline]
 wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 ntfs_read_run_nb+0x786/0x1070 fs/ntfs3/fsntfs.c:1252
 ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1313
 indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
 indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181
 indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666
 ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301
 ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392
 ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052
 write_inode fs/fs-writeback.c:1497 [inline]
 __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
 writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018
 wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129
 wb_check_background_flush fs/fs-writeback.c:2199 [inline]
 wb_do_writeback fs/fs-writeback.c:2287 [inline]
 wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4718
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
 indx_new+0x1bc/0x780 fs/ntfs3/index.c:955
 indx_insert_into_root+0x2fd1/0x37d0 fs/ntfs3/index.c:1723
 indx_insert_entry+0xe1d/0xee0 fs/ntfs3/index.c:1982
 ntfs_create_inode+0x4391/0x4df0 fs/ntfs3/inode.c:1689
 ntfs_mkdir+0x56/0x70 fs/ntfs3/namei.c:207
 vfs_mkdir+0x4a0/0x780 fs/namei.c:4210
 do_mkdirat+0x529/0x810 fs/namei.c:4233
 __do_sys_mkdirat fs/namei.c:4248 [inline]
 __se_sys_mkdirat fs/namei.c:4246 [inline]
 __x64_sys_mkdirat+0xc6/0x120 fs/namei.c:4246
 x64_sys_call+0x3a81/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:259
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 3708 Comm: kworker/u8:20 Not tainted 6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: writeback wb_workfn (flush-7:0)
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

