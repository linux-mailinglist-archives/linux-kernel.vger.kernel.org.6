Return-Path: <linux-kernel+bounces-525997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC5A3F890
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3146819C7431
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B0212FA1;
	Fri, 21 Feb 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVRynHTT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11241DFE00
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151496; cv=none; b=gHEdqXE+n2Ioa81g1MRb6tjfo5DkUs2u2AHq6iE/T2LGkAluZNgrsQrLaTgSmQ1wHHD/W+IC/BE2UFhAzieUtcr58UaIBeTxjXD3ouJ34xbSkZ4mAMWGpDgCUQ0fih3Vd6wRlBPqNatOq83VqBHeHOfrCXxMM8RBvNeHxiqtTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151496; c=relaxed/simple;
	bh=gC/FypNj+ZpUyniZ+8EtOmpEbEyuPuBTmn13DjMHXtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7m3JNZinGMHMQDDiTcp1/NvENcyDGfWEzxAMtjxUlQQ3KVL7K+cod4TbqTOroofFI8T6wvHU0XpdRPrLQ2d8e2bdnv6NPaPKppm7TDNs0VN0/o4qRLOyox5RPoe+OZ+k0SvVOPqBo0xU49010WK07POuBbehe7oem49cPwsOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVRynHTT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7dd005cb0so33289266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151492; x=1740756292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cslAnLurx2uWkIblqnE5n5YBSWA6fYOjQz9w/DOA/I=;
        b=fVRynHTTPRQEq9g0narEEgjlR1X7C19n38VPJaVV8Fo/j2oCRhISVDkvnQerDRsdLg
         EfCE5ySaD36sY1ygBBJA/m6Trc/AXqwkguVqeY8xBwtFFYPVkHIQrBVw5mO7FhwjfLOn
         8OWXvy2rB46rUQW1MmPmjN+TYO2XyKU8CzR9JsQJJOrrHeyTEk3Nl96iYMAqgvrPTPo8
         TfOHBK3PT9bornHrDw9aJkTHBWb3HSeUVXn8bTzbh0a6H8z4qj+ydlg7Ilp1GAOL+TOz
         1DvkdGriGsL4wjs7z1ykDDvfZsqLyZmXiKOY6rbJBADnUWm6mbdv7H6O2K8kF83meNyH
         6fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151492; x=1740756292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cslAnLurx2uWkIblqnE5n5YBSWA6fYOjQz9w/DOA/I=;
        b=vCcozpwn7f8hdQV0/J9PJN5nXDT97JvWAhBLAPf30A3UdEoVvHppwF12rLereVkLpY
         +/KwBQj5YwXe8uUP0ies/c9wqMiPIdbU7MAQk/vEDPJAD/XLug0Yb1UMGLI9mwdtiyxF
         GU/F1TR/E61AdmxGpEKUoGIIAQ2vb8Z6fXqB24JAyW+b4U1wccN1Xv3f0fXWGXfVL7sp
         90XwnstsfWg/4j+HOBSVCrO/CTjhRTEETAI5S4XYj5vf3DVEWMgvrXPsys5i9MRSokSE
         9YkKTAE6zLCCOuebYuH5wBPUzIQMFnujmt97YOHOOZjFCmQNjpoKW5+Kb/Hay6GeC0EP
         BAuA==
X-Forwarded-Encrypted: i=1; AJvYcCXpv/wc/MPgPANXzTKETA+iYTbXygHWFHq0i0n+iGLYXXkRiuYmFqHpU4CJuK/Y97ehSC8L2yrqODCBEvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIFrkGAXqe39Q9qKMvsZjwMSZ5aiWzDAuZjw03NqDTDof61WM
	Zufx/2mdlKaCXLRX0le63Y6egHdDqEsvqV7W1T0Mg6owmQgHspgCiK+96OqmZYg=
X-Gm-Gg: ASbGncsXwAxai5s02tRYVVXTrpUHA+MHfdfPQoKIc1vyQzW8HGw5jnQ2ZUcXJj44LG/
	uXtwbXlfrMOZiGbPJ6i2SJthmzMmkFHSMC/CIN+40l6HyF6nh/oF8eyfB7tDniM3HD7ZBpwLCIh
	uPmjcOGd82XJ4uepYLM836ukhvnffDNz5fQwS6LVBqv3tU6Hj9KGtM328yx9RaaWvtYHEqwUVSq
	UsTGuyGyxev5XFMiNW0Y/ImzHhKvxOEDkgMsY17OVw+id9MNRN3ze6q5qnZQTRQ7ToNPTsglc31
	NtWrus0R8Tzw1NOHyYwtLHxZxdO8wuUdIGKYUdPHVysUiKjGL3amxzfKBWruz26k7ZP5CEp1o6x
	H
