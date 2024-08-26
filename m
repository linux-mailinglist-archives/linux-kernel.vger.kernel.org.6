Return-Path: <linux-kernel+bounces-302010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADCB95F894
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C8028435A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786B1993B5;
	Mon, 26 Aug 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="BwVym2FK"
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711B1990D8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694981; cv=none; b=V6h6xGRdUGGik3LR+zUfIGC2B/PJrWKAkmQXs7FXOpXn8aO9CNs4cWuOaqEfMwFNSYamUQJvJ7CJCvizTXNBR3mmxYbNK0PuSgk1LrWZf+1cSgl2OqXUsxkAl1grTxvh5TqQKSI0LanlfX9MRrPoaGCqTfitCnkeJtE8A5qJIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694981; c=relaxed/simple;
	bh=yf12HVZ4t+7Uq8YBI9Q7lRshq/fOZheo3fufzqPXT78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7pPWBAjmueagAL68ezFonz4SvMTuWCiapPeHi+0U8Lc+XNxKVNCqgHBsDPsAk0c5YkkscYW/zmzUZqO/XtFPRDBS7wjPMyBk0bXIBTOT/2tlH/l5NccIn9M63ejOK6FYz8ZKpF5TKl79oYQqqdF9m6B09AM1AYnXdEYOREF1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=BwVym2FK; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240826175611a5feede63dde98fc36
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Aug 2024 19:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=K3qKt60IA+8SMUnwHI81gxuyfVTw/GaObbKMY0sD6g8=;
 b=BwVym2FKf4NoJWXhih/m0Sd3L3Ikr+o+yfSWKoWnX/ONFGSxaRKHkyIJTTAaxcrD+tAdCE
 yv+tzWGCBXqBVppbG21kxwzXblJ9dOfDMJItcil1KdNQ8DcNFbiIi8RTc8nTHJx8rv317I8C
 x7scrumhMEqsWPGpGTz1KwEG40HKe2d0wVM92wLjgjUwX4o7+Df9Fuu1T3Lo4lxreqkuYQMB
 gzRXWbBgCNS4rPhZWARRyVYwfAotziKOj7fSEsW6FnECGo+B0VeFLukLWGvcTIl7tvA4o1tv
 XdJRijY8NBFh2f3scuIcG8q+CiDkvcJIkLVFttQge97ulEp/Gqq7Qn4w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH 1/5] dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
Date: Mon, 26 Aug 2024 19:56:05 +0200
Message-ID: <f8e45e550687464e51697d96e345bbfe69b6044a.1724694969.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724694969.git.jan.kiszka@siemens.com>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
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

The PVU allows to define a limited set of mappings for incoming DMA
requests to the system memory. It is not a real IOMMU, thus hooked up
under the TI SoC bindings.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../bindings/soc/ti/ti,am654-pvu.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
new file mode 100644
index 000000000000..3095db0bef44
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) Siemens AG, 2024
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/ti,am654-pvu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM654 Peripheral Virtualization Unit
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-pvu
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: tlbif
+
+  interrupts:
+    items:
+      - description: fault interrupt
+
+  interrupt-names:
+    items:
+      - const: pvu
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    ti-pvu@30f80000 {
+        compatible = "ti,am654-pvu";
+        reg = <0 0x30f80000 0 0x1000>,
+              <0 0x36000000 0 0x100000>;
+        reg-names = "cfg", "tlbif";
+        interrupts-extended = <&intr_main_navss 390>;
+        interrupt-names = "pvu";
+    };
-- 
2.43.0


