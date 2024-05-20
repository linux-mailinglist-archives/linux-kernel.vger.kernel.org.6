Return-Path: <linux-kernel+bounces-183738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC7D8C9D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798581F211FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C070CC9;
	Mon, 20 May 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3zvRxp/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CF5676F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208302; cv=none; b=cUmrM9ygZ8YMRtYKBn3WmFvi0xg5oDIFQN0QMQ34IbvT6fKwNwBy8rd3PXWK0do2pMZ0Vdb7yNhN4oSvbLBRHepPqiuZ8GQdvXxHAgzJDtc0yxYyo2Ysjy9rC6sKIYUaaJR4leucanOO+xHln2f44VD/HU6LPgu9oDxzOVA+iCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208302; c=relaxed/simple;
	bh=JlQi7JvPzYAh931C9hlA44AF+MHsVYcwagV0PqFnFlc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m45IjCtuYuZF7GEqY0svzBwJWNAODEucNUvmsbzUvGqCt9NCbpkAlx4SwCURv9TCXAnXu6SAjZedO4fF/8PENqi7hOwLSYIKClYGWnuu8iqMIAD4B2wAUbrRp3zKXGxpj1Sxo4Cgxj5nEmvaVonhkYsHyEqhWl501HGhhxg/Ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3zvRxp/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so2938900e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716208299; x=1716813099; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrNYhx8ZBcKxATOUkC1QoO08RdNV/YVLLnK8c3rxE+U=;
        b=K3zvRxp/F3Bbm/C9VQDIuRZKn167/n5DV6I/KzcnEt83NY5qw05uWrqIVW047hOnVQ
         9Hwd39Tyx4q2Yb5C4kBiNxlYHGjVWaOPyLiajJD896kORTG4eDWDO397Mt5Z3X9b/m7a
         YHU0Uap7Uy1KwJVmntWeOUjpPvlyoDauKUxdSfVBgUPJfUeUlL3UVWQ598otxm/4epSc
         Mj1Bd4APHBNHgZpwnYUwQZKykPKNjCQUfArDug15HWGZ0tZuw6cT8mBzogIg9svuNPvs
         IKSUKBiLul2nv4NUyWWBnOhcesa7WdTs/Q0q4DvgbGvV70rI/MqQyQPjFcpKZu7H6v/I
         6KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716208299; x=1716813099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrNYhx8ZBcKxATOUkC1QoO08RdNV/YVLLnK8c3rxE+U=;
        b=aTXQ38TlzyMWp02O3mJ5dsYxDeCLtV4qW4XmLijTAFHuaDt7sJKcRpMu/Xp96fhM/m
         nEus3DQPI+Fb0PdZvi6g9v5Ok3sBPnsaCx/5IeZyKArcP8NAYkETLjihOSElMB+IyGNv
         +fercgQWlozLICHT7YsCWoQ5Fq/3wz3aNKy9KWULwKdRMhqmhNoBUYdZOzX0Dh7mul/S
         fW95uSL6pEzifN9J+RpMbAdQgiY2QrlYvEunxV85xBjUI8GXLkUq2NtHMGEzbCFiBxC2
         h6hco5yESR34fRX5hrUWzjGfqEqL+j9rbkw8Kw4uKc3PUoxxatWVSF0yb6ItL+0ODScP
         OCpw==
X-Forwarded-Encrypted: i=1; AJvYcCWIzyXOrLHe+ph8/lM5KnEpU8dEOsBKN82h6jhKcPfoQygBDmMq1JIv31YYgRljdRcOdEonP6qSGQFb63pjPWtrvvyi38d75tEXfGFZ
X-Gm-Message-State: AOJu0Yy0mxn4SUpQwKwPnxu7hg7mWtwaz4wU9oJ5UxPgdkr0fNytT+Gp
	c+KNeUoNW1nZhsoZlIvrVBCtE4u46NwUC7h32zx4yOt9lm/aW4LP
X-Google-Smtp-Source: AGHT+IHVQBHB0VVTEhCM9JoKzXVf7nxkpLDiiXfJwLS7t6LtOGkpJg540LWPjs6gZEjAhfbxgfzrgw==
X-Received: by 2002:ac2:46e2:0:b0:523:8744:54ae with SMTP id 2adb3069b0e04-52387445634mr9038073e87.63.1716208298578;
        Mon, 20 May 2024 05:31:38 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d7ee4sm4260420e87.182.2024.05.20.05.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:31:37 -0700 (PDT)
Date: Mon, 20 May 2024 15:31:33 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] regulator: pickable ranges: don't always cache vsel
Message-ID: <ZktCpcGZdgHWuN_L@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hot7rdN1Y0E6fLAD"
Content-Disposition: inline


--hot7rdN1Y0E6fLAD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some PMICs treat the vsel_reg same as apply-bit. Eg, when voltage range
is changed, the new voltage setting is not taking effect until the vsel
register is written.

