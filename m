Return-Path: <linux-kernel+bounces-554843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98998A5A1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCCF1893271
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC9A231A3B;
	Mon, 10 Mar 2025 18:08:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317C22AE7C;
	Mon, 10 Mar 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630111; cv=none; b=HsdXboKdrrJX+d7LtoRd4smQDbXOB5BdoWJnRZsdXV5N/ddQPyRJ9CVGICveVKRDzahThE2ZeHcA45hcgA9013pAZGqTmdKIcwfSGA2kKE6HUrAQET7LieAbq8gxG6sajEvj4jY0b1pJLXIbZz6uVXlYE/6Zj7rPgeoN18uMbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630111; c=relaxed/simple;
	bh=3QoDKJ2jdA4Jo7YpO2FWqrnftt8JeDxs6ksYF0O93QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHjZLVmiGAO/Pdm42SmmUb5ngxFuEnAHtgjd0p0ClLDbfItiNKa9YhEEJYLTIWChVSFnqOWbd7L0+A9t1uam1hgG10T972pg6qPr3S9T5hfXjZ6qQuHPAkt8BB10TxzIEfQfR5GxWIucsm4F0HfyYWm19tPRLQLlr7DOm9aYKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D60F1516;
	Mon, 10 Mar 2025 11:08:40 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07A5B3F673;
	Mon, 10 Mar 2025 11:08:27 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Add polling support to raw mode
Date: Mon, 10 Mar 2025 18:08:11 +0000
Message-ID: <20250310180811.1463539-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a couple of additional debugfs entries to enable polling-mode on
the waiting path of injected messages: message_poll will cause the system
to poll while waiting for the reply, while message_poll_async will send an
asynchronous message, as usual, and will use polling mode for the immediate
synchronous part of the async command.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Not sure if it is not better to unify all these common read/write entrypoint
into one single function that decide what to do based on the a strcmp of its
own filepath....seems still cleaner using these stupid wrappers to
diffrentiate between message_poll/message_poll_async etc etc
---
 Documentation/ABI/testing/debugfs-scmi-raw | 91 ++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c         |  3 +-
 drivers/firmware/arm_scmi/raw_mode.c       | 72 +++++++++++++++--
 3 files changed, 160 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/ABI/testing/debugfs-scmi-raw
index 97678cc9535c..5847b96b3896 100644
--- a/Documentation/ABI/testing/debugfs-scmi-raw
+++ b/Documentation/ABI/testing/debugfs-scmi-raw
@@ -31,6 +31,42 @@ Description:	SCMI Raw asynchronous message injection/snooping facility; write
 		(receiving an EOF at each message boundary).
 Users:		Debugging, any userspace test suite
 
+What:		/sys/kernel/debug/scmi/<n>/raw/message_poll
+Date:		June 2025
+KernelVersion:	6.16
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw message injection/snooping facility using polling mode;
+		write a complete SCMI command message (header included) in
+		little-endian binary format to have it sent to the configured
+		backend SCMI server for instance <n>, using polling mode on
+		the reception path. (if transport is polling capable)
+		Any subsequently received response can be read from this same
+		entry if it arrived within the configured timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/message_poll_async
+Date:		June 2025
+KernelVersion:	6.16
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw asynchronous message injection/snooping facility using
+		polling-mode; write a complete SCMI asynchronous command message
+		(header included) in little-endian binary format to have it sent
+		to the configured backend SCMI server for instance <n>, using
+		polling-mode on the reception path of the immediate part of the
+		asynchronous command. (if transport is polling capable)
+		Any subsequently received response can be read from this same
+		entry if it arrived within the configured timeout.
+		Any additional delayed response received afterwards can be read
+		from this same entry too if it arrived within the configured
+		timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+Users:		Debugging, any userspace test suite
+
 What:		/sys/kernel/debug/scmi/<n>/raw/errors
 Date:		March 2023
 KernelVersion:	6.3
@@ -115,3 +151,58 @@ Description:	SCMI Raw asynchronous message injection/snooping facility; write
 		exist only if the transport is configured to have more than
 		one default channel.
 Users:		Debugging, any userspace test suite
