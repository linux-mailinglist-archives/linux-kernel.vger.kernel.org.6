Return-Path: <linux-kernel+bounces-573394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D01A6D6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A43188D80F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A845225DAE9;
	Mon, 24 Mar 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoLU9gdK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD425D559;
	Mon, 24 Mar 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806544; cv=none; b=mg5QN5U3h3HZsMxYIdzJWu1o9FCI90hYJlM43+IfbhZ3vdCL31u920aNad2b2ziPJAulSgL/UAx5LXRi8RWG0XoD3GOHvoHBQskelq24nuYOAQAa/j3r4LbaDRvTDLjDbwlNtn33AOBTVyPnOQPin2YeE0pdx+skbjVR5Sz+fnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806544; c=relaxed/simple;
	bh=MFUP94WQLC3BNawTPVPiB9prARx5ML4CF/w6AvKfTr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoAbkD6Cth9ktSH5pXkhYkssgxFohO/TSKymF8+rbKmZJes0S2UUYrX3P2jNtOxPjzjhDYrfhBmfXU3DD2YW9d+sLps+TL4F3Dm2OPLHMdtRwdb94Ll0nfdZasEqdUWkP4RBF7fiYCjc4Z30A+FRQmH9eltIgO8+P7vA9GqsrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoLU9gdK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54954fa61c9so4818026e87.1;
        Mon, 24 Mar 2025 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806541; x=1743411341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gfTl00RLxjb84KJpVM0A+8Sk3nBc1Csx2LUIFUyD+A=;
        b=WoLU9gdK4q9n1/+HcGWzO3l6aWSuVpkzHydZrFPXhOLFG4CY+oeOoyJI8SFqC6jtiZ
         n7a76NFVYtLouWipqgGaWlY9BBEZr7tRc7lK8v3qGUq5dVGn5nYSJdfHqdYlB5+50Udy
         ZLFiMwOXqmyG3heSFfo8wcyuFsFjibm+1ejWcd7S4qiqJgGX5E+h4pLV1ogj0n7n0/XX
         VGxPvo/JCMCd3BBAcnIUjGfuWl4NmqGIKNxlheOhiIhy8Fwn4UC++jz+EVu6R4lH5pXc
         yuaId8n2ZjRi+tdo8+ks3QujnOHtGhCOoi80U6UGSNZYBMqYFSXJlnDao8FveEkqyz7y
         2YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806541; x=1743411341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gfTl00RLxjb84KJpVM0A+8Sk3nBc1Csx2LUIFUyD+A=;
        b=lItuKhoba7nXoOi3Des6Crdqs79ZD9WtTJ9bukrXF5ejWJStbtGSgNrpOS3c0uPAbE
         SKDTJNbfAFfED3cajKgUoWhzFudVjjMeCm56QAsZNm8STrPqW/Xi+9e42SK61y8xDb1z
         9VCyZawZc4ZjcXl7AVwbp1GdmsvURJQsO2DYX7At1VyBu81P+/ZbMLbVgpPcWwXhHdzM
         Vj8FyZ0dVNqo4gveAlhso50gaQR59dOQ3t0bTIaNj+oRvLofrMQvYMB12p0tZLh1EXRS
         Z6CpwjawBUAfqjp7zoEDHKBc6tB+rKam32Zbpc0wL1ZPGxjr5ulqK1E83ajyzuPlqzjT
         ZVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI+1HdxV9V6+DKl8rNA2L68bNUlYbTu/2tqL3SPBknCeu70K5pxzytI4cwMyuWiTT96jSnrQxz171c@vger.kernel.org, AJvYcCXrantQD4YEpC9v8L6uti5wfzJ+uQq4gJFAxhgLvddOUiCvc4LG6SClkfOoX1CT3m71YJp1umSTbkzQMlRH@vger.kernel.org
X-Gm-Message-State: AOJu0YynXETmz+SfDfigm+hEDwxE9oOZXyc80WBlsoCKab45uPyN26A/
	6ZEI0GPZK5gGy1+DNtstecmTp3UqotrfI5QwwzlMGC9bmATsGhNDKiyKsw==
