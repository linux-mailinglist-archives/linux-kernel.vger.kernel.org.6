Return-Path: <linux-kernel+bounces-334963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28CC97DEF3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC04282076
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839A1547DA;
	Sat, 21 Sep 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk5Daj6c"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C814A60E;
	Sat, 21 Sep 2024 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952520; cv=none; b=VRFEKNNKfiw9kX2cABR5OxCdr1U6jzNnAzxXQqVApK/1OtG4n8yO7zI4KdyEyZIv4dOgLW7sBy6/GwclhQ+HFFJzjM9BNaRTMB073RBX015GJIMNrPJ6bTMDyRGJ7nGbWX53D6gm2siFhdDIEyVcBh1Fj/xG1ZUHUyEkcMYYhGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952520; c=relaxed/simple;
	bh=uifJ6q8Bbmih9QgRojfJQIp6OOwa8aetIHjzcFyDF9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG7h1OhbCbIpcJkjU6Eg5PhQYC8xrzQBxmt2K/oOTX0JR8Oq7tPAGamJJXqgvSxLVTwg+JcUKbsc6eYKd99ASX+jMvRiz0nf7CheHZVHJrMuzLnGcSqOJtBVFiv63nRNSUXXPEgj3JXj0GKrFtmUVcyYCRmMsaIxn82uWdnYAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk5Daj6c; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so26131315e9.0;
        Sat, 21 Sep 2024 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726952516; x=1727557316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SqkYprUdOSY+dyVCKLeUfzexyXtMCfZ8UKpDwscKqg=;
        b=hk5Daj6cbW+x2ckMO9MQC940khY0gHCHm42+cpjTTwDxfwFr/QDPzlZIU6h7yWLchU
         w4PjgC/QNhdaOx8JNL7crsXOX+AHJYO27z30MpiKDajrJ0SG36hyhzWvXCeqVdRZriEx
         cvjfzKCCJnCwz2KzJ11qRiEuBLe9c9oe35S5ecT7L3pKeVQ5p7GDE//dv+2m/vEHcerl
         n2NKkLe92yfF5wPYcyqXIJAPYLHkF+8QYyJnfQgARzQ0403vxjDbgm2Lrrn9mFF30wjw
         mvbEwlctNSiGn5491xBuFHQWAPj++n5kEacDaU4ouHsjMFufRPp6/mhUC8/210tdq9dQ
         KCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952516; x=1727557316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SqkYprUdOSY+dyVCKLeUfzexyXtMCfZ8UKpDwscKqg=;
        b=Wiv4JAwZNOB1p4tlZvxT7w7YLh+OVE/3aQ7OwbXNoEReXlAh1987Pv1UC7O/XeBARf
         6aknObl/Zdd1EX4dKydvw6T0zOLH0hLWvU9fSoDYHumT/fUR/Sbq8yTvDH4CEqZg6xIK
         cMxiJd0xU/1R0jpHPlUi8u/w9CTsr4IUHQiTxKwmQD5qw8ongltD957CX+1JY82FkCnG
         AQEykoeNMZERtkRWrMnytpsJCOffCu4LVxKU/kLWjVepfphehbHXiyYB/43DEWh7q6jC
         mSXZMg59hBIqL2J9qrz1G/qY76SYl5Zs/B9OIE9ULd2rciXcOnLOPdyeFMZhMDjV2cbU
         +SKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4eWgo0UKfWle38NxhL5CHEccyDTjyLM2tSQdH2/44tTfswynuI21qzmIHno2a/Z96lt9a8HPG0bW5@vger.kernel.org, AJvYcCX27tyZ5FnW3VnxIHjr99c9J01/6uV5SONTzzP0/S62eLGYmajLN7C3cIX3MoXCw7EMh4cZAKk/EUp4B8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJG9g3tSOlb6tAUdMEEk3D2k2sKZdhs3y5YDhQKUXlwyrue0Bg
	r+q2Z/s9LRHRTAmeyHCkF62+uW5A3USl3ur0pGNtsdqKnP/d3scgoVvSNcTimYDdz2o8E0BW2Sp
	jmvDaEwn65pXdExxs1GroQ+nvHsY=
