Return-Path: <linux-kernel+bounces-201937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6608FC58D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C3E1C20965
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114C49638;
	Wed,  5 Jun 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoz2oULz"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821D191495
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575013; cv=none; b=nCQCZL7jgcn0bKo7T+26ntkzN+3NyFDMzP8t1Cx/ZA8nA5OZkwjuQjB4uQQGqAN95VKsUozaQGVUsvaDvJQIbtuM9puq8PbUpPt0eG6Gkkjy2dk72iBzi4SQyGbuRsPz9B/ieWt3/tYbthx/EV/+Kq/1ehbgAGJn2e8qpCfEEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575013; c=relaxed/simple;
	bh=f966CIHA2+bp1w+xzJXtK2SZhvIn4S4vZFtZr8TEASc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7GCrrUM027XJdDd69H1PD5ybCiUtjj0Sdps3ndrDv4kBlX1MPF1smjYSYHo7fLCt24hbgtFdut8iuNvnjzbx4Uae6lR57CdU3vSLWQq7kovFc/72qq8GcIqyJ8ERBb9m98GsA5eRP8bnZ1hPHzGKKVYn7sdXj9GaYF/+FYhe/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zoz2oULz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4213b94b7e7so3512335e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717575009; x=1718179809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH4LPM3TWH700ho4Wa1AxXQxLHwri1aWBCuXbmHJtDc=;
        b=zoz2oULzcuqWFatPsmqz47iqkCa6Upd+Ft6j2Zj1eMixIHMAwNpS5QxuTRlfcrmE1U
         /wQiz0UYDm5fW+rPo1FnA6yYdEhC56ssPnxdbosWb8sJBUvuePdZHesldUke7DhHcwUa
         FFFV/u4RGAExcjYYDklgq/dfJPRwKIWW19yxngjklQxPGsWc8Qbty31JRwZqDYeMnIZz
         +Np/TQhXpCVl2HKng7eQbmHa8P62gAZPytxpK2GHiC9Vhs3llA5Nve08b/KGWJCnitR7
         aSz3kDtFRlPacip0wh+kKyOsxin+qbZ150VqLKvP3fUviUJ2BbNoIzaeNQhVK7qAZZqI
         pNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575009; x=1718179809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH4LPM3TWH700ho4Wa1AxXQxLHwri1aWBCuXbmHJtDc=;
        b=juTJge3+FXOqDJS7cxHgQohYQHm5kKnew4ruWYz/gNds6c/vLSoqfG65laOEkw2nmj
         3p6A1J6rAUZmmrMunMFG3WCalOX+8fEjWAUhn3CTnQ+DQGUAMFMSl9KqwLetqKijiV2W
         SG8vtexE1/Jb1Pa9225zb8abYPWmFvkKZofczHzRn8lqINR9DXRI1NNzkcc5vtKgtdNG
         9ugPpv5Lh9NcUCYwULpF+UzsyV0HEq6C8MwmDJoxSjzgNyleeI8lbd/19wDakKp/5hTF
         dUIji6NXwQ4PbLC4s4yfIFlv1t/DNWNVqExaNWtiF2gluAPzLZnnCyUCr0NrAmj1IkFs
         CqAA==
X-Forwarded-Encrypted: i=1; AJvYcCVGkvq/XStthwUuKHYyUkXvQTkYloKvIn9qvprrBKBkRYc7O7e7OE1X28Abk/zH9VwKXladA0jOT3X9826owaeP+vD3g/X7c81cOHPS
X-Gm-Message-State: AOJu0Yy02or34qpNRDSk4nxZIz8o3fC4WOkDIfP0eDbDqpaomL+ktsrC
	Lp+5fJ7YhDQUXXY1UdLXzj3x0S/haBa+pJcHaCbVZj/UJAYuLsd3TsTnalrbga9VRqWrbazAVpR
	h5Zs=
X-Google-Smtp-Source: AGHT+IH8BBxMxYGodh23ucu8kjiGW7R26xSmRY4IJMFbzvwkpSaB7VY6Mx89ZT07BavL8RGgOr/QJA==
X-Received: by 2002:a05:600c:1990:b0:421:5372:c64c with SMTP id 5b1f17b1804b1-421562e59c9mr15806625e9.11.1717575009511;
        Wed, 05 Jun 2024 01:10:09 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581490e5sm11025585e9.34.2024.06.05.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:10:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Jun 2024 10:09:33 +0200
Subject: [PATCH v2 06/16] dt-bindings: clock: qcom,gpucc-sdm660: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dt-bindings-qcom-gcc-v2-6-f947b24f1283@linaro.org>
References: <20240605-dt-bindings-qcom-gcc-v2-0-f947b24f1283@linaro.org>
In-Reply-To: <20240605-dt-bindings-qcom-gcc-v2-0-f947b24f1283@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Del Regno <angelogioacchino.delregno@somainline.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=f966CIHA2+bp1w+xzJXtK2SZhvIn4S4vZFtZr8TEASc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYB1NySO8RLDFtBeo+JATHk8bCGBldSaHPoRwP
 sXQmWmfMASJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmAdTQAKCRDBN2bmhouD
 14iOD/95UIm3edPDrGxfcELKdtzkHP9NCOIvOwjkPnTcdcei0q9dg/tumC0IdVELbJEYZjJNyVc
 yR7tkILkLxh53PvjlZsDnH4xwgemLY1vHSrScGQUi8D9gwn4XOaa2OzMyi+nL0YWHXBmv2R76TH
 IoJ1PlXOnSbidgHSOSD+wSR+IZnAHKKgorHCe+zqCYMt7xlckTu0alBk4VH/cl0SHMdcPcJgDQq
 7wDk1TvTohDOvHF7aePT2glNJzZSBb6Rj4+UlnUliuzfoBZ2KiMNy5Uf/9mJYIBypDprIFOOgBY
 yKZca6E8eDvqLKtmdNF2PST6UdU+tffxG0LsHlFgjpWdhKrYhKSbgXaYxONUtUsYqSPz9ntJfo5
 m4Kdcvr6Wa+G7mebEMExOlCpWLJ92nRzLssNoJyXZuijmJ+DClQX9Vz3Jg+wqGZCJ7+V/CeK46A
 cKXkKEptwzTNayzfSnfxvp+0y+ixtpRnYpV+c2GLTQ2ehsEyUzmxHnjYrGtjzogEqsUbUkL7C4b
 zfEN1/1blOVowb46Y/GodGiQlDUdOSFoaDAe4R2MeA4uu11YkhJulU9nMM1W58WeqS/ZyG005d/
 9NJbE34Nn9vr+6g8U58aJ5XiDmiZW/20yCfMbqUDnYcKFtn17rfBIM9aCkQTnM03CAWdBWsA8id
 QZUjxp90lqMX5yA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of Qualcomm clock controllers, we can reference common
qcom,gcc.yaml schema to unify the common parts of the binding.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gpucc-sdm660.yaml | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc-sdm660.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc-sdm660.yaml
index 0518ea963cdd..79bb90dbe4c1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc-sdm660.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc-sdm660.yaml
@@ -33,28 +33,16 @@ properties:
       - const: gcc_gpu_gpll0_clk
       - const: gcc_gpu_gpll0_div_clk
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
 required:
   - compatible
-  - reg
   - clocks
   - clock-names
-  - '#clock-cells'
-  - '#reset-cells'
   - '#power-domain-cells'
 
-additionalProperties: false
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0


