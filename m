Return-Path: <linux-kernel+bounces-409809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A02B9C9203
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C05AB24DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5F19ADA2;
	Thu, 14 Nov 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGmwddek"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87E19993E;
	Thu, 14 Nov 2024 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610716; cv=none; b=V1vTOd8p7+vxMLcI782vAFRwn/iJAtARA+ehrlIb92+qRn3h2ZmFJVpeMVQRwRcqZzy4Dfr8EmRcwFu2hmwAHjFphq/aZNyGlg7ci5SOyl+rEXhqYWchzTfNt2GX0uYmotNd9ffJW0mfRrYIJ+8CniSw0y93+0fdr/oza3yKVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610716; c=relaxed/simple;
	bh=rqXzVDKY2HvrD5cfi4Gy4+13pMUCa5e1CoinlQ72Cp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDRreAB2uI1CNvWyeSblVskqgxF/R7r+j5OT/hxUZAdFCo3MrxQ9TB6f/PvaKf+4slnTK1i2Mdjd2E3KicS8A1rtXHOYkMYjaNt+7+YUpNwZiohpME3HE7B2qCS5l1hRvrxfBEe2SEQI2Dp3XZGfQOPp11CurIXTP0OFaNZpd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGmwddek; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e44654ae3so139870566b.1;
        Thu, 14 Nov 2024 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731610713; x=1732215513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO5liRDlcR47A0DVsuYsaUEJFw9er1mJTtpfKIrWSOM=;
        b=QGmwddekicePVBZ4/8l7tJOFrmSSAzvlkO/1GGWjqClhjoLt0nvrK2ZJUsUa9xi9fb
         YdXCZGW5hTF5tmwk/wew6Qhg23vUzzRkO1sqgstcnXc0nHbLGUBpiWq1CKv4xsaSMyBN
         vEc6YpLg6cwpFNgV/x1Atk6JE7la5MfFBEmDNDVTvF4Gqj8GGQrj5J7aFKArVQsNOWjk
         3CqfqioJqIkLP42GeIqC++9oA2aBwmGerwIUAqqZVv67BKvSL/scD8QDCdE+edRXNfZp
         tryRmqDKSdANM890KSL9ajLBLnatx0htnYehoy9M3035HlLBAS8h8+JkDj00CnTBquHK
         leKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731610713; x=1732215513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO5liRDlcR47A0DVsuYsaUEJFw9er1mJTtpfKIrWSOM=;
        b=OWNHa+Z3m49+wZKYTUpjrui3Ve44tfTiJg9yiy1pYAj0fDGiL1AG+INQSILYKfAkg7
         pNI1VZ+TX0dHXNJ/cU5mgCDr8A1oo4rv3VAoo7KJfO5FV8jGk+6GCBm03rqDNaC5XHN0
         hqsWhilp24f+AeqD1E1yDxAG/m4i0Dxy0tGhGRMIsqVmqOcp+xaCc/mNEKo3iOuDsuHo
         e7xPFQ9r1HPp4kKy0vUBmYmk121tBSiZuWOTZEDw1dm2WsHzYU9ID3d7XzkMFlkDZhUv
         9jBP7wv6l4Ey6R6XUWG24kbIENXveF8q5GpyuIyYGka8n4CtgQk+slZoVbmSgt4Ed+E3
         cnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDK46pxcOWHF3lTj9BGxPrJuvzAXpI3a4phE7Kpos8vSQ74M9bYB3UKkN92h7JtGmQFgU5JxbGrdTF7T2d@vger.kernel.org, AJvYcCVVsR4+SORaVnO69bGXz7dEwoUQZ/b0R1TTIJax7rpJpUd+eeWcy4RN129oaJQRIxy0+axX5q11UvIc@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhsiznwMkWxlcLmjGz/ipahZAF6tCNGiTuKr614OujlsJhosh
	VFcgKleoeegQ7k01HQhKqPSh0/HqP/ULpFa+B4497XXVgtMlv6eq
X-Google-Smtp-Source: AGHT+IES7N7ENMRe2XGq4MnqC63EZcYUBINk3rzUzCCISCDHBCJaLj+rIOZBTQLJQIw7uaUskvPNSg==
X-Received: by 2002:a17:907:7b91:b0:a99:d782:2e2b with SMTP id a640c23a62f3a-aa1f8074cccmr738869666b.30.1731610713127;
        Thu, 14 Nov 2024 10:58:33 -0800 (PST)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df50de1sm91509766b.58.2024.11.14.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:58:32 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Karol Przybylski <karprzy7@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas@kemnade.info,
	rogerq@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] dt-bindings: mfd: omap-usb-tll: convert to YAML
Date: Thu, 14 Nov 2024 19:58:30 +0100
Message-Id: <20241114185830.10025-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conversion of omap-usb-tll.txt into yaml format, inspired by discussion in [1]

All feedback greatly appreciated, especially about what to put in 'maintainer'

1 - https://lore.kernel.org/all/cd915c18-7230-4c38-a860-d2a777223147@kernel.org/

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 .../devicetree/bindings/mfd/omap-usb-tll.txt  | 27 ----------
 .../devicetree/bindings/mfd/omap-usb-tll.yaml | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml

diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
deleted file mode 100644
index c58d70437fce..000000000000
--- a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-OMAP HS USB Host TLL (Transceiver-Less Interface)
-
-Required properties:
-
-- compatible : should be "ti,usbhs-tll"
-- reg : should contain one register range i.e. start and length
-- interrupts : should contain the TLL module's interrupt
-- ti,hwmod : must contain "usb_tll_hs"
-
-Optional properties:
-
-- clocks: a list of phandles and clock-specifier pairs, one for each entry in
-  clock-names.
-
-- clock-names: should include:
-  * "usb_tll_hs_usb_ch0_clk" - USB TLL channel 0 clock
-  * "usb_tll_hs_usb_ch1_clk" - USB TLL channel 1 clock
-  * "usb_tll_hs_usb_ch2_clk" - USB TLL channel 2 clock
-
-Example:
-
-	usbhstll: usbhstll@4a062000 {
-		compatible = "ti,usbhs-tll";
-		reg = <0x4a062000 0x1000>;
-		interrupts = <78>;
-		ti,hwmods = "usb_tll_hs";
-	  };
diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml b/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
new file mode 100644
index 000000000000..f49417d1faf7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/omap-usb-tll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP HS USB Host TLL (Transceiver-Less Interface)
+
+maintainers:
+  - <maintainer@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - ti,usbhs-tll
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmod:
+    const: usb_tll_hs
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: usb_tll_hs_usb_ch0_clk
+      - const: usb_tll_hs_usb_ch1_clk
+      - const: usb_tll_hs_usb_ch2_clk
+    minItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmod
+
+additionalProperties: false
+
+examples:
+  - |
+    usbhstll@4a062000 {
+      compatible = "ti,usbhs-tll";
+      reg = <0x4a062000 0x1000>;
+      interrupts = <78>;
+      ti,hwmod = "usb_tll_hs";
+    };
-- 
2.34.1


