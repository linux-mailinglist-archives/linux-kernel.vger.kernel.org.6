Return-Path: <linux-kernel+bounces-525837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606DA3F61E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1740177C11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2689220B1F5;
	Fri, 21 Feb 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Qghw0Sxn"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231F18E025
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144918; cv=none; b=crHaSo2i5RG8abMQ/uqiyDuhuicvephWgJwV+joh5CnZVok9CmCMdu6wHF+Zt0n2U1F7tAK9A9l4o26bzXxlI2NDal0KQFWaCJRQBi/KQizjTmggH38ya3AMyBYjZPm7FO8jAjV34eqmCswx+RdcXtS2iNOj01BzBXc63bs9jdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144918; c=relaxed/simple;
	bh=69CvHWZCFYdgSTEbn1gjw1hCDAGPbz7reY7F+bDUKeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+mwuI+v/ME0xLwv76LUlWD9hOEiCNtFbPwWxJxOnqJqmdwOJ6iFqZBPzPK6j+SEEkNOWL/RaqVA7smLVfDQVMBQpnpzvxXvBKjEzrAq7QhRvYf+CMZMWxQ1jkpqaOlixqIEtKl6NalVmyjd2EdUgCnlqc03QSA5fgsC/h5K9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Qghw0Sxn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA29F41233
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740144913;
	bh=xQDKR8FhSx54xF1plKDryRTd9+jWjE/ZJaV1ShM5yWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Qghw0SxnMGt8QBC3JW9JY3x+XS3y47QbEslo7IHNjdZlGBLI8ZeXpNLHcVN3ZbO6C
	 xl8FrToV3Ax3r8zuhHd6/YQptmSyLDw6W7+75lA4yPdWdIRLv6B8lUA3bxbC6wI1Hq
	 YZPX6DdNTLhYnomV2IsVZ9fFh5SAsj9Ze0hmLx92Hs84Kgq1R9Vw4b3QnegP7H11O5
	 YlDrPQlWX0/CZ1pSCAucORmpF80awBapF23JEfF47s3zQeFbyoaf1tfMgmZ4X1vzT8
	 SD3kETcFwDRubHlumKMO9DNmh5xCotrBLbJzJ4sNywZIwJOYaBqHou6CmijdfYo1HK
	 E2VKugbFBknKg==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so3878563a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144912; x=1740749712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQDKR8FhSx54xF1plKDryRTd9+jWjE/ZJaV1ShM5yWg=;
        b=AhguDR8nMGpNPOe8JkxNOYlRemX+1eN8RyB7PSSI6Y4nDY4He9Ch0TT2+kNVTAipzZ
         CAGvTEZNMQraN7cDK+aEAn9mFlZFys8lUfmy59Eh1wLdJYWgtBoxk+H9Lc2WHX8QG4gC
         0Zo2xegxX8PSDCokOTOh5kcCREP4qO9PQVCkF+D9zUubKIX+evst5AK7LgXApMHlhwde
         OLHpoqoN1zzikfbhwZ+CKFOPl/UF0YW7RB1nIV2es5tB7kxqRlLN4paNielapT/+YGhC
         Tu+KfdIIrMRH9nG/1yyB+gzuPtxiC+ihxGRiMxUkMvTRwsR0BBA4I4ZCl3EVQygu2GUE
         1FJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWv+Cnsmxd5XUw5lhfK/+n0JNaiqqjZRmBLBKQ+94TygetiIWdN2LeI/lgpI2Ix3ux3KCQL591D1h+ZaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9WYOTrSZuvQUAOdCUBCOnQ6jMXWLqFprnstpDINp7M7ChQK0
	FEa9ZBVfmX0hBqugW1PUnmb/lhxWckUFQuj4HdIFBrLVLHZGyjDaVfbmYxOEAGm6Dc2RT2Jmte7
	kRelKWX5vDtNUVvdRHWS8DOoHwOWobfXGbP8Pq7CVZ+zrpgoV/dhla+fzhtNLSNTneQTqZYJc59
	tcXA==
X-Gm-Gg: ASbGncvsbtGs4RljSUW+KHwDuW+TL3qoOTYUWvOcMqODpZUcFOq3rI/3cQh8yRt2W4r
	TqmELcNALLbodjMeW8NokaZxHOtNovNyTT3x1GxohPnbH7YAQsouvZpSj6USoNMwwMmszJthWwI
	o6JIoqe/ialsM+tWvPCI6nXGvbDrzIMjxClL2AsN0lStF91Enlu6aPqV2I7OAavGAuq2ZV7sBuL
	VoWQm+pYCZxk2xBVt1aN1YfiT2ZQhdWcGp86eW3zW+uNPSAKzwd1fovLMz1ObezOoFg2zbnqvlj
	Yl45T6rz7Z1NApOW
X-Received: by 2002:a05:6a00:98f:b0:732:1eb2:7bf3 with SMTP id d2e1a72fcca58-73426d9f1abmr5620403b3a.21.1740144912382;
        Fri, 21 Feb 2025 05:35:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnNW6ktOwXAyFRQS/Z2lJ766Nk+fIdyEK6MLtv9HEvRdCBl0h57AH5PdWHmcGb/gkiaQ+5Nw==
X-Received: by 2002:a05:6a00:98f:b0:732:1eb2:7bf3 with SMTP id d2e1a72fcca58-73426d9f1abmr5620358b3a.21.1740144912074;
        Fri, 21 Feb 2025 05:35:12 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:2777:7867:71cd:dd56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325d65619bsm12565459b3a.113.2025.02.21.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:35:11 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] gpio: introduce utilities for synchronous fake device creation
