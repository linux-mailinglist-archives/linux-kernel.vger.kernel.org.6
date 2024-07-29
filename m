Return-Path: <linux-kernel+bounces-265226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E493EE22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9204B20E87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6413C8EA;
	Mon, 29 Jul 2024 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RcMBO6s0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A62131E4B;
	Mon, 29 Jul 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236964; cv=none; b=N7g1hZbIIYFwcE31P3H9SORRcXJZWJSqo7JZE67ycUVKj2I3Ju79uXwBVAZfs26NaaRVGHMIc72TSrDC7Cf0THcnr6Z0eNAFoHSkETiRWIQ0uLgDN3dxOpyJFrwOLktUNiFwRX4eJkOS6J0mRiNkGUPUFAMX7gaBJv5Lx/EBQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236964; c=relaxed/simple;
	bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiDlUwA2R7Ncn9s25Clc46KHYf7mAjeR1ONBiC+6s3Bw22+nnfuNIk8ZKqwmiu/v+uBb9zOGu7ydKXf3VY3t6ukr1oiGNdpLm5xvN4mb8YEefrPs3ohNcXk3Rf7RLQ5t+t9Sdn/ZiLqqISeZEbRlU4Ln8qqK3iPA5DWPqnFxvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RcMBO6s0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236962; x=1753772962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
  b=RcMBO6s05pZFtT1xeLNpoEIV+hjGgHjLdjjLhJoXoWgqv5F+neXaNXZB
   vVckgoZ9cXgR14acCO0uvRgnPcG3pJ7oQNA1MHpQKVYDNeYQyutTAR+9K
   vkXMhxud5HtYRJrxAmY4x3CyFPsTyyMwiXSVLvmulXDGFWoHuNS35vwIY
   duflzEL1HCuraFT5WCb//EuGGlCTnwS4A3thLX+dp3Twlr1vQHftTYbu1
   qJFcc3rCG4B4+DKfRcvaFumc2rMdOgZDx3JZaatdeknKVYcU2BNR7DJ3P
   yWYPQ1FEkiJXxnSKOl+AOotQu4pG9xxazDN6Z6Kgv/F3Mkdr8c0413I14
   w==;
X-CSE-ConnectionGUID: o1mEAA2WRF+mZwSZKkI/oQ==
X-CSE-MsgGUID: M625Avi5Q2iy2PWsO2pPNQ==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="197214000"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:09:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:09:07 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:09:02 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <p.zabel@pengutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 21/27] dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
Date: Mon, 29 Jul 2024 12:39:00 +0530
Message-ID: <20240729070900.1991270-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add documentation for SAM9X7 reset controller.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/reset/atmel,at91sam9260-reset.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 98465d26949e..c3b33bbc7319 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -26,6 +26,10 @@ properties:
       - items:
           - const: atmel,sama5d3-rstc
           - const: atmel,at91sam9g45-rstc
+      - items:
+          - enum:
+              - microchip,sam9x7-rstc
+          - const: microchip,sam9x60-rstc
 
   reg:
     minItems: 1
-- 
2.25.1


