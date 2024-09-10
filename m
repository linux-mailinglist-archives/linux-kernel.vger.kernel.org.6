Return-Path: <linux-kernel+bounces-323461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10D973D71
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B49285D91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C871AC44A;
	Tue, 10 Sep 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fJzL4eUU"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908781ABECE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985994; cv=none; b=Wj0wEcnwUCcvQ52n5ARhHKn6UR5U1iR2ZdxZetOF7FSAqUeiH3HwAgs1xwFmtRXp3EqnmdTOrVnjTw7PQLahs5QRfAaDEySyXyKulkiJOTZyC9XIeSetLrT7gG96YzOszMm0/mKqZGDpQBa8It8Mg42kPAjjlMNdYCNEKavrMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985994; c=relaxed/simple;
	bh=u91lamdMkF92PpI/055SiMTUxxxWT4COkRvJ+pY0Iy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQzLrQD3HIy0QcRmha92fabkvAsQimg157vK5hw+/QKbFNJYK1weL8j4jTnWwJVOajUZ6s4pYd8vQ5sX29zIAsDuQwBrL8HOOv4t2FyIdijXJQO4sb/Fft1kqlj8/dzflHEuWHeBgYhhRPv2CSLSTXNzC6o9lFDBa3aznpldVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fJzL4eUU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374b9761eecso760950f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985991; x=1726590791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiOqSLRv0cjYat8BpAAj37wTt3CDM1EXasAdqabdPNs=;
        b=fJzL4eUUv8ZlLDDGH1LbWf41tYgmEkRLRr5C+lLyJn0zmBfOcvNS5CJd4NrYJBAOFA
         u7lh2dFp/WC00kq4pF1XamyR+Up4lE5GANCEehGfUwapzGJABerqlBZKnz4D7+efgUl9
         curPpv3TqYzWTIQtf/EUX5comBtmqnPbRWK/2intpgBaX5aH528R7DRbWQSWSFdsioh7
         sy1ddtnjTyZ9FE5yklBtX2PSEljINzU9326huU8b7J+K8Gs7LSwbbb0uUkT8HbYlGNdD
         fvQ1hv/5Nn7zUwetjIbALxENk4dpjEyC4vLqwODkWFDK+coG20p/YCGqIl+bvxR+l4W0
         JBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985991; x=1726590791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiOqSLRv0cjYat8BpAAj37wTt3CDM1EXasAdqabdPNs=;
        b=Y1Qirxcgt3VkgxD8ZB4m9Hs3LeGGz0v4jQZfP9emAD/QvA766lFLxtiFLVvVwp82n5
         yMZpTU6JEudVNsDMlNnNVvJYiBpp17X8Oe0Y9YMLCJ0cby5IIzkapHpffHfJzZr3BznU
         iVE55KMuTD6aMjC9/LWIzC7MNDRwypW0ml99eGDEpZqSUXAnYAIhiArFq9qqHM3IMVtZ
         Jacy9W+Y0itGf7P4+espbtlnrlMsRuFhot5sla3zKMeM9IYZehyde2xQ2MxuAvNCi3nQ
         OMMyMLUhEmFM5ZQaXD6WTd2bSqDJ86onwls+PVS9Hyq9WhWSf/rkF0+nl/YC8gxBFoVo
         0jRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG7Pr3kM/4Yxqu8I64JZIpOdYpnKGK7aqqUwSnDTEomKCQNoeAmu3jsUJMOjGCbH51s4uWZXFqusS6jFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdnR6oi22Uv0QdjCcK6oHPPTSA2QU6BVpcf0KDHkI/a6jpO8Un
	Du8K1QxDUfik32OASeyKb82CuNdohCQGM0IrBZA3ifecz8tiOhxEuRdh2c6nNTU=
X-Google-Smtp-Source: AGHT+IHOckoxe0JL/4WHoUkDjjXjPPgihli3S39FifyWODZU6iQe3Mih7nuSpc8qwfgocD/VgC6ROQ==
X-Received: by 2002:adf:ebc2:0:b0:35f:d70:6193 with SMTP id ffacd0b85a97d-378b07f6d00mr146998f8f.41.1725985990749;
        Tue, 10 Sep 2024 09:33:10 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:51 +0200
