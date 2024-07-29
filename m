Return-Path: <linux-kernel+bounces-265321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935D93EF76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD7E282DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FBE13A896;
	Mon, 29 Jul 2024 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/7hL5Ew"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0D13B2BC;
	Mon, 29 Jul 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240487; cv=none; b=Ilk5MOIU5S1DJOAyclPdS1bblvbt4s14aNObx4aMGcLdY4Biio9JTcgergGXGUhcWZMW54eNNgIVv7kM+6GPt6hIfqvulM29F7B/k6BDOPl6513MabDTIO+rOVL/qNlf0iflJYgnAGC1bKFIh82U5dejWoXu7k3L3lpVfOdwKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240487; c=relaxed/simple;
	bh=IW2Ja7D7Z/VxjoKdaIAvenXR157/d3ddq+OoZiJ9Ujs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7jygPQyJ2+cY6/MiCa1o93YQD1ROXOhk1985NHbZOlqWY0GXEO+ZF+TbO6OfYJ9Xh/X+aA+8Vy4Bi25HSSIcSWeMyxDlKZ0s6gDV4OLOZphSO2GPlMb5qiWtP9o2Ra5AZ2UjxZ+wUMCGD93UrYp7bxdYg55MvQITVTw9sP62kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/7hL5Ew; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2c109eabso41235301fa.0;
        Mon, 29 Jul 2024 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722240483; x=1722845283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZfUWDuJ+Gp/tiqaKRDFbblvzBoyQv8RBku+yUKjHrc=;
        b=e/7hL5Ew6vsSzLO5Y5Khn40FyRsd4G31Tw7MC24SHEHQaXZdezdkZda/9m6DcA/0BM
         CkUn3NDEVelr+2iGZjj5jcyfrHBT/2xysu0DzTj+r/xTR5vrbqFuFDo1ErJSJAdQosRd
         /wYdXyGEwvV8NkMtefdgw9wZpoyqpI2d3wcEY5oPgne1kP88t+hulesMGwdEKZtbk6CT
         QxOWNJVFAyLr3ZO58QNBqHqQFC7Vv1XsCmlmFqCaWI/13RFakvhQp9IQFrmcBTcZ6vqh
         4qZy1MVvubaVLLbesaFnU34BCUkg7IOTaxdjLOsPP0ltj0CXvz27127oDl4qxvUge3CK
         J8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240483; x=1722845283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZfUWDuJ+Gp/tiqaKRDFbblvzBoyQv8RBku+yUKjHrc=;
        b=rHAfdqJDEZ+lQu+KgnKKtGqwRhhYbKMcCwMfT7GVx4L5JMdp2bksCFpmvloPe+g0wC
         8zODoaOl3baV2GI3gVCQKBbZGc27MooSp9y614Wn0rsRz1aGEzrQ7kpAJVJq3GTEHlyl
         QvkpmZXcq2h5nJkam/EKoZoEa9aLPGw4Rp2GKoW7LyYe8elJWGS99osWXYrUvMJ0W962
         bWX6cGg6KmfdEktjp8X0W9pVZ/vluU5ONY+WN2HmFrnfKaZeVpkMg75ePZTbB3v6KPug
         6oDn3kAf3qY8oQRdJVZ3rJvjj2wd5db2j6s97HQzy6WygrOHOxRlkxR50gCtPPY0oOjc
         CB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUCdIQucY2GDdhJaLfkCPrTfP9YfgM8yNibQAOKWji7lk/PE44O3A42FRy6K8z6UMz6a5qJpXhNN2XCVx9Hu7y5ATJ1Q5+9dVLA9WIxbmoO6YS42JyLR33U2VvqbH9vTnNKvrXsdKbuqw==
X-Gm-Message-State: AOJu0Yw+HfcpHbovnDay19WsmT+7rEKTfuhhpoLKFArKaZ6kKf2MeFUG
	2IrpNXi/Djh9dqRIlEJ6cxZM5CnM9jYHfmVnoT0NvW/6ar1ycYyGUoRrnw==
X-Google-Smtp-Source: AGHT+IGuNDvznEGeqPPrnPuE3gIyDp3nG8oOrCc4MBt7W+qGeulRvSxxx7O6BTRR9kzdrmZYzrbIdQ==
X-Received: by 2002:a05:651c:14d:b0:2ef:2b08:1742 with SMTP id 38308e7fff4ca-2f12ee2f0ecmr41837331fa.48.1722240482615;
        Mon, 29 Jul 2024 01:08:02 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590cedsm5352868a12.29.2024.07.29.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:08:02 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/3] nvmem: layouts: add U-Boot env layout
