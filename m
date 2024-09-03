Return-Path: <linux-kernel+bounces-312249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D600969402
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8FD285E1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE961D6C44;
	Tue,  3 Sep 2024 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ieZoPfna"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0A1D6790;
	Tue,  3 Sep 2024 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345856; cv=none; b=tH9IvIgeytuee9p4F2roh33NgcXI3jjmppcKnkZLuRc7HR6LUUVW/62Zyw6h+UHlw2xByqN4u8G464wt5dQQBtQzuK5BpXnJdQ4sNl9IlINYrVCDoptfITHcL3Ddr4FtCjfK0WdLCYNh2Q0+x4QXABx440S77PU2uNN0OlfHfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345856; c=relaxed/simple;
	bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ps3Em0A4KHUQxl/VNllxcsEwNRFufhNPpdNPeCS8pNmDV2s4Ix0fU4LzZnH1M/d/S6G/qi20xVJf7VpAy0vJkLUlmOmhj0FWqNBE4B2tRpntNdMGUjXxi+7LXIGWv0ATtvHbf93O25bXWuK2+wqJjUa+3yXHR3baN5MfzVa1dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ieZoPfna; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345854; x=1756881854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8i5Z2KfBYTZAJwGXyHoxcKMWI4cBoFSSa/Wp6ippfD0=;
  b=ieZoPfnanqyv4ZGKjSId9kBNnsd31u+PjafN/OLgWh0DKAzoGVNyaZlH
   6twNRTrAQh68xaIvx6CevV1CGCfMNizjaJUcQKTaZHc6BV1j3gfMvt+Sz
   ed+XC+lEenLpvTLEZVLF3aMKN7rwYiDg8wxBtD97E20lR7ZNWTrJzMJZY
   zqBAnFdvo9JyVgXR5CUyfV1i81OhDV/U78GrYew1xCm4h+k3eQbyJQCkF
   kXR9AtDE4tc3N012qT4LS1b9JfdpYo+WsYrgNo9V/0QeI/2xEhbkaUDxz
   Q3zClc5c4MO9ZO0JflvZujxT5w1CIF7lOwE/pJBtZyVKqNOGziUKmCYfO
   Q==;
X-CSE-ConnectionGUID: RQ/RpB+QRjexyFExAQsyWw==
X-CSE-MsgGUID: TwEtkzdtSVaZum2++WtYDQ==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31877401"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:44:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:43:36 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:43:32 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <p.zabel@pengutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 08/12] dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
Date: Tue, 3 Sep 2024 12:13:32 +0530
Message-ID: <20240903064332.49751-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
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


