Return-Path: <linux-kernel+bounces-252245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E35F931083
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1945428276F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF15E186E44;
	Mon, 15 Jul 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/SerU87"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E81849ED
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033030; cv=none; b=ex7gBUjBOfizQgZB+P2LGjzUxqlsdcndvQtmTT0JRmwjIXWV8QmlNraW+sEnVIDhhEl1KPqLIXWP8hq3lJfiZybbqKBtuVYkzaf3hd3qs+e0isqaUnLeysFkungd7fXRCgA6xM7pd/Zst50td7N53PmlchSQ0kRvQ4SPajg6rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033030; c=relaxed/simple;
	bh=S6vkVSNbhG89L370XvJhZTmegxYe3oPBTnuAUQ0eJrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mH8iU7IGLM+UKuJ8lF7QQJF1OhtqIlDxIHeweznHH0K6MqWAxE7vUx5JcMZDP8wJ2Bmzv0a3aMc7lXhs+LEcdvTtNJUmS2BY/60JQrxkQWUfG+BYHLk5iu0OJkRysxvRqRdfk34KG256xbwBiXKM6XN66Wv1O8TXjcnFTJUTehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/SerU87; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so4178240e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721033027; x=1721637827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsdzpTRLXnS6olUqpcfoyueExAl5OEraVlLDAUpRwyY=;
        b=B/SerU870wcbZokm85hUBUHwM+9z6ZL7qOIDyFTS43Wc3xw5Id9ydGmQ99eJkCkep5
         iO9NtuD9iTSNFJENzvyIwv+69hz8JjbPLH35lqpPuyHKlRZxInOTM9gsCAbocD9rKvvl
         2gikCfDvdnWfwfBWC/PumTOelhnXcxkos0rZuS5xehTl8477ogd3CGJ6nQHy6iUCbg05
         WAsDRspgyn8oKdhrLgaN7XI3bwohymNQ5udHvNQWjqeXUd9GQQAUw5padNCk6kCZk+iS
         eszqwMJu35bf/qM0XsimphjUKzHQBEeB6tJU8mal9YyCZm7hZf2J/SL5eSsGjaI5wGrn
         Oshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033027; x=1721637827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsdzpTRLXnS6olUqpcfoyueExAl5OEraVlLDAUpRwyY=;
        b=USAYA2i8/GNYjwNMmZoioL484QKUmOyOM5t58FY7DCpzerEINLvqwsRmpcMDmWMnXx
         TRo+byrostww01NFZxWtxqNkAXZHFfPqY5TDBcqSDJRjNQ0k05bIlnkPNqGky7S7p3qV
         1YifvrKo1hLTXlQkC9VYfvXRz73WvLsNko+oLoPpuZLE8mXTXWTZtYqiKytXOQK2zKgE
         BVnO1Vtk1mBF8CvKo2ojZH/nLbsDLIlQ0a+sboHFPIFAiNpalrup7fjjVmR5MK2OD6ph
         eLKXgnEANS3CMwJ+RfdV6lXsrQ/XDD+4D3VtbjJaK5MLUiRhtL+Kvx5/rdbXig+9aFiK
         fAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwBAhD8Fjt+h3drtOXEhlaq7mSBiAu5b0p/a3eOabnoajHb+MJuDC+0S4KCc0rKNE1OIKAhqhy/3Kkschf7rLwExAFiSFEVTefcYKv
X-Gm-Message-State: AOJu0YzeysDLaM0/rW7Rcwwx2jWVKHfDvoZbRNFGZfK8PlBRTP5PJArl
	aSZ4N0p9xvVaKRRotUiqDITbyoZQQHINyQfwEZL4s+edWhm1B9veMhA9iLrF3Es=
X-Google-Smtp-Source: AGHT+IFZ06GISOlCShv8E0xL7DUeyBRRoifs+3mdHj6HmVdE1N6FRa5TrRxeP5KnzTakGhRCH+kIzw==
X-Received: by 2002:a05:6512:3f0c:b0:52c:de00:9c04 with SMTP id 2adb3069b0e04-52eb99d338amr14103866e87.48.1721033027358;
        Mon, 15 Jul 2024 01:43:47 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb489sm77226925e9.37.2024.07.15.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:43:46 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: qcom,turingcc: convert to dtschema
Date: Mon, 15 Jul 2024 09:43:10 +0100
Message-ID: <20240715084313.14098-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the bindings for the Turing Clock Controller, currently only
used for QCS404, from the old text format to yaml.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 .../bindings/clock/qcom,turingcc.txt          | 19 --------
 .../bindings/clock/qcom,turingcc.yaml         | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,turingcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,turingcc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,turingcc.txt b/Documentation/devicetree/bindings/clock/qcom,turingcc.txt
deleted file mode 100644
index 126517de5f9a..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,turingcc.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Qualcomm Turing Clock & Reset Controller Binding
-------------------------------------------------
-
-Required properties :
-- compatible: shall contain "qcom,qcs404-turingcc".
-- reg: shall contain base register location and length.
-- clocks: ahb clock for the TuringCC
-- #clock-cells: from common clock binding, shall contain 1.
-- #reset-cells: from common reset binding, shall contain 1.
-
-Example:
-	turingcc: clock-controller@800000 {
-		compatible = "qcom,qcs404-turingcc";
-		reg = <0x00800000 0x30000>;
-		clocks = <&gcc GCC_CDSP_CFG_AHB_CLK>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,turingcc.yaml b/Documentation/devicetree/bindings/clock/qcom,turingcc.yaml
new file mode 100644
index 000000000000..0a57e42fb4d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,turingcc.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,turingcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Turing Clock & Reset Controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    const: qcom,qcs404-turingcc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+    turingcc: clock-controller@800000 {
+        compatible = "qcom,qcs404-turingcc";
+        reg = <0x00800000 0x30000>;
+        clocks = <&gcc GCC_CDSP_CFG_AHB_CLK>;
+
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.45.2


