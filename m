Return-Path: <linux-kernel+bounces-561467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32990A61244
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3F1B62CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C50200BB7;
	Fri, 14 Mar 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJx5I3WI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB51FF7C9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958056; cv=none; b=exg8cWX5HUN4EzP5aC8mpRo29VYglpQogW+QRZlq/oNggSVXilqJ8ddqKS6fZqXy4n23Qw8mgXnqe5aiX0+emKQy90pnrl2B7TEWo5cqjUCLFWtkATSiQXf9vaXLXuUzlsh7oIiqfVD2IQn9RkYgAyMu/pqegFqAYVZrGXpet8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958056; c=relaxed/simple;
	bh=CU+/XDQ60jyq3i9MimUs3kFmTV8jnj/R31j8nRU/h1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYfgHXHlvX9e/0sYZ3BVNmFm/XM6kKObz9NUxNLgyjj2C7ePUMUmktnTYMulRv9MvBwKlwG9xCqcyS0tDMSj02+YB+xoo5Fi+SOI5Y1ZcLKm1abhjgef7IRAkSQ/FBT9HH6E5PtMl/vL17ky/a87iEOQN06SeAckSV+hXkCVbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJx5I3WI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so279034766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741958053; x=1742562853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DObyF/iUzXjPpPEbY0w+cm8oMYW2eB7he9g871AEyE=;
        b=QJx5I3WIhysKc3fOhiO4N3zGklUXZIQhtCcJ01JzrnbmWLF90R5nqej5m6mROdcDhk
         v0cVaPOSYoInDRQUbQZXhVzGMq0TRxnU2W0NzC+g8uVjWlBnpOolJdLV5HHvrFQP2aIC
         ctDQ5JrHT7hF0XsTXpIWpZdt7pjYeycAu6rfbnq0+mYY9H0ZE39hYgAOanYY+KSBcqHA
         eN44rckluc7bxrEv1/+CjxqLYOcI3WDq8cgrJkbDdw+mQBJZH0893WK003kEHizuwc0z
         /ItByWB45osw04dIe+EGwJpJQbXGUNOzsTKZMmgu17usaymfjTLm1GovFQSdyVrfkJIZ
         n5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741958053; x=1742562853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DObyF/iUzXjPpPEbY0w+cm8oMYW2eB7he9g871AEyE=;
        b=O0UDR3Jm3aF3xXMBcJhmRjIQsRTJiEOQKb7Y0j6pVWUw+T5IsD60Y9DacyeRouNOTw
         SBOI/zNmNkFfymo5vSeTsAP/s5iW+RV3Cro4ZMB1CjF4TPAeasd618h0U8UEr3qHAmfg
         6XYfCFI9FuEWgqT/0R8Qmk4XZjZhdc3D6nxWPwAIXiUyRXZKNdTK2UIk+uYt24c4/93p
         M6v4d7hDj0uWpdmcrwO2PIrqe9sj93plF4J1MosbziZ3ZNmD1CDeLQHF1rm61PkuSFjN
         pmyX/WqXqHxFs8NqAdsXIaviVVP2jyM07Mm+Ar+JqzO6v//Vq3yIU4A01HGShNeE6h+A
         CO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO4DZVGP1vO27lzWV9W6AI9APZwFqIFWP+qC0gG/LItEkBKvj4ds7ECS3tcj+DzXh4Nw8eVa2JK5O87jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNyFU2CUuvvyy+QFKMAVNPWiIpjP514CyTFxmG+djIZZFD8K2L
	P0xiTaUKxpXyIB0adPFNr1V4oq0rn/O6Rs9J3inYWZPV5LGGpSq/+rbYO/AGqZI=
X-Gm-Gg: ASbGncsxOEqkOcxBL13ukfew7frjWv5tW9jsW1VDVT9Ac8JJWhms5ErOa+3xbv7VYVF
	bcMixvrpmNpRZudsfp5k80+mad2thhsv7ZTysDedrzwD/VZmXZVztIctR4/+aTwFJWMPt2QY7TU
	pNhvFwC0UBzP0wsexHrZDf6bMPmYaeSB/VfuycHC1IQe1dSl0M8mgCfArOr6BWsZlW72ZXYOol+
	Kya4LGidO1nt6UBeJ9qeA3ay1EoTkQtzHJIiGuzu980YYSEg3R8XkToktJdWDG1unAm08I4aQFN
	z5U4r36CRfaBs5rKtcRrinT1mgkAyH6w5w9ZH2cZklKtn8wLI08kBwksW14makW1htEmLN2d2mA
	GqATdvbD4ZNRraNVdIMDKQFnvkm8KZEpz9fLyfJujqMzODkDJ5SjLTmRYaZNBuLKkpHXO01AllE
	YG0lA=
X-Google-Smtp-Source: AGHT+IE6XOuB72UEqsTJNdvpZRBJmMnctkvfNijsse/zxvJ7jAiEAX/EBW4sazJg5K0fUUXfv75Z2g==
X-Received: by 2002:a17:907:7e91:b0:ac2:811a:665a with SMTP id a640c23a62f3a-ac3304ef297mr260778866b.57.1741958052787;
        Fri, 14 Mar 2025 06:14:12 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3fc0esm226008566b.137.2025.03.14.06.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:14:12 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 14 Mar 2025 13:14:01 +0000
Subject: [PATCH v6 3/5] arm64: dts: qcom: x1e80100: Add CAMCC block
 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v6-3-edcb2cfc3122@linaro.org>
References: <20250314-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v6-0-edcb2cfc3122@linaro.org>
In-Reply-To: <20250314-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v6-0-edcb2cfc3122@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2

Add the CAMCC block for x1e80100. The x1e80100 CAMCC block is an iteration
of previous CAMCC blocks with the exception of having two required
power-domains not just one.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 46b79fce92c90d969e3de48bc88e27915d1592bb..065a219e69c632eca288c9ade001949e37b92173 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
+#include <dt-bindings/clock/qcom,x1e80100-camcc.h>
 #include <dt-bindings/clock/qcom,x1e80100-dispcc.h>
 #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
 #include <dt-bindings/clock/qcom,x1e80100-gpucc.h>
@@ -5116,6 +5117,22 @@ usb_1_ss1_dwc3_ss: endpoint {
 			};
 		};
 
+		camcc: clock-controller@ade0000 {
+			compatible = "qcom,x1e80100-camcc";
+			reg = <0 0x0ade0000 0 0x20000>;
+			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&bi_tcxo_div2>,
+				 <&bi_tcxo_ao_div2>,
+				 <&sleep_clk>;
+			power-domains = <&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>,
+					<&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mdss: display-subsystem@ae00000 {
 			compatible = "qcom,x1e80100-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;

-- 
2.48.1


