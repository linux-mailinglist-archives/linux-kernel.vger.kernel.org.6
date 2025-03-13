Return-Path: <linux-kernel+bounces-559373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BC4A5F2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812393B7EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A5268FF1;
	Thu, 13 Mar 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKo3/S3I"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E7267385;
	Thu, 13 Mar 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866105; cv=none; b=VAGF3QldJMRUKd/IoVI8QFKhaj2qN+utDRWsCIbJUMOrk5FWkveEHMdBCm2me2ZFMrEIcK6qWAehsHGStDYKW2rG7U/AjVb2Ou3AxMvTDoaH/PSbk/F28WE6jqPTPke9uwxCssv9nvN/Hal48ALJpu4WGhpfx3oTtbms8CAYRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866105; c=relaxed/simple;
	bh=t2VwkGuSomJ8qenwL1C9A11juJRqs3O4eFcCna2Wkv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1+UefxxVoDjDrcqXRNiisWOXZIn/wnMYXB7JiH7yAOo+BzBWhRK6viEUb356eWw29wqvTvGpNsYCQB6IOicQPuimjrA1bnWhwcuOqsnAiHWNj7PxWpG/Zyiz1f7aw8MYFihcU0f9cV/gRSj83q4VojV+fd5l8V4MKz5JnMnxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKo3/S3I; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso9607571fa.0;
        Thu, 13 Mar 2025 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866101; x=1742470901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZmwH3CjF4AxxJqxTRCmwxCt3TSXdOVbA/04hf9p0WU=;
        b=WKo3/S3Irq+Mwpu1p1DyiKqr5GhxPLT526k38De00vh1aqepYXmk1kZq07ClUrx644
         gXJrLWfsUskY13ImbTmlSfw9uzGGnA5OlIvzWTc6mjIqEuBiTppxiYcJ3EzmvM7UsF9N
         kiibwbLZxeaF46+W7NRXL/2F3Lq0kWEZWjifaO+ZCoH4O2ChI93QVGTPpngUAb3G5yHu
         Pc20bc+xad8oBqMDBcLJUnAtpb3uz5N6Dj3DWhJopUwt2Adg3l+j4nefIR2Y3tJjRPEU
         1ltkGF5nJ6uzmZVthtKTzzJ4V02KutemlxU/BqUQSwJWVjXXAQZ+3JiBIMkccV5cBLT6
         Kg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866101; x=1742470901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZmwH3CjF4AxxJqxTRCmwxCt3TSXdOVbA/04hf9p0WU=;
        b=V1CoLgpsyzJciyR9sePVtIgCUhtpyB62gPt652hnfMVVwqNOkQjr3E45qOAgu5+EQF
         uElj7QTVgAUCzuT1Ke7ou3s3VVDO8G4vMEIsSPXW74iyrXkn3X6115SOw5R5vnH0Hv05
         /KrrUMOnaqTkzdPP3pcHz2SLFfg4eAsdcqMkbqRsAUF+ByWeP0YkFgLgzFeX2hRztFoW
         HxMca7sDiCbJeEoNjJGq8pvkKbp8DAlawjV6t/4FpLWjGGdGKQDHVpRhDu8V1V9gSDwh
         zcH2F5vkon2FFbty78CT4ur0x23v/9h/p30nBxGf7betEfKB2v8JAbnaWFQR1ep3QGsq
         keSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKJoMzFm5zhoEKDeK+gQ/AopsKBE1pVYeoKSlVLnpGcttzG0BSHn1WERIZj+Cjaj2XRyc3C+YPn1qJNCep@vger.kernel.org, AJvYcCW+T82T7tKoWoyH4ducwPYMDGOwtU7wSX51FQKUW+S7ff6Q0s4mv4Q8kub/+ocVFrh9cUuyDiooY80L@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoEWatCkKk+kQ2Snktc5TKtRTZPhDyWk22NC4dFRf4uJcZiYG
	HWOVNv4+cbGTNbV3yKD5xuxKpN6uY5fyP30Yr6B4bTRir69vtLJV
X-Gm-Gg: ASbGncsy/xt0hKR/Ybn96JqiKyCVG2U9Rju+AF0Qf/kxmxlIcQYAOcrqvcAr1Mmj//P
	Ak8dB5ye0IuV61rmMmUK297odCCbclfPFl2GPGS6QY1u+aoSqZS3jfutW28HgFNAFqkLEiRaA7f
	TUo2UGLwcP6BdUM7Gr5MWqXMiK0Ks+80pVladc3yHPc3YHRTibui+Err2zMfAEMj5E/8H6nZhWn
	UH1qbkjS7emPl+GM4IJ0yR4jnTGtT52PN1nEmGlK+uM3q6wsrJ2C2KzZhy8hW4WE4PvaSoyWLRP
	m9eW/rQxQJWL6b8vhGOpAriaBgq4tyO4FwrGGLRjVht+O7yQewo=
