Return-Path: <linux-kernel+bounces-559379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F68A5F2F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB33517A162
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B42269823;
	Thu, 13 Mar 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwpDlrnj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE665266581;
	Thu, 13 Mar 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866166; cv=none; b=Hg7SrcMDrAIcPIE26iYRTjonmJSQ+bmKXb+hh81QeDMu3Ah4WZIrCFC6MsSWAjlcBZnAeybMM9E5FHlREjVEAsuty8+Z98PpzRSFS6j6V6LSJftWAtdG92hccFvSJseayoGesaPdLvOacPQmGUDvRmDu93lne7jnPzjWq1/FcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866166; c=relaxed/simple;
	bh=n6wNWcY7Bz2eTob/jQtTQRLVyt1c9Lrqrdo99HUboJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw50UJvN7iejka+CME+mcTPcWjSGLNLdQ1YX9qG53cdTwOO/5ULc5z0uKG1Olrq65LKI2g8cJZeNGVRrOzEo4aF1A69j0wkY7XCeuWMUw8D6LuT1Kzo/4w7E8Gom8/7hTG41FfbmP3UJ5G8fx+xqMmf+JRHro62dfcPbrSJeKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwpDlrnj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c2d427194so9244041fa.0;
        Thu, 13 Mar 2025 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866163; x=1742470963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sH1CSeQqxMsaxepK0ektoX2EV0nlFdc3GsF7udPglQ=;
        b=FwpDlrnjRln/ZK//Itz4VzBwROD87JTmNpb/1Ydldo7EDWoOLnfxdu0u4mU6rqIFd/
         B9OesGymVLbK2GDbCL6QSuwzAAM33eW5g/9X48GiwCD7QabxLGdMuKogJ8OCDTVWACIR
         mtpdyjPHV6CDjqvZpXOy1ZuNYXZdFk+ksSDjagGdvCSlcMoE72/lNrrV5mDGlNVP84X4
         LAYWE+jfD+t6l0MU65QrcU68DpvuNiQxanKjzDlJtOV6rVOANpm8Crln2Yz85fjhkQ62
         EeBXgS9osoo8sw3iCVNW3dggQid8ehZ16jz/qeX9aKUz53asQ1Qpk3xMUsR/8upELSU+
         7gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866163; x=1742470963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sH1CSeQqxMsaxepK0ektoX2EV0nlFdc3GsF7udPglQ=;
        b=YUnTqTej6j6oIB6nMFMXIkJnHiYF09Xs13vSUNLxDXjObRivk+w6G0nxAnu/sGLK8i
         Al6bZVIenLRdwju8oglirx6imlyOFlcmSA3s7STlgBu8XsVdIAGt++5O7wwa6wOfi/sH
         6yI/Mp/qaE2Pml7NDBKsLEiNHzcVvyebpdC5g7cl0G6/6Y6scvRqc8yfnAoYhYoV3DB5
         S44auY5JKDyFy/bcyPRpcvKo+o2DoUd7VnjaJiNybas4csfebOl/jXbX7vXgwrebcNBJ
         ibCtSSoLIMWxm2VQ8w4lBwhtYGtl1pOaee21zWl1C4eHyI1YSrFCMF+5zT9f1mB3rJeI
         xV1w==
X-Forwarded-Encrypted: i=1; AJvYcCW4Fo8BcnZB2sR9HsvJ7ScoYyZkvuAH6/nb2sIA2oilJWL5Xep0nWhC2aLAEZwmxzyvewIB14QGHaPB@vger.kernel.org, AJvYcCXfuRooKcKcbVS2Nsh4W+u4r5VNYO9dMXUfYue7bBwaqUCU0dJC5xD5MD0xIZEScReAwQRHMI3yfE/C9g5Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83XTCRhSm1c+AgtqgmGSfqHVU0SHQsGLGFErU7vL5FGw6oqJe
	5+S7h/yxxwSNF/6QPPHg6vI6hrnejv48NLkQsa/fzSsZ66DParvz
