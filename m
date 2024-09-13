Return-Path: <linux-kernel+bounces-327767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D127A977AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DC11C24739
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A71D6C46;
	Fri, 13 Sep 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boyQgJ2N"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163681BC088
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215963; cv=none; b=jrQdFJQrPVonwkrQf81zf5Yy+2fy7wW2M9qTN65msCbDZU84iEFx+t+yx07B9qlX1dC+mqYTSy3VotKnmdAkv6UNDRLYvvBn6PPBzYQdi1hKi9784BuzH7GYwUPTE4QGEGHI/rnrqak+lodkFs5ZISWNvTNy1HeS2ZdQWfqOW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215963; c=relaxed/simple;
	bh=BYld73j3Aspco3IvxGvbmqly/CG5eTo2+L005K0xvWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgVHOjBIPOVyPnINSHvXvxzqgskd71uvDHkURYtokVR0GbGfe+Hlxxg5mfhyOyXqIg4B0g5XbWFlW2Z2s11r7l/Axoy5e4W5WOjuss9thR4tCIEWdcWpyEGz8IpIsWZnaj3BYykg8XcubdjEySZjiFnah9/Yqmp4LVGKO9p6MZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boyQgJ2N; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-846cdfbb153so511177241.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726215960; x=1726820760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FA0ytxdwBqA9nRxavwt8aKpIQNZ2ptMIrr+t63AHFEk=;
        b=boyQgJ2Nk/aRihhCmGad7g9P/QMfPk/rcw2niCDFSe2gvJ0clq13fRZbsLwXMzgp2F
         jevtsCTF8k7Gg3zfLI7AcqBTQiPU2pCm7lESKed0YNod3zpXtg0C8D1adBIk64mioubD
         REhbxMAI289n7pGNNkahGZSlswpbpmkE/6cdcgj3K4+oCMF4CouewJDVJgYnv06CodL0
         /2q8iYiTL9fXgUwrdMzzofOXbvIqCAW8DNz7W5eEBzH6Nf0gaf5n9cqcXRV1P1zLcmpl
         4IYI+kDz0eNeNsM0lZ2ATPMY+qCiZgVdkCIwfMeKmBq5oDqJl+Zbs2pVghwhT15JQaRR
         SBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726215960; x=1726820760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA0ytxdwBqA9nRxavwt8aKpIQNZ2ptMIrr+t63AHFEk=;
        b=PtuiEIHFDSkhVV06QULL4EaBYktCO3JS4I60nNkRNsz09phstffxzrTtu1i+9pmXR2
         lVXWKRcX5flCKXT5zqnmYZgVDzqWdPwxMQvqggBoNzDD5o9vLCnM0tyCztV0knWHz5UA
         ucDqqYSX9bvS8GcURBkxYGM+rRhk3PqVOshss3TM8uNtWd3t7c0wE6+gq/45IFgUnrkt
         Lvg2UxNVvHHdssRaV7SeCEqRk15SWpHuqc+0D/zDA5Zl8dQM4Cex2X68HO64kHWyqvuQ
         OO7DJvt/tugJsppT4k/lja80fb6dINcZVAS4xy50i4E9CcZbbsMWpm84mRdLujzb1AMB
         /ZGQ==
X-Gm-Message-State: AOJu0YwMEF/CQ0dHfo8DnJvbUjAZkADf8bCjBKXqPtDXa5zvZjAE4YPe
	3esdpy9/FeSgFUApTSf4wnA1eFnq5Asb3Im1WR8XcaEpSii2cqAhDdSRWbXYGDbTmvdw3d1btBg
	6MT2WKLpOUVl3ml1OUpoME99yZikq82AU
X-Google-Smtp-Source: AGHT+IEEInmjxAL0nGcdYhzV6X7Bl2h6NeCXmLCuth5kxag4Kk1W8LKZ51RshdHKBAX9iGGJSX0z110XyZuVIP+sxOE=
X-Received: by 2002:a05:6102:5120:b0:498:d39b:b0ef with SMTP id
 ada2fe7eead31-49d41479253mr4586950137.8.1726215959776; Fri, 13 Sep 2024
 01:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACb6ct1VapivgTKjsoUnq06UKvNUVwaL_CS750phHNwpPynQog@mail.gmail.com>
 <0000000000007f9cab0621faa59b@google.com>
