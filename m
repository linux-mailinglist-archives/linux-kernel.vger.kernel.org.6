Return-Path: <linux-kernel+bounces-214133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2603A908004
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26C528410B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F3ADDA5;
	Fri, 14 Jun 2024 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jE7Rcqrj"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5C4A11
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718323354; cv=none; b=SL1YKer9lYg7+BUxFrfpfuip6g8ALht2nGwhGcnFVrwi3m5MHRDeEEfeHXFkGry4uw1cyfeIwFVuzmGQDZO5oASA6H4ttv6VU3PcVbSfOrF42p6R7QdmqWlGb8+uHM/WViywuHQh+EtYXKDUOy5ehqdxu1oSP7npOHatbWt2Lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718323354; c=relaxed/simple;
	bh=bwFTYS1LXMHaETrXdK5thhWhFT5+sEKZ6Z1fZtNY+wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwzZT1fRYdr22AyJqqetH0MUupPvgRXrwLgcL8WPT1/ctQfEKlc40zU214UTJsebmJZd3dJAeqTPQTqbSMSXkgH/Bnp+v6D2nRuD0auzfxB0uZRgYqkON/URNblRs5d7UACjSBnkNdEjyhAeuPWgsa0vWo6DkOUusXDLC+OPWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jE7Rcqrj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ca342d6f3so1094919e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718323350; x=1718928150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6Pigrl3YMiYV0L2puz2MCBrwA4BsCn0v5eH3hYPj3M=;
        b=jE7Rcqrj6do1piaKkNk6EVfv7wcH9EHSEVRbooOO88hdIBYuI6iYVjCXaEG5dif+CP
         1cWQ5pDAnrTMPXQSjq0CVmUK9SkfFqcsfXKjpoqSQcOAfZMNXxoRyx8invgZfnBagHu1
         AxNQm44JXlm1oD4DUyAd+frcyACb893pA+Izk1yADak6XfrqQ4OA9pSt/IAmt4jn7Nbx
         0MDZZV8nKImTrXpyxltLLtN3iabiU35NzQXNoVuqxWDWsrywyB6o3yGLoW9AiGs8HHCJ
         x+QDUa1X91SlM1PhpA+1OYya04nBH3JmhYUlx/Nc41x8Ga+u9zADCtChpLkVA2Kmboq4
         LAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718323350; x=1718928150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6Pigrl3YMiYV0L2puz2MCBrwA4BsCn0v5eH3hYPj3M=;
        b=m7OzUpG3ly9ZqPdR4rTxIGwnMqW6dDZvAAZtkkE+q3mgc7JeJQP34rJwq3bdTlgQ34
         kvI0vJaqh/pO/ceIuXnScsbA8V4uVK9hX8hD51HsosRHa7vr/EO2vIbhQn89ECDxfNvD
         Zjc440C6j1J4w+KvMefgY8Lm8MT7EkY2uF0i6tS/DCy8tZQ1R4tCUCXuaCb66x1OJD6c
         2TyuEBWoeMP7OQEPiRLvpNBIPRGYzRwVQhyjhyQvUBtDMYMmhv3UyX8nR08LzQIuIEIL
         4UfYsu7/gElpIQq9IjeEuLI4MLVSlqHlNe+L2Be39ztERfYa/0etPE/6m0qQOt0VxuCa
         kYzg==
X-Forwarded-Encrypted: i=1; AJvYcCWgodjKnoQIU6eS7PR3nLgO1TKvO6JITFMPUWU6Z5yviQD0nmuBIy1dkzgdXEj053p+fmuLmzop3YyGoUG/L9fPTAEfNl/nhnEFy11X
X-Gm-Message-State: AOJu0YyXWHw7922zCDrAlDD3cqzFO0bnZtww+TiYUFn2aGh7ldpCG7Jd
	wHGPhL1BMhxOPKTpAXIPv8jDMwjQjCbee8ryuwNJ4MGJGVcVtAmT3/tnzZoxEBE=
