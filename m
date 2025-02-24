Return-Path: <linux-kernel+bounces-528354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3EBA416D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A91719D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36527453;
	Mon, 24 Feb 2025 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGU9s7nZ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57B19DF4B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384096; cv=none; b=MqWesSUCdy0KXL62qAj9elQGN/dUYhFToLIQeURqpnnDVgn1FE/gTn7HHF87b6PRyhTE16/w+GURbLT+UZchkeebLYRnNfBQNTktTGvPnbKV9gaiq+4hucuF6vBjjmpJPiGSlNaM0lW2ocglTwRlmnE50rAeo08Rcp3qWaY5y4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384096; c=relaxed/simple;
	bh=hCBzOfJSymMyHvVROjcOk8C8vSA3TYnFB5U/O/rnkDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uteDsqo89+H9hXa2FePt/J+/m0RXMOSqFoyklUuK8+NbqdnhkemAv6qoGsfoOAVBq+Z9SEnkhYkwoKVh7Xk7ndC4nNswfjUTuEK+JI/wxEjPn4Q7yFyRWgWy02EdOlp+yXPxOTEMQx4ioSJmSVTWEC8mmyrXCxd/JOOOGYShdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZGU9s7nZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2306802f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384093; x=1740988893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eldJ3fyZ9RULfFnJAoQ78yq6LgsezdF6MepZXaC6j0I=;
        b=ZGU9s7nZyGIXGCA7gkVySgfwKjFLShwI0dJ0LbJft9bo8V7LVRU8iESS3TrOeo0EfI
         qCfr2mXHEGnyuH2YzUEb4e8ytEr9zSHV8XBbNiTMpQtVNUBEiMW3Yn/4NvWpWWeEqbHi
         Y/dzIyqLXLAe+JeLHZDP1UVHREQszryPpCSELOJyLjUBnwU3fHeJHS+ESnU3eMnIg3yX
         XhqtBLSjzeSxgy282vtRYEkZgyrmfydNiJq+eGZs/+vnGv+zC1G34NFVr+sc7pK3djl2
         1lqNL9M0qB5XRhIoFEL0KW149A1Ann78LNhTmquv1qN6N7eEvtEWBPBd4mGuWKzk4FCF
         by/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384093; x=1740988893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eldJ3fyZ9RULfFnJAoQ78yq6LgsezdF6MepZXaC6j0I=;
        b=S1GQcDmR4Y9f6DLdb7lORJaWqf4w/CdzgYYaNSTFTSDGfvUnCIp1kWTgFJav7MVjIo
         A2XUbQonWU9IOIpNNRP3/QiWVQi8ikOSAnOPkF4GMA3RD85wcI2pcXPXCNErVJpjK1aK
         Dx+DjuGL3GRZJTN0l2zSoXnEPAZP1qFX08eOQ4IzLIAn01dqbIhvL9UjtcblK5aFyZsV
         vLvZlp3vGg8MwZyVY7lR7zKnfX8Csrxbaq9vwQ419wlcEa52O4vCS/F/kRSUs8OtTBuh
         3WlXFsSC+7JQOkfg1g1BoutX7PdkDzBuK+MosbDi8goW7kpqpyKpa8m9CkfikLZWxFGm
         7T4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjZR2fZbj0whwosY2zxCByJSHxsWSkGYDnGIT0u+4vdPd7eheny/A4Q3/Yn8xNVKduGXVM20irtAZ3BsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JESrBVBje0frPaGPksFQGejwgqb2fztcH9I+mauBhjdsJ5mi
	tou7350NnaeWBY4eTDLwnSTR4HrFFRHp7uorjqS+Jkz2PqUo6fu6gShB9gdmb0A=
X-Gm-Gg: ASbGnctj8S1JpPsRUmsPYxE9m/b5CBXcH7A4SY03XcnWMvWOxey/yXUoFrrxtP6Q5vq
	HdQKmaPQo3qGS48KTnIs1LY52cWYj5/RAG2vLxfp4g3ZXUOGEM6CUCizMDK9/d0Qy04lZyuivCh
	PhOa+fm7B3akexbEiJbFNFl77OSUUd7atY2bz91YE0lpYKYhoKmghI9qhSYaswazkyPk5r/87sr
	uzxm1nzzOaGNPXR2hQ1mpmJu5/SSiCOowp11IzKrz4Ijp0l3kF8S5moXob5CjzShm8AYXy0G1QI
	KMVSHtEIcundOqUMinamBTsVlvvC+x53MMXclZ/jmSZ/LoY7kOqEzJa45eTGx7CtFUICiZ974nr
	9TFcitg==
X-Google-Smtp-Source: AGHT+IHtf5uVeObOSZyCBZwbvEGvCzNRNum9va67etYAmQ/b61RunJpq5G91CksEuJbTMQeAIBjKag==
X-Received: by 2002:a05:6000:144a:b0:38f:2766:7594 with SMTP id ffacd0b85a97d-38f6e95c60cmr8671320f8f.12.1740384093024;
        Mon, 24 Feb 2025 00:01:33 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0367533sm97690395e9.27.2025.02.24.00.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:01:32 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Feb 2025 08:01:23 +0000
Subject: [PATCH 2/3] firmware: exynos-acpm: move common structures to
 exynos-acpm.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-acpm-debugfs-v1-2-2418a3ea1b17@linaro.org>
