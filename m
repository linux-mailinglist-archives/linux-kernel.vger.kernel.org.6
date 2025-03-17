Return-Path: <linux-kernel+bounces-563309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F991A63D44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF616188C1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DD7214A9F;
	Mon, 17 Mar 2025 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDng+6NF"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794686FB0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182751; cv=none; b=CKRgiVN2mV//L7xiFVDzQJfqpVkF2yvBNHKeCzZ6ZzlpStRd0tBzjO6RDWPNQgqND4kVWBfS8LKen9SkMKBBr4UyEvHD+Dj0lvV/X9wmJVPV6leyjHdtfHAdlbnegnpe0OAzC4cnIqNqgK/3N5mYoIUfkmvclCj8b00aHXX2Ozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182751; c=relaxed/simple;
	bh=omCatfOzL+qikK2zz7lXsbeub6aQZMse0TTrtyMDEhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RP4rmIjlw0U8CTOR8S94tIwjLRs1sxyjYycCBhZBSDXW/Rt0A2kw1+/x+iMObyK8eG1wJnPb7xjsyN+sUrNQ8EMKv7HCpAa/3W8KITXjdJZrr/b76YBHD37RIn7LrFO4DjBYPDkrOmGcKmwp/oaR2Al+mrUGOkN9ENPcDyAVjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDng+6NF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso2436513a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742182749; x=1742787549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxDX9NJenGf88Gn9xbMCoJkKrQcNQdFD/Whou5y0n+U=;
        b=jDng+6NFGS635JN7hd50d9TZtWMvWxTcnenujUTx8egyrbMUMMWO4Znand5XQPHr8L
         9u8f0Js3hIBkYkKQaiHZma7lOiNz7H5XpyW5VsOrfNL18ia4SKDnJHe5T8Z/eXUsIphm
         BCH3LmiEM79/N/521Cssd5NAFo+rwvVi+RrghxXKjYnRQEHMpaSpLDZKR+8J371eo3r7
         80lSpGlyCqYUynrGmzwEk58/v3Gy9lRZ+0N+pzvd9o4xa6b+1bN8dznOOF1ZtTd2OH9c
         XpCAWZUUMR9iTQZgdpjnr+8g7CPy2TlH69vcIyY7JuSPGnsQ/XXXIB3ZC9zBTRGZJYn4
         c3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742182749; x=1742787549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxDX9NJenGf88Gn9xbMCoJkKrQcNQdFD/Whou5y0n+U=;
        b=qd9dsTp05N1Rs5KicQ/LjwCPTmW0qvYILs0XzqzCfGIXszNmWRD98Mv0y6lDqUwwaX
         BbHyhB2n4VoBqNKZEUnEWVzvjymyiY+R7ORawbNjJ+vwJ3WB7ydtHQT4O7BGMhJrgq/w
         5aWmKZGNFL15Zr0WqYX6NE2PV1XLCRKexoDOgMIfCKPkOgOXQXKkO67nbWsUxlZLI8q5
         dvftoYF9ctuys89dtk+3yTHK42NWv5esHw8MpCALPtO9IShQMJ81C8q02AMQF1d3YZ1W
         lzh3PivmyCyI7rPgd1YkyZIPqnzPTMOodfCpNkd6HckcVnEEmzNpcX8KaD1Bc6mLZHDt
         LL/A==
X-Forwarded-Encrypted: i=1; AJvYcCUtw5S6dkJhI7M3t+kjF+n5nTsl9lWtvAJKHY07gDBD9fVfaj/lWePVvxjpXMNvqKWdcsBBmN5LrcXincI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8y2MFNAAn0ICu0aZf+NUYh73nJajBW5aHiikJmoUWY8nEW2j2
	BkuYrCkiq8j9RWdaHZ8d1gQRwo8kcbsOcBSRW58KONCWwlhMGXUs06P49NcKjEY/7bxFPglqwdJ
	QsUAvaw7fvRgxtm4/EHIBpVuXxyKJwciyasfExj0nVBaijM+cKIm19L4=
X-Gm-Gg: ASbGncunoAs2GppHldXQUzQUqPFxpxIcb/EOMdnFooWd10XPwfDCZk/2nBg1KG1Pf6a
	FfQHzmz4UAQcZzuJCJRVhRWZHTRYa5CIPDBPPzWU7tUVIDrm7/a/wwmDDFOh6Xf+JElT0H9zv4w
	rTpP2b73wv0qSpETFyViebSHCbhnZI