Subject: [PATCH v5 9/9] reset: amlogic: add auxiliary reset driver support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-9-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9862; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=u91lamdMkF92PpI/055SiMTUxxxWT4COkRvJ+pY0Iy8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS8bsGgOqSjd2mE4O60vlFbI+/HjwbMGSlHQ
 cvQmOJV9PWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0vAAKCRDm/A8cN/La
 hYdTD/4/1Pyh39PS/VeHZaFq6kuvxZkaQClJIh4OoHc57mBcfMPcf1hvW/npV/SEGYpRO+QCC5l
 psmjjow8oukt/0Gqafw/O2y+UrV95v/vlrKW30ZVAPU0a9B/GH61kIqoIrhO1VHu565zkwcabB9
 y1evOI7g3E4E1YE+ERDmFI9Too0kpwmOzF0aBS6qAl2XGVrav7fR4opr+rm2/moGQaHjSPSbD3A
 0CkOnpY4fK7hiP/ZZxDuL7Xp3Wr+kCPqm2b06TXosU4gtKl4jLMJfixSWkznmomYZz6eOpGoqxC
 X9Dcmdu0XWMDpSvJvMRIZXgZFtq8rizcBEpE96Iz46E7uXlVmUBo69LVAi1rKvyBSZn4y1a0g6W
 Tdy22/QeED8i53mrQzT1d0Zb3qyJktlv07mCXY3QIp28FFUQFlH41F9s9AhP0wA2byIcbHzClg1
 3a7FqNHBLOmw7wY6moZJ99E9uWwRsio38Nmj8Ru4f0MIYhJ1bpFnGvOokbbLvMdpDKWorxyntBh
 JciWq29e4F8L+LFS6OgqwljAhdrC0SgmIcwR5GUrWU014c9WViGRrkfDeXUB+N1j8nOttn5TuWv
 kzd8no1SMgIDmqBYXB8rqJGrO3LLK0vqAI9ptaERtmSOrEAyWxdp8UDSd3uSOXRkNai3iSNncRx
 APxrbVtg4gqptlA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add support for the reset controller present in the audio clock
controller of the g12 and sm1 SoC families, using the auxiliary bus.

This is expected to replace the driver currently present directly
within the related clock driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/amlogic/Kconfig              |   8 ++
 drivers/reset/amlogic/Makefile             |   1 +
 drivers/reset/amlogic/reset-meson-aux.c    | 136 +++++++++++++++++++++++++++++
 drivers/reset/amlogic/reset-meson-common.c |  25 +++++-
 drivers/reset/amlogic/reset-meson.c        |   3 +
 drivers/reset/amlogic/reset-meson.h        |   4 +
 include/soc/amlogic/reset-meson-aux.h      |  23 +++++
 7 files changed, 198 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
index 1d77987088f4..3bee9fd60269 100644
--- a/drivers/reset/amlogic/Kconfig
+++ b/drivers/reset/amlogic/Kconfig
@@ -11,6 +11,14 @@ config RESET_MESON
 	help
 	  This enables the reset driver for Amlogic SoCs.
 
+config RESET_MESON_AUX
+	tristate "Meson Reset Auxiliary Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	select AUXILIARY_BUS
+	select RESET_MESON_COMMON
+	help
+	  This enables the reset auxiliary driver for Amlogic SoCs.
+
 config RESET_MESON_AUDIO_ARB
 	tristate "Meson Audio Memory Arbiter Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/Makefile
index 74aaa2fb5e13..ca99a691282c 100644
--- a/drivers/reset/amlogic/Makefile
+++ b/drivers/reset/amlogic/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_MESON_AUX) += reset-meson-aux.o
 obj-$(CONFIG_RESET_MESON_COMMON) += reset-meson-common.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
