Return-Path: <linux-kernel+bounces-306118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805F963972
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9602B1C224CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15756A039;
	Thu, 29 Aug 2024 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ADRz6zEf";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="H6upLvPH"
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E6647
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724906294; cv=none; b=TTPoScaC0Dk5sF4ba2+3HtoX5bEvR80WKMowq5aaWPjAaNopfdW8u+/XEhQLMlRg+RtnFs/gPdlK+HB63Jwd0t/iOdAaXkwcN4n7J9qCjbJQ5GqFhkCEZlFcXh3shXjufgLrjBiMAr8nvClmt1Mlrs2/8ndw2IlFyUqAAL2EeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724906294; c=relaxed/simple;
	bh=atx/l4fpPMI7luyxqDTfQvYNekJUFV6JoQzeZCJaIGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tQCvn8PDGZCQQOxDDahkbElBHoaD0Cr1DqEjAsgMVIjyo2SBKkEQbxW9+AsAzvwI4HVrSCko9rRtZQ5bmzTTEdpepOKL1Bm4Dtj0g83Rm5sX0oj5f7rpl01oCCc1qR1zGaltBWzYEDvJnjj+r0EQur2KYr1Vp+RfsYDFzdhrCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=ADRz6zEf; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=H6upLvPH; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724906293; x=1756442293;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=atx/l4fpPMI7luyxqDTfQvYNekJUFV6JoQzeZCJaIGQ=;
  b=ADRz6zEfVPZ0k8iXnlHbE0LqmJGiRRxbEEffVQyj3ukmD7rJ9XxVG0O/
   /OqNcrkvqj4wZAMwyXHbOlSojuK5LE5rEdl23NMhlu1Ss1XBhYJnbwzc0
   CdvX57eHwWV9u57uM8LaqcHnhPDFdTHtCbgdRCblXuODbQ0XTTIlKWjrs
   hT/4kJMM5Nt9sipl5EdbttlWIku4E1XqUrGoBTodIgunXaBFmXQprvlmH
   qHJDLQPOKGSDl5YR7AsIrBRqldDG2BbW44gx9lNp+j4Ktk6q73hV2Uron
   2ZBSZpDkPDxJvmcDdycFD8OZG9+jEX1brtzGSbF36goYkPehHOjnlQFRx
   w==;
X-CSE-ConnectionGUID: LDuVlYjLSku4SB3gVHauyw==
X-CSE-MsgGUID: J9PIWfbuQECBIcm5WsNkMQ==
Received: from mail-il1-f199.google.com ([209.85.166.199])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 21:38:12 -0700
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d415635e6so2371015ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724906291; x=1725511091; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdlARSVWN+OmghoPF5G/EiYZnFNvWdDAGsYxJZbeCCE=;
        b=H6upLvPH93vJsGzQn+FBlTyZzdIswkEREiTDfraGra6xQ4z/jDLIsobVtU0rgE0RhF
         7czP4iDaTNn8VDH+mM2rBKefu/V0zlQhi8GRUzHnyRh2jrzG2fWMacbwR/nRcdFRL2DK
         dVZ/db1ZMe1AZbJwoXu3w6h5EF8JjS1ljui7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724906291; x=1725511091;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdlARSVWN+OmghoPF5G/EiYZnFNvWdDAGsYxJZbeCCE=;
        b=mqf1s8WKATIqCGhhTTt/Jn2kUfiRlmC+hEDRXRJQMGvr7FyC1NsSedBktGJEFwdLGe
         2e685TNvTTkUgkaHxQmKaxLlIIAZfYxQar7s9NC1w1JX3nU3/BcJmFttjM2+23baMq0Y
         F3+e46BzddaPUs8HpJ1JOf+5ORxhC0pChsRc3tHnpkpID98w9H7MbpdzO1o853pdK4C1
         tW9LeJ5UjzbcIr2XH6Wc3Dy5WHGk8M2e2wZ9WWauIdhPjQpnIu9GRcDkikmS7RjUmrFY
         EYogFLEPLeYu6rseuNThfe7bKa5WijcYHx9mS6hbmjs1BBL49iJ4vHaQ5usZ3TYZGz9c
         ZmHA==
X-Forwarded-Encrypted: i=1; AJvYcCVkIGkc421kTTWNxNHvCoYYpE0125OWALQYzGFaCiM+hLP9IaukuSPFTJ4OH2Epx8ruUhhzO36UAWOcMhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgs/gHBkdF6ej8WEkU86Ka2BkCd3aqtfC1KsFDUSi/aM9UZ0u
	k1nDFT3wW9h1sZr41mq+r1iQ12SL90YWE9lAYGV332XCKBIgmQuFVsDFGG+wg8OYypDCT8twjKQ
	D3UC0WoeLTALMLLnwPvGxBuWzJW+wQVNv9hoAqssWjqwT4nG29BRmBrUnGTmpG4wxvsc5Q18Y+x
	cfSJaNkf2JrsfuI3e889jrafnteabX6rWACfblOw==
