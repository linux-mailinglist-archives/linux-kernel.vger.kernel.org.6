Return-Path: <linux-kernel+bounces-331667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEEA97AFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59ADE1F24361
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F9A169AC5;
	Tue, 17 Sep 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdnjA14E"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382ED1547E6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573282; cv=none; b=PKwpeOVzY+06JckzITBt4rxMhraaREAxO2j/gENaMrO1HGzHRxU8NX6DvtjNWxxOiXKSdvnaXERrRMS9/R5enUdHaHdOY6RhbvFYsQgAbCfFvRIf6C6Bl3MO68T534fB8/H9Um9+YhK8sNiiffWtBdcDSvwftzCgUfNdc+UASn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573282; c=relaxed/simple;
	bh=jz0FE0Kf675baCmwmaa4cz9aN8rAv8r7cgzxmXwFamI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N0/OUx0IRF3hRoMYkb2hoMWZhOC5n1fPny/ryXxYhmeFXgpIhexsCX4Kxg4VBNq+b24lUuOClrBgiTkR31hVmveARbZALmRzXWMPnCXLiyoMxFVajNo8Fzfq9rQHriKmGXXNwQbl3v9zbj+PztYtg+NSpnNyn+I2F4dnfS4xyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HdnjA14E; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso919966666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726573279; x=1727178079; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBWxTLIwaRXzz2B6lBD4X89iivmw4HPn5CVhIHdb5b4=;
        b=HdnjA14Eo8G/eygl4QXA/kUdAo9m+07PH1fiSHlUnvfxFFuAdl4APEgCgiIBSZff4O
         uwYrPTfAYIGFoMNAsElo/97xA0U0cMJ662oxyw3nNN/aKiwF3cWAmcaMdmymmU99P+b1
         l64oyhKrNvMrHfBTNgFDmynLy7hLQV8zkOdsiVY3Mv07ZSG+x3H7a4SNFrDyGiQqfPbM
         dPFFiIisFPna68CBFlnpWvCEPK1/TE9VI8X4uhI7XzRbWEJqZjRpKr6w+cL9sPaXgSUg
         qlu7/Mf9XaD0SAAswcHYWUTilaNYFRChLkcHPVQImwxTymiHW0B5yTDRvU8+c+MmNOQu
         1eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726573279; x=1727178079;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBWxTLIwaRXzz2B6lBD4X89iivmw4HPn5CVhIHdb5b4=;
        b=jjlJIe8q3w/fsCbGz90VQo6rSmmNDxF+30YVHgtcQqSnm+KzipRmxzUpAyfnyiM7hX
         9Oe42NlM6XIVyKW5gTcI1qJ27sqA+VSDbgASI/2mnPBP3SBTAJ/0XZlqHaqcI29+cfPW
         Hngk0ZKLBpbBoKZKsDwl5R8k0uEp+k5Qhw/gDD3UxLVQgXoJL2zX9/OUtcnn5d2qim2J
         Ch1/Ekk6sARwcEYlnsZ7iK19h/nsqmAUPoPATnHEHYPrIKagwYe/Ou2E5PU47+O3nE+b
         vXfIOlLp8F+d7ZiOeP0C04Rw4ShFZWFjeTrm6bmThDGFAHhW5lt9YDW3OiZ3YCroTMEi
         4Thg==
X-Forwarded-Encrypted: i=1; AJvYcCWtq+lHYsjfFhAqYaQfL74uSHB/3yzH5rEmM3kcrD+T2LL0ZMHc74jHLy8I0gyx8Mi2lG7LN9v/8NcA1z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzsT4cuFT1C4ulFX2RYF7YgFXpmk6I+Er0/NUmbhT8AYUnqsQT
	wy3bh/QoKpUDx70ciYNjoscmF3jqnX8A9HV5bKsbakjXAYFsbfzOujsg97KLVis=
X-Google-Smtp-Source: AGHT+IH2PSVF4UNMXvmdrYZyznZ7q1qkqZCW0MIRea2AY8og0vl8cI8cc+wtlZVbuMmX/jgs8zvd9w==
X-Received: by 2002:a17:907:2da3:b0:a7d:9f92:9107 with SMTP id a640c23a62f3a-a9029690793mr2309234666b.58.1726573278256;
        Tue, 17 Sep 2024 04:41:18 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b4321sm431729166b.113.2024.09.17.04.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:41:17 -0700 (PDT)
