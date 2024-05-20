Return-Path: <linux-kernel+bounces-183748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7A8C9D74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E5BB22BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E355C35;
	Mon, 20 May 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRNtkcIT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909950275
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208630; cv=none; b=m2h1Glm/tvFigZj35A/jf1VCsCr+Jd3SJridIaUEJiwIFnU9Jzpf6o18s/Y8W+7+Q/hgL2r7vVMJ82tDvqIZLfngpExmzutSeCMN/0vAzbxCeK+5AmOmgBfVc3RTXu1P13aItztEzVyZvveY3Lp6p6FEUn2/2kj4UJkIBCPNBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208630; c=relaxed/simple;
	bh=OgdLUpSW9DzvTrrX9FwnFFIH/G0vAIHag+7Cg3w3T48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KVCnBVyTIqJQW8+hYJg5iNfwddmuOeDyPOS3RLWPaay9rkRY91So6UEwv7ewwvi6jqtpiN0EQn+XAIsPYpBG2XLWFfyBbF693YD+hJXUrH4/RQeTpT7NIGBWYwJmrjH50qg4akvrtVakcOXypy+HuPkU8tZ7Rk96aXdyVmAvNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRNtkcIT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e271acb015so54240501fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716208627; x=1716813427; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L26PlkWhQ//YcvEz188Hq57scALLWjwbCQn5B3+KM4w=;
        b=SRNtkcITwEnW8VzkE2lvqL6NSUUU3v3r3G840GqbDmkXMitku6NtrnD2bj4OdMYCnM
         8Kz+gGQFtkA1P6z/f16fsQy3XOP09ekKM1HhLe5rvnIl8iQ82JEs+ma6SRGzVCQ4WAqD
         IPPB0kuZW+Mr07jbr9f21Oo5xTueK2FVVWukiagahHShHTukLVAel5iGuJ0C63RZimRT
         F9L5i1U82/auM4RdNmcX75kP7EKroHy5BQAbrtVLj8S7J0AxJdGVAf2jUIkbk29k5Pet
         z9sCW7TZNdEhcwAKYaoxGIhh8a1oAolj6eyZGpyTShukpvMmBg9kIXYv0afXEl21Ep4L
         crrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716208627; x=1716813427;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L26PlkWhQ//YcvEz188Hq57scALLWjwbCQn5B3+KM4w=;
        b=EZQRfpcl3sDyviiOVm1PIioA09HjYoWCjxV6J7EKVc+6Bz98ziJkd5nJ0uMbYEmkhF
         5/NB3AnxoKXtYNzp8ZHdOVvvyF5ESHG55C6xXx62eM1BZEn9Uzr1oRtjGmDaqi+217JS
         oHWoS11xUPJT+Zf6dvrFcR+t7hoy3ynbZ+Y3kS/QbS6qMERX16a64cgycpx9xCxnJsr1
         JcIzIa/3G+Epd1BuGfd8NzdJJ4TuXtV8KAtDl8hMRlTs5Z6azaZfwJx0edNcPIR68lbx
         CL+0dH5rOZooNmDA8bQL4uF54rnzEpo7B5FHsYVKr/6SbDC30vIAeXPQe5lfuAov++rf
         qPMg==
X-Forwarded-Encrypted: i=1; AJvYcCVSk0s8tLdcXIRTL3QSu9L/p/HZc4FGDbi3OPWkfMm+WoUPaNjmAoodQXaBPl79HI4DU9NXTkMHUv7oez59Nl49wXBMnEeQzP3KRZ4I
X-Gm-Message-State: AOJu0Yywd71J356//45le18oyIZtCT/3j4vxrBYeii265OhY/bVc1Eav
	IizW4CZ/KAV1gVkPbot6QIeaUttdAgJCgcRIFG/ZGKX68ZE43VP3t528Dw==
X-Google-Smtp-Source: AGHT+IEjNZJ4bR6Ty8KOQqnKHn8m2U+u8hIUoKeyGoR02SOilyhLqGZwAVMNbKdMwcL8It+JsXxCxQ==
X-Received: by 2002:a2e:9053:0:b0:2e7:bc7:b6ea with SMTP id 38308e7fff4ca-2e70bc7b72fmr60305021fa.14.1716208626352;
        Mon, 20 May 2024 05:37:06 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d16200f4sm34631561fa.118.2024.05.20.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:37:05 -0700 (PDT)