X-Received: by 2002:a92:ca0e:0:b0:39d:20e2:1eea with SMTP id e9e14a558f8ab-39f377f0c3dmr23415755ab.10.1724906291199;
        Wed, 28 Aug 2024 21:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEteLNIHqL1htoQE8tW6f3813wsdNKuZ1+75vzrFQ35bYTwr54NMqTH6NYdrx1Bx49oiwg5p0x780goKtMlfEs=
X-Received: by 2002:a92:ca0e:0:b0:39d:20e2:1eea with SMTP id
 e9e14a558f8ab-39f377f0c3dmr23415655ab.10.1724906290844; Wed, 28 Aug 2024
 21:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4b_yFdN4fwPxpXEpJkcxEwXBxRHeQjeA3x3rMX4JpUwA@mail.gmail.com>
In-Reply-To: <CALAgD-4b_yFdN4fwPxpXEpJkcxEwXBxRHeQjeA3x3rMX4JpUwA@mail.gmail.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 21:38:00 -0700
Message-ID: <CALAgD-6CtS=LNAmGDYAUXWFjyq3nSKT=KCH-+bkhkGAT2-i88A@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in stack_depot_save_flags
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The above reproducer needs the additional support to run it. And here
is the C reproducer:
https://gist.github.com/freexxxyyy/de291db74555bd26fcbade9e16e14157

