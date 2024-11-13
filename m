Return-Path: <linux-kernel+bounces-408235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 925AC9C7C70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1980FB28628
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E2D206055;
	Wed, 13 Nov 2024 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoinyVRo"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAF205AC8;
	Wed, 13 Nov 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527610; cv=none; b=k1R+9hGFIho8PNnd0btbPTeJJig2/XnM2JOa8ou0hQtpnJ6pj0CD+r7XaaV9OvpFP9Ja28ZRSoMZcVZ+5UbDGWZQezW9JSTNZnKl2MlI3pdpGNB0YEvRyQ94e/dzLTBAhh/bwbiefkXvR+lIvnfGgwGynVU0VYWBgoJbRLdaQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527610; c=relaxed/simple;
	bh=yJXP5G6+KX6wZSm00Do5/7Oji6ODwGE6FTJrlHHDOfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqgm784qGFg4yT7fOjRYqMy5Rr8eF69TJDzm+dcbwV++tholp/wgHVG4C9qvOoJqU4ZaKxdh1QEnLnNMQ/3a8ja7B9eZVB4Bf331c5lYwnafe6rF7c4snEvIOiLc8OwTtNuLkIKKkFkgdrHl8U6ag+49Od96BXRYXsa9EdfMHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoinyVRo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so59667595e9.2;
        Wed, 13 Nov 2024 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731527606; x=1732132406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ8qCqZxQls27G5FvgYB3jPJTXzsMgq7re3gkn2j14I=;
        b=NoinyVRojt2twaByWRhyfdUCisR+Rzg8yMjPoev8Z5hk436PEkQCXtyHyBezdUhpol
         a/Fm75F+/YT+/TLqC24hZuYXGpbmQgImBnTb6wZFyHeYXclkehmu0qUQQe3LEVsANSBF
         H+kTOkXQozk6tfm3IxavN3a2cU9g/4ZtPsZ6zZRklbWuD58/uxqScjVey9t2axVO+GO8
         DKhrhsH92vOO5bSqr7X7+akAP6AlDEDt2ZF4j2T2o9FNdGk/Hs2v6LI1FLgdeU9tFI11
         fanI8h2znFeSi9SsfLwkfwBklIgbl9ltl5N3mWwLdnb6IQNA3SGULFHTcJX+iL+5aARf
         UpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527606; x=1732132406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ8qCqZxQls27G5FvgYB3jPJTXzsMgq7re3gkn2j14I=;
        b=Vr+5JtOEuIoaMgjDrFAp8ZdsKKwB4BMhHH//4hKMfqP3P+WXiJrFMf0whIzXaHa2WA
         NBeMsxUvZcMlaSPfRJm14cNNOXd0XBUVeohZKqOuYgXQFJQqsB7X655D4halx0dMBrLY
         lAuNQK2o+hEwZlQxi1Y0BZ3xXksJzHiPdSCjJf1PrIMEMEFx0wRA2qYJoNMWltvt0/a8
         N53LfXtV54okIrCJZrDolNMOCRgmFqW14tg+egeeit3QyZfyRxAfIbmg4B8iV3RbaKNY
         W5o3GmWcaa7i8DnwLJDTZmulN+wNPGwFj2mMHD0lCGNH2HJUyaNDDHTbuobedxHr4awh
         9U+A==
X-Forwarded-Encrypted: i=1; AJvYcCU55jbG+vKYNMuehjuFOwE7/uKSYw28arJVa/QWOf5dLyINWMaPgtbHRaijLJuKVk1mcIiM+Vr8hh/2CfcM@vger.kernel.org, AJvYcCUoQkoAVkFe0+w+lL0dd8gush8VHFcy31q/QsSHKxTlGtiwKL1XRCiHlek1NIL0n+08wU6PPodlDe4H@vger.kernel.org, AJvYcCVYqeetu+DQgP2bF+voEfm0mueS/ltoQDGLhQI6Msy1l6ZuTZ52zXsTFwJG8K4XnAwLejawyd6FhoTo7iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKCegAKzfABqezMVGssnrz4Pwt18Kdl1C69UoGrDkg+9a6NPz
	fbT9UiHtQKtZTWf5PEVnc91w9E5e7DRoctq2dypT6n3HhQojiJF8
X-Google-Smtp-Source: AGHT+IHDkGjE+BG151uOOvSO50zgIgNCO9RH+HMl6uHiRX3lePeeddimjRMMAgBVVCFvsXxrNxhlpA==
X-Received: by 2002:a05:6000:400e:b0:378:e8a9:98c5 with SMTP id ffacd0b85a97d-3820812efafmr6915270f8f.34.1731527606274;
        Wed, 13 Nov 2024 11:53:26 -0800 (PST)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503c58sm34633065e9.22.2024.11.13.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:53:25 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] ASoC: SOF: imx: add driver for imx95
