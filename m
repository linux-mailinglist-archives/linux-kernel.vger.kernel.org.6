Return-Path: <linux-kernel+bounces-535450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A08A47319
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A79188B993
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB51DDC2B;
	Thu, 27 Feb 2025 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acf3HYsO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA51DB37B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623135; cv=none; b=a2It9n+n91FJWf8JHtnJ9T++8PXV4KnpErZBvc9pEIP81TgeY35Kj2AtDiElkCEBnh1Gah9/Wbx1MaIia0qyIQTiIxfyETHyPjpbztOsTFDPPq6fxzWzrnYvS/9AdRRU9ZPB//pcFGCfh6AdpUR+BTOaAs7+E0H/1uTSLgvVRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623135; c=relaxed/simple;
	bh=gTQKG0fLWpD8Mjgk4DoVlbsZZVw4cfaJYQqKJoHiGbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBYu5KUbJtz4WB1dU2Oya0he/1VB/xKI5i8CzwD8B5+0MLn1oEI9BGv8Pk6Xz5RqEK00RWvHtsSnExKj7v8XvqJMXVH/mQLftoIFIzcW5LO8ChFXt7fXaQPzQqK8IRfiLuaC7XDvI4mJHRK9iB2oG/Uivqz3Z4vu/tqurN8Pl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=acf3HYsO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54943bb8006so403869e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740623131; x=1741227931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qq9MmRx9UTHcwOJg2plfoPnrstGHmU+KXfgGIfhmApo=;
        b=acf3HYsOd7y0AFna9uZU30y0mpgCkk+KviLH/Ecy6I3zWMnh33IGqJ5hex+svKtkFb
         h6YooyivAEgz3N0nzjzQnS/z1PCXC3/jCfWbdj6DhY4Vjb/fbJcyfndRVmhZ0fYOjdjv
         jdi1W/qhyRZJrqmSNOZxKK0P0p9RYZV3pG0M+VDOI+PEY4B70dhtTBFNUOJu6VrlpdjT
         p5yg6JBFrHnWsv7cKhzu47quuyQm1EWmfHrPIiTxqNRfIi8SCeXN7hgFxs2Tm/wfMqQI
         tHvXFsHELjd+Vo15JZ+xxF0Fr/HyjDBXsggH6XYJMFcCqcLd/ey8VdfekV3NE6ERtXnx
         zkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740623131; x=1741227931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq9MmRx9UTHcwOJg2plfoPnrstGHmU+KXfgGIfhmApo=;
        b=sDnhfXtkgNSvmi4u61xSfUuTkFWep9g4jczjzMxWDWemWWdeePK8RonZvdGlh69PYZ
         FqzU/PvostJpVvgTxjlMb/kwiogVBmG7x6vKVvq/zmeHizJwg0P3869kAvID/zGvhiCX
         PWrb5iHz5rewEABp6G64Y2SzVmgWfUeaWzVR7ViqkrBSY/YWpW/L82MeJspI+VMWdtOM
         PSYdiGhBfz6qLrNxdShfJXogLQvBSw0TUWpnPhcetK9qFqEQb6zixcW8hKrHkJmFE/7u
         XxZ9bY2xaMvQXWdzvqXH3dTEjDVOanNBSf/1LJjFYeXMPUI0Z3YFhNn9DEF3jTLLpZE2
         wsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbbW9YOEnCb61J+BWUSM7oMs5FF0BAjsg0nBDqqtln6EmSgKBT3N0eE3la28EWORgI6ENVxLRCI56Vs3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRM9OEKTB+vwTpFENWo3YnbDr2fjokPIii8w+pUNudln4v92D
	SPE1SvybI31b3k9SqbFmeT0vbIzv790MUmxDiIVvSo6TjLfKdHBNRcJCo+xgHUo=
