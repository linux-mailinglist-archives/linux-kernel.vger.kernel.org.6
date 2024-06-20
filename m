Return-Path: <linux-kernel+bounces-223650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D34F91160C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECAD1F222B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705415218E;
	Thu, 20 Jun 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAa+6YkV"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D65142E78
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924129; cv=none; b=GtMN4C+NN7pU+F+pvLIteCKlciMUXWzvKrSFPV548dxqsZmTsYvU8nYzxz78xUkqnzMurBh9PRS9SFJzM7SIwd0WXfA8xp2VcoZhGJk2YcjlYNTEPSn8bsWTgBbnMMVOHsVyylMfqUNMCDAUD/k1hvAICrcMxTcZmcVeUHw7fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924129; c=relaxed/simple;
	bh=fGeOg9IlwzluTlyCNY8YvZsrzUUPSUIaxst8pncMadQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Imnb4QbKKZR3bhb4shJFhOvgIGgCmps3AWfifFrMyJHhGCuHTa2N90KUuXjvemGROMDg1BxfGwnF4rwHD+6TXT4iKjTN5nYr0CN1D1wVIskjMN87zqVZ9v5FwYukVdEn9nzDOJQK9kWuQeC1ntb3ZSbW0QBHbm5TfaFWhXz4hwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAa+6YkV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso16067331fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718924125; x=1719528925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAkZJWRdrjseyHv3miJo8KPIeEQuDipmKcJIz+GAxHo=;
        b=rAa+6YkVLRNsWZNG5Q3IlVX01TFA90mFFeR7IV+HQk+VZxd8IwL6uTWrjvc50kgDpB
         15Ti7Lt/psFhX17k+YelHplJPUPXB811TlmRNXbqqPKxzvbnNwU5pL2JkueToFYBgKQe
         X30ew15hNKHPvCHU9kxJXPxVWJf8sC78dJfHYeXFoW1FDs6LYKPfoo8NVtg/jSX2mA+B
         hhy2otGh3DgAuxTB9Q7HFNFSZnie4FzPlcApPAZsNU/9/NlW28i893L02TghJRb1xZzs
         pucAvADc4tNvy2Far2/9sraCZGVvDRSTl1VaMw+CwloMlGVj8/MIWwAUoicTOCQzEaxa
         bXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718924125; x=1719528925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAkZJWRdrjseyHv3miJo8KPIeEQuDipmKcJIz+GAxHo=;
        b=DztfcLvKZsjRUyHd9YS5yDDvq/zm8P5bjlR6ev/4Nuyq3CTFLz7o2OWjC3RP4KEXUn
         dESdvtPxE+BldKS6Da0RDUwS2NuK221ivUWbKLqXYRMyTf47a7I1Kx3TlYgfxZLhmwO2
         HLAPcNca5vnH9eooZVFWgEHKs9CD+xZ6X/T7mtP4aBwqBfVkgbDNr+Fn+FDvgREupxPO
         AAdHAqZsH4YgU5BD1dkJa1wN2o9BMh9A6HxVG1dwpEWHc3N7BgX9VX9KihhNwP4h0gFj
         q6rSAacFoBarnS8yCKa5vdoiW3cgGJu5xLO6UqIt50L9iH0H/ng6vtdOd1o7rJemJv/I
         n1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUakufjdeLPDHq7yvwB0f+CEaEI5RGA93P20XjUmi2oHKzOwevTtGpweoRTBgD/GpXA/NKmiIsbmx0zOP0Q/FCJt6MzP6LdohaTGcFD
X-Gm-Message-State: AOJu0YxDr1+ak4IfObRhqmRjwsjUsLm5Pn9ddrN2hVCMEAxCu9OYKvoc
	pA+H9bxSIwwRdYRvW+uzPpypYDjL28asMTvw372T+cZikxlMWReGjUfQaP+1yhg=
