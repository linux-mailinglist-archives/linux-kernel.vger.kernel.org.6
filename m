Return-Path: <linux-kernel+bounces-350788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA09909B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018AAB2285C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8021CACE1;
	Fri,  4 Oct 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdwxkKSP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1F1CACD6
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060788; cv=none; b=H9+KkHfOXQ9cLZ9wCJsycQMUiWoT7Px17YmVT7qjI+2aPvWNOTU56sXdFPHQ/6VJdnpcHPgWkMjuyt4VcAwTio5X5yQ3jb8u/vtfmy8mBeMnfxJ8ZfyxiEuAcIuO3zkGmZDWzamqsfDb3NZS4GBZr8wYT4WkZTWj/79I9OpFEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060788; c=relaxed/simple;
	bh=ZmOuOwy+RtMJhCgjeWexgs5gFky/E9lSMSWcVYVJ+xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=df5DxFoXxVFk8A8RbzBmJbkoY2eYXhprvcw20su8v1kragPIM4GVwS+62Q1snu8vjfetuUea9nml4ULkoktfvvCt/jJllMEeFgWHSIbn1jktjdHAPHhT9XmozWEGJ1dKehv3uffIHZ8R7DRop7UrbJr2D3NxyBzEw0vWA0T+YOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdwxkKSP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cae102702so19158785e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728060784; x=1728665584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rt60eV3bPcymnWawAKOlNBP1EDv2gXjrC+zYiVoYAYc=;
        b=jdwxkKSP7PP+5s1hC/GhA0hwt8nXP96sgDKxPqJD/5f9AUbOWnLCBPD0nvL3jLivAM
         LX2b5hYsr/tY8DHIrpLIXCcjHtRaMibFTbrodov7qzPCL1GiChZU2PHQXqtqNGdr5xBi
         ZuxOU13DWO9ljbRFPHGwNqlogC57III2/bQHweUYlfAZ8jPf1PPraQfkJQK8WWy7AKo/
         DvxA8OY7kDgCWJMCwxH3sT5sYdf/xy00KttcmoxkIcAdJqFDarid3OtliAINywA0Qtg5
         gjik5kojgU4vNgca/UN47j/V6BmCowWNrR1VVvH+TNeY/A9FoTr5+jaP+vEHloZ5Ij23
         Hheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060784; x=1728665584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt60eV3bPcymnWawAKOlNBP1EDv2gXjrC+zYiVoYAYc=;
        b=B/875xo9g+hmY/lO5qctj4hecRMU9v3GqX7sQiSb4w39swrUA5ZOvm27SLaysrLcj2
         8vplTfQQfQXCAC6HOkEQUOxvqvfB8B7RKJyKb2Wx138dB4+nSEzH0FsLf44hm2ApaNXj
         4kSSfIjRfeW3g3OOPkOdCZX/UfgwcAQHLlVH2qTrnWX60yFAACaWT/NrIuTP73xIlCaz
         6IqZrASyXxW0hVrsj16rUzL+PCnFCiqSGGNXEtzE13so7jeGkB5fSN7EJDPQnMP5vV6d
         eBNOgSEVyJSas4EpWklRaJkMAIjkphDcn0KjrkV1wIUte/saQWDioRG60PenROhQ+4Vj
         A7tw==
X-Gm-Message-State: AOJu0YwgpIoLPI+aWpkN43JHtVfoaxD1fxk0HsIZ12r0qTNV832zIMXW
	+VxUBAC7KKPoEOiJXQJZFTFSft8eVvFCTMk2DeR0dLwn2wA2D0WLdJhtQb71Q2o=
X-Google-Smtp-Source: AGHT+IGhS4gFVH+ODTBqItOmDxZnuhg6aZpvhWEKNHhYInOkNE7eqn0l9/6L9WaQkWU0EgSRcAQxeQ==
X-Received: by 2002:a05:600c:3b2a:b0:42c:a7cc:cb64 with SMTP id 5b1f17b1804b1-42f85aa1992mr23625375e9.3.1728060784252;
        Fri, 04 Oct 2024 09:53:04 -0700 (PDT)
Received: from ta2.c.googlers.com.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695f108sm51907f8f.67.2024.10.04.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:53:03 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	marcan@marcan.st,
	neal@gompa.dev,
	alyssa@rosenzweig.io,
	broonie@kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mailbox: add async request mechanism to empower controllers w/ hw queues
