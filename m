Return-Path: <linux-kernel+bounces-354682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53C9940EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD05D1F27D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DD1CEE90;
	Tue,  8 Oct 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jB0yl5OS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129B1CBE9E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372912; cv=none; b=kosUm4zPfGzkBA/jSqTCFFT/N4beHoiImpsGhfhA/x6lZCh9JFPpamb3TtTAmcTgnXTTHhrTrl0BYARBH3QsW0Hjt/rHtNkqqaiKg6RimwsXrqPzt4Hx0RZHlP/pxStI1BhUT6HpR5xKicPs2JB0kknZnNmBgm7DbhgfDDQf3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372912; c=relaxed/simple;
	bh=FCqOe4DXER/0VZOtN15XPH63oTSeD3yVfZO8zRbIJt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMRzJ95MuByb/Fu9fqWabfCLhIjpOs6/moBgn6jk7kpfNuNoSuBvtyP7kFVSktHwQLyYBD+oQoyMMlotevyFiSMyxkkcPw0TEjbTkrHdgr6Hv95O7KLTAaqQLY68OkMC1ecfB0OckRCiEOmGPP5VVPMB4ZFzhw/Q3GFwsMz1P6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jB0yl5OS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b49ee353cso49632755ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728372909; x=1728977709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c14UN758N8+vkFT5tTmUlJZ0Goy+uLOHFXrggK2MABI=;
        b=jB0yl5OSTok7f6Fd65aMen27/DkAVe1VXEU1vtxzzmfwztr8D8rU7B1NGgpx3WJaF6
         Tf/EPQJL4uJ4f1ZtfbJ21IN2Q+8Fagjva1Yk9oE7nh6erk3kcN8huBPXpsI0FQWkCLdh
         Yc3MBUalN7bHDQ7zQTW2fwq6ekp6y7a6UczJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372909; x=1728977709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c14UN758N8+vkFT5tTmUlJZ0Goy+uLOHFXrggK2MABI=;
        b=Bg+w50IZMuAr2untl7VSJz8VBkaZ9XIIDGoumte6eQgPNneFqa3yBkwyyubh0D1mEs
         mKnlFMHxTVzjqA0F56Is4Ci6ymDSPF8APX0YOLEEe7f/kiu2AFE9/r8L7/pU3S6wcAVz
         MvzbkZ+edAsymXPjHAL27xDx7skcLrDJvlIqfBWCrXa7dldSqFk+gbdmuei43kwtrxhG
         5TlzP0yGi949AoApNFOXV85nSuUGyGFydZpTk10615YMSKIxRdBYziJL/EtlnvtblxyM
         rWNtOfmA8tBBhnEfXx/PvQrqFZRgDrsG0XxfUAczeM80cU0XSvrdyJTyw7o1zCQCgKdU
         YCkA==
X-Forwarded-Encrypted: i=1; AJvYcCVipE9ysK7CtKoX/xf1X8TESDHYj7AZn2ZQF7drPWPvrJLb7wQkdRoRviuY4wbDdYm0Opi3uvTEzunFhbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvH8faidlZC3XueMUy0y+Z8o/TZXtDXiz9xqgCsmJcchmwklT
	q2i/0YuSMA/Y9mfkAlIv4fnn849xtrbf+SuGAouNihWd2nnGw9yvqSxWGJJWjg==
X-Google-Smtp-Source: AGHT+IHbeZ8EI5ZqgWgHGayDJ9808vm+ua5NSMvqRa0mLEDRBmZwRAugUrSNXyQQZLTfCghn2oungQ==
X-Received: by 2002:a17:902:f602:b0:20b:b40b:345a with SMTP id d9443c01a7336-20bfee37052mr220036715ad.52.1728372909273;
        Tue, 08 Oct 2024 00:35:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939bd7sm50121175ad.120.2024.10.08.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:35:08 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v8 4/8] i2c: Introduce OF component probe function
Date: Tue,  8 Oct 2024 15:34:23 +0800
Message-ID: <20241008073430.3992087-5-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008073430.3992087-1-wenst@chromium.org>
References: <20241008073430.3992087-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices are designed and manufactured with some components having
multiple drop-in replacement options. These components are often
connected to the mainboard via ribbon cables, having the same signals
and pin assignments across all options. These may include the display
panel and touchscreen on laptops and tablets, and the trackpad on
laptops. Sometimes which component option is used in a particular device
can be detected by some firmware provided identifier, other times that
information is not available, and the kernel has to try to probe each
device.

