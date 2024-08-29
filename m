Return-Path: <linux-kernel+bounces-306579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C799640BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF20C1C244AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901D1662E8;
	Thu, 29 Aug 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sl7sOKrx"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AA18A924;
	Thu, 29 Aug 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925500; cv=none; b=H6jBDOSXlDcjVLZDjXba8V7YHF5nBq+MdvIO6HKNYXuTbeDyTOahrS/ycwYptU5YEEW+rTMEB28lsf2VKsYHj+KJv3g+Ncs4X+1RKYH14RPbDEhT8+ZsshgLkYGrdwxuetZ97ePpbogjFqNUuUirLJqVZGm/5xMK/qpx/KSgrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925500; c=relaxed/simple;
	bh=bn/1npRFBg5AELqurqShxB2OhHBkGEdDaslJlXXx3bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Rknj4LrumUx/k4P3KghX2bQg+LxfiDR6kp+XysbtInR1xEjoaW94Rmql9BHFinzelVuPN/6otsyl8b+7bTwIhcxQkKP/+3D88o9iPs5KLhAor8/3Z16i0jmTOVNBWeiS+LN8l7dngizwns++z3LxBYOcD4WEIJFYk3QWZnXyd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sl7sOKrx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724925499; x=1756461499;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=bn/1npRFBg5AELqurqShxB2OhHBkGEdDaslJlXXx3bY=;
  b=sl7sOKrxi/0zJy2mXCd7fIkBemFdZTE0ogsYaLvJ0CpeJNyGeHaH+BB+
   Kz6g1p5NAzr4YzGczIbenZy4hLWldVILbfDO7yqU8JX3x7Ci9bWBBbDXL
   ujlsyTuqQI/o1Ph/naMY4BsBxHOYMtbpinL6HOr34Tt535EttyZvKJdQZ
   gx3s5We7FeIpCF42KC4tXUiTWA+9LoZScGmgKAt80CBQLb3B5juy8HuU4
   2A67WatbURWqUI+o18WoYEhkTiCStOrJ7NfrgquzF8nKQdimbOXnPPWul
   B0R1GbJfSzhlD7KjB3GUSppWJeOJSx1JNGQChQbNGM8iQUtF5JovRCUxP
   w==;
X-CSE-ConnectionGUID: LGQAnO1RRT+/Lnt5/9YMoA==
X-CSE-MsgGUID: aoePMEnFTu2IvL/NpySfKA==
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="261987739"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 02:58:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 02:57:48 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Aug 2024 02:57:45 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Thu, 29 Aug 2024 15:27:42 +0530
Subject: [PATCH] dt-bindings: ARM: at91: Document Microchip SAMA7D65
 Curiosity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com>
X-B4-Tracking: v=1; b=H4sIABVG0GYC/x3MPQqAMAxA4atIZgM2/lWvIg6ljZrBVloRQby7x
 fEb3nsgcRROMBYPRL4kSfAZqizAbsavjOKygSpqKk0DJrOb3nUt2hAZ3YlK6abWNVnqNeTsiLz
 I/S+n+X0/tHjQ8WIAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Romain Sioen <romain.sioen@microchip.com>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724925464; l=1301;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=Y3EQm+KUhP0XyCykxR4HD0M+o/JUx0lh1Web0rsxU2E=;
 b=TwgzPVKu4LClgwK6phKDXIawIz8ZSYETLbHGRlU25kSK/5AwX4WjnVpoebHvNLjJTFs3vJFPX
 wKcYvBITYs5DzBg6YeeKbF3EqWP1cIGIbKzTyblWhM6ZVHkk1DPOy2Q
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

From: Romain Sioen <romain.sioen@microchip.com>

Document device tree binding of the Microchip SAMA7D65 Curiosity board.

Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 82f37328cc69..8e897680d43a 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -174,6 +174,13 @@ properties:
           - const: atmel,sama5d4
           - const: atmel,sama5
 
+      - description: Microchip SAMA7D65 Curiosity Board
+        items:
+          - const: microchip,sama7d65-curiosity
+          - const: microchip,sama7d65
+          - const: microchip,sama7d6
+          - const: microchip,sama7
+
       - items:
           - const: microchip,sama7g5ek # SAMA7G5 Evaluation Kit
           - const: microchip,sama7g5

---
base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
change-id: 20240829-sama7d65-core-dt-11843832c278

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