Date: Fri,  4 Oct 2024 16:53:01 +0000
Message-ID: <20241004165301.1979527-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current form of the mailbox framework doesn't allow controllers to benefit
of their hardware queue capabilities as the framework handles a single
active request at a time.

The active request is considered completed when TX completes. But it seems
that TX is not in direct relation with RX, so a client can't know to which
TX data the RX data corresponds to. Let's consider a client sends
TX1 data, mbox->ops->send_data() is called, timer is started immediately,
last_tx_done() returns true and the client is notified that TX1 completed.
Client sends TX2 and gets notified that TX2 completed. RX comes,
mbox_chan_received_data(chan, mssg) is called after both TX1 and TX2
completed. Client can't know if the received mssg belongs to TX1 or TX2.

In order to address these shortcomes, add a simple async mechanism
based on requests. A request will contain pointers to tx and rx (if any)
data, along with a pointer to a completion struct. Is the responsibility
of the client to allocate and fill the request:

static int client_send_request(struct demo_client *dc, void *data)
{
	DECLARE_MBOX_WAIT(wait);
	struct mbox_request req;
	int ret;

	req.tx = data;
	/*
	 * Set req.rx = NULL if no response is expected. Here we
	 * use the same memory to get the response.
	 */
	req.rx = data;

	ret = mbox_send_request(dc->mbox_chan, &req);
	ret = mbox_wait_request(ret, &wait);
	if (ret)
		dev_err(dc->dev, "%s failed %d\n", __func__, ret);
	return ret;
}

mbox_send_request() sends a message on the bus. The call may be in atomic
context. Returns -EINPROGRESS if data is fed into hardware, -ENOSPC when
the hardware queue is full, or zero when the request completes.
The message (queue) handling is thus deferred to the controller.

Similar mechanism is used in the crypto subsystem.

The async req mechanism is mutual exclusive with the current message
software queue handling. In the future the software queue handling can
be used as an opt-in backlog choice for users that need it. But we'll
have to do the conversion from ``void *message`` to
``struct mbox_request *req`` throughout the API.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Hi, Jassi, all,

A controller driver will follow, but I wanted to first get some feedback
on the overall idea. Written on top of v6.12-rc1.