In-Reply-To: <0000000000007f9cab0621faa59b@google.com>
From: Sathvik Joel <ksjoe30@gmail.com>
Date: Fri, 13 Sep 2024 13:55:47 +0530
Message-ID: <CACb6ct3x-hicbOn5ntiSUJdd3iPSmmnYcof4qH2ibauO7SG1KQ@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] [ntfs3?] KMSAN: uninit-value in sw842_compress
To: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="00000000000016ae6c0621fbf9c6"

--00000000000016ae6c0621fbf9c6
Content-Type: multipart/alternative; boundary="00000000000016ae6b0621fbf9c4"

--00000000000016ae6b0621fbf9c4
Content-Type: text/plain; charset="UTF-8"

#syz test

On Fri, 13 Sept 2024 at 12:21, syzbot <
syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still
> triggering an issue:
> KMSAN: uninit-value in sw842_compress
>
> =====================================================
> BUG: KMSAN: uninit-value in check_template lib/842/842_compress.c:393
> [inline]
> BUG: KMSAN: uninit-value in process_next lib/842/842_compress.c:458
> [inline]
> BUG: KMSAN: uninit-value in sw842_compress+0x1744/0x5a70
> lib/842/842_compress.c:545
>  check_template lib/842/842_compress.c:393 [inline]
>  process_next lib/842/842_compress.c:458 [inline]
>  sw842_compress+0x1744/0x5a70 lib/842/842_compress.c:545
>  crypto842_scompress+0x4f/0x70 crypto/842.c:78
>  scomp_acomp_comp_decomp+0x7c6/0xb90
>  scomp_acomp_compress+0x32/0x40 crypto/scompress.c:187
>  crypto_acomp_compress include/crypto/acompress.h:251 [inline]
>  zswap_compress+0x368/0xad0 mm/zswap.c:927
>  zswap_store+0x1af3/0x2dd0 mm/zswap.c:1459
>  swap_writepage+0x11f/0x470 mm/page_io.c:198
>  shmem_writepage+0x1a75/0x1f70 mm/shmem.c:1536
>  pageout mm/vmscan.c:680 [inline]
>  shrink_folio_list+0x577f/0x7cb0 mm/vmscan.c:1360
>  evict_folios+0x9a49/0xbb30 mm/vmscan.c:4560
>  try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4755
>  lru_gen_shrink_lruvec mm/vmscan.c:4897 [inline]
>  shrink_lruvec+0x4a3/0x46c0 mm/vmscan.c:5652
>  shrink_node_memcgs mm/vmscan.c:5888 [inline]
>  shrink_node+0x104e/0x50f0 mm/vmscan.c:5928
>  shrink_zones mm/vmscan.c:6172 [inline]
>  do_try_to_free_pages+0x820/0x2550 mm/vmscan.c:6234
>  try_to_free_mem_cgroup_pages+0x3f7/0xae0 mm/vmscan.c:6566
>  try_charge_memcg+0x72c/0x1830 mm/memcontrol.c:2210
>  try_charge mm/memcontrol-v1.h:20 [inline]
>  charge_memcg mm/memcontrol.c:4438 [inline]
>  __mem_cgroup_charge+0x11d/0x3f0 mm/memcontrol.c:4453
>  mem_cgroup_charge include/linux/memcontrol.h:672 [inline]
>  shmem_alloc_and_add_folio+0xe83/0x1ca0 mm/shmem.c:1792
>  shmem_get_folio_gfp+0x10bd/0x24c0 mm/shmem.c:2188
>  shmem_read_folio_gfp+0x80/0x140 mm/shmem.c:5201
>  drm_gem_get_pages+0x3cf/0x1440 drivers/gpu/drm/drm_gem.c:568
>  drm_gem_shmem_get_pages drivers/gpu/drm/drm_gem_shmem_helper.c:177
> [inline]
>  drm_gem_shmem_vmap+0x2dc/0xca0 drivers/gpu/drm/drm_gem_shmem_helper.c:337
>  drm_gem_shmem_object_vmap+0x35/0x40 include/drm/drm_gem_shmem_helper.h:229
>  drm_gem_vmap drivers/gpu/drm/drm_gem.c:1205 [inline]
>  drm_gem_vmap_unlocked+0xc6/0x200 drivers/gpu/drm/drm_gem.c:1247
>  drm_gem_fb_vmap+0x11b/0x590
> drivers/gpu/drm/drm_gem_framebuffer_helper.c:365
>  vkms_prepare_fb+0x12f/0x170 drivers/gpu/drm/vkms/vkms_plane.c:176
>  drm_atomic_helper_prepare_planes+0x436/0x10b0
> drivers/gpu/drm/drm_atomic_helper.c:2601
>  drm_atomic_helper_commit+0x1f3/0xe80
> drivers/gpu/drm/drm_atomic_helper.c:2029
>  drm_atomic_commit+0x30a/0x380 drivers/gpu/drm/drm_atomic.c:1522
>  drm_atomic_helper_update_plane+0x42b/0x600
> drivers/gpu/drm/drm_atomic_helper.c:3190
>  __setplane_atomic+0x33d/0x3f0 drivers/gpu/drm/drm_plane.c:1074
>  drm_mode_cursor_universal drivers/gpu/drm/drm_plane.c:1229 [inline]
>  drm_mode_cursor_common+0x171a/0x1e80 drivers/gpu/drm/drm_plane.c:1288
>  drm_mode_cursor_ioctl+0x97/0xd0 drivers/gpu/drm/drm_plane.c:1338
>  drm_ioctl_kernel+0x4ea/0x560 drivers/gpu/drm/drm_ioctl.c:745
>  drm_ioctl+0xd13/0x15a0 drivers/gpu/drm/drm_ioctl.c:842
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
>  x64_sys_call+0x18bf/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> <Zero or more stacks not recorded to save memory>
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
>  loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
>  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450
>  indx_write fs/ntfs3/index.c:1027 [inline]
>  indx_update_dup+0xd81/0xf80 fs/ntfs3/index.c:2694
>  ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301
>  ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392
>  ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052
>  write_inode fs/fs-writeback.c:1497 [inline]
>  __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
>  writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
>  __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018
>  wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129
>  wb_check_background_flush fs/fs-writeback.c:2199 [inline]
>  wb_do_writeback fs/fs-writeback.c:2287 [inline]
>  wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
>  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  ntfs_read_run_nb+0x786/0x1070 fs/ntfs3/fsntfs.c:1252
>  ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1313
>  indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
>  indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181
>  indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666
>  ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301
>  ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392
>  ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052
>  write_inode fs/fs-writeback.c:1497 [inline]
>  __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
>  writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
>  __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018
>  wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129
>  wb_check_background_flush fs/fs-writeback.c:2199 [inline]
>  wb_do_writeback fs/fs-writeback.c:2287 [inline]
>  wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
>  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450
>  indx_write fs/ntfs3/index.c:1027 [inline]
>  indx_update_dup+0xd81/0xf80 fs/ntfs3/index.c:2694
>  ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301
>  ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392
>  ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052
>  write_inode fs/fs-writeback.c:1497 [inline]
>  __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
>  writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
>  __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018
>  wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129
>  wb_check_background_flush fs/fs-writeback.c:2199 [inline]
>  wb_do_writeback fs/fs-writeback.c:2287 [inline]
>  wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
>  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  ntfs_read_run_nb+0x786/0x1070 fs/ntfs3/fsntfs.c:1252
>  ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1313
>  indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067
>  indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181
>  indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666
>  ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301
>  ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392
>  ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052
>  write_inode fs/fs-writeback.c:1497 [inline]
>  __writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716
>  writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947
>  __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018
>  wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129
>  wb_check_background_flush fs/fs-writeback.c:2199 [inline]
>  wb_do_writeback fs/fs-writeback.c:2287 [inline]
>  wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
>  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450
>  indx_write fs/ntfs3/index.c:1027 [inline]
>  indx_insert_into_buffer+0xd8f/0x2010 fs/ntfs3/index.c:1811
>  indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1988
>  ni_add_name+0xe5d/0x10d0 fs/ntfs3/frecord.c:3123
>  ntfs_link_inode+0x265/0x310 fs/ntfs3/inode.c:1768
>  ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146
>  vfs_link+0x93d/0xb70 fs/namei.c:4692
>  do_linkat+0x4f5/0xfd0 fs/namei.c:4762
>  __do_sys_link fs/namei.c:4796 [inline]
>  __se_sys_link fs/namei.c:4794 [inline]
>  __x64_sys_link+0xe8/0x140 fs/namei.c:4794
>  x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:87
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  hdr_insert_de fs/ntfs3/index.c:838 [inline]
>  indx_insert_into_buffer+0xcdf/0x2010 fs/ntfs3/index.c:1807
>  indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1988
>  ni_add_name+0xe5d/0x10d0 fs/ntfs3/frecord.c:3123
>  ntfs_link_inode+0x265/0x310 fs/ntfs3/inode.c:1768
>  ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146
>  vfs_link+0x93d/0xb70 fs/namei.c:4692
>  do_linkat+0x4f5/0xfd0 fs/namei.c:4762
>  __do_sys_link fs/namei.c:4796 [inline]
>  __se_sys_link fs/namei.c:4794 [inline]
>  __x64_sys_link+0xe8/0x140 fs/namei.c:4794
>  x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:87
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3998 [inline]
>  slab_alloc_node mm/slub.c:4041 [inline]
>  kmem_cache_alloc_noprof+0x637/0xb20 mm/slub.c:4048
>  ntfs_link_inode+0x8f/0x310 fs/ntfs3/inode.c:1756
>  ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146
>  vfs_link+0x93d/0xb70 fs/namei.c:4692
>  do_linkat+0x4f5/0xfd0 fs/namei.c:4762
>  __do_sys_link fs/namei.c:4796 [inline]
>  __se_sys_link fs/namei.c:4794 [inline]
>  __x64_sys_link+0xe8/0x140 fs/namei.c:4794
>  x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:87
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 1 UID: 0 PID: 5939 Comm: syz.0.15 Not tainted
> 6.11.0-rc7-syzkaller-g196145c606d0-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 08/06/2024
> =====================================================
>
>
> Tested on:
>
> commit:         196145c6 Merge tag 'clk-fixes-for-linus' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=159027c7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea008021530b2de3
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=17cae3c0a5b0acdc327d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> patch:
> https://syzkaller.appspot.com/x/patch.diff?x=1453949f980000
>
>

