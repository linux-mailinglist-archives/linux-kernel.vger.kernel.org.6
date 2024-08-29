Return-Path: <linux-kernel+bounces-306120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A7963977
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8810F286EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FEF146A63;
	Thu, 29 Aug 2024 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="UeUh0dlL";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="outCnuJv"
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9F487B0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724906511; cv=none; b=tuzrqqBWOtGa0lpdJ+v8Zx/8f1bVD5/5J/ViDJPLLLLMTnWEaJ3pjmcZk5yrnIkg2bE3PIl391KPM8L6lfn9KTII4DgXbN7JUVan0zv+6GRgU3624WseR/IS6dWMYOdD+iWvfjbs2oGFmkC8rpy385YYF5mNqd+Oz6HLCDGn1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724906511; c=relaxed/simple;
	bh=N55K+lqbtokbpeHPyQLp1yp/8pY1FCalwIwiCLBpKkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Rt/rEMOD/3wTkXi0DozJa1zrDeoPdFBqs939T5d1hOTUOBcFTpmG/5VMXNesFqQy7mQsJaSL0JfmJ+z1UaMsKmFOPMBte6wwlMIYgonAFehiakWkjcwFkEKtd059R1BBqHyJ+ALMItTjV/7sK1OerCCXO3AGdJx755rtVE7aOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=UeUh0dlL; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=outCnuJv; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724906511; x=1756442511;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=N55K+lqbtokbpeHPyQLp1yp/8pY1FCalwIwiCLBpKkA=;
  b=UeUh0dlL92YARZtuZ1bsH4S4Hw3aTDEZ6UHDh/GAbLXlmmhC9Y7OEOQy
   hHaUyJl+qOTvUBgpYBr7UWU3Ue+Fs7FDHZXShW3CLbs1WBVhAK2qeuNeX
   Hp+bEAU68VJK5gOpF5RU8gfaP3jmrd2+iJmBP7UE6kmJVxUutgHS0Wgbq
   BBHi87blj5W7AFKtMfTBNZXw3ptMvX580lWGOKMC4Qvseaws1BQd+GqPB
   367ZZQTnWOkW1hihCJzpAT+OwwwKjv4Zp81gNElZORRn2sVHBUzvprSZP
   reIGVto2uBnFXD4vr1oRTQdAN10vGZe2XnGc5kNS31eTDp4ID4DOSh8J+
   w==;
X-CSE-ConnectionGUID: ee5sJiUOTx6phWqQkeJzEw==
X-CSE-MsgGUID: WRtwkC/2SrKMIp4KhX21jA==
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 21:41:50 -0700
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-827878b9901so31998039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724906508; x=1725511308; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j+Tr1fFva5Li+Ga0XiTnVTvMJm0cBj4PqOZtjjYmfc=;
        b=outCnuJvJZtv8IjELxrklFJTPUTaynOo0xw/23R3MgHCWo6u1khV97v+Q8V53siYa1
         9MIGM6+VT7kIrXmXKycP581PttcTx9WlHfGy7gFJpDdrqbBQ6IL7neBhfKTI+119uqbl
         3ekswwf/zfHkFrBdy9ByNrmuRXtxOHA170UQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724906508; x=1725511308;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j+Tr1fFva5Li+Ga0XiTnVTvMJm0cBj4PqOZtjjYmfc=;
        b=B3+WkykN0Z9mEn5bfCdgHnJcLR6HexYFHMaHlda75cHAdAqoVvvghzesjex6uqa8F5
         XEC/Ky2wIz2eO75cO0Cz00WYKs7oFSePmJDJbsG3IYNSJWuva1JPRHjnQseegKksB5RM
         vjXGA/IIbPuAiTrXvKiJm344KYismh/s1XLZj2nHRTwwe5SzQZ01bjrHFpxhJbl1yVlM
         Efd7OEyiOiu5jY5uFHTeFTRl+JH/R5IDyPQ3qJqDvFtwfuo9A53yhyXFdi7rFywrGFT1
         0mExmUgyCyW0Vrydn5ezl+xj63mk8ee7U0X5BcmKddc+yrnbx1Z6Pp2FreBaVzUqqAGm
         Ieow==
X-Forwarded-Encrypted: i=1; AJvYcCVs+8ui2B5cgTzSnVOdrMXPUf8VYa2VvXuGH8GAZJ9jmGuY9s+QqLPXF2liu/PrCCnwW6sDy/O+fVXwSEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUpThATP7rypVlRyFtAy3Ku1UhxdhBF6cIQjblW4O6JXi3dVd
	6aa3YBS7igHXsuVfWOtx8K5TfQ3hbEbHMOfCiazaH9PNiuNyRH5tUkglyOYT2GtUew3+TzU1e+6
	+tfHBi5jfeMA1NTvAPYbVCLZBvdBuqXVCEIQYZmnVb+VTrct7OPao/1oj9E3deLXoVgK8fq035D
	XrisCvbHwIvvi/rbgmwuZaU/BV8OsexbtYyFvE4g==
X-Received: by 2002:a05:6e02:1a45:b0:375:ab93:5062 with SMTP id e9e14a558f8ab-39f377ce3aamr23072795ab.2.1724906508418;
        Wed, 28 Aug 2024 21:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0J3dNTe+2qV9lkdosRKxuXnkdEpRNntNeKXq+3Q4rNxHOZTihRQyUG0HNWH5h/RZ0JCROzgSHDqHxfuZ05CM=
