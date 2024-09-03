Return-Path: <linux-kernel+bounces-312240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBEF9693F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930B91F24370
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC93C1D618E;
	Tue,  3 Sep 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sGTlwTNA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EB1D54C6;
	Tue,  3 Sep 2024 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345770; cv=none; b=q1r5pAsf9HTu78i9QQwABi2MEnh1mQEuo0/0FxveyuLUfe4dhgGn2M6Lkv83+wXxgkFi7JbNZODfmHpHMKQxnyP9bqJuwJSu6Uv9Hf2iBVM9E/q1Il3CZhtTDiHh/SbiOKxV3g8rDMmbkZRLsW5eLLy0/tYMAP1YovJ0cbazusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345770; c=relaxed/simple;
	bh=1VQXaqXdgqyQ5EmTPgLBYwyXYe+q+1C8SSYLlJq+imQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0+I8fTDk023sdLPJTswPMoy8SH1qWvFcqAQ2oq41b+UhNLz+ceWwbCCIsURj6G5YvXInCD+OKqO7IsBNBKgm/nAp4ypMSQNk3Eut5mTrv7xEsOVwocRFRo8xgrcCbLP0TEoH17w8rz9jOdFSvLe70pXaC9EBYCcPBMmDA0YsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sGTlwTNA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345768; x=1756881768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1VQXaqXdgqyQ5EmTPgLBYwyXYe+q+1C8SSYLlJq+imQ=;
  b=sGTlwTNAXZcI1pFFGQLR0oDjZHPPlxWWoq4A922Jm3aimArrl9MeJKyD
   FZFwmhq9B8pd/HGxsWgFQ0GEGdbF0MVB1Qa1jYgxE5oTzITfMODdZ2DmU
   hCBtGmKBzT/7sRluyxuio7dN3Eh2P6GtJAp1jtxBbQMBBrAjpc2JtUPu/
   LWASUSJfhANxoyTMYnjCXEBneaDIRVxvVFcY/kPAO7Zs9RW3ptfik/bw0
   cEkoji4nV8IV/y6raDn+R3JpRX+b5SLgXtHjtqfQsR4u/hI4uHFq4uFrd
   EKvEHJ+4ZCCpzxW5MELUFUN59zIOyIHM4J5J/K2YhzfrIhbT7ya1OXeEh
   g==;
X-CSE-ConnectionGUID: q+Zs7HZmS1O4vWTV7SMIVA==
X-CSE-MsgGUID: xgiV5pA/QhSBElE711G20g==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31150000"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:42:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:42:36 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:42:33 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <conor@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v7 02/12] dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x7 compatible
Date: Tue, 3 Sep 2024 12:12:33 +0530
Message-ID: <20240903064233.49366-1-varshini.rajendran@microchip.com>
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

Add support for sam9x7 device compatible with sama5d2 compatible as the
fallback as the sam9x7 SoC uses the same tcb IP as the latter.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v7:

- Elaborated the commit message with justifications to the fallback.
---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index a46411149571..2c7275c4503b 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -15,13 +15,19 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - atmel,at91rm9200-tcb
-          - atmel,at91sam9x5-tcb
-          - atmel,sama5d2-tcb
-      - const: simple-mfd
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - atmel,at91rm9200-tcb
+              - atmel,at91sam9x5-tcb
+              - atmel,sama5d2-tcb
+          - const: simple-mfd
+          - const: syscon
+      - items:
+          - const: microchip,sam9x7-tcb
+          - const: atmel,sama5d2-tcb
+          - const: simple-mfd
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.25.1


