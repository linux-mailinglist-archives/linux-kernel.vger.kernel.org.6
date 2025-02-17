Return-Path: <linux-kernel+bounces-518084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2CA389C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB3B1884124
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140322618B;
	Mon, 17 Feb 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTDF2FQC"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438C22616F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810515; cv=none; b=ONJrmu8CgsvEaq7pGvIfxq4GAh4Jx5mH66II3dBdLhzKlIDBzV9SrxMGBIGmQAW34wVo8CHHdu9Hr3PEkajUjWOXgIpCEYqleIBPR38khVfqormnLy1XoxLoMFI5NFSA7w842r6m+OMrSku1Y2PhbpyVgTeo95qi7+E66d/u2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810515; c=relaxed/simple;
	bh=FNsPxO6mm9uvgk0lAHityCPGUm1IzGbPMEBflLcDTzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZyf9ItV3qWPmZskQgyIUNUyUjFOzeyt2d4LPhQlObS06iCiIHyvGB2xtOe558hGfAjWmW5+KQc8jGJ2E+iF9pHs7CKP+LKZXGCbEimxbQriQ41GsIdAU7sb2QjiYop3hgQEPiZH7hTBDi5NAImElATMK2kyUkSJ26uhKsxeMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fTDF2FQC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb9c8c4e59so25944466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810511; x=1740415311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMKKgpnl8eYech7ysqKuZzSoqRmn3tzrEprN1J+JmkM=;
        b=fTDF2FQCwc1wKraMNfSD3wXviKDg12W6H0VXgtVp8XDBLeXNRNyUFh+cUM2kiLFzVC
         ySko5Ox3+e+oTJTsf+DVHA0zggQ6RG+yC9iPAIW9RIjwBg3I+cRas80WBtHgQ/9wgRw8
         LSJwHdaykrpW0ofan6Fyamwh6MaD0Q1q29MYlQ3c6mhXk/lVuY+z6CcugXecOfhMYL7l
         770nrZS6HLXi1EC+7MXOr8wBjwmg33Oy7bM0W6noVDcg2JfTJRWYgFPbH6Q9sD4R2Mex
         0g0Zh+Kz9Lo5wMlf1nMPTbX8fDsEhMZyS61d/iQIM9xf83pgpSnpTutEp8p9Y9fJb2HE
         tGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810511; x=1740415311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMKKgpnl8eYech7ysqKuZzSoqRmn3tzrEprN1J+JmkM=;
        b=aDkfNp+2R6KjfTos4JZ8mrXt61NUu7de/Voz+/ifJV8qZU5W3ftbYGegmzjmz1oJL1
         G6IHqvpJ8MtoK6hqehU9Nz+vjoBoR/FEFmKvWuuk3bTmwrnhjeDJ2+GdIeARt1lqJdv8
         NpMV5+W0U+ReBA/+YQV/z5IP2RI5IcVBhyi9NggZAdRfNGxMwipZmo3tayYcDaxJ8Jwo
         +8KaQryT7YaDGkBZ2cfWWiPASl9v2djJEf4mMJmGCbcqKEOj0AbBpal1nrH79LWA3jY7
         SkLbk17zGMu8GA7G5K6iK7zKYnIsvNSVpUUV8FjiIDWvojALmfeuV1bRpYsKKdnT7nWy
         llHA==
X-Forwarded-Encrypted: i=1; AJvYcCXoUoT1OIuvBPs5DTAR1TeSGhSa6UZ8+5kTG8vmm6NycHQyXMPkPxSORMfS42k658pG2PvlP6EC3kc+KRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswxnBEihIVmpSejMBFqM+7P6Z3oRMkR2ojTDFldebtr116jIS
	9TD9zVpQiGUyhRnRVCfJdxDLhjDoQA9Ehdk+yAa+VZeqY+s1qOs2O3wFoKpgaOE=
X-Gm-Gg: ASbGncspL7tLtvm6a/OM5WKePiLCWXlnIcdh3NSsmKdewqxZLyaYkEtuWYX/HgZYEuw
	HMbeOOZPcAkyq44Z4PKVHRlWSaY05YqxvaP0Fe50KJmoi1Di1eMLvrQGfFCegWZjKBAWdsRMnMU
	0/fRZuZjroV+E7WCQiLVLhTtEda7ei2kUooC02UgMbEhIf1Kt93N7AgteYxMVoBhMDswzZuemrC
	oFZ1XJojt1TSUr7GDyhax2dEiZXKAYU83MDc0WHYqspqWkUV6iSabRrJHUrQFFVZw/+8BoajHLw
	TyrjrP4Jro98XY9y3c208eP3ZcGEMKI=
X-Google-Smtp-Source: AGHT+IGTzswrtCJPCqfyggi5m80u/jkul3kNxHxJa5SXSan9y/8fkbrnZlDazfpdDBs98is0eJDstg==
X-Received: by 2002:a17:907:d8b:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-abb709319d6mr401797666b.3.1739810511229;
        Mon, 17 Feb 2025 08:41:51 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac781b78sm82647966b.60.2025.02.17.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:41:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Feb 2025 17:41:25 +0100
Subject: [PATCH v2 04/16] dt-bindings: display/msm: dsi-controller-main:
 Add SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-sm8750-display-v2-4-d201dcdda6a4@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
