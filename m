Return-Path: <linux-kernel+bounces-573402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F52A6D6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9867A66B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10125D558;
	Mon, 24 Mar 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQv9sp/5"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96525D1F3;
	Mon, 24 Mar 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806630; cv=none; b=SvohB/6Sd5Ogn79uzoPb2D3LIneky6NJYIZ5oHai5et/nPYRH+oaz3CZEQCH8ZIegFQ5FBYvv9Tfwbu78/dE1I1OB+0zicEx7qPGpTZr+3VxCRBr0flFpEJ6KS/984hyefq6aj2r6mELAbn8XzZTJoAEbWQtYaFsY1EYyY/ozzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806630; c=relaxed/simple;
	bh=jp6GIe4SvlBD3jK5D25GUlnPAlTE05/tZ8hDye76W+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z50MuNU+i8r0WWy7/uHwxPyoRoXVkeTrwGmFI7hSHuMtr4JT9b2sDO1EzD+e9L+Gu2q62366mc2AySGn/fBsecQh88Q9eosK6w5Cjh38gRtyXJqj7ZotFFlMkO/5PerOs64aSfZJgXi56eVJMEcztdW2dqZ5hfYJTYAnkKiWE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQv9sp/5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfed67e08so46374991fa.2;
        Mon, 24 Mar 2025 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806626; x=1743411426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWucvm9NaGNeYXaakaS0Sv7wrQXTDWGmsMTOybZx7fY=;
        b=CQv9sp/5vGF2qrWjc3CWgcZAwWzwhsUB3PJZT9P4OddEIJFKawmnmZJqVUS06LGYQW
         nRU9h3SiEax2qjUs/gebKgCiTaoNnNseSaZ73GiYBwETbtIPHm6cRpJ0aFfwKNOyakNP
         HRU5lTaoQngyXH6nOm/DerOB5gHywtOvdqW77DSmtex/x3mIQhkAZmFEfSXLzUhOgRhX
         UMdRYzkOS/q3/XxRFvZoQVDgxdFR5DjjuDh5IuKoN1NhAAJlVm5j8HfsP3fB7bbGtIJU
         O83Y1zmAjoHhDC0bcAG0MuTCSNA1sZqsZe9Ae7Z+R7pE+qx9Hx0PoSXe1vxo9BGu4O/o
         GoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806626; x=1743411426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWucvm9NaGNeYXaakaS0Sv7wrQXTDWGmsMTOybZx7fY=;
        b=bIHnb0EvyMSVlPBCVnjsn0X5MebK6A2c5Y6ZqwjqckanEYz+VtTBh2RG3k458iRqIe
         AqUQytYdvembnHLa0po4N3/H/QXnbvgj+dS8jZmWUVEgCe1DG/Hl5xyXnTBjfO875ner
         ny0A+fCLbZfFCFQk+EN7RS5SIvhO7Wq2ibPD3SVVyiL0hgPVbNuJ646BlL+Ez/c8ACQ4
         UMU6Fiu+dXm9nrAivIIGl9BOrOyCZGfd/eHS+E/BAWxKK1YQX12887WSt6xtrfuU8/CZ
         IOyYkZ90EzghWOmcewVezfInUr5+efB6dKnpd6wtrJCmKUYWXz4z8iu6ez9tAWaaQzax
         Uplw==
X-Forwarded-Encrypted: i=1; AJvYcCULzQcMezavKhYT51hwD/tv7H0jijxoi0qSa4N/BxUCzFmK9umBMoHXZ2xK1oIZMRyUyxKb+3UmZvNK@vger.kernel.org, AJvYcCW6n5SsusJ7X790y2UoK6FzM8UwwjZu/y315igVDtPUmqACfwC48MNj7DLJbfty4fCsZ8eQZ2P7Xkn7FaBz@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxuE0YGjAhS3F/j2K+C/y/yobph0/xl1QVT2EAU23CZzmoFzY
	B1U5q8sQoMC7PLMtgB6RTsGTcs3NG4ttMFk0iUA5xvKq0U/ytwCMpxhNIg==
X-Gm-Gg: ASbGncuMqGfUDMTE8z0eqgnu46flnw++8D6zwAMrBMVcECWtDyu+XQLuffWoouoKgV4
	ktEaIUl/cJ3YZ2ZtQFnjsuPJQfxuMMF31sVFTIGnM9MZRd1xbLv2KNcy8IBKNGWzsa5TDfev+dS
	cm171nUg+zPJdMucQ9p2T2QDx4BuA/SazphK+9lkuY2zsOf6VJGibckpFVZ8gfYpFvZXTX4SxXf
	FoR9/MASyci0cK70Gx6ngnDmPgJawP7QiU5+/nGo4HYhrN2iF6w+TopL/tFaG/eMLGqjS41AeZ6
	EO7MVlx3QcMwR+qQEHAv51abzn3XpkNB8FXNg/y+tJzGW39qbX4=
