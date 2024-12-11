Return-Path: <linux-kernel+bounces-440920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D634A9EC678
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B40B188B9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92441E1C02;
	Wed, 11 Dec 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUx7rkPH"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172A1D89E5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904207; cv=none; b=Z5b03KQ8ZTQCbP7TSLmElUMIc0159kZ5x2OWX2hsKMPR2GCS8rg4gtZNawxi8Z7M+PG5cX6Zs4iJJ2JRYcyZ9+dkELeXTl74MShlafE81KYBFHrhyXKLDujuL7I/qTIEy5Tk7NVqMf/UTOv86PSmS/ptRlnr6YzX6CteJlnnKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904207; c=relaxed/simple;
	bh=HHt/umcpRq+rs/P2wbiPKSdjqZ1QwYbx9ZVZDypcOTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=krJe/11wDHjSPgjgEwUgv5vY5yXhSf8OoPWGLSel5wN+xXHyTYAtfyI5WW/UN1fTmOh5lNM6lbchz0WJEPxK7LwV0wtJylSp9h2NjH/ETxbbwDU9/M5a4VrtjK0wPwMmn2wcHKMVSg1MJEFIvzhcKEZrdj8zJTFWpwjea1Vkt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TUx7rkPH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso2048435e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904204; x=1734509004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVKyCHkPbEDOof6AiuTgileClIawd2CAXyMde6tHgVA=;
        b=TUx7rkPHOIsMZ1M2in+cRGCZFY67M5cwd/6xoXcMJR1jJfahredynf9l5yx4tJ2iIy
         GxrVeqZL/zVEaf8D8WXplncdJAJ+yKSdEHP5hjCDzNjblQY+Pjk3uIZGqZ2Jm6Xy/7zC
         emrt7vF+82HlD0lsC7X4KTrxFCLCLmxdOwqfC1PiV9KKBQfBA8FgYWbzDXfWelksUXE4
         mk97K1fvkz6LCev7tAMUWcQDue8U0TIiDq7+L9976mA0RUZ1kPgsGWM43qVW0YnQi5hU
         J3BaUhxXIb0yMe0LD//mDMR4C791B1Hu4U8FOtb0CGZNV755t/oM5XZdNgvFjwIl1ZXP
         k7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904204; x=1734509004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVKyCHkPbEDOof6AiuTgileClIawd2CAXyMde6tHgVA=;
        b=WnpSDVLml36ulgCNBu0PNv0CizerDHRVA2B+nr0yUrCJtHua5k4aljZJa0Erp5l/p+
         88zW3rx39P7B+mn8I3ivUH2MoF1Kt5+66zSlawNyjPUfwE5tlo9x3nrR7Cz/8iX0Kp0R
         wpR6j6idd1Dg4nnmgpIyWFIGnjUb8WNDe/jaD9lJIxiyFcfJCAuHVNQcCTXITr5NWTDG
         VABgQDYTqd2B1blaNyM8Kf4hqsVT4y2EeYFgQ0TKSTVMLjnjOK843RvPZCanOv9uc/AX
         PIiq2658w4yJ5yO7Q1CiWlrIhUxVO6KTpNuGYGfo8sLMaQxjGBkYNIZCBw/HbTRFRmf9
         dawQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRyS4BrWpkTOCx5ZVyb3V1rNswAfth9zzxgOPXPwPyqvle1vZfwQFqUPeo/mupwCjWoIEAHnrSxi01uUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxbzV0QpEt0llW4V3sMHasKUZ+4nf8+Vdk/EEisRrPrNapMkv
	2EZ0RnU4V2X/awVUVtQ0xgskiJM+dyMZzWEZLZfDA6XYo1kFjVIUULWJuO4nybo=
