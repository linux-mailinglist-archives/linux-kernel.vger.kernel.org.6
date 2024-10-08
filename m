Return-Path: <linux-kernel+bounces-354968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8942A994550
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD35D1C249C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B61C2313;
	Tue,  8 Oct 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KhAikeo/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C7199954
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383161; cv=none; b=MTR6WnMwSInlmEdGBgYQbBBTLU2Zuy77xg7XPHA+biLKR90ntDZ1Foi4ErNH3i6XF6YLDyNP8GcnXVF0RQejxc0hq0JYvZPyloqSHX57vYr//Cjp/RJ7BLB5l7A6UoatiyD3giKuqLetZSv64OESr1ndCJ4QtcIyw/QVoxsI3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383161; c=relaxed/simple;
	bh=0SiUI0XPRo2jRhetA9vyGMWUpVj4XsfNTFHURNlOH04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX97K9ub0IgLPBwctV/SLUhLuaMpiu3GMp7YqIjhXZpKXujPgfV0jTTdNdwd3qPU6Dv2ba8sVDMuAyQJGRR1Pihybg3rj0RCYOUfl7kxDrvNrUlHMHBJI5IZ3mhefLhRMI4KKvDgSqcIIsYMGLZXCWH5JyPoUzEdo6jBzdVPnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KhAikeo/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so47793185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728383158; x=1728987958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqxVo4wMuZAz1gb9rRHSLBbt62Cf0gHLCwY0eDFoz5o=;
        b=KhAikeo/YqKkMcD8IQhJKrpN0t6VQ6YjPfP3d4ooFAY9cQ0jjB9xkJoD86EteCMMQF
         mFT4QUhEDpEL7gVSfN/8aE3LrcZ4s7FiH7d4obbbdlcbxYRRs23GuJyXh5UB0y/zZDi4
         +Tn4WFJkN/WkkVRjPEhvG+sJ98Knm9Hczl1Bmd8B7l+3d7gVq+2WuoesV2asqQKviLbP
         IILMn/eElNziKUUfVtcoA4SFy7jfBdvW93DUnbWk1lMoCNx13v/sWM/WIR4M0JGmdh+T
         EbpQhED4oj9rkiGnZpthcIYGqgNhpqCJxLFR7HZqxrzGg8a4Ch0wNbeXnUt92IwWKBog
         3vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383158; x=1728987958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqxVo4wMuZAz1gb9rRHSLBbt62Cf0gHLCwY0eDFoz5o=;
        b=OZh1fVh3lVRDG/IO7l/LYrxsE65fE1jq8+Wlieck0UtCigs2vu+wOb6uXrDO0CnOvp
         8KAv1s1YQ/Pwhm8xp6/x9d04PfZOFitEQwRtLFlTbINmq88kx13vHtkOtM3phRfdOumn
         jFJizWLIW6bwvh6tYcTJ3LBKjzD8jZMHiRp7nlPjSEMq+8+cejyZyjBE7VFcM8JaeRjV
         6vT0TImO8sUesMnUL3czo5VgiO0+c8gEEZKd6tkEl3+j//D7wgi+ANKIBo38vDl5f7LG
         LKgIH8AfB1sPaM9wuLVXRlWdtKhRKpjwnwoMgCokkKRaZJDPkkKH97aGFcMn3oF37D1/
         cwBw==
X-Forwarded-Encrypted: i=1; AJvYcCWyzT9Zj2wHzKcgwN/pyLu17wtaZlL4Ju8C0rL/rwqXnjmlk3Ty+fpt0YfrR66Wzvj+mD2hdcXISewoRfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeeiSNTRaJHyWFd1yytAbpQroKz1qaSlKRWQSDuxAb9P4Vk2H
	9ZYupvulBFZFnnhaxxDbU12mCy58lKVrccSAq3knQj4sDHJeB1HWUVf/hKCw1/8=
X-Google-Smtp-Source: AGHT+IG15SkfLUfEDb3Rn7slxO3r55rCmxivf90UXngn8AYcP3vBnMicsP5TTmjDyhQH+4UL8s9sYg==
X-Received: by 2002:a05:600c:4f54:b0:42c:bde5:9082 with SMTP id 5b1f17b1804b1-42f85abed48mr114125075e9.17.1728383157858;
        Tue, 08 Oct 2024 03:25:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:738a:20da:f541:94ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691b505sm7766800f8f.43.2024.10.08.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:25:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 2/3] arm64: dts: qcom: sc8280xp-crd: enable bluetooth
Date: Tue,  8 Oct 2024 12:25:43 +0200
Message-ID: <20241008102545.40003-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008102545.40003-1-brgl@bgdev.pl>
References: <20241008102545.40003-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the bluetooth node for sc8280xp-crd and make it consume the outputs
from the PMU as per the new DT bindings contract.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 59 ++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 69326e4f5534..ccf51ca962df 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -20,6 +20,7 @@ aliases {
 		i2c4 = &i2c4;
 		i2c21 = &i2c21;
 		serial0 = &uart17;
+		serial1 = &uart2;
 	};
 
 	backlight: backlight {
@@ -264,10 +265,11 @@ usb1_sbu_mux: endpoint {
 	wcn6855-pmu {
 		compatible = "qcom,wcn6855-pmu";
 
-		pinctrl-0 = <&wlan_en>;
+		pinctrl-0 = <&bt_en>, <&wlan_en>;
 		pinctrl-names = "default";
 
 		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
 		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
 
 		vddio-supply = <&vreg_s10b>;
@@ -746,6 +748,26 @@ &sdc2 {
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-0 = <&uart2_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6855-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &uart17 {
 	compatible = "qcom,geni-debug-uart";
 
@@ -891,6 +913,13 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	bt_en: bt-en-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	edp_reg_en: edp-reg-en-state {
 		pins = "gpio25";
 		function = "gpio";
@@ -1084,6 +1113,34 @@ reset-n-pins {
 		};
 	};
 
+	uart2_default: uart2-default-state {
+		cts-pins {
+			pins = "gpio121";
+			function = "qup2";
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio122";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio124";
+			function = "qup2";
+			bias-pull-up;
+		};
+
+		tx-pins {
+			pins = "gpio123";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	usb0_sbu_default: usb0-sbu-state {
 		oe-n-pins {
 			pins = "gpio101";
-- 
2.30.2