Message-ID: <5ad81ed43d8bb2426c9ae7d22fdb4c7aeb905129.camel@linaro.org>
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>,  kernel-team@android.com,
 linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org
Date: Tue, 17 Sep 2024 12:41:16 +0100
In-Reply-To: <ZulJuCu-QcMYrphP@finisterre.sirena.org.uk>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
	 <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
	 <ZulJuCu-QcMYrphP@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Mark,

Thanks for the review!

On Tue, 2024-09-17 at 11:19 +0200, Mark Brown wrote:
> On Mon, Sep 16, 2024 at 05:48:53PM +0100, Andr=C3=A9 Draszik wrote:
>=20
> > +config REGULATOR_MAX20339
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Maxim MAX20339 overvolt=
age protector with load switches"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on GPIOLIB || COMPILE_TES=
T
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on I2C
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GPIO_REGMAP if GPIOLIB
>=20
> I don't see any dependency on gpiolib here, the GPIO functionality
> appears unrelated to the regulator functionality (this could reasonably
> be a MFD, though it's probably not worth it given how trivial the GPIO
> functionality is).

Yes, it's very trivial and I opted to go the simpler path without MFD.

The alternative is just
         depends on GPIO_REGMAP || COMPILE_TEST
which doesn't appear used at all in the tree, so I opted for the above
instead.

I'll change it the dependency line

>=20
> > +++ b/drivers/regulator/max20339-regulator.c
> > @@ -0,0 +1,912 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2024 Linaro Ltd.
>=20
> Nothing inherited from the original Pixel 6 kernel?

No, not for this one.

> > + *
> > + * Maxim MAX20339 load switch with over voltage protection
>=20
> Please make the entire comment a C++ one so things look more
> intentional.
>=20
> > +static const struct regmap_config max20339_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D MAX20339_LAST_REGISTER,
> > +	.wr_table =3D &max20339_write_table,
> > +	.rd_table =3D &max20339_rd_table,
> > +	.volatile_table =3D &max20339_volatile_table,
> > +	.precious_table =3D &max20339_precious_table,
> > +};
>=20
> You've specified volatile registers here but not configured a cache.

Yes, cache didn't seem worthwhile, but I wanted to document the volatile
registers nonetheless.

I'll enable the cache.