X-Google-Smtp-Source: AGHT+IHv7qxnZN74FT7XNrbHFxdGWBHu4rmxc7fPuCt3+RjB68fi/Hx+uiRkmPXvmo5XAHi8NP+c6XFhE5H+NkOydMA=
X-Received: by 2002:a05:600c:3ba5:b0:42c:bd5a:945b with SMTP id
 5b1f17b1804b1-42e7ac23f92mr42710265e9.21.1726952516132; Sat, 21 Sep 2024
 14:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000636a27062076e046@google.com>
In-Reply-To: <000000000000636a27062076e046@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 21 Sep 2024 23:01:45 +0200
Message-ID: <CA+fCnZcOqQaqzeRcLpF1_fzcTsoX_S6wQ6tX-7UXvZ7ebnBDnA@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in raw_ioctl
To: syzbot <syzbot+c17537a52fdd1e1bf35a@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 2:13=E2=80=AFAM syzbot
<syzbot+c17537a52fdd1e1bf35a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ca7df2c7bb5f Merge 6.11-rc4 into usb-next
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/us=
b.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1317d5f398000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D31bb2857b4a82=
509
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc17537a52fdd1e1=
bf35a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9cc03ea70257/dis=
k-ca7df2c7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2474799a1fb1/vmlinu=
x-ca7df2c7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/defdfb2c65cd/b=
zImage-ca7df2c7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c17537a52fdd1e1bf35a@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: double-free in raw_ioctl_ep_disable drivers/usb/gadget/legacy=
/raw_gadget.c:964 [inline]
> BUG: KASAN: double-free in raw_ioctl+0x4e7/0x2b90 drivers/usb/gadget/lega=
cy/raw_gadget.c:1321
> Free of addr ffff888111c532c0 by task syz.1.5060/27826
>
> CPU: 1 UID: 0 PID: 27826 Comm: syz.1.5060 Not tainted 6.11.0-rc4-syzkalle=
r-00047-gca7df2c7bb5f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:488
>  kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
>  poison_slab_object+0x135/0x160 mm/kasan/common.c:232
>  __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2252 [inline]
>  slab_free mm/slub.c:4473 [inline]
>  kfree+0x10b/0x380 mm/slub.c:4594
>  raw_ioctl_ep_disable drivers/usb/gadget/legacy/raw_gadget.c:964 [inline]
>  raw_ioctl+0x4e7/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1321
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc90ec49a7b
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 4=
4 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0=
 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:00007fc90d8c4f00 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fc90ef10320 RCX: 00007fc90ec49a7b
