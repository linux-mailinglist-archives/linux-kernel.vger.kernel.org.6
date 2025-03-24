Return-Path: <linux-kernel+bounces-573390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F1A6D6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62553B192C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8AE25D54D;
	Mon, 24 Mar 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdvJ0V/B"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8925744D;
	Mon, 24 Mar 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806505; cv=none; b=cF2stJqIw9ps6gQyXtIStGvZ9DjvkQNk4pHOJqSpRlK6G8iQkhnZB/ta4D5OUpyswwFBuocED+0+l+lA7We9KwaRIda7idbVw1hw9h01x4+sqS8z7ZUwR8g4lQ1ShPSHM+evEW0NnH3Iq3BlLtJbXEzl1FZigMCkCB5+uL9h7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806505; c=relaxed/simple;
	bh=Pe1zU4zOy4zJ1STwwwkhy9Ka0N6zvNRuqUxxqQ3pxxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo6JnNTQCcL5/+3Zxlr/ujfI8Z1I5FHMizGJ6N0XGxLt/vtBmN4FZxNQvVCaKdCNKILnPHtFtAmFvdTiDsEsdFSKooCPvmzLyFfuoxtMBdjY7yTeVw+C04zVgse7PqiY0r5ISy5MDdhGXUdHPP+ggOQDdbcXHbb+W3LeQ9vV9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdvJ0V/B; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54998f865b8so4170624e87.3;
        Mon, 24 Mar 2025 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806502; x=1743411302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9yjgZqexRjWkkcR270btwqFTgfMEh5ISkZy53msoXc=;
        b=cdvJ0V/B8t5PWIbfFOPqIS6mjvYg2aCUUdHUm9ZTXYyPzrqORbJJdZd/ZhOSwC2Bnl
         K5zHcim745E4Y9YXHRo+klDTVTwWosm82ocgisNCu1WSHCuUO9lAlslJO7t06cIA07Vx
         XCe5hQgrqei6nNYw/ZVrk9qg4sYAtmN4QMEKjdM50pmDMzVZBKNfIeMrmOT/CUYcvl57
         OC4VVT1YLLJlJraQWPBK9TIGGC8qVYcpZogjIvnI8vxVQ7YQ0tDjyzxVwvRt3dyyhlbb
         EwGnIkjWW6U5SDhrciNNCoCRQlkwCCxpOv8rv2FGiF/bmNzaWriCTJKWdE9lWBa+6CMi
         Xx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806502; x=1743411302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9yjgZqexRjWkkcR270btwqFTgfMEh5ISkZy53msoXc=;
        b=n/xsRjtwtfffAIVKCWl/iaKzIypqfsc1FNhXKNIOkpK22bDDWa5n60HV9PQC0BArRq
         Ghuw9ZWStwd3jm6HxzmVYwNTh5Q6f1zxXpy/+EqCotYv5hcJSCPbVBUTFinuzsy6/KO1
         q6tTqRFlodXi92K2drtttVF2eyZSysFY+RzS6C51iGHP8fFFFOL6dLQ4KABR5hDxEK0T
         m82waLHeUqcfkmsK+6fYWPm/cL6iMqwz2IdtyIAd37LTex6igYwux8FmJ+bkSqjbJILB
         kKQ8aC3aa9iCZBJIPXg5iTiVgs3rcAR33YKbwfylLW+eFpUhnldEGX5k8cbxymhv+p/h
         fRJg==
X-Forwarded-Encrypted: i=1; AJvYcCUP09s6gYYN6DD/8F2eQ5/O3hCNehXjcgGYhmWB5y+puoWZR6kQ0mRU0TWmvSBL0yqeFFPPVu/Seeu8@vger.kernel.org, AJvYcCVGSvwKwztYIDQ/0YJv3v0O7xqjJqFT1KJtpbpinU06evN9jsyV9hXTvar7FVMkDYexpW9v9ZSf9YF67Hxk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29KTDMg+FGoHBhicMs4nl8mdwY/bqed1hncdwd66OIwLcZhbU
	vVpDKJqU1PQyeJVJnK2Cc6gaMaKmK9tGdDJwUpfIa4rypBFfSPIl
X-Gm-Gg: ASbGncv2A7c2XOrdgSS6GR8jKnC5cGWpQUS95ZJk7IB2iIvBnq/p4qWVkofW6fMIkFN
	nyfUtatqvA3VtLDfKfokWMnH+xz2iSOKbGm4WouoPRfHecysmp5W30wtyS1zRByoZ7FIHPGUZxE
	pDHAmotcvWXZOPnHwNdelZIOjmaURctoHeiSgq0Dcs50AeWMxlnWiL49sRHcXaLgLkvctJoRsHI
	1cCa3AkuM9y4F7Gww1QcbaDw2t+LQ0Fht/jXvbll6H1liZPYhzGVpVVBu2ko7VnGZPhzYdR91vK
	IHFtcNsJE8ztAZW8skaaaUIbMuRYD0hc+G+QKgspnjan/P956c4=
X-Google-Smtp-Source: AGHT+IGiy/IQ4FBtE5dUSG0yXAWmbojOP7T5OsNSHfs9p+F+vLYlUP2fBqD/IM+aUvp0BuEhdrvvMg==
X-Received: by 2002:a05:6512:ea7:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54ad64f9f7fmr3670905e87.42.1742806501611;
        Mon, 24 Mar 2025 01:55:01 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64687fbsm1065132e87.32.2025.03.24.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:54:59 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:54:56 +0200
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
Subject: [PATCH v2 02/14] dt-bindings: mfd: Add ROHM BD96802 PMIC
Message-ID: <fa888bfb770b589f08e0fb2e6153d176df9cd2a9.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uFCGtdygzb0pMnCZ"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--uFCGtdygzb0pMnCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

BD96802Qxx-C is an automotive grade configurable Power Management
Integrated Circuit supporting Functional Safety features for application
processors, SoCs and FPGAs. BD96802 is controlled via I2C, provides two
interrupt lines and has two controllable buck regulators.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
  - No changes
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
2.49.0


--uFCGtdygzb0pMnCZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHeAACgkQeFA3/03a
ocVj6AgAozEOduDIcspBtTySp3foQTSQITk5S2JGTvP6dICvBHKzPk1RRtmI47Zh
1SUMXHZJFhrTrPJqGSJHhiwT56yN2x+UxcyV0r0pQxPYFRihqTLREGugmsPQCaxr
vfF2gkBbidLRoe4+zoCJkR5rHGYJtfVRSj2CdEQFdFH66zbXytwuvDZa5OreAgoq
TFZqucoHw5Vy2TwBoNUBIhVrUIyB2DWR8YPtQDdH2U3SoSld+HYRsEyzleahj5oK
izH9whqsngUIaPU35ZBpvacBaTN+Ia4z6bp3Np5E4BgTxmqPK8gnkQQi/FkQxdQI
UxSakcy6U8YM+8proE25koT0i01XVg==
=ufSN
-----END PGP SIGNATURE-----

--uFCGtdygzb0pMnCZ--