This change attempts to make the "probe each device" case cleaner. The
current approach is to have all options added and enabled in the device
tree. The kernel would then bind each device and run each driver's probe
function. This works, but has been broken before due to the introduction
of asynchronous probing, causing multiple instances requesting "shared"
resources, such as pinmuxes, GPIO pins, interrupt lines, at the same
time, with only one instance succeeding. Work arounds for these include
moving the pinmux to the parent I2C controller, using GPIO hogs or
pinmux settings to keep the GPIO pins in some fixed configuration, and
requesting the interrupt line very late. Such configurations can be seen
on the MT8183 Krane Chromebook tablets, and the Qualcomm sc8280xp-based
Lenovo Thinkpad 13S.

Instead of this delicate dance between drivers and device tree quirks,
this change introduces a simple I2C component probe function. For a
given class of devices on the same I2C bus, it will go through all of
them, doing a simple I2C read transfer and see which one of them responds.
It will then enable the device that responds.

This requires some minor modifications in the existing device tree. The
status for all the device nodes for the component options must be set
to "fail-needs-probe". This makes it clear that some mechanism is
needed to enable one of them, and also prevents the prober and device
drivers running at the same time.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v7:
- Dropped log level of "enabling component" to debug
- Dropped file name from header file
- Reverted to __free() cleanup for i2c bus node
- Corrected "failed-needs-probe" to "fail-needs-probe" in commit message
- Fixed incorrectly positioned period ('.') in commit message
- Expanded description of i2c_of_probe_component()
- Expanded comment explaining check for "available" devices to note that
  if such a device is found then the i2c probe function becomes a no-op
- Simplified check for "available" devices for-each loop
- Expanded description of @free_resources_early callback to explicitly
  state that it is not called if no working components are found
- Dropped !cfg check
- Replaced "fail" with "fail-needs-probe" in i2c_of_probe_component()
  kernel doc
- Combined callbacks (.get_resources with .enable; .cleanup with
  .free_resources_late); .free_resources_early renamed to .cleanup_early

Changes since v6:
- Correctly replaced for_each_child_of_node_scoped() with
  for_each_child_of_node_with_prefix()
- Added namespace for exported symbol
- Made the probe function a framework with hooks
- Split out a new header file
- Added MAINTAINERS entry
- Reworded kernel-doc
- Dropped usage of __free from i2c_of_probe_component() since error
  path cleanup is needed anyway

Changes since v5:
- Fixed indent in Makefile
- Split regulator and GPIO TODO items
- Reversed final conditional in i2c_of_probe_enable_node()

Changes since v4:
- Split code into helper functions
- Use scoped helpers and __free() to reduce error path

Changes since v3:
- Complete kernel-doc
- Return different error if I2C controller is disabled
- Expand comment to explain assumptions and constraints
- Split for-loop finding target node and operations on target node
- Add missing i2c_put_adapter()
- Move prober code to separate file

Rob also asked why there was a limitation of "exactly one touchscreen
will be enabled across the whole tree".

The use case this prober currently targets is a component on consumer
electronics (tablet or laptop) being swapped out due to cost or supply
reasons. Designs with multiple components of the same type are pretty
rare. The way the next patch is written also assumes this for efficiency
reasons.

Changes since v2:
- New patch split out from "of: Introduce hardware prober driver"
- Addressed Rob's comments
  - Move i2c prober to i2c subsystem
  - Use of_node_is_available() to check if node is enabled.
  - Use OF changeset API to update status property
- Addressed Andy's comments
  - Probe function now accepts "struct device *dev" instead to reduce
    line length and dereferences
  - Move "ret = 0" to just before for_each_child_of_node(i2c_node, node)
---
 MAINTAINERS                      |   8 ++
 drivers/i2c/Makefile             |   1 +
 drivers/i2c/i2c-core-of-prober.c | 176 +++++++++++++++++++++++++++++++
 include/linux/i2c-of-prober.h    |  70 ++++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 drivers/i2c/i2c-core-of-prober.c
 create mode 100644 include/linux/i2c-of-prober.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 84086d47db69..5defa175a6bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10682,6 +10682,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
 F:	drivers/i2c/busses/i2c-mv64xxx.c
 
+I2C OF COMPONENT PROBER
+M:	Chen-Yu Tsai <wenst@chromium.org>
+L:	linux-i2c@vger.kernel.org
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/i2c-core-of-prober.c
+F:	include/linux-i2c-of-prober.h
+
 I2C OVER PARALLEL PORT
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-i2c@vger.kernel.org
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index f12d6b10a85e..c539cdc1e305 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -9,6 +9,7 @@ i2c-core-objs			:= i2c-core-base.o i2c-core-smbus.o
 i2c-core-$(CONFIG_ACPI)		+= i2c-core-acpi.o
 i2c-core-$(CONFIG_I2C_SLAVE)	+= i2c-core-slave.o
 i2c-core-$(CONFIG_OF)		+= i2c-core-of.o
