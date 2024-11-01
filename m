Return-Path: <linux-kernel+bounces-391534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E49B8856
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5C2829A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169012F59C;
	Fri,  1 Nov 2024 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZXFQY+n"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DA52F88
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424180; cv=none; b=RmopJYDDJ9RFnr9gqHhhMCk/04m4jaAJBuXyVbPvPajWjrzuP1kqxDHFR8c803/nxKVMq5MaQQSucQM3u4wbpMGA7nfMnghTXK8FWugU5Zh61JmXPLJcAC3H5V7lMgY1Tzr1EZOIejryd+P9VxjRVKyepqVmPFwQAPTaA97nA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424180; c=relaxed/simple;
	bh=elGVOqEqBXSN04+uVRWcq0gO8Yb65PX1oVNXx6Cxivo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pujibf8117sf6hApwOUP67PNm9c31QJdmwKefrKLQ4Ml/X6rXHzy6Xr7s4oc5GA6oQXnpR5VPgByUOc7kintE9Upp3U649j1okJdVNqqlVDqAz3C75ijab8aL+U+8o8hhsqF3wYoqF6+SLf/th6YolrPZAMUj9NAiM6nsB0H4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZXFQY+n; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4fd00574so984300f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730424173; x=1731028973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWMomMxtacvJ4sOZNR5yx4C6TBNkoG2Q0q3PqLoenP4=;
        b=PZXFQY+nBDeQVFuroHUArKR+Yne8JKZsQxlZQpAyYTDJDD++w/N+rFYPVtiwia8z4Y
         r+cT2oo4hoG0otY2IxyUkmq0AQZug/FSlNcrp6yhBjZ0ipOxwMG776w8B41Jafae2mLu
         Ht1ySGBZ4WJHshnVHGapHuSAFqAGfiY/gqg7c4n4raRw76lcNKasSDyrBl2nnrXELT3Q
         3/7pDaGcXDnvlTOlRwXtpUFFdLtFuxZq//PztKgo7BMpbx95DHq9L9ON3C7uNbYzU6dS
         KfYSsnAVrdBlNv3jT4BBOH10Vbl/oryg8etZthbMKWyjQiphkBYuCl80LoJIABXJkONG
         S/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730424173; x=1731028973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWMomMxtacvJ4sOZNR5yx4C6TBNkoG2Q0q3PqLoenP4=;
        b=PEYLOoHM8SM1orfCiCbGfmVEIuxv07WKGo1Yf+pl50w++F/lO0J1lj8afC09NuCSBY
         dwPbzQRd0heQYrxN12/avncdzA8+F1C83vDQJIi4zBwSDt+DZ9mdwWfwFDp0xQimFdcS
         doO5aDUX+Wxmwi6Pt5iROPhmteXLG2hH6fi0AwkLdAphrjLpFi8c7FS3zV6T4bqvdot7
         gQSoMcj9AkW02cbxOB7xHgZ2T5TtbWVIP2goWl1ooTAozHECfV5zkOTEc3WtwhZHfGlK
         JsX+iu9Kuliz5UmzTUfusFHk/0SkydF6ezlWHa3lD2afWp4cSqAe+iP1K7RsnbrR1nTI
         nEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg1cXzCp83tdHtdpDRHSRnrar03tzW0ZQQnFJxPODMvQHFJRLwHBijIjs/unhnenL8B7SOS8oms4diid0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhGoRpK97gZhWKyWMdIGKZb/BnDqdzA051p05nXe8gf/PvFe1
	Ms3Kh3qVrjm0Ls9apuQBU7njpctBSVUQwxYpuJnAxXrL5dLYRLa9O+v2ACQMF00=
X-Google-Smtp-Source: AGHT+IFuL9Q07yTcsOaTlM9yCAi2Sq10Vfal5nmkc6A5s4iCIddgdM5+DCgpbmtvZDvAH4IhvlctSw==
X-Received: by 2002:a5d:47c5:0:b0:37c:cc7c:761c with SMTP id ffacd0b85a97d-381c130731fmr3735779f8f.3.1730424173123;
        Thu, 31 Oct 2024 18:22:53 -0700 (PDT)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad3fsm3501622f8f.95.2024.10.31.18.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:22:52 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org
Subject: [PATCH v2 2/2] clk: qcom: Add SM6115 LPASSCC
Date: Fri,  1 Nov 2024 01:22:47 +0000
Message-ID: <20241101012247.216825-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101012247.216825-1-alexey.klimov@linaro.org>
References: <20241101012247.216825-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

