Return-Path: <linux-kernel+bounces-559375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C7A5F2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DA176E64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13E2661BE;
	Thu, 13 Mar 2025 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4iA/RUg"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD2267394;
	Thu, 13 Mar 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866116; cv=none; b=LfLaeNG4nmg0eH+2s1rygVWq6kX2sJhDPiEuHQdaMdlkMU23mE8oHXqOGqCSbzC2rfQ45Q/rv20y7Rxlnktd8vOVjrszL/QxPbyj9XjzBvqar681+7w4jgqMNTyQR7Mdn3vcXI75a+Uyl6vxgr911yf5SVDV4EsLNE4uXU1IR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866116; c=relaxed/simple;
	bh=eU3YYf7hONR7o/hLM2pq9T5D9nlYZakGVI/JxgEwViw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym/FygXYSOsijQYx6vky8whhJ/RZcYtCyjnsQLfTvJNiJrcKCXvSdeH96dmQoGjlZ0k+MQ6Do21GycdaaYW/UhTj59J0A8zbuz+CkeOFIwVPC/r4BkMCpV0aDITRldUxxsEyTPr06A6tf3O1T1bDMJNypHvMoWygzUmkC2elk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4iA/RUg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307325f2436so8432041fa.0;
        Thu, 13 Mar 2025 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866113; x=1742470913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKR3l47tZ2hjthfOksJtoXtf/Vrl/m0urp6K2tpp6Xk=;
        b=d4iA/RUgwbMjekzDKq646vteOmPvUJgGzOx4BCXui0DTNYNxmaUfGVvpROBY7/dego
         LBkubaK022J8N0boismIPeomKPkU3EnIHwuMAgm9/CqIKD4wL4YS4yzujN7mY9OXVt/c
         cC6e+T/BfuWBr6Sn4k6YRD56XNeKZcjp8bJByhrT+yQJaWdqhbr+PL+4giGzyqeA6i8Z
         ZIweU94kYb3+dxY+Bfji8/vh+sEYFwyIVWZIQdFWMYu0Jx3nPcv1vR0VIhcw4Ou7sH16
         kPiOrBwZMy7U8tXXETgmilqDzpz8LXWx4Lfo1Zt7LbtqB3xVg7gXdywxhICjT+9lf0h3
         zW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866113; x=1742470913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKR3l47tZ2hjthfOksJtoXtf/Vrl/m0urp6K2tpp6Xk=;
        b=e7F1jkhTDAU/O48gsObDPmwOzyoZS64fjImobMZsgjIxaonoN1t29LFst82hviezKl
         7E/65/SROftOrdm+TNKJKp49qAXd9Djg6C/aNiZMNgvpx2n/HEKw0dwr6VjwkXqKXXcR
         20pbfcoe9xP3Et4Aq19Qx4iHjjbNz7xNwH+8c52W1bmMtcgxSxWItVhyQA7BDFZ+d/Sj
         pNR+GdyGIatIW17fZoURv94oU7eWcSQaWnTBJ0njKT/Lu8T5zhgkIFLMw98hJ5OJRjoG
         DJcdPQsrBP0vfR+9xO3T0Rok0IbJ4XKXeH0TnGOJAzuCcEOJUpiNYVJhn2wSKhpGGHe1
         G91Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzaCeRM+a1stAkZNvY+1cTp6qljR0Y4I40Ua/FH2NZ0ZWTG0xUB5M8jsdhmnuttUjP2PI1Gw9Lx/ddFOOh@vger.kernel.org, AJvYcCWoyuHeOOWTEuujnjO8y4ib4xiVy4VOc3tDBKxFQYuw2v0UCfIWczcpslpGPoNP608y80obu5GaXNhK@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQuW+kMglI6UR3mBHT7d+ZXlbLVEnh4HQGGAGZF6Pn+MLkBiO
	IKF/mHmJnZhXb7+fcBxkfJM0xjf2duuRBALrRB6+czi6Lg1+Lyl0
X-Gm-Gg: ASbGncucFz/irY6KLtl1PUZ3IirqE8DSuioSAnXfxCK1AQ5YEyQKWb+pijDvtnw0Ikz
	zQeyRDhygx3lU8tJhf/fRAXw2RgzJ+uEZVEsP+XpEYEJr3DqM76LFBexgQfTkuGtM95fVSAuM70
	5VWRTXrufzQuNGCh8yBkn4QBdYAXwKU+isVhzcpUVPiInu5l1Jp/qFNE3m/CgN1FWAGvkYBTE1J
	TBnt5c7DKD0D8SVfTjqiWIiwDhfGFEDUQhHkocgmIV4J4DT1CUjZRRCe3O2WnS02MaUWukzwJ/l
	9+ePUPOWNTq/gV42KLCsTvsm1UnwOJoK8LeCbnmp4SW+0eD5hM5kP9J5nb2qvw==
