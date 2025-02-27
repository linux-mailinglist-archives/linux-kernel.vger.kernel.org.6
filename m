Return-Path: <linux-kernel+bounces-535884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E26A4787E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35D01705E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8C227E8C;
	Thu, 27 Feb 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvGh4gH4"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF122576C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646842; cv=none; b=mva6k+QOgURq37evzdTYOAlLVnfZiy8fUgSaCkHSFvVK0g2uzT/5XrMjgZm6tv/8MciY8euh+6yu02UwrYDNEyJ3ZkkF8tP90P0vdVGjJivuvivun2G+dc4PAYKNQ8oVw/F4M8y7PwSSZ4o1Dio+3KspAHWj1XuwZfJFd1gEB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646842; c=relaxed/simple;
	bh=cGYHXokxVyCZVHTLRKLJGEGhLm1BHzPUmbHg+wxc3W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obSc2/9MKbuT0KtzJbRk6Bl/hRVTToHTnW1vt+KvqpIT/ejShWgp7PshJny2mW01gnEW21j9aLHGXC1MoSlnO+i8DrJ2TmpZ0Ob758ceoh2Auq0hhzEqJ9S1WqpbUie7p3H5HxY9rBuXowrLAwpUb9f3DriJo5HeP0dLYwajfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvGh4gH4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so6170165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740646838; x=1741251638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUMcWsjzRSuUJt/eRA3M0Z08Ceit+E/KlQusAzGZ3Qc=;
        b=QvGh4gH4mdOHfjNkZ19W6fJyDEu5CyQEqhZJRKdFub2JYV3KFD4uUJS+u2XGo1Gghz
         n/OOcXVl31dd6b5YfkU2UW3nUWPIztZNbyQ4UsUa15VqUCMkHODoTV9KTYOQfwMvYvbs
         HpNFQJmCuFkvebvaHsc0HOoPp4amyEBGNrMHE/NHQ/wTS6q4igTmhp+GULtbPgvEbf4K
         QFmHymyJc2gSOJWSMlYeyhqFtV7LRrw/aArsmbsa/pKiVr/XT8LIxvGyIkgEy+Uhmr0I
         WMJuSvXpaHXCPHey7BQdZb9ilh8xZoj12JDFmSCoerQpnK9kOa1Y93nE1q9SHFCxIxy7
         v/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646838; x=1741251638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUMcWsjzRSuUJt/eRA3M0Z08Ceit+E/KlQusAzGZ3Qc=;
        b=gwFg1NOzlkOQPJiQsD4P0DcLRYW5KPa2B9OlT0Nuev7X4snL4M5119dJhPFg9Y+m7R
         ukr+3pKoQ2uFYIf9QAENyNsq0fipPxOi2nHLYxjxjWeQ4PEanBKP/8VpP47gv5FdS8jQ
         FylnYSi9LexUJ8m+gLq92VkZeARSlh+s88+i7RWM5EKqgOOmo0d2+nAfiEt43LTwBnIO
         ohhH4ijXYN/kWxB9Fk2W9elFnf+CVgvpaSddsJnEmm562ct1GKiIZ3Rl4miL95AuvkGR
         04n3ng2TR2OP+UWOznCdnSFPAAXcrvymSm6mrKT2EdCIg3+tOlvhVZK5H+4MobeYPBEg
         BSGg==
X-Forwarded-Encrypted: i=1; AJvYcCWulm/yh5gF6kt5vnCIqid9LzX8q5eEurq5pNPqsJ6GoZvarzmVvqo5ZgufRy9jvHOZf3IPDVD2qS+uz+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgrx7B1r8Smj0eCccSuFYuzFL8enIol386yGA7U6Igftmsrvql
	PHdSseqS41pCab1CKhKXgDBtFgSJh6gyuszkXxpkwFjRZQmJVd/yFkfnmRhpuvk=
X-Gm-Gg: ASbGncu/5l458V5rvIX5wn6vUeDBJiMhwkwmGFCvZB41KYxqoGDuGoLSfAiyxLMS5qi
	mS5llFNx/u3fRhGd14aKIH4xbkoKGWZmRuc27+4Dn7EIr5FLE5QxeZu+bchzikrRS8PJ+5833lB
	XWx4URH9CUdZLAcAMGY0w9nVLg3ucycyOVQ6nyR4UVU8n73GafQbmZJ6otyKm8X1MaeJ/x8OCJ3
	5UwE8+YfUz1DDDkxg5wjH4OkpRjTKhRVdhswbTF5giqJCZyHN1sbz3GpQmRyCWStILtyy/EAlOq
	qoXVpEMMbd/p66gXS9M383ubzCZQwEgqlfkYkzKDdYel/7g=
