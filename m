Return-Path: <linux-kernel+bounces-233224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B285F91B480
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFC2813CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E22C87A;
	Fri, 28 Jun 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9XeR50I"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C041DA23
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536846; cv=none; b=SbVfMIKAShScowI69OqCpRfK3T14RFP/vqk2FYpw+k5y7iMJ6dJCy103VEwmrbEfsxBsIiSuyOEa6BIvU+qF4PAK1ajqrkpb1WG7i4Jhv3qwIj5jpAdpJtlriikRRpzLmsI7Epsp2aiCJo/cdINPxm+6R9WPJW555fZbw80Z2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536846; c=relaxed/simple;
	bh=ZZbdHFT9ZRAwH2jwxwKvq+WMg4pTAYm+sxzcfmphUPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0372MrcKljdMTBGNJDiMHHFoMLSeGCOpuJS0Dr6dBTCJiYFRrbHVCqTypQha90WE677dyXx5XfGV6zaT9K2GTyjAUinMABO3w1Et/u2qIOxDKt8aDNOc3oT63Xs3C2YkMqdoWeFgDqiRyHlEt+tLGmEqtJGt+f7LM+LLUlpvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i9XeR50I; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424ad289912so414075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719536842; x=1720141642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dynAb/Zg+8LwHqw/4XbLMs/MXNbFYTrBo5jd++nUj2c=;
        b=i9XeR50I6m+nb9xnfrPel0TRjc5ET8RlXxnweIh4FBk3vvoc3WHiU/Xl1BZATkWjhq
         5Y6cHnjKDhHSx1N8+ZVS7c9YXKPYdkdioppITH9qsKUlCOOSQdaDiQgAt5twENRKPNzX
         HOH3uyc4NcMTyWlK6+0B4r6WFioWlUitt7tEu7X+6LqYYRsa6HMs5OSon0bSNZTXyBEt
         eOGEFtCnajJKHjiaXKs92AJLdqZnsN82E/nGhE8vEz09nA0eK1aR/omy6nJl4NKcXORC
         CS3muZEgvO+DGZYrRdpaIIa/fCuug7tpBokUM2EJfW+flLsYws+40f9wTKiXeglQCJvu
         a+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536842; x=1720141642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dynAb/Zg+8LwHqw/4XbLMs/MXNbFYTrBo5jd++nUj2c=;
        b=YHpdZCN2I+jyLqRYo4V8cjfRIU3fv80RkAoWJ1OscxFQB/QEdDlJAn3SD8svzwDxaB
         sJEDEBgXzIetOoOO9QF1zTDzrzMxPx3K9dsy1uObraQ34ZxXkrCV/BzO/BUv7WNL4upP
         eNAroOIsPGWN6exf5rosmuoIxPRRU9zdfGAwiVvUu8C446jFCNefhxb37RjogNCtGea9
         A+qBI/bISMuNBa+2ifdrO0SB8tXLT23sne+ZnGaiPKTQsjMLnHl8/K/aynDpnJvxGLBe
         2RRokpTMmcx6q4Hj+EVKtcVkHn8uriuWwfjgqZiA27FSvbWU9zVdcymTwnbVCslUfaFJ
         OrQw==
X-Forwarded-Encrypted: i=1; AJvYcCXmnDnEdewl4o80lDPoSZYTHFFO4x0rfBCPY+ZqOzV93yLN1C7QHHUBd2Gy2qfdu6tDTvnpBD7K6KlBcGjcMR7kGdLbbM3WGo5hrcuC
X-Gm-Message-State: AOJu0YzDD5SIOevGCD7fxN+aoPf8uyfAztkpvJqJeaN4bBcg4b2+9uTT
	FRmjfy4pEfH7UogYugjMtJklIGfgeALTichGTXi0UnitW63Wx+NiD3hzVYgkVsk=
X-Google-Smtp-Source: AGHT+IGOKI5oJNmHOq5jyVwdpyCLf2KYJIoEqX0YWFdClIjga1qqCIxKbsEXzORyUUOyqTbaEueFlA==
X-Received: by 2002:a05:600c:1789:b0:424:a403:565f with SMTP id 5b1f17b1804b1-424a4035701mr65078085e9.11.1719536842616;
        Thu, 27 Jun 2024 18:07:22 -0700 (PDT)
Received: from fuerta.Home ([2a02:c7c:7213:c700:2cd1:b0e8:abb:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c27dsm13075805e9.7.2024.06.27.18.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:07:22 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	elder@linaro.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	alexey.klimov@linaro.org
Subject: [PATCH 6/7] arm64: dts: qcom: sm6115: add description of lpi_i2s2 pins
Date: Fri, 28 Jun 2024 02:07:14 +0100
Message-ID: <20240628010715.438471-7-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628010715.438471-1-alexey.klimov@linaro.org>
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required to enable to HDMI audio playback on
QRB4210 RB2 board.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 3a9fb1780c90..5487b274836f 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -823,6 +823,40 @@ lpass_tlmm: pinctrl@a7c0000 {
 			gpio-ranges = <&lpass_tlmm 0 0 26>;
 
 			status = "disabled";
+
+			lpi_i2s2_active: lpi-i2s2-active-state {
+				sck-pin {
+					pins = "gpio10";
+					function = "i2s2_clk";
+					bias-disable;
+					drive-strength = <8>;
+					output-high;
+				};
+
+				ws-pins {
+					pins = "gpio11";
+					function = "i2s2_ws";
+					bias-disable;
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data-pins {
+					pins = "gpio12";
+					function = "i2s2_data";
+					bias-disable;
+					drive-strength = <8>;
+					output-high;
+				};
+
+				ext-mclk1 {
+					pins = "gpio18";
+					function = "ext_mclk1_a";
+					bias-disable;
+					drive-strength = <16>;
+					output-high;
+				};
+			};
 		};
 
 		gcc: clock-controller@1400000 {
-- 
2.45.2


