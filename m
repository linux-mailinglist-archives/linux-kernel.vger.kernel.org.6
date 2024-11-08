Return-Path: <linux-kernel+bounces-401728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F79C1E72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F2283CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716971EF923;
	Fri,  8 Nov 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZaEXaQsL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="O2So4ga0"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39471EBA19;
	Fri,  8 Nov 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073788; cv=none; b=ZxAj4M+cnk9e42MWvciW2QW+Qy2Ex/jYxPBWXKqZrzwacG3VAPQUWiKrCxt1jWv/ty81CUCXz3KiGwzErzdZTXe60J3/nUtZgNSROivez5CJCl5cAVVjamaBQc4ZdNYhESG/N5AdC1yuWr0FBWPy2MUMY01hwDv6tbBtV8cG1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073788; c=relaxed/simple;
	bh=KiAP/W2+dqBSXLeFVL76gndUjxKa+rWMrzH7qvx+rlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gnxwxWJO7gkqQ8JgOB1KU7X10LOZrOdvLMV7NXubj9Bx4HQEtBFzDD72Y3f+LynsHRXIC4giH8mlpg3sBPuNdy7JiUoO1o/q/j5qBJuesFzsQupsWBMmXvo1HiZyy2AyZhhSgCJNrBG8rx/wYSxeAu+IBhQgkaAIlv72Zz8Y3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZaEXaQsL; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=O2So4ga0 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073785; x=1762609785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gkWYTfXRRhzmK8RFIzAG6O4Dq5zKISXppIUGrWAYD10=;
  b=ZaEXaQsLxgtMxFNbhzCl4LG6bhjZSh+qeSz5LzRTGFJBIq0ksIIuZeYR
   mm8hm6aUblXPxdE5FSOIL5Lolru5SmgtA7yIfwHLvbvakCtcVv6jFST4D
   Z0bZNloM+PWRFKnK0cIHWr9XRwKsfw09MA8pOVAfBOQYim+abQIeaVKfg
   jOB9N2x4QWnaCoYtf7Sg+E/uC8TJ+u04AQg/aC6gd3QLHBwW5FNum06nj
   9VIOTpLY3QNiPRNUdWjIGNbBXDlxhJE7vYsiGkDHJBByeZ3qHi+E784Bx
   X2upJ86RUvgULsoIrsVUruxsFRO8BY3II3r5lFQ2++gGFeVQ4QkUq9Ygr
   g==;
X-CSE-ConnectionGUID: kPpOHN7XRV2mGjpacNXANw==
X-CSE-MsgGUID: b5F5u3CQQmyGDjidvJU17A==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936918"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:49:37 +0100
X-CheckPoint: {672E16F1-4-1E10F2A5-CC0651E5}
X-MAIL-CPID: 1A141D1EC8B3A62498EA708BCD2F09ED_4
X-Control-Analysis: str=0001.0A682F26.672E16F1.0059,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FFF816353B;
	Fri,  8 Nov 2024 14:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073772; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=gkWYTfXRRhzmK8RFIzAG6O4Dq5zKISXppIUGrWAYD10=;
	b=O2So4ga0Fu4lZ8N0e1q945ooBxI3SbaJ+fcSzUgkkvOFl+8YcFFSxjjpzzLvKCLZCkOzDu
	X9d+WK/L4CTM09e8iBpU4Gd+3ykVjE0VPS+QYzBzZxoYR2oBeP/JYLJs3EoIwStjNmN55B
	uyFkcdwDmwOuk383T7ZLAPkj9e2K9AUNspHIM9Hfy1O59rQKEpUzleXbFYKN9MXxpbw8cW
	6mbGWwWEYbNWBUuFq2kqO2yZrodnZ1eebmcitTc1FiS+8a+v0BiPzQ7cU7RvfZ2ZLfoVPk
	WGMqhbeL0b8QRSLm4siNzrb3NIzzFB6laT5d52QvF1Ib1mT57q8tB/z32l+Oew==
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
Subject: [PATCH 0/8] TQMa7x DT cleanup
Date: Fri,  8 Nov 2024 14:49:18 +0100
Message-Id: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

this series fixes some DT binding check warnings as well as removing
duplicated nodes. Eventually IRQ support for thernet PHYs was added.
Additionally add CONFIG_JC42 to imx_v6_v7_defconfig.

Best regards,
Alexander

Alexander Stein (8):
  ARM: dts: imx7-mba7: remove LVDS transmitter regulator
  ARM: dts: imx7-tqma7: Remove superfluous status="okay" property
  ARM: dts: imx7-tqma7: add missing vs-supply for LM75A (rev. 01xxx)
  ARM: dts: imx7-mba7: Add 3.3V and 5.0V regulators
  ARM: dts: imx7-mba7: Fix SD card vmmc-supply
  ARM: dts: imx7-mba7: Remove duplicated power supply
  ARM: dts: imx7[d]-mba7: add Ethernet PHY IRQ support
  ARM: imx_v6_v7_defconfig: enable JC42 for TQMa7x

 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi  | 61 +++++++----------------
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi |  3 +-
 arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts  |  3 +-
 arch/arm/configs/imx_v6_v7_defconfig      |  1 +
 4 files changed, 21 insertions(+), 47 deletions(-)

-- 
2.34.1


