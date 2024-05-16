Return-Path: <linux-kernel+bounces-180800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5EB8C734D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E96F1F239BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98913142E91;
	Thu, 16 May 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9rS0oVh"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB62D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849699; cv=none; b=HSz3xRb8y056u7NxJsq614UznZt7nTmVcqkmA6TlSZ8ykOlB/0giBtKgTvDepsNcBQqhMX3XN8es2cS6O7fpF3sWAfe28zo0/rt+hdSiFxNT1TYxrOoZkvilu0OVmabz4l30gjmGeO0BdmQE42QRcaLQpC9lShqor3BpE9tpi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849699; c=relaxed/simple;
	bh=vmAg+FgarLaJFbkZMrmyFbmVsRcMYt086nIwji0hQ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDeTKpVG0SUuepV3M2FRc869548xrjx+3m6R84M+g5JoovwrqG8yzrXf+rBIpv+Vx/4c4x0sbmeOr76BhB8LHZ95Gbt8y9IYtOuXPOrtDkTqhsHqCuoyjqdTVi61+sdrUC7nKiNDTPpiBTOTin/Ri/fVj+it2z+yoZHIut2yVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9rS0oVh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52327368e59so532874e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715849696; x=1716454496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOReN2lzVLrwR7Z7Ot5yubLSaajl3RKaHFaHl+A5ziE=;
        b=d9rS0oVhMEbm2Mi2zc4V8QsgAAuhbV5DOH9/3rm+M8yg4bbrWxAYCvspSpCgKkLmSs
         B3b/R6Xyssbm9o4DLjtvzWvBr5+4qlNfyzLOqQT27DS7xk2fZA6PkoTd7RDYRIaurzrT
         S683cU2klYF7nqLV95KovmG4cFXaTkbJQl9LadpXjTybIx8zCYkAI8rJcpE1kaEZ0a7g
         sIhQHi5NgegYOTbDKs44Nn7u8O5dvZWxgiW7UvD4bffO0eGL+CSvviMj4UNegRizi55Q
         cFQXBxqspajhy2nGfDq5pQd4gMMc4dJNDOjMoSgRhTd+TG4L1JAQQYdCvgndIpI4R7ez
         4HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715849696; x=1716454496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOReN2lzVLrwR7Z7Ot5yubLSaajl3RKaHFaHl+A5ziE=;
        b=YMr8ePA8usSLlEHun1JsH7ez5f+dzAJ8usREzpbO5iTywVr869pguFqS4rD95y3r3v
         vSPsCoCWL6HBIJ8xmAa4cQhXrjYW8iSszPrVmhDuoSLdcE1SiS8kSlZliKPbC9BKDInu
         A2WSLjQTkTeOkmcVRHyxjHWOuBfRzF71kbULZSvBiAoaDedUUk/vxvstN8URQ6Nq24w9
         4A1jl3KpExIbwR3yCWa1Y85GiWWazHQRNDzZWIV4WNQAFqgaH1Ta7dLZzSDdCVdT4nLY
         nFnIYF+Flap4njH4qHpB4x43C5eEKwoe7eSWz3HznV7O6R28XKXUG9fZtVl4IrEGImgY
         WBIg==
X-Forwarded-Encrypted: i=1; AJvYcCX2xJP9/XZsunRnriiFwOFb9ksvbpY0XwzYBH0wihDLabDy/dkOv95gmysV6NdUqc7HSemBk3IPlBFoJppbcXz09ycvJBz/PSAnHMyJ
X-Gm-Message-State: AOJu0YzKqoDLkwEPavbLoq/o0ovyYnW4fGWKYmMqYlsrqgTp+2vnFpoV
	YvpgLQgzPpjkofRtZdssvGgy3ybZjcN8Ecst6+oc5RHzdzqteTPY
X-Google-Smtp-Source: AGHT+IFECwhgRpGyP/gELdKZazWEqfSBGJg0DsuHtwcNGRBAEwGTN2mvKDUgM5JaRuJiKMgJFgr57A==
X-Received: by 2002:a05:6512:3b14:b0:523:8819:6c with SMTP id 2adb3069b0e04-5238819010bmr4132458e87.30.1715849695753;
        Thu, 16 May 2024 01:54:55 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2c63sm2845026e87.278.2024.05.16.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:54:55 -0700 (PDT)
Date: Thu, 16 May 2024 11:54:41 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] regulator: bd71828: Don't overwrite runtime voltages
Message-ID: <e1883ae1e3ae5668f1030455d4750923561f3d68.1715848512.git.mazziesaccount@gmail.com>
References: <cover.1715848512.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ju4vgvCpkoEaiHHL"
Content-Disposition: inline
In-Reply-To: <cover.1715848512.git.mazziesaccount@gmail.com>


