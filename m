Return-Path: <linux-kernel+bounces-208769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2F9028F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4573528262D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BDA85626;
	Mon, 10 Jun 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4wk8vNzD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE31862C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046116; cv=none; b=furJN9Y7EF+TzztfiYG0mHQb2JavdeMguN4GPVWKwXC5wzOFsNLNfGxBdIJW7RL2c8elKfNZiDi4rT83UUTfB10GGjGqKwRltJw10LLj9oJXhkWQDsuKDMZtre8sY3C1BNcA6cwjM98JRD6gF3uCvi054hCIh7puVWftwQKvMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046116; c=relaxed/simple;
	bh=R3Jt6tO8R0eo6SEH5kUmqYEi3TCX4oM6uSHssG9IGUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfE4D5lCGeV4KnShBs9voisOyidUXF2KpMVvqPdGkgW6r12db1nvMf1YP8BGW0HadoFJhlaRcX7STbeTjzAZyIe3sF34zjQHiFCewzRYK7cAet1hdrFYh+OAcsrMIvPh6ebvfgrckMAvZnswsI/N9VWM5HxF3zcsb3Vw2dTcvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4wk8vNzD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a63359aaacaso35257566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718046113; x=1718650913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UHCkPwIMsb0VT2uipUlmlmb8ieguO9zcIjSFxcvYyo=;
        b=4wk8vNzDDcyItOKbTnKWmIHb8gbtqaur1J2TSfmRRh0cdua6WRq5DiDuPxO6CSyC3V
         zI+K4z7JNFFCZQES7Rhe6szSiPF9j8+Sm+JI6tL6dD55MsUkglVpxmdqoaEJlLvqX3LE
         tdBoNZ/sC+jGKiTlYDuEiidFXR3AEdDjr2Uj2h38ttJn/WsOUXoP5yTot7BrMUz0UlPx
         8fkGlu+wN96i70eNmQ4ZhPvbIQLaIZ8odxY8IT6FTKmnGnqXpWklHmZFldDG94YU7mvp
         LQcawR7z2mEbgsIu4z3+vkQSHQ9J/KT2cOmdUVvR9VwXZM7JNUvaVob4VWUz0h7BYAgn
         QPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718046113; x=1718650913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UHCkPwIMsb0VT2uipUlmlmb8ieguO9zcIjSFxcvYyo=;
        b=u0xPfgQKfUXka5SukK61WgS631P0xopS9x9KShL88XUX9aZ6aEsc9PnmPAbowQCaE9
         y01bxdXpAdfvPbtvFUobQDy2bD5D6LyPn6qmJJ37zI2MUTTH4iKfyovQsWaPKsCmxhzx
         QPkgTRZEpJXKh6onSi/7eCYc84wkhCQpYGWypMXFXVCjaSKcvQhH8WvPWAHxU2riHAlX
         FZ+zEXinyb+Xo+uvvGXhHuVP/RTls2s58La3L8HMvyudDbOFCW1qegChH8BnglUDjWag
         mfVPUVmuFvID7Z6MonafwzCW2ISxW92FplXcpTGmyxK4zbwk2lDv76G/hH4cRUO/o4LQ
         mGAA==
X-Forwarded-Encrypted: i=1; AJvYcCWhMi1S9yY40RacYryUKzf+ftNjAnR8NmpH71Lo2MyyV84DDUkvpzibNVdNZ522MpwK5fMh0zsuQ/Ez4C+1IG5URpfOQbBBrKChyvBi
X-Gm-Message-State: AOJu0YxnkxeUsikZTAu1uV/CjS1xr/xDTr+gsAOlPb7oV4d8eI8eCas6
	Fb9iZ7dolDTnxcINl7a3pf8saWbCy+fiU713xI7FAlBNtxNPb2H9OAV2+ZnkChkhuULLgazSu0b
	jtF57Y3dGPeGyg5iWKoEjZMC/TkvblsGoDHXbW/R0IXg+HzldJfRv
X-Google-Smtp-Source: AGHT+IFd5L5hIgAV6LuspYCVT5fWMIBJh+SUsm/uSV5DeRtg9tTXvTrElJwyf3PfdESujtw0I5PVonK+QvudETo7bKs=
X-Received: by 2002:a17:906:f8c8:b0:a6f:1ad7:6875 with SMTP id
 a640c23a62f3a-a6f1ad76903mr283294366b.69.1718046112462; Mon, 10 Jun 2024
 12:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d0f165061a6754c3@google.com>
In-Reply-To: <000000000000d0f165061a6754c3@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 12:01:14 -0700
Message-ID: <CAJD7tkaTQU1Kxt935fmq+_BJd-VT6vKFj58o7Aq+QhoyrOtCmw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KMSAN: uninit-value in zswap_store
To: syzbot <syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:09=E2=80=AFPM syzbot
<syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:=
/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D113f3fd698000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5d2cbf33633f=
507
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9c1fe13fcb51574=
b249b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/dis=
k-614da38e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinu=
x-614da38e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/b=
zImage-614da38e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com

This doesn't look like a zswap bug, and perhaps not a bug at all but I
am not sure. Zswap is reading the data in a folio to check if it is
filled with a repeated pattern, and it is encountering uninitialized
data. I am not sure if this is expected behavior or not.

