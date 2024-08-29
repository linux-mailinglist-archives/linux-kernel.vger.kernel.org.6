Return-Path: <linux-kernel+bounces-306128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B12963989
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE4286B28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691D7581F;
	Thu, 29 Aug 2024 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="FQFL/F+t";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="MAyWY/11"
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A94487B0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907208; cv=none; b=UsgzhQs2inzDUHAHeRKYPg+V+O1H3UyAYVGACWr35JK6K34KTIS5OVSeSfTeQpVkWvfccyQ+yzQlGr40oUmZIKkuMe/7z/i/tn5DdpnzNEL8r77N7WSvLSYXKdIO1wKhWRlXb+s1K0W/vLMghh91KJP11lcxvi5N718mBIgPEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907208; c=relaxed/simple;
	bh=vWRN8GDk/PZWv9onUtIniPDEz+cH5h9xFJ3pIAd7/jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DX4+Wti8Y3zYZyq/dhyng7RgUiOInlvkcNZfMETkddgyLbeUxPyYOqXTZPDBBX+0ZbfE167atwm409Qq/dhy9RO4vqrvkowKg3E5Od5sIbzVnwL5HnCHilTXEBtEFe27/LG+G8kI1NrRlYgg/KjKgpSIjOe1BHvnNmJK+HdW+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=FQFL/F+t; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=MAyWY/11; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724907207; x=1756443207;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=vWRN8GDk/PZWv9onUtIniPDEz+cH5h9xFJ3pIAd7/jk=;
  b=FQFL/F+tCTy9sHh8IhOiCpJzGJAi1kK2KQvB9PHrxGxrIIYytFj3dkTH
   SPWlNXGEAW6eACUSGAUQo1HwshJxochfmwlXfstrARSHBuZIohyBEkl+b
   caVUUFfQ00ReHHR9QLs2nRp4NPMCAUoods8OQAL985gPv6ttJjYWZIwG6
   0HZ6MDj2k2QcCDJXPbIuf98d6U3v1ZMbYl05mcbbxTFKHxeJBqw9Try/n
   2MGGF/dh9W6e9AYXJKDHbkvDz2MSlC/4MI53MOZ1sl+BL8mLibqm6sv0Q
   /emaoBYOVpfosPt2+NmaprPnKSABQhmzVaejKnDv42gMpEUDcEwGTbYO6
   w==;
X-CSE-ConnectionGUID: UNFLaWgAT5Wwk9I3IvcWAg==
X-CSE-MsgGUID: 50sKvfVySeq7y1N6eKY+pg==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 21:53:26 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f968e53b0so35681139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724907205; x=1725512005; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvbdCIAZoPSRQIRiURrONGlyZEULx7vGUPaM6+ggKQU=;
        b=MAyWY/11v8AuPTk6exVF/YB+ORPKHlv2Sau07TfFP4vMCgCGxz63COgNi6P/z1IkUo
         GMpW/9inh8u5sdLWLzo50osDvjewH3TxWgsYGLbNuMo20sA01kktNWqatGnFCoZOvbAF
         O2tQ7yiUsqemrDTLziNPKz0Fzijbhh5DkiIl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724907205; x=1725512005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvbdCIAZoPSRQIRiURrONGlyZEULx7vGUPaM6+ggKQU=;
        b=v6i/Ee8cqFPrxPcr3AyV5KytQi3XLI11ZK1asy7JVG69mRtGU8vv+xIvJ8Dj0/R7F1
         V5AxhgG+xmbkHFFi6pIzi6LkSTE4pjRuKdIOknHOm6QwsWxsu/tMXdVTCA+p+FfVj5cf
         f5HOPSOm11mntiVvy9EbbNpmffwIfgKc6WdfTJmG1yNZLw0EwNSI3WkopBVuQ9NPISpV
         9HM2xBjqJXySiy5PVMA0DTuSAfAl32rWkSj8O5BePjnIJk+/aNnYp0hP5+92/nr8XEch
         5I3YKr5Fexsn6c2OmRuz7BdDiCCJjOzCP7EYNXHLJBx0YRC5q6nj7Gx3KW1la5lehKM+
         zIiA==
X-Forwarded-Encrypted: i=1; AJvYcCVg93vhWihsoIXtAO+UQvdMbPNIq8A3Mip1AZQ8WsHlqLVgyD8iYPHJcgZX9LUJdmv5YNzNB2OcVGkF/jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOViC3u9KVBFtUVJqJ/Pi5R75EudX1+boVwKsq0JLtcPrS8zep
	ulnAd3L6vKX7vj43MgMCh0yrKq2E8265c1mnyEWCiXpTz8DXdXbkbG1msGa/mXdWxj7tpCPXTB3
	vvkRPal1usNHuolIFqiUHBcZuMjBm7FIu7wBNoYaqIpojEQZ0W3oz35/PlOR6aDvfDbJvUmHtZ9
	vVgN/eSCPvHh3lFCgUqBVoGZJ6zq/IzVx8ocD36g==
X-Received: by 2002:a92:cd82:0:b0:396:d1c5:e5f with SMTP id e9e14a558f8ab-39f377cb444mr22317805ab.6.1724907205107;
        Wed, 28 Aug 2024 21:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcwTyRjdhtHPn8fFiasa5L4D2qaBrkM7VAPOO3PIzhgsBOMN3eL7IUogzG0FaIeiEg6zw1KfFT30Ot+f97OkM=
