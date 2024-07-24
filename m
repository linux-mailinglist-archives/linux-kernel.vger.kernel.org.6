Return-Path: <linux-kernel+bounces-260989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B80393B147
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DC81F25E21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880B158DA7;
	Wed, 24 Jul 2024 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nrtvN3Rz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HyIftHHb"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF815D5DE;
	Wed, 24 Jul 2024 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825977; cv=none; b=dXWB6yCODN6DmdrCjkf4Mp/ZH/V2D8x377r372wmc9eBFLTWmknKO2hCMujtlK5+HLaZEiSM/TrnYqYHYex4D3owYX7gKQHcDmLgwmjC9sSl27TcfOm9zM8x8kGzBN7p1MxJpj5kZuZbHMJFVfo5wfjPWhI2Mlp53PAR52AbcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825977; c=relaxed/simple;
	bh=L6lTnmdqDciCXaus7+UT0pbn48NWU1Z74mfO8TCkvnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gm7nKhg0jK51fjfObu0yFb5houLkI7kaYFVYDEqtVXYobARk8WldazPAvePFl/sMteLoxQmcB1yYrpvRmncrcgJ+4M21eY2/TEAy5d7qw1kcH0a7jhF0ukB9BH8DicB1OggItB6I+F10nH9uYX5CLcBYcjB0g6GOyPIMHC5Fnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nrtvN3Rz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HyIftHHb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825974; x=1753361974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoceoWjVztSwkDXYO7vCWx1e9yJOPZXKSyzWzXs2Xi8=;
  b=nrtvN3RzwSsMbFyyZHv+u2JNt7akTjcnOJFaXJJizXG9cWQLOVqh8dfY
   2PWVfYcgkOTqi3Wr+402FpQf47UKEdrdYEssgD2xhcmwSPqAFP21BV+i5
   G3Jh7nWeJD/2glCp47IUZdVskkE4sOB0qxNbKStINYg8o9OYfjgWVHO4f
   NSmqDRIjKPMRMjUxB4nOrrBjAxNQPORPUAILM8B4MhO5zP4FSVit8NpA+
   C6jmxSAYjraD4EG+9DwbcVTQAMa6eP8BPXxQoccwCxrppxD5OM+yaLMsL
   Fhq8WG6zY6Ldnti3u/ESgLI4ZSe1o2Ks1VFlfs7PLfgriLkCQr30ztJ7P
   w==;
X-CSE-ConnectionGUID: MLYIFc25Szuxt88BKeEWGw==
X-CSE-MsgGUID: oT1380lAQGq03yq5B6+/1g==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058835"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:33 +0200
X-CheckPoint: {66A0FAB5-12-6C016D47-F93F7C64}
X-MAIL-CPID: 845A4A7543469DE6F4592CDDDE2E19AA_0
X-Control-Analysis: str=0001.0A782F26.66A0FAB5.0175,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2F04163720;
	Wed, 24 Jul 2024 14:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825973; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OoceoWjVztSwkDXYO7vCWx1e9yJOPZXKSyzWzXs2Xi8=;
	b=HyIftHHbfG5w6VL84V1WETY7jrgXmigd2IIp4Rt2RT6Of2kaxpK/Da61vCWOIeYZag/UZo
	jrWmRiyrjJfyDm2dsM3I3RRNdG2tnk7UDCCneCOdn3cN6IsnJRTJnh6+V45viL6gnt8PYv
	ueUPDkQx5PcUj+GoYBiClaJSSoHmEEUb1yj055enUBs+d9bv51QcIjq2XgwOUTTxFlAcIU
	UwG0l+W71XpDTgNztPqCxb5VZBymKD1bNyr5qNjdZsuNfCL2qqVn6+3cGykSAN+Jm7C7E8
	dOgBzo+vlEkhGfwAfVssVUe8pEAAxChofGiRSZpqBu3Ff3SDuLcBV13+Micu1w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: add GPIO line names
Date: Wed, 24 Jul 2024 14:59:00 +0200
Message-Id: <20240724125901.1391698-14-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
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
index 8a64959e92cb..9a21fbf986fe 100644
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


