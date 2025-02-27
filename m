Return-Path: <linux-kernel+bounces-537258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13CA489BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3838A188D647
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BDC26FDBA;
	Thu, 27 Feb 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nZA+BH0N"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD31D6182;
	Thu, 27 Feb 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687756; cv=none; b=L5TNbHh6LlY3YntIAEIoUAJHzhnGHzIG5J0TRQB0FFTg7zu1GqamLJZ0zYC4j3rnfgSTPLYfc7OaLPxYccaoD3a9S98DWa41sJZNEGuke4qDLGYmK3kncqbl8KSXd8S7Aqwm4ClSnGqNzaM+pK0XJF02mvGdaxxCcXfECXo4e/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687756; c=relaxed/simple;
	bh=vZKe8XL3SJUR5/IT3a1P9C+8yE7Z6Poz6JhpmGWxwvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2LfFQnJTQ55xVlycAzdB7ao/ASmYX7IvAtH9bPcjq2pnrgFJjISs+h+G0v8v0ACwNeHczFAJKaxy5ZAFMlvvoojX5PXS57gVoo0MfatoUPQlP3wSqcaIG3+P9X5nqY41ApALRG0kRBQzRfixWufW4rsVX2KHxeofhnaSQcrfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nZA+BH0N; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RKMBZl1958092
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 27 Feb 2025 14:22:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740687731;
	bh=qm8viJmjCBIQd1M3iyAkiGKfp0856O80COABjqNXgMk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nZA+BH0NP3VBnFYjJyPdBaqaUSAYzurvCqxjOBZ0wg3NET9QYYPic914P5et9dU14
	 Y90d7ziDLpqdfCU0Hb/piJARDzX1XSE5fbVxik2qeDYYfFAVXBFMuX/vkWCTv2+3od
	 H30wm8klQnzVLSGlib5pnvhFLW24IBxvJXT2i9aI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RKMBWV125054;
	Thu, 27 Feb 2025 14:22:11 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 14:22:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 14:22:11 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RKMAIN066405;
	Thu, 27 Feb 2025 14:22:11 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <c-vankar@ti.com>
Subject: [RFC PATCH 1/2] devicetree: bindings: mux: reg-mux: Update bindings for reg-mux for new property
Date: Fri, 28 Feb 2025 01:52:05 +0530
Message-ID: <20250227202206.2551305-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227202206.2551305-1-c-vankar@ti.com>
References: <20250227202206.2551305-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

DT-binding of reg-mux is defined in such a way that one need to provide
register offset and mask in a "mux-reg-masks" property and corresponding
register value in "idle-states" property. This constraint forces to define
these values in such a way that "mux-reg-masks" and "idle-states" must be
in sync with each other. This implementation would be more complex if
specific register or set of registers need to be configured which has
large memory space. Introduce a new property "mux-reg-masks-state" which
allow to specify offset, mask and value as a tuple in a single property.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 .../devicetree/bindings/mux/reg-mux.yaml      | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
index dc4be092fc2f..a73c5efcf860 100644
--- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
@@ -32,11 +32,36 @@ properties:
         - description: pre-shifted bitfield mask
     description: Each entry pair describes a single mux control.
 
-  idle-states: true
+  idle-states:
+    description: Each entry describes mux register state.
+
+  mux-reg-masks-state:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: register offset
+        - description: pre-shifted bitfield mask
+        - description: register value to be set
+    description: This property is an extension of mux-reg-masks which
+                 allows specifying register offset, mask and register
+                 value to be set in a single property.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - reg-mux
+              - mmio-mux
+    then:
+      properties:
+        mux-reg-masks: true
+        mux-reg-masks-state: true
+      maxItems: 1
 
 required:
   - compatible
-  - mux-reg-masks
   - '#mux-control-cells'
 
 additionalProperties: false
-- 
2.34.1