Date: Mon, 29 Jul 2024 10:07:33 +0200
Message-Id: <20240729080733.16839-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240729080733.16839-1-zajec5@gmail.com>
References: <20240729080733.16839-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot environment variables are stored in a specific format. Actual
data can be placed in various storage sources (MTD, UBI volume, EEPROM,
NVRAM, etc.).

Move all generic (NVMEM device independent) code from NVMEM device
driver to an NVMEM layout driver. Then add a simple NVMEM layout code on
top of it.

This allows using NVMEM layout for parsing U-Boot env data stored in any
kind of NVMEM device.

The old NVMEM glue driver stays in place for handling bindings in the
MTD context. To avoid code duplication it uses exported layout parsing
function. Please note that handling MTD & NVMEM layout bindings may be
refactored in the future.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V2: Add MODULE_DESCRIPTION()

This change was originally sent (and approved by Miquel) as a
[PATCH V3 6/6] nvmem: layouts: add U-Boot env layout

I just adjusted it to the approved binding and updated commit message.
I kept Miquel's Reviewed-by tag due to minimal changes.

I've successfully tested this code using it in both ways: as NVMEM
device driver & NVMEM layout.

 MAINTAINERS                        |   1 +
 drivers/nvmem/Kconfig              |   3 +-
 drivers/nvmem/layouts/Kconfig      |  11 ++
 drivers/nvmem/layouts/Makefile     |   1 +
 drivers/nvmem/layouts/u-boot-env.c | 211 +++++++++++++++++++++++++++++
 drivers/nvmem/layouts/u-boot-env.h |  15 ++
 drivers/nvmem/u-boot-env.c         | 165 +---------------------
 7 files changed, 242 insertions(+), 165 deletions(-)
 create mode 100644 drivers/nvmem/layouts/u-boot-env.c
 create mode 100644 drivers/nvmem/layouts/u-boot-env.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 12b870712da4..b785ef03dda3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23355,6 +23355,7 @@ U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	drivers/nvmem/layouts/u-boot-env.c
 F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 283134498fbc..d2c384f58028 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -363,8 +363,7 @@ config NVMEM_SUNXI_SID
 config NVMEM_U_BOOT_ENV
 	tristate "U-Boot environment variables support"
 	depends on OF && MTD
-	select CRC32
-	select GENERIC_NET_UTILS
+	select NVMEM_LAYOUT_U_BOOT_ENV
 	help
 	  U-Boot stores its setup as environment variables. This driver adds
 	  support for verifying & exporting such data. It also exposes variables
diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
index 9c6e672fc350..5e586dfebe47 100644
--- a/drivers/nvmem/layouts/Kconfig
+++ b/drivers/nvmem/layouts/Kconfig
@@ -26,6 +26,17 @@ config NVMEM_LAYOUT_ONIE_TLV
 
 	  If unsure, say N.
 
