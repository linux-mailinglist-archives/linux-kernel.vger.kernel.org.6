Return-Path: <linux-kernel+bounces-559364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DDA5F2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11E216B635
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35F266B5E;
	Thu, 13 Mar 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK3VPH6X"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D3266B46;
	Thu, 13 Mar 2025 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866067; cv=none; b=WDMlSTt1+bCMjyPxjJvMudLAaGbcObRI9qIW1xRb3C0/yVtLWWZ6QaXqTWxrFx1e5TG6DK430GZ1qXIoG+sifw+5oQiA/dJPqyrKn0X1wR3Xrqbuj12kQG6gFR3apNkht9dmmt0anPXZ7DXWmH1KXbvdIRzxHzhJDBJIHnNLI+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866067; c=relaxed/simple;
	bh=GplLPwTK9dUCVkJNtN05NSTyHk7TJv3f61TrBFXIMyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfXz+skphBVI3WlcDtL4sl1KKEMnfcPSGbVP/4+gaigDpPPhyDwpiyIFGeRbEoo2ckzHswf8EDHUFJE9jUWB2KRnyh94yvTIq94NGT5tRcnAAPgV/UrvABA2qKmgnaLrIWl/Gbzgo0d3bBqExyrilT8CrmHSN/n2J7Y85TAqWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK3VPH6X; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so889249e87.1;
        Thu, 13 Mar 2025 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866064; x=1742470864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BaFyzl0YFrML3OmytUU12qD6QrH8ZAERBPK4xvEEj5w=;
        b=LK3VPH6Xh0x/ZWuhIxY0g0dsAzyGlhYQw4yyKL7yplphWcScXvowvQkPmaEWBHGOqg
         Gl8QJ4Pyeh+VmyL+lHqeDGU4P8wy9l9l+MmVoIKa2CkoVIJ0nhgUiWYE9bfLIVljzMxt
         wW5GvvUo3VG2qakkrrZl1HJwE+mCoIlwN3tE0n3uweE7O/yCdzElTOTTd2wr4YLT5m7B
         6YUOtIt354y7RijAtUt4l5QhSN+ur0fvkLojWWvEnVsC1QfDTpWbjtGF3PXm9oPFImDF
         m5X6f0o3EMjCVqrVkedjD175YbcHc5NPMZbEiQ9YbDh41SzXBC1A6Cael1FtAuHgkM17
         Rclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866064; x=1742470864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaFyzl0YFrML3OmytUU12qD6QrH8ZAERBPK4xvEEj5w=;
        b=Tp+B/0oQmP53RyNC38ExBj60KkgIBdwIsPFd8EEV9FOAoCcHo0Q1N240SUznJMt/qo
         HVoFLBcLp0nTzJlbKnypEv7Da/zO7u3hCaL3pQidverht2z5Y393UXY9Gj9krGBbqxZa
         vHSN4jJaGiyq80XpFPYexo/jsxhVQX8aULhOTy6+YCHRZX2kFZ4ExHgjmV6+AZ3M1C7X
         h+celUqMeTSDaI8swbc81283qIM2I8nzDAl6ERsjKpxQbriG4cyzPoUX5g+cZSpFXgCh
         rDeWxmy3uCckdxb0gxYWGknRr2LDmPMv5tKwBy28tprH+Ad0xell/MF2MY35RwPpPcMm
         myMg==
X-Forwarded-Encrypted: i=1; AJvYcCUmtX7Tab2Bg6hOZE4UKYdja4hf0wY7yHwc7jsBhZkU3zxcO8rLRts+faX3+GKJ32xjAeGeOhKMoEIIgKZ1@vger.kernel.org, AJvYcCW4aE/u3GGvcHVXY0DMeQ3Az6JlH0mOloEXqSdhMAtFDUkiy3LQFxsBQGzXhOmw8erUWSWbW8X3BhPs@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwzkFiOs0rLu3x47I4mT5yo8bZkfMmDjXEX+GP8f1NB8petCL
	8ZKFozF1MnaIZ6i8dE4LVxFZJeM1hyOxutJBhQWkcVQLkUH3Y4Gw
X-Gm-Gg: ASbGnctW9JIDM2BOrfiXmoqGlGCy2QqTen09AVLVUpD9MRPrKJOBKEKK8NImhW8cfhj
	pCofqvXV6msz9CCppxX2MWNSbxzclwssUwz/6oB26k8MFQ1Txi6TVL2R34eeMCYius5vmckdrCb
	s1tQCQV+1pa9LcjKoylIJjGEpKHohwZkgRdtQeLhWlA4Y8Qn/8f6h31TJBX2OzVbhZ42OW4BrR9
	eHAi3mmYfJcMUqGMbzSJuzmM8IbqoLD7bx3OIr3piWYlGqp/d7XUCoaZZu8P7NF8XWHO7UO+Xdh
	+yPWtcH85O6cd+wZ73vVHszo6igH3RXgcnjFZCH/25/4dZ8venF3JB3V6K2aSg==
X-Google-Smtp-Source: AGHT+IG3MDbF1eCbxjtJyEQMKpiK2fHB+pBZVRFPvTPpNXX4w7096GwYJ/QPJOWPmhLvGnEzG+iIHw==
X-Received: by 2002:a05:6512:3993:b0:545:c7d:1784 with SMTP id 2adb3069b0e04-54990ec824amr9498561e87.43.1741866063854;
        Thu, 13 Mar 2025 04:41:03 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a702asm182306e87.212.2025.03.13.04.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:01 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:40:57 +0200
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
Subject: [PATCH 01/14] dt-bindings: regulator: Add ROHM BD96802 PMIC
Message-ID: <93b7b5ba885328301242b8ef708db92c24e50132.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OlLCymbnSnZA6bsA"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--OlLCymbnSnZA6bsA
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
2.48.1


--OlLCymbnSnZA6bsA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxEkACgkQeFA3/03a
ocV9eAf/YTGOqr0nkHr0qsRRN434dd/2sFINmLhSvGMVVdZB01nhPsod1b6aYBJN
kQb/p7xUWp60jitnFYmRExBdu8JJH4kZiLsST7PYD6Goin777QPEwZLMLH0LCZrp
nOTHbA7aYlZE//fhrg2cMADGjSLaID6ySF+vYdKbq6hsj7YXKd+bjEtpHcG8dBQi
8k7XzCK6OqTNErbZNIfmt8H6+UtF4Yi1hzgBFd2NQD2fZpeFQKGk7Fp/UuHh7BNP
GNK3E3mxUuAdziwKgpgFZ4rm+U2PwpAxblmPYIhKUqUbE4tXuzP11kYPEMCE9AUD
7wqWt7lNMZHwyPlDulzgFyxNJWzvYA==
=+NW0
-----END PGP SIGNATURE-----

--OlLCymbnSnZA6bsA--