> > +	if (status[3] & status[0] & MAX20339_INOVFAULT) {
> > +		dev_warn(dev, "Over voltage on INput\n");
> > +		regulator_notifier_call_chain(max20339->rdevs[MAX20339_REGULATOR_INS=
W],
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REGULATOR_EVENT_OVER_VOLTAGE_WARN,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
> > +	}
>=20
> This is an error on the input, not an error from this regulator, so the
> notification isn't appropriate here.

The input is usually a USB plug / cable. Is there a better option to report
this? I guess I could register a power supply.

> > +static int max20339_insw_is_enabled(struct regulator_dev *rdev)
> > +{
> > +	unsigned int val;
> > +	int ret;
> > +	struct device *dev =3D rdev_get_dev(rdev);
> > +
> > +	ret =3D regmap_read(rdev_get_regmap(rdev), MAX20339_STATUS1, &val);
> > +	if (ret) {
> > +		dev_err(dev, "error reading STATUS1: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	dev_dbg(dev, "%s: %s: %c\n", __func__, rdev->desc->name,
> > +		"ny"[FIELD_GET(MAX20339_INSWCLOSED, val)]);
>=20
> In addition to the log spam issues I've no idea how anyone is supposed
> to interpret this log :/

I'll remove it, it doesn't add much value.

> > +
> > +	return FIELD_GET(MAX20339_INSWCLOSED, val) =3D=3D 1;
> > +}
>=20
> This does not appear to be an enable control, it's reading back a status
> register rather than turning on or off a regulator.

This is the regulator_ops::is_enabled() callback, shouldn't it return the
status in effect? It's required to return effective status for one of the
code paths in _regulator_do_enable(), when .poll_enabled_time is !=3D 0.

> It's not clear to
> me what the status actually is (possibly saying if there's a voltage
> present?)

To enable, one writes to MAX20339_IN_CTR. While one can read back that
register, it doesn't reflect the actual status (e.g. it takes time to
take effect), so it has this MAX20339_STATUS1 register to inform us if
the output is actually enabled (switch closed or open).

On top of that, yes, the switch will also open if the input disappears
(cable unplug), this also is reflected in MAX20339_STATUS1 only.

So this regulator_ops::is_enabled() callback returns whether or not
it's open or closed - it returns the status that is in effect.

>  but it should be reported with a get_status() operation.

I missed ::get_status(), I'll implement it.

> > +static int max20339_set_voltage_sel(struct regulator_dev *rdev,
> > +				=C2=A0=C2=A0=C2=A0 unsigned int sel)
> > +{
> > +	return max20339_set_ovlo_helper(rdev,
> > +					FIELD_PREP(MAX20339_OVLOSEL_INOVLOSEL,
> > +						=C2=A0=C2=A0 sel));
> > +}
>=20
> This device does not appear to be a voltage regualtor, it is a
> protection device.=C2=A0 A set_voltage() operation is therfore inappropri=
ate
> for it, any voltage configuration would need to be done on the parent
> regulator.

This is handling one of the switches, and the input usually is
a USB plug / cable.

Based on the use-case (peripheral / OTG / wireless charging), the
overvoltage voltage=C2=A0needs to be modified at runtime for full
protection.

The set-voltage APIs seemed like a good fit for that, given the
regulator APIs allow setting those thresholds already (during init).

I'll see if I could maybe add a power supply as the parent and leave out
all the voltage and current related settings here altogether and make it
just control the switches, like some other regulator drivers do.

>=20
> > +static const struct regulator_ops max20339_insw_ops =3D {
> > +	.enable =3D regulator_enable_regmap,
> > +	.disable =3D regulator_disable_regmap,
> > +	.is_enabled =3D max20339_insw_is_enabled,
>=20
> The is_enabled() operation should match the enable() and disable(), it
> should reflect what the device is being told to do.

That wouldn't match _regulator_do_enable(), which requires .is_enabled()
to return the status in effect rather than the requested status, when
.poll_enabled_time is !=3D 0.


> > +static int max20339_lsw_is_enabled(struct regulator_dev *rdev)
> > +{
> > +	struct max20339_regulator *data =3D rdev_get_drvdata(rdev);
> > +	unsigned int val;
> > +	int ret;
> > +	struct device *dev =3D rdev_get_dev(rdev);
> > +
> > +	ret =3D regmap_read(rdev_get_regmap(rdev), data->status_reg, &val);
> > +	if (ret) {
> > +		dev_err(dev, "error reading STATUS%d: %d\n",
> > +			data->status_reg, ret);
> > +		return ret;
> > +	}
>=20
> Same issues here.

See above.

>=20
> > +	if (val & MAX20339_LSWxSHORTFAULT)
> > +		*flags |=3D REGULATOR_ERROR_OVER_CURRENT;
> > +
> > +	if (val & MAX20339_LSWxOVFAULT)
> > +		*flags |=3D REGULATOR_ERROR_OVER_VOLTAGE_WARN;
> > +
> > +	if (val & MAX20339_LSWxOCFAULT)
> > +		*flags |=3D REGULATOR_ERROR_OVER_CURRENT;
>=20
> These statuses should be flagged ot the core.

OK

>=20
> > +static int max20339_setup_irq(struct i2c_client *client,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *regmap,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regulator_dev *rdevs[])
> > +{
> > +	u8 enabled_irqs[3];
> > +	struct max20339_irq_data *max20339;
> > +	int ret;
> > +	unsigned long irq_flags;
> > +
> > +	/* the IRQ is optional */
> > +	if (!client->irq) {
> > +		enabled_irqs[0] =3D enabled_irqs[1] =3D enabled_irqs[2] =3D 0;
>=20
> Please just write a normal series of assignments, it's much clearer.

OK

> `
> > +		dev_info(&client->dev, "registered MAX20339 regulator %s\n",
> > +			 max20339_regulators[i].desc.name);
>=20
> This is just noise, remove it.

OK

Thanks,
Andre'