X-Google-Smtp-Source: AGHT+IFd2FWFzjwgjD0yJk6h7cK5z0EQrkvls36J7zeb0Mu2TWo2CJm/wwVMwD4Hqrky0GjuadbaOlxIr6g6DmSw/y8=
X-Received: by 2002:a17:90b:2645:b0:2ff:5357:1c7f with SMTP id
 98e67ed59e1d1-30151d5bdb1mr13394926a91.30.1742182748510; Sun, 16 Mar 2025
 20:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67d71fd3.050a0220.3657bb.0003.GAE@google.com>
In-Reply-To: <67d71fd3.050a0220.3657bb.0003.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Sun, 16 Mar 2025 23:38:55 -0400
X-Gm-Features: AQ5f1JrL7-kkTT35ZO4_P5Y0kOFyB6quoDhVQFXNxw7x5OvChTp2mkuFdYp2FOU
Message-ID: <CANp29Y4Oxcp=2YmrjQpXdYxrW6eKzjXfj65C=NE4bzfCJPVPoQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] upstream test error: KASAN:
 slab-use-after-free Write in binder_add_device (2)
To: syzbot <syzbot+35a5dd7a84685f5f9844@syzkaller.appspotmail.com>
Cc: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz invalid

On Sun, Mar 16, 2025 at 3:00=E2=80=AFPM syzbot
<syzbot+35a5dd7a84685f5f9844@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    29281a76709c Merge tag 'kvmarm-fixes-6.14-2' into kvmarm-=
m..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvma=
rm.git fuzzme
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1155cfa858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dab4d8c35f4d2e=
97
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D35a5dd7a84685f5=
f9844
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: arm64
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/3=
84ffdcca292/non_bootable_disk-29281a76.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1ca228f9e75/vmlinu=
x-29281a76.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/22c8671002d3/I=
mage-29281a76.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+35a5dd7a84685f5f9844@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:10=
26 [inline]
> BUG: KASAN: slab-use-after-free in binder_add_device+0x54/0x8c drivers/an=
droid/binder.c:6932
> Write of size 8 at addr 81f00000124ffa08 by task syz-executor/3323
> Pointer tag: [81], memory tag: [84]
>
> CPU: 0 UID: 0 PID: 3323 Comm: syz-executor Not tainted 6.14.0-rc2-syzkall=
er-g29281a76709c #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x1b4/0x500 mm/kasan/report.c:489
>  kasan_report+0xd8/0x138 mm/kasan/report.c:602
>  kasan_tag_mismatch+0x28/0x3c mm/kasan/sw_tags.c:175
>  __hwasan_tag_mismatch+0x30/0x60 arch/arm64/lib/kasan_sw_tags.S:55
>  hlist_add_head include/linux/list.h:1026 [inline]
>  binder_add_device+0x54/0x8c drivers/android/binder.c:6932
>  binderfs_binder_device_create+0x64c/0x6a0 drivers/android/binderfs.c:210
>  binderfs_fill_super+0x5d4/0x814 drivers/android/binderfs.c:729
>  vfs_get_super fs/super.c:1280 [inline]
>  get_tree_nodev+0x98/0x110 fs/super.c:1299
>  binderfs_fs_context_get_tree+0x28/0x38 drivers/android/binderfs.c:749
>  vfs_get_tree+0x68/0x1e4 fs/super.c:1814
>  do_new_mount+0x218/0x5d8 fs/namespace.c:3560
>  path_mount+0x428/0xa64 fs/namespace.c:3887
>  do_mount fs/namespace.c:3900 [inline]
>  __do_sys_mount fs/namespace.c:4111 [inline]
>  __se_sys_mount fs/namespace.c:4088 [inline]
>  __arm64_sys_mount+0x3dc/0x48c fs/namespace.c:4088
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x78/0x1b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0xe8/0x1b0 arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x40/0x50 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x14c arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>
> Allocated by task 3311:
>  kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
>  save_stack_info+0x34/0x144 mm/kasan/tags.c:106
>  kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:142
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0x9c mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __kmalloc_cache_noprof+0x2cc/0x434 mm/slub.c:4325
>  kmalloc_noprof include/linux/slab.h:901 [inline]
>  kzalloc_noprof include/linux/slab.h:1037 [inline]
>  binderfs_binder_device_create+0x124/0x6a0 drivers/android/binderfs.c:147
>  binderfs_fill_super+0x5d4/0x814 drivers/android/binderfs.c:729
>  vfs_get_super fs/super.c:1280 [inline]
>  get_tree_nodev+0x98/0x110 fs/super.c:1299
>  binderfs_fs_context_get_tree+0x28/0x38 drivers/android/binderfs.c:749
>  vfs_get_tree+0x68/0x1e4 fs/super.c:1814
>  do_new_mount+0x218/0x5d8 fs/namespace.c:3560
>  path_mount+0x428/0xa64 fs/namespace.c:3887
>  do_mount fs/namespace.c:3900 [inline]
>  __do_sys_mount fs/namespace.c:4111 [inline]
>  __se_sys_mount fs/namespace.c:4088 [inline]
>  __arm64_sys_mount+0x3dc/0x48c fs/namespace.c:4088
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x78/0x1b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0xe8/0x1b0 arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x40/0x50 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x14c arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>
> Freed by task 3311:
>  kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
>  save_stack_info+0x34/0x144 mm/kasan/tags.c:106
>  kasan_save_free_info+0x18/0x24 mm/kasan/tags.c:147
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x64/0x68 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2353 [inline]
>  slab_free mm/slub.c:4609 [inline]
>  kfree+0x14c/0x450 mm/slub.c:4757
>  binderfs_evict_inode+0x124/0x194 drivers/android/binderfs.c:278
>  evict+0x2e4/0x610 fs/inode.c:796
>  iput_final fs/inode.c:1946 [inline]
>  iput+0x564/0x5d8 fs/inode.c:1972
>  dentry_unlink_inode+0x2e0/0x310 fs/dcache.c:440
>  __dentry_kill+0x130/0x3e8 fs/dcache.c:643
>  shrink_kill+0xf8/0x324 fs/dcache.c:1088
>  shrink_dentry_list+0x280/0x4ec fs/dcache.c:1115
>  shrink_dcache_parent+0x88/0x21c
>  do_one_tree+0x2c/0xc0 fs/dcache.c:1578
>  shrink_dcache_for_umount+0x90/0x118 fs/dcache.c:1595
>  generic_shutdown_super+0x50/0x214 fs/super.c:620
>  kill_anon_super fs/super.c:1237 [inline]
>  kill_litter_super+0x64/0x90 fs/super.c:1247
>  binderfs_kill_super+0x3c/0x88 drivers/android/binderfs.c:791
>  deactivate_locked_super+0xa8/0x110 fs/super.c:473
>  deactivate_super+0xdc/0xe0 fs/super.c:506
>  cleanup_mnt+0x228/0x298 fs/namespace.c:1413
>  __cleanup_mnt+0x20/0x30 fs/namespace.c:1420
>  task_work_run+0x154/0x1c4 kernel/task_work.c:227
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x3b8/0x10dc kernel/exit.c:938
>  do_group_exit+0xfc/0x13c kernel/exit.c:1087
>  get_signal+0xd1c/0xd94 kernel/signal.c:3036
>  do_signal+0x17c/0x29a4 arch/arm64/kernel/signal.c:1658
>  do_notify_resume+0x7c/0x1b8 arch/arm64/kernel/entry-common.c:148
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_svc+0xac/0x14c arch/arm64/kernel/entry-common.c:745
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>
> The buggy address belongs to the object at fff00000124ffa00
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 8 bytes inside of
>  288-byte region [fff00000124ffa00, fff00000124ffb20)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x524f=
f
> anon flags: 0x1ffc00000000000(node=3D0|zone=3D0|lastcpupid=3D0x7ff|kasant=
ag=3D0x0)
> page_type: f5(slab)
> raw: 01ffc00000000000 28f000000a001900 0000000000000000 0000000000000001
> raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  fff00000124ff800: 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
>  fff00000124ff900: 01 01 01 01 fe fe fe fe fe fe fe fe fe fe fe fe
> >fff00000124ffa00: 84 84 84 84 84 84 84 84 84 84 84 84 84 84 84 84
>                    ^
>  fff00000124ffb00: 84 84 fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  fff00000124ffc00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/67d71fd3.050a0220.3657bb.0003.GAE%40google.com.

