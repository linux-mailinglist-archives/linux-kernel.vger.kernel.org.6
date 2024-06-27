Return-Path: <linux-kernel+bounces-232487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BDE91A991
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EFA1F25561
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2B1990CC;
	Thu, 27 Jun 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip3QDPoy"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44ED197A87
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499490; cv=none; b=rs6I2hHsUbZAe3gc0aeAbVPCbmbCPKWew5SO7PBtskgglBbgXL38oz19wRKN5LxY4bfmt+i3b3kLKZNE2GHUaOUwItffgx4eWCzsWplbIXhN04EoTLUQKwqBR4+zr2Vzm8H8R88VGMi+Wq+DIlwhHNbnya58Vz63R8aTMDR04Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499490; c=relaxed/simple;
	bh=7MwctdmVB+iJTzrgBECktp6juS2YdFsvbJpqsYqcihg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dh7ayXNmOhgJQv4000DofY32reXaSdUwBJNs8Q8yNp7Mm/Xn4DLaKKaNqGBPgPoarMvKWGKUsQIS0lAdXo+y4q8VEXsyQuKJFFQ1liHt5OVabxgCBp2zZ0rn/wPV6MQ8K/5GwygfmD1iXlCTYAza14oqYqCEXgKqBfkVYNgyGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ip3QDPoy; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so96541201fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499485; x=1720104285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xc5CJzlZcckit69hsy7iMWkzWV2hcPjFjQs+d5LaDk=;
        b=Ip3QDPoyPPaWjpo79z5zaEOAQT8Kyo3RCNrAyKqiM9Tf+tF4IsJnd56Lejca+oZZLr
         Euf4xgGs/wulhv18dQErEYuXeFMYpwt8XHM1Jg5yqKiUlSpzUo+psD1BaJtZ5L0LhoHk
         ccdiFuQEiYd8s6JaP+pp3Pr0lRmrrP+9Wn6jaX3wwXBnNc0BBh77IH00SSHLmuvGyz6R
         5j/j+UltkgYF2iaTlbsv3IZXsVAfQ8uDjB795F7NYfXMPn7KpTA+1QRnUQSHqaYz1XeM
         y8nq4/iY27l71ww939/YPDPAxpo7Hnv54g9IzNVDLCyBc+wN78nppYkOgqz0n0ei2R2i
         Kzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499485; x=1720104285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xc5CJzlZcckit69hsy7iMWkzWV2hcPjFjQs+d5LaDk=;
        b=UV5g2pQrEF8zjkHi1JsNbQU8YChA1vE9XzeCHozU/V5Au0eY53eWNuFslIU8VqwxVG
         D7v1r14xyjPQDHyLEBFtZyDbRxfdgHIJvLgV+7firY+nqMBiqEO4LC350shEvSTVRY0y
         AM9m/kkNipmk4qCguSzM0sPMnxqZBApQfla4sftLXTvc1LH3EfwXr2G3Dp94Pf1jkUOX
         4QbarF6ve3gWpnTKad0bQ+szr8dUwhR0fKQeaFkHYYSojZNuFVryAOGH5D92rMSqyMpo
         8wahCD4ZX4VoBZSEpOTKU1cb2byi6hSfEDmNmevbSSMrAAMqQE47jZ8JF11BGVdYb0CD
         y6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWN1jRHO7hqUGN0fHPB8xyuBqSQOAQ/fD9gBM8zh6pY6ahNO3e5xdIz0MXtmHYVUHUF0iu2QSFdHPRqHRgHMRT/fz5ZAMgX8ETcRw3w
X-Gm-Message-State: AOJu0YxhAkDRApHU7NpAPF3Mk2MCWBu0558878/bVMb0wGBqe0UiFuL5
	0vdivOWpWYJAMwzz6ca7PI/TpZ8JliGyQ2oo3VdDAApNNrur9jJi6YGVdGlzpTHLAOiavLUpfhO
	gdvQ=
