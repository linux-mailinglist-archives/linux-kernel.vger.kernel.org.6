Return-Path: <linux-kernel+bounces-573396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DBA6D6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6FF3B1AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974825D910;
	Mon, 24 Mar 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6AKU14Y"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CA25D904;
	Mon, 24 Mar 2025 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806568; cv=none; b=MyBB1/KTzjVdeAIKduxdh8bn6azAUA7wnVs2AQy4pa/HOkHIz/MQAIU5cHQXteJRLg5cvCiTMq+TCPVuCLGKgzmWQJpE8eFsfIAk5M5FuP+wEilriTIaYfNYFoJmuhGhP44UziPVEftzQWbH4u/+C7FIkFhlqWD5YoimwnzC44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806568; c=relaxed/simple;
	bh=KXs0caH43K2tWKZEbyZet9arlTRlx/bAscwgZ6pWNys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYymUss2iP8viSSRm8NGWvl13ILFZvdWKMtnixCTnYbg8ac7nk/iRa7YX6WT2EK36owsoplmt4Vh5N7ji5VeqFIR3gE/0HfWzz+2IBeGDvDUaEnJ5TbPW9xJ8AS1o3JYxQhyTCTdjRAjFK/pzgfLpkZGliBJiZng2/eKOu4tRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6AKU14Y; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-549946c5346so4510839e87.2;
        Mon, 24 Mar 2025 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806565; x=1743411365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtL7uwJe0eVpgthdISGFnYJ+MozwCudVEuMnjUqjLqU=;
        b=a6AKU14YI0sgPQDC5qsqltXnDyuYA+Ydx3zLDxOVUMCsGFSmWWluspZfrJ2ZwzvBWq
         AMivEL1TZA6Gi1owaZcHDNQkw+abFerHm5Vddwp/BExm+5uSTl86E4wOiPugx8vY1gQC
         sSDvcoMQABueAHaUiRlJxdunZ6zP6u81cyftIR2qYqqd4D0PC8PURRTVoOE2OKlSnGIA
         OaG8syNnZIAz9D4URfXJK+72FxQZljE4LnkKUlR2wNIa//oiAu7o5BVM4qvHrVhP+/2L
         VVphTas2A5WMfcCCUj3Uj9fSzAulPgLjX+u6GwUUKYJB5GeFVKIWSr3vvlB/TUWtJR1x
         T1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806565; x=1743411365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtL7uwJe0eVpgthdISGFnYJ+MozwCudVEuMnjUqjLqU=;
        b=kTqtwoNSlv1DkmnV1hunLHJjUUa/NBZrb3SgXKMixivA92k+6vSoceQcrh9cMCuMNI
         vj9ZH84PCXRQVNNDMmxfDO1oAY3YXHJrmQDwS1s83HABKMFi6CNR70KKOJjnHjX5NHD/
         g8py6oHyHRxXi7K3y5p4xMmXbtcDQ3hCVo59R3AB+o/4Df9zQuZqxWFaPSdD/3iFHqJ1
         2QSYFGYaBVrHCT6wTk77JPADhc7FbxHPcmJenCRlU541zEFBquttD9yjtaf/c2ULhfC9
         QrjpcEzStw2m2IOJjgvOMrTv/V0GvBlUbscWFCcesK5d+XfUlka+7PazhtlThwDJA/ji
         oTqg==
X-Forwarded-Encrypted: i=1; AJvYcCU4FoLDmZPgIdQ5iT7ojTmL3e4GhmX2W79O4z7zE3XJsFdYdjaMcwCueaZJGLkdGk2EuFouLxF5X0Gqm+ht@vger.kernel.org, AJvYcCW+nSlHFZOIihPWoEg/mGsYBvrwFXo5gSngKOQ5DjAzqHQNR4FgOO78JkzXxMp08gaq6J4Yt83/VAZ8@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjV1wEH3eLFHfAnkOmcdQYl3CXDDBCpmTtrIxpErKPJS4ZSop
	1OfBYRu5/dgilnXYeJ3bbo5rHnB5Owa8vBPgCA0vahtiyWBZewF9