X-Google-Smtp-Source: AGHT+IFKIQuk3xKeyN1ac8pfvFoGo1xm55r4yDfi0obbysI0RFch3oRgefyzIhmQ666lB2tFSSmLeg==
X-Received: by 2002:a17:907:7286:b0:aa6:9c29:86d1 with SMTP id a640c23a62f3a-abc099b8837mr122567366b.3.1740151491870;
        Fri, 21 Feb 2025 07:24:51 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:24:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:11 +0100
Subject: [PATCH v3 01/21] dt-bindings: display/msm: dsi-controller-main:
 Combine if:then: entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-1-3ea95b1630ea@linaro.org>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
In-Reply-To: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gC/FypNj+ZpUyniZ+8EtOmpEbEyuPuBTmn13DjMHXtU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJqsgXbxiTLYqR/PSolFrAbqMkllUjvxoL/mo
 OOMU655pAqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iarAAKCRDBN2bmhouD
 17YvD/wKGo6OfOEhuVfcMzmhFGgg37DWi/RIVXURAzYJ+joeU6L1inAafck7Qy+TNi6sa6k8YO1
 fBublLhM8E95wDVz2/WQV6PDZNKInMFryiQ8uIV9DGH4hqdtEMBp8ori6Rb1RTJICbSZWuTjEyp
 +9pggs6KDS6zo9nqtigeo3Tzcg98GlwsgEISJbA7N+ZfmNi/oNk7FEEdUxJ6FK3n61s9uoEgP3f
 fW1a/fSYE1ZGgoZ7R9UBXRDmddpNJwIYT32TWF3SJjr+tSXkLOnUKloaDf3FCpe/viuYqusz2f3
 muedbNjHozEOgPn3dpTvX6xCOBqgi605kIhmwJxme4fdw73jbYW3OBinFykeIAyosNeaHFwAt/9
 bZFl89wn8JGqzw1WpXJ+vPo0E4Y52PExXh8YYS9rSpaiAvZ/XPpoau6LFw2zAXFpuEpQlWK0fKN
 K81L05zXOa5dw8BFdJPaOXXqcVk08zwTqtxUeRWGP6dYYF8VPPhrdB4mLj56sNxguCHUR18pkW4
 HJ8UIhckPvigJQ4xaKWiwMOh1K4YIDf8UwejgyXirT3Xu00G4FBt/LnVt/MJsO6PtzGtbzY5pOj
 +Uk1USE2aNZrkUR6OusYZaTDOx4n5Vafs9/9NMO3ia2lXDdiWIDh9u7Yj8Hd4CI1Ev2GpyPwC1y
 kL6N46HexQeM2nw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Several devices have the same clock inputs, thus they can be in the same
if:then: clause, making everything smaller.  No functional impact.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/msm/dsi-controller-main.yaml  | 64 ++--------------------
 1 file changed, 5 insertions(+), 59 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index ffbd1dc9470e2091b477b0c88392d81802119f48..e496e5430918d54b2f07f1d5b64de85d29256951 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -248,24 +248,6 @@ allOf:
           contains:
             enum:
               - qcom,msm8916-dsi-ctrl
-    then:
-      properties:
-        clocks:
-          maxItems: 6
-        clock-names:
-          items:
-            - const: mdp_core
-            - const: iface
-            - const: bus
-            - const: byte
-            - const: pixel
-            - const: core
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8976-dsi-ctrl
     then:
@@ -328,28 +310,13 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-dsi-ctrl
-              - qcom,sm6125-dsi-ctrl
-              - qcom,sm6350-dsi-ctrl
-    then:
-      properties:
-        clocks:
-          maxItems: 6
-        clock-names:
-          items:
-            - const: byte
-            - const: byte_intf
-            - const: pixel
-            - const: core
-            - const: iface
-            - const: bus
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
               - qcom,sc7180-dsi-ctrl
               - qcom,sc7280-dsi-ctrl
+              - qcom,sdm845-dsi-ctrl
+              - qcom,sm6115-dsi-ctrl
+              - qcom,sm6125-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
+              - qcom,sm6375-dsi-ctrl
               - qcom,sm6150-dsi-ctrl
               - qcom,sm7150-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
@@ -393,27 +360,6 @@ allOf:
             - const: pixel
             - const: core
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sdm845-dsi-ctrl
-              - qcom,sm6115-dsi-ctrl
-              - qcom,sm6375-dsi-ctrl
-    then:
-      properties:
-        clocks:
-          maxItems: 6
-        clock-names:
-          items:
-            - const: byte
-            - const: byte_intf
-            - const: pixel
-            - const: core
-            - const: iface
-            - const: bus
-
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0


