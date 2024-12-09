Return-Path: <linux-kernel+bounces-437905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DAB9E9A51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61722829E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF73223C46;
	Mon,  9 Dec 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pB/LBxMj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D61C5CB8;
	Mon,  9 Dec 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757525; cv=none; b=fS1qSsMoqUlRml9+XvYwOi7RB6cRG9pvrZxql07pEeumRMB0AHZRs6J27/QUje+JccnqjJCv8Vig2vIY4LMNDVQ/k3MwiKqp8OrS6a6nMqaXH4MJwfiC7TT6iE1tAdpqBRwNp5kGbKUIhVxgyBSG5PYPbAIuvdPDfVVBAjzcEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757525; c=relaxed/simple;
	bh=lEJgCTz30ZkebZS5Flp4H/M53zfwCCmzWj2CKzKMjJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaswWc5OJT2zcKWcRNAJv8czZe9jjjtjJTRiU4ElQna0Sy9Yo3pEY3pQU2QC4RALn7guDv0vhzR6r3OLq/i0jyJcoGuizF2bfmUhE350+Jv/3s++rr8WnifKmKW/9g23YhN6CwQxZIdDzXiV76bqMEPdYSqklvdPerfF4G5Y72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pB/LBxMj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5304B1C0004;
	Mon,  9 Dec 2024 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733757514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4VBr1zEJa6gUZmX14RHtbHMhhsebpJLB65p0BnHY5c=;
	b=pB/LBxMjkk8ih+PbQL/MeI4eGtiZlcr1EuDeEfh6sPl/M94DVJrS5qHgRvOtApUNiGcLLG
	Jba6aULzfgkV/KxnFv0VMNN+5BQY0JOVVn7jmEB0C2Pg+syCUOFWvnJcCYwAwuYZC9N09v
	TMJeofyRdSEbC2opxNEYsAu058ENKalwsCj1qDwXNcG6DL4jExojHwO3Xm1OVAIPN8Tyrq
	cTgW/qaXXYlkDBPTUGoruAVIi5poBDtCvaCyrnZFaB0wfGAf4X31KY5FWV7pCqCLGwteC0
	tZgCsaFVPW2XTuAl4PohLxKAsUooddgj/fh7fB+2o5ZuNfLzGVAcZ/EacNestA==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Davis <afd@ti.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/7] dt-bindings: Add support for export-symbols node
Date: Mon,  9 Dec 2024 16:18:19 +0100
Message-ID: <20241209151830.95723-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209151830.95723-1-herve.codina@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

An export-symbols node allows to export symbols for symbols resolution
performed when applying a device tree overlay.

When a device tree overlay is applied on a node having an export-symbols
node, symbols listed in the export-symbols node are used to resolve
undefined symbols referenced from the overlay.

This allows:
  - Referencing symbols from an device tree overlay without the need to
    know the full base board. Only the connector definition is needed.

  - Using the exact same overlay on several connectors available on a given
    board.

For instance, the following description is supported with the
export-symbols node:
 - Base device tree board A:
    ...
    foo_connector: connector1 {
        export-symbols {
           connector = <&foo_connector>;
        };
    };

    bar_connector: connector2 {
        export-symbols {
           connector = <&bar_connector>;
        };
    };
    ...

 - Base device tree board B:
    ...
    front_connector: addon-connector {
        export-symbols {
           connector = <&front_connector>;
        };
    };
    ...

 - Overlay describing an addon board the can be connected on connectors:
    ...
    node {
        ...
        connector = <&connector>;
        ...
    };
    ...

Thanks to the export-symbols node, the overlay can be applied on
connector1 or connector2 available on board A but also on
addon-connector available on board B.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/export-symbols.yaml   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/export-symbols.yaml

diff --git a/Documentation/devicetree/bindings/export-symbols.yaml b/Documentation/devicetree/bindings/export-symbols.yaml
new file mode 100644
index 000000000000..0e404eff8937
--- /dev/null
+++ b/Documentation/devicetree/bindings/export-symbols.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/export-symbols.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Export symbols
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  An export-symbols node allows to export symbols for symbols resolution
+  performed when applying a device tree overlay.
+
+  When a device tree overlay is applied on a node having an export-symbols
+  node, symbols listed in the export-symbols node are used to resolve undefined
+  symbols referenced from the overlay.
+
+properties:
+  $nodename:
+    const: export-symbols
+
+patternProperties:
+  "^[a-zA-Z_]?[a-zA-Z0-9_]*$":
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A symbol exported in the form <symbol_name>=<phandle>.
+
+additionalProperties: false
+
+examples:
+  - |
+    /*
+     * Allows 'connector' symbol used in a device-tree overlay to be resolved to
+     * connector0 when the device-tree overlay is applied on connector0 node.
+     */
+    connector0: connector0 {
+      export-symbols {
+        connector = <&connector0>;
+      };
+    };
+...
-- 
2.47.0