X-Gm-Gg: ASbGncs7nADSQyc9eXQqq3omzpq00pHoegCiyWcTmpJcheaKEVajh0ZvWizuga8SA02
	Zd+zgg8JmM/qmZaMz2eE6BnUDZnu+zpEpTC+xshw2cO+pYZE0JXMX5fZPg4GeDyWiVvAOVUZsRR
	70eP4uqowVdUSKa7IEH3Qi0WrcWVQ7rgBtDAsski4s/nO8dgupZgLca3lBvxiOYVDG/IYJSm5zC
	hz7lSbU/pS3yB3vsLUyTS+EQOOMn3b5L438ktIypx+29cG3k7iaRjET+HWxbSGODmCejniZYAkU
	CG2mK6cY2NKT9X4SKYW8VQ07n1KGqSXgGhD6G4tvYaAOYyHIM3g=
X-Google-Smtp-Source: AGHT+IFxwdZhiHrDf3n9KaUX5zIf6aYBkFss9IpiWS6C1hHbCcqIYy2dBs6vcTGN5zqJfXZek7FsXA==
X-Received: by 2002:a05:6512:1255:b0:549:4ab7:7221 with SMTP id 2adb3069b0e04-54ad650bab5mr4095547e87.50.1742806564667;
        Mon, 24 Mar 2025 01:56:04 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad651243bsm1046909e87.249.2025.03.24.01.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:56:03 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:55:59 +0200
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
Subject: [PATCH v2 07/14] regulator: bd96801: Drop IC name from the IRQ
 resources
Message-ID: <820b18b8a2f8922f9f166fcf5a3f0f5b365b9043.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8UUBn7bx8lmda28C"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--8UUBn7bx8lmda28C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The resources generated in the BD96801 MFD driver are only visible to
the sub-drivers whose resource fields they are added. This makes
abbreviating the resource name with the IC name pointless. It just adds
confusion in those sub-drivers which do not really care the exact model
that generates the IRQ but just want to know the purpose IRQ was
generated for. Thus, as a preparatory fix to simplify adding support for
ROHM BD96802 PMIC the IC name "bd96801-" prefix was dropped from the IRQ
resource names. Adapt the regulator driver to this change.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
  - No changes

NOTE: This commit shall break the driver unless
5ba9557e5d41 ("mfd: bd96801: Drop IC name from the IRQ resources")
is also included. Compilation should not be broken though so squashing
should not be mandatory as long as both this regiulator commit and the
MFD commit will end up in same release.
---
 drivers/regulator/bd96801-regulator.c | 83 +++++++++++++--------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index 3a9d772491a8..48cdd583e92d 100644
--- a/drivers/regulator/bd96801-regulator.c
+++ b/drivers/regulator/bd96801-regulator.c
@@ -198,89 +198,89 @@ struct bd96801_irqinfo {
=20
 static const struct bd96801_irqinfo buck1_irqinfo[] =3D {
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck1-over-curr-h", 500,
-			"bd96801-buck1-overcurr-h"),
+			"buck1-overcurr-h"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck1-over-curr-l", 500,
-			"bd96801-buck1-overcurr-l"),
+			"buck1-overcurr-l"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck1-over-curr-n", 500,
-			"bd96801-buck1-overcurr-n"),
+			"buck1-overcurr-n"),
 	BD96801_IRQINFO(BD96801_PROT_OVP, "buck1-over-voltage", 500,
-			"bd96801-buck1-overvolt"),
+			"buck1-overvolt"),
 	BD96801_IRQINFO(BD96801_PROT_UVP, "buck1-under-voltage", 500,
-			"bd96801-buck1-undervolt"),
+			"buck1-undervolt"),
 	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck1-over-temp", 500,
-			"bd96801-buck1-thermal")
+			"buck1-thermal")
 };
