Return-Path: <linux-kernel+bounces-406376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C79C611C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A10BA189E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67620514D;
	Tue, 12 Nov 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E039gbUM"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC52076BB;
	Tue, 12 Nov 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430887; cv=none; b=ZmC90is2vbktbSHYzXleGcDlWAFz90ob9tOwZ6nVN7NQaJiJm0emGDcJyvQY2fDcraWYT59bQ38PKMSdzdK8BL+zorSRGGsml4sAK/5f87G7NpBrcISml/pELGTtlH7aRlI7ENZZgEDqc7Nx2qc8VvhpecJy/7dJDHVtyrI5xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430887; c=relaxed/simple;
	bh=uEP4rc+k06i8ew3zFo8Cn981ZcUlHzTfGxbMA+ArM0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rPK2HiOMQoEr9n0AAFnish84873Eos99++UBv2oIMPwgssqnF9bm4k0QbQrFKOt5ql9MjU/AMsAgsZY14mrVn7Jp2fqit/3hhZKxJ89zJfg/gPu3hna3jbaiO2+C2XPHMdtX/JaKXBZG27b2z33C+fvCAiMRXjKb8cJ1t2kwMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E039gbUM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539ee1acb86so6545069e87.0;
        Tue, 12 Nov 2024 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731430884; x=1732035684; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAhyIsqGDf28fa5zf1i4NS+jZpXp8c/tByN/JChqgj0=;
        b=E039gbUM4bOUywbSHRrhyBPFeayg2YQ/FDBRE88c0LrGgdctEhGUY40xPwxrntnRfi
         omsbXbGu1bB/jjbl2QOOeaSmPpvWC6DXQkbrfI1aWQFuJx72LbjHeszRCnebpftB8ttK
         GNoMuJF/urOFBcxyxFlk21sXy185MqYjdXzvxMCAGrLsMyCs/OjBZZQYoAf0ptMYzDlA
         obHrL7O6iqbrNzpGCRXUVInkX65LI3ldbbDrJasBkJF2qUFpGnVziGc29o0tQtvhcbWs
         xu45oETU8GNsVTTZ9aZ6TrAEFJ+2eSlOngCC5uk3Qu5JFo+PBXQ1m5PCMLIyDWD20WyQ
         EfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430884; x=1732035684;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAhyIsqGDf28fa5zf1i4NS+jZpXp8c/tByN/JChqgj0=;
        b=FD2c9bUoo2Mznuh9O32+o4gjuLPEVRoM8Xx6Y6VEY4jrAxM9NMOvejpeaYxakNiyeC
         KlsxMMl0HRm52m9YFem4y7SgKRhbzkFGsaNS8q2fIbFRwCh/bGWNhZ3XSyiMuxnUrVlq
         mK0bJ/sC4nrKrtE4aBLaREBKuT5LDOYe6ZyVO6PFaLo/bHfjcHzgNzRTMQb/5nVwDNhW
         UgbE3VbMv0F9aOCucq/CFo0LQdmdFYKeg77Xj0tgF17CYa4KoKaZs335Giri0r8G374t
         uFWl5EY28AZgcMnQORNUCboiM5DsGdUaGz6ewFCK5s3/fPofXPvGaK7/CpXlYpNIc7D5
         a/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2NCwwcDU5lJ8FOFUqoQOx9j/Ff8Zej6tMJzoAL+/6CkMvPadmDPPIlBMTLQWqmeRFGlpsMi57II+NbbO+@vger.kernel.org, AJvYcCWUtFGkSoT31Lkd4KFsau8sAff5LEOCuDGocB3133SOkOviJGFYInRBd3JAOj2CAYu75UhjnwqDgDJk@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGE9MFSQDa9DLvnMo4lX83HRkGafAaXvX2xitPxCYgWJRx8ZY
	x+6jLhy+LRwaS2fDWvVMcqbNJzkbC7ieiHWq2FdP0Gt4DIBvQeK0zbK+43/Z
X-Google-Smtp-Source: AGHT+IEY6jZQ0AMFq6Zsd8pHhRvxHoeUxZU+ugWzJp0O3cwWOT+A1L8mBDcfDInIEuV8GSGkgFAsxQ==
X-Received: by 2002:a05:6512:400c:b0:52c:daa4:2f5c with SMTP id 2adb3069b0e04-53d862e5e92mr8286253e87.42.1731430883107;
        Tue, 12 Nov 2024 09:01:23 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9b45sm1919859e87.212.2024.11.12.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:01:22 -0800 (PST)