--00000000000016ae6b0621fbf9c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, 13 Sept 2024 at 12:21, syzbot &lt;<a =
href=3D"mailto:syzbot%2B17cae3c0a5b0acdc327d@syzkaller.appspotmail.com">syz=
bot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
syzbot has tested the proposed patch but the reproducer is still triggering=
 an issue:<br>
KMSAN: uninit-value in sw842_compress<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
BUG: KMSAN: uninit-value in check_template lib/842/842_compress.c:393 [inli=
ne]<br>
BUG: KMSAN: uninit-value in process_next lib/842/842_compress.c:458 [inline=
]<br>
BUG: KMSAN: uninit-value in sw842_compress+0x1744/0x5a70 lib/842/842_compre=
ss.c:545<br>
=C2=A0check_template lib/842/842_compress.c:393 [inline]<br>
=C2=A0process_next lib/842/842_compress.c:458 [inline]<br>
=C2=A0sw842_compress+0x1744/0x5a70 lib/842/842_compress.c:545<br>
=C2=A0crypto842_scompress+0x4f/0x70 crypto/842.c:78<br>
=C2=A0scomp_acomp_comp_decomp+0x7c6/0xb90<br>
=C2=A0scomp_acomp_compress+0x32/0x40 crypto/scompress.c:187<br>
=C2=A0crypto_acomp_compress include/crypto/acompress.h:251 [inline]<br>
=C2=A0zswap_compress+0x368/0xad0 mm/zswap.c:927<br>
=C2=A0zswap_store+0x1af3/0x2dd0 mm/zswap.c:1459<br>
=C2=A0swap_writepage+0x11f/0x470 mm/page_io.c:198<br>
=C2=A0shmem_writepage+0x1a75/0x1f70 mm/shmem.c:1536<br>
=C2=A0pageout mm/vmscan.c:680 [inline]<br>
=C2=A0shrink_folio_list+0x577f/0x7cb0 mm/vmscan.c:1360<br>
=C2=A0evict_folios+0x9a49/0xbb30 mm/vmscan.c:4560<br>
=C2=A0try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4755<br>
=C2=A0lru_gen_shrink_lruvec mm/vmscan.c:4897 [inline]<br>
=C2=A0shrink_lruvec+0x4a3/0x46c0 mm/vmscan.c:5652<br>
=C2=A0shrink_node_memcgs mm/vmscan.c:5888 [inline]<br>
=C2=A0shrink_node+0x104e/0x50f0 mm/vmscan.c:5928<br>
=C2=A0shrink_zones mm/vmscan.c:6172 [inline]<br>
=C2=A0do_try_to_free_pages+0x820/0x2550 mm/vmscan.c:6234<br>
=C2=A0try_to_free_mem_cgroup_pages+0x3f7/0xae0 mm/vmscan.c:6566<br>
=C2=A0try_charge_memcg+0x72c/0x1830 mm/memcontrol.c:2210<br>
=C2=A0try_charge mm/memcontrol-v1.h:20 [inline]<br>
=C2=A0charge_memcg mm/memcontrol.c:4438 [inline]<br>
=C2=A0__mem_cgroup_charge+0x11d/0x3f0 mm/memcontrol.c:4453<br>
=C2=A0mem_cgroup_charge include/linux/memcontrol.h:672 [inline]<br>
=C2=A0shmem_alloc_and_add_folio+0xe83/0x1ca0 mm/shmem.c:1792<br>
=C2=A0shmem_get_folio_gfp+0x10bd/0x24c0 mm/shmem.c:2188<br>
=C2=A0shmem_read_folio_gfp+0x80/0x140 mm/shmem.c:5201<br>
=C2=A0drm_gem_get_pages+0x3cf/0x1440 drivers/gpu/drm/drm_gem.c:568<br>
=C2=A0drm_gem_shmem_get_pages drivers/gpu/drm/drm_gem_shmem_helper.c:177 [i=
nline]<br>
=C2=A0drm_gem_shmem_vmap+0x2dc/0xca0 drivers/gpu/drm/drm_gem_shmem_helper.c=
:337<br>
=C2=A0drm_gem_shmem_object_vmap+0x35/0x40 include/drm/drm_gem_shmem_helper.=
h:229<br>
=C2=A0drm_gem_vmap drivers/gpu/drm/drm_gem.c:1205 [inline]<br>
=C2=A0drm_gem_vmap_unlocked+0xc6/0x200 drivers/gpu/drm/drm_gem.c:1247<br>
=C2=A0drm_gem_fb_vmap+0x11b/0x590 drivers/gpu/drm/drm_gem_framebuffer_helpe=
r.c:365<br>
=C2=A0vkms_prepare_fb+0x12f/0x170 drivers/gpu/drm/vkms/vkms_plane.c:176<br>
=C2=A0drm_atomic_helper_prepare_planes+0x436/0x10b0 drivers/gpu/drm/drm_ato=
mic_helper.c:2601<br>
=C2=A0drm_atomic_helper_commit+0x1f3/0xe80 drivers/gpu/drm/drm_atomic_helpe=
r.c:2029<br>
=C2=A0drm_atomic_commit+0x30a/0x380 drivers/gpu/drm/drm_atomic.c:1522<br>
=C2=A0drm_atomic_helper_update_plane+0x42b/0x600 drivers/gpu/drm/drm_atomic=
_helper.c:3190<br>
=C2=A0__setplane_atomic+0x33d/0x3f0 drivers/gpu/drm/drm_plane.c:1074<br>
=C2=A0drm_mode_cursor_universal drivers/gpu/drm/drm_plane.c:1229 [inline]<b=
r>
=C2=A0drm_mode_cursor_common+0x171a/0x1e80 drivers/gpu/drm/drm_plane.c:1288=
<br>
=C2=A0drm_mode_cursor_ioctl+0x97/0xd0 drivers/gpu/drm/drm_plane.c:1338<br>
=C2=A0drm_ioctl_kernel+0x4ea/0x560 drivers/gpu/drm/drm_ioctl.c:745<br>
=C2=A0drm_ioctl+0xd13/0x15a0 drivers/gpu/drm/drm_ioctl.c:842<br>
=C2=A0vfs_ioctl fs/ioctl.c:51 [inline]<br>
=C2=A0__do_sys_ioctl fs/ioctl.c:907 [inline]<br>
=C2=A0__se_sys_ioctl+0x261/0x450 fs/ioctl.c:893<br>
=C2=A0__x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893<br>
=C2=A0x64_sys_call+0x18bf/0x3ba0 arch/x86/include/generated/asm/syscalls_64=
.h:17<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
<br>
&lt;Zero or more stacks not recorded to save memory&gt;<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0memcpy_from_iter lib/iov_iter.c:73 [inline]<br>
=C2=A0iterate_bvec include/linux/iov_iter.h:122 [inline]<br>
=C2=A0iterate_and_advance2 include/linux/iov_iter.h:249 [inline]<br>
=C2=A0iterate_and_advance include/linux/iov_iter.h:271 [inline]<br>
=C2=A0__copy_from_iter lib/iov_iter.c:249 [inline]<br>
=C2=A0copy_page_from_iter_atomic+0x12bb/0x2ae0 lib/iov_iter.c:481<br>
=C2=A0copy_folio_from_iter_atomic include/linux/uio.h:186 [inline]<br>
=C2=A0generic_perform_write+0x896/0x12e0 mm/filemap.c:4032<br>
=C2=A0shmem_file_write_iter+0x2bd/0x2f0 mm/shmem.c:3074<br>
=C2=A0do_iter_readv_writev+0x8a1/0xa40<br>
=C2=A0vfs_iter_write+0x459/0xd50 fs/read_write.c:895<br>
=C2=A0lo_write_bvec drivers/block/loop.c:243 [inline]<br>
=C2=A0lo_write_simple drivers/block/loop.c:264 [inline]<br>
=C2=A0do_req_filebacked drivers/block/loop.c:511 [inline]<br>
=C2=A0loop_handle_cmd drivers/block/loop.c:1910 [inline]<br>
=C2=A0loop_process_work+0x15ec/0x3750 drivers/block/loop.c:1945<br>
=C2=A0loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976<br>
=C2=A0process_one_work kernel/workqueue.c:3231 [inline]<br>
=C2=A0process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312<br>
=C2=A0worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393<br>
=C2=A0kthread+0x3e2/0x540 kernel/kthread.c:389<br>
=C2=A0ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147<br>
=C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450<br>
=C2=A0indx_write fs/ntfs3/index.c:1027 [inline]<br>
=C2=A0indx_update_dup+0xd81/0xf80 fs/ntfs3/index.c:2694<br>
=C2=A0ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301<br>
=C2=A0ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392<br>
=C2=A0ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052<br>
=C2=A0write_inode fs/fs-writeback.c:1497 [inline]<br>
=C2=A0__writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716<br>
=C2=A0writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947<br>
=C2=A0__writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018<br>
=C2=A0wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129<br>
=C2=A0wb_check_background_flush fs/fs-writeback.c:2199 [inline]<br>
=C2=A0wb_do_writeback fs/fs-writeback.c:2287 [inline]<br>
=C2=A0wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314<br>
=C2=A0process_one_work kernel/workqueue.c:3231 [inline]<br>
=C2=A0process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312<br>
=C2=A0worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393<br>
=C2=A0kthread+0x3e2/0x540 kernel/kthread.c:389<br>
=C2=A0ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147<br>
=C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0ntfs_read_run_nb+0x786/0x1070 fs/ntfs3/fsntfs.c:1252<br>
=C2=A0ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1313<br>
=C2=A0indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067<br>
=C2=A0indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181<br>
=C2=A0indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666<br>
=C2=A0ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301<br>
=C2=A0ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392<br>
=C2=A0ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052<br>
=C2=A0write_inode fs/fs-writeback.c:1497 [inline]<br>
=C2=A0__writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716<br>
=C2=A0writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947<br>
=C2=A0__writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018<br>
=C2=A0wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129<br>
=C2=A0wb_check_background_flush fs/fs-writeback.c:2199 [inline]<br>
=C2=A0wb_do_writeback fs/fs-writeback.c:2287 [inline]<br>
=C2=A0wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314<br>
=C2=A0process_one_work kernel/workqueue.c:3231 [inline]<br>
=C2=A0process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312<br>
=C2=A0worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393<br>
=C2=A0kthread+0x3e2/0x540 kernel/kthread.c:389<br>
=C2=A0ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147<br>
=C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450<br>
=C2=A0indx_write fs/ntfs3/index.c:1027 [inline]<br>
=C2=A0indx_update_dup+0xd81/0xf80 fs/ntfs3/index.c:2694<br>
=C2=A0ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301<br>
=C2=A0ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392<br>
=C2=A0ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052<br>
=C2=A0write_inode fs/fs-writeback.c:1497 [inline]<br>
=C2=A0__writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716<br>
=C2=A0writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947<br>
=C2=A0__writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018<br>
=C2=A0wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129<br>
=C2=A0wb_check_background_flush fs/fs-writeback.c:2199 [inline]<br>
=C2=A0wb_do_writeback fs/fs-writeback.c:2287 [inline]<br>
=C2=A0wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314<br>
=C2=A0process_one_work kernel/workqueue.c:3231 [inline]<br>
=C2=A0process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312<br>
=C2=A0worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393<br>
=C2=A0kthread+0x3e2/0x540 kernel/kthread.c:389<br>
=C2=A0ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147<br>
=C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0ntfs_read_run_nb+0x786/0x1070 fs/ntfs3/fsntfs.c:1252<br>
=C2=A0ntfs_read_bh+0x64/0xde0 fs/ntfs3/fsntfs.c:1313<br>
=C2=A0indx_read+0x44e/0x17b0 fs/ntfs3/index.c:1067<br>
=C2=A0indx_find+0xd12/0x1440 fs/ntfs3/index.c:1181<br>
=C2=A0indx_update_dup+0x607/0xf80 fs/ntfs3/index.c:2666<br>
=C2=A0ni_update_parent+0x12de/0x14b0 fs/ntfs3/frecord.c:3301<br>
=C2=A0ni_write_inode+0x1cf4/0x1de0 fs/ntfs3/frecord.c:3392<br>
=C2=A0ntfs3_write_inode+0x94/0xb0 fs/ntfs3/inode.c:1052<br>
=C2=A0write_inode fs/fs-writeback.c:1497 [inline]<br>
=C2=A0__writeback_single_inode+0x849/0x12c0 fs/fs-writeback.c:1716<br>
=C2=A0writeback_sb_inodes+0xc95/0x1e00 fs/fs-writeback.c:1947<br>
=C2=A0__writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2018<br>
=C2=A0wb_writeback+0x50b/0xea0 fs/fs-writeback.c:2129<br>
=C2=A0wb_check_background_flush fs/fs-writeback.c:2199 [inline]<br>
=C2=A0wb_do_writeback fs/fs-writeback.c:2287 [inline]<br>
=C2=A0wb_workfn+0x122c/0x1940 fs/fs-writeback.c:2314<br>
=C2=A0process_one_work kernel/workqueue.c:3231 [inline]<br>
=C2=A0process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312<br>
=C2=A0worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393<br>
=C2=A0kthread+0x3e2/0x540 kernel/kthread.c:389<br>
=C2=A0ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147<br>
=C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450<br>
=C2=A0indx_write fs/ntfs3/index.c:1027 [inline]<br>
=C2=A0indx_insert_into_buffer+0xd8f/0x2010 fs/ntfs3/index.c:1811<br>
=C2=A0indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1988<br>
=C2=A0ni_add_name+0xe5d/0x10d0 fs/ntfs3/frecord.c:3123<br>
=C2=A0ntfs_link_inode+0x265/0x310 fs/ntfs3/inode.c:1768<br>
=C2=A0ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146<br>
=C2=A0vfs_link+0x93d/0xb70 fs/namei.c:4692<br>
=C2=A0do_linkat+0x4f5/0xfd0 fs/namei.c:4762<br>
=C2=A0__do_sys_link fs/namei.c:4796 [inline]<br>
=C2=A0__se_sys_link fs/namei.c:4794 [inline]<br>
=C2=A0__x64_sys_link+0xe8/0x140 fs/namei.c:4794<br>
=C2=A0x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64=
.h:87<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0hdr_insert_de fs/ntfs3/index.c:838 [inline]<br>
=C2=A0indx_insert_into_buffer+0xcdf/0x2010 fs/ntfs3/index.c:1807<br>
=C2=A0indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1988<br>
=C2=A0ni_add_name+0xe5d/0x10d0 fs/ntfs3/frecord.c:3123<br>
=C2=A0ntfs_link_inode+0x265/0x310 fs/ntfs3/inode.c:1768<br>
=C2=A0ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146<br>
=C2=A0vfs_link+0x93d/0xb70 fs/namei.c:4692<br>
=C2=A0do_linkat+0x4f5/0xfd0 fs/namei.c:4762<br>
=C2=A0__do_sys_link fs/namei.c:4796 [inline]<br>
=C2=A0__se_sys_link fs/namei.c:4794 [inline]<br>
=C2=A0__x64_sys_link+0xe8/0x140 fs/namei.c:4794<br>
=C2=A0x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64=
.h:87<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
<br>
Uninit was created at:<br>
=C2=A0slab_post_alloc_hook mm/slub.c:3998 [inline]<br>
=C2=A0slab_alloc_node mm/slub.c:4041 [inline]<br>
=C2=A0kmem_cache_alloc_noprof+0x637/0xb20 mm/slub.c:4048<br>
=C2=A0ntfs_link_inode+0x8f/0x310 fs/ntfs3/inode.c:1756<br>
=C2=A0ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146<br>
=C2=A0vfs_link+0x93d/0xb70 fs/namei.c:4692<br>
=C2=A0do_linkat+0x4f5/0xfd0 fs/namei.c:4762<br>
=C2=A0__do_sys_link fs/namei.c:4796 [inline]<br>
=C2=A0__se_sys_link fs/namei.c:4794 [inline]<br>
=C2=A0__x64_sys_link+0xe8/0x140 fs/namei.c:4794<br>
=C2=A0x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64=
.h:87<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
<br>
CPU: 1 UID: 0 PID: 5939 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-g19=
6145c606d0-dirty #0<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 08/06/2024<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
<br>
<br>
Tested on:<br>
<br>
commit:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0196145c6 Merge tag &#39;clk-fixes-=
for-linus&#39; of git://git...<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0upstream<br>
console output: <a href=3D"https://syzkaller.appspot.com/x/log.txt?x=3D1590=
27c7980000" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.=
com/x/log.txt?x=3D159027c7980000</a><br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Dea008021530b2de3" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3Dea008021530b2de3</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D17cae3=
c0a5b0acdc327d" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3D17cae3c0a5b0acdc327d</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0Debian clang version 15.0.6, GNU ld (GN=
U Binutils for Debian) 2.40<br>
patch:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appsp=
ot.com/x/patch.diff?x=3D1453949f980000" rel=3D"noreferrer" target=3D"_blank=
">https://syzkaller.appspot.com/x/patch.diff?x=3D1453949f980000</a><br>
<br>
</blockquote></div>

