Return-Path: <linux-kernel+bounces-331411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB2A97AC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332A2814CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763214D70F;
	Tue, 17 Sep 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H48qdkqh"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD210F4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560238; cv=none; b=TJn/o+YA3Dp8/nYSsBpwsMZHlSjzwztgoIdtmQfPPxqfEU9SbSAhto/3g/74oi7BvlXcWO40PGMilKaJo7th4yQRsrkLVHg063X+BMzjZJ5Z2//5crUKXU4LFr2ZrGqtwfl4VaWNUtzRaYgEKkysNOsmtogfTGpz9MOPOCRp47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560238; c=relaxed/simple;
	bh=UoFfqD2LpJMk5DZ5pGUZqOQwQDnWXKdu78Ih+LQXRWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcY8Fs7LO8UXNT2btCT8ysRfc/C5nSoNSKX1NWtTmEfw5CBu5K2OdB72aF5xd8xGUt1MfgmZE7oHFxnamOQ7eXY4C8g2l2sqq8n9OeecRiDisfwogpdVWX4UyAtX0B0ndLqjQWzi0y6/SgiCiMeuN1RVNK10ZgE/Q895//Jb+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H48qdkqh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c3400367so3661690f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726560235; x=1727165035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Jj52CojAbwaF478qQYZAkMXNuH+bJTMmbgiHCPAopE=;
        b=H48qdkqhfOw7P1BrPP15qiZD8hP09j8OadZrF2Y2oYH0Qie68UjGFB49DDQXorn7Vx
         Japd03M2hd5a+2kJ/kH1bmeeJlX9L1B2F+9VlIxc61pqpUzLPenTWt1rXCpFqyrb5K9e
         ZSJBrVC8LzASP53SKJATTIK7fJa26G2zXgaN3Esn1qkmrly4omY3eHOaB3qc4c+fY6FP
         HdtmTHlmjzSCTxYnluMQg5utSF/SNq1+g2Z6TFMfrSxS1eES5/4fmMjqFQbl4JElZzDD
         cgHRSYkl5580Cq7pNO7TIstB59R2D14Fwz4bm2hUr8zSGIOjCzXU7dLB/KaflTuN4aU7
         Wx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726560235; x=1727165035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Jj52CojAbwaF478qQYZAkMXNuH+bJTMmbgiHCPAopE=;
        b=MKktfGpGJkv7kw5zFChZl4aiUjmvcYJWEMUrPJubsLtezuGUeXGfLcTJzgFfoUcNkx
         krpKw4pFFcekIDN9t5CdTcn9Hdih5lEnZULydB4gGkKse95NHwiqRZainsVOtejmsu53
         5dU3WuPQS4fHceeNr8ZwZokLl8/v/mXVLwMcI4/dky2zT7dMey2ufmeTgRQShr8Z8N8b
         iVxpu3B4p02vvUvfclArUTHEsCtRDJ5j2VllUMJfoKs5Du8ChofDjV9Dq4kcSlkVtShN
         uWx27/nqz+d9z8JBu8qRkNG4KNReRzJwZ9wkiGeTSApjzJfvs0IOwQ0A0eSssTw4QD77
         dsDA==
X-Forwarded-Encrypted: i=1; AJvYcCUd84aIOJoUAhkRq4D9xa3qJCaFmhtjgUkfqnyYyZt6aq7f00O6Y34xWv9zX9k4feQcWww1861NcggraFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsppF9D/hhStyzxqIQBYjcqAGfc8iBgxUAaBcV5K0Y6pgtexHA
	2cD1sayu/kfiEljoqmqyX6i21fjKdKQe66X7WXLJk9b58xwgKT5kjcHg5AEPIaM=
X-Google-Smtp-Source: AGHT+IHkEDJrgqcI0g1xCLSvN5bAIBmHriRBiRQ9vxVJa5aGKjqQ3X8TkQv3aRXEqJKW8YEDlx1VsQ==
X-Received: by 2002:a05:6000:b82:b0:377:4aa2:3af8 with SMTP id ffacd0b85a97d-378d61e251dmr12963702f8f.13.1726560235117;
        Tue, 17 Sep 2024 01:03:55 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906111a7a3sm414297066b.96.2024.09.17.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 01:03:54 -0700 (PDT)
Message-ID: <290668fb4f86a4d2caa779e517c736c93c3fc429.camel@linaro.org>
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Tue, 17 Sep 2024 09:03:53 +0100
In-Reply-To: <29f30aae-ffad-4a42-909e-b05f9cf360b5@kernel.org>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
	 <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
	 <29f30aae-ffad-4a42-909e-b05f9cf360b5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Mon, 2024-09-16 at 22:06 +0200, Krzysztof Kozlowski wrote:
