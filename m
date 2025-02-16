Return-Path: <linux-kernel+bounces-516583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B95A37459
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A6018917A2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4A194C9E;
	Sun, 16 Feb 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FjmU+VmG"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041A192590
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710722; cv=none; b=DnsOkFPA9z+pq/3mGNrgbKlUHrrTrmGloqRpbax4y0iPqv3SwvWJ/0p4GALslGjYWuDZF7/xQHYbr7vhqk3nmGlDFNFb0p9cswy/4eux1rcGky7t1G/Bz44kRVLAj19maIdqDIteHQJZ4G26feFRYGKsQWIYWK9kjxQ0bBMcd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710722; c=relaxed/simple;
	bh=rEnR6g5dONAt30j589RxgJPlKFdaeKR/MdU4AsEK4Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+DlvBCK+QVtfBFB5hl2rju4ps0GeuemUIP+ca6ZD2nlJrv4odDw1HO6mMKeM+1Kwy6KIx6GCm6+5H+duBBYZeFFFdSU7dKhgnTqkI+/NO1sc4H3lH5G39NXbo3NMCMHmTlMEv0fVtJ+M6xRK7Rze7ceRe24UcN55ay9++pZMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FjmU+VmG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD3DA3F2BC
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710716;
	bh=YWbOsm+CZ0rP8EEsqBCFAU6ijhi7ERtYl/4TbSEKuvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=FjmU+VmG3XpGk8sOLsid9aMPn+kAU/cjp4u2KxpyZZOxGm5h4UTxVixjrpZuuFbDD
	 Wuz5Eoi0761f2wDojMMtJkX6r4mdtA0yJ8UHniXnZS4JcNGF/f5fxHH9DDdBbGp54B
	 tLgDy/kDlYzycaY9UQcz2Oi9vzFViBNgpkLjFxYur7ZopswgRTpAsL7eJWb0MSzvMi
	 vtDw8hsqi2EzaEqcP2vuQ8VD0lbyR/iDujrkigPDEXKrAQCnGRd7oABZ8+YbxVU1Xv
	 uWpZFZvtiR3iWEKWke4qjrnujsvNy6O1ny0Lsa2o5n9FMCQF26NIgWjRUJ/Nm9VWP2
	 W2L8T+tLv0Etg==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso9395665a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710715; x=1740315515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWbOsm+CZ0rP8EEsqBCFAU6ijhi7ERtYl/4TbSEKuvk=;
        b=UbImcP+yWxIj5CShjcKJyy6wrTDF20lMHKzCCTkVvbtvCjgdPaIwXr2PO1NW1DWQE/
         y7Kimx2FcNTurMD3F486DGReO1++g97eTJVvPLHdV5Q3qX1LFGvsNzqPdyzqIEvQ64G/
         dgULHx6ufwQDJdm7OQaMvdtDdc13eeSR2KGWprZggyc4QQ/VDJJhiM0EKjbWG+NhBT5O
         IaPq2fdWm35bpK7R+nVR1oc9h0TSt1qHdiQzFh1gXhamMemR/2gcUJuU2hrwogQo9BqU
         0Y2KFa4aFsu5pej9mP4OAxH4mtvq26VAf2mmnhb9io6kcpe4YnEhGLxbCRfX96pDdJBx
         ldsA==
X-Forwarded-Encrypted: i=1; AJvYcCWE0nyoX1cHviE7dTZ1dsDS2FKuEvxt4U/SRgLYcwx2CGCNVfZrqW4GopnWHosvSY5zzwdWVjjuW6VkBws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWueyZZcXdp4cE0pNQK5h3WCFJJHtjWsv09Lx3ZEexqPqFABY9
	MSA5GCHaIPmS+7W5w8BHovdCLS4+wLg3yYgQLrg62Un5YLJxS+ulW2EZ3K5AP0wZclW9DXNVBWr
	Dwfmis7tJbmffAnGEaa6YIoLOOgInOxk/YphQd34vYcdaFo2kfPeEs81Meq1vOOsTKdwlgH9kJ7
	Ea0g==
X-Gm-Gg: ASbGncss4hLuViDzxbFbsJzjmN+9LgKM42ltGHQ2nHtmJEJVJOB0AuIH/hTjYcpRJAC
	kfRE/OJdq7LYhbhtur/OBQbLaqgJykzLku8pcfeq7/upYAOlC/kJbcV4/308HVHVpIXmGGbghUJ
	RGQ7jKr2NdY461QDoADHOW1U3txXdZunCbCOZaqJHCr8/rSpvk3sNXo+VMdeE/XYTH3khj4BrTR
	yK3qu14Bg1K0MNLqJQyC+6hekxxuDnH8VhQt23ttdB7kiSQO0+BlQSdQ1nj8PY0JYWY6cmwVeMR
	EQk/Ng==
X-Received: by 2002:a05:6a20:918e:b0:1e4:80a9:3fb8 with SMTP id adf61e73a8af0-1ee8cb5d194mr9500718637.16.1739710715284;
        Sun, 16 Feb 2025 04:58:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm+gOGp9YBo5KHi2FrSJg3FynLc/Gzo+d49GTcLDk3uRw/FcP0OrcjD42Gx4gpZ8lwU2fMEg==
X-Received: by 2002:a05:6a20:918e:b0:1e4:80a9:3fb8 with SMTP id adf61e73a8af0-1ee8cb5d194mr9500690637.16.1739710715005;
        Sun, 16 Feb 2025 04:58:35 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:58:34 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/13] gpio: pseudo: common helper functions for pseudo gpio devices
