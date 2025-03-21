Return-Path: <linux-kernel+bounces-571526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F660A6BE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A273AF718
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B73D1DE2C2;
	Fri, 21 Mar 2025 15:33:32 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80842A94
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571211; cv=none; b=dTeQiMv6P+QgPSw/mHyCZXhw0YaWdsz8hyjVdZlwqoW8stfIe1cj/SFFo7RGLr0Ts6Yjb06RJAxvoREsougaU8BiUXqIm+2dFx4ptblndw2UIPzGgx1I0frZ7lBbD8XtliBU4HxK/U0cL2l2FrX47F6Wyquq822zy+rXjMBgrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571211; c=relaxed/simple;
	bh=ZqWZgfF19wn0F9D/bfZgvrICxRQvmxpuCjufT4+0OiY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JQNTLPVX6EjrLsuSRHaf61HDrN4be+OXiEuRQdCAAcRUTZLkt2sXzRCp39Vm1K9tXTDRsKetIGiQWqbA4LRQxPS7Eob5hT7D4DUj3mAmY5V4x/KOz3huGhduSpz97yamkYUmODlyuZx6Ue2IncJgsiMODXUigKHA97YSt5gkxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2a379bbf0so41937205ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742571209; x=1743176009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lw7ghwuumnNph7RdlZoulnuNS45H4wnBjy+efPtZXF0=;
        b=ZmgA6BrdLhixGv6RiOQ/Cqh5E+gZ/GSPi7bdFrRPjA8Rq6iHFRER078PbRjbCA7rud
         325mY+2QPQmtsy2+j+2HYfy52hcdfotez452tUD7GDpFhwLwmLOHsZkiPpSuBGPGvtnk
         JOt4ciOAYH3mUeqfdBz0UwP4QHyW81zu+DzCBTvVi2bVQ6mWb41yIkV4H4jFMIWVLbvx
         tmyt4xorSKlfaqXH2fNosmmDN56ZR8UJlutJBVVvVUa4BVY9/rLyBASzMIjIdQAcKnS5
         FU/+1v3z5vWNAZ1he+lx6RVKOANWb5WV5x91MTwQLH+JPS0/gzIElYYE2E22G2AF7KCt
         572A==
X-Gm-Message-State: AOJu0YxvWYRKfHjx4yjBKE6u85TIbwAP+u+BCE2AaAjlWVTnPm/2DQl2
	DkZ3hiMFXQa/RnIWrFRyesNNKulv+3YTCX4rE+j0tIrm96XOSrObdYBsKodYWHT06aAEjl3RD9A
	P3nQr/a0vxgUSVqWnIUj/9zIG4s3rcHN9uTs/+mFWvL70pGpoRKMz6oxXxw==
X-Google-Smtp-Source: AGHT+IFNYF70C2xwEdEWnGCyzSRudUPaZiVmSQZkFZvC3rKaQ34Qxsqiqeb+dd5XUoSYQ4oKuqRctNEJi8f9vz85t6/Zsk4BOTR8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3cf:fe21:af8 with SMTP id
 e9e14a558f8ab-3d59612bcd5mr39148115ab.4.1742571208805; Fri, 21 Mar 2025
 08:33:28 -0700 (PDT)
Date: Fri, 21 Mar 2025 08:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dd86c8.050a0220.25ae54.0059.GAE@google.com>
Subject: [syzbot] [sound?] possible deadlock in __snd_timer_user_ioctl
From: syzbot <syzbot+2b96f44164236dda0f3b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4701f33a1070 Linux 6.14-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ed844c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f1ab0f4f8e33050
dashboard link: https://syzkaller.appspot.com/bug?extid=2b96f44164236dda0f3b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2dc8c7f3ede3/disk-4701f33a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b19e548eea76/vmlinux-4701f33a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0316f25ab8ca/bzImage-4701f33a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b96f44164236dda0f3b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc7-syzkaller #0 Not tainted
------------------------------------------------------
syz.0.488/8394 is trying to acquire lock:
ffff888028e09fe0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault mm/memory.c:6839 [inline]
ffff888028e09fe0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xe3/0x190 mm/memory.c:6832

