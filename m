Return-Path: <linux-kernel+bounces-383274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DE9B1956
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A2E1F2218E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D313D24D;
	Sat, 26 Oct 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKu6Awx2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB53762D2
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957424; cv=none; b=c8AXQHvWndQP8pCUjzEC3QwkO0C5ElGiGxG8eo98pAth2UfSbQ8eBmuxBfh3ZYvjW6mum6MtV5rYjiWINxHKMaq9n0Pc92AcrfnlTjxV8g7txHfuA0NUkwDlpsx6TEcBhTdyH9n/bZJzNCdvgJIE5QAv7Id5IJGcaS5zGmfN9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957424; c=relaxed/simple;
	bh=SxzqUFuvQeeNvZs+W4DmL3KehVYMr+8uYq67jXqmhRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnrHflwBGNZvsvgAN9V6nXMVzzAcJpbTbIAUVPZdcEFUfkFI4HUqL2arxiGg+R4qpqLpV/n0I0mCT2qxvOydewUHqK4uiSsdrTW7sTHzG7AbXql4Q84ErXy1ouqrW+OZ4JLnSwSI7S6glJYyOqp8pcShRlHDs24jlBdiTp+Vgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKu6Awx2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539983beb19so3670952e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729957420; x=1730562220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xraHByh9dspvceMJIW6qTfmhWn4iusv9VtXdHEauAWY=;
        b=zKu6Awx2qGbO8aahWeyMNZ7uyjxM1wQdzMet6kYpFnNaIL7nj8cPmHx2ZoP0uM+kAK
         vyFNWCdvEQmk6RGPD+DgqaO8ZiDWsubaTh4cDDM/p5YBmzHsmXN2n5LwFuUT6GYVVJPp
         zdYnTDulWTUFZB7KtA2A0GKeFoRanbke0z/eAOYyKqMEg/pFe+GRjD+Sy+9uJampWw6x
         9cx2gIQ5j/od/bNwSoz0rvMylO9HfT0/KQoL994YONtoRviWFQSteNihi3HhcKWpR+nh
         LKnBbdkKa+mK9RLpHJ0C38aM/e0hTvHKUDNah+H6E8vvhGE9EqOH2cK2kFCbKP1Px56v
         2Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729957420; x=1730562220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xraHByh9dspvceMJIW6qTfmhWn4iusv9VtXdHEauAWY=;
        b=Iy1b47gQq3YtaZi9ARMEOp2DqWY2BbJftiJcWD2fIt6sjfu4+bC7l4BUTmBA5cPa5F
         m7VtwW2yOforNIL9GTnyORo4UJea9aJrfNTgifjQJAat+mLGmQRlzKzWIThjV+kWhkLE
         KjzFHepLhbN+rMaBMvAWTEHJ4B+U44EYun1zLIlk3QJj2BLE220HXIQ5/20fQNkQMtiQ
         O8rpuCAa/nIYhNdjNLbx6ShQOJokQ6bZyiWWbah/howc4lxEKrtKfu+8nSHjR+ZsoNDX
         54YTsUd5B6np6M/YPwSREEsl/H5Y9d4gTArjRw7JAZa1f27XSnjJAvX3caGt4Na525tn
         QB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUa4uj11UcIgjFgfORXGPVnxkSKjIeZrwxt9bHBhueyGng1hBWywGD7cDWk7JLj3I+1Fy17HLx+oVSlj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGzyu6N9pHFPKLFEjOcYlrFF8iOy/NKPY021I0CFlGe8VEkvn
	nSRAfsn2dgafcn+Dg1vy6ecUgU0b69hufsYYNhUo6pvRC0CZ1FZhKxfxFflAGJk=
X-Google-Smtp-Source: AGHT+IFpoowRY8z6NhOhs/2WxDOFa3lRVAQaYGSZ0R8/N7mCNwXmnseXtek9ufWnGoKurbgiwBp6qA==
X-Received: by 2002:a05:6512:3b0b:b0:539:e85f:ba98 with SMTP id 2adb3069b0e04-53b34a1aff0mr1351749e87.56.1729957419856;
        Sat, 26 Oct 2024 08:43:39 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a47asm534934e87.1.2024.10.26.08.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:43:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 26 Oct 2024 18:43:31 +0300
