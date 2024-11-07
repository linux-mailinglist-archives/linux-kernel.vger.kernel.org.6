Return-Path: <linux-kernel+bounces-399554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA99C00A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A80E1C20FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463B1DF258;
	Thu,  7 Nov 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZrhR2YFi"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C91DE3B7;
	Thu,  7 Nov 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969865; cv=none; b=jESq/l4RdG5kiWXA2WqfXZiI4fNlW6AZiUmKJv5jMVjSGEU0aUOZsyHAODdpQs9Zhi0+I5aNeEaUqPrQrr08MoXS4t1UONAl07ZFfO+MDtIDnmKTwJ77dXpmWAs/K3QofWYmHlwZZSP8KAiPzKlnSZvjZcQ93NbnJvNG5E2I2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969865; c=relaxed/simple;
	bh=5Y2bIJcXUVeRq/52yqMTXRgAjwKnGM1KYGlk8qkGwzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g9Iryy0MlptYsu2mHl3FZTGPmoU74bRqv/FZimkL6/bgd1dDMgfEsWwwKaadX726/9+vPtIcCZQ1l4cuvJ/+/j/5Zs2KaUV0kE41m5tSnL5ZYVjLf2p8oN3G+IGemfZbCswLTAEzy9+rOU36/7pQkifJGiaXRAPOMmfLkVferx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZrhR2YFi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 32480891FD;
	Thu,  7 Nov 2024 09:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730969861;
	bh=Juwn84S5vUX2aH6VsMCIM7pJOc3sVKVbXwLzJq3+1Jw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZrhR2YFiEJSDeBRViCLCwwv1sJXOY5/PxxKtfkmDpYRzjSvJ3eD0Qa4qprD8iQL0l
	 pXeIEbpBGEL9otKCUwP7JWKDD+ARP/I8NhmAfEg2HbfmZ5UNdhY9ru5TidVLzqXbMj
	 A0wrsfk6WfA0HYpJYSXxSJM5Bo1zAX7Sv23x3dc+3K6fSuwCV3gMmGFvNjAwNioF/L
	 RMsghUxgakjOvRqqyBlTd38hxkcpWDNSwpclWRZqUlYPsLbrnXOfT/7X5uCLlH/QM+
	 WzAid5hldGQDCNnMn+fryDoJQWqEPgbnYhvY80xkjaBXSWAtggPFqXZ+/CEZ2zhla1
	 KMGuP4MN/+zYA==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v11 1/3] dt-bindings: display: Add powertip,{st7272|hx8238a} as DT Schema description
Date: Thu,  7 Nov 2024 09:57:03 +0100
Message-Id: <20241107085705.490940-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch provides the DT Schema description of:
- powertip,st7272  320 x 240 LCD display
- powertip,hx8238a 320 x 240 LCD display

Used with the different HW revisions of btt3 devices.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes for v9:
- New patch

Changes for v10:
- None

Changes for v11:
- Combine both separate dt-bindings patches for powertip,st7272 and
  powertip,hx8238a into one
- Drop the quotes for in "title" entry of powertip*.yaml files
---
 .../display/panel/powertip,hx8238a.yaml       | 29 +++++++++++++++++++
 .../display/panel/powertip,st7272.yaml        | 29 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml b/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
new file mode 100644
index 000000000000..b7d74faeb5d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/powertip,hx8238a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Powertip Electronic Technology Co. 320 x 240 LCD panel
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+allOf:
+  - $ref: panel-dpi.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: powertip,hx8238a
+      - {} # panel-dpi, but not listed here to avoid false select
+
+  height-mm: true
+  panel-timing: true
+  port: true
+  power-supply: true
+  width-mm: true
+
+additionalProperties: false
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
new file mode 100644
index 000000000000..f3622800f13f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/powertip,st7272.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Powertip Electronic Technology Co. 320 x 240 LCD panel
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+allOf:
+  - $ref: panel-dpi.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: powertip,st7272
+      - {} # panel-dpi, but not listed here to avoid false select
+
+  height-mm: true
+  panel-timing: true
+  port: true
+  power-supply: true
+  width-mm: true
+
+additionalProperties: false
+
+...
-- 
2.39.5


