Return-Path: <linux-kernel+bounces-573403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47EA6D6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC4C7A69C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9E25DAF4;
	Mon, 24 Mar 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPmhHB3h"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9725D8E6;
	Mon, 24 Mar 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806642; cv=none; b=Y5xw0all/XWUSSbK2bfDle0jF6KpYCI/Aa11Ta6aonvQzcqRBEGYXrZdqdkPxSHpggXdBdOTL5ndRVAXLB0kSFNgajbKw8mMWRHRK0Xds4UcNUFh7j4av4+MIsRXwioTkPRr2otcPwfgmjMW3ySfbd7CtVL7xWzsta9dQX6VuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806642; c=relaxed/simple;
	bh=LKu5sWL23vU5QilNqIZE7oISlgSG575mDkyaQRUukSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k++iHlIXrKYnDuXnsD8zR+DC4LmykViYcVc0DM19PRtfLfKknoGYhZ56rY8L31A0gjUfoL6HpP2eX6UiihNXq6WkPnqXv4uELOwrel4uFXESGZVgFu3Ov/TCSIgES3xMnHO/LX5aH0TCthGfucCKNaDrHcQ/KyBlivXdLI/a6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPmhHB3h; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so4789961e87.3;
        Mon, 24 Mar 2025 01:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806638; x=1743411438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8ksMsEKDJZAoJ22WKD1YIJRpzXnDKbM31Jrfa4KbmU=;
        b=WPmhHB3h4ol8Zswf15NBw3ykG2dRtdYKlfeH697QcEc1QLl8l00+IuJuR9ShZA4IC/
         MJFcAj2YgqWYWTlMe+/c+HLhisSrvqaWoSoJIuR3ifKtGezljY3WRKsV4h/S0x+2r1iq
         pEbMID+/pA3RGCs+hKU0QTzT+jpuBCrTia/peg6VPpwiejQDFf8IDFCnWBLlELmFTPrf
         f3BTA9tpDWN8jzxs5IWUZkKG9pnSqqJhiwt15Bl8oemGGTqGYxR85xsgTTSDMJR+wv2m
         73OryGfM465V79rZqWVkVACl+jp+hAkfrshEzQrvtnmhFZCYCRe2f4LQcoBohy0qOI6c
         YcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806638; x=1743411438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8ksMsEKDJZAoJ22WKD1YIJRpzXnDKbM31Jrfa4KbmU=;
        b=aIbM7R5lZCU+djpoLNjuBkcuS6Q1K5ijGEPGrvMP1Q/+pFESANiqpEiMLNqxd4x9XU
         sAhnvDO3CbPVxHRgDN1oOqjeZW3e0atvaM2GVC9PWPiybOIFoL24uYIWIkFfDFUK2AQW
         yaQAynos/RC+BdK0jnChjwGC3Y8O7IPafLFK67S4mvD7E/BiXw20SS3nJnXTbS/cwlZp
         LnrUU7HRNJ3e5dVDxA33IUYCXCg6CamHnlJtG58JdGbk3BLMnSkZ6k4BctkzqVdjHwY/
         shUDgLeoycQ1+ofR7DcuJLTZ2q0H9uUSQUkDMUnUBwGl6yyUrsxZMbJlssAi0MT8xvgK
         0Wxg==
X-Forwarded-Encrypted: i=1; AJvYcCXIFMQLZI8jfaj1c3/LdnGzsjQtJNWIb8VkmA/7yIVYswYmluzIHIRr/I2/pugwlfNVa3FxyEe3ATb+@vger.kernel.org, AJvYcCXUKv6FpA0CIyCRv4uL/dDLFpkPwMZ/Qxea0CsPq92clmGL9LdvAvoI82hF/91p+RUfIVohXQsd5wU+pJTY@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVx0VKSEO/J6YynSlGh5aZ/mRvOxcuhQg1wOuWtr3lq39xbug
	CY9763tFdP51boZRbx8El7N+/zq7S8jgojpE0R31XQ8nG/vb63KQ
