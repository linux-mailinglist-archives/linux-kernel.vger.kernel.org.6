Return-Path: <linux-kernel+bounces-188447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652EF8CE22D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9561C21714
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E812883C;
	Fri, 24 May 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rypv7Ggy"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5D5B1F8;
	Fri, 24 May 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538635; cv=none; b=HwNydIZ7JbauDC0e5FiArEUgc8DILJ8U8KeRXbOZ0RYroRWIlcaSmxNRb5a3v5Efam2Rtlo/6wQfH+LTz4vKR44JNvGX3b99SprESmwmop3eQ+t8MpPDaHfpcDtbTbKCTZX3+gEWP8DLH+xa6a0E/yjXot2LvUVE7BNuQ+mpoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538635; c=relaxed/simple;
	bh=FiVnBrORsgbrMgm/9Fxel6Aacpzj5+DJofKLEW/BxqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGh3O0j57en15vKj0TqSeU+gWhvTZ/0OQkLaqnJAcxMZfLtFWFLjrBhedgEZfAxuOSau4nlz/qyyxsw73who/v+1RSaVn3SO5t0v/1f+FCtFCfP6zOlzZ7w1693svTiJs6e7ycnmqnp6n4C0JZF6z1mPZjtPRdWNLu1ebwqqFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rypv7Ggy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5238b7d0494so9180767e87.3;
        Fri, 24 May 2024 01:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716538632; x=1717143432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYU7th+sP9Y5EgJGx8NE5uHiwuls5zINMP/N9oIeob0=;
        b=Rypv7GgyBzbn4i0/kz5VVx2U6dgkO8OFvFHt78gREGKvMADY0wytD+6/Ioftaj+OtM
         DPFUjHn0v3HsDVoTHOhcfC5qmd5ixqLu4mLTzJy5GBg8Gm+rzpAuPHZ6mBeWVGAMLhDd
         G2OnI/IHT2LOdxc2hydfSJdl8rZXyJlvMQf0w5s3E/1ejAJqQJVTvVrwEBzr0v6GEwWk
         XPWVMORDLKozm8Ik7Xjcbgnk1ox1Rq5RbBsavOZLpUO2SA9oNLkhdduyqIT8/gHewzJr
         7ieygnk6rvTorHD17OOEHXTbkeNPBkXhtWV5BO4ENcvvJccyo/eqzNzS12y1zaJLafMS
         0hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538632; x=1717143432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYU7th+sP9Y5EgJGx8NE5uHiwuls5zINMP/N9oIeob0=;
        b=ntwUpFgkqygqvUL7Y50IvEVqOo9HjBwxYsyjJqYQ46ZROg76jpYE9BVnnmEQaUpd9m
         cvXca0ewolVrEzPevRtzdt//U7Ije+AIdDjBOi2DGNeLYMtZIJ9g3tuySQFWkdNr8jzk
         8ZGhuuzL/PJrmkZCllXjFSnoNcXwcw78Id8G638YNthf4SEGYoSRnzAmEtwlhaxULpwj
         xXsZdaKsZxd/EjNf0EgPK8soVi1GEratAd1pArVBoRt/9VPwc+1725nJ4P2itfyHEut1
         ytgZZHbIV++B7iTH9qVqI5eq+RuKfx60EXbnayKFhyWX5MJFFJwAH58LRKT+9EBDYKkT
         ChWg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0/Wh+BFXsK3y0pp2S1dBN4kfO8dgnKnZQKv8gyughevqAlTX1rG5UM8+eple5UDqsGw29xmx+NK+ltS/IZbbHxEqeSNPujXbUFOBKco8+4QZBJxh/dHUY40Ui7KTKAq21R4yAKNfdA==
X-Gm-Message-State: AOJu0YwvTnCCNPPOol7JYd5vIBFBw1+UdUHKXguQPDENbzW+VTAyq89W
	qQvtGn5UWq5Uv1mAiv74gP3zAkTrOyrp5YJCZ5szvgm6RudRLEAy
X-Google-Smtp-Source: AGHT+IEZsppLEDEDKwsDDRzSaHgrmqpWDzfj0mpPNqQquVSEmp7ZKoDGEKcFqUKxN2cNH4in0b7UbQ==
X-Received: by 2002:a19:5f0d:0:b0:51d:5ffd:efe4 with SMTP id 2adb3069b0e04-52964ea9811mr1423557e87.1.1716538631686;
        Fri, 24 May 2024 01:17:11 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e887705sm124283e87.28.2024.05.24.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:17:10 -0700 (PDT)
Date: Fri, 24 May 2024 11:17:05 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] dt-bindings: mfd: bd96801 PMIC core
Message-ID: <bd468e695d8331762d5be77196368b82366be7af.1716533790.git.mazziesaccount@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kKCrEB1nWc/4YMm0"
Content-Disposition: inline
In-Reply-To: <cover.1716533790.git.mazziesaccount@gmail.com>


--kKCrEB1nWc/4YMm0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
DT bindings for the BD96801 core.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - use lowercase node names in example
 - minor addition to ERRB use-cases

RFCv2 =3D> v1
 - minor cleaning
 - add timeout-sec

