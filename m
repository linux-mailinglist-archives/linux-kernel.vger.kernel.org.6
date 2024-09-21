Return-Path: <linux-kernel+bounces-334961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C153597DEEF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB544B213CD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C4F143C5D;
	Sat, 21 Sep 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W08UbkYK"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3C2F46;
	Sat, 21 Sep 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726952498; cv=none; b=eiuDn9F2eLgy/+uvgFFlMrJauU4QxF4h2R3iE9K2CPG4GeqidtvGird2Oyj/e27YprCsr7dCS3K1S9tRIIChOkj1HH1oDaMdfXX3mV/RQbcfqBTH5VnOWy9iZYgi6SCnBLjT1XYIOMAWHAGLIKb6+IYglbeMVuuC35ZlVje8ZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726952498; c=relaxed/simple;
	bh=tJandYMTZMPUrt/F/MUwUgfvEdbhBsike7w/LOz9o80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFvicD8NmNaD0R9jfHJY/VDphhEdOo+CoLKKRdY+xhwXBSyTwvlVhdD512UsrMm4Y3+hByKymIJR/dOhIUk2WNnE1otY5wKR5E0NqHtTT9dWyzB7KBCdLXSPLKo0cXejv915AThtvpHHRF5BCfP2WncdjF+Ptmx41lv8W91zoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W08UbkYK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-378e5d4a80eso2291035f8f.0;
        Sat, 21 Sep 2024 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726952495; x=1727557295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X2PdBfqJhMA+XJNjo2kd1jmzxim46TDC4fdTOTEvmM=;
        b=W08UbkYKMMADWHt49WN8GuhBl74KMkgj1+C0M+eJaWWqDEkiqerU0RgjkXSDvtcsgD
         Y7chCuaoUQgOlHI9wtqt7TUBOv1bKSh2J7ZFArO7UBaGpo+1/QgfDOYqVV3JFa4XpAi0
         4tO7TygU64Bp/iP7sObTeKqUrL8Me+SUjlKLyXouit1GhWobXIr6TEvNyl8rAkjqrD24
         duzESARWq36B+3YsPY9CYmTZy88J2HhZweRpgYzZmsWDMysiB/g6s+W9pl+eEtLDHQPZ
         +VYF7HJWlh6VKmy+sAhzD6MRt8NzjTUGLkRWdSgnBdO+zH7uXCTmwNGHzkPk3XTQB3cs
         7vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726952495; x=1727557295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X2PdBfqJhMA+XJNjo2kd1jmzxim46TDC4fdTOTEvmM=;
        b=wCL8W57rUenDgozIYmmnSMfQmOfoeJ0eSggijPeOcvt3rUClDL6rGEfPLkHwAj9MCY
         jtbw3+dKxqM/WGUfMYaN8HQXCEsTsS1u/+mCe/yK+bXUc01+eHxbPdMaYuuuuhyYRr2M
         XvPoWnc83HfAPpT5+CbD12iHX4v1CDntQd27x/frphaKMMIUhNVnAQGnNhfjkmUF4jwU
         4+p5vEvh/yC2zEOUlyaiQitGyl4K226hzvrlfMyAJ4xjhvTc5kQp23g8uQRZyTOYye/d
         bORpK5T3u2yDi4FSZxPMGt06DdOE22SOHe5DfV86YKvbvEUxBu5/oPHSVJnx/JxjjX4I
         eVNA==
X-Forwarded-Encrypted: i=1; AJvYcCUuLmD9WARz4XLFL4+pXMHaVg7a0Zoh6tHFw4HgtKR3P7zYDgsoDk9zErHxAaioyLaVTHdz9UlBxnMaCVs=@vger.kernel.org, AJvYcCVbZvdaYqRfqFrCNerkcDGWDvoVgffVncpDmTZ9mtP3jQMJlr9i9Vh2UHiAWGwpexecrDIxiyUmJ7U5@vger.kernel.org
X-Gm-Message-State: AOJu0YyxOKI0y2YdMgQv0p0vdsMsse4gU/6OeLe49bK6PWjAMyIByKBs
	wLFpXDKpNKlR9nRCNw+9rnh74tz49QXaf2Ecs3eOwtgptWbfgGSfGIvkx53fCLcxbRWb7uRJ1Dh
	TgxRX0KJ+nq47OvEW2ZOEEDKhx3M=
X-Google-Smtp-Source: AGHT+IGZSko3CRl+ICTCJCVlhLcUr4DWxulkyE8KAJ/2uRIl93Z5ZN5RP4XAAAbqBUxVe2cNCtsTKG78oSdgxT+ZUjE=
X-Received: by 2002:a5d:58e4:0:b0:368:64e:a7dd with SMTP id
 ffacd0b85a97d-37a42386bc8mr3778976f8f.53.1726952494897; Sat, 21 Sep 2024
 14:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000031ec6061fd3872e@google.com>
