Return-Path: <linux-kernel+bounces-200386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266C8FAF41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8336E1C20E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84211448C9;
	Tue,  4 Jun 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwexEOHJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BA14372F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494599; cv=none; b=Y23//WZetT86hR3LFXkjCe/rkWvEPblpvG2ac+ODzGpADn3rP3q8IvCGBdaMnp9UD0vrlfjnq01exJHrnbvOMXe6OX+eN6V6HYyeS07WGuY0vE36DvAgXPXMOhYJ1Igb6V7ik/NlVDwnSasuDWwmqefiq02qa0lCwzwkLLBFC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494599; c=relaxed/simple;
	bh=na4DmRVhf3FcBBjP2+QrPnSQxRE2pOArDjSYe5oibYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5UDkVuJeIcnYhO9pi5LZJUZwAujBCJF+PtC665D3Z0nNkzenzoEM5IQxyhnUvi1KA81fWyPxK3wTtNuWGZM26TpsJJDz9+njoBuKT2hC9A5pdilnlO5K73nqBtbgH682rIPd6NYDTjo52zV0NvN7Q3UW3bOT7GnYLVL0UxOK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwexEOHJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42136faf3aeso17321785e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717494596; x=1718099396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eni1MPkr6BQj2JNT/q670h2qbU8dOfZxcp4/xHPwJss=;
        b=dwexEOHJavBHonEodhblIAbCatA1yrJDYDAt3CRR7mYZXilcIwqZjK/WM9umqVOdHD
         kmdqnA5vi7NS8wvLqJo2UHbiziqMmSE3QyAx4I9kzIlirVt7w6EL1XSW32s0hWFnClLJ
         ceIdqP+aNFjpow+pLOzAcSTRRtnR7KKzIJoNQxUS8gmn8qI52I3/xsJPS8rXoW0glXSf
         414W3fPES47GK8fBrUIuU7tZlRpNFxdwoaAGINDCbYRTq3ONUyKD6MzGt/ozYLMQFLPV
         98jCVOlQq6srlnk/6AT/X5DQ9w61Yn+unpxQY5v8Ib6uNxjrlS8Z0LjZbjmN2oi1C6d5
         OKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717494596; x=1718099396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eni1MPkr6BQj2JNT/q670h2qbU8dOfZxcp4/xHPwJss=;
        b=cGFw8Zfl/IqIyhgHPPF11NCYUiPNDeSxHhvY73GkR1b/A1ZkCAVeqgTHqw/zgd7Bqm
         6s2Scyn2e8VAVY+wJ4nYvV7kxy95fRcZn39eIiv3a8HAZe7wP3mLLkDm4DHchn59Do2T
         rX64xsoxFYx5oBqs+Fbs8r0SU43dZPoXcQoDeqK+vBJ4jAcPk8F0YWOfbLk/pc9EhZo3
         6EuqDi6LgJNTeRzaP3Pk0zlgei3rZKf3BAk4KpysPNPHLfUW1+AcRtzGhyg4yvWx8Phx
         vPuLUM+vc/2FTEONzHYRVzMz0QEaxsx1If5FvWMpZnDZLxuEhqoOsv33OeyM85fniZHI
         rO7g==
X-Forwarded-Encrypted: i=1; AJvYcCWan4raY6PHn+KTr9vJ0Tl9DdoX1lLjz+BJ1Wfu8rFubzHK6MWoYj5WWNhJUB2hGZKw7+lECQlYT+LAMDNVvm40eF+hHm5hNsYYN78N
X-Gm-Message-State: AOJu0YxJ/1A+9cok57tlaBd7/BX10pWk3eo/C6ruVfjtJHiqoj2mHCTX
	c3WcA0y2yVmswerEMQMJH3rM4MryBuEbsHWsy4MAA49fqma+YLNUX53NP2D3rUw=
X-Google-Smtp-Source: AGHT+IFNMTp2Iknbql0HmyBQsEdTLXkFZeovjw0rNu08wnkyq/afZj1EhQbTkmzPjmLwe8o15TBXbw==
X-Received: by 2002:a05:600c:a47:b0:420:29dd:84e3 with SMTP id 5b1f17b1804b1-4212e0add62mr97200255e9.26.1717494595840;
        Tue, 04 Jun 2024 02:49:55 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213c264714sm72904115e9.12.2024.06.04.02.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:49:55 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: qcom: x1e80100-crd: add USB DisplayPort audio
Date: Tue,  4 Jun 2024 11:49:47 +0200
Message-ID: <20240604094947.98191-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for playing audio over USB DisplayPort (the two left USB-C
ports on the CRD device).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index c39dd493a3af..08032c02fc22 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -189,6 +189,38 @@ sound {
 				"VA DMIC3", "VA MIC BIAS1",
 				"TX SWR_INPUT1", "ADC2_OUTPUT";
 
+		displayport-0-dai-link {
+			link-name = "DisplayPort0 Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai DISPLAY_PORT_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		displayport-1-dai-link {
+			link-name = "DisplayPort1 Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai DISPLAY_PORT_RX_1>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp1>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
 		wcd-playback-dai-link {
 			link-name = "WCD Playback";
 
@@ -836,6 +868,7 @@ &mdss {
 };
 
 &mdss_dp0 {
+	sound-name-prefix = "DisplayPort0";
 	status = "okay";
 };
 
@@ -845,6 +878,7 @@ &mdss_dp0_out {
 };
 
 &mdss_dp1 {
+	sound-name-prefix = "DisplayPort1";
 	status = "okay";
 };
 
-- 
2.43.0