--ju4vgvCpkoEaiHHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the regulators on the BD71828 have common voltage setting for
RUN/SUSPEND/IDLE/LPSR states. The enable control can be set for each
state though.

The driver allows setting the voltage values for these states via
device-tree. As a side effect, setting the voltages for
SUSPEND/IDLE/LPSR will also change the RUN level voltage which is not
desired and can break the system.

The comment in code reflects this behaviour, but it is likely to not
make people any happier. The right thing to do is to allow setting the
enable/disable state at SUSPEND/IDLE/LPSR via device-tree, but to
disallow setting state specific voltages for those regulators.

BUCK1 is a bit different. It only shares the SUSPEND and LPSR state
voltages. The former behaviour of allowing to silently overwrite the
SUSPEND state voltage by LPSR state voltage is also changed here so that
the SUSPEND voltage is prioritized over LPSR voltage.

Prevent setting PMIC state specific voltages for regulators which do not
support it.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 522498f8cb8c ("regulator: bd71828: Basic support for ROHM bd71828 PM=
IC regulators")
---
 drivers/regulator/bd71828-regulator.c | 58 +--------------------------
 1 file changed, 2 insertions(+), 56 deletions(-)

diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71=
828-regulator.c
index 08d4ee369287..dd871ffe979c 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -206,14 +206,11 @@ static const struct bd71828_regulator_data bd71828_rd=
ata[] =3D {
 			.suspend_reg =3D BD71828_REG_BUCK1_SUSP_VOLT,
 			.suspend_mask =3D BD71828_MASK_BUCK1267_VOLT,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
-			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
 			/*
 			 * LPSR voltage is same as SUSPEND voltage. Allow
-			 * setting it so that regulator can be set enabled at
-			 * LPSR state
+			 * only enabling/disabling regulator for LPSR state
 			 */
-			.lpsr_reg =3D BD71828_REG_BUCK1_SUSP_VOLT,
-			.lpsr_mask =3D BD71828_MASK_BUCK1267_VOLT,
+			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
 		},
 		.reg_inits =3D buck1_inits,
 		.reg_init_amnt =3D ARRAY_SIZE(buck1_inits),
@@ -288,13 +285,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_BUCK3_VOLT,
-			.idle_reg =3D BD71828_REG_BUCK3_VOLT,
-			.suspend_reg =3D BD71828_REG_BUCK3_VOLT,
-			.lpsr_reg =3D BD71828_REG_BUCK3_VOLT,
 			.run_mask =3D BD71828_MASK_BUCK3_VOLT,
-			.idle_mask =3D BD71828_MASK_BUCK3_VOLT,
-			.suspend_mask =3D BD71828_MASK_BUCK3_VOLT,
-			.lpsr_mask =3D BD71828_MASK_BUCK3_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -329,13 +320,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_BUCK4_VOLT,
-			.idle_reg =3D BD71828_REG_BUCK4_VOLT,
-			.suspend_reg =3D BD71828_REG_BUCK4_VOLT,
-			.lpsr_reg =3D BD71828_REG_BUCK4_VOLT,
 			.run_mask =3D BD71828_MASK_BUCK4_VOLT,
-			.idle_mask =3D BD71828_MASK_BUCK4_VOLT,
-			.suspend_mask =3D BD71828_MASK_BUCK4_VOLT,
-			.lpsr_mask =3D BD71828_MASK_BUCK4_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -370,13 +355,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_BUCK5_VOLT,
-			.idle_reg =3D BD71828_REG_BUCK5_VOLT,
-			.suspend_reg =3D BD71828_REG_BUCK5_VOLT,
-			.lpsr_reg =3D BD71828_REG_BUCK5_VOLT,
 			.run_mask =3D BD71828_MASK_BUCK5_VOLT,
-			.idle_mask =3D BD71828_MASK_BUCK5_VOLT,
-			.suspend_mask =3D BD71828_MASK_BUCK5_VOLT,
-			.lpsr_mask =3D BD71828_MASK_BUCK5_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -493,13 +472,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_LDO1_VOLT,
-			.idle_reg =3D BD71828_REG_LDO1_VOLT,
-			.suspend_reg =3D BD71828_REG_LDO1_VOLT,
-			.lpsr_reg =3D BD71828_REG_LDO1_VOLT,
 			.run_mask =3D BD71828_MASK_LDO_VOLT,
-			.idle_mask =3D BD71828_MASK_LDO_VOLT,
-			.suspend_mask =3D BD71828_MASK_LDO_VOLT,
-			.lpsr_mask =3D BD71828_MASK_LDO_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -533,13 +506,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_LDO2_VOLT,
-			.idle_reg =3D BD71828_REG_LDO2_VOLT,
-			.suspend_reg =3D BD71828_REG_LDO2_VOLT,
-			.lpsr_reg =3D BD71828_REG_LDO2_VOLT,
 			.run_mask =3D BD71828_MASK_LDO_VOLT,
-			.idle_mask =3D BD71828_MASK_LDO_VOLT,
-			.suspend_mask =3D BD71828_MASK_LDO_VOLT,
-			.lpsr_mask =3D BD71828_MASK_LDO_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -573,13 +540,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_LDO3_VOLT,
-			.idle_reg =3D BD71828_REG_LDO3_VOLT,
-			.suspend_reg =3D BD71828_REG_LDO3_VOLT,
-			.lpsr_reg =3D BD71828_REG_LDO3_VOLT,
 			.run_mask =3D BD71828_MASK_LDO_VOLT,
-			.idle_mask =3D BD71828_MASK_LDO_VOLT,
-			.suspend_mask =3D BD71828_MASK_LDO_VOLT,
-			.lpsr_mask =3D BD71828_MASK_LDO_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -614,13 +575,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_LDO4_VOLT,
-			.idle_reg =3D BD71828_REG_LDO4_VOLT,
-			.suspend_reg =3D BD71828_REG_LDO4_VOLT,
-			.lpsr_reg =3D BD71828_REG_LDO4_VOLT,
 			.run_mask =3D BD71828_MASK_LDO_VOLT,
-			.idle_mask =3D BD71828_MASK_LDO_VOLT,
-			.suspend_mask =3D BD71828_MASK_LDO_VOLT,
-			.lpsr_mask =3D BD71828_MASK_LDO_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -655,13 +610,7 @@ static const struct bd71828_regulator_data bd71828_rda=
ta[] =3D {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg =3D BD71828_REG_LDO5_VOLT,
-			.idle_reg =3D BD71828_REG_LDO5_VOLT,
-			.suspend_reg =3D BD71828_REG_LDO5_VOLT,
-			.lpsr_reg =3D BD71828_REG_LDO5_VOLT,
 			.run_mask =3D BD71828_MASK_LDO_VOLT,
-			.idle_mask =3D BD71828_MASK_LDO_VOLT,
-			.suspend_mask =3D BD71828_MASK_LDO_VOLT,
-			.lpsr_mask =3D BD71828_MASK_LDO_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
@@ -720,9 +669,6 @@ static const struct bd71828_regulator_data bd71828_rdat=
a[] =3D {
 			.suspend_reg =3D BD71828_REG_LDO7_VOLT,
 			.lpsr_reg =3D BD71828_REG_LDO7_VOLT,
 			.run_mask =3D BD71828_MASK_LDO_VOLT,
-			.idle_mask =3D BD71828_MASK_LDO_VOLT,
-			.suspend_mask =3D BD71828_MASK_LDO_VOLT,
-			.lpsr_mask =3D BD71828_MASK_LDO_VOLT,
 			.idle_on_mask =3D BD71828_MASK_IDLE_EN,
 			.suspend_on_mask =3D BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask =3D BD71828_MASK_LPSR_EN,
--=20
2.44.0


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

--ju4vgvCpkoEaiHHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZFydAACgkQeFA3/03a
ocWC5AgAipXd6MonmP0kzeRELFJtK6OA67RbNRKmxM/6wp1Mm5wdYEXVQMXlP26O
OIyyDnyzt0gf+eogfo/VwYOVjxpg7GBYGBD82Swik8NcDdoXYTjYxMyD2WwauJWZ
ISHNkigHIj9rul/3xotzBjfuKDr+Apero8B/8vFHKkdY7KJaul+rk6xN/D/2UCd3
1tqbtA9FjaqS9rm7uozYnVyJnepdL+vbbEgLZzkTfTPzYhH44HXzQy5NE6ekLyIj
FknwW4pJsl6msxT4H0gqLnV0FwNxIhEzjjYJpZwB5xcgFesNLcBJ7/tNLBAolxBa
GUlEWYC20mSSjq/LcbFoC+C0XDH3oQ==
=d9y3
-----END PGP SIGNATURE-----

--ju4vgvCpkoEaiHHL--