X-Gm-Gg: ASbGncujdiZ+tNgy6Sac0wp9MJN9pb/EISdEyoPeWqb49NUFuKzdHLh9dDkxoNhyjmL
	DYN98fHkrTrOLJUcR6DGQaQIbTBbub6z1VfeeHomjLzuMKBJYmWZHhQ5XuKFUp7zayQjQQF6Gm9
	UHoWbRnXMMvaWXLm1TADws6Mj4vuxzctdTt1k7odk1Rtll0UHJCrIC41TWFSLf5I7P7roStNt3b
	U15Vsgy5bKE7Yd/8FqPBq3ZpXiALZY8nx3NCxsuGhL4rX1aab+IGog/fhBdbOA3FlFW6TZBVmQG
	y70XwNmqM3eKGFluRCWX1IA3wxoamVQVnK657QJO2zpZRlh3JVvBbk2gEoWxHw==
X-Google-Smtp-Source: AGHT+IFVSgzozeE1pLfn5k8ldUKdmkLtw8E4M/X+0NMyOfLVUef47XgWQ2YiaRCPJRCVZttw5XJjrw==
X-Received: by 2002:a05:6512:3b0b:b0:549:38eb:d694 with SMTP id 2adb3069b0e04-549abacbcc7mr3681187e87.26.1741866162634;
        Thu, 13 Mar 2025 04:42:42 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864d7dsm183850e87.130.2025.03.13.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:42:41 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:42:37 +0200
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
Subject: [PATCH 09/14] regulator: bd96801: Support ROHM BD96802
Message-ID: <c6ef2373d7ea2891065bcbaf208978046cc469d9.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DMYhEBtsz2RVNr/C"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--DMYhEBtsz2RVNr/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96802 PMIC is primarily intended to be used as a companion
PMIC extending the capabilities of the BD96802 but it can be used on
it's own as well. When used as a companion PMIC, the start-up and
shut-down sequences are usually intitiated by the master PMIC using IF
pins.

The BD96802 looks from the digital interface point of view pretty much
like a reduced version of BD96801. It includes only 2 BUCKs and provides
the same error protection/detection mechanisms as the BD96801. Also, the
voltage control logic is same up to the register addresses.

Add support for controlling BD96802 using the BD96801 driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/regulator/bd96801-regulator.c | 92 ++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index 48cdd583e92d..893efdd92008 100644
--- a/drivers/regulator/bd96801-regulator.c
+++ b/drivers/regulator/bd96801-regulator.c
@@ -302,6 +302,7 @@ struct bd96801_pmic_data {
 	struct bd96801_regulator_data regulator_data[BD96801_NUM_REGULATORS];
 	struct regmap *regmap;
 	int fatal_ind;
+	int num_regulators;
 };
