Return-Path: <linux-kernel+bounces-573389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF4A6D6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C1B7A2E70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C925D8E1;
	Mon, 24 Mar 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3M4gZSY"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5811DFF0;
	Mon, 24 Mar 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806493; cv=none; b=K/rg6RJs4X7fuQzJhKrFs4k8i6u0amF7WGo1LMI4x51NyG0ol3VYSeynXvXGqXrKx0otUooLtFkufro8EOcHUcDhmtLdh0tGVaZvJm6SRxS46OYcgu1gJZqkw4iLBB1bmnTa8jN9txIQpX24/iC5d9xCx4g5kUxnddDMS519vGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806493; c=relaxed/simple;
	bh=hycr9IxrcTalcitmbI4tg6J/1h4hJBWfw7bzysWl4N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEo+ZpDaLG7OPWany8nNmce6OJTFZTJQc0FEeYDsge/0+n3MgJuYoxq0HGcUcQouDqfAmOSe9lQFOyCB7Q/qOtxFfpkHS9O/AaqizUtA6oF0JUc/EGh0DCgf8A/spWIsnVEJAX/T4Yo1I17EijeMIWGP/GoC1mJAQMY9ipgCAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3M4gZSY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a6bso43633401fa.1;
        Mon, 24 Mar 2025 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806490; x=1743411290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4PgdBjfMvh+LwZmBpgNjLd4N5iJTfwXMdQvoKH4gKw=;
        b=H3M4gZSYyK1INgPyZEnB9L5m54IHlZZ6AUSXzKCViQK0LMbmkVVzJ3jBQ2/U22zN49
         4ArcUsypw5PzgcUPaOTFPIsaWC2E1ZKL+t6xq9s0hEfY9eLZ+6TOBVQTw1YKKdAXIMzc
         E32dZPgtEp0ccIDmMe83NYaMXoQm8I9JbMfxzlAbBzoN+Gx/SkoBxzXEmpjElm3vquXF
         ViN2GcRievaUrpD5wC6MmrE30kwOBNMfzEvlzdZHohHI5tSUZEyeZGRDNAt3EhWObDDW
         juA0VP/GMVsotQDZ89r4DVk/pdekxTswpQTbFj5XdmSNVNipf9iNZJ/XLdG3K1UGxPfg
         K6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806490; x=1743411290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4PgdBjfMvh+LwZmBpgNjLd4N5iJTfwXMdQvoKH4gKw=;
        b=RRtv8RUJ5NoonFslxRmbz3Z31+9f6qKF+r4j8tO5P7yRBcBeE1XgfqDs2K2x06Wu0N
         XxnZyda1JYEGkstklpyqkhG5A0DebQC48s2mSR4uraqSru3kV6pUEuuXYsaN3uipSfC2
         fwv2+t6Cnpd35dwyT4fJLZOMN2Pb242jRKDcmYSjfLqHlgeWBAV+a0e3b1xzjjN4QD5e
         T5YlujCli5Y1ENFo1ZycwdhrxPl/6m6nvL4E33c1vbyPZmOH1Th20/9FSUmqvwLX/g1M
         o82Vj2iD+Uzei93oCYffh0Y2FFdutAbeK1q+jEG/dpDc71xjZaSf0dJ713eMnKrVDnsM
         rDXA==
X-Forwarded-Encrypted: i=1; AJvYcCVoZZUm0JmezZh6/ab0G5KO0Xtkha7BCwkrAYsOIIk7G3CyW58jbvq26vXlgp1LtjVTMTTKjKvRmczr@vger.kernel.org, AJvYcCWOaC4mK47N4s3BvO4A92LWIVQ0qpSwLtqviMWPw7grpMnO8L0iiMH1qmWeGA497Je27EeKMm1Hw9+7VOIW@vger.kernel.org
X-Gm-Message-State: AOJu0YxojpjXWYqQiI5NQH+hJsWyRBlGkKiy5SxbTdQQfGEgi2CYYC/S
	Q8dsV4uFLHwff6PEyLAhRwBNDBhWIPN25vfcncY0ch6nORXRXhHk
X-Gm-Gg: ASbGnctb8KqaNohkfHyTW5GYlfZjdvJnKlN5Yn918ARH9an25y7tnRtNSXo6bqAL1t4
	7UAJRsAMo1cM3dD3SMNTD9RYEVqYE8hh6zGjIgWHBbDdjE2G1z+hWjjPgkWstTdzeFISGs10Rk/
	3FFuwrYAIpRK+JwVWdgvJWrdAhQseLxAcV0UAmBqoAqOmox/SZxN2LQ/DYrMJCV9p9ouppstt4F
	eR4r3zyccG7CEUsbtyVBE4d120kKLBS81kUEuZyYw9ytR21JkdaHIiM2byhejlJLb6rdVhIpV1l
	AenerUc47KCI840BxvwAdVZtBu9Lt1hoAap57rjx45HD5zi1Gbo=
X-Google-Smtp-Source: AGHT+IFEHwB92fLiQgD2GWu2hJd4lLDZemSsPqGx9ThponiOAhjCP3/zLshZsbkBdSHEk7Qex/1tHQ==
X-Received: by 2002:a2e:8558:0:b0:30b:c22d:83b3 with SMTP id 38308e7fff4ca-30d7e242af5mr34299991fa.15.1742806489349;
        Mon, 24 Mar 2025 01:54:49 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d557b9fsm13627961fa.0.2025.03.24.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:54:48 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:54:44 +0200
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
Subject: [PATCH v2 01/14] dt-bindings: regulator: Add ROHM BD96802 PMIC
Message-ID: <2cb4d103d011f0d4293f6ef9307cef57709263d9.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tX24Qyg5RxLJMHne"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--tX24Qyg5RxLJMHne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

BD96802Qxx-C is an automotive grade configurable Power Management
Integrated Circuit supporting Functional Safety features for application
processors, SoCs and FPGAs. BD96802 is controlled via I2C, provides two
interrupt lines and has two controllable buck regulators.

The BD96802 belongs to the family of ROHM Scalable PMICs and is intended
to be used as a companion PMIC for the BD96801.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
  - No changes
---
 .../regulator/rohm,bd96802-regulator.yaml     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9680=
2-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96802-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96802-regula=
tor.yaml
new file mode 100644
index 000000000000..671eaf1096d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd96802-regulator.ya=
ml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd96802-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD96802 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+
+description:
+  This module is part of the ROHM BD96802 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  Regulator nodes should be named to buck1 and buck2.
+
+patternProperties:
+  "^buck[1-2]$":
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
2.49.0


--tX24Qyg5RxLJMHne
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHdQACgkQeFA3/03a
ocUuVQf/SiPv4nnggbW9j+fXlAvsQIRmfKJB+W3T6we60BrxRJ2iNJEGIp+5SE4e
WDA2q8tQPfXatUNTpcIZ/LBiqxXHiByEtQ2KMtFZu8aHzbhNa/JDw1AGeYmmuoBs
7STG6b+YIbNCGQGQDZoHHk0o4qTzWZBhMfuJAdAScLhbzyOxDGGJ1kIQv7CvRzk6
NoOlXeGidj1jmeO3/r2qnNG3N0cxcYHW8jwJL6NPfokytYsgh+Ww0YVnUIIuj0Jd
2rAtGqGWVXmkD77mvTf4q0ai6AsAfrLlK+r9X8PyZLopOhcqWAXe052xWH+UgFyR
WP0ysynuemqMZSQV3DV3nh4lTkysuA==
=mVBS
-----END PGP SIGNATURE-----

--tX24Qyg5RxLJMHne--

