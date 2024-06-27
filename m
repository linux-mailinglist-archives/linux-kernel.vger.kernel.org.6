Return-Path: <linux-kernel+bounces-232492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257991A99D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BC41C21F64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FE719939A;
	Thu, 27 Jun 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsAOsFuM"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9D198E63
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499493; cv=none; b=at+ReeADHflky28rUKgpfUdvijbPswjar3GDnlmFH+YMxQC6k7QrWK+G+iY5TJSG7h/GIBeL+De5zPclXI6j5Zsp8kuwiK9zh8YK7ipu54xJDgGnPJIi7anObcu9vZ7PV+t0Og56GUcYIflTg3sJq8WFqMwblJvrm1NrTIQMx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499493; c=relaxed/simple;
	bh=1J+2LdyyVLafDrHe8LpC5Gnoz1i0ukS2WsUPaS+h1Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpjsVimRoo3F55/FSRuiOt7xYTZky7fGjE7690jFQAGcMXlEBmGhWriQZWIjnyteuq3NCCaRfQmS8BFS4MYcj+cuxrfJ/L1z22dGwiqA0XCsF8CLXi7O5ZJezRo0Hz542ZgaL31AzUYD82ftm5PSzTnVh8sVhW46RjTnfsZlqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MsAOsFuM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso7792751e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499489; x=1720104289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNtBr7H/4KEA0lX1DXTpcBNEvKkptuFVb7g1QTFBXKE=;
        b=MsAOsFuMsTcJ8Bxfj0q0xmNvbmrg2+78Gk5w607WzIzxv+9a3iEZUUoK+Yp6G1wgBf
         u3Q1B4DUQeFFbfqAD58Q7YR6hIRlLNJ1Y9iU20t4LdiEDEx+aRnxKAQau5XQI4kSiED0
         Vvrhs1H4oqHqqD9bOIbaSX3/Mr9T5n5uBdFj1d0UrYFLI0a1p3D07XI3+BXwK9Ld/ete
         VnggmG5jbLJAF4o6fQyH3rfjBW3fStMJZ71gBTJT57eHfcwd2UpTtX9/PLcdl1WcCoNd
         fBblTcUVH6xfIl6eT4Qp8sgveLQ25FHhVFkkNxn2bI/gmcNkkrgwHSQDSz5OWp2iyAsc
         87ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499489; x=1720104289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNtBr7H/4KEA0lX1DXTpcBNEvKkptuFVb7g1QTFBXKE=;
        b=xFpwJGw+6n0Gfdx++VoYDND1DcFkisjNZgKDRjbHPuT9h22AsZzNb2/b+G3s1TdQCQ
         FX0IcOPZYsmlJt44kKVHqVBAOh1l+CtTYBzqOI6bssJbbHZR/3EWZuagm8G/IsQkhckV
         L+GNujR0fGcn8COGIg8gsONt0XoDWipizictMFXxHSa7HVFZE6KiRWi/vCUtvtO8t5gd
         Apy2NkJOO3OVDWaD3S9sIAmo9OGnq9DQzc+RjjAijfAph7nHTqUOMd8GugCmNr4QAKyu
         2n/9qhJ9YRXw3j71ttb4aioBaQZx82pFFJwtGk1Yl82Ot0g0193tdgAO97Xmlb+MvbSp
         U/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1kGehQNzW9AKflZ/h5TPDLCKGG89VvnlLz3TbmMJMAVXQy/xykhjIU+R6jaMdcfbgL/PClPCZ+uvhgQEHb9NN77s+XZhtV9XKvJMs
X-Gm-Message-State: AOJu0YxuW2kZnYPqe7U+qw/YafWcs72N44v0soaKUPHEYcrPtJ+Owl4U
	HTp15ZIb8IXqiyyqETKZ58w0CB22A+L1Z6IvjJdc5nUj6Ph8q8SwOclr/ftJsZ7t48QFsMyOdKI
	UNrI=
