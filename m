Return-Path: <linux-kernel+bounces-540916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B73A4B666
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD71188F636
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC018A6CF;
	Mon,  3 Mar 2025 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktk7eJBB"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD2155A4E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740971630; cv=none; b=IOTfzHJGSLvgrk2QfCB71Fd78KmHJC6Cl0QJJ6QhX7kJvRWqPK1rQY7nVsiw61au4PGIZLG3xgnFE4qpuN270QyKXtKdEyNHyO/yPG31OyqjxF3Wg6YTsIssg0SO9aCNiE/o7piLlVzvjp5v2J8bluauqs/yNq7UtRzrHyESOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740971630; c=relaxed/simple;
	bh=dh+zvDo+UpHRFL8aNAFar08sWbyPZoOHGP/ADoUTqoM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GzxOZ5BFKTzsgPsAbss21/bP0xbkg61vCmzUc+VnxpQ8NCWo5iuIJ6o3TKc9H63Ikj6Y47qIvu776qlCtIYxLrTEWcGkuQKnDXWwNBSdmVhwhJMMPrpS6ydEk1WYKgVfudco16LJ9uyMN0EUVUwStgonSWFF7WdeKqhaKZgdOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktk7eJBB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2bcdf5ea8faso2160952fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 19:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740971628; x=1741576428; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gmBzVLQpIbiF2/DaQb/qslxPK9RqAOBu64Pk7zoDCaI=;
        b=Ktk7eJBB47YzzWawlEjanox0JGJhCMwKeYOhhUtOnw3CqqKVl83Yuv0+dCYukgVY2Y
         INThvuUqFxGJH4LbDiFS815JN0bVkgyVr6zKs20P1UQ9Rb6HfX7/TA+U6ZQOEVEN2/I7
         0l6MFmDDPjsdXfL3TR5ih9yCE+ZMNkBqV1oAxJDUnQBF5NtJDIpR4nhpPqR0Cj5UueS3
         QoNzGKuc1PLVSBrz4+buqFQNdXSH+aRmrmBXsiFhqeldEue4UG51FYNjxhZwH5dOiA4A
         k9jFPj4JM/vlAbhKYUWiFM7GOK+VOcxqM+taHIZCH9fteMwrQPhxzVXftpba2Sqseu4h
         Y9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740971628; x=1741576428;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmBzVLQpIbiF2/DaQb/qslxPK9RqAOBu64Pk7zoDCaI=;
        b=wfOJFz8Iz40+iK1jz7FL0YqXb5umKtXCRF7ZdviGO+8maqnuHhv/v9Enl70Lx1Oyk4
         yLtoY6UAjL4C1pOsFWddCxyMdEyo2QZfwgF2By4N63NaKe9VdYD9GQPggO7bx84KFCrf
         07+Usx0O34EtZuPsiI7r7csc4HNUxdIBzTxtI3Bi6/mEmky4VtgP4J9cwxiW+I2Te4dE
         T8ETnCEkdP2UsAyOLN465wQGrShBesKF9s0MIUfc1SasMsHDni1T3J+4eoa+YosBjzkp
         RgWeGr6oz9pT+SCQI41lxQHrs7Hl7EMAaHg/jUh0U9gODYNegjF72E+Z7Sb5nV4KFrsc
         rGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7+Z7y+rhP7Do9A2oeFRecmddLqUYWCmnkSklgcIjQLLpFqBsyDxovaAl7TSssiifExAxFaGenrinouEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDein8Mwa2T2mlE2ZDC/SdLrZnb55Oqf6WWXAl0SN1ZkdnuHj
	Z31xB04VZb8YYlZmXB/P+se0r8MEBJuBiPHTm7oHc0JHa+puGrjFoJ5v+ayBLAWX5un7Ng7/1bl
	vbKyHc06jMeK0PjfilssGvg4u9p4=
X-Gm-Gg: ASbGnctN46TkbAxHdGr1kHbWQDcV8mNTigc+tLUaFiPZTq3xqxsdgq9oeE+dI0sNV50
	aIqMD8UQKxNfqFZ902WpgusoyYWq5WXzaqfHUELR/lzrgAWusFcwSMqfVMDUA+2oHmHPNN0ePLt
	8r7sm2TqHBzy1NZKDjG2LQipjsMQ==
X-Google-Smtp-Source: AGHT+IHF5JKbcSsLaGHljYDDj/qLKBX+f2vL9cCO+7cmNiI28pLNWgSIRuZV1rERv1oGZkt3YlLbAhmmshwYC0KkQIA=
X-Received: by 2002:a05:6870:71cb:b0:29e:4985:fef with SMTP id
 586e51a60fabf-2c178317c4cmr5148994fac.3.1740971628011; Sun, 02 Mar 2025
 19:13:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Mon, 3 Mar 2025 11:13:36 +0800
