Return-Path: <linux-kernel+bounces-191844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3678D1509
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30AA1F23179
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BDD73509;
	Tue, 28 May 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Z2ANtBZa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JPGPlKqC"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7B7346A;
	Tue, 28 May 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880324; cv=none; b=AX0R8WBKCeQXKcdLScilgLu//reyKo1pSgPctoOEnYA1utlvp7EClWhGaKjArldDFE2DLQmMNsq1FYIfv7j/7fYC3CD2G3TezaLmuAfLa0fRsvaSRDOAfoHTvlbxxNp44m2AJStdWxg3vUukzJz+/EoF4+vcZSA8BBIY7Bl7DDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880324; c=relaxed/simple;
	bh=elvAq7UtGknIb6crDSiKS9oRZqkD//5l72kIWJITzhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxrKbkhxPdtDaVNJN5rCGf/aq7alUxXJPJPPMWEJZYVJ5TLjNv8qbJbd6jhc50P2HvVinHwH0NQfeX5OC5qj/B+NiTu5LcrSgr1HTxBJaTyoySdYWPeP06yjbZ9L17Y/nnpJ8Mi40t29408KSatZFWgwjSMnYRbV2qxhj3BnBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Z2ANtBZa; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JPGPlKqC reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716880323; x=1748416323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T2u4zEaRlGBpo4Yx+BpIMgm18+yuNbm2IErR00tf+e4=;
  b=Z2ANtBZawf06y0uvnuvRkj2v9iLFDKmCHAgvW4OUThekADyMlIM0A+yd
   Ik8g2Uq2KtX6kF+RuTC6u5oCalteh3k4M5Eq2T9yuL1EcQMbp0g3CHYah
   Qq7yygv4KoQme1fMCbt7c/KrzagaTEEn98GCda5TI783aCogenoS00N91
   rWmCcikLBKBBEIFRR6oZLprOwlOmb6Oe6nEXTGRxaJhDOLRXB36WvknB6
   srRsTN1pSGfW/rf7ndD28IwUO2FAyr0PnINPiLwYGoUXW9Wg/DRi+gA5D
   z1wScvJFVs76cTegf4zTHgBQVh/OSSFHr29kcvcUxzb3eO0BtohHL5h0k
   Q==;
X-CSE-ConnectionGUID: DFWmmDeIT7S3unEt0oJ7JQ==
X-CSE-MsgGUID: DX3ya5D7SXmTvy0vBQrqew==
X-IronPort-AV: E=Sophos;i="6.08,194,1712613600"; 
   d="scan'208";a="37094743"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 May 2024 09:12:01 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69D811641FA;
	Tue, 28 May 2024 09:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716880316; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=T2u4zEaRlGBpo4Yx+BpIMgm18+yuNbm2IErR00tf+e4=;
	b=JPGPlKqCnnYg6Se19JlfY/mk26viejPo+9qzPngPhgTA0RRjaMaP+A4CvlAKxXsLyZbibi
	9JHQdo6tAu2NLCVmDrkKqsegd74htoBAzDkAgIkYAOy0DMpa0ZKU/1LF965ePGzjK1sUkh
	CFNMxV2wNaNqmphqSNRq9Pbyt5FJS4MF+pmZm1g+i2mm+rFB7wKpLSqWPAqdtJxXlNvqYa
	N9VZ44uzbHz0BVLWnlZFKOExK8nNrouzkijknp4RH44zHT/7s6gFl1DJNX4PZEA+XY128e
	lkeMME6Sg4Oy8EzEBmoNrjwAMonw5IJIKrebRNx6e6h035+ppM0Qty5ZN+pQPA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/2] arm64: dts: imx8mp: Add imx8mp-specific irqsteer compatible
Date: Tue, 28 May 2024 09:11:41 +0200
Message-Id: <20240528071141.92003-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528071141.92003-1-alexander.stein@ew.tq-group.com>
References: <20240528071141.92003-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

i.MX8MP irqsteer has power-domain support, so use a dedicated compatible.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 8eb9f24007d00..fdaf7d5314384 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1996,7 +1996,7 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 			};
 
 			irqsteer_hdmi: interrupt-controller@32fc2000 {
-				compatible = "fsl,imx-irqsteer";
+				compatible = "fsl,imx8mp-irqsteer", "fsl,imx-irqsteer";
 				reg = <0x32fc2000 0x1000>;
 				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-controller;
-- 
2.34.1


