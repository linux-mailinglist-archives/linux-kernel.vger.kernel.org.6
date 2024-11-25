Return-Path: <linux-kernel+bounces-421521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E819D8C61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8619F285562
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F91B9831;
	Mon, 25 Nov 2024 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxvhrqCH"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB501B414E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560292; cv=none; b=J4jcdd6sojHgU3do/1W0qxBNrrJdUS1nOyqCH/Pzg6h2nhePWn0iip3nigpF1cAQ+XWS8KVTrRmV0bNtnqMKhxRltLAAmBviTXZvw/cfjCX1akgXWz6wUaqnTRzBh9c+o9MNUp9HeFC2pB57LfVMBzc2PvJ6m7L/w4PbbEl+t8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560292; c=relaxed/simple;
	bh=nQdveVz0U8LjLVzHCbp//UgMS1/8ert9nrQXlFvrOdE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RK+9qvzlABPc84CdwO/Q4roIvZ44aLN+7c52XLta6I4oey2FWsh260OkNjZqjM9UThVY3sUdl+PZlCXpNKwqaXfOVbMNjZTR3lt8mipC31ignwsR2tO9cyRckXpaKa6akXbRcESwIrhM679/hxd3+3dRXwLI1yr2bypK2p8s6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxvhrqCH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4315d98a75fso40108985e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732560289; x=1733165089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d51oFRTw84JSKB1foTZtP9z0jdqfbxCn0u7gU1Gqt2I=;
        b=mxvhrqCHT2tPIyLrsiMSKiITOLurXngqlsnXSBqMBL88ezzWVd6kptzzhWTgfhfeEv
         5h99ETHidse1jbhhBRowyJfIHL9rN550x+5drpfK0+10ypJQZgESbC0SUG9I1xrZJtzK
         4O9r26pH6TyYjPx8aS8xnoswm7VZ5pqWTKFGeyQ2dY1WGplqDc/LSbP3fktQbe3L2oXn
         QTzhPqLWL1eTHfL182CXX6FFGdmgFXHTraD0QKafZiDD6toGBb5NCISia4YK5ft8W0Tf
         1C0TuxhGimnRAB4qYJFF5mJW5nelczW1DoZTBhz9WwYQg+lmxANFq2BgJbEbuUPxtaxw
         R2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732560289; x=1733165089;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d51oFRTw84JSKB1foTZtP9z0jdqfbxCn0u7gU1Gqt2I=;
        b=ZTcnOX3TprbF+IyoNwQkFTu8PPlBeVYYPtJ2pT4mAoxEsQdR/dTnO0BddzWsCeKK4W
         NFhkC7I26BQiguz1awhpM+n19OsFJyIex0eVthNPeJbZUjnZO+DwgtHpgvFVDfRI/4m7
         Yh7x/ay84jf6SHU+fTWOUkxuM6bhdMXx1mNnFKWim+bvmyn36DR6MreWLFZCL+6EBj6Q
         EXWvMKecZWrbeAnGPQ++D/6947iTWOMBSWrzU+Yajv6WNKkql2XbVngIjfos1Blx7U+j
         IhFdFIxZf/9u0spOr8+ngtkKp/fpUAUKAe/cfWcWv9QGESEZIsuOOItTCjO31ANgLKWY
         QSQA==
X-Forwarded-Encrypted: i=1; AJvYcCV7+OX+ZN1xLQ3xgYdDlHgFr4Wu3xJdWEEm4aeO1Laa8cu2UtG0v23WFY7QyhDfHJ3+F/bhM8PXxhkgyTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4yr7S3BXKgYs9Zv30yRwbJ4MqNftJ38QZZ7HEbw5I+II4WD7
	Faz9hwux/C5sjQ1cMtr9p61PtsIGXcBUrHhyDqTTsUDxH2F5APeaDGzhxYefXS28bH7BV9C6B36
	sig==
