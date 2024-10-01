Return-Path: <linux-kernel+bounces-346709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91D98C7BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67A11F23A14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C701CCECE;
	Tue,  1 Oct 2024 21:44:17 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217E19ABC3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819057; cv=none; b=devNf4K3H3xvptZyA3qj9WK+mzxuVAd02CsB7MwHDFBreXzULKij44ssmj9ZpKARxxKrzdm6R16ft2DCAUUXeNNYDXc9YUk3HHol8vlInxqZFVzbODPscjCycUzGe+10tjlJWadfOm7Z5i+3sBIM6klRXbuwz7EQ41+Fs9vC34Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819057; c=relaxed/simple;
	bh=kkR+b3NQiM+njzscY6j9JqvL3TbsK5l5xC6/AGrKOs8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nyj0nVv9Cw47edkVqy3v05Z+jDDX7XDo/x5EoXKe5+TBGYj+rgut6W9gojG49+BsYWjdyonZWlfC/64b7rUGbDEuY7NgzZbt5gcseGs6x2BNwwuhPqO6gAoAJ+VXqSGWUrzb4RDGYyovLlufACBiqGmka6BlQHF/9qGcEsVM0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so790354439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819055; x=1728423855;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO+FuIVkOzq55prA91CwHa9sjNpZFO+JyeWAS/S8hv8=;
        b=kcE203mG8S9s0I8FdSuCfFmW4jh2TMAdgr4XRydDgc7JthXo7zOzBq9ag/pAJbPxnC
         oFh6tpUPdM0FyCrEjy1mMdsKUQbc34qxJP70HMPC4bYQAgZk2+IBMr3EPkAXb1E9N7kZ
         n42hVBCuhVxiiEIcfzIP91TKwZOWS90t/ooQtm5+ceB7acRQuY2uY2Emt9xuRzbn2Rmx
         tlUjf3uniDDe7Ta1E/NtNhGAbXYUSJRrjr9let6Q/lp7UNJHkYm2TZ0TwPWbXy90h3rq
         fJUajMMeASG3mdJJYua+s8iU/HyLdco/eik0CVGfj89qzUwXjJyUPNeGXQMC5jKk9QY2
         hvow==
X-Gm-Message-State: AOJu0YwPkMrcXn8NK9axpRC/5QRyhh1IJBMuBVVvL2xNq2fNw43pKkIS
	dCmL/p5CaPctW5iwvIPjCDmTGOtQSLAymkSDlpDKTi7PIaygpbPohF8RdBauXjFr/4AIPgNYJfX
	NkEFZXskSuyKnCW6Iu7ZcDSVGxQsMIUzpsTAeUVD+kbSabNA4pbBqHIo=
X-Google-Smtp-Source: AGHT+IG34Tqe/sY0ZpM+OJ1xvdXl9gnZvJ3GLvsxEYsYissscg5juUkhoEVFC4MEJUemE7jh16BU43mfvSN0ald916brjOWMSeP2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:3a0:a385:9128 with SMTP id
 e9e14a558f8ab-3a36591ad35mr9848365ab.6.1727819054242; Tue, 01 Oct 2024
 14:44:14 -0700 (PDT)
Date: Tue, 01 Oct 2024 14:44:14 -0700
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc6d2e.050a0220.f28ec.04d5.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [hfs?] KMSAN: uninit-value in
 __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent =
(2)
Author: surajsonawane0215@gmail.com

This change ensures that the extent and cached_extents structures are fully
initialized before use.
By adding memset, it prevents uninitialized memory issues reported by
KMSAN, avoiding undefined
behavior and possible crashes during extent handling.

#syz test

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 fs/hfs/extent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 4a0ce131e..cee1b4504 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -154,6 +154,7 @@ static inline int __hfs_ext_read_extent(struct
hfs_find_data *fd, struct hfs_ext

  hfs_ext_build_key(fd->search_key, cnid, block, type);
  fd->key->ext.FNum =3D 0;
+ memset(extent, 0, sizeof(struct hfs_extent));
  res =3D hfs_brec_find(fd);
  if (res && res !=3D -ENOENT)
  return res;
@@ -176,6 +177,7 @@ static inline int __hfs_ext_cache_extent(struct
hfs_find_data *fd, struct inode
  return res;
  }

+ memset(HFS_I(inode)->cached_extents, 0,
sizeof(HFS_I(inode)->cached_extents));
  res =3D __hfs_ext_read_extent(fd, HFS_I(inode)->cached_extents,
inode->i_ino,
     block, HFS_IS_RSRC(inode) ? HFS_FK_RSRC : HFS_FK_DATA);
  if (!res) {
--=20
2.34.1

On Tue, Oct 1, 2024 at 2:57=E2=80=AFPM syzbot <
syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of
> git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11b9be2798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D85d8f50d88ddf=
2a
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dd395b0c369e492a17530
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15b9be27980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10ddd50798000=
0
>
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/265feec46ffa/disk-ad46e8f9.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/d0f41ea693d3/vmlinux-ad46e8f=
9.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/45082d33d192/bzImage-ad46e8f=
9.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/c19549ac916f/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 64
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:160
> [inline]
> BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x69f/0x7e0
> fs/hfs/extent.c:179
>  __hfs_ext_read_extent fs/hfs/extent.c:160 [inline]
>  __hfs_ext_cache_extent+0x69f/0x7e0 fs/hfs/extent.c:179
>  hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
>  hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
>  __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
>  block_write_begin fs/buffer.c:2231 [inline]
>  cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
>  hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
>  cont_expand_zero fs/buffer.c:2509 [inline]
>  cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
>  hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
>  hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
>  hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
>  notify_change+0x1a8e/0x1b80 fs/attr.c:503
>  do_truncate+0x22a/0x2b0 fs/open.c:65
>  vfs_truncate+0x5d4/0x680 fs/open.c:111
>  do_sys_truncate+0x104/0x240 fs/open.c:134
>  __do_sys_truncate fs/open.c:146 [inline]
>  __se_sys_truncate fs/open.c:144 [inline]
>  __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
>  x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
77
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4092 [inline]
>  slab_alloc_node mm/slub.c:4135 [inline]
>  __do_kmalloc_node mm/slub.c:4264 [inline]
>  __kmalloc_noprof+0x661/0xf30 mm/slub.c:4277
>  kmalloc_noprof include/linux/slab.h:882 [inline]
>  hfs_find_init+0x91/0x250 fs/hfs/bfind.c:21
>  hfs_ext_read_extent fs/hfs/extent.c:200 [inline]
>  hfs_get_block+0x68d/0xf50 fs/hfs/extent.c:366
>  __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
>  block_write_begin fs/buffer.c:2231 [inline]
>  cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
>  hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
>  cont_expand_zero fs/buffer.c:2509 [inline]
>  cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
>  hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
>  hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
>  hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
>  notify_change+0x1a8e/0x1b80 fs/attr.c:503
>  do_truncate+0x22a/0x2b0 fs/open.c:65
>  vfs_truncate+0x5d4/0x680 fs/open.c:111
>  do_sys_truncate+0x104/0x240 fs/open.c:134
>  __do_sys_truncate fs/open.c:146 [inline]
>  __se_sys_truncate fs/open.c:144 [inline]
>  __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
>  x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
77
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 0 UID: 0 PID: 5188 Comm: syz-executor246 Not tainted
> 6.11.0-syzkaller-11728-gad46e8f95e93 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/66fbc081.050a0220.6bad9.=
0056.GAE%40google.com
> .
>

