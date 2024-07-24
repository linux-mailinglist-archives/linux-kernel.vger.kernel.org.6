Return-Path: <linux-kernel+bounces-261060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6B293B26A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF7328221A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A8158D96;
	Wed, 24 Jul 2024 14:10:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8035DDC5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830237; cv=none; b=gUpwgHwR74oeH8502TFKh4nOqv4q93+WaO22W153KQealZkt93LD4GZ4BUliO5KngB2KSi+GOe9V98ZfHxfT5gfFqnTVgYLdMPwuVnEYK1Rid1eB1q+RGErFFFaDIvV7EBkwnQEkB3EVRHFYxsvyNEUpHVe+a+X1mMQLUoysieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830237; c=relaxed/simple;
	bh=I//QT2Y2LNh/jAS9/5aClvE3fhMEPAzrCMMBrtq2w4s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mjqdh02mA/LAGcVTbqb6raU8ufsCgiLoxtX7FGTcuhdzU0wq0s3tAULFtrQwownMfV3LKqGPVHv4Ul9ZMndgVult1GI4S7tPtd5BoC2FMrjGkIOxJgSrVDrT660TC2MzBnDgUZiKfSoKT8LzZkSf3SEln1B2wq9NxCbC7/CO7Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a20115ff0so1205695ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830235; x=1722435035;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rke9SrdPSSHVahZflKTJUGygjJ7frSja8B/83dVEu70=;
        b=m8X4siOj7LcRMWQVWw75uRLE6wkTNfpJTvACYZ1Ew9JA+vxAtElyWh36UR8QnvAIC6
         Mp/inYxQuDZfCMNGadpMJMAtjIKLLuDBy977EG3Dvsj5GEZHajsAF4oBgEmrldAqVIVe
         O8a5khrScMdBC+oinjcpxL/MLWQGw5llYTRBaTCgB1tzeiQiW27kkcZ341ONkSmDAlJZ
         jw90XO1ilt7g/oFN/6V5v4BVOUHj77e9VB3UvhB1KlEbGy9oxXOdhpUoNBBjQqgI5jMv
         kZd4s5SXosF237leemnbGPQw2IO/7wO9fWlkhHMzTI2IyHT6fDJxmgaL7+NnVFNCvput
         AJFw==
X-Forwarded-Encrypted: i=1; AJvYcCXn2ysjt4w40aRbyLeu0b28MWzQ+fJObwNREA6am/3IZWcss+lZD109SdTzadtpxirWdKvx4mwJvcq8fXXUGgYBgJjub/ZKvjqFRhSD
X-Gm-Message-State: AOJu0Yye1Hi1n39a9gsu5EiRRcQIP8URO6JPoJQAwJgoIKlcHzXeNkqj
	agZ5ZNv11/3RJo49chFzCB8vCOzOlQp9nrqztTfT5b4NZRjS20U7X3EH+bIA4caN/5PQDTFiV8O
	jtDFBjZRZNaxBSK8E+fKuBrSSWczzupa6c0bMVeBPQmS195B/r9LANKA=
X-Google-Smtp-Source: AGHT+IGA2MjPEBsrVDJ5Bo4PW3RlcJ5HqVSl0sz616yLVYq/Bw1N214YkMLBHbWEziJZm+rx912MO9KgzrXACgQzZfMG1+DzbwuJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831c:b0:4c0:9380:a260 with SMTP id
 8926c6da1cb9f-4c28ef5e79dmr79435173.3.1721830233807; Wed, 24 Jul 2024
 07:10:33 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:10:33 -0700
In-Reply-To: <0000000000006bca48061692b790@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000733373061dfed75d@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in gup_fast_fallback
From: syzbot <syzbot+63ba90b81c16b86379bd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15009665980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d732ba79a3d0331b
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162862e3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d14ce3980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a022c722f874/disk-786c8248.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/860e2faa9749/vmlinux-786c8248.xz
kernel image: https://storage.googleapis.com/syzbot-assets/518e4afe4ede/bzImage-786c8248.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/09d1622c5e09/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63ba90b81c16b86379bd@syzkaller.appspotmail.com

