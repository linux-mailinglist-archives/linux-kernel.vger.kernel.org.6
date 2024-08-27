Return-Path: <linux-kernel+bounces-303875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA6961665
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BE1B21608
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216D1D2F52;
	Tue, 27 Aug 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="b8atZ+SR"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465091D2786;
	Tue, 27 Aug 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781948; cv=none; b=IGlaPTGeLeyBA6xE/gkwpda1wWDpSx+2e+uOZNlZkJPXJfTiW1nnVYG57Uhj+JTKj5EeG8p7ueIAUe8I3tA6zkNvVxvqeVbZcyD7vHqNBepT+or646dN1G4TDKEbc3NP+oQcDZet+BoiMzPl8HuXGjMGYEXFndH/aRvgjYkmhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781948; c=relaxed/simple;
	bh=Gw79yOjbZv9gbtsmtzI8ONCwsue7qo7vUany0vBy9CA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttMII6SxWgbckrQdwKVMmpztJG2Q7fgKTQ3YYxuyTBdwHnNuxoooQ+QsC7f6gR1e54JEAsnchNa7TQ1lB9r4Cqs5pys07IhPz6Eze0DvpnDnp1CfUkysZGVOmGFd4iNjbGT3xSCtXr7FZkMLA1fvrhEchAHJgS9xbb1mb46uXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=b8atZ+SR; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id EBE2E88A4B;
	Tue, 27 Aug 2024 20:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724781944;
	bh=1fH1ehWxhmFHL+pwCnGMKQmfjMRvcUVp0cPiBxZjs50=;
	h=From:To:Cc:Subject:Date:From;
	b=b8atZ+SRNppskEgkPf+Mjub7Jnem6+xHUTcCsmeVEWybyqzNmtHHhF4VcEdfSzdSX
	 XvqW+xpmAFbywPGjgBlC7I/QuVYd/gJoPR5hbLqivbw/mYLS/Qj+uakN2PQUW5P61T
	 p6atH7yVcy6jqAqNysj0UWJDsl1e6h3dIP66zKPowzQZ8VtNTccPij0Ualz4SMb0rP
	 V9dklJ+nomYFzjNM21FVnPb5y/HNL2VM1+FYbqgJrVUBPibCA+i1g4/FuOagfQ8diK
	 4IPWz088olkLME+6bWOB2Sa85GwcQPzUkXjIniXE22YG/K3vnOlprQmy3BT0xRA7WM
	 Xy9VsUXBF/tew==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ASoC: dt-bindings: Add dt bindings definition file for imx28 saif
Date: Tue, 27 Aug 2024 20:05:28 +0200
Message-Id: <20240827180528.2315563-1-lukma@denx.de>
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

This file allows correct check of DTS node for imx287 based
"fsl,imx28-saif" compatible device.

It corresponds to Documentation/devicetree/bindings/fsl,imx28-saif

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 .../devicetree/bindings/sound/fsl,saif.yaml   | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,saif.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,saif.yaml b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
new file mode 100644
index 000000000000..747faa411a50
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,saif.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,saif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS Serial Audio Interface (SAIF)
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+description: |
+  The SAIF is based on I2S module that is used to communicate with audio codecs,
+  but only with half-duplex manner (i.e. it can either transmit or receive PCM
+  audio).
+
+properties:
+  compatible:
+    const: fsl,imx28-saif
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
+  clocks:
+    maxItems: 1
+
+  fsl,saif-master:
+    description: Indicate that saif is a slave and its phandle points to master
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+  - "#sound-dai-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    saif0: saif@80042000 {
+        #sound-dai-cells = <0>;
+        compatible = "fsl,imx28-saif";
+        reg = <0x80042000 2000>;
+        interrupts = <59>;
+        clocks = <&clks 53>;
+        dmas = <&dma_apbx 4>;
+        dma-names = "rx-tx";
+    };
+  - |
+    saif1: saif@80046000 {
+        #sound-dai-cells = <0>;
+        compatible = "fsl,imx28-saif";
+        reg = <0x80046000 2000>;
+        interrupts = <58>;
+        clocks = <&clks 53>;
+        dmas = <&dma_apbx 5>;
+        dma-names = "rx-tx";
+        fsl,saif-master = <&saif0>;
+    };
-- 
2.39.2


