Return-Path: <linux-kernel+bounces-320548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B0A970BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520731C21997
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023B1422A8;
	Mon,  9 Sep 2024 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YwY6Yaal"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090928377
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849290; cv=none; b=sADmmiAsrMalFxERXj42ujgBNDWYrhFOafJntx8KHUUgBeFQXyCnWScSgv2xbLkHHMUX7ZPBg4QWqi1YLHzHo6DcepV2wXyzh7IcKydoDaKkiMy5cEARCVJybcBdwDMZF3zCqCKiKJwAPM5J13n+ehj90NKQicHvbi9eIC51qc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849290; c=relaxed/simple;
	bh=S35dfgsIzGXD6Kt/h/v50ggnL3BBepYxVflCyAkVaP4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NGF4ruDH++Yg52a2zYGWxrYqnkPZieKpq+rfPJ2f3f1arzn4Dgnv72O439WE0t6mlcOmqHUdizeTshIlV8hRNpBLRUqGL7RnNd4OGoMuemFUsmoXI4+MIkpgkm/sIlL1Mn8EWbM8nN4jBivEunIQQJhd7eyG81O/iXXyQ9m3Zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YwY6Yaal; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374b9761eecso2533543f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 19:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725849286; x=1726454086; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2U5k40hXiq8BqMAVZG6gqpRxk2ZEcFAorJo+PfYHGc=;
        b=YwY6Yaal4QbWhF1HtYCpy5neh7K4jxdnANYNcNgl/KZU9DLYpJlhZEecKh1kpATIGx
         fjDVYxl1r1k1OhmrO8r2CNbAddAzY7dvdrqSpt4k66eERhjPZLQpTFb+P7PhaJVbfFVH
         HgkJBTXkL22YGvMgZoavRmS81O7pGP8uEbqAmL6LSz9BbLsF7Gh77UYu8qR1kPcxipYk
         9t3ByHbw8LDL6Qf9GyEtWayDjsjrCNsLM+6Auxuk2LEwz6MocxbrXWbyKDc6Zsl6Klui
         nQSdTOpFIXSo2PCO69DzC0RVZrnBV7zvtj3r9AiInrZ7k+n3ZWbARjTabKHgddb9aNmo
         E2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725849286; x=1726454086;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2U5k40hXiq8BqMAVZG6gqpRxk2ZEcFAorJo+PfYHGc=;
        b=fDalWgdoxjCqv9QncZoDXDno3GFKZl1uZ7HUV6r+Tb7edWmpO9KSz87eeCQBDYcDyN
         kv32omqM0X6kF8ciYfbKRSqBOenqiY2s3+pUWWeiIzKFIC65Xoq1ZJ8CwFP1w0OIttvH
         If5BgbspOy/yegGioiPVuicY2WvcKfs9S8yuG/F/CCZanD8XBDVKpgFliOduXG0x42PN
         LgcLOSIA/VTDpk+XioQXliOcYR/JDiBE9rKr/dPfJnfWpoQ1WTVfHhWK1obuw6faCvXi
         BtP60Dxhc55yRjSU2zMJf4eN32mUXq5I07+WbxHYbAPlUCTsen7CJTCHMGh5BNK81+Ho
         swjA==
X-Forwarded-Encrypted: i=1; AJvYcCVmLoiYuwFN4V31Sar80N7Ejd5t0CsY/Kc/xoNXrhmNbZNU4+UjZGVokVyJE2pJPYOcjobz8AGiPoWlyFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbBrioaklGp1nJ+6rY5tNX3AAaOYtBhj+YlH/SDql5EpAuJcl
	7o0LBNInNTuNUPDbLH7sQ+9y9VbCTeWnPe0WGH2aMTMow/qK+deqcejmn4G5msE=
X-Google-Smtp-Source: AGHT+IHINWhFzRQMpoDqEcGOut+6Bc9YipC6/CILLhK+BhWQUeP62Hbabad+9VeHBssUVXOW2TLJFQ==
X-Received: by 2002:a5d:4983:0:b0:371:86b2:a7e4 with SMTP id ffacd0b85a97d-37889682e03mr5878900f8f.37.1725849286182;
        Sun, 08 Sep 2024 19:34:46 -0700 (PDT)