X-Google-Smtp-Source: AGHT+IGhSkg6sZudd7WL+JIhoq3uTnvPYNMrVwdgMiNaSnFM4tfEbRIz0Yb+65deJpqdoi+2eo4gig==
X-Received: by 2002:a05:651c:a0b:b0:30b:ba06:b6f9 with SMTP id 38308e7fff4ca-30d7e3001e5mr41670821fa.26.1742806626038;
        Mon, 24 Mar 2025 01:57:06 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d925949sm13095131fa.112.2025.03.24.01.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:57:05 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:57:01 +0200
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
Subject: [PATCH v2 12/14] mfd: bd96801: Support ROHM BD96806
Message-ID: <41eb1a3b174bce6bb979bfae0e2fb486be51d70b.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dqWsc0l52iLFBRzy"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--dqWsc0l52iLFBRzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96806 is from the software perspective almost identical to
the ROHM BD96802. The main difference is different voltage tuning
ranges. Add support differentiating these PMICs based on the compatible,
and invoking the regulator driver with correct IC type.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Use chip_type enum
---
 drivers/mfd/rohm-bd96801.c       | 23 +++++++++++++++++++++++
 include/linux/mfd/rohm-generic.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index dd0be7d675b8..66fa017ad568 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -225,6 +225,11 @@ static struct mfd_cell bd96805_cells[] =3D {
 	[REGULATOR_CELL] =3D { .name =3D "bd96805-regulator", },
 };
=20
+static struct mfd_cell bd96806_cells[] =3D {
+	[WDG_CELL] =3D { .name =3D "bd96806-wdt", },
+	[REGULATOR_CELL] =3D { .name =3D "bd96806-regulator", },
+};
+
 static const struct regmap_range bd96801_volatile_ranges[] =3D {
 	/* Status registers */
 	regmap_reg_range(BD96801_REG_WD_FEED, BD96801_REG_WD_FAILCOUNT),
@@ -617,6 +622,20 @@ static const struct bd968xx bd96805_data =3D {
 	.unlock_val =3D BD96801_UNLOCK,
 };
=20
+static struct bd968xx bd96806_data =3D {
+	.errb_irqs =3D bd96802_reg_errb_irqs,
+	.intb_irqs =3D bd96802_reg_intb_irqs,
+	.num_errb_irqs =3D ARRAY_SIZE(bd96802_reg_errb_irqs),
+	.num_intb_irqs =3D ARRAY_SIZE(bd96802_reg_intb_irqs),
+	.errb_irq_chip =3D &bd96802_irq_chip_errb,
+	.intb_irq_chip =3D &bd96802_irq_chip_intb,
+	.regmap_config =3D &bd96802_regmap_config,
+	.cells =3D bd96806_cells,
+	.num_cells =3D ARRAY_SIZE(bd96806_cells),
+	.unlock_reg =3D BD96801_LOCK_REG,
+	.unlock_val =3D BD96801_UNLOCK,
+};
+
 static int bd96801_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
@@ -642,6 +661,9 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 	case ROHM_CHIP_TYPE_BD96805:
 		ddata =3D &bd96805_data;
 		break;
+	case ROHM_CHIP_TYPE_BD96806:
+		ddata =3D &bd96806_data;
+		break;
 	default:
 		dev_err(&i2c->dev, "Unknown IC\n");
 		return -EINVAL;
@@ -739,6 +761,7 @@ static const struct of_device_id bd96801_of_match[] =3D=
 {
 	{ .compatible =3D "rohm,bd96801", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
1 },
 	{ .compatible =3D "rohm,bd96802", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
2 },
 	{ .compatible =3D "rohm,bd96805", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
5 },
+	{ .compatible =3D "rohm,bd96806", .data =3D (void *)ROHM_CHIP_TYPE_BD9680=
6 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd96801_of_match);
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index 867acf5baefc..579e8dcfcca4 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -19,6 +19,7 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD96801,
 	ROHM_CHIP_TYPE_BD96802,
 	ROHM_CHIP_TYPE_BD96805,
+	ROHM_CHIP_TYPE_BD96806,
 	ROHM_CHIP_TYPE_AMOUNT
 };
=20
--=20
2.49.0


--dqWsc0l52iLFBRzy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHl0ACgkQeFA3/03a
ocU0NAf/dj7gGLZfDyLqcWFvgKZ6R6k0xlvYh9WD+IzqX0neyFVciVQGZiFgTZAY
DPTFMOLBqE4fr6D5a6ckhJvuvVHLSEF0ppGjSzjxXG5Z/Xg5ClYyWpe7GQ0eDkLZ
wFfcZqgVsBWG5WQ76bVQqMJm8cPqGgC5Ac0qBJvRRMmSWSyDSXmklkhRZQgLjao/
seYYA1+wtHIS+I8iPKYfEfgbMAsO0spAVxN2iYA5h/W0lJoH4yVXZGjYc0Xymw6V
tHzxMLa02mGmzkglLydstOviScAuqcvtTG9zzTYj6Z6EV3doYHHhdxJ3cg4SUXFV
SBiIm568l0R5aNn5pTj8hNRtWZb7Ng==
=zKiv
-----END PGP SIGNATURE-----

--dqWsc0l52iLFBRzy--