SM6115 (and its derivatives or similar SoCs) has an LPASS clock
controller block which provides audio-related resets.

Add the required code to support them.

Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
[alexey.klimov] fixed compilation errors after rebase,
slightly changed the commit message
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/clk/qcom/Kconfig          |  9 ++++
 drivers/clk/qcom/Makefile         |  1 +
 drivers/clk/qcom/lpasscc-sm6115.c | 85 +++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/clk/qcom/lpasscc-sm6115.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 953589e07c59..26021166e329 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1193,6 +1193,15 @@ config SM_GPUCC_8650
 	  Say Y if you want to support graphics controller devices and
 	  functionality such as 3D graphics.
 
+config SM_LPASSCC_6115
+	tristate "SM6115 Low Power Audio Subsystem (LPASS) Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select SM_GCC_6115
+	help
+	  Support for the LPASS clock controller on SM6115 devices.
+	  Say Y if you want to toggle LPASS-adjacent resets within
+	  this clock controller to reset the LPASS subsystem.
+
 config SM_TCSRCC_8550
 	tristate "SM8550 TCSR Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index fac4b9b61e55..784434febd4c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
 obj-$(CONFIG_SM_GPUCC_8450) += gpucc-sm8450.o
 obj-$(CONFIG_SM_GPUCC_8550) += gpucc-sm8550.o
 obj-$(CONFIG_SM_GPUCC_8650) += gpucc-sm8650.o
+obj-$(CONFIG_SM_LPASSCC_6115) += lpasscc-sm6115.o
 obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
 obj-$(CONFIG_SM_TCSRCC_8650) += tcsrcc-sm8650.o
 obj-$(CONFIG_SM_VIDEOCC_7150) += videocc-sm7150.o
diff --git a/drivers/clk/qcom/lpasscc-sm6115.c b/drivers/clk/qcom/lpasscc-sm6115.c
new file mode 100644
index 000000000000..8ffdab71b948
--- /dev/null
+++ b/drivers/clk/qcom/lpasscc-sm6115.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, 2023 Linaro Limited
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm6115-lpasscc.h>
+
+#include "common.h"
+#include "reset.h"
+
+static const struct qcom_reset_map lpass_audiocc_sm6115_resets[] = {
+	[LPASS_AUDIO_SWR_RX_CGCR] =  { .reg = 0x98, .bit = 1, .udelay = 500 },
+};
+
+static struct regmap_config lpass_audiocc_sm6115_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.name = "lpass-audio-csr",
+	.max_register = 0x1000,
+};
+
+static const struct qcom_cc_desc lpass_audiocc_sm6115_reset_desc = {
+	.config = &lpass_audiocc_sm6115_regmap_config,
+	.resets = lpass_audiocc_sm6115_resets,
+	.num_resets = ARRAY_SIZE(lpass_audiocc_sm6115_resets),
+};
+
+static const struct qcom_reset_map lpasscc_sm6115_resets[] = {
+	[LPASS_SWR_TX_CONFIG_CGCR] = { .reg = 0x100, .bit = 1, .udelay = 500 },
+};
+
+static struct regmap_config lpasscc_sm6115_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.name = "lpass-tcsr",
+	.max_register = 0x1000,
+};
+
+static const struct qcom_cc_desc lpasscc_sm6115_reset_desc = {
+	.config = &lpasscc_sm6115_regmap_config,
+	.resets = lpasscc_sm6115_resets,
+	.num_resets = ARRAY_SIZE(lpasscc_sm6115_resets),
+};
+
+static const struct of_device_id lpasscc_sm6115_match_table[] = {
+	{
+		.compatible = "qcom,sm6115-lpassaudiocc",
+		.data = &lpass_audiocc_sm6115_reset_desc,
+	}, {
+		.compatible = "qcom,sm6115-lpasscc",
+		.data = &lpasscc_sm6115_reset_desc,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lpasscc_sm6115_match_table);
+
+static int lpasscc_sm6115_probe(struct platform_device *pdev)
+{
+	const struct qcom_cc_desc *desc = of_device_get_match_data(&pdev->dev);
+
+	return qcom_cc_probe_by_index(pdev, 0, desc);
+}
+
+static struct platform_driver lpasscc_sm6115_driver = {
+	.probe = lpasscc_sm6115_probe,
+	.driver = {
+		.name = "lpasscc-sm6115",
+		.of_match_table = lpasscc_sm6115_match_table,
+	},
+};
+
+module_platform_driver(lpasscc_sm6115_driver);
+
+MODULE_DESCRIPTION("QTI LPASSCC SM6115 Driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


