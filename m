Return-Path: <linux-kernel+bounces-431321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 939039E3CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EBAB2B4EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCC81F8ACE;
	Wed,  4 Dec 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOJS4CjN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D391F8AE1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320838; cv=none; b=CJmGogLobz9LMzGTWJi3jb8Yhm46mZouOYq41BL2Wph/URrqcbD1Xfm2WHdYSelbw3UZbDLSPYL0gPIWIPzp8vhhVsLo7J4W2bnk+hi6LuZf6SyAD7PJhxSDy0hndTLS/mK6meyGDnr7o0YsfZSq6/N8nKVLRS4z1ZR8WdLoDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320838; c=relaxed/simple;
	bh=REvlMMxx0XAJybhZSmB310utOAbwLWPvmzpZTyrvIuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPNwPyQc9GUo8CI1bU+5tRjFKT7RDn2nX2j7cU9q5FUUXI8mk326oY57Pg8sEqqYCAaSRagU+cmVx6GwdpL9ikzPNLBHOv1uv+f+bpCn+7glnhXhzwBcOUjoJiAAQEAU0XG96wfX44LxsFjR/YpNMbFhep8zn5wmsuTLrYQ4rrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JOJS4CjN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a90fed23so57887925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320833; x=1733925633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Lorw65PtQ4cm8iqjexRvk/cRJr+lEVzhB14Mwt3cdQ=;
        b=JOJS4CjNkh+aw+dEJeFPZcPYIvVVmMnDBdRJJaftoCTwjTkMDrmc0gzggGU0KBQnt6
         //oYfGDy6Lnqz1YJynHWz+GPYCFUlnjEmtiDEDv1YFfRvntSFdpvXGi2wqWTlV1OAsYI
         9z5ZzU0E9TlLRwiQF+/IIjZYHrofMjqSNW/ryfgNSlJcdbpVfQJQHN8oXouvZJQtsAzf
         l2iP3dJokTWIYg+BT43pEq3WvA3qCLXg0iZRwM29rTk+fVZ5tIfPEUiDNNYPhXxf8yPm
         J2jiIb8Th9zhMkdqpbizYEdiiVdN4PanTGvUvL64gOde0xEfFqliTMY/ECrdiIz48TPv
         JK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320833; x=1733925633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Lorw65PtQ4cm8iqjexRvk/cRJr+lEVzhB14Mwt3cdQ=;
        b=OvvfwLbuAA6dh1WP3Sa3ZLJjNGJ+Wds0wSdccWe2NH3PDvzt/I6p6RBdl6ZA+OiOP6
         k+Nwk7pstng1HSsPnaQLYEUMlqbfEnAXlPTyPtTYlU2KDHZIqM6kZ19O4Kcv4tgYijvg
         iefC4QkkdOb5OfDnS3NQ2ASDuBVLnwhnGBS39vw9MRIy/PStM/W+U717VIkqHoFmCcI2
         HSpz8eVfsSA96RNzar7KuY5VOe2Tc2IYpVsLzJF5JstozhfFsjR4lwjctzleNwhjFMUa
         0D54Gi7+6CIlj0VleSbwzDS/tCprXDWtItHWQ/FVbs60WP5B7YGMk+DDJL3TT90kB2Ba
         OF3A==
X-Forwarded-Encrypted: i=1; AJvYcCWSySchVVDGYWZoH7JPxRAp4CwrLcdYBnvcaEkUJvb+dH6OGM+epOdGZysShFF3r0YeWF90O7skCJsBV6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWvTa/2js21HtbC7fEur5ugRHYEUUSnC8ICknaHWM1fklBCoM
	hgUbHz0ZV4i8rg0v2o67nZg2UzWDxcuG7jkOtF3wY7ocZZOYBYLM/9SN0NPQf5k=
X-Gm-Gg: ASbGnctx+3/eVuVjPQEaLRWdmYK/69QZGQbwMFDuasiz5/aHUP8RsJOAG0IxbKAB2iL
	cAm2Iw/+0OjaKqNwq4SwMWiGcjAj17fYDJ/oqTxJ5CywuupJs/URRjkgW+VQxaeg+RuppMbSmAD
	bumYGCDYEwUPLB06WshoAaHibsvPXdm3JwtHLFzAOV36sSTSl7VXTvGH3U9c3BkMdkFnnthcWYF
	/Wg2r8R4/zLKLLlXLAqs/c1JTemMI1tJvupTP5ea14YgvBkTXAOVTgkWEwtmEi2+LBOMog=
X-Google-Smtp-Source: AGHT+IEhbpa9f+P23WmGe+eMo7IUbIQGX/UUlmqDiHg7PK8H8fusSK3gTlimkg0zm5RcyUlNRq/QLw==
X-Received: by 2002:a5d:6daa:0:b0:385:f195:27f with SMTP id ffacd0b85a97d-385fd3cd094mr4427049f8f.5.1733320833194;
        Wed, 04 Dec 2024 06:00:33 -0800 (PST)
Received: from localhost.localdomain ([2a00:2381:fd67:101:8e2:966d:36c4:3579])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm13689978f8f.49.2024.12.04.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:00:32 -0800 (PST)
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
Subject: [PATCH v6 3/4] arm64: dts: qcom: sm4250: add LPASS LPI pin controller
Date: Wed,  4 Dec 2024 14:00:26 +0000
Message-ID: <20241204140027.2198763-4-alexey.klimov@linaro.org>
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


