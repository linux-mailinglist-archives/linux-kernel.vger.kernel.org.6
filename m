Return-Path: <linux-kernel+bounces-201934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D21D8FC582
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DCA282CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42BC191478;
	Wed,  5 Jun 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Px5UZ3oI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830718F2F4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575010; cv=none; b=aoctm6/7xnAE49oqqv7hZHSkVzOZ5Qo6e8A2l/T5gdzLw8N+m6fnF6zNyQg6BEbvDDWZu/opev6KA/EB8sBQY2ZMSPXCGO7JzElT2u8YmehzS1GWFB4a0PnfFGQ2PkLopLdDQoBzxLfW0u/3unfLUe3AMsP3oux4QPTO82QVP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575010; c=relaxed/simple;
	bh=SSWEUcXb7IJDJzNM+jb4MEzvvgySn/hMY1DcgV7TKyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlIs0UbUfYaTC//h+K29RbENg3Ex6/nMdI5Hv3ESHJ+C+7ka4/SVO006sUX+zkgcsHEj16SW8MXoW/zP6K5syJIIrIH8or65810uGY3Z62tmFYMn99Yv/7doVfWHPSRIOtLPNYV4zIh/xchOcEmBuc8JFHOCdRQxljzA1vW9pl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Px5UZ3oI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b8b638437so2213947e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717575006; x=1718179806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+zwVKSAum2DaFAm6tYOQH/F5iFGCC/SFG3ee9rvIoA=;
        b=Px5UZ3oIW8zccJF4miPHEkcw/grt6mN5p5IpgZDB8LTbDRUkgvpcVg0AdkRDGxJVfI
         bnt/ncJIFV0b813N64vN1btygUOUxn4aCu2XzGRdAWpZhfflA4npHuMf4QCnhCJMFh66
         nQNaL2D63v4cKw6eEnIWDK4uOS7crpx0Wd/1J1tUplCBDC4y59ONA1whKAaZZj+24Cqb
         7wI9FSXDy1IqSpKNemXDYJmSHoU6rHs1qndNvlI1SAm52P/T06aI7H1DtvI+LwHhA5Oi
         bdNsXfn8RUqZ4OovcH5uKRnfVmYWYlAfapI+K44x9mFiXfzzbTwxrE7n8/rXXDkU0mVV
         pPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575006; x=1718179806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+zwVKSAum2DaFAm6tYOQH/F5iFGCC/SFG3ee9rvIoA=;
        b=nMGvqtIKssEftKGvggh+5H729BeB1/1j1lJ92MmqEkr/Wm/Gr8RQn2SRhhH9zyBO7D
         SzDdT9URs64KSQnqxm1ejJ448icwW7aaEj/UAMw5JQ7Ks0U6SeqN33+HDFMhnW2mg7z5
         38eLxkqNsvhlXvWKSq37gXOIenZaKic6XVZ1/+cJ+pfhPlfZzADkUh2ySCRkNo8hV5zL
         88tr1GZ1CB1x6UKalpS5yRPa8CdO2QgIDmPKiYCB/3nk9jXnYcsvwjNBYumwnxC86TIx
         8rmR75fxJDmO6HGiLFbc70w21nhE6DMGOs+P1iTMzL2Gxi0pPTrgRgDMrYTzs4oxfCy7
         3/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1fPWdxlo244rxfG8qsB6I+jmh/2Gxjmgbuip1LVDBEyJoH3ibmhu+62awzam2nrhJe9dO8KphQ5tWGbq9lYYco6stsfnlolpAivqk
X-Gm-Message-State: AOJu0YwM5nInRFt2rUxNs5lnWO8AzT26JiDdsofYxQw3BJZqlOJNhrXg
	XCVr5JLU4u6M4ALcVnf08CAYZU0ZMIHgUpYW0e7vxTH9mEbeaAaRqI399HKeaEc=
X-Google-Smtp-Source: AGHT+IH5d4V59NC+XGv6lIQnfz93MaZm+qjgrqIwoMkedFCEZLqUK9rFm9UipAJ+RDgswwELlG3JQw==
X-Received: by 2002:a05:6512:3b97:b0:52b:8847:ad0f with SMTP id 2adb3069b0e04-52bab4cb7afmr1400352e87.11.1717575006568;
        Wed, 05 Jun 2024 01:10:06 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581490e5sm11025585e9.34.2024.06.05.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:10:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Jun 2024 10:09:31 +0200
Subject: [PATCH v2 04/16] dt-bindings: clock: qcom,dispcc-sm6350: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dt-bindings-qcom-gcc-v2-4-f947b24f1283@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SSWEUcXb7IJDJzNM+jb4MEzvvgySn/hMY1DcgV7TKyQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYB1LWrOwDkrAakAlecHHf0Sl1oRB/LWF8UJL6
 VyvS0MI2hqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmAdSwAKCRDBN2bmhouD
 18dfD/9NzmMA4Hu7ex3Il2R6GYC9AL6Us0e83is2COyV18Nz57mpXaH6eaivv7j0TkIGfvQxBr+
 IHS2CzLcPqKom7fe+sE61p2w/cwY+V7zZzy0gEvj1tdnVb8U5+WCj5GCh+et+Yzp44EobgSjiln
 T4y75Kh02lp25jyARtqTbO9XOOA+n5jg4zxLk6Z+8NmKkWpueMuQyqcvPRAWzsA4cFw5dmNhtVT
 AybPZPHeOaSqF5SjmZJjpbf5bSy1L6T4jBAE+xpYYcNoe5jI7uuXXsiz1WJ2FyvaaduSVyaL0pZ
 L0+ae1KKbpTe83xC9l0zby+Nj9F3Ul6/NI4rqwfnH0cGzdQaUYSju21ThggX01n0fX+TCB2y+Js
 h6jL8bO8JTHk1N7U8X5hkyX9R/TeGK2WYG4DzeQpKXHNq28DHvbbDiRZ+aIaPgGIjjLxmnlLa9v
 KuuJHHYZcnWOY/PCt99NqSOMtAU1Eavh1nv7zjWX9yFxrN8AVCDeS9clMLbPyIzQqQTQpAB98ia
 0mUqBZGKelXyFD+Q+d2L3D0aHJ+oRIuQ3j0ViFX2QlP/1zFRmn4lYivSffgogCktxfERi+k5Gif
 JqQDZjgB430Y0Q2b7xZ1LQxU77wfVBMZa5vQxw6Nrrb45Xu4NVngagG1LAQAiixikUcLDGjM4JU
 iE6cJ9heuACmWLg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of Qualcomm clock controllers, we can reference common
qcom,gcc.yaml schema to unify the common parts of the binding.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


