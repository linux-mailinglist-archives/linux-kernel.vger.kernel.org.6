Return-Path: <linux-kernel+bounces-429966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7679E29C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529E81604EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3B200B98;
	Tue,  3 Dec 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0weV0Y6"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948111FAC51
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247862; cv=none; b=qTJH0fUTOGte+6CvRPeluKm0yyyCvjRoR2DcUpQHgt7CrCp5sd8Oq0/R1gvSmOO9P9Wq7jh7KCnFso1i4bHfmBAqaMqjKfrVCfxeRggsgoWr2mFvEoFPyarNq3Johb+QRRJgN2ARUAeGuI+a16tarY6qPzI6M8sL0aOayXICBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247862; c=relaxed/simple;
	bh=/p05xSypzO/4OeH+2vX+nGZmcBYlJ2JK65edxSL5uQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAKuhp5LtIk/vvwOWGT4Oqny0Es0yFbfU1Z854pXFHLhznRctMGwd1AhBGEk+kw+mv2tG8sRhdyo2HVim7stOIxxTWMyPdfXMpjvU1D1EzW9gO9Jdjtt4Vou+mVRy5e+vyKCBnsDlezMi9+e7Uneb9EesieOcI5ndLAG4X5gi9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U0weV0Y6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so51231775e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733247859; x=1733852659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20enjGFbIMY6ySoTLbqeBiSJRGb2uQMuia/Z5TqK/Vk=;
        b=U0weV0Y6Dd76An6ast9Ib9o0DP3SetY+zXv/J9FiR0Y0buNdXZeA3obQK33TpDxKVa
         JDQWmg2W1IXCvBNJfT2yFAd+HNF97H6Av9MBOX/r13dvXLovztEjkENQ7tmCGf8SuzCX
         LZDCWu+0V2LDFj7ZSmmlmAVbTvbpbad5LWWTRerrGTRTvWJ/P9WMBFOkYsObqmTPO5rY
         p3nU0S5fIumsKDAGRUhOw+hs3TmNdhr9dyfTUKwVFiUBGPjxb4m72NDRaxpapNfTaOSw
         Jhtov0VB/5mKZVUBuHUIHyG/FM52cLla8FMtmV3jo7J8h7lfBWqEZmPQZCQXVSGD4etN
         9gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733247859; x=1733852659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20enjGFbIMY6ySoTLbqeBiSJRGb2uQMuia/Z5TqK/Vk=;
        b=j60xKg4z/IsUT9X9B3IJxVJ+cL4X2beAfm06S6JI2o0Is1GoGvh+XT4EkfN2lQHqb0
         1eq0fZ2TZiuOTmp6YixCJnmTFmGj/bNcfH9hOvlR2FsWgsnuZ0oVk4b0fUsslSw9D083
         o41QoJrv+/C0jVqArUNo9R02Z0S6Bb9ateqdesP9uvnUHRgjpYw8CRRYvLM31RFOGito
         AA5J2PjMJgPtxO+w2xiCIxhs7MMg+Lg2+EI5092cZK09uhZtzc1QfjW6tGLwIVq7kSJh
         a5OyB+Cs4Z3FLOlP3sA93ZR/76ZAZ5wxBPeLQ1ZMyeheAVMeyYArUtjl/vblTMyhv+3Q
         T+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXbLszVitxsk3/1ESiO+IyPejwKqTVq7jfHr+d6CZPmZDqNFr4tJ6I4tisjRw75+OPcgngq9uB8Cz9m7no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrqUICrLd/nH01UtjgR7ATNiCPthGf7Hf5e/h0P5NKJIYbEs/
	/PXWENbrdalg6FN9F/nRrsFvmUnyvFQTDJpi1NuHBAisABHiDSPlLe5Qwra+uew=
X-Gm-Gg: ASbGncu1qSqKqa7HAqKX8bXK7JM5DR6ZzBkZgjBJthTp5oMjdSNqiNigmUbCWQp/+Zu
	90Mf60tdtSFYNJg9C+V3jLGfy8/wUqLb1GUmO+XdyIgc0x15La+kriQoTyPh24H/9W1BbiSZB4m
	SV63NnHTaTYEwOCOFnu368P2t+mVGzuPi38qVfGObWHxZSHm/6OWF5ZgUaEXcXYVbvcEXxV5sXT
	oB/Vr/5Jfs/FTlXbsdAVieY/JqDvviWNrFe2tcjxsfFpBBnyTD/PMMqO6NREa4=
X-Google-Smtp-Source: AGHT+IHWm+MdE4pGT7/SWD+IygidPPYvtwFY2rLG6XMxPlA0erOfEDLVdpRRoXo4nK9V4WvRYNyvTQ==
X-Received: by 2002:a05:600c:524d:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-434d09ce368mr32037235e9.16.1733247858857;
        Tue, 03 Dec 2024 09:44:18 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:9f9f:834f:9008:1528])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d05b4909sm17648055e9.2.2024.12.03.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:44:18 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 03 Dec 2024 18:44:02 +0100
Subject: [PATCH 1/2] arm64: dts: qcom: sc8280xp-x13s: Drop duplicate DMIC
 supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-x1e80100-va-mic-bias-v1-1-0dfd4d9b492c@linaro.org>
References: <20241203-x1e80100-va-mic-bias-v1-0-0dfd4d9b492c@linaro.org>
In-Reply-To: <20241203-x1e80100-va-mic-bias-v1-0-0dfd4d9b492c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

The WCD938x codec provides two controls for each of the MIC_BIASn outputs:

 - "MIC BIASn" enables an internal regulator to generate the output
   with a configurable voltage (qcom,micbiasN-microvolt).

 - "VA MIC BIASn" enables "pull-up mode" that bypasses the internal
   regulator and directly outputs fixed 1.8V from the VDD_PX pin.
   This is intended for low-power VA (voice activation) use cases.

The audio-routing setup for the ThinkPad X13s currently specifies both
as power supplies for the DMICs, but only one of them can be active
at the same time. In practice, only the internal regulator is used
with the current setup because the driver prefers it over pull-up mode.

Make this more clear by dropping the redundant routes to the pull-up
"VA MIC BIASn" supply. There is no functional difference except that we
skip briefly switching to pull-up mode when shutting down the microphone.

Fixes: 2e498f35c385 ("arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai links and routing")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f3190f408f4b2c7ca9fe368d652d5d66bb3949af..0f1ebd869ce315bfed2c17ae90b2451b3892b96b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1202,9 +1202,6 @@ &sound {
 		"VA DMIC0", "MIC BIAS1",
 		"VA DMIC1", "MIC BIAS1",
 		"VA DMIC2", "MIC BIAS3",
-		"VA DMIC0", "VA MIC BIAS1",
-		"VA DMIC1", "VA MIC BIAS1",
-		"VA DMIC2", "VA MIC BIAS3",
 		"TX SWR_ADC1", "ADC2_OUTPUT";
 
 	wcd-playback-dai-link {

-- 
2.47.0


