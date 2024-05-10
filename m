Return-Path: <linux-kernel+bounces-175777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5188C24D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2741F255AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FB17084D;
	Fri, 10 May 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="qDiGUUcG"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33412AAE9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344043; cv=none; b=nZD2bRKcNS7N0hR+739g63Sf4P8QUDywdTmWq1QCPrBeQmbAvBy9r3+YaqMi1YWcz76LlJLxcWACKXWmlZMkxSQEAKkiRnD7eiz8gEDX1hvhyhPt+aWNjDSVKs95Ij1yrh+rjnQ5VO1KsILKZNNmAvsvPJ6ZoqQuCybmpniXWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344043; c=relaxed/simple;
	bh=fVRg0B+SoKGyQZjZGM35V3zycwmERzXO4crppui7oW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt/zJvFDrX7kSpo2G5J2FuIMAbyldm2CmK73wj9cROohPpnNOHRzR5ArATVS9HNfOu+IirbGLaAWFciwccE7R1iQXpMyVO7+QB4JqweMaZ3AX+4/HJ6A6GGOs0C7hEsj0SwbvHW2z491PZcjFeUYwVvS6l4T4qqrmInHZrPr+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=qDiGUUcG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c448b44aso509696566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1715344040; x=1715948840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mcIqLuJJPw3GiMJfbLNtSKUQP2lsFTPw8ADS4mj8Dg=;
        b=qDiGUUcGQPj4ZkBovTn1ywv1ie8jJ/zs3nfLD9y9YMa1mbgHpXAs6QluP9ktsvPsFS
         MtARIyixoIgBs7OqyJPVf2sT6nY1d1GpPY26OCXfgE6OypaQBp8CN+Z7JhsqKiNY/+9d
         aS1vDujZTDQsSEiQZTcO0Z0WOb6lzNoxDMSJvy6MXnCmLuN9401DfRGxYo92BhWtSb21
         PFvum/MrdSz9tWpoGGLUfX+HxWzNaNmurPZRZW3afngozUW7ZQ0SPZsoVjy0hDA7NhJa
         XIRDVdHlr/i/xalkBlloSfsumr07KiVGIO4WZGvEjpgV+3jlaIMm96QT+SbcQNdVeLGT
         UO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715344040; x=1715948840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mcIqLuJJPw3GiMJfbLNtSKUQP2lsFTPw8ADS4mj8Dg=;
        b=GL1uFBxIY5qrziPb9Ir4D6ivwJVgZSwzuxgwfb02Bf2cBZBAIlqfwes1zxM8IgvSSg
         Rr6pEzq6ux6XAz7Fe1JN27e4ju1dZE+wGZRuGOJ2GfPCATsyzEbEhoydrVIifaswr/1v
         //H566vgG34EsXen+pwQ2me5ZVSvhz6xNHF5yZwxgPx4NBw22GEjzsrAJbVpQR/h4n8r
         ugWUsgrJJFMQ47R4iVguRNJAalBCeQwhN9pQsF1e0UT0CAf3YzR81zfYd8dUkIpj60Pa
         EpLid6E6WHbJdKRrSCk3sdB2mmQCFGQUiMR5v2CX15Iv82tflr4wWlOJqJuwWHOSDEvY
         ucUA==
X-Forwarded-Encrypted: i=1; AJvYcCVKEcHwwQ+jGi6W/mcbq9xyn+bgxQwH+ANwhXg8sp8eQtv7V+xd55OVceGYsuhNySo8TPbYqNfGIg/VnpAu57PKRe+tX64FxxG3sXrJ
X-Gm-Message-State: AOJu0Yzz6NRP+UBatOyOrseIL8FKtceogg2YYwnTViQdob4on+4sbz0H
	6AueJW9uDd26gLzsu3eaK81odWI902B8U7UOIB2+pYSmMwCgkYHPz+jD7mJ44rA=
X-Google-Smtp-Source: AGHT+IHRZ6F9QRbCi+Ce6mddApr315w18te4B3o9cg98Wf4XxL2oksDu0esFm+ifb+xhkWK/GDdzIA==
X-Received: by 2002:a17:906:3c56:b0:a59:f380:1823 with SMTP id a640c23a62f3a-a5a2d66b493mr165210566b.49.1715344039844;
        Fri, 10 May 2024 05:27:19 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (2a02-a210-20ba-5a00-9ceb-707b-2d57-26f7.cable.dynamic.v6.ziggo.nl. [2a02:a210:20ba:5a00:9ceb:707b:2d57:26f7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b017b1sm178043366b.181.2024.05.10.05.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:27:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 May 2024 14:27:09 +0200
Subject: [PATCH DNM 2/2] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 DisplayPort sound support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-sc7280-apr-v1-2-e9eabda05f85@fairphone.com>
References: <20240510-sc7280-apr-v1-0-e9eabda05f85@fairphone.com>
In-Reply-To: <20240510-sc7280-apr-v1-0-e9eabda05f85@fairphone.com>
To: cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Add the required nodes for sound playback via a connected external
display (DisplayPort over USB-C).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Depends on a bunch of patches upstream doing bringup of Display (DSI),
DisplayPort, GPU, and then finally audio could land. But we're blocked
on DPU 1:1:1 topology for all of that unfortunately.

And also machine driver for sound just exists a bit hackily.
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 05bbf1da5cb8..2bbbcaeff95e 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -14,6 +14,8 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include "sc7280.dtsi"
 #include "pm7250b.dtsi"
 #include "pm7325.dtsi"
@@ -774,6 +776,12 @@ &pon_resin {
 	status = "okay";
 };
 
+&q6afedai {
+	dai@104 {
+		reg = <DISPLAY_PORT_RX>;
+	};
+};
+
 &qup_spi13_cs {
 	drive-strength = <6>;
 	bias-disable;
@@ -847,6 +855,34 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&sound {
+	compatible = "fairphone,fp5-sndcard";
+	model = "Fairphone 5";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	displayport-rx-dai-link {
+		link-name = "DisplayPort Playback";
+
+		cpu {
+			sound-dai = <&q6afedai DISPLAY_PORT_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&mdss_dp>;
+		};
+	};
+};
+
 &spi13 {
 	status = "okay";
 

-- 
2.45.0