> RDX: 000000000000000b RSI: 0000000040045506 RDI: 0000000000000004
> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000010
> R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000868 R14: 00007fc90ef10b88 R15: 0000000000000868
>  </TASK>
>
> Allocated by task 27832:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:4158 [inline]
>  __kmalloc_node_track_caller_noprof+0x1ff/0x3e0 mm/slub.c:4177
>  memdup_user+0x2a/0xd0 mm/util.c:226
>  raw_ioctl_ep_enable drivers/usb/gadget/legacy/raw_gadget.c:847 [inline]
>  raw_ioctl+0xbca/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1318
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 27826:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
>  poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
>  __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2252 [inline]
>  slab_free mm/slub.c:4473 [inline]
>  kfree+0x10b/0x380 mm/slub.c:4594
>  dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
>  kref_put include/linux/kref.h:65 [inline]
>  raw_release+0x16e/0x2c0 drivers/usb/gadget/legacy/raw_gadget.c:473
>  __fput+0x408/0xbb0 fs/file_table.c:422
>  __fput_sync+0x47/0x50 fs/file_table.c:507
>  __do_sys_close fs/open.c:1566 [inline]
>  __se_sys_close fs/open.c:1551 [inline]
>  __x64_sys_close+0x86/0x100 fs/open.c:1551
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff888111c532c0
>  which belongs to the cache kmalloc-16 of size 16
> The buggy address is located 0 bytes inside of
>  16-byte region [ffff888111c532c0, ffff888111c532d0)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888111c5=
3300 pfn:0x111c53
> anon flags: 0x200000000000000(node=3D0|zone=3D2)
> page_type: 0xfdffffff(slab)
> raw: 0200000000000000 ffff888100041640 0000000000000000 dead000000000001
> raw: ffff888111c53300 0000000000800077 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0=
(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 12232, tgid 12232 (kw=
orker/1:7), ts 1485408509711, free_ts 1461255308030
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
>  prep_new_page mm/page_alloc.c:1501 [inline]
>  get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3439
>  __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4695
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x4e/0xf0 mm/slub.c:2321
>  allocate_slab mm/slub.c:2484 [inline]
>  new_slab+0x84/0x260 mm/slub.c:2537
>  ___slab_alloc+0xdac/0x1870 mm/slub.c:3723
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
>  __slab_alloc_node mm/slub.c:3866 [inline]
>  slab_alloc_node mm/slub.c:4025 [inline]
>  __do_kmalloc_node mm/slub.c:4157 [inline]
>  __kmalloc_node_track_caller_noprof+0x14e/0x3e0 mm/slub.c:4177
>  kvasprintf+0xbd/0x160 lib/kasprintf.c:25
>  kasprintf+0xc8/0x100 lib/kasprintf.c:59
>  dvb_create_tsout_entity+0x26d/0x430 drivers/media/dvb-core/dvbdev.c:266
>  dvb_create_media_entity drivers/media/dvb-core/dvbdev.c:298 [inline]
>  dvb_register_media_device drivers/media/dvb-core/dvbdev.c:397 [inline]
>  dvb_register_device+0xd99/0x2000 drivers/media/dvb-core/dvbdev.c:547
>  dvb_dmxdev_init+0x33e/0x4e0 drivers/media/dvb-core/dmxdev.c:1435
>  dvb_usb_adapter_dvb_init+0x636/0x9f0 drivers/media/usb/dvb-usb/dvb-usb-d=
vb.c:192
>  dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:86 [inline=
]
>  dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:186 [inline]
>  dvb_usb_device_init+0x15c7/0x20a0 drivers/media/usb/dvb-usb/dvb-usb-init=
.c:310
>  gp8psk_usb_probe+0x51/0xe0 drivers/media/usb/dvb-usb/gp8psk.c:304
> page last free pid 803 tgid 803 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1094 [inline]
>  free_unref_page+0x698/0xce0 mm/page_alloc.c:2612
>  kasan_depopulate_vmalloc_pte+0x63/0x80 mm/kasan/shadow.c:408
>  apply_to_pte_range mm/memory.c:2797 [inline]
>  apply_to_pmd_range mm/memory.c:2841 [inline]
>  apply_to_pud_range mm/memory.c:2877 [inline]
>  apply_to_p4d_range mm/memory.c:2913 [inline]
>  __apply_to_page_range+0x795/0xdd0 mm/memory.c:2947
>  kasan_release_vmalloc+0xac/0xc0 mm/kasan/shadow.c:525
>  purge_vmap_node+0x3fc/0x920 mm/vmalloc.c:2208
>  __purge_vmap_area_lazy+0x9ca/0xc10 mm/vmalloc.c:2290
>  drain_vmap_area_work+0x27/0x40 mm/vmalloc.c:2324
>  process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
>  process_scheduled_works kernel/workqueue.c:3312 [inline]
>  worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Memory state around the buggy address:
>  ffff888111c53180: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>  ffff888111c53200: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
> >ffff888111c53280: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>                                            ^
>  ffff888111c53300: fa fb fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
>  ffff888111c53380: fa fb fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

#syz dup: KASAN: invalid-free in dev_free

