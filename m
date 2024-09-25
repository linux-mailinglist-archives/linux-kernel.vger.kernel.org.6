Return-Path: <linux-kernel+bounces-338374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E717B985709
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909D11F25051
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B02189F2D;
	Wed, 25 Sep 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e09VFQkk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C6186E4C;
	Wed, 25 Sep 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259316; cv=none; b=sfGxctCMipRKHhLt8OKWZ/NeYviV6CX5rt/rsZMiQvyjUW5y4lgnvSCiXaSTOr/yIVHz2cOBhfaIipWwCg0a84q3/G56g1p2HFKg09XUGfeAWCZBDy4qAzGc/kzRUKyoK8Tzcatsx1KafTxz2b5Qz48LGe+a3Yz0tPPoTd/V4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259316; c=relaxed/simple;
	bh=43/aBGH/beeq/R6HFa6uglRIgJS7aSs4e4soAOJqPo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dS+AR1uOpEJWWxAolxqP5GgT74AmrqtfKLsZmzvT1MjWvpgxUx7JHjR8k7apbvUpoPVjWyCVvNCw7Z74Xl4kHLz9PsPghFk0L812s+hu4sddeym3ZGdd/9/pNIIsp7IACoZETEFXOr3Qg7g7J00u7Q3WubHtBXYdZBof6V5Uq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e09VFQkk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb806623eso56877305e9.2;
        Wed, 25 Sep 2024 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259312; x=1727864112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xm9CdzNjdFxXiQLDIbBOl19NIoTai2DZ2tEF/6IV/ts=;
        b=e09VFQkkBc2fBQk7w9U1qkwxOEEZXc0B9FNMYU/pEH94zCBkNFoch/wiH8fl4YoAVG
         WL0AJaYHDU0DRSfCMbfN62Z9hD5j6ZAM7nu7b5vJn3k6q/abdX4NCLrQ74QEe9uxU/lw
         jKnzNK7aF5vv6FAXzxhU0dBgEC7IVLiObyfMv3380HSqtv77+2QUMwOkmgCrHKVftXMI
         BGC70xfH2ayHOFFS8bE8snCD/PZjKKv0hAIKloHbMW766GuQ17rxPNw8viMALzLbmzur
         E+brqgB9dkMdC40KrOZq0oESsR244G70mDAHiYWBPrFhpcf37dzeOo8SWhDvMQMd2HIN
         bw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259312; x=1727864112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm9CdzNjdFxXiQLDIbBOl19NIoTai2DZ2tEF/6IV/ts=;
        b=avl0pZhvMeiWT8ktDI/KIuyNOGhIVCGEIy7ASDBknhcxamPjAku6hQbBu5C0ndZ5Y/
         yRjbvDrrJfndLaujBEt8j3PD+/sjNKGWAs9jWI2pvn3W2YOjDsMJ9cjkVPXzd7TcQ5bH
         jFDZTzGH5DZ4UapaUdBARo4Snwt4W4kuRwD3feqT1sozeXE0CFWAozI7OWIdItybPHM2
         6s4vIP1Y9YL8YaH3mMsxWp+bjJhGODAmJcfgnwYyawUyFIpQ2Pu3HWy6H3uLqZKP81h9
         PM9sbV/9efWRE+cpBWED+XhzNbrxuOMvY2jShOr6EXULqiBDtVHjo4ATIcZ+ubDysOpq
         tbnw==
X-Forwarded-Encrypted: i=1; AJvYcCUgWgzvshB+/ZQTWbWmbLDIfDqG6JHApa+25rTKNwrYV7pB1wYrWPcPdj/0gahrPPYYYiUmPpivhfyWFApn@vger.kernel.org, AJvYcCV0aUrY3NZXrMn3x6EIymHJfzTRTu4uDRX4QrvzAOSQ15vvBRJLR7fmiiMyXYK1Q1yibU58d67UeAB4@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFnKy6xirbk1soFwQXwhxslVGY/iHkIRzJ2cCUZnXETcqyMRI
	JZXPxaF5BXXvlxKa/dOkO0clfgaXpgso9qrKE2v17L6VAOIbn60s
X-Google-Smtp-Source: AGHT+IFrUhPfnR1ZpaYpm6503WQfwgTFcsU1lGXcEyJha8rBKvGPhx/LgRwNZvRJtSCOoqRvLwLrDw==
X-Received: by 2002:a05:600c:310f:b0:42c:bd5a:945b with SMTP id 5b1f17b1804b1-42e9611dd5dmr15299805e9.21.1727259312318;
        Wed, 25 Sep 2024 03:15:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cbc1560a7sm3628194f8f.0.2024.09.25.03.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:15:12 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH 3/3] mtd: parser: add support for Airoha parser
Date: Wed, 25 Sep 2024 12:13:59 +0200
Message-ID: <20240925101422.8373-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925101422.8373-1-ansuelsmth@gmail.com>
References: <20240925101422.8373-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha parser based on a post parse ofpart function.

Airoha partition table follow normal fixed-partition implementation
with a special implementation for the ART partition. This is always the
last partition and is placed from the end of the flash - the partition
size.

To enable this special implementation for ART partition, the relevant
node require the "airoha,dynamic-art" compatible. With that declared,
offset value is ignored and real offset is updated with the calculated
value.

Due to usage of specific bad block management driver, the MTD size might
vary hence the ART partition offset needs to be dynamically parsed and
can't be declared statically.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/parsers/Kconfig         | 10 +++++
 drivers/mtd/parsers/Makefile        |  1 +
 drivers/mtd/parsers/ofpart_airoha.c | 57 +++++++++++++++++++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h | 18 +++++++++
 drivers/mtd/parsers/ofpart_core.c   |  6 +++
 5 files changed, 92 insertions(+)
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index da03ab6efe04..d6c53aa16ea6 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -72,6 +72,16 @@ config MTD_OF_PARTS
 	  flash memory node, as described in
 	  Documentation/devicetree/bindings/mtd/mtd.yaml.
 