ntfs3: loop0: Mark volume as dirty due to NTFS errors
ntfs3: loop0: Failed to load $Extend (-116).
ntfs3: loop0: Failed to initialize $Extend.
======================================================
WARNING: possible circular locking dependency detected
6.10.0-syzkaller-12246-g786c8248dbd3 #0 Not tainted
------------------------------------------------------
syz-executor288/5099 is trying to acquire lock:
ffff888063210b18 (&mm->mmap_lock){++++}-{3:3}, at: gup_fast_fallback+0x233/0x2b50 mm/gup.c:3367

but task is already holding lock:
ffff88807a2be310 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:819 [inline]
ffff88807a2be310 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_file_write_iter+0x24a/0x740 fs/ntfs3/file.c:1166

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       ntfs_file_mmap+0x5bf/0x850 fs/ntfs3/file.c:368
       call_mmap include/linux/fs.h:2129 [inline]
       mmap_region+0xe8f/0x2090 mm/mmap.c:2927
       do_mmap+0x8ad/0xfa0 mm/mmap.c:1438
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1484
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       gup_fast_fallback+0x24c/0x2b50 mm/gup.c:3367
       pin_user_pages_fast+0xcc/0x160 mm/gup.c:3491
       iov_iter_extract_user_pages lib/iov_iter.c:1583 [inline]
       iov_iter_extract_pages+0x3db/0x720 lib/iov_iter.c:1646
       dio_refill_pages fs/direct-io.c:173 [inline]
       dio_get_page fs/direct-io.c:214 [inline]
       do_direct_IO fs/direct-io.c:916 [inline]
       __blockdev_direct_IO+0x144c/0x4890 fs/direct-io.c:1249
       blockdev_direct_IO include/linux/fs.h:3212 [inline]
       ntfs_direct_IO+0x195/0x370 fs/ntfs3/inode.c:801
       generic_file_direct_write+0x130/0x350 mm/filemap.c:3941
       __generic_file_write_iter+0x129/0x230 mm/filemap.c:4107
       ntfs_file_write_iter+0x663/0x740 fs/ntfs3/file.c:1193
       do_iter_readv_writev+0x60a/0x890
       vfs_writev+0x37c/0xbb0 fs/read_write.c:971
       do_pwritev fs/read_write.c:1072 [inline]
       __do_sys_pwritev2 fs/read_write.c:1131 [inline]
       __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#14);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#14);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz-executor288/5099:
 #0: ffff888023990420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2876 [inline]
 #0: ffff888023990420 (sb_writers#9){.+.+}-{0:0}, at: vfs_writev+0x2d4/0xbb0 fs/read_write.c:969
 #1: ffff88807a2be310 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:819 [inline]
 #1: ffff88807a2be310 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: ntfs_file_write_iter+0x24a/0x740 fs/ntfs3/file.c:1166

stack backtrace:
CPU: 0 UID: 0 PID: 5099 Comm: syz-executor288 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 gup_fast_fallback+0x24c/0x2b50 mm/gup.c:3367
 pin_user_pages_fast+0xcc/0x160 mm/gup.c:3491
 iov_iter_extract_user_pages lib/iov_iter.c:1583 [inline]
 iov_iter_extract_pages+0x3db/0x720 lib/iov_iter.c:1646
 dio_refill_pages fs/direct-io.c:173 [inline]
 dio_get_page fs/direct-io.c:214 [inline]
 do_direct_IO fs/direct-io.c:916 [inline]
 __blockdev_direct_IO+0x144c/0x4890 fs/direct-io.c:1249
 blockdev_direct_IO include/linux/fs.h:3212 [inline]
 ntfs_direct_IO+0x195/0x370 fs/ntfs3/inode.c:801
 generic_file_direct_write+0x130/0x350 mm/filemap.c:3941
 __generic_file_write_iter+0x129/0x230 mm/filemap.c:4107
 ntfs_file_write_iter+0x663/0x740 fs/ntfs3/file.c:1193
 do_iter_readv_writev+0x60a/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb9777dcb59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe15926128 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb9777dcb59
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007fb97786f5f0 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000007000 R11: 0000000000000246 R12: 00007ffe15926160
R13: 00007ffe15926388 R14: 431bde82d7b634db R15: 00007fb97782503b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

