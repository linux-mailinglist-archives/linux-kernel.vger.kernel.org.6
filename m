Return-Path: <linux-kernel+bounces-556791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D1A5CEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A971884815
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B82638BD;
	Tue, 11 Mar 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aefXyNMT"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B0265607
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719750; cv=none; b=j4Bm472pCUNuq2bi6JrEjrjidx5n7Z6vMU2cQ+YhwAa7KN5lBrG5RBHsTUoZakJGQEJpNYhIM3Se2qE662Okku0EogwWwWD/b1ae12MR+QEdx7KS5BzwJaPGxY2GwCQq+7CaTOw1yggkrelJnEZWLCTdXn/e4s33Kd7iLlSLL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719750; c=relaxed/simple;
	bh=vM/Rhh3m/LDu1luem1JmpPvieCwNMZVHKpBxAm5wGsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB99yRg8Oof52m0+eTmCNgD2TDzGvMP5AjZVRMwG1FK9lbpmjWtDEw9Ss/ZPbfMR3u5Igtm3p/WCoHk/Mr8iL8Z9T2kONTmW32O+ALf6xSmoOTP/MGbxPOav9hzOQ7s2hbYHyVKkINAeAzmYHYVyl+2zn5CLftGkS8TdrnIOlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aefXyNMT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39123ad8a9fso371369f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719747; x=1742324547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX08Ji8HI3+KbtFLo37LoGENRgVWTP1rrMFXfNP52RU=;
        b=aefXyNMT+u4eoQZ/rFXa1KyuQZKuYpvoLRsy6tUEFyFTwZuzsqp4j6bqT8l2a2RqsF
         zS5LjcPKxHrAWlOcpEHYnZa/brQalweeqHRVBDTWzmlVToo2YFAEKhUa1m3fYAVBUq+a
         XaAilJl4JhazhCMnXY91FAl4JM2Ka2SyzSHxIyw2RaYw9lrLsmp2haT1STJ7PgJeVprf
         xSgCP8yFhv1OshASX1wXfuJ7lxanU/EcU7s4S4qWr80VIKCBJcmxMC5+qWO3bFJEHov0
         +LqVsgipla7NSp3zsexNBx4KxrfclV0OPPO70KHIcbhJ5otNQMK8Z1WQ+zWvHB6MBx/z
         AeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719747; x=1742324547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX08Ji8HI3+KbtFLo37LoGENRgVWTP1rrMFXfNP52RU=;
        b=VgPiTkrC7KvDz0t7urGL4yzljBLbdUcwy+mHrvW2KJTH+wnZMcKhSqVRoh++h+Y7nu
         IIPEsoqi0CAbpPZx0RCEiWv3k5uKa/Zo6keUdRT01JPvjkRgtu6XoC9nVK8celgGRkU/
         26DH/sopSLEpFV8nuBM6/NHO+P4w6LEQyt8W5H0k+3jFMrv0Jb4L3YkLAVxayzU9RoAd
         TUsU4G6V03bxc1jAWsc6wAp/dOzx8c26X87k7nSTRdjggK7dI5EYRQVWqRQKNT/VszC5
         yiitW82b0lCyNZEgl/1rhT1QhVsj+1ZwPfQcB8grkTb44xw+IWL994dqHV++/LvYMiJr
         Qm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRE7k0edtLrPbN3lDxT1BU0OKgyMNvAUesLuMNpde9qL4s5YRDjh1tLWcW8h4lU0pijAlHsQEoARXgU3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXbijWTUb828HHF3CUEVaB/gRwgEo3QfkUOVDIpwVdFfxTNW/
	JhQQz5qbntjrcmGDiPnafKMlQIqOaFt6ATjKp+/ARJVs6R4kE47KpjT2g5Wemmw=
X-Gm-Gg: ASbGncsv0hzotCwkg6LUpYk2HapA315bKHEzPZj4pu0hgMi8y9fNJkcYjoLMA+F8l0R
	dZUNJFsddqywXCMNBPgVy5scQh5rhkwTnr+mQaGYoG8jCk9GzqxqcD7JauhOJHFGIj69mU92OxN
	miFVasapIH7RNKjr3WN0mL+hucFqdFE9qBoeK072IWbr4xW/UyLeG/gX9t3g7c0OPgI8K8M+rNW
	KBy7wCRw980l+Z3lwAdw5olAT4m9y8WikZS4kLctt5i9i+TEg0nNJFmJvJWYNIgUZMEGOBpmiVi
	Htoofe+gYBhba1luTsTZB+dqz+NmsY6/VprVpkNSOgg6q1VDBdmxUfL9a0Y=
X-Google-Smtp-Source: AGHT+IE2n0MfJYoUab/sCdFT6aJjrI3Uvq0aDb8rnqdRJQHOYDQUaJhfbkTymsdz/VIXrXgdwkFI5A==
X-Received: by 2002:a05:600c:1992:b0:439:9b3f:2dd9 with SMTP id 5b1f17b1804b1-43d01c305cfmr25909345e9.7.1741719746990;
        Tue, 11 Mar 2025 12:02:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:01:54 +0100
Subject: [PATCH v4 04/19] dt-bindings: display/msm: qcom,sm8650-dpu: Add
 SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-4-da6b3e959c76@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=943;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vM/Rhh3m/LDu1luem1JmpPvieCwNMZVHKpBxAm5wGsQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0IiocmK7G66FTqUKGat1Pcxqrslw0gSJB99AE
 o+CCOeaee+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIqAAKCRDBN2bmhouD
 12fHD/4rXszGtQ6+BkcqOFgb6A3GryEXr2IaxtUfqKrWkKyjYlq6wvQ9318mCdgZrm/DHBVqdsv
 G4JWx+ued+V+4MctrGrkeeITliPnnPVgI4BkWhbQa6gRo5dFGsVVbKZwcltpk7gwrB58tm/JYzx
 L+ED/1OP+uGKSfM+rJfQgnnppTAn7JBefwB9maqx0dyXfT0eW0AIhEVZ0omaz+/fVZFKGaM8Ylw
 JXK6UPuVxjF8LVr2wxXYt4efqgWX2vvhllxTuq6xZZdTtYjDPUVQDHYWoxkv1raZyDuBstdG30k
 oJelobea91F8Vo6W2q+PvKNCXz1msLvAMT8nkfPXxUEtORLp+2Mc+dZm1HB0K85ZDrH6pcJydLs
 99GEHJBeOOACp0gJU1GUfobaMGDmEpSMdGZMhsaH/njw11yvmOgh6rT451cXUhm3+MomAwV7FBw
 8anWN/cwJB3/XDiohxwhhtC6JsK+ep7FuwAT4XRx6uFBTvtiKvZglVEvhu5lKIXZuK/k674D62e
 kwxHPFO51rJrApDv3bh2nT8GUwYnFcyrT9nsMi0svF0N6ufaEvducVNJIk03srOfdmeSoAKtiYQ
 FhbFbElPjWiu+9yp59id6Zxx9lbs6tAkto7btoGFtAzKPiHqgbRd7zeI3+vkadvc+rhln9vBFnj
 NUBdxpqFxUTm+iw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add DPU for Qualcomm SM8750 SoC which has several differences, new
blocks and changes in registers, making it incompatible with SM8650.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 01cf79bd754b491349c52c5aef49ba06e835d0bf..0a46120dd8680371ed031f7773859716f49c3aa1 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -16,6 +16,7 @@ properties:
     enum:
       - qcom,sa8775p-dpu
       - qcom,sm8650-dpu
+      - qcom,sm8750-dpu
       - qcom,x1e80100-dpu
 
   reg:

-- 
2.43.0


