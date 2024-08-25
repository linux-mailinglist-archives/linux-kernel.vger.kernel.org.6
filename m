Return-Path: <linux-kernel+bounces-300229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50995E0D7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266A81C20D25
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3117C61;
	Sun, 25 Aug 2024 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="nG/jGa0b";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fDAxZ56V"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4AF9DF
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557458; cv=none; b=TkYpnkMrdvDk/H0rIuWrIgJAeSMSXSU7GN94Z4Z21c3tDg6qcgRa0OE2RdhNg86icqn1yw1znGSkhjPfasbQB0VroCQRPdxsRNoSrWlDpTswzVODl3Ja2Eb+FAMAAbfRvoqaner+rR5No96xERh87Ln55Zoj7l9kY76vEbLbJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557458; c=relaxed/simple;
	bh=FM7whOXNd89QmiEQN7nmFm0ChdBqJCYLOGAlFoljVJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=E+woo0cvK+bhnhxIJa5FLXrgb6ZnrRD5OUffaV7Ud7Ijb9yBDgRNPQujWscDbdN7ZoOmPEUSG/7QWeExpthGoyBjXYd3o44x4qFScEBK7Utqm/9XMGPL0FXZXdpbPIASChiZL4P20XCgzdbA4xPzupmML6DIhbgkgtLHEgcsTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=nG/jGa0b; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=fDAxZ56V; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724557456; x=1756093456;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=FM7whOXNd89QmiEQN7nmFm0ChdBqJCYLOGAlFoljVJ4=;
  b=nG/jGa0bEcvKNajHQYUKVdP9p3tCeQffmRafH8W4DwDvj+GZeDEThweK
   BJg4MjLgykuZ9K9uIQQ6MVUBXphCfxaaMmT03rPOndOek5RRW9Y0fLU/C
   6MxvEB3y3iGrdbp4F04Pa7PiUQZzONfXspEEeVwI6RL+tyO/xcag6Cvr4
   0dQ+kPIPe4TxsFWRiNtGIqtf2iju/2Y+eoEkbZm2hz2KgxW8PzwKjSjmi
   ySWt+BtIU6YqRE8kPox/UzCpEX+1MrqGY+yuh+1wQaj/5lO9GlM158CTs
   1XWJbMUwUO8QbDkFaK4xIg0x50WjNecw8d43OzJs3bmrOaH0oPE6cpBAd
   w==;
X-CSE-ConnectionGUID: KNhvH+VlSniMkBHUow6gkQ==
X-CSE-MsgGUID: V2phmNmdRayDurViYCxCxA==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 20:44:15 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d432914cc7so2837564a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 20:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724557455; x=1725162255; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WlNFO+ztLG6nNab5HHTwGPu+w5ltrPjK5YCSFxoG/5g=;
        b=fDAxZ56V0Xh35QyyS52lN97wBZDfGylT+8gJ+cwRgvxanH1bPrh8kuE42EsO1nlInM
         wIP56SY5VSMVGHcoEEipMor8jqeBZA6Oi3rVwNObKoE7XTSNLvKtAqBPBlFF6dOWnJYb
         ggIOFFuTdwrNmI4DenPDSAvEE8EX6IN3i2VrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724557455; x=1725162255;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlNFO+ztLG6nNab5HHTwGPu+w5ltrPjK5YCSFxoG/5g=;
        b=vVNFt8AVltzlKgcxZab+cNGj+9RIyTiO+Y3kodh17Ovig9mITeWMHqhcL1jmTeK9lz
         ROisUD2ePPgEmMZBJfoSk3Xxg6kxbTHo+JhAWk2q08hapTZCo2warnmrw848AViBGShD
         a5I4zPfJ/jjCUJrLhxUkurloT4AXuUi5n7dV8wg1K5o6skapdCjR6Jk5N4dTOk+4Mr9f
         Czf8jbOw7bv9C6Zb/CqfVrafwk20ujDHfuA397uzW43gQ1JO7XCTtKIn+ViCP0RsWUsi
         47voKussolpnESAMPUeCl+H1W3IH2k4JdKvgqg5y65Fwh3UViRa7+B0BEb3BvFhEIImc
         YYkw==