X-Google-Smtp-Source: AGHT+IH5UIwXjKfdAlrtgtsP/gSAJqsbdrJZUJutPq0mL+YKqAKX7hdu9dO+j3gNoMNN5f3Ra3X8wg==
X-Received: by 2002:a05:6512:2204:b0:52c:8a3a:fe2c with SMTP id 2adb3069b0e04-52ca6e9418bmr803193e87.45.1718323350643;
        Thu, 13 Jun 2024 17:02:30 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca288804dsm374797e87.262.2024.06.13.17.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 17:02:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Jun 2024 03:02:21 +0300
Subject: [PATCH v4 2/3] dt-bindings: display: panel-edp-legacy: drop
 several eDP panels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-edp-panel-drop-v4-2-4e0a112eec46@linaro.org>
References: <20240614-edp-panel-drop-v4-0-4e0a112eec46@linaro.org>
In-Reply-To: <20240614-edp-panel-drop-v4-0-4e0a112eec46@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bwFTYS1LXMHaETrXdK5thhWhFT5+sEKZ6Z1fZtNY+wI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBma4iSZsRNQHJbZ2W+MlzIjjpWcJvGuGGSRSBPl
 oP3J++Uqg6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmuIkgAKCRCLPIo+Aiko
 1c4ICACTV5xKxTeR4arRjMWq6WVUa4a11qDoeZstp6WyrpASyxBgyXbvip2HW1SwbJxXFOhuUlq
 E9kJZMdQp1ENLl3oO482umdp3DMsEXlqlivUDazOSuVXt9NffF6tL5L15vxLd+eWSg/7USAY3zU
 xRlO66Y02jrnuYV6WJ4/xBXZl57y0rKQeFcQqSbQ0eYq7XFgq5TCN6iHB2o6k8/gUagTxdUEk+b
 BkhTxoZ1lYwwqdZJV9FHijzdRFqpRbZcyvfh5eUVs0BTlyZrjVBw25iEpaVLtjPNO6E6FXlt2Dw
 sGW1cCncmCkFnU6RVYWKZjaqIKIcLifZev9xXLuGGabDlJUb
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The panel-edp-legacy.yaml includes legacy bindings for several eDP
panels which were never used in DT files present in Linux tree and most
likely have never been used with the upstream kernel. Drop compatibles
for these panels in favour of using a generic "edp-panel" device on the
AUX bus.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/display/panel/panel-edp-legacy.yaml    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-edp-legacy.yaml b/Documentation/devicetree/bindings/display/panel/panel-edp-legacy.yaml
index 9e5864de49e7..b308047c1edf 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-edp-legacy.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-edp-legacy.yaml
@@ -31,13 +31,9 @@ properties:
         # AUO B116XAK01 eDP TFT LCD panel
       - auo,b116xa01
         # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
-      - auo,b133han05
-        # AU Optronics Corporation 13.3" FHD (1920x1080) color TFT-LCD panel
       - auo,b133htn01
         # AU Optronics Corporation 13.3" WXGA (1366x768) TFT LCD panel
       - auo,b133xtn01
-        # AU Optronics Corporation 14.0" FHD (1920x1080) color TFT-LCD panel
-      - auo,b140han06
         # BOE OPTOELECTRONICS TECHNOLOGY 10.1" WXGA TFT LCD panel
       - boe,nv101wxmn51
         # BOE NV133FHM-N61 13.3" FHD (1920x1080) TFT LCD Panel
@@ -56,8 +52,6 @@ properties:
       - innolux,n125hce-gn1
         # Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
       - innolux,p120zdg-bf1
-        # InfoVision Optoelectronics M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel
-      - ivo,m133nwf4-r0
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
       - kingdisplay,kd116n21-30nv-a010
         # LG LP079QX1-SP0V 7.9" (1536x2048 pixels) TFT LCD panel
@@ -78,10 +72,6 @@ properties:
       - sharp,ld-d5116z01b
         # Sharp 12.3" (2400x1600 pixels) TFT LCD panel
       - sharp,lq123p1jx31
-        # Sharp 14" (1920x1080 pixels) TFT LCD panel
-      - sharp,lq140m1jw46
-        # Starry 12.2" (1920x1200 pixels) TFT LCD panel
-      - starry,kr122ea0sra
 
   backlight: true
   ddc-i2c-bus: true

-- 
2.39.2


