Return-Path: <linux-kernel+bounces-559367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E47A5F2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD0E188F22D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A93267F4D;
	Thu, 13 Mar 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POG4t+cB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3C267B93;
	Thu, 13 Mar 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866080; cv=none; b=oG+w3bja3tcDz2MmrTadNxiSaDoJVti8+ViLktk8+BObvL/yxC58cMDwxwI/gpI17CQ4A/9fwSFFZv2exeaC4+jZsuVf1Fsf89zvKcppHiojuGypPFfofJPjzNqkwAkUPGSO8aktp9DM4UdruklQOc+bwKU+cqBfQ+5/mIsTFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866080; c=relaxed/simple;
	bh=N97BpYlbNSPfzJGQZ1D7SkQx/OmwuZruOYtg7xU7yyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dER5P7vXRt6+qomYxe8MQW7eH9tE5cM35KgvK4hDaQMsKV8m6WNs6PSgJaYKEenvWEDO2ucx0ksSy5N+4gaqC/6I56Wx8AEBQ1BgOCyDkQKlTqYs619N85aPe39ndFjMiG0iSEe9/U8XxbKq+IbUOgLWLjkQTngRvwa0Zap/SL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POG4t+cB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54996d30bfbso717718e87.2;
        Thu, 13 Mar 2025 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866076; x=1742470876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+NTzzn1Fnv8JX9NGjwEvgHmyeUTwJ8v4hknnj/x0Lo=;
        b=POG4t+cBWbpjFb7UK4AAT60fdcOcMzXnViszpv6xYlm0FNJFlKdx9HKW2RchA4zH++
         NbdsGSqNn5K0DkMxZE9oZLd19qIHUmfnw+1z4HBPdWKxtcv3fRnZXe+Bbgla2pEad0t6
         LXf9yt9hddmay4Jcyhnlv+tZGJycx9XbZSIHF0/lPH/x4PMGaaXOyuWueeRBil7bIXKd
         OfweNV8+/17xqanQBk5cuZAhF7Gn2YpBbvTYFUvkVy+yhuXXtqSuiGsP8ZxgeGPJUsYs
         4PXJ7N5EY9OLd1qM/0oHgVAccFByjL10PdIKK5Jz830TaRTAhLJKeQ6X5srVQXP/DFPI
         xTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866076; x=1742470876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+NTzzn1Fnv8JX9NGjwEvgHmyeUTwJ8v4hknnj/x0Lo=;
        b=QKgGcjFZFXHTbEm7oE1jzRMY9HlgY0x8qND0z4dS6H98dIDLfWI0eYnj61CrFsB/3a
         GEu9l6x/guStnGgK8lYh1qLUCI/ST6K5QqNkG+yRdyPWHwgT8vb8PXx4fQ6lj97zLCTG
         I+J0ttU9Y2vMBOkhPNKtwTf1plJ4kY1k0r1fjV0KBqMUf26EwCoXEdQb/+sAt4p0/qb1
         VKDImAF66M+TbPELk+kCblfwEjqVBUapNL2pmHjtaxvPbzEG11J4EI1iQplyoseVAjZY
         /rziNHpuunJICWNuTcjPL6pTQra7bGAdX9keIQZcG3sRKqKS0GwkcAzSIUQCCbcoSybl
         i5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVjItLeS4I6pfRGoHX0wlN4EAhspCG5tVgzQ7p3h23+zO9iXaxGh9Ys4eNZzlkljQC/14Y7BMObJ7Qu3gln@vger.kernel.org, AJvYcCWM9dFqbgO8CcVD2r3NXlG/9JDS5DouT/TgsvpAWWUOkXUSMQpne0v3Z1uwGNU1f3AeiThXKskJdOkr@vger.kernel.org
X-Gm-Message-State: AOJu0YxEU3gxINn1mQMTuyRLZD7DLclPDAKuLT8yBf+2XTxQNno3li+E
	1IctbTS9mXieFn07YdgO1EQOMj7KasjZUuB++8neBdWu5SlkdANT
X-Gm-Gg: ASbGncvKvGFWcGWA3Jv0mnTwxvl4lvU4ZE/EWYc3bVrJ9fOX2KikErGtXjoZ0uS8V+O
	FGuGWAXzsy08ChaTkl4jV6TZe9rnAvbWx4RlCW68Q3GV4XPv9+WraguPBlgC0wJ2cKANsdEs3A3
	W4OFC5CDpKk90dbxg9jPLjadXVquuyVRTyzWvoomzkfRdowCsqsl+tDoxNXMDKTtOAS35AnkUVP
	PSyHYydAqvG1LtJp2n8jaQlZWeKJt28YiPC6KyTmZnVB4Ubk2OUl94O6xXzjff+el9ZqFEPYVSn
	zBKm+MZnrnv0NEFVTun0YE3mA7oZA9Xx/xvvGp5/xw9xtGmG2yA=
