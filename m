Return-Path: <linux-kernel+bounces-190243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C58CFBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949E51F2171F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28E13B790;
	Mon, 27 May 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip6aD4TF"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0E13AD28
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799370; cv=none; b=hxg1hR6LwotSndIoCNbL5hsyG68ci+63KDMy+U1l+T0V0KQr0b2SSX81mTH0Z+EgG4tL5NrTPwkxzYH7OZW2fhTzUKT9i368/d7LthUHr5dAAiGDadQaEXfUbkva8JXPsNSl1/lNiBQfJp0sVXjhk7AFEaoMzq/qpKn90TAkiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799370; c=relaxed/simple;
	bh=FSjR/z57MPpK+sFVQN3f9Y5HY3fXrry6aEHjLvU6BMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxQmrQ4RECFFvlzueKkZRVqlRkWTeIT8ey/DIIkkvPmo/xMV242u5UrwWobvzqxwl2c3g+WoY9Lzmw/YsH7FuxV14d4o26seFii5upo2q5Ol6g/dXtzJbAzFqTaNV7DKP5xLp4FGq+PTx/kG37uCv/R8b4RCOU5gRPLDfRzySqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ip6aD4TF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so38586831fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716799365; x=1717404165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYVqqrufrlU4tP6uYGCro4lra2OX39FvNlNmisAjzCU=;
        b=Ip6aD4TFAy3QRpADw9fijpETJx73qabS5Tr8Fi/sjvsRgXMgmw6AkGPR0yx/oHWgKk
         ch0MXKh0834kyzDPiI1HMLW61FIj1mYWtipaMtBER8EfGTpWSrSpshVTQ6zNR539l7cZ
         Sx4v/PfZdBXRXnBKnLzjaO5XhYWUx1vVIq2D8WKG2/SXp6ec1I35K6Yq0G4aHaIflZ+4
         cJ/ftk7izb6ejNkkE+swdwwV/p8rFoSHKndI42sfZpojAcLR8VUVy210+U6JLiUwu7y3
         hBWW8sPCkZ4RqwKh3mwibBYrhR854v/YSri6DMmlTgS0NW0ZXaGF2Ub2eQ2YW1YoDnBc
         NdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799365; x=1717404165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYVqqrufrlU4tP6uYGCro4lra2OX39FvNlNmisAjzCU=;
        b=kSlqLAeGuBliOdd1RSxbccAZMr8HgnOvTOrLGLQPyBMnHWHPnx8x7Ybp+zM5BN5u3r
         FNsNA/FA1D/Ah6ZD3yGJRG8wYDH5lTun/tbhXebwlsROPbUhIL4Mn4K0pMV5h501RfLe
         GPzQwEfovwipRS+tpNX+A6XLfvfOOmCTCCAdLu2FAiu27IbelsoeRpqoXqNFH6TisyOW
         jhQKSZDhpk6P/cAzACCcuaeA2oHU96oPzlT2lXBcc8j2g75UKaD4iqiS6OU6Fg1q8CLi
         gGdUMgBXEZ8m7Pux/U1nyPdrHaFm2ppLv6dJQt7Nozm1Z4nvKwc4aWJHuo6xBhyytKVb
         MoQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz6LTl0avU5v8xc79pmtnmruKshnTPFBHJGE38UjGHH0GqC0quZ//dGauUQNefXmI29rsaiN4fWRS/g1im5iXwCARAQ4+ihKi4mKSD
X-Gm-Message-State: AOJu0Yx6sqKZr5LV1qhjTje0VmZFugvu9/FRTLi8yJDgM3lbyLw0orfz
	4FSonw+AvPiagodMeOPE5BhzuGt/jEHmlFrt5uxZmBrUhpZw+TOuc/H4xOLtYRM=
X-Google-Smtp-Source: AGHT+IGqVjhmpV6P5dYKIK4bQm7p4J/a/8bHzzCxS0JX9QjuVHpgXeL4JdCcI+kWd/pi8uJ22Nc/vQ==
X-Received: by 2002:a05:651c:1992:b0:2e7:1e4a:31d3 with SMTP id 38308e7fff4ca-2e95b097761mr98346481fa.16.1716799362952;
        Mon, 27 May 2024 01:42:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3558889fb57sm8447292f8f.114.2024.05.27.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:42:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 27 May 2024 10:42:33 +0200
Subject: [PATCH v2 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp:
 Reference usb-switch.yaml to allow mode-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-1-a03e68d7b8fc@linaro.org>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FSjR/z57MPpK+sFVQN3f9Y5HY3fXrry6aEHjLvU6BMI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVEd8GmfhAqkq4Fqoj88/8nK66iClT54YKRfYfb0P
 0PAPK7+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlRHfAAKCRB33NvayMhJ0Q0nD/
 kBMcULAeJSxBGlLBsUcLneHOfYhQd3mHi+3AO40RXHfYiJ/HadsPEmSIK6u5QxD+p9eKXY6IBqfE+L
 IP1psTwbYV59r9PQclAq+evAa0bpzxtlHXIt9tH/hncy6Lj5fSYImp5GvMFdLZy3hgPcZtNfxmgDc+
 obFtz6z9+9R/5OaKbFf/gofv+/Djfw1H0V1zX8r1gzws1fTQGUnPqXQcuV704oKNT8k3Lcbbhnm72A
 SJgbW/jT7H98OM42FjJQn26g6MOdrL4bvCVj9htpoNZIEgv1l6U5wEWx9VhnfTnJjJKUO85mOXqGeo
 GT55odHIc+yy6nyZtlk8sCEVWb5Tc2hY9akaeF1HL6iYkT8OUGOETN4YqEs5F6B1h8xEUZf11F0lNI
 +KbxRgq9nb27IapqLzD2RGKRl6E4JJGG+63A2jxZ7mhp1HHddOTTGXnCqsvRQuY+jyhCLIx/XqpNz4
 MsA6SocfppaHs2Vse1Om19Xsbvl/yXqmw5PlOPcp7UO0IxWywKVhZp/9EgJVI8WdwRpps4fkDgDBtu
 MJ/leX8S5QAiwCCJxz/sekNnBmYC07ILgdMkmMLhgrHoZAwmoAbo/HaA65JV6Dk2LHyMtk4aYbfOJX
 jO3weNYZlRKf/xhplQ5j13g5oi/kTsfRzIpOO3HztKCljQIj2ssFvsNPWRzA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The QMP USB3/DP Combo PHY can work in 3 modes:
- DisplayPort Only
- USB3 Only
- USB3 + DisplayPort Combo mode

In order to switch between those modes, the PHY needs to receive
Type-C events, allow marking to the phy with the mode-switch
property in order to allow the PHY to Type-C events.

Reference usb-switch.yaml as a simpler way to allow the mode-switch
property instead of duplicating the property definition.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml     | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 2d0d7e9e6431..5358d3a6fde3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -71,10 +71,8 @@ properties:
     description:
       See include/dt-bindings/phy/phy-qcom-qmp.h
 
-  orientation-switch:
-    description:
-      Flag the PHY as possible handler of USB Type-C orientation switching
-    type: boolean
+  mode-switch: true
+  orientation-switch: true
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -104,6 +102,7 @@ required:
   - "#phy-cells"
 
 allOf:
+  - $ref: /schemas/usb/usb-switch.yaml#
   - if:
       properties:
         compatible:

-- 
2.34.1