+config MTD_OF_PARTS_AIROHA
+	bool "Airoha EN7815 partitioning support"
+	depends on MTD_OF_PARTS && (ARCH_AIROHA || COMPILE_TEST)
+	default ARCH_AIROHA
+	help
+	  This provides partitions parser for Airoha EN7815 family devices
+	  that can have dynamic "ART" partition at the end of the flash.
+	  It takes care of finding the correct offset and update property
+	  with it.
+
 config MTD_OF_PARTS_BCM4908
 	bool "BCM4908 partitioning support"
 	depends on MTD_OF_PARTS && (ARCH_BCMBCA || COMPILE_TEST)
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 9b00c62b837a..d67f9b4d39ac 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_MTD_BRCM_U_BOOT)		+= brcm_u-boot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS)		+= cmdlinepart.o
 obj-$(CONFIG_MTD_OF_PARTS)		+= ofpart.o
 ofpart-y				+= ofpart_core.o
+ofpart-$(CONFIG_MTD_OF_PARTS_AIROHA)	+= ofpart_airoha.o
 ofpart-$(CONFIG_MTD_OF_PARTS_BCM4908)	+= ofpart_bcm4908.o
 ofpart-$(CONFIG_MTD_OF_PARTS_LINKSYS_NS)+= ofpart_linksys_ns.o
 obj-$(CONFIG_MTD_PARSER_IMAGETAG)	+= parser_imagetag.o
diff --git a/drivers/mtd/parsers/ofpart_airoha.c b/drivers/mtd/parsers/ofpart_airoha.c
new file mode 100644
index 000000000000..5e2cc7b6376b
--- /dev/null
+++ b/drivers/mtd/parsers/ofpart_airoha.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/slab.h>
+#include <linux/mtd/partitions.h>
+
+#include "ofpart_airoha.h"
+
+int airoha_partitions_post_parse(struct mtd_info *mtd,
+				 struct mtd_partition *parts,
+				 int nr_parts)
+{
+	struct mtd_partition *part;
+	int len, a_cells, s_cells;
+	struct device_node *pp;
+	struct property *prop;
+	const __be32 *reg;
+	__be32 *new_reg;
+
+	part = &parts[nr_parts - 1];
+	pp = part->of_node;
+
+	/* Skip if ART partition have a valid offset instead of a dynamic one */
+	if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
+		return 0;
+
+	/* ART partition is set at the end of flash - size */
+	part->offset = mtd->size - part->size;
+
+	/* Update the offset with the new calculate value in DT */
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	/* Reg already validated by fixed-partition parser */
+	reg = of_get_property(pp, "reg", &len);
+
+	/* Fixed partition */
+	a_cells = of_n_addr_cells(pp);
+	s_cells = of_n_size_cells(pp);
+
+	prop->name = "reg";
+	prop->length = (a_cells + s_cells) * sizeof(__be32);
+	prop->value = kmemdup(reg, (a_cells + s_cells) * sizeof(__be32),
+			      GFP_KERNEL);
+	new_reg = prop->value;
+	memset(new_reg, 0, a_cells * sizeof(__be32));
+	new_reg[a_cells - 1] = cpu_to_be32(part->offset);
+	if (a_cells > 1)
+		new_reg[0] = cpu_to_be32(part->offset >> 32);
+	of_update_property(pp, prop);
+
+	return 0;
+}
diff --git a/drivers/mtd/parsers/ofpart_airoha.h b/drivers/mtd/parsers/ofpart_airoha.h
new file mode 100644
index 000000000000..3e8a8456c13a
--- /dev/null
+++ b/drivers/mtd/parsers/ofpart_airoha.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __OFPART_AIROHA_H
+#define __OFPART_AIROHA_H
+
+#ifdef CONFIG_MTD_OF_PARTS_AIROHA
+int airoha_partitions_post_parse(struct mtd_info *mtd,
+				 struct mtd_partition *parts,
+				 int nr_parts);
+#else
+static inline int airoha_partitions_post_parse(struct mtd_info *mtd,
+					       struct mtd_partition *parts,
+					       int nr_parts)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/drivers/mtd/parsers/ofpart_core.c b/drivers/mtd/parsers/ofpart_core.c
index abfa68798918..8e86fa4f3bbd 100644
--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mtd/partitions.h>
 
+#include "ofpart_airoha.h"
 #include "ofpart_bcm4908.h"
 #include "ofpart_linksys_ns.h"
 
@@ -23,6 +24,10 @@ struct fixed_partitions_quirks {
 	int (*post_parse)(struct mtd_info *mtd, struct mtd_partition *parts, int nr_parts);
 };
 
+static struct fixed_partitions_quirks airoha_partitions_quirks = {
+	.post_parse = airoha_partitions_post_parse,
+};
+
 static struct fixed_partitions_quirks bcm4908_partitions_quirks = {
 	.post_parse = bcm4908_partitions_post_parse,
 };
@@ -192,6 +197,7 @@ static const struct of_device_id parse_ofpart_match_table[] = {
 	/* Generic */
 	{ .compatible = "fixed-partitions" },
 	/* Customized */
+	{ .compatible = "airoha,fixed-partitions", .data = &airoha_partitions_quirks, },
 	{ .compatible = "brcm,bcm4908-partitions", .data = &bcm4908_partitions_quirks, },
 	{ .compatible = "linksys,ns-partitions", .data = &linksys_ns_partitions_quirks, },
 	{},
-- 
2.45.2


