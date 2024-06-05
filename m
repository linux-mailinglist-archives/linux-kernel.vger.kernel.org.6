Return-Path: <linux-kernel+bounces-201946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C377F8FC5B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0711F224D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A64194A60;
	Wed,  5 Jun 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCzg64uP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441EA18F2FD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575027; cv=none; b=A3U+9URxV3YIxn8BaY2botbGy+boHJJAzmw/nJ5cZAh4L7xxWNiYHWCmK6c1KVjyfXP5DPpqT6YMFKRVYH7qN1Wiqd+fS5q38Lo3oVlGlfp+uoueRfVPnwGmeT0NU5ynm91yV+iWHtYcbIdAJaM76NxSuz0UVwA83G6jQmNmu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575027; c=relaxed/simple;
	bh=jMwVDYuTXPE4d4cjbkq2915HFztt3oE3OBxwy+m9hqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTGtV9IL9DtnX5ZnTL0VEZ/BcimYRR4hV4bZFE5rznm8vdtOxCLCRkNLcXwIeIwqKooUOMLG3zA1z2Q436f+cPuVUcno5GoCFfnfy09zmFDDpag2hArvRlm66rOWHoiecYs9RrOkBPCRKODN0+3VWResMJWB7WknRZYL7Z1YymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCzg64uP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42147970772so12402025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717575024; x=1718179824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccwWtqu128BIkjZa3Qa+0J//B4/QCZIpgvBFihJ44X0=;
        b=dCzg64uPuzqyCJbs7isXQDQGvMRURS2UnDCxdXJp+drdDRNz30efSmRy7Avn1LDMGQ
         2SxaBYmnC0GXnWiMJIUQrpHKxlHamupbv6Xn+MPl2iVBih+aR42OMO0FJKQodszRjQbA
         67TUrLr7gtPQwhX84L9dOuyI/3PWk3R7g3H+Vlf7K/LPtqEjHm5EZFOP2owrxVYMj3YS
         vQWRqV5jeAVy2SYvIjwtBkcs43niMT23CoDjJk1dBF4HikvgI28BRBsSKi0BC67l+ryy
         usq1DwAzUQsathG2IjM8pNIzku9zMA8YoG1Chi/dZWap1+CEsgHzeTmaXzgUdh/WXuEB
         aRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575024; x=1718179824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccwWtqu128BIkjZa3Qa+0J//B4/QCZIpgvBFihJ44X0=;
        b=a2fKCDNGQlLh7UpwXisoIzi96Dg7SCeQQn5QNQIE5RutSEsEfkNVWG9bp9SaAyrvBG
         SqW8pPuVGY6E0I8mRxsufoxpjXP7sMh5a8QLMVdAiJHws52xbqvTNhPicGAMYMGyye//
         PN2Cve5k7S3xZLowTBoNG7SDpwsESbcN8lp3HVurwl5jr+r+BicfhAwiSoczo1dj3+Qg
         wL/OmZuYJhAtSEaUAQmbJZMWCN7QSA6IleLf3ujXfekjXvwHmmNLfxW2zYRPIMpz2kBG
         23qrgUhjex0DGTehkBIXeXHUh3x3yJVrRT6yckHCzHbXQjEICzxNfUFWWpgJGlibWUOe
         oE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfyXr8gLVGH4mpDZPhn8eEv+gF08/+zikfxVCl1oNCZrulzC6gvBUtAH0bqZOvlqVbRI/lprnqBkFJ24Gbf8iERqIq1rzchuVQzyEU
X-Gm-Message-State: AOJu0YwMoqOx1tEWovEbHNjuzWbBS+uxf//Gz3T63F3DIze/P1q0hdNx
	yLJyxblssZ6OPNjahaDqks1wzNiuLo6iQB9WI5SDk+yIGrXU0JXt945X5DoT2qQ=
X-Google-Smtp-Source: AGHT+IGMxLAtc9uFsVYhYw2w6dzQ4zWkbVzXBxxchBOq/IGMAnvz3LdBxm/btLTl/ONGuCgy9Rlmng==
X-Received: by 2002:a05:600c:1d0f:b0:41a:908c:b841 with SMTP id 5b1f17b1804b1-42156338a11mr15723215e9.32.1717575023850;
        Wed, 05 Jun 2024 01:10:23 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581490e5sm11025585e9.34.2024.06.05.01.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:10:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Jun 2024 10:09:42 +0200
Subject: [PATCH v2 15/16] dt-bindings: clock: qcom,sm8550-dispcc: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dt-bindings-qcom-gcc-v2-15-f947b24f1283@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jMwVDYuTXPE4d4cjbkq2915HFztt3oE3OBxwy+m9hqM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYB1VTkxVA87c4tTif+JaZ/GJBDe90l+uMed+E
 RkmHRkjC76JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmAdVQAKCRDBN2bmhouD
 184gD/0THXqgq8Jh+kF9wWHbzGxeHmnccvmaOX3L4WFhOQzMh9lWi6PwOUIaHv4O51xEYlYrMRh
 iYV42R5wl8eob6xAhMMQ8X0daknRd0/8nHQrb4+czOt+hNRvtTDD2D+kFrSIgJTD2LWf08gkZbU
 jYYPFLKfLHguCt4lQe90GdtA9qhw8F+vDO4GgyPACGhD8KC4RC+sSfDO8SRFYkpWgpGpFG1BRKt
 ExobDISIkQU0bO648uPU7TNlMFEgehnzosVhHI9mTsM7WEShvKSZcQ23grt2vWaJ6igmNXkKveP
 b6usJRh7G1KzDAstcWMOBoRcRwSvrsYR26JJ1o3b8qKh2WU0gAqDByjN9fcgvSRtwxiWPjvAP8x
 MYSb1RIsA7iiMvNPgkt3jboWSCm0WV5QhGe1R4iQ1IPY7D81p34GOkbROJMjVRqCGnxxuhFAq9c
 VxOUmXPote96vIS8Ss2xPqXa04vEAJrAmw2W4Q/tQkQzEliy+x/Y2hX0PyFsuDhLeWpt7GwndlD
 LTkNZB/ULbAxWTWuY3Q/1bS1ozRsvVyxAaW4HKT2VAZd8B/35m5yzdWMXNY+5XhyFlEA+YiXoNO
 IiAO7LN5vB94HimKzamql4X27BKYde0ZJdb0oDhy0C6ZAjuxgxa1c7NtHcE4xyotxuKEySpP59z
 ZCOOnlZB/VJmyGA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of Qualcomm clock controllers, we can reference common
qcom,gcc.yaml schema to unify the common parts of the binding.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm8550-dispcc.yaml           | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index bad0260764d4..c17035a180db 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -45,18 +45,6 @@ properties:
       - description: Link clock from DP PHY3
       - description: VCO DIV clock from DP PHY3
 
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
   power-domains:
     description:
       A phandle and PM domain specifier for the MMCX power domain.
@@ -69,13 +57,13 @@ properties:
 
 required:
   - compatible
-  - reg
   - clocks
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


