Return-Path: <linux-kernel+bounces-176749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371008C3465
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03C61F2174C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73353E22;
	Sat, 11 May 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQiFTy6Z"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834F36AF8
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715465055; cv=none; b=L4qLm9n4Fs857Zk48KxVcxjfmNwbppWu1/uyYyjXwuZo9gD88xqDffLzzDprlrROOJC1SGUBr9zySBvy3Oa7F953j6YKjfqrCMb+BZgaIt60Vimk+EX3E0rRK3r0x+TSc5HmoOBG1z5iRsXgP+Evk22KABdsiWz0chbBFPi8YmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715465055; c=relaxed/simple;
	bh=Xy9PldcR183DRnBL5409rKkzxlfVFfpBt9Qkn4329v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bdtw6XmyUturfqE41LiftciLHbJY5KpKOCLEJhg+ItqsL18GoxvPn3wkhQIxUiOOZp1dUdkZAmUlywlync7Y5Gt1Jjg8IeUfhAR3XTTcQkz+vGNcknMyXjDY50THVWMMhfVQwr4Ne/UncI864sxrfJBa9eN8pSw05K+26ZTx4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQiFTy6Z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so2940736e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715465052; x=1716069852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NiTVC0ap1sbMmX+P4azo73mVUt/soqEHYFiWewJv/E=;
        b=qQiFTy6Z93EMH6MuhQu1OQ9VE7kkwcd6fK8nc2CkKPkcBmge8hhBcJnNZdF1scpPcJ
         VaQgiVJsJVJ4v5iH/e4NAh8tJy4Ds85H86guQm1xgj7cskGkxAUT1PBfyuOlUwVSfbB1
         ajJz2sSlnTlRwsNd/3aOn80Gg4IP7nun/Xk2BoTJeBnar2XpAKY0ReHcLYjnDxw8fkm6
         gVuJXOAE1cGQhR5OAMR6ak7L7Ev9GqSHqd1vCoRU2XsGMTde+Rj/QTdOBviPgKAKBbvc
         k/BY/WcO5cEvW4N5V4Ao7K1M6ZsLH8kLPy4nU5MNIC9p5GqS14ijA6wfUf/tjGQ3nvjl
         Nv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715465052; x=1716069852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NiTVC0ap1sbMmX+P4azo73mVUt/soqEHYFiWewJv/E=;
        b=deJ7MtFDGH8YRAJUTs1K+LBKRQ226CRJq7/kKoek9jW8wUtTHAywSS4aUNncXoNOlh
         Qj+/mUlrqF4cLEt89etoo0a0qPWTlNmlV1t+BuT8S1V4TR3tY9dV2BCTqLF0OdW3hTeG
         bfFteEBEvSFHrX2reVWsGecjR3Pw/B9grJhOIPqyvJ5LTAzf17qkp7F9JyiEEDimyFvb
         2jGhAo7RRG3UWup2YfOWn+EcVXBXX9ErkjAyWMIFpAmcEqLnKN5Q0/J71HKB2b0rLUCI
         XtDyPlGun0F8B2Ei20yk7JAE8IoHNVWSsF3gf/kT25z0Haidif5JF9K1RCSnico4rKX+
         YK1w==
X-Forwarded-Encrypted: i=1; AJvYcCX7eo3owu2uFC2oQB8cyYrhz6Z+ftH842UQSvWEqpl3CmMk7/L/Vea2Gc86CyUMv+ELIPsMj3ighnxi21ozHozcBA7kC3i9Qru5vmE+
X-Gm-Message-State: AOJu0YxA/HfJIordrfaImeRlwJKEnEYQ0zInLtra/7si6eMEt6qdh33F
	FNE4RXSPRS+TV7rK/OfjPia3Cv1rm6g862j2ytcxDBUpTJ+zKVl8aUBqg71wgoM=
