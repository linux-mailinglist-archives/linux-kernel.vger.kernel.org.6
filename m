Return-Path: <linux-kernel+bounces-573399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE0A6D6C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CDE3B1E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6925DD0B;
	Mon, 24 Mar 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc+XGBg7"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C025DB03;
	Mon, 24 Mar 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806594; cv=none; b=b6/SFtdv3IBWAUZWhd3dosODZgjVfu4jCxdFbLSKc0lok0J0ChLxi+jFPQ6RCk/ehVHVJQnUXFjTEuQGpCg2DoJp//r98k4SkP6xadBBi00swXD8CSwkx2rEaBg/QSVMKo9doNp+mch0qGsoLnJ9BQwDxoq6d32O0KMxNsDjwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806594; c=relaxed/simple;
	bh=l4WWAwEydaPNgF4KjhGROyUK39NyBrA+t9scJbuSYW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcqQz/gAQqanxJ9bmSMRTVBGqnwhPCyExZGUd/UrQeOUXtKJN0+cLzO2IeTUlORqUSAnfcSUneuA1Yly2mOvutulxlXlrZRaiVWMMXldmE4/PDMyR+Pzc/LDY5aAW1T38tzu7UlaYKey9tKcHzkVPVXHChDJcQiXg99A2HyiMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc+XGBg7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54aef877725so248898e87.1;
        Mon, 24 Mar 2025 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806590; x=1743411390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fdlKmgWUdck7JQxeSbntpoEnLA6wDGGCN4OQ/puqE8=;
        b=Zc+XGBg7wenf5RiX7VS13S0thNw5KJirBJMtLTG7xt5b5hvIwAP71u6Fcx9RG0olol
         TEapYmisNq2hOKJwuuf+Z2O+TcY+5Up2LEyUGxPfRB61u+qW2zZ7klyk9TNwJa9D/N4V
         YIY9j6sQozgYOBrG/IO6nctM6d0K8YnHIhFgtQZZe9tiaMMTzR7KAfaJ8MGF9RFTWB08
         XsX/lwJKbP0IZSMznJjv8rm+RVTg3O6+n2qQRoYaSCrJbizMCdenYmbyrh8Ss0BlsIiV
         HuHiUwYcoH2URQCfHIAVMy7tZ8J30E8gGRHBmVw8OO0kx8pC7PBjWxPIkJ2EbrSqFZ1g
         JC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806590; x=1743411390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fdlKmgWUdck7JQxeSbntpoEnLA6wDGGCN4OQ/puqE8=;
        b=fKR4N6ix69SGnyDiBDJHdeccfP8ybOXmukjfP2L5S/np/txrOPtQ1W/mbHPGP+Gy7Z
         2VdvV3RmxGYZ7FPFfV7L5NxLfnba+WRo6WkBQwBXOwl9PFWFBzVci/k0dqJfsbfjJmXk
         75NzQuP7ZwCK2N+zFF+fj6vAyWfXAXQvYXqWZiEWpPS+oz6TO2ibzpuYeu4JnfVAZKN0
         KjWmSJALiIFe2KGnwyPSxwo/uhn3JZcwrHTK508TY1dhT+VtZRpqM6fkRrf4kwKyodU4
         zSP2OXGr7uKgWk9ouny0djfqYFBq7ZTu50PGFtnWE7g8ySeXlCuRzM+t8pX9pxC+rXXN
         zUWg==
X-Forwarded-Encrypted: i=1; AJvYcCXErmsuWc/vtNF1Q1H9itL+OMUsEYy1EOmnqu5g0yaZSd8P6Al/oMxRKNcTPWuthV6OM9Jr4sIu+5pR3NhK@vger.kernel.org, AJvYcCXhHw4rNS+acVgR/KWrhJkZhp3FL7+RtqoWci+mET8oOnJjhfEIUTXT190eY13L10l37vZlmnNEGCwX@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJ7TV14kqRwxOYHhl5gEBlaGkSIe31twkL5Jdg1crJ95DkUCo
	B3RYl4Y2sgB4/Watkk3GUTRk8eUO8BnefdGIglnGYquqKv8WmUal
X-Gm-Gg: ASbGncsHglcqKw9yrIoLJmH0oCRgtcfemejaYQv8yggd6yBI5zwJt4C0CXUwkrQ/uki
	ThUViuLyCBG1EL92lLJu7E3+9IvPDyLgBQJtgnIqLDDZ4bT5wnelGgows+igsbBJ/UdeYINZuU+
	WXLXOgrHfYslEzig5/0VmevvFYbfipz2d3PkJWqdIbwMgxt1bhjETGQLiJ99X+9eL+sko5kTt6h
	2XjY4UE7Lg7aZMpumyVpSxmSMSDjVko1P7l1Oy/vfAFmu+Mj80XbkhaA3ejc3lRS8Sm7/KBMG1Y
	/c3HXV0r5Isq4s+Bg1jGCKQX9XvoXtSfCGoUj2ISH/kiC/Mo/Jc=
X-Google-Smtp-Source: AGHT+IElkGpEGEXGcM5VcpOtUTb8PykQYgDole3Ne06Zo+hRHDi3i0YC/ufNXj0Li5b0fBPW6PVBdw==
X-Received: by 2002:a05:6512:1103:b0:549:7330:6a5a with SMTP id 2adb3069b0e04-54ad648f09dmr4505290e87.23.1742806589980;
        Mon, 24 Mar 2025 01:56:29 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbd0asm1054096e87.111.2025.03.24.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:56:28 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:56:25 +0200
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
Subject: [PATCH v2 09/14] regulator: bd96801: Support ROHM BD96802
Message-ID: <ac254491c2d650d263b064142068c282a3f624fa.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EXNubZP+THGMtcHt"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--EXNubZP+THGMtcHt
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
Revision history:
v1 =3D> :
 - No changes
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
2.49.0


--EXNubZP+THGMtcHt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHjkACgkQeFA3/03a
ocXWgggApCu9vSoLTovPwKwNr750AuIygBiXB5ZvyF0cHl4WJMLoMe5o6AZs38Xt
cFabE41c2+eiK961xMf8HkFOe/xGSz4P6LmWWYl4ilfaGX7YJ0IdRJ4fJY9WR7G7
K7wYFYgqe6kFSwS3oQVGWMKDtIOg5c9K4VxMUORnkgsgWrMO3YiCs2XWrjNlmn6Q
UJYP0cQ3TbxHjY+B2l/YDCq1qTZuZjsvWmI5Uy40hK/g4ItwaZdQE9JS9CuiSzI/
HTCd1eQwXxRQ/0fVq5zwv+rd1N1E/f99lKRzJXjmf7qc+mUb19m00dblId9B/cWN
QCo50l6EtamS9h2vTHl0mE1DQJ46YQ==
=h/5c
-----END PGP SIGNATURE-----

--EXNubZP+THGMtcHt--