X-Gm-Features: AQ5f1JqqijLs3bFWtevlXsuIBeA-xBAFw1elRj2Ktw5Lr2gMzu5MaeUY7OslC7k
Message-ID: <CA+HokZq7F42iyusA4QYJA4N=q5SMVqvW0MnhejwDxagKhKFm_g@mail.gmail.com>
Subject: =?UTF-8?B?S0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgUmVhZCBpbiBnZnMyX2Rpc2NhcmQg77yIIA==?=
	=?UTF-8?B?djYuMTQtcmM0IGtlcm5lbO+8iQ==?=
To: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ve encountered a KASAN-reported slab-use-after-free in the GFS2
filesystem on Linux 6.14.0-rc4 during an unmount operation. Here are
the details:

Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.conf=
ig
Kernel Log=EF=BC=9A https://github.com/Strforexc/LinuxKernelbug/blob/main/s=
lab_uaf_read_gfs2_dis/log0
Reproduce.c:  https://github.com/Strforexc/LinuxKernelbug/blob/main/slab_ua=
f_read_gfs2_dis/repro.cprog

KASAN detects a use-after-free read of size 8 at address
ffff88802233e168 in list_empty (include/linux/list.h:373), called from
gfs2_discard (fs/gfs2/aops.c:587). This occurs when discarding a
buffer during filesystem shutdown.
Location: The fault occurs in gfs2_discard at if
(!list_empty(&bd->bd_list) && !buffer_pinned(bh)), accessing
bd->bd_list.next after bd is freed.

Cause: A struct gfs2_bufdata (bd) is freed in gfs2_log_flush during
gfs2_quota_sync, but its buffer_head (bh->b_private) retains the
pointer. Later, gfs2_discard dereferences it during inode eviction in
gfs2_put_super.
Context: Syzkaller=E2=80=99s unmount operation triggers this sequence,
exposing a lifecycle mismatch between buffer data and inode pages.


Could GFS2 maintainers investigate? Possible issues:
1. bh->b_private not cleared after freeing bd in gfs2_log_flush.
2. Race between gfs2_quota_sync freeing buffers and gfs2_put_super
discarding them.

Our knowledge of the kernel is somewhat limited, and we'd appreciate
it if you could determine if there is such an issue. If this issue
doesn't have an impact, please ignore it =E2=98=BA.

If you fix this issue, please add the following tag to the commit:
Reported-by: Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou
Zhao xnxc22xnxc22@qq.com, Haoran Liu <cherest_san@163.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inl=
ine]
BUG: KASAN: slab-use-after-free in gfs2_discard+0x2ed/0x360 fs/gfs2/aops.c:=
587
Read of size 8 at addr ffff88802233e168 by task syz-executor/13663

CPU: 0 UID: 0 PID: 13663 Comm: syz-executor Not tainted 6.14.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description.constprop.0+0x2c/0x420 mm/kasan/report.c:408
 print_report+0xaa/0x270 mm/kasan/report.c:521
 kasan_report+0xbd/0x100 mm/kasan/report.c:634
 list_empty include/linux/list.h:373 [inline]
 gfs2_discard+0x2ed/0x360 fs/gfs2/aops.c:587
 gfs2_invalidate_folio+0x210/0x490 fs/gfs2/aops.c:625
 folio_invalidate mm/truncate.c:126 [inline]
 truncate_cleanup_folio+0x2ea/0x480 mm/truncate.c:146
 truncate_inode_pages_range+0x214/0xe20 mm/truncate.c:326
 gfs2_evict_inode+0x32b/0xcb0 fs/gfs2/super.c:1527
 evict+0x3f2/0x940 fs/inode.c:796
 iput_final+0x32e/0x4b0 fs/inode.c:1946
 iput+0x185/0x1c0 fs/inode.c:1972
 gfs2_put_super+0x2b5/0x750 fs/gfs2/super.c:629
 generic_shutdown_super+0x156/0x390 fs/super.c:642
 kill_block_super+0x3b/0x90 fs/super.c:1710
 gfs2_kill_sb+0x380/0x430 fs/gfs2/ops_fstype.c:1793
 deactivate_locked_super+0xbb/0x140 fs/super.c:473
 deactivate_super+0xb1/0xd0 fs/super.c:506
 cleanup_mnt+0x2df/0x430 fs/namespace.c:1413
 task_work_run+0x16c/0x270 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xd8/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01c47b9fcb
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa 31 f6
e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 a8 ff ff ff f7 d8
RSP: 002b:00007ffd1d416d58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000043 RCX: 00007f01c47b9fcb
RDX: 00007f01c465ab30 RSI: 0000000000000009 RDI: 00007ffd1d416e10
RBP: 00007ffd1d416e10 R08: 0000000000000000 R09: 00007ffd1d416be0
R10: 000055555f553673 R11: 0000000000000246 R12: 00007f01c486a47d
R13: 00007ffd1d417ee0 R14: 000055555f553600 R15: 00000000000260b1
 </TASK>

