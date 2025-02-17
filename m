Return-Path: <linux-kernel+bounces-518085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4C3A389CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E03716349B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD4226546;
	Mon, 17 Feb 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QR8BUiPM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD63226197
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810516; cv=none; b=TKoDsSoj35ReyNK9abMGWse80E0GhLT0NefgcBbwc1/xsuiAE9pd6VtEMP6+VLvIBchfbgckMvRYMewLkUTkBXPwCwO9Vsj5hvIoCyhv/gg/dd3mukEV+prRB7V0/3tNofodOb6KyRncEFJpXtoh0zgVJa86C5pggOo5117y1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810516; c=relaxed/simple;
	bh=K/LvPsSs8jLRaKqgMy3wwlLWJHnMlL7FxoRoOu4sBqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SALSMxmG4TIr2d1yJOs/bJKuMuy6m/PSRQJEDZ3Muot/z/+v0J5e9f4RUkGX8PK4Jrs1mgDNKFezyaQlgu+u2S2BpBALJJ+8XISyqfdBgPg2VUwFN6j1MKU3iUcPR1oroTrv+Ve7+mqNNN+2n7S/mEerEKZ+vOemUMpKczWcUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QR8BUiPM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb9c8c4e59so25944966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810513; x=1740415313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAwXSbZcFpOuQBHVRwbOUqZidyc0Shw8eVGCnAwERkg=;
        b=QR8BUiPMrzRxYT+0ix/ZmPy27o+VvDXGa//26oeGO/JPengT+ZZwCzghwxnFmPN21+
         T1AB5U5FR/SswxEpl1azdDpYDQVwe+c+x8l5GdpdvmCYc8omcyxSNaPs7fOJwjHvXLjn
         H5J8lWoa2Ahh5FN8SKH+deVTqnBU3rFJ2sTGvy3GirQzvqp7aFGWPdidJMvGqQkJRS5p
         x88pOYwqf5zD4qoKE5s35rTbOxC0Nta8rujoAnSbBvt9kIPsJSc+YHybYjlJ5WIrWd4Z
         WHQ5W6kTHShYZt/guHbVH1OHLTSV1OrkUXKnjz+XJlyMPtWHqLcQ+Y4e4/JCDS7AxRLX
         nfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810513; x=1740415313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAwXSbZcFpOuQBHVRwbOUqZidyc0Shw8eVGCnAwERkg=;
        b=KM5I5Rf7LyIHT7+ptAz0bbdoDtH2k5x3b9Vui6V/GbZlXlrRIXfaZmUtIbNcH93+ti
         w4n1CAyOQWPs5ORG676bijHf7t2wjg3i4fXjHh735q5Hzx3EOfCCnKvvyGmVwqOhtq8b
         icbkg6g0KPbMfygyxVsDensJFb97G5j24RaeqYG2Y5ZcsFEB9gp7D85MgdW4vD8Y7kh0
         i1TkmmWf6wabTc+2MOJZKCCXiPk+qx4FHj4DpOtxzOciZdB6uC0HXZdFodaEI7SxijjJ
         aKuI2lpcUAx52LhfsKuhJ0P3FlTLu1WG9zoC3KosW/JK6HlBLZVoF0fB8ZfqDi0islQW
         3VYA==
X-Forwarded-Encrypted: i=1; AJvYcCW5XP6WeNSdW+l8kQPSDLq8GcFnFZFby2UFMTAEgj44y9yZ8tgEjD+aX5hdgysO5WzWWO8cGg4xC6/3z38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmf0eEYESk7Mfc4DA1dQCkHIp8LLKvkPHTumyU4LQolJuh/Kt8
	8iFtgAfycEXil2hOliGZLnrF51vyBmoidurjVqCM8+I74xz1sT5u+4BcLkADyVU=
