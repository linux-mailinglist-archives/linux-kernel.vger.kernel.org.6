Return-Path: <linux-kernel+bounces-430982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF05A9E37DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C6CB252BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124BA1AF0C5;
	Wed,  4 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObR8PXyu"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934C187FFA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309120; cv=none; b=Vk+yS6Rqvd6xQQnWqG/cV+pfoHzmHNryKg29dW6UPhdQBQ1OUFpPQvlOmXJeNn3zvV217a0bOVP11qhbCWJIDE1Sx4rWwKJYKk+F2NcEfwYJ/PdrWZezak49uBKg/uho7j1a5DnS3FZYn5YQO66z7Bge+SJBXso0OFiihanK8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309120; c=relaxed/simple;
	bh=fxYcdUfZVshmW3K+OY/btqceQ6KRhi9srUFU5dW2Pyw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nevrh0r/DUaWXZFZYOZzQE8kLNIH56ppjz+xATH1LMWoZ2XCkq5ROSN0LV0CdEUfTfcBFYGCQVpZB7KjDWFQGfEN169VBtjxbo9YTq3uS3ZoT0sbmAKCN2Z9WLu2qvD7Id+4AJAFD3xfCho4vap28xJD0FE7jXnZUNYQvHbhJhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObR8PXyu; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so2708623f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733309117; x=1733913917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47E3YyW6DrR27MbE2FWe5udRH/OIbLEqcmInTqvOrvY=;
        b=ObR8PXyugZaiircKphs6MRecOl5HzRMJJwFC4qhdpqmab9zyifD8JnyGFsiLX2ygxV
         os0kudJoVtdABI+zcSk/zMo6HgSYTx9r81ZgkiZL9FkXKl72WCOlAFaJgb0YkA7x2Ahf
         t5VebpCWGWHlyhd66Pt0E1cfWuijm5vkgNuW8R6DgQPkQMJsck6hro7JB6o5cb3hRNda
         og1C2f8dNFjo2awld3zQtiH6syh/dtXd0e9jqwN9falY2beHofU1uImSSV3oHEYibpBl
         n/UK9BqyMkUwAgDLTyDbQvvW8tU+/NhthPd8VEnL1KbDzunccA8QybawoGEJ0RjAUSnH
         oljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309117; x=1733913917;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47E3YyW6DrR27MbE2FWe5udRH/OIbLEqcmInTqvOrvY=;
        b=wO35w/Uaou8nZZquzDPAxcR3llGqxozSkNeyibGLcNhrUaH4xR+LUt7R2aLWkZyRSc
         wjLCobwvJvPkkyZCA5aIYElYs+DQ9z/nONA/0WAJ4Ue9W4qHxB+p/NNIgS19QmQzd1e1
         N7GRdBt0oPH80snj31Q5RUMKrHFs8f4c5FeTVeEEw4e5QT4aHDzZnKLmgD5P5HR54/IN
         hN2wmeVMn2ugVKQJ9ri1EJyzDrFdOT5XvUr7NFQk5+xvqp7dy8n9E86qMN7QW95lhfxl
         WUgRJ9D4ZEoaTZsSxSODdwidUN0sIG14xdeOchBpNFEJs8MAGg1sRZO927gk/zAcUc5+
         C7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVpqMv77NdKofhtYmMRO2eFSJBOUlVoMduNFc6czqa7HtTs09w4Q7aOPtfUdIyGy12AsHzWj3UkN7/WTHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBJCskVCtPIMAhgzgg76zBiCSDw7ppVfkFLKAio8X8oz3SWvL
	EGuMBEQyET0WwP48akydmmZ2COjpWXxga/hJXMfAiXVdnq3d+sy4M7TbIGuWpzhwd7rU7sYGKyH
	DtQ==
X-Google-Smtp-Source: AGHT+IHO5lBRS9CVlcosceV4uqtJ3ozsKz1F+Tz3ehGwr2YlfyuEuN7UJFBK45IYdvS2HvYYpO+OLpjs6HY=
X-Received: from wmil20.prod.google.com ([2002:a7b:c454:0:b0:434:9dec:7cc5])
 (user=dawidn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:186b:b0:385:ec89:2f07
 with SMTP id ffacd0b85a97d-38607ae4117mr2655875f8f.32.1733309116850; Wed, 04
 Dec 2024 02:45:16 -0800 (PST)
Date: Wed,  4 Dec 2024 10:45:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204104514.1541964-1-dawidn@google.com>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec: jump to RW before probing
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
V1 -> V2:
- Use dev_info instead of dev_warn when cros_ec_rwsig_continue returns
  an error.
- Return immediately from cros_ec_rwsig_continue, if the RWSIG_ACTION
  command fails itself, not SPI transaction.

 drivers/platform/chrome/cros_ec.c           |  5 ++
 drivers/platform/chrome/cros_ec_i2c.c       |  3 +-
 drivers/platform/chrome/cros_ec_ishtp.c     |  2 +-
 drivers/platform/chrome/cros_ec_lpc.c       |  2 +-
 drivers/platform/chrome/cros_ec_proto.c     | 62 +++++++++++++++++++++
 drivers/platform/chrome/cros_ec_rpmsg.c     |  2 +-
 drivers/platform/chrome/cros_ec_spi.c       |  2 +-
 drivers/platform/chrome/cros_ec_uart.c      |  2 +-
 include/linux/platform_data/cros_ec_proto.h |  2 +
 9 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index e821b3d39590..110771a8645e 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -204,6 +204,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	mutex_init(&ec_dev->lock);
 	lockdep_set_class(&ec_dev->lock, &ec_dev->lockdep_key);
 
+	/* Send RWSIG continue to jump to RW for devices using RWSIG. */
+	err = cros_ec_rwsig_continue(ec_dev);
+	if (err)
+		dev_info(dev, "Failed to continue RWSIG: %d\n", err);
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
index 5c9a53dffcf9..9b451fac275d 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -15,6 +15,8 @@
 #include "cros_ec_trace.h"
 
 #define EC_COMMAND_RETRIES	50
+#define RWSIG_CONTINUE_RETRIES	8
+#define RWSIG_CONTINUE_MAX_ERRORS_IN_ROW	3
 
 static const int cros_ec_error_map[] = {
 	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
@@ -288,6 +290,66 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint3
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
+		if (ret < 0) {
+			error_count++;
+		} else if (msg->result == EC_RES_INVALID_COMMAND) {
+			/*
+			 * If EC_RES_INVALID_COMMAND is retured, it means RWSIG
+			 * is not supported or EC is already in RW, so there is
+			 * nothing left to do.
+			 */
+			break;
+		} else if (msg->result != EC_RES_SUCCESS) {
+			/* Unexpected command error. */
+			ret = cros_ec_map_error(msg->result);
+			break;
+		} else {
+			/*
+			 * The EC_CMD_RWSIG_ACTION succeed. Send the command
+			 * more times, to make sure EC is in RW. A following
+			 * command can timeout, because EC may need some time to
+			 * initialize after jump to RW.
+			 */
+			error_count = 0;
+		}
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
2.47.0.338.g60cca15819-goog


