Return-Path: <linux-kernel+bounces-181571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286928C7DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05501F2235F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86C158A26;
	Thu, 16 May 2024 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGGxbfMN"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC84157E6B;
	Thu, 16 May 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892096; cv=none; b=t8sxvCPr3uHegp0TySAvgSUvllHIxx916RmL2TZnn03aHgRWwygtKQi70tCLv6GYNwFP4W6JW1mYFZK9rTV5ZoC96TgwZt5HmjIVvhruinlSyue7DX2D0ARujsRbTZm2+ig5WEHq/ORdchdD+J/eDkpm35qHyAg/wUgcDf10Dqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892096; c=relaxed/simple;
	bh=YG6Irvok/llj/JOUak/E8yE3D7cWV/e/rGxYwg0Av88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJD7Cf3FhTmUMT0WHOW4uYhPemHmuFMTObFitPfbnDEYbg+qhfb1lG6cELNCIZfCDAJm8s6wy4GnDsUIf6T/rDWfelGao2Y4dfCAJvHUvePmhiwJempR/zxJqQKNQz2jersTa6GyG6O3s4IeZUWmSIaGLm1qf234pkqg+/YW9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGGxbfMN; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so14866691fa.3;
        Thu, 16 May 2024 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715892093; x=1716496893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opo8rK0GjT1pcxD/DdT5h2EA1MA57S7z8/+NMoMMi8Y=;
        b=JGGxbfMNsR4ZvvMm1dkE3vkw1vvsptr4ijDwB4QUWetjqGptOT1tnKisJX6ucNa8mb
         7BuGJy2vIVTxae48NROxvg/C5rVYkj6Ooq6y/PHEJm5vciANety7pllwd51Shai/W16Q
         Kr7wvRHlU1AIdl+d2CFJZKnsYm62/WCdnefHMUwpz05Hy9r0qHT78mjm0ASPpRERzhbH
         nZsFKa//uUZJ62sXp3BVW6Dw0jWBk92d95hwLKaoDoQRdYQpe5nnZEaNK96+l//RRpqT
         adqT6bAVAyLajT903W0WhddpUZDA0fORVbYPSPZY5T8fsN2JOVy3fXqFddIv67bfqrqT
         FZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715892093; x=1716496893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Opo8rK0GjT1pcxD/DdT5h2EA1MA57S7z8/+NMoMMi8Y=;
        b=qQi1yR8o1SJQW+xURgFNeoMnN5tWFJ83joyyc7W3nBRUnDcZOUJYwgctyBxZDcqxIQ
         Z0tfRYYUR41TmwxGohkK0bScPtBJE00KhRluP2h18OTkgrdct5gy9XpdoYThbVoZi749
         kjXl6EPGamPRQGBdytEAabRvJ0ip4QsR0fH2v6YvfFeWlFFG9nU9RErkiCPDYeeZPrit
         yUH/G6KZrgBfhRRYJcdIpy4XLxcRdLRwlO+Oh9mrqdXS9gso5wDkxjTt/dAXsxhg4Kai
         CAshaT3b3oMe3qbRkZSW7ttRHz95uYA6ZQGVQmI9WTxhtMTogivW/gdSKw0gqvi8TPxN
         dmZA==
X-Forwarded-Encrypted: i=1; AJvYcCVgMzc1wXfjiUuocF9K7b0HR/SRb968i03MLIYzmCzuPJZa6NYj0PrQwxmHdDTexFwIQbHHO3bS6TQW11FOpD3tdh90ydihxGg0aBmbow4LAbAteiw8CjdO0ARAmz9g7CL09BVtV1zZfQ==
X-Gm-Message-State: AOJu0YwgsG1l3pgA86SR+F+6N7zaK2oCs+InI2jo0U6dKqBw6kP6eiHm
	6DEZtZYG9BXoMVm0YcfSUcTHfFbNwiwKEtX/Op1R0bV5KqLELiLI
X-Google-Smtp-Source: AGHT+IFkZ7z3jVZAtbsPTlP+QbCw2nX9bvAx9eVFbzWe4AfgwJu6Me5+ek3irY+a0N8SYp2fo3MWDA==
X-Received: by 2002:a2e:7405:0:b0:2da:c37f:655e with SMTP id 38308e7fff4ca-2e51fd4a7a6mr124569501fa.16.1715892092957;
        Thu, 16 May 2024 13:41:32 -0700 (PDT)
Received: from localhost.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2b8f7fsm10859828a12.66.2024.05.16.13.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:41:32 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: mfd: add schema for 8ulp's SIM
Date: Thu, 16 May 2024 23:40:30 +0300
Message-Id: <20240516204031.171920-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add schema for i.MX8ULP's SIM.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/mfd/nxp,imx8ulp-sim.yaml         | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml

diff --git a/Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml b/Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml
new file mode 100644
index 000000000000..fbb17c06e3c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/nxp,imx8ulp-sim.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8ULP System Integration Module
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  8ULP's SIM provides control and configuration options for
+  some of the chip's components.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,imx8ulp-avd-sim
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  mux-controller:
+    $ref: ../mux/reg-mux.yaml
+
+  reset-controller:
+    $ref: ../reset/nxp,imx8ulp-sim-reset.yaml
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,imx8ulp-avd-sim
+    then:
+      required:
+        - reset-controller
+        - mux-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8ulp-clock.h>
+    syscon@2da50000 {
+      compatible = "nxp,imx8ulp-avd-sim", "syscon";
+      reg = <0x2da50000 0x38>;
+      clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
+
+      mux-controller {
+        compatible = "mmio-mux";
+        #mux-control-cells = <1>;
+        mux-reg-masks = <0x8 0x00000200>;
+      };
+
+      reset-controller {
+        compatible = "nxp,imx8ulp-avd-sim-reset";
+        #reset-cells = <1>;
+      };
+    };
-- 
2.34.1