X-Google-Smtp-Source: AGHT+IFAR/zqNw50nHwDi76ySdj7Hl1VbATouAR8F3pbM/yDUa3A8kzUc2bpZle6+uIQsvhVUiMyVQ==
X-Received: by 2002:a05:600c:4fc8:b0:439:9496:17df with SMTP id 5b1f17b1804b1-43ab8fe76d2mr54409195e9.13.1740646837915;
        Thu, 27 Feb 2025 01:00:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm47170715e9.30.2025.02.27.01.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:00:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 27 Feb 2025 10:00:32 +0100
Subject: [PATCH v5 1/2] arm64: dts: qcom: sm8550: add missing cpu-cfg
 interconnect path in the mdss node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-topic-sm8x50-mdss-interconnect-bindings-fix-v5-1-bf6233c6ebe5@linaro.org>
References: <20250227-topic-sm8x50-mdss-interconnect-bindings-fix-v5-0-bf6233c6ebe5@linaro.org>
In-Reply-To: <20250227-topic-sm8x50-mdss-interconnect-bindings-fix-v5-0-bf6233c6ebe5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cGYHXokxVyCZVHTLRKLJGEGhLm1BHzPUmbHg+wxc3W8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnwCmzyG921aczf4S+Wf/fUUMYMyLKKPpZOnTHRwHd
 jtJu9COJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ8ApswAKCRB33NvayMhJ0V5FD/
 4qJGfeqekL+VtYWZLzxQJOqkkjLmoS3De6ahtaP5vgOuhg3Q2tof8+1vftHTJxUxK6ZOX4G1sqzsdP
 Afh5mo/dGHFC4biu/LqwJ+j7WJrOo6li2dY/nwl0HwetI/6fdXTwOnGnCtTBJ64exXpPV4bIsT5iMU
 jfopw2wcATQLIXkEpKlaZVPyUyyaqNLdJumssY3bFV23RuMpfL7od5FEE3JCRxOpNKCl3HlBYJF+Vt
 d3QraFgjVuiBz4x86tl9SjICN0twKkpqk18D16ks/PfvtkA81cXr4RELRHIohz5k7zwaZoVRFXhUiA
 EfCZ/zKCLYYH/Cz7hz4hcGfaxbv+eEz146MW59Kn6EcDD2Fnq0/kxOfV3YLpHQ9J4JjyOB5OTKml2T
 PtFkgomFBZO2FW2qSS5JDyDfc0ZplwElrRZFd60RYx6tFUFhO4z+w4Op2713eBDCIPzQACFHcT2Cl4
 ntM7uwfluN7Vr4rOdz30Z9eXzoNjCjMQ+g34+5E5tExqAhtG20qRWsDHIC8Tkfw5bldIduBkF+lMCC
 E+EGMDUgjoa0Q9hbSvpg6GsHGAcesaLRQAqPDsXzaMR+lBmr3diYu/5wa6qbyFxSnG0fGA59f7Vrfh
 LceUU7l6WDfQ820wcjYBbJmL0dnfSbmLIKw4AbBRd5bZV9WsTvRxvkjXhqng==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The bindings requires the mdp0-mem and the cpu-cfg interconnect path,
add the missing cpu-cfg path to fix the dtbs check error and also to ensure
that MDSS has enough bandwidth to let HLOS write config registers.

Fixes: b8591df49cde ("arm64: dts: qcom: sm8550: correct MDSS interconnects")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d02d80d731b9a8746655af6da236307760a8f662..18bcb4ac6bd8433a0f10f4826f4c6958444c080f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3355,8 +3355,10 @@ mdss: display-subsystem@ae00000 {
 			power-domains = <&dispcc MDSS_GDSC>;
 
 			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
-					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
-			interconnect-names = "mdp0-mem";
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem", "cpu-cfg";
 
 			iommus = <&apps_smmu 0x1c00 0x2>;
 

-- 
2.34.1