X-Gm-Gg: ASbGncs0Hy6X6AfQ/mouuY2808VJLbaMbdW3niD+WWNJyfEvljjs8fNvGgz1jdbn0PO
	pZSwBvlPAiRImD3FTIilLAxRGoIQoG3vHKNfmdk3iUgFcrj3UincaCVRNpslLZM1bTMzaBN000j
	Q8RQmPIaz6cNyR6gYwg0gJteM5iwzcUTAttcvtkX7wqOzbCpbibHoXF1NXoayT+IVCwv9W5sRP3
	hh/ZebfESmjCssqaAD/snz8ETpz9a44eDhtsKBWPaXfTlQQeiZwYvZAFK7j4yZdnkwe16YiPkE4
	3WzHz4a/IQYMsIUnS+4L0PLlqO8tbCo=
X-Google-Smtp-Source: AGHT+IHwt9rKtdqVpWvlWMU9opivZ7B6UiCBuR01NuzfOowAfznEVo3RY7QMrNt1GQOd6t23b+mNaA==
X-Received: by 2002:a17:907:c1f:b0:ab6:db64:b040 with SMTP id a640c23a62f3a-abb70dad1e7mr357653066b.12.1739810513000;
        Mon, 17 Feb 2025 08:41:53 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac781b78sm82647966b.60.2025.02.17.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:41:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Feb 2025 17:41:26 +0100
Subject: [PATCH v2 05/16] dt-bindings: display/msm: dp-controller: Add
 SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-sm8750-display-v2-5-d201dcdda6a4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=978;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=K/LvPsSs8jLRaKqgMy3wwlLWJHnMlL7FxoRoOu4sBqA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBns2a78Jl/FGD655nQ2ck6lMnvuiIvLFc2KWABe
 cxYdI+PBHCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7NmuwAKCRDBN2bmhouD
 19SAD/47HAphtGjTesMY+DDBLPGVDxs9LvcNhaL12xOwXoKX9nzrjNxyunuPfjSnCSMX6P+7WvR
 WOE0v45WZ/wAuJSaUZmryLvApkkf1UCY9+KEXnglMErTefMJW5nA1ZANRAQ7oVJuZe08MJq6UZ2
 6FcW/BuA7wkxKcZ4+jf4/z2GJgBl2B8zrWxAA7vW4AAoF/nwM8f2g3+3cFiEzCEyiCOKFUl+51S
 1/NYFYzfTa8qebl4rQr/QBmTPe+8qoP6eFrwusxrsXJezjXMpAG0kB8Wto/YxxtWfLAEgWE8H7U
 v6FG6CT8MTIMY9YAML0nRz4pcGnsfq2Mjv8zN+LurTsu4WVrr9Y50URiIvm9ufKAe0OQIHBrRmt
 fSt/MfvWHwBdOv8ivzJBjOQZKcVTXFRg1t4Z2ovrdDxNL6yvFzcSMvHKHOYOImeo4JKRRWHX2xS
 lcNVc0pJsEGBPFz1eeYZPiMXBklL2KZGlRXHTKQU3qqOMDdogSf2k37eOf3Qi3zGEUF27X3o80W
 1n9sHksn6pT9ZLoemO+9GDmyV+3j+eKrZRX28sta+LIFpua0998IQwIQ7F1KRFTcwtJYfm9GuGm
 TMXIcJ2EKF7scPlkiwVXAYTHa6K2Tg9KRqnxHO1m5Y9LrSctkxV/vuc7R1+zQuk+0BB6JwUMgxV
 iWuep+VjxioDxXw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add DisplayPort controller for Qualcomm SM8750 SoC which so far looks
fully compatible with earlier SM8650 variant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index e00b88332f2fed2fc33f6d72c5cc3d827cd7594e..a4bf9e07a28355c0391d1757fab16ebe5ff14a44 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -37,6 +37,10 @@ properties:
               - qcom,sm8450-dp
               - qcom,sm8550-dp
           - const: qcom,sm8350-dp
+      - items:
+          - enum:
+              - qcom,sm8750-dp
+          - const: qcom,sm8650-dp
 
   reg:
     minItems: 4

-- 
2.43.0


