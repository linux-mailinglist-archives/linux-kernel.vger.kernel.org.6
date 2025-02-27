Return-Path: <linux-kernel+bounces-536344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24186A47E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E73165523
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7CB22DF92;
	Thu, 27 Feb 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TiGeMy2g"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F222D7B2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661137; cv=none; b=oHIrUfe/5TQokXP8OvegzBeHEFNzmsCvYDJH0n2E6cdD0pB30EASIr7Or4Jm+wrj3Qez8mhgUOorMUT24bD6AaJLH2YqCE6zTZFDJ3Oz+ar8H+0MBWHGQmQGJ94IBesexG41b+ylGA5t2CObA76sPINBRvn481VVEhpT3a70sWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661137; c=relaxed/simple;
	bh=dT5L81QZd9ml7f0jsryPGQHSjzeNso4RNMuuRronL0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iUr0FxAQLfdD15z/gAseE+aLl2jYhDrCs/VuRfHuOsUGKXYSuElp1W7qlJSvciQukzt2wrEkY25J3D5ru/LFco1X569UDYJHdT0lN3mWQpngho2Pjr+2P2nssDlhUav3uZoJMmrTL9+OSabxqrlrOY3hiAQzENhNqPJlW4Rodo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TiGeMy2g; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E66641CFD;
	Thu, 27 Feb 2025 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740661132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTE06Wbb2OM49gD1uO4FAF7+EIpzsE2Tg148tPUePjg=;
	b=TiGeMy2gnXL56gcnNnUa6+KDH4trUyUhrlGUFxpqCwRLZamVhG/3XjaPYG2wBQN1/I8juu
	rswIjddQLWYeZqrnvkN31X/PeHOM7jaeMDYSrPdfyhX8DKkzkUMPaPDtqWx+ENAMUcBebL
	1PTmrHPg0r3KzZJg3Dnm6byql9VtCpf05o/uiZjmAm/+8ZRghz3LePfAoGVdHU8aHnueTl
	pT429UjuA2yuP3MmgpbhmLCeM0gKTV2cKprlo3b0jXEZtF8R05g0u1iFsp57zprLRuxZUR
	yBOZzxXKZGrzGXdpiO8UrvjXLeXOZ3Qvw363iuni5bu/6balSCwNuUCyVOACNQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: florian.fainelli@broadcom.com,  Brian Norris
 <computersforpeace@gmail.com>,  Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,  Kamal Dasu
 <kdasu@broadcom.com>
Subject: Re: [PATCH] mtd: rawnand: brcmnand: fix PM resume warning
In-Reply-To: <20250226225356.16380-1-kamal.dasu@broadcom.com> (Kamal Dasu's
	message of "Wed, 26 Feb 2025 17:53:09 -0500")
References: <20250226225356.16380-1-kamal.dasu@broadcom.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 13:58:49 +0100
Message-ID: <874j0fczna.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppedvudejrdduuddvrddukeelrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrudduvddrudekledrudekuddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehkrghmrghlrdgurghsuhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopegtohhmphhuthgvrhhsfhhorhhpvggrtggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghom
 hdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Kamal,

On 26/02/2025 at 17:53:09 -05, Kamal Dasu <kamal.dasu@broadcom.com> wrote:

> Fixed warning due to unintialized struct nand_operation op->cs
> WARN_ON(op->cs >=3D nanddev_ntargets(&chip->base)
>
> [   14.588522] ------------[ cut here ]------------
> [   14.588529] WARNING: CPU: 0 PID: 1392 at drivers/mtd/nand/raw/internal=
s.h:139 nand_reset_op+0x1e0/0x1f8
> [   14.588553] Modules linked in: bdc udc_core
> [   14.588579] CPU: 0 UID: 0 PID: 1392 Comm: rtcwake Tainted: G        W =
         6.14.0-rc4-g5394eea10651 #16
> [   14.588590] Tainted: [W]=3DWARN
> [   14.588593] Hardware name: Broadcom STB (Flattened Device Tree)
> [   14.588598] Call trace:
> [   14.588604]  dump_backtrace from show_stack+0x18/0x1c
> [   14.588622]  r7:00000009 r6:0000008b r5:60000153 r4:c0fa558c
> [   14.588625]  show_stack from dump_stack_lvl+0x70/0x7c
> [   14.588639]  dump_stack_lvl from dump_stack+0x18/0x1c
> [   14.588653]  r5:c08d40b0 r4:c1003cb0
> [   14.588656]  dump_stack from __warn+0x84/0xe4
> [   14.588668]  __warn from warn_slowpath_fmt+0x18c/0x194
> [   14.588678]  r7:c08d40b0 r6:c1003cb0 r5:00000000 r4:00000000
> [   14.588681]  warn_slowpath_fmt from nand_reset_op+0x1e0/0x1f8
> [   14.588695]  r8:70c40dff r7:89705f41 r6:36b4a597 r5:c26c9444 r4:c26b00=
48
> [   14.588697]  nand_reset_op from brcmnand_resume+0x13c/0x150
> [   14.588714]  r9:00000000 r8:00000000 r7:c24f8010 r6:c228a3f8 r5:c26c94=
bc r4:c26b0040
> [   14.588717]  brcmnand_resume from platform_pm_resume+0x34/0x54
> [   14.588735]  r5:00000010 r4:c0840a50
> [   14.588738]  platform_pm_resume from dpm_run_callback+0x5c/0x14c
> [   14.588757]  dpm_run_callback from device_resume+0xc0/0x324
> [   14.588776]  r9:c24f8054 r8:c24f80a0 r7:00000000 r6:00000000 r5:000000=
10 r4:c24f8010
> [   14.588779]  device_resume from dpm_resume+0x130/0x160
> [   14.588799]  r9:c22539e4 r8:00000010 r7:c22bebb0 r6:c24f8010 r5:c22539=
dc r4:c22539b0
> [   14.588802]  dpm_resume from dpm_resume_end+0x14/0x20
> [   14.588822]  r10:c2204e40 r9:00000000 r8:c228a3fc r7:00000000 r6:00000=
003 r5:c228a414
> [   14.588826]  r4:00000010
> [   14.588828]  dpm_resume_end from suspend_devices_and_enter+0x274/0x6f8
> [   14.588848]  r5:c228a414 r4:00000000
> [   14.588851]  suspend_devices_and_enter from pm_suspend+0x228/0x2bc
> [   14.588868]  r10:c3502910 r9:c3501f40 r8:00000004 r7:c228a438 r6:c0f95=
e18 r5:00000000
> [   14.588871]  r4:00000003
> [   14.588874]  pm_suspend from state_store+0x74/0xd0
> [   14.588889]  r7:c228a438 r6:c0f934c8 r5:00000003 r4:00000003
> [   14.588892]  state_store from kobj_attr_store+0x1c/0x28
> [   14.588913]  r9:00000000 r8:00000000 r7:f09f9f08 r6:00000004 r5:c35029=
00 r4:c0283250
> [   14.588916]  kobj_attr_store from sysfs_kf_write+0x40/0x4c
> [   14.588936]  r5:c3502900 r4:c0d92a48
> [   14.588939]  sysfs_kf_write from kernfs_fop_write_iter+0x104/0x1f0
> [   14.588956]  r5:c3502900 r4:c3501f40
> [   14.588960]  kernfs_fop_write_iter from vfs_write+0x250/0x420
> [   14.588980]  r10:c0e14b48 r9:00000000 r8:c25f5780 r7:00443398 r6:f09f9=
f68 r5:c34f7f00
> [   14.588983]  r4:c042a88c
> [   14.588987]  vfs_write from ksys_write+0x74/0xe4
> [   14.589005]  r10:00000004 r9:c25f5780 r8:c02002f0 r7:00000000 r6:00000=
000 r5:c34f7f00
> [   14.589008]  r4:c34f7f00
> [   14.589011]  ksys_write from sys_write+0x10/0x14
> [   14.589029]  r7:00000004 r6:004421c0 r5:00443398 r4:00000004
> [   14.589032]  sys_write from ret_fast_syscall+0x0/0x5c
> [   14.589044] Exception stack(0xf09f9fa8 to 0xf09f9ff0)
> [   14.589050] 9fa0:                   00000004 00443398 00000004 0044339=
8 00000004 00000001
> [   14.589056] 9fc0: 00000004 00443398 004421c0 00000004 b6ecbd58 0000000=
8 bebfbc38 0043eb78
> [   14.589062] 9fe0: 00440eb0 bebfbaf8 b6de18a0 b6e579e8
> [   14.589065] ---[ end trace 0000000000000000 ]---
>
> The fix uses the higher level nand_reset(chip, chipnr); where chipnr =3D =
0, when
> doing PM resume operation in compliance with the controller support for s=
ingle die
> nand chip. This ensures that the op->cs is initialized before calling the
> nand_reset_op().

While I believe the fix is correct, the explanation is partially
satisfying because you focus on the Warning reported above (which indeed
needs fixing) whereas the bigger problem you have is the fact that your
NAND chip is probably no longer in sync timing wise with the
host. Switching from nand_reset_op() to nand_reset() implies more than
just setting the cs field, it also reconfigures the data interface
(ie. the timings). I believe this is important enough to be mentioned.

> Fixes : 97d90da8a886 ("mtd: nand: provide several helpers to do common NA=
ND operations")

Please add Cc: stable@ here.

> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>

Thanks,
Miqu=C3=A8l

