Return-Path: <linux-kernel+bounces-511575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE41A32CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77074169DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C925EF88;
	Wed, 12 Feb 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGxUY2on"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9EF25EF89
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379863; cv=none; b=O5Q6hXxx2kU6IeZ3CayYiKlBDsHuYSPS+IY9qZO/78pUzGzxX+2Nruj5bfp0Mv9x9bEmpGKKhKh/B5F4LSCkcy9Hs/jsAkJ+ANIblUEcyUDOK7+KouRpSKsLBQb0czKxuWWYXXNjw8zgwaK+kpw1PAVCLQdaHHJ1s0fmulqwMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379863; c=relaxed/simple;
	bh=/NYZuVJ5CW8Pc7756jGUtf0Lv3irVG+gP3QhGB2cFMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZAn1bSvHVMeX5SF3SDMt6CyBx4kqAAlCxS0iiaTtWD2xCLjhod/9eCw9Po5KY1pJDnFB6MBOopRq+p4y/ejefSFqNTSsc2IM6BsSFeZQl50HkKozFDZ9/BfgrTvfDE0YK0pmAHursI0MJ4YCL1Jo5RQoLLArc6+BLd3sROfViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PGxUY2on; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so2111376a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379860; x=1739984660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYw0tG/nuWEvSbLScJnWGG2Q11zXbK7g2BHQcn5xcy0=;
        b=PGxUY2onQ7l/ynhXzdODhL+LJ84b/njUlAb0Qfc2wsoNq/3YrhAzm4R5yaGIUY7TOD
         J7mYNxdYBqbpL9kYY3Cw9M5Dt38OTiJdmuliWGbVGKFDoifnvU2MfyYj1qHDL2xR97TX
         Xtz0Zt8a94ML64LhZndC88WcnG4JFnO3RgnDroNATRZ/xzYFUKdKJyiy2M/aSsnQCbkc
         gaqEoab8HNblxbUHGmHGSVdH3tkwDiBQ3Fvxnh/L5T+FF9KGzJiEPahghjjQYFd/ChPI
         lRq8a8kLFlYNmI58PhtjUqt23Nh4jnoHHx/3z/ZOfsDBKfQMrkNsHxnIF2PRgllzSGQy
         INkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379860; x=1739984660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYw0tG/nuWEvSbLScJnWGG2Q11zXbK7g2BHQcn5xcy0=;
        b=NV6dNS4bboQqjDH4tjJ1ZnSKREarM5FZBSc8Zrpbcf86Z90eEy5vwQR/RiLD9nduV2
         DQ4Z4nNIkRdxt/AWbGPpq4LLHIuMYPLKaf31yUJTPs8aWNNjEGacbRVbDiM+8554mp0F
         /G4AHWRcIoOpPUGtYTJ4r4IAf87+N3kdg3sIKQHFEO/9lT8NTlc2FvHisVSFpMkikb+D
         EbCl5o6ZDPJY1R99L0Pnli8uUqhQOIZoxvhy3pKcs908Jeo91nHGY879j41f7ME8N1lG
         8UPneODk3jiMxI5UCEuhwAxpcGxymGNXTbj9ntnNZ/cr9jiuvIMvGI/U5nYoRHpkoHem
         QjSA==
X-Forwarded-Encrypted: i=1; AJvYcCWgxww4c9O+0A4oECfyC98j3QoirwOIlelR2K4XYhmN0d9L71AOMczsx5nHEB3JMXgQO/RslTdOApmC/zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dB0uUeL9BQ4UP96uuRx7ReqPPrVmep0y/fj/UI3yZrvLTlQy
	FFgyQHVznro2yV5uOpWmr1Z6v00OPHo1CTdbWb8Hh3DwsoUorXWwTwHsBtxSn3o=
X-Gm-Gg: ASbGncuCtCCMbWU3GV4s/XILOvRzUOzldeHYBTUVmnmTvMeplciXrxPTLxOxcIMWAeV
	4tzlA4aGIV9qSzwb/0dlG26it1xbEanvlrsXkoz40qCveAyokB69/GFYns79fB8r4hfjBY6EPWr
	MS6sQ4eHJkMSrtJG9zfVEjkjQkP8COGRVeC4ZuHGGwa4j1g2wSOAddDutJosrFvzrsqUL/PjidY
	pSUyOCmBKo8cxOOVTD6Uj+7kBqw/Qg5nNa4oXRIci7A7NdOigLH+iQ/kcwLfg7tucUHUsJley+Y
	8OVSOWnRE+1qCWlDr/HFSwogqhv0
X-Google-Smtp-Source: AGHT+IGwS9pGhWIrn8y879zF3bgF1bakf9yBm5N5I3DRe/DsDY25Qv96woF2RY7pM8YiIFh7fSb+cg==
X-Received: by 2002:a05:6402:27c9:b0:5dc:80ba:ddb1 with SMTP id 4fb4d7f45d1cf-5dec992221bmr34314a12.14.1739379860196;
        Wed, 12 Feb 2025 09:04:20 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:19 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:50 +0100
Subject: [PATCH 4/8] arm64: dts: qcom: sm8650: Add missing properties for
 cryptobam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-4-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

num-channels and qcom,num-ees are required for BAM nodes without clock,
because the driver cannot ensure the hardware is powered on when trying to
obtain the information from the hardware registers. Specifying the node
without these properties is unsafe and has caused early boot crashes for
other SoCs before [1, 2].

Add the missing information from the hardware registers to ensure the
driver can probe successfully without causing crashes.

[1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
[2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/

Cc: stable@vger.kernel.org
Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 86684cb9a9325618ddb74458621cf4bbdc1cc0d1..c8a2a76a98f000610f33cd1ada82eebd6ae95343 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2533,6 +2533,8 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x481 0>;
 
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
 			qcom,controlled-remotely;
 		};
 

-- 
2.47.2


