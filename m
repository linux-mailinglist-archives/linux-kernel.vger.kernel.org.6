Return-Path: <linux-kernel+bounces-437408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF69E92DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE30283DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0C221D83;
	Mon,  9 Dec 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNcY2QWq"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC742206A5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745180; cv=none; b=qyoQ7yXJ190C3jCOUnBK/smbGm++OnLZUsSGgbvjKdkO/WfYzXVNoQDy8S0S2QsECnkuU0G6E+eM+J3p4uySg/Aukgmmw0HSpE7ziiJXryJ0DTHvuzMZ7b7ySNwtxGCHiHKEmG3Zrdo24l1qf+KPbowkpDMhbrAgSFyxh4YvtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745180; c=relaxed/simple;
	bh=MUj9GEOsI8x/GUI7Cn3GA34WkthggJJh0pVciz+tOzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsUJIPrYWTVdqNdJnbVGMUz4w9eN/aFcw2S7sSs7yxTTS5tkIZLTmb+2ylpFucrKniPhQMOwzRES1jqrA9RhVHYZhI5Gfy1itax64cdAZeKlWUkN9V+b4Oi62xovVmAB0qtD8/+RhIW1fcTNvw5GHkpEkPJhFbw8GxZvLySMPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qNcY2QWq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso807372666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745177; x=1734349977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmy83kro+8flL7LgVM3y5DWoO7YZdsYDOqXSagXiZjQ=;
        b=qNcY2QWqFK31ocHgugSLzwjUPZ31IhPkrVhWdtGH6zsGGITak0wwXv+EJWEUcZYT4g
         zPmb/7+TVYxK6jCqd5bh7LY1MnlC0gfa6HGYIW3on/+nos2/5TDWtAjLF6hqCsq88wXh
         h81chr29XBzOv2Ngth8j4HIcrT7NG8Dh6C1UIiVJgLiVzN0VzseLYmzst8Ampmw94wui
         +LNBajs8K/9JF6mgImIj8KgDZqla62llTEDWwrjTR2+f5Nlo/kQ9GP7sMzckjkUpBMm8
         GhkNrPpDDYKmDiYggskLTLjuOdkIAzUSQHKihFopyXkdMB2+Yuw3TTnKlbcJxLM+a8AR
         ZA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745177; x=1734349977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmy83kro+8flL7LgVM3y5DWoO7YZdsYDOqXSagXiZjQ=;
        b=gh/WT+lhVsy+ldfHB5g4NtxbXGr7eMoH3NEpwwW6lFIbBu1tEZs+AMPh+5K7E54SiJ
         5Hkyt70yOAuyPE1fXHsRhUXsuCKgOrpuWaa/9fOa0JeDPbxekxY0iAWSp0FOrRwSCdP3
         FnNxIKca+syhIo/w7NceqMjJL+2LaIJxeVAd472f1+EnAuyjdHA8exBmfZCc5Ghj8keY
         2WQ8pZoWld1ZNcsaNd9b0UERivO76kaT+yn2NgxvyJipx40ypS538kyo+k4at1yUFJVl
         0vejdaS0+zSIlRu4IZwbn1ozLB+aQ+kmWjkyCPCKH9lgH0HhkvTvqtQjuzVxjusyxveI
         Svrw==
X-Forwarded-Encrypted: i=1; AJvYcCXCIQ+5LaeHo4oe5NOZ70jBzuIvfi+DqsHJ8Espfmnd6BEJyYgFED6OgAbXoUluh5L5pD3M+hqaxo8LV1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWsLQpPXhpzZAOeeLkP/kD3pu1cE4adnX7FdQdHqCHJ+qnidH
	bxy1GsM2ijqGbqueBH3ZgTAf7lHV+wblWxF+ZsmFinUm0HBGoUSUsCBpiOpqoik=
X-Gm-Gg: ASbGnctlhJ6XLg0FA+l1BEufgULUBAGv6edgcgE5xCkj4oOORCgqIoTavRYSYBtusrf
	XqVxsy8gX8TN2og16tMOHuooO8NeAa29+V0gdQ22c8xm1V1OQ5V8XeIipP9aveP2ya7WQLIjfnO
	6adbcPm8FaIJc6YaNXFV6j7Q7janixtGKUq4+aWVp9Fw3lQa5h9KyXNyWRMHVU0/DqgcnMu59uq
	b45BmC1dUow7lwmVivYRc6bnyPU6yNFvPFsHeXvPHwpzDL5igFMgvbCKSM=
X-Google-Smtp-Source: AGHT+IGiWbOTy8zye1QYnkmHeO+nIc+nRXYGew0YVSqcwnSc2t4cADrXq8qKclvHTVj6CC4TOLtF7w==
X-Received: by 2002:a17:906:9555:b0:aa6:8275:2239 with SMTP id a640c23a62f3a-aa69ce44c4fmr966766b.57.1733745176691;
        Mon, 09 Dec 2024 03:52:56 -0800 (PST)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa677968cdbsm247614266b.125.2024.12.09.03.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:52:56 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 09 Dec 2024 11:52:53 +0000
Subject: [PATCH v5 1/3] media: venus: Add support for static video
 encoder/decoder declarations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-1-ef7e5f85f302@linaro.org>
References: <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-0-ef7e5f85f302@linaro.org>
In-Reply-To: <20241209-media-staging-24-11-25-rb3-hw-compat-string-v5-0-ef7e5f85f302@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com, 
 quic_dikshita@quicinc.com, konradybcio@kernel.org, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

Add resource structure data and probe() logic to support static
declarations of encoder and decoder.

Right now we rely on video encoder/decoder selection happening in the dtb
but, this goes against the remit of device tree which is supposed to
describe hardware, not select functional logic in Linux drivers.

