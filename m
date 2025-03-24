Return-Path: <linux-kernel+bounces-573400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40BA6D6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 916D07A3DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE5525DAF0;
	Mon, 24 Mar 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO3VsLgA"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972125D8EA;
	Mon, 24 Mar 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806607; cv=none; b=nRwrzKKrk8ROGw1AivolPBVgqm6om+gjqOls4FBWj6BiHo3vOr8vTmFQSiGd25Tvqv+qVdZgKLmNNpjj6ZPrP0AZjJaClZWeQeLPLWRl1C93QYdaZjcvuMOQFv01t3RvjCEYUqOdHwaZfwXdP5zqtmrFuCIzB2SXi5Xv/caUyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806607; c=relaxed/simple;
	bh=dYYNLBzfwUTPQs2qM5tzmXBZTENgFX+8vrThcSUn1u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhxbKUVVudUbOXkOcO2v2H/iJ+HzlXv6a3LPrtgUkE+Ta5zfT1RdUmqiNYHu/dJUyVr3OMdhRCPCialNJBZJ4SW5tUrxsL6zh7M/UokNqH6yTf8wqGTEUQEIfr4dc4lvrSjdIo+ey1Be1BM6nyPTuEpFOFnQrdI7SCraAESKSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO3VsLgA; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499614d3d2so4713547e87.3;
        Mon, 24 Mar 2025 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806604; x=1743411404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MBTv8wDbhpjg+5MeOQCqBqfNr19l5kdFji4eWbxmuA=;
        b=AO3VsLgAo+jXqDzIuDS0ut+qPqTSCtQTyRajl/ggokIlb5Iwyp9I7AZW9qz1Thy3jJ
         J5c0DJaZwxfHQbrLoKGMV8KRRP9zw6AKt2igKk2bL2lfkKMB/F3D2daVjmpcyzroRRFx
         dL49bQadH3EPCAbEBwV93Ya7XIEL0RMRKXYWLXH45FU5UrEYtRGPINiZbesetwzMFxzA
         5NPkIDAcNqhM8Zz4sLO3099Arps4GSODO61xBPqomsOp2W1kk0ckcxeg2mwuk/DCzYwd
         fX9LU7l12483R9hVKxzhIIr8W5Zo6IWMxr1N+zLxEnAN6Z6NGosHgqaTy5QoEstGot+U
         W01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806604; x=1743411404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MBTv8wDbhpjg+5MeOQCqBqfNr19l5kdFji4eWbxmuA=;
        b=C4pWR88OTJ4OsxoNWqdxaDKSml5TpxDKGqsHvAG2bMlTwILb7dtk5HKbghMSNVAi3r
         yCfB9dqrGsWwO8XvSsiX3XFUt7wsKI5onukHCt6IWSxay6b2j90mIxBKwk/9P8kQ0msK
         Jk7IY69L9jrBcoGNazqWVw0njUZWf7wZcmtmP0Hy63nRpjfgWrnWTtaSyoTB+xH9sSdt
         lsFp+wDTfIsyBifnR9Jpj2JqV/ggsEpWCVK8EyZoHmRg4FahZw8JSBMcWWdQOuXhf4KM
         PyBCLBJTNotAB7MfAGW/XjzWhqDxH1zXkobGr8k58l5+PhQNd9nEu8nx5xdsRSGH/pFz
         1omg==
X-Forwarded-Encrypted: i=1; AJvYcCWOnwIF+mt1gABKQ8EDhHbI91ci0eDgnc6l9u3YW5H1BPfyBHCbJU+D2mKDnNANwVp0MT+6tZGq99Tm@vger.kernel.org, AJvYcCWm7lheyBySZTmCL87cuqFDCrFOwPIU6rd+euU97cKvm6PGUREkOFbx44+qFYadr0Jw3A2ZTz3x1YAvnKE1@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHoP18YXyAgIm0IEnxVINjNVzhMEtgeYVm2Fg9Ns03FxI5J8T
	LHRwVZsJw/VEizifYJWbLK3LAI5G4zMmQ7bkotHvDKOvZ31DVOEIiXihOA==
X-Gm-Gg: ASbGnct+8kaVKt2ePla3XW5PzGm1u7BfzmtJ6/QQcQatR8tf4G12DoQRtvCnjmIrNZd
	us5bNrd1bR7zKSPGUV7Untg5aG7BZ/ImGBxaQV4cYaAPxc8ADgSbOQaVVL3gIKBdCJX7hah6YK4
	fDLUj6H0Kws9rAd8pURvOMAe4Mlzw2GCBhFB1dgmnrE6xgtC9nK6S2dv+gLWihWNpLJqjmhLRQ/
	A1FtvEckaNpaerlcGG4wtLaLTwOcKi1mny47cehfiGEudYA9GfPe8cb/pvCJaUt89qrSboYtvtr
	sfv2H6L/dHiV8S/2TSZyeFqnY5XqYHkHZPcn81Os4L7UZUGUHTA=