X-Received: by 2002:a92:cd82:0:b0:396:d1c5:e5f with SMTP id
 e9e14a558f8ab-39f377cb444mr22317675ab.6.1724907204821; Wed, 28 Aug 2024
 21:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
In-Reply-To: <CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 21:53:14 -0700
Message-ID: <CALAgD-7JpFBhb1L+NXL9WoQP4hWbmfwsnWmePsER4SCud-BE9A@mail.gmail.com>
Subject: Re: WARNING in process_measurement
To: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The above syzkaller reproducer needs additional support. And here is
the C reproducer:
https://gist.github.com/freexxxyyy/c3d1ccb8104af6b0d51ed50c29b363d3

On Sat, Aug 24, 2024 at 10:23=E2=80=AFPM Xingyu Li <xli399@ucr.edu> wrote:
>
> Hi,
>
> We found a bug in Linux 6.10. This is likely a mutex corruption bug,
> where the mutex's internal state has been compromised, leading to an
> integrity check failure. The bug occurs in
> https://elixir.bootlin.com/linux/v6.10/source/security/integrity/ima/ima_=
main.c#L269.
>
> The bug report and syzkaller reproducer are as follows:
>
> Bug report:
>
> DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> __mutex_lock_common kernel/locking/mutex.c:587 [inline]
> WARNING: CPU: 0 PID: 8057 at kernel/locking/mutex.c:587
> __mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> Modules linked in:
> CPU: 0 PID: 8057 Comm: cron Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
> RIP: 0010:__mutex_lock+0xc2d/0xd50 kernel/locking/mutex.c:752
> Code: 04 20 84 c0 0f 85 13 01 00 00 83 3d fc e5 23 04 00 0f 85 e9 f4
> ff ff 48 c7 c7 60 70 4c 8b 48 c7 c6 e0 70 4c 8b e8 83 f4 54 f6 <0f> 0b
> e9 cf f4 ff ff 0f 0b e9 dc f8 ff ff 0f 0b e9 5b f5 ff ff 48
> RSP: 0018:ffffc9000aa77380 EFLAGS: 00010246
> RAX: 26a6b2d2d0cdac00 RBX: 0000000000000000 RCX: ffff8880241e5a00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000aa774d0 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> R10: dffffc0000000000 R11: ffffed100c74519b R12: dffffc0000000000
> R13: ffff888020efc330 R14: 0000000000000000 R15: 1ffff9200154eeb8
> FS:  00007f902ffb1840(0000) GS:ffff888063a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f902fb7e06a CR3: 0000000018c3c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  process_measurement+0x536/0x1ff0 security/integrity/ima/ima_main.c:269
>  ima_file_check+0xec/0x170 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0x51/0xb0 security/security.c:2982
>  do_open fs/namei.c:3656 [inline]
>  path_openat+0x2c0b/0x3580 fs/namei.c:3813
>  do_filp_open+0x22d/0x480 fs/namei.c:3840
>  do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
>  do_sys_open fs/open.c:1428 [inline]
>  __do_sys_openat fs/open.c:1444 [inline]
>  __se_sys_openat fs/open.c:1439 [inline]
>  __x64_sys_openat+0x243/0x290 fs/open.c:1439
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f903019a167
> Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85
> c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
> 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
> RSP: 002b:00007fff194600a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000564dd2fb9cf0 RCX: 00007f903019a167
> RDX: 0000000000000000 RSI: 00007f902fb7e103 RDI: 00000000ffffff9c
> RBP: 00007f902fb7e103 R08: 0000000000000008 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000564dd2fb9cf0 R14: 0000000000000001 R15: 0000000000000000
>  </TASK>
>
>
> Syzkaller reproducer:
> # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
> Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
> NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
> KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
> Wifi:false IEEE802154:true Sysctl:true Swap:false UseTmpDir:true
> HandleSegv:true Trace:false LegacyOptions:{Collide:false Fault:false
> FaultCall:0 FaultNth:0}}
> r0 =3D openat$ptmx(0xffffffffffffff9c, 0x0, 0x141040, 0x0)
> ioctl$TIOCSETD(r0, 0x5423, 0x0)
> mmap$IORING_OFF_CQ_RING(&(0x7f0000ffc000/0x4000)=3Dnil, 0x4000, 0x2,
> 0x20031, 0xffffffffffffffff, 0x8000000)
> mmap$IORING_OFF_SQ_RING(&(0x7f0000ff4000/0xc000)=3Dnil, 0xc000, 0xe,
> 0x12, 0xffffffffffffffff, 0x0)
> openat$sndseq(0xffffffffffffff9c, 0x0, 0x902)
> write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
> &(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf=
264340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b=
12ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6=
a300916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53b=
c414539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
> 0xb4)
> r1 =3D syz_open_dev$sg(&(0x7f00000003c0), 0x0, 0x8000)
> ioctl$syz_spec_1724254976_2866(r1, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
> [0x85, 0x8, 0x15, 0xd]})
> ioctl$KDGKBDIACR(0xffffffffffffffff, 0x4bfa, 0x0)
>
>
> --
> Yours sincerely,
> Xingyu



--=20
Yours sincerely,
Xingyu

