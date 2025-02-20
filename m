Return-Path: <linux-kernel+bounces-523523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33EAA3D801
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9ED27A6846
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96431F3B8B;
	Thu, 20 Feb 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTOQ5b5l"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8F1F1523
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050101; cv=none; b=BOAtiwrVxuXKN0cZRGeCIrBq/1DgEgd/LlP8L/9TShipPCfRIEKYOKqqChsyVIsNFp5MWL9AVWkb/yshLpwp3aY/h8vyTuHwDJ+6AzertkX5lheQPpR8Yy+0r0m2p/d73NV0+4kfHRvV28HmRfw07SUeuuN3lWSEMNpjRzRMDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050101; c=relaxed/simple;
	bh=h5+bG7QnOGzKdNB1OGuaSSBt1fw1j+BI9wMBVkvkoFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNae6YNceYHP1tdzn02md3AU/rm3rGVLcfWC7O5glSG3ZFcT3dL2+uRYaRgNTuYLhxzfcH8Usy/HLXfE+k7bp6aGDawo2jSATcsC9Mbaav4ro4FoCBuWEA81QzTJFKlVD07FxmBXSRjbGCKOgjpLECwKLbsSUXJRjXd77ty4fiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTOQ5b5l; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5461cb12e39so813711e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740050097; x=1740654897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kmi5qZiZT2PWJkmQW4SIR2YbWKNMaLc2hi9Q1PeeMGU=;
        b=QTOQ5b5lY/sPEsTI3MEib34ZDhz2LgLEfMB04ceN4HFTYp9qJwuH2BMMnEijO9s277
         dS+u2GckvHxsYvqgre8mb705Qy3bTOv/wV4TA+A5oboouNQ0fnUxdg7u026BqVklvPMl
         mJkVW/UxH+D6M72iU+naVMEoMVT0VoVeKqiA6T2Tj70LCSdllTH+HQZSdqVwjmY/sAok
         nW2UgTiCOxD9iuw8ldD8Sk0tTmwxGeUWf8TSS6bREkXH8l/VsZi7Xcunq9EdKOO6awVG
         oyw24LUZXbzIX+1HgtpfRzEaObenlb5STcFQxsrmYjO9OgekSmlQCp779OGIeT4W4rNB
         AkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050097; x=1740654897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kmi5qZiZT2PWJkmQW4SIR2YbWKNMaLc2hi9Q1PeeMGU=;
        b=oRTHwC2kQKuZwqFRPJhXnGyDmAKKYKgfZD6ig2VIHFSLiwW618I0274KZTgBhjv6H0
         Ox5d5s6hyLcbix8rMV8EsAtnaXyAofD1sdJUpKE6PEGVMoArt3gBsOtJtnsyDmv+pb5T
         Dfg7RawQPzaxAFvgMLaaMGWAz4QVW7fT27te/g9iYEYpopXn+MyIj8E92PXBW3wsMqfo
         BBZ2D39sPl5Og4GuvN4saMh6d298gF8Bq0ZZ6qkgS8j+zRtClnDc+HyuvjWe7/JOq0Hv
         SXgW4hXunJImvGXHw/KeoDwvMSS3L1qYSwMmlYFHR8Ko2zfP66lgSfCPr0ryATl1g115
         tZsA==
X-Forwarded-Encrypted: i=1; AJvYcCVdB3dZc8mz0o4VSbWd7KcRQENL/gS49p0lGiZgcpFkMt1Qc66dL7Mya6iktZ0Pl/uwQwPREAQaktybm58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcP+LcQbCWf/b5MWWZSUNxCFoGqvhQeTSME7p+XRhs6fv9cWk
	z3y9xZEYRvJ9lk5AnKJxIvlKFeQ45PKMZGoaCwblVGXwqrAnQ/LT1in4E2o+yxU=
X-Gm-Gg: ASbGncujSDLXPUiw74cCE35pRz44sruBYfLWluuu8HOlEor7I1d6ieSgdJ2OcpFM1Oz
	7JNHCpiZkTSFIhOPRlwY64mEluCEiFpWYofCRrBBgnqGLfjzuVBqAYkqzVZj3oNlY1gVd7uPfZQ
	wtB6rbiR6V/Gco64kxuWH6n0V5QAfUlsK+hkJESfcaR559mE9vyRZ03rWDakC0FRQO4Dnxc5I4u
	6Lpuwg9YfP76MrinlzFnkGfNN1n2pVa7NWrAMrn1EmH7nJSG04hxTSM9TJPv9tXtGtOHMVETc+J
	QNCb1zEYCdSwz3TNwhGJ2Tk=
X-Google-Smtp-Source: AGHT+IEcT8WbQ5vEweEAYBbOtxpJnbkkjGYmd95cHUJt/YZkrsXFT+WC5s2N5eKXQwAqzYTMpYUmmA==
X-Received: by 2002:a05:6512:3a8f:b0:545:cc2:acd7 with SMTP id 2adb3069b0e04-54724a7b458mr785756e87.27.1740050097280;
        Thu, 20 Feb 2025 03:14:57 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545297856c6sm2056164e87.142.2025.02.20.03.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:14:55 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 13:14:43 +0200
Subject: [PATCH v2 1/7] dt-bindings: display: msm: mdp4: add LCDC clock and
 PLL source
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-fd-mdp4-lvds-v2-1-15afe5578a31@linaro.org>
References: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
In-Reply-To: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=h5+bG7QnOGzKdNB1OGuaSSBt1fw1j+BI9wMBVkvkoFE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntw6rLFo5o/3jAn6PLBBB8PgMmUUthGTk+MMz3
 InhVdiOND2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cOqwAKCRCLPIo+Aiko
 1T+3B/wIyihaqmkz1M8Ue/9XefuiaGR4R8gc3Nvfhww3ydt5DSX5EZw5UVzMInfEP1xG4CPoA4u
 hKzVa8HwQouiKCKBbdX5vF79BlHcquloeI5Y8JH6w8VLkE0JCiCm1swqbq2Ak52Hi8zWgVMaZ0N
 /4iptmF7mzSgUYBc/4uQVWvhGzUVB/MxxldvDVJF/ETZHcAK21P7ej6V9VbrZG2QLDAaP94Gz2t
 2WGe08QpbdMkw1qz+JWHeigDBpghXOuipKUNxeWdHH3v2spRexhSKjgHaMVb9113vqi9ss/DvkT
 EZgReHrtG6NJUbt410Dl9MpFn/PHtEem1Eo7Use0eqzsNWEF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add the LCDC / LVDS clock input and the XO used to drive internal LVDS
PLL to MDP4 controller bindings. The controller also provides LVDS PHY
PLL, so add optional #clock-cells to the device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/mdp4.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdp4.yaml b/Documentation/devicetree/bindings/display/msm/mdp4.yaml
index 35204a2875795e2c1f7582c8fab227f8a9107ed9..03ee09faa335f332259b64a42eefa3ec199b8e03 100644
--- a/Documentation/devicetree/bindings/display/msm/mdp4.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdp4.yaml
@@ -18,9 +18,10 @@ properties:
 
   clocks:
     minItems: 6
-    maxItems: 6
+    maxItems: 8
 
   clock-names:
+    minItems: 6
     items:
       - const: core_clk
       - const: iface_clk
@@ -28,6 +29,12 @@ properties:
       - const: lut_clk
       - const: hdmi_clk
       - const: tv_clk
+      - const: lcdc_clk
+      - const: pxo
+        description: XO used to drive the internal LVDS PLL
+
+  '#clock-cells':
+    const: 0
 
   reg:
     maxItems: 1

-- 
2.39.5


