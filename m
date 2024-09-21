Return-Path: <linux-kernel+bounces-334965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7400B97DEF7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F417282030
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0906170A23;
	Sat, 21 Sep 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Fk5OM8"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243314EC46;
	Sat, 21 Sep 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952540; cv=none; b=I4Uj3sOM91iJ+snP3utO4TxbbCkUmSzrTfe3rI/LBKbfRCFeIhZ4QtshtsLr/zteOzob5+AKqwfW6q9ot7OnMsYf8V/a7tnV7Vo4s20lPb1L3iq+VcrJr7Qrr8PlZtwdKME1jCZ7GjHXoL6c3j3ninuFSuijpcgf3Zmn5wAcEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952540; c=relaxed/simple;
	bh=3wCK4pDmxl7uTyWPDiG6ZYuTYmBF9WwLuq6djQ6BLkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkOaZFlGqFNt/RwN2oMGmqfHbqUDuFRep3rn+QNqIkHael38/aKhlFMK9PmYS/sDyTrLTpgRQ17ptAYeuLwqISH03CUKnQVp3CpT/tRfTxMOqSHoyvmT76c8sr/InOFEGefW0zyi0O3LT5f29IgCGuB5s6s6K9Y6179hgcnH/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8Fk5OM8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c180d123so1822388f8f.3;
        Sat, 21 Sep 2024 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726952536; x=1727557336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKoAXStZLBWHetqp1i1bLnjUeePA58I2T3QO0NmIvV0=;
        b=J8Fk5OM8D5jxV64eL6aJsJe5HXgZiratkh48rJ5dATxJfI6OREdNrWpdMWODt7G0G0
         s1w1tnauEVKFocWF+ztT4qcN+eNj7Q4St/NVs/4EeX4YCPN9tuSFyXyR2v9bjSzNSTki
         iMUueWaqL5AjO4qc5WsJN5vqqWFQ4R4NSmLQYnbARJuK2wbevyA0v8Yy+WUxDzr4xBci
         4KioBTiYWmzZ/ztp5Cd7echosDVnfImSaHd+9k0z5z3g4G00qE7hLXjcEd9BcWmiAT9K
         gB7pyIE6t5a/qlSNyeY1MeOWtw0fIAK2b55tiIhaVAs2Bve3Mxv3075Ojbh8Rm4mhqOa
         ZRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952536; x=1727557336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKoAXStZLBWHetqp1i1bLnjUeePA58I2T3QO0NmIvV0=;
        b=ZZOczaSudOMPgjm195XTivnH26iI/OwzENuS01Bd+Q+nRFA5sGDeLK+Ty8LvXsofoN
         3u0hOGcpC0meCmnvuICS563GZ80UdSBQA/I5kYFP46kGeclQgm4qoocpJdvINXvk+5ve
         CLMfSE+tXqbX7Fo2FS9gWZzn7KyiJoMP8wFeXBrHEB6Gfol6tZYUZod+5r5I291WaB5a
         k4gT9I2khgsRT7vjUfoI+Up4uSx6mmGtpNBoEidwnRuQ2WHyrOTB6e4Bh6f3AumqRytt
         JkeGZuDDSTPxcrtc68/JHkyaD31Fsaibdc7295Tc/jnsmoroVLHA2bfE1ZGqzxji0BIa
         jSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+WnqtZGheaJhbkMbjiCJelGL6HzT0Py9zpkjGHGmLgkT9PU82F7XfTaZJKqtEWxkr5iBQTlHcn0kt@vger.kernel.org, AJvYcCWxpSnif140N7gNNOlycl0HLnqzcgs8KqSGUNFn7XwdznUBeWsFSJiwrqA4QCTetbyNmglC4voWlROz384=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxd0ireRWSMpGaK2aXBTe5Obo1Tk3SAzz7jOf/RtOy/csFvvSJ
	IXCLeGSt9sBxkM1hORQaC6BNFLcE3SUaIBZIhnaxRd3lbHVutNKYBvafDI3NDrH1ypQyhZKs5F3
	e2O8EKa0yWP7s3QeInWxYOBz0SDM=
X-Google-Smtp-Source: AGHT+IEUm6alyY+xiS5Eswn1hbYUtIGkAkiOyJTDIHRXpKNYIc6s4aylzcfTCsv7nyhcfB8WhkBRL6HdXpeBuxfPHto=
X-Received: by 2002:adf:ef89:0:b0:374:babf:ac4d with SMTP id
 ffacd0b85a97d-37a42392ec2mr3083634f8f.58.1726952536232; Sat, 21 Sep 2024
 14:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66ef21d7.050a0220.3195df.0068.GAE@google.com>
