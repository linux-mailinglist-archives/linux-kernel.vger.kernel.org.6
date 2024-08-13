Return-Path: <linux-kernel+bounces-284144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482994FD89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8EE1C22808
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9653A1A0;
	Tue, 13 Aug 2024 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="EuPhEBsf"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AE36B11
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529107; cv=none; b=fLG38its2eKWLB2n8q32qXwcOB3B/v54So+Ke7F2dZBNeIvrfChhBXx9jidWQ9Yf45WvJ4u09ezcdku/fUoR2jf3x87PBpcc666KRnh+llKnOu3k1zs7rNYQ4+TCNT4eZF9ykU3zCTvgxVcHHWlz13kNrKmZNCKnWwWLkRjZ4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529107; c=relaxed/simple;
	bh=EyCKSez3LbFuR+m2ozHngTTkoAokq4OOqdOZvp9c6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bc+ZCIVKPGgRL1eiooQmv2iyV2ErwKyBcxr2qhVQU04+4Ks43i8zLg6qnLsZRdS8Nc7gbYwjB80vwgb0/8GfiWc0Ul3EkjNlpEScI31xtyHBBfkrl6QvlZ5E/++M3VsOjrq8aeBAM2H/TPupSutRMuVRCj9+QBcAEswYRpu+rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=EuPhEBsf; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202408130605023910af7e817cdc2b02
        for <linux-kernel@vger.kernel.org>;
        Tue, 13 Aug 2024 08:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hZYakEfcZ+N1KAVTTOd/kQD4JofxMtxQELqh4JnQ7ho=;
 b=EuPhEBsfRgw5TI6JVKL1Z+6Z/cJEsjDjOr+V+tyWhmwa051CMRmWe6vESrQ7G+CoKg8jFi
 TsiTQ7DT3LpMzNILuvY6EY65gVOyWGa8TLFXjmSLwcig8bOTTnFG2+0CevNUrN4cEQTlVztN
 VbzHK55A6COv3gffDSfknqmqAVPjKiWk2vzMg/vfxp7if88/wECxzCLOJ9R4qZrkuM1pKaK+
 AtQq7hmCPUV/6kPlZA1dgHTua24JNA0egn0jiGXzIXR4OGuy5klgU6N6ZMfuxInVUkv2ydJO
 bRsTAokiQlH1eFjd2xpDuVzcAasVSAQ0bx4+2ABspAwC3h1rQQRoCk0Q==;
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
Subject: [PATCH v3 2/3] dt-bindings: soc: ti: am645-system-controller: add child nodes used by main domain
Date: Tue, 13 Aug 2024 08:04:59 +0200
Message-ID: <ac1622c04e5ae2bb80075e70dbde23abc2f3a4b5.1723529100.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723529100.git.jan.kiszka@siemens.com>
References: <cover.1723529100.git.jan.kiszka@siemens.com>
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
 .../soc/ti/ti,am654-system-controller.yaml    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
index e79803e586ca..5a689ec3c5c9 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
@@ -29,11 +29,36 @@ properties:
 
   ranges: true
 
+  mux-controller:
+    type: object
+    ref: /schemas/mux/reg-mux.yaml#
+    description:
+      This is the SERDES lane control mux.
+
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
     $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
 
+  "^clock@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
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