X-Forwarded-Encrypted: i=1; AJvYcCVTInQMVQrox0HzaX7+C30QZ8+CmovFjFM0SjY75Q6iSdBrtmmQCdMENELs5pvtl5skslQnqsyE/M/RTf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxnayWpgNZwvfu1XhAd9GBwsBfqJ+dCiHNNInew7CN8YyKxjN
	Mke9+o63Se1oPLx3WmJ52qPE44+gkL1veJiNQ84qKk8p1AQHmalRuNmrR7aTUZ9uEDfgHwCu7VT
	5xGuT0MwYPyxbZ2rkUQyT+x8bhiOXIF3+/saRgRNPJwIIgNkRO4hkxL3oyeQgpp5rgbGU/kzTqE
	IA0LOCBTmo6iKhOGfhJxNT+CGURmdur6AAFqOhSEO9wXfKUjIT
X-Received: by 2002:a17:90a:ff17:b0:2c8:2cd1:881b with SMTP id 98e67ed59e1d1-2d60aa0f083mr16910248a91.20.1724557454677;
        Sat, 24 Aug 2024 20:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU+HsVb/G5ejwZ52uDwS7YiO4LT+f3lOluJtWwrv+4yYkeEbROdJ0e06yk4D07CQzPf2+4FqMGy+N+GHKxs4w=
X-Received: by 2002:a17:90a:ff17:b0:2c8:2cd1:881b with SMTP id
 98e67ed59e1d1-2d60aa0f083mr16910233a91.20.1724557454242; Sat, 24 Aug 2024
 20:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 20:44:03 -0700
Message-ID: <CALAgD-4b_yFdN4fwPxpXEpJkcxEwXBxRHeQjeA3x3rMX4JpUwA@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in stack_depot_save_flags
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a null pointer dereference bug in Linux v6.10 using syzkaller.
We listed the bug report and the syzkaller reproducer as below:

Bug report:

BUG: kernel NULL pointer dereference, address: 0000000000000010
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 55851 Comm: syz-executor Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:find_stack lib/stackdepot.c:553 [inline]
RIP: 0010:stack_depot_save_flags+0x19a/0x840 lib/stackdepot.c:618
Code: 48 89 54 24 18 31 f6 4c 89 44 24 10 e8 1f 78 c7 ff 31 f6 4c 8b
44 24 10 48 8b 54 24 18 45 85 e4 75 62 4d 8b 3f 49 39 d7 74 5d <45> 39
77 10 75 f2 45 39 47 14 75 ec 31 c0 49 8b 4c c5 00 49 3b 4c
RSP: 0018:ffffc9000479ed30 EFLAGS: 00010207
RAX: ffff888134c00000 RBX: 0000000000000001 RCX: 000000000022f640
RDX: ffff888134e2f640 RSI: 0000000000000000 RDI: 0000000021439b4f
RBP: 000000000000001c R08: 000000000000001c R09: 1ffffffff1e48be5
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: ffffffff845e6c46
R13: ffffc9000479ed90 R14: 00000000c7222f64 R15: 0000000000000000
FS:  000055558666b500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000001ae74000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x4d/0x70 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x62/0x70 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmem_cache_alloc_noprof+0x13a/0x2c0 mm/slub.c:4009
 fill_pool lib/debugobjects.c:168 [inline]
 debug_objects_fill_pool+0x796/0x9a0 lib/debugobjects.c:615
 debug_object_activate+0x34/0x4a0 lib/debugobjects.c:704
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common kernel/rcu/tree.c:3057 [inline]
 call_rcu+0x93/0xa60 kernel/rcu/tree.c:3176
 kernfs_put+0x1d6/0x340 fs/kernfs/dir.c:578
 kernfs_remove_by_name_ns+0xdb/0x150 fs/kernfs/dir.c:1695
 kernfs_remove_by_name include/linux/kernfs.h:625 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xfa/0x2c0 fs/sysfs/group.c:319
 sysfs_remove_groups+0x50/0xa0 fs/sysfs/group.c:343
 device_remove_groups drivers/base/core.c:2833 [inline]
 device_remove_attrs+0x1d8/0x290 drivers/base/core.c:2963
 device_del+0x512/0x940 drivers/base/core.c:3867
 unregister_netdevice_many_notify+0x11a3/0x16d0 net/core/dev.c:11249
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x2ff/0x370 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 nsim_destroy+0x17c/0x5b0 drivers/net/netdevsim/netdev.c:778
 __nsim_dev_port_del+0x14a/0x1b0 drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x282/0x480 drivers/net/netdevsim/dev.c:1658
 nsim_drv_remove+0x54/0x160 drivers/net/netdevsim/dev.c:1673
 device_remove drivers/base/dd.c:566 [inline]
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x4a6/0x7b0 drivers/base/dd.c:1293
 bus_remove_device+0x377/0x440 drivers/base/bus.c:574
 device_del+0x51a/0x940 drivers/base/core.c:3868
 device_unregister+0x17/0xb0 drivers/base/core.c:3909
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
 del_device_store+0x35b/0x470 drivers/net/netdevsim/bus.c:226
 kernfs_fop_write_iter+0x3ae/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x8a1/0xc70 fs/read_write.c:590
 ksys_write+0x19b/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f7a8717f49f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 8c 02 00 48 8b 54