+
+
+What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message_poll
+Date:		June 2025
+KernelVersion:	6.16
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw message injection/snooping facility using polling mode;
+		write a complete SCMI command message (header included) in
+		little-endian binary format to have it sent to the configured
+		backend SCMI server for instance <n> through the <m> transport
+		channel, using polling mode on the reception path.
+		(if transport is polling capable)
+		Any subsequently received response can be read from this same
+		entry if it arrived on channel <m> within the configured
+		timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+		Channel identifier <m> matches the SCMI protocol number which
+		has been associated with this transport channel in the DT
+		description, with base protocol number 0x10 being the default
+		channel for this instance.
+		Note that these per-channel entries rooted at <..>/channels
+		exist only if the transport is configured to have more than
+		one default channel.
+Users:		Debugging, any userspace test suite
+
+What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message_poll_async
+Date:		June 2025
+KernelVersion:	6.16
+Contact:	cristian.marussi@arm.com
+Description:	SCMI Raw asynchronous message injection/snooping facility using
+		polling-mode; write a complete SCMI asynchronous command message
+		(header included) in little-endian binary format to have it sent
+		to the configured backend SCMI server for instance <n> through
+		the <m> transport channel, using polling mode on the reception
+		path of the immediate part of the asynchronous command.
+		(if transport is polling capable)
+		Any subsequently received response can be read from this same
+		entry if it arrived on channel <m> within the configured
+		timeout.
+		Any additional delayed response received afterwards can be read
+		from this same entry too if it arrived within the configured
+		timeout.
+		Each write to the entry causes one command request to be built
+		and sent while the replies are read back one message at time
+		(receiving an EOF at each message boundary).
+		Channel identifier <m> matches the SCMI protocol number which
+		has been associated with this transport channel in the DT
+		description, with base protocol number 0x10 being the default
+		channel for this instance.
+		Note that these per-channel entries rooted at <..>/channels
+		exist only if the transport is configured to have more than
+		one default channel.
+Users:		Debugging, any userspace test suite
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e6cf83950875..bf2dc200604e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1190,7 +1190,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		 * RX path since it will be already queued at the end of the TX
 		 * poll loop.
 		 */