In-Reply-To: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
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
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4323;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=FNsPxO6mm9uvgk0lAHityCPGUm1IzGbPMEBflLcDTzQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBns2a6eg8jKK/RyyaSz8JokEoix1Mba5jwcyKxz
 FO5fmLKv6WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7NmugAKCRDBN2bmhouD
 11K6D/9qb6pfJNR2w2GtVlMN7d8ELbhuFInPw/YrDqYbjRjjK8MhlXYbxJTlajHlFjFi3ExrZGx
 sBE3DApk9QvzyBCSGHOfZGJNuBDb9zfiAkZt7Ex92J/MYL/C2Bg1Wh+4QAoDAXIwaUwoCEaETQc
 caUPi68WvWibTHHsc/rQ9TsEjVy+itoerpNvAJSTitx+8NsA8LDCFehtWhwQi2RpVIYS8m1tKmn
 ksS/cAr4+cv1K8ugg8QAcam5ocLhlP4vz5SPSE86Fzv4atS46ElxDsQDhejkRLO5hSs6Vyu1F10
 lxB2c4WXY3najNn2IiqNyKm/gevpykFBuTO+8IJ7MEyoH2VchQaLB7SrCudDOREu6cH/5WDSB0h
 silAL371P/9bSpWtPo0TeiTt12hfvONwbfUHwGK4SRO14Qr2w6rGfmos6AisxRJvkbqBV2wmvd7
 JR1K61cvTQS9ar5LXko4R5mVMdo3XYNaM1zX9zpUmHcS3yoycR4LWnPrYKJbXABGss3Slk5do/+
 tNfiRY33icnQKFLtak6GypMaMPzR3ePvODZa9vSgeVuXFDC7e+BrRtkNBJIeB4HH25Y40yfvkMR
 iIjsSB8gFp1Xmv7awTYvw/VokxjsgpcJmvNZrNk5J00+cEgaZw7lqFaKc97MeuIo2HmpsfdVLfV
 7XM1+fP1WV+e7bg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add DSI controller for Qualcomm SM8750 SoC which is quite different from
previous (SM8650) generation.

It does not allow the display clock controller clocks like "byte" and
"pixel" to be reparented to DSI PHY PLLs while the DSI PHY PLL is not
configured (not prepared, rate not set).  Therefore
assigned-clock-parents are not working here and driver is responsible
for reparenting clocks with proper procedure.  These clocks are now
inputs to the DSI controller device.

Except that SM8750 DSI comes with several differences, new blocks and
changes in registers, making it incompatible with SM8650.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/msm/dsi-controller-main.yaml  | 54 ++++++++++++++++++++--
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 2aab33cd0017cd4a0c915b7297bb3952e62561fa..8ecb2d8e296edf555df7380eac284b41a3f000a5 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -40,6 +40,7 @@ properties:
               - qcom,sm8450-dsi-ctrl
               - qcom,sm8550-dsi-ctrl
               - qcom,sm8650-dsi-ctrl
+              - qcom,sm8750-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
       - enum:
           - qcom,dsi-ctrl-6g-qcm2290
@@ -68,11 +69,11 @@ properties:
        - mnoc:: MNOC clock
        - pixel:: Display pixel clock.
     minItems: 3
-    maxItems: 9
+    maxItems: 12
 
   clock-names:
     minItems: 3
-    maxItems: 9
+    maxItems: 12
 
   phys:
     maxItems: 1
@@ -107,7 +108,8 @@ properties:
     minItems: 2
     maxItems: 4
     description: |
-      Parents of "byte" and "pixel" for the given platform.
+      For DSI on SM8650 and older: parents of "byte" and "pixel" for the given
+      platform.
       For DSIv2 platforms this should contain "byte", "esc", "src" and
       "pixel_src" clocks.
 
@@ -216,8 +218,6 @@ required:
   - clocks
   - clock-names
   - phys
-  - assigned-clocks
-  - assigned-clock-parents
   - ports
 
 allOf:
@@ -242,6 +242,9 @@ allOf:
             - const: byte
             - const: pixel
             - const: core
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
 
   - if:
       properties:
@@ -264,6 +267,9 @@ allOf:
             - const: byte
             - const: pixel
             - const: core
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
 
   - if:
       properties:
@@ -286,6 +292,9 @@ allOf:
             - const: pixel
             - const: core
             - const: core_mmss
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
 
   - if:
       properties:
@@ -307,6 +316,9 @@ allOf:
             - const: core_mmss
             - const: pixel
             - const: core
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
 
   - if:
       properties:
@@ -342,6 +354,35 @@ allOf:
             - const: core
             - const: iface
             - const: bus
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8750-dsi-ctrl
+    then:
+      properties:
+        clocks:
+          minItems: 12
+          maxItems: 12
+        clock-names:
+          items:
+            - const: byte
+            - const: byte_intf
+            - const: pixel
+            - const: core
+            - const: iface
+            - const: bus
+            - const: dsi_pll_pixel
+            - const: dsi_pll_byte
+            - const: esync
+            - const: osc
+            - const: byte_src
+            - const: pixel_src
 
   - if:
       properties:
@@ -365,6 +406,9 @@ allOf:
             - const: core_mmss
             - const: pixel
             - const: core
+      required:
+        - assigned-clocks
+        - assigned-clock-parents
 
 unevaluatedProperties: false
 

-- 
2.43.0