Could it just be that the size of the data written by syzbot is not
divisible by PAGE_SIZE, so part of the final page is left
uninitialized? Do we keep the unwritten parts of a shmem page
uninitialized by any chance?

Hugh, do you mind taking a quick look at whether this is a real bug?

If this is expected behavior, perhaps there is some annotation we can
use in zswap that it is fine to encounter uninitialized data when
reading the folio.

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in zswap_is_page_same_filled mm/zswap.c:1481 [in=
line]
> BUG: KMSAN: uninit-value in zswap_store+0x1008/0x2ca0 mm/zswap.c:1553
>  zswap_is_page_same_filled mm/zswap.c:1481 [inline]
>  zswap_store+0x1008/0x2ca0 mm/zswap.c:1553
>  swap_writepage+0x126/0x4c0 mm/page_io.c:198
>  shmem_writepage+0x1826/0x1f70 mm/shmem.c:1518
>  pageout mm/vmscan.c:660 [inline]
>  shrink_folio_list+0x4a55/0x7910 mm/vmscan.c:1323
>  evict_folios+0x9d7f/0xcc20 mm/vmscan.c:4537
>  try_to_shrink_lruvec+0x160e/0x1a50 mm/vmscan.c:4733
>  shrink_one+0x66f/0xd40 mm/vmscan.c:4772
>  shrink_many mm/vmscan.c:4835 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4935 [inline]
>  shrink_node+0x4856/0x55f0 mm/vmscan.c:5894
>  kswapd_shrink_node mm/vmscan.c:6704 [inline]
>  balance_pgdat mm/vmscan.c:6895 [inline]
>  kswapd+0x1eba/0x4460 mm/vmscan.c:7164
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  memcpy_from_iter lib/iov_iter.c:73 [inline]
>  iterate_bvec include/linux/iov_iter.h:122 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>  __copy_from_iter lib/iov_iter.c:249 [inline]
>  copy_page_from_iter_atomic+0x12b7/0x2ae0 lib/iov_iter.c:481
>  generic_perform_write+0x4c1/0xc60 mm/filemap.c:3982
>  shmem_file_write_iter+0x2bd/0x2f0 mm/shmem.c:2920
>  do_iter_readv_writev+0x7e6/0x960
>  vfs_iter_write+0x459/0xd00 fs/read_write.c:895
>  lo_write_bvec drivers/block/loop.c:246 [inline]
>  lo_write_simple drivers/block/loop.c:267 [inline]
>  do_req_filebacked drivers/block/loop.c:491 [inline]
>  loop_handle_cmd drivers/block/loop.c:1907 [inline]
>  loop_process_work+0x1502/0x3440 drivers/block/loop.c:1942
>  loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1973
>  process_one_work kernel/workqueue.c:3267 [inline]
>  process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
>  worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was created at:
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
>  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
>  alloc_pages mm/mempolicy.c:2335 [inline]
>  folio_alloc+0x1d0/0x230 mm/mempolicy.c:2342
>  filemap_alloc_folio+0xa6/0x440 mm/filemap.c:984
>  __filemap_get_folio+0xa10/0x14b0 mm/filemap.c:1926
>  grow_dev_folio fs/buffer.c:1042 [inline]
>  grow_buffers fs/buffer.c:1108 [inline]
>  __getblk_slow fs/buffer.c:1134 [inline]
>  bdev_getblk+0x39b/0xc80 fs/buffer.c:1429
>  __getblk include/linux/buffer_head.h:355 [inline]
>  sb_getblk include/linux/buffer_head.h:361 [inline]
>  ext4_getblk+0x3da/0xe00 fs/ext4/inode.c:843
>  ext4_xattr_inode_write fs/ext4/xattr.c:1421 [inline]
>  ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1596 [inline]
>  ext4_xattr_set_entry+0x574d/0x6880 fs/ext4/xattr.c:1718
>  ext4_xattr_block_set+0xb94/0x4fb0 fs/ext4/xattr.c:2037
>  ext4_xattr_move_to_block fs/ext4/xattr.c:2654 [inline]
>  ext4_xattr_make_inode_space fs/ext4/xattr.c:2729 [inline]
>  ext4_expand_extra_isize_ea+0x20bd/0x3560 fs/ext4/xattr.c:2821
>  __ext4_expand_extra_isize+0x5dc/0x680 fs/ext4/inode.c:5789
>  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
>  __ext4_mark_inode_dirty+0x70d/0xa10 fs/ext4/inode.c:5910
>  ext4_delete_inline_entry+0x650/0x7d0 fs/ext4/inline.c:1753
>  ext4_delete_entry+0x13f/0x7d0 fs/ext4/namei.c:2719
>  __ext4_unlink+0x9b8/0x11b0 fs/ext4/namei.c:3273
>  ext4_unlink+0x226/0x630 fs/ext4/namei.c:3321
>  vfs_unlink+0x676/0xa30 fs/namei.c:4343
>  do_unlinkat+0x823/0xe10 fs/namei.c:4407
>  __do_sys_unlinkat fs/namei.c:4450 [inline]
>  __se_sys_unlinkat fs/namei.c:4443 [inline]
>  __x64_sys_unlinkat+0x17c/0x230 fs/namei.c:4443
>  x64_sys_call+0x846/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2=
64
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 1 PID: 88 Comm: kswapd1 Not tainted 6.9.0-syzkaller-02707-g614da38e2=
f7a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/02/2024
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

