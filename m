Return-Path: <linux-kernel+bounces-180942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC68C7543
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42F01C2259C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07511459FC;
	Thu, 16 May 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="DAq1bOfJ"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779C145B04
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859095; cv=none; b=PsOReVMnXTQBj4vAkOrvEuxZLNxFjKYLKlBU2nqHtuJFqniWnRjXW24u1fhn6KhDNV22s7XVvinEKEClICaq/43rywVDZOn+ZkJgB16DTh0THG4jfDK2wjAfznW8F7sHodjO3RKL/c9/Rjo+Yn57vIxr3B4NP6Io/uE+44jhvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859095; c=relaxed/simple;
	bh=GWKuSrTWmIS6pThKyUYmnhONhinJfOqFlZ9/TygxLVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL1IY0mthKHuiX8+vTyUpAul867qAd4CrN7U0/401Z7NKvoegTHY8M3KyNZUV2Gs5R3FhbBYYSw1uFsh54Yw+cpt8zMoFHsAfSWI6KpACiCx2RmTgZzWeSwpXscwTDNs9gngX3kmvC5GQ+HpYlyyuEX9KLWz04l0vQZ2mzyZh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=DAq1bOfJ; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F0E9181C14;
	Thu, 16 May 2024 14:31:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1715859086; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GEQArPt1kn/Khi/Y6aFVKGpGzNy0MfkExrWMzBfSx18=;
	b=DAq1bOfJMqCy1Nruz0C7qB4eKNGlPUEmg2JWadC+PvREVbpRUmo0F6vae3/o/kPLmCHvBJ
	WsDgsJ0nXoFNlxw4+uqELaz4OsSZrqCL/peX5wV1WGYXrX5dfZN4M+5acnStqubOmg5G1v
	PN5K6YoQUBJCscKu6qIasyH8fTbvB3nk6GP/b8dSYd+9Yc2V9ruhKmyR4QcNAQIL2WJbE0
	jv89FE3tqPE3lZzujgIfNLrabyCa8WYj5yH+369XUUYdCQ/khq5eXq2MbXcgAileTSuCCx
	5fawMult2oWT8H5TKpfZ+mp5GNdAPqjx65Rd4CUVAIKR7AbOCP/P8pmgFPaV6A==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 1/4] soc: amlogic: meson-gx-socinfo: move common code to header file
Date: Thu, 16 May 2024 14:26:47 +0300
Message-ID: <20240516112849.3803674-4-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240516112849.3803674-2-adeep@lexina.in>
References: <20240516112849.3803674-2-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Move common constants and inline functions from meson-gx-socinfo driver
to header file. Create new structures for store meson64 cpu_id and chip_id.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 120 ++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 136 ++----------------
 2 files changed, 134 insertions(+), 122 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h