X-Gm-Gg: ASbGncv0u0hKJnxXkSWEKmmFpO+TXJlTqCvIRckr7i8S6cXnAW1Vf7YiuSsOESAeYZx
	49G0iSD5UpeM6a4Jhxzxzndd/By9U0pwZglBdrd+9QY9i5LYq5fa6NzQXzAIcvM9gyvWlGPoIAW
	8LoknksM5/jvk5VtdEIHFRm8GDLngxDxb7MNb3rKIFuEifW4YINhsOLYCh65en+R2j1t81mJxy9
	Z3eFUj5MlnX/H+lQmpDQIjtTC/BLbWSyQ8xo5O8BE4Uxmb6pnwr0n9ZMJ1QmkQXZB2JpQtdqpM4
	ROC0+JjfRVT6pofZ8JWNYcKK8dzKzIFm2A==
X-Google-Smtp-Source: AGHT+IEfNBpBj/ziCw82ad5v30aNPQAqE97K5Ze93xNXV4raP7uNtPDw2CsgCTSSUsjHK8YDRWNp3g==
X-Received: by 2002:a05:6512:114d:b0:546:2ea9:6662 with SMTP id 2adb3069b0e04-54851109c6emr5818345e87.51.1740623131341;
        Wed, 26 Feb 2025 18:25:31 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441742a0sm48067e87.5.2025.02.26.18.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 18:25:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Feb 2025 04:25:15 +0200
Subject: [PATCH v3 7/7] arm: dts: qcom: apq8064: link LVDS clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-fd-mdp4-lvds-v3-7-c983788987ae@linaro.org>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gTQKG0fLWpD8Mjgk4DoVlbsZZVw4cfaJYQqKJoHiGbg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnv80HWgZt9T8wm96Mnxu2uLkRoQ+p08Vp+8VBB
 DjQRLaZ80yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7/NBwAKCRCLPIo+Aiko
 1ftqB/45YhkzEZkAfeOFiXyfNAE94XiLoA1jUXvCiK6882ceMMQbxiQuvNpui7zQpA6uvNM9zi5
 8lJvqdPEbKx+jgF9481iin0lE+yv7k0HqBf4GhTPfb/6dQCCYdtAXtAIJOQLAOZ/lvD8QSQ+G/Q
 pYsckfnly5UpsZLhIjafPx5mAZzVQBxup6O1PjZeERDQJm5UJlPaO+CCWGSvbb8UrqmH41M9u8x
 7jnsmXpjy5UD49Sx9S3SI0tv1jgw2Qi64uj4s9afgN30VfwTSLE19phN038/IBCYcRrqEuAFXf/
 jmRndD8vaNxweMA++NIyVi8MRVVYgBGgsyJ8/Vi7Qx3PETtr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link LVDS clocks to the from MDP4 to the MMCC and back from the MMCC
to the MDP4 display controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 5f1a6b4b764492486df1a2610979f56c0a37b64a..b884900716464b6291869ff50825762a55099982 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -737,7 +737,8 @@ mmcc: clock-controller@4000000 {
 				 <&dsi0_phy 0>,
 				 <&dsi1_phy 1>,
 				 <&dsi1_phy 0>,
-				 <&hdmi_phy>;
+				 <&hdmi_phy>,
+				 <&mdp>;
 			clock-names = "pxo",
 				      "pll3",
 				      "pll8_vote",
@@ -745,7 +746,8 @@ mmcc: clock-controller@4000000 {
 				      "dsi1pllbyte",
 				      "dsi2pll",
 				      "dsi2pllbyte",
-				      "hdmipll";
+				      "hdmipll",
+				      "lvdspll";
 		};
 
 		l2cc: clock-controller@2011000 {
@@ -1404,13 +1406,19 @@ mdp: display-controller@5100000 {
 				 <&mmcc MDP_AXI_CLK>,
 				 <&mmcc MDP_LUT_CLK>,
 				 <&mmcc HDMI_TV_CLK>,
-				 <&mmcc MDP_TV_CLK>;
+				 <&mmcc MDP_TV_CLK>,
+				 <&mmcc LVDS_CLK>,
+				 <&rpmcc RPM_PXO_CLK>;
 			clock-names = "core_clk",
 				      "iface_clk",
 				      "bus_clk",
 				      "lut_clk",
 				      "hdmi_clk",
-				      "tv_clk";
+				      "tv_clk",
+				      "lcdc_clk",
+				      "pxo";
+
+			#clock-cells = <0>;
 
 			iommus = <&mdp_port0 0
 				  &mdp_port0 2

-- 
2.39.5


