Return-Path: <linux-kernel+bounces-327661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0299778F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B691F262F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2CB1AD26C;
	Fri, 13 Sep 2024 06:51:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F614143C40
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210265; cv=none; b=Tp7+AuOic59ObK3MnKXBH44MeXldA+iNxpKSERhohIuktA9qYvtk0xx4+M/KhQ/tOLs1wlQEx4006CXIvGv+niqnAMFZXclgR3hOpYSyG0xjacHPY9CwnlhMaViKKr8L7AOvPK0xGq1GyyPBPZLYwEDZG2LUhKe70ahz5GxmPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210265; c=relaxed/simple;
	bh=I5gUSU8A43j4EMtPZSVzdAO9LnLE3sgQrm4sCQRWQcU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qS5ZUCsDbkooLZGeUBfL3VedafJUxo9GJGKk5juEn/7QaTf894Y33LOG10US8pYM/QoNv+hCn9pfl92xUI9CdFVDVktoPMgismcsAh+sf+nEwLcpCsNud6pgX05c3NTtCXTHk0+dBMqKjkJgYyrVqE8j0yT/+CqzejsWXPvdhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f510b3f81so33935135ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726210262; x=1726815062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkc96E3dG3MYjX0uC5Kc7FpNYHue9DlbLBx98kDPhKs=;
        b=VSSrJ3n65QdjTm7+ZLkKGk8lozLVTlecTlTay7P21E2ODpBoevk5cbdNVncv5G6djT
         amDGxo+QJ6A/Qp6OQFEkWgH0j0YCMGmbQIcA2DKlKCMc49VB0s9NrJpPmbNpwM17Smzk
         6wuM91O+G0IimXh5Ixh1yHFeqqcSaxtZ1Q2R4ihjFvEPWO4orY243HFHHN6wpQkMdMh8
         lvqYmOFHJ4RJ0RflVVZzeQ6HgCDn2kzSa9zxyLG5s7IByz4PVDzwSQx5aIfFdnB0IJtY
         Vg9ymV2yDd8lWKjkwUgfuUWEUWD4z3SS2UxDmTxfpWz9ZGfQalzw8XmpW/9XsDBiWhMw
         h5KA==
X-Forwarded-Encrypted: i=1; AJvYcCXx9lX9NXtG2bus9o6AV2gVMhlLXOWFYELrhRXHDC9/bigoid8ckezc7nTdYNvHqyX5IYEATlcw4AtGmrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpoM9tDrLmkaaKYVKGhDdaecD3dmdS0s+STcCoYk5Ap/Rler3j
	5djQ2KZ26qDMnYtF4I6tUgby/aMp6bzDL3pNqErkb6KIeWbmJQhCTp261duyOoKAWn7f7iigsJA
	ZlO9CyWbn8+avrEhal6y4xV1tfBSvVzgwopdDYJkSZImbpXGkh5J8e5I=
X-Google-Smtp-Source: AGHT+IFFlsIjX5atkSyL0cpdtKMOpx5T4OVv256ODsZFsDLjupgDrQsiEqkWs+fyFKzE4TeZJ0LUs0BE59WSLbgc08pOKIs5GuKd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3603:b0:39f:6f6c:90ba with SMTP id
 e9e14a558f8ab-3a08461c414mr34107645ab.6.1726210262403; Thu, 12 Sep 2024
 23:51:02 -0700 (PDT)
Date: Thu, 12 Sep 2024 23:51:02 -0700
In-Reply-To: <CACb6ct1VapivgTKjsoUnq06UKvNUVwaL_CS750phHNwpPynQog@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f9cab0621faa59b@google.com>
Subject: Re: [syzbot] [crypto?] [ntfs3?] KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: ksjoe30@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in sw842_compress

