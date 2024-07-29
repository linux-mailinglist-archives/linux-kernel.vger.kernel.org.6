Return-Path: <linux-kernel+bounces-266352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8793FE96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB61F22127
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265FB18C324;
	Mon, 29 Jul 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTrdC4lJ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28831891C6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282745; cv=none; b=bIaZWjSC6svaeuL7Wfy5Y9TqYEHOsabGTxLlGoBTBAAfN8VxBu1TBZv3lTln6FI4IEzN68P96QTrdZnKA1UjIpwW4LN65AzXkWD8WCxfNbyLSruH/nRj+x+DGXQUzSDB0PbUPI71Unn9Y3nyxGCKsnQqEewlT6eDgqHcJOKuP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282745; c=relaxed/simple;
	bh=1JDpJg4D5mnG6rxlSXya5MgNo0kQEJZBIz2UcIt5yCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UsVUHXc3janVlvd+ksEPuV8onqkTSszGr5PjBK4pWB2deXCpWhIT3EJUA5K04hQi45dO2/YlnH3mkuGvfnpIaajfwjh2AA2iKNxDbXBzSLcPo4KwBKw7TatyLMirf02v24QOE4975FDY1y2XynJMOw7+rBO/Kup8VDBHrhhk+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTrdC4lJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso4540193e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722282740; x=1722887540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z48cJN8bsHcSp42cPATakCbMPlmNxxITyOVFPogjtvg=;
        b=UTrdC4lJYNkk4dQErrBwxOCEL2/sw6N+rJf1NNr/F0DX8KEw+H+2LEjkg2Xdk4edof
         78n5+8AXUYn8wtbEgH25DXSsWLiSiXpFYycE7OLzLKK95TOuh4B3UpZEFA0eaROAUvdh
         nC0lNX8Z6cUQzqkJZEBChSQFsO4bjA5x8rZQCxEe7eMCK3CLKBuTJ1bdDctSdjL7CUhL
         yptkROIqUsd1rlEdPHea7DmQvSNtuwjqt/oOALRaHJT7XAalWg0YOa0SV8Xq8C88BAxD
         MlBcziY1THy3XCf+p3cdp96rJJEvNC5nCQX1Y/epS3//4+kTQOxbkRRdPIvlDDAAEQEA
         PEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722282740; x=1722887540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z48cJN8bsHcSp42cPATakCbMPlmNxxITyOVFPogjtvg=;
        b=mQo/4My4VzyUP71dsU4c/7oGKWCfsAzAUBWdDlxTRh6vkfhMZ7/7yhw/DwoaXx+hxQ
         +HyQeUEn3htaQ5E79IRO8R/B9CKRYzRZ2edDr0I4zI32Bhiby6jxcwnVAIRYDnAyrEzW
         3cMHeQQDD99WNXqmfx3HYSjB0gQwtx6ca1hf8FX4fHJFr/3+IvHM6X+yRSgztNbTi8d+
         +8sA8apgWf+KMF9qU6LDifpxw+eSS3BMzR0uhhmeb13IbzF3A3m0C2b6Ysxa/uC7RYc3
         N5MyBYrqCW69+TzcdiIp/4sEi+5W67709chLhC/Iuxw+MLe1MFk+Pk1K2+d/eeQlh6TI
         rjCA==
X-Forwarded-Encrypted: i=1; AJvYcCUnJqQ5ynAxeG55KuEjQ5NBmgnpjwcL+Y4JiE0QEHELw8uMckvP0lahC1GsCTBf5bGK6KI91pRETFfdqHObxinoG1+IMbrn11C3iStK
X-Gm-Message-State: AOJu0Yy/QnSHDL9Mu4fwjmvIaZnHki8k3dGLbUeS3EufQ5T3KkD7YEwy
	PmKGNHHJTC0vpC8+v18F/r3yfoQoS1eW3B5RA+DNfdm8Kfp2zPHk5eOL4kdxaSQ=
