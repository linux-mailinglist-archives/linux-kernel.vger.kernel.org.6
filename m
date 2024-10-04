Return-Path: <linux-kernel+bounces-350114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FDA990012
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC8D1C23A03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB11547C4;
	Fri,  4 Oct 2024 09:41:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A141514EE;
	Fri,  4 Oct 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034895; cv=none; b=ifpmYi6kkPQIAPqJDCFpSDbIgQFlg3YPkK3AcvY8egRvA44hs9ZXQ8PaPdn0NNkSZsC91/Hhh6EV4LFPR2RfFScCQX7WeWSijvt7Mepsus1A7s0sH6JJtWduyLyv+yiAeZ/IdW6i+Y10uqKBlBnDiGwOBZUAXxECYOCBzsAbeMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034895; c=relaxed/simple;
	bh=F6TOiOTXaFP75m1kSPAmCfW4cJNNpGfzWfeBrZ2PDaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9T3fTuhifBK2BYfxI0+66jt2A441YgWjKA79EqvluyKew+WT9rcxWH5UJUFVj8E/geuzuoTNhEGNxRaZRAMf8bI0BnXCdJHZNcTVICvLxanANinjPD4NaE4hvykZ/Y7f139IxA5uCj1WnlTEv4a8e1QmtYFNw5xoXmDw+3JFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D5A339;
	Fri,  4 Oct 2024 02:42:00 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 449973F64C;
	Fri,  4 Oct 2024 02:41:29 -0700 (PDT)
Date: Fri, 4 Oct 2024 10:41:24 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Martin Botka <martin.botka@somainline.org>,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 3/5] mfd: axp20x: Allow multiple regulators
Message-ID: <20241004104124.7280c81a@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v64c-KoCwzfXpPbyLtxgZbwoQ+e4uYAk7pcHCkrTRbfr3A@mail.gmail.com>
References: <20241003111444.543964-1-andre.przywara@arm.com>
	<20241003111444.543964-4-andre.przywara@arm.com>
	<CAGb2v64c-KoCwzfXpPbyLtxgZbwoQ+e4uYAk7pcHCkrTRbfr3A@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

Hi Chen-Yu,

thanks for having a look!

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

Yeah, I was wondering about this as well. And it's two different PMICs here
as well: most A523/T527 system seem to come with an AXP717/AXP323 combo.
Though there are not linked together in any way, like in this master/slave
mode of the AXP806.
I will test on (your old) A80 board, and will add a Fixes: tag in v2,
should it also fail there.

> > Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
>=20
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks,
Andre

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


