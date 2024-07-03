Return-Path: <linux-kernel+bounces-239585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564579262D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EADB26154
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083B17967E;
	Wed,  3 Jul 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="nw8XZRWd"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF21DA318
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015541; cv=fail; b=BqFFFyJrmFJ0o90FMLQmFMbR7aifuGRkngHgBagaWxnB4KQwTzZ4TNgXjlByBmKARlPAK04Ui4n3Al1ahQOf5UzGRyEHLYLQ59Xc6m6j0j8Sh/4K2UJNr3q1URfjg+SJ2tZkCldghldQa777AvQw/YIlmM7XqECTmyWr3W4NeAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015541; c=relaxed/simple;
	bh=YLyHybSX3+zB6VG4DWtXY3StcrR7v96jAx9FfNN+bqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdYpGGTwmyBZU5zHo01pwDCc589tLVOC2U+1qDrvwfSYuI1y5HYeSkE7nV+kA/sHu1+zmezzqwfaSgNCc1kkY5SoipilSWq+WmWnwXTsF/G5Gad0bp/kMqZV4NBbv2fcdlpei8mtDS3pGhv4xZiVA91OMdWU7it62StPqD0PimA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=nw8XZRWd; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9kvKE5LjKyV2kcwp17CPvzZmJnkZ4GdB3ayt60EEPYYCZCqY760RfQX4uOlv3EAu7rNSkkuuu5/8TSDpu1Vgtc97HAdL9V38RGMTbS030lMp1srVGi/b2vr8tF6CbOdbhCz057h+fy/24c9n+2H7bWBgOt0u8LHFpPSvyvORzuzNoPhdrdEqMw9bYBl2XE82e0d393L2THVm2xtNIyz+cJ9wCi1D9n8VVycGmSqgx2SjDiWm6t4jU4XlA8LLZ5PTgy4eMwCxGRt7gSweFEhBbHD2friXyhoMfr0d/UQmLFxe0s0pru6ZqkL/X33fC/F5FmjxgUdnLRC0AnZdh9MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72Pkxfxy4KUppT6FGmPWCZ0c7v/vM2SXFD9mQJ9dNPA=;
 b=Z4SZApwl7lEtUm9m1+DLGaVgbyC+gFZsoRl6TSkm0kM2nL0k5p3sLQ7ux5IR0vtfx8aBOi8yLqSv124JSgZYFpWyGeMyAMsFJ4ltbIj+a727G0WLQssBsT47rB7xbrO36jxiOepHBvwBVIxbRMfyX/83JYgq4a94sqnabjo9nTRvN48l7TzBAPnCE62WNbV8SVJzeVRje/5llVpJYvA7uqVjDY08l7X7z4v2JmE5MSx+suQCMe1D/rQxGIEfA8AeQUeWKALkeFZCa3Mf58E1qYcUDXNC+LHbHUoQMNneobfE7XVRhWCCd5WwuP4UmnCU2NiERnw8Lwe7cjjvNixeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72Pkxfxy4KUppT6FGmPWCZ0c7v/vM2SXFD9mQJ9dNPA=;
 b=nw8XZRWdOtGTdk36dqUjtqAzEg8lcIg6LgaVrD+NZOQhgEhAcZFlzt+6V7wOp83HST2ffNyOam0J+Xnqn6aVsPx2WkRBKDTPjWl3360H87XPQay+IUBIOjdULYAe1Kj6puQMmZI1ywEQhxuVRYGg+0JszjV5LOjJ1Bsgaogsa7E=
Received: from AS4P195CA0035.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::19)
 by PAXPR07MB8339.eurprd07.prod.outlook.com (2603:10a6:102:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 14:05:31 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::84) by AS4P195CA0035.outlook.office365.com
 (2603:10a6:20b:65a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 14:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 14:05:30 +0000
Received: from N9W6SW14.arri.de (10.30.4.245) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 3 Jul
 2024 16:05:29 +0200
From: Christian Eggers <ceggers@arri.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: David Lechner <david@lechnology.com>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?=
	<noralf@tronnes.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH] drm/tiny: Add support for Sitronix ST7539
