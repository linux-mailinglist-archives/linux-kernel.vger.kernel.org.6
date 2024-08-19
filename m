Return-Path: <linux-kernel+bounces-292027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8021956A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB342B24E71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559416B3AC;
	Mon, 19 Aug 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="n6GlwG78";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fwNsBQEB"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8016C69E;
	Mon, 19 Aug 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069052; cv=none; b=RsVOEPUDoN4GDPlZkJYAIWJnvdoE6e9ptrEzXyIq2M2IavD3B6X+hQOEP2kMGTbvYK+RmT+tp7pSDecY6wKioiAyOXqmtvHG4EHLi6VTmHjic2AhnwuAXE4VHwe4cneI7DP8Ft6ISe1+4glq6Xq8Mp+jU4zYb5QpOs+fPKc4a5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069052; c=relaxed/simple;
	bh=/NJtnATzw+QAXdLAyomfDPF56FCcypv7gXFOTV5iT2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPaQODz17itdXCNHzTNGG24IVwVyw/g57K3spv2NrgK14GlPeH1be9MX7GrX/LXPgSGDTlwMuiCtJLnhshw+Th4T6e+hMiNiqMqOQHFEyymgEf37P86fUA9VTbN42ZGzjasCs1WBs0ZYZFxxvR8dfrhnt9rw1Ocvj+IwCRuQdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=n6GlwG78; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fwNsBQEB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069050; x=1755605050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CUhDDd4L0Nhb449dRHFlHrsNDXqMMLHgE27Tqum9MVs=;
  b=n6GlwG78TN6OmYnxJpm3YtNzTgnXHPFBGTwFfF17yRvF46CShH8kAozO
   3EKMj4NMWQMuDMJFSN8XWonCCTZgAVwQIcynV9KtEqBn/Kr5CxXaeGHlS
   jHUN++6PKyaq9T07QaYmoxQR/DTrdxnANh+2KiQDSUSK/wB8fMOj81m8l
   K20PJbuEcCeZ5m6hJCBXqtFRfllAcm2WJER8Kt0Rwg2+iElP4bbx3hqVn
   Jgpd+vgUS5FbstRqhg9jWhxCy/PmxpkLhtlHLcOoCxXN71Ss6ufquYqgI
   ELMcbdmPBJtqGe5q55VlojC1CtRtOKTDxwM60CDq8+vOkMUUcuzXnHG8Y
   Q==;
X-CSE-ConnectionGUID: qHKk8luzRe6kLkr5VtF0eQ==
X-CSE-MsgGUID: QsDYxp4hS0CygMkoEBjZ+Q==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467123"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:09 +0200
X-CheckPoint: {66C334B9-20-FF00FE11-F2A862FD}
X-MAIL-CPID: D4B7E3D9CAD9360846CFC0F2BA1424EA_5
X-Control-Analysis: str=0001.0A782F29.66C334BA.0018,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96FFF166BA2;
	Mon, 19 Aug 2024 14:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069045; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CUhDDd4L0Nhb449dRHFlHrsNDXqMMLHgE27Tqum9MVs=;
	b=fwNsBQEBq286wXJSmKL31AjfZoYmzEbjKxD54Z+VV8bCzuoh4eDaBvySB7jCNpARxK5y2k
	ufSVKgDK3KticjiCViSoraQw+K5p+z8R9yAtGuSbtwP3Db525z8XMlYhzYIsYtomPBMuyv
	on9aV3J3dCW91SR2w1OmWySMw3Fz+AqzCZ4G7X6W95+KvqofrL0HdRUStuXbfgT3Wg9uZV
	vpuKw4biIKFbSkDLZrEWv1C/fhT7PlxUNZ2zfpoMuCEY3o3XDJjElRPB7inbL3Nng6FPaH
	NSjdVqGc8mAspZwgQkHyoe8EtC3bsow2XYQVnYuo/pJySY2BOcWm+CFa3rduOg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v2 06/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: add missing pad configurations
Date: Mon, 19 Aug 2024 14:03:20 +0200
Message-Id: <20240819120328.229622-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

- add missing (and currently unused) pad groups
- assign muxed GPIO pads for X1 to gpio2 node

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 9e4fd1eabcfb8..b3db7175cdd43 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -222,6 +222,11 @@ rtc-irq-hog {
 	};
 };
 
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>;
+};
+
 &gpio3 {
 	ethphy-eqos-irq-hog {
 		gpio-hog;
@@ -524,6 +529,19 @@ &usdhc2 {
 };
 
 &iomuxc {
+	pinctrl_afe: afegrp {
+		fsl,pins = <
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO07__GPIO2_IO07			0x011e
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO08__GPIO2_IO08			0x051e
+			/* HYS | PD */
+			MX93_PAD_GPIO_IO09__GPIO2_IO09			0x1400
+			/* HYS */
+			MX93_PAD_GPIO_IO24__GPIO2_IO24			0x1000
+		>;
+	};
+
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			/* PD | FSEL_2 | DSE X4 */
@@ -606,6 +624,28 @@ MX93_PAD_GPIO_IO25__CAN2_TX			0x039e
 		>;
 	};
 
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <
+			/* HYS | PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO16__GPIO2_IO16			0x151e
+			MX93_PAD_GPIO_IO17__GPIO2_IO17			0x151e
+			MX93_PAD_GPIO_IO18__GPIO2_IO18			0x151e
+			MX93_PAD_GPIO_IO19__GPIO2_IO19			0x151e
+			MX93_PAD_GPIO_IO20__GPIO2_IO20			0x151e
+			MX93_PAD_GPIO_IO21__GPIO2_IO21			0x151e
+			MX93_PAD_GPIO_IO26__GPIO2_IO26			0x151e
+		>;
+	};
+
+	pinctrl_jtag: jtaggrp {
+		fsl,pins = <
+			MX93_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK		0x051e
+			MX93_PAD_DAP_TDI__JTAG_MUX_TDI			0x1200
+			MX93_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO		0x031e
+			MX93_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS		0x1200
+		>;
+	};
+
 	pinctrl_lpi2c3: lpi2c3grp {
 		fsl,pins = <
 			/* SION | HYS | OD | FSEL_3 | DSE X4 */
@@ -639,6 +679,14 @@ MX93_PAD_GPIO_IO00__GPIO2_IO00			0x011e
 		>;
 	};
 
+	pinctrl_mipi_csi: mipicsigrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3		0x051e /* MCLK */
+			MX93_PAD_GPIO_IO10__GPIO2_IO10			0x051e /* TRIGGER */
+			MX93_PAD_GPIO_IO11__GPIO2_IO11			0x1400 /* SYNC */
+		>;
+	};
+
 	pinctrl_pcf85063: pcf85063grp {
 		fsl,pins = <
 			/* HYS | FSEL_0 | No DSE */
-- 
2.34.1