=20
 static int ldo_map_notif(int irq, struct regulator_irq_data *rid,
@@ -503,6 +504,70 @@ static int bd96801_walk_regulator_dt(struct device *de=
v, struct regmap *regmap,
  * case later. What we can easly do for preparing is to not use static glo=
bal
  * data for regulators though.
  */
+static const struct bd96801_pmic_data bd96802_data =3D {
+	.regulator_data =3D {
+	{
+		.desc =3D {
+			.name =3D "buck1",
+			.of_match =3D of_match_ptr("buck1"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK1,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_tune_volts),
+			.n_voltages =3D BD96801_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK1_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK1_VSEL_REG,
+			.vsel_mask =3D BD96801_BUCK_VSEL_MASK,
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
+			.linear_ranges =3D bd96801_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_tune_volts),
+			.n_voltages =3D BD96801_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK2_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK2_VSEL_REG,
+			.vsel_mask =3D BD96801_BUCK_VSEL_MASK,
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
 static const struct bd96801_pmic_data bd96801_data =3D {
 	.regulator_data =3D {
 	{
@@ -688,11 +753,13 @@ static const struct bd96801_pmic_data bd96801_data =
=3D {
 		.ldo_vol_lvl =3D BD96801_LDO7_VOL_LVL_REG,
 	},
 	},
+	.num_regulators =3D 7,
 };
=20
-static int initialize_pmic_data(struct device *dev,
+static int initialize_pmic_data(struct platform_device *pdev,
 				struct bd96801_pmic_data *pdata)
 {
+	struct device *dev =3D &pdev->dev;
 	int r, i;
=20
 	/*
@@ -700,7 +767,7 @@ static int initialize_pmic_data(struct device *dev,
 	 * wish to modify IRQ information independently for each driver
 	 * instance.
 	 */
-	for (r =3D 0; r < BD96801_NUM_REGULATORS; r++) {
+	for (r =3D 0; r < pdata->num_regulators; r++) {
 		const struct bd96801_irqinfo *template;
 		struct bd96801_irqinfo *new;
 		int num_infos;
@@ -866,6 +933,7 @@ static int bd96801_probe(struct platform_device *pdev)
 {
 	struct regulator_dev *ldo_errs_rdev_arr[BD96801_NUM_LDOS];
 	struct regulator_dev *all_rdevs[BD96801_NUM_REGULATORS];
+	struct bd96801_pmic_data *pdata_template;
 	struct bd96801_regulator_data *rdesc;
 	struct regulator_config config =3D {};
 	int ldo_errs_arr[BD96801_NUM_LDOS];
@@ -878,12 +946,16 @@ static int bd96801_probe(struct platform_device *pdev)
=20
 	parent =3D pdev->dev.parent;
=20
-	pdata =3D devm_kmemdup(&pdev->dev, &bd96801_data, sizeof(bd96801_data),
+	pdata_template =3D (struct bd96801_pmic_data *)platform_get_device_id(pde=
v)->driver_data;
+	if (!pdata_template)
+		return -ENODEV;
+
+	pdata =3D devm_kmemdup(&pdev->dev, pdata_template, sizeof(bd96801_data),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
=20
-	if (initialize_pmic_data(&pdev->dev, pdata))
+	if (initialize_pmic_data(pdev, pdata))
 		return -ENOMEM;
=20
 	pdata->regmap =3D dev_get_regmap(parent, NULL);
@@ -906,11 +978,11 @@ static int bd96801_probe(struct platform_device *pdev)
 		use_errb =3D true;
=20
 	ret =3D bd96801_walk_regulator_dt(&pdev->dev, pdata->regmap, rdesc,
-					BD96801_NUM_REGULATORS);
+					pdata->num_regulators);
 	if (ret)
 		return ret;
=20
-	for (i =3D 0; i < ARRAY_SIZE(pdata->regulator_data); i++) {
+	for (i =3D 0; i < pdata->num_regulators; i++) {
 		struct regulator_dev *rdev;
 		struct bd96801_irq_desc *idesc =3D &rdesc[i].irq_desc;
 		int j;
@@ -923,6 +995,7 @@ static int bd96801_probe(struct platform_device *pdev)
 				rdesc[i].desc.name);
 			return PTR_ERR(rdev);
 		}
+
 		all_rdevs[i] =3D rdev;
 		/*
 		 * LDOs don't have own temperature monitoring. If temperature
@@ -972,14 +1045,15 @@ static int bd96801_probe(struct platform_device *pde=
v)
=20
 	if (use_errb)
 		return bd96801_global_errb_irqs(pdev, all_rdevs,
-						ARRAY_SIZE(all_rdevs));
+						pdata->num_regulators);
=20
 	return 0;
 }
=20
 static const struct platform_device_id bd96801_pmic_id[] =3D {
-	{ "bd96801-regulator", },
-	{ }
+	{ "bd96801-regulator", (kernel_ulong_t)&bd96801_data },
+	{ "bd96802-regulator", (kernel_ulong_t)&bd96802_data },
+	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd96801_pmic_id);
=20
--=20
2.48.1


--DMYhEBtsz2RVNr/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxK0ACgkQeFA3/03a
ocVWWAf+MWAF+YNyN4Iv63yWdEBesOmBhO6AoS0syLd6cpogfUNLhK3Lw5HyV5Lg
eODt91bHWv73fa/f3iDtvYbN+H7IA1rT4PEj97UJn5UpijDNRM6F2+nd72CsgL6/
D9PDTGDn/7P4XiJQ9rnqZnSzTVxa6hgpmBNJbQmBuJ75TotDKcYbsvCmm+jKgHSR
KxPzDoguYqozGGTefgpUWO8AvT2nqqe9g6tP7MCcFDk8yyT6nOF7B51MJ4vBAF7A
tjH1hcjWbw9S9jlwRppTpgO21jMdV0lC3HYWjqjFTAFHcJSUJuJbkqMWKTOTdHcz
vlySGuutU7+b0W9AIFEkb+vNxld1Bw==
=ozfp
-----END PGP SIGNATURE-----

--DMYhEBtsz2RVNr/C--

