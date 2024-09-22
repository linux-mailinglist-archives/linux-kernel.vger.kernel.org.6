Return-Path: <linux-kernel+bounces-335223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCBD97E2CB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7AB1F217F1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1F039FFE;
	Sun, 22 Sep 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlIQb/Kj"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A42AE9F;
	Sun, 22 Sep 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027007; cv=none; b=HtCLettXs3yL5raqwZqUSsZE/7l/9k5f7VOODDEFoyMKkddMHC1tRBekFMlCZEQU36Bi88WQ9nnYxpT+7mTfOSbI6mObDdh8gVX2wk9V/GVles199gSCNZ1cZ4wi5FgJ/Rz1jHNIfP62GZo+lduOdVgj14g26RM0h0XTlyYzFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027007; c=relaxed/simple;
	bh=mjvAP+JnaPfWNZUJhTl7ospoADxFXh1F9b20zOwM8bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/v15s/t/RR8gFw9HlPRS5JJzQ1RsdLAU0BtelA6aDfE/Ux9z+6HDYM8p+XIdltnlmMzmOYaUK4J3VO0CaiEjboYjk1rzxPEnEwjGeF736xnshUdymKylUuGzKAzJ9+Iw9c1ShWTFHZn/4+2DgL02iO2tcMiz0ywVG5cO0fEl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlIQb/Kj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so46274445e9.0;
        Sun, 22 Sep 2024 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727027004; x=1727631804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAjYhVQ4C8qjWITifRAvYNMOE8p4qGOmbG7rB+b/sOU=;
        b=LlIQb/KjyR1LMzKWBEeZIzCZxI7rlUw/YppdFPUtoUFn9PlFMdOYZMIc8RZA9/okRA
         phNOR1siIrHg3J+YkVAz13h6QUlNCuQ1cRbyhD5tzzaRrK0RHaU+17IXIcNkLX9YwACP
         FXljrnGK+DaNjwiFbdDZYW86WH/8dAxqdygEx8nz9HrxNIQqescezpVkkVXXQmsij0m9
         6FjVYMpn7S45jYqBYN+Ds5lQFiT5Q7EuUITsN/mKbIdhBj45U2Q+toGcdm5aAYGBqZ9O
         Hfqlh+jsX188rQM1Edf5ABqW+73G8kjTt0igZS//TcZz12urGpxBXYzqSMRcRsy0pwAD
         Q1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727027004; x=1727631804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAjYhVQ4C8qjWITifRAvYNMOE8p4qGOmbG7rB+b/sOU=;
        b=Ko/k1JWhHPn74fG8Yu30UhyxY3YcT+6B0Rx82EwXwUYWDJupSidAcq1gfdLSg/nZws
         AYoDtJQgTBkUbIw4h5C0zYpkq1eICkPkuiEOAhMKMDxWa0C2kXyT2S3vcZM+WpMAxkNa
         aGebgTuoJaRCq7LN2JytXk9tfbObc2YuPk8WqzP9sDadZvjbqJzLtb8Naiyxosg7orPp
         XCHFiOeLMTICpe70U12mBjH1PXZNvRlxq836b77Gl+jm90VBDYZRq8CQDN7CPT32usFB
         +KKTXqPNFEuGsS1CGQ5GB1k9HI7eWmNkyRwrU4e2HanR4HQLalWAbSaa3D1oky3gnuhl
         5kdg==
X-Forwarded-Encrypted: i=1; AJvYcCWi/vPERqL1o7tOEqpBdDPt1Hd/JdGOEKthb6HNVHkR1hcLmT61nT15KQ3ZHzARWFE6c6YdG5pyFGUNgGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhs6qwcdD5aDPDThO7hYY+TrO8KkK/ml6eW3q2BwYCFcaB4fe4
	GdnNOiOzItE1d/Qqv+kTxGyxkHvcBI60/TFOUF1UavPgrcSzxS0cxA4zrlZV
X-Google-Smtp-Source: AGHT+IHp7HvXth4+/t06EUgh6Jxqi0dI/PkunLPhvuAKvjxVJB+S7Y/BjsFPWYMR3mh0rKxVkNkSRA==
X-Received: by 2002:a05:600c:1e23:b0:42c:bcc8:5882 with SMTP id 5b1f17b1804b1-42e7abe418fmr105816945e9.7.1727027003879;
        Sun, 22 Sep 2024 10:43:23 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae60ad0sm80758535e9.1.2024.09.22.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 10:43:22 -0700 (PDT)
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
Subject: [PATCH v5 1/3] dt-bindings: reset: add schema for imx8ulp SIM reset
Date: Sun, 22 Sep 2024 13:42:23 -0400
Message-Id: <20240922174225.75948-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
References: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
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
 .../reset/nxp,imx8ulp-avd-sim-reset.yaml      | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
new file mode 100644
index 000000000000..f6797966fd35
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml
@@ -0,0 +1,58 @@
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
+description:
+  Some instances of i.MX8ULP's SIM may offer control over the reset of some
+  components of a certain domain (example - AVD-SIM).
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
+  - clocks
+  - '#reset-cells'
+  - mux-controller
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