24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 1c 8d 02 00 48
RSP: 002b:00007ffe05a55700 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f7a8717f49f
RDX: 0000000000000001 RSI: 00007ffe05a55750 RDI: 0000000000000005
RBP: 00007f7a871f5fcf R08: 0000000000000000 R09: 00007ffe05a55557
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007ffe05a55750 R14: 00007f7a87e74620 R15: 0000000000000003
 </TASK>
Modules linked in:
CR2: 0000000000000010
---[ end trace 0000000000000000 ]---
RIP: 0010:find_stack lib/stackdepot.c:553 [inline]
RIP: 0010:stack_depot_save_flags+0x19a/0x840 lib/stackdepot.c:618
Code: 48 89 54 24 18 31 f6 4c 89 44 24 10 e8 1f 78 c7 ff 31 f6 4c 8b
44 24 10 48 8b 54 24 18 45 85 e4 75 62 4d 8b 3f 49 39 d7 74 5d <45> 39
77 10 75 f2 45 39 47 14 75 ec 31 c0 49 8b 4c c5 00 49 3b 4c
RSP: 0018:ffffc9000479ed30 EFLAGS: 00010207
RAX: ffff888134c00000 RBX: 0000000000000001 RCX: 000000000022f640
RDX: ffff888134e2f640 RSI: 0000000000000000 RDI: 0000000021439b4f
RBP: 000000000000001c R08: 000000000000001c R09: 1ffffffff1e48be5
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: ffffffff845e6c46
R13: ffffc9000479ed90 R14: 00000000c7222f64 R15: 0000000000000000
FS:  000055558666b500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000001ae74000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 48 89 54 24 18       mov    %rdx,0x18(%rsp)
   5: 31 f6                 xor    %esi,%esi
   7: 4c 89 44 24 10       mov    %r8,0x10(%rsp)
   c: e8 1f 78 c7 ff       call   0xffc77830
  11: 31 f6                 xor    %esi,%esi
  13: 4c 8b 44 24 10       mov    0x10(%rsp),%r8
  18: 48 8b 54 24 18       mov    0x18(%rsp),%rdx
  1d: 45 85 e4             test   %r12d,%r12d
  20: 75 62                 jne    0x84
  22: 4d 8b 3f             mov    (%r15),%r15
  25: 49 39 d7             cmp    %rdx,%r15
  28: 74 5d                 je     0x87
* 2a: 45 39 77 10           cmp    %r14d,0x10(%r15) <-- trapping instruction
  2e: 75 f2                 jne    0x22
  30: 45 39 47 14           cmp    %r8d,0x14(%r15)
  34: 75 ec                 jne    0x22
  36: 31 c0                 xor    %eax,%eax
  38: 49 8b 4c c5 00       mov    0x0(%r13,%rax,8),%rcx
  3d: 49                   rex.WB
  3e: 3b                   .byte 0x3b
  3f: 4c                   rex.WR

Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true
NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false
DevlinkPCI:false NicVF:false USB:true VhciInjection:false Wifi:false
IEEE802154:true Sysctl:true Swap:true UseTmpDir:true HandleSegv:false
Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0
FaultNth:0}}
ioctl$TCSETSF2(0xffffffffffffffff, 0x402c542d,
&(0x7f0000000080)={0xffffffff, 0x80000001, 0x9, 0x5, 0x1,
"59a5c6499e35bca140f08427393b336889f0cc", 0x2, 0x101})
r0 = syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x8000)
openat$ptmx(0xffffffffffffff9c, 0x0, 0x80, 0x0)
ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)={0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})





-- 
Yours sincerely,
Xingyu

