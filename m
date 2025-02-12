Return-Path: <linux-kernel+bounces-511573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50FEA32CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958713AC154
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DE25D54C;
	Wed, 12 Feb 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fplOecLa"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8F25A332
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379859; cv=none; b=TwXr/O7/a5jyhmU9miHHkT+VBC/3h4TD95WPHuoDJeJWRk0BBO1bY/lPvEzUt1viv8N67hFWkeDBkozd0lfDawBHAvN4+3owNWMWJrNPogzQoStN4PEbr7OlmgapXHSic1p8EOACYSL2GBRjYaO/eFXQVcKwqWBhufI0T7Zreyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379859; c=relaxed/simple;
	bh=sItJi983hvl01AxWCTmMFX7g70a0Fg4QZpXz/Tz/yyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1bformVZHJh6uAHa6E7Ow3vsEk8Nex/FlUrnD+QAL2no+TovFaTCcs6WXaHTKgq95wFiI6CYwx8BoDxsfFNO9UXLRc5HNH2ZZwuEQ8nH5pQ/pCxoyEuPYvf+QjrhHBrNQiS1h8bB38JTdCXCwY7EPnTnj8SUO+dx8ks+oii6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fplOecLa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so7968964a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379856; x=1739984656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6w5okXU2Yu7jFnBUo43BoM84SGqbG4jaCw++xQVChE=;
        b=fplOecLazFKo5bPFXcwrIqQPAKwTv/hZFpxZ3qpbztC1+19mMbHK2yFc9WbbDYe6ET
         nVv2e+6D9DuF8iYMYSAxCSn/+K7FkrhohfbI8R1ZB09JmdhREq+uNQG6asRfeB5jYh/R
         J+/O33zB22fnrkfnKzU0nYNvaA4t5FsRiE7uN6r2KtUFu6E5ep0JGhidgUksXKaX3ooF
         +6HzAoeAOFLQ0qAFQ8YyuRiHkQTRm496czah6qCk9eTAO8m8wW1gI4sW4WJr1RwIP3Gx
         Sd3sHqk/+hdVd6wIigKkkemT2eCMZZfsWf5jPlJ6LBsfXRPK/k3/hJMUk3yD2IN/i7aP
         HHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379856; x=1739984656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6w5okXU2Yu7jFnBUo43BoM84SGqbG4jaCw++xQVChE=;
        b=h8kBotKwclJrBAreQj3npttF1yKzsGMunGESJhtHvyuUAz3ctn5ZELYc/Jca4vOI7F
         6zz0JdCV+gZq4isK8JShDy0jmg158x7A9rDy5bN+SZXQFr+GjujBMvxwORkPt0K5FKp6
         mO1+aNpKSjdEsQ2dKvAAkw4N4PnzXGS3YViBnUlksL0BppifZfjNhiNSBF5U555HNEcr
         FiyfmalbWdmOtRY/IehLx0c2l1u9hr0XP7114xzJ4OHFV5Oa25C645s0ipPXjM2MXupK
         4Mp/V34S3YtkceFdOPKpfkF02vEOGWItygzXEKfAnD4ywmVJ3YBdamXcBvpaFqVGIBbh
         NvDg==
X-Forwarded-Encrypted: i=1; AJvYcCVRQoifG4Vwd5x9ivo1XX6OIN9JH0PNP/deub1fhOhGYZ/Sc/C60aiFXGBIOOzzDFpRHBwk2h9uLj16XjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxubRX9Qrwei0nQ09VMepfXpDKydFvV0xLKF46dKk6CXPHkdp/9
	u7ceLPgHzzOBzVhl5LB3gJ1TJmhteof2PY35UvxT6yEDpTkdJp7XQCMumdQIff0=
X-Gm-Gg: ASbGncvYiqRhEypxmbk2kFBlqGoxV8xQrO5Jx/WywcaOJ1dkXgjSGkT4qIVVOiNOtXO
	F5TH7rQgllagOEPkE+tDozF9Q9k8auaiOU1gaJfzki9rASBDfU8hk7FrW7gNU4t9r20gCWq9+RZ
	uUGREFH9m3fXcqUJJ17OUV0uoadD/ma8GEdLk2/yjB//vKG3VnyE6q+QBB26tqijYpqCLhKATXH
	SJMiBgZwvQaRxMENfDgaj5rTfV2+gw3BmGfcoFD+l47DTG98xDkbmdbFlbSll4e5kDE4zW+u275
	LSd2hiVsNmf2CKCu0bg0b/tfQdZ/
X-Google-Smtp-Source: AGHT+IEABcOOIELXz+JFdeOSsPBTKQScoxzR7QmtBueg1gF7h6+a32NeKWZuRnmzY2n57dt66bqjMQ==
X-Received: by 2002:a05:6402:26cf:b0:5de:42f5:817b with SMTP id 4fb4d7f45d1cf-5deade15403mr3357122a12.31.1739379854662;
        Wed, 12 Feb 2025 09:04:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:14 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:48 +0100
Subject: [PATCH 2/8] arm64: dts: qcom: sm8450: Add missing properties for
 cryptobam
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-2-f560889e65d8@linaro.org>
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
Fixes: b92b0d2f7582 ("arm64: dts: qcom: sm8450: add crypto nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9c809fc5fa45a98ff5441a0b6809931588897243..419df72cd04b0c328756fdc484f4e46b6c325412 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5283,6 +5283,8 @@ cryptobam: dma-controller@1dc4000 {
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x584 0x11>,
 				 <&apps_smmu 0x588 0x0>,

-- 
2.47.2