X-Google-Smtp-Source: AGHT+IGRBJggbLJLBGfYgW/0wPx8tCJWmx0m9/7rc4DkPfbVNa85+lHHNi7nRNQtuOIb9Hu1/GYCkw==
X-Received: by 2002:a2e:9ed5:0:b0:2ec:50fa:1e47 with SMTP id 38308e7fff4ca-2ec5b2a0a1fmr87677291fa.21.1719499485331;
        Thu, 27 Jun 2024 07:44:45 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm2775911fa.11.2024.06.27.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:44:41 +0300
Subject: [PATCH v4 2/7] usb: typec: ucsi: simplify command sending API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ucsi-rework-interface-v4-2-289ddc6874c7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17396;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7MwctdmVB+iJTzrgBECktp6juS2YdFsvbJpqsYqcihg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfXrZ0OcrotJEk0yj9kOgl26Bg9OPYxvJb51oC
 vKo9XBk7kaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZn162QAKCRCLPIo+Aiko
 1ZAYB/94Sb2MnkUMGHom+70CRNc+DdhObAAyvHadRA1MAzWCCA4W8cZ21XqtktpZmvG0xvAhbGi
 iyMSgOYdpq9oqBnMQbUumxNWu8wP73KleiYUhWH0QEMpNraDuVF+ZrQi3dCdvTtmtjq7smmNdn7
 Xyt15+sfDIkgYURcfmRxKnAsJYZ2rb8b89BGTLLpFdzxhoTRRocOF7C/6D4McJrJ/E1oLyVl6qW
 F2r+J3l1/sJrcFmUWXh8fumHzLQz0AiuaGcJYSpq3nGqGFRbbr0JIUPx9EmvWkXfimUQqNPSuu6
 oaVhLzlkx8jDhvVwuvkqp9nvAljgbMTA8Ip3pI2Fr2D6wtdz
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The sync_write and async_write are used only for writing UCSI commands
to the UCSI_CONTROL offsets. Rename sync_write and async_write
operations to sync_control and async_control accordingly. Drop the
offset and length fields and pass u64 command instead.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c           | 18 +++++++----------
 drivers/usb/typec/ucsi/ucsi.h           | 10 ++++------
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 31 ++++++++++++++----------------
 drivers/usb/typec/ucsi/ucsi_ccg.c       | 34 +++++++++++++++------------------
 drivers/usb/typec/ucsi/ucsi_glink.c     | 14 ++++++--------
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 24 +++++++++++------------
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 20 +++++++------------
 7 files changed, 64 insertions(+), 87 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 651c22473472..e8172b7711c8 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -60,7 +60,7 @@ static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 		ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
 	}
 
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	return ucsi->ops->sync_control(ucsi, ctrl);
 }
 
 static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
@@ -155,7 +155,7 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 		connector_num = 0;
 	}
 
-	ret = ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
+	ret = ucsi->ops->sync_control(ucsi, cmd);
 	if (ret)
 		return ret;
 
@@ -1350,8 +1350,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 	 */
 	if (cci & UCSI_CCI_RESET_COMPLETE) {
 		command = UCSI_SET_NOTIFICATION_ENABLE;
-		ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
-					     sizeof(command));
+		ret = ucsi->ops->async_control(ucsi, command);
 		if (ret < 0)
 			goto out;
 
@@ -1372,8 +1371,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 	}
 
 	command = UCSI_PPM_RESET;
-	ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL, &command,
-				     sizeof(command));
+	ret = ucsi->ops->async_control(ucsi, command);
 	if (ret < 0)
 		goto out;
 
@@ -1394,9 +1392,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		/* If the PPM is still doing something else, reset it again. */
 		if (cci & ~UCSI_CCI_RESET_COMPLETE) {
-			ret = ucsi->ops->async_write(ucsi, UCSI_CONTROL,
-						     &command,
-						     sizeof(command));
+			ret = ucsi->ops->async_control(ucsi, command);
 			if (ret < 0)
 				goto out;
 		}
