Return-Path: <linux-kernel+bounces-391699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0679B8A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B031F23039
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 05:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8C14A605;
	Fri,  1 Nov 2024 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2BFlKow"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3814A4F7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730439123; cv=none; b=R5FYcIG8ExFmoLt/l/ZSZpOlP/RWsS+7Y6Tr18Ndjj4a7MEhbgFLanD7M65J02c/iv1nYa0g3RPjU07wsLyCS3UvmNsEgGXA5pTvKmnIe6grdLG5VwkzV3Slt0sgsshPVH9HO01fs9624iEETNDY+ScUWBFNBZ1PBIQrZ7Qu3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730439123; c=relaxed/simple;
	bh=6c0ImAxpls+T5z2bpQ9Yl4ZdWHui8yMGQ0RY/fek5lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEKp9ttxIFNBd+9gJOxgLHWe81qXG3tDAPaVk+ifeoFD4vqhIp6f2icEdtpJkUjyOSEBa4/C65UlrASSysRXc2OwUKg7gJTrZmw7Hb0+ikPir6aoUKSeKO+Q6+N6JzGYP71OmHgWw+dGDThoz8rWLtapNz9zb7lFTbID07vIoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2BFlKow; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso14150075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730439119; x=1731043919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AagxMQSTeepIIRbJkNHGMYKTNJijkgoWpQ4x2Maii6E=;
        b=z2BFlKow3SzRncajDgWooC/DTyPN3MbU+2BUgT4t3JnJphPdhkl5tDrAe5lRsPouLC
         sfAyaB7UAev4A7B6U4hAUBPtoIIphlXWApQu9pd+ioPb3xfV04xfSam0TAHu6SMCMlnC
         5PHdMxG8b6YRxZj9eIq6rtEME17T1ke1mRZ1EhedSQp2N/otTmvt5W9uibxMBZ/c5MI9
         9/Wr9W9DfmDpWs/u0ZMWckAiya9egKCD2FeJnCCzsdp6WaTJQJDo8j7kM49YAbzWZcnY
         Vr4jJYnDYV+tYu4YDrYXYc4BgZlwNmhEaq6MKg91dzIO0ukZlMWDGWHA4vmRDQJj37P6
         mt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730439119; x=1731043919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AagxMQSTeepIIRbJkNHGMYKTNJijkgoWpQ4x2Maii6E=;
        b=eYDNvYEh3qVqjilRv+r1CYDq6GVQpzWgsochCXoWxq5Af9RaXjt+gSjHoejoPQOVW2
         knvAPvUUUxdu1otN1+6UmYzddfTCXU0I9+qnPIJmtb4viNiq9UKX5tcpg94iCb3YWWYN
         MxCVSZKSp+Nq05HVNeNb6wlT0A2Qo3iAY/DlQae0L4x+gnEUobgeaS4C/DMtTmLSLX8a
         TSuSwaIfRRfe1lhzQwOgzYP8datGw+MRxTua/tGbK4g/J/LIlL0n7mSPq2Bsy4lnWhwu
         5eXUnMd1LcR0tovVC+Uq5aNWWheh9pScOx4g5SgEGzp9SrPQNFeb7X8T1KnFSBd0cqph
         CIhg==
X-Forwarded-Encrypted: i=1; AJvYcCWvyFp/08qYGoWgnJ4QNRxDbrn6GGVHCrm5WZuLvuDFeuGdAji3IVy6huUx8jUzztWNFIAThx2Y2TPEUm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMdcmoZAD/PokQcpGmazYm35s4V0fmFn3XP+lTzJCybMzZ3yV
	MlRCfh6dT/5JWMBIoHllZT1IGIagayvgAYwZv1BavsAzQ815QYz1Jcxn+fPpaLg=
X-Google-Smtp-Source: AGHT+IENmFZ2CH0DtPNo/eS9oAo1+rJXuWpBueUsCl0BOJBXfwA7xhWdqjWkh69ceSQdQ5+HnDh0+g==
X-Received: by 2002:a5d:5847:0:b0:37d:4d3f:51e9 with SMTP id ffacd0b85a97d-381c7aa451dmr1773039f8f.40.1730439119587;
        Thu, 31 Oct 2024 22:31:59 -0700 (PDT)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852fdsm46960505e9.34.2024.10.31.22.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 22:31:59 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/10] arm64: dts: qcom: sm4250: add description of soundwire pins
Date: Fri,  1 Nov 2024 05:31:46 +0000
Message-ID: <20241101053154.497550-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101053154.497550-1-alexey.klimov@linaro.org>
References: <20241101053154.497550-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds data and clock pins description (their active state)
of soundwire masters.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
index 1b9983ab122e..8873015c05b9 100644
--- a/arch/arm64/boot/dts/qcom/sm4250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -37,6 +37,16 @@ &cpu7 {
 	compatible = "qcom,kryo240";
 };
 
+&swr0 {
+	pinctrl-0 = <&lpass_tx_swr_active>;
+	pinctrl-names = "default";
+};
+
+&swr1 {
+	pinctrl-0 = <&lpass_rx_swr_active>;
+	pinctrl-names = "default";
+};
+
 &lpass_tlmm {
 	compatible = "qcom,sm4250-lpass-lpi-pinctrl";
 	gpio-ranges = <&lpass_tlmm 0 0 26>;
@@ -74,4 +84,40 @@ ext-mclk1-pins {
 			output-high;
 		};
 	};
+
+	lpass_tx_swr_active: lpass-tx-swr-active-state {
+		clk-pins {
+			pins = "gpio0";
+			function = "swr_tx_clk";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-disable;
+		};
+
+		data-pins {
+			pins = "gpio1", "gpio2";
+			function = "swr_tx_data";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-bus-hold;
+		};
+	};
+
+	lpass_rx_swr_active: lpass-rx-swr-active-state {
+		clk-pins {
+			pins = "gpio3";
+			function = "swr_rx_clk";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-disable;
+		};
+
+		data-pins {
+			pins = "gpio4", "gpio5";
+			function = "swr_rx_data";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-bus-hold;
+		};
+	};
 };
-- 
2.45.2