X-Gm-Gg: ASbGncuSVnqhULjaSG7R4HaAOrruG5kc1JyZzzQWJidwnFkp2vyIwkoEv7+gGgjQ11M
	qObt2xaaFFE5cPkWzVipoCT2H1gHXMKwm2U1iZi28uWn5kyO4vFG0KLs1mzVE7FhWeivxfj6HwN
	eYaSvhMEm+oGyQeQ2Mo5O0gicmSgJ0kr8nJ6t5R3R10p0HWAtmaHscT1l4ZEYcUJUTFebUPeyuX
	mNLvsoxeSLklGSjuQp5X5zl0ESYAXtyyT170lxi2VEz6UtXyctaLvwwviYAyPZt+GNY07406cc=
X-Google-Smtp-Source: AGHT+IGhPwcuCgM3fPvm56eRExOf/eGd1h9nJdejhG+qEfznvHAVTOQvOL8XTI5wy2VQ1Bzpe1idhg==
X-Received: by 2002:a7b:cd15:0:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-4361c80b03fmr11062735e9.13.1733904204328;
        Wed, 11 Dec 2024 00:03:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm24205795e9.4.2024.12.11.00.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:03:23 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:03:13 +0100
Subject: [PATCH v3 5/6] arm64: dts: qcom: sc7180: fix psci power domain
 node names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-misc-dt-fixes-v3-5-010ac10529b1@linaro.org>
References: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
In-Reply-To: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Felipe Balbi <felipe.balbi@microsoft.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2701;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HHt/umcpRq+rs/P2wbiPKSdjqZ1QwYbx9ZVZDypcOTg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUdEdSfG6gF/9m9deOQADrp4w5V+cGh3Ih26oQB5
 /Moyab6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lHRAAKCRB33NvayMhJ0eRhD/
 wLQqDIb0dAOMtb60EDg1nuds2TSPJFoASZDzAkVE2w/r44bLaJ0HZLrPtEwaSJ/65BfBG4/bLcOSV4
 IWvByVEzQ76AUURvZoGFmFyItgeRMoYN4cZzdfl5Z3YwBt78UU0hf7EKQ5vWYBR3WdFIKJwgvWUIPN
 I6HbFPaNkZpB1OciARrDVO8tUwxxZ2jMq4Lh5NPS0DKVtOp2lxkuOD/ZCzKTWtlx13VxlI0kJEz2cF
 qWSOCl2azitR551G0WNrUN/0KJ2bbLgjf5xYmvRbeCrlOBlMqt1c2EOMRq609rz3b9Q9x+0nKNTcK+
 HVipnqcXuUQUqFXRmrkEX/g+QECgokZIphD6uB10A6Fe0ntXYq0g1m/w6CH9vA3e5RjB0CIySKJnX8
 3KhdzndOX0gR4JUNduIVgkvXZ36xGfZTmP0QDJX1alVI1087TpvinyFiDqQrgA7/lf4nYJa1PuV/F6
 L1M/TOFhrk0b4uP7ERHxBjmlNgjgD5d03vTc1vSlmgfvoL2L2gGi9G5j3qhYmpOfPMGQ2N/BK/GGNz
 0QacTFuaGlcWtFDHw4CWdc1PizN+HcCLu4kQGjuG16tYeJ+3NqR9jMikTttcKqPHYSDHmqr0j+Fbxa
 Pv43JgbYYldBha8MRCCt+9+p33gykrZPc8RQUQ3/oga9fc/7hQq8TFHVuYAQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Rename the psci power domain node names to match the bindings.

This Fixes:
sc7180-acer-aspire1.dts: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6', 'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 76fe314d2ad50d002ee6adf4659fa685ddae89de..e7773d215f34eba9a42808eb37fac7fa1fda87b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -580,55 +580,55 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		cpu_pd0: cpu0 {
+		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd1: cpu1 {
+		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd2: cpu2 {
+		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd3: cpu3 {
+		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd4: cpu4 {
+		cpu_pd4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd5: cpu5 {
+		cpu_pd5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
 		};
 
-		cpu_pd6: cpu6 {
+		cpu_pd6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
 		};
 
-		cpu_pd7: cpu7 {
+		cpu_pd7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
 			domain-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
 		};
 
-		cluster_pd: cpu-cluster0 {
+		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cluster_sleep_pc
 					      &cluster_sleep_cx_ret

-- 
2.34.1