Add a flag 'range_applied_by_vsel' to the regulator desc to indicate this
behaviour and to force the vsel value to be written to hardware if range
was changed, even if the old selector was same as the new one.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
I have a feeling this same thing should be done with the apply-bit
writes. I just wonder why no-one has reported problems with it. Maybe
all the hardware with the apply bit has 'self clearing' apply register
marked as volatile? Anyways, I'll leave it out of this patch because I
have no hardware to test the apply-bit stuff, and as I haven't seen any
problem reports about it.
---
 drivers/regulator/helpers.c      | 43 ++++++++++++++++++++++----------
 include/linux/regulator/driver.h |  3 +++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index d49268336553..6e1ace660b8c 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -161,6 +161,32 @@ int regulator_get_voltage_sel_pickable_regmap(struct r=
egulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_pickable_regmap);
=20
+static int write_separate_vsel_and_range(struct regulator_dev *rdev,
+					 unsigned int sel, unsigned int range)
+{
+	bool range_updated;
+	int ret;
+
+	ret =3D regmap_update_bits_base(rdev->regmap, rdev->desc->vsel_range_reg,
+				      rdev->desc->vsel_range_mask,
+				      range, &range_updated, false, false);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some PMICs treat the vsel_reg same as apply-bit. Force it to be
+	 * written if the range changed, even if the old selector was same as
+	 * the new one
+	 */
+	if (rdev->desc->range_applied_by_vsel && range_updated)
+		return regmap_write_bits(rdev->regmap,
+					rdev->desc->vsel_reg,
+					rdev->desc->vsel_mask, sel);
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  rdev->desc->vsel_mask, sel);
+}
+
 /**
  * regulator_set_voltage_sel_pickable_regmap - pickable range set_voltage_=
sel
  *
@@ -199,21 +225,12 @@ int regulator_set_voltage_sel_pickable_regmap(struct =
regulator_dev *rdev,
 	range =3D rdev->desc->linear_range_selectors_bitfield[i];
 	range <<=3D ffs(rdev->desc->vsel_range_mask) - 1;
=20
-	if (rdev->desc->vsel_reg =3D=3D rdev->desc->vsel_range_reg) {
-		ret =3D regmap_update_bits(rdev->regmap,
-					 rdev->desc->vsel_reg,
+	if (rdev->desc->vsel_reg =3D=3D rdev->desc->vsel_range_reg)
+		ret =3D regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
 					 rdev->desc->vsel_range_mask |
 					 rdev->desc->vsel_mask, sel | range);
-	} else {
-		ret =3D regmap_update_bits(rdev->regmap,
-					 rdev->desc->vsel_range_reg,
-					 rdev->desc->vsel_range_mask, range);
-		if (ret)
-			return ret;
-
-		ret =3D regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
-				  rdev->desc->vsel_mask, sel);
-	}
+	else
+		ret =3D write_separate_vsel_and_range(rdev, sel, range);
=20
 	if (ret)
 		return ret;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index 22a07c0900a4..f230a472ccd3 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -299,6 +299,8 @@ enum regulator_type {
  * @vsel_range_reg: Register for range selector when using pickable ranges
  *		    and ``regulator_map_*_voltage_*_pickable`` functions.
  * @vsel_range_mask: Mask for register bitfield used for range selector
+ * @range_applied_by_vsel: A flag to indicate that changes to vsel_range_r=
eg
+ *			   are only effective after vsel_reg is written
  * @vsel_reg: Register for selector when using ``regulator_map_*_voltage_*=
``
  * @vsel_mask: Mask for register bitfield used for selector
  * @vsel_step: Specify the resolution of selector stepping when setting
@@ -389,6 +391,7 @@ struct regulator_desc {
=20
 	unsigned int vsel_range_reg;
 	unsigned int vsel_range_mask;
+	bool range_applied_by_vsel;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
 	unsigned int vsel_step;
--=20
2.45.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--hot7rdN1Y0E6fLAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZLQqUACgkQeFA3/03a
ocUURAf/R3C9yigGG6a8fF52exxcbKlHBtfHAh/8zakCxu+pxwtaZAOq7wSEN9kg
KZqS88pZCuz+3Gu6l3o2dKLNTWoRPXsWXq1xQqD0jgL5mx3XaiPg7fBjJySEiyGX
Z+YJKZPpMqOB2mCvQwVGNGR1Tc6U+fq6Qms7ZRb67W6tXv3lvoS6OFPwm4sjy34q
+kq5kKX7ZcXBSpqCsXyMC14eCIQo6YjfQU7fNvs0ATkMFe6hwyopmhMFspbv5SVQ
KzuOocEFE50wTBNl3FWVgQsszGk+xfmxC920urz3I1+9R9ZFsplcSW5lfcoyH6xv
pRn3Avwqj8G5176Y7NeDr3uqlM7SPw==
=4W/Z
-----END PGP SIGNATURE-----

--hot7rdN1Y0E6fLAD--