=20
 static const struct bd96801_irqinfo buck2_irqinfo[] =3D {
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck2-over-curr-h", 500,
-			"bd96801-buck2-overcurr-h"),
+			"buck2-overcurr-h"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck2-over-curr-l", 500,
-			"bd96801-buck2-overcurr-l"),
+			"buck2-overcurr-l"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck2-over-curr-n", 500,
-			"bd96801-buck2-overcurr-n"),
+			"buck2-overcurr-n"),
 	BD96801_IRQINFO(BD96801_PROT_OVP, "buck2-over-voltage", 500,
-			"bd96801-buck2-overvolt"),
+			"buck2-overvolt"),
 	BD96801_IRQINFO(BD96801_PROT_UVP, "buck2-under-voltage", 500,
-			"bd96801-buck2-undervolt"),
+			"buck2-undervolt"),
 	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck2-over-temp", 500,
-			"bd96801-buck2-thermal")
+			"buck2-thermal")
 };
=20
 static const struct bd96801_irqinfo buck3_irqinfo[] =3D {
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck3-over-curr-h", 500,
-			"bd96801-buck3-overcurr-h"),
+			"buck3-overcurr-h"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck3-over-curr-l", 500,
-			"bd96801-buck3-overcurr-l"),
+			"buck3-overcurr-l"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck3-over-curr-n", 500,
-			"bd96801-buck3-overcurr-n"),
+			"buck3-overcurr-n"),
 	BD96801_IRQINFO(BD96801_PROT_OVP, "buck3-over-voltage", 500,
-			"bd96801-buck3-overvolt"),
+			"buck3-overvolt"),
 	BD96801_IRQINFO(BD96801_PROT_UVP, "buck3-under-voltage", 500,
-			"bd96801-buck3-undervolt"),
+			"buck3-undervolt"),
 	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck3-over-temp", 500,
-			"bd96801-buck3-thermal")
+			"buck3-thermal")
 };
=20
 static const struct bd96801_irqinfo buck4_irqinfo[] =3D {
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck4-over-curr-h", 500,
-			"bd96801-buck4-overcurr-h"),
+			"buck4-overcurr-h"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck4-over-curr-l", 500,
-			"bd96801-buck4-overcurr-l"),
+			"buck4-overcurr-l"),
 	BD96801_IRQINFO(BD96801_PROT_OCP, "buck4-over-curr-n", 500,
-			"bd96801-buck4-overcurr-n"),
+			"buck4-overcurr-n"),
 	BD96801_IRQINFO(BD96801_PROT_OVP, "buck4-over-voltage", 500,
-			"bd96801-buck4-overvolt"),
+			"buck4-overvolt"),
 	BD96801_IRQINFO(BD96801_PROT_UVP, "buck4-under-voltage", 500,
-			"bd96801-buck4-undervolt"),
+			"buck4-undervolt"),
 	BD96801_IRQINFO(BD96801_PROT_TEMP, "buck4-over-temp", 500,
-			"bd96801-buck4-thermal")
+			"buck4-thermal")
 };
=20
 static const struct bd96801_irqinfo ldo5_irqinfo[] =3D {
 	BD96801_IRQINFO(BD96801_PROT_OCP, "ldo5-overcurr", 500,
-			"bd96801-ldo5-overcurr"),
+			"ldo5-overcurr"),
 	BD96801_IRQINFO(BD96801_PROT_OVP, "ldo5-over-voltage", 500,
-			"bd96801-ldo5-overvolt"),
+			"ldo5-overvolt"),
 	BD96801_IRQINFO(BD96801_PROT_UVP, "ldo5-under-voltage", 500,
-			"bd96801-ldo5-undervolt"),
+			"ldo5-undervolt"),
 };
=20
 static const struct bd96801_irqinfo ldo6_irqinfo[] =3D {
 	BD96801_IRQINFO(BD96801_PROT_OCP, "ldo6-overcurr", 500,
-			"bd96801-ldo6-overcurr"),
+			"ldo6-overcurr"),
 	BD96801_IRQINFO(BD96801_PROT_OVP, "ldo6-over-voltage", 500,
-			"bd96801-ldo6-overvolt"),
+			"ldo6-overvolt"),
 	BD96801_IRQINFO(BD96801_PROT_UVP, "ldo6-under-voltage", 500,
-			"bd96801-ldo6-undervolt"),
+			"ldo6-undervolt"),
 };
