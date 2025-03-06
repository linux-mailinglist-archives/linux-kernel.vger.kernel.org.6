Return-Path: <linux-kernel+bounces-548806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE9A54995
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEFD1886204
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D97D2153D2;
	Thu,  6 Mar 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qVwCa2pD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA621507C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260660; cv=none; b=j8Jhr1z2Oh1LD3gvPeH2qe3jabzQ88FMm2pQ+gfKHiqZ5sVtawHMF7KIQHE9UyE/93oOMidqRoWAafYCasXjgMGErU05VbSWcsHpsK9yH/Uj1Ug0Lub6X3WbgMUNewtW9cUweEK0xsvFeXvDO8/7bLKFmezRNpRues/atrCxOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260660; c=relaxed/simple;
	bh=7yYZJd86bIYU+vT8RAjY7wEp1oq0Xfmfy1RQITDVRe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqWDTHCWmuBWri+70mWlvP+HyWV2GWlaNTRf3ud1xAFYvElW7kADohLkh1G9byM9qXp1iQ0aB621ozuvOlmcvLm9yhtwSOYJSrZnYJBXZeEtq/9gMixZTlCOGmRB8raeVAuONH7jsM555m0zi7+YlSh+mCd0+i+NISFamiYSkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qVwCa2pD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so4085855e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260656; x=1741865456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8grfYWwIX4hpiA7jlx82Mk2yoAsYJcNHuOuvJvnYwRc=;
        b=qVwCa2pDhzlowXcZPTga5a0lXfiD9DBXlQ+VtX6oNpTzsDB+rQ6Xsixz28M0GI5FJx
         +YYF5vygmXrQqOqkROz7kY45tHNyMu6WotpzI3KRg0KPvLB5X5V2AzPAY+SLkOLjfnlZ
         Ctr2av6AQu6GoXK3bQTSioEibh0LWawRyBobY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260656; x=1741865456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8grfYWwIX4hpiA7jlx82Mk2yoAsYJcNHuOuvJvnYwRc=;
        b=WZc0OBlWcWttz5L2WotASDrAp7JApyJKciHywokJskXUfwbMsy8kLEQzjVpz0wJ4kZ
         IGNjk91T3gzuKZGPhbzFO41hO9/Md0AXlHNFxuZiMFa62WjxNfubukjFnXk4HFPMQKsV
         AY4Qye98eoACUipNt1YHxTzsTcMWnGmuNTmRS+lqNnA89OCnurcHttXPGNiwX2nyVLpe
         yx9hz6cwo/YaxTovLr7pg+yRiOHkaSbO0IJ2YPzGSmtgjxSrZGXX2ORZiTE2myi8anM7
         vs9iBzQgyU70OGQlC2z+SwmE/ALVCpCQHMpLB70vVoMmGDapoEyGKRlD2M54JDR6Wzs8
         XgXg==
X-Gm-Message-State: AOJu0YxQb8c8DIoaPtdYHKXnTjC+lkzvPxEH/iaau+RkuZ3/Il42V2BC
	Ti8jcNUyMZV3Ze17SsFMyRzbAG56exVVWkxBp5TH99Wk3rXL/hzR39efOgGcnKyPjrMf1HnLpty
	y
X-Gm-Gg: ASbGncs7ABCk1G7VhMbxifwsxpbTMmIhPRHfXRRy8CujeSBTjpRWIYxNph9EqLVEwll
	t+dljx4N4jE2WKzWsIc8si+s0MKerSc+yD2KKlR/9xi/cyWiQccMUSlspvCVaxeMswZxbxvDKVn
	VZQ+F8u3G8JA7nLcC8HNbFZ5G4g3G3YgbPVW/pX4p8yAoeV7EHByiq6L1+tORavkgovLa+awHxi
	Av463+QIwM6AUO7nxb8ogJN5uJTixDsdyeOrHhz0wTCkyMQhmaDsaEjrXLrdnlt+2g2LiXL0AAb
	Ssi+iMDlwshVEw20blr/Y+QApmJHBK9rMN8e2knm4jYsbQxn1MLpWWJgKqrBd8Tc0n79FiaJ8hc
	31boKjw==
X-Google-Smtp-Source: AGHT+IFeKvGyyBqN0xdpou0tHRjJGAp0jFx4x573e2BTr5KjxvJqJCsFOx3f7ZBV0vsm+afHKUXGSA==
X-Received: by 2002:a05:600c:3b87:b0:439:6101:5440 with SMTP id 5b1f17b1804b1-43bd296abc2mr49684235e9.8.1741260656050;
        Thu, 06 Mar 2025 03:30:56 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 17/18] arm64: dts: imx8mn: add PLLs to clock controller module (CCM)
Date: Thu,  6 Mar 2025 12:28:06 +0100
Message-ID: <20250306112959.242131-18-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the PLLs generated by anatop to the clock list of the Clock
Controller Module (CCM) node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 49be492b5687..01013c1fd61d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -643,9 +643,14 @@ clk: clock-controller@30380000 {
 					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-					 <&clk_ext3>, <&clk_ext4>;
+					 <&clk_ext3>, <&clk_ext4>,
+					 <&anatop IMX8MN_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MN_ANATOP_AUDIO_PLL2>,
+					 <&anatop IMX8MN_ANATOP_DRAM_PLL>,
+					 <&anatop IMX8MN_ANATOP_VIDEO_PLL>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
-					      "clk_ext3", "clk_ext4";
+					      "clk_ext3", "clk_ext4", "audio_pll1", "audio_pll2",
+					      "dram_pll", "video_pll";
 				assigned-clocks = <&clk IMX8MN_CLK_A53_SRC>,
 						<&clk IMX8MN_CLK_A53_CORE>,
 						<&clk IMX8MN_CLK_NOC>,
-- 
2.43.0