X-Google-Smtp-Source: AGHT+IFcaKUwE6nw58d+MaCnRlOtr9ZAVvHele9K2bliHS/NEwazq7CG2wLr+msRJzjdwFVnFB1bnw==
X-Received: by 2002:ac2:4bca:0:b0:52e:9fe0:bee4 with SMTP id 2adb3069b0e04-5309b25a273mr5894940e87.9.1722282739977;
        Mon, 29 Jul 2024 12:52:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd1088sm1615590e87.106.2024.07.29.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 12:52:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jul 2024 22:52:15 +0300
Subject: [PATCH v2 2/5] dt-bindings: soc: qcom: smd-rpm: add generic
 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-fix-smd-rpm-v2-2-0776408a94c5@linaro.org>
References: <20240729-fix-smd-rpm-v2-0-0776408a94c5@linaro.org>
In-Reply-To: <20240729-fix-smd-rpm-v2-0-0776408a94c5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-clk@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6374;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1JDpJg4D5mnG6rxlSXya5MgNo0kQEJZBIz2UcIt5yCE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmp/LwR8pGhbfM1GtrQTm+ZLaqyAWQ7eK4uhzfH
 WdV99zdoRSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZqfy8AAKCRCLPIo+Aiko
 1Qu4CAChkTQQu+D2Q3DYhFnTtiOJZcnzT4tw+OmUtPvnE3wrdXUmPLbNL+Qe/hlQj9q8FXOb1i0
 MAXHqOe9xi/djn0/l3DN8/FnmKtUTaVUk3cpsDZu8jXehrrAPtM0nbCRS0ZNZEV6XuSdOh0qo1s
 P81wKJtFvpeI5W0LDFT2p2oEqE/zgb0a9LeETEY4mHc4OIaHCZU8bTnZ3uqnXuu/xDIkJ9HSCr9
 xTDxGbFEbXwWLaWe41AWUil3so4QOe+Ej9xNXZdCJJ9DMZO2j6NTL2DzNYmGP8mb/chR6p6SJAf
 5GM0Oel8/rlBJdDCZ9DIF1aYoJ+YZlN95NTBNLe1XJiuLHGP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add two generic compatibles to all smd-rpm devices, they follow the same
RPMSG protocol and are either accessed through the smd-edge or through
the glink-edge.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |  2 +-
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   |  2 +-
 .../bindings/remoteproc/qcom,rpm-proc.yaml         |  4 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 74 ++++++++++------------
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |  2 +-
 5 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
