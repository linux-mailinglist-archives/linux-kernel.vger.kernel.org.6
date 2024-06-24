Return-Path: <linux-kernel+bounces-226706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E591914286
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18C71C217B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6695920330;
	Mon, 24 Jun 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyK94JgK"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50102561B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209592; cv=none; b=okMzu4nUF9YgndszlTXoJd0Wi3faoqZJ7dl4IvVbtReTQHtU3QJlVc3c3cKiWnyYkJcJFnXiwChdj5rmUY/L01tK8QPS7m97a4QhxM4Ji+gsWU+CmTO79va8WuZ/Y1D20VAD52dAwgCJxVvowFZagb++7nA5rjAwkFKWvPCoYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209592; c=relaxed/simple;
	bh=LxHZIrSp1CnouL93gRMqN4Au5qi46r+19NEIeihUeYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/p21uSLBb5gZPNHBoiom+HxjAQyY+MyOX/CurRiAqPCxJP1UOAZC6dFmI3kUvj7WPn+zHt1L1C4z2q6g//us6JO4OY2x6nxx4OFcGG50o8FuZ//jJmSH9XVrtGCSex74hg9UPYJQxpJOHlICqTFZEAkQTXsaZgqQT3gXpXuedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyK94JgK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so42092521fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719209589; x=1719814389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/qRlD3FVKL5iXIy13BpU+Kwpwg+2SoBUqkyXN31Zr4=;
        b=UyK94JgKhfhTyuxq43ax1jSsClDx4gxGCUt4BO64KaVXhjmaCOnBlpaG7XzUM+LexD
         rFkNKvm5ac1tc+6hBPsuIQb7fyAArktvcTwXdspdv+UFUnmp3avFd+PjVqg5fiJlmHfk
         OeecKH+n555x31zJWbsR9Rm8VymVa25HOKSt3ic4+ojgtP5iusGpZJHIZ31g3ZN1RMoX
         RV4CGclbZpuw/xYqywR0HKtJ9zc+wWsRLtmlU8TZNhQcZYTX0z/jhQt3BighPdU5v5tl
         XazOmtvhLZUNMEubDi3htU+VJoUJpfaihD0/u+SWfdoIwxonMBbUcGCaLHjheYRAyikY
         U3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719209589; x=1719814389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/qRlD3FVKL5iXIy13BpU+Kwpwg+2SoBUqkyXN31Zr4=;
        b=f7/MdTGqWoX4s1WD6bPoyBZPq/O9mmFqzhMmXF8gNOOuDNxl4bnG46yQQCV4bA740G
         Bij3Ff3tegVKC+D1225PbHC6IicZ3934ISqPtxOj5StDabRv16OOfMgNOrQsiawWgiLS
         ga0FX15FLaXESSSNxPGTTkvq1+5cQMDbFMCqQn5p97zoFDI6rcDNwzbpwMvHywsdoB9w
         MR5xoIAL+wpkyGBI60urzGrQki5gpm2ViDLJbEM6LukMb4DRLcwGgQdy9JZy5AN29XOr
         K5MnhvsXiMLTQKVul5PYWVknnLuL4fejKllAf6CDG/B54BXjpPHgCliMFFFvOr0NXVWW
         cCog==
X-Forwarded-Encrypted: i=1; AJvYcCXdWq3LSQaiTvSNfYcK8IQf+p2N29tZ8FVQ5D/VY0voNJgEMp1V84UQ1mO6SWL3py6isEx1HQYcBpovkszrbZqGNKVSbymvprDUTYXZ
X-Gm-Message-State: AOJu0YxzEHUXAt1YfoGquUSKZqrjo7JdBXgeFGQSJ0siCeOgAMJraEDg
	RiUy2E7A5IFnijqsC3mpUHQdGspi5An8i7FlawX9wwEpdFNrX6TKE4/ReJCymU8=