Received: from smtpclient.apple ([195.245.241.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823de8de7sm2969770a12.37.2024.09.08.19.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2024 19:34:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3816.100.2.1.1\))
Subject: Re: kernel BUG in gfs2_withdraw
From: Glass Su <glass.su@suse.com>
In-Reply-To: <CAHOo4gLpD0G6e9LAb3b8tRaEjcw1vo3TsqL7BV8ouv=dtnsJEw@mail.gmail.com>
Date: Mon, 9 Sep 2024 10:34:30 +0800
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <260BB329-0F7C-420C-906B-7E6076AD2FA2@suse.com>
References: <CAHOo4gLpD0G6e9LAb3b8tRaEjcw1vo3TsqL7BV8ouv=dtnsJEw@mail.gmail.com>
To: Hui Guo <guohui.study@gmail.com>
X-Mailer: Apple Mail (2.3816.100.2.1.1)



> On Aug 31, 2024, at 10:38, Hui Guo <guohui.study@gmail.com> wrote:
>=20
> Hi Kernel Maintainers,
> we found a crash "kernel BUG in gfs2_withdraw" (it seems a bug in
> gfs2) in upstream:
> This bug seems to have been triggered before and fixed, but it can
> still be triggered now.

IIUC, there is a new =E2=80=9Cbug=E2=80=9D. See comment below.
>=20
> HEAD Commit: d5d547aa7b51467b15d9caa86b116f8c2507c72a(Merge tag
> 'random-6.11-rc6-for-linus')
> console output:
> =
https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15=
d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/log0
> kernel config: =
https://github.com/androidAppGuard/KernelBugs/blob/main/6.11.config
> syz reproducer:
> =
https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15=
d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/repro.prog=

> C reproducer: =
https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15=
d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/repro.cpro=
g
> the state file of fs:
> =
https://github.com/androidAppGuard/KernelBugs/blob/main/d5d547aa7b51467b15=
d9caa86b116f8c2507c72a/0d1c927593a03040214498e5b44a9d7881a1def6/mount_0.gz=

>=20
> Best,
> Hui Guo
>=20
> The following context is the crash report.
>=20
> gfs2: fsid=3Dsyz:syz.0: fatal: invalid metadata block - bh =3D
> 1125899906854035 (bad magic number), function =3D gfs2_quota_init, =
file
> =3D fs/gfs2/quota.c, line =3D 1432
> gfs2: fsid=3Dsyz:syz.0: about to withdraw this file system
> ------------[ cut here ]------------
> kernel BUG at fs/gfs2/util.c:340!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 12970 Comm: syz.1.390 Not tainted
> 6.11.0-rc5-00081-gd5d547aa7b51 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 =
04/01/2014
> RIP: 0010:gfs2_withdraw+0xf32/0x11e0 =
data/linux_kernel/linux/fs/gfs2/util.c:340


The line triggers BUG_ON is:

BUG_ON(sdp->sd_args.ar_debug);

repro.cprog mounts the image with option =E2=80=9Cdebug=E2=80=9D which =
set sd_args.ar_debug.=20

memcpy((void*)0x20000000, "debug", 5);

The =E2=80=9Cdebug=E2=80=9D option should not be used in  production =
systems. Can you silence the syzbot issue?

=E2=80=94=20
Su