X-Google-Smtp-Source: AGHT+IGbMTcjaF71gs8UEmllm/cZdGSu9SSF39iyWed21Q+1hKmMPd9h3Z1V8ZGE/nAjslPn95Q19A==
X-Received: by 2002:a05:6512:3048:b0:549:8d16:7267 with SMTP id 2adb3069b0e04-54990e2bbc2mr8547605e87.10.1741866100410;
        Thu, 13 Mar 2025 04:41:40 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864e01sm187376e87.112.2025.03.13.04.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:39 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:41:35 +0200
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
Subject: [PATCH 04/14] dt-bindings: mfd: bd96802: Add ROHM BD96806
Message-ID: <40a47b9ab61e9092bc16747b8e92ba0ce44fb1ac.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lOj8NaVvEWD5XEyi"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--lOj8NaVvEWD5XEyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96806 is very similar to the BD96802. The differences visible
to the drivers is different tune voltage ranges.

Add compatible for the ROHM BD96805 PMIC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/mfd/rohm,bd96802-pmic.yaml       | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
index d5d9e69dc0c2..c6e6be4015b2 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
@@ -4,23 +4,23 @@
 $id: http://devicetree.org/schemas/mfd/rohm,bd96802-pmic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM BD96802 Scalable Power Management Integrated Circuit
+title: ROHM BD96802 / BD96806Scalable Power Management Integrated Circuit
=20
 maintainers:
   - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
=20
 description: |
-  BD96802Qxx-C is an automotive grade configurable Power Management
-  Integrated Circuit supporting Functional Safety features for application
+  BD96802Qxx-C and BD96806 are automotive grade configurable Power Managem=
ent
+  Integrated Circuits supporting Functional Safety features for application
   processors, SoCs and FPGAs
=20
 properties:
   compatible:
-    const: rohm,bd96802
+    enum:
+      - rohm,bd96802
+      - rohm,bd96806
=20
   reg:
-    description:
-      I2C slave address.
     maxItems: 1
=20
   interrupts:
@@ -29,7 +29,8 @@ properties:
       for fatal IRQs which will cause the PMIC to shut down power outputs.
       In many systems this will shut down the SoC contolling the PMIC and
       connecting/handling the errb can be omitted. However, there are cases
-      where the SoC is not powered by the PMIC. In that case it may be
+      where the SoC is not powered by the PMIC or has a short time backup
+      energy to handle shutdown of critical hardware. In that case it may =
be
       useful to connect the errb and handle errb events.
     minItems: 1
     maxItems: 2
@@ -69,7 +70,7 @@ examples:
             interrupt-names =3D "intb", "errb";
=20
             regulators {
-                buck1: BUCK1 {
+                buck1 {
                     regulator-name =3D "buck1";
                     regulator-ramp-delay =3D <1250>;
                     /* 0.5V min INITIAL - 150 mV tune */
@@ -84,7 +85,7 @@ examples:
                     regulator-temp-protection-kelvin =3D <1>;
                     regulator-temp-warn-kelvin =3D <0>;
                 };
-                buck2: BUCK2 {
+                buck2 {
                     regulator-name =3D "buck2";
                     regulator-min-microvolt =3D <350000>;
                     regulator-max-microvolt =3D <3450000>;
--=20
2.48.1


--lOj8NaVvEWD5XEyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxG8ACgkQeFA3/03a
ocUx8gf+Mb2iVzao1T9FPrIGbDSq9EH6AC0es8g3J5888Li0mQMfjmwz/1pqd20M
Ev32ChMeUwcjphlHVziqVHyBH5eJR8eLMSr70lhUdGg2F1i4k/uxhk5tikh7HcLo
3aw/K7L/j3GK+6/M9rViFn6/zqH+W8zNsHT7D5u2t3IoLzeFNlv6jkeFKgw3UTc4
TgotxFgPK2DcL/lVGCLgPo0SDzjpUpmqd5csRgKi7kLV2VM+E9WHdxbDZyPmCcF+
v2M2gG6fSh/0p32t/bpY4ihGyplHdEvff5eMZMDlClKA6GB5vHM8zoWyJYA2DMFv
nO9yjukaN92LtWdc/PLLRZw0gPcNyw==
=aTet
-----END PGP SIGNATURE-----

--lOj8NaVvEWD5XEyi--

