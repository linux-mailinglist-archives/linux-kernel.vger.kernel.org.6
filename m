Return-Path: <linux-kernel+bounces-258928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFDB938E98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37CF91F20F16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2916D9BC;
	Mon, 22 Jul 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxr3wQE4"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61BD16D4C8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649462; cv=none; b=QZmmg8noesWiFaKtMMTn7YQ3CqOBEAmO764QG9oK3XKWWE0O3xifnBKAwOjOYJDOR0JV18SzmvQGyB4DerRqbDlFoCk1UA+q3LuO11ieF+W4+m8qyxyYH6f5TofaU1hGt/5lyCrwBOdQdT+8rkQ1bLXWpGAFdgEM9HpIf5e00Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649462; c=relaxed/simple;
	bh=65PyLSBpiaNeTDfZNz0O65PLI+c0PdBCHqYf5aTIRpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFCYQxjjcqBHMsFnPZjUlP75RYBl9ff8NJl60lz4VPnO3AR+o63lONkAC7aE1/BfhDOiF8A5cUd8I2aksZeRJa6bp+XGnCBCLb6kiQa2Wbmm4Bb5WNRNoisIPjgTTVI6mCDsGfKoFuK0TuLmCnPBUBVIcS9aImFr2srDqPC6JY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pxr3wQE4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so12365291fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721649459; x=1722254259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqvhj+qMhyZfOAH67003wNl8OKNkSRS5rpgVLzYzc2c=;
        b=pxr3wQE4NIOO9+K/nTbhx68zHtFGMBtpL/nY+HcWCxbUhI7OrbJ09L2Kw6xKFdd4Jq
         dto6dzxgDt5VfokYDndwb03rq7Y+5V7AtcLlnB3m6K/grN89XqwKnFuivE4VJdLdySbj
         bBpB7H9baVcuHl31OEPA2bexsS4B+Mo6c6CACldcsVRJ6wQ+ptRpxyxbwBRwD19LK8b5
         nImSMx9qKscfObO6bP9RjRstfKHvbA6+UJZ0EKFubco+VUFTiQ39V1tpNBamFwshpeK3
         7tGw+d8V2ebaSJEih1QwcE0/wzQFsi+ps8Z5+PTohb+TxGDcxO8pygIAOfPUkEZSM2T6
         my2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721649459; x=1722254259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqvhj+qMhyZfOAH67003wNl8OKNkSRS5rpgVLzYzc2c=;
        b=Na9j9PO5o33tVGG7zcbF1ZX/ULIIrYtbW+F5oqHIm+GyGKKVSgqfYtEnbr7thc6PZf
         gbMsXE2d6dHmdZyyT2TNNx6zpRyV30Z0SuKiFD4VyoalsdXZaiAO3k/uioX2190IlMxl
         ecdhHkxcD7sPI/2FBmQPfhBf+JgmX0w9Gj2MGtToyRuOQVod2IB5DXajhPlJWticrp6i
         f4HPKa4VcZJJux8LEfizgNo5qmyQyK82vvKThzd2IiJtpvQSA/ANVjneJydxAhyZ9qzu
         79QEpYx9fpBoGqz1Ut+fMm04KAkV0RKkQGrpspWT5XleYcSvalGMXQS/6NnQVs1VuGRH
         jPbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/hFgO45/f3Uv+IEsCHt4PmF7GiUH1cyYI0Oq30K7JamQkVxPXW/V/DWjF5OR49B0iUdjuwDiXjTNnePSmINjkvxVYh/Ke+tK6odGm
X-Gm-Message-State: AOJu0YwkMxTasxKRwaBxmlHui2GzC0bBT+3jRI3GUgPBGv93ckKfvNF/
	XDSLkiv3ooca5vS63EJmVXJgEIgE3XbT7Kscjov51OmmDl0Jrt4ud5gM2e7oDdA=
X-Google-Smtp-Source: AGHT+IE/ny8tUH6mP6jdGMZsIr+Mn8V+MYLbUJ4BAP2qqfNiF92XD6zyQeHNLMtH93ZNcO1fqSKefw==
X-Received: by 2002:a2e:9811:0:b0:2ee:8c72:36d8 with SMTP id 38308e7fff4ca-2ef1685dfcdmr49230191fa.49.1721649459116;
        Mon, 22 Jul 2024 04:57:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef0fd10bffsm12449611fa.134.2024.07.22.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:57:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 22 Jul 2024 14:57:20 +0300
Subject: [PATCH 3/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable
 VolumeUp button
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-miix630-support-v1-3-a6483cfe8674@linaro.org>
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
In-Reply-To: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=65PyLSBpiaNeTDfZNz0O65PLI+c0PdBCHqYf5aTIRpY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmnkkvJKXzztfFqa65RT6QOZKsipXphRR5J/ETv
 XLjAOb0wZmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZp5JLwAKCRCLPIo+Aiko
 1fofCACr5K4Ll1dsx+nFBh69IgXhzSzxiI7ZCutdL7qo2mb6WiXz6b5Dp9+kvz0x5D2kpB5j/54
 9ef6UH2oJxpLfVXoruzemy5R4RLVqTgo/O1vCS1ODu392aUsCn1b0j1xwvlfOozAEG+NaxhOtJp
 y1RQzWYAarATaaxG4mlMkt1Utb9D/I7sLM2CFvAGInBUuXHU4MbnuMFWp7n5FZwwe+ra2lC0/mZ
 eTZzJGSEGCHpNlye77mddooH3dZAmbmhGfHIAUNzPJzPWe0Ch1Yg4JR3ZJgiIz8QB2gSy/CwKyK
 oZM83+8+atu088NokYAPwSujVioRVNap84586kLxMKzMgGVt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add gpio-keys device, responsible for a single button: Volume Up.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
index f585bc8ba2ce..bca309ac0cb8 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
@@ -3,12 +3,27 @@
 
 /dts-v1/;
 
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "msm8998-clamshell.dtsi"
 
 / {
 	model = "Lenovo Miix 630";
 	compatible = "lenovo,miix-630", "qcom,msm8998";
 	chassis-type = "convertible";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_pin_a>;
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &blsp1_i2c5 {
@@ -45,6 +60,16 @@ keyboard@3a {
 	};
 };
 
+&pm8998_gpios {
+	vol_up_pin_a: vol-up-active-state {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/msm8998/LENOVO/81F1/qcadsp8998.mbn";
 	status = "okay";

-- 
2.39.2