X-Gm-Gg: ASbGncuS2hrZ1ta232JyCtwbjcAs7RWUDge09E3REKKycQSWoPcUEWV/WJ5Tkc8dcrT
	9aF3RIc72cmEce+rC8NCuAT7sbhwLsOab9eCwumVYva4wd+lgTCtqZ3LflGwbKwL3f4EfoIzzJU
	7g6t4LWGIUz471bpeNtQtRKCGTWviTQq5jE4FBxlkq1PC/UHq/47jOchlcX2Mo4QKNhbmejZ14b
	pz4/gIH86qGIJp0QmizoZztQ3Qxe30UK/wxo/53SSSg6FKD2nGkvFAYnp27eHccvBjJgxzjLEoy
	KbwzYJqfj4+3+/d/sZRi3p1eBM4ncsJPMtUJxBBv3UyVkkpEq5g=
X-Google-Smtp-Source: AGHT+IHpiRzL0YqQm1ThmUgH2bFqp91HkUFMoOKA8jwIEw7aT1xKs0hMir8rWE7TPmC8ksB9H5s5rg==
X-Received: by 2002:a05:6512:3a90:b0:549:8f01:6a71 with SMTP id 2adb3069b0e04-54ad6509fe3mr3661776e87.51.1742806541015;
        Mon, 24 Mar 2025 01:55:41 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6512520sm1063442e87.245.2025.03.24.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:55:38 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:55:33 +0200
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
Subject: [PATCH v2 05/14] mfd: rohm-bd96801: Add chip info
Message-ID: <89fd6ce27a21d575dd25b625bafc60cca6647f96.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nzk9Hc0in5DiT2vE"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--Nzk9Hc0in5DiT2vE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Prepare for adding support for BD96802 which is very similar to BD96801.
Separate chip specific data into own structure which can be picked based
on the type of the IC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> v2:
  - Use chip_type enum
  - Rename cd to ddata
---
 drivers/mfd/rohm-bd96801.c | 90 +++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index 60ec8db790a7..52e25d7ca888 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -40,7 +40,21 @@
 #include <linux/mfd/rohm-bd96801.h>
 #include <linux/mfd/rohm-generic.h>
=20
-static const struct resource regulator_errb_irqs[] =3D {
+struct bd968xx {
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
@@ -345,18 +359,44 @@ static const struct regmap_config bd96801_regmap_conf=
ig =3D {
 	.cache_type =3D REGCACHE_MAPLE,
 };
=20
+static const struct bd968xx bd96801_data =3D {
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
+	const struct bd968xx *ddata;
 	const struct fwnode_handle *fwnode;
 	struct resource *regulator_res;
 	struct resource wdg_irq;
 	struct regmap *regmap;
-	int intb_irq, errb_irq, num_intb, num_errb =3D 0;
+	int intb_irq, errb_irq, num_errb =3D 0;
 	int num_regu_irqs, wdg_irq_no;
+	unsigned int chip_type;
 	int i, ret;
=20
+	chip_type =3D (unsigned int)(uintptr_t)device_get_match_data(&i2c->dev);
+	switch (chip_type) {
+	case ROHM_CHIP_TYPE_BD96801:
+		ddata =3D &bd96801_data;
+		break;
+	default:
+		dev_err(&i2c->dev, "Unknown IC\n");
+		return -EINVAL;
+	}
+
 	fwnode =3D dev_fwnode(&i2c->dev);
 	if (!fwnode)
 		return dev_err_probe(&i2c->dev, -EINVAL, "Failed to find fwnode\n");
@@ -365,34 +405,32 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
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
+		num_errb =3D ddata->num_errb_irqs;
=20
-	num_regu_irqs =3D num_intb + num_errb;
+	num_regu_irqs =3D ddata->num_intb_irqs + num_errb;
=20
 	regulator_res =3D devm_kcalloc(&i2c->dev, num_regu_irqs,
 				     sizeof(*regulator_res), GFP_KERNEL);
 	if (!regulator_res)
 		return -ENOMEM;
=20
-	regmap =3D devm_regmap_init_i2c(i2c, &bd96801_regmap_config);
+	regmap =3D devm_regmap_init_i2c(i2c, ddata->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
 				    "Regmap initialization failed\n");
=20
-	ret =3D regmap_write(regmap, BD96801_LOCK_REG, BD96801_UNLOCK);
+	ret =3D regmap_write(regmap, ddata->unlock_reg, ddata->unlock_val);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret, "Failed to unlock PMIC\n");
=20
 	ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, intb_irq,
-				       IRQF_ONESHOT, 0, &bd96801_irq_chip_intb,
+				       IRQF_ONESHOT, 0, ddata->intb_irq_chip,
 				       &intb_irq_data);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret, "Failed to add INTB IRQ chip\n");
