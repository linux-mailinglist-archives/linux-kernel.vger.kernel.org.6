Return-Path: <linux-kernel+bounces-259577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822299398C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062991F22695
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A813BC0E;
	Tue, 23 Jul 2024 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wznchvlM"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CFF13B2AF;
	Tue, 23 Jul 2024 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721707123; cv=none; b=EiRyen4gBk9MbmN8ACU62qyCX5uJJHf09DroMPryIKDR9hGzlyRRH+qiSwm/EmhBYO6ZPwvZtIdjE+UBcjndl8zaZwVTQ1lL5csb5bCfSw3M/nrFZjwcV4CjMzYaUiGc9VVRfti07Fr2uYuXOaJODDpRuAjJ8enN2ny65MzrMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721707123; c=relaxed/simple;
	bh=QaZPBdRXBnNoYC6POAWTe568FVBvdK9ANZJdsYar81g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AAuz78CMHllYCE1NsX1ppmlYhw92W7Vxntik6Y+w1O8r1sm8JAA9fCsSKf7dfKMViy13Hvm2s2QxNmaTWh/mjqTGbMaQlqv7J++WWcwn1+VkWhPcJF+TBLk0NK8aK+o0yKtryDHqob18lVkLkSyTjcRjUw6KaX9Ite6JRl1LAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wznchvlM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46N3vtrs130337;
	Mon, 22 Jul 2024 22:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721707075;
	bh=QY0MlLrj3g0NYSWIJXB1RRjSGvQ4ni/mPVy92zAq0DQ=;
	h=From:To:CC:Subject:Date;
	b=wznchvlMUwY7qxZ1e09HwNyQN3N0cDQd5M6ME0OYOVjsFsgZlu8B6CVItvtargVxN
	 Js8+rohHteQkRZb4JEiOjD3QEvsvzihSJxC8t8OHGbjqEl5rKE7WPTSGiJnMml0lMx
	 l6OUzYKtiaH1fwxQo6kWUOGhTF2GILd/3zS6j0Mk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46N3vtUW010354
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jul 2024 22:57:55 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jul 2024 22:57:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jul 2024 22:57:54 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.245])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46N3vlVq070234;
	Mon, 22 Jul 2024 22:57:48 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-firmware@kernel.org>
CC: <kevin-lu@ti.com>, <baojun.xu@ti.com>, <13916275206@139.com>,
        <v-po@ti.com>, <linux-sound@vger.kernel.org>, <robinchen@ti.com>,
        <linux-kernel@vger.kernel.org>, <mimperial@lenovo.com>,
        <cchen50@lenovo.com>, <soyer@irl.hu>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoc: tas2781: Move tas2563_dvc_table into a separate Header file
Date: Tue, 23 Jul 2024 11:57:34 +0800
Message-ID: <20240723035735.332-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563_dvc_table into a separate Header file, as only tas2781
codec driver use this table, and hda side codec driver won't use it.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - | Reported-by: kernel test robot <lkp@intel.com>
   | Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202407131659.uSVINfrZ-lkp@intel.com/__;!!G3vK!QyZeGtz-H
 - Create tas2563-tlv.h into include/sound
 - Move tas2563_dvc_table from tas2781-tlv.h to tas2563-tlv.h
 - Add "#include <sound/tas2563-tlv.h>" into tas2781-i2c.c
---
 include/sound/tas2563-tlv.h    | 279 +++++++++++++++++++++++++++++++++
 include/sound/tas2781-tlv.h    | 260 ------------------------------
 sound/soc/codecs/tas2781-i2c.c |   1 +
 3 files changed, 280 insertions(+), 260 deletions(-)
 create mode 100644 include/sound/tas2563-tlv.h