X-Gm-Gg: ASbGncv/XUdy3DVRV86x0jjYvT2dzXLb1t6ycS3FtbBucElKRHZKw1uQKdAo/0ZwY2e
	RtoQc0nxganrbwD9ZDnxppTQrM/NAmC43o5cJ6D/urwaiidfoTmvY/f+Ki00Sw2ElxueJUfkqe8
	52d3h8Oa5cVlWwkPv5nN/PNlvvma4ZyOUpyb7+G3kGcsCE9A8mL11u8pGyw9sdq+BNWu2dIsXzp
	8bZfDfZSi9erwGcEr4BwcCEcst6x/g7wOpw5USdeAQ4u9vI53cuLPDQw8sAxDyaJVU996GE1+bp
	EWEJ1b5Tme9xdrpEy5O76jrn9iuB15acNqUQDso1yPv2ZvBsypo=
X-Google-Smtp-Source: AGHT+IF7ZXU29vsWaG+6+MSp5aBPP6eU41oSGmzTr9s91X36gaoryMRUoP3h5PJgq/WnN7Oho1/tkQ==
X-Received: by 2002:a05:6512:2351:b0:549:91d3:4f0f with SMTP id 2adb3069b0e04-54ad646ce76mr3787451e87.11.1742806638083;
        Mon, 24 Mar 2025 01:57:18 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647cadfsm1066678e87.72.2025.03.24.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:57:15 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:57:12 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/14] regulator: bd96801: Support ROHM BD96806 PMIC
Message-ID: <734397c8bdb86419fbced3432c7074badaad6657.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IV+ZmV8GLV4FtVYi"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--IV+ZmV8GLV4FtVYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96806 is from the software perspective almost identical to
the ROHM BD96802. The main difference is different voltage tuning
ranges.

Add support differentiating these PMICs and provide correct voltages
for both models.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> :
 - No changes
---
 drivers/regulator/bd96801-regulator.c | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index d829289942f9..fb9e7c3314a3 100644
--- a/drivers/regulator/bd96801-regulator.c
+++ b/drivers/regulator/bd96801-regulator.c
@@ -962,6 +962,70 @@ static const struct bd96801_pmic_data bd96805_data =3D=
 {
 	.num_regulators =3D 7,
 };
=20
+static const struct bd96801_pmic_data bd96806_data =3D {
+	.regulator_data =3D {
+	{
+		.desc =3D {
+			.name =3D "buck1",
+			.of_match =3D of_match_ptr("buck1"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK1,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96805_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96805_tune_volts),
+			.n_voltages =3D BD96805_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK1_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK1_VSEL_REG,
+			.vsel_mask =3D BD96805_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK1_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck1_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck1_irqinfo),
+		},
+	},
+	{
+		.desc =3D {
+			.name =3D "buck2",
+			.of_match =3D of_match_ptr("buck2"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK2,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96805_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96805_tune_volts),
+			.n_voltages =3D BD96805_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK2_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK2_VSEL_REG,
+			.vsel_mask =3D BD96805_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK2_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck2_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck2_irqinfo),
+		},
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+	},
+	},
+	.num_regulators =3D 2,
+};
+
 static int initialize_pmic_data(struct platform_device *pdev,
 				struct bd96801_pmic_data *pdata)
 {
@@ -1260,6 +1324,7 @@ static const struct platform_device_id bd96801_pmic_i=
d[] =3D {
 	{ "bd96801-regulator", (kernel_ulong_t)&bd96801_data },
 	{ "bd96802-regulator", (kernel_ulong_t)&bd96802_data },
 	{ "bd96805-regulator", (kernel_ulong_t)&bd96805_data },
+	{ "bd96806-regulator", (kernel_ulong_t)&bd96806_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd96801_pmic_id);
--=20
2.49.0


--IV+ZmV8GLV4FtVYi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHmgACgkQeFA3/03a
ocU1kgf/ZcY3vO1UHvmeClZccbQwo5xRfocgywJatw+EN9lH48lrAw5F/n69NORk
HAfcWzPfrTl0arZwVCLNB9gIUsiJWV1KEd3UbRfE1Gt++ZpIqJCjtnjdQawjsK57
4HgMVtPEWMVf/3pNxF8Mt5P5eys5EiI+ZrCKHJPrlcz2AKVWDn0HMeXUw93yJ6U6
R896sbEhJy79LrLojwvzUakc29WJ9Ft+K3MvV2SCHLEaFPBApsJ7yOdc9LGQCbJe
/uWSwhIKCQ16HkssvuGco17GgD5XM0exA/jrNTzt0hSwcl+Oae6pE5AuhzQkI7Q/
YzH6Ib3I9GC57QZRU3cy5iPSSy50kQ==
=+BCp
-----END PGP SIGNATURE-----

--IV+ZmV8GLV4FtVYi--