> Code: e6 e8 52 02 d2 fd 4d 85 e4 0f 84 5d ff ff ff e8 e4 fe d1 fd 4c
> 89 e7 e8 ec 3a 36 07 49 89 c4 e9 13 ff ff ff e8 cf fe d1 fd 90 <0f> 0b
> e8 c7 fe d1 fd be 08 00 00 00 48 89 ef e8 2a 3a 2d fe f0 80
> RSP: 0018:ffffc90017a8f6c0 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff88805ab0c000 RCX: ffffc9000f4d1000
> RDX: 0000000000040000 RSI: ffffffff83b80071 RDI: 0000000000000001
> RBP: ffff88805ab0c0a8 R08: 0000000000000001 R09: ffffed1005885179
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
> R13: 0000000000001001 R14: ffffc90017a8f750 R15: ffff88805ab0d1f8
> FS: 00007f0c2d8db640(0000) GS:ffff88802c400000(0000) =
knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc52c957a8c CR3: 00000000633d4000 CR4: 0000000000750ef0
> PKRU: 80000000
> Call Trace:
> <TASK>
> gfs2_meta_check_ii+0x65/0xa0 =
data/linux_kernel/linux/fs/gfs2/util.c:501
> gfs2_metatype_check_i data/linux_kernel/linux/fs/gfs2/util.h:126 =
[inline]
> gfs2_quota_init+0xfda/0x1360 =
data/linux_kernel/linux/fs/gfs2/quota.c:1432
> gfs2_make_fs_rw+0x3a2/0x5d0 =
data/linux_kernel/linux/fs/gfs2/super.c:159
> gfs2_fill_super+0x2887/0x2c00 =
data/linux_kernel/linux/fs/gfs2/ops_fstype.c:1274
> get_tree_bdev+0x378/0x600 data/linux_kernel/linux/fs/super.c:1635
> gfs2_get_tree+0x4e/0x280 =
data/linux_kernel/linux/fs/gfs2/ops_fstype.c:1329
> vfs_get_tree+0x94/0x380 data/linux_kernel/linux/fs/super.c:1800
> do_new_mount data/linux_kernel/linux/fs/namespace.c:3472 [inline]
> path_mount+0x6b2/0x1ea0 data/linux_kernel/linux/fs/namespace.c:3799
> do_mount data/linux_kernel/linux/fs/namespace.c:3812 [inline]
> __do_sys_mount data/linux_kernel/linux/fs/namespace.c:4020 [inline]
> __se_sys_mount data/linux_kernel/linux/fs/namespace.c:3997 [inline]
> __x64_sys_mount+0x284/0x310 =
data/linux_kernel/linux/fs/namespace.c:3997
> do_syscall_x64 data/linux_kernel/linux/arch/x86/entry/common.c:52 =
[inline]
> do_syscall_64+0xcb/0x250 =
data/linux_kernel/linux/arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0c2cb9b45e
> Code: 48 c7 c0 ff ff ff ff eb aa e8 5e 20 00 00 66 2e 0f 1f 84 00 00
> 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0c2d8dada8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 000000000003b2c4 RCX: 00007f0c2cb9b45e
> RDX: 000000002003b2c0 RSI: 000000002003b300 RDI: 00007f0c2d8dae00
> RBP: 00007f0c2d8dae40 R08: 00007f0c2d8dae40 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000002003b2c0
> R13: 000000002003b300 R14: 00007f0c2d8dae00 R15: 0000000020000000
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:gfs2_withdraw+0xf32/0x11e0 =
data/linux_kernel/linux/fs/gfs2/util.c:340
> Code: e6 e8 52 02 d2 fd 4d 85 e4 0f 84 5d ff ff ff e8 e4 fe d1 fd 4c
> 89 e7 e8 ec 3a 36 07 49 89 c4 e9 13 ff ff ff e8 cf fe d1 fd 90 <0f> 0b
> e8 c7 fe d1 fd be 08 00 00 00 48 89 ef e8 2a 3a 2d fe f0 80
> RSP: 0018:ffffc90017a8f6c0 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff88805ab0c000 RCX: ffffc9000f4d1000
> RDX: 0000000000040000 RSI: ffffffff83b80071 RDI: 0000000000000001
> RBP: ffff88805ab0c0a8 R08: 0000000000000001 R09: ffffed1005885179
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
> R13: 0000000000001001 R14: ffffc90017a8f750 R15: ffff88805ab0d1f8
> FS: 00007f0c2d8db640(0000) GS:ffff88802c400000(0000) =
knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc52c957a8c CR3: 00000000633d4000 CR4: 0000000000750ef0
> PKRU: 80000000
>=20