+i2c-core-$(CONFIG_OF_DYNAMIC)	+= i2c-core-of-prober.o
 
 obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
new file mode 100644
index 000000000000..cc1aae9fef43
--- /dev/null
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux I2C core OF component prober code
+ *
+ * Copyright (C) 2024 Google LLC
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/i2c-of-prober.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+/*
+ * Some devices, such as Google Hana Chromebooks, are produced by multiple
+ * vendors each using their preferred components. Such components are all
+ * in the device tree. Instead of having all of them enabled and having each
+ * driver separately try and probe its device while fighting over shared
+ * resources, they can be marked as "fail-needs-probe" and have a prober
+ * figure out which one is actually used beforehand.
+ *
+ * This prober assumes such drop-in parts are on the same I2C bus, have
+ * non-conflicting addresses, and can be directly probed by seeing which
+ * address responds.
+ *
+ * TODO:
+ * - Support handling common regulators.
+ * - Support handling common GPIOs.
+ * - Support I2C muxes
+ */
+
+static struct device_node *i2c_of_probe_get_i2c_node(struct device *dev, const char *type)
+{
+	struct device_node *node __free(device_node) = of_find_node_by_name(NULL, type);
+	if (!node)
+		return dev_err_ptr_probe(dev, -ENODEV, "Could not find %s device node\n", type);
+
+	struct device_node *i2c_node __free(device_node) = of_get_parent(node);
+	if (!of_node_name_eq(i2c_node, "i2c"))
+		return dev_err_ptr_probe(dev, -EINVAL, "%s device isn't on I2C bus\n", type);
+
+	if (!of_device_is_available(i2c_node))
+		return dev_err_ptr_probe(dev, -ENODEV, "I2C controller not available\n");
+
+	return no_free_ptr(i2c_node);
+}
+
+static int i2c_of_probe_enable_node(struct device *dev, struct device_node *node)
+{
+	int ret;
+
+	dev_dbg(dev, "Enabling %pOF\n", node);
+
+	struct of_changeset *ocs __free(kfree) = kzalloc(sizeof(*ocs), GFP_KERNEL);
+	if (!ocs)
+		return -ENOMEM;
+
+	of_changeset_init(ocs);
+	ret = of_changeset_update_prop_string(ocs, node, "status", "okay");
+	if (ret)
+		return ret;
+
+	ret = of_changeset_apply(ocs);
+	if (ret) {
+		/* ocs needs to be explicitly cleaned up before being freed. */
+		of_changeset_destroy(ocs);
+	} else {
+		/*
+		 * ocs is intentionally kept around as it needs to
+		 * exist as long as the change is applied.
+		 */
+		void *ptr __always_unused = no_free_ptr(ocs);
+	}
+
+	return ret;
+}
+
+static const struct i2c_of_probe_ops i2c_of_probe_dummy_ops;
+
+/**
+ * i2c_of_probe_component() - probe for devices of "type" on the same i2c bus
+ * @dev: Pointer to the &struct device of the caller, only used for dev_printk() messages.
+ * @cfg: Pointer to the &struct i2c_of_probe_cfg containing callbacks and other options
+ *       for the prober.
+ * @ctx: Context data for callbacks.
+ *
+ * Probe for possible I2C components of the same "type" (&i2c_of_probe_cfg->type)
+ * on the same I2C bus that have their status marked as "fail-needs-probe".
+ *
+ * Assumes that across the entire device tree the only instances of nodes
+ * with "type" prefixed node names (not including the address portion) are
+ * the ones that need handling for second source components. In other words,
+ * if "type" is "touchscreen", then all device nodes named "touchscreen*"
+ * are the ones that need probing. There cannot be another "touchscreen*"
+ * node that is already enabled.
+ *
+ * Assumes that for each "type" of component, only one actually exists. In
+ * other words, only one matching and existing device will be enabled.
+ *
+ * Context: Process context only. Does non-atomic I2C transfers.
+ *          Should only be used from a driver probe function, as the function
+ *          can return -EPROBE_DEFER if the I2C adapter or other resources
+ *          are unavailable.
+ * Return: 0 on success or no-op, error code otherwise.
+ *         A no-op can happen when it seems like the device tree already
+ *         has components of the type to be probed already enabled. This
+ *         can happen when the device tree had not been updated to mark
+ *         the status of the to-be-probed components as "fail-needs-probe".
+ *         Or this function was already run with the same parameters and
+ *         succeeded in enabling a component. The latter could happen if
+ *         the user had multiple types of components to probe, and one of
+ *         them down the list caused a deferred probe. This is expected
+ *         behavior.
+ */
+int i2c_of_probe_component(struct device *dev, const struct i2c_of_probe_cfg *cfg, void *ctx)
+{
+	const struct i2c_of_probe_ops *ops;
+	const char *type;
+	struct i2c_adapter *i2c;
+	int ret;
+
+	ops = cfg->ops ?: &i2c_of_probe_dummy_ops;
+	type = cfg->type;
+
+	struct device_node *i2c_node __free(device_node) = i2c_of_probe_get_i2c_node(dev, type);
+	if (IS_ERR(i2c_node))
+		return PTR_ERR(i2c_node);
+
+	/*
+	 * If any devices of the given "type" are already enabled then this function is a no-op.
+	 * Either the device tree hasn't been modified to work with this probe function, or the
+	 * function had already run before and enabled some component.
+	 */
+	for_each_child_of_node_with_prefix(i2c_node, node, type)
+		if (of_device_is_available(node))
+			return 0;
+
+	i2c = of_get_i2c_adapter_by_node(i2c_node);
+	if (!i2c)
+		return dev_err_probe(dev, -EPROBE_DEFER, "Couldn't get I2C adapter\n");
+
+	/* Grab and enable resources */
+	ret = 0;
+	if (ops->enable)
+		ret = ops->enable(dev, i2c_node, ctx);
+	if (ret)
+		goto out_put_i2c_adapter;
+
+	for_each_child_of_node_with_prefix(i2c_node, node, type) {
+		union i2c_smbus_data data;
+		u32 addr;
+
+		if (of_property_read_u32(node, "reg", &addr))
+			continue;
+		if (i2c_smbus_xfer(i2c, addr, 0, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data) < 0)
+			continue;
+
+		/* Found a device that is responding */
+		if (ops->cleanup_early)
+			ops->cleanup_early(dev, ctx);
+		ret = i2c_of_probe_enable_node(dev, node);
+		break;
+	}
+
+	if (ops->cleanup)
+		ops->cleanup(dev, ctx);
+out_put_i2c_adapter:
+	i2c_put_adapter(i2c);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(i2c_of_probe_component, I2C_OF_PROBER);
diff --git a/include/linux/i2c-of-prober.h b/include/linux/i2c-of-prober.h
new file mode 100644
index 000000000000..b771da21a051
--- /dev/null
+++ b/include/linux/i2c-of-prober.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Definitions for the Linux I2C OF component prober
+ *
+ * Copyright (C) 2024 Google LLC
+ */
+
+#ifndef _LINUX_I2C_OF_PROBER_H
+#define _LINUX_I2C_OF_PROBER_H
+
+struct device;
+struct device_node;
+
+/**
+ * struct i2c_of_probe_ops - I2C OF component prober callbacks
+ *
+ * A set of callbacks to be used by i2c_of_probe_component().
+ *
+ * All callbacks are optional. Callbacks are called only once per run, and are
+ * used in the order they are defined in this structure.
+ *
+ * All callbacks that have return values shall return %0 on success,
+ * or a negative error number on failure.
+ *
+ * The @dev parameter passed to the callbacks is the same as @dev passed to
+ * i2c_of_probe_component(). It should only be used for dev_printk() calls
+ * and nothing else, especially not managed device resource (devres) APIs.
+ */
+struct i2c_of_probe_ops {
+	/**
+	 * @enable: Retrieve and enable resources so that the components respond to probes.
+	 *
+	 * Resources should be reverted to their initial state before returning if this fails.
+	 */
+	int (*enable)(struct device *dev, struct device_node *bus_node, void *data);
+
+	/**
+	 * @cleanup_early: Release exclusive resources prior to enabling component.
+	 *
+	 * Only called if a matching component is actually found. If none are found,
+	 * resources that would have been released in this callback should be released in
+	 * @free_resourcs_late instead.
+	 */
+	void (*cleanup_early)(struct device *dev, void *data);
+
+	/**
+	 * @cleanup: Opposite of @enable to balance refcounts and free resources after probing.
+	 *
+	 * Should check if resources were already freed by @cleanup_early.
+	 */
+	void (*cleanup)(struct device *dev, void *data);
+};
+
+/**
+ * struct i2c_of_probe_cfg - I2C OF component prober configuration
+ * @ops: Callbacks for the prober to use.
+ * @type: A string to match the device node name prefix to probe for.
+ */
+struct i2c_of_probe_cfg {
+	const struct i2c_of_probe_ops *ops;
+	const char *type;
+};
+
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
+
+int i2c_of_probe_component(struct device *dev, const struct i2c_of_probe_cfg *cfg, void *ctx);
+
+#endif /* IS_ENABLED(CONFIG_OF_DYNAMIC) */
+
+#endif /* _LINUX_I2C_OF_PROBER_H */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


