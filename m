Return-Path: <linux-kernel+bounces-572181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8EBA6C7C2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77841781E0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0153C185E7F;
	Sat, 22 Mar 2025 06:11:25 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE713C695
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742623884; cv=none; b=H3g7RNwRI0LwroaTZjH+Fq3/6QEwWmsa6W439TwVeL42bWBXaiWSBuV7ICYLgpFiGGojpmcreVXwGXZIFuoeHqxLsKLA1DzI5PksItQRb898ct7qkN9G99VGYn60zn1zNN4iQNIK75wHsBXfrI+LsnR2XCaR78DqWQYWu5sblek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742623884; c=relaxed/simple;
	bh=4tVmLcFk7GShZumIG1KBnFMY+kw8ZmGR7qR6LOWqmCE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qr8qlB2CCB7uhMzAoRI0CrrasyWvmJc4PZ5OZfucQp/1+PXwLuu91VG0tiHKNWHMuDPZCyF9IAiwVCB50O6EOB8p0FspWek7zoHSzEUHCOQdt5YZTjzS5gNmff6pqAAsvwbCthsBv3DCYbiLbKKMKek+fr4gsJrqqI4lJyWz8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d3d949fd42so47782965ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742623882; x=1743228682;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2gqwx/ub3iU4KkfW3e3HxgscIsVZSTibXySbq/gqw8=;
        b=tZla/fQKASszZ61nzy6F8R6+uRMtovWG9MndK9EJAV+GLPXVukJin8vBPTeUv72wzq
         clercCOzkdpkmHGCBQAiaCoL0oYqurb7NflOCub/rU+OKhE9iCPwdC3PXs5j2cs+Pmvf
         +fnakX60rgEFWbFGogxwVRmvvenozq6/y80Q5xlvs3RjzHQFS6LOnt88/XQjiksghquB
         Ji8h+obI3YMag3vQerxGNyXIYvOk73OOJf5bdgVKfHLTPkAJ+Bzc85iQmEsowY68rv7L
         xjB5XP1uSJn1vRGxJNZICjdpVOmeMCOsa3XFQ+6EaNA+FE8FKAgNLDMiApZqXuZpXnj6
         cuUg==
X-Gm-Message-State: AOJu0YwqEkLF/e8pu72F5NQJLiFqj1vN4efnmpK7Lp500unhpdlVXIOv
	CKh9LmMitRRpD6XKNcPRGKn7i7WYaorDhrlTIRSWGXIwhk329w3kYBlwpOCNZt72Z+CF7Ce136A
	2/hnTKyRW76Hf737PLOKAI4ICBUuN4BaTSvPo3iiLr0TdOWxiT/yysBiWpA==
X-Google-Smtp-Source: AGHT+IG2uEsO+FrcOoej73ayXuS3JG/2eneXpnGSJf8AtqnEmBIevP/qKBc87ar0P0Dtd4j18QiNMgTfWayhyGyjtMKzrcgJYZRO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:3d3:dfc6:bc26 with SMTP id
 e9e14a558f8ab-3d596188bdfmr68877355ab.22.1742623881893; Fri, 21 Mar 2025
 23:11:21 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:11:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67de5489.050a0220.31a16b.002a.GAE@google.com>
Subject: [syzbot] [sound?] possible deadlock in snd_timer_open
From: syzbot <syzbot+04dc474cd658421fd07c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc444ada1310 Merge tag 'soc-fixes-6.14-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dee068580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f1ab0f4f8e33050
dashboard link: https://syzkaller.appspot.com/bug?extid=04dc474cd658421fd07c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d8091bec0ef8/disk-fc444ada.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0addc811ee52/vmlinux-fc444ada.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f3df78bd6e03/bzImage-fc444ada.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04dc474cd658421fd07c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc7-syzkaller-00050-gfc444ada1310 #0 Not tainted
------------------------------------------------------
syz.3.1481/11930 is trying to acquire lock:
ffffffff8fdaf688 (register_mutex){+.+.}-{4:4}, at: snd_timer_open+0x90/0x1020 sound/core/timer.c:307

but task is already holding lock:
ffff888030624ac0 (&loopback->cable_lock){+.+.}-{4:4}, at: loopback_open+0x110/0x13a0 sound/drivers/aloop.c:1240

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&loopback->cable_lock){+.+.}-{4:4}:
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

-> #1 (&mm->mmap_lock){++++}-{4:4}:
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

-> #0 (register_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       snd_timer_open+0x90/0x1020 sound/core/timer.c:307
       loopback_snd_timer_open+0xaca/0x1020 sound/drivers/aloop.c:1202
       loopback_open+0x2bf/0x13a0 sound/drivers/aloop.c:1268
       snd_pcm_open_substream+0xa50/0x17c0 sound/core/pcm_native.c:2753
       snd_pcm_open_file sound/core/pcm_native.c:2789 [inline]
       snd_pcm_open+0x29b/0x700 sound/core/pcm_native.c:2854
       snd_pcm_playback_open sound/core/pcm_native.c:2814 [inline]
       snd_pcm_playback_open+0x86/0xe0 sound/core/pcm_native.c:2806
       snd_open+0x1fe/0x450 sound/core/sound.c:166
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

other info that might help us debug this:

Chain exists of:
  register_mutex --> &mm->mmap_lock --> &loopback->cable_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&loopback->cable_lock);
                               lock(&mm->mmap_lock);
                               lock(&loopback->cable_lock);
  lock(register_mutex);

 *** DEADLOCK ***

2 locks held by syz.3.1481/11930:
 #0: ffff88814d02fae0 (&pcm->open_mutex){+.+.}-{4:4}, at: snd_pcm_open+0x261/0x700 sound/core/pcm_native.c:2852
 #1: ffff888030624ac0 (&loopback->cable_lock){+.+.}-{4:4}, at: loopback_open+0x110/0x13a0 sound/drivers/aloop.c:1240

stack backtrace:
CPU: 1 UID: 0 PID: 11930 Comm: syz.3.1481 Not tainted 6.14.0-rc7-syzkaller-00050-gfc444ada1310 #0
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
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
 snd_timer_open+0x90/0x1020 sound/core/timer.c:307
 loopback_snd_timer_open+0xaca/0x1020 sound/drivers/aloop.c:1202
 loopback_open+0x2bf/0x13a0 sound/drivers/aloop.c:1268
 snd_pcm_open_substream+0xa50/0x17c0 sound/core/pcm_native.c:2753
 snd_pcm_open_file sound/core/pcm_native.c:2789 [inline]
 snd_pcm_open+0x29b/0x700 sound/core/pcm_native.c:2854
 snd_pcm_playback_open sound/core/pcm_native.c:2814 [inline]
 snd_pcm_playback_open+0x86/0xe0 sound/core/pcm_native.c:2806
 snd_open+0x1fe/0x450 sound/core/sound.c:166
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
RIP: 0033:0x7f55a1f8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f55a2e8e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f55a21a5fa0 RCX: 00007f55a1f8d169
RDX: 0000000000080000 RSI: 0000400000000c40 RDI: ffffffffffffff9c
RBP: 00007f55a200e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f55a21a5fa0 R15: 00007ffcdede93a8
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

