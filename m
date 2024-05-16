Return-Path: <linux-kernel+bounces-181569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4938C7DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA676283CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0615821F;
	Thu, 16 May 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHbhKtwR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAF158202;
	Thu, 16 May 2024 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892091; cv=none; b=B5w7mWr4Qdk7yFiZm05WhLAZx8gQouLs9naUPhRiTYBNR3a/YENrbvCinayxEZoKCDaQDfg8/8eQzbHIfVyo703zTnvRJLZ6TUALYMBNUa373eWnFE3iCJRpP6C8K03QVEcDVNlayDetayhh68nNNEx5B8V63xAn4MHn90Bz204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892091; c=relaxed/simple;
	bh=gvMfQjhb/VOFUmjKkAioFSe9h2iL6RMf6plv37DH/ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQ3LTMt4/p4Pfp6G4Wb4tLGq+DckFzV0r74AAUkQKez6k7c182AfRvKV/FMx6x4yYwMIGUdRuajo0udRoOxdgOvqPax0PVLAqXdjUc357K0LFOiLISEW8HX/lj18yGfRW05oMrdZ4cPP0neK5u+vsWtJRlxt12zYmc3NBp8/SQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHbhKtwR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e271acb015so16611281fa.1;
        Thu, 16 May 2024 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715892088; x=1716496888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9bzG+7WWN+HDoYVZdX4V+PH6WrIzda8p1Pj5+2jjMc=;
        b=UHbhKtwR48ARoi1UAEo8Q1wQff7PAMUwmTQSc7ZD9ibAIaFp762K3PsofRM9+dqRzp
         6+O0oIe0VdmxNlV9JfwTFzgylL+CAqxUGZzymI53bPRD670N1PpwuxqI/NJnoy1C1KX2
         fe3xRsh+8Rh3Kt9Q5yZ6IdyKrwTw2GWbOPJi9vKVXbVDXg11zGjouo8PsdpOzebLHy7O
         84nC0XbStPtTqq/mirZu95vNuWesP33VzFw5ncF0O3X7TfNceKKD4VhxE+LBflmYl3mD
         CMxK8Ak+T/CWlD4SNr4hihlMBOm3wE9cz51bdyzzEvjdBbfVVQVZjDY1znRN1/qKL6qU
         AfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715892088; x=1716496888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9bzG+7WWN+HDoYVZdX4V+PH6WrIzda8p1Pj5+2jjMc=;
        b=bCxWU8TkbfGr/NXGZh4CoSGinByH8yd3w3yQb0nbC3oqYBbHn852vHSLODWqnZfe3l
         +dqCAAVGIlzWURHWTjlNEF53+I1wxum0GNkJlTAxJyua7H7coXgkVlRInnu7k9aXYqo4
         djXRoPTYtjRd6GU9GjfuaOV7mOTJG4T6UvdNEx8OFhcU8/oNf9yBa5j7t5sx1bRB/tk4
         Dkawy5Kis87W7K9YZTZ3lXY9KnRSI1Evp4HGMdy72QLWsktLCnGrXPIOsrdaIMjaOKy/
         yB+caA1r7u8vqjlT5BJlaQB1oyujGgvecLJIXyKGd0WBPYVHWk4+jY4hUJ65MlGzVTey
         4R0A==
X-Forwarded-Encrypted: i=1; AJvYcCWQKsx3CTC+CRMWx/zPvaGvaiUOJbLJzgVrGj6T1VDv8QqWXXk/f7vyjYMP0V9PGS/HHLj8SLPKAC/u5MoERsxZ55y6HlfVjmU7tfYNQB3Gq8x5dRyCwcRDaiIfZi0YC94+JKWyEJHYDA==
X-Gm-Message-State: AOJu0YznW10Gk0W4tHavYdqCngKcOlQaz0oCcFSRlW5OSg8lnBz0DHdX
	dl32Nn8Spcqa1pqOugu78WW4qJfvs9Byr9IgC+E0iG4xEKTVnIPc
X-Google-Smtp-Source: AGHT+IEFGSc0CnG+tYsSSgCwy/77Qt99fprI3mfIXypzGxDG0oSuL8FcWOgmKGZrcZQIDfuZ2cY+0A==
X-Received: by 2002:a2e:97c3:0:b0:2e1:f253:152a with SMTP id 38308e7fff4ca-2e5204aef69mr137733531fa.51.1715892088228;
        Thu, 16 May 2024 13:41:28 -0700 (PDT)
Received: from localhost.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2b8f7fsm10859828a12.66.2024.05.16.13.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:41:27 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: reset: add schema for imx8ulp SIM reset
Date: Thu, 16 May 2024 23:40:28 +0300
Message-Id: <20240516204031.171920-2-laurentiumihalcea111@gmail.com>
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

Add schema for imx8ulp's SIM reset controller.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/reset/nxp,imx8ulp-sim-reset.yaml | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
new file mode 100644
index 000000000000..ec9a5c73e83c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
@@ -0,0 +1,43 @@
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
+  Some instances of i.MX8ULP's SIM may offer control over the
+  reset of some components of a certain domain (e.g: AVD-SIM).
+  As far as the DT is concerned, this means that the reset
+  controller needs to be a child of the SIM node.
+
+properties:
+  compatible:
+    const: nxp,imx8ulp-avd-sim-reset
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#reset-cells'
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
+      reset-controller {
+        compatible = "nxp,imx8ulp-avd-sim-reset";
+        #reset-cells = <1>;
+      };
+    };
-- 
2.34.1


