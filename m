Return-Path: <linux-kernel+bounces-172507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693378BF2D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7CC1C21E60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF313B595;
	Tue,  7 May 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="tV9RFvpe"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314813AD09;
	Tue,  7 May 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124010; cv=none; b=OQ2/9ujOid2chednbpelyEjuYckqjQzuxurt3lg+XBFlXVsd8V4Td0pC/A+31gI/5RESsSU18k5Ah92lP2OI+ctBqctZX0Lf48apcxyS/kf27CBb34srkvFmcfpQ3/QNqkF88mTpxUt1upWDUE+b919Mj5LFDSkXFOS2ymL48to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124010; c=relaxed/simple;
	bh=VXXp+vIcwUatnl8KxL30RNVCCUrO76jiXcAXDYXeP3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMvRJA+QzeofBYSQNYiiUuRGBuoOTFplHMVWyUFiTrIWmEJWycrgdgn1LUHRh+/T3lazVM7UkmwzwIt2/JBOApsieEQYJt/j+D9ZZThRE9+9BO+eK5ZD8KcAJe2S6kKcPFMBi3e/2w6kJiBOykaDWo/37/S53a+9sAh3jw8jl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=tV9RFvpe; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4B723100002;
	Wed,  8 May 2024 02:20:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4B723100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715124001;
	bh=Sg2NSSWydrUfExA0STQZrax0QRiPJJZL+IsAQDgDZr4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=tV9RFvpe0KVjONwN3XoOres7K8W9UQQTfKCWASu0JlFMdcvlf0DgHwmDGhjzPyRTN
	 0vaAj39KBLLY+XxH/MdG2vvPChxSQdHpzj6/G5iCSOtwBxfJdZdoaiOQBBnKwAAeQH
	 AUKROv7sOZj3RjNpO6qLOtghHznPWkQ73uQv5yY8nnGK4VucvclgZVJ0W1weia7csj
	 B1HR/OKB8/Ahk8gyvviRF/WqAEwOdyePTcASVlECT5SpwUOKXJGkax6FoB2JM/Ude8
	 3G1lh2yp1qwvonJDSM6LKRqIhNNpkmGMC8S1Tl4kzIC33x4u4Lal+MCRwP/hHNw5hE
	 o7pFgWJM30wUQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  8 May 2024 02:20:01 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 8 May 2024 02:20:00 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <oxffffaa@gmail.com>,
	<kernel@sberdevices.ru>, Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v6 1/3] dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
Date: Wed, 8 May 2024 02:09:01 +0300
Message-ID: <20240507230903.3399594-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240507230903.3399594-1-avkrasnov@salutedevices.com>
References: <20240507230903.3399594-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185123 [May 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/07 17:58:00 #25118681
X-KSMG-AntiVirus-Status: Clean, skipped

Boot ROM code on Meson requires that some pages on NAND must be written
in special mode: "short" ECC mode where each block is 384 bytes and
scrambling mode is on. Such pages are located on the chip in the
following way (for example):

[ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
  ^           ^           ^           ^

pX is page number "X". "^" means "special" page used by boot ROM - e.g.
every 2nd page in the range of [0, 7]. Step (2 in example is set by
'amlogic,boot-page-step' field. Last page in range (7 in example) is
set by 'amlogic,boot-pages' field.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 .../bindings/mtd/amlogic,meson-nand.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
index 57b6957c8415..284f0f882c32 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -64,11 +64,29 @@ patternProperties:
         items:
           maximum: 0
 
+      amlogic,boot-pages:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Number of pages starting from offset 0, where a special ECC
+          configuration must be used because it is accessed by the ROM
+          code. This ECC configuration uses 384 bytes data blocks.
+          Also scrambling mode is enabled for such pages.
+
+      amlogic,boot-page-step:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Interval between pages, accessed by the ROM code. For example
+          we have 8 pages [0, 7]. Pages 0,2,4,6 are accessed by the
+          ROM code, so this field will be 2 (e.g. every 2nd page). Rest
+          of pages - 1,3,5,7 are read/written without this mode.
+
     unevaluatedProperties: false
 
     dependencies:
       nand-ecc-strength: [nand-ecc-step-size]
       nand-ecc-step-size: [nand-ecc-strength]
+      amlogic,boot-pages: [nand-is-boot-medium, "amlogic,boot-page-step"]
+      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-pages"]
 
 
 required:
-- 
2.35.0