X-Google-Smtp-Source: AGHT+IEhQeJqQXegmX8nsuEwNbVnR9xVzXrXv4FIcsBCk6YSb4iXu6HxPXoaLLnydiR4R2nwn9Bppg==
X-Received: by 2002:a05:651c:4ca:b0:30c:aae:6d4e with SMTP id 38308e7fff4ca-30c0aae6eafmr76166591fa.23.1741866112687;
        Thu, 13 Mar 2025 04:41:52 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f100c39sm1855861fa.48.2025.03.13.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:50 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:41:47 +0200
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
Subject: [PATCH 05/14] mfd: rohm-bd96801: Add chip info
Message-ID: <fd445f9cbbdaa3fd5d7a9e59093f86e5ff7139b1.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xni6nKO7BxNC7pNi"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--Xni6nKO7BxNC7pNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Prepare for adding support for BD96802 which is very similar to BD96801.
Separate chip specific data into own structure which can be picked to be
used by the device-tree.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd96801.c | 83 ++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index 60ec8db790a7..1232f571e4b1 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -40,7 +40,21 @@
 #include <linux/mfd/rohm-bd96801.h>
 #include <linux/mfd/rohm-generic.h>
=20
-static const struct resource regulator_errb_irqs[] =3D {
+struct bd968xx_chip_data {
+	const struct resource *errb_irqs;
+	const struct resource *intb_irqs;
+	int num_errb_irqs;
+	int num_intb_irqs;
+	const struct regmap_irq_chip *errb_irq_chip;
+	const struct regmap_irq_chip *intb_irq_chip;
+	const struct regmap_config *regmap_config;
+	struct mfd_cell *cells;
+	int num_cells;
+	int unlock_reg;
+	int unlock_val;
+};
+
+static const struct resource bd96801_reg_errb_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD96801_OTP_ERR_STAT, "bd96801-otp-err"),
 	DEFINE_RES_IRQ_NAMED(BD96801_DBIST_ERR_STAT, "bd96801-dbist-err"),
 	DEFINE_RES_IRQ_NAMED(BD96801_EEP_ERR_STAT, "bd96801-eep-err"),
@@ -98,7 +112,7 @@ static const struct resource regulator_errb_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD96801_LDO7_SHDN_ERR_STAT, "bd96801-ldo7-shdn-err"),
 };
=20
-static const struct resource regulator_intb_irqs[] =3D {
+static const struct resource bd96801_reg_intb_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD96801_TW_STAT, "bd96801-core-thermal"),
=20
 	DEFINE_RES_IRQ_NAMED(BD96801_BUCK1_OCPH_STAT, "bd96801-buck1-overcurr-h"),
@@ -345,18 +359,37 @@ static const struct regmap_config bd96801_regmap_conf=
ig =3D {
 	.cache_type =3D REGCACHE_MAPLE,
 };
=20
+static const struct bd968xx_chip_data bd96801_chip_data =3D {
+	.errb_irqs =3D bd96801_reg_errb_irqs,
+	.intb_irqs =3D bd96801_reg_intb_irqs,
+	.num_errb_irqs =3D ARRAY_SIZE(bd96801_reg_errb_irqs),
+	.num_intb_irqs =3D ARRAY_SIZE(bd96801_reg_intb_irqs),
+	.errb_irq_chip =3D &bd96801_irq_chip_errb,
+	.intb_irq_chip =3D &bd96801_irq_chip_intb,
+	.regmap_config =3D &bd96801_regmap_config,
+	.cells =3D bd96801_cells,
+	.num_cells =3D ARRAY_SIZE(bd96801_cells),
+	.unlock_reg =3D BD96801_LOCK_REG,
+	.unlock_val =3D BD96801_UNLOCK,
+};
+
 static int bd96801_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
 	struct irq_domain *intb_domain, *errb_domain;
+	static const struct bd968xx_chip_data *cd;
 	const struct fwnode_handle *fwnode;
 	struct resource *regulator_res;
 	struct resource wdg_irq;
 	struct regmap *regmap;
-	int intb_irq, errb_irq, num_intb, num_errb =3D 0;
+	int intb_irq, errb_irq, num_errb =3D 0;
 	int num_regu_irqs, wdg_irq_no;
 	int i, ret;
=20
+	cd =3D device_get_match_data(&i2c->dev);
+	if (!cd)
+		return -ENODEV;
+
 	fwnode =3D dev_fwnode(&i2c->dev);
 	if (!fwnode)
 		return dev_err_probe(&i2c->dev, -EINVAL, "Failed to find fwnode\n");
@@ -365,34 +398,32 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	if (intb_irq < 0)
 		return dev_err_probe(&i2c->dev, intb_irq, "INTB IRQ not configured\n");
=20
-	num_intb =3D  ARRAY_SIZE(regulator_intb_irqs);
-
 	/* ERRB may be omitted if processor is powered by the PMIC */
 	errb_irq =3D fwnode_irq_get_byname(fwnode, "errb");
