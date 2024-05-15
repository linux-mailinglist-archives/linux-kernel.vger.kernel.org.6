Return-Path: <linux-kernel+bounces-179481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A868C6058
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91481F20F95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C63D387;
	Wed, 15 May 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="Czn1Vf/k"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577B3A1DC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752608; cv=none; b=kXL6itDgOhEpIoLEkGpDVYP0YEkpZbclHG7hEbuM/+vxPPcqHamaxWplcOSbbrtXC0QdfF3un1xvcLFWthxKHf2UKkU9PIY7cfM5o4nmDXibr1drxsV8avYyR9GmcKysB6Dceik6OhFzS8bofNoYLVPHivgDtc4IZ2D8MdDhQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752608; c=relaxed/simple;
	bh=cyeRO384dHW2MYT8JIo7DJOjR66vQqh8tFcczHx+8rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwB229JXlCzyUSS1uqjnayuppVFEPPJpfuHsM7n+BQRQdnVc8mO/mIpYxuWxW+6olVuQA4trGuuS5OyiFsaY6XBiVpZEqPwRVlQAuppc6fbiptU1i1kQyMxk8lHp2v2d1d73D9JqCmFHI0FA48enstxfY85AilQ25JP0I5noAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=Czn1Vf/k; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VfMtF1xkwz9sWh;
	Wed, 15 May 2024 07:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1715752597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE0nwydxMkHzvZi0deV/PjTpG5/LcNV3P0PFZ0iKdMg=;
	b=Czn1Vf/kNQofw9oV9gSoczcOlhh31UtC2XQV0HW7lHrke4hzdMvWQVnofFRAxaoYTI2O3t
	p5xHadh5IwuwEBIqCZ1tzhrIZj++COSBqaxAsV5X1XzxTQ3p4SfMkFYGx4uKQ1sbjP2mmj
	HIbLlHen3hDE/gd9YyECiURATcRjtsu9jyM0ljbw74VYDgVzducvX7nAG6F57Uyfjh4wRD
	2PahysHJJdBMK+HJHI6uK0V8sK71eUJk5z3yW7+g4xxMwE4+SEvx8MOIQrrQ1fbmmFzVS5
	umyNhXVEXJJ06tyi+mK8zCxyJ+4ONb+gPxTSwVEfcH60BORMTsj9dSs/ryPCkA==
From: Ben Walsh <ben@jubnut.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ben Walsh <ben@jubnut.com>
Subject: [PATCH 1/6] platform/chrome: cros_ec_lpc: MEC access can return error code
Date: Wed, 15 May 2024 06:56:26 +0100
Message-ID: <20240515055631.5775-2-ben@jubnut.com>
In-Reply-To: <20240515055631.5775-1-ben@jubnut.com>
References: <20240515055631.5775-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VfMtF1xkwz9sWh