=20
 static const struct bd96801_irqinfo ldo7_irqinfo[] =3D {
 	BD96801_IRQINFO(BD96801_PROT_OCP, "ldo7-overcurr", 500,
-			"bd96801-ldo7-overcurr"),
+			"ldo7-overcurr"),
 	BD96801_IRQINFO(BD96801_PROT_OVP, "ldo7-over-voltage", 500,
-			"bd96801-ldo7-overvolt"),
+			"ldo7-overvolt"),
 	BD96801_IRQINFO(BD96801_PROT_UVP, "ldo7-under-voltage", 500,
-			"bd96801-ldo7-undervolt"),
+			"ldo7-undervolt"),
 };
=20
 struct bd96801_irq_desc {
@@ -741,8 +741,7 @@ static int bd96801_rdev_errb_irqs(struct platform_devic=
e *pdev,
 	int i;
 	void *retp;
 	static const char * const single_out_errb_irqs[] =3D {
-		"bd96801-%s-pvin-err", "bd96801-%s-ovp-err",
-		"bd96801-%s-uvp-err", "bd96801-%s-shdn-err",
+		"%s-pvin-err", "%s-ovp-err", "%s-uvp-err", "%s-shdn-err",
 	};
=20
 	for (i =3D 0; i < ARRAY_SIZE(single_out_errb_irqs); i++) {
@@ -779,12 +778,10 @@ static int bd96801_global_errb_irqs(struct platform_d=
evice *pdev,
 	int i, num_irqs;
 	void *retp;
 	static const char * const global_errb_irqs[] =3D {
-		"bd96801-otp-err", "bd96801-dbist-err", "bd96801-eep-err",
-		"bd96801-abist-err", "bd96801-prstb-err", "bd96801-drmoserr1",
-		"bd96801-drmoserr2", "bd96801-slave-err", "bd96801-vref-err",
-		"bd96801-tsd", "bd96801-uvlo-err", "bd96801-ovlo-err",
-		"bd96801-osc-err", "bd96801-pon-err", "bd96801-poff-err",
-		"bd96801-cmd-shdn-err", "bd96801-int-shdn-err"
+		"otp-err", "dbist-err", "eep-err", "abist-err", "prstb-err",
+		"drmoserr1", "drmoserr2", "slave-err", "vref-err", "tsd",
+		"uvlo-err", "ovlo-err", "osc-err", "pon-err", "poff-err",
+		"cmd-shdn-err", "int-shdn-err"
 	};
=20
 	num_irqs =3D ARRAY_SIZE(global_errb_irqs);
@@ -956,12 +953,12 @@ static int bd96801_probe(struct platform_device *pdev)
 	if (temp_notif_ldos) {
 		int irq;
 		struct regulator_irq_desc tw_desc =3D {
-			.name =3D "bd96801-core-thermal",
+			.name =3D "core-thermal",
 			.irq_off_ms =3D 500,
 			.map_event =3D ldo_map_notif,
 		};
=20
-		irq =3D platform_get_irq_byname(pdev, "bd96801-core-thermal");
+		irq =3D platform_get_irq_byname(pdev, "core-thermal");
 		if (irq < 0)
 			return irq;
=20
--=20
2.49.0


--8UUBn7bx8lmda28C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHh8ACgkQeFA3/03a
ocXqRAf+Jl5VE5VM9D/7Rmv7rR/BPMWl5ef/4epYOMKMQqw/6eVpZGTrm+WhIYnx
aQX6Uud9gPUXVpKtVPZs5pSknbU8Kx1zAqgqNNxiazRuwu12IHNUMvvvgtl+otdG
r5BA55XJmKHq2wGyNYpjeZnSNiqz1wn8KVIWYDeHELCDXd9rCrXnZdk+3t/lp3QL
nhAnXK4GffEs5mSbcexqqmELjtLv52GIYdK35e+Q1CiFy7zWwqUOvHT4DLV38xnX
L+QqCO4xs3hUalGcRXc49WU+m74qKFTc8tbDnhFpTdyVxJUK4RMecDzxPDIl/jEw
di8qSIxTZ9nVqsieLy9jR+eSWvEQYQ==
=AM9i
-----END PGP SIGNATURE-----

--8UUBn7bx8lmda28C--

