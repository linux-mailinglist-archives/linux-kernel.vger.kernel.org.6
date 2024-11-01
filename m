Return-Path: <linux-kernel+bounces-392626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED39B966E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B600CB20E15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E11CDFD2;
	Fri,  1 Nov 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twZkZ5HL"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C741CC8AC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481573; cv=none; b=FuRd4xXLnql+fn8GZwXr7tjEzSkxFk3UB+l947i/al4xuJjvzuCaW7fxXv/dLKtV6VBCIbpQ+Xa/uNblOXCXtwnYtNLVyAnvvUZZCOY3KmAGzhJIIxKZkpMuDx2WEz5usA7VYcMjZgqBM906IpDoJ9BTpYfWgqgrVjumGwP4yzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481573; c=relaxed/simple;
	bh=Uw1kw80+4Ph0iYJYEz6jxj5pEwJ8ghjEEJqw3z7y2dY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjKRDb+1DrPoIwqeDvLuRdCcKw6ot5TVAbTu2MKY8/nN+QE+2u+Z2uiJhhVybhzhEfUAZTlmM3niJkvdLyqOOxUyUW7s+3KJTgzruCDQTLKHE11ZjZcY0kD45RyhFNrzsmQ/AUljr3k45lgnnJzODM+n2TiXNOnRjaH52aLOjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=twZkZ5HL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315549c4d5so2977375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730481570; x=1731086370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDZtCL9V6jrVKjdiSq8qlRaC8zEyNDaShmQ+ETFKWVw=;
        b=twZkZ5HLNnmNTMRp+0Df7gMZAvAHmQQ4P4XD0Zb5GEZgiLFjH/aImYzRmjFvMPqz9S
         DhvQjno08lVh/yPvXuciSmPpFFbrKF/cD0WnNvjtVvS8ZIWr9wFkftCzL+Pwguol1SoL
         pGQKrnE+kh0cxhptmJ3KJfC6w8SuhJNyczyrB4LcEXEWXX90WlqUyztqoJbUBSgTSvAA
         advrdcB1zRfw46LaVRWVlozboZ7EQvnouYXNTFkbC4jZISS2fISbGEoSBE1hsXz33QcT
         KE8A/gSyeAgZV8P4qg2jv/sQD3B4rzp8F3S1U/pmyEEcBCyfd6VHPJN6GlfR4Dbk5ivq
         MaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730481570; x=1731086370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDZtCL9V6jrVKjdiSq8qlRaC8zEyNDaShmQ+ETFKWVw=;
        b=PaYomvVPJVJ8KbV//qQM+pJQpBPR55ln9ukbwz0PytQycrQXfcSL1/NUxjG2s4rkK/
         6Ao/Ygr62HvUpfhrUfgUTToIeg0ZpnUJkl5MKsD2NK2N1W5ZMwwRRkjPANpmmjTw8YyM
         6b+6Ypitd9XoZfmCaI8udmWvTldCllq/69cO/Hg/V9vrjJ0ySVkKBiXbpVndoCv/yrOB
         n7imdG6em6NHqZvw5t7LsntiGZ7LEJ+zuNoPWB6zJVIuN6Fr6oAEuPybnjoBG+mH7nb4
         5O2tO7HPfNo4qcN9zNg0wKmCSP0uQzmA4I1IIRHatNAeiYk4xLRekbrxDa1hgkTMrqMk
         QdYw==
X-Forwarded-Encrypted: i=1; AJvYcCWPtBu/uHS2xEU72YXfTmK4pA/H1uzbobxIkPVq/OwSkgTFrfkz4CcdeZJo6x067zVv9DDbjjnfaIbXafQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyV3EL1Au8ZzvhXgY+F+ECfH4hq9XBweluYN4m+dLbbuH80UNC
	4fMap8Q6uJCAOn1ylC0lP3WNltNgu6IeDIl5E6ns6MUS02Vo8nMCz/u+ojaU7j4xScrLM4Rylki
	E
X-Google-Smtp-Source: AGHT+IFXI4zBDNZFUyCQ1S2/iebv5GSHd8S+ETRizsc5twFAEN71HH5OqaNoDg4yE/sE/EE/IQ0Nng==
X-Received: by 2002:a05:600c:45cf:b0:42c:aeee:d8ee with SMTP id 5b1f17b1804b1-4319ad4adc4mr89947435e9.8.1730481570105;
        Fri, 01 Nov 2024 10:19:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab305sm68536785e9.7.2024.11.01.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:19:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 01 Nov 2024 18:19:13 +0100
Subject: [PATCH 3/4] arm64: dts: qcom: sm8750-mtp: Enable ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-sm8750-audio-v1-3-730aec176459@linaro.org>
References: <20241101-sm8750-audio-v1-0-730aec176459@linaro.org>
In-Reply-To: <20241101-sm8750-audio-v1-0-730aec176459@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=827;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Uw1kw80+4Ph0iYJYEz6jxj5pEwJ8ghjEEJqw3z7y2dY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnJQ2YuQagmHTZZmJlFZW+1o53G9FkFSaMOU81V
 C7SLXTOv1CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZyUNmAAKCRDBN2bmhouD
 1830D/9yS4vRhpAYxs6KQCBrnLx88jnNdB4mLaKS6G/YAr1KCa+psbzN9B5VmL8vWF3Es+g2Opt
 xUz3L6kW7NoZAoqCf2qvPbGkwsSe+B028Juawv+flK1IUjBjCJu5racKEGo97tinEol1Dyxez/l
 I0e1b2a44Qr4/lhSyzsxBlP/VZFuByaiplQQ8jt4rtbvxOughWsC7+LX5QT/qwukF+glwVZ3gYk
 mDG0HwF3L2yLVoXr2YYN3wZKIJk+0zTob8G2eudat3JTnes8A36AHFJi/H0t53UMqwuzngAf7X5
 26/rhacehjKT2yHIg3ekWHCsbYQPzlkgHdR8XZyON3x9qSPxtdwD+RAUNqbSUOf0kAduHr0PRL/
 Z4JpHAsbcO5qWN3w9Ej8dCm6focXY2nb8lN24MjJmVm7ixedBENKg0jEIwh9vR99iCEOo2Oh4U2
 CyZ0CU08KWHx6Q5XUQTvuJcRY4+kSFXnH5y1jXioSNjB6+iLMqji53F2OdHVyEDf17k0zPptu0Y
 HShWJqATeRHF2pYJHedCxsQ68Dk2nwsle6svf7Sy73tc9cxjctfI4NnwaNXA/YMJ6KXtGWOpxEt
 8VaUaroQmQundZ9pStSF9hQdaMpmynnG5gTL/rslVORGq2blXhhIzuiyxAwdhtX83+TUB+4rELf
 KRHTkRxbvy+4ztQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable ADSP on MTP8750 board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Firmware release will follow up later.
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index e1a94dc76e2f15463015ac971a93e702835baaec..eb3f5bf51f6fed73f3ba9f9dd20ce6da2f9a8fe4 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -865,6 +865,13 @@ &qupv3_1 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sm8750/adsp.mbn",
+			"qcom/sm8750/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
 &spmi_bus {
 	pm8550ve_d: pmic@3 {
 		compatible = "qcom,pm8550ve", "qcom,spmi-pmic";

-- 
2.43.0


