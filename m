Return-Path: <linux-kernel+bounces-403657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1569C38B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5252A281FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7201553A3;
	Mon, 11 Nov 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kvg7Qyqo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F481487F4;
	Mon, 11 Nov 2024 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308156; cv=none; b=Gz0iCWmePBrpucbYrd1arh0h4Lwu0LIh4gKDaq4IZnrV9cGrJ5CTHIK869w4InYi0NUvzZi+zCPjRTvBT9GomkcG/QsSRWZxNaYrGgR2yOxEcNj1jmpEuaLfwcoo0ooBldwWJ4hOWK7dnWR9ailjtfRJ1vnrlsOVCVSGa1bXBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308156; c=relaxed/simple;
	bh=aPMrsjI+c6iPJKbzOjnFcwEzzSVmYfrtlku2cTvvpw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EHJGgA6ijJglvVxWixKGZnKDi+xqvgIF5qyuAXNz+pSX5ebij9iP1u4fL49psXrU7WQ2BC6M3G4rNplMJUbSWHOBg3Q7hDvaMSFrFBXjRapx3f6Xd95vS3xhXNwdYCZXsZ3IUteZVJwP2oA2dRM5zQJEjxKoRkFFefxFDbli1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kvg7Qyqo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731308156; x=1762844156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aPMrsjI+c6iPJKbzOjnFcwEzzSVmYfrtlku2cTvvpw0=;
  b=kvg7QyqoM/0ZQakMiKA8C/nJHMArbl0c4iTT6BLu5Ej9fxIrhJUIF0q9
   rsQ92XO4QWBd/X5qiRSTnD6MH5B950bFx/dvajxJHRm0JQ+BixenmtG5r
   lr1IkuW1atGLjhgJXslpY1oPnmdPrCbvOtBDpfrRPoqvR3CEWDIOOESkT
   UDjRCyKHsErl61IJ8G5VJo5Ve5wAzNQlsTbnt4gIVkYC+uQGKYvG1p1uV
   yiYMG4Hn31lbWUj/aRF8uF1j+jjHDVESdWSgiWSz+EhWTQ92xfoZqEl2u
   xzAoNEPaopUNJGoL8aTdouebtTFmtp3gUTL/Q60Zr+SNdXxP9yDI0pQHV
   w==;
X-CSE-ConnectionGUID: ep4875LgSx6tm9VmeD6HJQ==
X-CSE-MsgGUID: Xs8eyJPZSGinRZUJIbtNZw==
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="265270146"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2024 23:55:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Nov 2024 23:55:15 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 10 Nov 2024 23:55:06 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dharma.b@microchip.com>,
	<hari.prasathge@microchip.com>, <varshini.rajendran@microchip.com>,
	<arnd@arndb.de>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v6 0/4] MIPI DSI Controller support for SAM9X75 series
Date: Mon, 11 Nov 2024 12:24:58 +0530
Message-ID: <20241111065502.411710-1-manikandan.m@microchip.com>
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

 .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 109 ++++
 MAINTAINERS                                   |   7 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   8 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c     | 545 ++++++++++++++++++
 6 files changed, 671 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/bridge/dw-mipi-dsi-mchp.c


base-commit: 4f537776340dab2b680a4d8554567f6884240d0b
-- 
2.25.1


