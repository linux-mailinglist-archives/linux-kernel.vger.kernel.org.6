Return-Path: <linux-kernel+bounces-350119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C164990024
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB0E1F24499
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F414B06A;
	Fri,  4 Oct 2024 09:42:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A514AD24;
	Fri,  4 Oct 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034953; cv=none; b=iIrmuvR4hm756fwdI5SONj9zeojqoEuGvemxOJaAiYghBts9u12D7TBqF/CpRTE0HTcSEfVP7RQ8VMj5uimqn7529dDiOO39+8G4XBKEeweL76zObMXYdTsiLZln/ZhvLhQt78uAjOyD3RUk5xxylS706zQsVI07+dpOn/gnEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034953; c=relaxed/simple;
	bh=qBrp9b2JFsXIIwmv/dzgme8ndotyZbizXpIi1iZzvW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTzh+zwU8DA9rwhbv+1qGv7Pk7V+oSYYeHBWuxWCkyBEZnsJKFHUiv3qX9JgqzIC0ErH0oly5y9Z1Njm7H6r45/cM1K5tH1pIWdHcHevMa218NXeqDlchn8qyWEVIPVAty0ZzoKXw6O9GMVE87ouAkQjzMg6igpIEihs0dzTn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AACD3339;
	Fri,  4 Oct 2024 02:43:00 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362B63F64C;
	Fri,  4 Oct 2024 02:42:29 -0700 (PDT)
Date: Fri, 4 Oct 2024 10:42:26 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Martin Botka <martin.botka@somainline.org>,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 4/5] mfd: axp20x: Add support for AXP323
Message-ID: <20241004104226.04534d8c@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v64jPk64Y-Aef1YPWkjCfp0eq6EasE2xszu8+WoX+Epv-A@mail.gmail.com>
References: <20241003111444.543964-1-andre.przywara@arm.com>
	<20241003111444.543964-5-andre.przywara@arm.com>
	<CAGb2v64jPk64Y-Aef1YPWkjCfp0eq6EasE2xszu8+WoX+Epv-A@mail.gmail.com>
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

