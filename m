Return-Path: <linux-kernel+bounces-352648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06857992222
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB511C20B6D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9B18BC03;
	Sun,  6 Oct 2024 22:49:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB85189B82;
	Sun,  6 Oct 2024 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254976; cv=none; b=fPvKo9vaiNeWdhAHQRxOVcelqgGnl3hBJDaLkrDRv8tgCj4vPT62GMwgEujXe6rJPN7k8DRj3pXD4pjYjhe8PreP3C8TpHRGEZzA9aylAk6but6tAfwj+c9VK1vwyBJX6eesLWQDr0omdNTBrm7IZvoTR/15bwIMcQ8T9zqvjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254976; c=relaxed/simple;
	bh=IOOeMV89E7aNTUliK/fscRe2KpJ2omft6sLvy4jNzIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2pD/Q7j9IUn8kKHzLA7YXFhroNmQCd4UvRY39A9fyZDS/mXQEPYtNjDVLzSwCG9dMJiPhJG54yjOiT6UPZd56r3MjQA0cgbgEj+zd2aaZa/SgWGHDoVp0xya6RWW4/75XMQmgWlV2EDc1A3NaK4W1fY/QhxC+jZ2L0RpzDAkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66220FEC;
	Sun,  6 Oct 2024 15:50:03 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4478E3F640;
	Sun,  6 Oct 2024 15:49:32 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:48:49 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Martin Botka <martin.botka@somainline.org>,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 3/5] mfd: axp20x: Allow multiple regulators
Message-ID: <20241006234849.427682c7@minigeek.lan>
In-Reply-To: <CAGb2v64c-KoCwzfXpPbyLtxgZbwoQ+e4uYAk7pcHCkrTRbfr3A@mail.gmail.com>
References: <20241003111444.543964-1-andre.przywara@arm.com>
	<20241003111444.543964-4-andre.przywara@arm.com>
	<CAGb2v64c-KoCwzfXpPbyLtxgZbwoQ+e4uYAk7pcHCkrTRbfr3A@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 23:19:16 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Thu, Oct 3, 2024 at 7:15=E2=80=AFPM Andre Przywara <andre.przywara@arm=
.com> wrote:
> >
> > At the moment trying to register a second AXP chip makes the probe fail,
> > as some sysfs registration fails due to a duplicate name:
> >
> > ...
> > [    3.688215] axp20x-i2c 0-0035: AXP20X driver loaded
> > [    3.695610] axp20x-i2c 0-0036: AXP20x variant AXP323 found
> > [    3.706151] sysfs: cannot create duplicate filename '/bus/platform/d=
evices/axp20x-regulator'
> > [    3.714718] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-=
rc1-00026-g50bf2e2c079d-dirty #192
> > [    3.724020] Hardware name: Avaota A1 (DT)
> > [    3.728029] Call trace:
> > [    3.730477]  dump_backtrace+0x94/0xec
> > [    3.734146]  show_stack+0x18/0x24
> > [    3.737462]  dump_stack_lvl+0x80/0xf4
> > [    3.741128]  dump_stack+0x18/0x24
> > [    3.744444]  sysfs_warn_dup+0x64/0x80
> > [    3.748109]  sysfs_do_create_link_sd+0xf0/0xf8
> > [    3.752553]  sysfs_create_link+0x20/0x40
> > [    3.756476]  bus_add_device+0x64/0x104
> > [    3.760229]  device_add+0x310/0x760
> > [    3.763717]  platform_device_add+0x10c/0x238
> > [    3.767990]  mfd_add_device+0x4ec/0x5c8
> > [    3.771829]  mfd_add_devices+0x88/0x11c
> > [    3.775666]  axp20x_device_probe+0x70/0x184
> > [    3.779851]  axp20x_i2c_probe+0x9c/0xd8
> > ...
> >
> > This is because we use PLATFORM_DEVID_NONE for the mfd_add_devices()
> > call, which would number the child devices in the same 0-based way, even
> > for the second (or any other) instance.
> >
> > Use PLATFORM_DEVID_AUTO instead, which automatically assigns
> > non-conflicting device numbers. =20
>=20
> That's weird... I don't remember running into this when working on the A8=
0,
> which had two albeit different AXP chips. That was a long time ago though.

So I tested this on a Cubieboard 4, and it works there either way,
with or without this patch. That's RSB instead of I2C, which honestly
shouldn't make much of a difference, but maybe the call path differs?

But since it still works, I think this patch is correct regardless.

Thanks,
Andre


> > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
>=20
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>=20
> > ---
> >  drivers/mfd/axp20x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index 5ceea359289f..bc08ae433260 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -1419,7 +1419,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
> >                 }
> >         }
> >
> > -       ret =3D mfd_add_devices(axp20x->dev, -1, axp20x->cells,
> > +       ret =3D mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20=
x->cells,
> >                               axp20x->nr_cells, NULL, 0, NULL);
> >
> >         if (ret) {
> > --
> > 2.25.1
> > =20
>=20