X-Google-Smtp-Source: AGHT+IHA+04KBmSgohZAFUfxTxaLqHSlVruLNyGNeozjydYof7rH7Znp8aNlL99iQBrmVfTTirLhcmNCV14=
X-Received: from wmrk17.prod.google.com ([2002:a05:600c:b51:b0:434:a152:3ce1])
 (user=dawidn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6a06:b0:434:9fb5:fe04
 with SMTP id 5b1f17b1804b1-4349fb5ff09mr33583835e9.28.1732560288954; Mon, 25
 Nov 2024 10:44:48 -0800 (PST)
Date: Mon, 25 Nov 2024 18:44:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125184446.1040187-1-dawidn@google.com>
Subject: [PATCH 1/2] platform/chrome: cros_ec: jump to RW before probing
From: Dawid Niedzwiecki <dawidn@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, Dawid Niedzwiecki <dawidn@google.com>
Content-Type: text/plain; charset="UTF-8"

There are EC devices, like FPMCU, that use RWSIG as a method of
authenticating RW section. After the authentication succeeds, EC device
waits some time before jumping to RW. EC can be probed before the jump,
which means there is a time window after jump to RW in which EC won't
respond, because it is not initialized. It can cause a communication
errors after probing.

To avoid such problems, send the RWSIG continue command first, which
skips waiting for the jump to RW. Send the command more times, to make
sure EC is ready in RW before the start of the actual probing process. If
a EC device doesn't support the RWSIG, it will respond with invalid
command error code and probing will continue as usual.

Signed-off-by: Dawid Niedzwiecki <dawidn@google.com>
---
 drivers/platform/chrome/cros_ec.c           |  5 ++
 drivers/platform/chrome/cros_ec_i2c.c       |  3 +-
 drivers/platform/chrome/cros_ec_ishtp.c     |  2 +-
 drivers/platform/chrome/cros_ec_lpc.c       |  2 +-
 drivers/platform/chrome/cros_ec_proto.c     | 60 +++++++++++++++++++++
 drivers/platform/chrome/cros_ec_rpmsg.c     |  2 +-
 drivers/platform/chrome/cros_ec_spi.c       |  2 +-
 drivers/platform/chrome/cros_ec_uart.c      |  2 +-
 include/linux/platform_data/cros_ec_proto.h |  2 +
 9 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index e821b3d39590..2bbe888f77ca 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -204,6 +204,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	mutex_init(&ec_dev->lock);
 	lockdep_set_class(&ec_dev->lock, &ec_dev->lockdep_key);
 
+	/* Send RWSIG continue to jump to RW for devices using RWSIG. */
+	err = cros_ec_rwsig_continue(ec_dev);
+	if (err)
+		dev_warn(dev, "Failed to continue RWSIG: %d\n", err);
+
 	err = cros_ec_query_all(ec_dev);
 	if (err) {
 		dev_err(dev, "Cannot identify the EC: error %d\n", err);
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 62662ba5bf6e..38af97cdaab2 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -305,7 +305,8 @@ static int cros_ec_i2c_probe(struct i2c_client *client)
 	ec_dev->phys_name = client->adapter->name;
 	ec_dev->din_size = sizeof(struct ec_host_response_i2c) +
 			   sizeof(struct ec_response_get_protocol_info);
-	ec_dev->dout_size = sizeof(struct ec_host_request_i2c);
+	ec_dev->dout_size = sizeof(struct ec_host_request_i2c) +
+			    sizeof(struct ec_params_rwsig_action);
 
 	err = cros_ec_register(ec_dev);
 	if (err) {
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 5ac37bd024c8..7e7190b30cbb 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -557,7 +557,7 @@ static int cros_ec_dev_init(struct ishtp_cl_data *client_data)
 	ec_dev->phys_name = dev_name(dev);
 	ec_dev->din_size = sizeof(struct cros_ish_in_msg) +
 			   sizeof(struct ec_response_get_protocol_info);
-	ec_dev->dout_size = sizeof(struct cros_ish_out_msg);
+	ec_dev->dout_size = sizeof(struct cros_ish_out_msg) + sizeof(struct ec_params_rwsig_action);
 
 	return cros_ec_register(ec_dev);
 }
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 924bf4d3cc77..1e1d68359958 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -573,7 +573,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	ec_dev->cmd_readmem = cros_ec_lpc_readmem;
 	ec_dev->din_size = sizeof(struct ec_host_response) +
 			   sizeof(struct ec_response_get_protocol_info);
-	ec_dev->dout_size = sizeof(struct ec_host_request);
+	ec_dev->dout_size = sizeof(struct ec_host_request) + sizeof(struct ec_params_rwsig_action);
 	ec_dev->priv = ec_lpc;
 
 	/*
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 5c9a53dffcf9..4bd17ddefbd6 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -15,6 +15,8 @@
 #include "cros_ec_trace.h"
 
 #define EC_COMMAND_RETRIES	50
+#define RWSIG_CONTINUE_RETRIES	8
+#define RWSIG_CONTINUE_MAX_ERRORS_IN_ROW	3
 
 static const int cros_ec_error_map[] = {
 	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
@@ -288,6 +290,64 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
 	return ret;
 }
 
+int cros_ec_rwsig_continue(struct cros_ec_device *ec_dev)
+{
+	struct cros_ec_command *msg;
+	struct ec_params_rwsig_action *rwsig_action;
+	int ret = 0;
+	int error_count = 0;
+
+	ec_dev->proto_version = 3;
+
+	msg = kmalloc(sizeof(*msg) + sizeof(*rwsig_action), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = 0;
+	msg->command = EC_CMD_RWSIG_ACTION;
+	msg->insize = 0;
+	msg->outsize = sizeof(*rwsig_action);
+
+	rwsig_action = (struct ec_params_rwsig_action *)msg->data;
+	rwsig_action->action = RWSIG_ACTION_CONTINUE;
+
+	for (int i = 0; i < RWSIG_CONTINUE_RETRIES; i++) {
+		ret = cros_ec_send_command(ec_dev, msg);
+
+		if (ret < 0)
+			error_count++;
+		else if (msg->result == EC_RES_INVALID_COMMAND)
+			/*
+			 * If EC_RES_INVALID_COMMAND is retured, it means RWSIG
+			 * is not supported or EC is already in RW, so there is
+			 * nothing left to do.
+			 */
+			break;
+		else if (msg->result != EC_RES_SUCCESS)
+			/* Unexpected command error. */
+			error_count++;
+		else
+			/*
+			 * The EC_CMD_RWSIG_ACTION succeed. Send the command
+			 * more times, to make sure EC is in RW. A following
+			 * command can timeout, because EC may need some time to
+			 * initialize after jump to RW.
+			 */
+			error_count = 0;
+
+		if (error_count >= RWSIG_CONTINUE_MAX_ERRORS_IN_ROW)
+			break;
+
+		if (ret != -ETIMEDOUT)
+			usleep_range(90000, 100000);
+	}
+
+	kfree(msg);
+
+	return ret;
+}
+EXPORT_SYMBOL(cros_ec_rwsig_continue);
+
 static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
 {
 	struct cros_ec_command *msg;
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index 39d3b50a7c09..bc2666491db1 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -231,7 +231,7 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
 	ec_dev->phys_name = dev_name(&rpdev->dev);
 	ec_dev->din_size = sizeof(struct ec_host_response) +
 			   sizeof(struct ec_response_get_protocol_info);
-	ec_dev->dout_size = sizeof(struct ec_host_request);
+	ec_dev->dout_size = sizeof(struct ec_host_request) + sizeof(struct ec_params_rwsig_action);
 	dev_set_drvdata(dev, ec_dev);
 
 	ec_rpmsg->rpdev = rpdev;
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 86a3d32a7763..946373238502 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -766,7 +766,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	ec_dev->din_size = EC_MSG_PREAMBLE_COUNT +
 			   sizeof(struct ec_host_response) +
 			   sizeof(struct ec_response_get_protocol_info);
-	ec_dev->dout_size = sizeof(struct ec_host_request);
+	ec_dev->dout_size = sizeof(struct ec_host_request) + sizeof(struct ec_params_rwsig_action);
 
 	ec_spi->last_transfer_ns = ktime_get_ns();
 
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 62bc24f6dcc7..19c179d49c90 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -283,7 +283,7 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 	ec_dev->pkt_xfer = cros_ec_uart_pkt_xfer;
 	ec_dev->din_size = sizeof(struct ec_host_response) +
 			   sizeof(struct ec_response_get_protocol_info);
-	ec_dev->dout_size = sizeof(struct ec_host_request);
+	ec_dev->dout_size = sizeof(struct ec_host_request) + sizeof(struct ec_params_rwsig_action);
 
 	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index b34ed0cc1f8d..701389c16fa7 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -246,6 +246,8 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg);
 
+int cros_ec_rwsig_continue(struct cros_ec_device *ec_dev);
+
 int cros_ec_query_all(struct cros_ec_device *ec_dev);
 
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
-- 
2.47.0.371.ga323438b13-goog