@@ -404,24 +442,25 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	 * has two domains so we do IRQ mapping here and provide the
 	 * already mapped IRQ numbers to sub-devices.
 	 */
-	for (i =3D 0; i < num_intb; i++) {
+	for (i =3D 0; i < ddata->num_intb_irqs; i++) {
 		struct resource *res =3D &regulator_res[i];
=20
-		*res =3D regulator_intb_irqs[i];
+		*res =3D ddata->intb_irqs[i];
 		res->start =3D res->end =3D irq_create_mapping(intb_domain,
 							    res->start);
 	}
=20
 	wdg_irq_no =3D irq_create_mapping(intb_domain, BD96801_WDT_ERR_STAT);
 	wdg_irq =3D DEFINE_RES_IRQ_NAMED(wdg_irq_no, "bd96801-wdg");
-	bd96801_cells[WDG_CELL].resources =3D &wdg_irq;
-	bd96801_cells[WDG_CELL].num_resources =3D 1;
+
+	ddata->cells[WDG_CELL].resources =3D &wdg_irq;
+	ddata->cells[WDG_CELL].num_resources =3D 1;
=20
 	if (!num_errb)
 		goto skip_errb;
=20
 	ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, errb_irq, IRQF_ONESHO=
T,
-				       0, &bd96801_irq_chip_errb, &errb_irq_data);
+				       0, ddata->errb_irq_chip, &errb_irq_data);
 	if (ret)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to add ERRB IRQ chip\n");
@@ -429,18 +468,17 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	errb_domain =3D regmap_irq_get_domain(errb_irq_data);
=20
 	for (i =3D 0; i < num_errb; i++) {
-		struct resource *res =3D &regulator_res[num_intb + i];
+		struct resource *res =3D &regulator_res[ddata->num_intb_irqs + i];
=20
-		*res =3D regulator_errb_irqs[i];
+		*res =3D ddata->errb_irqs[i];
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
+	ddata->cells[REGULATOR_CELL].resources =3D regulator_res;
+	ddata->cells[REGULATOR_CELL].num_resources =3D num_regu_irqs;
+	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, ddata->cells,
+				   ddata->num_cells, NULL, 0, NULL);
 	if (ret)
 		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
=20
@@ -448,7 +486,7 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 }
=20
 static const struct of_device_id bd96801_of_match[] =3D {
-	{ .compatible =3D "rohm,bd96801",	},
+	{ .compatible =3D "rohm,bd96801", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd96801_of_match);
--=20
2.49.0


--Nzk9Hc0in5DiT2vE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHgUACgkQeFA3/03a
ocW3fgf9HkglsLXFFffitvTR2YBOIagqqBU1l3eZSGboFr7BzLdjWFpVr4oRNemq
dPn6TLc5ZcnzBJzrbBlS3/5hcExdrT9ll2IW05S0CHtEGg0Tkd1/FyjinKZM3M0p
LMJOBoDAqvkadR3sR2kFYT5Q01Wt2tLhiV/5Nfqb5JQ98TFV/BdnKeN3aSPSC638
EI4oxS5fq6y9flqBqo3+oGShGqxyPw8qnTsUzKdVALDNAjaBY1MwTDNaTXMKtzpY
AmYknPKdCJtTfIUoheclOp0Pn+ms7DNpzTGFWHFH18l/ONgizWfHGe5gorMwHvMz
in/dsj4gn32bFY1b2Ip1U9znjSWSOA==
=VNoQ
-----END PGP SIGNATURE-----

--Nzk9Hc0in5DiT2vE--

