Return-Path: <linux-kernel+bounces-526000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A7A3F89A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAE519C7F22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56023211488;
	Fri, 21 Feb 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHKRSssL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294521147A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151502; cv=none; b=Oct6HsjfoYH1InQSHoHbSRz1TaYJ1YmhwCshlFOJ/GmYcKgnw1rD/WYd1CHpnM0yZlZizE29BYgIiRJL4viRq2YZnqwuYreS0wMduCMBvkBLifb6ZQD//NqeWiMkaB2guy7oLZy8CkqyC/fs4DTbSdIzNvNROb0gCKHfxpZzQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151502; c=relaxed/simple;
	bh=sQUir1TiVRbtsw+Rrr4J2GdnerWUccENvKyAuylyDIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCxqSwjJcjdXvyTTjhLd7M+N5WXBo7SB01GwiNcSE3LPVQAvxJKX2pB0Q7p0cy0//a69s28j2R+1mkAGF49+v00lpI8JiGH0QFSoxac5oun8GSqpbaQaFegECBvjRltbCgHnGY8yKx0dd55Qs7aPw+OC7G3+jSuwrjfmD4usSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHKRSssL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7098af6fdso34127166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151499; x=1740756299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysi0JDUh4a5HDZVHMcgvLzjscdPZigz8vY2N2CGO+pI=;
        b=fHKRSssLmmiVjyYWTOl7xjS082hFKqwhXNT0ifvd33ml3CYKEmpWHW+Y1nAA9xWMZ1
         tX0lmDqIGCbSp9JXB+juWYv40McQC4f93bEM+7A6t1RGQfaR4qdqKXB17p9FLpe3PiVb
         SUtgng9Pgz2n9sJ3jCfTaHVMzw/O+RYWtfOmvOuQ8Em/CyyHIzeZEgg57tsbZb0SrwoM
         GfVWriavQCWx/tZYtikSU0MHTeGuX9Z9Q73uE2yhK6GpGPvToGZBMcN6/PxDqVYFx55x
         b5N/7Z6nsaIOtXXAltXnCDn1Q0nbVp0elC0mfqvhgGx0VID6jodMjNLvYsldNGHKjDfe
         eNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151499; x=1740756299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysi0JDUh4a5HDZVHMcgvLzjscdPZigz8vY2N2CGO+pI=;
        b=PmRnjNd0Uc39/DP3eTBfLhaXq5GyHCx9MMV4EvQ/5Ito45I3oSiCcSXU2AUI/OpZoN
         EAw1QbrICw7ZjqtGDAuTNpIifK9whAMKbYwfDS8oK6uxsykeyv1cm5x4Jgll69CBGmX1
         tWuEH8V0TGh0sE+x84dMZrN3wg/0R+xBok3V5W6ZbKLkhzWOVxhcUDeOvQR07GaZeXOx
         ARJlq3gPc4NlBQlYEIaB9mQinIuCIbMkw5hwpdCY8cVBMwuXK3txwHV6e0uK241ylR7d
         ECLkH9bmZKdlyL5M+QEjwVkY1vkOEgUpiKO/aIaAYk2c9KAKe4lsIEXToCvUDMq/o0QV
         dj5A==
X-Forwarded-Encrypted: i=1; AJvYcCU89C+ShzUL8bwiRGsjQxMh0ehwFPVaDRqg1wtyIWh3I+sqY2Trltwrg5bbs90tbMh2S+Z7SYQby3HiTjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hPDBTDas/KtHGqcHRGZBr+9NKpbgCV4KofcCQ0GSTQRTvYIW
	Z20O881z01yXRhGJFOXzD38d5eim4OcvVGlFWuEtYDSWJXwbGwHjTaiwOniWyp4=
X-Gm-Gg: ASbGnculsE+IPUsGsKiSEseYXhMsweJGoRXuTi5g396qmRjCIlWaC2O19fO8mF4LIMo
	vJw1djmqQmy/8cAsrV8zs/cMhwl9fvO6UYzchS8bTDaVtvhGDQl8iBbWpaGkW/vFa4v4xZy/wch
	KQKng1K8UAizX93CQyHjNkMF5JRrqkmOch0YbEPDRzG9BJVX/sqf2434+yuKcYlRWWy6T+b2tFF
	dIGeWShfZJhOwjRDPrGrCSgCsebgHRKKxN/8ufCnae3q1EJ4kwZRVU31ptwZpW7KFAUu/vfVG5l
	QzSHR7g5hSVl8JWD4ttRrCutUbAcK+InJ67fvnwSTfNfoBBT82f6/uhAVQ5HfePJ4j7PEOsEFBB
	l
X-Google-Smtp-Source: AGHT+IFKiCGs8WGJjCjTwDeH5gItqV3Z4eBJ2EseKZT54AU+egPgFTE16MYl1DUKy6/45OfK9TlWOQ==
X-Received: by 2002:a17:907:2d22:b0:ab3:8bcc:3d97 with SMTP id a640c23a62f3a-abc09a46c73mr147170066b.5.1740151498576;
        Fri, 21 Feb 2025 07:24:58 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:24:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:14 +0100
Subject: [PATCH v3 04/21] dt-bindings: display/msm: dsi-controller-main:
 Add SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-4-3ea95b1630ea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4373;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=sQUir1TiVRbtsw+Rrr4J2GdnerWUccENvKyAuylyDIY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJqvbfkL6mifLhnkJ8uZyWrdVvqdxgfUK+3Eg
 sWqITQW+uqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iarwAKCRDBN2bmhouD
 17ScD/0WhW0eY92Rf1M1qxmQ9bWlOi0q6oHKlhME2auE7BpgsJHCJtPsQFg8ZCPpnVkwDPXU7Kj
 JE45JCNTiIcbBznrQaw57ao2XQTnW2WgrpEAeFcRbvdUaeOWhZlkbQ762LGD36nlUiYAQixXTRj
 TtaVv9vO9IlnUQ2Ej4cg1r0ByY29f4pnY3z65T6kVLVFruL92YrR6btwijpiyuqJeWpXxyS2NvY
 ZtTis85EqKruB+RIwxjGmFIHytjTkUffiliCYFEcKAHRx8upuqW0NuKGCAjW5Vna2uq11Jx3hxg
 XowEPVduEhaa9+QqAJF5Ir4FK/Sh3msX4sPdUmTJ2Or1QB55OLVbyyGX9lDwS1ochXYyk1Buef3
 gtzfMmHj/fmECtg+RGU6Njb95awMv4OqzRczYUeluLUxAOyOp476LAQwcVrySnyA3jLzBt1xtI3
 ArRRs1sFbOiFfyZcyWeiMeVpD91yyCj0Vo1ewChFxFmHvF/qq3lhRoEHGTG6eyFguI1Adjsl1ok
 DJ1TIxO/JHORazEkOrtHImUUVPy/e9Zak56HRdyQa3X1jfbGtqKWhKEO2xpcvLIzSasjQ5jyMb+
 +deP5RYyfejTHOxRlHCyWcSJL9xC6KzyO/iqmVKqHdS4G+1bWitDFHeZYEXtn39FSJsnqNUK3bg
 Z/OoH8n7yIpfFeA==
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