cros_ec_lpc_io_bytes_mec was returning a u8 checksum of all bytes
read/written, which didn't leave room to indicate errors. Change this
u8 to an int where negative values indicate an error, and non-negative
values are the checksum as before.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc.c      | 148 ++++++++++++++-------
 drivers/platform/chrome/cros_ec_lpc_mec.c  |   9 +-
 drivers/platform/chrome/cros_ec_lpc_mec.h  |   7 +-
 drivers/platform/chrome/wilco_ec/mailbox.c |  22 +--
 4 files changed, 124 insertions(+), 62 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index ddfbfec44f4c..e638c7d82e22 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -62,14 +62,16 @@ struct cros_ec_lpc {
 
 /**
  * struct lpc_driver_ops - LPC driver operations
- * @read: Copy length bytes from EC address offset into buffer dest. Returns
- *        the 8-bit checksum of all bytes read.
- * @write: Copy length bytes from buffer msg into EC address offset. Returns
- *         the 8-bit checksum of all bytes written.
+ * @read: Copy length bytes from EC address offset into buffer dest.
+ *        Returns a negative error code on error, or the 8-bit checksum
+ *        of all bytes read.
+ * @write: Copy length bytes from buffer msg into EC address offset.
+ *         Returns a negative error code on error, or the 8-bit checksum
+ *         of all bytes written.
  */
 struct lpc_driver_ops {
-	u8 (*read)(unsigned int offset, unsigned int length, u8 *dest);
-	u8 (*write)(unsigned int offset, unsigned int length, const u8 *msg);
+	int (*read)(unsigned int offset, unsigned int length, u8 *dest);
+	int (*write)(unsigned int offset, unsigned int length, const u8 *msg);
 };
 
 static struct lpc_driver_ops cros_ec_lpc_ops = { };
@@ -78,10 +80,10 @@ static struct lpc_driver_ops cros_ec_lpc_ops = { };
  * A generic instance of the read function of struct lpc_driver_ops, used for
  * the LPC EC.
  */
-static u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length,
-				 u8 *dest)
+static int cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length,
+				  u8 *dest)
 {
-	int sum = 0;
+	u8 sum = 0;
 	int i;
 
 	for (i = 0; i < length; ++i) {
@@ -97,10 +99,10 @@ static u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length,
  * A generic instance of the write function of struct lpc_driver_ops, used for
  * the LPC EC.
  */
-static u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
-				  const u8 *msg)
+static int cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
+				   const u8 *msg)
 {
-	int sum = 0;
+	u8 sum = 0;
 	int i;
 
 	for (i = 0; i < length; ++i) {
@@ -116,14 +118,19 @@ static u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length,
  * An instance of the read function of struct lpc_driver_ops, used for the
  * MEC variant of LPC EC.
  */
-static u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
-				     u8 *dest)
+static int cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
+				      u8 *dest)
 {
-	int in_range = cros_ec_lpc_mec_in_range(offset, length);
+	int in_range;
 
-	if (in_range < 0)
+	if (length == 0)
 		return 0;
 
+	in_range = cros_ec_lpc_mec_in_range(offset, length);
+
+	if (in_range < 0)
+		return in_range;
+
 	return in_range ?
 		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
 					 offset - EC_HOST_CMD_REGION0,
@@ -135,14 +142,19 @@ static u8 cros_ec_lpc_mec_read_bytes(unsigned int offset, unsigned int length,
  * An instance of the write function of struct lpc_driver_ops, used for the
  * MEC variant of LPC EC.
  */
-static u8 cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
-				      const u8 *msg)
+static int cros_ec_lpc_mec_write_bytes(unsigned int offset, unsigned int length,
+				       const u8 *msg)
 {
-	int in_range = cros_ec_lpc_mec_in_range(offset, length);
+	int in_range;
 
-	if (in_range < 0)
+	if (length == 0)
 		return 0;
 
+	in_range = cros_ec_lpc_mec_in_range(offset, length);
+
+	if (in_range < 0)
+		return in_range;
+
 	return in_range ?
 		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
 					 offset - EC_HOST_CMD_REGION0,
@@ -154,11 +166,14 @@ static int ec_response_timed_out(void)
 {
 	unsigned long one_second = jiffies + HZ;
 	u8 data;
+	int ret;
 
 	usleep_range(200, 300);
 	do {
-		if (!(cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_CMD, 1, &data) &
-		    EC_LPC_STATUS_BUSY_MASK))
+		ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_CMD, 1, &data);
+		if (ret < 0)
+			return ret;
+		if (!(data & EC_LPC_STATUS_BUSY_MASK))
 			return 0;
 		usleep_range(100, 200);
 	} while (time_before(jiffies, one_second));
@@ -179,28 +194,41 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 		goto done;
 
 	/* Write buffer */
-	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
+	ret = cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
+	if (ret < 0)
+		goto done;
 
 	/* Here we go */
 	sum = EC_COMMAND_PROTOCOL_3;
-	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
+	ret = cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
+	if (ret < 0)
+		goto done;
 
-	if (ec_response_timed_out()) {
+	ret = ec_response_timed_out();
+	if (ret < 0)
+		goto done;
+	if (ret) {
 		dev_warn(ec->dev, "EC response timed out\n");
 		ret = -EIO;
 		goto done;
 	}
 
 	/* Check result */
-	msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
+	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
+	if (ret < 0)
+		goto done;
+	msg->result = sum;
 	ret = cros_ec_check_result(ec, msg);
 	if (ret)
 		goto done;
 
 	/* Read back response */
 	dout = (u8 *)&response;
-	sum = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
+	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET, sizeof(response),
 				   dout);
+	if (ret < 0)
+		goto done;
+	sum = ret;
 
 	msg->result = response.result;
 
@@ -213,9 +241,12 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 	}
 
 	/* Read response and process checksum */