X-Google-Smtp-Source: AGHT+IGUiD3mS5+oZ8ev/5mxFflruXQcNA8/q+CsXlE5S9i5BqGO6u8B6JfDkGRmSMAGYCAU7/EsxQ==
X-Received: by 2002:a2e:b0c9:0:b0:2eb:68d0:f1cc with SMTP id 38308e7fff4ca-2ec3cfe125emr44226971fa.43.1718924125185;
        Thu, 20 Jun 2024 15:55:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d60126fsm510461fa.20.2024.06.20.15.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:55:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 01:55:22 +0300
Subject: [PATCH v2 3/7] usb: typec: ucsi: split read operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-ucsi-rework-interface-v2-3-a399ff96bf88@linaro.org>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
In-Reply-To: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15706;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=fGeOg9IlwzluTlyCNY8YvZsrzUUPSUIaxst8pncMadQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmdLNZ9IsRZ2SYZqtkRYbeqqOuBNLN6cPmTV9OH
 Jxzz2Qa13OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnSzWQAKCRCLPIo+Aiko
 1WFpB/9sh/+wHYkz+qu3yxn9fZvh/0Eo6L3xJovCmUhthpJpDnU2mkjcQqdpmUA52SwVHlwgNnI
 uegzjw8lmM96Xfi9g8QRKkr+peWoQoEtFfVI6aLdMLbsZXP5/nNT+V30SBdLZbk5fL1o7+OOIkD
 /seBtdREcvj/hvjS5zvRmf5p3Xw7etsn39a+wVs3g3nLRWT7z/jK0TAHXh7SEHvMy9XSU7wFfXf
 jjgaHqd6vHFhl3hnTCJpoJIML25Fu7uaZQVUflaDoi2uMO/t89QwJE/Qlulk8vsDvjbtlRhr71H
 KaB2McNlJcrTKZmUDe7qqPYY3MZJKIIX+/vjdvBm8OdXWe/1
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The read operation is only used to read fixed data at fixed offsets
(UCSI_VERSION, UCSI_CCI, UCSI_MESSAGE_IN). In some cases drivers apply
offset-specific overrides. Split the read() operation into three
operations, read_version(), read_cci(), read_message_in().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c           | 20 +++++------
 drivers/usb/typec/ucsi/ucsi.h           |  9 +++--
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 60 ++++++++++++++++++++++++++++-----
 drivers/usb/typec/ucsi/ucsi_ccg.c       | 50 ++++++++++++++-------------
 drivers/usb/typec/ucsi/ucsi_glink.c     | 19 ++++++++++-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 19 ++++++++++-
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 +++++++++++++++++-----------
 7 files changed, 163 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2441b077f457..81b459b26b74 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -46,7 +46,7 @@ static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
 	if (ucsi->version <= UCSI_VERSION_1_2)
 		buf_size = clamp(buf_size, 0, 16);
 
-	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
+	return ucsi->ops->read_message_in(ucsi, buf, buf_size);
 }
 
 static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
@@ -130,7 +130,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (ret)
 		return ret;
 
-	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ucsi->ops->read_cci(ucsi, &cci);
 	if (ret)
 		return ret;
 
@@ -1302,7 +1302,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ucsi->ops->read_cci(ucsi, &cci);
 	if (ret < 0)
 		goto out;
 