Date: Sun, 16 Feb 2025 21:58:06 +0900
Message-ID: <20250216125816.14430-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250216125816.14430-1-koichiro.den@canonical.com>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
platform device and wait synchronously for probe completion.
With gpio-aggregator adopting the same approach in a later commit for
its configfs interface, it's time to factor out the common code.

Add gpio-pseudo.[ch] to house helper functions used by all the pseudo
GPIO device implementations.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/Kconfig       |  4 ++
 drivers/gpio/Makefile      |  1 +
 drivers/gpio/gpio-pseudo.c | 86 ++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-pseudo.h | 24 +++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 drivers/gpio/gpio-pseudo.c
 create mode 100644 drivers/gpio/gpio-pseudo.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 56c1f30ac195..1e2c95e03a95 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1863,6 +1863,10 @@ config GPIO_MPSSE
 
 endmenu
 
+# This symbol is selected by some pseudo gpio device implementations
+config GPIO_PSEUDO
+	bool
+
 menu "Virtual GPIO drivers"
 
 config GPIO_AGGREGATOR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index af3ba4d81b58..5eb54147a1ab 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -136,6 +136,7 @@ obj-$(CONFIG_GPIO_PISOSR)		+= gpio-pisosr.o
 obj-$(CONFIG_GPIO_PL061)		+= gpio-pl061.o
 obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
 obj-$(CONFIG_GPIO_POLARFIRE_SOC)	+= gpio-mpfs.o
+obj-$(CONFIG_GPIO_PSEUDO)		+= gpio-pseudo.o
 obj-$(CONFIG_GPIO_PXA)			+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+= gpio-raspberrypi-exp.o
 obj-$(CONFIG_GPIO_RC5T583)		+= gpio-rc5t583.o
diff --git a/drivers/gpio/gpio-pseudo.c b/drivers/gpio/gpio-pseudo.c
new file mode 100644
index 000000000000..6e3da05440d8
--- /dev/null
+++ b/drivers/gpio/gpio-pseudo.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Helper functions for Pseudo GPIOs
+ *
+ * Copyright 2025 Canonical Ltd.
+ */
+
+#include "gpio-pseudo.h"
+
+static int pseudo_gpio_notifier_call(struct notifier_block *nb,
+				     unsigned long action,
+				     void *data)
+{
+	struct pseudo_gpio_common *common;
+	struct device *dev = data;
+
+	common = container_of(nb, struct pseudo_gpio_common, bus_notifier);
+	if (!device_match_name(dev, common->name))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_BOUND_DRIVER:
+		common->driver_bound = true;
+		break;
+	case BUS_NOTIFY_DRIVER_NOT_BOUND:
+		common->driver_bound = false;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	complete(&common->probe_completion);
+	return NOTIFY_OK;
+}
+
+void pseudo_gpio_init(struct pseudo_gpio_common *common)
+{
+	memset(common, 0, sizeof(*common));
+	init_completion(&common->probe_completion);
+	common->bus_notifier.notifier_call = pseudo_gpio_notifier_call;
+}
+EXPORT_SYMBOL_GPL(pseudo_gpio_init);
+
+int pseudo_gpio_register(struct pseudo_gpio_common *common,
+			 struct platform_device_info *pdevinfo)
+{
+	struct platform_device *pdev;
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "%s.%u", pdevinfo->name, pdevinfo->id);
+	if (!name)
+		return -ENOMEM;
+
+	common->driver_bound = false;
+	common->name = name;
+	reinit_completion(&common->probe_completion);
+	bus_register_notifier(&platform_bus_type, &common->bus_notifier);
+
+	pdev = platform_device_register_full(pdevinfo);
+	if (IS_ERR(pdev)) {
+		bus_unregister_notifier(&platform_bus_type, &common->bus_notifier);
+		kfree(common->name);
+		return PTR_ERR(pdev);
+	}
+
+	wait_for_completion(&common->probe_completion);
+	bus_unregister_notifier(&platform_bus_type, &common->bus_notifier);
+
+	if (!common->driver_bound) {
+		platform_device_unregister(pdev);
+		kfree(common->name);
+		return -ENXIO;
+	}
+
+	common->pdev = pdev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pseudo_gpio_register);
+
+void pseudo_gpio_unregister(struct pseudo_gpio_common *common)
+{
+	platform_device_unregister(common->pdev);
+	kfree(common->name);
+	common->pdev = NULL;
+}
+EXPORT_SYMBOL_GPL(pseudo_gpio_unregister);
diff --git a/drivers/gpio/gpio-pseudo.h b/drivers/gpio/gpio-pseudo.h
new file mode 100644
index 000000000000..093112b6cce5
--- /dev/null
+++ b/drivers/gpio/gpio-pseudo.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef GPIO_PSEUDO_H
+#define GPIO_PSEUDO_H
+
+#include <linux/completion.h>
+#include <linux/platform_device.h>
+
+struct pseudo_gpio_common {
+	struct platform_device *pdev;
+	const char *name;
+
+	/* Synchronize with probe */
+	struct notifier_block bus_notifier;
+	struct completion probe_completion;
+	bool driver_bound;
+};
+
+void pseudo_gpio_init(struct pseudo_gpio_common *common);
+int pseudo_gpio_register(struct pseudo_gpio_common *common,
+			 struct platform_device_info *pdevinfo);
+void pseudo_gpio_unregister(struct pseudo_gpio_common *common);
+
+#endif /* GPIO_PSEUDO_H */
-- 
2.45.2