Date: Wed, 3 Jul 2024 16:05:04 +0200
Message-ID: <20240703140504.8518-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|PAXPR07MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb1eaf9-cf4b-4266-88d8-08dc9b69327b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NZrl8zQxCaYWlKyNi0yQqCybFAU2lz87xtZ73p0LYCE5fHA6N6Xx/UX+JAoI?=
 =?us-ascii?Q?RvOehHW8B9RRC4eaCmRoKpEV+eYX9vHg22oQPjaDhuaCKx/ETAX8sMcIzO8M?=
 =?us-ascii?Q?13UUBnQVav+rNv5vP76hkoCItYmoN84+MJDsuyLQEFoWbMIlTbMTLnbeP+I9?=
 =?us-ascii?Q?P92DR7Vs4tDa1fa4wAPtNxY9zJwzW/3XIvi9/o5N8k3EiHwZf2lWvyWc0Vb/?=
 =?us-ascii?Q?dtQ30FTjMnTJt8n3weQsvBuAApOiWV+NZMzWdLBCq7KB4Ir9fTGq4iISvUQ/?=
 =?us-ascii?Q?/lAdWHtm59Q0Zr5fd9Z6MlfP+FpL0bHddPYs92yGl3vSchKEaJnAyVz0VULV?=
 =?us-ascii?Q?/fZqC3nVAQma7eCWGz4weZ0PL3qatTbQyIW+U3HZ82BYsfNPacZDlC/RP7c6?=
 =?us-ascii?Q?sZ2PM+mN4zDu6EuBk88ijdAe7i9POT0krFMfjOI9ZGlKLe0TBeHBlB5wxE3N?=
 =?us-ascii?Q?G8xNDu045WxUOHx3Vj87opXbWeYkZq2CYUlNWW1ukbEfv1xTxT9ROYFdZ6u1?=
 =?us-ascii?Q?ftia5x8SDHrgyW2dj3tDQMEn7JBvyflxMHEHHtYuF/xz2x+UjPJNWNXO500i?=
 =?us-ascii?Q?+ptlPKChTBsTDRbztAmd6BRXhqzyo5aVLHrI0A4qZx6ytISNbQTakRECa2PD?=
 =?us-ascii?Q?l59XDZkMkHEWDe1CnfviRb8USgu2gszedKLel1J9bZ3bTV37hsOXCaMJOfka?=
 =?us-ascii?Q?LVgo3QT9x6FqWLca4ldShzNNMKKgiJ6FDiNYmHHVgm3Gg2aN1LZGlM9MArZS?=
 =?us-ascii?Q?R2Q6DLw74+eIkMRlgeyxlyJyWDvLnBmFlctv2AaEyoF1EWLtw89a5vwfZGrz?=
 =?us-ascii?Q?hdrAtiKJCixifDYb82PGRC4T5yQFaFkQyoDZNUrhFY819sv5l2xIlxhhAPGS?=
 =?us-ascii?Q?lk3nFV1ofLuz9//w5CvaMcNZAhkjxHvOHBbK8UTYHChjEdPR6HsE0H/fzI06?=
 =?us-ascii?Q?AhqOJHXy3/Q0iHV0IuiHEm36W88iNN4kifV97ubN0PCGG4JTs1V6M5Qki9in?=
 =?us-ascii?Q?EQL0ZnnO3+euQHQ+8Sksy6u5KVev6lAPGiYacsI1rNgXCEefqxYyIJJzGdiD?=
 =?us-ascii?Q?qOUV6XmEgZw8wGpUdyFZ2HVCtU+HKwYVmLOpb++ARFWoSG8+S5SRqPquQ9SB?=
 =?us-ascii?Q?j+iSERubAlUGYLm4L4D/1r0kI3YJSFO0SZQQln8ZW0afZdWTFUs6RIgm5Vkq?=
 =?us-ascii?Q?9+hEVTmVVUUPHI/KdgTZEgQ8HxdaNJzj96Z0Yb/rSqrVYJaMylIwlpZgCLpS?=
 =?us-ascii?Q?Jg+fKhdAjkbu5XcBe2pFalqxSH7ARJo2Xd9xOcA0OomB9h+DC50jMWVZmVQ4?=
 =?us-ascii?Q?/oh35FSbx2LWOTtNLv67aW3f41Re08bguC+cjKCvZalhz8g0xUG/06P1iHpX?=
 =?us-ascii?Q?1K4GTWSEMOU2iIoU4NF7wYgZlmFp?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:05:30.0283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb1eaf9-cf4b-4266-88d8-08dc9b69327b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8339

Based on the existing ST7586 driver. But the ST7539 ...
- is monochrome only
- has 8 VERTICAL pixels per byte
- doesn't support any MIPI DCS commands
- has (a few) 16 bit commands
- doesn't support setting a clipping rect when writing to the RAM
- doesn't support rotation (only mirroring of X and/or Y axis)

