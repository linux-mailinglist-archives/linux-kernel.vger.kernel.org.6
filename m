Return-Path: <linux-kernel+bounces-401731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3062E9C1E78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40CC282E61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CDB1F583D;
	Fri,  8 Nov 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EOnDrGRZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CLaWFqzb"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C01F470C;
	Fri,  8 Nov 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073795; cv=none; b=Z84AxU89IStCgmfg9t0JDWbUheBCCQ7hzCAr94KIADRqa2q0NnidZFhI4VVLKl/VlZEmWGd+lAP3PiOvJzOWNc8MQtWKKL9cAcd+aOpNtix0U1qH1H+g+xvGJKRwkxRty8p6sQ0JyJVKt2I6QihDh+7Ub+aQjvZiq2/NZ7r/P14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073795; c=relaxed/simple;
	bh=aCBfSx5ga7pj2Hhamx5vaPscCNi3wQymN503IgykoPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSm+GNzxsCogRCmFgzVteig1ycEOPfve+YOrJJO7JoyIQTPP/6ErEqFhH9j9lQ+RZii/V9ZFCq+/8bSo+chYiqdaBL4Ul4PlB2WM2jvHpl2zBxL9UTNTIzAZpb1LKC+BMr+6H1sneU+5Hal6+st7t2U+wd7G6dIvaoQz8Ru50Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EOnDrGRZ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CLaWFqzb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073793; x=1762609793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5n323UXrPp5uudp6Hu5dvoIoBuE/xHbBKXp9ytYca4=;
  b=EOnDrGRZFhUxEubZqBVMbyZSiFw7tUpM4iR/Npn59jcEETCAprgQSfyT
   l/7gk5IBDPMd2BAdkGIt8a7gpRK6mP1T1LYnXemgsiV4o0PE31d3oO60/
   n+gCaCzDC2scrlZ3jsCXMD/JLjEbLLiXwph9n3et/4oER5W+m6v56P2/8
   TtA5ANN/iucEs6b1d+5UpmRkX2MbscHPNkuMTYD3GpZ8Re5Vt6CCHDsTo
   Xbjg1nFUD8jXX+aHmVo7Q4RfOhOfFD72dK/gvHJDNFChO2zTgc08m5j1e
   psIFhqhFVf9qe60YEX6fvkGcRmotsSVfpiTIG/ApJNHv3VCBD7gN8u5xH
   g==;
X-CSE-ConnectionGUID: kI+aj7XnR4C+APTkXdKzqg==
X-CSE-MsgGUID: wnAiSrcLTs6RMK/QnJbJqw==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936928"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:49:52 +0100
X-CheckPoint: {672E1700-1E-86C05612-CA75E1CA}
X-MAIL-CPID: 98C61AF8CE5227264DCC1B41E75CB408_1
X-Control-Analysis: str=0001.0A682F2A.672E1701.0010,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B63C816528A;
	Fri,  8 Nov 2024 14:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073788; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=K5n323UXrPp5uudp6Hu5dvoIoBuE/xHbBKXp9ytYca4=;
	b=CLaWFqzbYQhqqkJvBP9b9GlqzyBAOllrLxcKE8UyXS1soo612hpG4eF8DCIm7aR0zQpPCU
	3f54K20btAoC5/06OfMXy1hOyiQoTbCZvbNP/gYWY9+LEFK9mivt7AGplj7yozMaS7gG8A
	efisn+KuZAZXQ9tUIGKgB0f+EMjF0Wl6BJTJPdiaOIRxSROA2XtyTc4YBcDymAVr0X9D+u
	6Y+GnI5y0AqhaU/lWWi20WGvrVhEl0aiGh7unM2RyZm16xpvJuGO/cdFBmLkvgab2HieWE
	kcD8uIW5M6tagjDFVwZRoB7wV8cbts3exQRZ8ojOwWRR37Wl1dZuUvkKcplYag==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] ARM: dts: imx7-tqma7: add missing vs-supply for LM75A (rev. 01xxx)
Date: Fri,  8 Nov 2024 14:49:21 +0100
Message-Id: <20241108134926.1324626-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add missing supply for LM75. Fixes the kernel warning:
  lm75 0-0048: supply vs not found, using dummy regulator

Fixes: c9d4affbe60a ("ARM: dts: imx: tqma7: add lm75a sensor (rev. 01xxx)")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
index 656ab0562695b..aa8f65cd4adf7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi
@@ -135,6 +135,7 @@ vgen6_reg: vldo4 {
 	lm75a: temperature-sensor@48 {
 		compatible = "national,lm75a";
 		reg = <0x48>;
+		vs-supply = <&vgen4_reg>;
 	};
 
 	/* NXP SE97BTP with temperature sensor + eeprom, TQMa7x 02xx */
-- 
2.34.1


