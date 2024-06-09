Return-Path: <linux-kernel+bounces-207363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8DF901628
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389D9B20F7D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD9405E6;
	Sun,  9 Jun 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdhUKMyC"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A6374D4;
	Sun,  9 Jun 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717938072; cv=none; b=SZyFd9l100OmM7aDmXzsW7W2pWE7qlkA488JnbIdWZ4xfLEUDDRacmnuSt4JgM06uHwLXnVEpQJ5NCcW+CcwHX7nn1N3wD/ttuElAWqjBsRcxZpz08bN8fsRZMtothNzQ7EVEDQCOLFhQTNhdtGi9hs2Qa70/DGxo3hNiSRsB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717938072; c=relaxed/simple;
	bh=j49VU9MU24LvpW7FfwuoiEMwbcnOP7x2EnhIo7iP/Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cOoVuasI5h/Fl2TcBg+8f/QFnqsSvsJCgZJm61vy6YbJ0xssTtA56W8uDVRDqrrinfaS+Z/nyOZm+9Owm+XT8SAgw/3YFI6FlcdAp9Wfy5sJV6fWARgPrUnbVqU/X/6PwrBR8syES0XchsXaMvFFPAP6wMmKzLHAhcNQxzw6uCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdhUKMyC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6ef64b092cso180202766b.1;
        Sun, 09 Jun 2024 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717938069; x=1718542869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REsRox1e0RuQ8D5QAaZjLhlhSVKgshVITv7B++1K8Ss=;
        b=HdhUKMyCszV2EXAMcPngB/2Sh7n6BzLfYP0YgdbD+7hWlS9HwYKAhBpL7rQP5PJ3Ls
         V48NS5RJDXW0DXf/qTn9P9OTPtHDwDjV014PMhwB877PBZQzAu74h1ZIiAHQIfliUYNo
         CsDSWuCSsh2wpCeHhxauQJzomUGBnC/ETmGom1Az1JJfTPrqe1TsirCD4tytLeFkEuPv
         207eHL5t7q1JQ+VFXFBeLEFJ5Yw2rBAdWSjB+02THcWLcfD/lFhwFbNslD/LDYNj3VZR
         9uuAchz2QqaiYBy2UQAQhiq38VNIMp9Djrtn4CKYrPoa2FuXG14wVMKiaiWRuz0FA4nN
         QAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717938069; x=1718542869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REsRox1e0RuQ8D5QAaZjLhlhSVKgshVITv7B++1K8Ss=;
        b=YcpqMDN/0o14aVnbSpilSqojAbxq/C0JGR9uZuWE4mbwkZc3D/wcztXkVe60aYHxtM
         jD1S9Ih/yhDFjErfo9lV9KxPEMycQKg7VpgqJRPnMbn6tSe15gddiXcp60acJQupDDJ5
         3448NKHY57rTRK+uiQiv+ZOUywmoWTJ3+QTP3ZBr1GaJT4HgbTHnzxe4A7OZMCg406pH
         OcX9Ww7gT1/DCkip6bxtbm2xQ6dSmy2U1F+tM/wAjYxN6oLGlVMQGje2COF1xExbvJ+Y
         BH3gIV7JQzehm4OhWBiS71GmGUth+UetImIWUfOiW/Tjrk5zzuwC8xznpWpa//0KK3z3
         V59Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0xXO+ul8kXzAfEnl3HuorZ5IHsPrNun2eMbsxJuU0uHqfmJbRsB8m0fN4y9MyerCyPKQ8Rn4+IC5bSl8Q/n1LiMy7/hm2aztwdB5vTYQCiosTxamn1WEmZKHO07Pb1SIZi5I5eAur1A==
X-Gm-Message-State: AOJu0YwAmjUxstuwAwok3Al2odBro6l+p0Z+CsMQ4XNJKX7q1FoZ0Jmj
	TxPgBG71Uj3MSSpVrKcs5Qo7MzjZOiRX/s/LVUMQJEVO8nrkHjeD
X-Google-Smtp-Source: AGHT+IHuwX9E4jd+uOP3g2E/VCQpCP2FwgjdCll+ONft/3eSl0lcdXlxqQ5XLFW8iIp/cysdKtueIQ==
X-Received: by 2002:a17:906:4a4a:b0:a6f:74:d389 with SMTP id a640c23a62f3a-a6f0074d52fmr240671266b.14.1717938068825;
        Sun, 09 Jun 2024 06:01:08 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1841fceasm85961266b.70.2024.06.09.06.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 06:01:08 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: reset: add schema for imx8ulp SIM reset
Date: Sun,  9 Jun 2024 15:58:59 +0300
Message-Id: <20240609125901.76274-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
References: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
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
 .../bindings/reset/nxp,imx8ulp-sim-reset.yaml | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
new file mode 100644
index 000000000000..e7faec55ff36
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/nxp,imx8ulp-sim-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8ULP System Integration Module Reset Controller
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
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
+    $ref: ../mux/reg-mux.yaml
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,imx8ulp-avd-sim-reset
+    then:
+      required:
+        - mux-controller
+        - clocks
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


