Return-Path: <linux-kernel+bounces-559377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE293A5F2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238663BED04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1F2676E5;
	Thu, 13 Mar 2025 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuVu/piS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467D266581;
	Thu, 13 Mar 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866141; cv=none; b=QYjueEF0zV5DJNyE4ZFyroEVpWQ3NROc6Jijc38AtZJceUlg1CiQbDsv3fTWz/rixKswJ0Tlctxh0W77AXxDM20MQrDBetIXqhfYlsbPRPZg3pLFLbFM2deeUoOXJjuUtis8k6ThG9Z50fx7HAenfCV6TjOlc/Q2w78KbZdtrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866141; c=relaxed/simple;
	bh=/JxIC7aR3bRJRFuoQy9esFDnFXej9ASlYUcCdNd/OHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg3xrSvBKyqqd/Fv7Iz71WvSpfNtbI1SnRPuFhZWCgobQTzrSij9hXn8tsKSRbwogWRi2MQdAudxETU+K4X1gBn+FJP+euup3kvIq0TL2RWGfSfvM31xAIvM1RxXpSiOd9Il61YY4FoPLG3+rKRSQ881lDnsi1JqR5l+Gp1CED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuVu/piS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1082896e87.1;
        Thu, 13 Mar 2025 04:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866138; x=1742470938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6+SMXVzJpWLpywifkIhVksmx0T6n4RMXXLjjzLrghY=;
        b=HuVu/piSaSK89Ie7Cr3ef9HQQEg4hajc99yNsp+t9TrnkSXzLC2h3AvA3D3Jm4rglx
         CN+dhpUt9KS+w3IXHI7O8SMRm86dFK/ot6VSJgnHffQyjxtF9+tjEuJree61qcfqCeTe
         JWRP+OSHeMEpaUM0CB2+yI/ilAUuNSI+I/ffUl6XhGBjsXbj1jY4JVhg7Rp6po+vimDu
         R3wlw35cjiKoV5pXqiL8BVhQpXuC2v+uNUfWkXSdfRxf708sndLoN4UQBgt53S9p+yZg
         r8aXHkbB6XRX9uoB+HtS/gFps2XrGzY/s+v52f0+tX1CVU1l3l48AqXqmM4rLIfs+OoH
         lNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866138; x=1742470938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6+SMXVzJpWLpywifkIhVksmx0T6n4RMXXLjjzLrghY=;
        b=C7J/tP0OAf0D0PsSlZAFTO4gDkjoYTB3CfO+1A6Mt3pwcIi7IIYW2pRyCaxg+rluJq
         bcydTiC4C38csbLzSPC7h8aQYM7ccb349C5p6wa4Xii/3RRSXvAzPSYSx/PI6SrqsRX5
         w4IMBLSFUeEr3H734ZBOYR35Cvb8L39At6oS/xC/sfQ1QyGQBxVNs65xA2/2nZTi8iIm
         vMfGIxDIpJ9aDC0LZK1stXs5r6xAUhjB3R0ZzihKaIsa0zs9fzX02g1b3JXjvIt9IrwK
         27tniVDJD1yKJysPynA1ki0fNQK2++xKtDhOeWQJAwfhOy4Dm8R16sh7crWjCk1Lxp16
         +Z9A==
X-Forwarded-Encrypted: i=1; AJvYcCVUkl4KeUcnIjY5Fh7ClsgjwaA69Iltuf0I5QmISeBvNF8nGNdmxzIppKN4LZsKsCIkd7tQL4JhIhSB2WOc@vger.kernel.org, AJvYcCVe7ARnyYS6HkC2tsTFo7DyftKs/CVYWeloSBxvg6V0PtCxOEDXpalYYzYYkFFEvoL59okfwc8pYGO5@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPFRFWpbLc/t9jmzZQK/PDFgAflGMppdcoZmMlRBO3MFxELvv
	+CtZGX7CBezlXGh1fqrqad0p6q9Yt/ifIzJSB11uWINOeuSPf5mv
X-Gm-Gg: ASbGncsuGefq73XIMDCs2HZc/5H65YeEXtpF3TvX1oae8MsCJry0IT5aGi27thCBtB/
	ClyUgXpjBsaOix6YAIaE0FxDGaxv8efGeqUmd7zBnh9apG3032+us8w5VI7K6Ig70PlZbvJeOtE
	wXRJTTlBdYxFVA6VJvGBsw0wMQaxiwrKXYMvJqH2i5LeaJPC3kQfXNbjhr7oihhpNCjmGUI0poB
	KmvBNTeBhRkfGMJGgJ0wmdLESLHHkCbiQ18YgPTi/S/C6Cr5KQ4R88T5Zw5K1E6SnBXbFhW7l0G
	/VpgKRZ3/TXM2IC9aQ6xhkvISwIpQ9010gYoc3jwZ7GcxMN3R8I=
X-Google-Smtp-Source: AGHT+IGYZhCGB+diKE9nsSxB0ent3Tf902DnS2EifBzklWnUWYuz7pBKsJIhwgJTUNP41Yi+4xl3og==
X-Received: by 2002:a05:6512:1596:b0:549:965f:5960 with SMTP id 2adb3069b0e04-549ba440077mr911202e87.16.1741866137646;
        Thu, 13 Mar 2025 04:42:17 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864d24sm187807e87.108.2025.03.13.04.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:42:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:42:12 +0200
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
Subject: [PATCH 07/14] regulator: bd96801: Drop IC name from the IRQ resources
Message-ID: <9af81632fb6100af25af729f19237965add05d68.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XzL+GtzC5s9Eqhlj"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--XzL+GtzC5s9Eqhlj
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
2.48.1


--XzL+GtzC5s9Eqhlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxJQACgkQeFA3/03a
ocVjrAf9FxCXcnvmMIKJUDbm+aemFQVA/FIjPDIAOSmyqrGl0/Fjuw50MZEaD2ps
Ew4qnzq4DcBetQbYHiohFAIUPLPWgqv8RBxclyYu0xT4P0CVN0NNCLfLWrt028sK
MMCsQsB5nKPkrsnUDW6RvWxlW/0gJG61e5eSeA6z8lK460t+Adv0uTC9q3LmwJ94
thnk9X7aRFmdCCuuDcOkAZr4z/qKXWUzrhKlsAb7obZ13EB7eFWXPh5OZ30VaARb
hTRqoD9nojyjE34OHkwAHJuBp0Zs9yOwOvshqPlkTwJcRnp5644sHRqz1whD99hN
331H6YqpoQCWOvR1JXbMurNF6cMjKw==
=5AyJ
-----END PGP SIGNATURE-----

--XzL+GtzC5s9Eqhlj--

