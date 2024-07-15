Return-Path: <linux-kernel+bounces-252843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375649318BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74ED281948
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598F481D5;
	Mon, 15 Jul 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZyRaCTS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537346556;
	Mon, 15 Jul 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062004; cv=none; b=K073jbRDVHVPTaEbkXkGj6n8sjjyGf4pAk3bOe9tsod2eaxk5Zlb+FZRqb3sS/hjN5fRX7h1t0XdOETCg90Hf+hPfKMpCdFtZgmVVnNx0VGmSyDYe3RdTBQBlX27bWAPGEyxC3pwDHAXBPWKkKBNb4iF8KWrxHB94D7X46zOWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062004; c=relaxed/simple;
	bh=KxhhSwZpJ8R3MqZlHHkvsmpFuMpX/g8ZczfW80IX57A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THOu4D+yjTW+ZaZz5N8FqdWygeATnkNLNi+DihF7kJrYbXNHnY6VuJhJvTxTIOSXtJPdXo7Uskjsx2WnuJIPbmDmIAMF7nvTc23zvtdTo4u7a9ayeMlT+Zbj9pOIhjxw/t7JSpxuFQbrmHwrsX2/I8LCuhAQDUZMfYKwbUzMG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZyRaCTS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so31467795e9.2;
        Mon, 15 Jul 2024 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721062001; x=1721666801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE107BcHqsNE5dZ7htAOIriFiMS47OFGE7QlqBRD04Y=;
        b=IZyRaCTSJAnWz/egdYPME+x/gHr7WLDWijNu61mgsUJerKXnaJBs2W3NthYeWtHV1Y
         ++HufmeDdJXiMKmZRul3lXb7t4UEzjqS7BJhZiYCaynsgbcrLdioWOi68xhdnXpSSVKp
         Bt7tFBtgh27IaXOpisvi7j9UfuBgA4O31tniQXMFC+vTOodEz8qFua6+m+rLDhV6T/bj
         Kcytp8RXB/kgj8hyFasGI6OiRpBHF6iNHSYQMILGPV/ne14epIGWBhaR0vogHx8nAlwr
         e4XzJa0xYvIUuKVeVLXB9LAIhwA23kaubXOOHabW1fm806vFLWv8PD29naGHG/Ily6xE
         bu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062001; x=1721666801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE107BcHqsNE5dZ7htAOIriFiMS47OFGE7QlqBRD04Y=;
        b=lOuk2M+TLbC83A5H1PbrilZG1bpTcQGQbH5cgJuOIzLl+cCXUjiE3MH386lM07ADBV
         VfK93dCTduafXFL+zNEmvTv0JaLWTKrLqAcwKSVZEzbZHFLMPQaHeJb8qsMn3MTm9rWy
         seJ4xKBIZ3QvRMb8b0JXign51Vb8cm5br0EhTzK0tDOFZ4+PKKm+eYu+Vjv3vOVe28D7
         LDONB5FkR4qYWu4I8VpPk0xrJEKHgKZNA2FEaLV8TXm+3R51s+xFSCgYeiYIibC9gf9i
         jGdwdg/h/oS4ler+pLxg2BSiEnb9Q3/XENhzJ0EC4YZM4nPDlYmbvSH5Ktr+9tfl+Mc8
         ofDA==
X-Forwarded-Encrypted: i=1; AJvYcCWsqYbyJ9JjZJMRFRJbH3K1SC7BxOHQt5j1tgTI8yoyroubkJX6owC2h/Uc2Z82lD8tJql098MgQBWVGocsqX+eamHlFya/fDTn2xyV
X-Gm-Message-State: AOJu0YxaI+XqumIejAgW6KBBwEbSrtrx4LgdNIw+VguXI2qCzpBe7OpQ
	lZH26+jZyoIDXE/wmky6ZLge/fndO3fT0wU0sH553G11cQHyJtFOK5K17pYf7KA=
X-Google-Smtp-Source: AGHT+IHIy6chjAutKf/iJIZQURe9szXYTSWbYLQqamzyq1p7dzNS2ZlGs2F6yEGiZtrsigYIbUcOnQ==
X-Received: by 2002:a05:600c:4e90:b0:426:5d0d:a2c9 with SMTP id 5b1f17b1804b1-427b8893008mr1417175e9.10.1721062001372;
        Mon, 15 Jul 2024 09:46:41 -0700 (PDT)
Received: from playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e7749esm94316975e9.2.2024.07.15.09.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:46:40 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: reset: add schema for imx8ulp SIM reset
Date: Mon, 15 Jul 2024 12:45:12 -0400
Message-Id: <20240715164514.8718-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
References: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add schema for imx8ulp's SIM reset controller.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../reset/nxp,imx8ulp-avd-sim-reset.yaml      | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
new file mode 100644
index 000000000000..ae03c5750fa7
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/nxp,imx8ulp-avd-sim-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8ULP System Integration Module Reset Controller
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: >
+  Some instances of i.MX8ULP's SIM may offer control
+  over the reset of some components of a certain domain
+  (e.g: AVD-SIM).
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,imx8ulp-avd-sim-reset
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  mux-controller:
+    $ref: /schemas/mux/reg-mux.yaml#
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+  - mux-controller
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8ulp-clock.h>
+    syscon@2da50000 {
+      compatible = "nxp,imx8ulp-avd-sim-reset", "syscon";
+      reg = <0x2da50000 0x38>;
+      clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
+      #reset-cells = <1>;
+
+      mux-controller {
+        compatible = "mmio-mux";
+        #mux-control-cells = <1>;
+        mux-reg-masks = <0x8 0x00000200>;
+      };
+    };
-- 
2.34.1


