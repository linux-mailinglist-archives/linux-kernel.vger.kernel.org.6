Return-Path: <linux-kernel+bounces-176747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C238C345D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51C51C20E60
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A20433AB;
	Sat, 11 May 2024 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWpDQekE"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606B225AF
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715465053; cv=none; b=dJOswSl3oGospRFHOgN4o0F5zKqoLryV/mx1dvPUDqc89m7sFGbKgGg6ybAfrCwttHbd1gPNVcMjiZsirv5m4uLZwXF18T+H1j5Dz7NBynqEYirFGL2FAg1MlUODwvnZ1eUR12WW/gYymmdQMhlf3DDvgJxUDVNwcKZ+AQiI6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715465053; c=relaxed/simple;
	bh=Pl/YNaCowSJwtvM5CLxzriI2N0LVr+hVT798TnH3gks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GY2VwzSvMvo3l8hxgcEQCB55ZhtXSFR6r5hbHYF3OYFDBrBRjqJC7H0zAv5oCnQQ3zcIFHoXqPaQ82E45D4VD4Qzq9QSlT/o30CHDRknVGqJ4HVD9aqWmwiiBS75BrLFAngEM9xE+8hZpPtoX3u8Vn0fZJNH6MPVMoHUMcoILhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWpDQekE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e1fa824504so41266271fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715465050; x=1716069850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGbtrKVvMS3wVGFki5Rf2NIaUlWzz6uY1OnrfScTkhE=;
        b=NWpDQekEbgD6Ysagab244rUMweOfy2WbIANLCDW/e3lYEC1FcGetqwKQj36B3dUg8e
         GKcURVE/2WCcnmYEohr6uCweGYDUndkoTbwoqgcnaBxg5V/icCvlRIzPJVvWvWZd2kbG
         RpcENDs42heuRNFNin7r5Nrw8oAR4dbzK449M7jXT1YphWZ8X+CS1ZPs/8sQjDDgmWYC
         9GxhGb3PrFWa2B2Vp6wyXuA3d+Bxt9V9Ke6X4q4VYlhM8iBBLmJ++4zP0ePA/AJGRAOi
         Nfwjh7/qi03X1x4hs6Wwtd+Iyn0WPH8JvckD+EOJ4cNLBZhaQ0LnGPAew2hna+0l3n16
         M7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715465050; x=1716069850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGbtrKVvMS3wVGFki5Rf2NIaUlWzz6uY1OnrfScTkhE=;
        b=Mg0rgp9ZLvtVVGBcVb8kGmNNPhk1RfGj9WfpVy5FxAeMCLrowV8JvQNbE3BQbo6Q3v
         84sjZlSc7ChEk65knMGGTrpLB7yCJ/33PYrieMJBTdxX9krmK51IupP488kKnIhu9JWp
         IxtCEsE1h6Qd/T28uRMe7S2Bd0FaybzIzS3ymBubDO8zdADwK8ex3zxjZvDREDj2C3y7
         SONzWs1a4jGU+6UtYN9yS634qUGeB1c/BGPYnpL6SqET2LUXeC2G89W1333v9MJrx+xK
         C2+li0SCvinL+jYTQfu8PdJ+pX98nhGKTJQdY36x0LHtPu3eXiUTp/29NV5zxTOAS4tE
         ERLw==
X-Forwarded-Encrypted: i=1; AJvYcCXRyZWBskvFj6oUXEgYghOtkpCak6B4sG80s1XXNi2MQY0K0kc/ATWvET86f04sn14+9nBxcXDP3q/kCOjsKFu/FMccdZ9afee4q4O2
X-Gm-Message-State: AOJu0Yy57oYK7V+NGqh9JPuMvB/McJ4On3X2Rldu56zrGPUxxn/kdTO5
	cr94EZ6APL8Pph5hhkM8zt1sjus/DgSsc9k9fmatC8nyrg25XXtx3p2FZ0pHPCA=
X-Google-Smtp-Source: AGHT+IEwNjYLeCCD4oxMulDqDNZbeEEPPW+1lZfqLN4je/0vd6KnbpaLx2WrA85yPfFv0dgSXXe+fg==
X-Received: by 2002:a05:6512:3447:b0:51d:82a2:8d72 with SMTP id 2adb3069b0e04-5220fc6d7fcmr3258054e87.40.1715465050072;
        Sat, 11 May 2024 15:04:10 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d878fsm1123875e87.206.2024.05.11.15.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 15:04:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 01:04:07 +0300
Subject: [PATCH v4 1/9] dt-bindings: clk: qcom,dispcc-sm8x50: describe
 additional DP clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-typec-fix-sm8250-v4-1-ad153c747a97@linaro.org>
References: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
In-Reply-To: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Pl/YNaCowSJwtvM5CLxzriI2N0LVr+hVT798TnH3gks=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP+tXp0Q5GwpORS+iXqTB5ajH8osXG5Ezc0mES
 IOnbKfLsZSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/rVwAKCRCLPIo+Aiko
 1RZbB/9jfNSvkrAiw3FfSqlT7aAyrEiQRJI/7aZT73ThY08D9L8FFb8NDFAcOcZ3/+053LXmFG+
 7Q442pF4cmedrD8wYwP3gFja36hQ9tkKQM6yGvG0Hv5fZm9l1rhA2TPWYZZEeGv+1K5mKmY/L96
 e2YRvo1w4VJYmnKtThuFlqakeBXsRjIc3xGq928b+yjpsl6yR1hmMsP6yuYJU2b19mzlaHbMqfQ
 SmM3zfh1gDpOF69ODUM/GRk3Nj2Vs5eXlQ/9o6Sf/WPLsZfTovepUjeKXwDTzUzOvHT6tJP/VmG
 vjvVve7M2ka3tZg4hBSZ/drWzqx4onBz/mCErRXDBej7DjMt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the affected Qualcomm platforms the display clock controller has
additional DP input clocks, describe them in DT schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
index 59cc88a52f6b..5831579b572e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
@@ -27,6 +27,7 @@ properties:
       - qcom,sm8350-dispcc
 
   clocks:
+    minItems: 7
     items:
       - description: Board XO source
       - description: Byte clock from DSI PHY0
@@ -35,8 +36,15 @@ properties:
       - description: Pixel clock from DSI PHY1
       - description: Link clock from DP PHY
       - description: VCO DIV clock from DP PHY
+      - description: Link clock from eDP PHY
+      - description: VCO DIV clock from eDP PHY
+      - description: Link clock from DP1 PHY
+      - description: VCO DIV clock from DP1 PHY
+      - description: Link clock from DP2 PHY
+      - description: VCO DIV clock from DP2 PHY
 
   clock-names:
+    minItems: 7
     items:
       - const: bi_tcxo
       - const: dsi0_phy_pll_out_byteclk
@@ -45,6 +53,12 @@ properties:
       - const: dsi1_phy_pll_out_dsiclk
       - const: dp_phy_pll_link_clk
       - const: dp_phy_pll_vco_div_clk
+      - const: edp_phy_pll_link_clk
+      - const: edp_phy_pll_vco_div_clk
+      - const: dptx1_phy_pll_link_clk
+      - const: dptx1_phy_pll_vco_div_clk
+      - const: dptx2_phy_pll_link_clk
+      - const: dptx2_phy_pll_vco_div_clk
 
   '#clock-cells':
     const: 1
@@ -68,6 +82,20 @@ properties:
       A phandle to an OPP node describing required MMCX performance point.
     maxItems: 1
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: qcom,sc8180x-dispcc
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          maxItems: 7
+
 required:
   - compatible
   - reg

-- 
2.39.2


