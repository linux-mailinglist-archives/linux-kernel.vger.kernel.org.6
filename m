Return-Path: <linux-kernel+bounces-573371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64297A6D679
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6C13AD6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F625DAF9;
	Mon, 24 Mar 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="T5xDHaeJ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A925D8E4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805673; cv=none; b=ZqpAIY3s+oI/iPmM28DyzcbCra+t/nJO6sUtkkb1X5kUoN3gZgW3wMEulhLWWBwUTc+jjYNtzMTcl1V+Xpgbn+lCS+cTDgx+Pwd5hEfnL0hv7ngjB6jeb6vGpj4EvbOHg9RnmMhzHzkQRw1aHcywfEamNSz4tTC5Fcozna9fLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805673; c=relaxed/simple;
	bh=GLAsUw1OONraXoc4O2AxkqLiMT4MdPKRGHr5nbrSBI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTW8nmv7YUg+4U0ThMSTatfDlL3xBBagInTQzzSEhVtKVIMCBXIodWeiWUzXK4aVGggywMZJhNGi18S9bPS4v+VL2cg8Cfy97OywO6e9DZnlShN0TBoPTB3X9OjXqJXjwWgYq69o6j0xD4NlvZ7Qf1tDVZP9RISi6D4wYEYEG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=T5xDHaeJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so6381630a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742805668; x=1743410468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHERlL971lhRhRNPhw773ZN7phaB0MazKYjf9mnRkOo=;
        b=T5xDHaeJdhNYbVjkiU0qmpziz5FYqA0/E69+GlOtc2ruR9Eu1lJz8JbtD8IQEcrib/
         JiZaPeEV/5h6MLw78ryzML3FX4p8pDFr9SVGayw20yz6YMlS1IOOdJ2Nm+wf2r1DoOq3
         TJP/1LralDz2AgfjjvsC1CGrCQ1aWTMnMOAdYMlQnjFN3I0FZdfRATW5LHrAt4rddz+v
         pi4x1n4Sw788bJiJ3+8k5L0oeH39+IEIWI1E7JzBt18GUhpPXiI8xPWCfD8ymPf34vYV
         HHcctPH+af5sSfVKzFwqknWZOCPmQuGI5WKtPQGohjg3wixbVnOvRbYMaEBCIM913njD
         aXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805668; x=1743410468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHERlL971lhRhRNPhw773ZN7phaB0MazKYjf9mnRkOo=;
        b=VvKa66zTpZmpwP/WRgEmZFxFca2tdCULP4y4N7aoz6FbIKwRtqWkJdxa0VXwC7shMI
         mvsxnw/wzpHdudOxz3bnrtr+Eyv/sgp5e18BicSI4nKunk9bi552LTJmzmaqIWy8o84z
         L5hdsSr66DM53IMP2F81KzSZ76Ex5qQ1wC/Z+qGsiJyPnUcC1p1WRacW/bCvJO9vjerV
         NrvzVaY8XNFpqxtmHodrivsMniRp7CXEnAhm8iBpb26QQN7dpA1Ehm9PGvzMteLJ6YZG
         wIAZtW3abl6pZ18NZjqGvAaOmPY2pby4gdhHci4gGcowwKyWWX0GWpBT+FC7Dh3Lwge7
         b5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCKdgNoUkkb/q7clYCYYhSTUof6uS5+2jBUo93Ir/atnrB6Ac27lXGTAUtl8mBwRnWk3lo0K/MIiIOQL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpwzR5tCGkyut4Ieh9+FjErIu2Ojw+Mmc4pP9nDAqFEyBWwli
	15N5pE2AT+A5ZlKqxH3I9OTFj0IzdNvqiGIUwLbbikAozLtg9duxm0yEQVYWlGQ=
