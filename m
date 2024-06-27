Return-Path: <linux-kernel+bounces-232488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9A91A995
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2911F25342
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588241990D1;
	Thu, 27 Jun 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCyROD7U"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BF197A9D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499490; cv=none; b=lN46sEGGnp+X3nZBMAUlTi0TgORuDUt99rk2mD1eMY4sHOYGtVvA70q7SKni68vASbR300LFB7PN/tukSwOCjiOie52/z2QlSg8wcSvXUHt1RuXyCPTrRsAqE7gkbDW0Hmq+/5UaK5uy8eoaXGPZjKK3MLJPcTG/jhf59kdXGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499490; c=relaxed/simple;
	bh=ngrfxb9LgQo60Yk99ph8ipR6eAAXUwAD0pFIgQOxGvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hmFAzMZz/WIU/OpA6/hyR7hlSYEJiU1AgpQrdy0ciP5NxtrLPoagfR6+SZt7bUnlP6/JiT2+MYJHkK2cJ7EX0vfGBr8ZYv1kwRHXc8KQr7CYhH/nfUChtqFxWgadao/rbLLHJOBUlY+VVeLSFxF5RYsAEuLHMmEuLpQDe8leO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCyROD7U; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so89985851fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499486; x=1720104286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UghCq0if0rPxKzwOGOdd2hJL8Uwk9IwhUB+0hzFweFk=;
        b=SCyROD7UbYNQgOabU0na0tuDA53hqcwFyEy20Y7KzSRi+qlCMh1NY6cvtZA+gd7qhh
         ECVtx4V0bXyH9FeBWeJbtuDKJ9Jm0sRcanzFq25awvqrdmAF3rRQav7ZBEzzFwuI7cgU
         gmK6W0dshqBfyIyZG8m1yVAR2yQQkmuF+SheESXhFgvgOFCCiyaBFFGFlgZ0ciqbBvNb
         5tJyE2Y5SeEo73fWRen29mE38wSMXm8xBF3FgE/6AXykqaPNR+w/jTs9CJeLrP9KMRIX
         CVdC5lTuNi1ESLphxy92OBwDvASNBfFgO+diIUBtMGeHeCCkpdbwPCrsW2Fso6+0gfiO
         JY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499486; x=1720104286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UghCq0if0rPxKzwOGOdd2hJL8Uwk9IwhUB+0hzFweFk=;
        b=DQtoM1zWJX2CZyWDVuE0nO8+1wCgopn7wz4M6O+FZt37DktuHMkWBVkfZ1S3j0+5kp
         pA3nst+6s0JWwH8DLIK1/AUaWjQFFNJIoSJIo4fT9Ufb9j3s7uYknCfIqK0glBaAKUmw
         8WmzYi/hvbZ6VCLJAF/6hlct/2Gi+8Lcyb3FxIpFRWwoQXsrnFa6v1A7G0/7IOm5tmqw
         jfYQi/RyYJIvAGTKz/o/5RoSX/jOTEXcRh/vdLF0rWVRn5ri2V9/+n5M7gfu8yIbwZo1
         GT9ZgVaHeEMbk1RZcJPDEF+rgoKIJkDQPqXeyqwYw/0THT0YeYqxGAQ50/qSNJCmLJCZ
         2Pew==
X-Forwarded-Encrypted: i=1; AJvYcCV6zVxoCwk0GrWKkAfb8O+6V4QNb2ZOHme01YqzaqcTzzXNC+9kl0xQ/84to1dDucqrGwB80Z8XAjf/ZJiveTCmW9tl5E+Be6GOs0v3
X-Gm-Message-State: AOJu0YxBNIl1CxXG9hqPdCVN9ur3oqcFLExn/gwljTKYKA/bM9JP9izv
	6HY46fZybme3McXsj0u8VW4rprNMhjP56PdUwpTxJVRUxBdGQAANzKclvIeYb36KW4GDhlkyB3l
	QiwM=
X-Google-Smtp-Source: AGHT+IFsshOXCXHl2FwpJZDr74IVz6qa4XzpSU8GVhBvy+WZyILZMJdKv/yipLbEuWVS+aB9wtcpOA==
X-Received: by 2002:a2e:7c03:0:b0:2ec:4aac:8fd6 with SMTP id 38308e7fff4ca-2ec5b36b940mr85306941fa.10.1719499486053;
        Thu, 27 Jun 2024 07:44:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm2775911fa.11.2024.06.27.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:44:42 +0300
Subject: [PATCH v4 3/7] usb: typec: ucsi: split read operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ucsi-rework-interface-v4-3-289ddc6874c7@linaro.org>
References: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
In-Reply-To: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17090;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ngrfxb9LgQo60Yk99ph8ipR6eAAXUwAD0pFIgQOxGvs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfXrZCfhNE5yevor8AbbbZlfy46bcJny6xgLVy
 cgpuUMp3a6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZn162QAKCRCLPIo+Aiko
 1fgGB/47D94ko774U9MqWLJY7Ou/4dkmzpzrKWfS8mEh5jMI9+OVaoc+25I05KAh6jjT/5SlysK
 aV5BQ+c1XDuhDsbIf83kPUW12xQ40NT0JhKbkmCfyx6ulqt/XD9hdrXGZy2VPcZTNl3Qg0iv23D
 GSxEdrGhgbNeV+SMrtPPXaC0WUW7kptY+bU80RrbIn/Y0mu5l49TFWdLU6OrP7gMl/+9t1ckW8y
 pv1mpw7zbXQct0FtUd7zFmYETBB00tjiDtGy9+wlETEk8cCwR0ZJ4Az74HsEn+V9RrphD5C4Qg7
 rPnMmY0457Mcs8IFa5iFec1G1iAdBZY1SmTGFKtff5iRwuUA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The read operation is only used to read fixed data at fixed offsets
