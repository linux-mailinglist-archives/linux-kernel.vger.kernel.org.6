Return-Path: <linux-kernel+bounces-559380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAEEA5F2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA77019C0C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3324267732;
	Thu, 13 Mar 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5Boa5kT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FC2661A9;
	Thu, 13 Mar 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866180; cv=none; b=ThaGs0FQcnZefkJ6wNBU4b5BQMg86Zk7mrGcUHMpMnSsnOlY0sdC0TwDIdeElPhwOrPo8dh3j9nZh3EBnUfjoGPhHx5ohuO1Gs6nP3O3nRqfaEix7BXiX/66+WRrGhEDeTB4+/CBhS2Mkz7RjTQWSGoCGRg/3auvQXyblTFxLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866180; c=relaxed/simple;
	bh=GnM9+ODiIobRJJe/t+mogebEdIauojstQQxKYura4pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJJhyfKfRA64dSNgb3WYYtJ8tiRiQ0NWwbU20P0qM1ukBGlaPNs+MLh1IAIjYmjOnfaz8ycBprcInswTLpg0Kq0qmTOOdwOVc+weznd7f4Ysp3HBhoiKErMdzwBawEdjN02R5neJ1O8oFjpIRcM/mOruRojJB2v4HfSAG2c0d+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5Boa5kT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so1003651e87.3;
        Thu, 13 Mar 2025 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866177; x=1742470977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3/RVKBOntsSZqZfSIlTjJnIJ8gX41W/BCOeO7xEtek=;
        b=j5Boa5kT/WkJItl51m4ZldCtjs6ITgL+4bHHu1CtpbsIe1ZLbb6deDtuOWgUG/9WWk
         OGJXJtl7+G3117fMud3K93nzXLQFX3dCSgvYABjy3/wo1IEAJ3KGj20izbmY88ln6KaE
         VJX11fGwx4kdG9LpdMUL2zKnLJdINfqLzQvWkuyzFo7euzETf775RBqq55kgSOvFXdox
         01Lj1K+cJa4K0Z1jyqLoui2/X9DfrxJAkjbI0JhQRRN/oG1zzWWSYYWFlmGkelkuRBpQ
         p23B0e2a2drkZgqjho+yYyO2NEVcKBHuEEL0Uz3t6HHuF/Ag9uV2O/ynvqHyZoPijV0g
         gggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866177; x=1742470977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3/RVKBOntsSZqZfSIlTjJnIJ8gX41W/BCOeO7xEtek=;
        b=Q5e1Ikbwjzu0NSbYQwpB/Ab3xkcwVrjXWEUOZ16uZe/ntehWQZg4rhb5oGaTnWQIwI
         WCXm5M46XDd0DXWm9mR4RgfhyPX9lT9X5RTyEUqBUdUuekYhpFuckxhW7DYOQo6bmIsW
         /OkUffTG4GT5UZGBS+8aCnDDYBlVjpBx7qV8nl8PBsewxYFj+pGHm/t+FL5dEFbrbGaW
         VRkuWM/BPyoq2e6yDtWFOmAfitSiUCXoAqP2Hze48IH2UWYu0pUAjZf3i23ssBOrpAzB
         5eAbIWai8FtCc7Av25LTQg2n+nQcVEq6OTI2sswI9QG6o+ja5dvmQxBoQRhazY8WMqIY
         zzBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+yAvcOh4LOMB7PqVMSnhwHAZvtmBvV2zwkAM3bAfgidpowugdY7dO2hVgZk1FIoZrASaI6/KEahzG@vger.kernel.org, AJvYcCXrt3VsNG8XuhydoD6ssdtiNJmMdI8kjghgNBWWKUV/HoN8d6E0HnDLAc1UnlXi/T3228PCaduLB94rV3mB@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWI0c1ZtEzJy61rViHI42uhJC88wrU/FrxYcYGI6IhzNADRmO
	lpcZnRu3QGUbjGOKiU6DbItl0psB8KgxlrJstRQbdgUwMvMdnkPJ