Subject: [PATCH v3 1/3] dt-bindings: cache: qcom,llcc: document SAR2130P
 and SAR1130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-sar2130p-llcc-v3-1-2a58fa1b4d12@linaro.org>
References: <20241026-sar2130p-llcc-v3-0-2a58fa1b4d12@linaro.org>
In-Reply-To: <20241026-sar2130p-llcc-v3-0-2a58fa1b4d12@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=SxzqUFuvQeeNvZs+W4DmL3KehVYMr+8uYq67jXqmhRc=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHQ4nzTDBnBcK7piehwCwaY+Sbn/wn+qDnPV5u
 C52n28r8s+JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx0OJwAKCRAU23LtvoBl
 uLBlEACbT+OToPS9Pi5fiuF+BnJ+6luZzwEdvw/BVsI1rsnb0uVujl2mPMKHt/EX883Qqrssbw+
 iAAEc4QnDosyWEnRmlnUeGZqG6BZq2a1Okv2f6uvgOBfNA906vpySWA9qqT3fUqQvwIonYQQnAa
 9NT+WFKm1njXLq9XX9q8PbYj85tLwiZJhPQRX+UbG2PLs/nkxSUn+4c0wtjVBsKRcSpkE7jpmnv
 S/h4MD+FremCjkP/ov4TVt4607Kq/4uyjDsghIKch0ZDyJIzFMDq/Ya2uGToMXCsUE4vh7DmeC/
 T0Prfzpkn8pi3zHfm8RXmG1PQ0HjlNQAAC9wPV6kJDsxiNrCTIh2gQH6NjK6DSbD3w/lVJIhbtG
 o68udKPN991rPfpeoi1IZUwQA75tK7CBHKjfThU++rf2urswe01X4Iv6uZ6TN4d5frw+kA1NpZp
 PwXUmQpi92uDkytVgEASNyfhhpPkQmCLbrQO2yyaxeXvXvRByXG7pD1WIKZEBlG3hgB0354fttq
 yNYQmDI0eenoL51i/VebvcpTcmSmgD0mP5afOt3IvNtfXTdT3hG3c4YYgPEGf6niJrlh394xRBn
 GP6kccBtfUH4YJDjGBuQN+cy7Im0pFRPLMGiI4kwi/ZXidjCgwrqGNCL8CZW+1ACHrWj41lRcG8
 xsLMDNEy/DRFdNQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Describe the last level cache controller on the SAR2130P and SAR1130P
platforms. They have 2 banks and also a separate register set to control
scratchpad slice.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/cache/qcom,llcc.yaml       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 68ea5f70b75f031cd8b23cf48d566c3a760dab77..2edacf28944c78b53b51744d787f5d529ad83f3c 100644
--- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -22,6 +22,8 @@ properties:
     enum:
       - qcom,qdu1000-llcc
       - qcom,sa8775p-llcc
+      - qcom,sar1130p-llcc
+      - qcom,sar2130p-llcc
       - qcom,sc7180-llcc
       - qcom,sc7280-llcc
       - qcom,sc8180x-llcc
@@ -62,6 +64,32 @@ required:
   - reg-names
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sar1130p-llcc
+              - qcom,sar2130p-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC1 base register region
+            - description: LLCC broadcast OR register region
+            - description: LLCC broadcast AND register region
+            - description: LLCC scratchpad broadcast OR register region
+            - description: LLCC scratchpad broadcast AND register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc1_base
+            - const: llcc_broadcast_base
+            - const: llcc_broadcast_and_base
+            - const: llcc_scratchpad_broadcast_base
+            - const: llcc_scratchpad_broadcast_and_base
+
   - if:
       properties:
         compatible:

-- 
2.39.5


