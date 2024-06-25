Return-Path: <linux-kernel+bounces-228457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D36916033
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1131C1C2168B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596FE146D69;
	Tue, 25 Jun 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIUfrfl9"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29A1DFFD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301327; cv=none; b=eb66eGDAwQW4QYJE8WcI2toZY8pQUT4ulbdU8bnWrbMVtqS/p1x0jQD3W/FFzv41dNq+0dLQJ09GFPM9AOgfmQvzQP72SkV2jrIkKFECvmkz3bf3LAQm0LEdRd4r0k63ArD6J/gCkk0SFxO6cGJnBYnd5j9jfyxyHh1j1Srp1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301327; c=relaxed/simple;
	bh=GmkimFcFtFK8mMsCi0jj7QEksDlg26Utvz9AR83r6Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAntmCkRUDTHvgUQlImcr2Tgh+76VP0iI5U1YTNPh7x6kzQYXP7IINVQ2MMHdY0GGQodOJtzu0BLLzT48xHelAIKfFrx6pq443RGsx5hDvokKMvtFE4B6iUuELkBDRlsnkXIg1nZDiK12+SOANVxnu8/8vxvQfRIHIOGV+G+fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIUfrfl9; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25cc6962c24so2302985fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719301325; x=1719906125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRB38DCEZO7cOWwaamoDCIbRbW1WGzcG4rzbWV+0pOM=;
        b=MIUfrfl9q0X89T4BztDoQ0m8pgzLDhZbtTgUanDZnlQiBtYydmJNNzyC1EcYX8Hwfi
         kJxukzhej1d3kXCslioNkllwEjCxORP2BxGF++sezP9E67qt0jIaGkDoLG1+s03od1CY
         CMIee5k1Enuc/3WCX6B0y2WB/rUhKddmPy3Y9uc4PhSx/NX6YOJ3h/8w6CWIIQudTyKY
         vwqIQtLC23dZ1IWD8TOaQA2rIlpV+9Lb+Qmym8Wl97+vputIgNAhJ3wxIDEDCWgjWQ38
         9RJWXyCuQhq5brjANv89niBJ0qev1XrSuJcO3rKidxgvjYgu6eaYWX49H1e4gY7gIM4f
         ZTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301325; x=1719906125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRB38DCEZO7cOWwaamoDCIbRbW1WGzcG4rzbWV+0pOM=;
        b=wsuXuCA9LUTBnT6ZMmmGekTQtODavo9LkSUAGrx6AWX7OHdN/Jl/gFYjA8WvlJB5Vm
         x7Awz5ntMGh+Xg1SDKixbpT/jWiQm1pUvnViHhpt7I/Eyo+Kaeub+D7oruoR3lSVnhQ4
         RXOqbJnClqbHzbiUAA4KctMCaqHGQKFHRJANOvDaU9lr26N4yk0HFmmXb5NFzLR5vKt/
         LGmZ5OWQA1jfxGCRDrepnhwAYCjikiYPXqibIkrq2zVjWnxKpvAbdDJc3SNiTBHOlOBn
         QFG0L3JpBoui0iQwrQlrGYTZkWWrtRO5GGrJxBRe6byZ4BcHrPTNJlVsabFnOvBHGLkW
         ye0w==
X-Forwarded-Encrypted: i=1; AJvYcCXBQyBOLCiBu9XBSXiRbmAj7mPcyY6IXfq3XausgEOrZGHW7xkaw3nDTGl+krIkrKiZBzlaJ5Ba65wx1qkYUz1tivNUJle9JQDEvqaP
X-Gm-Message-State: AOJu0Yx/EmsV2+Jy60l/WWnQbi1uVktpGZJEDOVR/QsgHW6DtU4rG9Vn
	PWlc6bdKh2hbcYC2TLyMqKbkr6+/bl3WwoPkGXACHDHNgAVSRVp6tGNcsE/GSw==
X-Google-Smtp-Source: AGHT+IGUI/YebZZksQQBqBp3qcWWB8sVkfkJcd0UugX2LPBmEhL8Cml8W3OQr90aRqjoLDLmk2VB4Q==
X-Received: by 2002:a05:6870:148e:b0:259:31ad:b566 with SMTP id 586e51a60fabf-25d06e55cf3mr6658652fac.42.1719301324649;
        Tue, 25 Jun 2024 00:42:04 -0700 (PDT)
Received: from localhost.localdomain ([117.193.213.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065126d0b0sm7404416b3a.103.2024.06.25.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:42:04 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mhi@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] bus: mhi: host: pci_generic: Use unique 'mhi_pci_dev_info' for product families
Date: Tue, 25 Jun 2024 13:11:48 +0530
Message-Id: <20240625074148.7412-1-manivannan.sadhasivam@linaro.org>
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
 drivers/bus/mhi/host/pci_generic.c | 76 +++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 08844ee79654..25113b87b780 100644
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
-- 
2.25.1