X-Received: by 2002:a05:6e02:1a45:b0:375:ab93:5062 with SMTP id
 e9e14a558f8ab-39f377ce3aamr23072685ab.2.1724906508006; Wed, 28 Aug 2024
 21:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-58VEomA47Srga5H-p6cZa0zPj+y3E1se0rHb3gj4UvyA@mail.gmail.com>
In-Reply-To: <CALAgD-58VEomA47Srga5H-p6cZa0zPj+y3E1se0rHb3gj4UvyA@mail.gmail.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 21:41:37 -0700
Message-ID: <CALAgD-61-PHPuazoRmBRe7KFDTrnr4mwn5vg8fU2rRMjWUw2kA@mail.gmail.com>
Subject: Re: BUG: general protection fault in batadv_bla_del_backbone_claims
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the C reproducer:
https://gist.github.com/freexxxyyy/b5d77fc4396caf3b79d88fb2a12ef0ff

On Fri, Aug 23, 2024 at 7:10=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Hello,
>
> We found the following issue using syzkaller on Linux v6.10.
>
> It seems to be a null pointer dereference bug
> Need to check the `fi=3D=3DNULL` before 'fi->fib_dead' on line 1587 of
> net/ipv4/fib_trie.c
>
> The bug report is:
>
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
> CPU: 0 PID: 9032 Comm: syz.0.15 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:fib_table_lookup+0x709/0x1790 net/ipv4/fib_trie.c:1587
> Code: 38 f3 75 4c e8 38 b9 15 f8 49 be 00 00 00 00 00 fc ff df eb 05
> e8 27 b9 15 f8 48 8b 44 24 20 48 8d 58 44 48 89 d8 48 c1 e8 03 <42> 8a
> 04 30 84 c0 0f 85 76 03 00 00 0f b6 1b 31 ff 89 de e8 df bb
> RSP: 0018:ffffc90004acf020 EFLAGS: 00010203
> RAX: 0000000000000008 RBX: 0000000000000044 RCX: ffff88801db88000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90004acf170 R08: ffffffff897b97ee R09: 1ffffffff221f8b0
> R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: 1ffff11003b1bbe6
> R13: ffff88801d8ddf20 R14: dffffc0000000000 R15: ffff88801d8ddf30
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0cfb3b48d0 CR3: 000000001811e000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __inet_dev_addr_type+0x2e9/0x510 net/ipv4/fib_frontend.c:225
>  inet_addr_type_dev_table net/ipv4/fib_frontend.c:267 [inline]
>  fib_del_ifaddr+0x1114/0x14b0 net/ipv4/fib_frontend.c:1320
>  fib_inetaddr_event+0xcc/0x1f0 net/ipv4/fib_frontend.c:1448
>  notifier_call_chain kernel/notifier.c:93 [inline]
>  blocking_notifier_call_chain+0x126/0x1d0 kernel/notifier.c:388
>  __inet_del_ifa+0x87a/0x1020 net/ipv4/devinet.c:437
>  inet_del_ifa net/ipv4/devinet.c:474 [inline]
>  inetdev_destroy net/ipv4/devinet.c:327 [inline]
>  inetdev_event+0x664/0x1590 net/ipv4/devinet.c:1633
>  notifier_call_chain kernel/notifier.c:93 [inline]
>  raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
>  call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
>  call_netdevice_notifiers net/core/dev.c:2044 [inline]
>  unregister_netdevice_many_notify+0xd65/0x16d0 net/core/dev.c:11219
>  unregister_netdevice_many net/core/dev.c:11277 [inline]
>  unregister_netdevice_queue+0x2ff/0x370 net/core/dev.c:11156
>  unregister_netdevice include/linux/netdevice.h:3119 [inline]
>  __tun_detach+0x6ad/0x15e0 drivers/net/tun.c:685
>  tun_detach drivers/net/tun.c:701 [inline]
>  tun_chr_close+0x104/0x1b0 drivers/net/tun.c:3500
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  task_work_run+0x239/0x2f0 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa13/0x2560 kernel/exit.c:876
>  do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
>  get_signal+0x1697/0x1730 kernel/signal.c:2909
>  arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
>  do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f38fcb809b9
> Code: Unable to access opcode bytes at 0x7f38fcb8098f.
> RSP: 002b:00007ffca268d598 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: 0000000000000002 RBX: 00007f38fcd45f80 RCX: 00007f38fcb809b9
> RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
> RBP: 00007f38fcbf4f70 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f38fcd45f80 R14: 00007f38fcd45f80 R15: 0000000000000d01
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:fib_table_lookup+0x709/0x1790 net/ipv4/fib_trie.c:1587
> Code: 38 f3 75 4c e8 38 b9 15 f8 49 be 00 00 00 00 00 fc ff df eb 05
> e8 27 b9 15 f8 48 8b 44 24 20 48 8d 58 44 48 89 d8 48 c1 e8 03 <42> 8a
> 04 30 84 c0 0f 85 76 03 00 00 0f b6 1b 31 ff 89 de e8 df bb
> RSP: 0018:ffffc90004acf020 EFLAGS: 00010203
> RAX: 0000000000000008 RBX: 0000000000000044 RCX: ffff88801db88000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90004acf170 R08: ffffffff897b97ee R09: 1ffffffff221f8b0
> R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: 1ffff11003b1bbe6
> R13: ffff88801d8ddf20 R14: dffffc0000000000 R15: ffff88801d8ddf30
> FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2a89116b60 CR3: 00000000202c2000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> --
> Yours sincerely,
> Xingyu



--=20
Yours sincerely,
Xingyu

