Return-Path: <linux-kernel+bounces-319789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B31AB97023C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1163DB21858
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503515CD60;
	Sat,  7 Sep 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CARVvijV"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C0315A86E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725713493; cv=none; b=mq7cJ+h5YN/iW5lIA8DYKRTUAMI05tOEf7HzDpejqhDLZcRp+CklT+A4tpJvueIRcq2v61QzCddzBadgwrDK8B3omw5/2T7KoU9WlUm9mVZbAspYe0rI2jLIan4VgoIzcsiyc3Ct5556gGgeLuwPAkq+HORukeZDEIcPXafRt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725713493; c=relaxed/simple;
	bh=FbPPcJdW+bGZLS3YmzaJ6IJk8UVJuYX/re+7WZkDQ/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TH87XNH046+ZndFdi4j0m77MHY/LmC399VHoZk/fTBRO2iQicW9EOVTjoFG3heQim1N7F4gY6VgEJMcDHItJJdkwliu5EEXlAZlfMMAL7piG1NmqH5OsMTftvoK6d5r87l6MPbbCzXtse4hhPcWF2513PE7eStcS61TKkIxJM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CARVvijV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53653ee23adso2734225e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725713489; x=1726318289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDVo3MzAbIx6b8jRl8MquzPosSeypNFMkHTbgKo5XqU=;
        b=CARVvijVXa2dZuc5gB/SOKsdP+Ps8/kUNw2DobtfntmxcCgtrYawksyu9flxXRJiXg
         GmIojDTagh0IeTU/KTaPdXkZT4RFxeB+AtqVGIYZ7ckKoM3qHSGKBPjNyKPTsQld5BkE
         xuCim39ZO1mk0Qz0HGl90WNgzYDsMFPLQ9gJpbuLf9mSRL2eKfmWPKAHo5k/MaLoTzhF
         8mG/qerwofenk5vITp56YOxq8Je0WkLUlTLLsr/I8adGyV2wXfbgsr67m7MkYa5PMn5L
         LlPmdgTJfQ2Ufy+2XMAaMJHzHyYezrXhcVDmpB3XTmsbTHNiTh2ztBj3TZEK97AEokUq
         mOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725713489; x=1726318289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDVo3MzAbIx6b8jRl8MquzPosSeypNFMkHTbgKo5XqU=;
        b=vMPQmnDHcFj9H0uZKPnZ6V/AgnjWk7+VYwHn8vBT412sXQdXn8uiTBGBQNLpRxzbZu
         fKM8Y7VAT9oRgntmpH75uzAuMnjuT5IVBksrjBujeMWYgT185+CY4AUz6s36ZHiBhFBK
         N2P/NeWKWDW318UufrKw7k2y1QzFELqvB6KWfzm4TPiyrkF6Brex39P5MNCh3/6phBbu
         5MsOJexPqegQO8YljvoGyfZmAEKP0GorOIA6jdliMQEBVK/SriuO6hqzaYNNm8Y71Tvt
         K3/5jIcAuvn39otOz2llaUs4ttqyyLbhUNI/Ha6m3wVwe2WsApkILAQ9R+eDcD0PDlu5
         JFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYaNTCt8UrMZrGYwUPXqo/5xLcMND40pBWHbFqGaQX4vGmqBAhjF+Tdil/Th7hNa6hl5kz9JUkFTLtr/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9sCwT/nLjhQbJPZOkrf4P7U209kY0bEYzGC2CmOaCTdaY9iK
	K4JEJfwDf+VqrFMPALFRWhNdnLQMXd2mSiBkIkjPrXrCCIq3la1RjrNtu+XbrDw=
X-Google-Smtp-Source: AGHT+IHYhOhBbWnaWxKu1B6sRwgfi+J4mqtxWE2mK7NioXQgNA0fa2p5fmbAFaz24LShWrvq9RJEOA==
X-Received: by 2002:a05:6512:230f:b0:530:c212:4a5a with SMTP id 2adb3069b0e04-536587b424bmr3171930e87.22.1725713489140;
        Sat, 07 Sep 2024 05:51:29 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cb76fsm143273e87.177.2024.09.07.05.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:51:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 07 Sep 2024 15:51:25 +0300
Subject: [PATCH 2/4] arm64: dts: qcom: sc7280: don't enable GPU on
 unsupported devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-rb3g2-fixes-v1-2-eb9da98e9f80@linaro.org>
References: <20240907-rb3g2-fixes-v1-0-eb9da98e9f80@linaro.org>
In-Reply-To: <20240907-rb3g2-fixes-v1-0-eb9da98e9f80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=FbPPcJdW+bGZLS3YmzaJ6IJk8UVJuYX/re+7WZkDQ/o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3ExNHfwvG2xRSUHOPqEpZ3U0lGm9qvDVaT9Am
 7z9t31HcxuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtxMTQAKCRCLPIo+Aiko
 1WAhB/9dfSLAlTO6T6tKYBoQDsYSMcwEFFPwNVWJ8PcJ/4VMgKYxMPvpsG+aWX9tzE6uVEt3KwR
 Mq4yEkqFRVZYce96kQnXCCcGXdpqAhXl45WVb2DPZJZE9cpXGwz6GRbJil8k6eBOX50ZdIaorsj
 trf979n1HP4DV6ZSfp5s5Tt0cQYL/2Vxmk23pBt4XOwB7tXrXT1DSeBrXoZuZoDmZElxFFNuJHL
 IG62QaY9wXys9EeqLXR0LJqr80musX1mj7CzSmmga2K8b3c0YeC9uKLyQDNIiMMFSCZ8w8fuDwU
 UEUtVd7HIv+F8XITz5s/B0X5N4T0YKO/DWRCqZViAqAGYch2
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On SC7280 and derivative platforms GPU by default requires a signed
binary, a660_zap.mbn. Disable GPU by default and enable it only when
the binary is actually available (QCM6490-IDP, RB3gen2). ChromeOS
devices do not use TrustZone, so GPU can be enabled by default in
sc7280-chrome-common.dtsi. FairPhone5 and SHIFTphone8 DTS already
enable GPU (even though it wasn't required beforehand).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           | 8 ++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 4 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 2 ++
 4 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 84c45419cb8d..c4cfafb3ec15 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -499,6 +499,14 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/qcm6490/a660_zap.mbn";
+};
+
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5d0167fbc709..00b755779608 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -557,6 +557,14 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/qcs6490/a660_zap.mbn";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index cecb3e89f7f7..eb5e32035d93 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -56,6 +56,10 @@ &CLUSTER_PD {
 	domain-idle-states = <&CLUSTER_SLEEP_0>;
 };
 
+&gpu {
+	status = "okay";
+};
+
 &lpass_aon {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 3d8410683402..fbdc9c19242c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2823,6 +2823,8 @@ gpu: gpu@3d00000 {
 			nvmem-cells = <&gpu_speed_bin>;
 			nvmem-cell-names = "speed_bin";
 
+			status = "disabled";
+
 			gpu_zap_shader: zap-shader {
 				memory-region = <&gpu_zap_mem>;
 			};

-- 
2.39.2


