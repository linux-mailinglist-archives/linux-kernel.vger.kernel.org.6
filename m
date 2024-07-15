Return-Path: <linux-kernel+bounces-252339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F449311D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F247CB22C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33618733E;
	Mon, 15 Jul 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yLvmndCo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95A1862AB;
	Mon, 15 Jul 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037485; cv=none; b=iTC7aQoRr5HWD2vBjWxIWkYJsupusR0Q+00hvM6u2xy0hYi0zVXuVs48qNkDAmQsTRy2e5alUXy+rZG3lZQWZFwwdoaY2KFhfgjj83/A7dvRUolSt/DIawO+wbkgFF9IRDbDE+SnGQdSHb0gSPCHgqxdTetwBhgwa56Uy9f1UIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037485; c=relaxed/simple;
	bh=nAt8VBS7wBWsqWXn67dHYCaAAYqSJWG1z+5IeoSpFRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0hBhLCYOBMKRqHy2jgoxttdu5pN+3ky8/gnilqx0O71idSCR+VA8gsP9YWRQCQ9E9fSunbLxF3pIag3Q167CC/Yh7i0L6QzoFolbG61ysEGb+fFhPATgSM3Q15ZdMF3PAi57AMiq8+L2pfuad9Jk7xOoPLzWlqBWuu9Y+TvFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yLvmndCo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721037484; x=1752573484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nAt8VBS7wBWsqWXn67dHYCaAAYqSJWG1z+5IeoSpFRA=;
  b=yLvmndCoeTAgDhSaLFiXTx+LG/KVPXs6uVBbR9qb/2ZOBsGohZFOHq49
   gJia6XLUCqRruYdxcJIu1Nhl+F04NBJn04Nbcm3ryLNQwDfptGYL1ipIO
   1DREtwq5Qpkx3je0Mj8Q3u2KY0VoZXpTAj0bymfoB1BBS/WJxjM6p6zu+
   Y/RPn8fbfwKgWzXXLkK+X2iSI7CZemjS6D9YH5ANOhWT2bmcsvLWEngCV
   7UxbY5yVkI5nEfMyy4uAdl5L12m4e7EIr4MZDDJX8mre3y8rrLYY3IQ8+
   rHPFgbwRR8fRZG/MsWLn8s3F17hszpBYPn0tPOaYS5nIqRp5V/egi6GN2
   A==;
X-CSE-ConnectionGUID: f2RA4CzOQFeHP4RB67Wxuw==
X-CSE-MsgGUID: AsO29LzERRaTouRrGMLJqg==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="29237561"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 02:57:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 02:57:51 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jul 2024 02:57:40 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <Jason@zx2c4.com>,
	<rdunlap@infradead.org>, <akpm@linux-foundation.org>,
	<geert+renesas@glider.be>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>, <Hari.PrasathGE@microchip.com>,
	<Nicolas.Ferre@microchip.com>
Subject: [PATCH v2 0/4] MIPI DSI Controller support for SAM9X75 series
Date: Mon, 15 Jul 2024 15:27:32 +0530
Message-ID: <20240715095736.618246-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the Microchip's MIPI DSI Controller
wrapper driver that uses the Synopsys DesignWare MIPI DSI host controller
bridge for SAM9X75 SoC series.

Changelogs are available in respective patches.

Manikandan Muralidharan (4):
  dt-bindings: display: bridge: add sam9x75-mipi-dsi binding
  drm/bridge: add Microchip DSI controller support for sam9x7 SoC series
  MAINTAINERS: add SAM9X7 SoC's Microchip's MIPI DSI host wrapper driver
  ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller
    support

 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 116 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   8 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c     | 546 ++++++++++++++++++
 6 files changed, 679 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c

-- 
2.25.1