Date: Wed, 13 Nov 2024 14:52:39 -0500
Message-Id: <20241113195240.3699-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add SOF driver for imx95.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 sound/soc/sof/imx/Kconfig  |   8 +
 sound/soc/sof/imx/Makefile |   2 +
 sound/soc/sof/imx/imx95.c  | 401 +++++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+)
 create mode 100644 sound/soc/sof/imx/imx95.c

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index 4751b04d5e6f..51a70a193533 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -50,4 +50,12 @@ config SND_SOC_SOF_IMX8ULP
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
+config SND_SOC_SOF_IMX95
+	tristate "SOF support for i.MX95"
+	depends on IMX_DSP
+	help
+	  This adds support for Sound Open Firmware for NXP i.MX95 platforms.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
 endif ## SND_SOC_SOF_IMX_TOPLEVEL
diff --git a/sound/soc/sof/imx/Makefile b/sound/soc/sof/imx/Makefile
index be0bf0736dfa..715ac3798668 100644
--- a/sound/soc/sof/imx/Makefile
+++ b/sound/soc/sof/imx/Makefile
@@ -2,10 +2,12 @@
 snd-sof-imx8-y := imx8.o
 snd-sof-imx8m-y := imx8m.o
 snd-sof-imx8ulp-y := imx8ulp.o
+snd-sof-imx95-y := imx95.o
 
 snd-sof-imx-common-y := imx-common.o
 
 obj-$(CONFIG_SND_SOC_SOF_IMX8) += snd-sof-imx8.o
 obj-$(CONFIG_SND_SOC_SOF_IMX8M) += snd-sof-imx8m.o
 obj-$(CONFIG_SND_SOC_SOF_IMX8ULP) += snd-sof-imx8ulp.o
+obj-$(CONFIG_SND_SOC_SOF_IMX95) += snd-sof-imx95.o
 obj-$(CONFIG_SND_SOC_SOF_IMX_COMMON) += imx-common.o
