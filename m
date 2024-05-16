Return-Path: <linux-kernel+bounces-180802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A68C734F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD6E285AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C43142E99;
	Thu, 16 May 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNKZOqf9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782414372A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849751; cv=none; b=Iwk0Hj6RHjH3aHB+TYvM8CK8CTo3QYN4d5hbWzZnZZTL3WthyTsZmGh4HgI84AVheSs3onyLu6Ll0e1N8aNFnw8sVRFKDJgtH6KRxRLpRk8GB0GxZgKNMY2ausvfWj0/UrxqOdS95cVS3Ir/MHCkzwsOi95qXM2w3A2AKpxrk6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849751; c=relaxed/simple;
	bh=UH6o5tnApQDxK9LmOd8/qeqo92iXYibQSiMF/ytYgx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6dAkfvFxtLfArR2tLOnwWFE+cBZHAvuPfldYsOcmktFMetDKSdciYbZz64obFZP8X6l+PT9a7Wsa1BLDt6f0wdLWCxiZWdlw/G6bGkYaSjeYClFgIyuAGwwWaOGhcc0lV+K9NFBR3CSTYT4VYnXQ0Hc0T0c4MJTUNLgi39OKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNKZOqf9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f72a29f13so611828e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715849745; x=1716454545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8v7X2F3uSyb2mvD/tgvgRR3jPHgfhOPs6JPuD+m7eEc=;
        b=QNKZOqf9OPTEi3plzPwXXG1M+QVUgpmrHgmLDH0q65O5voeYysp48FED3JC5MgLwwA
         Nb2QUBD8xGR+J20od8B/5RJw4TbXekBRgVBWtRy0Fi9ipG4NWTjGqrFgJQJ/uy/xE+Wq
         hjF8rsV7XB4mqaJOr+MA8rak3gViZCSF3XT54m4ok1VddRz/I6habxCTXlyv63Pb4LIP
         8spIxDXAJrkipbkP+MAU+eMcGtfNVLmqXChqJtqTFgmLW/iEPYsy7iL+4n+BRcOVR3Ds
         YFiSaGRCbK9V7+TMt+eTIcqQE0JZLXDF29uxyWOPDSTnjBCuDrMzX1WESJQLGDoeEvhY
         9q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715849745; x=1716454545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v7X2F3uSyb2mvD/tgvgRR3jPHgfhOPs6JPuD+m7eEc=;
        b=EWGizEUIDyAuReivkC3i4KsLyuxMaG9K4eOc6OBDEnbP1DlBqQQ5TFVb9Tb1o6xXWP
         +465X8jKS5eIhb5FMUel5mGbfSbEhMu39xMQEcG+pKcaoIrCJStGSXM0H2MWRZprwvrz
         OqBz2PGylzi/q385C7MTR6uFH3hPQc4tbCBfzG6W2DAAmbZNqQTFiAH3TBDzXOqqu1FZ
         38FWeqzUnbMGKVKRFcts/ol5E5IYB3Yt2gMkgQo30aVM5UTFtQHIb/RXptc/rHeWGzAa
         RAQBfF9tOn/zka3sjj9TOvAF8mEGXqcV5CTiGUlyhdWk4AXjV7E44xrDx4YYPjQ0BR6Y
         9PEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWcYu9TWcfkpannoq7gTecYJw09l8vnX5JPL9ejyAqZQipHbc7PpGFrJWTqgXJsRDoS63kwPtaZ6NRx0VEAxpff7YiwXSYQKremKm1
X-Gm-Message-State: AOJu0YzSZ4nI3v2M5l7RusO9P627xcg3TMiCVktoKpv3Tg2u/78APGuD
	g9mkHELjDaThprN+FCxKyL4/nKKPhzjbadu3fJQOTCPfDbE5uapG
X-Google-Smtp-Source: AGHT+IEP8K8j1OdOwH5HaXkQYTZO6ffgftngytdera6X8KJRiHgAwcWmTS0/I6a9ZxVyRHUL9ZOR1Q==
X-Received: by 2002:a05:6512:312f:b0:51c:1fb4:2327 with SMTP id 2adb3069b0e04-5221006f7f3mr12343900e87.24.1715849741042;
        Thu, 16 May 2024 01:55:41 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2be2sm2893269e87.254.2024.05.16.01.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:55:40 -0700 (PDT)
Date: Thu, 16 May 2024 11:55:37 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] regulator: rohm-regulator: warn if unsupported voltage
 is set
Message-ID: <0937411855967cbefd9ff2d6045a52ca26712c4a.1715848512.git.mazziesaccount@gmail.com>
References: <cover.1715848512.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="feluPDTPybhE8DMK"
Content-Disposition: inline
In-Reply-To: <cover.1715848512.git.mazziesaccount@gmail.com>


--feluPDTPybhE8DMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few of the ROHM PMICs allow setting low-power state specific voltages
for regulators. These voltages are then taken in use (by the hardware)
when the PMIC state is changed.

The voltages for these states can be given via device-tree. If
unsupported voltage has been given, the users have only seen print:
"driver callback failed to parse DT for regulator <name>". This does
help to pinpoint the problem to some extent, but there may be several
properties in device-tree so it should help if we can be a bit more
specific.

Print the voltage value and the run-state property if voltage can not be
supported.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/regulator/rohm-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-re=
gulator.c
index 0e2418ed957c..4b95ca01959c 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -46,6 +46,7 @@ static int set_dvs_level(const struct regulator_desc *des=
c,
 			continue;
 		if (ret =3D=3D uv) {
 			i <<=3D ffs(desc->vsel_mask) - 1;
+
 			ret =3D regmap_update_bits(regmap, reg, mask, i);
 			if (omask && !ret)
 				ret =3D regmap_update_bits(regmap, oreg, omask,
@@ -53,6 +54,9 @@ static int set_dvs_level(const struct regulator_desc *des=
c,
 			break;
 		}
 	}
+	if (i =3D=3D desc->n_voltages)
+		pr_warn("Unsupported %s voltage %u\n", prop, uv);
+
 	return ret;
 }
=20
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

--feluPDTPybhE8DMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZFygkACgkQeFA3/03a
ocXm8QgAye7nLPVpI2v476i5jFtamsFRBEGpB46uHujOWQ53QkPi+MbyRIwKetaA
t4L1MUSRAfiD1l1/3KJ6P1fEDHBzZA+F8QVdCObeP/WK0rtOFf6yno/7a0dYzdDd
HchK982+S3rka6VWEUaOyn+jin9ITX8B8JacmgiGyXKXYaYwxSUOyi5HXtaxBWNP
8WGsMscrE95JvOMV69NwtktBgLpUoOzu8/wo3BoupYy/Qan/JwAT5VzctfX0h5yP
MWZNDlebKbOrq2xUbLhfQqu3SKdpbaPiSsWV11zcj2pTa8HCBfbt/GqFuoS8c9fC
s6q5S+RrVr4YI1T4D0At0xiJMZihdA==
=IgwW
-----END PGP SIGNATURE-----

--feluPDTPybhE8DMK--