Thanks,
ta

 drivers/mailbox/mailbox.c          | 126 +++++++++++++++++++++++------
 include/linux/mailbox_client.h     |   4 +
 include/linux/mailbox_controller.h |   7 ++
 include/linux/mailbox_request.h    |  24 ++++++
 4 files changed, 138 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/mailbox_request.h

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2c9895..b711d4cd4d64 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -158,6 +158,11 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
  */
 void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
 {
+	if (chan->mbox->ops->send_request) {
+		dev_dbg(chan->mbox->dev, "Operation not supported for mailbox requests\n");
+		return;
+	}
+
 	/* No buffering the received data */
 	if (chan->cl->rx_callback)
 		chan->cl->rx_callback(chan->cl, mssg);
@@ -176,6 +181,11 @@ EXPORT_SYMBOL_GPL(mbox_chan_received_data);
  */
 void mbox_chan_txdone(struct mbox_chan *chan, int r)
 {
+	if (chan->mbox->ops->send_request) {
+		dev_dbg(chan->mbox->dev, "Operation not supported for mailbox requests\n");
+		return;
+	}
+
 	if (unlikely(!(chan->txdone_method & TXDONE_BY_IRQ))) {
 		dev_err(chan->mbox->dev,
 		       "Controller can't run the TX ticker\n");
@@ -197,6 +207,11 @@ EXPORT_SYMBOL_GPL(mbox_chan_txdone);
  */
 void mbox_client_txdone(struct mbox_chan *chan, int r)
 {
+	if (chan->mbox->ops->send_request) {
+		dev_dbg(chan->mbox->dev, "Operation not supported for mailbox requests\n");
+		return;
+	}
+
 	if (unlikely(!(chan->txdone_method & TXDONE_BY_ACK))) {
 		dev_err(chan->mbox->dev, "Client can't run the TX ticker\n");
 		return;
@@ -261,6 +276,11 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 	if (!chan || !chan->cl)
 		return -EINVAL;
 
+	if (chan->mbox->ops->send_request) {
+		dev_dbg(chan->mbox->dev, "Operation not supported for mailbox requests\n");
+		return -EOPNOTSUPP;
+	}
+
 	t = add_to_rbuf(chan, mssg);
 	if (t < 0) {
 		dev_err(chan->mbox->dev, "Try increasing MBOX_TX_QUEUE_LEN\n");
@@ -289,6 +309,39 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
+int mbox_send_request(struct mbox_chan *chan, struct mbox_request *req)
+{
+	return chan->mbox->ops->send_request(chan, req);
+}
+EXPORT_SYMBOL_GPL(mbox_send_request);
+
+int mbox_wait_request(int err, struct mbox_wait *wait)
+{
+	switch (err) {
+	case -EINPROGRESS:
+		wait_for_completion(&wait->completion);
+		reinit_completion(&wait->completion);
+		err = wait->err;
+		break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mbox_wait_request);
+
+void mbox_request_complete(struct mbox_request *req, int err)
+{
+	struct mbox_wait *wait;
+
+	if (err == -EINPROGRESS)
+		return;
+
+	wait = req->wait;
+	wait->err = err;
+	complete(&wait->completion);
+}
+EXPORT_SYMBOL_GPL(mbox_request_complete);
+
 /**
  * mbox_flush - flush a mailbox channel
  * @chan: mailbox channel to flush
@@ -311,24 +364,44 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 		return -ENOTSUPP;
 
 	ret = chan->mbox->ops->flush(chan, timeout);
-	if (ret < 0)
+	if (ret < 0 && !chan->mbox->ops->send_request)
 		tx_tick(chan, ret);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mbox_flush);
 
+static int mbox_chan_startup(struct mbox_chan *chan, struct mbox_client *cl)
+{
+	struct mbox_controller *mbox = chan->mbox;
+	struct device *dev = cl->dev;
+	int ret;
+
+	if (!mbox->ops->startup)
+		return 0;
+
+	ret = mbox->ops->startup(chan);
+	if (ret) {
+		dev_err(dev, "Unable to startup the chan (%d)\n", ret);
+		mbox_free_channel(chan);
+	}
+
+	return ret;
+}
+
 static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 {
 	struct device *dev = cl->dev;
 	unsigned long flags;
-	int ret;
 
 	if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
 		dev_dbg(dev, "%s: mailbox not free\n", __func__);
 		return -EBUSY;
 	}
 
+	if (chan->mbox->ops->send_request)
+		return mbox_chan_startup(chan, cl);
+
 	spin_lock_irqsave(&chan->lock, flags);
 	chan->msg_free = 0;
 	chan->msg_count = 0;
@@ -341,17 +414,7 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	if (chan->mbox->ops->startup) {
-		ret = chan->mbox->ops->startup(chan);
-
-		if (ret) {
-			dev_err(dev, "Unable to startup the chan (%d)\n", ret);
-			mbox_free_channel(chan);
-			return ret;
-		}
-	}
-
-	return 0;
+	return mbox_chan_startup(chan, cl);
 }
 
 /**
@@ -474,13 +537,17 @@ EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
  */
 void mbox_free_channel(struct mbox_chan *chan)
 {
+	struct mbox_controller *mbox = chan->mbox;
 	unsigned long flags;
 
 	if (!chan || !chan->cl)
 		return;
 
-	if (chan->mbox->ops->shutdown)
-		chan->mbox->ops->shutdown(chan);
+	if (mbox->ops->shutdown)
+		mbox->ops->shutdown(chan);
+
+	if (mbox->ops->send_request)
+		return module_put(mbox->dev->driver->owner);
 
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	spin_lock_irqsave(&chan->lock, flags);
@@ -489,7 +556,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == TXDONE_BY_ACK)
 		chan->txdone_method = TXDONE_BY_POLL;
 
-	module_put(chan->mbox->dev->driver->owner);
+	module_put(mbox->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
@@ -506,6 +573,13 @@ of_mbox_index_xlate(struct mbox_controller *mbox,
 	return &mbox->chans[ind];
 }
 
+static void mbox_controller_add_tail(struct mbox_controller *mbox)
+{
+	mutex_lock(&con_mutex);
+	list_add_tail(&mbox->node, &mbox_cons);
+	mutex_unlock(&con_mutex);
+}
+
 /**
  * mbox_controller_register - Register the mailbox controller
  * @mbox:	Pointer to the mailbox controller.
@@ -520,6 +594,17 @@ int mbox_controller_register(struct mbox_controller *mbox)
 	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
 		return -EINVAL;
 
+	if (mbox->ops->send_request && mbox->ops->send_data)
+		return -EINVAL;
+
+	if (!mbox->of_xlate)
+		mbox->of_xlate = of_mbox_index_xlate;
+
+	if (mbox->ops->send_request) {
+		mbox_controller_add_tail(mbox);
+		return 0;
+	}
+
 	if (mbox->txdone_irq)
 		txdone = TXDONE_BY_IRQ;
 	else if (mbox->txdone_poll)
@@ -549,12 +634,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 		spin_lock_init(&chan->lock);
 	}
 
-	if (!mbox->of_xlate)
-		mbox->of_xlate = of_mbox_index_xlate;
-
-	mutex_lock(&con_mutex);
-	list_add_tail(&mbox->node, &mbox_cons);
-	mutex_unlock(&con_mutex);
+	mbox_controller_add_tail(mbox);
 
 	return 0;
 }
@@ -578,7 +658,7 @@ void mbox_controller_unregister(struct mbox_controller *mbox)
 	for (i = 0; i < mbox->num_chans; i++)
 		mbox_free_channel(&mbox->chans[i]);
 
-	if (mbox->txdone_poll)
+	if (!mbox->ops->send_request && mbox->txdone_poll)
 		hrtimer_cancel(&mbox->poll_hrt);
 
 	mutex_unlock(&con_mutex);
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 734694912ef7..2eb951fdee0b 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -9,6 +9,7 @@
 
 #include <linux/of.h>
 #include <linux/device.h>
+#include <linux/mailbox_request.h>
 
 struct mbox_chan;
 
@@ -47,4 +48,7 @@ void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
 bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
 void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
 
+int mbox_send_request(struct mbox_chan *chan, struct mbox_request *req);
+int mbox_wait_request(int err, struct mbox_wait *wait);
+
 #endif /* __MAILBOX_CLIENT_H */
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 6fee33cb52f5..0582964b10a0 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -8,6 +8,7 @@
 #include <linux/hrtimer.h>
 #include <linux/device.h>
 #include <linux/completion.h>
+#include <linux/mailbox_request.h>
 
 struct mbox_chan;
 
@@ -20,6 +21,10 @@ struct mbox_chan;
  *		transmission of data is reported by the controller via
  *		mbox_chan_txdone (if it has some TX ACK irq). It must not
  *		sleep.
+ * @send_request: The API asks the MBOX controller driver to transmit a message
+ *                on the bus. The call may be in atomic context. Returns
+ *                -EINPROGRESS if data is fed into hardware, -ENOSPC when the
+ *                hardware queue is full, or zero when the request completes.
  * @flush:	Called when a client requests transmissions to be blocking but
  *		the context doesn't allow sleeping. Typically the controller
  *		will implement a busy loop waiting for the data to flush out.
@@ -45,6 +50,7 @@ struct mbox_chan;
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
+	int (*send_request)(struct mbox_chan *chan, struct mbox_request *req);
 	int (*flush)(struct mbox_chan *chan, unsigned long timeout);
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);
@@ -131,6 +137,7 @@ int mbox_controller_register(struct mbox_controller *mbox); /* can sleep */
 void mbox_controller_unregister(struct mbox_controller *mbox); /* can sleep */
 void mbox_chan_received_data(struct mbox_chan *chan, void *data); /* atomic */
 void mbox_chan_txdone(struct mbox_chan *chan, int r); /* atomic */
+void mbox_request_complete(struct mbox_request *req, int err); /*can sleep */
 
 int devm_mbox_controller_register(struct device *dev,
 				  struct mbox_controller *mbox);
diff --git a/include/linux/mailbox_request.h b/include/linux/mailbox_request.h
new file mode 100644
index 000000000000..ea826adb31ac
--- /dev/null
+++ b/include/linux/mailbox_request.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __MAILBOX_REQUEST_H
+#define __MAILBOX_REQUEST_H
+
+#include <linux/types.h>
+#include <linux/completion.h>
+
+struct mbox_wait {
+	struct completion completion;
+	int err;
+};
+
+#define DECLARE_MBOX_WAIT(_wait) \
+	struct mbox_wait _wait = { \
+		COMPLETION_INITIALIZER_ONSTACK((_wait).completion), 0 }
+
+struct mbox_request {
+	void *tx;
+	void *rx;
+	struct mbox_wait *wait;
+};
+
+#endif /* __MAILBOX_H */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


