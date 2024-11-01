Return-Path: <linux-kernel+bounces-391511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6EF9B8810
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093A81C21915
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43612CD8B;
	Fri,  1 Nov 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuShoqND"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2539FC1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422781; cv=none; b=XiGte01Teca4ywu16LGIPtZofIsDNkQIhA9zubRhuDEy4dbkem9+s0BuuwLoeRWSO0PGLtD+dPvfFTCIdbLP++ieOkmvTxCRx1qBnCYT/RGBm1o+Vrjcs7TWwLiS2FIIYnyeTJAdZnzcb0D2ybgyFjERwZsQMbb0Y6k91d7qSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422781; c=relaxed/simple;
	bh=j94jq3vGJcIrOguDPhFtJsy9iuNY//3T5GgkTscKZyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhZgx8CvzaoUAKKcm2t5njasq9pEgicKn7Zi/xNomNh1skmNarE1pyLFSgvU1x/nfdWF1OY4hc0I14wK5FgPLOyjw76HKwUIPCvwBP2+kxcyg9thWeZ2AJ9ET9WDr8BSNx50A8YWxLpdNtRsHMQX3uFxQHdN63w3W1xD++isIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FuShoqND; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431616c23b5so9381235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730422771; x=1731027571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pnag8ISnHry4lkix9pSW6/v+Tf+7fphW3qIjWj70mo=;
        b=FuShoqNDBGp/vxPYCvidh4Q3QGS/6FPixklxvA5UqKd7Myi1OSppkgT2SqPIolqARk
         K7R48v0QIbF2qtitk/XVHI4fMdY5spm5rrenVjEcv9HMycFtXVXAxn6DqIbf6ftFUJp7
         +f1vy0doBDZnGbZjBxiSARiJ5pwJQ4Vll2BQWRm0Sqs8t2oUsWymUbBg9+H7WvyX17Js
         zHaP/rOamFGjLBqhZaoDCO4hxjQjA4IkWGU/XZ9mnj8N3sVcjfFdggfcvGRc8AY8RcEb
         anO64VcC9bnBtUFnL/6q3trDZXbZOatA15aHgm1tRVajjUxkBl8fhfeOIQ8A5w1JBysg
         7CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422771; x=1731027571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pnag8ISnHry4lkix9pSW6/v+Tf+7fphW3qIjWj70mo=;
        b=d13F4lVrdj3zpRbPAuSwbN5cjDfsek+ze1vVMoIb3XHjVg8ShWzuPgGRkALnoFlQy9
         fuhXbgGVV1KniLPsaDTBRVZb2khl+3s7YI8afJnuD0sxN9WIjTru5j5hDTG0ja8ccT/F
         w7K8VyzEtn/RGHtPne6ywl7Xly3cEtmBqpCouEPhen3Bmi7rFRz33bQMzoehe3bfJdfu
         uEj5oekdAsf/TnvsDhkjjHuccaZ48sPP5JWkntQekCyzzsSVyhh18Y/FIako8+BS5P7f
         pCYVFvgxZW4Ml7koFNiJGvHzNLOfrj2nVUl7cgbz8mFALAo/IPDtSCrjwIWgOCipvlco
         K9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUckwmEk4w+tOuwq7/0ejuL91FX1laOYk7hBZ6IjRKXSCT9tDSe8hDv/cxh67IJtvtVaXt79VJh0GwKqKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOCIy/TdgdSMmWjHp3efeits/IjCnZpUQry/HNMxcBz86dtQg
	m1Itgdfu2igRuqu/Q5s/4dIng8j7z26pLAWAmI/5OLRk4ATTwObDAui7U5PdaaY=
X-Google-Smtp-Source: AGHT+IFPJ0LubzZHrwzpNHQoqzbxQbgOtCnxU+OXToXETbFqBbBJ3rL3HRCpuGdl9gwIdN5pJsLoxw==
X-Received: by 2002:a05:600c:1c26:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-4327daa3649mr36215135e9.8.1730422771388;
        Thu, 31 Oct 2024 17:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947a9fsm74208035e9.22.2024.10.31.17.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:59:30 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	a39.skl@gmail.com
Subject: [PATCH v4 4/5] arm64: dts: qcom: sm4250: add LPASS LPI pin controller
Date: Fri,  1 Nov 2024 00:59:24 +0000
Message-ID: <20241101005925.186696-5-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101005925.186696-1-alexey.klimov@linaro.org>
References: <20241101005925.186696-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
controller device node required for audio subsystem on Qualcomm
QRB4210 RB2. QRB4210 is based on sm4250 which has a slightly different
lpass pin controller comparing to sm6115.

While at this, also add description of lpi_i2s2 pins (active state)
required for audio playback via HDMI.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi | 39 ++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
index a0ed61925e12..1b9983ab122e 100644
--- a/arch/arm64/boot/dts/qcom/sm4250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -36,3 +36,42 @@ &cpu6 {
 &cpu7 {
 	compatible = "qcom,kryo240";
 };
+
+&lpass_tlmm {
+	compatible = "qcom,sm4250-lpass-lpi-pinctrl";
+	gpio-ranges = <&lpass_tlmm 0 0 26>;
+
+	lpi_i2s2_active: lpi-i2s2-active-state {
+		sck-pins {
+			pins = "gpio10";
+			function = "i2s2_clk";
+			bias-disable;
+			drive-strength = <8>;
+			output-high;
+		};
+
+		ws-pins {
+			pins = "gpio11";
+			function = "i2s2_ws";
+			bias-disable;
+			drive-strength = <8>;
+			output-high;
+		};
+
+		data-pins {
+			pins = "gpio12";
+			function = "i2s2_data";
+			bias-disable;
+			drive-strength = <8>;
+			output-high;
+		};
+
+		ext-mclk1-pins {
+			pins = "gpio18";
+			function = "ext_mclk1_a";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+	};
+};
-- 
2.45.2