X-Google-Smtp-Source: AGHT+IGrP6svr/z5pv0/3y5rivGjoodOHh2/Q1nNE1vHxyzQcWhkLTFapi32xNxn7eLpIsagDqswZA==
X-Received: by 2002:a05:6512:130c:b0:545:b28:2fa2 with SMTP id 2adb3069b0e04-54ad6476fd4mr3637826e87.7.1742806603636;
        Mon, 24 Mar 2025 01:56:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64685besm1097252e87.33.2025.03.24.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:56:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:56:37 +0200
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
Subject: [PATCH v2 10/14] mfd: bd96801: Support ROHM BD96805
Message-ID: <7e81709d2ca56d1ee60ee8af5db86109869da862.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IapNYVAZLjooksJM"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--IapNYVAZLjooksJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96805 is from the software perspective almost identical to
the ROHM BD96801. The main difference is different voltage tuning
ranges. Add support differentiating these PMICs based on the compatible,
and invoking the regulator driver with correct IC type.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Use chip_type enum
---
 drivers/mfd/rohm-bd96801.c       | 22 ++++++++++++++++++++++
 include/linux/mfd/rohm-generic.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index e5ee5f556a55..dd0be7d675b8 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -220,6 +220,10 @@ static struct mfd_cell bd96802_cells[] =3D {
 	[WDG_CELL] =3D { .name =3D "bd96801-wdt", },
 	[REGULATOR_CELL] =3D { .name =3D "bd96802-regulator", },
 };
+static struct mfd_cell bd96805_cells[] =3D {
+	[WDG_CELL] =3D { .name =3D "bd96801-wdt", },
+	[REGULATOR_CELL] =3D { .name =3D "bd96805-regulator", },
+};
=20
 static const struct regmap_range bd96801_volatile_ranges[] =3D {
 	/* Status registers */
@@ -599,6 +603,20 @@ static const struct bd968xx bd96802_data =3D {
 	.unlock_val =3D BD96801_UNLOCK,
 };
=20
+static const struct bd968xx bd96805_data =3D {
+	.errb_irqs =3D bd96801_reg_errb_irqs,
+	.intb_irqs =3D bd96801_reg_intb_irqs,
+	.num_errb_irqs =3D ARRAY_SIZE(bd96801_reg_errb_irqs),
+	.num_intb_irqs =3D ARRAY_SIZE(bd96801_reg_intb_irqs),
+	.errb_irq_chip =3D &bd96801_irq_chip_errb,
+	.intb_irq_chip =3D &bd96801_irq_chip_intb,
+	.regmap_config =3D &bd96801_regmap_config,
+	.cells =3D bd96805_cells,
+	.num_cells =3D ARRAY_SIZE(bd96805_cells),
+	.unlock_reg =3D BD96801_LOCK_REG,
+	.unlock_val =3D BD96801_UNLOCK,
+};
+
 static int bd96801_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
@@ -621,6 +639,9 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	case ROHM_CHIP_TYPE_BD96802:
 		ddata =3D &bd96802_data;
 		break;
+	case ROHM_CHIP_TYPE_BD96805:
+		ddata =3D &bd96805_data;
+		break;
 	default:
 		dev_err(&i2c->dev, "Unknown IC\n");
 		return -EINVAL;
@@ -717,6 +738,7 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 static const struct of_device_id bd96801_of_match[] =3D {
 	{ .compatible =3D "rohm,bd96801", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
1 },
 	{ .compatible =3D "rohm,bd96802", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
2 },
+	{ .compatible =3D "rohm,bd96805", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
5 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd96801_of_match);
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index 11b86f9129e3..867acf5baefc 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -18,6 +18,7 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD71847,
 	ROHM_CHIP_TYPE_BD96801,
 	ROHM_CHIP_TYPE_BD96802,
+	ROHM_CHIP_TYPE_BD96805,
 	ROHM_CHIP_TYPE_AMOUNT
 };
=20
--=20
2.49.0


--IapNYVAZLjooksJM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHkUACgkQeFA3/03a
ocX7YwgAw6q+DZ6p4JVvvT0T/Fe9cDUfN7Po0unmf2SbzcMwCEIX1CYLCBnNz0+B
La5BV07SCCQGzDhMI++N5WKZdRQBZQJ3rijpb21CCesfcQmAb+GYG7qorvNLHNIO
1PC4A2Dgz0b5GK1hB0FQ3OB1RfOErra4ghV8h0/aBxmc1DIHj4CLQJa49wpzN2SG
ddD4acwSL5ZuL/KJNs5K+68H/V5tLXOLwVWOsE3x1Y0M8GO7L+ExwLfCN7ZSN87u
RztNV5q8x4GNtD6GSJ8nSCGaYjH62d0YZGf7A3RkLjrZ6Nutba2zWCcQqQiDExrA
5v84Ei30/1gOdZJCEG9wU+657qWm2w==
=z+UE
-----END PGP SIGNATURE-----

--IapNYVAZLjooksJM--

