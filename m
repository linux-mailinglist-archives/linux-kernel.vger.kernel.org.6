Return-Path: <linux-kernel+bounces-196919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E68D6397
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B090C1C2742A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91BC176242;
	Fri, 31 May 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wivfO/Ae"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59581171658
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163572; cv=none; b=McJNZCcBt7mcGqtP62xTPKsKvxTQTEBszXMmxKoENX/ogqslufD7dcDe4GXguHJWWpj49Fov/3u8+fW/n24KgKxmLZ0hR36pTXafnNs5W1hus92BEoxTOQT5HfyKRUMF4vQUgkQC//xzg82tP7n2E57g5PUMjNV6ExHVFNdQZ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163572; c=relaxed/simple;
	bh=vKewDKzem7j0L2j6vi2Hi9Jg8CLGOGeHVFNdAkbU4mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a15CMNZe+5PsBj73eu3mI3OKc1E0yoCNMUHcloCqJmnI040UI08o71jr8m0Vz6tEIziDaD0A4hNjm6Q6iWcK3PocuB09p37yZXeJH+sps5UNPvQaPSbKl+6h/YsvA6JcV1wx5jhM3jBrKJpzKNK7y/q46N44H4wafsE9KeAGNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wivfO/Ae; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso26972521fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717163569; x=1717768369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxSE4Ip2VRrLAQNyBwtogt40s9zPtBzrtsuferIkfjQ=;
        b=wivfO/AesGgnSN1DuLEECcZDR4xc838aru0dvD7QN7c71HzW7OCzZowKWAP/yXcpkV
         9qRTUEmEWSBYlrVijY5ME1Pj00MeBRhd6HiRd/+Z4PEcAo33S2kqmIi+ReDd7HoLv6kP
         KvGZvhfjs3ir60ItQOMDyxExnrQ82FU07EtRIT4jlDJpBrPZhJ1keG9mfbazvCimzaDM
         4Q3wzY5ebk/0tgGK7Gs8Cz6scKCRalMg/Kg21JNaxbQauvh9kfPq6nz6tddeLWTcvDW2
         ZSM07susLVtVmHhChVfpsZtd5W39pgYFKNZEZKh4ZT3kIkmxhoAeVfQaPTwVOGItspeu
         xdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163569; x=1717768369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxSE4Ip2VRrLAQNyBwtogt40s9zPtBzrtsuferIkfjQ=;
        b=t6mzJXMHVEQWilGBtIMeADketgWXnhoI5BS9TRm0c9F/U0wwne6pK+YkUZ0F/94ExL
         Lag3dh/bTCc8Sf/Is1YugnMdNl51GXVkXQkeZ+yzxxDz71c9AUrNiXo38F8zSQoLWbLh
         Y+sJ9NQQzBy/oUID/FjxbDRmMxgaoxzLAzm9DsAd7HSBixJQHU1xj3A+mV/W5LiSfocm
         S19VPCV0uEolnsqJLj/FHW48p9bqpvsq/0h52XBhgfi7xBeVZ/b/TJmHjj6SeZqZqj1H
         Tt7ZiJMgFEFXaX9goBdXeDsO0i5NmqbwfgwLV776+mFg+OPHMt08pKJep9d7gm1t+myT
         g6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB10fSA1gBfxbUCtRr0pWIKqBGru/ycRP802TJbjHhWiqqwmLqdBkN2c5FAJRqJF/IjUEPUELUtNmuYXviu66b19bSdAb0CJHBN3lY
X-Gm-Message-State: AOJu0YxcvQPhBhoL2cxGd7fU7D6Pd0e/N9ZVUE6Bgdr+LDPabc9pynri
	AgWajolWbFGqln/cBTPDnBMuILfn3QAWiIsXs54LVyHtYiinmnvsMqBIZ0/qKnHmfbu7lE0VJ+G
	97Ujw3w==
X-Google-Smtp-Source: AGHT+IE6m1JsnXGdm4aoYVHty5PhDewhxB9FNgLv3mUGYQY9s+aI+Ocyh/Zah/zsLrEMiOgpppEKWQ==
X-Received: by 2002:a2e:859:0:b0:2ea:7f57:5a74 with SMTP id 38308e7fff4ca-2ea951e4603mr12737701fa.42.1717163569562;
        Fri, 31 May 2024 06:52:49 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b85ec87sm26762735e9.27.2024.05.31.06.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:52:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 31 May 2024 15:52:22 +0200
Subject: [PATCH 04/16] dt-bindings: clock: qcom,dispcc-sm6350: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-dt-bindings-qcom-gcc-v1-4-b37d49fe1421@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vKewDKzem7j0L2j6vi2Hi9Jg8CLGOGeHVFNdAkbU4mQ=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGZZ1hqj9l+TESMNv8z3VgkxfnNuNYTVIo3Ev61JlwAJaM4YW
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJmWdYaAAoJEME3ZuaGi4PXfV4P/idQ
 I29A/7stD1NZJ28Fwx2g9MVywTW6C8JwTIe26y5lPeZ4I91MrxhitN7X2QHdnnQiqu7p2lRiizm
 Wt2Tvt7f6FMWZurC0RRVH4rPibHDCqbaWqIHyStU2CUAgCAJ9LAHZ05a0KYomZYvyo4J6ud7pML
 gtgMnThUESrxXxdWYaT+99pHoMW+3eSWENVLpUjNCjjPn90wy7kFYqT28Ep8b4U9WmCI6X7eJLl
 L022lpg49EsY7F1TV/UTYx4AIlbdl2WvRToBRCr1Yyca84w8dcNYOLIMGaT63tMudoXVR5h32Fk
 MGrnKstBWRVX2WrU+SwBKgY7hdCFFp/YFm+X8gfa/SMRq3HWs8CdkpsIZjsw18VtYLN6n5JFmNs
 VnviOy1/BTd94B2jgRM4r+/VdOewXfCRAg2PmehbNydoEdVcCvS5vtLIF5yYodHDtylfqxDN1FA
 Wa4Cm/fjvRxFBhFBsXq/uHjVQh3IFM6sSaIU3x3y84XSzNM2hOIhNHbT/YUjGbVvmL7P2hdFFNT
 A1yktkzW0dBEyJ+WcjzVrVaWQIuepongWhNQAirngT/c5a1kLBmC3lWf2zjQC3+I/VWZGtk23H4
 ns/PuhaKFE8SJ+0+pNexvmRCOMONlkAsD2+TuzwUz33QYXNhCTgSP7ZNdSMS9xknmkhyrRSWgnn
 T/+/a
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of clock controllers, the SM6350 display clock controller
is also some variant of standard Qualcomm GCC, so reference common
qcom,gcc.yaml schema to simplify the binding and unify it with others.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,dispcc-sm6350.yaml           | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
index 8efac3fb159f..a584b4953e68 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
@@ -37,28 +37,16 @@ properties:
       - const: dp_phy_pll_link_clk
       - const: dp_phy_pll_vco_div_clk
 
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


