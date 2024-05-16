Return-Path: <linux-kernel+bounces-181210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C218C7906
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFF128597D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AC14F9CC;
	Thu, 16 May 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FOD90Ys8"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C514E2F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872138; cv=none; b=OFkfrdp3PgZ4X5THEZr+gLuBd8C8jHAO5dTjBtILf5/MzQ0XvdvK4QpjCNeXzk1R7cv4GoBKpPUBQfEnjE9MmUqvoFfp1Zj5VmaopylErW9hidCBhXpryzvBn2cmtUWzmFtsqh6vPYNSn7CKAOADPBeIKEOp7BOt4tW9NgWFyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872138; c=relaxed/simple;
	bh=p/YPY8cjy1AkeLBPe0wJNMGliuqwW5LH2qnn291HdqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TerGZmfC9JdXSU4boMitGHH0gypcqmhhX/O2hb9/QMxjPUvqHTm9yluhs9fgvj+vy4qpYmYZBhdrfBJIhpN3rKjaL+axV66D9A/vZWI0B4W0W5yO0UgyhV9SqL7zNDyTYls8fAOJmW4CEJytowGO/Qk6rt3dQwsHxv8EGk+10eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FOD90Ys8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4201986d60aso29144345e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872135; x=1716476935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puB+gD3ay9Sx041zZz0+FhSyarhWutAqTKpIgu3JFCo=;
        b=FOD90Ys8thMEkMdPY3oNFgRuhC+Xr43s+32UV1ygh2lCl2NaKDdsrfongK/mEZ8FLS
         N2TuWnETfs2nCNOd8UnGnRO02HhGLwZzLfhSvZPdqZOoWlNaU1a8ULrxIsE/svKVGiJ/
         vDL5ReN4LznmB0QaeDxE2IyO4nCJ5LCc5dJbpSL7MLqNToKqa9cELH9f6dJOU7s82KEP
         0WvJuRTPG9n+n5GaMQSAh2QzPwilXYHN8Q/hubFAiVOJAMlLJIwIsnNWpILadx0gRwwZ
         KZaS6vF8C4LB6bLOWnHNlnkdolahbInlyZeOOgG/z6Eq07/6uHLh4n9U+l4FMT9ZV809
         d/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872135; x=1716476935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puB+gD3ay9Sx041zZz0+FhSyarhWutAqTKpIgu3JFCo=;
        b=jjGM0EqlmRvhS3siYG7n5+4I5KWiKWlKs1fTp7dSbrQ82HfabQciDWUI2EOWYrSdYi
         sJYRFGA8TEYlWkoC4NArtFZh25ouC+6Ke8ImmDjOzuyLCu/WQfKGzGD3gD7Bfd0FDmrc
         uzqG1uPFic/2UgTQK8Dyd6Q1aSDX2sIgP4KIADu4uyB9vO9YuAXwOnNs18bFhaQzDg22
         Yo5+Hon30rUMMTDSjykM9Sy2WN1BqMbuDIwbispWTYHoegD+PuO5/fsgoVrVaqzKwF7x
         AJB2+vnfXRzL00OECeZ1yEbm7UX8uYxzritMVh7jHd8dmDSGjHHjlb3rjlaBLz5ANoM0
         +eOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWIoOO8TsIe8T8QTahX7LnbpJHEFLfxH8R/5rqo4GfssGTYDsbzNGT41DQ/jM5WqlxHQbLsLqvVTkgS+15kIJ+599lDoczBOAQ/d4M
X-Gm-Message-State: AOJu0YxaHlEPKf+TWQiUqbi4zH2SsZdP9FQkgnHkipR2im0Ayk7w1kVI
	aHiH9A3zR5XFw/NmnPZriIt4RZr0/RD41OHiDG8FWJJ7PPVFgVCIvdeGkvXeULY=
X-Google-Smtp-Source: AGHT+IERIDiWGU6HrqYN8ZiuBsFdA4JZIIGZnn0g1+UjHbl3RAe6+oeD2WgCdEHGNIBGCjI44i0UXQ==
X-Received: by 2002:a05:600c:1383:b0:41c:2992:a3bd with SMTP id 5b1f17b1804b1-41feac5a45fmr141942315e9.27.1715872134895;
        Thu, 16 May 2024 08:08:54 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1fce:7e5a:e201:edd5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm309351725e9.18.2024.05.16.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:08:54 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [RFC PATCH 8/9] clk: meson: add auxiliary reset helper driver
