Return-Path: <linux-kernel+bounces-307744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7177F965257
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54E31F25090
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7381BAEE2;
	Thu, 29 Aug 2024 21:50:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896F1BA860
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968227; cv=none; b=Han0AhIaMG2FFt9/F1HJx5alFDM6RJSHxtwQAQL4TQ6A3Pb5TISZjZeP5YsKHYcbSXoSKigVHcOh8BHaeqzTGMxzC1ggPMraqsG7jQjbbxn5PXQhUDvq3rQgOpCXZxyAavYMfXgi8XH+6uIHpepFGY158sFnAapbzLcpdv6Hyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968227; c=relaxed/simple;
	bh=D71/8YhIYykgRRLrGUL5OqJn579RJY18Dj+3EIRoz3g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f6zlTkln0eTza1rBKA2h3dh/k8yEAn/9P+fw4l/6GvxFst3inUrKLXxm1m+bwFliMDbJJeDhd/Nx0NMGOeWnvYL1go9WykFogD5YX4fgRd7Vo6Dc5AK+5gW3edPjCNuah+jduWr5gccIiVfBMbDx/sWZ7C8/7uUiAX3RSq0jvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a246af0aaso35907739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968223; x=1725573023;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qswwExplEZg5MplKCrqtU1zfBevl1xiCA/odAG0HRnY=;
        b=GevsyvkGTx+UOvIQ45JPZK3lb21LmHpXSa9mRnsGtAp/cgV4/FkweZ+9zV2fJRPfrj
         4qegoT176uUJYoI950liiXePlDRod2dZW4zP8026j9p/GVlWONaGK2u8srColD3Js1tv
         718M0OzvQocpWFOcFbXD8esSbv3SwUKA5IZP1NWo2XPUSsvBBwTMqO7lysJsjA/N73vl
         MtmeKcPDlzyFVsPqoK06FRWDfkIdOBidPbkXeNDFL/RNGn1uehBy4Jrv2ZOZW5w10zYf
         Y4BpvSI0PVBRB82xCcUdvB9+SlNZFd1Ax7RLrqK+F1moo06lPL+7qz3xeoE4OCP2bNPu
         Somw==
X-Forwarded-Encrypted: i=1; AJvYcCUcqXG18ZieRFR7O8E8Csnjq0T4lXa7l41u4rgkj0pfbeKz66eNliTXOkIL+b3Vx4ywDNVjRj16wKK5zhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtExqkpgwvLt8lFN9/LugIBq+a3CRIzn1jHFuTua+RMbrBlgVg
	kXf5O97rNnJHs/i5m26r3ffBdX/Hr5TnSK0vDATxLftm6+Iv6d85LU1hHB4DFFCug/zpCpCNJpA
	vugi26hIyRnI8mlADRNy7T0l2vg5lrqiIsV1qPL2WCSqFt7nK9Sljnt8=
X-Google-Smtp-Source: AGHT+IHdl4a0XrtF4G/HcXsFzyGe7XcP0ZqF3ESdwtIW7/b6hPy/ka6bqDMCHsNaGiM8cmk+DnKTkmfOQlmJWm+6biD+nKC56MKu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160e:b0:81f:861c:9d83 with SMTP id
 ca18e2360f4ac-82a2624763emr1292039f.1.1724968223240; Thu, 29 Aug 2024
 14:50:23 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:50:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000320db40620d976af@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in lzo1x_1_do_compress (3)
