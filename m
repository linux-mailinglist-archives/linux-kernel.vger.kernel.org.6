Return-Path: <linux-kernel+bounces-202878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A28FD24A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C821C234B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE0188CBD;
	Wed,  5 Jun 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1bsUUuq"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C285154BE5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603241; cv=none; b=llRJMY6IZbDFQjF1AArb2tAaYTcW8ye9swLbf6kG+5scpJtii8hd4E0q72S5zt0m1c1Xfz4MfAQ9NQqciblSMAPu4QSy9Osa9D9xT8gqmiwlQEjq4DxESlI/yZ8cQU1TeuWvZCKyNvkYrRXAAebAcAQvlxWv/oCAX8TaRbZTxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603241; c=relaxed/simple;
	bh=c/2SKyVNxmDDEy4jtRH3u8SNLIlWuUpwBcMP/asBnSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDkouAogZt+YCXF00iwrwigiyZrIUyTLNTbGQiZdOwOPZqEkMH4ZZp08WcPAr1rvY8zquP7uzokhA93+BESgZxf/odYcwkCN0/IHawViVa02/Z0TVRaYDZHnCSBgGSwyrCswYKjfDZLOTcUrq7+8UeVbght4VbFzTwAahzkayPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g1bsUUuq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso689591fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717603237; x=1718208037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS6pzXJDK9QslMNjlWCKMW5GnNTj+YYAKSrFzSpQVwY=;
        b=g1bsUUuqpOhBWPzE30Jlh8lVWsdDyfdJY9Zy/kdq7kxcJGyIEvui0SkornbDUdFHuU
         v860oTepOZF+3k66EHZkN1kjyjMBD3OHAFzzNMcvguX2xk2FvGP8snzs7dwC/qBUq+oB
         QAMihJOTASDfELqPsMz1KbL+H3aXVosYUOyiz9VrmZeMj/CxdtctSP9qQ6Bc4XRPXGFa
         jes4uM/hQQKYXmW0k23usyfCmwUTcMl2aSuHqsk7d05FG7Khp5pci+nm3zsMaga+r6yo
         rhl4cbpa3yWm7wbFOxFGkyV8jKSx9M5MJUYTJzblb0gFLIL7lpCWJIoILZ4r/n75iwI8
         wAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717603237; x=1718208037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS6pzXJDK9QslMNjlWCKMW5GnNTj+YYAKSrFzSpQVwY=;
        b=KdJmgqUZoZJ3LVeIoeIKz1Qo+RUEpQtCFsaCHUmJmMjj6oMmYz1jaPyQVA1Ba2o77I
         7uBwDZQEF7eaPLvTRhbNQQPWhXdrAnvmSLTzTldrNYiHfGVXIyt+Ba8DrxHVvvTpjfKj
         WfZLa2CDdDAaYUnkg8K9iRCMCM3YDAhwMobLLrl5oXrruRnFpgVmzXrlp0d+OvKgHWB6
         zEPcQWpJgIUN/j2UARYsAY9JE2K0cxpjctofmfqnmcCnDwUXgiUQyP0lGoU4m9Avb5QG
         2Jb6CNA2n6lTqpYNB4CXNYMmCGHhl9hh3e1Ii9C8XXXHz9/pUWJtJiXZLLAI2Lz0UPSr
         BIQA==
X-Forwarded-Encrypted: i=1; AJvYcCXPTspqUCD6pwq3vrH1bDlmr9ODdzpq/YDeDKMiAphhE88ptIjWOMBxN7elt/Gw1qhbutj9gamqTmI7GE4Q+xK6tJRZBX6HG53byfho
X-Gm-Message-State: AOJu0Yx3bxGKK64peeQl8zVVt2AUWSW1gF8eot+qUwkGesXaD6+MNd74
	nhSxK1KOltKGd96KZCePT3UotL2vSqt3JZXWI2M/xMAJEKsN2y8MyyhNk1E09Pc=
X-Google-Smtp-Source: AGHT+IFVQ6EuFCOacFNDp/dYjlatng7UYWk7LSo2A1ZJyk2RuDDqs7BYNK1FQL5VNFszGvVvaRqBWQ==
X-Received: by 2002:a05:651c:119a:b0:2e9:6265:9926 with SMTP id 38308e7fff4ca-2eac7a9a366mr14411021fa.49.1717603237432;
        Wed, 05 Jun 2024 09:00:37 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158149008sm26288975e9.29.2024.06.05.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:00:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT 3/4] arm64: dts: qcom: sm8250-sony-xperia: correct touchscreen interrupt flags
Date: Wed,  5 Jun 2024 18:00:31 +0200
Message-ID: <20240605160032.150587-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605160032.150587-1-krzysztof.kozlowski@linaro.org>
References: <20240605160032.150587-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupt flags 0x2008 looks like some downstream copy-paste, because
generic GPIOLIB code, used by Qualcomm pin controller drivers, ignores
flags outside of IRQ_TYPE_SENSE_MASK.  Probably the intention was to
pass just 0x8, so IRQ_TYPE_LEVEL_LOW.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index e07d0311ecb5..f6870d3f2886 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -520,7 +520,7 @@ touchscreen@48 {
 		compatible = "samsung,s6sy761";
 		reg = <0x48>;
 		interrupt-parent = <&tlmm>;
-		interrupts = <39 0x2008>;
+		interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
 		/* It's "vddio" downstream but it works anyway! */
 		vdd-supply = <&vreg_l1c_1p8>;
 		avdd-supply = <&vreg_l10c_3p3>;
-- 
2.43.0


