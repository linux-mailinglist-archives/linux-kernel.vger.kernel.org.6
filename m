Return-Path: <linux-kernel+bounces-188446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13888CE22A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879F92822AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C51292D8;
	Fri, 24 May 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V15ivU6y"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8C749C;
	Fri, 24 May 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538604; cv=none; b=ATo3mHBfRQ4ZaR4fYoc8nu/l3mM6gyOzzTNFHBGCNQa8sELofbSObTVrE1v0pfLXTV8zUCMUIpnOuLLfLZ2d345OHVCfR8DA3cge84gdMQmYXF9ZZO8TsB0vAT9HjIiTIz58kc+3EGYU9Olgz4YAqQ7yOe7fFeHX8RsL5hMzwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538604; c=relaxed/simple;
	bh=sfRBTOda2jiMuUq/9n33f50kI2wqzVaG46fxXz+Mx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aviCMqscMmzwhiwqhDqnTBqYrAtRz3tnE2/JzLZlRCLBkiiUm9XBDcAMQlzmi6P1iA93FsKsLMK+2fnhN59aTJsxp97/IA3ZFY9WzEpZwNq0CTbgJo9hfJW5aFgVm+D2s6fDC1iHRg+EZxx4ev6L0RXD6eh5QbooB2TvVvxUPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V15ivU6y; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5296232e00bso590356e87.3;
        Fri, 24 May 2024 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716538599; x=1717143399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp56wHJqNYnbJaMid2Ww2YYQQliXGWFofx7nxsOO7AU=;
        b=V15ivU6yybfJxSiaSQI5uatbD922soh/dtZusf2fTRgZT9TYtPsz4vKI246C5Phi5P
         oH4dmXkx8DA16EZRh6+VLURCqB0patEiV9WInibi7m1yh3kSNBK5OTJFSqcn1uL3cI/e
         tR7MUZok3sUl5j0FDrK+avc3ca/rBFIqVMsllwydRKQlrKceqbV7kdM7Z0cR/sAio9m0
         4eLizGcgHjquIgSkJbSZkthPBo6/9VWASAYAnp6YAxyxKweCyVA4UB9/Av0xp7PsyrDp
         I3GRPJvNXlN1iTl4Mw/YX0/7Vrd/38E75JFmtfvZE0V2kdmfMbl/Or3iXhuAOnepTUel
         r5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538599; x=1717143399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp56wHJqNYnbJaMid2Ww2YYQQliXGWFofx7nxsOO7AU=;
        b=bvYhxY7QBfI7zXmCQsLMBe1iwJ7gMPu1s2QpmTZ+ZY1XhDUanpP4lEprNsDfCW8/M6
         F/5M4TCzp4lcfB2qCT0EP09+AUE3l65ckHBVAMxHS9fzeuKPFweeL9K/tlQgMC/X1MIw
         lqf2A60gEbGjV5ySZyYh/diTjZaiaXUH1Yfpg+g77W0DovoRFGUoxvjI55suLfTHkNAc
         +mv80CH0UBDU9z/38Tcb/hLYmf6W4aCrQIyzEx6VGbZVbd/IKP3aXUy56/5vDV1ZnF0f
         CQTwPmbtH9Xb84s8pm19COrkwWCP3OTf3nN7fqzWBrKt6hCu8p7XwB+XDDaUjRg2FKWA
         eePw==
X-Forwarded-Encrypted: i=1; AJvYcCUvLcdZC7pBsRc7vTP3EF7vkXRUZsVJdo0kojbtGKEktLG/lzzIa0JtIw/guvDYCtcjD8md2NxjIX1VGC/GRXUcmWsmkOP7bOxIK3e+Zm2+1esSP+nn1oOQb3vHD4kXToIJpWTqmduCsg==
X-Gm-Message-State: AOJu0YwEatTouZMZq7TiwWp1krvDfbcCH696c8Tc/6wFCaW4CxSTRpo6
	qK0u1M75OyC4hHJZWD9kpVURX7bUbywGiMYYowmg+7JFgp2xh1ZT
