Return-Path: <linux-kernel+bounces-239274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229E9258B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B0BB2AC67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EA4176ADB;
	Wed,  3 Jul 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yg6d5L+6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDB176AAF;
	Wed,  3 Jul 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002605; cv=none; b=hsTg5n5TjRs4xrmqwjzFJfjk2V3dasG5yedfEP4YKIqNp9Sw3mDVM/bDhl25afPBzABt2R0N/UkwE06jxAGFbMrd6QCLoO4vOrz5J6V6noSH5z3BJomaVpwVIPIDkhTTQgu/wbgestaJy4WIHPc0fKn5GneMP7US8Ze6ZhPawgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002605; c=relaxed/simple;
	bh=xbdNDU83RLdASHMfHIv+diZ3brJ2+ZBeOGZRr9HKbWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exCVJ/FtNXxCIZGjGzyi11wnVnupRxmQ09RmDVkwh12GUZ4FYMFmoxJ65Vw+QBocxlMjQi/sWAyz8Mq2O+q3pfl2mQkji3DHOWXco6NaKrh16PcHOhD3PcXRjpcd+qN+yPoJzFG2fVQ9YkOQZ+nKeesjkljpICcMTQsWCz7zgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yg6d5L+6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002604; x=1751538604;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xbdNDU83RLdASHMfHIv+diZ3brJ2+ZBeOGZRr9HKbWI=;
  b=Yg6d5L+6qHXJ1hdSpCpGVq70+8A6kQoUV3W3rHw8NeKRwF06tHaDm/yB
   58eSOMwoTerl8TBnoTkWGd0sZyMSzT8OSy+OI/SCGr+hFuNqhYt4Hv4gb
   GjaaIOfKG+IrlpTC1WNyyyhhamf+LS3vhS7ZaYeox8gny4AbMyNQ9jsr0
   LVuoAbnyee35o2MRqdToRZUZ5RsprHVpKB7eEPGITvSbYyjLItMk/6+8/
   msD/ccrtqt6Y9+aYnv0wK1/b6UuiUEHnISRdPcGt362iGjoQ46mt41t8G
   HS0pl5ERSHsLT+qwy6rCzq1DTrnHaxy2D/9ON41pS4tpzlqRze2dNZ3GT
   g==;
X-CSE-ConnectionGUID: WSWDYVd0Sief6o+XdEUAmQ==
X-CSE-MsgGUID: pxtzhN7kRv2+NnrgAfezkw==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="259682274"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:30:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:29:43 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:29:38 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mihai.sain@microchip.com>,
	<varshini.rajendran@microchip.com>, <andrei.simion@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 26/27] dt-bindings: arm: add sam9x75 curiosity board
Date: Wed, 3 Jul 2024 15:59:36 +0530
Message-ID: <20240703102936.196606-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add documentation for SAM9X75 Curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
- Updated Acked-by tag.
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 82f37328cc69..7160ec80ac1b 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -106,6 +106,12 @@ properties:
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
+      - description: Microchip SAM9X7 Evaluation Boards
+        items:
+          - const: microchip,sam9x75-curiosity
+          - const: microchip,sam9x7
+          - const: atmel,at91sam9
+
       - description: Nattis v2 board with Natte v2 power board
         items:
           - const: axentia,nattis-2
-- 
2.25.1


