Return-Path: <linux-kernel+bounces-273690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB8946C87
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 07:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EFC1C214FE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 05:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBE5FEE4;
	Sun,  4 Aug 2024 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5bbXfbp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708343CF63
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750039; cv=none; b=sJZWeJl/WaMh2sSbm4Sbb7trpnIMJktfCAMLV11jtyKeXByf9i1/4JVNF1pTugj95DebQVTVhpk+4D7JUS6o9Imv7sQjt826srUIOATPs/kepfHFM9eW+oe4IqGf/SQFjCIUxJ4FiwRDTrblElFiGhf4TAC5Yv5NIahCK1djQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750039; c=relaxed/simple;
	bh=jVYTvN/M5oXQ0cuOojPrVIEl/Z9fBYssaRlhkXEzBxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDQk2kVhy2m5aTK+WNvtJOkJX8xGnyMqAUwSXzDi7ABr8xisH4A2MFA328WF+Iw6iUmf8Em2WzFxm4QGY88C5DgrSZOtg6FVv0O7zESwloLj3LmtlFFA/+0DtVuyl6lmjfZ0tihEy+tICTejvxQAUQ68AHPUErwu/0hluPyZPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V5bbXfbp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f01afa11cso14115484e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 22:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722750035; x=1723354835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGZoVd2rDgNeiiA+eJxTSi+RLq7K+EuCeMoKQavvKp8=;
        b=V5bbXfbpkO5lLAl9VtWGBuGemgtN5/PwNwLKQquGOtJGlvSQQZTiq/oCz4947N8Poj
         I2jVwuQJOv2qJzh7dBlLQKF7f3+ZJEUjELdungX5J44jkxBzUoNeHunCAPklRYiwZu+D
         cpUlik0poCQaRVdXnJoWg5AURpaZ2JsmPc0oiqrkams5mKdcDO40OqdNX0FyIRLZJA+C
         epkOU0fco9e5yoPO4Tk/aEbaKo8tY08GMBBKF5hdiKPZ9bMPmGu1PwB3LsO+gfpaKJHw
         3VS+88UUQl1EGPafVzokIr/pkhMLvDVtH4ZylkCzdIsNKPyCMDn68Illv04xUpfKZvS0
         //ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722750035; x=1723354835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGZoVd2rDgNeiiA+eJxTSi+RLq7K+EuCeMoKQavvKp8=;
        b=ZyXnVvBVCcsqg47LZn97VPyf3ssNLe7XEN8dOqdXKA4wX4lBezd8EbrI6BVJdoTvfm
         isDdOqwokkMwk0bGcKInh90Mq+svwnzB2ryQwtdGkFMHzR8tT4LqrMkpUwD0zVEtEgsz
         KuNdTm4ziMf0zTrxFYjqAiix7O4SQuBjz73jonMU9CH1qxy0jSO1e4iphCHKNhvEeijP
         RTLI2y7PVOQtrLbPUylukNobwIPphTK8Ss0qGtwguqDwj5qJXKOojhaxMsGIYyc6gMLp
         uo6vFLR9mylf+bnB2o4RKFXPo9VidBqN5YmgqNiLwQiSCjH8TsmFlN4F3M4BSsLYbgmv
         7URw==
X-Forwarded-Encrypted: i=1; AJvYcCUS9ZXmKT6NU48IhGoYrAsnYM78HROylvw0EKx75l7yVo/yUs1bSrRgBqzgpq+Q/SzAjdbccp04QXYrt3z9h6wR3TtK3D8MXk6GgzBC
X-Gm-Message-State: AOJu0YyZNx1QRHk75NOfaQdbaZlxGvpdKBPX/qASccgbGNZLz2U9KWrQ
	QBs0EP/RtoU12EjJ8Bh5FdI/zNptnrkiTv0afwJYbPMegsdU+f7YltD9piQ7QEU=
X-Google-Smtp-Source: AGHT+IEPlAu7+t1OD9xkZBZB+NNWj0yEEWFX5JqjgVG0e9+KB+gZngiGtuqgNS6nmYBsvDyIL2hvxA==
X-Received: by 2002:a05:6512:12d2:b0:52c:82fa:ef7b with SMTP id 2adb3069b0e04-530bb3a351cmr4927864e87.44.1722750034659;
        Sat, 03 Aug 2024 22:40:34 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bd7sm292248466b.34.2024.08.03.22.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 22:40:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 04 Aug 2024 08:40:14 +0300
Subject: [PATCH 10/11] arm64: dts: qcom: sm8350: add refgen regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-sm8350-fixes-v1-10-1149dd8399fe@linaro.org>
References: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
In-Reply-To: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=jVYTvN/M5oXQ0cuOojPrVIEl/Z9fBYssaRlhkXEzBxU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9p6EfvbJs11IWt2KySeq1a453nXk+N4QleS7+4FFfmh7
 112W23pZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBElrex/xVnkppt/SZk00ar
 XNlFkenx77pbV31njlzh7OjUJ13Q3GwY/XSPo82lVULHrvZ8NNqZZXh065xDLesqVII2VKSdfu5
 arcjOJneoNEL89RtDbb93903q20stEmVC56iv+z2dj+uNkeC+pNtXjKQEVJ1kNJnPrGRb3W5yWf
 Zr/64NMvznzzsmW13fOy0oYLPYJnXLbU8vrz/fuzus9mnQo/81uaYXfPXCum6/4Kj2rl0akxile
 +xCyJ35Armi1uZaiWuYnGXK3Z8vmv9jynIj7w61x9PYvLelyTwOUm46fsu7QM21R1ejaGNWTbj2
 tybFiW83CnZLLDnNoR7vs6dfiGON4BpN1qgvW++tfMsMAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On SM8350 platform the DSI internally is using the refgen regulator. Add
corresponding device node and link it as a supply to the DSI node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 27f36e6366df..37a2aba0d4ca 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2251,6 +2251,12 @@ usb_2_hsphy: phy@88e4000 {
 			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
 		};
 
+		refgen: regulator@88e7000 {
+			compatible = "qcom,sm8350-refgen-regulator",
+				     "qcom,sm8250-refgen-regulator";
+			reg = <0x0 0x088e7000 0x0 0x84>;
+		};
+
 		usb_1_qmpphy: phy@88e8000 {
 			compatible = "qcom,sm8350-qmp-usb3-dp-phy";
 			reg = <0 0x088e8000 0 0x3000>;
@@ -2710,6 +2716,7 @@ mdss_dsi0: dsi@ae94000 {
 
 				operating-points-v2 = <&dsi0_opp_table>;
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
+				refgen-supply = <&refgen>;
 
 				phys = <&mdss_dsi0_phy>;
 
@@ -2808,6 +2815,7 @@ mdss_dsi1: dsi@ae96000 {
 
 				operating-points-v2 = <&dsi1_opp_table>;
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
+				refgen-supply = <&refgen>;
 
 				phys = <&mdss_dsi1_phy>;
 

-- 
2.39.2


