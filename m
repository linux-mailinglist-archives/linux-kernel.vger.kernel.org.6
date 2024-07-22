Return-Path: <linux-kernel+bounces-258911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5C938E51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B531F21DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301E16D9A2;
	Mon, 22 Jul 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nj4RTrxg"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24116D31F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648921; cv=none; b=KbKgIk4eKF/4wHaBF2bWjLgJlCT7YwRk/vnjMssZxUgEx3YdToa8weWV16dQh94rJ1Y5ORtZpOTcc/BIo580T4kpdWgEhoE9MH9Ueh9QaptaOtkJfyEWfE6M7QqcHBODqN24ZkEkkCuwwz5rduTBvzEKRIbHTgYah+japVd/LqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648921; c=relaxed/simple;
	bh=wD61BJEe+DtpldLoB47C2K14wZvHYpFBbqDwcS8dm80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/po8OETo4yoCNlKG5iMC4ag7vDfEu4MfD5lzr/56bZBk/VtrEmso0vjfcKtF5RAY5PeIN8grOdS4m1fIvYJ+ZWS9BZN08nbIqDdRwIyJrvDyDBEhBjWyqePRyzUHDOR7det7EaHOswpRnUOKpOT8islrMO97jqIyPqNuiMV55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nj4RTrxg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367963ea053so2814195f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721648918; x=1722253718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEQhJ8RmyEK4utl0P1w5rhlSQbA/Z/BVuVsMqnisRQs=;
        b=Nj4RTrxg0pEDFOVQXXBRrYHUGVqlyOio/Qr1x6elE+hrrA0k0WF3HiZBX0FvgVGvHZ
         HNNsFkKR33443N3rJ59zYRyeZS6MIr9lOeROl2Vp8U6U82/MkXdLHYxxvk52qmG1sKSf
         sRPQVxDdPWMlz3X77ZReyujv2DTj78QvKbgRTZ5kwfGlaiOADB7ZeExnfAiP1q3IXNtV
         7KN6LwVRbDWKzjAvADdoVxHaeQNiS0xsY09r1k4Dc/wsGNqqg9MAFnaAHXfnLKmPIAoj
         hV1xZ6whDqLH4K8Qi9zMNZSIkWRH0TAkYyEVwe2RgD/Lwp5HWB7WrpDMuAZ3a3OiwKEe
         fBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721648918; x=1722253718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEQhJ8RmyEK4utl0P1w5rhlSQbA/Z/BVuVsMqnisRQs=;
        b=Hm69Hcu6kd30fVTDUc5fRixfMZhAk0X51AmU4wtGCrD8XK3xAKIp2Su8VKTMm90320
         eei28s/gqDnfQSm8N/vmz67eB6MvbFsM65FX+hypZW4s/3vfWVWIDxw2K6rfBVzTP0fj
         yl3ByQFs7JVlpo81Zzph9EokJDv42R09PT+aCc1HF4O3ASu4gelr1rSo+6i2BLyAUq2T
         Zo/nOFj3D0XzlabWC29sTfnWnmG9OsM8WKXZgEuIw9X+hnFlKxgu2HK8QAU82Rmk5mHZ
         Z2zcLZxZYQUciwhSBlirwtvGmVdL7QzQ04Rw3r7te3PFLQXTwys2AHntgDZ71nyeEq+L
         TFxA==
X-Forwarded-Encrypted: i=1; AJvYcCUFHTDQm/njuoo6GBXiY2KiDrKRA790TGmAe0OUrMofB8tao2J4ypvtzYAzqFnr16zQi3Ci6kedCJ9VvAjdYEe3Cjdac7YMxfZ15DUs
X-Gm-Message-State: AOJu0Yz24Yb+oz7Us1/r9pa9OrzAb1ySJ/2YIYaiP0Wd3kv3EpXWV+3X
	7YLn0Wilx4EaNlqT4Zc7gCi97rAbDsfMq8JPoGdfSDhO0SDuOQSYsWz1RbbEFaw=
X-Google-Smtp-Source: AGHT+IGKpS0nQgbe/uD9XJhIjoMoaBtib38Bga2oF1nh093dMGjT066HpoZP92R6DX5gbx4KE+COVQ==
X-Received: by 2002:adf:ce8e:0:b0:368:4226:407b with SMTP id ffacd0b85a97d-369bb2d6213mr4881462f8f.61.1721648918141;
        Mon, 22 Jul 2024 04:48:38 -0700 (PDT)
Received: from [192.168.1.191] ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa17csm125681235e9.2.2024.07.22.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:48:37 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
Date: Mon, 22 Jul 2024 12:47:57 +0100
Subject: [PATCH 3/3] ARM: dts: qcom: pma8084: add pon node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-pmic-bindings-v1-3-555942b3c4e1@linaro.org>
References: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
In-Reply-To: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rayyan Ansari <rayyan.ansari@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=rayyan.ansari@linaro.org; h=from:subject:message-id;
 bh=wD61BJEe+DtpldLoB47C2K14wZvHYpFBbqDwcS8dm80=;
 b=owGbwMvMwCXmtuJiX/SRuS2Mp9WSGNLmuQvXRL8Ifr+cN2lii8vj+svTnLoWVdk/fJAxQzplv
 T3b2nmMHaUsDGJcDLJiiiyHm76seb3dSejK9qpTMHNYmUCGMHBxCsBESusZ/mnkP75zcvLWF4pr
 xH0u/dq04Z1/k3cEr83DZ2UT/zbXSL9g+GfBzuvysn210qtahgmv3Yp+cdu+k6gs3RjiMDcm/sd
 DbgYA
X-Developer-Key: i=rayyan.ansari@linaro.org; a=openpgp;
 fpr=C382F4ACEBB74212D4B77ACA46A8D18E5BC49D84

Wrap existing pwrkey node inside a pon node, to conform to dt schema.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 arch/arm/boot/dts/qcom/pma8084.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
index 2985f4805b93..dbf7afcbfd8b 100644
--- a/arch/arm/boot/dts/qcom/pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom/pma8084.dtsi
@@ -19,12 +19,16 @@ rtc@6000 {
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		pwrkey@800 {
-			compatible = "qcom,pm8941-pwrkey";
+		pon@800 {
+			compatible = "qcom,pm8941-pon";
 			reg = <0x800>;
-			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
-			debounce = <15625>;
-			bias-pull-up;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+			};
 		};
 
 		pma8084_gpios: gpio@c000 {

-- 
2.45.2


