Return-Path: <linux-kernel+bounces-536809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD1A4849D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DC9178503
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1726E648;
	Thu, 27 Feb 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+h+rKBr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7126E638
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672283; cv=none; b=oIR00rZefr4CnaMOJtzKsniNH02mNRXduG0+49Mp1j4Q0uQMpd8uf3s06AQHQ2yDJ/zNdC8gF1viMg/s3u/BMHsQauNngQKj0I7BzpdBFuUEV0rppheLUAhTCZyWJIKtVKCG1QxV0N/avqlw1JxYnOZ9uSNBLKGfD+1426hBtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672283; c=relaxed/simple;
	bh=5crfA43Wc1eshy40EYAu5JOOOnUyb0U245+kFC1E5l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnj/7bvWz9MiosHJirtbt44vb+I9S252mFKc+Xt5mLKZu4ZfzxIJtDTxxII9gywyMCXuJrPB2bU+7rROCarMN0aqeRhpd+hEBshW1J4vTnet+WNDAl8THY0KkKLUBltcPUEHGAbgvJwioJ97UoB8So96eVG3bid9QXQrns1Gpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B+h+rKBr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so10616205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740672279; x=1741277079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooJ/hYw0wA6kIng2NE6ZvceF9VdgEvsQvsmSqmonZcA=;
        b=B+h+rKBrA7hobOUOJ0ntt8Fqh2BgwHB6fh2E7p2O+jVWXduirLW7R9q4gVUkP7mBD5
         eGNh2rKjfjVb335sjO+Gfjw5QLuCvqfR8Gzn1wa21VLgA7OnluuMPgxihp7iYF1+tiJl
         jvx9zHshm0D6IwM+T7MKZTQhI/Za2gOc4//kAF/hxNE8T0xupBJOBXFqDoIaAnB1Jc7M
         yg36I2B4UyKUM4v0s/4E0iIz4lZPrw6WWJlkO2n7u1cAwM+w6nwg63whdkQH3tVMMOol
         OoRhQNPtnJVa8XcoBgO85Xfpk+YUInPUtEUuxEkVRnQYr8zYm20cEd9N3aSy4AgFlww8
         lqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672279; x=1741277079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooJ/hYw0wA6kIng2NE6ZvceF9VdgEvsQvsmSqmonZcA=;
        b=hwjgVMSlZKCj4HZ5xEBmiEIO+5bXR+Ra8w4a2tPtSyIkgOli0MxQabs0du6OfkGp2p
         SAThB1s8aA2bMnHUzvHn1ZH7ZNOICLBhETWyIZHKAoy/bDWfmoSxsJFZCDfm29XifI9l
         8iuXKHAjpr+Xk8/AZFXUnMXf1zAskHdo7x/Sqbk5jcPTZbs+EUIhPdhfdYDIyLi54vy2
         ajGvQZFkn0hPreTD058swRHOnhhQqmIbctaK3cd1sKxropesSGl50de6vYnd9YV/INDb
         77SILlqFtZBlK+OIZwu0Nt963a0I+REHQ/Ieu+lQrIK80QaXmiMHlp7uTia52qgkVmlM
         RGPw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNprZ7VUksLCczhmhBacEAJYvscxnu829q8wfOM3u8MnOqPs2ulsGYaPhHq7ve2cRTF4k/QxzR5Tmkx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFOuQK6U997HEadLCVVFoGiSJPEe1Irvc38c/+QY4aPFilSvb
	hREOqH530XgBS5u8wv33U6P5UzAkEiXArHuB3eo3uZff8ZCI7L4D5D46enjrl7fRC1ofBk5TFAm
	J
X-Gm-Gg: ASbGncuJ8qWclqoi1P1VO2VlEHqEPpr42HvFB/UpQrmpxFgxmdUMW05FqzFajSaZv+2
	9BWNzCAJp5nykJ4zIQnyAhCgiVnZen8TJsmXQ1nlzUgmbzwutAGhbaR6uEH3RBbeQgVH9zNXJc6
	8iAOr4XTADv1dwleZNVxFOytj/AZL8CUeGnqwj+MQ+gQ2FC9iY1saG71PnzwEf2GbhSo26ULj6n
	w5WghKP/ocRcUhUjaMIVIKFonRAVnKiPtvRjpoJEQvSUqfnpy0pZaC5r33o8n3k9GH9m8P36k1U
	4BaH9rLG5i8S9Ertg9LJ4j6YFWHvXZ534iCxeJe1KofdCJQ=
