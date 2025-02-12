Return-Path: <linux-kernel+bounces-511568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C8A32CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E5188969A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542B92586DE;
	Wed, 12 Feb 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDJ1sID2"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85624271838
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379856; cv=none; b=alGPoFkFdHWRUtJ2Z/d192kMNRmT3ISqexBdteflm4RMDbvkhNjtbUmoafALU/7OtFqiPgfCPJixQ7Ao6QYsq3ToMZKSD9oaW9rn7S8LixHFddrpAjTj2ST3geJqOVqHK7wSuOuq/7e+2Jz6CUnWwU679xeMhfiJD8h2WJ7mCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379856; c=relaxed/simple;
	bh=btRO2rOJup/wmjNa0o3QQGaXrKePyDSWMf40JjUiMBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oecHsJdrKk8g9pyVvl8KQPg1E90k0wXTkXmk3j7CLAi8pQb411B9TPkZeCVLAwdXZNKZtLENXhiSoo+gtN4gp1quHcU/eaeRxeRPmtbRvqipTxLED55CZyIY/0OHGT76GrO+4QMkQzYm2ABUUE/8j8cpKeGWSZ/t2wdm/+fjGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dDJ1sID2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5deb0d6787cso1437253a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379852; x=1739984652; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOdSsrVkTURNY/Q7FQn0+ahIqRzchEXyI5DDymGy/g0=;
        b=dDJ1sID2FdBD2F6vx8DMajuhzvKU4vW3GDohexS5/N1zL5cngjYqreHtAsOm2ptJQL
         pXfTyYsbZMi991ESNA1yGZcyRaKDcEnkpZhczFMtfQqvDbFVvx9KsoD96/7MA9rJT+bZ
         MFRs0Wuq/nS7Duiy+Li7cmwTPe6uz/jxglsmYI9LBQ+QTKO/pz2f2yMs+semI9cfnu4U
         j47UogTDVyIO8/RB7y3mCF2FcEbfvexaZJwMAZAFYu2TQuKnFdkOyzEX1axXDvur6bk9
         V/qisDy4C6oD0OgINrmORsGbAi/sbX4xmXkz/t+H0uOiXUaGIrK1hsBHZFU6YA090G+8
         P4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379852; x=1739984652;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOdSsrVkTURNY/Q7FQn0+ahIqRzchEXyI5DDymGy/g0=;
        b=slyoW2ZaWt1bmmvzRRyPpZA4Yl+E4qFmFaTG8Y2/WSuieFjRBJy+5+b3irDLmAieE1
         CG4CM2jNioqEW86kLWCbP8JGGAgyKGrZiMdeXdORxKfmjBNVrCHuEK3sAHKhJjdFaCgQ
         MK1bTtQL/re4Qu5k1/7Bq4orU5H70rHc+UT8n+cQl54UvMs1ISVYw5kzse/CbD9W622D
         vL4VBf0GHY+7pFMGWqW9ej5Vz8Srp+qKtCPd8fmLf5mn9zylOHRLbIuKIju4SkerWwTH
         cPHvtDm14RaF8w2Znyx0ZnTtaAnOwWH/SPuflCFReitT6kER1hVvqNH4qtQNAP51GSlP
         sWww==
X-Forwarded-Encrypted: i=1; AJvYcCUMUXKziBR/M9fdGaBfOjUsXSyIH/y/EL5l/SPAC2vC3Ms5Kcci0QELEPGORNM2/4+IMCG9oimEKtS57s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcJ0QawfbKbtT8j9vTaD5OJnQmSUOySB2a8/rG/I9J3UVu+BV
	MLHPusmRqWlXblMTDois7/aTSAqfWEoc5g47ydz5t3/gmCIswtpb/Y0GHiLa9Ow=
X-Gm-Gg: ASbGncvFbsbHjA4dW2uRyeeF09JiuQK45r4U+FIBc/xTbyIq9JcqPtdXtrOjqbkCMUJ
	PY/d6kM0oi7dIqs875iqQB2zTfAPchkBDT2RmGMM+bndzSSevx84pWwk5PuAdkRfGvXV9zVUsUP
	s/sc0nFKz4I/4RiEVyMATzfrUrWmjJjg/ycIvo0bp04iSSSe6J9SGK0L+oa6X7Z3NArVg2rOU46
	jFhwtq0wjoyxOZgK5shu8Z52HxItltT3DDHXh1sLGZkvci14711GUd/NL9BXJRnVxv9Ngf1B9Ek
	WTaEJ5cyvV1z6e2f7mHv6Lcy7nWH
X-Google-Smtp-Source: AGHT+IEQEtIiwT19pSZM69pmOEInJBgSECAuQB4A0NcaYOGmILP2pTTU6UgWdVc9CPww0WfLyZjaUQ==
X-Received: by 2002:a05:6402:4403:b0:5db:f4fc:8a0c with SMTP id 4fb4d7f45d1cf-5deade0fe18mr3056067a12.21.1739379851631;
        Wed, 12 Feb 2025 09:04:11 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:10 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/8] dmaengine: qcom: bam_dma: Fix DT error handling for
 num-channels/ees
Date: Wed, 12 Feb 2025 18:03:46 +0100
Message-Id: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLUrGcC/x3LQQqAIBBA0avIrBtQMYmuEi1Mx5qFFgoRSHdPW
 j4+v0GlwlRhFg0K3Vz5zB1qEOAPl3dCDt2gpR6llgY3lzAkh5EfqqhI2qid9UZN0J+r0B/6sqz
 v+wGlHPoaXwAAAA==
X-Change-ID: 20250204-bam-dma-fixes-1e06f2a6c418
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

The bam_dma driver has always printed an error to the kernel log in these
situations, but that was not enough to prevent people from upstreaming
patches without the required properties.

To prevent these situations in the future, enforce the presence of the
properties in both driver and schema and add the missing properties to the
affected platforms.

[1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
[2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Luca Weiss (1):
      arm64: dts: qcom: sm8350: Reenable crypto & cryptobam

Stephan Gerhold (7):
      arm64: dts: qcom: sm8450: Add missing properties for cryptobam
      arm64: dts: qcom: sm8550: Add missing properties for cryptobam
      arm64: dts: qcom: sm8650: Add missing properties for cryptobam
      arm64: dts: qcom: sa8775p: Add missing properties for cryptobam
      arm64: dts: qcom: ipq9574: Add missing properties for cryptobam
      dt-bindings: dma: qcom: bam-dma: Add missing required properties
      dmaengine: qcom: bam_dma: Fix DT error handling for num-channels/ees

 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                   | 2 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                   | 2 ++
 arch/arm64/boot/dts/qcom/sm8350.dtsi                    | 6 ++----
 arch/arm64/boot/dts/qcom/sm8450.dtsi                    | 2 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi                    | 2 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi                    | 2 ++
 drivers/dma/qcom/bam_dma.c                              | 8 ++++++--
 8 files changed, 22 insertions(+), 6 deletions(-)
---
base-commit: c674aa7c289e51659e40dda0f954886ef7f80042
change-id: 20250204-bam-dma-fixes-1e06f2a6c418

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


