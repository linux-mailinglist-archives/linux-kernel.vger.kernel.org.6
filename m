Return-Path: <linux-kernel+bounces-260976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159893B12E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19ADB286973
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F6B158DCC;
	Wed, 24 Jul 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="K6IFPlQh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YPMbgdHe"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712D158A3F;
	Wed, 24 Jul 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825960; cv=none; b=CrZRXgqJ28DxOgO9vGUFdzVFVK+zH852gICDJhlmr9MZQv1G8VcqkqAC3UmYcbxAcVnsjoCcT3gVzvo1vGd+Qe1QIJRY23xxjnbt1Wzk8Td7C3wLsiiSeTuQRRqLKy/3vksXORxsD0sg6Jj1uE39eFoxOIXjtRa2EFTp+Cd+KYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825960; c=relaxed/simple;
	bh=BjLz3vvlKoIFphRRwm9pVGCXXoqHf2HFuzlo+D5Mmhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnST3SHRTS5vkgr6r5mbEzFl4J7um6ulK0gNraFqUu2EShdwKy2A//KsyEgf5SzzKTBa30SaMjbn3QW96HR4RVSxXCnm54qWV4NPKFplzenbIyKVAYxczxg+4TKloKS7OHNYdir3XuW4TjaWVP96/gH9a96WRsH3HoZqo2pzgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=K6IFPlQh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YPMbgdHe reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825957; x=1753361957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xrLriYpIHkASuQ0PhpaaclUZukREhQCI/m6LAzkECy4=;
  b=K6IFPlQhCkrS8TDy45kILmuLAZNpNxRUu7FhAmNiY5NPdTboDv5VVl3g
   ANHeDWAqhq/wYAoSA5mGnbDqYKoBSat1N5f87F0Hlpder4hnM+dgkXK02
   OpJvguaCZVo0+8dwJVoxBlrX+yIH6M0jqT8xaJ1sxtMyuYO+PSgrfjuuq
   WsjEt3gP06hWwOldYRppzWmYF66UYFGvE/3e1lALdDXyr6/Mq7Afwtp83
   LgmJw8v/0gtHdK6efayxxN1pM1Pzu8PnMsMKvm9M3EjXms3A3Z4zBzgbA
   gLnxsB5Ok8/wAE2O5PCzZaD+rjQKX/297b+nxYEZ9h+zvRn+Aojr5B/pM
   g==;
X-CSE-ConnectionGUID: 36PoJbGKRVaEZ6kxLE6ZzQ==
X-CSE-MsgGUID: xG9v/kseTh2C/YF+7vR4Nw==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058820"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:08 +0200
X-CheckPoint: {66A0FA9C-19-6C016D47-F93F7C64}
X-MAIL-CPID: 2CF9144EBBBA82907B2D39FA10BE1A90_0
X-Control-Analysis: str=0001.0A782F17.66A0FA9C.0190,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34309160A85;
	Wed, 24 Jul 2024 14:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825948; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=xrLriYpIHkASuQ0PhpaaclUZukREhQCI/m6LAzkECy4=;
	b=YPMbgdHetOion5w6ieCRISjWvy4w10b9Y1+L6noXrF0EV3s4hcrSY4yefqun3q7prrJ1+C
	stxVxtWN2hTI73jJwkkVTgJHd93UnZBgwpEO7U8MhCrKqacAyL5EFfCR2jV84RIPLcQuva
	t3rnUHZeNT8pTEjk7iu4Xm/R0JgGeux3e9MP4Zlu14NneSC7+85pphQNp9ExN69y0GUCkg
	Ky1WY0cJA2mn78IyfLQ1yfOyb9sd0TiS+c21hzxNajOvjrexuaRZ0QKQpw28V7N5OVAwdr
	GcAONgPLG1s3cleC/dlzEl4L2CQhsNubVW4t9w4W++7dVD1xFWf5xlDzJ0IOjg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] TQMa93xx improvements
Date: Wed, 24 Jul 2024 14:58:47 +0200
Message-Id: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
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

this series add improvements for the TQMa93xx series.
Despite changes for pad configuration as requested form hardware team, this also
adds the PMIC node which allows to specify correct supplies for e.g. eMMC.
Also GPIO lin enames are added for userspace usage using e.g. libgpiod.
This series also includes a workaround for USDHCI errata.

Best regards,
Alexander

Alexander Stein (4):
  arm64: dts: freescale: imx93-tqma9352: Add PMIC node
  arm64: dts: freescale: imx93-tqma9352: add eMMC regulators
  arm64: dts: freescale: imx93-tqma9352-mba91xxla: Add ethernet aliases
  arm64: dts: freescale: imx93-tqma9352-mba91xxca: Add ethernet aliases

Markus Niebel (10):
  arm64: dts: freescale: imx93-tqma9352: fix CMA alloc-ranges
  arm64: dts: freescale: imx93-tqma9352: improve pad configuration
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: fix typo
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: improve pad
    configuration
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: add irq for temp
    sensor
  arm64: dts: freescale: imx93-tqma9352-mba93xxla: add GPIO line names
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: improve pad
    configuration
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: add RTC / temp sensor
    IRQ
  arm64: dts: freescale: imx93-tqma9352-mba93xxca: add GPIO line names
  arm64: dts: freescale: imx93-tqma9352: set SION for cmd and data pad
    of USDHC

 .../freescale/imx93-tqma9352-mba93xxca.dts    | 299 ++++++++++++-----
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 308 +++++++++++++-----
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 174 +++++++---
 3 files changed, 581 insertions(+), 200 deletions(-)

-- 
2.34.1