-		if (!xfer->hdr.poll_completion)
+		if (!xfer->hdr.poll_completion ||
+		    xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
 			scmi_raw_message_report(info->raw, xfer,
 						SCMI_RAW_REPLY_QUEUE,
 						cinfo->id);
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 7cc0d616b8de..3d543b1d8947 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -671,11 +671,13 @@ static int scmi_do_xfer_raw_start(struct scmi_raw_mode_info *raw,
  * @len: Length of the message in @buf.
  * @chan_id: The channel ID to use.
  * @async: A flag stating if an asynchronous command is required.
+ * @poll: A flag stating if a polling transmission is required.
  *
  * Return: 0 on Success
  */
 static int scmi_raw_message_send(struct scmi_raw_mode_info *raw,
-				 void *buf, size_t len, u8 chan_id, bool async)
+				 void *buf, size_t len, u8 chan_id,
+				 bool async, bool poll)
 {
 	int ret;
 	struct scmi_xfer *xfer;
@@ -684,6 +686,16 @@ static int scmi_raw_message_send(struct scmi_raw_mode_info *raw,
 	if (ret)
 		return ret;
 
+	if (poll) {
+		if (is_transport_polling_capable(raw->desc)) {
+			xfer->hdr.poll_completion = true;
+		} else {
+			dev_err(raw->handle->dev,
+				"Failed to send RAW message - Polling NOT supported\n");
+			return -EINVAL;
+		}
+	}
+
 	ret = scmi_do_xfer_raw_start(raw, xfer, chan_id, async);
 	if (ret)
 		scmi_xfer_raw_put(raw->handle, xfer);
@@ -801,7 +813,7 @@ static ssize_t scmi_dbg_raw_mode_common_read(struct file *filp,
 static ssize_t scmi_dbg_raw_mode_common_write(struct file *filp,
 					      const char __user *buf,
 					      size_t count, loff_t *ppos,
-					      bool async)
+					      bool async, bool poll)
 {
 	int ret;
 	struct scmi_dbg_raw_data *rd = filp->private_data;
@@ -831,7 +843,7 @@ static ssize_t scmi_dbg_raw_mode_common_write(struct file *filp,
 	}
 
 	ret = scmi_raw_message_send(rd->raw, rd->tx.buf, rd->tx_size,
-				    rd->chan_id, async);
+				    rd->chan_id, async, poll);
 
 	/* Reset ppos for next message ... */
 	rd->tx_size = 0;
@@ -875,7 +887,8 @@ static ssize_t scmi_dbg_raw_mode_message_write(struct file *filp,
 					       const char __user *buf,
 					       size_t count, loff_t *ppos)
 {
-	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos, false);
+	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos,
+					      false, false);
 }
 
 static __poll_t scmi_dbg_raw_mode_message_poll(struct file *filp,
@@ -964,7 +977,8 @@ static ssize_t scmi_dbg_raw_mode_message_async_write(struct file *filp,
 						     const char __user *buf,
 						     size_t count, loff_t *ppos)
 {
-	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos, true);
+	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos,
+					      true, false);
 }
 
 static const struct file_operations scmi_dbg_raw_mode_message_async_fops = {
@@ -976,6 +990,40 @@ static const struct file_operations scmi_dbg_raw_mode_message_async_fops = {
 	.owner = THIS_MODULE,
 };
 
+static ssize_t scmi_dbg_raw_mode_message_poll_write(struct file *filp,
+						    const char __user *buf,
+						    size_t count, loff_t *ppos)
+{
+	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos,
+					      false, true);
+}
+
+static const struct file_operations scmi_dbg_raw_mode_message_poll_fops = {
+	.open = scmi_dbg_raw_mode_open,
+	.release = scmi_dbg_raw_mode_release,
+	.read = scmi_dbg_raw_mode_message_read,
+	.write = scmi_dbg_raw_mode_message_poll_write,
+	.poll = scmi_dbg_raw_mode_message_poll,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t scmi_dbg_raw_mode_message_poll_async_write(struct file *filp,
+							  const char __user *buf,
+							  size_t count, loff_t *ppos)
+{
+	return scmi_dbg_raw_mode_common_write(filp, buf, count, ppos,
+					      true, true);
+}
+
+static const struct file_operations scmi_dbg_raw_mode_message_poll_async_fops = {
+	.open = scmi_dbg_raw_mode_open,
+	.release = scmi_dbg_raw_mode_release,
+	.read = scmi_dbg_raw_mode_message_read,
+	.write = scmi_dbg_raw_mode_message_poll_async_write,
+	.poll = scmi_dbg_raw_mode_message_poll,
+	.owner = THIS_MODULE,
+};
+
 static ssize_t scmi_test_dbg_raw_mode_notif_read(struct file *filp,
 						 char __user *buf,
 						 size_t count, loff_t *ppos)
@@ -1199,6 +1247,12 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 	debugfs_create_file("message_async", 0600, raw->dentry, raw,
 			    &scmi_dbg_raw_mode_message_async_fops);
 
+	debugfs_create_file("message_poll", 0600, raw->dentry, raw,
+			    &scmi_dbg_raw_mode_message_poll_fops);
+
+	debugfs_create_file("message_poll_async", 0600, raw->dentry, raw,
+			    &scmi_dbg_raw_mode_message_poll_async_fops);
+
 	debugfs_create_file("notification", 0400, raw->dentry, raw,
 			    &scmi_dbg_raw_mode_notification_fops);
 
@@ -1230,6 +1284,14 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			debugfs_create_file_aux_num("message_async", 0600, chd,
 					    raw, channels[i],
 					    &scmi_dbg_raw_mode_message_async_fops);
+
+			debugfs_create_file_aux_num("message_poll", 0600, chd,
+						    raw, channels[i],
+						    &scmi_dbg_raw_mode_message_poll_fops);
+
+			debugfs_create_file_aux_num("message_poll_async", 0600,
+						    chd, raw, channels[i],
+						    &scmi_dbg_raw_mode_message_poll_async_fops);
 		}
 	}
 
-- 
2.47.0