@@ -1924,7 +1920,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 {
 	struct ucsi *ucsi;
 
-	if (!ops || !ops->read || !ops->sync_write || !ops->async_write)
+	if (!ops || !ops->read || !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
@@ -2000,7 +1996,7 @@ void ucsi_unregister(struct ucsi *ucsi)
 	cancel_work_sync(&ucsi->resume_work);
 
 	/* Disable notifications */
-	ucsi->ops->async_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
+	ucsi->ops->async_control(ucsi, cmd);
 
 	if (!ucsi->connector)
 		return;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index fe95a80050d3..a8c161a39f11 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -57,8 +57,8 @@ struct dentry;
 /**
  * struct ucsi_operations - UCSI I/O operations
  * @read: Read operation
- * @sync_write: Blocking write operation
- * @async_write: Non-blocking write operation
+ * @sync_control: Blocking control operation
+ * @async_control: Non-blocking control operation
  * @update_altmodes: Squashes duplicate DP altmodes
  * @update_connector: Update connector capabilities before registering
  * @connector_status: Updates connector status, called holding connector lock
@@ -70,10 +70,8 @@ struct dentry;
 struct ucsi_operations {
 	int (*read)(struct ucsi *ucsi, unsigned int offset,
 		    void *val, size_t val_len);
-	int (*sync_write)(struct ucsi *ucsi, unsigned int offset,
-			  const void *val, size_t val_len);
-	int (*async_write)(struct ucsi *ucsi, unsigned int offset,
-			   const void *val, size_t val_len);
+	int (*sync_control)(struct ucsi *ucsi, u64 command);
+	int (*async_control)(struct ucsi *ucsi, u64 command);
 	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
 				struct ucsi_altmode *updated);
 	void (*update_connector)(struct ucsi_connector *con);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index adf32ca0f761..f54e4722d8f6 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -61,22 +61,20 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 	return 0;
 }
 
-static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
-				 const void *val, size_t val_len)
+static int ucsi_acpi_async_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 
-	memcpy(ua->base + offset, val, val_len);
-	ua->cmd = *(u64 *)val;
+	memcpy(ua->base + UCSI_CONTROL, &command, sizeof(command));
+	ua->cmd = command;
 
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
 
-static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
-				const void *val, size_t val_len)
+static int ucsi_acpi_sync_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
+	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
 	int ret;
 
 	if (ack)
@@ -84,7 +82,7 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 	else
 		set_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
 
-	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
+	ret = ucsi_acpi_async_control(ucsi, command);
 	if (ret)
 		goto out_clear_bit;
 
@@ -102,8 +100,8 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read = ucsi_acpi_read,
-	.sync_write = ucsi_acpi_sync_write,
-	.async_write = ucsi_acpi_async_write
+	.sync_control = ucsi_acpi_sync_control,
+	.async_control = ucsi_acpi_async_control
 };
 
 static int
@@ -125,8 +123,8 @@ ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_
 
 static const struct ucsi_operations ucsi_zenbook_ops = {
 	.read = ucsi_zenbook_read,
-	.sync_write = ucsi_acpi_sync_write,
-	.async_write = ucsi_acpi_async_write
+	.sync_control = ucsi_acpi_sync_control,
+	.async_control = ucsi_acpi_async_control
 };
 
 static int ucsi_gram_read(struct ucsi *ucsi, unsigned int offset,
@@ -157,13 +155,12 @@ static int ucsi_gram_read(struct ucsi *ucsi, unsigned int offset,
 	return ret;
 }
 
-static int ucsi_gram_sync_write(struct ucsi *ucsi, unsigned int offset,
-				const void *val, size_t val_len)
+static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
 
-	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
+	ret = ucsi_acpi_sync_control(ucsi, command);
 	if (ret < 0)
 		return ret;
 
@@ -177,8 +174,8 @@ static int ucsi_gram_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 static const struct ucsi_operations ucsi_gram_ops = {
 	.read = ucsi_gram_read,
-	.sync_write = ucsi_gram_sync_write,
-	.async_write = ucsi_acpi_async_write
+	.sync_control = ucsi_gram_sync_control,
+	.async_control = ucsi_acpi_async_control
 };
 
 static const struct dmi_system_id ucsi_acpi_quirks[] = {
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index dda7c7c94e08..76b39bb9762d 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -610,25 +610,23 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	return ret;
 }
 
-static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
-				const void *val, size_t val_len)
+static int ucsi_ccg_async_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
-	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
+	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_CONTROL);
 
 	/*
-	 * UCSI may read CCI instantly after async_write,
+	 * UCSI may read CCI instantly after async_control,
 	 * clear CCI to avoid caller getting wrong data before we get CCI from ISR
 	 */
 	spin_lock(&uc->op_lock);
 	uc->op_data.cci = 0;
 	spin_unlock(&uc->op_lock);
 
-	return ccg_write(uc, reg, val, val_len);
+	return ccg_write(uc, reg, (u8 *)&command, sizeof(command));
 }
 
-static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
-			       const void *val, size_t val_len)
+static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	struct ucsi_connector *con;
@@ -639,19 +637,17 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 	pm_runtime_get_sync(uc->dev);
 	set_bit(DEV_CMD_PENDING, &uc->flags);
 