-	if (errb_irq < 0)
-		errb_irq =3D 0;
+	if (errb_irq =3D=3D -EPROBE_DEFER)
+		return errb_irq;
=20
-	if (errb_irq)
-		num_errb =3D ARRAY_SIZE(regulator_errb_irqs);
+	if (errb_irq > 0)
+		num_errb =3D cd->num_errb_irqs;
=20
-	num_regu_irqs =3D num_intb + num_errb;
+	num_regu_irqs =3D cd->num_intb_irqs + num_errb;
=20
 	regulator_res =3D devm_kcalloc(&i2c->dev, num_regu_irqs,
 				     sizeof(*regulator_res), GFP_KERNEL);
 	if (!regulator_res)
 		return -ENOMEM;
=20
-	regmap =3D devm_regmap_init_i2c(i2c, &bd96801_regmap_config);
+	regmap =3D devm_regmap_init_i2c(i2c, cd->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
 				    "Regmap initialization failed\n");
=20
-	ret =3D regmap_write(regmap, BD96801_LOCK_REG, BD96801_UNLOCK);
+	ret =3D regmap_write(regmap, cd->unlock_reg, cd->unlock_val);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret, "Failed to unlock PMIC\n");
=20
 	ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, intb_irq,
-				       IRQF_ONESHOT, 0, &bd96801_irq_chip_intb,
+				       IRQF_ONESHOT, 0, cd->intb_irq_chip,
 				       &intb_irq_data);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB IRQ chip\n");
@@ -404,24 +435,25 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	 * has two domains so we do IRQ mapping here and provide the
 	 * already mapped IRQ numbers to sub-devices.
 	 */
-	for (i =3D 0; i < num_intb; i++) {
+	for (i =3D 0; i < cd->num_intb_irqs; i++) {
 		struct resource *res =3D &regulator_res[i];
=20
-		*res =3D regulator_intb_irqs[i];
+		*res =3D cd->intb_irqs[i];
 		res->start =3D res->end =3D irq_create_mapping(intb_domain,
 							    res->start);
 	}
=20
 	wdg_irq_no =3D irq_create_mapping(intb_domain, BD96801_WDT_ERR_STAT);
 	wdg_irq =3D DEFINE_RES_IRQ_NAMED(wdg_irq_no, "bd96801-wdg");
-	bd96801_cells[WDG_CELL].resources =3D &wdg_irq;
-	bd96801_cells[WDG_CELL].num_resources =3D 1;
+
+	cd->cells[WDG_CELL].resources =3D &wdg_irq;
+	cd->cells[WDG_CELL].num_resources =3D 1;
=20
 	if (!num_errb)
 		goto skip_errb;
=20
 	ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, errb_irq, IRQF_ONESHO=
T,
-				       0, &bd96801_irq_chip_errb, &errb_irq_data);
+				       0, cd->errb_irq_chip, &errb_irq_data);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to add ERRB IRQ chip\n");
@@ -429,18 +461,17 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	errb_domain =3D regmap_irq_get_domain(errb_irq_data);
=20
 	for (i =3D 0; i < num_errb; i++) {
-		struct resource *res =3D &regulator_res[num_intb + i];
+		struct resource *res =3D &regulator_res[cd->num_intb_irqs + i];
=20
-		*res =3D regulator_errb_irqs[i];
+		*res =3D cd->errb_irqs[i];
 		res->start =3D res->end =3D irq_create_mapping(errb_domain, res->start);
 	}
=20
 skip_errb:
-	bd96801_cells[REGULATOR_CELL].resources =3D regulator_res;
-	bd96801_cells[REGULATOR_CELL].num_resources =3D num_regu_irqs;
-
-	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, bd96801_cell=
s,
-				   ARRAY_SIZE(bd96801_cells), NULL, 0, NULL);
+	cd->cells[REGULATOR_CELL].resources =3D regulator_res;
+	cd->cells[REGULATOR_CELL].num_resources =3D num_regu_irqs;
+	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
+				   cd->cells, cd->num_cells, NULL, 0, NULL);
 	if (ret)
 		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
=20
@@ -448,7 +479,7 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 }
=20
 static const struct of_device_id bd96801_of_match[] =3D {
-	{ .compatible =3D "rohm,bd96801",	},
+	{ .compatible =3D "rohm,bd96801", .data =3D &bd96801_chip_data, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd96801_of_match);
--=20
2.48.1


--Xni6nKO7BxNC7pNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxHsACgkQeFA3/03a
ocU+pAf+M58z/a9hjMZCiFNnbXIxQPCF6b7e376ZvY1kDO8mGqbTOhey5mIStxBA
oKM3dFTeZdVbjvvJA5wwl6ngL9EBK+N5uNoQGbxN/MCxHEPpS3jLDcVojdBztSUa
1STqXqOeKgTAHaKV5mNxrNypg3E9ZW9NYemGOtDz0b47sez3QVhlfVsMbMGxlgSs
No7lb7BVmyBwCXQv4pKCRXn5fvvQsGxzIOTz5iChGsZy6h29J1ZfdHck+G4BFcdD
wkJR7zKw83BIAGD79eQZQNazqgDqCoP9UqzlOds5rjU4rkzR+G8q8qeJS1bgggzw
Ox8iylO7VnF6ksN9RCLDWz7FHQtIfw==
=keq5
-----END PGP SIGNATURE-----

--Xni6nKO7BxNC7pNi--