In-Reply-To: <000000000000031ec6061fd3872e@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 21 Sep 2024 23:01:24 +0200
Message-ID: <CA+fCnZcprcDQgGQvmVOCPih+S-+vLzkrvj3aw8mRDSz+5M91Hw@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in raw_release
To: syzbot <syzbot+b5e01354ba4aea02654b@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:20=E2=80=AFPM syzbot
<syzbot+b5e01354ba4aea02654b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d74da846046a Merge tag 'platform-drivers-x86-v6.11-3' of =
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15717e6b98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D801d05d1ea4be=
1b8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db5e01354ba4aea0=
2654b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/abf3bd7fae83/dis=
k-d74da846.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ab1df710091d/vmlinu=
x-d74da846.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/de4fcc24c87c/b=
zImage-d74da846.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b5e01354ba4aea02654b@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: double-free in dev_free drivers/usb/gadget/legacy/raw_gadget.=
c:225 [inline]
> BUG: KASAN: double-free in kref_put+0x4a8/0x7c0 include/linux/kref.h:65
> Free of addr ffff88807ce9ef00 by task syz.1.6138/1440
>
> CPU: 0 UID: 0 PID: 1440 Comm: syz.1.6138 Not tainted 6.11.0-rc3-syzkaller=
-00007-gd74da846046a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report_invalid_free+0x11a/0x140 mm/kasan/report.c:563
>  poison_slab_object+0xf4/0x150
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2252 [inline]
>  slab_free mm/slub.c:4473 [inline]
>  kfree+0x149/0x360 mm/slub.c:4594
>  dev_free drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
>  kref_put+0x4a8/0x7c0 include/linux/kref.h:65
>  raw_release+0x138/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:473
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  __do_sys_close fs/open.c:1566 [inline]
>  __se_sys_close fs/open.c:1551 [inline]
>  __x64_sys_close+0x7f/0x110 fs/open.c:1551
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f256497868a
> Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 2=
4 0c e8 13 8b 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 36 89 d7 89 44 24 0c e8 73 8b 02 00 8b 44 24
> RSP: 002b:00007f25657f0ff0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 00007f2564b16058 RCX: 00007f256497868a
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000009
> RBP: 00007f25649e78ee R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000009 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f2564b16058 R15: 00007f2564c3fa38
>  </TASK>
>
> Allocated by task 1440:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:4158 [inline]
>  __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4177
>  memdup_user+0x2b/0xc0 mm/util.c:226
>  raw_ioctl_ep_enable drivers/usb/gadget/legacy/raw_gadget.c:847 [inline]
>  raw_ioctl+0xd0f/0x3cd0 drivers/usb/gadget/legacy/raw_gadget.c:1318
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 1419:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2252 [inline]
>  slab_free mm/slub.c:4473 [inline]
>  kfree+0x149/0x360 mm/slub.c:4594
>  dev_free drivers/usb/gadget/legacy/raw_gadget.c:225 [inline]
>  kref_put+0x4a8/0x7c0 include/linux/kref.h:65
>  raw_release+0x138/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:473
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  __do_sys_close fs/open.c:1566 [inline]
>  __se_sys_close fs/open.c:1551 [inline]
>  __x64_sys_close+0x7f/0x110 fs/open.c:1551
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff88807ce9ef00
>  which belongs to the cache kmalloc-16 of size 16
> The buggy address is located 0 bytes inside of
>  16-byte region [ffff88807ce9ef00, ffff88807ce9ef10)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ce9=
e
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xfdffffff(slab)
> raw: 00fff00000000000 ffff888015841640 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000080800080 00000001fdffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0=
(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 605, tgid 605 (syz-ex=
ecutor), ts 2161207442978, free_ts 2155687277813
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
>  prep_new_page mm/page_alloc.c:1501 [inline]
>  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3442
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4700
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2321
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2484
>  new_slab mm/slub.c:2537 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
>  __slab_alloc+0x58/0xa0 mm/slub.c:3813
>  __slab_alloc_node mm/slub.c:3866 [inline]
>  slab_alloc_node mm/slub.c:4025 [inline]
>  __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4184
>  kmalloc_noprof include/linux/slab.h:681 [inline]
>  kzalloc_noprof include/linux/slab.h:807 [inline]
>  apparmor_sk_alloc_security+0x77/0x100 security/apparmor/lsm.c:1065
>  security_sk_alloc+0x75/0xb0 security/security.c:4689
>  sk_prot_alloc+0xfa/0x210 net/core/sock.c:2099
>  sk_alloc+0x38/0x370 net/core/sock.c:2149
>  inet_create+0x652/0xe70 net/ipv4/af_inet.c:326
>  __sock_create+0x490/0x920 net/socket.c:1571
>  sock_create net/socket.c:1622 [inline]
>  __sys_socket_create net/socket.c:1659 [inline]
>  __sys_socket+0x150/0x3c0 net/socket.c:1706
>  __do_sys_socket net/socket.c:1720 [inline]
>  __se_sys_socket net/socket.c:1718 [inline]
>  __x64_sys_socket+0x7a/0x90 net/socket.c:1718
> page last free pid 30679 tgid 30679 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1094 [inline]
>  free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
>  rcu_do_batch kernel/rcu/tree.c:2569 [inline]
>  rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
>  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inli=
ne]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:702
>
> Memory state around the buggy address:
>  ffff88807ce9ee00: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>  ffff88807ce9ee80: 00 00 fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
> >ffff88807ce9ef00: fa fb fc fc fa fb fc fc 00 03 fc fc fa fb fc fc
>                    ^
>  ffff88807ce9ef80: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>  ffff88807ce9f000: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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