X-Google-Smtp-Source: AGHT+IH8doeNIsGIgaprszLsrMy6PYYlH+q9gCqBBM6/GXlFjz+BmBNHDR2riaZQFUTqN2YaKlHIbw==
X-Received: by 2002:a05:600c:19d4:b0:439:34dd:c3cc with SMTP id 5b1f17b1804b1-43ab90169c6mr63727665e9.22.1740672272193;
        Thu, 27 Feb 2025 08:04:32 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5393e5sm58811225e9.20.2025.02.27.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:04:31 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 27 Feb 2025 17:04:28 +0100
Subject: [PATCH v3 1/3] arm64: dts: qcom: sm8650: fix PMU interrupt flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-topic-sm8650-pmu-ppi-partition-v3-1-0f6feeefe50f@linaro.org>
References: <20250227-topic-sm8650-pmu-ppi-partition-v3-0-0f6feeefe50f@linaro.org>
In-Reply-To: <20250227-topic-sm8650-pmu-ppi-partition-v3-0-0f6feeefe50f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5crfA43Wc1eshy40EYAu5JOOOnUyb0U245+kFC1E5l0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnwI0NL3w2Sov2sZjc6MlbPHSm2hC+bhw4CDpnoVdx
 9/maLN6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ8CNDQAKCRB33NvayMhJ0e8cEA
 CI0B3gu/m+jloy4MMcR/JYiGbo4z3fVTEh6VklmJUcGisIp2AURsAAGEdoIret1qw2wHQ8Mdw1zEpN
 esjnZhDvcY72cu2GpHM2iWJdLTIu7iqUZBlaDgqC4OvtA6KNUUJOZXkMbwek0/ZG36QTfqi+LKtZ4a
 0opiDY7wdToRZCjLLS9+x6bRbJCSb6bSuWPcV490jmnyIHr4/HG2mg0wAfWk0l5XRsYgfUhNkUXEc1
 qhDVDBof/aLu8LUcXlWOSBjYnD4XlmYeC1umSCxX/OCR6kH+0hId8YYpXSqPA61HHvM/MH2vUJXIyB
 DXRh7os6mcMlBM/I8iz0tKi3lNIUbSWl98DGb7Jc6ZkD7Llv4x8Mv1yWt7BxrgbG2OpJ0vRrqOPZDk
 IvlwrNjybmclhwXxQGYDkYDZLSJjbjxDscnDZl9GZL61qEF7KYtqVhZh8QB972WcGxpgIivnCwMi96
 ZlhaibpMy6ehEqlXsLWSYNBBOZDB0r7TDjao5ixIkXwcYDaxlvdQFcQWVvye0PDS397FXZH25joPv3
 FyE9UbpBoGIA+sxrYt4Wm21CIKg/xmDbQ/SccHq2mgfR36F8nEdzJR6f8jZTSznJnBxTpqP9GABzat
 9eiYNYG8ROeAD1GQemARnVLtOqGwA9EnqEKetlF3Vs76GWs2eKQwDX0UpazQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The ARM PMU interrupt is sometimes defined as IRQ_TYPE_LEVEL_LOW,
or IRQ_TYPE_LEVEL_HIGH, but downstream and recent platforms used the
IRQ_TYPE_LEVEL_HIGH flag so align the SM8650 definition to have a
functional PMU working.

Fixes: c8a346e408cb ("arm64: dts: qcom: Split PMU nodes for heterogeneous CPUs")
Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index de960bcaf3ccf6e2be47bf63a02effbfb75241bf..895f70cf6f57a84dda38604789d5ad6d80471944 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -1417,17 +1417,17 @@ opp-3302400000 {
 
 	pmu-a520 {
 		compatible = "arm,cortex-a520-pmu";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	pmu-a720 {
 		compatible = "arm,cortex-a720-pmu";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	pmu-x4 {
 		compatible = "arm,cortex-x4-pmu";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	psci {

-- 
2.34.1