--00000000000016ae6b0621fbf9c4--
--00000000000016ae6c0621fbf9c6
Content-Type: text/plain; charset="US-ASCII"; name="diff --git alib842842_compress.c bl.txt"
Content-Disposition: attachment; 
	filename="diff --git alib842842_compress.c bl.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m10geh3j0>
X-Attachment-Id: f_m10geh3j0

ZGlmZiAtLWdpdCBhL2xpYi84NDIvODQyX2NvbXByZXNzLmMgYi9saWIvODQyLzg0Ml9jb21wcmVz
cy5jDQppbmRleCBjMDJiYWE0MTY4ZTEuLjIwNDRhZDE0ZmQ2ZiAxMDA2NDQNCi0tLSBhL2xpYi84
NDIvODQyX2NvbXByZXNzLmMNCisrKyBiL2xpYi84NDIvODQyX2NvbXByZXNzLmMNCkBAIC00Nzgs
NiArNDc4LDkgQEAgaW50IHN3ODQyX2NvbXByZXNzKGNvbnN0IHU4ICppbiwgdW5zaWduZWQgaW50
IGlsZW4sDQogCQkgICB1OCAqb3V0LCB1bnNpZ25lZCBpbnQgKm9sZW4sIHZvaWQgKndtZW0pDQog
ew0KIAlzdHJ1Y3Qgc3c4NDJfcGFyYW0gKnAgPSAoc3RydWN0IHN3ODQyX3BhcmFtICopd21lbTsN
CisJLy8gWmVyby1pbml0aWFsaXplIHRoZSBlbnRpcmUgc3RydWN0dXJlIHRvIHByZXZlbnQgdW5p
bml0aWFsaXplZCBmaWVsZHMNCisgICAgbWVtc2V0KHAsIDAsIHNpemVvZigqcCkpOw0KKw0KIAlp
bnQgcmV0Ow0KIAl1NjQgbGFzdCwgbmV4dCwgcGFkLCB0b3RhbDsNCiAJdTggcmVwZWF0X2NvdW50
ID0gMDsNCg==
--00000000000016ae6c0621fbf9c6--

