Return-Path: <linux-kernel+bounces-573392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BADA6D6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E4B3B1909
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E2525D8EE;
	Mon, 24 Mar 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeLvyACT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1A25D54D;
	Mon, 24 Mar 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806531; cv=none; b=DVhKJ0jUh9zoZT76KfMpiSfU2RJ2eRThX0Y1WhogsrKZWsyCTAFLdNLNuWFCw15wjnC4U0RLhHqaw40ShVlmeQNMww+SY6jzuCtyVMsy+yNSxYkMt725vM7OUckPIuWF3f6XT6txVWrZCYn1b6PqezpEezUQIh7hY81IS78f8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806531; c=relaxed/simple;
	bh=1WtMZ+avKs10TeJ5g2BS1G1HEiErrUGL5tU46qVNWXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPzfNn6QkyTgYfY82zlPtb+BGX0SyRQnmwjyhW/fSsFaQPoPuwKi8QF9Qpexy3aSx97GkgzK87RFmCi7eLQbX5zm83EHNRHgyf5qCCdZ6IDjN9DkRta5odSkl7HA9zm5Kf+kmdX6DiCad03wbj1v6wS2mJLR+CixVaN3WfDrATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeLvyACT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30c05fd126cso37494251fa.3;
        Mon, 24 Mar 2025 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806528; x=1743411328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQZyEIP3/ePBQiI8Bs2V1ahk/S9nXaRyvTPaIWEZt+g=;
        b=DeLvyACTX+VUqCBvpobH/3LZvBtGQcMmgRCkjzsxpW5jLceiAxbZd2U960soyQN+ij
         sHNddy6mYZhmDBAJfmaqXEJA5bVLYgEZZd0IwJXhDr6VMwv0l7pKGCqRvt9CZJi+rewv
         9F6WgK18qN9c8OqioXOtNsuF2ft+9GRljvI3bKYVosV8sNGQX9+IV+b06z1tqaRh+Fce
         +DNWXwLFfGUoSPmj1q7TNsPy+qGaGUP0pcSrv2srzBlP8MSTTx5bsUjR93uW9Zb9X+in
         Edq1E+prWG+QGgN4cHbs0SFfAsfIY/T+p+ZnHz9qTp5JrpppDJH7FoohsC645xxwxVeT
         3DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806528; x=1743411328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQZyEIP3/ePBQiI8Bs2V1ahk/S9nXaRyvTPaIWEZt+g=;
        b=Mhex33RvuH1RnmEweCQjlmtWkcUTv27Avbeuvds+wfiIrHK/TpBefV+Qr6Aym1orL+
         nLgVdCU6+GEuKMYNbprrLwkyQyQ2vLNQm8SHJXM2+QHC5X6qGlI8SjL4URU0k50DN0sq
         hdEjroB7I4lCf3sDh7GdzyYxbPTw2PV52t8WCNvNKDuxgh26/g4nJGWPVbciXG3kryo1
         1JJdzSYS+HfIDarrNy5Wt/eI2jWAxLvKmK85C8RYqqbSQpG+nGF4MtWg62FAplyWUki+
         Rb4qyqKD2FspqkGKu52wl7P9i3ffHW/9V/qOUrg5Iayr/M1nc8bKkN9aR6mjupTQLP4b
         JU9A==
X-Forwarded-Encrypted: i=1; AJvYcCV0Y6Li1dKlcAZmLVv3gzjNCBgquXdHmxLr34O1lSt4d65/G8wL+yElJGMl2hECXjix9HRrv6b915HMZnkg@vger.kernel.org, AJvYcCV4fg3r8iuDtUsci/fdOWyNRJ48otjKe/IEq7fQ8Q6IfA5JOvrFETwPWtkyyrMJItPim1182lS8oCu2@vger.kernel.org
X-Gm-Message-State: AOJu0YyotyYWizdLj5e7XSbGtG6cBAEXAqGwlboNSef8VPkySRaavTFk
	7N/IjV3tlPjADjHYDiYJ74o/HkCGzaiYyg+8sScwraBOS+VgKMwO
X-Gm-Gg: ASbGncvgU27YYCkTh3ad7kuz9eSZfDbHzEmdSy3RXp1+DtM6nymht4WbUaHAymjGAIN
	0RGN79vT0rSy9uW58Ex1vLJjjCZ1Z+LF5pdqtiRgkaH7fKgWScdaR4MF8hK080v8SVM61EM5Q4b
	S/3bxHLo6lmLm+Q8AQCF5dBUHdldSid9C19+mimhMWqx/PqvzFwBxBMHr6SsAr9dHw2gsjsiHUu
	wLZZA3RHm76dui0mMACndQs03OdoKsSxMkJkp829byERAuyWSKHT9KBwOAV6Za23EMxVmoseO0m
	TilvE9Q6SNkfONFDwhVwImrzSAhz0slYju6LCkCWQkz1DZhOm2Y=
X-Google-Smtp-Source: AGHT+IEVqU7HL1CLrd6wdNeorTDWgOPAP4DTNxILPvTGkZyQc3Z3NLyuPWkSiI9pqWN7ZqL09DNsFQ==
X-Received: by 2002:a2e:9c95:0:b0:30b:ee78:79d2 with SMTP id 38308e7fff4ca-30d7e2bb92dmr37674701fa.36.1742806527271;
        Mon, 24 Mar 2025 01:55:27 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c1a21sm12753081fa.19.2025.03.24.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:55:26 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:55:21 +0200
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
Subject: [PATCH v2 04/14] dt-bindings: mfd: bd96802: Add ROHM BD96806
Message-ID: <99ffe94d642b6c73cd5199103e65419c93214533.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5OKbO5lRvuPl3q+"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--f5OKbO5lRvuPl3q+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96806 is very similar to the BD96802. The differences visible
to the drivers is different tune voltage ranges.

Add compatible for the ROHM BD96805 PMIC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
  - No changes
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
2.49.0


--f5OKbO5lRvuPl3q+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHfkACgkQeFA3/03a
ocUnJQgAmvUgTIRuM/dMtbVLOOiEduXb9oXBC8OP8M+XOHjD0Mc+DrySdQf/CETS
UFDRkUSIR+VAOMc56dBVD+qsNFOuyIL+mDaZzh1rCbDh75MWSpadP6T1VCW5wlM6
X/ZuPLJwZ1QByhGETYRh5Ei35tYPZhP9RjVO2HedVxNy/SkX6ahLzXsQcoXZ9k9M
QDSlnkgDWCKAOFx/suYYcJzeebqqaI+gjbUZHnlAiXNRaXLnkj4gdZKnBVXehbS8
N+slIxcGr68Ha01A5aviYRPWe8Jgq2ehjvtp5oFln2xkrmt1u4+9hnINTrbLF8Pt
N0BayToO8yM0jHH6MYgsyHJbqvOOiw==
=GD09
-----END PGP SIGNATURE-----

--f5OKbO5lRvuPl3q+--

