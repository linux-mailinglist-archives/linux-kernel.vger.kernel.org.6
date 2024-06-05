Return-Path: <linux-kernel+bounces-202860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968698FD1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973111C22E53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178814C592;
	Wed,  5 Jun 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcwmId/s"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F661FE7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602371; cv=none; b=ceRS0tB0Mhy8S31cUfU6u1Yz2hI3VKF7nyblQgmn55gEL/tFpYeccRHeo6yq95Jfz+3wLVEFF/Kf39zcdiyca3mkFrBNmlb6f/SG/X8MLj9M8rwg/g5551KMPWfHjFoS96wrWhpbbUDshcatwJovNQhGTKChNvGQerRvMCOJhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602371; c=relaxed/simple;
	bh=rGN3r4WEOwjURMC7okauif1dbYoCUx19KLivnKcncgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8VQL1BkS4hINPHKn48Lfms5foRjsT5xiYO9jM68AUO3YiDYwyyMQvhdUMiGGNEUYbdsBLXf1r1AjNzuHT7sybabsH0XGnGgatYuCysCd7epY3QC4PyurF+0t5b1+F27oW0+H7BWPkJjcVu45onGuyCpLL6n0hxXhdVzyjDG+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mcwmId/s; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35dc984b3d2so5210426f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717602368; x=1718207168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9rBCfBezDeI8/lC2JFYqfnoXfJQKZRJOb2ugt/ZxY4=;
        b=mcwmId/sRZpyUP9TZbHDgEA6NbfH1+p5NB8a9U+7UHY9diwig/lkz2EPm4oyhHia1H
         5iPW7jIDpv3yTaLc02kh0AcVNN5ZO+taBbGGeU5da+b16wCpuAtXHIBUPpvyFPApARq4
         g7ixf4vaBU2j+kJoujgicWwQasyTXqiFLG9CfRkL7MgWAqVYjVfRSx8pq9f4gnQASHgF
         pxDqwdvTP99uXBm7sCaXOnylOCpbT5j0rdAjPvcbfFsjk03QQXQweVJQLpfY0QIMYcO9
         Tm0MtVn0pfPGDZIyIpoAyyGDgJ4BD1TlCloygM/MKqCbBEa0CqcBm8e96IDE93kSWWI3
         NGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602368; x=1718207168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9rBCfBezDeI8/lC2JFYqfnoXfJQKZRJOb2ugt/ZxY4=;
        b=lq80dhCcbmV/1b/JcaCDiOiGa8vz2Ne9nVO+lc7ze+krrObR0Eu5S+7IWdXikwRBrB
         qEXyuGXn4RUe3zU9vQSe6nD4tH84SY4kzv5zBCffUGdC+RF6FPhZ9LW4QIYN1BH1jB6r
         rqMcLtdZEyn+4VFjkE1whvV0YSwV9Co9khZXObKcyKORJ+D241a0vx4H5tqdpPdHOQ26
         i1uT6L7XmV73fGZKBFsddQCRXAOU1bwj7gt/KlPMklsdfzmRDMTQz7mQ1vnvNkrVwuLF
         ym2nAyzJAfV7R+kqQIh4utATm6DmSdjR3fL+VTp4MlQmlgyHfoAcZQS1NuJcEc6qJoYE
         7n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFtw5N25flrR1XMa7SA+ffKTuq33JPCva9k67cBRSIMb6lPluwevEqIgWL+fK0lwf3DXS7yvq4XJT+kYdG9MyttHNVE0mA+IIaJeGb
X-Gm-Message-State: AOJu0YwiOEZrr8cpM1UJUJoc4/+ZlrLif5+GKo96fnuRpHiJop3mj6RX
	SWc5SxAM/9wz6c5NEjTuyYgpZtukvnwY0m+zMf4xy5nlgMHZ0cViWT3eTC4BBE0=
X-Google-Smtp-Source: AGHT+IFf/VMwsZzJQun9mFkZhrd1Q/wkG7tQGe8G9jlXLLJdVl1MFqLMciBRZUNmGARwsbCrFxikEQ==
X-Received: by 2002:a05:6000:114a:b0:357:393d:5006 with SMTP id ffacd0b85a97d-35e8406866emr2329535f8f.7.1717602367955;
        Wed, 05 Jun 2024 08:46:07 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca981sm14868452f8f.33.2024.06.05.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:46:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: use defines for interrupts
Date: Wed,  5 Jun 2024 17:46:05 +0200
Message-ID: <20240605154605.149051-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hard-coded interrupt parts (GIC, flags) with standard defines
for readability.  No changes in resulting DTBs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 8 ++++----
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 8 ++++----
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 8 ++++----
 arch/arm64/boot/dts/qcom/sm6125.dtsi  | 8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 9949d2cd23d8..917fa246857d 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -1093,10 +1093,10 @@ gmu_sram: gmu-sram@0 {
 
 	timer: timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 2 0xff08>,
-			     <GIC_PPI 3 0xff08>,
-			     <GIC_PPI 4 0xff08>,
-			     <GIC_PPI 1 0xff08>;
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	vph_pwr: vph-pwr-regulator {
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index d591c83e4bac..26a0940d42ec 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1531,10 +1531,10 @@ pcie@0 {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 2 0xff08>,
-			     <GIC_PPI 3 0xff08>,
-			     <GIC_PPI 4 0xff08>,
-			     <GIC_PPI 1 0xff08>;
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	smp2p-adsp {
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f5921b80ef94..f202c1f3c89c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2601,10 +2601,10 @@ gpu_alert0: trip-point0 {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 1 0xf08>,
-				 <GIC_PPI 2 0xf08>,
-				 <GIC_PPI 3 0xf08>,
-				 <GIC_PPI 0 0xf08>;
+		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 98ab08356088..777c380c2fa0 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -1588,10 +1588,10 @@ intc: interrupt-controller@f200000 {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 1 0xf08
-			      GIC_PPI 2 0xf08
-			      GIC_PPI 3 0xf08
-			      GIC_PPI 0 0xf08>;
+		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <19200000>;
 	};
 };
-- 
2.43.0


