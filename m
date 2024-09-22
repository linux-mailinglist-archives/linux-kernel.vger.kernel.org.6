Return-Path: <linux-kernel+bounces-335075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE99997E0AE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B25C1C20995
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D013A3F9;
	Sun, 22 Sep 2024 09:17:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC53308A
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726996644; cv=none; b=FzZSU6DIsjL76wE40CaBJkpCzQ+DqZr/k0QSfAlwJ81DoTzk+PUFyOzC54fYY8AjwrvsZsK20BqT/dFe0fX2ms8mRwbu4si8FN/ILXElyIIhOPWutVIHDyqUsBo5ObYzSrZQXFxILZhEOwGOsZolDLRiOE3UlF8HibkwVNhovrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726996644; c=relaxed/simple;
	bh=M/eZFAhMUaYa0RhmlRvxZHNHJgXkgmvfbAmbHepbqls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uTK3sEgE+uJnH5PKtcJpyjwOPJxXTHKZC2EgaQcHDc9mpaX6GgaOIZxvDCvvNXD965sMnFU16v75rhTnmqRi4eC4P77MoeMuAl1qEvFzyBd+9AkkFIKo+XiMyPvUkzFkbO7PVqaCdl+yKRDfFqNzyLfKiXM7ZRR6IfbYxcxT/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1957c7cf3so6386585ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 02:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726996642; x=1727601442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZlxNiqGhVO8KGi8G8VOncekpmqDbO4rxQuTO7t98V4=;
        b=Bi74CVjNpIIXqbnBF3BWc0UR3GCRe/02pZaDoM2VR3owqLm2Q4OraZz4NeCXH2Mlcm
         200269dFM28u/GQaQ9MS7tD3fV9Pe+XE0nnCJeH+tzKjmejFZehm5pbVAAAYQGwN7gz8
         FMMDiNRvDKBbOA8geN6zltkkXich5PYRk/G7I9w5ddo1B+Qd11sz+C+EKAOWzF99wZiR
         dw/BKV3irPiUA3Q+J+6dGsIc6NJd9z/gHOkcz6ZDlQLwJB0Xoe2TQZ59CASFIuuL4l/u
         YJhlxNCuwV1KdYz1Dm3SWOCx3qTa+bGXMs0ThoDq1gUQfFFpTq+kDIQP6qFMjewfffV8
         H9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf6i32Ox4H+xWoYzfLCO7VvZ1Nh2sCSIv77ZfbOpYlBBQhXl5KDpN0B+OspMUPMBwVdMstOYoUnET2SSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8Z0gjGIoJFSK3MMxsj88o72PqCTB6U5bfBbUb3HjYyjVVS3g
	CDatxD53wA0GRQt0ABu4HrxVXMO0gOLoS/2mH3/xdwvD2ymwTy1Nm/pcxehwtanXZzEafaYZnX/
	WhZHBTS0f2zi4HyPujgOPgVaA1AxlIVq2+jMOw4A/FBtz47mosRIGxFQ=
X-Google-Smtp-Source: AGHT+IH0227KKcpAN2HBn66W/qC4cbgp1UVGCv90D90kGu65khMkuKGjaFJI1smH9vf+pIjHLaqrnkStoAtCYW1oaJGpByW+dN2j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:3a0:9f85:d74e with SMTP id
 e9e14a558f8ab-3a0c8d0ba04mr71182365ab.16.1726996641788; Sun, 22 Sep 2024
 02:17:21 -0700 (PDT)
Date: Sun, 22 Sep 2024 02:17:21 -0700
In-Reply-To: <0000000000006f6622061eb52dba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66efe0a1.050a0220.3195df.0094.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_generic_write
From: syzbot <syzbot+8f282cce71948071c335@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=125cec27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547de13ee0a4d284
dashboard link: https://syzkaller.appspot.com/bug?extid=8f282cce71948071c335
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108bb080580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165cec27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d83fc781c223/disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ed4c5969fba/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76a67bd894be/bzImage-88264981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f282cce71948071c335@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usb_submit_urb+0x597/0x2350 drivers/usb/core/urb.c:430
 usbtmc_generic_write+0x7b6/0xe80 drivers/usb/class/usbtmc.c:1213
 usbtmc_write+0xdb7/0x1210 drivers/usb/class/usbtmc.c:1622
 vfs_write+0x487/0x1540 fs/read_write.c:681
 ksys_write+0x20f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4092 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 __kmalloc_cache_noprof+0x4f0/0xb00 mm/slub.c:4291
 kmalloc_noprof include/linux/slab.h:878 [inline]
 usbtmc_create_urb drivers/usb/class/usbtmc.c:757 [inline]
 usbtmc_generic_write+0x430/0xe80 drivers/usb/class/usbtmc.c:1176
 usbtmc_write+0xdb7/0x1210 drivers/usb/class/usbtmc.c:1622
 vfs_write+0x487/0x1540 fs/read_write.c:681
 ksys_write+0x20f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Byte 3 of 4 is uninitialized
Memory access of size 4 starts at ffff8881150f6000

CPU: 1 UID: 0 PID: 5201 Comm: syz-executor176 Not tainted 6.11.0-syzkaller-08481-g88264981f208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

