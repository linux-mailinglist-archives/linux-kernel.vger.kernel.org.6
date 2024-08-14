Return-Path: <linux-kernel+bounces-286901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B6F952029
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32412285C62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F51BBBDB;
	Wed, 14 Aug 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="CDWrCbB7"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFC1B9B38
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653453; cv=none; b=cJLxpJItNSptoLc+hiqONH699dfo1Y1qd/UomKs9xINGGaSwAPdff6CDpZuoGohgUzJPV1pP4JRqRFvZ6pUYQYaJagjXwgpZ3wD/bg/NWNgGZ+oOICXVFQdFdNe2EtOvbq9Hc2SGnmCAzBhg2gk00etlnaimrb1EBTs8LiCXP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653453; c=relaxed/simple;
	bh=sKghzG0RX+rgDeN0hOcvIlG/KV7gZFIviIsTSldbKQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uey/C/q5ayB5QgFob+bU6upKbxYn4ELr1BULjfdmivNc2wOreyVxtJd6/MaMcgVnDnHgW2tEQ7IHBiASCQtloKNE5/QEwl7GSn0EqYHJJ+JHWW6/9EkHZxZ4BT48YfhpiiV0Iz6IaHhtgRrA5KmDG0NGhRhBQPUlRdIBB4tWU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=CDWrCbB7; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024081416372150c62f89e94ba56558
        for <linux-kernel@vger.kernel.org>;
        Wed, 14 Aug 2024 18:37:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LVA0GFSxNECADZufp0g0Bta+YJBr8N9H6B10ZsamqQI=;
 b=CDWrCbB7x/M5Dmx3qa6y5UKGwcljEIvi75nf3ZRnJP7u7kCB/FUlTt+SWsSCoKVIhAQMbd
 5ymcAj6r7kwnVTDE5IliKzlacGysxOSg50Ze0Fj+Az9HxPOeDB9UQ/rE9uw4qJOa+Wrie0nv
 2jn63tRyWzjLL2hUUYzY/2886J+uGqEsy5IaDzFbVCFvUA0RmjRNL6dDVI98Iz+GXQvEn4+h
 /mD+8i2l5iMX9B541ZrJCFRpZwry7GryrQrpYoboagRg3+4Cy2s0L6e1e/XOKXpome587UEl
 Coy8uXHylr2P/dx11kHQaywkHYQ2Ucd4wenwOtnXmP0B4f4nd+peYWjg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller: add child nodes used by main domain
Date: Wed, 14 Aug 2024 18:37:18 +0200
Message-ID: <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723653439.git.jan.kiszka@siemens.com>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Expand bindings to cover both the MCU and the main usage of the AM654
system controller.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../soc/ti/ti,am654-system-controller.yaml    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
index e79803e586ca..cb9da3ec39a8 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
@@ -29,11 +29,30 @@ properties:
 
   ranges: true
 
+  dss-oldi-io-ctrl@41e0:
+    type: object
+    $ref: /schemas/mfd/syscon.yaml#
+    properties:
+      compatible:
+        items:
+          - const: ti,am654-dss-oldi-io-ctrl
+          - const: syscon
+
+  clock-controller@4140:
+    type: object
+    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
+    description:
+      Clock provider for TI EHRPWM nodes.
+
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
     $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
 
+  "^clock@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
+
 required:
   - compatible
   - reg
-- 
2.43.0


