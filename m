Return-Path: <linux-kernel+bounces-431320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9509E3C34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1735CB360D4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FA62040BD;
	Wed,  4 Dec 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuQpHd+B"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFF1F8AC4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320837; cv=none; b=VoJ8KS7omYQ4JXc8Tfm33LudArgq53+SOp11XOD+PDcZsJYsU8n5WYoDhS4ZSLJpXf90s4aE/5VDTdK2IhLlMGdHHkvoXwNlTdEoizLBmh7G/1nqVr0u1QBgn2+2AlaXULNgIYmAeVJxYHLc/20xBio4VbdqXOHuBeXr+UY9QnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320837; c=relaxed/simple;
	bh=ssp4dcsZCDyLM82QaOE3c2k7MIcONTsg6QEdlf87K3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz0i5L9SqQobfknl1EUkvbC1UeCfn63ZhEGSp+Ox8Y8nLao6AeOJKUmP32AQhjqsw0+xO29+JctmHsyHtdpBO98FAdnNoDQKM9JKZaHpaYS3UpRG2lpK96N0TC4GgfatSJGT2/8bWDXutlMUVrOrjnUMTuoGJeHiNcxFebYvDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GuQpHd+B; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385df53e559so4015867f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320833; x=1733925633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLrHu50pzztwUqxBZk1ZRxPuancx79BTgjqfe/nlYrM=;
        b=GuQpHd+BknyYyIB5IEpeAd525TxBvFkPimTeMlQMAGcuid448fy8iWlPu6h8wVyiZD
         ez1+vq8QMD6B7iPULs0idlUZA8YBrsyFa+AJFPn4FD4wzhPWic/eEIqXw75nyCpp0Qf6
         aFCKTQWYKbNxnkyXrCEXql+7X4dCxV4jZqnEM+0HHv9fRITeVx8wruTppYNeJaIwQfV8
         JlBxYCcVzPBYXSCgLjxYSPu0eN1eQRjLhfkvJLzw1VwIdKaH7ERNE/N8FrYlLU9p7hz7
         lk/MHEc8vCZRM3cGPGV6DmDVCJ9YI2iX9dxb9wBx8mAipTljsXAFVREN5CYl3fbnaxFU
         KS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320833; x=1733925633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLrHu50pzztwUqxBZk1ZRxPuancx79BTgjqfe/nlYrM=;
        b=dlZ3gQt7xBpCBgA8KiUWxjbNdXAO5MyLBOEngxlv4zkkF5qv2dGx2f1JmlQ/Zvitmx
         SLqtNqzHvibmiBiIRm0SWBjpJ20fIKlpKzAVQPSnWnoYUnMEuFWZAP5ZqV6gvgvZAvqQ
         VEsDaI5UJz8cQ0e7yzvT7Q9+vs9w9zWlm8Y+ZKC34iSWxljZxuDmfvmstnrR2xlyyHdR
         3ttstmPj941QWLYSel+sDhmydd/3KiJSoXRhQjxdes4Cv4pFh3nwV5lbQPVD1QcLtoX4
         rlLGM8w/vvyBDAikwD5WTvX6TgoST3qbqOQpFt+4qEGrnyWnmeQ/ZOdXzko6jeJCgYTJ
         sBZA==
X-Forwarded-Encrypted: i=1; AJvYcCW4WGw5wQJ+JNBnhA2YuUSCjmGbDUqHH5Xz1iEwY+BS34c26C2chq/Fy3n2d8QhaKGVj2cVKeb7NFEnm1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2tnTMhy7zG25FE5FxOY2Dl2qpd2qUW3C5SANy4yxhaxxDdM6
	nvjz2I61BSq4dAp2TlQsnyRF+xu5TQvzV6BGWhecUUsa02t7x6GX1kaB4x0CAQ0=
X-Gm-Gg: ASbGncsr4wRCYuHZy1HtKPlYSLr7e+kmfhrZF02NMEB7vgNtyX1O9P//acAeZtun9xb
	0usY1KfEiMyFCEpuQi+0L1ZCECqMlSekHp3wae6rwvzrSSQNzw07X9wH1DgE/gbp0Ak+eirtrMG
	RqC9pU+8+Uw05DrxcjbQn5cK30Gb7wkHUiUIXVrGlQyk88M9oUgP3BXhlr9c95XWZfFfQIBK0SZ
	/ihfXvU1NMD3yOrSHkWWXb+vwmvlvLvb5XPUJ0cnMtqA6pFjqmrwFRn4Y+rZsZ2SH9vLMU=
X-Google-Smtp-Source: AGHT+IHYK7Du5iUylGSHkyu3iZhxC6pu4WEqdTfJd2HA8NRTO0kPBBavxBK4pbJjpzuedl5Cz9JDnA==
X-Received: by 2002:a5d:588c:0:b0:385:edd1:2249 with SMTP id ffacd0b85a97d-385fd433008mr5794874f8f.50.1733320832123;
        Wed, 04 Dec 2024 06:00:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:2381:fd67:101:8e2:966d:36c4:3579])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm13689978f8f.49.2024.12.04.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:00:31 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	a39.skl@gmail.com,
	konrad.dybcio@oss.qualcomm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] arm64: dts: qcom: sm6115: add LPASS LPI pin controller
Date: Wed,  4 Dec 2024 14:00:25 +0000
Message-ID: <20241204140027.2198763-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204140027.2198763-1-alexey.klimov@linaro.org>
References: <20241204140027.2198763-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
controller device node required for audio subsystem on Qualcomm
QRB4210 RB2.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 816b8331933d..df2241237b26 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -810,6 +811,20 @@ data-pins {
 			};
 		};
 
+		lpass_tlmm: pinctrl@a7c0000 {
+			compatible = "qcom,sm6115-lpass-lpi-pinctrl";
+			reg = <0x0 0x0a7c0000 0x0 0x20000>,
+			      <0x0 0x0a950000 0x0 0x10000>;
+
+			clocks = <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "audio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 19>;
+
+		};
+
 		gcc: clock-controller@1400000 {
 			compatible = "qcom,gcc-sm6115";
 			reg = <0x0 0x01400000 0x0 0x1f0000>;
-- 
2.45.2


