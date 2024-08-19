Return-Path: <linux-kernel+bounces-292025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7FA956A49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EF1285BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EAA16BE35;
	Mon, 19 Aug 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ijQLbDmw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XcSY19so"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409E16B752;
	Mon, 19 Aug 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069041; cv=none; b=eotSvYuEBaK3kpm86wRntmwnypktjcjLt0nCmogm/7I5CfgQTK6DeAX2iekcMNDJJm2vLvyz9IlPbMA+DGimp5HmDaupnFigsWBNg2VSABqb8tA1rSBa0fELh/8UwTY9JyIJz9rFdxvAQcF/cstsxA0sOwW51Hiq8OxAsckHeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069041; c=relaxed/simple;
	bh=8B8TGnn2lHir4wKZiD53Xk06jWNRL0WK+iIrRLtqmuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBq3yiFxcW9TMUaNIaO5idH9ZfzCRgFF3tYYWPV5rg6smsoezHUxwwlXh1w4nSDmWAl6sDwfZ55IP0wBu48xwumqxhVKlDtXkpKEqbPLhD/yDE/gkkeUPtn2FqF1jwmMQp4XwdQwXMS8ubclvfLcJeYg3KORPVa1IQs0oIA79Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ijQLbDmw; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XcSY19so reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069039; x=1755605039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CyDUDb6WuXUW8dv4nW3tr3AH/eeOqQacQfm1Ie6rDGw=;
  b=ijQLbDmwUGSHOYu6fvsK7FrZf1GrqBRwiD9jWOcoLsYpaVBu+cKa9vC/
   rygQQvl6b2Eva6oM6D98qeBoxZ8rKv3Iwb4Nw2McXPEBeBqhGALLH7LIN
   NzPXBnPgHsa378zAgf2aBzYH3Acx9rnNle2hSmrLk0+RQhm2gX731JVuO
   6qrqEg4l9hRJ27kmm5e60U4+/lVmjTKNEoxHxehRVVI2SuhETPfcHjnTb
   Uj5iIl3qzHNs2dDVYiiUXjVhDFq4Wh5U6h5bl5KStPnMDNY5pLZE6Xgzw
   CwZInra4fnCsGZP/hmh6vOs0Kkq/7dohKZ+wNNi+2NSOydvNNNk4VMTlE
   g==;
X-CSE-ConnectionGUID: gEG1kUZJQnmr1L8lT21Weg==
X-CSE-MsgGUID: HRyERiq4T7e2zS2R9NDOrA==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467111"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:03:58 +0200
X-CheckPoint: {66C334AE-17-E9ED6009-C4B0BEC8}
X-MAIL-CPID: CC8392074D6D5F94FC03C398CD7CA761_3
X-Control-Analysis: str=0001.0A782F24.66C334AE.00FA,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAAC71657A4;
	Mon, 19 Aug 2024 14:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069034; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CyDUDb6WuXUW8dv4nW3tr3AH/eeOqQacQfm1Ie6rDGw=;
	b=XcSY19so5faHa9cGUTsycnweQU0DR1vI084cPGtA/4JzYBvO7afezf9t/PtumI2n/dAGQX
	SjcAons7sLb8cx8Wtr4RRGHrCjv/u1riYzp+X5ZZuqXJ03wq1Ff/3BcQS0fBY+TAUVtGTD
	eu+YeTssv6uldedW/txQz+VlqC8sPpyTlWFhquY2RuBXFy9I9xkUMA3Y7grKGJ5XzxWNFE
	Dt+bxWSaOw0xxf2e9j9aKadVuPxApfGyRqd2Hx8bZa1Wd+I156UIFDLp5knaSM023cHwi5
	qzVby8qVsEt/DkkL8fcExAxVrbClN3LUogSUojY8uJ36s8pG/xYPfwHQDh72oQ==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: enable LPSPI6 interface
Date: Mon, 19 Aug 2024 14:03:18 +0200
Message-Id: <20240819120328.229622-5-alexander.stein@ew.tq-group.com>
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

LPSPI6 features a NAFE13388 analog frontend.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index bbe0fcf97b2a5..f8b489e54bc96 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -414,6 +414,13 @@ dp_dsi_in: endpoint {
 	};
 };
 
+&lpspi6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi6>, <&pinctrl_lpspi6_cs>;
+	cs-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &lpuart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -607,6 +614,23 @@ MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x4000199e
 		>;
 	};
 
+	pinctrl_lpspi6: lpspi6grp {
+		fsl,pins = <
+			/* HYS | PD | FSEL_0 | DSE no drive */
+			MX93_PAD_GPIO_IO01__LPSPI6_SIN			0x1400
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO02__LPSPI6_SOUT			0x051e
+			MX93_PAD_GPIO_IO03__LPSPI6_SCK			0x051e
+		>;
+	};
+
+	pinctrl_lpspi6_cs: lpspi6csgrp {
+		fsl,pins = <
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO00__GPIO2_IO00			0x011e
+		>;
+	};
+
 	pinctrl_pcf85063: pcf85063grp {
 		fsl,pins = <
 			/* HYS | FSEL_0 | No DSE */
-- 
2.34.1