X-Gm-Gg: ASbGnctj6dCjNpT/WbxjQ59dfl8aXPP/q111KuGQK+mCeCT464wR17MBHeRAFQMTpL8
	gbG3rmEWN93Wbel7mmCU98xv1xoYUD5IeT0IrnhQsYF1avLjNKWbUPqMI6IehIYN0hXPFsgbAY1
	es5BR4oaOvg+q2z+7f5ArCBvWBAWjiXSnK3s5wHM3y6ramYt5XDb6tn9ToDERHNtKBQHzSnfx/S
	uWVjHk/dNeKaAgowUB/nn9b1jzoe+E+lXvtrACNhpupz0N+6OAepZVBM9cXj42VSjyt8cRgncx0
	63PGf0NTpJTWZ5LitmeDt5274A8lWrA9Vt/Ar4vAYlUZK6uB4YY=
X-Google-Smtp-Source: AGHT+IHSIjkVU6ozNSZvptBVnKyAgeqqKZ1m6gKHeVV7vL9fZ78Lu5io5UckwkTygdHeH9VSyLtihA==
X-Received: by 2002:a05:6512:1245:b0:545:441:52d4 with SMTP id 2adb3069b0e04-549abaccba1mr3389146e87.26.1741866176356;
        Thu, 13 Mar 2025 04:42:56 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba879ed0sm184418e87.163.2025.03.13.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:42:55 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:42:51 +0200
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
Subject: [PATCH 10/14] mfd: bd96801: Support ROHM BD96805
Message-ID: <125b495859e00d16dd59046fcb117bd8cbca5f14.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I+I55vHc4zvWt2vm"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--I+I55vHc4zvWt2vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96805 is from the software perspective almost identical to
the ROHM BD96801. The main difference is different voltage tuning
ranges. Add support differentiating these PMICs based on the compatible,
and invoking the regulator driver with correct IC type.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd96801.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index 2438cfdeecf9..2ab4e1c0f9b8 100644
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
@@ -599,6 +603,20 @@ static struct bd968xx_chip_data bd96802_chip_data =3D {
 	.unlock_val =3D BD96801_UNLOCK,
 };
=20
+static const struct bd968xx_chip_data bd96805_chip_data =3D {
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
@@ -709,6 +727,7 @@ static int bd96801_i2c_probe(struct i2c_client *i2c)
 static const struct of_device_id bd96801_of_match[] =3D {
 	{ .compatible =3D "rohm,bd96801", .data =3D &bd96801_chip_data, },
 	{ .compatible =3D "rohm,bd96802", .data =3D &bd96802_chip_data, },
+	{ .compatible =3D "rohm,bd96805", .data =3D &bd96805_chip_data, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd96801_of_match);
--=20
2.48.1


--I+I55vHc4zvWt2vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxLsACgkQeFA3/03a
ocWD1QgAuGDLk8yYF1cpx4h5ns7p9Dd4egX613GQKFeFZbSVUiMWfPaD/pJbjd06
u/XAxlDalxiiF5U/TQ/QACvYr8/Op0Uumhpdko+ik+c62J/hwd88GRBp9pc17Vlk
KtcCyBforIrcm9K4scbT6FhNn1TDwCpTn1idLSdNpKbCSHQqUqBYK7lMGMlcNDFr
mSTFFjdZhc+xVT3qatOiVUmt2HQohfFZmdm31mt75SGfmQKtA5H22rPAf0MFSIPf
gUgsYYattmXlysIgmkdzNrIEg83jXr9BOndFIhauKdGGCx4JEFBhSjPe+Jt4SKku
pyWrroZZXkjIDyjxCAw3DQQKlVA7JA==
=SOv0
-----END PGP SIGNATURE-----

--I+I55vHc4zvWt2vm--