+config NVMEM_LAYOUT_U_BOOT_ENV
+	tristate "U-Boot environment variables layout"
+	select CRC32
+	select GENERIC_NET_UTILS
+	help
+	  U-Boot stores its setup as environment variables. This driver adds
+	  support for verifying & exporting such data. It also exposes variables
+	  as NVMEM cells so they can be referenced by other drivers.
+
+	  If unsure, say N.
+
 endmenu
 
 endif
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 2974bd7d33ed..4940c9db0665 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
+obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
new file mode 100644
index 000000000000..731e6f4f12b2
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 - 2023 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/crc32.h>
+#include <linux/etherdevice.h>
+#include <linux/export.h>
+#include <linux/if_ether.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "u-boot-env.h"
+
+struct u_boot_env_image_single {
+	__le32 crc32;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_redundant {
+	__le32 crc32;
+	u8 mark;
+	uint8_t data[];
+} __packed;
+
+struct u_boot_env_image_broadcom {
+	__le32 magic;
+	__le32 len;
+	__le32 crc32;
+	DECLARE_FLEX_ARRAY(uint8_t, data);
+} __packed;
+
+static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
+						unsigned int offset, void *buf, size_t bytes)
+{
+	u8 mac[ETH_ALEN];
+
+	if (bytes != 3 * ETH_ALEN - 1)
+		return -EINVAL;
+
+	if (!mac_pton(buf, mac))
+		return -EINVAL;
+
+	if (index)
+		eth_addr_add(mac, index);
+
+	ether_addr_copy(buf, mac);
+
+	return 0;
+}
+
+static int u_boot_env_parse_cells(struct device *dev, struct nvmem_device *nvmem, uint8_t *buf,
+				  size_t data_offset, size_t data_len)
+{
+	char *data = buf + data_offset;
+	char *var, *value, *eq;
+
+	for (var = data;
+	     var < data + data_len && *var;
+	     var = value + strlen(value) + 1) {
+		struct nvmem_cell_info info = {};
+
+		eq = strchr(var, '=');
+		if (!eq)
+			break;
+		*eq = '\0';
+		value = eq + 1;
+
+		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
+		if (!info.name)
+			return -ENOMEM;
+		info.offset = data_offset + value - data;
+		info.bytes = strlen(value);
+		info.np = of_get_child_by_name(dev->of_node, info.name);
+		if (!strcmp(var, "ethaddr")) {
+			info.raw_len = strlen(value);
+			info.bytes = ETH_ALEN;
+			info.read_post_process = u_boot_env_read_post_process_ethaddr;
+		}
+
+		nvmem_add_one_cell(nvmem, &info);
+	}
+
+	return 0;
+}
+
+int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
+		     enum u_boot_env_format format)
+{
+	size_t crc32_data_offset;
+	size_t crc32_data_len;
+	size_t crc32_offset;
+	__le32 *crc32_addr;
+	size_t data_offset;
+	size_t data_len;
+	size_t dev_size;
+	uint32_t crc32;
+	uint32_t calc;
+	uint8_t *buf;
+	int bytes;
+	int err;
+
+	dev_size = nvmem_dev_size(nvmem);
+
+	buf = kzalloc(dev_size, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0) {
+		err = bytes;
+		goto err_kfree;
+	} else if (bytes != dev_size) {
+		err = -EIO;
+		goto err_kfree;
+	}
+
+	switch (format) {
+	case U_BOOT_FORMAT_SINGLE:
+		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
+		data_offset = offsetof(struct u_boot_env_image_single, data);
+		break;
+	case U_BOOT_FORMAT_REDUNDANT:
+		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		data_offset = offsetof(struct u_boot_env_image_redundant, data);
+		break;
+	case U_BOOT_FORMAT_BROADCOM:
+		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		break;
+	}
+
+	if (dev_size < data_offset) {
+		dev_err(dev, "Device too small for u-boot-env\n");
+		err = -EIO;
+		goto err_kfree;
+	}
+
+	crc32_addr = (__le32 *)(buf + crc32_offset);
+	crc32 = le32_to_cpu(*crc32_addr);
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
+
+	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	if (calc != crc32) {
+		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
+		err = -EINVAL;
+		goto err_kfree;
+	}
+
+	buf[dev_size - 1] = '\0';
+	err = u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_len);
+
+err_kfree:
+	kfree(buf);
+err_out:
+	return err;
+}
+EXPORT_SYMBOL_GPL(u_boot_env_parse);
+
+static int u_boot_env_add_cells(struct nvmem_layout *layout)
+{
+	struct device *dev = &layout->dev;
+	enum u_boot_env_format format;
+
+	format = (uintptr_t)device_get_match_data(dev);
+
+	return u_boot_env_parse(dev, layout->nvmem, format);
+}
+
+static int u_boot_env_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = u_boot_env_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void u_boot_env_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
+static const struct of_device_id u_boot_env_of_match_table[] = {
+	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
+	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
+	{},
+};
+
+static struct nvmem_layout_driver u_boot_env_layout = {
+	.driver = {
+		.name = "u-boot-env-layout",
+		.of_match_table = u_boot_env_of_match_table,
+	},
+	.probe = u_boot_env_probe,
+	.remove = u_boot_env_remove,
+};
+module_nvmem_layout_driver(u_boot_env_layout);
+
+MODULE_AUTHOR("Rafał Miłecki");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, u_boot_env_of_match_table);
+MODULE_DESCRIPTION("NVMEM layout driver for U-Boot environment variables");
diff --git a/drivers/nvmem/layouts/u-boot-env.h b/drivers/nvmem/layouts/u-boot-env.h
new file mode 100644
index 000000000000..dd5f280ac047
--- /dev/null
+++ b/drivers/nvmem/layouts/u-boot-env.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H
+#define _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H
+
+enum u_boot_env_format {
+	U_BOOT_FORMAT_SINGLE,
+	U_BOOT_FORMAT_REDUNDANT,
+	U_BOOT_FORMAT_BROADCOM,
+};
+
+int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
+		     enum u_boot_env_format format);
+
+#endif  /* ifndef _LINUX_NVMEM_LAYOUTS_U_BOOT_ENV_H */
diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 593f0bf4a395..ced414fc9e60 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -3,23 +3,15 @@
  * Copyright (C) 2022 Rafał Miłecki <rafal@milecki.pl>
  */
 