X-Google-Smtp-Source: AGHT+IFuZEL6MZEjWuwNLfzDYfGHyS/llMVd1NMMeT9bsPSWu/Jy2JNXc5sF0MhHkWdyYmsc8EnSpg==
X-Received: by 2002:ac2:44c6:0:b0:549:91d3:cb16 with SMTP id 2adb3069b0e04-54991d3cb26mr7381426e87.4.1741866075720;
        Thu, 13 Mar 2025 04:41:15 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c1a26sm185901e87.97.2025.03.13.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:14 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:41:10 +0200
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
Subject: [PATCH 02/14] dt-bindings: mfd: Add ROHM BD96802 PMIC
Message-ID: <b8cd10416e2c3751fda58bf2b3dad86c78ebd43f.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ft2n4GX3RX91ewdq"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--Ft2n4GX3RX91ewdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

BD96802Qxx-C is an automotive grade configurable Power Management
Integrated Circuit supporting Functional Safety features for application
processors, SoCs and FPGAs. BD96802 is controlled via I2C, provides two
interrupt lines and has two controllable buck regulators.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/mfd/rohm,bd96802-pmic.yaml       | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
new file mode 100644
index 000000000000..d5d9e69dc0c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd96802-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD96802 Scalable Power Management Integrated Circuit
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description: |
+  BD96802Qxx-C is an automotive grade configurable Power Management
+  Integrated Circuit supporting Functional Safety features for application
+  processors, SoCs and FPGAs
+
+properties:
+  compatible:
+    const: rohm,bd96802
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  interrupts:
+    description:
+      The PMIC provides intb and errb IRQ lines. The errb IRQ line is used
+      for fatal IRQs which will cause the PMIC to shut down power outputs.
+      In many systems this will shut down the SoC contolling the PMIC and
+      connecting/handling the errb can be omitted. However, there are cases
+      where the SoC is not powered by the PMIC. In that case it may be
+      useful to connect the errb and handle errb events.
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - enum: [intb, errb]
+      - const: errb
+
+  regulators:
+    $ref: ../regulator/rohm,bd96802-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        pmic: pmic@62 {
+            reg =3D <0x62>;
+            compatible =3D "rohm,bd96802";
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>, <6 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names =3D "intb", "errb";
+
+            regulators {
+                buck1: BUCK1 {
+                    regulator-name =3D "buck1";
+                    regulator-ramp-delay =3D <1250>;
+                    /* 0.5V min INITIAL - 150 mV tune */
+                    regulator-min-microvolt =3D <350000>;
+                    /* 3.3V + 150mV tune */
+                    regulator-max-microvolt =3D <3450000>;
+
+                    /* These can be set only when PMIC is in STBY */
+                    rohm,initial-voltage-microvolt =3D <500000>;
+                    regulator-ov-error-microvolt =3D <230000>;
+                    regulator-uv-error-microvolt =3D <230000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+                buck2: BUCK2 {
+                    regulator-name =3D "buck2";
+                    regulator-min-microvolt =3D <350000>;
+                    regulator-max-microvolt =3D <3450000>;
+
+                    rohm,initial-voltage-microvolt =3D <3000000>;
+                    regulator-ov-error-microvolt =3D <18000>;
+                    regulator-uv-error-microvolt =3D <18000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <1>;
+                };
+            };
+        };
+    };
--=20
2.48.1


--Ft2n4GX3RX91ewdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxFYACgkQeFA3/03a
ocVhHQgAnLpjnJKwh/semeo1xD2I3Jt6+sp29OCZ2Nxg1ofkSNTjP7Yqq4snTECY
oLT6jHbnLiWOSxjaM2n+he4nbU9VAAilT3nCdTGkVvSCmli/kKWcSokEpGymufJt
qJYWp94FPUSX6B8qa6GYlVRCnembYG+ThG/R0ey3MYkSw6J2vJpGiA2oZLkSijUP
wt/GXryKHiCQYiepcfNNlVlzATGidrazSgk5EKh8pjEXz0CilvGgJ0uYWRSAO9sf
fk1xTl7edkK2g15lhX2iBlMm5X5ONKQhbP99HeQAwE1qf0OTZv51dGRf51kymK6w
JhXViahJowVC0R5SkF/axepApHHIXg==
=oGI1
-----END PGP SIGNATURE-----

--Ft2n4GX3RX91ewdq--