In-Reply-To: <66ef21d7.050a0220.3195df.0068.GAE@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 21 Sep 2024 23:02:05 +0200
Message-ID: <CA+fCnZfPcaNKA-BnOA1GsLDkirr3wz06LRRB_3E+LdZE+W=2Tg@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in raw_ioctl_ep_set_clear_halt_wedge
To: syzbot <syzbot+1966d2bbc2befdc0ba2c@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 9:43=E2=80=AFPM syzbot
<syzbot+1966d2bbc2befdc0ba2c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID con=
s..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/us=
b.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D143d808058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcb61872d4d8c5=
df9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1966d2bbc2befdc=
0ba2c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c69290425359/dis=
k-68d42091.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/caf4f26a3e85/vmlinu=
x-68d42091.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3acdec4b62e6/b=
zImage-68d42091.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+1966d2bbc2befdc0ba2c@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in usb_endpoint_xfer_isoc include/uapi/li=
nux/usb/ch9.h:563 [inline]
> BUG: KASAN: slab-use-after-free in raw_ioctl_ep_set_clear_halt_wedge+0x4b=
e/0x7c0 drivers/usb/gadget/legacy/raw_gadget.c:1012
> Read of size 1 at addr ffff888111e55b83 by task syz.4.752/7534
>
> CPU: 1 UID: 0 PID: 7534 Comm: syz.4.752 Not tainted 6.11.0-rc7-syzkaller-=
00152-g68d4209158f4 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:488
>  kasan_report+0xd9/0x110 mm/kasan/report.c:601
>  usb_endpoint_xfer_isoc include/uapi/linux/usb/ch9.h:563 [inline]
>  raw_ioctl_ep_set_clear_halt_wedge+0x4be/0x7c0 drivers/usb/gadget/legacy/=
raw_gadget.c:1012
>  raw_ioctl+0x105/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1350
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>  __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2f3c32def9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2f3afa1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f2f3c4e5f80 RCX: 00007f2f3c32def9
> RDX: 0000000000000000 RSI: 000000004004550d RDI: 0000000000000003
> RBP: 00007f2f3c3a0b76 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f2f3c4e5f80 R15: 00007ffdece30528
>  </TASK>
>
> Allocated by task 7538:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:4162 [inline]
>  __kmalloc_node_track_caller_noprof+0x1ff/0x3e0 mm/slub.c:4181
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
> Freed by task 7534:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
>  poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
>  __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2256 [inline]
>  slab_free mm/slub.c:4477 [inline]
>  kfree+0x10b/0x380 mm/slub.c:4598
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
> The buggy address belongs to the object at ffff888111e55b80
>  which belongs to the cache kmalloc-16 of size 16
> The buggy address is located 3 bytes inside of
>  freed 16-byte region [ffff888111e55b80, ffff888111e55b90)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x111e=
55
> flags: 0x200000000000000(node=3D0|zone=3D2)
> page_type: 0xfdffffff(slab)
> raw: 0200000000000000 ffff888100041640 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000000800080 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0=
(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9, tgid 9 (kworker/0:=
1), ts 108651586204, free_ts 108237529970
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
>  prep_new_page mm/page_alloc.c:1508 [inline]
>  get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3446
>  __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4702
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
>  allocate_slab mm/slub.c:2488 [inline]
>  new_slab+0x84/0x260 mm/slub.c:2541
>  ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
>  __slab_alloc_node mm/slub.c:3870 [inline]
>  slab_alloc_node mm/slub.c:4029 [inline]
>  __do_kmalloc_node mm/slub.c:4161 [inline]
>  __kmalloc_noprof+0x325/0x3c0 mm/slub.c:4174
>  kmalloc_noprof include/linux/slab.h:685 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  rh_call_control drivers/usb/core/hcd.c:491 [inline]
>  rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
>  usb_hcd_submit_urb+0x6b6/0x2090 drivers/usb/core/hcd.c:1529
>  usb_submit_urb+0x87c/0x1730 drivers/usb/core/urb.c:581
>  usb_start_wait_urb+0x103/0x4c0 drivers/usb/core/message.c:59
>  usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
>  usb_control_msg+0x327/0x4b0 drivers/usb/core/message.c:154
>  usb_clear_port_feature drivers/usb/core/hub.c:453 [inline]
>  hub_activate+0xb02/0x1d60 drivers/usb/core/hub.c:1230
>  hub_resume+0xaa/0x3f0 drivers/usb/core/hub.c:4005
>  usb_resume_interface.constprop.0.isra.0+0x2c8/0x3e0 drivers/usb/core/dri=
ver.c:1379
>  usb_resume_both+0x274/0x800 drivers/usb/core/driver.c:1539
> page last free pid 4937 tgid 4937 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1101 [inline]
>  free_unref_page+0x698/0xce0 mm/page_alloc.c:2619
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x4e/0x70 mm/kasan/common.c:322
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3992 [inline]
>  slab_alloc_node mm/slub.c:4041 [inline]
>  kmem_cache_alloc_noprof+0x11c/0x2b0 mm/slub.c:4048
>  getname_flags.part.0+0x4c/0x550 fs/namei.c:139
>  getname_flags include/linux/audit.h:322 [inline]
>  getname fs/namei.c:225 [inline]
>  __do_sys_unlink fs/namei.c:4534 [inline]
>  __se_sys_unlink fs/namei.c:4532 [inline]
>  __x64_sys_unlink+0xb0/0x110 fs/namei.c:4532
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888111e55a80: 00 00 fc fc 00 01 fc fc fa fb fc fc 00 00 fc fc
>  ffff888111e55b00: fa fb fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
> >ffff888111e55b80: fa fb fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
>                    ^
>  ffff888111e55c00: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>  ffff888111e55c80: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
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