> On 16/09/2024 18:48, Andr=C3=A9 Draszik wrote:
> > The MAX20339 is an overvoltage protection (OVP) device which also
> > integrates two load switches with resistor programmable current
> > limiting and includes ESD protection for the USB Type-C signal pins.
> >=20
> > This driver exposes the main path and the two the load switches via the
>=20
> ...
>=20
> > +
> > +
> > +static irqreturn_t max20339_irq(int irqno, void *data)
> > +{
> > +	struct max20339_irq_data *max20339 =3D data;
> > +	struct device *dev =3D max20339->dev;
> > +	struct regmap *regmap =3D max20339->regmap;
> > +	u8 status[6];
> > +	int ret;
> > +
> > +	ret =3D regmap_bulk_read(regmap, MAX20339_STATUS1, status,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(status));
> > +	if (ret) {
> > +		dev_err(dev, "Failed to read IRQ status: %d\n", ret);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	dev_dbg(dev,
> > +		"INT1 2 3: %#.2x %#.2x %#.2x STATUS1 2 3: %#.2x %#.2x %#.2x\n",
> > +		status[3], status[4], status[5], status[0], status[1],
> > +		status[2]);
>=20
> You should not have prints, even debugs, in interrupt handlers. This can
> flood the dmesg.
>=20
> > +
> > +	if (!status[3] && !status[4] && !status[5])
> > +		return IRQ_NONE;
> > +
> > +	/* overall status */
> > +	if (status[3] & status[0] & MAX20339_THMFAULT) {
> > +		dev_warn(dev, "Thermal fault\n");
> > +		for (int i =3D 0; i < ARRAY_SIZE(max20339->rdevs); ++i)
> > +			regulator_notifier_call_chain(max20339->rdevs[i],
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 REGULATOR_EVENT_OVER_TEMP,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
> > +	}
> > +
> > +	/* INSW status */
> > +	if ((status[3] & MAX20339_VINVALID)
> > +	=C2=A0=C2=A0=C2=A0 && !(status[0] & MAX20339_VINVALID)) {
> > +		dev_warn(dev, "Vin over- or undervoltage\n");
>=20
> Same with all these. What happens if interrupt is triggered constantly?

You unplug the USB cable :-), but yes, I'll come up with something better.

> [...]
> > +}
> > +
> > +static int max20339_lsw_dt_parse(struct device_node *np,
> > +				 const struct regulator_desc *desc,
> > +				 struct regulator_config *cfg)
> > +{
> > +	struct max20339_regulator *data =3D cfg->driver_data;
> > +
> > +	/* we turn missing properties into a fatal issue during probe() */
>=20
> Your binding does not look in sync with above.

Do you mean it doesn't enforce existence of this property? (It does and
binding check appropriately complains if it's missing). Otherwise, can
you please point me to the problem you're seeing?

From the binding:

+properties:
+  [...]
+  regulators:
+    type: object
+    [...]
+    patternProperties:
+      "^lsw[12]$":
+        [...]
+        properties:
+          [...]
+          shunt-resistor-micro-ohms:
+            [...]
+        required:
+          - shunt-resistor-micro-ohms
+
+        unevaluatedProperties: false
+
+    required:
+      - lsw1
+      - lsw2
+
+    additionalProperties: false
+
+[...]
+
+required:
+  [...]
+  - regulators

Anything wrong or missing in the above?

> > [...]
> > +	},=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +	.ovp_mask =3D _ovp_mask,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> > +	.status_reg =3D _status_reg,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +}
> > +
> > +
>=20
> Here and in few other places - just one blank line.

OK.

> > +static struct max20339_regulator max20339_regulators[MAX20339_N_REGULA=
TORS] =3D {
>=20
> This can be const and then use container_of instead of rdev_get_drvdata()=
.
>=20
> See:
> https://lore.kernel.org/all/20240909-regulator-const-v1-17-8934704a5787@l=
inaro.org/

Thanks!

> [...]
> > +
> > +	irq_flags =3D IRQF_ONESHOT | IRQF_SHARED;
>=20
> Why shared?

Just to be nice in case somebody puts it on a shared line. Not actually
required in my case.

> > +	irq_flags |=3D irqd_get_trigger_type(irq_get_irq_data(client->irq));
> > +
> > +	ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>=20
> Shared interrupts should not be devm. It leads to tricky cases during
> removal. If you investigated the code and you are 100% sure there is no
> issue, please write a short comment in the code confirming that. Or just
> don't use devm.

I wasn't aware of this, thanks. I'll drop the shared and somebody can
revisit it in the future if required. BTW, a naive grep returned +400
drivers that use shared together with devm.

> > [...]
> > +
> > +	ret =3D PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&client->dev,
> > +			&(struct gpio_regmap_config) {
> > +				.parent =3D &client->dev,
> > +				.regmap =3D regmap,
> > +				.fwnode =3D fwnode,
> > +				.ngpio =3D ARRAY_SIZE(names),
> > +				.names =3D names,
> > +				.reg_dat_base =3D MAX20339_STATUS1,
> > +				.reg_mask_xlate =3D max20339_gpio_regmap_xlate
> > +			}));
>=20
> That's not really readable. Please split PTR_ERR_OR_ZERO.

OK.

> > [...]
> > +
> > +	regmap =3D devm_regmap_init_i2c(client, &max20339_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err_probe(&client->dev, PTR_ERR(regmap),
>=20
> return dev_err_probe

Oops, sure.

> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "regmap init failed\n");
> > +		return PTR_ERR(regmap);
> > +	}

> > [...]
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id max20339_of_id[] =3D {
> > +	{ .compatible =3D "maxim,max20339", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, max20339_of_id);
> > +#endif
> > +
> > +static struct i2c_driver max20339_i2c_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "max20339",
> > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +		.of_match_table =3D of_match_ptr(max20339_of_id),
>=20
> Drop of_match_ptr and earlier #ifdef. Not much benefits and limits usage
> to OF-systems.

OK.

Thanks Krzysztof!
Andre

>=20
> Best regards,
> Krzysztof
>=20