index 3665dd30604a..02fcffe93f1a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -139,7 +139,7 @@ examples:
   - |
     rpm {
         rpm-requests {
-            compatible = "qcom,rpm-msm8916";
+            compatible = "qcom,rpm-msm8916", "qcom,smd-rpm";
             qcom,smd-channels = "rpm_requests";
 
             clock-controller {
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
index 3766d4513b37..c54234247ab3 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
@@ -90,7 +90,7 @@ examples:
         qcom,rpm-msg-ram = <&rpm_msg_ram>;
 
         rpm-requests {
-            compatible = "qcom,rpm-msm8996";
+            compatible = "qcom,rpm-msm8996", "qcom,glink-smd-rpm";
             qcom,glink-channels = "rpm_requests";
 
             /* ... */
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
index 7afafde17a38..0c3e668b5d31 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
@@ -142,7 +142,7 @@ examples:
         qcom,smd-edge = <15>;
 
         rpm-requests {
-          compatible = "qcom,rpm-msm8916";
+          compatible = "qcom,rpm-msm8916", "qcom,smd-rpm";
           qcom,smd-channels = "rpm_requests";
           /* ... */
         };
@@ -163,7 +163,7 @@ examples:
         mboxes = <&apcs_glb 0>;
 
         rpm-requests {
-          compatible = "qcom,rpm-qcm2290";
+          compatible = "qcom,rpm-qcm2290", "qcom,glink-smd-rpm";
           qcom,glink-channels = "rpm_requests";
           /* ... */
         };
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 2fa725b8af5d..270bcd079f88 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -30,31 +30,37 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,rpm-apq8084
-      - qcom,rpm-ipq6018
-      - qcom,rpm-ipq9574
-      - qcom,rpm-mdm9607
-      - qcom,rpm-msm8226
-      - qcom,rpm-msm8610
-      - qcom,rpm-msm8909
-      - qcom,rpm-msm8916
-      - qcom,rpm-msm8917
-      - qcom,rpm-msm8936
-      - qcom,rpm-msm8937
-      - qcom,rpm-msm8952
-      - qcom,rpm-msm8953
-      - qcom,rpm-msm8974
-      - qcom,rpm-msm8976
-      - qcom,rpm-msm8994
-      - qcom,rpm-msm8996
-      - qcom,rpm-msm8998
-      - qcom,rpm-qcm2290
-      - qcom,rpm-qcs404
-      - qcom,rpm-sdm660
-      - qcom,rpm-sm6115
-      - qcom,rpm-sm6125
-      - qcom,rpm-sm6375
+    oneOf:
+      - items:
+          - enum:
+              - qcom,rpm-apq8084
+              - qcom,rpm-mdm9607
+              - qcom,rpm-msm8226
+              - qcom,rpm-msm8610
+              - qcom,rpm-msm8909
+              - qcom,rpm-msm8916
+              - qcom,rpm-msm8917
+              - qcom,rpm-msm8936
+              - qcom,rpm-msm8937
+              - qcom,rpm-msm8952
+              - qcom,rpm-msm8953
+              - qcom,rpm-msm8974
+              - qcom,rpm-msm8976
+              - qcom,rpm-msm8994
+          - const: qcom,smd-rpm
+      - items:
+          - enum:
+              - qcom,rpm-ipq6018
+              - qcom,rpm-ipq9574
+              - qcom,rpm-msm8996
+              - qcom,rpm-msm8998
+              - qcom,rpm-qcm2290
+              - qcom,rpm-qcs404
+              - qcom,rpm-sdm660
+              - qcom,rpm-sm6115
+              - qcom,rpm-sm6125
+              - qcom,rpm-sm6375
+          - const: qcom,glink-smd-rpm
 
   clock-controller:
     $ref: /schemas/clock/qcom,rpmcc.yaml#
@@ -84,21 +90,7 @@ if:
   properties:
     compatible:
       contains:
-        enum:
-          - qcom,rpm-apq8084
-          - qcom,rpm-mdm9607
-          - qcom,rpm-msm8226
-          - qcom,rpm-msm8610
-          - qcom,rpm-msm8909
-          - qcom,rpm-msm8916
-          - qcom,rpm-msm8917
-          - qcom,rpm-msm8936
-          - qcom,rpm-msm8937
-          - qcom,rpm-msm8952
-          - qcom,rpm-msm8953
-          - qcom,rpm-msm8974
-          - qcom,rpm-msm8976
-          - qcom,rpm-msm8994
+        const: qcom,smd-rpm
 then:
   properties:
     qcom,glink-channels: false
@@ -129,7 +121,7 @@ examples:
             qcom,smd-edge = <15>;
 
             rpm-requests {
-                compatible = "qcom,rpm-msm8916";
+                compatible = "qcom,rpm-msm8916", "qcom,smd-rpm";
                 qcom,smd-channels = "rpm_requests";
 
                 clock-controller {
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index 4819ce90d206..d9fabefc8147 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -56,7 +56,7 @@ examples:
             qcom,smd-edge = <15>;
 
             rpm-requests {
-                compatible = "qcom,rpm-msm8974";
+                compatible = "qcom,rpm-msm8974", "qcom,smd-rpm";
                 qcom,smd-channels = "rpm_requests";
 
                 clock-controller {

-- 
2.39.2