diff --git a/include/sound/tas2563-tlv.h b/include/sound/tas2563-tlv.h
new file mode 100644
index 000000000000..2dab81a4c359
--- /dev/null
+++ b/include/sound/tas2563-tlv.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2563 Audio Smart Amplifier
+//
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2563 driver implements a flexible and configurable
+// algo coefficient setting for one, two, or even multiple
+// TAS2563 chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+//
+
+#ifndef __TAS2563_TLV_H__
+#define __TAS2563_TLV_H__
+
+static const DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
+
+/* pow(10, db/20) * pow(2,30) */
+static const unsigned char tas2563_dvc_table[][4] = {
+	{ 0X00, 0X00, 0X00, 0X00 }, /* -121.5db */
+	{ 0X00, 0X00, 0X03, 0XBC }, /* -121.0db */
+	{ 0X00, 0X00, 0X03, 0XF5 }, /* -120.5db */
+	{ 0X00, 0X00, 0X04, 0X31 }, /* -120.0db */
+	{ 0X00, 0X00, 0X04, 0X71 }, /* -119.5db */
+	{ 0X00, 0X00, 0X04, 0XB4 }, /* -119.0db */
+	{ 0X00, 0X00, 0X04, 0XFC }, /* -118.5db */
+	{ 0X00, 0X00, 0X05, 0X47 }, /* -118.0db */
+	{ 0X00, 0X00, 0X05, 0X97 }, /* -117.5db */
+	{ 0X00, 0X00, 0X05, 0XEC }, /* -117.0db */
+	{ 0X00, 0X00, 0X06, 0X46 }, /* -116.5db */
+	{ 0X00, 0X00, 0X06, 0XA5 }, /* -116.0db */
+	{ 0X00, 0X00, 0X07, 0X0A }, /* -115.5db */
+	{ 0X00, 0X00, 0X07, 0X75 }, /* -115.0db */
+	{ 0X00, 0X00, 0X07, 0XE6 }, /* -114.5db */
+	{ 0X00, 0X00, 0X08, 0X5E }, /* -114.0db */
+	{ 0X00, 0X00, 0X08, 0XDD }, /* -113.5db */
+	{ 0X00, 0X00, 0X09, 0X63 }, /* -113.0db */
+	{ 0X00, 0X00, 0X09, 0XF2 }, /* -112.5db */
+	{ 0X00, 0X00, 0X0A, 0X89 }, /* -112.0db */
+	{ 0X00, 0X00, 0X0B, 0X28 }, /* -111.5db */
+	{ 0X00, 0X00, 0X0B, 0XD2 }, /* -111.0db */
+	{ 0X00, 0X00, 0X0C, 0X85 }, /* -110.5db */
+	{ 0X00, 0X00, 0X0D, 0X43 }, /* -110.0db */
+	{ 0X00, 0X00, 0X0E, 0X0C }, /* -109.5db */
+	{ 0X00, 0X00, 0X0E, 0XE1 }, /* -109.0db */
+	{ 0X00, 0X00, 0X0F, 0XC3 }, /* -108.5db */
+	{ 0X00, 0X00, 0X10, 0XB2 }, /* -108.0db */
+	{ 0X00, 0X00, 0X11, 0XAF }, /* -107.5db */
+	{ 0X00, 0X00, 0X12, 0XBC }, /* -107.0db */
+	{ 0X00, 0X00, 0X13, 0XD8 }, /* -106.5db */
+	{ 0X00, 0X00, 0X15, 0X05 }, /* -106.0db */
+	{ 0X00, 0X00, 0X16, 0X44 }, /* -105.5db */
+	{ 0X00, 0X00, 0X17, 0X96 }, /* -105.0db */
+	{ 0X00, 0X00, 0X18, 0XFB }, /* -104.5db */
+	{ 0X00, 0X00, 0X1A, 0X76 }, /* -104.0db */
+	{ 0X00, 0X00, 0X1C, 0X08 }, /* -103.5db */
+	{ 0X00, 0X00, 0X1D, 0XB1 }, /* -103.0db */
+	{ 0X00, 0X00, 0X1F, 0X73 }, /* -102.5db */
+	{ 0X00, 0X00, 0X21, 0X51 }, /* -102.0db */
+	{ 0X00, 0X00, 0X23, 0X4A }, /* -101.5db */
+	{ 0X00, 0X00, 0X25, 0X61 }, /* -101.0db */
+	{ 0X00, 0X00, 0X27, 0X98 }, /* -100.5db */
+	{ 0X00, 0X00, 0X29, 0XF1 }, /* -100.0db */
+	{ 0X00, 0X00, 0X2C, 0X6D }, /* -99.5db */
+	{ 0X00, 0X00, 0X2F, 0X0F }, /* -99.0db */
+	{ 0X00, 0X00, 0X31, 0XD9 }, /* -98.5db */
+	{ 0X00, 0X00, 0X34, 0XCD }, /* -98.0db */
+	{ 0X00, 0X00, 0X37, 0XEE }, /* -97.5db */
+	{ 0X00, 0X00, 0X3B, 0X3F }, /* -97.0db */
+	{ 0X00, 0X00, 0X3E, 0XC1 }, /* -96.5db */
+	{ 0X00, 0X00, 0X42, 0X79 }, /* -96.0db */
+	{ 0X00, 0X00, 0X46, 0X6A }, /* -95.5db */
+	{ 0X00, 0X00, 0X4A, 0X96 }, /* -95.0db */
+	{ 0X00, 0X00, 0X4F, 0X01 }, /* -94.5db */
+	{ 0X00, 0X00, 0X53, 0XAF }, /* -94.0db */
+	{ 0X00, 0X00, 0X58, 0XA5 }, /* -93.5db */
+	{ 0X00, 0X00, 0X5D, 0XE6 }, /* -93.0db */
+	{ 0X00, 0X00, 0X63, 0X76 }, /* -92.5db */
+	{ 0X00, 0X00, 0X69, 0X5B }, /* -92.0db */
+	{ 0X00, 0X00, 0X6F, 0X99 }, /* -91.5db */
+	{ 0X00, 0X00, 0X76, 0X36 }, /* -91.0db */
+	{ 0X00, 0X00, 0X7D, 0X37 }, /* -90.5db */
+	{ 0X00, 0X00, 0X84, 0XA2 }, /* -90.0db */
+	{ 0X00, 0X00, 0X8C, 0X7E }, /* -89.5db */
+	{ 0X00, 0X00, 0X94, 0XD1 }, /* -89.0db */
+	{ 0X00, 0X00, 0X9D, 0XA3 }, /* -88.5db */
+	{ 0X00, 0X00, 0XA6, 0XFA }, /* -88.0db */
+	{ 0X00, 0X00, 0XB0, 0XDF }, /* -87.5db */
+	{ 0X00, 0X00, 0XBB, 0X5A }, /* -87.0db */
+	{ 0X00, 0X00, 0XC6, 0X74 }, /* -86.5db */
+	{ 0X00, 0X00, 0XD2, 0X36 }, /* -86.0db */
+	{ 0X00, 0X00, 0XDE, 0XAB }, /* -85.5db */
+	{ 0X00, 0X00, 0XEB, 0XDC }, /* -85.0db */
+	{ 0X00, 0X00, 0XF9, 0XD6 }, /* -84.5db */
+	{ 0X00, 0X01, 0X08, 0XA4 }, /* -84.0db */
+	{ 0X00, 0X01, 0X18, 0X52 }, /* -83.5db */
+	{ 0X00, 0X01, 0X28, 0XEF }, /* -83.0db */
+	{ 0X00, 0X01, 0X3A, 0X87 }, /* -82.5db */
+	{ 0X00, 0X01, 0X4D, 0X2A }, /* -82.0db */
+	{ 0X00, 0X01, 0X60, 0XE8 }, /* -81.5db */
+	{ 0X00, 0X01, 0X75, 0XD1 }, /* -81.0db */
+	{ 0X00, 0X01, 0X8B, 0XF7 }, /* -80.5db */
+	{ 0X00, 0X01, 0XA3, 0X6E }, /* -80.0db */
+	{ 0X00, 0X01, 0XBC, 0X48 }, /* -79.5db */
+	{ 0X00, 0X01, 0XD6, 0X9B }, /* -79.0db */
+	{ 0X00, 0X01, 0XF2, 0X7E }, /* -78.5db */
+	{ 0X00, 0X02, 0X10, 0X08 }, /* -78.0db */
+	{ 0X00, 0X02, 0X2F, 0X51 }, /* -77.5db */
+	{ 0X00, 0X02, 0X50, 0X76 }, /* -77.0db */
+	{ 0X00, 0X02, 0X73, 0X91 }, /* -76.5db */
+	{ 0X00, 0X02, 0X98, 0XC0 }, /* -76.0db */
+	{ 0X00, 0X02, 0XC0, 0X24 }, /* -75.5db */
+	{ 0X00, 0X02, 0XE9, 0XDD }, /* -75.0db */
+	{ 0X00, 0X03, 0X16, 0X0F }, /* -74.5db */
+	{ 0X00, 0X03, 0X44, 0XDF }, /* -74.0db */
+	{ 0X00, 0X03, 0X76, 0X76 }, /* -73.5db */
+	{ 0X00, 0X03, 0XAA, 0XFC }, /* -73.0db */
+	{ 0X00, 0X03, 0XE2, 0XA0 }, /* -72.5db */
+	{ 0X00, 0X04, 0X1D, 0X8F }, /* -72.0db */
+	{ 0X00, 0X04, 0X5B, 0XFD }, /* -71.5db */
+	{ 0X00, 0X04, 0X9E, 0X1D }, /* -71.0db */
+	{ 0X00, 0X04, 0XE4, 0X29 }, /* -70.5db */
+	{ 0X00, 0X05, 0X2E, 0X5A }, /* -70.0db */
+	{ 0X00, 0X05, 0X7C, 0XF2 }, /* -69.5db */
+	{ 0X00, 0X05, 0XD0, 0X31 }, /* -69.0db */
+	{ 0X00, 0X06, 0X28, 0X60 }, /* -68.5db */
+	{ 0X00, 0X06, 0X85, 0XC8 }, /* -68.0db */
+	{ 0X00, 0X06, 0XE8, 0XB9 }, /* -67.5db */
+	{ 0X00, 0X07, 0X51, 0X86 }, /* -67.0db */
+	{ 0X00, 0X07, 0XC0, 0X8A }, /* -66.5db */
+	{ 0X00, 0X08, 0X36, 0X21 }, /* -66.0db */
+	{ 0X00, 0X08, 0XB2, 0XB0 }, /* -65.5db */
+	{ 0X00, 0X09, 0X36, 0XA1 }, /* -65.0db */
+	{ 0X00, 0X09, 0XC2, 0X63 }, /* -64.5db */
+	{ 0X00, 0X0A, 0X56, 0X6D }, /* -64.0db */
+	{ 0X00, 0X0A, 0XF3, 0X3C }, /* -63.5db */
+	{ 0X00, 0X0B, 0X99, 0X56 }, /* -63.0db */
+	{ 0X00, 0X0C, 0X49, 0X48 }, /* -62.5db */
+	{ 0X00, 0X0D, 0X03, 0XA7 }, /* -62.0db */
+	{ 0X00, 0X0D, 0XC9, 0X11 }, /* -61.5db */
+	{ 0X00, 0X0E, 0X9A, 0X2D }, /* -61.0db */
+	{ 0X00, 0X0F, 0X77, 0XAD }, /* -60.5db */
+	{ 0X00, 0X10, 0X62, 0X4D }, /* -60.0db */
+	{ 0X00, 0X11, 0X5A, 0XD5 }, /* -59.5db */
+	{ 0X00, 0X12, 0X62, 0X16 }, /* -59.0db */
+	{ 0X00, 0X13, 0X78, 0XF0 }, /* -58.5db */
+	{ 0X00, 0X14, 0XA0, 0X50 }, /* -58.0db */
+	{ 0X00, 0X15, 0XD9, 0X31 }, /* -57.5db */
+	{ 0X00, 0X17, 0X24, 0X9C }, /* -57.0db */
+	{ 0X00, 0X18, 0X83, 0XAA }, /* -56.5db */
+	{ 0X00, 0X19, 0XF7, 0X86 }, /* -56.0db */
+	{ 0X00, 0X1B, 0X81, 0X6A }, /* -55.5db */
+	{ 0X00, 0X1D, 0X22, 0XA4 }, /* -55.0db */
+	{ 0X00, 0X1E, 0XDC, 0X98 }, /* -54.5db */
+	{ 0X00, 0X20, 0XB0, 0XBC }, /* -54.0db */
+	{ 0X00, 0X22, 0XA0, 0X9D }, /* -53.5db */
+	{ 0X00, 0X24, 0XAD, 0XE0 }, /* -53.0db */
+	{ 0X00, 0X26, 0XDA, 0X43 }, /* -52.5db */
+	{ 0X00, 0X29, 0X27, 0X9D }, /* -52.0db */
+	{ 0X00, 0X2B, 0X97, 0XE3 }, /* -51.5db */
+	{ 0X00, 0X2E, 0X2D, 0X27 }, /* -51.0db */
+	{ 0X00, 0X30, 0XE9, 0X9A }, /* -50.5db */
+	{ 0X00, 0X33, 0XCF, 0X8D }, /* -50.0db */
+	{ 0X00, 0X36, 0XE1, 0X78 }, /* -49.5db */
+	{ 0X00, 0X3A, 0X21, 0XF3 }, /* -49.0db */
+	{ 0X00, 0X3D, 0X93, 0XC3 }, /* -48.5db */
+	{ 0X00, 0X41, 0X39, 0XD3 }, /* -48.0db */
+	{ 0X00, 0X45, 0X17, 0X3B }, /* -47.5db */
+	{ 0X00, 0X49, 0X2F, 0X44 }, /* -47.0db */
+	{ 0X00, 0X4D, 0X85, 0X66 }, /* -46.5db */
+	{ 0X00, 0X52, 0X1D, 0X50 }, /* -46.0db */
+	{ 0X00, 0X56, 0XFA, 0XE8 }, /* -45.5db */
+	{ 0X00, 0X5C, 0X22, 0X4E }, /* -45.0db */
+	{ 0X00, 0X61, 0X97, 0XE1 }, /* -44.5db */
+	{ 0X00, 0X67, 0X60, 0X44 }, /* -44.0db */
+	{ 0X00, 0X6D, 0X80, 0X60 }, /* -43.5db */
+	{ 0X00, 0X73, 0XFD, 0X65 }, /* -43.0db */
+	{ 0X00, 0X7A, 0XDC, 0XD7 }, /* -42.5db */
+	{ 0X00, 0X82, 0X24, 0X8A }, /* -42.0db */
+	{ 0X00, 0X89, 0XDA, 0XAB }, /* -41.5db */
+	{ 0X00, 0X92, 0X05, 0XC6 }, /* -41.0db */
+	{ 0X00, 0X9A, 0XAC, 0XC8 }, /* -40.5db */
+	{ 0X00, 0XA3, 0XD7, 0X0A }, /* -40.0db */
+	{ 0X00, 0XAD, 0X8C, 0X52 }, /* -39.5db */
+	{ 0X00, 0XB7, 0XD4, 0XDD }, /* -39.0db */
+	{ 0X00, 0XC2, 0XB9, 0X65 }, /* -38.5db */
+	{ 0X00, 0XCE, 0X43, 0X28 }, /* -38.0db */
+	{ 0X00, 0XDA, 0X7B, 0XF1 }, /* -37.5db */
+	{ 0X00, 0XE7, 0X6E, 0X1E }, /* -37.0db */
+	{ 0X00, 0XF5, 0X24, 0XAC }, /* -36.5db */
+	{ 0X01, 0X03, 0XAB, 0X3D }, /* -36.0db */
+	{ 0X01, 0X13, 0X0E, 0X24 }, /* -35.5db */
+	{ 0X01, 0X23, 0X5A, 0X71 }, /* -35.0db */
+	{ 0X01, 0X34, 0X9D, 0XF8 }, /* -34.5db */
+	{ 0X01, 0X46, 0XE7, 0X5D }, /* -34.0db */
+	{ 0X01, 0X5A, 0X46, 0X27 }, /* -33.5db */
+	{ 0X01, 0X6E, 0XCA, 0XC5 }, /* -33.0db */
+	{ 0X01, 0X84, 0X86, 0X9F }, /* -32.5db */
+	{ 0X01, 0X9B, 0X8C, 0X27 }, /* -32.0db */
+	{ 0X01, 0XB3, 0XEE, 0XE5 }, /* -31.5db */
+	{ 0X01, 0XCD, 0XC3, 0X8C }, /* -31.0db */
+	{ 0X01, 0XE9, 0X20, 0X05 }, /* -30.5db */
+	{ 0X02, 0X06, 0X1B, 0X89 }, /* -30.0db */
+	{ 0X02, 0X24, 0XCE, 0XB0 }, /* -29.5db */
+	{ 0X02, 0X45, 0X53, 0X85 }, /* -29.0db */
+	{ 0X02, 0X67, 0XC5, 0XA2 }, /* -28.5db */
+	{ 0X02, 0X8C, 0X42, 0X3F }, /* -28.0db */
+	{ 0X02, 0XB2, 0XE8, 0X55 }, /* -27.5db */
+	{ 0X02, 0XDB, 0XD8, 0XAD }, /* -27.0db */
+	{ 0X03, 0X07, 0X36, 0X05 }, /* -26.5db */
+	{ 0X03, 0X35, 0X25, 0X29 }, /* -26.0db */
+	{ 0X03, 0X65, 0XCD, 0X13 }, /* -25.5db */
+	{ 0X03, 0X99, 0X57, 0X0C }, /* -25.0db */
+	{ 0X03, 0XCF, 0XEE, 0XCF }, /* -24.5db */
+	{ 0X04, 0X09, 0XC2, 0XB0 }, /* -24.0db */
+	{ 0X04, 0X47, 0X03, 0XC1 }, /* -23.5db */
+	{ 0X04, 0X87, 0XE5, 0XFB }, /* -23.0db */
+	{ 0X04, 0XCC, 0XA0, 0X6D }, /* -22.5db */
+	{ 0X05, 0X15, 0X6D, 0X68 }, /* -22.0db */
+	{ 0X05, 0X62, 0X8A, 0XB3 }, /* -21.5db */
+	{ 0X05, 0XB4, 0X39, 0XBC }, /* -21.0db */
+	{ 0X06, 0X0A, 0XBF, 0XD4 }, /* -20.5db */
+	{ 0X06, 0X66, 0X66, 0X66 }, /* -20.0db */
+	{ 0X06, 0XC7, 0X7B, 0X36 }, /* -19.5db */
+	{ 0X07, 0X2E, 0X50, 0XA6 }, /* -19.0db */
+	{ 0X07, 0X9B, 0X3D, 0XF6 }, /* -18.5db */
+	{ 0X08, 0X0E, 0X9F, 0X96 }, /* -18.0db */
+	{ 0X08, 0X88, 0XD7, 0X6D }, /* -17.5db */
+	{ 0X09, 0X0A, 0X4D, 0X2F }, /* -17.0db */
+	{ 0X09, 0X93, 0X6E, 0XB8 }, /* -16.5db */
+	{ 0X0A, 0X24, 0XB0, 0X62 }, /* -16.0db */
+	{ 0X0A, 0XBE, 0X8D, 0X70 }, /* -15.5db */
+	{ 0X0B, 0X61, 0X88, 0X71 }, /* -15.0db */
+	{ 0X0C, 0X0E, 0X2B, 0XB0 }, /* -14.5db */
+	{ 0X0C, 0XC5, 0X09, 0XAB }, /* -14.0db */
+	{ 0X0D, 0X86, 0XBD, 0X8D }, /* -13.5db */
+	{ 0X0E, 0X53, 0XEB, 0XB3 }, /* -13.0db */
+	{ 0X0F, 0X2D, 0X42, 0X38 }, /* -12.5db */
+	{ 0X10, 0X13, 0X79, 0X87 }, /* -12.0db */
+	{ 0X11, 0X07, 0X54, 0XF9 }, /* -11.5db */
+	{ 0X12, 0X09, 0XA3, 0X7A }, /* -11.0db */
+	{ 0X13, 0X1B, 0X40, 0X39 }, /* -10.5db */
+	{ 0X14, 0X3D, 0X13, 0X62 }, /* -10.0db */
+	{ 0X15, 0X70, 0X12, 0XE1 }, /* -9.5db */
+	{ 0X16, 0XB5, 0X43, 0X37 }, /* -9.0db */
+	{ 0X18, 0X0D, 0XB8, 0X54 }, /* -8.5db */
+	{ 0X19, 0X7A, 0X96, 0X7F }, /* -8.0db */
+	{ 0X1A, 0XFD, 0X13, 0X54 }, /* -7.5db */
+	{ 0X1C, 0X96, 0X76, 0XC6 }, /* -7.0db */
+	{ 0X1E, 0X48, 0X1C, 0X37 }, /* -6.5db */
+	{ 0X20, 0X13, 0X73, 0X9E }, /* -6.0db */
+	{ 0X21, 0XFA, 0X02, 0XBF }, /* -5.5db */
+	{ 0X23, 0XFD, 0X66, 0X78 }, /* -5.0db */
+	{ 0X26, 0X1F, 0X54, 0X1C }, /* -4.5db */
+	{ 0X28, 0X61, 0X9A, 0XE9 }, /* -4.0db */
+	{ 0X2A, 0XC6, 0X25, 0X91 }, /* -3.5db */
+	{ 0X2D, 0X4E, 0XFB, 0XD5 }, /* -3.0db */
+	{ 0X2F, 0XFE, 0X44, 0X48 }, /* -2.5db */
+	{ 0X32, 0XD6, 0X46, 0X17 }, /* -2.0db */
+	{ 0X35, 0XD9, 0X6B, 0X02 }, /* -1.5db */
+	{ 0X39, 0X0A, 0X41, 0X5F }, /* -1.0db */
+	{ 0X3C, 0X6B, 0X7E, 0X4F }, /* -0.5db */
+	{ 0X40, 0X00, 0X00, 0X00 }, /* 0.0db */
+	{ 0X43, 0XCA, 0XD0, 0X22 }, /* 0.5db */
+	{ 0X47, 0XCF, 0X26, 0X7D }, /* 1.0db */
+	{ 0X4C, 0X10, 0X6B, 0XA5 }, /* 1.5db */
+	{ 0X50, 0X92, 0X3B, 0XE3 }, /* 2.0db */
+	{ 0X55, 0X58, 0X6A, 0X46 }, /* 2.5db */
+	{ 0X5A, 0X67, 0X03, 0XDF }, /* 3.0db */
+	{ 0X5F, 0XC2, 0X53, 0X32 }, /* 3.5db */
+	{ 0X65, 0X6E, 0XE3, 0XDB }, /* 4.0db */
+	{ 0X6B, 0X71, 0X86, 0X68 }, /* 4.5db */
+	{ 0X71, 0XCF, 0X54, 0X71 }, /* 5.0db */
+	{ 0X78, 0X8D, 0XB4, 0XE9 }, /* 5.5db */
+	{ 0X7F, 0XFF, 0XFF, 0XFF }, /* 6.0db */
+};
+#endif
diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index 99c41bfc7827..5b003843752b 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -17,265 +17,5 @@
 
 static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