On Sat, Aug 24, 2024 at 8:44=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Hi,
>
> We found a null pointer dereference bug in Linux v6.10 using syzkaller.
> We listed the bug report and the syzkaller reproducer as below:
>
> Bug report:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000010
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 55851 Comm: syz-executor Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:find_stack lib/stackdepot.c:553 [inline]
> RIP: 0010:stack_depot_save_flags+0x19a/0x840 lib/stackdepot.c:618
> Code: 48 89 54 24 18 31 f6 4c 89 44 24 10 e8 1f 78 c7 ff 31 f6 4c 8b
> 44 24 10 48 8b 54 24 18 45 85 e4 75 62 4d 8b 3f 49 39 d7 74 5d <45> 39
> 77 10 75 f2 45 39 47 14 75 ec 31 c0 49 8b 4c c5 00 49 3b 4c
> RSP: 0018:ffffc9000479ed30 EFLAGS: 00010207
> RAX: ffff888134c00000 RBX: 0000000000000001 RCX: 000000000022f640
> RDX: ffff888134e2f640 RSI: 0000000000000000 RDI: 0000000021439b4f
> RBP: 000000000000001c R08: 000000000000001c R09: 1ffffffff1e48be5
> R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: ffffffff845e6c46
> R13: ffffc9000479ed90 R14: 00000000c7222f64 R15: 0000000000000000
> FS:  000055558666b500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 000000001ae74000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kasan_save_stack mm/kasan/common.c:48 [inline]
>  kasan_save_track+0x4d/0x70 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:312 [inline]
>  __kasan_slab_alloc+0x62/0x70 mm/kasan/common.c:338
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3940 [inline]
>  slab_alloc_node mm/slub.c:4002 [inline]
>  kmem_cache_alloc_noprof+0x13a/0x2c0 mm/slub.c:4009
>  fill_pool lib/debugobjects.c:168 [inline]
>  debug_objects_fill_pool+0x796/0x9a0 lib/debugobjects.c:615
>  debug_object_activate+0x34/0x4a0 lib/debugobjects.c:704
>  debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
>  __call_rcu_common kernel/rcu/tree.c:3057 [inline]
>  call_rcu+0x93/0xa60 kernel/rcu/tree.c:3176
>  kernfs_put+0x1d6/0x340 fs/kernfs/dir.c:578
>  kernfs_remove_by_name_ns+0xdb/0x150 fs/kernfs/dir.c:1695
>  kernfs_remove_by_name include/linux/kernfs.h:625 [inline]
>  remove_files fs/sysfs/group.c:28 [inline]
>  sysfs_remove_group+0xfa/0x2c0 fs/sysfs/group.c:319
>  sysfs_remove_groups+0x50/0xa0 fs/sysfs/group.c:343
>  device_remove_groups drivers/base/core.c:2833 [inline]
>  device_remove_attrs+0x1d8/0x290 drivers/base/core.c:2963
>  device_del+0x512/0x940 drivers/base/core.c:3867
>  unregister_netdevice_many_notify+0x11a3/0x16d0 net/core/dev.c:11249
>  unregister_netdevice_many net/core/dev.c:11277 [inline]
>  unregister_netdevice_queue+0x2ff/0x370 net/core/dev.c:11156
>  unregister_netdevice include/linux/netdevice.h:3119 [inline]
>  nsim_destroy+0x17c/0x5b0 drivers/net/netdevsim/netdev.c:778
>  __nsim_dev_port_del+0x14a/0x1b0 drivers/net/netdevsim/dev.c:1425
>  nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
>  nsim_dev_reload_destroy+0x282/0x480 drivers/net/netdevsim/dev.c:1658
>  nsim_drv_remove+0x54/0x160 drivers/net/netdevsim/dev.c:1673
>  device_remove drivers/base/dd.c:566 [inline]
>  __device_release_driver drivers/base/dd.c:1270 [inline]
>  device_release_driver_internal+0x4a6/0x7b0 drivers/base/dd.c:1293
>  bus_remove_device+0x377/0x440 drivers/base/bus.c:574
>  device_del+0x51a/0x940 drivers/base/core.c:3868
>  device_unregister+0x17/0xb0 drivers/base/core.c:3909
>  nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
>  del_device_store+0x35b/0x470 drivers/net/netdevsim/bus.c:226
>  kernfs_fop_write_iter+0x3ae/0x500 fs/kernfs/file.c:334
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0x8a1/0xc70 fs/read_write.c:590
>  ksys_write+0x19b/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f7a8717f49f
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 8c 02 00 48 8b 54
> 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 1c 8d 02 00 48
> RSP: 002b:00007ffe05a55700 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f7a8717f49f
> RDX: 0000000000000001 RSI: 00007ffe05a55750 RDI: 0000000000000005
> RBP: 00007f7a871f5fcf R08: 0000000000000000 R09: 00007ffe05a55557
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
> R13: 00007ffe05a55750 R14: 00007f7a87e74620 R15: 0000000000000003
>  </TASK>
> Modules linked in:
> CR2: 0000000000000010
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:find_stack lib/stackdepot.c:553 [inline]
> RIP: 0010:stack_depot_save_flags+0x19a/0x840 lib/stackdepot.c:618
> Code: 48 89 54 24 18 31 f6 4c 89 44 24 10 e8 1f 78 c7 ff 31 f6 4c 8b
> 44 24 10 48 8b 54 24 18 45 85 e4 75 62 4d 8b 3f 49 39 d7 74 5d <45> 39
> 77 10 75 f2 45 39 47 14 75 ec 31 c0 49 8b 4c c5 00 49 3b 4c
> RSP: 0018:ffffc9000479ed30 EFLAGS: 00010207
> RAX: ffff888134c00000 RBX: 0000000000000001 RCX: 000000000022f640
> RDX: ffff888134e2f640 RSI: 0000000000000000 RDI: 0000000021439b4f
> RBP: 000000000000001c R08: 000000000000001c R09: 1ffffffff1e48be5
> R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: ffffffff845e6c46
> R13: ffffc9000479ed90 R14: 00000000c7222f64 R15: 0000000000000000
> FS:  000055558666b500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 000000001ae74000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0: 48 89 54 24 18       mov    %rdx,0x18(%rsp)
>    5: 31 f6                 xor    %esi,%esi
>    7: 4c 89 44 24 10       mov    %r8,0x10(%rsp)
>    c: e8 1f 78 c7 ff       call   0xffc77830
>   11: 31 f6                 xor    %esi,%esi
>   13: 4c 8b 44 24 10       mov    0x10(%rsp),%r8
>   18: 48 8b 54 24 18       mov    0x18(%rsp),%rdx
>   1d: 45 85 e4             test   %r12d,%r12d
>   20: 75 62                 jne    0x84
>   22: 4d 8b 3f             mov    (%r15),%r15
>   25: 49 39 d7             cmp    %rdx,%r15
>   28: 74 5d                 je     0x87
> * 2a: 45 39 77 10           cmp    %r14d,0x10(%r15) <-- trapping instruct=
ion
>   2e: 75 f2                 jne    0x22
>   30: 45 39 47 14           cmp    %r8d,0x14(%r15)
>   34: 75 ec                 jne    0x22
>   36: 31 c0                 xor    %eax,%eax
>   38: 49 8b 4c c5 00       mov    0x0(%r13,%rax,8),%rcx
>   3d: 49                   rex.WB
>   3e: 3b                   .byte 0x3b
>   3f: 4c                   rex.WR
>
> Syzkaller reproducer:
> # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
> Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true
> NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false
> DevlinkPCI:false NicVF:false USB:true VhciInjection:false Wifi:false
> IEEE802154:true Sysctl:true Swap:true UseTmpDir:true HandleSegv:false
> Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0
> FaultNth:0}}
> ioctl$TCSETSF2(0xffffffffffffffff, 0x402c542d,
> &(0x7f0000000080)=3D{0xffffffff, 0x80000001, 0x9, 0x5, 0x1,
> "59a5c6499e35bca140f08427393b336889f0cc", 0x2, 0x101})
> r0 =3D syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x8000)
> openat$ptmx(0xffffffffffffff9c, 0x0, 0x80, 0x0)
> ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
> [0x85, 0x8, 0x15, 0xd]})
>
>
>
>
>
> --
> Yours sincerely,
> Xingyu



--=20
Yours sincerely,
Xingyu

