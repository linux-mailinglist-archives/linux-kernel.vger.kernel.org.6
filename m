Return-Path: <linux-kernel+bounces-445486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 327579F16E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA53818821CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB6219047A;
	Fri, 13 Dec 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-heidelberg.de header.i=@uni-heidelberg.de header.b="FD3E/TEI"
Received: from relay3.uni-heidelberg.de (relay3.uni-heidelberg.de [129.206.100.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A7191489;
	Fri, 13 Dec 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.206.100.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119748; cv=none; b=cOB1hI2D0c5fp9dXvOEGW5Gjb7vPNpbqfkge3mK3MMMDmdXG5/QBv26iLrm/u2vopIQ8hWIm9mOQ6OoI+30QpfWdh/HaVt048IWKGs4ZPguOVRrxDP50m6quOhHagbPkizWGFAF588f7izHb1K57aocmqQXSsaSEmgHXUXy8Nc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119748; c=relaxed/simple;
	bh=zFml9V48tq1Bs/Zu8HpapxYWnav6z7nwM0EEjEzGWV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Olo/VBun3xzMu7peSSMqsqj3AR1dOmA/WGO1fSrgm4tLHc3a4ll1c2oFQCSKrqeJUCIkspbLRTuv3beWiyLFn0/SYXNAfSDqY5IyCNZkzJRCKTYcyoXpNj+IZVtma2e9U6PRiuNCe8bhyhKb4ZFaclMq7DzZCMWISlbKKClRvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-heidelberg.de; spf=none smtp.mailfrom=lemon.iwr.uni-heidelberg.de; dkim=pass (2048-bit key) header.d=uni-heidelberg.de header.i=@uni-heidelberg.de header.b=FD3E/TEI; arc=none smtp.client-ip=129.206.100.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-heidelberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lemon.iwr.uni-heidelberg.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uni-heidelberg.de; i=@uni-heidelberg.de; q=dns/txt;
  s=s1; t=1734119745; x=1765655745;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zFml9V48tq1Bs/Zu8HpapxYWnav6z7nwM0EEjEzGWV0=;
  b=FD3E/TEIgozCbpiRNQpKRQA5l47MY9f7F6fmb0hBxG73l+NoaGV9ntAY
   gtaWHe2p0Fr8fg2qywzC2tplB2cacqL3oT9+WY+ZgxvHEawrbKJz33iTy
   WMJ/EDmQqomrajLwoIzEd6JivCJToCm71/N6fyNVCGxXp+drjqWQu5kEp
   5XVf5tAbPBNNKaImVLBPoVELHgfKiv+cW2bW3399mMkf9xPkIiDvaruad
   vbMF6QjHuJPg9GCLYVzYQW4rFjrDpGtPEwzR9rLuT0XavvXFUNAsXrdm1
   bysQtEr8oXlnb4igTdc4BNU3266dVSevJkaugOmGxbv1eleL//RC6U+Gh
   w==;
X-CSE-ConnectionGUID: +ub3uNglS8mJbHVh7XVuPA==
X-CSE-MsgGUID: OFt8zcDWTwaDCed5i4LwPQ==
X-IPAS-Result: =?us-ascii?q?A2AWAwDYj1xn/1BqzoFagQmBU4IcgwmEVbAJFIF5AQEBA?=
 =?us-ascii?q?QEBAQEBCUQEAQGFB4puKDQJDgECBAEBAQEDAgMBAQEBAQEBAQ4BAQYBAQEBA?=
 =?us-ascii?q?QcFgSGGCIcEVjIDAiYCFjoOARKFZrFigTKBAd5KgVaBGi6ITgGFazuCDYR+g?=
 =?us-ascii?q?RQBg2iEJQU2gz46gi8EiRydO4FNeDIBVRMXCwcFgTo6AyIMNjECgR6BAhQGF?=
 =?us-ascii?q?QSBC0Y9gklpSToCDQI2aYE7JFiCTYUZhGWEVYJLVYJ9ghl8gSEdQAMLbT03B?=
 =?us-ascii?q?g4bnSVGhxijZKMjB6ViBBYzl1GTAJYbgmAiqQiBZ4IVMz6DNlIZD49PAQLFB?=
 =?us-ascii?q?nc8AgcLAQEDCZFtAQE?=
IronPort-Data: A9a23:1HeE5q3I+T8eX8BU3/bD5Y12kn2cJEfYwER7XKvMYLTBsI5bpzEPz
 2sYCmCOO/zcZmqnKd4iYYzi8khUuZ7VyNNgHlNv3Hw8FHgiRejtXInGdBeuY0t+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7wdOCn9z8kjv3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOt/vZ8Ug35pwehRtB1rAATaET1LPhvyRNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1jqEl/uFIorNfofTKiXmcJaLVeS9oiI+t5yZv/R3jndaPpDXlBYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes1zFfUuxVPJHZSwmY+OxRbbVXTo+KVrLksWA41HythqOUgbo
 JT0KBhVBvyCr+a7xbW9DOhznII+KsiuPI4etnxkxzzDArAqTPgvQY2Tv44ehm9uwJkWQ7COP
 6L1ahI2BPjESx1LM0oaEro6keKvgD/+bCcetVSU4Ko64mTeyAZ8yrerPNe9ltmiH58LxBnB/
 jyYl4j/KjY0KIyNwha6zm2lqsTCkX76BKYNLITto5aGh3XJnzdCVUZIPbehmtGjjUS+c9FSM
 UoZ/mwpt6da3E+xXNq+UwGQo3OeuBMYHd1KHIUS4waLzbCX7xqxBWUeSDNFLts8u6ceWjEsz
 XeChNLkQzt1v9W9S3+H8LqW6yixIyEfIGQqaioNTA9D6N7myKkohxfSQ9JLC66yitn8Hz22x
 CqFxAA6hrMOnYsCzaD+/l3dhT+ojpzIVRIuoATRUHis4g5waMiifYPAwVza6+tQaZ2ESEmAl
 HwFgNSFquQPC4yd0iCAXo0lELy35v2ILCfRjHZxEJQ7sTeg4XiuecZX+j4WDENoNNsUPDzke
 knevStP65JJenind6l6Z8S2EctC8ET7PdDoU/fSKNtReN5scg7C/CxvaUOU1W33nw4gnMnTJ
 Kt3b+7vEHxBFIJoyAHmQsUX8YErmRAA2Fv6EMWTIwuc7ZKSY3ucSLEgOVSIb/wk4K7snOkz2
 4sOXydt40gEONASchXqHZgvwUciAVVTOHwbg8hac+mFZAt5Aic8Df6Uwb4gd4FhlalPmaHE8
 xlRu3O0KnKl3RUryi3TNBiPjY8Dur4l9RoG0dQEZwrA5pTaSd/HAWd2X8JfkUMb3OJi1+Voa
 PIOZt+NBP9CIhyepG9BNcOt9t05JU/w7e5rA8ZDSGVuF3KHb1GSkuIIgiOynMXzJnPs7JBk8
 9VMKCuHG8VfL+idMComQKj2lALs5iZ1dBNaQk3JPNRJY0Tw+YV2Yyz8j/M6J8sBMxqr+9dp/
 1j+PPrZzMGTy7IIHC7h3PDV9NvzQrciRiK33QDztN6LCMUTxUL7qacobQpCVWm1uL/ckEl6W
 dho8g==
IronPort-HdrOrdr: A9a23:rY+Rk61FrAls5XRAVLpPOQqjBJAkLtp133Aq2lEZdPUzSL38qy
 nOpoV56faQsl0ssR4b6LK90cW7L080sKQFhbX5Xo3PYOCFggSVxehZhOOO/9SjIVyYygc378
 ddmsZFaeHYMXg/q9rm6w+lFNsazMCA673Av5an8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:arNhm2Fey9i/vTZ2qmIk6URPB+YqdkaNyVXaA3G4VlZXVYW8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AjMg1/Q+zjebslZCPOxUPhzOQf+BG//S8A2wyrYo?=
 =?us-ascii?q?Pl+KJOXFxZxOCtA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay3.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 20:54:34 +0100
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
	(envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
	id 1tMBk9-0000QN-SP; Fri, 13 Dec 2024 20:54:33 +0100
Date: Fri, 13 Dec 2024 20:54:33 +0100
From: Hermann.Lauer@uni-heidelberg.de
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: sun8i-r40: remove unused GPIO regulator
Message-ID: <20241213195433.GA1568@lemon.iwr.uni-heidelberg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Subject: [PATCH v2] ARM: dts: sun8i-r40: remove unused GPIO regulator

Banana Pi M2 Ultra V1.1 board resets immediately when the usb core tries
to setup PH23 GPIO. It turned out that the V1.0 board USB-A ports are
always power supplied and according to the board scheme PH23 is simply
not connected.

So remove the PH23 setup: Doesn't harm V1.0 (with R40) and let V1.1
(with A40i) start.

Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>
---
V2: shorten subject, rm dangerous PH23 regulator completely

diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
--- a/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-r40-bananapi-m2-ultra.dts
@@ -91,15 +91,6 @@
 		};
 	};
 
-	reg_vcc5v0: vcc5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>; /* PH23 */
-		enable-active-high;
-	};
-
 	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
@@ -347,7 +338,5 @@
 };
 
 &usbphy {
-	usb1_vbus-supply = <&reg_vcc5v0>;
-	usb2_vbus-supply = <&reg_vcc5v0>;
 	status = "okay";
 };

