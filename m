Return-Path: <linux-kernel+bounces-523529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C40A3D817
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FE189F955
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB71F55FA;
	Thu, 20 Feb 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ses+K2r4"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687D1F30DE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050115; cv=none; b=qoYMFa3z21HKStk0X75znb/vOGs+GwdWny8gxMJQ9ADhltmV7bLHJ9Q2l5LE1lgwNdvvcwn1qiTtgTcEvzFRyPMM3VBrwJeYKocvEPa4A2Q8lXI7Sc7qTXzIsBhlkOSxDabVGHmSQRE/vVRmP42Qdg0sWhKgyRHPiC1+cV4fAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050115; c=relaxed/simple;
	bh=d0CtcQf8Wv3lL9BY8WXV1YwbKLOoSAl/tzsPQ0leEnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1uQCC3Le/p71ZPQXwSgdp3cxJ8eM8mQRX5gjYY6ocr/jeZ+ntK3zTo+b4UJa8SG76pAwfXwjvE+/eZ/eVBaVC41s7/4DxRPOELbqvyCC/4JTwYrll0Y+N0h2cLQz1QdHaqC61HlqzxETMCERapGxDmlk4F42OgatfCF6FHhAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ses+K2r4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30761be8fa7so7774731fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740050111; x=1740654911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X5DqzSWRf6FCwakTqnI1Z6ip+HiUbF/QIcptAcLPLE=;
        b=ses+K2r4X5O9AW4iM/3roKTgO7COuXU0TMUwAWq8MiZQ0jDZ6MIxvZ0Tz1sIobIEs0
         1Lw18dtr7pn3nA1JCMmMIPEZ4XvQFtcOa1yW/05isEDzuVcr6C/B5U8lFXuSryZNSfVl
         Ib+t5ORz6LHu+wP830jR+y/PlMa/PQtBBOUdrRvrA2VCAYYCNXOVp1g3XIlp5PKkTino
         eY8KLX61MGny4kRDcok0xFR1Lk5ZoFF51u0ck6WHl61kPwdMEgJ04fejpLqPgyp+1xQs
         B2dz7lQntYT+IuLy0xm2E3Q0jueyBlTZ9Nmgzr5EKWn/04s16VODAaoYJ/8gLpQBOfVq
         D6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050111; x=1740654911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X5DqzSWRf6FCwakTqnI1Z6ip+HiUbF/QIcptAcLPLE=;
        b=ixs4UvC57RFFPP0Nb0hv6f0fMZI/iFLoLxf33KezavYLE+TijwKVbtIpjrPh1WT1DJ
         0KzKNtHgwIQWLyvyCFeBcnevLzqEqheKM3E8a5PmzKUSBuA2MLjqc2DFI/aOFCJeDNMr
         MI1UKqDurnPfUybMKNpEeHakrERkyOuhbkDNafGvj6fDZnE2n3K0qgRuZhY0NTP9vXjr
         LHQ58sNFsTabQJ701iGkHgBVXlyFIyezvZOhnLCrQlcGrA9vEpPnFIM0+tFZbi8dkJZ8
         zmJ7qL6xJTnaUBoyRddi49G/TCP9eIwmpiNhOnRo7Km3Pi6HyAJ5ITIllUYvM8v+d7zB
         msXw==
X-Forwarded-Encrypted: i=1; AJvYcCWjb1wjnvkxfwnOOIRo+gOjKsii078QUfTUmo80aXEHy6/IqctmQcyZv8kxAzmGmjLZWX9MDE4s5eGrWPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oXIZ4+GtbrD014hTyRpMvwbbB5Y+VMjogYgO5ySd1cz65V/n
	7k7t5/xt6mA+tsrWfzsmkxlwAzy7nP8exmsg3GUYL1pS7YR9J8UqhHJHbNMWr8Y=
X-Gm-Gg: ASbGnct4WPgB5+gAwSxhbnGgs3cAboO2EABKA7zYBWVwJhnUPE9Uv9G/oeDxgWUk+zK
	ql7zzQCnT/1mmRHO64pxXr1nMGdqnsv87Bj5qrecIgBqqgPpCbObIdT9SA+oKwf/tZw98MjpRkx
	wj9cC4apAJsLJcjzXRGnrQ6dYfMceEkLTIFTCRWIMyiqalf6xosUTg7ZpAtK0OSdXeIlA2vFl+m
	X+H9sLuM5N2U8WZnSE1g/8VtTy8Nk2ID78DohDNhi7Dr2wzwXAKQhMpwlfEw8AuUyXIk756H9I0
	PMvHmmVVs9S5G2tsUGppQec=
X-Google-Smtp-Source: AGHT+IEBrH7t5T3Pj2WB/YKjyu6Tt9mfV/BJf6mygTdxQLlHJOo6nI55pj3svLEpB1+vdLAfNkGcnQ==
X-Received: by 2002:a05:6512:68c:b0:543:e406:6363 with SMTP id 2adb3069b0e04-5462eedb651mr3405483e87.3.1740050111516;
        Thu, 20 Feb 2025 03:15:11 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545297856c6sm2056164e87.142.2025.02.20.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:15:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 13:14:49 +0200
Subject: [PATCH v2 7/7] arm: dts: qcom: apq8064: link LVDS clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-fd-mdp4-lvds-v2-7-15afe5578a31@linaro.org>
References: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
In-Reply-To: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=d0CtcQf8Wv3lL9BY8WXV1YwbKLOoSAl/tzsPQ0leEnU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntw6sydCzdr3lq263K0JOQk4Qc0tnyxdU2wME+
 N15Skc4LBWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cOrAAKCRCLPIo+Aiko
 1a22B/4pss99hBOLDX1XScPaKx+olriF4M0K8pHizkh00Z3WXSnIrKWJXBFmoeXMv3qVLJGrM0t
 XYV/MGe18IURcZhSkygCpi9HvJpgzK1QVEW74QVH9x9GSMrWQba0SLDX1XLzOdGYooiBB5mUI8E
 EuXd973XQNSA8aWj4ilqqFrzPvd+O7wYJPNC8s8WnG7Zt3Gz8FuIW5NzveuDEk4+d2delGqk9PY
 Nuxg8zf+Nxh9tMnz6to4uG9vp3dw8eB62vBCBvfcsgEzqok9at27cUaEEKlbBieluMZ6W4HKacr
 IO+VeB/mBl7Pa5mhesh4KgO9VbWqQ5+a9Jc65SqVnFSdjklR
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Link LVDS clocks to the from MDP4 to the MMCC and back from the MMCC
to the MDP4 display controller.

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