Date: Thu, 16 May 2024 17:08:38 +0200
Message-ID: <20240516150842.705844-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add an helper module to register auxiliary reset drivers from
Amlogic clock controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig             |  5 ++
 drivers/clk/meson/Makefile            |  1 +
 drivers/clk/meson/meson-clk-rst-aux.c | 84 +++++++++++++++++++++++++++
 drivers/clk/meson/meson-clk-rst-aux.h | 14 +++++
 4 files changed, 104 insertions(+)
 create mode 100644 drivers/clk/meson/meson-clk-rst-aux.c
 create mode 100644 drivers/clk/meson/meson-clk-rst-aux.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 59a40a49f8e1..6905aa2f080c 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -37,6 +37,11 @@ config COMMON_CLK_MESON_VCLK
 config COMMON_CLK_MESON_CLKC_UTILS
 	tristate
 
+config COMMON_CLK_MESON_CLK_RST_AUX
+	depends on REGMAP && AUXILIARY_BUS
+	imply RESET_MESON
+	tristate
+
 config COMMON_CLK_MESON_AO_CLKC
 	tristate
 	select COMMON_CLK_MESON_REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 9ba43fe7a07a..2926a04b6c33 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,6 +2,7 @@
 # Amlogic clock drivers
 
 obj-$(CONFIG_COMMON_CLK_MESON_CLKC_UTILS) += meson-clkc-utils.o
+obj-$(CONFIG_COMMON_CLK_MESON_CLK_RST_AUX) += meson-clk-rst-aux.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_CPU_DYNDIV) += clk-cpu-dyndiv.o
 obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
diff --git a/drivers/clk/meson/meson-clk-rst-aux.c b/drivers/clk/meson/meson-clk-rst-aux.c
new file mode 100644
index 000000000000..a7cf3c39828c
--- /dev/null
+++ b/drivers/clk/meson/meson-clk-rst-aux.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2024 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/auxiliary_bus.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <soc/amlogic/meson8b-auxiliary-reset.h>
+
+#include "meson-clk-rst-aux.h"
+
+static DEFINE_IDA(meson_clk_rst_aux_ida);
+
+static void meson_clk_rst_aux_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct meson8b_reset_adev *raux =
+		to_meson8b_reset_adev(adev);
+
+	ida_free(&meson_clk_rst_aux_ida, adev->id);
+	kfree(raux);
+}
+
+static void meson_clk_rst_aux_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+int devm_meson_clk_rst_aux_register(struct device *dev,
+				    struct regmap *map,
+				    const char *adev_name)
+{
+	struct meson8b_reset_adev *raux;
+	struct auxiliary_device *adev;
+	int ret;
+
+	raux = kzalloc(sizeof(*raux), GFP_KERNEL);
+	if (!raux)
+		return -ENOMEM;
+
+	ret = ida_alloc(&meson_clk_rst_aux_ida, GFP_KERNEL);
+	if (ret < 0)
+		goto raux_free;
+
+	raux->map = map;
+
+	adev = &raux->adev;
+	adev->id = ret;
+	adev->name = adev_name;
+	adev->dev.parent = dev;
+	adev->dev.release = meson_clk_rst_aux_release;
+	device_set_of_node_from_dev(&adev->dev, dev);
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		goto ida_free;
+
+	ret = __auxiliary_device_add(adev, dev->driver->name);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, meson_clk_rst_aux_unregister_adev,
+					adev);
+
+ida_free:
+	ida_free(&meson_clk_rst_aux_ida, adev->id);
+raux_free:
+	kfree(raux);
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(devm_meson_clk_rst_aux_register);
+
+MODULE_DESCRIPTION("Amlogic auxiliary reset helper for clock");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/meson-clk-rst-aux.h b/drivers/clk/meson/meson-clk-rst-aux.h
new file mode 100644
index 000000000000..386a55a36cd9
--- /dev/null
+++ b/drivers/clk/meson/meson-clk-rst-aux.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_RST_AUX_H
+#define __MESON_CLK_RST_AUX_H
+
+int devm_meson_clk_rst_aux_register(struct device *dev,
+				    struct regmap *map,
+				    const char *adev_name);
+
+#endif /* __MESON_CLK_RST_AUX_H */
-- 
2.43.0