On Thu, 3 Oct 2024 23:20:58 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Thu, Oct 3, 2024 at 7:15=E2=80=AFPM Andre Przywara <andre.przywara@arm=
.com> wrote:
> >
> > The X-Powers AXP323 is a very close sibling of the AXP313A. The only
> > difference seems to be the ability to dual-phase the first two DC/DC
> > converter, which adds another register.
> >
> > Add the required boilerplate to introduce a new PMIC to the AXP MFD
> > driver. Where possible, this just maps into the existing structs defined
> > for the AXP313A, only deviating where needed.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/mfd/axp20x-i2c.c   |  1 +
> >  drivers/mfd/axp20x.c       | 26 ++++++++++++++++++++++++++
> >  include/linux/mfd/axp20x.h |  2 ++
> >  3 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> > index 791a0b4cb64b..5c93136f977e 100644
> > --- a/drivers/mfd/axp20x-i2c.c
> > +++ b/drivers/mfd/axp20x-i2c.c
> > @@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[=
] =3D {
> >         { .compatible =3D "x-powers,axp221", .data =3D (void *)AXP221_I=
D },
> >         { .compatible =3D "x-powers,axp223", .data =3D (void *)AXP223_I=
D },
> >         { .compatible =3D "x-powers,axp313a", .data =3D (void *)AXP313A=
_ID },
> > +       { .compatible =3D "x-powers,axp323", .data =3D (void *)AXP323_I=
D },
> >         { .compatible =3D "x-powers,axp717", .data =3D (void *)AXP717_I=
D },
> >         { .compatible =3D "x-powers,axp803", .data =3D (void *)AXP803_I=
D },
> >         { .compatible =3D "x-powers,axp806", .data =3D (void *)AXP806_I=
D },
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index bc08ae433260..8d90962b56d9 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -42,6 +42,7 @@ static const char * const axp20x_model_names[] =3D {
> >         [AXP223_ID] =3D "AXP223",
> >         [AXP288_ID] =3D "AXP288",
> >         [AXP313A_ID] =3D "AXP313a",
> > +       [AXP323_ID] =3D "AXP323",
> >         [AXP717_ID] =3D "AXP717",
> >         [AXP803_ID] =3D "AXP803",
> >         [AXP806_ID] =3D "AXP806",
> > @@ -193,6 +194,10 @@ static const struct regmap_range axp313a_writeable=
_ranges[] =3D {
> >         regmap_reg_range(AXP313A_ON_INDICATE, AXP313A_IRQ_STATE),
> >  };
> >
> > +static const struct regmap_range axp323_writeable_ranges[] =3D {
> > +       regmap_reg_range(AXP313A_ON_INDICATE, AXP323_DCDC_MODE_CTRL2),
> > +};
> > +
> >  static const struct regmap_range axp313a_volatile_ranges[] =3D {
> >         regmap_reg_range(AXP313A_SHUTDOWN_CTRL, AXP313A_SHUTDOWN_CTRL),
> >         regmap_reg_range(AXP313A_IRQ_STATE, AXP313A_IRQ_STATE),
> > @@ -203,6 +208,11 @@ static const struct regmap_access_table axp313a_wr=
iteable_table =3D {
> >         .n_yes_ranges =3D ARRAY_SIZE(axp313a_writeable_ranges),
> >  };
> >
> > +static const struct regmap_access_table axp323_writeable_table =3D {
> > +       .yes_ranges =3D axp323_writeable_ranges,
> > +       .n_yes_ranges =3D ARRAY_SIZE(axp323_writeable_ranges),
> > +};
> > +
> >  static const struct regmap_access_table axp313a_volatile_table =3D {
> >         .yes_ranges =3D axp313a_volatile_ranges,
> >         .n_yes_ranges =3D ARRAY_SIZE(axp313a_volatile_ranges),
> > @@ -433,6 +443,15 @@ static const struct regmap_config axp313a_regmap_c=
onfig =3D {
> >         .cache_type =3D REGCACHE_MAPLE,
> >  };
> >
> > +static const struct regmap_config axp323_regmap_config =3D {
> > +       .reg_bits =3D 8,
> > +       .val_bits =3D 8,
> > +       .wr_table =3D &axp323_writeable_table,
> > +       .volatile_table =3D &axp313a_volatile_table,
> > +       .max_register =3D AXP323_DCDC_MODE_CTRL2,
> > +       .cache_type =3D REGCACHE_RBTREE, =20
>=20
> Maple tree instead?

Ah yes, you are right, this was lost over a rebase. Will fix in v2.

> The rest looks fine, so once fixed,
>=20
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
Andre

>=20
> > +};
> > +
> >  static const struct regmap_config axp717_regmap_config =3D {
> >         .reg_bits =3D 8,
> >         .val_bits =3D 8,
> > @@ -1221,6 +1240,7 @@ static int axp20x_power_off(struct sys_off_data *=
data)
> >         unsigned int shutdown_reg;
> >
> >         switch (axp20x->variant) {
> > +       case AXP323_ID:
> >         case AXP313A_ID:
> >                 shutdown_reg =3D AXP313A_SHUTDOWN_CTRL;
> >                 break;
> > @@ -1289,6 +1309,12 @@ int axp20x_match_device(struct axp20x_dev *axp20=
x)
> >                 axp20x->regmap_cfg =3D &axp313a_regmap_config;
> >                 axp20x->regmap_irq_chip =3D &axp313a_regmap_irq_chip;
> >                 break;
> > +       case AXP323_ID:
> > +               axp20x->nr_cells =3D ARRAY_SIZE(axp313a_cells);
> > +               axp20x->cells =3D axp313a_cells;
> > +               axp20x->regmap_cfg =3D &axp323_regmap_config;
> > +               axp20x->regmap_irq_chip =3D &axp313a_regmap_irq_chip;
> > +               break;
> >         case AXP717_ID:
> >                 axp20x->nr_cells =3D ARRAY_SIZE(axp717_cells);
> >                 axp20x->cells =3D axp717_cells;
> > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > index 79ecaaaa2070..c3df0e615fbf 100644
> > --- a/include/linux/mfd/axp20x.h
> > +++ b/include/linux/mfd/axp20x.h
> > @@ -19,6 +19,7 @@ enum axp20x_variants {
> >         AXP223_ID,
> >         AXP288_ID,
> >         AXP313A_ID,
> > +       AXP323_ID,
> >         AXP717_ID,
> >         AXP803_ID,
> >         AXP806_ID,
> > @@ -113,6 +114,7 @@ enum axp20x_variants {
> >  #define AXP313A_SHUTDOWN_CTRL          0x1a
> >  #define AXP313A_IRQ_EN                 0x20
> >  #define AXP313A_IRQ_STATE              0x21
> > +#define AXP323_DCDC_MODE_CTRL2         0x22
> >
> >  #define AXP717_ON_INDICATE             0x00
> >  #define AXP717_PMU_STATUS_2            0x01
> > --
> > 2.25.1
> > =20