-	sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET +
-				    sizeof(response), response.data_len,
-				    msg->data);
+	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PACKET +
+				   sizeof(response), response.data_len,
+				   msg->data);
+	if (ret < 0)
+		goto done;
+	sum += ret;
 
 	if (sum) {
 		dev_err(ec->dev,
@@ -255,32 +286,47 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
 	sum = msg->command + args.flags + args.command_version + args.data_size;
 
 	/* Copy data and update checksum */
-	sum += cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
-				     msg->data);
+	ret = cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PARAM, msg->outsize,
+				    msg->data);
+	if (ret < 0)
+		goto done;
+	sum += ret;
 
 	/* Finalize checksum and write args */
 	args.checksum = sum;
-	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
-			      (u8 *)&args);
+	ret = cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_ARGS, sizeof(args),
+				    (u8 *)&args);
+	if (ret < 0)
+		goto done;
 
 	/* Here we go */
 	sum = msg->command;
-	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
+	ret = cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
+	if (ret < 0)
+		goto done;
 
-	if (ec_response_timed_out()) {
+	ret = ec_response_timed_out();
+	if (ret < 0)
+		goto done;
+	if (ret) {
 		dev_warn(ec->dev, "EC response timed out\n");
 		ret = -EIO;
 		goto done;
 	}
 
 	/* Check result */
-	msg->result = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
+	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_DATA, 1, &sum);
+	if (ret < 0)
+		goto done;
+	msg->result = sum;
 	ret = cros_ec_check_result(ec, msg);
 	if (ret)
 		goto done;
 
 	/* Read back args */
-	cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_ARGS, sizeof(args), (u8 *)&args);
+	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_ARGS, sizeof(args), (u8 *)&args);
+	if (ret < 0)
+		goto done;
 
 	if (args.data_size > msg->insize) {
 		dev_err(ec->dev,
@@ -294,8 +340,11 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
 	sum = msg->command + args.flags + args.command_version + args.data_size;
 
 	/* Read response and update checksum */
-	sum += cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PARAM, args.data_size,
-				    msg->data);
+	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PARAM, args.data_size,
+				   msg->data);
+	if (ret < 0)
+		goto done;
+	sum += ret;
 
 	/* Verify checksum */
 	if (args.checksum != sum) {
@@ -320,19 +369,24 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
 	int i = offset;
 	char *s = dest;
 	int cnt = 0;
+	int ret;
 
 	if (offset >= EC_MEMMAP_SIZE - bytes)
 		return -EINVAL;
 
 	/* fixed length */
 	if (bytes) {
-		cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + offset, bytes, s);
+		ret = cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + offset, bytes, s);
+		if (ret < 0)
+			return ret;
 		return bytes;
 	}
 
 	/* string */
 	for (; i < EC_MEMMAP_SIZE; i++, s++) {
-		cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + i, 1, s);
+		ret = cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + i, 1, s);
+		if (ret < 0)
+			return ret;
 		cnt++;
 		if (!*s)
 			break;
