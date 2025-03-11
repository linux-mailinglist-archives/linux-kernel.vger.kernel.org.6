Return-Path: <linux-kernel+bounces-556788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2AA5CEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FBD189E03F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDA9264A82;
	Tue, 11 Mar 2025 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWFD8h9T"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1D264A81
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719746; cv=none; b=dYpbYDeMYaEdPLrvuNcPlgMaaCHE22lVpmomrlD2VEN7dRFPrmWMsTamTW9Cbd9VowJ/275vYTzvlb3GMZoA/3G+y6Hu65LYCSKV9DWlniooC/jc078xWybEpi0dfUzLLHH2gsnnyC3uj09NTQ/cgRltlaUXWQAUmL7SEYgnuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719746; c=relaxed/simple;
	bh=sQUir1TiVRbtsw+Rrr4J2GdnerWUccENvKyAuylyDIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=up1cKj/4l6Dxw26JGF0ms/RcjMUrz9CAxlTekHkMdaFPL1rPxpCd2ENDckUJPRx4h1ishW0oeLwRVCS1m5n9I0L6GnbdG6XqcL5mGGj0/bvXnZOcf3jZtlA8Ti+u7/WzGildgm3eslGRNkDncj2IoHlLRqYJoUrmC+h3//ZqDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWFD8h9T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391324ef4a0so300690f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719742; x=1742324542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysi0JDUh4a5HDZVHMcgvLzjscdPZigz8vY2N2CGO+pI=;
        b=EWFD8h9TPSjt3MufMLawY/vWQXSzDurhU6kjHoO7rDyOoClW4DrIAD96YYBCX8vS0C
         UvlPRY51dzRF6O5z7IM6rCnxBu+x/4XsZpoRVXz8pm0EVm75Fa8QgqDYS4gmCoAMHVfU
         RoeFhsS/yPhP+zfBOrjpC5eC0krmDkX5cerdFYiFatKTEzyw8xrwsz9+G1SBY10PsLIY
         ALYtjmdnmnDrybKuMkTqqClICrvHUv2V6tUhqs7jULceL2Th2K78UOplc/6cezAC8/MA
         +EeDBNVr+5X1iomE+9NFx5huRDC57ZUTXAhBe3WmMoBl4JXyqi1jAItpLv4LkV5gOXTb
         nDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719742; x=1742324542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysi0JDUh4a5HDZVHMcgvLzjscdPZigz8vY2N2CGO+pI=;
        b=ucI9PoWds16NCYJ5KTNJRodoKbwjWjndVpn/FYhsxwod3RCGFO4oXNR9YMuZmWb2tA
         B3I4zZx5GT/lMC4XjhlEhjbUmFxFRIKdXRXCpNzbDpbRYqZZCnI1BV3hFS6++2UlUGOR
         qscpR8XCMm9v5lZJBnSuKmhUFCHNFIyBhgQLBXWFavWPvi5GuNf2tkSQfd6QqL0bXBYf
         Jhd/fBv6R70YNbFSS9gKVcpDyd5iIFCiU3pLI5butbDMzy7U6uu7Jv8o3Az/al2i/uzs
         XFUIaHJYODUiErDHsdRMiOl+CieKM+daQtamv4YoCLM1Fc0mvR8e0FgzschJHH4Z+J4J
         gANg==
X-Forwarded-Encrypted: i=1; AJvYcCVu/XIkNxbIyQDsa+Jt+tQk0DO6EU6YKmvtmQoZYq0A7J7Bxts41LOv8n9rXOA5b6aA9X3CBMhzjdBlQWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdYcujjDtNbgNaRqVaQsTWUamP3Cus0ObX2M+IZiHOUq74hmy
	WYR+OvQDHJClY5bGescjrlNLl0kTODjVJemRaqg1ifASo/xfETnjWdaBIY5H3VA=
X-Gm-Gg: ASbGncu4noNQhr73wnJ9bO94pY0Nojr/ptbM7i6QBZr2nrnoB0DNK06hT6Tp144CsC/
	Ri0J/JlbujJMiwL1zvWC1ONKsfk4rgVhQ3UBH+rkNexJKWw0iA9YJUy2j9DoqSgws3v8fQ9h/EG
	WVeHbZQUNzgTnZVKiEQ8n4RfK5cZXnvzxNVX5kpuvr5WewBrY3KqptbKUzeuRrjRQwrLH0HSG6a
	RQvypYok0ArJVNjXGZ/ter69SSCA3NkQMI4abR6sY4iLnuRGP5q8waPhg78+GFG+hBGdVpwFkTl
	1xFzdulcImFVmkCRgPllUS2R5FHMe3sG/7GScMU3hZ49zWooffj97GhBDhI=
X-Google-Smtp-Source: AGHT+IF417WVwkhv/4kEj5mDmA48euPvIfgAetNKZ077oeDcX29A47ICgyJbHG2WlP6N8LBlrOLfhg==
X-Received: by 2002:a5d:598d:0:b0:38f:2833:2c87 with SMTP id ffacd0b85a97d-3913bbd0d34mr4867195f8f.11.1741719741888;
        Tue, 11 Mar 2025 12:02:21 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:01:52 +0100
Subject: [PATCH v4 02/19] dt-bindings: display/msm: dsi-controller-main:
 Add SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-2-da6b3e959c76@linaro.org>
References: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
In-Reply-To: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0Iim/DeJggisQZOiWbGTSOucZf+5Z6lD9UY2b
 NR1mQALSr2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIpgAKCRDBN2bmhouD
 12NOD/0eVzZaD4fQjBBYiBAOPxLRo/Sm7deaZtAXBdyL9/HYJb8xLV4oZoAja8KYgQOXorIMPoj
 bX9BybGjnXaJgxcDLXaEu9BL+IZMMEHqhtb54jnFzyK/p4CWCEgCUgSC0UFsKZjEXpeBmOZkJFc
 6vk6IRa6wj9LedgNYdo6qWNZyfnAs8COTojDU7wDE5YkD+76CDVjSfbOmXaA3k+gEdNfFl/DED5
 ukw3aVk91nRCYY+iETIqzuCbRDy9OO9Xp/VaTM3Aa17PCluZD7UtAnlPqwjt6wNG2l9Oi0iYSlW
 FqcqPf3T1Qzl8IBUe+n3AJV81TIykkQh8pYa+iLvlcsiIP8C1NxV6lVZMvmFNT/5Y9kS5G7Nqbb
 EOdxKVbmwxIpXb7xlvmnXcN+eP0NeKg4R1zgjeQkrwaEu6M1JpujbWQ8Qxhk1iyIxz5XJSwDR5C
 BR6S1SlWFxYzP80fGuT4EBTXCV/K4f2fc1ri3xKR+rn2xrij3zfwjFSQeI7YFodC/AQgmQtSVhR
 wm4lYoOFWMACJPDy/tgpZbnlDeKz03cK3t5efJVsRJFXkjA+czVHYiDWtU+WmcroMFJmZU1h+yr
 aZWAXQEfgC+hr9ySFX/xx4Y5YDh3diWXwfX1c81a7vYzhilb8V8kfvgVlAIQ41ZRia9mVMc6VX/
 y36CkiidRFk69Hw==
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


