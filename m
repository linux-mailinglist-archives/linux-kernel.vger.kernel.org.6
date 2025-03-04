Return-Path: <linux-kernel+bounces-543818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64ADA4DA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5083AECFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46B1FE44C;
	Tue,  4 Mar 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pMz6roM/"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DB1FECBA;
	Tue,  4 Mar 2025 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083801; cv=none; b=KRLd5nwqf2x8p+e7W+K7FvC2szOfqSRWxQd30RABGtvXoAc+1JYmp30/nl1RT4aTSXctC1+QA+8mPBrTU4Clg/3AC15xyIP9swgYs51NJbDYYWl5n1x6ziJe9xmHAdxmanePLg2bNmdaXwEaJwHrCSIJEceapzHoWiCm/BzEUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083801; c=relaxed/simple;
	bh=PxSXHz3lpuMQTovHxgzpLW7oclyaT77hfGzT3uAd88s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjzz/pVrdUqn/WmCsSrzw+gfbj133lOeYlhdUoK5vOY6sNIn28BhF3IZf1f0YQmYrxDf/djjIdY9zZpdM+WDu3LY5Q9cq1gzcV1Dpb/0GLcwuSmaNwD63cCChvdUR4LqTInaLAw8ECilpkSx3gI3mnXNan6mUhn/vZQxSOtfxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pMz6roM/; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524ANBHr3620567
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 04:23:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741083791;
	bh=t8w9NsJ6B7JwHvl7/jsLYPToyhpWTMcif2X3wj+SSs8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pMz6roM/V4iSBkrgznzSIvWKqyB0FeMIEllea6XK8qxhRQOdDsFUCb0gBZZVa1MZa
	 5l1jM8w+MgY3gsG/jQRUjcG9eFFiblGl8s8/HBs/eFUJM2lO6Pnx/x7djresFkHv01
	 Q7Iexg4W2iFcWj48j/rwOYe7gDOyJ9ptGlPJYr+k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524ANBMr092601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 04:23:11 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 04:23:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 04:23:11 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524ANAVD061957;
	Tue, 4 Mar 2025 04:23:10 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Chintan Vankar
	<c-vankar@ti.com>
Subject: [RFC PATCH v2 1/2] devicetree: bindings: mux: reg-mux: Update bindings for reg-mux for new property
Date: Tue, 4 Mar 2025 15:53:05 +0530
Message-ID: <20250304102306.2977836-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304102306.2977836-1-c-vankar@ti.com>
References: <20250304102306.2977836-1-c-vankar@ti.com>
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

Link to v1:
https://lore.kernel.org/r/20250227202206.2551305-2-c-vankar@ti.com/

Changes from v1 to v2:
- Updated dt-bindings for the required conditions as suggested by Conor
  Dooley and Andrew Davis.

 .../devicetree/bindings/mux/reg-mux.yaml      | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
index dc4be092fc2f..5255e4a06920 100644
--- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
@@ -32,12 +32,30 @@ properties:
         - description: pre-shifted bitfield mask
     description: Each entry pair describes a single mux control.
 
-  idle-states: true
+  idle-states:
+    description: Each entry describes mux register state.
 
-required:
-  - compatible
-  - mux-reg-masks
-  - '#mux-control-cells'
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
+  - not:
+      required: [mux-reg-masks, mux-reg-masks-state]
+
+  - if:
+      required:
+        - mux-reg-masks-state
+    then:
+      properties:
+        idle-states: false
 
 additionalProperties: false
 
-- 
2.34.1


