Return-Path: <linux-kernel+bounces-231533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5205091999C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C32816CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2419307D;
	Wed, 26 Jun 2024 21:05:25 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92714D6EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435924; cv=none; b=cGbfUnSPxRK8LrxSc6Fhksfq4+7xVUui45UGIhNbUCSsj9DA3fY8GanLf101tdKn6MAwSSnRBfHMTjwHrosZZbY8JI3N7r9+V2mgsniJo7G9QV2xjFgC5EPt1mcV/Mzdd8qZ8TuHwGJ1FgkQSPUUqu14YEm4BxVtt5AxPccGG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435924; c=relaxed/simple;
	bh=DxYsEu4X1WbGkMeaD25NyGPmimdyWj6ZTquz3FeYzBY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OAVctcqsVOgkUvmsxOAoxjd3kRddoPTcdhzkxIBZhTCOYLzHqM1DOGXixzkDAMoEPrdbDj6dmpWUmsy8rqopsxFP80sEfXM2GPS0E0IkKxTemuYGbbgMfoazmAqrkh8iR1Riq9joEIBGBNTaZra13+GVUlVfs3jAOMzvGX3vy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so1018277139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719435922; x=1720040722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omCqdrKHC9uzHdZWn8d5VjrY3aw/1rvIIaZnUoHvFKA=;
        b=wv6Qlhc+HukFgnlxplg2pE1s4clJb/ZPcvmRWdh2DcrMlnbzHQtHfLB8rj/6WKfFkN
         QcN0BJRoafji1cSLebgKiZAgwLMIFb7lSIMnUr8b+qmLgWwJJYneXAN1D7gTjPD/3AJd
         BOArurs7fNrB4CeY01/ypNRzCo5VZHuRxVsyO0BUwJAzBhGTrymkHYXvqBVt1IJW6yzj
         7Oet/xBcz7g+P2BZVxUBFfVYuXEveLdkdP5MTYatGNsufsG0mwuHC4X8FkxWYDBVqeST
         OYrmcaR90ih3mDPV53S0koMifWejAHJjTx+srNCrMX3RUP/ywr3cBTeOiedu0akZjDJN
         xG9w==
X-Forwarded-Encrypted: i=1; AJvYcCWnDvmBd6o99aTnTXIDEGYgIvQ8inwl1Fp4HDjzv87BD2u30Q5myX8GrNhhk9M2FZwsasWsaHfEZBH2BaSGuqDsbcOujcRtwkOiW/9g
X-Gm-Message-State: AOJu0Yw0IRn+sOPKVsx7N5QNBa/VVc2+sP/OD9LrDQi3xT2W0zGI2K82
	53efaTexe7QSikfLQDijDCBtEzrIZQIKoUsBu9yHXTJsgC6z01eS+7+8RVtyNph7PMFxDpIJPGm
	biiBJnkoVGMisZRjsec2P0Gvxx3R4w7AW5qk0WaiSRFwroh4uW1X4VEM=
X-Google-Smtp-Source: AGHT+IFoMT6tJtVY+fXtOJsl8GG9kzXW2ldoxnXTNpwealYNmfj+vEzYul0qnuL3c1ZQTGgHUF2CpsYJw5qZuPMxwwQwvm2pf7mZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9611:b0:4b9:bdfd:f15b with SMTP id
 8926c6da1cb9f-4b9ece1ba70mr1187592173.4.1719435922590; Wed, 26 Jun 2024
 14:05:22 -0700 (PDT)
Date: Wed, 26 Jun 2024 14:05:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000615c23061bd15fc4@google.com>
Subject: [syzbot] [dri?] WARNING in drm_mode_create_lease_ioctl
From: syzbot <syzbot+6754751ad05524dae739@syzkaller.appspotmail.com>
To: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac2193b4b460 Merge branches 'for-next/misc', 'for-next/kse..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=101cc882980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36900d37ec67d13f
dashboard link: https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c17cd6980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15879c82980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c4f87d36ca3/disk-ac2193b4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8410475de662/vmlinux-ac2193b4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/495a4ced254d/Image-ac2193b4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6754751ad05524dae739@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6281 at mm/page_alloc.c:4654 __alloc_pages_noprof+0x324/0x6c0 mm/page_alloc.c:4654
Modules linked in:
CPU: 0 PID: 6281 Comm: syz-executor181 Tainted: G        W          6.10.0-rc3-syzkaller-gac2193b4b460 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __alloc_pages_noprof+0x324/0x6c0 mm/page_alloc.c:4654
lr : __alloc_pages_noprof+0xc8/0x6c0 mm/page_alloc.c:4648
sp : ffff800099017600
x29: ffff8000990176f0 x28: ffff800099017620 x27: dfff800000000000
x26: ffff700013202ec4 x25: 0000000000000000 x24: ffff800099017640
x23: 0000000000000000 x22: 0000000000040dc0 x21: 1ffff00013202ec8
x20: ffff800099017660 x19: 000000000000000b x18: ffff8000990176e0
x17: 000000000000c88a x16: ffff80008afa5980 x15: 0000000000000005
x14: 1ffff00013202ecc x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013202ed1 x10: 1ffff00013202ed0 x9 : 0000000000000001
x8 : ffff80009232a000 x7 : 0000000000000000 x6 : ffff0000e07d0900
x5 : ffff0000e07d0900 x4 : 0000000000000000 x3 : 0000000000000020
x2 : 0000000000000008 x1 : 0000000000000000 x0 : ffff800099017660
Call trace:
 __alloc_pages_noprof+0x324/0x6c0 mm/page_alloc.c:4654
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 __kmalloc_large_node+0xbc/0x200 mm/slub.c:4067
 __do_kmalloc_node mm/slub.c:4110 [inline]
 __kmalloc_noprof+0x360/0x494 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kmalloc_array_noprof include/linux/slab.h:699 [inline]
 fill_object_idr drivers/gpu/drm/drm_lease.c:389 [inline]
 drm_mode_create_lease_ioctl+0x4b0/0x17e4 drivers/gpu/drm/drm_lease.c:522
 drm_ioctl_kernel+0x26c/0x368 drivers/gpu/drm/drm_ioctl.c:744
 drm_ioctl+0x5e4/0xae4 drivers/gpu/drm/drm_ioctl.c:841
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 14766
hardirqs last  enabled at (14765): [<ffff80008b0693e8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (14765): [<ffff80008b0693e8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (14766): [<ffff80008b066ee4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (8860): [<ffff8000801ea3cc>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (8860): [<ffff8000801ea3cc>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
softirqs last disabled at (8855): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