diff --git a/drivers/soc/amlogic/meson-gx-socinfo-internal.h b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
new file mode 100644
index 000000000000..3ebb80972fc7
--- /dev/null
+++ b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Copyright (c) 2024 JetHome
+ * Author: Neil Armstrong <neil.armstrong@linaro.org>
+ * Author: Viacheslav Bocharov <adeep@lexina.in>
+ *
+ */
+
+#ifndef _MESON_GX_SOCINFO_INTERNAL_H_
+#define _MESON_GX_SOCINFO_INTERNAL_H_
+
+#include <linux/types.h>
+
+#define AO_SEC_SD_CFG8		0xe0
+#define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
+
+union meson_cpu_id {
+	struct { // cpu_id v1
+		u32 layout_ver:4;
+		u32 reserved:4;
+		u32 chip_rev:8;
+		u32 pack_id:8;
+		u32 major_id:8;
+	} v1;
+	struct { // cpu_id v2
+		u32 major_id:8;
+		u32 chip_rev:8;
+		u32 pack_id:8;
+		u32 reserved:4;
+		u32 layout_ver:4;
+	} v2;
+	u32	raw;
+};
+
+struct meson_sm_chip_id {
+	u32 version;
+	union meson_cpu_id cpu_id;
+	u8 serial[12];
+};
+
+static const struct meson_gx_soc_id {
+	const char *name;
+	unsigned int id;
+} soc_ids[] = {
+	{ "GXBB", 0x1f },
+	{ "GXTVBB", 0x20 },
+	{ "GXL", 0x21 },
+	{ "GXM", 0x22 },
+	{ "TXL", 0x23 },
+	{ "TXLX", 0x24 },
+	{ "AXG", 0x25 },
+	{ "GXLX", 0x26 },
+	{ "TXHD", 0x27 },
+	{ "G12A", 0x28 },
+	{ "G12B", 0x29 },
+	{ "SM1", 0x2b },
+	{ "A1", 0x2c },
+};
+
+static const struct meson_gx_package_id {
+	const char *name;
+	unsigned int major_id;
+	unsigned int pack_id;
+	unsigned int pack_mask;
+} soc_packages[] = {
+	{ "S905", 0x1f, 0, 0x20 }, /* pack_id != 0x20 */
+	{ "S905H", 0x1f, 0x3, 0xf }, /* pack_id & 0xf == 0x3 */
+	{ "S905M", 0x1f, 0x20, 0xf0 }, /* pack_id == 0x20 */
+	{ "S905D", 0x21, 0, 0xf0 },
+	{ "S905X", 0x21, 0x80, 0xf0 },
+	{ "S905W", 0x21, 0xa0, 0xf0 },
+	{ "S905L", 0x21, 0xc0, 0xf0 },
+	{ "S905M2", 0x21, 0xe0, 0xf0 },
+	{ "S805X", 0x21, 0x30, 0xf0 },
+	{ "S805Y", 0x21, 0xb0, 0xf0 },
+	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
+	{ "962X", 0x24, 0x10, 0xf0 },
+	{ "962E", 0x24, 0x20, 0xf0 },
+	{ "A113X", 0x25, 0x37, 0xff },
+	{ "A113D", 0x25, 0x22, 0xff },
+	{ "S905D2", 0x28, 0x10, 0xf0 },
+	{ "S905Y2", 0x28, 0x30, 0xf0 },
+	{ "S905X2", 0x28, 0x40, 0xf0 },
+	{ "A311D", 0x29, 0x10, 0xf0 },
+	{ "S922X", 0x29, 0x40, 0xf0 },
+	{ "S905D3", 0x2b, 0x4, 0xf5 },
+	{ "S905X3", 0x2b, 0x5, 0xf5 },
+	{ "S905X3", 0x2b, 0x10, 0x3f },
+	{ "S905D3", 0x2b, 0x30, 0x3f },
+	{ "A113L", 0x2c, 0x0, 0xf8 },
+};
+
+static inline const char *socinfo_v1_to_package_id(union meson_cpu_id socinfo)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(soc_packages) ; ++i) {
+		if (soc_packages[i].major_id == socinfo.v1.major_id &&
+		    soc_packages[i].pack_id ==
+				(socinfo.v1.pack_id & soc_packages[i].pack_mask))
+			return soc_packages[i].name;
+	}
+
+	return "Unknown";
+}
+
+static inline const char *socinfo_v1_to_soc_id(union meson_cpu_id socinfo)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(soc_ids) ; ++i) {
+		if (soc_ids[i].id == socinfo.v1.major_id)
+			return soc_ids[i].name;
+	}
+
+	return "Unknown";
+}
+
+#endif /* _MESON_GX_SOCINFO_INTERNAL_H_ */
diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 6abb730344ab..006f3b09940d 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -12,118 +12,10 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
-#include <linux/bitfield.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
-#define AO_SEC_SD_CFG8		0xe0
-#define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
-
-#define SOCINFO_MAJOR	GENMASK(31, 24)
-#define SOCINFO_PACK	GENMASK(23, 16)
-#define SOCINFO_MINOR	GENMASK(15, 8)
-#define SOCINFO_MISC	GENMASK(7, 0)
-
-static const struct meson_gx_soc_id {
-	const char *name;
-	unsigned int id;
-} soc_ids[] = {
-	{ "GXBB", 0x1f },
-	{ "GXTVBB", 0x20 },
-	{ "GXL", 0x21 },
-	{ "GXM", 0x22 },
-	{ "TXL", 0x23 },
-	{ "TXLX", 0x24 },
-	{ "AXG", 0x25 },
-	{ "GXLX", 0x26 },
-	{ "TXHD", 0x27 },
-	{ "G12A", 0x28 },
-	{ "G12B", 0x29 },
-	{ "SM1", 0x2b },
-	{ "A1", 0x2c },
-};
-
-static const struct meson_gx_package_id {
-	const char *name;
-	unsigned int major_id;
-	unsigned int pack_id;
-	unsigned int pack_mask;
-} soc_packages[] = {
-	{ "S905", 0x1f, 0, 0x20 }, /* pack_id != 0x20 */
-	{ "S905H", 0x1f, 0x3, 0xf }, /* pack_id & 0xf == 0x3 */
-	{ "S905M", 0x1f, 0x20, 0xf0 }, /* pack_id == 0x20 */
-	{ "S905D", 0x21, 0, 0xf0 },
-	{ "S905X", 0x21, 0x80, 0xf0 },
-	{ "S905W", 0x21, 0xa0, 0xf0 },
-	{ "S905L", 0x21, 0xc0, 0xf0 },
-	{ "S905M2", 0x21, 0xe0, 0xf0 },
-	{ "S805X", 0x21, 0x30, 0xf0 },
-	{ "S805Y", 0x21, 0xb0, 0xf0 },
-	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
-	{ "962X", 0x24, 0x10, 0xf0 },
-	{ "962E", 0x24, 0x20, 0xf0 },
-	{ "A113X", 0x25, 0x37, 0xff },
-	{ "A113D", 0x25, 0x22, 0xff },
-	{ "S905D2", 0x28, 0x10, 0xf0 },
-	{ "S905Y2", 0x28, 0x30, 0xf0 },
-	{ "S905X2", 0x28, 0x40, 0xf0 },
-	{ "A311D", 0x29, 0x10, 0xf0 },
-	{ "S922X", 0x29, 0x40, 0xf0 },
-	{ "S905D3", 0x2b, 0x4, 0xf5 },
-	{ "S905X3", 0x2b, 0x5, 0xf5 },
-	{ "S905X3", 0x2b, 0x10, 0x3f },
-	{ "S905D3", 0x2b, 0x30, 0x3f },
-	{ "A113L", 0x2c, 0x0, 0xf8 },
-};
-
-static inline unsigned int socinfo_to_major(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_MAJOR, socinfo);
-}
-
-static inline unsigned int socinfo_to_minor(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_MINOR, socinfo);
-}
-
-static inline unsigned int socinfo_to_pack(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_PACK, socinfo);
-}
-
-static inline unsigned int socinfo_to_misc(u32 socinfo)
-{
-	return FIELD_GET(SOCINFO_MISC, socinfo);
-}
-
-static const char *socinfo_to_package_id(u32 socinfo)
-{
-	unsigned int pack = socinfo_to_pack(socinfo);
-	unsigned int major = socinfo_to_major(socinfo);
-	int i;
-
-	for (i = 0 ; i < ARRAY_SIZE(soc_packages) ; ++i) {
-		if (soc_packages[i].major_id == major &&
-		    soc_packages[i].pack_id ==
-				(pack & soc_packages[i].pack_mask))
-			return soc_packages[i].name;
-	}
-
-	return "Unknown";
-}
-
-static const char *socinfo_to_soc_id(u32 socinfo)
-{
-	unsigned int id = socinfo_to_major(socinfo);
-	int i;
-
-	for (i = 0 ; i < ARRAY_SIZE(soc_ids) ; ++i) {
-		if (soc_ids[i].id == id)
-			return soc_ids[i].name;
-	}
-
-	return "Unknown";
-}
+#include "meson-gx-socinfo-internal.h"
 
 static int __init meson_gx_socinfo_init(void)
 {
@@ -131,7 +23,7 @@ static int __init meson_gx_socinfo_init(void)
 	struct soc_device *soc_dev;
 	struct device_node *np;
 	struct regmap *regmap;
-	unsigned int socinfo;
+	union meson_cpu_id socinfo;
 	struct device *dev;
 	int ret;
 
@@ -160,11 +52,11 @@ static int __init meson_gx_socinfo_init(void)
 		return -ENODEV;
 	}
 