@@ -1320,8 +1320,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
 		do {
-			ret = ucsi->ops->read(ucsi, UCSI_CCI,
-					      &cci, sizeof(cci));
+			ret = ucsi->ops->read_cci(ucsi, &cci);
 			if (ret < 0)
 				goto out;
 			if (cci & UCSI_CCI_COMMAND_COMPLETE)
@@ -1350,7 +1349,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 		/* Give the PPM time to process a reset before reading CCI */
 		msleep(20);
 
-		ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+		ret = ucsi->ops->read_cci(ucsi, &cci);
 		if (ret)
 			goto out;
 
@@ -1770,7 +1769,7 @@ static int ucsi_init(struct ucsi *ucsi)
 	ucsi->ntfy = ntfy;
 
 	mutex_lock(&ucsi->ppm_lock);
-	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ucsi->ops->read_cci(ucsi, &cci);
 	mutex_unlock(&ucsi->ppm_lock);
 	if (ret)
 		return ret;
@@ -1884,7 +1883,9 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 {
 	struct ucsi *ucsi;
 
-	if (!ops || !ops->read || !ops->sync_control || !ops->async_control)
+	if (!ops ||
+	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
+	    !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
@@ -1920,8 +1921,7 @@ int ucsi_register(struct ucsi *ucsi)
 {
 	int ret;
 
-	ret = ucsi->ops->read(ucsi, UCSI_VERSION, &ucsi->version,
-			      sizeof(ucsi->version));
+	ret = ucsi->ops->read_version(ucsi, &ucsi->version);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 713a6d3fc4e9..0cf550cc9b5d 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -56,7 +56,9 @@ struct dentry;
 
 /**
  * struct ucsi_operations - UCSI I/O operations
- * @read: Read operation
+ * @read_version: Read implemented UCSI version
+ * @read_cci: Read CCI register
+ * @read_message_in: Read message data from UCSI
  * @sync_control: Blocking control operation
  * @async_control: Non-blocking control operation
  * @update_altmodes: Squashes duplicate DP altmodes
@@ -68,8 +70,9 @@ struct dentry;
  * return immediately after sending the data to the PPM.
  */
 struct ucsi_operations {
-	int (*read)(struct ucsi *ucsi, unsigned int offset,
-		    void *val, size_t val_len);
+	int (*read_version)(struct ucsi *ucsi, u16 *version);
+	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
+	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
 	int (*sync_control)(struct ucsi *ucsi, u64 command);
 	int (*async_control)(struct ucsi *ucsi, u64 command);
 	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index feccbfc8acbe..61dd28dae3a4 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -45,8 +45,7 @@ static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
 	return 0;
 }
 
-static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
-			  void *val, size_t val_len)
+static int ucsi_acpi_read_version(struct ucsi *ucsi, u16 *version)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
@@ -55,7 +54,35 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 	if (ret)
 		return ret;
 
-	memcpy(val, ua->base + offset, val_len);
+	memcpy(version, ua->base + UCSI_VERSION, sizeof(*version));
+
+	return 0;
+}
+
+static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+	if (ret)
+		return ret;
+
+	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
+
+	return 0;
+}
+
+static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+	if (ret)
+		return ret;
+
+	memcpy(val, ua->base + UCSI_MESSAGE_IN, val_len);
 
 	return 0;
 }
@@ -98,30 +125,45 @@ static int ucsi_acpi_sync_control(struct ucsi *ucsi, u64 command)
 }
 
 static const struct ucsi_operations ucsi_acpi_ops = {
-	.read = ucsi_acpi_read,
+	.read_version = ucsi_acpi_read_version,
+	.read_cci = ucsi_acpi_read_cci,
+	.read_message_in = ucsi_acpi_read_message_in,
 	.sync_control = ucsi_acpi_sync_control,
 	.async_control = ucsi_acpi_async_control
 };
 
 static int
-ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_len)
+ucsi_zenbook_read_cci(struct ucsi *ucsi, u32 *cci)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
 
-	if (offset == UCSI_VERSION || UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
+	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
 		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
 		if (ret)
 			return ret;
 	}
 
-	memcpy(val, ua->base + offset, val_len);
+	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
+
+	return 0;
+}
+
+static int
+ucsi_zenbook_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+
+	/* UCSI_MESSAGE_IN is never read for PPM_RESET, return stored data */
+	memcpy(val, ua->base + UCSI_MESSAGE_IN, val_len);
 
 	return 0;
 }
 
 static const struct ucsi_operations ucsi_zenbook_ops = {
-	.read = ucsi_zenbook_read,
+	.read_version = ucsi_acpi_read_version,
+	.read_cci = ucsi_zenbook_read_cci,
+	.read_message_in = ucsi_zenbook_read_message_in,
 	.sync_control = ucsi_acpi_sync_control,
 	.async_control = ucsi_acpi_async_control
 };
@@ -143,7 +185,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	u32 cci;
 	int ret;
 