but task is already holding lock:
ffffffff8fdaf688 (register_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
ffffffff8fdaf688 (register_mutex){+.+.}-{4:4}, at: snd_timer_user_next_device sound/core/timer.c:1526 [inline]
ffffffff8fdaf688 (register_mutex){+.+.}-{4:4}, at: __snd_timer_user_ioctl.isra.0+0xa0c/0x2640 sound/core/timer.c:2247

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (register_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       snd_timer_open+0x90/0x1020 sound/core/timer.c:307
       loopback_snd_timer_open+0xaca/0x1020 sound/drivers/aloop.c:1202
       loopback_open+0x2bf/0x13a0 sound/drivers/aloop.c:1268
       snd_pcm_open_substream+0xa50/0x17c0 sound/core/pcm_native.c:2753
       snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2439 [inline]
       snd_pcm_oss_open+0x754/0x1400 sound/core/oss/pcm_oss.c:2520
       soundcore_open+0x409/0x580 sound/sound_core.c:594
       chrdev_open+0x237/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x735/0x1c40 fs/open.c:956
       vfs_open+0x82/0x3f0 fs/open.c:1086
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1e88/0x2d80 fs/namei.c:3989
       do_filp_open+0x20c/0x470 fs/namei.c:4016
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
       do_sys_open fs/open.c:1443 [inline]
       __do_sys_openat fs/open.c:1459 [inline]
       __se_sys_openat fs/open.c:1454 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1454
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&loopback->cable_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       rule_format+0x111/0x3b0 sound/drivers/aloop.c:982
       constrain_params_by_rules+0x547/0xca0 sound/core/pcm_native.c:436
       snd_pcm_hw_refine sound/core/pcm_native.c:567 [inline]
       snd_pcm_hw_refine+0x7e8/0xad0 sound/core/pcm_native.c:545
       snd_pcm_hw_param_mask sound/core/oss/pcm_oss.c:190 [inline]
       snd_pcm_oss_change_params_locked+0x645/0x3a60 sound/core/oss/pcm_oss.c:886
       snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1105 [inline]
       snd_pcm_oss_mmap+0x603/0x7c0 sound/core/oss/pcm_oss.c:2914
       call_mmap include/linux/fs.h:2245 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2296 [inline]
       __mmap_new_vma mm/vma.c:2360 [inline]
       __mmap_region+0x181f/0x2760 mm/vma.c:2461
       mmap_region+0x1ab/0x3f0 mm/vma.c:2539
       do_mmap+0xd8d/0x11b0 mm/mmap.c:561
       vm_mmap_pgoff+0x279/0x440 mm/util.c:578
       ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:607
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __might_fault mm/memory.c:6839 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6832
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2d/0xd0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       snd_timer_user_gstatus sound/core/timer.c:1699 [inline]
       __snd_timer_user_ioctl.isra.0+0xd47/0x2640 sound/core/timer.c:2256
       snd_timer_user_ioctl+0x72/0xb0 sound/core/timer.c:2291
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &loopback->cable_lock --> register_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(register_mutex);
                               lock(&loopback->cable_lock);
                               lock(register_mutex);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz.0.488/8394:
 #0: ffff8880332c2568 (&tu->ioctl_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
 #0: ffff8880332c2568 (&tu->ioctl_lock){+.+.}-{4:4}, at: snd_timer_user_ioctl+0x4a/0xb0 sound/core/timer.c:2290
 #1: ffffffff8fdaf688 (register_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
 #1: ffffffff8fdaf688 (register_mutex){+.+.}-{4:4}, at: snd_timer_user_next_device sound/core/timer.c:1526 [inline]
 #1: ffffffff8fdaf688 (register_mutex){+.+.}-{4:4}, at: __snd_timer_user_ioctl.isra.0+0xa0c/0x2640 sound/core/timer.c:2247

stack backtrace:
CPU: 1 UID: 0 PID: 8394 Comm: syz.0.488 Not tainted 6.14.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain kernel/locking/lockdep.c:3906 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __might_fault mm/memory.c:6839 [inline]
 __might_fault+0x11b/0x190 mm/memory.c:6832
 _inline_copy_to_user include/linux/uaccess.h:192 [inline]
 _copy_to_user+0x2d/0xd0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:225 [inline]
 snd_timer_user_gstatus sound/core/timer.c:1699 [inline]
 __snd_timer_user_ioctl.isra.0+0xd47/0x2640 sound/core/timer.c:2256
 snd_timer_user_ioctl+0x72/0xb0 sound/core/timer.c:2291
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdbb2f8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdbb3d93038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdbb31a6080 RCX: 00007fdbb2f8d169
RDX: 0000400000000140 RSI: 00000000c0145401 RDI: 0000000000000003
RBP: 00007fdbb300e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdbb31a6080 R15: 00007ffee7e06528
 </TASK>


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