X-Google-Smtp-Source: AGHT+IG/vhBiPKr5H4VT6VZmk2uUGM/u22Kql0wRoMQv2jlBGgqfEGeeogNI1eT58eYyoTwcxeXGpA==
X-Received: by 2002:a2e:b616:0:b0:2ee:4eb8:2f15 with SMTP id 38308e7fff4ca-2ee4eb83097mr3650321fa.29.1719499488733;
        Thu, 27 Jun 2024 07:44:48 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm2775911fa.11.2024.06.27.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:44:45 +0300
Subject: [PATCH v4 6/7] usb: typec: ucsi: extract common code for command
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ucsi-rework-interface-v4-6-289ddc6874c7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18771;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1J+2LdyyVLafDrHe8LpC5Gnoz1i0ukS2WsUPaS+h1Z4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1pt1U3TR/xqks+dehgSe+1eTzHbEH7jZnEG/8TUT6173
 jpKuyZ0MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiRjs4GPqc5X5cCDIwuK+y
 rf3DoaywuvyoYvGL3/mzWm9/ye6KfNoebRrbKNabmsm9622qkcw5RrZrHw8ERE2qCn7/zM3he4f
 70gM+DPdn+HPPauW9IrF9TeHHc3918923N+SoxesyevJobGpmfRyRc+DevuwXa+IWVyqdW/wurr
 outez1RRN+12prlvVbn6T1/73x76LM7FAhxR0djBwWx62/mhjwVvyP8DjusPhDa9MBNVGxT7nLb
 ewfZq3m35bu/Sb4zuQDLMuP3L6TrbzjbQdXwyPetRIHH7cm/y+3e1ayt2zp2fWxTKdO7asufr+k
 YEtdwCpBpY+GroWx5RdquXYKH8hxC5ZdZadvt+/T+Zs3AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Extract common functions to handle command sending and to handle events
from UCSI. This ensures that all UCSI glue drivers handle the ACKs in
the same way.

The CCG driver used DEV_CMD_PENDING both for internal
firmware-related commands and for UCSI control handling. Leave the
former use case intact.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c           | 43 +++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h           |  7 +++++
 drivers/usb/typec/ucsi/ucsi_acpi.c      | 56 +++++----------------------------
 drivers/usb/typec/ucsi/ucsi_ccg.c       | 21 ++-----------
 drivers/usb/typec/ucsi/ucsi_glink.c     | 47 ++-------------------------
 drivers/usb/typec/ucsi/ucsi_stm32g0.c   | 44 ++------------------------
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 52 ++----------------------------
 7 files changed, 67 insertions(+), 203 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2d87fe277c62..25d2ee5ee8bb 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,6 +36,48 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