X-Google-Smtp-Source: AGHT+IFl2QVb5+Ml2dJdo6naTCB0whKifzTd6jKoUynZMwmvr+54Ah3ay9voWlVFhwkF/YCas3qXBA==
X-Received: by 2002:a2e:8416:0:b0:2ec:500c:b2db with SMTP id 38308e7fff4ca-2ec5b37a4bfmr18655871fa.22.1719209588710;
        Sun, 23 Jun 2024 23:13:08 -0700 (PDT)
Received: from linaro-pc.lan (40.37.82.80.dsl-dynamic.vsi.ru. [80.82.37.40])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5d2c3446sm4011481fa.38.2024.06.23.23.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 23:13:08 -0700 (PDT)
From: Maxim Anisimov <maxim.anisimov.ua@gmail.com>
To: 
Cc: maxim.anisimov.ua@gmail.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Michael Walle <michael@walle.cc>,
	Mark Brown <broonie@kernel.org>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spinand: Add support for HeYangTek HYF1GQ4UDACAE
Date: Mon, 24 Jun 2024 09:12:17 +0300
Message-ID: <20240624061246.5292-1-maxim.anisimov.ua@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Support HeYangTek HYF1GQ4UDACAE SPI NAND.

Datasheet Link:
- https://www.heyangtek.cn/previewfile.jsp?file=ABUIABA9GAAgwsvRnwYo-eDpsgc

Signed-off-by: Maxim Anisimov <maxim.anisimov.ua@gmail.com>
---
 drivers/mtd/nand/spi/Makefile    |   4 +-
 drivers/mtd/nand/spi/core.c      |   1 +
 drivers/mtd/nand/spi/heyangtek.c | 112 +++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h      |   1 +
 4 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/heyangtek.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 19cc77288ebb..69d95fbdd0ce 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
-spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o heyangtek.o
+spinand-objs += macronix.o micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e0b6715e5dfe..45795e5f1e49 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -942,6 +942,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&esmt_c8_spinand_manufacturer,
 	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
+	&heyangtek_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/heyangtek.c b/drivers/mtd/nand/spi/heyangtek.c
new file mode 100644
index 000000000000..d4a5dbca40fb
--- /dev/null
+++ b/drivers/mtd/nand/spi/heyangtek.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *      Andrey Zolotarev <andrey.zolotarev@keenetic.com> - the main driver logic
+ *      Maxim Anisimov <maxim.anisimov.ua@gmail.com> - adaptation to mainline linux kernel
+ *
+ * Based on:
+ *      https://github.com/keenetic/kernel-49/commit/bacade569fb12bc0ad31ba09bca9b890118fbca7
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_HEYANGTEK		0xC9
+
+#define STATUS_ECC_LIMIT_BITFLIPS	(3 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int hyfxgq4uda_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = section * 16 + 8;
+	region->length = 8;
+
+	return 0;
+}
+
+static int hyfxgq4uda_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	/* ECC-protected user meta-data */
+	region->offset = section * 16 + 4;
+	region->length = 4;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops hyfxgq4uda_ooblayout = {
+	.ecc = hyfxgq4uda_ooblayout_ecc,
+	.free = hyfxgq4uda_ooblayout_free,
+};
+
+static int hyfxgq4uda_ecc_get_status(struct spinand_device *spinand,
+				     u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		return nanddev_get_ecc_conf(nand)->strength >> 1;
+
+	case STATUS_ECC_LIMIT_BITFLIPS:
+		return nanddev_get_ecc_conf(nand)->strength;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info heyangtek_spinand_table[] = {
+	SPINAND_INFO("HYF1GQ4UDACAE",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&hyfxgq4uda_ooblayout,
+				     hyfxgq4uda_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops heyangtek_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer heyangtek_spinand_manufacturer = {
+	.id = SPINAND_MFR_HEYANGTEK,
+	.name = "HeYangTek",
+	.chips = heyangtek_spinand_table,
+	.nchips = ARRAY_SIZE(heyangtek_spinand_table),
+	.ops = &heyangtek_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..06ee35a27e3b 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -265,6 +265,7 @@ extern const struct spinand_manufacturer ato_spinand_manufacturer;
 extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
+extern const struct spinand_manufacturer heyangtek_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
-- 
2.45.1


