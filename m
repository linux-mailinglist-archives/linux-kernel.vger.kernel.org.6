Return-Path: <linux-kernel+bounces-313504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C596A644
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DBCB2147B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D98190660;
	Tue,  3 Sep 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDFmMNcC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F1190047
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387202; cv=none; b=WLpSB2Qx9747LY9S9p8ua+tOwe9YnTrw7NckSTyCjDN3X2/IGaYHxyKBpSDYu4H3gePeQOKfxnYQ8ExTIwcxxZIaZnFq4Y5t9JA/nIXawjkaRZCWeoVIgAok4Pn+TtbLgYsrPz0g0kgwnvMvnBcntzX+BquIAIQuLDOLIQiHans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387202; c=relaxed/simple;
	bh=7vDHN8kEnFIpQ91TrkdHk9K7XX9lzR4B5ZvbKVtTJ0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lquEs/0nNVHgB22P2Fcrv9ZkkrP48Qg2SQR2yRaKg40qGZIGw6c1WaamIfy/ZTW+AZ0HLqhXv20xhmxXkbCOLAn7W3FWJ9RY5q62Jv/4FOr56CKAiQDuocbsx9+2aJiA7C/tXGhVlTIDId10iOH9QQrjtwR+GWntRYkoQ8brJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDFmMNcC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c7a49152aso37614985e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725387199; x=1725991999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6Kj0hnp8VinFY3kEwN8XqdDQPi7VXjSoFZ3cN4dg5M=;
        b=bDFmMNcCIS2hS1WJfQSp62RuILSeIDxRmeXwhDud5VhkgOKJTGLljV5fdfRR3zavek
         hwLont7K/ajyAHVWZIxcjWiaEgzDNOtXVMJnnhEI3Fwc8YyPRb4dfFti8gcwzURHbEdC
         dzAcB7W3SXevqGQbMtHlOJW1kR58vRhpJ/0y/Y0wmJ5Fsc4SQS/2ywlt1I29tNU0hEpi
         DPCRPoGLjqT72xGYPpE5mMgZ7gwl6VP4FN1utih/h718PJq7gLgcLKFb8gkp37sllFEz
         70YsbAx6V0MR6bLIVrVOnHNUpQJFPDbrVjF0GZ8mywUVpg7Qvwd8cdc1QuS2FXJFPwLJ
         t2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387199; x=1725991999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6Kj0hnp8VinFY3kEwN8XqdDQPi7VXjSoFZ3cN4dg5M=;
        b=UI6QzNH7P0B0/6rqSjbda9hr3DF2cBNAjwnLUjh6JAjA8LyHGbkOdsrxsF0qTc/7xp
         YjDKPIxY6swNZCNqrtYjiyuzNz5cy9nm7oTIqEMJSUcSUY9l9pbsEPALBFWFmTNOoe/4
         /nsWt0Zw+Ra7pnST3uFwNPZOxaxVfrVwcsFHTYmLB0Z45XWXm/3m7NgoOsrQ1KA/mqEm
         jUerWLSZIDZPHmcOOr+zHGPYx1Bn7+84N7XdhV/iJx68765lpJC3zPgCtS4nA5fgTEli
         SG4/Q1+RBI+qd/pU0UiVkz5J6iDPvdJTVZkicAJRXfp7hD4r7J3eYhJL3xheUJT8xIMo
         CFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgvTSyOUNReuclYFnFcUCip7AqGrngYJaoOLgsKxlwHKXLC38TFSpebA/Jj/JijIGlJaM9RbRVpl1pxAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3j22DQHGXwYNNU3/ADGALGLmBhLcCppFtuAmi9hOxtV74Sum
	T56sQkZZZJzTX+uUzLGe7ivLOPvS3V7cHrB1vy/sr/wVp5w2xZmau4guMw43jocDG9j0qzLB3AL
	bWA0eZ6BOBBKWLClk1zat78YFD+rBn4ZMICRw
X-Google-Smtp-Source: AGHT+IEU4CeR00snJrOwa16VF5YVHMG9EStu32g7dxShERgkayk/B0FHEcEOCaqXkOdcTOJMsSeOg1DIfPC7EdG5wco=
X-Received: by 2002:a05:6000:b82:b0:374:bb28:2c29 with SMTP id
 ffacd0b85a97d-374bb282d0emr9611076f8f.0.1725387198266; Tue, 03 Sep 2024
 11:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002d4c5e0620ffb2f5@google.com>