-	if (offset == UCSI_CONTROL && val_len == sizeof(uc->last_cmd_sent)) {
-		uc->last_cmd_sent = *(u64 *)val;
+	uc->last_cmd_sent = command;
 
-		if (UCSI_COMMAND(uc->last_cmd_sent) == UCSI_SET_NEW_CAM &&
-		    uc->has_multiple_dp) {
-			con_index = (uc->last_cmd_sent >> 16) &
-				    UCSI_CMD_CONNECTOR_MASK;
-			con = &uc->ucsi->connector[con_index - 1];
-			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
-		}
+	if (UCSI_COMMAND(uc->last_cmd_sent) == UCSI_SET_NEW_CAM &&
+	    uc->has_multiple_dp) {
+		con_index = (uc->last_cmd_sent >> 16) &
+			UCSI_CMD_CONNECTOR_MASK;
+		con = &uc->ucsi->connector[con_index - 1];
+		ucsi_ccg_update_set_new_cam_cmd(uc, con, &command);
 	}
 
-	ret = ucsi_ccg_async_write(ucsi, offset, val, val_len);
+	ret = ucsi_ccg_async_control(ucsi, command);
 	if (ret)
 		goto err_clear_bit;
 
@@ -668,8 +664,8 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 static const struct ucsi_operations ucsi_ccg_ops = {
 	.read = ucsi_ccg_read,
-	.sync_write = ucsi_ccg_sync_write,
-	.async_write = ucsi_ccg_async_write,
+	.sync_control = ucsi_ccg_sync_control,
+	.async_control = ucsi_ccg_async_control,
 	.update_altmodes = ucsi_ccg_update_altmodes
 };
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 2fa973afe4e6..ebd76257c4fc 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -143,21 +143,19 @@ static int pmic_glink_ucsi_locked_write(struct pmic_glink_ucsi *ucsi, unsigned i
 	return 0;
 }
 
-static int pmic_glink_ucsi_async_write(struct ucsi *__ucsi, unsigned int offset,
-				       const void *val, size_t val_len)
+static int pmic_glink_ucsi_async_control(struct ucsi *__ucsi, u64 command)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
 	int ret;
 
 	mutex_lock(&ucsi->lock);
-	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
+	ret = pmic_glink_ucsi_locked_write(ucsi, UCSI_CONTROL, &command, sizeof(command));
 	mutex_unlock(&ucsi->lock);
 
 	return ret;
 }
 
-static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
-				      const void *val, size_t val_len)
+static int pmic_glink_ucsi_sync_control(struct ucsi *__ucsi, u64 command)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
 	unsigned long left;
@@ -169,7 +167,7 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
 	ucsi->sync_val = 0;
 	reinit_completion(&ucsi->sync_ack);
 	ucsi->sync_pending = true;
-	ret = pmic_glink_ucsi_locked_write(ucsi, offset, val, val_len);
+	ret = pmic_glink_ucsi_locked_write(ucsi, UCSI_CONTROL, &command, sizeof(command));
 	mutex_unlock(&ucsi->lock);
 
 	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
