Return-Path: <linux-kernel+bounces-405092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295719C4CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38762854D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E9209660;
	Tue, 12 Nov 2024 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzudQ6IX"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F55207A34
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379998; cv=none; b=gnSmru4GV7yL8zNtJ5ROJtMb08hyY1GVVxI++qAoKWe/v6XUj8Iej0qUkReHC7ifhPLMMlsW/99EMFhNP9CFDi2WOw9fVxOnEfE+T4CS4magyt+figRdqjFE+esqIOmFwepaaILK2BEY1LpNgua3jJkjW85yHFlnxgjU+WpKtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379998; c=relaxed/simple;
	bh=REvlMMxx0XAJybhZSmB310utOAbwLWPvmzpZTyrvIuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TB4TZNQ5TjqhqtnIn7vFTDy96AMLyoR5TrT194q3+LJRwt9sniTzXvIOaaJrY5PZlB9lcBrcFQYAAD5OUB02ZlElUpPL+F+M48jIj87PPMSaH35flj2xi8zqeLz8nCLqvmz2yQ8QKkTSfBLRacanqiyBlwUtYSqqHcnRepPNW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzudQ6IX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so3954492f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731379995; x=1731984795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Lorw65PtQ4cm8iqjexRvk/cRJr+lEVzhB14Mwt3cdQ=;
        b=jzudQ6IXcq6zylUew8J4c7ND21Fivm26rnbW39CiC09GFjtfG/ROCRKbahgElPV4I5
         7ruzqXr+SV9FRDh+p2+8SRwP1L/z70W+qH/gztfnQs/R6VdMaFPg9k5QoZ/bkcmpkQMI
         sbb5KQQS2O8Mltx70AuJsDzm4UmrZUMPFLSzhIzY/QlLvanXP/7/r/fAkOMBB9J9ZTJf
         wNbxGda1p1uHgpMAFeGnkybvw4PqXh+dzyZaAH3XKn2I039b7dEbv0SMZCdJlqXqyz8r
         S93hjsS7tIuwPZzrAIWD0lo7ltuAOIz+IKe2lvkR1rfpJ0pqqcVsbTfavanHt9GbtylC
         B98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731379995; x=1731984795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Lorw65PtQ4cm8iqjexRvk/cRJr+lEVzhB14Mwt3cdQ=;
        b=hLBU6oAR38cnAq8AlAbecAMTpIa91fVqJmhfJufEdL3VVmqB8Mi+lhkleOOpfRfH0o
         r3Qp86vdg6c3wbSON8kMViliSFrS5Xok750wOxcOoTT7igjiwlxKdcCVP4qjobe/rT8m
         ggCoKCS8X0//e1+bC9pYD/e7cZbLhregnJbIlTjHQ98i+SQXBPKs659Npv//XmDto8Yy
         E3y2YFTVsiy9X5dtYmEAMZjKnkt/JmbExvHSVC6wwPHMD2pxoIvse0Oe68VKY4zpNXTu
         cipCsANs0g3PD7pyKluIbmwDMXddBzTiL145AziNTRmB1tNc2BLoPs3+8eubDSccByhB
         DSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNnN3SP8N3/yeN4uHut8UJ4Sq6B4SrC43LWemNl9wFiRaAMfoYoRxNb5IOSuzwfafPqNS8UUR6Rhj19OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5MJNj949YGyNe6Tnbk6Gkug9yJ7tl3CTZFmfZKwD4VyMt4Kp
	G8G03zEueCm6b+0zqOnM161K8etUF6FXdqxSx9HAaSZ6X0kL4FwrJLMO1tBM1Hg=
X-Google-Smtp-Source: AGHT+IEXkJ1aBj0V8ruILZdaXYACOVbungEyelI77L3kEH9tEoDfZehKRKzAE7Jp6HasezXgUkm9Zg==
X-Received: by 2002:a05:6000:2d11:b0:381:f604:4aa8 with SMTP id ffacd0b85a97d-381f6044ed7mr6571685f8f.53.1731379994783;
        Mon, 11 Nov 2024 18:53:14 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed999e0csm14056380f8f.59.2024.11.11.18.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 18:53:13 -0800 (PST)
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
Subject: [PATCH v5 3/4] arm64: dts: qcom: sm4250: add LPASS LPI pin controller
Date: Tue, 12 Nov 2024 02:53:05 +0000
Message-ID: <20241112025306.712122-4-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112025306.712122-1-alexey.klimov@linaro.org>
References: <20241112025306.712122-1-alexey.klimov@linaro.org>
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
index a0ed61925e12..cd8c8e59976e 100644
--- a/arch/arm64/boot/dts/qcom/sm4250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -36,3 +36,42 @@ &cpu6 {
 &cpu7 {
 	compatible = "qcom,kryo240";
 };
+
+&lpass_tlmm {
+	compatible = "qcom,sm4250-lpass-lpi-pinctrl";
+	gpio-ranges = <&lpass_tlmm 0 0 27>;
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