Questions/TODO:
- should drivers for such old displays be mainlined?
- shall I use mipi_dbi_ although the display doesn't implement MIPI DCS
  (and has some 16 bit commands)?
- can the conversion to 8 vertical pixels/byte (taken from
  solomon/ssd130x.c) be avoided / simplified / made more efficient?
- how to implement setting of the display contrast (required by my
  application)?
- add device tree binding

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 MAINTAINERS                   |   6 +
 drivers/gpu/drm/tiny/Kconfig  |  11 +
 drivers/gpu/drm/tiny/Makefile |   1 +
 drivers/gpu/drm/tiny/st7539.c | 424 ++++++++++++++++++++++++++++++++++
 4 files changed, 442 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/st7539.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e7d543cf9f6c..7191206c1ae3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7116,6 +7116,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
 
+DRM DRIVER FOR SITRONIX ST7539 PANELS
+M:	Christian Eggers <ceggers@arri.de>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/tiny/st7539.c
+
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f6889f649bc1..220d2aee9354 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -186,6 +186,17 @@ config TINYDRM_REPAPER
 
 	  If M is selected the module will be called repaper.
 
+config TINYDRM_ST7539
+	tristate "DRM support for Sitronix ST7539 display panels"
+	depends on DRM && SPI
+	select DRM_KMS_HELPER
+	select DRM_GEM_DMA_HELPER
+	select DRM_MIPI_DBI
+	help
+	  DRM driver for Sitronix ST7539 panels.
+
+	  If M is selected the module will be called st7539.
+
 config TINYDRM_ST7586
 	tristate "DRM support for Sitronix ST7586 display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 76dde89a044b..0bd217779995 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
 obj-$(CONFIG_TINYDRM_ILI9486)		+= ili9486.o
 obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
 obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
+obj-$(CONFIG_TINYDRM_ST7539)		+= st7539.o
 obj-$(CONFIG_TINYDRM_ST7586)		+= st7586.o
 obj-$(CONFIG_TINYDRM_ST7735R)		+= st7735r.o