+void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
+{
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+
+	if (cci & UCSI_CCI_ACK_COMPLETE &&
+	    test_bit(ACK_PENDING, &ucsi->flags))
+		complete(&ucsi->complete);
+
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(COMMAND_PENDING, &ucsi->flags))
+		complete(&ucsi->complete);
+}
+EXPORT_SYMBOL_GPL(ucsi_notify_common);
+
+int ucsi_sync_control_common(struct ucsi *ucsi, u64 command)
+{
+	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
+	int ret;
+
+	if (ack)
+		set_bit(ACK_PENDING, &ucsi->flags);
+	else
+		set_bit(COMMAND_PENDING, &ucsi->flags);
+
+	ret = ucsi->ops->async_control(ucsi, command);
+	if (ret)
+		goto out_clear_bit;
+
+	if (!wait_for_completion_timeout(&ucsi->complete, 5 * HZ))
+		ret = -ETIMEDOUT;
+
+out_clear_bit:
+	if (ack)
+		clear_bit(ACK_PENDING, &ucsi->flags);
+	else
+		clear_bit(COMMAND_PENDING, &ucsi->flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ucsi_sync_control_common);
+
 static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
@@ -1919,6 +1961,7 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	INIT_WORK(&ucsi->resume_work, ucsi_resume_work);
 	INIT_DELAYED_WORK(&ucsi->work, ucsi_init_work);
 	mutex_init(&ucsi->ppm_lock);
+	init_completion(&ucsi->complete);
 	ucsi->dev = dev;
 	ucsi->ops = ops;
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 2560e144e158..57129f3c0814 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -4,6 +4,7 @@
 #define __DRIVER_USB_TYPEC_UCSI_H
 
 #include <linux/bitops.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/power_supply.h>
 #include <linux/types.h>
@@ -425,6 +426,9 @@ struct ucsi {
 	/* PPM communication flags */
 	unsigned long flags;
 #define EVENT_PENDING	0
+#define COMMAND_PENDING	1
+#define ACK_PENDING	2
+	struct completion complete;
 
 	unsigned long quirks;
 #define UCSI_NO_PARTNER_PDOS	BIT(0)	/* Don't read partner's PDOs */
@@ -489,6 +493,9 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 void ucsi_altmode_update_active(struct ucsi_connector *con);
 int ucsi_resume(struct ucsi *ucsi);
 
+void ucsi_notify_common(struct ucsi *ucsi, u32 cci);
+int ucsi_sync_control_common(struct ucsi *ucsi, u64 command);
+
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 int ucsi_register_port_psy(struct ucsi_connector *con);
 void ucsi_unregister_port_psy(struct ucsi_connector *con);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 3660dc3e6d32..7a5dff8d9cc6 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -21,11 +21,7 @@ struct ucsi_acpi {
 	struct device *dev;
 	struct ucsi *ucsi;
 	void *base;
-	struct completion complete;
-	unsigned long flags;
-#define UCSI_ACPI_COMMAND_PENDING	1
-#define UCSI_ACPI_ACK_PENDING		2
-#define UCSI_ACPI_CHECK_BOGUS_EVENT	3
+	bool check_bogus_event;
 	guid_t guid;
 	u64 cmd;
 };
@@ -98,38 +94,11 @@ static int ucsi_acpi_async_control(struct ucsi *ucsi, u64 command)
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
 
-static int ucsi_acpi_sync_control(struct ucsi *ucsi, u64 command)
-{
-	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
-	int ret;
-
-	if (ack)
-		set_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
-	else
-		set_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
-
-	ret = ucsi_acpi_async_control(ucsi, command);
-	if (ret)
-		goto out_clear_bit;
-
-	if (!wait_for_completion_timeout(&ua->complete, 5 * HZ))
-		ret = -ETIMEDOUT;
-
-out_clear_bit:
-	if (ack)
-		clear_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
-	else
-		clear_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
-
-	return ret;
-}
-
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
 	.read_message_in = ucsi_acpi_read_message_in,
-	.sync_control = ucsi_acpi_sync_control,
+	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_acpi_async_control
 };
 
@@ -165,7 +134,7 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_zenbook_read_cci,
 	.read_message_in = ucsi_zenbook_read_message_in,
-	.sync_control = ucsi_acpi_sync_control,
+	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_acpi_async_control
 };
 
@@ -182,14 +151,14 @@ static int ucsi_gram_read_message_in(struct ucsi *ucsi, void *val, size_t val_le
 		return ret;
 
 	if (UCSI_COMMAND(ua->cmd) == UCSI_GET_CONNECTOR_STATUS &&
-	    test_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags)) {
+	    ua->check_bogus_event) {
 		status = (struct ucsi_connector_status *)val;
 
 		/* Clear the bogus change */
 		if (status->change == bogus_change)
 			status->change = 0;
 
-		clear_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags);
+		ua->check_bogus_event = false;
 	}
 
 	return ret;
@@ -200,14 +169,14 @@ static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
 
-	ret = ucsi_acpi_sync_control(ucsi, command);
+	ret = ucsi_sync_control_common(ucsi, command);
 	if (ret < 0)
 		return ret;
 
 	if (UCSI_COMMAND(ua->cmd) == UCSI_GET_PDOS &&
 	    ua->cmd & UCSI_GET_PDOS_PARTNER_PDO(1) &&
 	    ua->cmd & UCSI_GET_PDOS_SRC_PDOS)
