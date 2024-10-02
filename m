Return-Path: <linux-kernel+bounces-347084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBB98CD9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895201F23769
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E918E373;
	Wed,  2 Oct 2024 07:08:14 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEE13D886
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852894; cv=none; b=ZVBpXunukHkp7Dicgm9jWuyqciup4kMXTlWZGAUn3QqX6rRabs62/5DBWkZU7WtvV2DuhvCeX0n6QiVVwsyGrdsD/lmDDcKwaFQmYKvvHo8I7nrZxxbwGoTHanSQ8hwW3r2TudqQoRZHfoRDt9VV+ZC6gN+STSU1z7Ibqsbwh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852894; c=relaxed/simple;
	bh=ZW+agxiaR5trSj1jgc4W00ukYJN3ivEi77ENrSlZt1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fyIaGuaDMbb29DymqkQRU5VPW3FG+BqhvRhuvBq0xY+nyEEdMNCgNlD4QA+B8/FvX9OY7xJ2I1QRZyG6ThW2YZkiC6aolW6cppX5ViJqK4ocB6B93SM5p+Y6Pm4WYTgMwxaNbNPmGh+ma3Ik5qNMiyIEdP/bHLn4YI2o1ORDOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82d094a0010so679365439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727852891; x=1728457691;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaliCY5k4/BV0q6Z3on28AJaiG9d02MfjeyqA/yczvg=;
        b=YIfaBrCXsgJ7o4l1x8E7RB4pYp+4cyGeY/wEBC/qMxvMgWvp/pgQY14Wt07MPI2WCP
         js1KN3taQEDhKoHFSRnXV2pSniIYoEJV+g/w8HPsQhw+kADrLyNU6uzX4TRq5vMOxIUt
         IB+XqfINfXD4POZ7Q1OXjFwbBkfzgqHx55ZCiYg1Uw+TlBd0leX137KuRhD3eV7fIDSy
         NbSN8YDkqsy3g1z2848mufdMYxw2KVFXFKr7p9guu8uvmEn41tmwXm2WwuxlggM895+x
         YVdIVCP/4gjbv6aRHCEiFPcGUA4LrTFxeEi4kUYDPdIyTctkFOtbuV32rTdvfhF6s5tK
         yZdg==
X-Gm-Message-State: AOJu0YwrDDPS1PMisXfZd9z7dx/tEE+rcPWtbWiz2R4TZWG2jcyzYFYE
	G1MBBcvlX1mjBoU3XkZ+c1jDNJBGk7USoO0kbzU2Z5N9GuMRyUirXZ8A6ZlkX8LxK3LU1zWJDwG
	BpGnBxyiQu7oFVLg8YApgcaxtXcVsioVALj2zF9S+6ty/Qfh2OsbeO8w=
X-Google-Smtp-Source: AGHT+IHi6ReR50rLnv1fpS3EB3vDomoF6k7fVKiyi/ajBP/8N+u6iR5b2n4Nik+2onEENV1b8wYuZS2sx/iXkwhxHC5unVA5TkAQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a2:7651:9876 with SMTP id
 e9e14a558f8ab-3a36592a77amr21305555ab.13.1727852891545; Wed, 02 Oct 2024
 00:08:11 -0700 (PDT)
Date: Wed, 02 Oct 2024 00:08:11 -0700
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcf15b.050a0220.f28ec.04f6.GAE@google.com>
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

#syz test

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

