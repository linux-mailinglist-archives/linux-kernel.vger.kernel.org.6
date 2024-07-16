Return-Path: <linux-kernel+bounces-253848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9DD9327DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC8A1C21492
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD1F19B3E2;
	Tue, 16 Jul 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKrRriEF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872B19AD6B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138232; cv=none; b=fjeoZy2D4fParvGdm+1Zd0dM9GFHC2rrr7OfEVRcXoHLVF4qDimM0P3ZTMT+T/MN4liSLaO8VOKNCE6OM727Ma0/X6U23c9BJTtn491gz8FXMQ4Oyv3DfMq/bITdrbRHu0BJIYYMwgaxTS91pEMsjAc0xGydNi/HkcRe4bU4lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138232; c=relaxed/simple;
	bh=6ielWizRopPkxt9Xz5NhoZmUGUPDJRFuNHGi/CU8TFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irpezlvcVpOZ2ahUVm3F75sen7bIhUyzxZZQAZKQEEk7Ii8AAimonBVNcY7PAlJFelveSPV+Mq9easeJ+Jp+0kHO7e/LesKRdRfLXBMYYuzD1oa5jaxa55EJTLmuGImiCSc7TMNO8uC4qev+8d0bLEesQp5uxe9GQiMuR5HH0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKrRriEF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so44036505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721138229; x=1721743029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AD5pyTTXIBOHwrPdHnxMSU03OrIeYJeJpP0/KwZpIGo=;
        b=kKrRriEFOCiDCMHH+GikMXjV3iMpeVUMjJzt8VvVCfnU9EAj+Lwxjx0hjBurjQ50t2
         +5Z6wvK58cAMc9So5WEvRwbYUcOyfEQJ1TsTvlmX9FbXOIA5N9Dzjk+3K3sSpa7LnCwE
         tEwWI5DWMuCdrBDBglUOSZkF0hFVBLk/Qn+8oRv07ZnDTgT7d5eIiQS0Iy05CQ9FOuNU
         EEutZgibVBPbAWsFE8WCsqv8rQL7wOMdWM9KWdbNGqCgaLj4hHA939okGkzwY2sHqsnx
         7NF24ltNiAR4pUzsR40vOPkWjEjXMR/6BabC/hc7ucv5d7n7vnl2ZL6i/KlYONuY6qDz
         gE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721138229; x=1721743029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AD5pyTTXIBOHwrPdHnxMSU03OrIeYJeJpP0/KwZpIGo=;
        b=qRs3JBtNZaTOyiyDa5e3qQlF5NqHranXYs09BMKsUwDtPKoG2rEdauMlVazUJvFtag
         d9nsUlpiMhKokb2oS6IHx79fjH6wRU3Uy/OiNnhomMdJUeaeq9m2OvILI9buWjpwHrN0
         sjCn+zUcXRvkIDEAx8uS6xtd79jq/wcE5c3ka/QKyiN731UkCnoT2zrWT8Ro72hjtRDb
         arrsqcOA0CvQyzsWCaeJyowIGpcpUs3sG7zIE4ObuJvw5jiWROkzpa/AM86g7fX78M5G
         Z2T5KTvFsFPZFOAPtd0ttjbsutwHM6OSmApOR+aJWr5epexWVB8Nw5kcMoAzxHEfGD8P
         rQuw==
X-Forwarded-Encrypted: i=1; AJvYcCXn3D5CJoyJd/+Afn08hoHG6WMQ2TbCAqmkGpvbnn8QoN/vE1taznDchYzoxrTKKP5fGFYTZkaCMRITF4thJo3aarSBOE2PiMzZ7/70
X-Gm-Message-State: AOJu0YzuMHJgryOsxb10171qQlgjcwSYSEquS/JCkG6GjGsKNAJ6jahO
	cmhNiBh3oanvj5Yrtoo0Ss+B35djrE5BSkFIUjNhJR5tZDtvreAfpQNHNbuaGpU=
X-Google-Smtp-Source: AGHT+IHfXvfzcFPFhmELdhCG/Exp1aFv5Ieq9lSZsPGvNiqjb3fzPq3o6IHorLqxOsRM8yer9Q8BXg==
X-Received: by 2002:a05:600c:1908:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-427ba650391mr21090175e9.8.1721138229388;
        Tue, 16 Jul 2024 06:57:09 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427bb99a23dsm19118905e9.1.2024.07.16.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:57:09 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8939-samsung-a7: rename pwm node to conform to dtschema
Date: Tue, 16 Jul 2024 14:53:38 +0100
Message-ID: <20240716135339.87192-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the pwm node from "pwm-vibrator" to "pwm" to conform to the dt schema.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
index 91acdb160227..ceba6e73b211 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -198,7 +198,7 @@ touchkey@20 {
 		};
 	};
 
-	pwm_vibrator: pwm-vibrator {
+	pwm_vibrator: pwm {
 		compatible = "clk-pwm";
 		#pwm-cells = <2>;
 
-- 
2.45.2


