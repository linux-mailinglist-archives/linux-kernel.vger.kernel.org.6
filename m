Return-Path: <linux-kernel+bounces-226401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB21913DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311702813F9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3C185092;
	Sun, 23 Jun 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0GLX5pC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402F184127
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719173009; cv=none; b=OzYs1Cp9b9slNPi32B1X9G0nZAYtBgl7g11hV777w0aIXtIud25qNauLr72esnxVC/BvSvwdZu1yBgearO3Sr8t1keyyL/pENZZSPJQgF/Eq6bM6PxeugqnoQDaDsphKl8L1VReelQgJlEqivty4qcyQlY9yY5yCqyAy8uJnsEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719173009; c=relaxed/simple;
	bh=4/9Aq/arFNn+xRSwSsZRPh1izhnXURJa1LwMF+ulWIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIluaMlvxpSMj+UUJ1PL5ZHrUx4jquRr2ixzXhZe0a4udym+HE6Roeac9Hu/FctY9RKNASWmAWY7L2/K2iTuTQZjaoe6eUNNYAyM2MOBO5lT7vDueKFm2wY8p+/LfZlhv1+C9fZ2gc5rik4G5xZr0e6CXAU5ntg+CfEnXW/JdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0GLX5pC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4248ff53f04so2741015e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719173006; x=1719777806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRwsnzJtrZqzT+Su1tk781Q5TL7jN+Wj95SuluafSco=;
        b=E0GLX5pCQXaobxqucSlqO4alw44/XygXWGzIoevVGbEyA1A6YDOo6STSqw2w5aefRD
         XKg3NuE67aYFCEF0W3lkj0Gd0iIM4GsJ6xkh7Riv8lnbJXeqnETHeWjVkYMXHj/M81DR
         cfMK+rIpSQCV0NaLCU6dFGS3jvtny1fb/ZQaCsVPIm+F65WXgxvw5w3RQr708rcTJn0Q
         AK0uYSA8hYEUfQ6I2kwJ7BQOGD/EZv2x9DF0nrlX2VeQq0yifhIvWHzjc6DfzB5UFxyf
         PRjl5C+4eyFFtWUDdSvzkMpnHqyFpKBPepKBNs3GL1iMeYQuQGXZYN9aDTcIJ6t/OzpR
         CUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719173006; x=1719777806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRwsnzJtrZqzT+Su1tk781Q5TL7jN+Wj95SuluafSco=;
        b=Y61gyhTkBgHWQl2LuDLJoEV3iMOPxL75ixrxXsKAzE9wBrwBfR3gFDWB5ktxPoXXnQ
         LRnrzm67ihoBZnlIcOuf1KyReAymMsoWiCrye/wuP4qtD+yj/dXNeDi6zA6GXYtUXxgh
         bOD1Cz5kKxJeCVlntKhc2nL52YX1DfX8FHlfWEpHwV7cChAhJwig8hZ5VjYiSoVz8XnO
         mjTndDG/20el2ObttgP1tfRiKZuK6FFqmT7P+lV3K40ysK4NFD8pzhSYbJGgpb0yY2JH
         +GXL/hvnGv5+++LOK6ClwLNtDVKwdfdNyVoYQwI6UL+K8H16FMcVIAiLBI1zU8iY+a9E
         zmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUoROeIBrlQuArr6TQBhuHkUyKVN4bqTppyubQZKYA+RoAQCPopT/CQFVaN690OCXs0rBI+fUjdUikdSNfINTfsnClf1xTL1WExe6A
X-Gm-Message-State: AOJu0YxeKE7a+KkHjEa2MUTBTSHBWA9SmDOkAgMXohdHpHs6OnsRN/ds
	/zoHmcABlQr8YM0t7UNKuaX/fFcp7g08zazS2EHUki6y22BAom4sbG2zz6e/rfQ=
X-Google-Smtp-Source: AGHT+IFJpv39zP4029Ssli5x6YQ1Ds7nJ3+NECE5rAgHlYqbz/JJirZIdj6Ljc5SlMfSG2LXJ09QnA==
X-Received: by 2002:a05:600c:240c:b0:424:9477:ba19 with SMTP id 5b1f17b1804b1-4249477be72mr1664375e9.0.1719173006056;
        Sun, 23 Jun 2024 13:03:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54c9sm150685345e9.27.2024.06.23.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 13:03:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 23 Jun 2024 22:03:00 +0200
Subject: [PATCH v2 1/4] dt-bindings: display/msm/gpu: constrain clocks in
 top-level
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-qcom-adreno-dts-bindings-driver-v2-1-9496410de992@linaro.org>
References: <20240623-qcom-adreno-dts-bindings-driver-v2-0-9496410de992@linaro.org>
In-Reply-To: <20240623-qcom-adreno-dts-bindings-driver-v2-0-9496410de992@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4/9Aq/arFNn+xRSwSsZRPh1izhnXURJa1LwMF+ulWIA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmeH+GBCUCUJpJdjHiAhVps4qq/mnaC30VIybMf
 k4SsU1FP9WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnh/hgAKCRDBN2bmhouD
 1zJpD/4hFM10qme9VeV2lS5WgpaIGfkSCtPbJ9yqeAmaQunz1ilA8smxq8cdUVXE9gLxmFhU5l1
 lQI+Lt85hl+Y5dXEqzVKxzrxeWj7YMdNX//e9a3b76kZPr3OESjU6xFZ8wYcAsFPyTqiKUFh8FU
 hGD0Cy+ql0nbC4mA3mQSyQDKuDymYy55LJjnruaHgjIx8dE1LugaPIOsIbfgU2tC3TMhLBqkvrw
 jpIfJu0wJd2iY7blxkFwA2i3gAvo1FHIlj9k0oUMNo/miPH4Bc6NEux0tDGkDftTKM9gn67wz4D
 7YdaDJ24YV7g1pckorl4PYZS6cLcJ8+MXl+ovS4oYAf3/21eqYYUiPTCYvLvCjDCh/t+gcki17U
 b5gZFIG+X7H5IDDEQNk9QWbjP9fNQdqeMkgyEF4p6fF7j10zzpGh4IllsMEO2bY0h91CXKqG+A0
 Kkku9mY+F7xAWHFIB38ZkRxZFcP3VicGP8HmGnase3+7GOWNG+xSNnkzUdRhwB9uZH/taKN2e22
 v8jUhjV3gEsrLWjXqsrIja17NJDgakeyCKRqJizfHMBJIuE1lkP642irbb2BCnfknwUSdQVhDpM
 EaiPu+ZJ9ZmllVhplasqbS8nXwQoCwCL8Ct9Mm4dmk7Y3SnKlr8mxcNmqB08LjmKjTkxsEVronl
 XRvouwunMTYdgig==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

We expect each schema with variable number of clocks, to have the widest
constrains in top-level "properties:".  This is more readable and also
makes binding stricter, if there is no "if:then:" block for given
variant.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 40b5c6bd11f8..253e68d92779 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -32,9 +32,13 @@ properties:
           - pattern: '^amd,imageon-200\.[0-1]$'
           - const: amd,imageon
 
-  clocks: true
+  clocks:
+    minItems: 2
+    maxItems: 7
 
-  clock-names: true
+  clock-names:
+    minItems: 2
+    maxItems: 7
 
   reg:
     minItems: 1

-- 
2.43.0


