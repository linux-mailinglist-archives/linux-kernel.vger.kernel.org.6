Return-Path: <linux-kernel+bounces-573391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD9A6D6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B174F188D525
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8225D8E4;
	Mon, 24 Mar 2025 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gci2cBaX"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEE25D556;
	Mon, 24 Mar 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806518; cv=none; b=saytbafWid52Wan8e4SpUgUpGGQTbb35WePajnc7CVK1mw9MO0MSGGR9ZBRCaRgFazYOhz12zXgdnJGgQcPsPFupKxFVY8x7Oex18XbGMof/ihLtwAVLlGVFw83Zn2yq6pln2PqSalbG5bo43sjoK5/J9EWAcGE4rPo2r3Gvk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806518; c=relaxed/simple;
	bh=x8sWT2g8fK+d88kNARMzrbZDa93Emzzq5esTbT0aAFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh6fQHd4JKgZyRFxrcmioWXda21UXh29YNij3B067yXNEjbzpjqYciLRcs8um0+VGwHRqHZ2Xo/hWf8jE1GtcF69SIGuQ7y11SNpNgyt0fzbJQ+GlfSgr88vvqVH7rYcUy6wu3lyQ0sHyi8uevpEDnSQsQHbr9LIzTbEExMn+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gci2cBaX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54acc04516cso4418316e87.1;
        Mon, 24 Mar 2025 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806515; x=1743411315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6gGcB8A61kUe3aU56RKUuGTjM7c6+npC0pYVsiDB4M=;
        b=gci2cBaXs26usxoDednVhRhHuQjD77IlpUvbzqdBx5pQF42gn5eqiZVmNWK8IBZE1A
         eMAXEdl4rN/NSIz/Y8zdvmErFA+80HPhMK81TvcJp/LA1v/F18QgnbW/pD50WvDYkBO5
         Wh/cWHh7qGNo9U3jTANEzpgfthma8EiahPzeMEwZ9jTzmsYj48Md4qZs5eWXketcRQla
         XI7tFMIMTG80B+tjD//GBtEUBM5GWZhCHhBROYCO+8g606ONOKcOtN0v9su3iimG8nrU
         N/vZKIgD4hqHSrh7hZcGdTumdChuLPdrGjDdGD+t6rNRUEEHl939uhnXf6FNsdlVb2bU
         k7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806515; x=1743411315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6gGcB8A61kUe3aU56RKUuGTjM7c6+npC0pYVsiDB4M=;
        b=sed7ZZHnQeEvXKgcLsnm3K3nLQSrDM+1LnnOjT8QNgUabw4mGnWvL6eDv3uwj9pOF7
         Ie5uD5TYY5jIWqriwRDrbe9O8saj/tG3ChPOqKgcJCUl4NRZqX0P+6q4va4DTax7JzKG
         ewndSrkI3P1msondHrOmptXOgX0mfv2Wc6Dia0r0ANDcwB3vGMbu8Hc8pJKbQYjGJLgP
         Hjk+qeNrobh3aHLODq3Qu53hiJKd8R0gRb49L1xbswPmVlyeINx9TbX36FlRkCuL7dJB
         RieMYmDdBdgZlqYW9eoimRyC/ix1JHKINnzjdpXsJ/0HjBdIyuJAgPmBWrRBRKMmDqxK
         rvjA==
X-Forwarded-Encrypted: i=1; AJvYcCWQk3qcmaV82w6lu/RskdkDYq3BWLxOmh14HAvGiQdu6JUJ/YqAo6IqoZqKQzNwlhaV9jLehB2mLi7i@vger.kernel.org, AJvYcCXStXeptoPDNIQhsGe9mlhxmylrbyFVKQNbTRJk54RJc2K9LJNXep/1KAMSCp78GCP39Iy4pL5gNI1o4gSk@vger.kernel.org
X-Gm-Message-State: AOJu0YyS94R2+6/cPwaMWOVHBAhfP8IxE8TVnLsjrUpXk/XV0cHX8UkW
	N1/cFtJWq5LmBWiIAm/d064+GVNN0gcqmFoWOi4fFtumPcyYKQ5m
