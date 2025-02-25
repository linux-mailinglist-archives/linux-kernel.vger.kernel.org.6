Return-Path: <linux-kernel+bounces-530833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD01FA438FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9748042141F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7DD26989F;
	Tue, 25 Feb 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUsJ0JZZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521A26981E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474353; cv=none; b=r6Xne1rKIbU7tpJUcIq9AnFK+MusjC8uFp/3W8nox3XRO/MHKUZIrAwTIwUPwnMYQ5lOy/3QresjnvHc6mwhzd0ij8WtBdeHW8NS3O21yc0iWBMLDcMS5RWpf7vIv2SGmSp9mCZriblgbUGGgSb2rNvWSMunm0bv5SIgBPXRR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474353; c=relaxed/simple;
	bh=JTVJkXQ8vZ6nxJX4jG3BnwDYUC+zBILYi0/GP0SyV34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FEd0FL5YtcbsQlRObuGOTaIJT10T8OWTInDhjINIacOQgFgRCvJfxZsn3YcnuFj8gR9xosM/OMWZIo+tNMbnSlkj0Q39sAgwjvkTmz37QKQpyjDkOkOr+ASVtGjtzXzvrAscK2i7D3d7vZeVoyFSy8SgsTNwhdfpApnckFLKBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HUsJ0JZZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb9fac29d8so81191366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474349; x=1741079149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sAL967SIYKC/s55u5inAE7XXnuMpEFX5DsCH7UXWsg=;
        b=HUsJ0JZZoXi4Ve5GDn1QZdj4oEyV4iZo6rXORGGcIK55Sh5i8cn1J63R954ivbK3Ea
         YjI2EXejdAdooyB2JgRY1XiU0ObrbrXZokCkpXclQJXFw0CGqGx9aG00hQfrzHxAUnQ2
         KtUad4eKqGYY+yTW5kLf3XAcTRBMRG3vnFfVsmoaStcQHrLwyxlSwhHxQuMAfSOL+XGS
         TZ2MVJsT2jTKjiw6SN4DDVm6rfQ8JiR1Xpkktyz4ctOIwBUg5FeiFSMBPcuoCWL9K/fG
         BWGOWRrCZz+ZVyZ/Yn1HLjtCwgtY6XArshVJK/cZICzvXGP73jr5RN3ZVNcz7CxUO/SE
         +5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474349; x=1741079149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sAL967SIYKC/s55u5inAE7XXnuMpEFX5DsCH7UXWsg=;
        b=p5K/T5wNPMNAeOKrEVE5q8/EeAYGUwKBNlZO3T5/Wu/xgYl3jslO3jprFxOvfZOrZC
         k2lrX/fcryoUpEn52WOizC3AfL+nCfbOniVVWacrhKnXKMZTnpmyEC/KJoV2Zty70QLX
         Gn9LIGM8+c7khfgujm14GIn0UEkyOtK8ZUV3ZYRbYTgFXNaI9wPKWS4TKk+G/8eJGF1z
         okMFNzhoBp3roXENlubJcGQ9xSu4oboAm4KqT0nWWfj7xPjPxW44VGfXL6bIiUxVJZkF
         ke/hxBHlTsjf+ncXViNsArZZ+EuhB3rqEVaHrxqdBTmBG1eCIjQMoY17TdeagHILr3zB
         l9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWx9bXnLR3E+6SRVrnA8wG5QKemEWSFRFe6N5tBBOVfmrPiEJEjNq+l6cb3uv9KyCK9UkaVMKbqG1HCpM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2qjKZu4UrDG80wMLWTlIKbo43mH535wzfmnXBmcYx64Qe4Vk
	0jLDbyPyoRPf+49NDPBIkPfcD2NQnJnma5BoORDJQHxA3nCvwfUs8sK8cMen6Kk=
X-Gm-Gg: ASbGncu2HwM+aA5acX2BJYd0xQWedyc176EynUezIFr3aXL+YUuWx8g6suk6e13iAdb
	dRAg88wBpFGDdlShZ1TTgLnPNk/PtxlZldfIG1bT7Qk7bvVkhhu9KM/MeqEZvrlSZ0/lFWZD2wE
	AbV+POldWR38MqDNB+Q5hal+R9KiJhAK6T0IW0TKCGU1NenI4jULmrChrF9lNNVvv1AltCN0t/4
	+ObbufRtfDMIpeeJ1KK7aJYJ+NK1dt3oUhFjlaIzuefwu8pMone9T49/jq07RL8aV75/3ao+9FQ
	4ziOEJHRfRyX9Rg8MAGzmn0qGW4IEoddOjzBsHD+yrevxSub8eay1aMuT7rcGouPqQloS4ueyhZ
	k