-#include <linux/crc32.h>
-#include <linux/etherdevice.h>
-#include <linux/if_ether.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-enum u_boot_env_format {
-	U_BOOT_FORMAT_SINGLE,
-	U_BOOT_FORMAT_REDUNDANT,
-	U_BOOT_FORMAT_BROADCOM,
-};
+#include "layouts/u-boot-env.h"
 
 struct u_boot_env {
 	struct device *dev;
@@ -29,24 +21,6 @@ struct u_boot_env {
 	struct mtd_info *mtd;
 };
 
-struct u_boot_env_image_single {
-	__le32 crc32;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_redundant {
-	__le32 crc32;
-	u8 mark;
-	uint8_t data[];
-} __packed;
-
-struct u_boot_env_image_broadcom {
-	__le32 magic;
-	__le32 len;
-	__le32 crc32;
-	DECLARE_FLEX_ARRAY(uint8_t, data);
-} __packed;
-
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
@@ -69,141 +43,6 @@ static int u_boot_env_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
-static int u_boot_env_read_post_process_ethaddr(void *context, const char *id, int index,
-						unsigned int offset, void *buf, size_t bytes)
-{
-	u8 mac[ETH_ALEN];
-
-	if (bytes != 3 * ETH_ALEN - 1)
-		return -EINVAL;
-
-	if (!mac_pton(buf, mac))
-		return -EINVAL;
-
-	if (index)
-		eth_addr_add(mac, index);
-
-	ether_addr_copy(buf, mac);
-
-	return 0;
-}
-
-static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
-				size_t data_offset, size_t data_len)
-{
-	struct nvmem_device *nvmem = priv->nvmem;
-	struct device *dev = priv->dev;
-	char *data = buf + data_offset;
-	char *var, *value, *eq;
-
-	for (var = data;
-	     var < data + data_len && *var;
-	     var = value + strlen(value) + 1) {
-		struct nvmem_cell_info info = {};
-
-		eq = strchr(var, '=');
-		if (!eq)
-			break;
-		*eq = '\0';
-		value = eq + 1;
-
-		info.name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!info.name)
-			return -ENOMEM;
-		info.offset = data_offset + value - data;
-		info.bytes = strlen(value);
-		info.np = of_get_child_by_name(dev->of_node, info.name);
-		if (!strcmp(var, "ethaddr")) {
-			info.raw_len = strlen(value);
-			info.bytes = ETH_ALEN;
-			info.read_post_process = u_boot_env_read_post_process_ethaddr;
-		}
-
-		nvmem_add_one_cell(nvmem, &info);
-	}
-
-	return 0;
-}
-
-static int u_boot_env_parse(struct u_boot_env *priv)
-{
-	struct nvmem_device *nvmem = priv->nvmem;
-	struct device *dev = priv->dev;
-	size_t crc32_data_offset;
-	size_t crc32_data_len;
-	size_t crc32_offset;
-	__le32 *crc32_addr;
-	size_t data_offset;
-	size_t data_len;
-	size_t dev_size;
-	uint32_t crc32;
-	uint32_t calc;
-	uint8_t *buf;
-	int bytes;
-	int err;
-
-	dev_size = nvmem_dev_size(nvmem);
-
-	buf = kzalloc(dev_size, GFP_KERNEL);
-	if (!buf) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
-	if (bytes < 0) {
-		err = bytes;
-		goto err_kfree;
-	} else if (bytes != dev_size) {
-		err = -EIO;
-		goto err_kfree;
-	}
-
-	switch (priv->format) {
-	case U_BOOT_FORMAT_SINGLE:
-		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
-		data_offset = offsetof(struct u_boot_env_image_single, data);
-		break;
-	case U_BOOT_FORMAT_REDUNDANT:
-		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		data_offset = offsetof(struct u_boot_env_image_redundant, data);
-		break;
-	case U_BOOT_FORMAT_BROADCOM:
-		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
-		break;
-	}
-
-	if (dev_size < data_offset) {
-		dev_err(dev, "Device too small for u-boot-env\n");
-		err = -EIO;
-		goto err_kfree;
-	}
-
-	crc32_addr = (__le32 *)(buf + crc32_offset);
-	crc32 = le32_to_cpu(*crc32_addr);
-	crc32_data_len = dev_size - crc32_data_offset;
-	data_len = dev_size - data_offset;
-
-	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
-	if (calc != crc32) {
-		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
-		err = -EINVAL;
-		goto err_kfree;
-	}
-
-	buf[dev_size - 1] = '\0';
-	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
-
-err_kfree:
-	kfree(buf);
-err_out:
-	return err;
-}
-
 static int u_boot_env_probe(struct platform_device *pdev)
 {
 	struct nvmem_config config = {
@@ -235,7 +74,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->nvmem))
 		return PTR_ERR(priv->nvmem);
 
-	return u_boot_env_parse(priv);
+	return u_boot_env_parse(dev, priv->nvmem, priv->format);
 }
 
 static const struct of_device_id u_boot_env_of_match_table[] = {
-- 
2.35.3