X-Gm-Gg: ASbGncvgqMVUkOwDUg3zOn+kFHdxfH0g6PgkzZiE1K5If7ze0IuJsNsyNHJMD+1RsHN
	2b7jGuS+a8XKJwtAtoP1VawFLGqPyQguY9WjEheV3VnSJ04tXp3d9HMhW8Ksvl96OtQZAd4KvaO
	bee1hVjJmpCRK92d+CGlafACXtEwM5RPwkW/GToJ76XyfewOFDK+FxMYURaReLkQWuKLlYJfBY1
	zDa7UumWRxzM5twWoSB/0GYLED2ex+H2vnU0rI3PRMMDF6F6RlEqOl93h7qInK2HYOkzTLjWtz9
	H+pTI8L7G/unJXjzAWSw+oNJkw+p5r5IikLId61IIPVIcmP5yxvjLhOlHe3RugbZrE//IvKNzGX
	DPxbr509LtLaUgoCpeQ==
X-Google-Smtp-Source: AGHT+IFE5/MpqqL2hNF98hOzKJwcxXpuxQ2ZxAMOx5ASm9H25AMrv76V9q9yPx88TbUT9h5ov9f4lQ==
X-Received: by 2002:a05:6402:35d4:b0:5e6:466e:5866 with SMTP id 4fb4d7f45d1cf-5ebcd4ecdeemr10659531a12.25.1742805667522;
        Mon, 24 Mar 2025 01:41:07 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0dfb33sm5715937a12.68.2025.03.24.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:41:07 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 24 Mar 2025 09:41:02 +0100
Subject: [PATCH v2 2/4] dt-bindings: clock: add SM6350 QCOM video clock
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-sm6350-videocc-v2-2-cc22386433f4@fairphone.com>
References: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
In-Reply-To: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

From: Konrad Dybcio <konradybcio@kernel.org>

Add device tree bindings for video clock controller for SM6350 SoCs.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 ++++++++++++++++
 include/dt-bindings/clock/qcom,sm6350-videocc.h    | 27 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 340c7e5cf98024dedad6d7db4fea10e9f8077419..5f7738d6835c4ba999402e163fc85a07e3a47a5a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -14,6 +14,7 @@ description: |
   domains on Qualcomm SoCs.
 
   See also::
+    include/dt-bindings/clock/qcom,sm6350-videocc.h
     include/dt-bindings/clock/qcom,videocc-sc7180.h
     include/dt-bindings/clock/qcom,videocc-sc7280.h
     include/dt-bindings/clock/qcom,videocc-sdm845.h
@@ -26,6 +27,7 @@ properties:
       - qcom,sc7180-videocc
       - qcom,sc7280-videocc
       - qcom,sdm845-videocc
+      - qcom,sm6350-videocc
       - qcom,sm8150-videocc
       - qcom,sm8250-videocc
 
@@ -87,6 +89,24 @@ allOf:
             - const: bi_tcxo
             - const: bi_tcxo_ao
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6350-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Video AHB clock from GCC
+            - description: Board XO source
+            - description: Sleep Clock source
+        clock-names:
+          items:
+            - const: iface
+            - const: bi_tcxo
+            - const: sleep_clk
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/qcom,sm6350-videocc.h b/include/dt-bindings/clock/qcom,sm6350-videocc.h
new file mode 100644
index 0000000000000000000000000000000000000000..2af7f91fa023bed469bbb2c071d93383dba29441
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6350-videocc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM6350_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM6350_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_PLL0			0
+#define VIDEO_PLL0_OUT_EVEN             1
+#define VIDEO_CC_IRIS_AHB_CLK		2
+#define VIDEO_CC_IRIS_CLK_SRC		3
+#define VIDEO_CC_MVS0_AXI_CLK		4
+#define VIDEO_CC_MVS0_CORE_CLK		5
+#define VIDEO_CC_MVSC_CORE_CLK		6
+#define VIDEO_CC_MVSC_CTL_AXI_CLK	7
+#define VIDEO_CC_SLEEP_CLK		8
+#define VIDEO_CC_SLEEP_CLK_SRC		9
+#define VIDEO_CC_VENUS_AHB_CLK		10
+
+/* GDSCs */
+#define MVSC_GDSC			0
+#define MVS0_GDSC			1
+
+#endif

-- 
2.49.0