diff --git a/drivers/gpu/drm/tiny/st7539.c b/drivers/gpu/drm/tiny/st7539.c
new file mode 100644
index 000000000000..9a6aeea006ef
--- /dev/null
+++ b/drivers/gpu/drm/tiny/st7539.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DRM driver for Sitronix ST7539 panels
+ *
+ * Copyright 2024 Christian Eggers <ceggers@arri.de>
+ *
+ * based on st7586.c
+ * Copyright 2017 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+#include <video/mipi_display.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_fb_dma_helper.h>
+#include <drm/drm_fbdev_dma.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_mipi_dbi.h>
+#include <drm/drm_rect.h>
+
+/* controller-specific commands */
+#define ST7539_SET_COLUMN_ADDRESS_LSB(CA) (0x00 | ((CA) & 0x0f))
+#define ST7539_SET_COLUMN_ADDRESS_MSB(CA) (0x10 | (((CA) & 0xff) >> 4))
+#define ST7539_SET_SCROLL_LINE(x)    (0x40 | ((x) & 0x3f))
+#define ST7539_SET_CONTRAST           0x81    /* + 1 byte value */
+#define ST7539_SET_FPS__76            0xA0    /* 76 fps */
+#define ST7539_SET_FPS__95            0xA1    /* 95 fps */
+#define ST7539_SET_FPS__132           0xA2    /* 132 fps */
+#define ST7539_SET_FPS__168           0xA3    /* 168 fps */
+#define ST7539_SET_DISP_NORMAL        0xA6    /* non inverse */
+#define ST7539_SET_DISP_INVERSE       0xA7    /* inverse display */
+#define ST7539_SET_DISP_OFF           0xAE    /* display off and controller power down */
+#define ST7539_SET_DISP_ON            0xAF    /* display on and controller power on */
+#define ST7539_SET_PAGE_ADDRESS(PA)  (0xB0 | ((PA) & 0xf))
+#define ST7539_SET_SCAN_NORMAL        0xC0    /* MX=0, MY=0 */
+#define ST7539_SET_SCAN_X_INV         0xC2    /* MX=1, MY=0 */
+#define ST7539_SET_SCAN_Y_INV         0xC4    /* MX=0, MY=1 */
+#define ST7539_SET_SCAN_XY_INV        0xC6    /* MX=1, MY=1 */
+#define ST7539_SOFT_RESET             0xE2
+#define ST7539_NOP                    0xE3
+#define ST7539_SET_BIAS__1_6          0xE8    /* 1/6 */
+#define ST7539_SET_BIAS__1_7          0xE9    /* 1/7 */
+#define ST7539_SET_BIAS__1_8          0xEA    /* 1/8 */
+#define ST7539_SET_BIAS__1_9          0xEB    /* 1/9 */
+
+#define ST7539_HOR_RES 192
+#define ST7539_VER_RES 64
+
+/* slightly modified version of from mipi_dbi_typec3_command() */
+static int st7539_dbi_command_buf(struct mipi_dbi *dbi,
+				   u8 *cmd, size_t cmd_len,
+				   u8 *par, size_t num)
+{
+	struct spi_device *spi = dbi->spi;
+	u32 speed_hz;
+	int ret = 0;
+
+	spi_bus_lock(spi->controller);
+	gpiod_set_value_cansleep(dbi->dc, 0);
+	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, cmd_len);
+	ret = mipi_dbi_spi_transfer(spi, speed_hz, 8, cmd, cmd_len);
+	spi_bus_unlock(spi->controller);
+	if (ret || !num)
+		return ret;
+
+	spi_bus_lock(spi->controller);
+	gpiod_set_value_cansleep(dbi->dc, 1);
+	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
+	ret = mipi_dbi_spi_transfer(spi, speed_hz, 8, par, num);
+	spi_bus_unlock(spi->controller);
+
+	return ret;
+}
+
+/**
+ * st7539_dbi_command16 - Command with 2 bytes
+ * @dbi: MIPI DBI structure
+ * @cmd: Array of two command bytes
+ *
+ * Returns:
+ * Zero on success, negative error code on failure.
+ */
+static int st7539_dbi_command16(struct mipi_dbi *dbi, const u8 *cmd)
+{
+	u8 *cmdbuf;
+	int ret;
+
+	/* SPI requires dma-safe buffers */
+	cmdbuf = kmemdup(cmd, 2, GFP_KERNEL);
+	if (!cmdbuf)
+		return -ENOMEM;
+
+	mutex_lock(&dbi->cmdlock);
+	ret = st7539_dbi_command_buf(dbi, cmdbuf, 2, NULL, 0);
+	mutex_unlock(&dbi->cmdlock);
+
+	kfree(cmdbuf);
+
+	return ret;
+}
+
+static int st7539_dbi_typec3_command(struct mipi_dbi *dbi,
+				   u8 *cmd, u8 *par, size_t num)
+{
+	return st7539_dbi_command_buf(dbi, cmd, 1, par, num);
+}
+
+/*
+ * The ST7539 controller packs 8 VERTICAL pixels into one byte
+ * (similar as "page_address_mode" for SH1106 in drm/solomon/ssd130x.c).
+ */
+
+static void st7539_xrgb8888_to_mono(u8 *dst, struct iosys_map *src,
+				       struct drm_framebuffer *fb,
+				       struct drm_rect *clip,
+				       struct drm_format_conv_state *fmtcnv_state)
+{
+	u8 *buf;
+	struct iosys_map dst_map;
+
+	unsigned int width = drm_rect_width(clip);
+	unsigned int height = drm_rect_height(clip);
+	unsigned int line_length = DIV_ROUND_UP(width, 8);
+	unsigned int page_height = 8;
+	unsigned int pages = DIV_ROUND_UP(height, page_height);
+	size_t len = pages * width;
+	u32 array_idx = 0;
+	int i, j, k;
+
+	/* intermediate buffer (8 horizontal pixels per byte) */
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	iosys_map_set_vaddr(&dst_map, buf);
+	drm_fb_xrgb8888_to_mono(&dst_map, NULL, src, fb, clip, fmtcnv_state);
+
+	/* convert to 8 VERTICAL pixels per byte */
+	for (i = 0; i < pages; i++) {
+		for (j = 0; j < width; j++) {
+			u8 data = 0;
+
+			for (k = 0; k < 8; k++) {
+				u8 byte = buf[(8 * i + k) * line_length + j / 8];
+				u8 bit = !((byte >> (j % 8)) & 1);  /* invert pixels */
+
+				data |= bit << k;
+			}
+			dst[array_idx++] = data;
+		}
+	}
+
+	kfree(buf);
+}
+
+static int st7539_buf_copy(void *dst, struct iosys_map *src, struct drm_framebuffer *fb,
+			   struct drm_rect *clip, struct drm_format_conv_state *fmtcnv_state)
+{
+	int ret;
+
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret)
+		return ret;
+
+	st7539_xrgb8888_to_mono(dst, src, fb, clip, fmtcnv_state);
+
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+static void st7539_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
+			    struct drm_rect *rect, struct drm_format_conv_state *fmtcnv_state)
+{
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
+	struct mipi_dbi *dbi = &dbidev->dbi;
+	int start, end, ret = 0;
+
+	/* hardware doesn't support clipping of the column --> send full lines */
+	rect->x1 = 0;
+	rect->x2 = ST7539_HOR_RES;
+	/* 8 pixels per byte, so grow clip to nearest multiple of 8 */
+	rect->y1 = rounddown(rect->y1, 8);
+	rect->y2 = roundup(rect->y2, 8);
+
+	DRM_DEBUG_KMS("Flushing [FB:%d] " DRM_RECT_FMT "\n", fb->base.id, DRM_RECT_ARG(rect));
+
+	ret = st7539_buf_copy(dbidev->tx_buf, src, fb, rect, fmtcnv_state);
+	if (ret)
+		goto err_msg;
+
+	/* Pixels are packed 8 per byte */
+	start = rect->y1 / 8;
+	end = rect->y2 / 8;
+
+	mipi_dbi_command(dbi, ST7539_SET_COLUMN_ADDRESS_LSB(rect->x1 & 0xFF));
+	mipi_dbi_command(dbi, ST7539_SET_COLUMN_ADDRESS_MSB((rect->x1 >> 8) & 0xFF));
+
+	ret = mipi_dbi_command_buf(dbi, ST7539_SET_PAGE_ADDRESS(start),
+				   (u8 *)dbidev->tx_buf,
+				   (rect->x2 - rect->x1) * (end - start));
+err_msg:
+	if (ret)
+		dev_err_once(fb->dev->dev, "Failed to update display %d\n", ret);
+}
+
+static void st7539_pipe_update(struct drm_simple_display_pipe *pipe,
+			       struct drm_plane_state *old_state)
+{
+	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_rect rect;
+	int idx;
+
+	if (!pipe->crtc.state->active)
+		return;
+
+	if (!drm_dev_enter(fb->dev, &idx))
+		return;
+
+	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+		st7539_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
+				&shadow_plane_state->fmtcnv_state);
+
+	drm_dev_exit(idx);
+}
+
+static void st7539_pipe_enable(struct drm_simple_display_pipe *pipe,
+			       struct drm_crtc_state *crtc_state,
+			       struct drm_plane_state *plane_state)
+{
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct mipi_dbi *dbi = &dbidev->dbi;
+	struct drm_rect rect = {
+		.x1 = 0,
+		.x2 = fb->width,
+		.y1 = 0,
+		.y2 = fb->height,
+	};
+	int idx;
+
+	if (!drm_dev_enter(pipe->crtc.dev, &idx))
+		return;
+
+	DRM_DEBUG_KMS("\n");
+
+	/* Cannot use mipi_dbi_poweron_reset() here as the ST7539 has a non DCI
+	 * opcode for soft reset
+	 */
+	mipi_dbi_hw_reset(dbi);
+
+	mipi_dbi_command(dbi, ST7539_SOFT_RESET);
+	mipi_dbi_command(dbi, ST7539_SET_FPS__76);
+	mipi_dbi_command(dbi, ST7539_SET_BIAS__1_9);
+	st7539_dbi_command16(dbi, (u8[]){ST7539_SET_CONTRAST, 120});
+	mipi_dbi_command(dbi, ST7539_SET_SCAN_Y_INV);  /* ToDo: make this configurable */
+
+	st7539_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
+			&shadow_plane_state->fmtcnv_state);
+
+	mipi_dbi_command(dbi, ST7539_SET_DISP_ON);
+}
+
+static void st7539_pipe_disable(struct drm_simple_display_pipe *pipe)
+{
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
+
+	/*
+	 * This callback is not protected by drm_dev_enter/exit since we want to
+	 * turn off the display on regular driver unload. It's highly unlikely
+	 * that the underlying SPI controller is gone should this be called after
+	 * unplug.
+	 */
+
+	DRM_DEBUG_KMS("\n");
+
+	mipi_dbi_command(&dbidev->dbi, MIPI_DCS_SET_DISPLAY_OFF);
+}
+
+static const u32 st7539_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+static const struct drm_simple_display_pipe_funcs st7539_pipe_funcs = {
+	.mode_valid	= mipi_dbi_pipe_mode_valid,
+	.enable		= st7539_pipe_enable,
+	.disable	= st7539_pipe_disable,
+	.update		= st7539_pipe_update,
+	.begin_fb_access = mipi_dbi_pipe_begin_fb_access,
+	.end_fb_access	= mipi_dbi_pipe_end_fb_access,
+	.reset_plane	= mipi_dbi_pipe_reset_plane,
+	.duplicate_plane_state = mipi_dbi_pipe_duplicate_plane_state,
+	.destroy_plane_state = mipi_dbi_pipe_destroy_plane_state,
+};
+
+static const struct drm_display_mode st7539_mode = {
+	DRM_SIMPLE_MODE(ST7539_HOR_RES, ST7539_VER_RES, 57, 23),
+};
+
+DEFINE_DRM_GEM_DMA_FOPS(st7539_fops);
+
+static const struct drm_driver st7539_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.fops			= &st7539_fops,
+	DRM_GEM_DMA_DRIVER_OPS_VMAP,
+	.debugfs_init		= mipi_dbi_debugfs_init,
+	.name			= "st7539",
+	.desc			= "Sitronix ST7539",
+	.date			= "20240624",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static const struct of_device_id st7539_of_match[] = {
+	{ .compatible = "sitronix,st7539" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, st7539_of_match);
+
+static const struct spi_device_id st7539_id[] = {
+	{ "st7539", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, st7539_id);
+
+static int st7539_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct mipi_dbi_dev *dbidev;
+	struct drm_device *drm;
+	struct mipi_dbi *dbi;
+	struct gpio_desc *a0;
+	size_t bufsize;
+	int ret;
+
+	dbidev = devm_drm_dev_alloc(dev, &st7539_driver,
+				    struct mipi_dbi_dev, drm);
+	if (IS_ERR(dbidev))
+		return PTR_ERR(dbidev);
+
+	dbi = &dbidev->dbi;
+	drm = &dbidev->drm;
+
+	bufsize = DIV_ROUND_UP(st7539_mode.vdisplay, 8) * st7539_mode.hdisplay;
+
+	dbi->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(dbi->reset))
+		return dev_err_probe(dev, PTR_ERR(dbi->reset), "Failed to get GPIO 'reset'\n");
+
+	a0 = devm_gpiod_get(dev, "a0", GPIOD_OUT_LOW);
+	if (IS_ERR(a0))
+		return dev_err_probe(dev, PTR_ERR(a0), "Failed to get GPIO 'a0'\n");
+
+	ret = mipi_dbi_spi_init(spi, dbi, a0);
+	if (ret)
+		return ret;
+
+	/* override the command function set in mipi_dbi_spi_init() */
+	dbi->command = st7539_dbi_typec3_command;
+
+	/* Cannot read from this controller via SPI */
+	dbi->read_commands = NULL;
+
+	ret = mipi_dbi_dev_init_with_formats(dbidev, &st7539_pipe_funcs,
+					     st7539_formats, ARRAY_SIZE(st7539_formats),
+					     &st7539_mode, 0, bufsize);
+	if (ret)
+		return ret;
+
+	drm_mode_config_reset(drm);
+
+	ret = drm_dev_register(drm, 0);
+	if (ret)
+		return ret;
+
+	spi_set_drvdata(spi, drm);
+
+	drm_fbdev_dma_setup(drm, 0);
+
+	return 0;
+}
+
+static void st7539_remove(struct spi_device *spi)
+{
+	struct drm_device *drm = spi_get_drvdata(spi);
+
+	drm_dev_unplug(drm);
+	drm_atomic_helper_shutdown(drm);
+}
+
+static void st7539_shutdown(struct spi_device *spi)
+{
+	drm_atomic_helper_shutdown(spi_get_drvdata(spi));
+}
+
+static struct spi_driver st7539_spi_driver = {
+	.driver = {
+		.name = "st7539",
+		.of_match_table = st7539_of_match,
+	},
+	.id_table = st7539_id,
+	.probe = st7539_probe,
+	.remove = st7539_remove,
+	.shutdown = st7539_shutdown,
+};
+module_spi_driver(st7539_spi_driver);
+
+MODULE_DESCRIPTION("Sitronix ST7539 DRM driver");
+MODULE_AUTHOR("Christian Eggers <ceggers@arri.de>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