X-Gm-Gg: ASbGncvORGFzgPMiV1xKu4s4xLL3BlBSeApgHKqjKg5kTEUcZ8sShaX0dcAYcgtL8vO
	vEsEIoGFk/XUM7DAg0nxdYpLkxnkFMswrKVf/CZxo1osU9UAyuY5t01xdKKBV18VohF8Vvu8OOz
	9IXA2GGP4+LxjGWVb34w5vODohGmpKwNrGDjTvr7nKn3Q9aJdOk29wmDF6fwVTjCNmnHfskfRTH
	t3E43or6FgfjX+Uw0g6lH4fo7Wsc2NZ7C9E1AxPutboi0aXKYdNH5GNffJLVXjQwcyQvULuYIjA
	BbPOz7uttmgn2zqBl5RbdfbVSvcDhXaVxkk82q9GXOXK7K+25fc=
X-Google-Smtp-Source: AGHT+IEaIi/p79aQyMoGzcbqgRU9qEdsma44MZy3etmXE3hbuig2dTDT6KKDpcsl+mLaMFOhCoH7HQ==
X-Received: by 2002:a05:6512:ba5:b0:54a:c4af:18 with SMTP id 2adb3069b0e04-54ad6486711mr4158315e87.22.1742806514802;
        Mon, 24 Mar 2025 01:55:14 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65095d3sm1062936e87.199.2025.03.24.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:55:12 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:55:07 +0200
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
Subject: [PATCH v2 03/14] dt-bindings: mfd: bd96801: Add ROHM BD96805
Message-ID: <e220ff02f9f1727734999a9a0f7acbb5334522c0.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j8ne4SGJpB13nTmp"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--j8ne4SGJpB13nTmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96805 is very similar to the BD96801. The differences visible
to the drivers is different tune voltage ranges.

Add compatible for the ROHM BD96805 PMIC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
  - No changes
---
 .../devicetree/bindings/mfd/rohm,bd96801-pmic.yaml     | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
index efee3de0d9ad..0e06570483ae 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/mfd/rohm,bd96801-pmic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM BD96801 Scalable Power Management Integrated Circuit
+title: ROHM BD96801/BD96805 Scalable Power Management Integrated Circuit
=20
 maintainers:
   - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
=20
 description:
-  BD96801 is an automotive grade single-chip power management IC.
-  It integrates 4 buck converters and 3 LDOs with safety features like
+  BD96801 and BD96805 are automotive grade, single-chip power management I=
Cs.
+  They both integrate 4 buck converters and 3 LDOs with safety features li=
ke
   over-/under voltage and over current detection and a watchdog.
=20
 properties:
   compatible:
-    const: rohm,bd96801
+    enum:
+      - rohm,bd96801
+      - rohm,bd96805
=20
   reg:
     maxItems: 1
--=20
2.49.0


--j8ne4SGJpB13nTmp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHesACgkQeFA3/03a
ocX7PQf+NyLmiz+Do+hPTxhCDleKGWOj6TGmoON+2v+Lifp7mxl8nnRbdOumxqPa
zZ+3ZYjihPL3diO8TcGw2FAxiMIPqK3HYL8xtpNTf+yHnOTk5I+xZOv/i6oUm+kK
wgEvxz5hwrRINSTKdsdbgt7pvD35WoQkyjocBpfHwAMWhkK+xXrrVNNlO6vJ/yYr
i0dYPrPvrPocTG56brKSvYRgnXzDX8qmLtzQLkfWWKlI8ssgckeR5LtLNKVvZGb4
tsrzp5lRnihYtdjC2wKNiLG905stdhWpPYXnq51K0pKKPTvNKvV/2MAP9FyinqSh
XRo83n6l7aYElp2hfMF/BHUP2jpgJQ==
=lntp
-----END PGP SIGNATURE-----

--j8ne4SGJpB13nTmp--

