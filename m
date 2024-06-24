Return-Path: <linux-kernel+bounces-226726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609829142BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15ADA1F22EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2902D627;
	Mon, 24 Jun 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="i7obmKSx"
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B828DCB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210671; cv=none; b=Qt4v61h48ZMjbS9oFFv45p3rRIIo9eTfnoIFjtfBdviVIcl334GSKRbGBXVgSkaKR5mTq0YM/kLETEfTxn/4exhymkNSxPNVr7GYBenHmLBYY3skZbN5tr868ELMmu4sKWDg4vyP+a5xQOKadJZSGi9mLQfPPUJacasH7WZXqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210671; c=relaxed/simple;
	bh=de7de+rT9nbBMSSSnfOCoLPHya/yDwE8bC/DvKjslAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltunD8BUzI3Y0vNZkWr3fFOwXw7FvLSx3rGDz8wwX2EN8DsxPVc9+N2bODuuDezkTbaBAfEWUmpGJW9Tfw8QwEeadfJq6fpNIzbxSZAx+IQ8cIKalJcBHkttsCu1OPHnS01FkKq55cey6ULOLIup0o41rT863w6cxHdOCArgH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=i7obmKSx; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240624062052e62a7d89208ad9efd0
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jun 2024 08:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KrnFVQqPX0XMmlsqlUHcoKE2zhOTIf+F9SOvzEJf3Xw=;
 b=i7obmKSxnvrrjen1ef+GZO0hmc31P4vU69rd8yt8kvvkqIY7d3W4ai0VorRv6F/QvZvIGD
 0efXOXjkCMwSnoppjMGJCN5ofHaNHPRO6lRcBDM12hzRa48DJSEntEFRG8BicOQbcfJEvZVP
 cwthpGE1yx9/GgupflfNmFQmAaqqg=;
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
Subject: [PATCH 3/4] dt-bindings: soc: ti: am645-system-controller: add child nodes used by main domain
Date: Mon, 24 Jun 2024 08:20:49 +0200
Message-ID: <52848094062ea55b0063e6fc37f27e6ed5035aa8.1719210050.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1719210050.git.jan.kiszka@siemens.com>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
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
 .../soc/ti/ti,am654-system-controller.yaml    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
index e79803e586ca..0eec807f38df 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
@@ -34,6 +34,35 @@ patternProperties:
     type: object
     $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
 
+  "^mux-controller$":
+    type: object
+    description:
+      This is the SERDES lane control mux.
+
+  "^clock@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/mfd/syscon.yaml#
+    properties:
+      compatible:
+        items:
+          - const: ti,am654-serdes-ctrl
+          - const: syscon
+
+  "^dss-oldi-io-ctrl@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/mfd/syscon.yaml#
+    properties:
+      compatible:
+        items:
+          - const: ti,am654-dss-oldi-io-ctrl
+          - const: syscon
+
+  "^clock-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
+    description:
+      Clock provider for TI EHRPWM nodes.
+
 required:
   - compatible
   - reg
-- 
2.43.0