=====================================================
BUG: KMSAN: uninit-value in check_template lib/842/842_compress.c:393 [inline]
BUG: KMSAN: uninit-value in process_next lib/842/842_compress.c:458 [inline]
BUG: KMSAN: uninit-value in sw842_compress+0x1744/0x5a70 lib/842/842_compress.c:545
 check_template lib/842/842_compress.c:393 [inline]
 process_next lib/842/842_compress.c:458 [inline]
 sw842_compress+0x1744/0x5a70 lib/842/842_compress.c:545
 crypto842_scompress+0x4f/0x70 crypto/842.c:78
 scomp_acomp_comp_decomp+0x7c6/0xb90
 scomp_acomp_compress+0x32/0x40 crypto/scompress.c:187
 crypto_acomp_compress include/crypto/acompress.h:251 [inline]
 zswap_compress+0x368/0xad0 mm/zswap.c:927
 zswap_store+0x1af3/0x2dd0 mm/zswap.c:1459
 swap_writepage+0x11f/0x470 mm/page_io.c:198
 shmem_writepage+0x1a75/0x1f70 mm/shmem.c:1536
 pageout mm/vmscan.c:680 [inline]
 shrink_folio_list+0x577f/0x7cb0 mm/vmscan.c:1360
 evict_folios+0x9a49/0xbb30 mm/vmscan.c:4560
 try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4755
 lru_gen_shrink_lruvec mm/vmscan.c:4897 [inline]
 shrink_lruvec+0x4a3/0x46c0 mm/vmscan.c:5652
 shrink_node_memcgs mm/vmscan.c:5888 [inline]
 shrink_node+0x104e/0x50f0 mm/vmscan.c:5928
 shrink_zones mm/vmscan.c:6172 [inline]
 do_try_to_free_pages+0x820/0x2550 mm/vmscan.c:6234
 try_to_free_mem_cgroup_pages+0x3f7/0xae0 mm/vmscan.c:6566
 try_charge_memcg+0x72c/0x1830 mm/memcontrol.c:2210
 try_charge mm/memcontrol-v1.h:20 [inline]
 charge_memcg mm/memcontrol.c:4438 [inline]
 __mem_cgroup_charge+0x11d/0x3f0 mm/memcontrol.c:4453
 mem_cgroup_charge include/linux/memcontrol.h:672 [inline]
 shmem_alloc_and_add_folio+0xe83/0x1ca0 mm/shmem.c:1792
 shmem_get_folio_gfp+0x10bd/0x24c0 mm/shmem.c:2188
 shmem_read_folio_gfp+0x80/0x140 mm/shmem.c:5201
 drm_gem_get_pages+0x3cf/0x1440 drivers/gpu/drm/drm_gem.c:568
 drm_gem_shmem_get_pages drivers/gpu/drm/drm_gem_shmem_helper.c:177 [inline]
 drm_gem_shmem_vmap+0x2dc/0xca0 drivers/gpu/drm/drm_gem_shmem_helper.c:337
 drm_gem_shmem_object_vmap+0x35/0x40 include/drm/drm_gem_shmem_helper.h:229
 drm_gem_vmap drivers/gpu/drm/drm_gem.c:1205 [inline]
 drm_gem_vmap_unlocked+0xc6/0x200 drivers/gpu/drm/drm_gem.c:1247
 drm_gem_fb_vmap+0x11b/0x590 drivers/gpu/drm/drm_gem_framebuffer_helper.c:365
 vkms_prepare_fb+0x12f/0x170 drivers/gpu/drm/vkms/vkms_plane.c:176
 drm_atomic_helper_prepare_planes+0x436/0x10b0 drivers/gpu/drm/drm_atomic_helper.c:2601
 drm_atomic_helper_commit+0x1f3/0xe80 drivers/gpu/drm/drm_atomic_helper.c:2029
 drm_atomic_commit+0x30a/0x380 drivers/gpu/drm/drm_atomic.c:1522
 drm_atomic_helper_update_plane+0x42b/0x600 drivers/gpu/drm/drm_atomic_helper.c:3190
 __setplane_atomic+0x33d/0x3f0 drivers/gpu/drm/drm_plane.c:1074
 drm_mode_cursor_universal drivers/gpu/drm/drm_plane.c:1229 [inline]
 drm_mode_cursor_common+0x171a/0x1e80 drivers/gpu/drm/drm_plane.c:1288
 drm_mode_cursor_ioctl+0x97/0xd0 drivers/gpu/drm/drm_plane.c:1338
 drm_ioctl_kernel+0x4ea/0x560 drivers/gpu/drm/drm_ioctl.c:745
 drm_ioctl+0xd13/0x15a0 drivers/gpu/drm/drm_ioctl.c:842
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:893
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
 x64_sys_call+0x18bf/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

