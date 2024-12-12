Return-Path: <linux-kernel+bounces-443337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA49EEDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1648188419D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E02253EE;
	Thu, 12 Dec 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKaohNa1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FC221D9C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018244; cv=none; b=sjg/14r96sPRj1o+aMkguAk4VCVdG/Zf4V/AqYXlZlk51CSabXZbBZwOdiHgDMJ4c1UHdptGkuTtUz5BmnWk4+tLA7P0JI6fmeFIQCMs/6RlHfztIl4y803YZf6HWBiy0V1SMU+iT1RFZBH11jtpOHrO1gQ6nz3aXl6bRFpVDvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018244; c=relaxed/simple;
	bh=2U3cIpMR781g/GfpmXVJzVTA2XVkQ1k3SY+wzu3Tc7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hITi06EZcU7mfgxC3iEeFujMNYON8u8xSvCywkhardUwi53/TiU2oIkoxv+sPTTmex8wrzdaoWgzdRjnqImayZJy2L34VSbq7XhK02Swxa0sdbPBRPv20GUkcbjf0q1vVGEwxOFZFqhjBQ6PP3SbYTDZmtrtLdMLQOnkf+GNsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKaohNa1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso7274755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734018240; x=1734623040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sYCGfkHDNTUYrfu1p0MBWMT4rMemdA0rLxD3BGGzRo=;
        b=aKaohNa1d0alWzEJAisniAod8Osi6/unH9cFs0zZQtJvjs6zUrpvMmOv5uCHaOv9JJ
         lSq386koxwYPFB5BpTGK2QblUiLYu9kIOrtmAzfbNN7R7Qaf+l1tBrC4MYC6kOtWSvbC
         J8DLZanEH5i+t7N2JTiOD3tWJEIb0z3ibZMjktyj+xytXDL7hIOGnb56pHEzMFVXMDpm
         H6gmvUfnkn3xQ7A1JzbVvvOeVm17aKBNZcVPu3BBjeVoc1lJf0aaCQyy6KrYrsJWU+9t
         HKlmWmeRTvZmCRf2d45nBu5Dgr57Kj4n9qetRtlz5N2Q4nF+JNBWVPfCWYKQPLnvExQQ
         0ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018240; x=1734623040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sYCGfkHDNTUYrfu1p0MBWMT4rMemdA0rLxD3BGGzRo=;
        b=WVp47lr0AHvULgDDugzXM4NO37kyGVILfEWo+W/xx1N6Zyf843NOEp96MKAIoAgGtX
         ++TsKGiCDUWuPKhvWjWQyh71fSs2NcqELrAvlZlGDB6G5TL9UFkqpLkqKA+qd84maXd7
         QfS8RBXHySKCVyfOLG2cHdS0ppma+MsNdeu9yEbpl42Zyk+rEzu4Edz5BZpnRMoAYfN8
         kvC8Dkb/qYFwQyryqRZzbrKP7ZSob3rws8NA30wBFJgYH/X3sOOq/Mbtem4VAoZZt7oW
         XJflWoMM2iMT7LRYe39U1/JN+SlnBcV5xolTrOG22+8xj8/d0idHexWY2OqjEGDrZOZx
         K9YA==
X-Gm-Message-State: AOJu0YwHzu3NFt098R9NKQHjJiu6DXN58T4pGZW/BvoySOTOliXa0mr9
	EIeus0PX4E5aZCVbavYr7HAs37E4aVDphSI2XSEDYqjDajcxomeVAO0s9h525Gk=
X-Gm-Gg: ASbGnctK7oNORZb2Lg0CbbcKNRrjupTte+mzE+2hyuw2G9WA5kx5YcY+UiIEcWUL7pR
	TORL1XLl4K5capW9b35frDISm8dKWvyrGGMDqdgi9cxJFOOUkX7rUxMGqG0xGPunQrFTzuURvRn
	hRRA5VZ5lnKw1FN98Qax6q4hKLkCI8IEI764XU1hR1QE73jN17Ns87e/jd7US3/19GfN7PQETyD
	+yFOZJRIy0j7ofioPph0KVtCbBGIKq5b35BfIAXFeeCdRELSxbR7I4u4v2C2/hCKfVVEpq6/raQ
	DyChjDs8Y8UiHi8SfMcbCpBnPqDx9LGrLg==
