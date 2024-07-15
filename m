Return-Path: <linux-kernel+bounces-252998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500E931B05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37651F22C81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA371B52;
	Mon, 15 Jul 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vERtmmL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA626AB8;
	Mon, 15 Jul 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071824; cv=none; b=aBhfZ3O6D3WA+J8ZDHbBUqmBMrhn8IMl7IrDypbUPZxkEx8poXezl0zz/Li+aWlfA99WGtnB56JL8lcjOmMf/DKnF0V6/BQMV2BnsPBsxOGJV+SUvvc/by0uNjRUwo7COgZfyiowVO4O98rCWFGwFyhNvnTGV8pfGjkemtY797M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071824; c=relaxed/simple;
	bh=tGsUF26rthjSBOBNFtY5VI/KJK9SJct6xyHxzeNGIcE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mzseMHk6Fm5WiB98vOs5SzuW1Baxeia23Yb4E3rATIyIi6YQTc0VhowC/NsnWieHvDATeQ6diRSgF0eVo52EiGd7053+Y/Lcw12IQ8u3zgFTC16bYm4YIQ1jZRgSVV/98RpHSE7ksdA4zTrGDWoNqF1bQ2oqiPisiBodAiyBQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vERtmmL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AEEC4AF0A;
	Mon, 15 Jul 2024 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071823;
	bh=tGsUF26rthjSBOBNFtY5VI/KJK9SJct6xyHxzeNGIcE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=vERtmmL1W5S/u1Jf/veSawCHamOAtTMmNGMq1V1sKzAqWs3SE+8G7gPVxQkKheRLX
	 MJDS+voZwuGaRu4KMYt36b8VCdF3j9V2RSxY7ZN0KEW4+QYDWKI9N58rnaulSrNyoZ
	 r6tdoyTR6sM84yArcvrbwRQ9JC2GnG9bEqDvkEZSb0qOGEQo9T59bxxVHLZLYvhsMA
	 kWh07SW1LzwKCS9TQwqRZHBVckNPGaainWN59/4mHIEb1mOfLHVSLAakB4RmLtNppd
	 epWZmJEru0uTD7FKwuz2Rn7B6hnk/h3v/VX7XmLRmgdFJHqYZfGuwOGC1Jn3+L7ZXb
	 GwUVZjy8yFocA==
Message-ID: <7db2d8ae07a9ef1a226dfd08a3f88f8a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jv81cgv4z.fsf@starbuckisacylon.baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com> <20240710162526.2341399-8-jbrunet@baylibre.com> <88d1dbd92e922ad002367d8dac67d0eb.sboyd@kernel.org> <1jv81cgv4z.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH 7/8] reset: amlogic: add auxiliary reset driver support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 15 Jul 2024 12:30:21 -0700
User-Agent: alot/0.10

Quoting Jerome Brunet (2024-07-11 02:01:16)
> On Wed 10 Jul 2024 at 15:49, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Jerome Brunet (2024-07-10 09:25:16)
> >> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> >> index e34a10b15593..5cc767d50e8f 100644
> >> --- a/drivers/reset/reset-meson.c
> >> +++ b/drivers/reset/reset-meson.c
> > [...]
> >> +
> >> +int devm_meson_rst_aux_register(struct device *dev,
> >> +                               struct regmap *map,
> >> +                               const char *adev_name)
> >> +{
> >> +       struct meson_reset_adev *raux;
> >> +       struct auxiliary_device *adev;
> >> +       int ret;
> >> +
> >> +       raux =3D kzalloc(sizeof(*raux), GFP_KERNEL);
> >> +       if (!raux)
> >> +               return -ENOMEM;
> >> +
> >> +       ret =3D ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
> >
> > Do we expect more than one device with the same name? I wonder if the
> > IDA can be skipped.
>=20
> I've wondered about that too.
>=20
> I don't think it is the case right now but I'm not 100% sure.
> Since I spent time thinking about it, I thought it would just be safer (a=
nd
> relatively cheap) to put in and enough annoying debugging the
> expectation does not hold true.
>=20
> I don't have a strong opinion on this. What do you prefer ?

I don't have a strong opinion either so it's fine to leave it there.

> >> diff --git a/include/soc/amlogic/meson-auxiliary-reset.h b/include/soc=
/amlogic/meson-auxiliary-reset.h
> >> new file mode 100644
> >> index 000000000000..8fdb02b18d8c
> >> --- /dev/null
> >> +++ b/include/soc/amlogic/meson-auxiliary-reset.h
> >> @@ -0,0 +1,23 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef __SOC_AMLOGIC_MESON_AUX_RESET_H
> >> +#define __SOC_AMLOGIC_MESON_AUX_RESET_H
> >> +
> >> +#include <linux/err.h>
> >> +
> >> +struct device;
> >> +struct regmap;
> >> +
> >> +#ifdef CONFIG_RESET_MESON
> >> +int devm_meson_rst_aux_register(struct device *dev,
> >> +                               struct regmap *map,
> >> +                               const char *adev_name);
> >> +#else
> >> +static inline int devm_meson_rst_aux_register(struct device *dev,
> >> +                                             struct regmap *map,
> >> +                                             const char *adev_name)
> >> +{
> >> +       return -EOPNOTSUPP;
> >
> > Shouldn't this be 'return 0' so that the clk driver doesn't have to care
> > about the config?
>=20
> I don't think the system (in general) would be able function without the =
reset
> driver, so the question is rather phylosophical.
>=20
> Let's say it could, if this returns 0, consumers of the reset controller
> will defer indefinitely ... which is always a bit more difficult to sort
> out.
>=20
> If it returns an error, the problem is pretty obvious, helping people
> solve it quickly.
>=20
> Also the actual device we trying to register provides clocks and reset.
> It is not like the reset is an optional part we don't care about.
>=20
> On this instance it starts from clock, but it could have been the other
> way around. Both are equally important.
>=20
> I'd prefer if it returns an error when the registration can't even start.
>=20

Ok. Fair enough.