diff --git a/sound/soc/sof/imx/imx95.c b/sound/soc/sof/imx/imx95.c
new file mode 100644
index 000000000000..5a0e44f5bd48
--- /dev/null
+++ b/sound/soc/sof/imx/imx95.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/firmware/imx/dsp.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <sound/sof.h>
+
+#include "../sof-of-dev.h"
+#include "../ops.h"
+
+#define IMX_SIP_SRC 0xC2000005
+#define IMX_SIP_SRC_M_RESET_ADDR_SET 0x03
+
+#define IMX95_CPU_VEC_FLAGS_BOOT BIT(29)
+
+#define IMX_SIP_LMM 0xC200000F
+#define IMX_SIP_LMM_BOOT 0x0
+#define IMX_SIP_LMM_SHUTDOWN 0x1
+
+#define IMX95_M7_LM_ID 0x1
+
+#define MBOX_DSPBOX_OFFSET 0x1000
+#define MBOX_WINDOW_OFFSET 0x6000000
+
+struct imx95_priv {
+	struct platform_device *ipc_dev;
+	struct imx_dsp_ipc *ipc_handle;
+	resource_size_t bootaddr;
+};
+
+static void imx95_ipc_handle_reply(struct imx_dsp_ipc *ipc)
+{
+	unsigned long flags;
+	struct snd_sof_dev *sdev = imx_dsp_get_data(ipc);
+
+	spin_lock_irqsave(&sdev->ipc_lock, flags);
+	snd_sof_ipc_process_reply(sdev, 0);
+	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
+}
+
+static void imx95_ipc_handle_request(struct imx_dsp_ipc *ipc)
+{
+	snd_sof_ipc_msgs_rx(imx_dsp_get_data(ipc));
+}
+
+static struct imx_dsp_ops ipc_ops = {
+	.handle_reply = imx95_ipc_handle_reply,
+	.handle_request = imx95_ipc_handle_request,
+};
+
+static int imx95_disable_enable_core(bool enable)
+{
+	struct arm_smccc_res res;
+
+	if (enable)
+		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_BOOT, IMX95_M7_LM_ID,
+			      0, 0, 0, 0, 0, &res);
+	else
+		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_SHUTDOWN, IMX95_M7_LM_ID,
+			      0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int imx95_run(struct snd_sof_dev *sdev)
+{
+	return imx95_disable_enable_core(true);
+}
+
+static int imx95_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
+{
+	struct imx95_priv *priv = sdev->pdata->hw_pdata;
+
+	sof_mailbox_write(sdev, sdev->host_box.offset,
+			  msg->msg_data, msg->msg_size);
+
+	imx_dsp_ring_doorbell(priv->ipc_handle, 0);
+
+	return 0;
+}
+
+static int imx95_get_mailbox_offset(struct snd_sof_dev *sdev)
+{
+	return MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
+}
+
+static int imx95_get_bar_index(struct snd_sof_dev *sdev, u32 type)
+{
+	switch (type) {
+	case SOF_FW_BLK_TYPE_SRAM:
+		return type;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx95_get_window_offset(struct snd_sof_dev *sdev, u32 id)
+{
+	return MBOX_WINDOW_OFFSET;
+}
+
+static int imx95_set_power_state(struct snd_sof_dev *sdev,
+				 const struct sof_dsp_power_state *target_state)
+{
+	sdev->dsp_power_state = *target_state;
+
+	return 0;
+}
+
+static int imx95_suspend_resume(struct snd_sof_dev *sdev, bool suspend)
+{
+	struct imx95_priv *priv;
+	int ret, i;
+
+	priv = sdev->pdata->hw_pdata;
+
+	if (suspend) {
+		ret = imx95_disable_enable_core(false);
+		if (ret) {
+			dev_err(sdev->dev, "failed to stop core\n");
+			return ret;
+		}
+	}
+
+	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
+		if (suspend)
+			imx_dsp_free_channel(priv->ipc_handle, i);
+		else
+			imx_dsp_request_channel(priv->ipc_handle, i);
+	}
+
+	return 0;
+}
+
+static int imx95_runtime_resume(struct snd_sof_dev *sdev)
+{
+	int ret;
+	const struct sof_dsp_power_state target_state = {
+		.state = SOF_DSP_PM_D0,
+	};
+
+	ret = imx95_suspend_resume(sdev, false);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to runtime resume: %d\n", ret);
+		return ret;
+	}
+
+	return snd_sof_dsp_set_power_state(sdev, &target_state);
+}
+
+static int imx95_resume(struct snd_sof_dev *sdev)
+{
+	int ret;
+	const struct sof_dsp_power_state target_state = {
+		.state = SOF_DSP_PM_D0,
+	};
+
+	ret = imx95_suspend_resume(sdev, false);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to resume: %d\n", ret);
+		return ret;
+	}
+
+	if (pm_runtime_suspended(sdev->dev)) {
+		pm_runtime_disable(sdev->dev);
+		pm_runtime_set_active(sdev->dev);
+		pm_runtime_mark_last_busy(sdev->dev);
+		pm_runtime_enable(sdev->dev);
+		pm_runtime_idle(sdev->dev);
+	}
+
+	return snd_sof_dsp_set_power_state(sdev, &target_state);
+}
+
+static int imx95_runtime_suspend(struct snd_sof_dev *sdev)
+{
+	int ret;
+	const struct sof_dsp_power_state target_state = {
+		.state = SOF_DSP_PM_D3,
+	};
+
+	ret = imx95_suspend_resume(sdev, true);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to runtime suspend: %d\n", ret);
+		return ret;
+	}
+
+	return snd_sof_dsp_set_power_state(sdev, &target_state);
+}
+
+static int imx95_suspend(struct snd_sof_dev *sdev, unsigned int target_state)
+{
+	int ret;
+	const struct sof_dsp_power_state target_power_state = {
+		.state = target_state,
+	};
+
+	if (!pm_runtime_suspended(sdev->dev)) {
+		ret = imx95_suspend_resume(sdev, true);
+		if (ret < 0) {
+			dev_err(sdev->dev, "failed to suspend: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return snd_sof_dsp_set_power_state(sdev, &target_power_state);
+}
+
+static struct snd_soc_dai_driver imx95_dai[] = {
+	{
+		.name = "sai3",
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 32,
+		},
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 32,
+		},
+	},
+};
+
+static int imx95_probe(struct snd_sof_dev *sdev)
+{
+	struct platform_device *pdev;
+	struct imx95_priv *priv;
+	struct resource *res;
+	struct arm_smccc_res smc_ret;
+	int ret;
+
+	pdev = container_of(sdev->dev, struct platform_device, dev);
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "failed to alloc priv\n");
+
+	sdev->pdata->hw_pdata = priv;
+
+	/* map SRAM */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to fetch SRAM region\n");
+
+	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(&pdev->dev, res->start,
+						       resource_size(res));
+	if (IS_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]),
+				     "failed to map SRAM region\n");
+
+	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
+	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
+	sdev->dsp_box.offset = MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
+	priv->bootaddr = res->start;
+
+	ret = of_reserved_mem_device_init(sdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to bind DMA region\n");
+
+	priv->ipc_dev = platform_device_register_data(&pdev->dev, "imx-dsp",
+						      PLATFORM_DEVID_NONE,
+						      pdev, sizeof(*pdev));
+	if (IS_ERR(priv->ipc_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->ipc_dev),
+				     "failed to create IPC device\n");
+
+	priv->ipc_handle = dev_get_drvdata(&priv->ipc_dev->dev);
+	if (!priv->ipc_handle) {
+		ret = -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to fetch ipc handle\n");
+		goto err_unregister_ipc_dev;
+	}
+
+	priv->ipc_handle->ops = &ipc_ops;
+	imx_dsp_set_data(priv->ipc_handle, sdev);
+
+	/* set core boot reset address */
+	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_M_RESET_ADDR_SET, priv->bootaddr,
+		      IMX95_CPU_VEC_FLAGS_BOOT, 0, 0, 0, 0, &smc_ret);
+	if ((int)smc_ret.a0 < 0) {
+		ret = smc_ret.a0;
+		dev_err(&pdev->dev, "failed to set boot address: %d", ret);
+		goto err_unregister_ipc_dev;
+	}
+
+	return 0;
+
+err_unregister_ipc_dev:
+	platform_device_unregister(priv->ipc_dev);
+
+	return ret;
+}
+
+static void imx95_remove(struct snd_sof_dev *sdev)
+{
+	struct imx95_priv *priv;
+
+	priv = sdev->pdata->hw_pdata;
+
+	if (imx95_disable_enable_core(false))
+		dev_err(sdev->dev, "failed to stop core\n");
+
+	platform_device_unregister(priv->ipc_dev);
+}
+
+static const struct snd_sof_dsp_ops sof_imx95_ops = {
+	.probe = imx95_probe,
+	.remove = imx95_remove,
+
+	/* mandatory "DSP" ops */
+	.run = imx95_run,
+	.block_read = sof_block_read,
+	.block_write = sof_block_write,
+	.send_msg = imx95_send_msg,
+	.load_firmware = snd_sof_load_firmware_memcpy,
+	.ipc_msg_data = sof_ipc_msg_data,
+
+	.mailbox_read = sof_mailbox_read,
+	.mailbox_write = sof_mailbox_write,
+
+	.get_mailbox_offset = imx95_get_mailbox_offset,
+	.get_bar_index = imx95_get_bar_index,
+	.get_window_offset = imx95_get_window_offset,
+
+	.pcm_open = sof_stream_pcm_open,
+	.pcm_close = sof_stream_pcm_close,
+	.set_stream_data_offset = sof_set_stream_data_offset,
+
+	.runtime_suspend = imx95_runtime_suspend,
+	.runtime_resume = imx95_runtime_resume,
+
+	.resume = imx95_resume,
+	.suspend = imx95_suspend,
+
+	.set_power_state = imx95_set_power_state,
+
+	.drv = imx95_dai,
+	.num_drv = ARRAY_SIZE(imx95_dai),
+
+	.hw_info = SNDRV_PCM_INFO_MMAP |
+		   SNDRV_PCM_INFO_MMAP_VALID |
+		   SNDRV_PCM_INFO_INTERLEAVED |
+		   SNDRV_PCM_INFO_PAUSE |
+		   SNDRV_PCM_INFO_BATCH |
+		   SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+};
+
+static struct snd_sof_of_mach sof_imx95_machs[] = {
+	{
+		.compatible = "fsl,imx95-19x19-evk",
+		.sof_tplg_filename = "sof-imx95-wm8962.tplg",
+		.drv_name = "asoc-audio-graph-card2",
+	},
+	{
+	},
+};
+
+static struct sof_dev_desc sof_of_imx95_desc = {
+	.of_machines = sof_imx95_machs,
+	.ipc_supported_mask = BIT(SOF_IPC_TYPE_3),
+	.ipc_default = SOF_IPC_TYPE_3,
+	.default_fw_path = {
+		[SOF_IPC_TYPE_3] = "imx/sof",
+	},
+	.default_tplg_path = {
+		[SOF_IPC_TYPE_3] = "imx/sof-tplg",
+	},
+	.default_fw_filename = {
+		[SOF_IPC_TYPE_3] = "sof-imx95.ri",
+	},
+	.ops = &sof_imx95_ops,
+};
+
+static const struct of_device_id sof_of_imx95_ids[] = {
+	{ .compatible = "fsl,imx95-cm7-sof", .data = &sof_of_imx95_desc },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sof_of_imx95_ids);
+
+static struct platform_driver snd_sof_of_imx95_driver = {
+	.probe = sof_of_probe,
+	.remove = sof_of_remove,
+	.driver = {
+		.name = "sof-audio-of-imx95",
+		.pm = &sof_of_pm,
+		.of_match_table = sof_of_imx95_ids,
+	},
+};
+module_platform_driver(snd_sof_of_imx95_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("SOF support for i.MX95 platforms");
+MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
-- 
2.34.1