Date: Fri, 21 Feb 2025 22:34:59 +0900
Message-ID: <20250221133501.2203897-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250221133501.2203897-1-koichiro.den@canonical.com>
References: <20250221133501.2203897-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
platform device, wait for probe completion, and retrieve the probe
success or error status synchronously. With gpio-aggregator planned to
adopt this approach for its configfs interface, it's time to factor
out the common code.

Add dev-sync-probe.[ch] to house helper functions used by all such
implementations.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/Kconfig          |  3 ++
 drivers/gpio/Makefile         |  3 ++
 drivers/gpio/dev-sync-probe.c | 97 +++++++++++++++++++++++++++++++++++
 drivers/gpio/dev-sync-probe.h | 25 +++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 drivers/gpio/dev-sync-probe.c
 create mode 100644 drivers/gpio/dev-sync-probe.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 56c1f30ac195..e15405add317 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1947,3 +1947,6 @@ config GPIO_VIRTUSER
 endmenu
 
 endif
+
+config DEV_SYNC_PROBE
+	tristate
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index af3ba4d81b58..af130882ffee 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -19,6 +19,9 @@ obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 # directly supported by gpio-generic
 gpio-generic-$(CONFIG_GPIO_GENERIC)	+= gpio-mmio.o
 
+# Utilities for drivers that need synchronous fake device creation
+obj-$(CONFIG_DEV_SYNC_PROBE)		+= dev-sync-probe.o
+
 obj-$(CONFIG_GPIO_104_DIO_48E)		+= gpio-104-dio-48e.o
 obj-$(CONFIG_GPIO_104_IDI_48)		+= gpio-104-idi-48.o
 obj-$(CONFIG_GPIO_104_IDIO_16)		+= gpio-104-idio-16.o
diff --git a/drivers/gpio/dev-sync-probe.c b/drivers/gpio/dev-sync-probe.c
new file mode 100644
index 000000000000..9ea733b863b2
--- /dev/null
+++ b/drivers/gpio/dev-sync-probe.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Common code for drivers creating fake platform devices.
+ *
+ * Provides synchronous device creation: waits for probe completion and
+ * returns the probe success or error status to the device creator.
+ *
+ * Copyright (C) 2021 Bartosz Golaszewski <brgl@bgdev.pl>
+ * Copyright (C) 2025 Koichiro Den <koichiro.den@canonical.com>
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#include "dev-sync-probe.h"
+
+static int dev_sync_probe_notifier_call(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct dev_sync_probe_data *pdata;
+	struct device *dev = data;
+
+	pdata = container_of(nb, struct dev_sync_probe_data, bus_notifier);
+	if (!device_match_name(dev, pdata->name))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_BOUND_DRIVER:
+		pdata->driver_bound = true;
+		break;
+	case BUS_NOTIFY_DRIVER_NOT_BOUND:
+		pdata->driver_bound = false;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	complete(&pdata->probe_completion);
+	return NOTIFY_OK;
+}
+
+void dev_sync_probe_init(struct dev_sync_probe_data *data)
+{
+	memset(data, 0, sizeof(*data));
+	init_completion(&data->probe_completion);
+	data->bus_notifier.notifier_call = dev_sync_probe_notifier_call;
+}
+EXPORT_SYMBOL_GPL(dev_sync_probe_init);
+
+int dev_sync_probe_register(struct dev_sync_probe_data *data,
+			    struct platform_device_info *pdevinfo)
+{
+	struct platform_device *pdev;
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "%s.%d", pdevinfo->name, pdevinfo->id);
+	if (!name)
+		return -ENOMEM;
+
+	data->driver_bound = false;
+	data->name = name;
+	reinit_completion(&data->probe_completion);
+	bus_register_notifier(&platform_bus_type, &data->bus_notifier);
+
+	pdev = platform_device_register_full(pdevinfo);
+	if (IS_ERR(pdev)) {
+		bus_unregister_notifier(&platform_bus_type, &data->bus_notifier);
+		kfree(data->name);
+		return PTR_ERR(pdev);
+	}
+
+	wait_for_completion(&data->probe_completion);
+	bus_unregister_notifier(&platform_bus_type, &data->bus_notifier);
+
+	if (!data->driver_bound) {
+		platform_device_unregister(pdev);
+		kfree(data->name);
+		return -ENXIO;
+	}
+
+	data->pdev = pdev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_sync_probe_register);
+
+void dev_sync_probe_unregister(struct dev_sync_probe_data *data)
+{
+	platform_device_unregister(data->pdev);
+	kfree(data->name);
+	data->pdev = NULL;
+}
+EXPORT_SYMBOL_GPL(dev_sync_probe_unregister);
+
+MODULE_AUTHOR("Bartosz Golaszewski <brgl@bgdev.pl>");
+MODULE_AUTHOR("Koichiro Den <koichiro.den@canonical.com>");
+MODULE_DESCRIPTION("Utilities for synchronous fake device creation");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/dev-sync-probe.h b/drivers/gpio/dev-sync-probe.h
new file mode 100644
index 000000000000..4b3d52b70519
--- /dev/null
+++ b/drivers/gpio/dev-sync-probe.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef DEV_SYNC_PROBE_H
+#define DEV_SYNC_PROBE_H
+
+#include <linux/completion.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+
+struct dev_sync_probe_data {
+	struct platform_device *pdev;
+	const char *name;
+
+	/* Synchronize with probe */
+	struct notifier_block bus_notifier;
+	struct completion probe_completion;
+	bool driver_bound;
+};
+
+void dev_sync_probe_init(struct dev_sync_probe_data *data);
+int dev_sync_probe_register(struct dev_sync_probe_data *data,
+			    struct platform_device_info *pdevinfo);
+void dev_sync_probe_unregister(struct dev_sync_probe_data *data);
+
+#endif /* DEV_SYNC_PROBE_H */
-- 
2.45.2


