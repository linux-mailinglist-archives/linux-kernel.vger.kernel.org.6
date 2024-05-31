Return-Path: <linux-kernel+bounces-196927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E918D63BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6431B28278
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8317FACB;
	Fri, 31 May 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdCjW17i"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2617F4E4
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163585; cv=none; b=Ifm8iQ9/I2fpSoHbMf6vYH0EekQOTMnipiPXRETbr8epZGYA2kaUyombREXNoyDamqKFJd2zEXQvBIh6t13KZCObN7DmS6ebdSc4QDxboGBpGJIhQ+wayc3IvSvEGBRUHcLYNAqgfUiamhN8Jtjy/1ioj1YInow2PZCoAWv2Clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163585; c=relaxed/simple;
	bh=DOva5o7JruofS1G3C6j0Cce4E+7zctrv58XU401pM5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gn3EhNOijDqHcQULHgSgP70DlnAz91t8piF/1n9Q2aoLKZWyIGsVkKRRiMRtCgopaXz08YnFOH9XoS+yqP13vcv2gTgP/J1PajbXgDBKELwfG+khhf4xIr0DFVh/nEbo3y55vf9wJ5zlqhHa4Xv7V6yRb12Bfe97q4GZRYZp4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdCjW17i; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4211249fbafso19504265e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717163582; x=1717768382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAqQPVNrdpwDzzvtCH3SxU93oCP7Rm/0w5IHgGKsNHc=;
        b=jdCjW17iJh71J3E0H+6N0C244NsxzTcu8wgsA/4vkOq7THZ8FhouEbU/F5PrnL5K7I
         a9iQKtZnt29/EksYjG3oB1WIQzY+QB1RdmKgSS0gUXCvSCYz5J1NTDlI9tXIzAtfD8w9
         2EjzKN884v6gFarq/mXbHPRf36ZPJcXE7YgRsn0kFZNZEwg70LoJL52Y5Q4gwc4uNPpk
         83TBahpeRMA+MoVdIbgeAP44RhNhbDzmEODIbt1iEfMiavwo0KFnneIgpEZLfjCj4Vh/
         hq9UwPBH1q9SV9+ho+mgYspUqatQ1hcR4nEGXCV5MGQxprFbcttHGnVA94LC1averqoN
         mF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163582; x=1717768382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAqQPVNrdpwDzzvtCH3SxU93oCP7Rm/0w5IHgGKsNHc=;
        b=Oox/9qAQtyjfYewkmfz76wh81FmIGn1edu86ttEAHoCy+Osim+hu+SNspk07CziKR7
         jzpapgisJO0QceCuz1GkfyrQX2QowcPCF4vPsGeQoeOnays++pm792S2ibEJCeW/IrC/
         4VMpRFpCr0VROH45+Vi+zyCP43OeJ4qB1xvmnjHhdPko+9vCtrYNn0K2kNH6AVFz+tIl
         WlXCcJVnt4zSwkWRte66JlO4qCDNkUDmLj1nQeZ+6KnGqp/DuNucx45ZMw0PnWCzrqXx
         ia4QXLKfaA27U2V1o1hjP8f3HfBH+72yQGqL66z0oY3j59XzeF/39bFuxhcDZkRVNR66
         r70w==
X-Forwarded-Encrypted: i=1; AJvYcCUhrakg80oWU/jOZ0Pl+5rNM+hGYCfLmaMJPdUiJG+zUCmitsLOISj4eqloms9qsuk+pwIoAsOyqEYABIhiDRfcudH135lYoG6gtBuH
X-Gm-Message-State: AOJu0YxiIHbmffQ2JKXbYdq15CE5aZpv7d2t96+Q6Oq1MrrvzzSoQuQ5
	Ga75IvR8yMQBhXTPTj6DtSxCTTqGzARkLXwgeSNlhwPuTFoyv2dzgZwuGqxdCEY=
X-Google-Smtp-Source: AGHT+IFgbRm/VHmhf7+BsyCQ5aIYScMJirfjEBdXWGHX4d8/k+V6Cu5nT5ku8wjKUfJ7G+rKdvLOOA==
X-Received: by 2002:a05:600c:a04:b0:419:f9ae:e50 with SMTP id 5b1f17b1804b1-4212e0c146bmr16144195e9.37.1717163582463;
        Fri, 31 May 2024 06:53:02 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b85ec87sm26762735e9.27.2024.05.31.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:53:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 31 May 2024 15:52:29 +0200
Subject: [PATCH 11/16] dt-bindings: clock: qcom,sc7280-dispcc: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-dt-bindings-qcom-gcc-v1-11-b37d49fe1421@linaro.org>
References: <20240531-dt-bindings-qcom-gcc-v1-0-b37d49fe1421@linaro.org>
In-Reply-To: <20240531-dt-bindings-qcom-gcc-v1-0-b37d49fe1421@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DOva5o7JruofS1G3C6j0Cce4E+7zctrv58XU401pM5A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmWdYgI/RTfRaXgWAfSs4mq2OQHkEnrHgYOCCqR
 DcKNRZ/aN2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZlnWIAAKCRDBN2bmhouD
 1/LIEACMGXSjmPLVVhHb+A6FXn/1sWJMV/2TN7n29dlpoZaLBn15Tsbf5+lroA+EsxormidFH6a
 i1CVL1ElhLNFCIdo+MsDmm3232uRokqnFY/yIQT+Q2QBWTW2oeogLvOB78M4P8gpZJRc6SyrwZ9
 ZitSMV0dETCKyuZPXR/U/r29IShxRcM6n3MVcm4+VJuNJ01MS88mWQKAP98M+m6zsyS12jP54l1
 2BLTEpHLiD+Jo6srjyMD1/7CbNWsqcRQneE14oAblC8CGkBDsE0bnwDTwrFrUxFseX9NJnjuCy5
 bsBWcBdufDjG4Bl+OdWZXN7+eXZAXpEw4kqPAMD8zzPtaq5uyhbPZ1DHRgz8w6QFEMjY4/MdkIP
 wGRvmoh5EcTmau5+1Fa/0lCz0U9WF3D69HLLWVZDlW/C3i1ZW2QIWDK6/wR17OAEgY1J7sbCMNh
 3dQLUjmsXrqzrnZesWRl6N1NeHHrNePQMqrNe9pF6l57a/UfFKTIReYPuf+IkVr6Uv7ER0/8fDf
 cBQ9LT5WWLvS1YFlodbqyWHEXRBMMT4H6yhpg9ytlJ9zvNGzUcHUb0AdaUt0RKcibBui8pEEqNY
 0H8oItPihF2wQBYbpPKulPIAGWNxJR45Ni5c9O4s4k6Mxa8Gx9gu2cilWtZ1+QNCzM95gGzDJxt
 9pE5tJD1CU//R/g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of clock controllers, the SC7280 Display clock controller
is also some variant of standard Qualcomm GCC, so reference common
qcom,gcc.yaml schema to simplify the binding and unify it with others.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sc7280-dispcc.yaml           | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
index c42b0ef61385..23177661be40 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
@@ -41,28 +41,16 @@ properties:
       - const: edp_phy_pll_link_clk
       - const: edp_phy_pll_vco_div_clk
 
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