-	ret = ua->ucsi->ops->read(ua->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ua->ucsi->ops->read_cci(ua->ucsi, &cci);
 	if (ret)
 		return;
 
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 76b39bb9762d..6ccc394f268e 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -556,32 +556,34 @@ static void ucsi_ccg_nvidia_altmode(struct ucsi_ccg *uc,
 	}
 }
 
-static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
-			 void *val, size_t val_len)
+static int ucsi_ccg_read_version(struct ucsi *ucsi, u16 *version)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
-	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
-	struct ucsi_capability *cap;
-	struct ucsi_altmode *alt;
-	int ret = 0;
+	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_VERSION);
 
-	if (offset == UCSI_CCI) {
-		spin_lock(&uc->op_lock);
-		memcpy(val, &(uc->op_data).cci, val_len);
-		spin_unlock(&uc->op_lock);
-	} else if (offset == UCSI_MESSAGE_IN) {
-		spin_lock(&uc->op_lock);
-		memcpy(val, &(uc->op_data).message_in, val_len);
-		spin_unlock(&uc->op_lock);
-	} else {
-		ret = ccg_read(uc, reg, val, val_len);
-	}
+	return ccg_read(uc, reg, (u8 *)version, sizeof(*version));
+}
 
-	if (ret)
-		return ret;
+static int ucsi_ccg_read_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 
-	if (offset != UCSI_MESSAGE_IN)
-		return ret;
+	spin_lock(&uc->op_lock);
+	*cci = uc->op_data.cci;
+	spin_unlock(&uc->op_lock);
+
+	return 0;
+}
+
+static int ucsi_ccg_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
+{
+	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
+	struct ucsi_capability *cap;
+	struct ucsi_altmode *alt;
+
+	spin_lock(&uc->op_lock);
+	memcpy(val, uc->op_data.message_in, val_len);
+	spin_unlock(&uc->op_lock);
 
 	switch (UCSI_COMMAND(uc->last_cmd_sent)) {
 	case UCSI_GET_CURRENT_CAM:
@@ -607,7 +609,7 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	}
 	uc->last_cmd_sent = 0;
 
-	return ret;
+	return 0;
 }
 
 static int ucsi_ccg_async_control(struct ucsi *ucsi, u64 command)
@@ -663,7 +665,9 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 }
 
 static const struct ucsi_operations ucsi_ccg_ops = {
-	.read = ucsi_ccg_read,
+	.read_version = ucsi_ccg_read_version,
+	.read_cci = ucsi_ccg_read_cci,
+	.read_message_in = ucsi_ccg_read_message_in,
 	.sync_control = ucsi_ccg_sync_control,
 	.async_control = ucsi_ccg_async_control,
 	.update_altmodes = ucsi_ccg_update_altmodes
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 5986c4a824a6..62a3a192e076 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -114,6 +114,21 @@ static int pmic_glink_ucsi_read(struct ucsi *__ucsi, unsigned int offset,
 	return ret;
 }
 
+static int pmic_glink_ucsi_read_version(struct ucsi *ucsi, u16 *version)
+{
+	return pmic_glink_ucsi_read(ucsi, UCSI_VERSION, version, sizeof(*version));
+}
+
+static int pmic_glink_ucsi_read_cci(struct ucsi *ucsi, u32 *cci)
+{
+	return pmic_glink_ucsi_read(ucsi, UCSI_CCI, cci, sizeof(*cci));
+}
+
+static int pmic_glink_ucsi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
+{
+	return pmic_glink_ucsi_read(ucsi, UCSI_MESSAGE_IN, val, val_len);
+}
+
 static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned int offset,
 					const void *val, size_t val_len)
 {
@@ -214,7 +229,9 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 }
 
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
-	.read = pmic_glink_ucsi_read,
+	.read_version = pmic_glink_ucsi_read_version,
+	.read_cci = pmic_glink_ucsi_read_cci,
+	.read_message_in = pmic_glink_ucsi_read_message_in,
 	.sync_control = pmic_glink_ucsi_sync_control,
 	.async_control = pmic_glink_ucsi_async_control,
 	.update_connector = pmic_glink_ucsi_update_connector,
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 396e2090e7c3..14737ca3724c 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -359,6 +359,21 @@ static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset, void *val,
 	return 0;
 }
 