Date: Mon, 20 May 2024 15:36:55 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] regulator: tps6287x: Force writing VSEL bit
Message-ID: <ZktD50C5twF1EuKu@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4RW6lHdK0m4qn3Ux"
Content-Disposition: inline


--4RW6lHdK0m4qn3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The data-sheet for TPS6287x-Q1
https://www.ti.com/lit/ds/symlink/tps62873-q1.pdf
states at chapter 9.3.6.1 Output Voltage Range:

"Note that every change to the VRANGE[1:0] bits must be followed by a
write to the VSET register, even if the value of the VSET[7:0] bits does
not change."

The current implementation of the driver uses the
regulator_set_voltage_sel_pickable_regmap() helper which further uses
regmap_update_bits() to write the VSET-register. The
regmap_update_bits() will not access the hardware if the new register
value is same as old. It is worth noting that this is true also when the
register is marked volatile, which I can't say is wrong because
'read-mnodify-write'-cycle with a volatile register is in any case
something user should carefully consider.

The 'range_applied_by_vsel'-flag in regulator desc was added to force
the vsel register upodates by using regmap_write_bits(). This variant
will always unconditionally write the bits to the hardware.

It is worth noting that the vsel is now forced to be written to the
hardware, whether the range was changed or not. This may cause a
performance drop if users are wrtiting same voltage value repeteadly.

It would be possible to read the range register to determine if it was
changed, but this would be a performance issue for users who don't use
reg cache for vsel.

Always write the VSET register to the hardware regardless the cache.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 7b0518fbf2be ("regulator: Add support for TI TPS6287x regulators")

---
This change has not been tested in appropriate hardware. All testing /
reviewing is very much appreciated.

And just a note - the git log for this file has a few invalid
'signed-off-by'-lines, where the last '>' is missing in email addresses.
I guess it's too late to help it, but it's good to know that the
get_maintainer.pl generates recipient lists where the '>' endings are
also missing. As a consequence, at least the version of mutt mail-client
which I use leaves the Cc field empty - which can result patches never
ending up to intended recipients ... not that the undersigned was so
careless sender :rolleyes:

---
 drivers/regulator/tps6287x-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps=
6287x-regulator.c
index 9b7c3d77789e..3c9d79e003e4 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -115,6 +115,7 @@ static struct regulator_desc tps6287x_reg =3D {
 	.vsel_mask =3D 0xFF,
 	.vsel_range_reg =3D TPS6287X_CTRL2,
 	.vsel_range_mask =3D TPS6287X_CTRL2_VRANGE,
+	.range_applied_by_vsel =3D true,
 	.ramp_reg =3D TPS6287X_CTRL1,
 	.ramp_mask =3D TPS6287X_CTRL1_VRAMP,
 	.ramp_delay_table =3D tps6287x_ramp_table,
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

--4RW6lHdK0m4qn3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZLQ+cACgkQeFA3/03a
ocVlJAf+OPTQb3cFf8kzq+C7N7NiYwVxkco/xW8BQSE/ugMthes4VC341nNWQoQy
0afm2u9EvHpAp5MOtVsipS3fKnsTpfPLqBsNdjt5DnYD+8MBX7zqfyp04L6hm1xU
xaQC+sWP9wfaSMLy+RrLpy/adfDBKcWgziGXkDmlTeMfhB4+BT+WI/EN3ySS66IZ
opxdhx4DvvUT6T2YDN94zq3hObaC02Q+kUT7bcidx7NA5x1cFHQHrpI4Ljxbj+zk
pkf77Zj4xdQNl21g1hU9t4sIFbo4fq7/hrsmwUS7nAs2qU7Z6EfOXfh+cF2q5f51
0kZedszcC3pHC853gjW3y+pwT5xC1g==
=RujD
-----END PGP SIGNATURE-----

--4RW6lHdK0m4qn3Ux--