X-Google-Smtp-Source: AGHT+IEM86Gqq08WRWkDL5NNk9fBp8nxJuXN3qlSxAqTtOCQuHZYJ9DOu68hAlG84WZXeiYHu8ZHCQ==
X-Received: by 2002:a05:6512:54d:b0:51e:1264:8435 with SMTP id 2adb3069b0e04-529646df3cdmr766385e87.27.1716538599186;
        Fri, 24 May 2024 01:16:39 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970854d2csm124074e87.141.2024.05.24.01.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:16:38 -0700 (PDT)
Date: Fri, 24 May 2024 11:16:33 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 01/10] dt-bindings: ROHM BD96801 PMIC regulators
Message-ID: <6a7d3b9dc594f253bf190508df98395556449068.1716533790.git.mazziesaccount@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DytgOnmV9Dv5uq4T"
Content-Disposition: inline
In-Reply-To: <cover.1716533790.git.mazziesaccount@gmail.com>


--DytgOnmV9Dv5uq4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 regulators.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
v1 =3D> v2:
    - use lowercase node names in example
    - drop unnecessary '|' from description

RFCv2 =3D> v1
    - Drop regulator-name pattern requirement
    - do not require regulator-name
---
 .../regulator/rohm,bd96801-regulator.yaml     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9680=
1-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96801-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regula=
tor.yaml
new file mode 100644
index 000000000000..b3d2d7d583ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.ya=
ml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd96801-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD96801 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description:
+  This module is part of the ROHM BD96801 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  Regulator nodes should be named to buck_<number> and ldo_<number>.
+  The valid names for BD96801 regulator nodes are
+  buck1, buck2, buck3, buck4, ldo5, ldo6, ldo7
+
+patternProperties:
+  "^ldo[5-7]$":
+    type: object
+    description:
+      Properties for single LDO regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      rohm,initial-voltage-microvolt:
+        description:
+          Initial voltage for regulator. Voltage can be tuned +/-150 mV fr=
om
+          this value. NOTE, This can be modified via I2C only when PMIC is=
 in
+          STBY state.
+        minimum: 300000
+        maximum: 3300000
+
+    unevaluatedProperties: false
+
+  "^buck[1-4]$":
+    type: object
+    description:
+      Properties for single BUCK regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      rohm,initial-voltage-microvolt:
+        description:
+          Initial voltage for regulator. Voltage can be tuned +/-150 mV fr=
om
+          this value. NOTE, This can be modified via I2C only when PMIC is=
 in
+          STBY state.
+        minimum: 500000
+        maximum: 3300000
+
+      rohm,keep-on-stby:
+        description:
+          Keep the regulator powered when PMIC transitions to STBY state.
+        type: boolean
+
+    unevaluatedProperties: false
+
+additionalProperties: false
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

--DytgOnmV9Dv5uq4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZQTOEACgkQeFA3/03a
ocWLiwf/YSUNzD5wB0hD+3K/b946kwKDtx8b0sSaA9xCi2o4VZlEh/CHhWudKyl5
7/58eVF+S7coCqMpY+3/mYJyRTsKNUYDMptldGudB/4n4Z29ELuh8KN+WqIxIwkI
3IeTzId34uNTTYuj6hPjnKUuc/5ZV93J4HWH+T/gEZ+ytzVUZ5xwsO5HmHzFKsnJ
afJknsb4KB7fGhrM4xuh8oxrqtF3EeynIAmG4/fpDEom0VbzxF7yP5ZXOVrYixY0
UXPL3sssygqDbtWwcl8HBHngh5VPfTckX3z6wFEIaaY3XpjMoCwFiEX09PcpTsNm
4AvbQWnuEqnSW6ke/KE+SPVtzxCpXg==
=1MzQ
-----END PGP SIGNATURE-----

--DytgOnmV9Dv5uq4T--