diff --git a/drivers/reset/amlogic/reset-meson-aux.c b/drivers/reset/amlogic/reset-meson-aux.c
new file mode 100644
index 000000000000..dd8453001db9
--- /dev/null
+++ b/drivers/reset/amlogic/reset-meson-aux.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Amlogic Meson Reset Auxiliary driver
+ *
+ * Copyright (c) 2024 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+#include "reset-meson.h"
+#include <soc/amlogic/reset-meson-aux.h>
+
+static DEFINE_IDA(meson_rst_aux_ida);
+
+struct meson_reset_adev {
+	struct auxiliary_device adev;
+	struct regmap *map;
+};
+
+#define to_meson_reset_adev(_adev) \
+	container_of((_adev), struct meson_reset_adev, adev)
+
+static const struct meson_reset_param meson_g12a_audio_param = {
+	.reset_ops	= &meson_reset_toggle_ops,
+	.reset_num	= 26,
+	.level_offset	= 0x24,
+};
+
+static const struct meson_reset_param meson_sm1_audio_param = {
+	.reset_ops	= &meson_reset_toggle_ops,
+	.reset_num	= 39,
+	.level_offset	= 0x28,
+};
+
+static const struct auxiliary_device_id meson_reset_aux_ids[] = {
+	{
+		.name = "axg-audio-clkc.rst-g12a",
+		.driver_data = (kernel_ulong_t)&meson_g12a_audio_param,
+	}, {
+		.name = "axg-audio-clkc.rst-sm1",
+		.driver_data = (kernel_ulong_t)&meson_sm1_audio_param,
+	}, {}
+};
+MODULE_DEVICE_TABLE(auxiliary, meson_reset_aux_ids);
+
+static int meson_reset_aux_probe(struct auxiliary_device *adev,
+				 const struct auxiliary_device_id *id)
+{
+	const struct meson_reset_param *param =
+		(const struct meson_reset_param *)(id->driver_data);
+	struct meson_reset_adev *raux =
+		to_meson_reset_adev(adev);
+
+	return meson_reset_controller_register(&adev->dev, raux->map, param);
+}
+
+static struct auxiliary_driver meson_reset_aux_driver = {
+	.probe		= meson_reset_aux_probe,
+	.id_table	= meson_reset_aux_ids,
+};
+module_auxiliary_driver(meson_reset_aux_driver);
+
+static void meson_rst_aux_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct meson_reset_adev *raux =
+		to_meson_reset_adev(adev);
+
+	ida_free(&meson_rst_aux_ida, adev->id);
+	kfree(raux);
+}
+
+static void meson_rst_aux_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+int devm_meson_rst_aux_register(struct device *dev,
+				struct regmap *map,
+				const char *adev_name)
+{
+	struct meson_reset_adev *raux;
+	struct auxiliary_device *adev;
+	int ret;
+
+	raux = kzalloc(sizeof(*raux), GFP_KERNEL);
+	if (!raux)
+		return -ENOMEM;
+
+	ret = ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);
+	if (ret < 0)
+		goto raux_free;
+
+	raux->map = map;
+
+	adev = &raux->adev;
+	adev->id = ret;
+	adev->name = adev_name;
+	adev->dev.parent = dev;
+	adev->dev.release = meson_rst_aux_release;
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
+	return devm_add_action_or_reset(dev, meson_rst_aux_unregister_adev,
+					adev);
+
+ida_free:
+	ida_free(&meson_rst_aux_ida, adev->id);
+raux_free:
+	kfree(raux);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_meson_rst_aux_register);
+
+MODULE_DESCRIPTION("Amlogic Meson Reset Auxiliary driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS(MESON_RESET);
diff --git a/drivers/reset/amlogic/reset-meson-common.c b/drivers/reset/amlogic/reset-meson-common.c
index d57544801ae9..a7b1b250a64d 100644
--- a/drivers/reset/amlogic/reset-meson-common.c
+++ b/drivers/reset/amlogic/reset-meson-common.c
@@ -87,12 +87,33 @@ static int meson_reset_deassert(struct reset_controller_dev *rcdev,
 	return meson_reset_level(rcdev, id, false);
 }
 
-static const struct reset_control_ops meson_reset_ops = {
+static int meson_reset_level_toggle(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	int ret;
+
+	ret = meson_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return meson_reset_deassert(rcdev, id);
+}
+
+const struct reset_control_ops meson_reset_ops = {
 	.reset		= meson_reset_reset,
 	.assert		= meson_reset_assert,
 	.deassert	= meson_reset_deassert,
 	.status		= meson_reset_status,
 };
+EXPORT_SYMBOL_NS_GPL(meson_reset_ops, MESON_RESET);
+
+const struct reset_control_ops meson_reset_toggle_ops = {
+	.reset		= meson_reset_level_toggle,
+	.assert		= meson_reset_assert,
+	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
+};
+EXPORT_SYMBOL_NS_GPL(meson_reset_toggle_ops, MESON_RESET);
 
 int meson_reset_controller_register(struct device *dev, struct regmap *map,
 				    const struct meson_reset_param *param)
@@ -107,7 +128,7 @@ int meson_reset_controller_register(struct device *dev, struct regmap *map,
 	data->map = map;
 	data->rcdev.owner = dev->driver->owner;
 	data->rcdev.nr_resets = param->reset_num;
-	data->rcdev.ops = &meson_reset_ops;
+	data->rcdev.ops = data->param->reset_ops;
 	data->rcdev.of_node = dev->of_node;
 
 	return devm_reset_controller_register(dev, &data->rcdev);
diff --git a/drivers/reset/amlogic/reset-meson.c b/drivers/reset/amlogic/reset-meson.c
index feb19bf6da77..6ae4ed6b7f8b 100644
--- a/drivers/reset/amlogic/reset-meson.c
+++ b/drivers/reset/amlogic/reset-meson.c
@@ -18,6 +18,7 @@
 #include "reset-meson.h"
 
 static const struct meson_reset_param meson8b_param = {
+	.reset_ops	= &meson_reset_ops,
 	.reset_num	= 256,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
@@ -25,6 +26,7 @@ static const struct meson_reset_param meson8b_param = {
 };
 
 static const struct meson_reset_param meson_a1_param = {
+	.reset_ops	= &meson_reset_ops,
 	.reset_num	= 96,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
@@ -32,6 +34,7 @@ static const struct meson_reset_param meson_a1_param = {
 };
 
 static const struct meson_reset_param meson_s4_param = {
+	.reset_ops	= &meson_reset_ops,
 	.reset_num	= 192,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
diff --git a/drivers/reset/amlogic/reset-meson.h b/drivers/reset/amlogic/reset-meson.h
index 4e1dbd7569c5..2051e126dc3a 100644
--- a/drivers/reset/amlogic/reset-meson.h
+++ b/drivers/reset/amlogic/reset-meson.h
@@ -12,6 +12,7 @@
 #include <linux/reset-controller.h>
 
 struct meson_reset_param {
+	const struct reset_control_ops *reset_ops;
 	unsigned int reset_num;
 	unsigned int reset_offset;
 	unsigned int level_offset;
@@ -21,4 +22,7 @@ struct meson_reset_param {
 int meson_reset_controller_register(struct device *dev, struct regmap *map,
 				    const struct meson_reset_param *param);
 
+extern const struct reset_control_ops meson_reset_ops;
+extern const struct reset_control_ops meson_reset_toggle_ops;
+
 #endif /* __MESON_RESET_H */
diff --git a/include/soc/amlogic/reset-meson-aux.h b/include/soc/amlogic/reset-meson-aux.h
new file mode 100644
index 000000000000..d8a15d48c984
--- /dev/null
+++ b/include/soc/amlogic/reset-meson-aux.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_RESET_MESON_AUX_H
+#define __SOC_RESET_MESON_AUX_H
+
+#include <linux/err.h>
+
+struct device;
+struct regmap;
+
+#if IS_ENABLED(CONFIG_RESET_MESON_AUX)
+int devm_meson_rst_aux_register(struct device *dev,
+				struct regmap *map,
+				const char *adev_name);
+#else
+static inline int devm_meson_rst_aux_register(struct device *dev,
+					      struct regmap *map,
+					      const char *adev_name)
+{
+	return 0;
+}
+#endif
+
+#endif /* __SOC_RESET_MESON_AUX_H */

-- 
2.45.2