(UCSI_VERSION, UCSI_CCI, UCSI_MESSAGE_IN). In some cases drivers apply
offset-specific overrides. Split the read() operation into three
operations, read_version(), read_cci(), read_message_in().

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c           | 20 ++++-----
 drivers/usb/typec/ucsi/ucsi.h           |  9 +++--
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 72 ++++++++++++++++++++++++++-------
 drivers/usb/typec/ucsi/ucsi_ccg.c       | 50 ++++++++++++-----------
 drivers/usb/typec/ucsi/ucsi_glink.c     | 19 ++++++++-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 19 ++++++++-
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 +++++++++++++++---------
 7 files changed, 169 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index e8172b7711c8..17d12c1872f6 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -46,7 +46,7 @@ static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
 	if (ucsi->version <= UCSI_VERSION_1_2)
 		buf_size = clamp(buf_size, 0, 16);
 
-	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
+	return ucsi->ops->read_message_in(ucsi, buf, buf_size);
 }
 
 static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
@@ -159,7 +159,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (ret)
 		return ret;
 
-	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ucsi->ops->read_cci(ucsi, &cci);
 	if (ret)
 		return ret;
 
@@ -1338,7 +1338,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ucsi->ops->read_cci(ucsi, &cci);
 	if (ret < 0)
 		goto out;
 
@@ -1356,8 +1356,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
 		do {
-			ret = ucsi->ops->read(ucsi, UCSI_CCI,
-					      &cci, sizeof(cci));
+			ret = ucsi->ops->read_cci(ucsi, &cci);
 			if (ret < 0)
 				goto out;
 			if (cci & UCSI_CCI_COMMAND_COMPLETE)
@@ -1386,7 +1385,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 		/* Give the PPM time to process a reset before reading CCI */
 		msleep(20);
 
-		ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+		ret = ucsi->ops->read_cci(ucsi, &cci);
 		if (ret)
 			goto out;
 
@@ -1806,7 +1805,7 @@ static int ucsi_init(struct ucsi *ucsi)
 	ucsi->ntfy = ntfy;
 
 	mutex_lock(&ucsi->ppm_lock);
-	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ucsi->ops->read_cci(ucsi, &cci);
 	mutex_unlock(&ucsi->ppm_lock);
 	if (ret)
 		return ret;
@@ -1920,7 +1919,9 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 {
 	struct ucsi *ucsi;
 
-	if (!ops || !ops->read || !ops->sync_control || !ops->async_control)
+	if (!ops ||
+	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
+	    !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
@@ -1956,8 +1957,7 @@ int ucsi_register(struct ucsi *ucsi)
 {
 	int ret;
 
-	ret = ucsi->ops->read(ucsi, UCSI_VERSION, &ucsi->version,
-			      sizeof(ucsi->version));
+	ret = ucsi->ops->read_version(ucsi, &ucsi->version);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index a8c161a39f11..2560e144e158 100644
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
index f54e4722d8f6..3660dc3e6d32 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -46,8 +46,7 @@ static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
 	return 0;
 }
 
-static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
-			  void *val, size_t val_len)
+static int ucsi_acpi_read_version(struct ucsi *ucsi, u16 *version)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
@@ -56,7 +55,35 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
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
@@ -99,36 +126,50 @@ static int ucsi_acpi_sync_control(struct ucsi *ucsi, u64 command)
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
 
-static int ucsi_gram_read(struct ucsi *ucsi, unsigned int offset,
-			  void *val, size_t val_len)
+static int ucsi_gram_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	u16 bogus_change = UCSI_CONSTAT_POWER_LEVEL_CHANGE |
 			   UCSI_CONSTAT_PDOS_CHANGE;
@@ -136,13 +177,12 @@ static int ucsi_gram_read(struct ucsi *ucsi, unsigned int offset,
 	struct ucsi_connector_status *status;
 	int ret;
 
-	ret = ucsi_acpi_read(ucsi, offset, val, val_len);
+	ret = ucsi_acpi_read_message_in(ucsi, val, val_len);
 	if (ret < 0)
 		return ret;
 
 	if (UCSI_COMMAND(ua->cmd) == UCSI_GET_CONNECTOR_STATUS &&
-	    test_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags) &&
-	    offset == UCSI_MESSAGE_IN) {
+	    test_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags)) {
 		status = (struct ucsi_connector_status *)val;
 
 		/* Clear the bogus change */
@@ -173,7 +213,9 @@ static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
 }
 
 static const struct ucsi_operations ucsi_gram_ops = {
-	.read = ucsi_gram_read,
+	.read_version = ucsi_acpi_read_version,
+	.read_cci = ucsi_acpi_read_cci,
+	.read_message_in = ucsi_gram_read_message_in,
 	.sync_control = ucsi_gram_sync_control,
 	.async_control = ucsi_acpi_async_control
 };
@@ -203,7 +245,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
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
index ebd76257c4fc..56bad054e78f 100644
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