References: <20250224-acpm-debugfs-v1-0-2418a3ea1b17@linaro.org>
In-Reply-To: <20250224-acpm-debugfs-v1-0-2418a3ea1b17@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: andre.draszik@linaro.org, peter.griffin@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740384089; l=4949;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=hCBzOfJSymMyHvVROjcOk8C8vSA3TYnFB5U/O/rnkDE=;
 b=ATLynd3c1Y0yvN4/G4Wd0ln2S20qs67kvDyIgdhR9p4lEnrThWwETuUT7EpmvVxuE4ICAf2Hk
 NacKRW6DfReDLvZ+0SKuVRyS5pZc2HH7MZxIvDXf0/JNF0VtXLnWvh9
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Prepare for the ACPM logging feature addition. ACPM is capable of logging
things to SRAM. The logging feature needs access to struct acpm_info
in order to get the sram_base, to the configuration data from SRAM, and to
the struct acpm_queue internal driver representation of a queue.
Move these structs to a common exynos-acpm.h.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 48 +-------------------------
 drivers/firmware/samsung/exynos-acpm.h | 63 ++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 3c14afc89fd7..8d83841f1d62 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -12,7 +12,6 @@
 #include <linux/container_of.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/firmware/samsung/exynos-acpm-protocol.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mailbox/exynos-message.h>
@@ -27,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#include "exynos-acpm-xfer.h"
+#include "exynos-acpm.h"
 #include "exynos-acpm-pmic.h"
 
 #define ACPM_PROTOCOL_SEQNUM		GENMASK(21, 16)
@@ -38,20 +37,6 @@
 
 #define ACPM_GS101_INITDATA_BASE	0xa000
 
-/**
- * struct acpm_shmem - shared memory configuration information.
- * @reserved:	unused fields.
- * @chans:	offset to array of struct acpm_chan_shmem.
- * @reserved1:	unused fields.
- * @num_chans:	number of channels.
- */
-struct acpm_shmem {
-	u32 reserved[2];
-	u32 chans;
-	u32 reserved1[3];
-	u32 num_chans;
-};
-
 /**
  * struct acpm_chan_shmem - descriptor of a shared memory channel.
  *
@@ -85,19 +70,6 @@ struct acpm_chan_shmem {
 	u32 poll_completion;
 };
 
-/**
- * struct acpm_queue - exynos acpm queue.
- *
- * @rear:	rear address of the queue.
- * @front:	front address of the queue.
- * @base:	base address of the queue.
- */
-struct acpm_queue {
-	void __iomem *rear;
-	void __iomem *front;
-	void __iomem *base;
-};
-
 /**
  * struct acpm_rx_data - RX queue data.
  *
@@ -155,24 +127,6 @@ struct acpm_chan {
 	struct acpm_rx_data rx_data[ACPM_SEQNUM_MAX];
 };
 
-/**
- * struct acpm_info - driver's private data.
- * @shmem:	pointer to the SRAM configuration data.
- * @sram_base:	base address of SRAM.
- * @chans:	pointer to the ACPM channel parameters retrieved from SRAM.
- * @dev:	pointer to the exynos-acpm device.
- * @handle:	instance of acpm_handle to send to clients.
- * @num_chans:	number of channels available for this controller.
- */
-struct acpm_info {
-	struct acpm_shmem __iomem *shmem;
-	void __iomem *sram_base;
-	struct acpm_chan *chans;
-	struct device *dev;
-	struct acpm_handle handle;
-	u32 num_chans;
-};
-
 /**
  * struct acpm_match_data - of_device_id data.
  * @initdata_base:	offset in SRAM where the channels configuration resides.
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
new file mode 100644
index 000000000000..c212fe28758a
--- /dev/null
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Samsung Electronics Co., Ltd.
+ * Copyright 2020 Google LLC.
+ * Copyright 2024 Linaro Ltd.
+ */
+#ifndef __EXYNOS_ACPM_H__
+#define __EXYNOS_ACPM_H__
+
+#include <linux/debugfs.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/types.h>
+
+#include "exynos-acpm-xfer.h"
+
+/**
+ * struct acpm_shmem - shared memory configuration information.
+ * @reserved:	unused fields.
+ * @chans:	offset to array of struct acpm_chan_shmem.
+ * @reserved1:	unused fields.
+ * @num_chans:	number of channels.
+ */
+struct acpm_shmem {
+	u32 reserved[2];
+	u32 chans;
+	u32 reserved1[3];
+	u32 num_chans;
+};
+
+/**
+ * struct acpm_queue - exynos acpm queue.
+ * @rear:	rear address of the queue.
+ * @front:	front address of the queue.
+ * @base:	base address of the queue.
+ */
+struct acpm_queue {
+	void __iomem *rear;
+	void __iomem *front;
+	void __iomem *base;
+};
+
+struct device;
+struct acpm_chan;
+
+/**
+ * struct acpm_info - driver's private data.
+ * @shmem:	pointer to the SRAM configuration data.
+ * @sram_base:	base address of SRAM.
+ * @chans:	pointer to the ACPM channel parameters retrieved from SRAM.
+ * @dev:	pointer to the exynos-acpm device.
+ * @handle:	instance of acpm_handle to send to clients.
+ * @num_chans:	number of channels available for this controller.
+ */
+struct acpm_info {
+	struct acpm_shmem __iomem *shmem;
+	void __iomem *sram_base;
+	struct acpm_chan *chans;
+	struct device *dev;
+	struct acpm_handle handle;
+	u32 num_chans;
+};
+
+#endif /* __EXYNOS_ACPM_H__ */

-- 
2.48.1.601.g30ceb7b040-goog