Allocated by task 13663:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x40 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x97/0xa0 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x167/0x400 mm/slub.c:4171
 gfs2_alloc_bufdata fs/gfs2/trans.c:168 [inline]
 gfs2_trans_add_data+0x4bf/0x800 fs/gfs2/trans.c:209
 gfs2_unstuffer_folio+0x1d5/0x930 fs/gfs2/bmap.c:81
 __gfs2_unstuff_inode+0x392/0x750 fs/gfs2/bmap.c:119
 gfs2_unstuff_dinode+0xb5/0x1b0 fs/gfs2/bmap.c:166
 gfs2_adjust_quota+0x10c/0xc00 fs/gfs2/quota.c:847
 do_sync+0xb17/0xe90 fs/gfs2/quota.c:961
 gfs2_quota_sync+0x31f/0x540 fs/gfs2/quota.c:1357
 gfs2_sync_fs+0x44/0xc0 fs/gfs2/super.c:670
 sync_filesystem+0x116/0x2a0 fs/sync.c:56
 generic_shutdown_super+0x74/0x390 fs/super.c:621
 kill_block_super+0x3b/0x90 fs/super.c:1710
 gfs2_kill_sb+0x380/0x430 fs/gfs2/ops_fstype.c:1793
 deactivate_locked_super+0xbb/0x140 fs/super.c:473
 deactivate_super+0xb1/0xd0 fs/super.c:506
 cleanup_mnt+0x2df/0x430 fs/namespace.c:1413
 task_work_run+0x16c/0x270 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xd8/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 13663:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x40 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x80 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x54/0x80 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x134/0x400 mm/slub.c:4711
 trans_drain fs/gfs2/log.c:1020 [inline]
 gfs2_log_flush+0x1647/0x2990 fs/gfs2/log.c:1160
 do_sync+0x5cc/0xe90 fs/gfs2/quota.c:981
 gfs2_quota_sync+0x31f/0x540 fs/gfs2/quota.c:1357
 gfs2_sync_fs+0x44/0xc0 fs/gfs2/super.c:670
 sync_filesystem+0x116/0x2a0 fs/sync.c:56
 generic_shutdown_super+0x74/0x390 fs/super.c:621
 kill_block_super+0x3b/0x90 fs/super.c:1710
 gfs2_kill_sb+0x380/0x430 fs/gfs2/ops_fstype.c:1793
 deactivate_locked_super+0xbb/0x140 fs/super.c:473
 deactivate_super+0xb1/0xd0 fs/super.c:506
 cleanup_mnt+0x2df/0x430 fs/namespace.c:1413
 task_work_run+0x16c/0x270 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xd8/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802233e150
 which belongs to the cache gfs2_bufdata of size 80
The buggy address is located 24 bytes inside of
 freed 80-byte region [ffff88802233e150, ffff88802233e1a0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2233e
flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff8880433c7b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 13663,
tgid 13663 (syz-executor), ts 156080436640, free_ts 156046629654
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1a3/0x1d0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x8a5/0xfa0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x1d8/0x3b0 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1f2/0x550 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x229/0x310 mm/slub.c:2587
 ___slab_alloc+0x7f3/0x12b0 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xc0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0x275/0x400 mm/slub.c:4171
 gfs2_alloc_bufdata fs/gfs2/trans.c:168 [inline]
 gfs2_trans_add_meta+0x863/0xce0 fs/gfs2/trans.c:251
 gfs2_alloc_extent fs/gfs2/rgrp.c:2237 [inline]
 gfs2_alloc_blocks+0x41b/0x1870 fs/gfs2/rgrp.c:2447
 __gfs2_unstuff_inode+0x33c/0x750 fs/gfs2/bmap.c:107
 gfs2_unstuff_dinode+0xb5/0x1b0 fs/gfs2/bmap.c:166
 gfs2_adjust_quota+0x10c/0xc00 fs/gfs2/quota.c:847
 do_sync+0xb17/0xe90 fs/gfs2/quota.c:961
 gfs2_quota_sync+0x31f/0x540 fs/gfs2/quota.c:1357
 gfs2_sync_fs+0x44/0xc0 fs/gfs2/super.c:670
page last free pid 13238 tgid 13238 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x71f/0xff0 mm/page_alloc.c:2660
 vfree+0x172/0x850 mm/vmalloc.c:3383
 delayed_vfree_work+0x57/0x70 mm/vmalloc.c:3303
 process_one_work+0x109d/0x18c0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x677/0xe90 kernel/workqueue.c:3398
 kthread+0x3b3/0x760 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88802233e000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
 ffff88802233e080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
>ffff88802233e100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
                                                          ^
 ffff88802233e180: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88802233e200: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Regards,
Zhizhuo Tang

