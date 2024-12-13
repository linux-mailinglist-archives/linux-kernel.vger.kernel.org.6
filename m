Return-Path: <linux-kernel+bounces-445006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F329F0FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899C11887F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3F1E5700;
	Fri, 13 Dec 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGxhOicT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57B1E412A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101676; cv=none; b=DdkVClsV6v2cG1h1CmZJFmZRoyHA7jTbCwBJIIjyBRn7Nd2Lw2dOIJE+9vlCEtBAJKThUGsfMlaSaYIJRnHXNSYWIuL2mrSwUqb4uBTnHv7ilyxNVbHPFNrW/nQWN1HBm6cCKLbUaegllZl64ATspZW2vE+Dp8d6qWZhJ8uRqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101676; c=relaxed/simple;
	bh=yEPqHjmIbUmITf1O49UDWhwRUCdSrmaIhPmoTG307TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXb5dyEydTFkqshnRqF+MwUK54umuZot1Od+poKTm3tlNWgWWSuHfKRPRHXt4g9vwgjT7rXy7DSyS9DWX0vHHvi/LUq9CQM88PY/XELbveN21tavNOzCpxMhiXRip/B3HEoT94D+HPtHG/P0ZEq9DzFDBuXvlnAqvDbudrfmXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGxhOicT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43616bf3358so2062415e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101673; x=1734706473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJx0NfcTqStUzuYKIn4gg25GLXMxBa36UekQophjNMI=;
        b=yGxhOicT7AbAFyPv3Pi2o26Afk93J6SpLKc2xbKTtlalYV1I2dDaK6UYYOrbNnAx5K
         xZxDaDJyaBGRHNd+qZlrHcLVPIBjzSIEwAGbiSHg9To5jE0HagEu7NUPl5ffCAgJcHz2
         MlIW2PkH/GscTqyuIe4N6RZnQG0Y6ZV2iS40PNtsMHXfAWrWjoY72uzaCqDdHJrojX40
         WM5Kk/XXm6bAYq1vxPUIBp0s7IGBjqm1RArvj3ZTBo2JzQM4uv2v1xBFmRYYxFZJAv5z
         DdqmhKd02c95K3qaz9tplFMDi/9i5b943Tend84ggdvWjOdX/mn0g8UyIHmCU9vllyXc
         SHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101673; x=1734706473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJx0NfcTqStUzuYKIn4gg25GLXMxBa36UekQophjNMI=;
        b=FfdnhPq392HSz3kfuke1MAccw+hMVtKa3zAfzvaHtg+hHnnufd40kaSNqRDXUMKWNE
         hA6U0/cwqRQezxix1UqCGEpi/oWf0VF0LlcIRVXg/+xjgRxpwIscA9uSX/q1/ydTnI+t
         oQ214s9332n1+tM95A5s49TtAvj0m2s+RIUs+uJJu4IshqSPKPPSiu4lSqi1XHdKq0iU
         bO3LRRusjAw7mEeHow2Qq/PieCC6KpCxT6nPLHIINlnlJU3SFH4CpCxgzThAUkvSm5Vy
         jIbpzdJ6XO9dPe+jW8arlCDb0uZLcydxQfTysDGnCBN8C8L3mea8UW5Tv0677PE1dP79
         FMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc7CXV93GdX3skKoLJOo3bIMi5VxOU3Gjk6B7NCgUG8jIQNwrkSltboib/gmkerNDgn7yQgfKv5XcD4W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwplzeWW/NwL3AeQ5W+iOh+ey0sJ7VB9R25FYEGxnDAw3UgOZsx
	cJ+E88wqT1aCUPUukk83SPAHPDCb1BIBKv9NYLLgLki/84mycEnwiHtv3OJsOEU=
X-Gm-Gg: ASbGncsOfox8U3JaL9K28C0yz0yBy8hMsP6FlPumzUxRv8fmlzRxaMMPtftB5zHr1Sx
	B56hcXSjy31Q0RnRMKFG03fMs5ROjWf0AJae/+ADfxTjkX129/NGpnjdJCmM0L7RRUoXFC/ZXI6
	8fa8W4G4c0C4kRlCOGpGzpM4wl6/qgFLFGKLSWeFXJyKXaX2imeaYrnUXTwnTZbr58UTRGoVzd1
	m6Wo25Nkzgvz2mm2kZfbjWo4uxafgM/1uQM7ReN8JBg/HZa1TbMKa+/u0qfU8qO5d0cpe3M
X-Google-Smtp-Source: AGHT+IFHZpCbaQkTUY5HnWNjelzKqfrJoEAL2h5O/+zGEBTs8xWaKt5CDOCxpRY3Q3yooQKN/wZjTQ==
X-Received: by 2002:a05:600c:1c1c:b0:434:f22e:a5be with SMTP id 5b1f17b1804b1-4362aab59a0mr9252155e9.8.1734101672529;
        Fri, 13 Dec 2024 06:54:32 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:53:55 +0100
Subject: [PATCH v3 06/23] arm64: dts: qcom: sm8450: Fix MPSS memory length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-6-2e0036fccd8d@linaro.org>
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=yEPqHjmIbUmITf1O49UDWhwRUCdSrmaIhPmoTG307TM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqM/bd490LhmOCHFz3Nr+cpTrIlv2h6iPsHO
 FoDRY1/rUiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKjAAKCRDBN2bmhouD
 16EfEACNN9AnnLEyvpZnL1x0CmAbuNdF9m//w0H/u0Ftxsoo7isBJL9SE0ovZiaU8WBdW+c+/RB
 EwEX9QoCQfx9rbUcWbBntypwvcuZwnDMTLkddGl0JxgUCB5iaIJN0AZBOPK2IQdOggvpay51od6
 zgi/Jczt93oo1DpyUorjEXJMh4xIMfTE5myIIdg8cvhQ0pZpVPD4vqDNOxQ7PZ/kAoLQU80Zc2b
 V+W0ZexGFlAsAJvHN0Ckdo4SAKj5GdfcaGV36mqOPwosscz768ypiKXrIRS+9uSfne9Y3E0y1sv
 SRaaEVW3L8x9BpYFJpu0CPdf2ds+xbJ2VVdTS0KjX+vfk9eg6vp19P0Gkav79ZJNmupaR9HxRVN
 WvFp+9Iyv/aUscJMeqCr9K9UWeZkHFXiuUIGFNcSeHPZTpwUTfpJsvHWBk/0xkw4R+Odppff6a3
 jBOuvxxvJdUZOdIVYs85pDzcxE9GDQe7H/I6nghDcFEyKssQiYUUg8LlwMxBl5dheAusWFE7R/j
 4ym2Y3yIn+don3xCd+fC4ckHdz/Utw7/mg+2nhz0iNLoR1w8Yu9tPoGgF/KXPJMxTx3hn98dSJe
 v+kivRs5uazwhpTFjXm/7kMzlpC+XxHJ2w8ZuYpZX4sLcAGGRsQ/7grZZfMRbGkFzrCAZru8hac
 V0KH0ghaTltTliQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7a3bf847b0b9eae2094b0a8f48f6900a31b28ae4..6df110f3ec21dd8efe0bf5e93621b2cabb77fd17 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2907,7 +2907,7 @@ compute-cb@8 {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8450-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0