@@ -217,8 +215,8 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read = pmic_glink_ucsi_read,
-	.sync_write = pmic_glink_ucsi_sync_write,
-	.async_write = pmic_glink_ucsi_async_write,
+	.sync_control = pmic_glink_ucsi_sync_control,
+	.async_control = pmic_glink_ucsi_async_control,
 	.update_connector = pmic_glink_ucsi_update_connector,
 	.connector_status = pmic_glink_ucsi_connector_status,
 };
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index ac69288e8bb0..396e2090e7c3 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -359,8 +359,7 @@ static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset, void *val,
 	return 0;
 }
 
-static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, const void *val,
-				    size_t len)
+static int ucsi_stm32g0_async_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
 	struct i2c_client *client = g0->client;
@@ -373,19 +372,19 @@ static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, cons
 	unsigned char *buf;
 	int ret;
 
-	buf = kmalloc(len + 1, GFP_KERNEL);
+	buf = kmalloc(sizeof(command) + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	buf[0] = offset;
-	memcpy(&buf[1], val, len);
-	msg[0].len = len + 1;
+	buf[0] = UCSI_CONTROL;
+	memcpy(&buf[1], &command, sizeof(command));
+	msg[0].len = sizeof(command) + 1;
 	msg[0].buf = buf;
 
 	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
 	kfree(buf);
 	if (ret != ARRAY_SIZE(msg)) {
-		dev_err(g0->dev, "i2c write %02x, %02x error: %d\n", client->addr, offset, ret);
+		dev_err(g0->dev, "i2c write %02x, %02x error: %d\n", client->addr, UCSI_CONTROL, ret);
 
 		return ret < 0 ? ret : -EIO;
 	}
@@ -393,11 +392,10 @@ static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, cons
 	return 0;
 }
 
-static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const void *val,
-				   size_t len)
+static int ucsi_stm32g0_sync_control(struct ucsi *ucsi, u64 command)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
+	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
 	int ret;
 
 	if (ack)
@@ -405,7 +403,7 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 	else
 		set_bit(COMMAND_PENDING, &g0->flags);
 
-	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
+	ret = ucsi_stm32g0_async_control(ucsi, command);
 	if (ret)
 		goto out_clear_bit;
 
@@ -449,8 +447,8 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 
 static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.read = ucsi_stm32g0_read,
-	.sync_write = ucsi_stm32g0_sync_write,
-	.async_write = ucsi_stm32g0_async_write,
+	.sync_control = ucsi_stm32g0_sync_control,
+	.async_control = ucsi_stm32g0_async_control,
 };
 
 static int ucsi_stm32g0_register(struct ucsi *ucsi)
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index 8bee0b469041..e5e8ba0c0eaa 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -56,23 +56,17 @@ static int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,
 	}
 }
 
-static int yoga_c630_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
-				      const void *val, size_t val_len)
+static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
 {
 	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
 
-	if (offset != UCSI_CONTROL ||
-	    val_len != YOGA_C630_UCSI_WRITE_SIZE)
-		return -EINVAL;
-
-	return yoga_c630_ec_ucsi_write(uec->ec, val);
+	return yoga_c630_ec_ucsi_write(uec->ec, (u8*)&command);
 }
 
-static int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
-				     const void *val, size_t val_len)
+static int yoga_c630_ucsi_sync_control(struct ucsi *ucsi, u64 command)
 {
 	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
+	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
 	int ret;
 
 	if (ack)
@@ -82,7 +76,7 @@ static int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 	reinit_completion(&uec->complete);
 
-	ret = yoga_c630_ucsi_async_write(ucsi, offset, val, val_len);
+	ret = yoga_c630_ucsi_async_control(ucsi, command);
 	if (ret)
 		goto out_clear_bit;
 
@@ -100,8 +94,8 @@ static int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read = yoga_c630_ucsi_read,
-	.sync_write = yoga_c630_ucsi_sync_write,
-	.async_write = yoga_c630_ucsi_async_write,
+	.sync_control = yoga_c630_ucsi_sync_control,
+	.async_control = yoga_c630_ucsi_async_control,
 };
 
 static void yoga_c630_ucsi_notify_ucsi(struct yoga_c630_ucsi *uec, u32 cci)

-- 
2.39.2