<Zero or more stacks not recorded to save memory>

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 copy_page_from_iter_atomic+0x12bb/0x2ae0 lib/iov_iter.c:481
 copy_folio_from_iter_atomic include/linux/uio.h:186 [inline]
 generic_perform_write+0x896/0x12e0 mm/filemap.c:4032
 shmem_file_write_iter+0x2bd/0x2f0 mm/shmem.c:3074
 do_iter_readv_writev+0x8a1/0xa40
 vfs_iter_write+0x459/0xd50 fs/read_write.c:895
 lo_write_bvec drivers/block/loop.c:243 [inline]
 lo_write_simple drivers/block/loop.c:264 [inline]
 do_req_filebacked drivers/block/loop.c:511 [inline]
 loop_handle_cmd drivers/block/loop.c:1910 [inline]
 loop_process_work+0x15ec/0x3750 drivers/block/loop.c:1945
 loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450
 indx_write fs/ntfs3/index.c:1027 [inline]
 indx_update_dup+0xd81/0xf80 fs/ntfs3/index.c:2694
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
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
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
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450
 indx_write fs/ntfs3/index.c:1027 [inline]
 indx_update_dup+0xd81/0xf80 fs/ntfs3/index.c:2694
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
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
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
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 ntfs_write_bh+0x652/0xdb0 fs/ntfs3/fsntfs.c:1450
 indx_write fs/ntfs3/index.c:1027 [inline]
 indx_insert_into_buffer+0xd8f/0x2010 fs/ntfs3/index.c:1811
 indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1988
 ni_add_name+0xe5d/0x10d0 fs/ntfs3/frecord.c:3123
 ntfs_link_inode+0x265/0x310 fs/ntfs3/inode.c:1768
 ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146
 vfs_link+0x93d/0xb70 fs/namei.c:4692
 do_linkat+0x4f5/0xfd0 fs/namei.c:4762
 __do_sys_link fs/namei.c:4796 [inline]
 __se_sys_link fs/namei.c:4794 [inline]
 __x64_sys_link+0xe8/0x140 fs/namei.c:4794
 x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:87
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 hdr_insert_de fs/ntfs3/index.c:838 [inline]
 indx_insert_into_buffer+0xcdf/0x2010 fs/ntfs3/index.c:1807
 indx_insert_entry+0xa3c/0xee0 fs/ntfs3/index.c:1988
 ni_add_name+0xe5d/0x10d0 fs/ntfs3/frecord.c:3123
 ntfs_link_inode+0x265/0x310 fs/ntfs3/inode.c:1768
 ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146
 vfs_link+0x93d/0xb70 fs/namei.c:4692
 do_linkat+0x4f5/0xfd0 fs/namei.c:4762
 __do_sys_link fs/namei.c:4796 [inline]
 __se_sys_link fs/namei.c:4794 [inline]
 __x64_sys_link+0xe8/0x140 fs/namei.c:4794
 x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:87
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3998 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 kmem_cache_alloc_noprof+0x637/0xb20 mm/slub.c:4048
 ntfs_link_inode+0x8f/0x310 fs/ntfs3/inode.c:1756
 ntfs_link+0x21d/0x500 fs/ntfs3/namei.c:146
 vfs_link+0x93d/0xb70 fs/namei.c:4692
 do_linkat+0x4f5/0xfd0 fs/namei.c:4762
 __do_sys_link fs/namei.c:4796 [inline]
 __se_sys_link fs/namei.c:4794 [inline]
 __x64_sys_link+0xe8/0x140 fs/namei.c:4794
 x64_sys_call+0x2853/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:87
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5939 Comm: syz.0.15 Not tainted 6.11.0-rc7-syzkaller-g196145c606d0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


Tested on:

commit:         196145c6 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159027c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea008021530b2de3
dashboard link: https://syzkaller.appspot.com/bug?extid=17cae3c0a5b0acdc327d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1453949f980000