+static int ucsi_stm32g0_read_version(struct ucsi *ucsi, u16 *version)
+{
+	return ucsi_stm32g0_read(ucsi, UCSI_VERSION, version, sizeof(*version));
+}
+
+static int ucsi_stm32g0_read_cci(struct ucsi *ucsi, u32 *cci)
+{
+	return ucsi_stm32g0_read(ucsi, UCSI_CCI, cci, sizeof(*cci));
+}
+
+static int ucsi_stm32g0_read_message_in(struct ucsi *ucsi, void *val, size_t len)
+{
+	return ucsi_stm32g0_read(ucsi, UCSI_MESSAGE_IN, val, len);
+}
+
 static int ucsi_stm32g0_async_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
@@ -446,7 +461,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 }
 
 static const struct ucsi_operations ucsi_stm32g0_ops = {
-	.read = ucsi_stm32g0_read,
+	.read_version = ucsi_stm32g0_read_version,
+	.read_cci = ucsi_stm32g0_read_cci,
+	.read_message_in = ucsi_stm32g0_read_message_in,
 	.sync_control = ucsi_stm32g0_sync_control,
 	.async_control = ucsi_stm32g0_async_control,
 };
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index e5e8ba0c0eaa..95a333ad5496 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -27,8 +27,16 @@ struct yoga_c630_ucsi {
 	u16 version;
 };
 
-static int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,
-			       void *val, size_t val_len)
+static int yoga_c630_ucsi_read_version(struct ucsi *ucsi, u16 *version)
+{
+	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
+
+	*version = uec->version;
+
+	return 0;
+}
+
+static int yoga_c630_ucsi_read_cci(struct ucsi *ucsi, u32 *cci)
 {
 	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
 	u8 buf[YOGA_C630_UCSI_READ_SIZE];
@@ -38,22 +46,26 @@ static int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,
 	if (ret)
 		return ret;
 
-	if (offset == UCSI_VERSION) {
-		memcpy(val, &uec->version, min(val_len, sizeof(uec->version)));
-		return 0;
-	}
+	memcpy(cci, buf, sizeof(*cci));
 
-	switch (offset) {
-	case UCSI_CCI:
-		memcpy(val, buf, min(val_len, YOGA_C630_UCSI_CCI_SIZE));
-		return 0;
-	case UCSI_MESSAGE_IN:
-		memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
-		       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
-		return 0;
-	default:
-		return -EINVAL;
-	}
+	return 0;
+}
+
+static int yoga_c630_ucsi_read_message_in(struct ucsi *ucsi,
+					  void *val, size_t val_len)
+{
+	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
+	u8 buf[YOGA_C630_UCSI_READ_SIZE];
+	int ret;
+
+	ret = yoga_c630_ec_ucsi_read(uec->ec, buf);
+	if (ret)
+		return ret;
+
+	memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
+	       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
+
+	return 0;
 }
 
 static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
@@ -93,7 +105,9 @@ static int yoga_c630_ucsi_sync_control(struct ucsi *ucsi, u64 command)
 }
 
 const struct ucsi_operations yoga_c630_ucsi_ops = {
-	.read = yoga_c630_ucsi_read,
+	.read_version = yoga_c630_ucsi_read_version,
+	.read_cci = yoga_c630_ucsi_read_cci,
+	.read_message_in = yoga_c630_ucsi_read_message_in,
 	.sync_control = yoga_c630_ucsi_sync_control,
 	.async_control = yoga_c630_ucsi_async_control,
 };
@@ -126,7 +140,7 @@ static int yoga_c630_ucsi_notify(struct notifier_block *nb,
 		return NOTIFY_OK;
 
 	case LENOVO_EC_EVENT_UCSI:
-		ret = uec->ucsi->ops->read(uec->ucsi, UCSI_CCI, &cci, sizeof(cci));
+		ret = uec->ucsi->ops->read_cci(uec->ucsi, &cci);
 		if (ret)
 			return NOTIFY_DONE;
 

-- 
2.39.2


