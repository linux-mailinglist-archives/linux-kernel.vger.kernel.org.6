Return-Path: <linux-kernel+bounces-316164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD396CC08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A76287621
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5B748D;
	Thu,  5 Sep 2024 01:06:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8E4A33
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498389; cv=none; b=Qsi10M6t2RhoDHNjPUNsW14BTLX3n2OkesRmxMKPGSOja91vgKBMF7mTGzYw1a+BiMLtU1n1kAzuTV6BNAo6cLThJyVMfPqEHAQmygd6OJlwTgobZhzFlEVf8MgRlsavc39dZrirMfYK6jVOsUBlItJOhzTSfI7zpn4IL2n20XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498389; c=relaxed/simple;
	bh=+2N2cz/vZlvK6MElK7BHsETaZta8am9aEmLHNHtUIcI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R3kRYcKzWaLFKFlR0V7OhDokDMrIct6jqZLMVgp8Kglzx0o03BSzrEyqQMlJzqaZf8yF3sBN4nchfiXNOpfE+DXVQn4sIHm9OEKfViTLuOQQ5ZJSYtG7ZEaosmihVbiYtRCjr2DCZkA2onGwmY3/RbES/OlfmzTYyiPY2c3eSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a124bc41aso27945639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 18:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725498387; x=1726103187;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAYLa3gAJq10imgnxwcHrNfTMkbi9jOvDxj4gkfBOpk=;
        b=wJ8hMo6w2HCk5tBpLtscsK2+MVosd7dwqUpp/GhHCm1kqC+g4y84LFD/xbrX/RpyId
         c7YMSuyVIUqWUuIeZ4L+QpUKQ1jKFN9x40sP5VHd7t1ThTxYA+AvMohXX1MCGJHdn/e4
         BBDYexS9zV/VgDt1bij1Rni+EB7OoMaby6Gt+GWn7x5R/RB3y12UJmMBxU9TbwskgW9Z
         kjbSXena0hOSjk52Av3O1OqURxyef1fiJc2cRDk65JhTctckowfGOcLjOdQzP2LrPM4E
         5DCYLdnbvK0lzgXmbKLkjqLceU3muGAr0Ml3TclY+jctoElXynb9LHJkJ7foTIOs85qH
         4TQA==
X-Forwarded-Encrypted: i=1; AJvYcCUtmhUZuphTzmG9LzHKNILD4Elqd0E0UOt1dLoR6svOXozbteeCyn+0n2afJHF5LlcUQhBDoQX1wtugSjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqWXsxyN4wQJTPn6z+d89hoPQLAs8naVF0zXRD+H1qNJu75jO
	jRViFONGIDARzCKi3435q7dY50KjdDi9HD9NVk6+z47iGvS+X5v526lOTfoepDXSVUg0bZFiAFQ
	RRyT/3DzrYM5LIXQXOI3clZcDv8UvI/m8j0ilUkuxL5Yd2vl/ZCOgnVg=
X-Google-Smtp-Source: AGHT+IE5oGFdAYetB0WLbVlthXsHM+ywys8HRBRBTS9ulokWHG3VpTsY5NmR61O+Zlkrq2VPGQF8Z2WbhGLDZk+MvNpDzvPFqaID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4b9:6f13:fb1a with SMTP id
 8926c6da1cb9f-4d05e73844cmr161634173.4.1725498387122; Wed, 04 Sep 2024
 18:06:27 -0700 (PDT)
Date: Wed, 04 Sep 2024 18:06:27 -0700
In-Reply-To: <000000000000f4447f06202eca5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cde9c062154e6f3@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (4)
From: syzbot <syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com>
To: daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c7fb1692dc01 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11742d63980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11703653980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154565b7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c7fb1692.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/246da487db6f/vmlinux-c7fb1692.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0ea1e4dac0f/bzImage-c7fb1692.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com

R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit drivers/video/fbdev/core/sysimgblt.c:257 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1ec6/0x2b00 drivers/video/fbdev/core/sysimgblt.c:326
Write of size 4 at addr ffffc90001c41000 by task syz-executor161/5103

CPU: 0 UID: 0 PID: 5103 Comm: syz-executor161 Not tainted 6.11.0-rc6-syzkaller-00048-gc7fb1692dc01 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:257 [inline]
 sys_imageblit+0x1ec6/0x2b00 drivers/video/fbdev/core/sysimgblt.c:326
 drm_fbdev_shmem_defio_imageblit+0x2e/0x100 drivers/gpu/drm/drm_fbdev_shmem.c:39
 bit_putcs+0x18ba/0x1db0
 fbcon_putcs+0x255/0x390 drivers/video/fbdev/core/fbcon.c:1288
 do_update_region+0x396/0x450 drivers/tty/vt/vt.c:619
 redraw_screen+0x902/0xe90 drivers/tty/vt/vt.c:971
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:794 [inline]
 set_con2fb_map+0xa6c/0x10a0 drivers/video/fbdev/core/fbcon.c:865
 fbcon_set_con2fb_map_ioctl+0x207/0x320 drivers/video/fbdev/core/fbcon.c:3092
 do_fb_ioctl+0x38f/0x7b0 drivers/video/fbdev/core/fb_chrdev.c:138
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feb9b353729
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde9b9f968 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffde9b9f980 RCX: 00007feb9b353729
RDX: 00000000200000c0 RSI: 0000000000004610 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffde9b9f707 R09: 00000000000000a0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90001941000, ffffc90001c42000) created by:
 drm_gem_shmem_vmap+0x3ac/0x630 drivers/gpu/drm/drm_gem_shmem_helper.c:343

Memory state around the buggy address:
 ffffc90001c40f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001c40f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90001c41000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90001c41080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90001c41100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

