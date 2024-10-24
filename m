Return-Path: <linux-kernel+bounces-379710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553729AE280
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD9E5B21609
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195381C0DE2;
	Thu, 24 Oct 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LMbUlRiz"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538531B4F02
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765691; cv=none; b=bNgYaiSwZHuZYj3VFSl28c5vhQUDlKXcB3EaYzJ9WA0BKFbKB2N6K4n+v6G14CE07ilwYdndHo/iN6W8W5GLdlSRlkFiIDUnXQgKz/0fPEcpjTnvoy0O5/gsmMTwgFg8x1OP4fieZc/N+J8t4A9o3H0yjjUFtXE+FhMmDb0JmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765691; c=relaxed/simple;
	bh=wnIvT3IpVrnkazOAfuknkSg50yEaXIoQFrYlNgWuD0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTTUvb4XVGSa+gp7nNi8d3E3Vnp415azG4uIamQu6seUjmPAJ1XjDVrGdXAt4BdfU6mKiH3lPpe1nCNFoRZfK8TuuP0WE/siRlQjsR9bdc9cmvJVGjuMi4sEqONmQ6nQkWPgt8KVVXoSn53NNwdtiUQRUXzkhTcE/UJnBOJpHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=LMbUlRiz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c962c3e97dso919144a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729765687; x=1730370487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVJNmqv90FijvAIp/3GkvDIQz+9MpbG95NCFvDT1TVU=;
        b=LMbUlRizXworeZFE7nbaaWM+cWfwbdc+U15sOg1MNgB5W3z/3NVxPrzhUJH6Kldd3j
         dcNh4BVb5uYsy5ID795Mrx0UpI/UXgI3MAEGe0Se/cqf3mlwMCkDptjgyuSCAjAwp9Kp
         eVOhX3flE/kQOkTzAGIpLz0dqrDvaEI9o0/8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729765687; x=1730370487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVJNmqv90FijvAIp/3GkvDIQz+9MpbG95NCFvDT1TVU=;
        b=nFqdyHtYpPlYzyPJkOne4dWrPcX2JjGLmGXKVMKTQ9AYoeXSVJzxVDeMHVJTDo6u5Y
         Dx9CUUmpahevz9RQahDKXKKVIrnA4ia24tVrXCTMLMstwjklpt3SO2ytuWlEYkaLjerp
         mW3VebOh6E0MOtcLTF13dNzwkD3hiC5DD8n5dXulDz4fIjEB/sGyrjk8K7HPt86kj3Oq
         WLdYVxseO7SYKUVXLc9x8SPmcJhJCWILq1dFkJVnsZelY6LsTHfcKIPmESbvhobEn5p0
         TRbyT6KhfMUNS/u7hK3dq4dCaXHTMPGL/LQNdPsQde3g3EDyVa94XXqenEXM7w7ir82K
         prgA==
X-Gm-Message-State: AOJu0YxSQsspFfsRloYk8HvXdKuEY8KBIUPbCRXoynhuCmZ/NZKwN4di
	2vDIoYqfG45ZOCHPGXS+nc9sGfomYMILwBlxoRndSWXP+DTKI18dgzDXRpEsB0aMaC70gzsNIPE
	PUcw=
X-Google-Smtp-Source: AGHT+IFIqyj+bFhDT0bT0Yue3u7gj7a0OTnPThmVI8x1ivIOOR0hXbcRig1qWOZuLaJ3Cyrf5Wbirg==
X-Received: by 2002:a05:6402:3591:b0:5cb:6ca4:f552 with SMTP id 4fb4d7f45d1cf-5cb8b1a982emr4924713a12.35.1729765687354;
        Thu, 24 Oct 2024 03:28:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:f79d:49dd:b804:3f48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c726besm5538534a12.93.2024.10.24.03.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:28:07 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: imx8mn-bsh-smm-s2/pro: add simple-framebuffer
Date: Thu, 24 Oct 2024 12:27:56 +0200
Message-ID: <20241024102800.3481574-1-dario.binacchi@amarulasolutions.com>
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

 .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
index 7675583a6b67..3d670534a714 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
@@ -4,6 +4,34 @@
  */
 
 / {
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
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