Provide two strings in the venus resource structure enc_nodename and
dec_nodename.

When set the venus driver will create an OF entry in-memory consistent
with:

dec_nodename {
    compat = "video-decoder";
};

and/or

enc_nodename {
    compat = "video-encoder";
};

This will allow us to reuse the existing driver scheme of relying on compat
names maintaining compatibility with old dtb files.

dec_nodename can be "video-decoder" or "video0"
enc_nodename can be "video-encoder" or "video1"

This change relies on of_changeset() API as a result select OF_DYNAMIC will
be added to venus/Kconfig

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/Kconfig |  1 +
 drivers/media/platform/qcom/venus/core.c  | 94 ++++++++++++++++++++++++++++++-
 drivers/media/platform/qcom/venus/core.h  |  4 ++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
index bfd50e8f34219db8a1de7960d7ea93b20db2982a..bc2e410b29cb415a36540a4f98709eae44f4ec35 100644
--- a/drivers/media/platform/qcom/venus/Kconfig
+++ b/drivers/media/platform/qcom/venus/Kconfig
@@ -3,6 +3,7 @@ config VIDEO_QCOM_VENUS
 	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && QCOM_SMEM
 	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
+	select OF_DYNAMIC if ARCH_QCOM
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select QCOM_SCM
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 4e26b18790537885a77d66c1917a4e7a146eaf57..88dfa9f240dc6d18a7f58dc06b1bf10274b7121e 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -286,6 +286,89 @@ static irqreturn_t venus_isr_thread(int irq, void *dev_id)
 	return ret;
 }
 
+#if defined(CONFIG_OF_DYNAMIC)
+static int venus_add_video_core(struct venus_core *core, const char *node_name,
+				const char *compat)
+{
+	struct of_changeset *ocs = core->ocs;
+	struct device *dev = core->dev;
+	struct device_node *np, *enp;
+	int ret;
+
+	if (!node_name)
+		return 0;
+
+	enp = of_find_node_by_name(dev->of_node, node_name);
+	if (enp) {
+		of_node_put(enp);
+		return 0;
+	}
+
+	np = of_changeset_create_node(ocs, dev->of_node, node_name);
+	if (!np) {
+		dev_err(dev, "Unable to create new node\n");
+		return -ENODEV;
+	}
+
+	ret = of_changeset_add_prop_string(ocs, np, "compatible", compat);
+	if (ret)
+		dev_err(dev, "unable to add %s\n", compat);
+
+	of_node_put(np);
+
+	return ret;
+}
+
+static int venus_add_dynamic_nodes(struct venus_core *core)
+{
+	struct device *dev = core->dev;
+	int ret;
+
+	core->ocs = kmalloc(sizeof(*core->ocs), GFP_KERNEL);
+	if (!core->ocs)
+		return -ENOMEM;
+
+	of_changeset_init(core->ocs);
+
+	ret = venus_add_video_core(core, core->res->dec_nodename, "venus-decoder");
+	if (ret)
+		goto err;
+
+	ret = venus_add_video_core(core, core->res->enc_nodename, "venus-encoder");
+	if (ret)
+		goto err;
+
+	ret = of_changeset_apply(core->ocs);
+	if (ret) {
+		dev_err(dev, "applying changeset fail ret %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	of_changeset_destroy(core->ocs);
+	kfree(core->ocs);
+	core->ocs = NULL;
+	return ret;
+}
+
+static void venus_remove_dynamic_nodes(struct venus_core *core)
+{
+	if (core->ocs) {
+		of_changeset_revert(core->ocs);
+		of_changeset_destroy(core->ocs);
+		kfree(core->ocs);
+	}
+}
+#else
+static int venus_add_dynamic_nodes(struct venus_core *core)
+{
+	return 0;
+}
+
+static void venus_remove_dynamic_nodes(struct venus_core *core) {}
+#endif
+
 static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -365,9 +448,14 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_runtime_disable;
 
+	if (core->res->dec_nodename || core->res->enc_nodename) {
+		if (venus_add_dynamic_nodes(core))
+			goto err_runtime_disable;
+	}
+
 	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
 	if (ret)
-		goto err_runtime_disable;
+		goto err_remove_dynamic_nodes;
 
 	ret = venus_firmware_init(core);
 	if (ret)
@@ -411,6 +499,8 @@ static int venus_probe(struct platform_device *pdev)
 	venus_firmware_deinit(core);
 err_of_depopulate:
 	of_platform_depopulate(dev);
+err_remove_dynamic_nodes:
+	venus_remove_dynamic_nodes(core);
 err_runtime_disable:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
@@ -443,6 +533,8 @@ static void venus_remove(struct platform_device *pdev)
 
 	venus_firmware_deinit(core);
 
+	venus_remove_dynamic_nodes(core);
+
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 27784fd7082c321222b23ca4b2902a04c49e19ca..306231b4f7d0201175974b4a42574f30d23e08f0 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -90,6 +90,8 @@ struct venus_resources {
 	u32 cp_nonpixel_start;
 	u32 cp_nonpixel_size;
 	const char *fwname;
+	const char *enc_nodename;
+	const char *dec_nodename;
 };
 
 enum venus_fmt {
@@ -171,6 +173,7 @@ struct venus_format {
  * @root:	debugfs root directory
  * @venus_ver:	the venus firmware version
  * @dump_core:	a flag indicating that a core dump is required
+ * @ocs:	OF changeset pointer
  */
 struct venus_core {
 	void __iomem *base;
@@ -235,6 +238,7 @@ struct venus_core {
 		u32 rev;
 	} venus_ver;
 	unsigned long dump_core;
+	struct of_changeset *ocs;
 };
 
 struct vdec_controls {

-- 
2.47.1