-		set_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags);
+		ua->check_bogus_event = true;
 
 	return ret;
 }
@@ -249,15 +218,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (ret)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
-
-	if (cci & UCSI_CCI_ACK_COMPLETE &&
-	    test_bit(UCSI_ACPI_ACK_PENDING, &ua->flags))
-		complete(&ua->complete);
-	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
-		complete(&ua->complete);
+	ucsi_notify_common(ua->ucsi, cci);
 }
 
 static int ucsi_acpi_probe(struct platform_device *pdev)
@@ -291,7 +252,6 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
 	id = dmi_first_match(ucsi_acpi_quirks);
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 6ccc394f268e..ba4db2310a05 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -222,8 +222,6 @@ struct ucsi_ccg {
 	u16 fw_build;
 	struct work_struct pm_work;
 
-	struct completion complete;
-
 	u64 last_cmd_sent;
 	bool has_multiple_dp;
 	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
@@ -637,7 +635,6 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 
 	mutex_lock(&uc->lock);
 	pm_runtime_get_sync(uc->dev);
-	set_bit(DEV_CMD_PENDING, &uc->flags);
 
 	uc->last_cmd_sent = command;
 
@@ -649,15 +646,8 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 		ucsi_ccg_update_set_new_cam_cmd(uc, con, &command);
 	}
 
-	ret = ucsi_ccg_async_control(ucsi, command);
-	if (ret)
-		goto err_clear_bit;
-
-	if (!wait_for_completion_timeout(&uc->complete, msecs_to_jiffies(5000)))
-		ret = -ETIMEDOUT;
+	ret = ucsi_sync_control_common(ucsi, command);
 
-err_clear_bit:
-	clear_bit(DEV_CMD_PENDING, &uc->flags);
 	pm_runtime_put_sync(uc->dev);
 	mutex_unlock(&uc->lock);
 
@@ -694,9 +684,6 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	if (ret)
 		goto err_clear_irq;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
-
 	/*
 	 * As per CCGx UCSI interface guide, copy CCI and MESSAGE_IN
 	 * to the OpRegion before clear the UCSI interrupt
@@ -708,9 +695,8 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 err_clear_irq:
 	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 
-	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
-		complete(&uc->complete);
+	if (!ret)
+		ucsi_notify_common(uc->ucsi, cci);
 
 	return IRQ_HANDLED;
 }
@@ -1429,7 +1415,6 @@ static int ucsi_ccg_probe(struct i2c_client *client)
 	uc->client = client;
 	uc->irq = client->irq;
 	mutex_init(&uc->lock);
-	init_completion(&uc->complete);
 	INIT_WORK(&uc->work, ccg_update_firmware);
 	INIT_WORK(&uc->pm_work, ccg_pm_workaround_work);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 56bad054e78f..16c328497e0b 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -64,12 +64,8 @@ struct pmic_glink_ucsi {
 	struct ucsi *ucsi;
 	struct completion read_ack;
 	struct completion write_ack;
-	struct completion sync_ack;
-	bool sync_pending;
 	struct mutex lock;	/* protects concurrent access to PMIC Glink interface */
 
-	int sync_val;
-
 	struct work_struct notify_work;
 	struct work_struct register_work;
 
@@ -170,35 +166,6 @@ static int pmic_glink_ucsi_async_control(struct ucsi *__ucsi, u64 command)
 	return ret;
 }
 
