Return-Path: <linux-kernel+bounces-299448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D295D4BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D041F2393B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A081E190665;
	Fri, 23 Aug 2024 17:56:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFD18C32A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435765; cv=none; b=ac44mWq6/TB/cG52ItuL28fjclV44xL9f33bLyW0VL6JKPiHM6b0604WYUHF9JOLr7AugmnT8SnXyjUMRq2ZkEBkmQU6SIl3SUzHrherLHv3jYXGXSbLAgIFD4CJ3FoiU4enbAhrHQpQ/Cvt/f+6M9rMclWBfTZN+W777/v1SlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435765; c=relaxed/simple;
	bh=AAirZX7L6gC1ESgzRmRHpDCW/58TDoa13P3fHCj9NqU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mPtZkRf7DePpmPXH3g4+rEHexT6naN3LU37vocnZBW4zebdK9w2FuVlHp89dVJ/sqY3ZKkb/ddHEbX8+mYF8IWMkGk2dDa0l1r1XouCHDbSQc9cuC3KsSGAKsLED3wwAP1U8PvTklrmg9bTFqCrScpxK8ySUONphC0m+QOsbY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824c925d120so208840839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724435762; x=1725040562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hIypXV8gtMHSvpHuY3rvjg6Nf2BK9DMgLO05nRJb7Q=;
        b=Vy8vomTxMyZ3hqJ2L83XRbHHJvCWdnoQUA9JkZ/ZTDlWucKv1zvemRPnSmq1894TVg
         77N7CCbsvMgIlbtt0K56flMCjHRfNCF+60fMTJMnSqfLN6ND/KivdN91ZbHVvwjJ0BBC
         jm1/vjqotycOAM/wLNjGQiPlZM/6pxjkw12By2nWplHb4XmN69zVwLgfwKtGYqL39UmQ
         9xXdeaNFpCWMdMOWBK29XSMeuzM1oqtPlskEvLQf7kCCJQ+/lA2qFwCz2yTnNQQxgO+s
         NKWIim86RP6+udfxHKJ3TVvqSjGhzWOfdlmMunlGNe4s7j1NZTFzefeSas8vRyv6qC7Q
         tXWw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Eum7CQr0rjBLWA3j5TX0jBXX3bp7AoZey8sz5XyvO+U4S8lHh6/Tcce8gUT0G4kdJAtYRKFnlP3jiIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWMcmL8SkOEgX9GJuCgBDyXQk/e+Q2Q/yUxQpsnE9Bmyc0MjR
	CQQKMWAcaMxuTyJ7MmZJMkU4xxc8sakzvrkixVl2v71vWlXNFu346NO/nQXIPVv4PJqiY9w7T+D
	AnybSbumFTAnw9sJtAs/XosTmv13s3NkGQ/F4PbJXZZVEhzuk75FRY/s=
X-Google-Smtp-Source: AGHT+IGrEW0rE1MbiWoj8DErNRxy1YPQbt9WhJpXUq4JMIZ9/uj1oDdT8SGMNE84/PJRO2SsjqVIDBpFJSqUbt/HEpGiD1FjPGNu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871e:b0:4c2:7f96:6f4 with SMTP id
 8926c6da1cb9f-4ce82b2ba8dmr89809173.4.1724435762677; Fri, 23 Aug 2024
 10:56:02 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:56:02 -0700
In-Reply-To: <9dfe6ab434654f52a317b26f799d5ddb@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000129aab06205d7d93@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ni_fiemap
From: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in attr_data_get_block

loop0: detected capacity change from 0 to 4096
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc1-syzkaller-00016-g7529036a025a #0 Not tainted
------------------------------------------------------
syz-executor.0/5510 is trying to acquire lock:
ffff88806c041e60 (&ni->ni_lock/5){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1111 [inline]
ffff88806c041e60 (&ni->ni_lock/5){+.+.}-{3:3}, at: attr_data_get_block+0x44b/0x2f20 fs/ntfs3/attrib.c:917

but task is already holding lock:
ffff888023f4d718 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff888023f4d718 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __might_fault+0xc6/0x120 mm/memory.c:6388
       _inline_copy_to_user include/linux/uaccess.h:176 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:209 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ni_fiemap+0x4f5/0x1910 fs/ntfs3/frecord.c:1993
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1346
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->ni_lock/5){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1111 [inline]
       attr_data_get_block+0x44b/0x2f20 fs/ntfs3/attrib.c:917
       ntfs_file_mmap+0x4f5/0x850 fs/ntfs3/file.c:370
       call_mmap include/linux/fs.h:2129 [inline]
       mmap_region+0xe8f/0x2090 mm/mmap.c:2957
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
                               lock(&ni->ni_lock/5);
                               lock(&mm->mmap_lock);
  lock(&ni->ni_lock/5);

 *** DEADLOCK ***

1 lock held by syz-executor.0/5510:
 #0: ffff888023f4d718 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff888023f4d718 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586

stack backtrace:
CPU: 1 UID: 0 PID: 5510 Comm: syz-executor.0 Not tainted 6.11.0-rc1-syzkaller-00016-g7529036a025a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ni_lock fs/ntfs3/ntfs_fs.h:1111 [inline]
 attr_data_get_block+0x44b/0x2f20 fs/ntfs3/attrib.c:917
 ntfs_file_mmap+0x4f5/0x850 fs/ntfs3/file.c:370
 call_mmap include/linux/fs.h:2129 [inline]
 mmap_region+0xe8f/0x2090 mm/mmap.c:2957
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf3647dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf372630c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fcf365abf80 RCX: 00007fcf3647dea9
RDX: 00000000027fffff RSI: 0000000000600000 RDI: 0000000020000000
RBP: 00007fcf364ca4a4 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000004002011 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fcf365abf80 R15: 00007ffdefad79e8
 </TASK>


Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17478b91980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=500271480f7d801c
dashboard link: https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