-static const DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
 
-/* pow(10, db/20) * pow(2,30) */
-static const unsigned char tas2563_dvc_table[][4] = {
-	{ 0X00, 0X00, 0X00, 0X00 }, /* -121.5db */
-	{ 0X00, 0X00, 0X03, 0XBC }, /* -121.0db */
-	{ 0X00, 0X00, 0X03, 0XF5 }, /* -120.5db */
-	{ 0X00, 0X00, 0X04, 0X31 }, /* -120.0db */
-	{ 0X00, 0X00, 0X04, 0X71 }, /* -119.5db */
-	{ 0X00, 0X00, 0X04, 0XB4 }, /* -119.0db */
-	{ 0X00, 0X00, 0X04, 0XFC }, /* -118.5db */
-	{ 0X00, 0X00, 0X05, 0X47 }, /* -118.0db */
-	{ 0X00, 0X00, 0X05, 0X97 }, /* -117.5db */
-	{ 0X00, 0X00, 0X05, 0XEC }, /* -117.0db */
-	{ 0X00, 0X00, 0X06, 0X46 }, /* -116.5db */
-	{ 0X00, 0X00, 0X06, 0XA5 }, /* -116.0db */
-	{ 0X00, 0X00, 0X07, 0X0A }, /* -115.5db */
-	{ 0X00, 0X00, 0X07, 0X75 }, /* -115.0db */
-	{ 0X00, 0X00, 0X07, 0XE6 }, /* -114.5db */
-	{ 0X00, 0X00, 0X08, 0X5E }, /* -114.0db */
-	{ 0X00, 0X00, 0X08, 0XDD }, /* -113.5db */
-	{ 0X00, 0X00, 0X09, 0X63 }, /* -113.0db */
-	{ 0X00, 0X00, 0X09, 0XF2 }, /* -112.5db */
-	{ 0X00, 0X00, 0X0A, 0X89 }, /* -112.0db */
-	{ 0X00, 0X00, 0X0B, 0X28 }, /* -111.5db */
-	{ 0X00, 0X00, 0X0B, 0XD2 }, /* -111.0db */
-	{ 0X00, 0X00, 0X0C, 0X85 }, /* -110.5db */
-	{ 0X00, 0X00, 0X0D, 0X43 }, /* -110.0db */
-	{ 0X00, 0X00, 0X0E, 0X0C }, /* -109.5db */
-	{ 0X00, 0X00, 0X0E, 0XE1 }, /* -109.0db */
-	{ 0X00, 0X00, 0X0F, 0XC3 }, /* -108.5db */
-	{ 0X00, 0X00, 0X10, 0XB2 }, /* -108.0db */
-	{ 0X00, 0X00, 0X11, 0XAF }, /* -107.5db */
-	{ 0X00, 0X00, 0X12, 0XBC }, /* -107.0db */
-	{ 0X00, 0X00, 0X13, 0XD8 }, /* -106.5db */
-	{ 0X00, 0X00, 0X15, 0X05 }, /* -106.0db */
-	{ 0X00, 0X00, 0X16, 0X44 }, /* -105.5db */
-	{ 0X00, 0X00, 0X17, 0X96 }, /* -105.0db */
-	{ 0X00, 0X00, 0X18, 0XFB }, /* -104.5db */
-	{ 0X00, 0X00, 0X1A, 0X76 }, /* -104.0db */
-	{ 0X00, 0X00, 0X1C, 0X08 }, /* -103.5db */
-	{ 0X00, 0X00, 0X1D, 0XB1 }, /* -103.0db */
-	{ 0X00, 0X00, 0X1F, 0X73 }, /* -102.5db */
-	{ 0X00, 0X00, 0X21, 0X51 }, /* -102.0db */
-	{ 0X00, 0X00, 0X23, 0X4A }, /* -101.5db */
-	{ 0X00, 0X00, 0X25, 0X61 }, /* -101.0db */
-	{ 0X00, 0X00, 0X27, 0X98 }, /* -100.5db */
-	{ 0X00, 0X00, 0X29, 0XF1 }, /* -100.0db */
-	{ 0X00, 0X00, 0X2C, 0X6D }, /* -99.5db */
-	{ 0X00, 0X00, 0X2F, 0X0F }, /* -99.0db */
-	{ 0X00, 0X00, 0X31, 0XD9 }, /* -98.5db */
-	{ 0X00, 0X00, 0X34, 0XCD }, /* -98.0db */
-	{ 0X00, 0X00, 0X37, 0XEE }, /* -97.5db */
-	{ 0X00, 0X00, 0X3B, 0X3F }, /* -97.0db */
-	{ 0X00, 0X00, 0X3E, 0XC1 }, /* -96.5db */
-	{ 0X00, 0X00, 0X42, 0X79 }, /* -96.0db */
-	{ 0X00, 0X00, 0X46, 0X6A }, /* -95.5db */
-	{ 0X00, 0X00, 0X4A, 0X96 }, /* -95.0db */
-	{ 0X00, 0X00, 0X4F, 0X01 }, /* -94.5db */
-	{ 0X00, 0X00, 0X53, 0XAF }, /* -94.0db */
-	{ 0X00, 0X00, 0X58, 0XA5 }, /* -93.5db */
-	{ 0X00, 0X00, 0X5D, 0XE6 }, /* -93.0db */
-	{ 0X00, 0X00, 0X63, 0X76 }, /* -92.5db */
-	{ 0X00, 0X00, 0X69, 0X5B }, /* -92.0db */
-	{ 0X00, 0X00, 0X6F, 0X99 }, /* -91.5db */
-	{ 0X00, 0X00, 0X76, 0X36 }, /* -91.0db */
-	{ 0X00, 0X00, 0X7D, 0X37 }, /* -90.5db */
-	{ 0X00, 0X00, 0X84, 0XA2 }, /* -90.0db */
-	{ 0X00, 0X00, 0X8C, 0X7E }, /* -89.5db */
-	{ 0X00, 0X00, 0X94, 0XD1 }, /* -89.0db */
-	{ 0X00, 0X00, 0X9D, 0XA3 }, /* -88.5db */
-	{ 0X00, 0X00, 0XA6, 0XFA }, /* -88.0db */
-	{ 0X00, 0X00, 0XB0, 0XDF }, /* -87.5db */
-	{ 0X00, 0X00, 0XBB, 0X5A }, /* -87.0db */
-	{ 0X00, 0X00, 0XC6, 0X74 }, /* -86.5db */
-	{ 0X00, 0X00, 0XD2, 0X36 }, /* -86.0db */
-	{ 0X00, 0X00, 0XDE, 0XAB }, /* -85.5db */
-	{ 0X00, 0X00, 0XEB, 0XDC }, /* -85.0db */
-	{ 0X00, 0X00, 0XF9, 0XD6 }, /* -84.5db */
-	{ 0X00, 0X01, 0X08, 0XA4 }, /* -84.0db */
-	{ 0X00, 0X01, 0X18, 0X52 }, /* -83.5db */
-	{ 0X00, 0X01, 0X28, 0XEF }, /* -83.0db */
-	{ 0X00, 0X01, 0X3A, 0X87 }, /* -82.5db */
-	{ 0X00, 0X01, 0X4D, 0X2A }, /* -82.0db */
-	{ 0X00, 0X01, 0X60, 0XE8 }, /* -81.5db */
-	{ 0X00, 0X01, 0X75, 0XD1 }, /* -81.0db */
-	{ 0X00, 0X01, 0X8B, 0XF7 }, /* -80.5db */
-	{ 0X00, 0X01, 0XA3, 0X6E }, /* -80.0db */
-	{ 0X00, 0X01, 0XBC, 0X48 }, /* -79.5db */
-	{ 0X00, 0X01, 0XD6, 0X9B }, /* -79.0db */
-	{ 0X00, 0X01, 0XF2, 0X7E }, /* -78.5db */
-	{ 0X00, 0X02, 0X10, 0X08 }, /* -78.0db */
-	{ 0X00, 0X02, 0X2F, 0X51 }, /* -77.5db */
-	{ 0X00, 0X02, 0X50, 0X76 }, /* -77.0db */
-	{ 0X00, 0X02, 0X73, 0X91 }, /* -76.5db */
-	{ 0X00, 0X02, 0X98, 0XC0 }, /* -76.0db */
-	{ 0X00, 0X02, 0XC0, 0X24 }, /* -75.5db */
-	{ 0X00, 0X02, 0XE9, 0XDD }, /* -75.0db */
-	{ 0X00, 0X03, 0X16, 0X0F }, /* -74.5db */
-	{ 0X00, 0X03, 0X44, 0XDF }, /* -74.0db */
-	{ 0X00, 0X03, 0X76, 0X76 }, /* -73.5db */
-	{ 0X00, 0X03, 0XAA, 0XFC }, /* -73.0db */
-	{ 0X00, 0X03, 0XE2, 0XA0 }, /* -72.5db */
-	{ 0X00, 0X04, 0X1D, 0X8F }, /* -72.0db */
-	{ 0X00, 0X04, 0X5B, 0XFD }, /* -71.5db */
-	{ 0X00, 0X04, 0X9E, 0X1D }, /* -71.0db */
-	{ 0X00, 0X04, 0XE4, 0X29 }, /* -70.5db */
-	{ 0X00, 0X05, 0X2E, 0X5A }, /* -70.0db */
-	{ 0X00, 0X05, 0X7C, 0XF2 }, /* -69.5db */
-	{ 0X00, 0X05, 0XD0, 0X31 }, /* -69.0db */
-	{ 0X00, 0X06, 0X28, 0X60 }, /* -68.5db */
-	{ 0X00, 0X06, 0X85, 0XC8 }, /* -68.0db */
-	{ 0X00, 0X06, 0XE8, 0XB9 }, /* -67.5db */
-	{ 0X00, 0X07, 0X51, 0X86 }, /* -67.0db */
-	{ 0X00, 0X07, 0XC0, 0X8A }, /* -66.5db */
-	{ 0X00, 0X08, 0X36, 0X21 }, /* -66.0db */
-	{ 0X00, 0X08, 0XB2, 0XB0 }, /* -65.5db */
-	{ 0X00, 0X09, 0X36, 0XA1 }, /* -65.0db */
-	{ 0X00, 0X09, 0XC2, 0X63 }, /* -64.5db */
-	{ 0X00, 0X0A, 0X56, 0X6D }, /* -64.0db */
-	{ 0X00, 0X0A, 0XF3, 0X3C }, /* -63.5db */
-	{ 0X00, 0X0B, 0X99, 0X56 }, /* -63.0db */
-	{ 0X00, 0X0C, 0X49, 0X48 }, /* -62.5db */
-	{ 0X00, 0X0D, 0X03, 0XA7 }, /* -62.0db */
-	{ 0X00, 0X0D, 0XC9, 0X11 }, /* -61.5db */
-	{ 0X00, 0X0E, 0X9A, 0X2D }, /* -61.0db */
-	{ 0X00, 0X0F, 0X77, 0XAD }, /* -60.5db */
-	{ 0X00, 0X10, 0X62, 0X4D }, /* -60.0db */
-	{ 0X00, 0X11, 0X5A, 0XD5 }, /* -59.5db */
-	{ 0X00, 0X12, 0X62, 0X16 }, /* -59.0db */
-	{ 0X00, 0X13, 0X78, 0XF0 }, /* -58.5db */
-	{ 0X00, 0X14, 0XA0, 0X50 }, /* -58.0db */
-	{ 0X00, 0X15, 0XD9, 0X31 }, /* -57.5db */
-	{ 0X00, 0X17, 0X24, 0X9C }, /* -57.0db */
-	{ 0X00, 0X18, 0X83, 0XAA }, /* -56.5db */
-	{ 0X00, 0X19, 0XF7, 0X86 }, /* -56.0db */
-	{ 0X00, 0X1B, 0X81, 0X6A }, /* -55.5db */
-	{ 0X00, 0X1D, 0X22, 0XA4 }, /* -55.0db */
-	{ 0X00, 0X1E, 0XDC, 0X98 }, /* -54.5db */
-	{ 0X00, 0X20, 0XB0, 0XBC }, /* -54.0db */
-	{ 0X00, 0X22, 0XA0, 0X9D }, /* -53.5db */
-	{ 0X00, 0X24, 0XAD, 0XE0 }, /* -53.0db */
-	{ 0X00, 0X26, 0XDA, 0X43 }, /* -52.5db */
-	{ 0X00, 0X29, 0X27, 0X9D }, /* -52.0db */
-	{ 0X00, 0X2B, 0X97, 0XE3 }, /* -51.5db */
-	{ 0X00, 0X2E, 0X2D, 0X27 }, /* -51.0db */
-	{ 0X00, 0X30, 0XE9, 0X9A }, /* -50.5db */
-	{ 0X00, 0X33, 0XCF, 0X8D }, /* -50.0db */
-	{ 0X00, 0X36, 0XE1, 0X78 }, /* -49.5db */
-	{ 0X00, 0X3A, 0X21, 0XF3 }, /* -49.0db */
-	{ 0X00, 0X3D, 0X93, 0XC3 }, /* -48.5db */
-	{ 0X00, 0X41, 0X39, 0XD3 }, /* -48.0db */
-	{ 0X00, 0X45, 0X17, 0X3B }, /* -47.5db */
-	{ 0X00, 0X49, 0X2F, 0X44 }, /* -47.0db */
-	{ 0X00, 0X4D, 0X85, 0X66 }, /* -46.5db */
-	{ 0X00, 0X52, 0X1D, 0X50 }, /* -46.0db */
-	{ 0X00, 0X56, 0XFA, 0XE8 }, /* -45.5db */
-	{ 0X00, 0X5C, 0X22, 0X4E }, /* -45.0db */
-	{ 0X00, 0X61, 0X97, 0XE1 }, /* -44.5db */
-	{ 0X00, 0X67, 0X60, 0X44 }, /* -44.0db */
-	{ 0X00, 0X6D, 0X80, 0X60 }, /* -43.5db */
-	{ 0X00, 0X73, 0XFD, 0X65 }, /* -43.0db */
-	{ 0X00, 0X7A, 0XDC, 0XD7 }, /* -42.5db */
-	{ 0X00, 0X82, 0X24, 0X8A }, /* -42.0db */
-	{ 0X00, 0X89, 0XDA, 0XAB }, /* -41.5db */
-	{ 0X00, 0X92, 0X05, 0XC6 }, /* -41.0db */
-	{ 0X00, 0X9A, 0XAC, 0XC8 }, /* -40.5db */
-	{ 0X00, 0XA3, 0XD7, 0X0A }, /* -40.0db */
-	{ 0X00, 0XAD, 0X8C, 0X52 }, /* -39.5db */
-	{ 0X00, 0XB7, 0XD4, 0XDD }, /* -39.0db */
-	{ 0X00, 0XC2, 0XB9, 0X65 }, /* -38.5db */
-	{ 0X00, 0XCE, 0X43, 0X28 }, /* -38.0db */
-	{ 0X00, 0XDA, 0X7B, 0XF1 }, /* -37.5db */
-	{ 0X00, 0XE7, 0X6E, 0X1E }, /* -37.0db */
-	{ 0X00, 0XF5, 0X24, 0XAC }, /* -36.5db */
-	{ 0X01, 0X03, 0XAB, 0X3D }, /* -36.0db */
-	{ 0X01, 0X13, 0X0E, 0X24 }, /* -35.5db */
-	{ 0X01, 0X23, 0X5A, 0X71 }, /* -35.0db */
-	{ 0X01, 0X34, 0X9D, 0XF8 }, /* -34.5db */
-	{ 0X01, 0X46, 0XE7, 0X5D }, /* -34.0db */
-	{ 0X01, 0X5A, 0X46, 0X27 }, /* -33.5db */
-	{ 0X01, 0X6E, 0XCA, 0XC5 }, /* -33.0db */
-	{ 0X01, 0X84, 0X86, 0X9F }, /* -32.5db */
-	{ 0X01, 0X9B, 0X8C, 0X27 }, /* -32.0db */
-	{ 0X01, 0XB3, 0XEE, 0XE5 }, /* -31.5db */
-	{ 0X01, 0XCD, 0XC3, 0X8C }, /* -31.0db */
-	{ 0X01, 0XE9, 0X20, 0X05 }, /* -30.5db */
-	{ 0X02, 0X06, 0X1B, 0X89 }, /* -30.0db */
-	{ 0X02, 0X24, 0XCE, 0XB0 }, /* -29.5db */
-	{ 0X02, 0X45, 0X53, 0X85 }, /* -29.0db */
-	{ 0X02, 0X67, 0XC5, 0XA2 }, /* -28.5db */
-	{ 0X02, 0X8C, 0X42, 0X3F }, /* -28.0db */
-	{ 0X02, 0XB2, 0XE8, 0X55 }, /* -27.5db */
-	{ 0X02, 0XDB, 0XD8, 0XAD }, /* -27.0db */
-	{ 0X03, 0X07, 0X36, 0X05 }, /* -26.5db */
-	{ 0X03, 0X35, 0X25, 0X29 }, /* -26.0db */
-	{ 0X03, 0X65, 0XCD, 0X13 }, /* -25.5db */
-	{ 0X03, 0X99, 0X57, 0X0C }, /* -25.0db */
-	{ 0X03, 0XCF, 0XEE, 0XCF }, /* -24.5db */
-	{ 0X04, 0X09, 0XC2, 0XB0 }, /* -24.0db */
-	{ 0X04, 0X47, 0X03, 0XC1 }, /* -23.5db */
-	{ 0X04, 0X87, 0XE5, 0XFB }, /* -23.0db */
-	{ 0X04, 0XCC, 0XA0, 0X6D }, /* -22.5db */
-	{ 0X05, 0X15, 0X6D, 0X68 }, /* -22.0db */
-	{ 0X05, 0X62, 0X8A, 0XB3 }, /* -21.5db */
-	{ 0X05, 0XB4, 0X39, 0XBC }, /* -21.0db */
-	{ 0X06, 0X0A, 0XBF, 0XD4 }, /* -20.5db */
-	{ 0X06, 0X66, 0X66, 0X66 }, /* -20.0db */
-	{ 0X06, 0XC7, 0X7B, 0X36 }, /* -19.5db */
-	{ 0X07, 0X2E, 0X50, 0XA6 }, /* -19.0db */
-	{ 0X07, 0X9B, 0X3D, 0XF6 }, /* -18.5db */
-	{ 0X08, 0X0E, 0X9F, 0X96 }, /* -18.0db */
-	{ 0X08, 0X88, 0XD7, 0X6D }, /* -17.5db */
-	{ 0X09, 0X0A, 0X4D, 0X2F }, /* -17.0db */
-	{ 0X09, 0X93, 0X6E, 0XB8 }, /* -16.5db */
-	{ 0X0A, 0X24, 0XB0, 0X62 }, /* -16.0db */
-	{ 0X0A, 0XBE, 0X8D, 0X70 }, /* -15.5db */
-	{ 0X0B, 0X61, 0X88, 0X71 }, /* -15.0db */
-	{ 0X0C, 0X0E, 0X2B, 0XB0 }, /* -14.5db */
-	{ 0X0C, 0XC5, 0X09, 0XAB }, /* -14.0db */
-	{ 0X0D, 0X86, 0XBD, 0X8D }, /* -13.5db */
-	{ 0X0E, 0X53, 0XEB, 0XB3 }, /* -13.0db */
-	{ 0X0F, 0X2D, 0X42, 0X38 }, /* -12.5db */
-	{ 0X10, 0X13, 0X79, 0X87 }, /* -12.0db */
-	{ 0X11, 0X07, 0X54, 0XF9 }, /* -11.5db */
-	{ 0X12, 0X09, 0XA3, 0X7A }, /* -11.0db */
-	{ 0X13, 0X1B, 0X40, 0X39 }, /* -10.5db */
-	{ 0X14, 0X3D, 0X13, 0X62 }, /* -10.0db */
-	{ 0X15, 0X70, 0X12, 0XE1 }, /* -9.5db */
-	{ 0X16, 0XB5, 0X43, 0X37 }, /* -9.0db */
-	{ 0X18, 0X0D, 0XB8, 0X54 }, /* -8.5db */
-	{ 0X19, 0X7A, 0X96, 0X7F }, /* -8.0db */
-	{ 0X1A, 0XFD, 0X13, 0X54 }, /* -7.5db */
-	{ 0X1C, 0X96, 0X76, 0XC6 }, /* -7.0db */
-	{ 0X1E, 0X48, 0X1C, 0X37 }, /* -6.5db */
-	{ 0X20, 0X13, 0X73, 0X9E }, /* -6.0db */
-	{ 0X21, 0XFA, 0X02, 0XBF }, /* -5.5db */
-	{ 0X23, 0XFD, 0X66, 0X78 }, /* -5.0db */
-	{ 0X26, 0X1F, 0X54, 0X1C }, /* -4.5db */
-	{ 0X28, 0X61, 0X9A, 0XE9 }, /* -4.0db */
-	{ 0X2A, 0XC6, 0X25, 0X91 }, /* -3.5db */
-	{ 0X2D, 0X4E, 0XFB, 0XD5 }, /* -3.0db */
-	{ 0X2F, 0XFE, 0X44, 0X48 }, /* -2.5db */
-	{ 0X32, 0XD6, 0X46, 0X17 }, /* -2.0db */
-	{ 0X35, 0XD9, 0X6B, 0X02 }, /* -1.5db */
-	{ 0X39, 0X0A, 0X41, 0X5F }, /* -1.0db */
-	{ 0X3C, 0X6B, 0X7E, 0X4F }, /* -0.5db */
-	{ 0X40, 0X00, 0X00, 0X00 }, /* 0.0db */
-	{ 0X43, 0XCA, 0XD0, 0X22 }, /* 0.5db */
-	{ 0X47, 0XCF, 0X26, 0X7D }, /* 1.0db */
-	{ 0X4C, 0X10, 0X6B, 0XA5 }, /* 1.5db */
-	{ 0X50, 0X92, 0X3B, 0XE3 }, /* 2.0db */
-	{ 0X55, 0X58, 0X6A, 0X46 }, /* 2.5db */
-	{ 0X5A, 0X67, 0X03, 0XDF }, /* 3.0db */
-	{ 0X5F, 0XC2, 0X53, 0X32 }, /* 3.5db */
-	{ 0X65, 0X6E, 0XE3, 0XDB }, /* 4.0db */
-	{ 0X6B, 0X71, 0X86, 0X68 }, /* 4.5db */
-	{ 0X71, 0XCF, 0X54, 0X71 }, /* 5.0db */
-	{ 0X78, 0X8D, 0XB4, 0XE9 }, /* 5.5db */
-	{ 0XFF, 0XFF, 0XFF, 0XFF }, /* 6.0db */
-};
 #endif
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index e79d613745b4..8a57c045afdd 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -30,6 +30,7 @@
 #include <sound/soc.h>
 #include <sound/tas2781.h>
 #include <sound/tlv.h>
+#include <sound/tas2563-tlv.h>
 #include <sound/tas2781-tlv.h>
 #include <asm/unaligned.h>
 
-- 
2.34.1