X-Google-Smtp-Source: AGHT+IGN/O451uNdobw5eR4f+pisbXs6lLZFYeSNFMLURRhFrS1Naf+7h53+qP3DXrYTQROzZHfugA==
X-Received: by 2002:a17:907:9713:b0:ab7:5fcd:d4be with SMTP id a640c23a62f3a-abc099c6a2dmr697998666b.1.1740474348822;
        Tue, 25 Feb 2025 01:05:48 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm106681566b.148.2025.02.25.01.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:05:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:05:34 +0100
Subject: [PATCH 3/5] dt-bindings: wireless: ath12k: Strip ath12k prefix
 from calibration property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-b-wifi-qcom-calibration-variant-v1-3-3b2aa3f89c53@linaro.org>
References: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
In-Reply-To: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JTVJkXQ8vZ6nxJX4jG3BnwDYUC+zBILYi0/GP0SyV34=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvYfiP7AFaiu4hFbS1G2fGNJ16ZvacyJZZcJr4
 ReBMJiTMmSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72H4gAKCRDBN2bmhouD
 163kD/9429RBSJrEM4OsIa9/ktExaWuclrDJQb33xACbdd4jmZjrfjtDiE3ESWVQIMqreGJF05i
 UgWZj38mrrVTZYpuTLyBQzdQ4EMS3tkMqaqKDCaLrfiAXybkDMtJ4FeU/TUcHmixMaEjJRiln6/
 7xfL/EYwvmiiaT3MWxptJ1udSDkqiHc6HUNvTxU7aUT53fQhKxwaju1811sc174zOGGfgTKchfU
 3Y2+ngkl3645+n3JUwq5RJc7Ynwc0mWKFohm6IbFyBS9Oc7YI10FY55siDqulHQDf8Vee8PVrvG
 5ySm+X0rcV9Kz/oZwClVEAXUPTAjEMzU24eNl+fK2gU2ze4c87Y19xDYsPhpDnnXxAhP3KXpyYj
 onMZ+FQeuDpZE8Bb84fXSI78eUUuJn6zQabIo3iFuETZRoUlDY03EXWXBpx0iGm+52mO1KS6lRm
 MMiwgTopTmUTsof2I+Jylsyxn12jyIkRAk40ThFH62eb+Ey186eN6Z+C8M90Qtn8acrN8ZU2+J9
 Vodz/d1LBcFeNHFVqwL02bkAe8oDr61MQS7cmmQv26tAqwiU+pueOt8BZYq4q+hKiOMlbUE/NkN
 ucrK4S2RMjgglWL2lf93gqTRFRgt88OZxY8QVyFaphwzPZAHYjSD22jvfZoknxC9ak3zscZDi0n
 T5wq/ixczbgRvAw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Devicetree properties describing exactly the same thing should be
reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
certain calibration data, so properties should not be prefixed with
device family (ath12k).

Deprecate qcom,ath12k-calibration-variant and alike, so we gradually
switch to a common property.  This will also allow moving these
properties to common schema, if desired.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
index 318f305405e3b34e66a31bec7460c0a9d020ebc1..589960144fe1d56eb6f15f63a2d594210e045d27 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
@@ -52,8 +52,15 @@ properties:
   reg:
     maxItems: 1
 
+  qcom,calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      String to uniquely identify variant of the calibration data for designs
+      with colliding bus and device ids
+
   qcom,ath12k-calibration-variant:
     $ref: /schemas/types.yaml#/definitions/string
+    deprecated: true
     description:
       String to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
@@ -103,7 +110,7 @@ examples:
                 compatible = "pci17cb,1109";
                 reg = <0x0 0x0 0x0 0x0 0x0>;
 
-                qcom,ath12k-calibration-variant = "RDP433_1";
+                qcom,calibration-variant = "RDP433_1";
 
                 ports {
                     #address-cells = <1>;
@@ -139,7 +146,7 @@ examples:
                 compatible = "pci17cb,1109";
                 reg = <0x0 0x0 0x0 0x0 0x0>;
 
-                qcom,ath12k-calibration-variant = "RDP433_2";
+                qcom,calibration-variant = "RDP433_2";
                 qcom,wsi-controller;
 
                 ports {
@@ -176,7 +183,7 @@ examples:
                 compatible = "pci17cb,1109";
                 reg = <0x0 0x0 0x0 0x0 0x0>;
 
-                qcom,ath12k-calibration-variant = "RDP433_3";
+                qcom,calibration-variant = "RDP433_3";
 
                 ports {
                     #address-cells = <1>;

-- 
2.43.0