X-Google-Smtp-Source: AGHT+IEz5IPOIfCDmcunyW3gkasjS/UeOuHKyWwCEW7bEHsz6couePyR36Hvo3oJ0/6OzwNn4Jrz5w==
X-Received: by 2002:a05:6512:2309:b0:51f:3e41:efd8 with SMTP id 2adb3069b0e04-5220e27a2ccmr2259688e87.1.1715465051765;
        Sat, 11 May 2024 15:04:11 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d878fsm1123875e87.206.2024.05.11.15.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 15:04:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 01:04:09 +0300
Subject: [PATCH v4 3/9] arm64: dts: qcom: sm8250: describe HS signals
 properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-typec-fix-sm8250-v4-3-ad153c747a97@linaro.org>
References: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
In-Reply-To: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Xy9PldcR183DRnBL5409rKkzxlfVFfpBt9Qkn4329v8=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5r96/DeyuzcYMY3y9mPm9cVcx+9XqHY2r4uilGS939D9
 tXa1qZORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEzkqgoHwyKOrbUsTxKjfyfU
 ads9W3QualfKvEsnbkleMN3f3+QtLc90cR4b60HOikv71/K92Md04j3XJuEFDo9Lko4ukdD44XH
 k0TSBgq02UVv4513f7LXbJEheJHahe0SHifZ2rzIzQ//ft7KMf6r7zzgYVsMkUz+/JzNaW1N0Rg
 mXTsy9NTEcapd7g716P+qtnDa573H0lO6VLvW7G5UeVaQZJK/PuZ6QWBamldvLcqGXYylrXemGZ
 RdN5r3s/vPa7klK6aE9e2wyBZwuOl493PMzeQLj70tWC9T2P5RMOSr3wV6CZ4rkX4/vIWc7Dp7U
 f+fA61B9RP+JjdgZqcgC9eATwSu23IkJUG4zqZ0QmXEMAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The OF graph should describe physical signals. There is no 'role switch'
signal between Type-C connector and the DWC3 USB controller. Rename
endpoints to mention USB HS signal instead (this follows the example
lead by other plaforms, including QRB2210 RB1, QRB4210 RB2 and all PMIC
GLINK platforms).

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                 | 8 ++++----
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 8 ++++----
 arch/arm64/boot/dts/qcom/sm8250.dtsi                     | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cd0db4f31d4a..44239d1e57e9 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1356,8 +1356,8 @@ &usb_1_dwc3 {
 	usb-role-switch;
 };
 
-&usb_1_role_switch_out {
-	remote-endpoint = <&pm8150b_role_switch_in>;
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
 };
 
 &usb_1_hsphy {
@@ -1465,8 +1465,8 @@ ports {
 
 			port@0 {
 				reg = <0>;
-				pm8150b_role_switch_in: endpoint {
-					remote-endpoint = <&usb_1_role_switch_out>;
+				pm8150b_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs_out>;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 41f117474872..3596dd328c31 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -659,8 +659,8 @@ ports {
 			port@0 {
 				reg = <0>;
 
-				pm8150b_role_switch_in: endpoint {
-					remote-endpoint = <&usb_1_role_switch_out>;
+				pm8150b_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs_out>;
 				};
 			};
 		};
@@ -725,8 +725,8 @@ &usb_1_hsphy {
 	status = "okay";
 };
 
-&usb_1_role_switch_out {
-	remote-endpoint = <&pm8150b_role_switch_in>;
+&usb_1_dwc3_hs_out {
+	remote-endpoint = <&pm8150b_hs_in>;
 };
 
 &ufs_mem_hc {
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 8ccade628f1f..0ec473ceb3d2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4226,7 +4226,7 @@ usb_1_dwc3: usb@a600000 {
 				phy-names = "usb2-phy", "usb3-phy";
 
 				port {
-					usb_1_role_switch_out: endpoint {};
+					usb_1_dwc3_hs_out: endpoint {};
 				};
 			};
 		};

-- 
2.39.2


