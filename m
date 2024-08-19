Return-Path: <linux-kernel+bounces-292036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DBE956A64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D8B221D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998F16A95E;
	Mon, 19 Aug 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ipTiGm5r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tTr4+WSv"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195E16DC2F;
	Mon, 19 Aug 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069091; cv=none; b=gQak77NbywignQH3x42Ir47RZOcj/byLZAXwD75w7To3s7kHqTjwAnetRlpJYXbpV3GwTy0DG5p1HXNd1dEhLsJZ3K6e5G0QTseCpSCczQhb20VKUzR3Zo4rm3mciCTACUxUITcD3JWGJ/qZ7xIlDotzIw07pNLhbdKJPNms784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069091; c=relaxed/simple;
	bh=b+PLG+ezWxae8DAKlzQPw0pyFkPfrTOSIryHMtMu79I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuHD02VgVDMd9U8mqSlNCt9XK9EPX3cxsQfsq6qjwxclVrwWNVLxAr8Jonxpn1IpE0g8iPo2ZL+RaYbFWPOZ/YnhzvMtzuN+3IvNRJdv3FoaCfTcijjYkgj9kjwT3P++roBPcN+U+mu25iFVIfnlShIpnGQEY2V3c7/yws3z3uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ipTiGm5r; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tTr4+WSv reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069089; x=1755605089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NH68B4ounFCN4GOrQp/scCfLXKmQGexl525mYrvvjos=;
  b=ipTiGm5rOJdtq/mbAF7aT1i+gcS5ra6EuHaeI0pBiFWi2SAJseaQEGt0
   +kyc7Kkgn2Wf4YJ1yn7aKyExFsB8ARYanopWUbXjYfnr5SKjNL+OoGW26
   jaBiT6Vu5YF+52QsezzqH7tJudL8Z4HrELZCScEnXNbMV/PrVgEzt7A0H
   Y1Rv53y3ADtW30Z452VmdSfBGzjELXVT0i//eYopxW+WwVZLaeNtj09Q2
   3OqejT7hiyJUp6C5dKXrP9z/+V57g5WZfP1R88fiSCJQlV7wzL3V+W6rB
   xGbpWuQd0XRyGVc/lx02HZzLLd85L8OwYsHx7cv60PE7TdQsE/hMrJW3F
   A==;
X-CSE-ConnectionGUID: Y5ngiW8LTnersZCIJq6OBg==
X-CSE-MsgGUID: GJ0HdLmGSACHgDAQOtqeNA==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467153"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:49 +0200
X-CheckPoint: {66C334E1-0-751552D8-F91D2344}
X-MAIL-CPID: 5F20051A3F2FEB06FF0870AB16C464CF_4
X-Control-Analysis: str=0001.0A782F19.66C334E1.0025,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D726D168925;
	Mon, 19 Aug 2024 14:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069084; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=NH68B4ounFCN4GOrQp/scCfLXKmQGexl525mYrvvjos=;
	b=tTr4+WSvZu45Soym4JcRsunP6IeUx7sGkesqzBtJgeqbo//ZNQBlTKkbNlM+zYnusAIy6M
	YJ6g6DEN977CLPIPEHt2AJJ4OrY4y8Nf7qgHDjN7uXMAPJYCHR9YzmcbGjsvIQlBKbZ2bZ
	1RSN33Kn0JL5CIODj57NfZegRwwv27x2NqDREJzS/6n8C9ZNIjSYq65VZEWu/R+cb6PBB9
	XpjmIfoqE1tSImY3pJRUZE+V6f5dh4wqpiI5grBTwZoo5C3xk+iVKHnYEDj67Juoy2HSf3
	DFzX0Dm50ApGbflVW80RFsK2II+6GmnfeupWm1ibVaVudjJEiv4M41YWcaZFTg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 13/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: add GPIO line names
Date: Mon, 19 Aug 2024 14:03:27 +0200
Message-Id: <20240819120328.229622-14-alexander.stein@ew.tq-group.com>
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Provide GPIO line names for userspace usage, e.g. libgpiod.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index b4795e2e2ebf7..79b9f13de4af5 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -276,6 +276,16 @@ &flexcan2 {
 };
 
 &gpio1 {
+	gpio-line-names =
+		/* 00 */ "", "", "USB_C_ALERT#", "PMIC_IRQ#",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "", "", "BM2_TEMP_EVENT_MOD#",
+		/* 12 */ "PEX_INT#", "", "RTC_EVENT#", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "", "",
+		/* 28 */ "", "", "", "";
+
 	expander-irq-hog {
 		gpio-hog;
 		gpios = <12 GPIO_ACTIVE_LOW>;
@@ -294,6 +304,40 @@ tcpc-irq-hog {
 &gpio2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio2>;
+
+	gpio-line-names =
+		/* 00 */ "SPI6_PCS0#", "", "", "",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "FAN_RPM", "MIPI_CSI_TRIGGER", "MIPI_CSI_SYNC",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "X1_11", "X1_21", "X1_17", "X1_13",
+		/* 20 */ "X1_15", "X1_9", "", "",
+		/* 24 */ "", "", "X1_7", "",
+		/* 28 */ "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		/* 00 */ "SD2_CD#", "", "", "",
+		/* 04 */ "", "", "", "SD2_RST#",
+		/* 08 */ "", "", "", "",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "ENET1_INT#", "ENET2_INT#",
+		/* 28 */ "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		/* 00 */ "", "", "", "",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "", "", "",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "", "",
+		/* 28 */ "", "DP_INT", "", "";
 };
 
 &lpi2c3 {
-- 
2.34.1