-	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo);
+	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo.raw);
 	if (ret < 0)
 		return ret;
 
-	if (!socinfo) {
+	if (!socinfo.raw) {
 		pr_err("%s: invalid chipid value\n", __func__);
 		return -EINVAL;
 	}
@@ -175,13 +67,13 @@ static int __init meson_gx_socinfo_init(void)
 
 	soc_dev_attr->family = "Amlogic Meson";
 	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
-					   socinfo_to_major(socinfo),
-					   socinfo_to_minor(socinfo),
-					   socinfo_to_pack(socinfo),
-					   socinfo_to_misc(socinfo));
+					   socinfo.v1.major_id,
+					   socinfo.v1.chip_rev,
+					   socinfo.v1.pack_id,
+					   (socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
 	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s (%s)",
-					 socinfo_to_soc_id(socinfo),
-					 socinfo_to_package_id(socinfo));
+					 socinfo_v1_to_soc_id(socinfo),
+					 socinfo_v1_to_package_id(socinfo));
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
@@ -194,10 +86,10 @@ static int __init meson_gx_socinfo_init(void)
 
 	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected\n",
 			soc_dev_attr->soc_id,
-			socinfo_to_major(socinfo),
-			socinfo_to_minor(socinfo),
-			socinfo_to_pack(socinfo),
-			socinfo_to_misc(socinfo));
+			socinfo.v1.major_id,
+			socinfo.v1.chip_rev,
+			socinfo.v1.pack_id,
+			(socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
 
 	return 0;
 }
-- 
2.43.2


