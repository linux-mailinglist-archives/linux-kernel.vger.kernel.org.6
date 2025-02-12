Return-Path: <linux-kernel+bounces-511574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03466A32CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D1D188AB11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF4260A2C;
	Wed, 12 Feb 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flHOZUoS"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B025E441
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379862; cv=none; b=DqCmfIUei1UMS3PcKfUZlmJj32qhlFsBtNQedYUrmSaEGeobZoumOKs94Qq3/SQZIUaaCr7vVI8yOjPVjKB5esmlIY4SJ66A1blRL6+HI6zeYMH0/8ZW6QQoy+xUwS/m1rXUlXImGeyrE1vUzR4e2UPK/N2LkY8je67WIaEZG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379862; c=relaxed/simple;
	bh=0qyK2u3z/NjnPLJ+3zpCNms4pKQWuPqdWHn9aOhe7T8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qiuaFulJvnpozZ6SkOIMhdjX/ozPak1M0vw4vDpZ3L47XRO9E5FQL+xtdp14MrCzVgp5ppowgkZXj8gGLrhMT/Y5cSOt8b0rnTW5TQ3o6PAl2FFHcuZOjDuhl7X7UkaVZgq3EtQyUggMH/L+kETPNFFShkdZ9l9ICJwYW2nlrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flHOZUoS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7c6fc35b3so595740766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379858; x=1739984658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyOxpDSL06VJYzsC7GVy/mIHwyNXFSDSkM/lCd+8REc=;
        b=flHOZUoSvyBajKJqvP+UiHgxPZziw91JOMSZ50wsveGAHG4eVZeYtB/rGOhA3x3725
         ymQQL5plbzhXw/VtTsF+8a9ooqvK99kGMJDjFO/lkk3ptP4elqUTu7WmeWor8l3pioW8
         fiWMOuHZRGwHMR2ucE5zHn+S3Qd7q4ayaGZRz7fj4bFzm7iwHaMVUCYC0VQ2UPrJHobo
         8E9loQ3b8X6ODL5l2XdSAq+fZmJc0XCPUqwz+hLrTZtHF7CFtNBq0WMHD4XNHVBwEbE6
         BknFTuZn/K/KFLzZu2sEcf1HzMrpML1QcN1PQY2O2T8kXTtY0h1PtspRO+71JgjeiEPI
         X/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379858; x=1739984658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyOxpDSL06VJYzsC7GVy/mIHwyNXFSDSkM/lCd+8REc=;
        b=ILlnxARjvyyXrkW3T5SfFI+SsZUV4KhjTR0p4q2sUNUflWMQt/sd72G7/BoINxFygt
         DPgb0BtKGnbzd2pU7WiXk5pWmHt55zt13DhLDpS54UOKQWJ90RwQEnwOK0/r6+aMp4l/
         6zjiQeDkHMS6+sTRqyhmBJxBzoHzqSwuzT4qVsfuGuwg1aU9dC9Wex8OvSMENiHTTkyG
         /suRph4V1j9cTB4p6jaAk5klhPyZ7FlQipkwuTacABeEUNkIjdNA05ZkKiyNUhzu4dci
         D4GCg09kETGy/rGuEqg6hcnCld/PxrDqz59MANFQY+YQ2AZoSpB0H6jwNbazPC0MR9u6
         WmvA==
X-Forwarded-Encrypted: i=1; AJvYcCUukvD0b9gk1P9sKYOtM15px9UoAnaBkNPgurawdCr8nufOvHA7cbwLml3568lq04UsI83bp7bDL8CTy7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKD3wzGmUmCl2AHm/lwAwnMH5bSwk5yrrsFtSH2pD2yQTCmySE
	xI3RCTEUBV1/Lvv+sooTLQ5gcBNyO8us50t264PMUO9N0aja02QgUrEQM7PJDRc=
X-Gm-Gg: ASbGnctKm595TeOZoRtV+E/ugm59eJD1pFPQPILz5uz1j0/SdVikGZXXHsDeIsczMKF
	uioxb6qqv01DOjUaFXAsiHtmR1vNUqyVcz1dC8EHnquV9ZAkhzYQN5qOxs6xlunNvKqok0g3yXd
	gjQkghSppmvqMqETgNNpBK6bLk9EmcF0kKXrKaWdYEY/Lf9Nw+l5kc6k+JZ6W2jBAf6wCCQoar8
	8cYxRuu9Z4q8IvwLyF4ETjLpg//DFTMWjUAUQ8dQcwkqLrCeSl8dv994twI9vAiMtB1nbZMfC5X
	dcQ+dQaCPot2BbN7TeTIAsXHUhC+
X-Google-Smtp-Source: AGHT+IEfiTWbMpQQLn1RJXdfkKpVVIRE4eJH1Ib8zZn4l3QF/V96r1o6kde9pJJhsidNjbz7Sos45Q==
X-Received: by 2002:a17:907:7249:b0:ab6:d0b9:8fd1 with SMTP id a640c23a62f3a-ab7f3787affmr361088666b.34.1739379857852;
        Wed, 12 Feb 2025 09:04:17 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:16 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:49 +0100
Subject: [PATCH 3/8] arm64: dts: qcom: sm8550: Add missing properties for
 cryptobam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-3-f560889e65d8@linaro.org>
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
Fixes: 433477c3bf0b ("arm64: dts: qcom: sm8550: add QCrypto nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index eac8de4005d82f246bc50f64f09515631d895c99..ac3e00ad417719be2885d76d3197f96137848337 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1957,6 +1957,8 @@ cryptobam: dma-controller@1dc4000 {
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x480 0x0>,
 				 <&apps_smmu 0x481 0x0>;

-- 
2.47.2


