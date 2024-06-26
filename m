Return-Path: <linux-kernel+bounces-230085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E077F91782C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C5F283E24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7479614534D;
	Wed, 26 Jun 2024 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjnFBwNA"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F94374D9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379978; cv=none; b=VFgNIKvGJolKn8VqPrBSQvHu2/nLp0+mVfI/3pAyVm0S4boooEnwhxcBzV8W7j+kG0jh4s+yWIQYzjNpj9WzUSubc1EMZbLsnrhX5IaAgY5sribnw57Sgtyhx1cg4Ai6KDVSfVtikmRaXsS9joGQs9536sg8PS1q7pkcvCxn3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379978; c=relaxed/simple;
	bh=xCT7lVp98kCRZtyWYRxfixQfe2CIPTxNgxIBvGBDguI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmEcWIxA7EOKntZr6WU053JOKVnSJzHDjZtm17qIy01/uneGhr476sUpvcSV3phQQxiNiV9ke4O+9gatSmyhkzYalhTF3hWLUHsE3qXQxEioyodF2BhNlOLrwZioY7NqhJx7MArTVjFYjXy/ckYJy+GGNxvCXi3hkUJh6HYKB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BjnFBwNA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9de13d6baso44822735ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719379976; x=1719984776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1S+AEoskXT5Wt8HN5vslZq0yRwGsMLc0XREaoIRCLVM=;
        b=BjnFBwNAMmU6/X+j7cyrY25J7RnAh2W/BymN6chdFOPlJ2AUK/rdrfy1Gbka4oF0RJ
         rfWt03Bi9T07NWzB+8m1/5zv5Y7HUI9NIYONcefVyy3MuOOhT65aCUMF4t3A9+YlI7HQ
         ks/n7fVFJoIWNOY2x+voqOCrk/wKyOK0qwls2ZqkS0VnIBtvoWKp3XsxUucTUb7mXjmd
         V77seX6QoJ2y5L1nym2lIOv6Q5smqFvYZlsRsN/ljvaGPG+Qo56IH0ykfoCk7Q7KDW7T
         1PbSiq0L8DAxH3kDHKhz3KwxXuEuUwlLEEGGFrqyCWRfOex3JeRkSWZeLQR3n7o9lpGR
         EgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719379976; x=1719984776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1S+AEoskXT5Wt8HN5vslZq0yRwGsMLc0XREaoIRCLVM=;
        b=I9nlwdXVfDR9CNsY00quZ0j2nRZo2ljnf0kRUDk4dIlUTxf2Y5oypgKRX+h5ZrW0y1
         LPrNe0KPMWKLZEJfAIZY39D9DZ4PmsirSJtvlTzP4NedD9mVXOPRTE0g4PZ31k6VGSSw
         l6y8bMLnfyB/LkMsc0shpjSWT3CKogBkysmJWmbsafFPZGuKfkMmwjwloZ24uBRDcmja
         I6obd9FL9zENl0MDn0UhF4Lf9db8lLA6q8b2EPBmXu9Bdp26m9s54V9TaOv4wnOf2U8Z
         S/Qiw1Hi4MR3Trqpgqmlj7CNF8zZJSnNBHo4GpW3IsRs0HY94FfDMLua7wXgHh0SMqSD
         I/IA==
X-Forwarded-Encrypted: i=1; AJvYcCVbbK1Rn5SwK9xBXu48ZoB+Mow/CEvYejwXhSBbE40pxyX95XURdN0nuvXwDlO6UKD0ASP6UD+4J+8A8MeKqfekFOu+Xkc7HdQI60+P
X-Gm-Message-State: AOJu0YzcAlUckwnLjDLiLfSe+TPT1t5ejrDdotT+qfKRhe8omxKAh99y
	YoFnWU5pqdChfhZ262sBlu5uvMr+C6rvmsOPBnPHhfmAI1ZAzBGjGlBrOFQCrg==
X-Google-Smtp-Source: AGHT+IHO3kspsD4A/iShQUWYN2rXxiofepDsn0PW/d6X0ZHmL7FAhVYbvvthnUL6HyeynPdbr74pOg==
X-Received: by 2002:a17:902:bb10:b0:1f7:b24:c271 with SMTP id d9443c01a7336-1fa23f6750amr76532745ad.21.1719379976122;
        Tue, 25 Jun 2024 22:32:56 -0700 (PDT)