X-Google-Smtp-Source: AGHT+IFWnLDcBs1YFh+lFtIQyXRCp4fpmS1qTnnxvwviVbcPJl2inWgtyLS88igyMkaBIy8IzkTXtQ==
X-Received: by 2002:a05:600c:3b0e:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-4362282e38dmr38316825e9.14.1734018240277;
        Thu, 12 Dec 2024 07:44:00 -0800 (PST)
Received: from ta2.c.googlers.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625553208sm19992375e9.9.2024.12.12.07.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:43:59 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 12 Dec 2024 15:43:45 +0000
Subject: [PATCH v4 1/3] dt-bindings: mailbox: add google,gs101-mbox
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-acpm-v4-upstream-mbox-v4-1-02f8de92cfaf@linaro.org>
References: <20241212-acpm-v4-upstream-mbox-v4-0-02f8de92cfaf@linaro.org>
In-Reply-To: <20241212-acpm-v4-upstream-mbox-v4-0-02f8de92cfaf@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
 willmcvicker@google.com, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734018238; l=3410;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=2U3cIpMR781g/GfpmXVJzVTA2XVkQ1k3SY+wzu3Tc7o=;
 b=dj2pBC8lHn3zTW4F13RoMR+aFB5b4vyOkBgO8VAohZvTmW8QzdjekCEaA6kmDl97zt9qxO0Xh
 Ojms8YxxxiXAskMypQsCMWWvbcesVPqLxkYfimBf7PziCcQdg+RzkQ/
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add bindings for the Samsung Exynos Mailbox Controller.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/mailbox/google,gs101-mbox.yaml        | 79 ++++++++++++++++++++++
 include/dt-bindings/mailbox/google,gs101.h         | 14 ++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/google,gs101-mbox.yaml b/Documentation/devicetree/bindings/mailbox/google,gs101-mbox.yaml
new file mode 100644
index 000000000000..efc2f605acea
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/google,gs101-mbox.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/google,gs101-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Mailbox Controller
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description: |
+  The samsung exynos mailbox controller has 16 flag bits for hardware interrupt
+  generation and a shared register for passing mailbox messages. When the
+  controller is used by the ACPM protocol the shared register is ignored and
+  the mailbox controller acts as a doorbell. The controller just raises the
+  interrupt to the firmware after the ACPM protocol has written the message to
+  SRAM.
+
+properties:
+  compatible:
+    const: google,gs101-mbox
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+
+  interrupts:
+    description: IRQ line for the RX mailbox.
+    maxItems: 1
+
+  '#mbox-cells':
+    description: |
+      <&phandle type channel>
+      phandle : label name of controller.
+      type    : channel type, doorbell or data-transfer.
+      channel : channel number.
+
+      Here is how a client can reference them:
+      mboxes = <&ap2apm_mailbox DOORBELL 2>;
+      mboxes = <&ap2apm_mailbox DATA 3>;
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  # Doorbell mode.
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/google,gs101.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ap2apm_mailbox: mailbox@17610000 {
+            compatible = "google,gs101-acpm-mbox";
+            reg = <0x17610000 0x1000>;
+            clocks = <&cmu_apm CLK_GOUT_APM_MAILBOX_APM_AP_PCLK>;
+            clock-names = "pclk";
+            interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH 0>;
+            #mbox-cells = <2>;
+        };
+    };
diff --git a/include/dt-bindings/mailbox/google,gs101.h b/include/dt-bindings/mailbox/google,gs101.h
new file mode 100644
index 000000000000..7ff4fe669f9e
--- /dev/null
+++ b/include/dt-bindings/mailbox/google,gs101.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright 2024 Linaro Ltd.
+ *
+ * This header provides constants for the defined mailbox channel types.
+ */
+
+#ifndef _DT_BINDINGS_MAILBOX_GOOGLE_GS101_H
+#define _DT_BINDINGS_MAILBOX_GOOGLE_GS101_H
+
+#define DOORBELL	0
+#define DATA		1
+
+#endif /* _DT_BINDINGS_MAILBOX_GOOGLE_GS101_H */

-- 
2.47.0.338.g60cca15819-goog