-static int pmic_glink_ucsi_sync_control(struct ucsi *__ucsi, u64 command)
-{
-	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(__ucsi);
-	unsigned long left;
-	int ret;
-
-	/* TOFIX: Downstream forces recipient to CON when UCSI_GET_ALTERNATE_MODES command */
-
-	mutex_lock(&ucsi->lock);
-	ucsi->sync_val = 0;
-	reinit_completion(&ucsi->sync_ack);
-	ucsi->sync_pending = true;
-	ret = pmic_glink_ucsi_locked_write(ucsi, UCSI_CONTROL, &command, sizeof(command));
-	mutex_unlock(&ucsi->lock);
-
-	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
-	if (!left) {
-		dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
-		/* return 0 here and let core UCSI code handle the CCI_BUSY */
-		ret = 0;
-	} else if (ucsi->sync_val) {
-		dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
-	}
-
-	ucsi->sync_pending = false;
-
-	return ret;
-}
-
 static void pmic_glink_ucsi_update_connector(struct ucsi_connector *con)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
@@ -232,7 +199,7 @@ static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read_version = pmic_glink_ucsi_read_version,
 	.read_cci = pmic_glink_ucsi_read_cci,
 	.read_message_in = pmic_glink_ucsi_read_message_in,
-	.sync_control = pmic_glink_ucsi_sync_control,
+	.sync_control = ucsi_sync_control_common,
 	.async_control = pmic_glink_ucsi_async_control,
 	.update_connector = pmic_glink_ucsi_update_connector,
 	.connector_status = pmic_glink_ucsi_connector_status,
@@ -256,14 +223,12 @@ static void pmic_glink_ucsi_write_ack(struct pmic_glink_ucsi *ucsi, const void *
 	if (resp->ret_code)
 		return;
 
-	ucsi->sync_val = resp->ret_code;
 	complete(&ucsi->write_ack);
 }
 
 static void pmic_glink_ucsi_notify(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, notify_work);
-	unsigned int con_num;
 	u32 cci;
 	int ret;
 
@@ -273,14 +238,7 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 		return;
 	}
 
-	con_num = UCSI_CCI_CONNECTOR(cci);
-	if (con_num)
-		ucsi_connector_change(ucsi->ucsi, con_num);
-
-	if (ucsi->sync_pending &&
-		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
-		complete(&ucsi->sync_ack);
-	}
+	ucsi_notify_common(ucsi->ucsi, cci);
 }
 
 static void pmic_glink_ucsi_register(struct work_struct *work)
@@ -362,7 +320,6 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
 	init_completion(&ucsi->read_ack);
 	init_completion(&ucsi->write_ack);
-	init_completion(&ucsi->sync_ack);
 	mutex_init(&ucsi->lock);
 
 	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 14737ca3724c..d948c3f579e1 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -61,11 +61,7 @@ struct ucsi_stm32g0 {
 	struct i2c_client *i2c_bl;
 	bool in_bootloader;
 	u8 bl_version;
-	struct completion complete;
 	struct device *dev;
-	unsigned long flags;
-#define COMMAND_PENDING	1
-#define ACK_PENDING	2
 	const char *fw_name;
 	struct ucsi *ucsi;
 	bool suspended;
@@ -407,35 +403,6 @@ static int ucsi_stm32g0_async_control(struct ucsi *ucsi, u64 command)
 	return 0;
 }
 
-static int ucsi_stm32g0_sync_control(struct ucsi *ucsi, u64 command)
-{
-	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
-	int ret;
-
-	if (ack)
-		set_bit(ACK_PENDING, &g0->flags);
-	else
-		set_bit(COMMAND_PENDING, &g0->flags);
-
-	ret = ucsi_stm32g0_async_control(ucsi, command);
-	if (ret)
-		goto out_clear_bit;
-
-	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
-		ret = -ETIMEDOUT;
-	else
-		return 0;
-
-out_clear_bit:
-	if (ack)
-		clear_bit(ACK_PENDING, &g0->flags);
-	else
-		clear_bit(COMMAND_PENDING, &g0->flags);
-
-	return ret;
-}
-
 static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 {
 	struct ucsi_stm32g0 *g0 = data;
@@ -449,13 +416,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 	if (ret)
 		return IRQ_NONE;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
-
-	if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
-		complete(&g0->complete);
-	if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
-		complete(&g0->complete);
+	ucsi_notify_common(g0->ucsi, cci);
 
 	return IRQ_HANDLED;
 }
