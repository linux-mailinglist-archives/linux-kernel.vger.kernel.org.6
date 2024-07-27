Return-Path: <linux-kernel+bounces-264156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610793DF93
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC361F21900
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276A16EB44;
	Sat, 27 Jul 2024 13:44:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AC6F2E2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722087863; cv=none; b=P8fFlQ+yILfr/WsEzTbjjVJF/EvZAgmbIjKxAHqW+sa1p5tbygfSdBaTaJDFJa8E18m2XDAKzh6kLdPWyAFcCIVkx2O60CJcnPRkzFPIYUVhgpuIgddCTtqI+Okc2XMrqYcE3nW29TImBQhssY4W46qw+dlEXF29153SBeeqwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722087863; c=relaxed/simple;
	bh=Bx4gA5xkQNyhV8lHQ+P1Cilk0RItWwLCFUUS/yCtRAQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PG9SxGEyQjKyd7v5M2j5lBG5atO/IbDyXLgsPzKIWMLFPNobI24YsiZrT8u79BeGVqr7FxFOk4GqngNyyytZ4EUxiBTikEQEjcMG2zl7+x+x/SgsG/GWaWEHWmamlfMLzlp8QkO8QsTK20I2wuoAfsWS7pbaSlm7FSTZ4cUhR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39696c3f2d6so30718425ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 06:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722087861; x=1722692661;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Caq2l1msZTqR7bR4+0x4P/OrvebEVPtJYK8KRXE0DA=;
        b=ZzxrhK5XOImTzUIlH0Yr9ky4hh5RKS1Pv+JXMVtXs6688kbYzOS86M7DXNbV3Egu1p
         yhEdh1jxLEuq+mtv5+i8Lw/K5PmDowYPP4buzBl/vwh9ExLph7YPmUzQaz2vUVvjjiLO
         O+BFZyP7O8KDPl67Adv2L4OndE/mWtJUauScAtxSXK3JU4tyqnPZNwq+kwk/N/qlwNNP
         Rz+kZ5qBxJyaXoEKxPDjapqLYwVcl7wfiNoswN0Te/v3zxuIWBIFi78kvWhClpgof/pY
         FnADDxgtL3Qg78QCm/0m1LYc4oYgjmXXjcXsFhBMqPBHVw8Ydf21wIL3mG99Ktovf5EM
         HY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7e3mfcVhWp6pXkM8O+6hkxoS748o0L2jgPd+w0Q8yPvInDz3UfwVeKG4d2eGvLiLO/lQE7IvpsSFd+sH1+N+R92bo+1RbqF16ZfX5
X-Gm-Message-State: AOJu0Ywt3ohkWMELiWIvWLAuwwK8hIi2G8I+Xzj4503D6t0/0M5FrJee
	u3yvhQYtEu7vebfHPE9Etcs5yrYeE4NQOkFJfPSyRZJ0xlbEF+NXP06wEGdUMvY7FIXI64c0ABD
	MtNX97UTQZRHG1VvxDpKw0IjacyjWUSW+nFLZkZldob8Nago8BcJGizQ=
X-Google-Smtp-Source: AGHT+IHI2xgsk/0HJRQ91WDOiWCEFzbBX/3nV95TiqS6BiDV27sXliTzz5mg556IpdmavxsNvZQSVtxuM8D0YaMJtljylJDOG1mU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39aec44f69emr2295855ab.5.1722087860919; Sat, 27 Jul 2024
 06:44:20 -0700 (PDT)
Date: Sat, 27 Jul 2024 06:44:20 -0700
In-Reply-To: <0000000000002488fc061ae886f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038f243061e3ad3fe@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_file_mmap
From: syzbot <syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2f8c4f506285 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10836f19980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108328d9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e875a1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beafa5a4d4f9/disk-2f8c4f50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e58aee7103bd/vmlinux-2f8c4f50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92d87af85377/bzImage-2f8c4f50.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ed5b83574e49/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-syzkaller-12708-g2f8c4f506285 #0 Not tainted
------------------------------------------------------
syz-executor114/5223 is trying to acquire lock:
ffff888073150af0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
ffff888073150af0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: ntfs_file_mmap+0x5bf/0x850 fs/ntfs3/file.c:368

but task is already holding lock:
ffff88807dfbf398 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff88807dfbf398 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
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
       generic_file_direct_write+0x132/0x350 mm/filemap.c:3941
       __generic_file_write_iter+0x129/0x230 mm/filemap.c:4107
       ntfs_file_write_iter+0x663/0x740 fs/ntfs3/file.c:1193
       do_iter_readv_writev+0x60c/0x890
       vfs_writev+0x37c/0xbb0 fs/read_write.c:971
       do_pwritev fs/read_write.c:1072 [inline]
       __do_sys_pwritev2 fs/read_write.c:1131 [inline]
       __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       ntfs_file_mmap+0x5bf/0x850 fs/ntfs3/file.c:368
       call_mmap include/linux/fs.h:2129 [inline]
       mmap_region+0xe91/0x2090 mm/mmap.c:2957
       do_mmap+0x8f9/0x1010 mm/mmap.c:1468
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#15);
                               lock(&mm->mmap_lock);
  lock(&sb->s_type->i_mutex_key#15);

 *** DEADLOCK ***

1 lock held by syz-executor114/5223:
 #0: ffff88807dfbf398 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff88807dfbf398 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586

stack backtrace:
CPU: 0 UID: 0 PID: 5223 Comm: syz-executor114 Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285 #0
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
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:799 [inline]
 ntfs_file_mmap+0x5bf/0x850 fs/ntfs3/file.c:368
 call_mmap include/linux/fs.h:2129 [inline]
 mmap_region+0xe91/0x2090 mm/mmap.c:2957
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f71d1735e19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbfcbe088 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f71d1735e19
RDX: 00000000007fffff RSI: 0000000000003000 RDI: 0000000020000000
RBP: 00007f71d17c95f0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000246 R12: 00007fffbfcbe0c0
R13: 00007fffbfcbe2e8 R14: 431bde82d7b634db R15: 00007f71d177f03b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