Received: from localhost.localdomain ([120.60.143.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa95e9a456sm2876925ad.66.2024.06.25.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:32:55 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mhi@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] bus: mhi: host: pci_generic: Use unique 'mhi_pci_dev_info' for product families
Date: Wed, 26 Jun 2024 11:02:37 +0530
Message-Id: <20240626053237.4227-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a single 'mhi_pci_dev_info' is shared across different product
families. Even though it makes the device functional, it misleads the users
by sharing the common product name.

For instance, below message will be printed for Foxconn SDX62 modem during
boot:

"MHI PCI device found: foxconn-sdx65"

But this is quite misleading to the users since the actual modem plugged in
could be 'T99W373' which is based on SDX62.

So fix this issue by using a unique 'mhi_pci_dev_info' for product
families. This allows us to specify a unique product name for each product
family. Also, once this name is exposed to client drivers, they may use
this name to identify the modems and use any modem specific configuration.

Modems of unknown product families are not impacted by this change.

CC: Slark Xiao <slark_xiao@163.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Used 'mhi_foxconn_t99w175_info' for HP variant as well

 drivers/bus/mhi/host/pci_generic.c | 78 ++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 08844ee79654..35ae7cd0711f 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -419,8 +419,10 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
 	.event_cfg = mhi_foxconn_sdx55_events,
 };
 
-static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
-	.name = "foxconn-sdx24",
+static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
+	.name = "foxconn-sdx55",
+	.fw = "qcom/sdx55m/sbl1.mbn",
+	.edl = "qcom/sdx55m/edl.mbn",
 	.config = &modem_foxconn_sdx55_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -428,8 +430,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
 	.sideband_wake = false,
 };
 
-static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
-	.name = "foxconn-sdx55",
+static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
+	.name = "foxconn-t99w175",
 	.fw = "qcom/sdx55m/sbl1.mbn",
 	.edl = "qcom/sdx55m/edl.mbn",
 	.config = &modem_foxconn_sdx55_config,
@@ -439,8 +441,46 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
 	.sideband_wake = false,
 };
 
-static const struct mhi_pci_dev_info mhi_foxconn_sdx65_info = {
-	.name = "foxconn-sdx65",
+static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
+	.name = "foxconn-dw5930e",
+	.fw = "qcom/sdx55m/sbl1.mbn",
+	.edl = "qcom/sdx55m/edl.mbn",
+	.config = &modem_foxconn_sdx55_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
+static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
+	.name = "foxconn-t99w368",
+	.config = &modem_foxconn_sdx55_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
+static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
+	.name = "foxconn-t99w373",
+	.config = &modem_foxconn_sdx55_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
+static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
+	.name = "foxconn-t99w510",
+	.config = &modem_foxconn_sdx55_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.mru_default = 32768,
+	.sideband_wake = false,
+};
+
+static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
+	.name = "foxconn-dw5932e",
 	.config = &modem_foxconn_sdx55_config,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
@@ -646,40 +686,40 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
 	/* DW5930e (sdx55), With eSIM, It's also T99W175 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b0),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5930e_info },
 	/* DW5930e (sdx55), Non-eSIM, It's also T99W175 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b1),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5930e_info },
 	/* T99W175 (sdx55), Based on Qualcomm new baseline */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0bf),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
 	/* T99W175 (sdx55) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0c3),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
 	/* T99W368 (sdx65) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d8),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w368_info },
 	/* T99W373 (sdx62) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w373_info },
 	/* T99W510 (sdx24), variant 1 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f0),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w510_info },
 	/* T99W510 (sdx24), variant 2 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f1),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w510_info },
 	/* T99W510 (sdx24), variant 3 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f2),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w510_info },
 	/* DW5932e-eSIM (sdx62), With eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f5),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5932e_info },
 	/* DW5932e (sdx62), Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5932e_info },
 	/* MV31-W (Cinterion) */
 	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
@@ -694,7 +734,7 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
 	/* T99W175 (sdx55), HP variant */
 	{ PCI_DEVICE(0x03f0, 0x0a6c),
-		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
-- 
2.25.1