From: syzbot <syzbot+02341e0daa42a15ce130@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5be63fc19fca Linux 6.11-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d06825980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=522060455c43d52e
dashboard link: https://syzkaller.appspot.com/bug?extid=02341e0daa42a15ce130
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b3d7926efea/disk-5be63fc1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e5cbee87f73/vmlinux-5be63fc1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa58f9a69ae7/bzImage-5be63fc1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02341e0daa42a15ce130@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in lzo1x_1_do_compress+0x19f9/0x2510 lib/lzo/lzo1x_compress.c:178
 lzo1x_1_do_compress+0x19f9/0x2510 lib/lzo/lzo1x_compress.c:178
 lzogeneric1x_1_compress+0x26a/0x11b0 lib/lzo/lzo1x_compress.c:333
 lzo1x_1_compress+0x47/0x80 lib/lzo/lzo1x_compress.c:383
 __lzo_compress crypto/lzo.c:58 [inline]
 lzo_scompress+0x98/0x180 crypto/lzo.c:79
 scomp_acomp_comp_decomp+0x7c6/0xb90
 scomp_acomp_compress+0x32/0x40 crypto/scompress.c:187
 crypto_acomp_compress include/crypto/acompress.h:251 [inline]
 zswap_compress+0x368/0xad0 mm/zswap.c:927
 zswap_store+0x1af3/0x2dd0 mm/zswap.c:1459
 swap_writepage+0x11f/0x470 mm/page_io.c:198
 shmem_writepage+0x1a75/0x1f70 mm/shmem.c:1536
 pageout mm/vmscan.c:680 [inline]
 shrink_folio_list+0x577f/0x7cb0 mm/vmscan.c:1360
 evict_folios+0x9bce/0xbc80 mm/vmscan.c:4580
 try_to_shrink_lruvec+0x13a3/0x1750 mm/vmscan.c:4775
 shrink_one+0x646/0xd20 mm/vmscan.c:4813
 shrink_many mm/vmscan.c:4876 [inline]
 lru_gen_shrink_node mm/vmscan.c:4954 [inline]
 shrink_node+0x451a/0x50f0 mm/vmscan.c:5934
 kswapd_shrink_node mm/vmscan.c:6762 [inline]
 balance_pgdat mm/vmscan.c:6954 [inline]
 kswapd+0x257e/0x4290 mm/vmscan.c:7223
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

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
 worker_thread+0xea7/0x14d0 kernel/workqueue.c:3389
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 copy_to_dinode+0x881/0xb30 fs/jfs/jfs_imap.c:3158
 diWrite+0x1bf5/0x1f00 fs/jfs/jfs_imap.c:790
 txCommit+0xdb8/0x8cd0 fs/jfs/jfs_txnmgr.c:1255
 __jfs_xattr_set+0x1b7/0x1f0 fs/jfs/xattr.c:936
 jfs_xattr_set+0x79/0x90 fs/jfs/xattr.c:958
 __vfs_setxattr+0x844/0x8b0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x22f/0xb00 fs/xattr.c:234
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:295
 vfs_setxattr+0x294/0x650 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 __do_sys_fsetxattr fs/xattr.c:710 [inline]
 __se_sys_fsetxattr+0x7f0/0x980 fs/xattr.c:686
 __x64_sys_fsetxattr+0xe4/0x150 fs/xattr.c:686
 x64_sys_call+0x19c3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:191
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 ea_put fs/jfs/xattr.c:639 [inline]
 __jfs_setxattr+0x185f/0x1ae0 fs/jfs/xattr.c:785
 __jfs_xattr_set+0xe6/0x1f0 fs/jfs/xattr.c:934
 jfs_xattr_set+0x79/0x90 fs/jfs/xattr.c:958
 __vfs_setxattr+0x844/0x8b0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x22f/0xb00 fs/xattr.c:234
 __vfs_setxattr_locked+0x441/0x480 fs/xattr.c:295
 vfs_setxattr+0x294/0x650 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 __do_sys_fsetxattr fs/xattr.c:710 [inline]
 __se_sys_fsetxattr+0x7f0/0x980 fs/xattr.c:686
 __x64_sys_fsetxattr+0xe4/0x150 fs/xattr.c:686
 x64_sys_call+0x19c3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:191
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable ea_buf created at:
 __jfs_setxattr+0x5d/0x1ae0 fs/jfs/xattr.c:662
 __jfs_xattr_set+0xe6/0x1f0 fs/jfs/xattr.c:934

CPU: 0 UID: 0 PID: 81 Comm: kswapd0 Tainted: G        W          6.11.0-rc5-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