@@ -464,7 +425,7 @@ static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.read_version = ucsi_stm32g0_read_version,
 	.read_cci = ucsi_stm32g0_read_cci,
 	.read_message_in = ucsi_stm32g0_read_message_in,
-	.sync_control = ucsi_stm32g0_sync_control,
+	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_stm32g0_async_control,
 };
 
@@ -665,7 +626,6 @@ static int ucsi_stm32g0_probe(struct i2c_client *client)
 
 	g0->dev = dev;
 	g0->client = client;
-	init_completion(&g0->complete);
 	i2c_set_clientdata(client, g0);
 
 	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops);
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index 95a333ad5496..f3a5e24ea84d 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -20,10 +20,6 @@ struct yoga_c630_ucsi {
 	struct yoga_c630_ec *ec;
 	struct ucsi *ucsi;
 	struct notifier_block nb;
-	struct completion complete;
-	unsigned long flags;
-#define UCSI_C630_COMMAND_PENDING	0
-#define UCSI_C630_ACK_PENDING		1
 	u16 version;
 };
 
@@ -75,57 +71,14 @@ static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
 	return yoga_c630_ec_ucsi_write(uec->ec, (u8*)&command);
 }
 
-static int yoga_c630_ucsi_sync_control(struct ucsi *ucsi, u64 command)
-{
-	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
-	bool ack = UCSI_COMMAND(command) == UCSI_ACK_CC_CI;
-	int ret;
-
-	if (ack)
-		set_bit(UCSI_C630_ACK_PENDING, &uec->flags);
-	else
-		set_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
-
-	reinit_completion(&uec->complete);
-
-	ret = yoga_c630_ucsi_async_control(ucsi, command);
-	if (ret)
-		goto out_clear_bit;
-
-	if (!wait_for_completion_timeout(&uec->complete, 5 * HZ))
-		ret = -ETIMEDOUT;
-
-out_clear_bit:
-	if (ack)
-		clear_bit(UCSI_C630_ACK_PENDING, &uec->flags);
-	else
-		clear_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
-
-	return ret;
-}
-
 const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read_version = yoga_c630_ucsi_read_version,
 	.read_cci = yoga_c630_ucsi_read_cci,
 	.read_message_in = yoga_c630_ucsi_read_message_in,
-	.sync_control = yoga_c630_ucsi_sync_control,
+	.sync_control = ucsi_sync_control_common,
 	.async_control = yoga_c630_ucsi_async_control,
 };
 
-static void yoga_c630_ucsi_notify_ucsi(struct yoga_c630_ucsi *uec, u32 cci)
-{
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(uec->ucsi, UCSI_CCI_CONNECTOR(cci));
-
-	if (cci & UCSI_CCI_ACK_COMPLETE &&
-	    test_bit(UCSI_C630_ACK_PENDING, &uec->flags))
-		complete(&uec->complete);
-
-	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
-	    test_bit(UCSI_C630_COMMAND_PENDING, &uec->flags))
-		complete(&uec->complete);
-}
-
 static int yoga_c630_ucsi_notify(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
@@ -144,7 +97,7 @@ static int yoga_c630_ucsi_notify(struct notifier_block *nb,
 		if (ret)
 			return NOTIFY_DONE;
 
-		yoga_c630_ucsi_notify_ucsi(uec, cci);
+		ucsi_notify_common(uec->ucsi, cci);
 
 		return NOTIFY_OK;
 
@@ -165,7 +118,6 @@ static int yoga_c630_ucsi_probe(struct auxiliary_device *adev,
 		return -ENOMEM;
 
 	uec->ec = ec;
-	init_completion(&uec->complete);
 	uec->nb.notifier_call = yoga_c630_ucsi_notify;
 
 	uec->ucsi = ucsi_create(&adev->dev, &yoga_c630_ucsi_ops);

-- 
2.39.2


