Return-Path: <linux-kernel+bounces-433665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE569E5B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4A116199B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4B21D59F;
	Thu,  5 Dec 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pZGZznLb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5122146E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415980; cv=none; b=aIssYLUIfRZU7+SGEXw/vFTJP8OnRHp/4OsSkg3DSmFnzd6dlDSQAqqNLpJq3P6Vqu9GjRGH2t7F4GjUla5F6u+m05FTfiKA6rpD+PxML/ayUOkUVoshvgLwBguOcVJDuaehLaddPHKFQKATQmUvXm/3GnNxdMO/pggLlX4adDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415980; c=relaxed/simple;
	bh=yC5x0Kr3GQ+y52MwCBTCIIJOZYvx1zk4EFtR7xU0I1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFJ34jSzUMz8vvPq5t7l0o4+WUK/HUYdjPVQ4cY7X7l9Dw1OUtGFLksTcXG4mEVgh+T4QdOpkuDlKcmsljpFrGQA3ZPC/fmh5rGLGxn89DbvbKMRQemRTYULX4HgH+J6pfDk3U4NMPoiPcjsVuCMiA4066qAQxLix0PEmaDRbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=pZGZznLb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0cfb9fecaso1702050a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733415976; x=1734020776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCLk/wc3MKwAF912ySsq2eZpu6hxxtGQsnffSicJSqo=;
        b=pZGZznLbKIi52VA0bfdAU7IBbIVPEU39yNcQpBYTwJ4oAEhWmKCVaqxRp2d5WxbKX5
         3BZTHH9mXFPxPoZsSHzsTUc5vz0OCdii5y7nyve3sdQeb5lXpwMw8SHra8MjEDujhjKk
         eiFG390EiZtakgc3ddoLSmsulfJ3zTqlABhy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415976; x=1734020776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCLk/wc3MKwAF912ySsq2eZpu6hxxtGQsnffSicJSqo=;
        b=ZY+ogV8y6Ide31EG6CERcMv5+AC3H8rJXwT1P6PfQwbeglt4j8/dJAmU6YoTCcoI17
         L0f2UwosIjftBgaJjQ74cF4/y3hjD58UYuaA2VR16IJ/OR9Te5SEaKHPn9z/e2237LPk
         U5yZk/yPKHY5I7DjYk4T0eQzvhWDgZDMX/nbVcxzrAOF1qVgvSoACNgFnjZULCSEfiks
         aCUEBLY3UJsjWp8UDjSWGwd+dtJeA+yt/6EIT1qZbbQVtKJHmREVYfBXjD2iRVYiq4xB
         vmY7CHbnwPXWOsdMXn3qaxuOwswzFanvTk9LLWjyZqCC7aQIoajT51u9JNPKIA1MlLlt
         WxIw==
X-Gm-Message-State: AOJu0Yz+j5amfJY1Y6idskvi3iUhz4hOxvrbaDlcMPDWIKZ0G+3T2Gs7
	P+8+sLyKCJTkKTxhtIukQiaqHb5Wz+Pex0ittNbm9hAf+bkhBqx36X/UgNYJO17qDrivc09xA4P
	x
X-Gm-Gg: ASbGnctRrB5OjH//NK1cuIcyF6P+A9Uyv2lsrQmn5f8T/Sr8euKKT4Pzw8XT1/RmPba
	LR1H60gmdnEN16b8nAkVlSPdkKgSPt+1bzYRntu+sZwJzRPsovYnD6w/sP616VG/oBaYiQEe55M
	GTRdApuuySD2nEurjgBhkmqiUWhhdzsEtBnQgNttxlkFdeQT6KJlF2MCMXBIjBMQcAPVBLLg62K
	Z1BWcmVIzj9PSxetKklnl/nd7M1bWdediq9yy1AEEG/RAz400mIjWwaNo8YZcPrA3STa57WyMFK
	BFshKfFR0ynxewIotnKvr1k1By/9AZ1tn4h8H2A8kUZikA==
X-Google-Smtp-Source: AGHT+IFXrt5EyVJNmwjOInbQwIR0hRyAYkVbpEnHiym56laCVf9oh8OvxH+kl7ISbHpLv75ASv1ecQ==
X-Received: by 2002:a05:6402:5107:b0:5d0:eb2d:db97 with SMTP id 4fb4d7f45d1cf-5d10cb80219mr11709960a12.25.1733415975690;
        Thu, 05 Dec 2024 08:26:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c798f98sm965026a12.57.2024.12.05.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:26:15 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
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
Subject: [RESEND PATCH v2] arm64: dts: imx8mn-bsh-smm-s2/pro: add simple-framebuffer
Date: Thu,  5 Dec 2024 17:26:04 +0100
Message-ID: <20241205162612.1804274-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple-framebuffer node for U-Boot to further fill and activate.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Fix the warnings:
  (ranges_format): /chosen:ranges: empty "ranges" property but its #address-cells (1) differs from / (2)
  (ranges_format): /chosen:ranges: empty "ranges" property but its #size-cells (1) differs from / (2)
  by setting both #address-cells and #size-cells to 2.

 .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
index 7675583a6b67..98dec3c42060 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
@@ -4,6 +4,34 @@
  */
 
 / {
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer-panel0 {
+			compatible = "simple-framebuffer";
+			clocks = <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>, /* lcdif */
+				 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+				 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+				 <&clk IMX8MN_VIDEO_PLL1>,
+				 <&clk IMX8MN_CLK_DISP_AXI_ROOT>, /* pgc_dispmix */
+				 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+				 <&clk IMX8MN_CLK_DISP_AXI>,
+				 <&clk IMX8MN_CLK_DISP_APB>,
+				 <&clk IMX8MN_SYS_PLL2_1000M>,
+				 <&clk IMX8MN_SYS_PLL1_800M>,
+				 <&clk IMX8MN_CLK_DSI_CORE>, /* mipi_disi */
+				 <&clk IMX8MN_CLK_DSI_PHY_REF>;
+
+			power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_LCDIF>,
+					<&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_DSI>;
+			dvdd-supply = <&reg_3v3_dvdd>;
+			avdd-supply = <&reg_v3v3_avdd>;
+			status = "disabled";
+		};
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 700000 0>;	/* 700000 ns = 1337Hz */
-- 
2.43.0


