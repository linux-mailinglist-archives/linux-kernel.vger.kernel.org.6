Return-Path: <linux-kernel+bounces-434697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2650B9E69E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0049C165785
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004B1EF09B;
	Fri,  6 Dec 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duJCmUHa"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A861B4129
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476521; cv=none; b=KHdONnJQZjs4HEdGv72xE1uXmGpd878B8nUKLYl6odWHcMcTTYO7NTbB1sjgXTvAqKx85v4o277MFncD/NuyNeAvBPNugRedhg3PVP3yINwmLwC1Ygt7kKjmwWLvj6e3EuzQ6kj2WwzFdRM6LjifYfNQbjm0Udp5LQ1Yc6qogPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476521; c=relaxed/simple;
	bh=+H94MKi/+KLKTAEdCf3+ha3VhZ2bwmcZ7ERdKtfc5y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SX9XwJjWJF1w+Cyrs6kRgdjc4SYReTzRqwnxQFNigQSCUcz8C2immI+P2s66Cl+MNLjHV+IzfXqrUCoQ/7VARec58eoEJl7CB2BM3lSwmhLyoIkQihWDTroh+RP3bIDhSZ/pE7gn60hbrULyo6+Ad0VdEM5Yoh6eqA7Bv987U1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duJCmUHa; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4349f32c9a6so2480545e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733476518; x=1734081318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MVlDn92ycjNPLLmYap9W5hrklg2KcAzREXkZCn1Hs4=;
        b=duJCmUHakKSzktzSxxQ9p8xC7AjEhE/iAQ1PfA6hvZ9Z/AhAdbhY1cHhhdqFTXfSdQ
         J5mCq9oSqbqh0KZnUlVOz9XPfCvesI56Yz8i5nf1kB9nc6afxosynk/It+COiqrpXgM3
         FA2FUcDQLJvRIwNhUTdm9JsW7ZG2pcpi0gBIQe9dcCG0ewZyWbz9lvxKIl+T/QSvowqi
         yPISJCQtEd88uvORUECegd02oUzajpUEfq6c8oDKAyvw6BLm8SgK57a7xmwsEOXT7MYW
         TeGFEtSaFKd+noOA6IlHDIRYgo6LWPIGBfxFGwN58MKg/aK2j7omqxpGvlI0s21TexSu
         Atpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476518; x=1734081318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MVlDn92ycjNPLLmYap9W5hrklg2KcAzREXkZCn1Hs4=;
        b=QA7awh6fNp1I76CsuJmVdo9KTaMu5RzUcBz5mqPvRmmNNo5LUqk630NK/IlyjTy7vI
         AR2RWfjfxdwQH7ucdwKLhJ7iuSiFXzDuko6g4+spKhL2Pd3MJeW6GMbc27IHgK9NBbN3
         iAx1EUd8QK5q/qumG0/dd4GhrUKUlpHstRdTpWR4dgE1iip6fZbQUPcCSLS9Vzbotekj
         zwxvtOpzpoREQKLIOtGID77weWIKS1qFMsdziD7N+kl/ejKudSgcSTb4qHNfLWv49xXa
         Qn8XOQCHUxw9UftC7FJ2pNtIMm5IxLDV0dMsa+ACDMV1Rw4WHrcibpV+4MArtoP9diXs
         HSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiHfj25cjGmSwdlYLWWn2Vf4g8gp2uPcujMPdhBvt8mafv+5QQr7HsN+WEO82mPZwVAOsGiTDq7daQNzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRrZzuuDNR9bvTkh3SyhdL/SaUSixtp92zFAVCZuvcQIQGDvh
	byIN2aZs86OfpBWuisKsT8dkHObm8T/lNsx06dhamV5kRZy2A9NgsTrPkYYe3j7FZP8FbLWOHRK
	BqQ==
X-Google-Smtp-Source: AGHT+IG8jEe/8oqP+4sI48X1FnUr2gXr2SbFhrr0xivfLS+pQieEKk4fb8t0oihq1ZCL8eWldRUNFofrS6U=
X-Received: from wmik22.prod.google.com ([2002:a7b:c416:0:b0:434:a28f:aa62])
 (user=dawidn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3544:b0:434:9f1e:2c2e
 with SMTP id 5b1f17b1804b1-434ddead636mr21517775e9.15.1733476518326; Fri, 06
 Dec 2024 01:15:18 -0800 (PST)
Date: Fri,  6 Dec 2024 09:15:13 +0000
In-Reply-To: <20241206091514.2538350-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206091514.2538350-1-dawidn@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206091514.2538350-2-dawidn@google.com>
Subject: [PATCH v3 1/2] platform/chrome: cros_ec: jump to RW before probing
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
index 5c9a53dffcf9..ed3623b54bc3 100644
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
+		if (ret < 0) {
+			if (++error_count >= RWSIG_CONTINUE_MAX_ERRORS_IN_ROW)
+				break;
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


