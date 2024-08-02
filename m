Return-Path: <linux-kernel+bounces-273127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0A49464CB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C1F1F22C16
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760E127E0D;
	Fri,  2 Aug 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdmolVEE"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC1763E7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632690; cv=none; b=sC/sLp3+roqk2beRbnBFUUW9kScU9aDsPEwKOUqpZSnsiDWPkzXJtJRhQTH1LWvOl13tzRkIz8p+mVZs8K17FWFJQajBQjQ5cyWnHQ/fxl8hrgRYHaoot9tQaIrdKjre/UGqP5pLHjsP36EjuTkRMGD/3T/HtvG+vQc5a0rtPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632690; c=relaxed/simple;
	bh=z1RdEZ7A8nCpAdJiYNdv+o6BPnQVzKEX+9aqwiP/Jig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUbPVF0I854v0oHMxKdVzz0+FEB6MRQQWC+wwGU+fRcxeNN33VZBl7kXds+feLv1UXeRGaxqpQNYJWx0v9ZswLcD4CL1e7gfelhGLxtTvNTZ2XofQzoub0eEmeztB4UAiC7GJ7BcLepCV+weX5OFh8u9RH+uXTUni63ymiyE1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hdmolVEE; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fbbd4775bso191774739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722632687; x=1723237487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bizVYN62g2WR0h6WdBjGD7lztQUVqZACzgFg3ew1NZg=;
        b=hdmolVEEz3F+RJMK0XoDpq4DHzYtDE48C+k1TzlEB82oZRtD2cAQ/W4mZKgG0P9itj
         DfLFI3EmT8cl5zas7GmWLAvl3x78g0ob/r1oQyLyElpnF00LKaVFzZwoI0twQU48di2B
         n6KYi5qkGPGL85W00E/yq6pqAncO7syKTcEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632687; x=1723237487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bizVYN62g2WR0h6WdBjGD7lztQUVqZACzgFg3ew1NZg=;
        b=gt3iHtzFhb8RFERpECpTWvM4OHbmm8hN8gBT61pgZKbXQzgPoAAAAQUCkuyxRvKW0w
         Z5uHYPljdTVDbV2bsMTpt5LjUFdMTrql0LSH5FFrFG9zCKOOi8nJJo0tGC5Im+GPtFI2
         yYYd1SkLQ9Sr5I78J0mOP8MKukFzsnCaJECw447qepeauXz9s6kyQLn0o8/pqeKP+gyw
         YkBkBxZ3OrSrvXLKrS8ijc9ieEVeGwX0D0Avopnqhh28G0ACqMPVcnco1zgntXpMLXFC
         WbiOb/NGVtZp+FiP1da9UOcj1uTkYd1RPOGVpXlNPT/xgO+/IYRZjI2Vrc522u7JaWgB
         2YDA==
X-Gm-Message-State: AOJu0Yz3TcYi1uWWOl0AtYEAGpfeKf/RdRugYVsOnDfqKWt9OpCG5Bgg
	GNALKM9fyWhDHvtRml6UbkBEBlVgZBzvkEax4Hp5XX9kMglvoBzD+k4y3qAODrjXg+ILW2GHZqs
	4gQ==
X-Google-Smtp-Source: AGHT+IHUFG1Og3qZnJuB+WHW/Mj9RyaQmwZbLxjxKt93uYCF5XTb9EODVbRysfl5tZk2LzoGN4JDew==
X-Received: by 2002:a05:6602:3ca:b0:81f:9468:7c3c with SMTP id ca18e2360f4ac-81fd43e3415mr598235239f.12.1722632687275;
        Fri, 02 Aug 2024 14:04:47 -0700 (PDT)
Received: from rink.c.googlers.com.com (212.165.232.35.bc.googleusercontent.com. [35.232.165.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d7223csm70159939f.42.2024.08.02.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:04:46 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org,
	jettrink@chromium.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3] tpm: Add new device/vendor ID 0x50666666
Date: Fri,  2 Aug 2024 21:04:32 +0000
Message-ID: <20240802210441.625738-1-jettrink@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept another DID:VID for the next generation Google TPM. This TPM
has the same Ti50 firmware and fulfills the same interface.

Signed-off-by: Jett Rink <jettrink@chromium.org>
---

Changes in v3:
Refactor ternary operators into helper method.

Changes in v2:
Patchset 2 applies cleanly

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 30 ++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index adf22992138e..1f83cfe2724c 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -31,7 +31,8 @@
 #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
 #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
-#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_DT_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_OT_I2C_DID_VID		0x50666666L	/* Device and vendor ID reg value */
 #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
 #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
 #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
@@ -668,6 +669,27 @@ static const struct of_device_id of_cr50_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
 #endif
 
+/**
+ * tpm_cr50_vid_to_name() - Maps VID to name.
+ * @vendor:	Vendor identifier to map to name
+ *
+ * Return:
+ *	A valid string for the vendor or empty string
+ */
+static const char *tpm_cr50_vid_to_name(u32 vendor)
+{
+	switch (vendor) {
+	case TPM_CR50_I2C_DID_VID:
+		return "cr50";
+	case TPM_TI50_DT_I2C_DID_VID:
+		return "ti50 DT";
+	case TPM_TI50_OT_I2C_DID_VID:
+		return "ti50 OT";
+	default:
+		return "";
+	}
+}
+
 /**
  * tpm_cr50_i2c_probe() - Driver probe function.
  * @client:	I2C client information.
@@ -741,14 +763,16 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	}
 
 	vendor = le32_to_cpup((__le32 *)buf);
-	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
+	if (vendor != TPM_CR50_I2C_DID_VID &&
+	    vendor != TPM_TI50_DT_I2C_DID_VID &&
+	    vendor != TPM_TI50_OT_I2C_DID_VID) {
 		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
 		tpm_cr50_release_locality(chip, true);
 		return -ENODEV;
 	}
 
 	dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
-		 vendor == TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
+		 tpm_cr50_vid_to_name(vendor),
 		 client->addr, client->irq, vendor >> 16);
 	return tpm_chip_register(chip);
 }
-- 
2.46.0.rc2.264.g509ed76dc8-goog