In-Reply-To: <0000000000002d4c5e0620ffb2f5@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 11:12:42 -0700
Message-ID: <CAJD7tkZ2ThhUTbL_YahnStSxFnH_3-UCmmro5VmmeKw1vnmcLg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in zswap_store (2)
To: syzbot <syzbot+d13dc01606d396f1a66e@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 12:27=E2=80=AFPM syzbot
<syzbot+d13dc01606d396f1a66e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3e9bff3bbe13 Merge tag 'vfs-6.11-rc6.fixes' of gitolite.k=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11e9fb8d98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D522060455c43d=
52e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd13dc01606d396f=
1a66e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2143e6626450/dis=
k-3e9bff3b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/20b63281b398/vmlinu=
x-3e9bff3b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d0aef7b01715/b=
zImage-3e9bff3b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d13dc01606d396f1a66e@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in zswap_is_folio_same_filled mm/zswap.c:1371 [i=
nline]
> BUG: KMSAN: uninit-value in zswap_store+0x13e7/0x2dd0 mm/zswap.c:1438
>  zswap_is_folio_same_filled mm/zswap.c:1371 [inline]
>  zswap_store+0x13e7/0x2dd0 mm/zswap.c:1438
>  swap_writepage+0x11f/0x470 mm/page_io.c:198
>  shmem_writepage+0x1a75/0x1f70 mm/shmem.c:1536
>  pageout mm/vmscan.c:680 [inline]
>  shrink_folio_list+0x577f/0x7cb0 mm/vmscan.c:1360
>  evict_folios+0x9bce/0xbc80 mm/vmscan.c:4580
>  try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4775
>  shrink_one+0x646/0xd20 mm/vmscan.c:4813
>  shrink_many mm/vmscan.c:4876 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4954 [inline]
>  shrink_node+0x451a/0x50f0 mm/vmscan.c:5934
>  kswapd_shrink_node mm/vmscan.c:6762 [inline]
>  balance_pgdat mm/vmscan.c:6954 [inline]
>  kswapd+0x257e/0x4290 mm/vmscan.c:7223
>  kthread+0x3dd/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  memcpy_from_iter lib/iov_iter.c:73 [inline]
>  iterate_bvec include/linux/iov_iter.h:122 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>  __copy_from_iter lib/iov_iter.c:249 [inline]
>  copy_page_from_iter_atomic+0x12bb/0x2ae0 lib/iov_iter.c:481
>  copy_folio_from_iter_atomic include/linux/uio.h:186 [inline]
>  generic_perform_write+0x896/0x12e0 mm/filemap.c:4032
>  shmem_file_write_iter+0x2bd/0x2f0 mm/shmem.c:3074
>  do_iter_readv_writev+0x8a1/0xa40
>  vfs_iter_write+0x459/0xd50 fs/read_write.c:895
>  lo_write_bvec drivers/block/loop.c:243 [inline]
>  lo_write_simple drivers/block/loop.c:264 [inline]
>  do_req_filebacked drivers/block/loop.c:511 [inline]
>  loop_handle_cmd drivers/block/loop.c:1910 [inline]
>  loop_process_work+0x15ec/0x3750 drivers/block/loop.c:1945
>  loop_workfn+0x48/0x60 drivers/block/loop.c:1969
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
>  worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
>  kthread+0x3dd/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was created at:
>  __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4718
>  alloc_pages_bulk_noprof+0x19e/0x21e0 mm/page_alloc.c:4643
>  btrfs_alloc_page_array fs/btrfs/extent_io.c:704 [inline]
>  alloc_eb_folio_array+0x19c/0x750 fs/btrfs/extent_io.c:728
>  alloc_extent_buffer+0x75a/0x3ba0 fs/btrfs/extent_io.c:3109
>  btrfs_find_create_tree_block+0x46/0x60 fs/btrfs/disk-io.c:614
>  btrfs_init_new_buffer fs/btrfs/extent-tree.c:5026 [inline]
>  btrfs_alloc_tree_block+0x415/0x1990 fs/btrfs/extent-tree.c:5139
>  btrfs_alloc_log_tree_node fs/btrfs/disk-io.c:951 [inline]
>  btrfs_add_log_tree+0x1b7/0x7a0 fs/btrfs/disk-io.c:999
>  start_log_trans fs/btrfs/tree-log.c:227 [inline]
>  btrfs_log_inode_parent+0xa87/0x1c30 fs/btrfs/tree-log.c:7102
>  btrfs_log_dentry_safe+0x9a/0x100 fs/btrfs/tree-log.c:7207
>  btrfs_sync_file+0x15d9/0x2170 fs/btrfs/file.c:1773
>  vfs_fsync_range+0x20d/0x270 fs/sync.c:188
>  generic_write_sync include/linux/fs.h:2821 [inline]
>  btrfs_do_write_iter+0xa17/0xb60 fs/btrfs/file.c:1515
>  btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1525
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xb2f/0x1550 fs/read_write.c:590
>  ksys_write+0x20f/0x4c0 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
>  x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

This looks like a similar problem to [1], but with btrfs instead of
ext4 this time. As Hugh figured out last time, apparently we have a
btrfs file system on a loop device on a tmpfs file. It seems like
btrfs creates and writes back a non-fully initialized block (for
logs?). Shmem copies the memory into its pagecache and later tries to
swap it out through zswap. At which point zswap reads the
uninitialized memory to figure out if it's same-filled.

I suspect we want something similar to what ext4 did in commit
65121eff3e4c ("ext4: avoid writing unitialized memory to disk in EA
inodes") for btrfs. Adding btrfs folks here.

Side-note: apparently the same-filled check in zswap (which is now
being moved to core swap code [2]) is a good way to detect filesystems
writing uninitialized data to disk when the file systems are on a loop
device on a tmpfs file and reclaim kicks in.

[1]https://lore.kernel.org/lkml/000000000000d0f165061a6754c3@google.com/
[2]https://lore.kernel.org/lkml/20240823190545.979059-1-usamaarif642@gmail.=
com/

>
> CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Tainted: G        W          6.11.0-r=
c5-syzkaller-00015-g3e9bff3bbe13 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