@@ -425,8 +479,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	 */
 	cros_ec_lpc_ops.read = cros_ec_lpc_mec_read_bytes;
 	cros_ec_lpc_ops.write = cros_ec_lpc_mec_write_bytes;
-	cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
-	if (buf[0] != 'E' || buf[1] != 'C') {
+	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
+	if (ret < 0 || buf[0] != 'E' || buf[1] != 'C') {
 		if (!devm_request_region(dev, ec_lpc->mmio_memory_base, EC_MEMMAP_SIZE,
 					 dev_name(dev))) {
 			dev_err(dev, "couldn't reserve memmap region\n");
@@ -436,9 +490,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 		/* Re-assign read/write operations for the non MEC variant */
 		cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
 		cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
-		cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + EC_MEMMAP_ID, 2,
-				     buf);
-		if (buf[0] != 'E' || buf[1] != 'C') {
+		ret = cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + EC_MEMMAP_ID, 2,
+					   buf);
+		if (ret < 0 || buf[0] != 'E' || buf[1] != 'C') {
 			dev_err(dev, "EC ID not detected\n");
 			return -ENODEV;
 		}
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index 0d9c79b270ce..395dc3a6fb5e 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -67,11 +67,12 @@ int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
  * @length:  Number of bytes to read / write
  * @buf:     Destination / source buffer
  *
- * Return: 8-bit checksum of all bytes read / written
+ * @return:  A negative error code on error, or 8-bit checksum of all
+ *           bytes read / written
  */
-u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
-			    unsigned int offset, unsigned int length,
-			    u8 *buf)
+int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
+			     unsigned int offset, unsigned int length,
+			     u8 *buf)
 {
 	int i = 0;
 	int io_addr;
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
index 9d0521b23e8a..69670832f187 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.h
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
@@ -64,9 +64,10 @@ int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length);
  * @length:  Number of bytes to read / write
  * @buf:     Destination / source buffer
  *
- * @return 8-bit checksum of all bytes read / written
+ * @return:  A negative error code on error, or 8-bit checksum of all
+ *           bytes read / written
  */
-u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
-			    unsigned int offset, unsigned int length, u8 *buf);
+int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
+			     unsigned int offset, unsigned int length, u8 *buf);
 
 #endif /* __CROS_EC_LPC_MEC_H */
diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index 0f98358ea824..4d8273b47cde 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -117,13 +117,17 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
 			     struct wilco_ec_request *rq)
 {
 	struct wilco_ec_response *rs;
-	u8 checksum;
+	int ret;
 	u8 flag;
 
 	/* Write request header, then data */
-	cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, 0, sizeof(*rq), (u8 *)rq);
-	cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, sizeof(*rq), msg->request_size,
-				 msg->request_data);
+	ret = cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, 0, sizeof(*rq), (u8 *)rq);
+	if (ret < 0)
+		return ret;
+	ret = cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, sizeof(*rq), msg->request_size,
+				       msg->request_data);
+	if (ret < 0)
+		return ret;
 
 	/* Start the command */
 	outb(EC_MAILBOX_START_COMMAND, ec->io_command->start);
@@ -149,10 +153,12 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
 
 	/* Read back response */
 	rs = ec->data_buffer;
-	checksum = cros_ec_lpc_io_bytes_mec(MEC_IO_READ, 0,
-					    sizeof(*rs) + EC_MAILBOX_DATA_SIZE,
-					    (u8 *)rs);
-	if (checksum) {
+	ret = cros_ec_lpc_io_bytes_mec(MEC_IO_READ, 0,
+				       sizeof(*rs) + EC_MAILBOX_DATA_SIZE,
+				       (u8 *)rs);
+	if (ret < 0)
+		return ret;
+	if (ret) {
 		dev_dbg(ec->dev, "bad packet checksum 0x%02x\n", rs->checksum);
 		return -EBADMSG;
 	}
-- 
2.45.0