RFCv1 =3D> RFCv2:
  - Document rohm,hw-timeout-ms
  - Document rohm,wdg-action
---
 .../bindings/mfd/rohm,bd96801-pmic.yaml       | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
new file mode 100644
index 000000000000..d381125a0a15
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd96801-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD96801 Scalable Power Management Integrated Circuit
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description:
+  BD96801 is an automotive grade single-chip power management IC.
+  It integrates 4 buck converters and 3 LDOs with safety features like
+  over-/under voltage and over current detection and a watchdog.
+
+properties:
+  compatible:
+    const: rohm,bd96801
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The PMIC provides intb and errb IRQ lines. The errb IRQ line is used
+      for fatal IRQs which will cause the PMIC to shut down power outputs.
+      In many systems this will shut down the SoC contolling the PMIC and
+      connecting/handling the errb can be omitted. However, there are cases
+      where the SoC is not powered by the PMIC or has a short time backup
+      energy to handle shutdown of critical hardware. In that case it may =
be
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
+  rohm,hw-timeout-ms:
+    description:
+      Watchdog timeout value(s). First walue is timeout limit. Second valu=
e is
+      optional value for 'too early' watchdog ping if window timeout mode =
is
+      to be used.
+    minItems: 1
+    maxItems: 2
+
+  rohm,wdg-action:
+    description:
+      Whether the watchdog failure must turn off the regulator power outpu=
ts or
+      just toggle the INTB line.
+    enum:
+      - prstb
+      - intb-only
+
+  timeout-sec:
+    maxItems: 2
+
+  regulators:
+    $ref: /schemas/regulator/rohm,bd96801-regulator.yaml
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
+        pmic: pmic@60 {
+            reg =3D <0x60>;
+            compatible =3D "rohm,bd96801";
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>, <6 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-names =3D "intb", "errb";
+
+            regulators {
+                buck1 {
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
+                buck2 {
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
+                buck3 {
+                    regulator-name =3D "buck3";
+                    regulator-min-microvolt =3D <350000>;
+                    regulator-max-microvolt =3D <3450000>;
+
+                    rohm,initial-voltage-microvolt =3D <600000>;
+                    regulator-ov-warn-microvolt =3D <18000>;
+                    regulator-uv-warn-microvolt =3D <18000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-error-kelvin =3D <0>;
+                };
+                buck4 {
+                    regulator-name =3D "buck4";
+                    regulator-min-microvolt =3D <350000>;
+                    regulator-max-microvolt =3D <3450000>;
+
+                    rohm,initial-voltage-microvolt =3D <600000>;
+                    regulator-ov-warn-microvolt =3D <18000>;
+                    regulator-uv-warn-microvolt =3D <18000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-error-kelvin =3D <0>;
+                };
+                ldo5 {
+                    regulator-name =3D "ldo5";
+                    regulator-min-microvolt =3D <300000>;
+                    regulator-max-microvolt =3D <3300000>;
+
+                    rohm,initial-voltage-microvolt =3D <500000>;
+                    regulator-ov-error-microvolt =3D <36000>;
+                    regulator-uv-error-microvolt =3D <34000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+                ldo6 {
+                    regulator-name =3D "ldo6";
+                    regulator-min-microvolt =3D <300000>;
+                    regulator-max-microvolt =3D <3300000>;
+
+                    rohm,initial-voltage-microvolt =3D <300000>;
+                    regulator-ov-error-microvolt =3D <36000>;
+                    regulator-uv-error-microvolt =3D <34000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+                ldo7 {
+                    regulator-name =3D "ldo7";
+                    regulator-min-microvolt =3D <300000>;
+                    regulator-max-microvolt =3D <3300000>;
+
+                    rohm,initial-voltage-microvolt =3D <500000>;
+                    regulator-ov-error-microvolt =3D <36000>;
+                    regulator-uv-error-microvolt =3D <34000>;
+                    regulator-temp-protection-kelvin =3D <1>;
+                    regulator-temp-warn-kelvin =3D <0>;
+                };
+            };
+        };
+    };
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

--kKCrEB1nWc/4YMm0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZQTQEACgkQeFA3/03a
ocVB8Af4nZHZVnLp1JDhTu63ycQIMCXHcGmrZPoFghB9Lf7zgZsrhD06IXhtTAIQ
YNBbsE1Wd02cqkFIM2vfT7Un4mGXRmsTfxnL1t4thIX/KWNCZsRJAMC1h35whaIJ
6Qsnm2v5wEIMuvle+BLbiEK9emAc8Qu9FzDUBddPy0Eq4GuLatIKeYMsro1vvhPK
qfrZQp0XppsGNHFrPT1J1P3KJm3RWhMdurOjxGGCfHMMNPq8SQrklh3+GUaHurDE
aJ12XFkp1auQfrylYliMWDJ1I1H1zRZec4CO7u3wklUYKq6jsnLiG/XaIPM0UpZ7
3eXmWdNJWBayhvc6um9QnrYRIEtT
=r1Tw
-----END PGP SIGNATURE-----

--kKCrEB1nWc/4YMm0--

