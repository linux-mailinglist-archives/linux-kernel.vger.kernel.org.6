Return-Path: <linux-kernel+bounces-329832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3997967F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB471F216F6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583431C6F44;
	Sun, 15 Sep 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/8vSJqr"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647C1C4630;
	Sun, 15 Sep 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400649; cv=none; b=SKNeIIaSTmEprV3jK9DGcxnUbcHSHod6BkjbV5lufNQ7rWcHftWONMAhkPMkmbJVcRDp4YTvRsteOvwxGeRta0//8N6j3g2VoRXcEiPKvK3l/FiQLeUIYJLBqHbLkY0eVcLKMFfZr37rmkTCmZesCCP0kZbsCgHiIovlEy8ARqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400649; c=relaxed/simple;
	bh=HgijeomsNGsoTD7HIIXQI6oJ83tlGGXVPPZwJNbDgRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0xlSKqOt9MgAOLpRO6BO9J7CLexmZmzD+a71ET9Q8ZNKypdHfo7DJafSZKxwuQ7GVZdmZfPeZZIc5n3WPHtMKcewlP6a+CRMdwZJwsEcEiMg51Oylkx5IisANNtcMSrV2HEg1pk9fZ+TecDNMetARWj97DhnrDZbjRTsi+7rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/8vSJqr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c4226a56a8so2434504a12.2;
        Sun, 15 Sep 2024 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726400646; x=1727005446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMukAaRv6lsduEQXd5W1x8cQrcsYqXKgAlv5XHYkQXQ=;
        b=U/8vSJqrCoyjdziO6HyBgiOkhpxEhhLlfbgG9vFkEIhcabHnZ8hHG1tLuIcci1yWvz
         B/GrwPaBAfdoS+y9AuajuKCCWDlwP52gQFQ64N9C3cXzt7JnKatFUdM+Y3HXCu8OMGxu
         9skV65ZLiJzgF1u8MSor+KxJAAkLXrDuaOhkYmxynQTv9Ggz/piP+HhdRnMTRAfmcceo
         FlgCQvmnueGvw4iH0iQK8jIsRX9VFk56TunB5HX/w/tyePLH5Y1HEMzcIHgE7GfYTOBD
         t5e3IZRDbUZ8UpqZpiFm/Tn+YDcl0Ufj8S4DJ4P6KbgpAuOLg/aomWOnpnjHgnNW3qRW
         EPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726400646; x=1727005446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMukAaRv6lsduEQXd5W1x8cQrcsYqXKgAlv5XHYkQXQ=;
        b=Aa+5glTOvc2J/RzD+UWN5lYcpDOGL0Xvdxc6rt2DBEao23+7SVIMCiXBEZG1YsV/C6
         UL5/S508WFB7e5syAunt9bG5Hq1d71akTDWQGjXhtDbsymqCYpi7YTmwXz6MMaVFUHi2
         unV2fWmkqrQH0JFhfv5QQ02hNpv8PwPGJyY2gWFBgfbyQWh69c2DbWx+mPhkQCozr0j9
         cNSvbeP+a9JPM5K73KRjQQCUf+7OScxMH7f5HdVK4J79UkWi86KCAtycTukbR9iYe75D
         1Smr63hOP1SJqVNCFxxcq37PUbvwdOEajsdneNDs5eyLlF5yW8D+EzggwNI2aR95PSnD
         wnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9gfJSMUb5e5clQVfYPTERsXpZVTivgWzxJXk35m9iGRb9+nXIp8Z3rFhuqu4HOMbFhR11DGjAyi0VMMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfcDscNTX/eSO+iWVi5ztc/0qQqntXWH1b9Yo6nlOBJZ58vPP
	MI9/vGvBsXywOdqE7lqdYQWRVuWOxkhA0QAWpg/6LhYbI4GPHPqi
X-Google-Smtp-Source: AGHT+IE31cvGT/N6V95eA06b6sHMWCe5xvfNaDUEwVbsa4UyYKFSiLYAh+OpvI2B3F+xUi2OqHNUUQ==
X-Received: by 2002:a17:907:26c3:b0:a72:50f7:3c6f with SMTP id a640c23a62f3a-a9029432757mr1209442066b.14.1726400645566;
        Sun, 15 Sep 2024 04:44:05 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109676esm188778266b.33.2024.09.15.04.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 04:44:04 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
X-Google-Original-From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
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
Subject: [PATCH v4 1/3] dt-bindings: reset: add schema for imx8ulp SIM reset
Date: Sun, 15 Sep 2024 07:43:09 -0400
Message-Id: <20240915114311.75496-2-laurentiu.mihalcea@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
References: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