Date: Tue, 12 Nov 2024 19:01:06 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: bd71815: Fix rsense and typos
Message-ID: <0efd8e9de0ae8d62ee4c6b78cc565b04007a245d.1731430700.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+9NMvW1Rb/r3xLhX"
Content-Disposition: inline


--+9NMvW1Rb/r3xLhX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The sense resistor used for measuring currents is typically some tens of
milli Ohms. It has accidentally been documented to be tens of mega Ohms.
Fix the size of this resistor and a few copy-paste errors while at it.

Drop the unsuitable 'rohm,charger-sense-resistor-ohms' property (which
can't represent resistors smaller than one Ohm), and introduce a new
'rohm,charger-sense-resistor-micro-ohms' property with appropriate
minimum, maximum and default values instead.

Fixes: 4238dc1e6490 ("dt_bindings: mfd: Add ROHM BD71815 PMIC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
The sense resistor property has not been used by upstream drivers, but
it is nevertheless good idea to keep it here for the sake of the
completenes. Furthermore, there may be a respin of the charger driver
RFC series coming as I am working on another PMIC variant with similar
charging block. Also, there is now an updstream dts with BD71828 PMIC,
which can be controlled with same downstream charger driver as BD71815.
---
 .../bindings/mfd/rohm,bd71815-pmic.yaml       | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
index bb81307dc11b..4fc78efaa550 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
@@ -50,15 +50,15 @@ properties:
     minimum: 0
     maximum: 1
=20
-  rohm,charger-sense-resistor-ohms:
-    minimum: 10000000
-    maximum: 50000000
+  rohm,charger-sense-resistor-micro-ohms:
+    minimum: 10000
+    maximum: 50000
     description: |
-      BD71827 and BD71828 have SAR ADC for measuring charging currents.
-      External sense resistor (RSENSE in data sheet) should be used. If
-      something other but 30MOhm resistor is used the resistance value
-      should be given here in Ohms.
-    default: 30000000
+      BD71815 has SAR ADC for measuring charging currents. External sense
+      resistor (RSENSE in data sheet) should be used. If something other
+      but a 30 mOhm resistor is used the resistance value should be given
+      here in micro Ohms.
+    default: 30000
=20
   regulators:
     $ref: /schemas/regulator/rohm,bd71815-regulator.yaml
@@ -67,7 +67,7 @@ properties:
=20
   gpio-reserved-ranges:
     description: |
-      Usage of BD71828 GPIO pins can be changed via OTP. This property can=
 be
+      Usage of BD71815 GPIO pins can be changed via OTP. This property can=
 be
       used to mark the pins which should not be configured for GPIO. Pleas=
e see
       the ../gpio/gpio.txt for more information.
=20
@@ -113,7 +113,7 @@ examples:
             gpio-controller;
             #gpio-cells =3D <2>;
=20
-            rohm,charger-sense-resistor-ohms =3D <10000000>;
+            rohm,charger-sense-resistor-micro-ohms =3D <10000>;
=20
             regulators {
                 buck1: buck1 {

base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
--=20
2.47.0


--+9NMvW1Rb/r3xLhX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmczicsACgkQeFA3/03a
ocW34Qf+L7YAFqDSI2HYyrLmFDSCOv87K/kLD3qG9JgYXfPgSNb7c82N4d7VHg8S
3wlsp3JYMr2oRPenh0jU74Oh/TW6kdVERPDzEJio/h6DRCpyn683cMo2g/54gWBY
Bz+fL06SdGae3fioYBDifUsOvl9pMSdGUUc6i8mvQQjqhRNIyblKKjBCVdKawTyI
YFgwA6rUSGR8L25nJ941TAYCCG+tTGylK3OYz1ELp3ByCWJH09cYj1NttGBmq+ce
1ILnV7flBAxzfuJ0ahNK2pxr+wyxDv7jmJ9SSRCQmk8RG3lv45JqWxwkv/XiVHJT
dsc++cXEEB78BrrOCCJrcq5SLydkVQ==
=Pbb7
-----END PGP SIGNATURE-----

--+9NMvW1Rb/r3xLhX--

