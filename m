Return-Path: <linux-kernel+bounces-273845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC08946EE1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D404B218D9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459D66BFA5;
	Sun,  4 Aug 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cL5A5xKh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8VvpyGv"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532694D8DA
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776560; cv=none; b=Ke2mJpk/oPXu/RUaKf6cJeqNxrf0/W4UCIEYf45WUovB0DRq0ZrnErE2ovHUBjHgnKwEw2i+qVnUXwm1MSYYv8JYL/6hsfZWk5Azy64iDBFM6LxRhdukeYTtd0dCNYjlTqtTrArLuEzty8F7bfmIdT+pzSyILXqouRU2OxBOFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776560; c=relaxed/simple;
	bh=6gNVdCbKVSjJWTIrAa6h7j/OsYRdI7mtMVNyParzw+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgXfB38BgQOTj6mOS7tX2zLfMD5LMx+/bcq2G6TtQGPcJJ5SEsPL5G11Tv4sQFgRSupbgrw/wtcZow1M800nnhQN3m8E1sf9DNsQyEXwGtYSIO6P10HJL4ecSfOVvmd0SwjgTKTRT4pgEE7nCxrlFvW3u/PewhfXj9+U/WkyJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cL5A5xKh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8VvpyGv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 97F641388037;
	Sun,  4 Aug 2024 09:02:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 09:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776557; x=
	1722862957; bh=GZl0F95VKdVRmO/VEzrXjIFDoXhwf1ZOuWhytnJzBf0=; b=c
	L5A5xKhX5dT1ywGHYqCCxW6xxlGDrgTd2HK44i6NLyvaZSHfXwMSmL8/HY3AjX1P
	lGWQ85TWXeEujVwbovv9TprvDHewcJhYJ+LfJGkOeK7vwqViKXGY3i9AhE3bW+pQ
	2necELC5gHSct9W9BuRa7N5QErfGI8EXduEg7W/oKkscDxLlyUx4BawNsMHqctLo
	VlDE6tcyuhDpBC3/2Qp5yGl8pka92UlMN03HtRf1NwMaeofaeI4S7U9AlgHb7T+y
	sHflI0uz5sWxKina1BDAUEEcDIsSw+YDA6afon4mtX7z1qnGIowONnz7THJk0lOF
	vakSVcY5GlNxOBGX75xvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776557; x=
	1722862957; bh=GZl0F95VKdVRmO/VEzrXjIFDoXhwf1ZOuWhytnJzBf0=; b=X
	8VvpyGvcHY+3vX1J0lvikQBPWE43DUFODQMp27ipV+NO+Z0QRAAo55DUoyMc167r
	CBaqzed5Wi7uHbfpFQ8C8gqHox5xy5MHW8BRDs5036OhcnuSE/EgdhEUl7yKYWdx
	IC3d5REEuMKywaHBBdd4o1znyIuHpa8R68hKrza+DZ/hwj+BtUXRQjyWEAda6xkX
	ov88pRcof4L+9+ucTr8cZnvSdekU+irCnC6F6arANw8INrdZAPmod6+PmCXKpSEs
	gLYOqsVfT3CCu2V96kh6NhQamwOGER+D7u7Lnw71n+tE0p8YBhQ4qZ3R1k+3/LTa
	/qkAwO82eSW0hWvqCpOUg==
X-ME-Sender: <xms:7XuvZiXL3eFvQj5PhG4xmczF-3Rj5f6WEgGWs5n0yPIhFesi0fhFpA>
    <xme:7XuvZunYBBRE9DmDiK-jqa8R1rvAi2ipwTMb_P19dcaRusZovfTXBvNKrdlAclvzG
    IyZNS4aTsAIn2RnN9A>
X-ME-Received: <xmr:7XuvZmYJHt0Ojxnb3joUwgOuxP-MHb0VNIwWCncQvj2p1AFK1vw-87_78sd-VP3CzoCADnkJC14AZYw6IgFI40L1B4eyNgUQUmZ3u9GITItpwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:7XuvZpUQJ4XIJUYi68tHaQFo4snLMLl0e7o7NzFiw8dQb3g2aMF0ug>
    <xmx:7XuvZsmxJ4bu-qPdeadYfbFWfvJAgHrpOSRmsUSl5q4D2QRhXmXr1Q>
    <xmx:7XuvZufk03wK0t0Q1amifo2PR2DNZFx3xFSghtIqkUkOIe9tE-NzQw>
    <xmx:7XuvZuGRcU9Y9OjcI6hSw4TfUThWcpGs7dFUNa_wdWVKledmGBLu9w>
    <xmx:7XuvZhzPYThSAl4QyTKFuF3QnpBndcZ3lEAQYBtsMNMhEvRo1RRSpp5e>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:36 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] firewire: core: use guard macro to access to IDR for fw_device
Date: Sun,  4 Aug 2024 22:02:13 +0900
Message-ID: <20240804130225.243496-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
References: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core function maintains the instance of fw_device structure by IDR.
The concurrent access to IDR is protected by static read/write semaphore.
The semaphore is also utilized to protect concurrent access to the
content of configuration ROM cached to the instance so that the cache is
swapped to the latest one.

This commit uses guard macro to maintain the mutex.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c   | 25 +++++-------
 drivers/firewire/core-device.c | 73 +++++++++++++++-------------------
 2 files changed, 42 insertions(+), 56 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index a51aabb963fb..c3baf688bb70 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -454,21 +454,18 @@ static int ioctl_get_info(struct client *client, union ioctl_arg *arg)
 	a->version = FW_CDEV_KERNEL_VERSION;
 	a->card = client->device->card->index;
 
-	down_read(&fw_device_rwsem);
-
-	if (a->rom != 0) {
-		size_t want = a->rom_length;
-		size_t have = client->device->config_rom_length * 4;
-
-		ret = copy_to_user(u64_to_uptr(a->rom),
-				   client->device->config_rom, min(want, have));
+	scoped_guard(rwsem_read, &fw_device_rwsem) {
+		if (a->rom != 0) {
+			size_t want = a->rom_length;
+			size_t have = client->device->config_rom_length * 4;
+
+			ret = copy_to_user(u64_to_uptr(a->rom), client->device->config_rom,
+					   min(want, have));
+			if (ret != 0)
+				return -EFAULT;
+		}
+		a->rom_length = client->device->config_rom_length * 4;
 	}
-	a->rom_length = client->device->config_rom_length * 4;
-
-	up_read(&fw_device_rwsem);
-
-	if (ret != 0)
-		return -EFAULT;
 
 	guard(mutex)(&client->device->client_list_mutex);
 
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 00e9a13e6c45..d695ec2f1efe 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -288,7 +288,7 @@ static ssize_t show_immediate(struct device *dev,
 	const u32 *directories[] = {NULL, NULL};
 	int i, value = -1;
 
-	down_read(&fw_device_rwsem);
+	guard(rwsem_read)(&fw_device_rwsem);
 
 	if (is_fw_unit(dev)) {
 		directories[0] = fw_unit(dev)->directory;
@@ -317,8 +317,6 @@ static ssize_t show_immediate(struct device *dev,
 		}
 	}
 
-	up_read(&fw_device_rwsem);
-
 	if (value < 0)
 		return -ENOENT;
 
@@ -339,7 +337,7 @@ static ssize_t show_text_leaf(struct device *dev,
 	char dummy_buf[2];
 	int i, ret = -ENOENT;
 
-	down_read(&fw_device_rwsem);
+	guard(rwsem_read)(&fw_device_rwsem);
 
 	if (is_fw_unit(dev)) {
 		directories[0] = fw_unit(dev)->directory;
@@ -382,15 +380,14 @@ static ssize_t show_text_leaf(struct device *dev,
 		}
 	}
 
-	if (ret >= 0) {
-		/* Strip trailing whitespace and add newline. */
-		while (ret > 0 && isspace(buf[ret - 1]))
-			ret--;
-		strcpy(buf + ret, "\n");
-		ret++;
-	}
+	if (ret < 0)
+		return ret;
 
-	up_read(&fw_device_rwsem);
+	// Strip trailing whitespace and add newline.
+	while (ret > 0 && isspace(buf[ret - 1]))
+		ret--;
+	strcpy(buf + ret, "\n");
+	ret++;
 
 	return ret;
 }
@@ -466,10 +463,10 @@ static ssize_t config_rom_show(struct device *dev,
 	struct fw_device *device = fw_device(dev);
 	size_t length;
 
-	down_read(&fw_device_rwsem);
+	guard(rwsem_read)(&fw_device_rwsem);
+
 	length = device->config_rom_length * 4;
 	memcpy(buf, device->config_rom, length);
-	up_read(&fw_device_rwsem);
 
 	return length;
 }
@@ -478,13 +475,10 @@ static ssize_t guid_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct fw_device *device = fw_device(dev);
-	int ret;
 
-	down_read(&fw_device_rwsem);
-	ret = sysfs_emit(buf, "0x%08x%08x\n", device->config_rom[3], device->config_rom[4]);
-	up_read(&fw_device_rwsem);
+	guard(rwsem_read)(&fw_device_rwsem);
 
-	return ret;
+	return sysfs_emit(buf, "0x%08x%08x\n", device->config_rom[3], device->config_rom[4]);
 }
 
 static ssize_t is_local_show(struct device *dev,
@@ -524,7 +518,8 @@ static ssize_t units_show(struct device *dev,
 	struct fw_csr_iterator ci;
 	int key, value, i = 0;
 
-	down_read(&fw_device_rwsem);
+	guard(rwsem_read)(&fw_device_rwsem);
+
 	fw_csr_iterator_init(&ci, &device->config_rom[ROOT_DIR_OFFSET]);
 	while (fw_csr_iterator_next(&ci, &key, &value)) {
 		if (key != (CSR_UNIT | CSR_DIRECTORY))
@@ -533,7 +528,6 @@ static ssize_t units_show(struct device *dev,
 		if (i >= PAGE_SIZE - (8 + 1 + 8 + 1))
 			break;
 	}
-	up_read(&fw_device_rwsem);
 
 	if (i)
 		buf[i - 1] = '\n';
@@ -729,10 +723,10 @@ static int read_config_rom(struct fw_device *device, int generation)
 		goto out;
 	}
 
-	down_write(&fw_device_rwsem);
-	device->config_rom = new_rom;
-	device->config_rom_length = length;
-	up_write(&fw_device_rwsem);
+	scoped_guard(rwsem_write, &fw_device_rwsem) {
+		device->config_rom = new_rom;
+		device->config_rom_length = length;
+	}
 
 	kfree(old_rom);
 	ret = RCODE_COMPLETE;
@@ -826,11 +820,11 @@ struct fw_device *fw_device_get_by_devt(dev_t devt)
 {
 	struct fw_device *device;
 
-	down_read(&fw_device_rwsem);
+	guard(rwsem_read)(&fw_device_rwsem);
+
 	device = idr_find(&fw_device_idr, MINOR(devt));
 	if (device)
 		fw_device_get(device);
-	up_read(&fw_device_rwsem);
 
 	return device;
 }
@@ -882,9 +876,8 @@ static void fw_device_shutdown(struct work_struct *work)
 	device_for_each_child(&device->device, NULL, shutdown_unit);
 	device_unregister(&device->device);
 
-	down_write(&fw_device_rwsem);
-	idr_remove(&fw_device_idr, minor);
-	up_write(&fw_device_rwsem);
+	scoped_guard(rwsem_write, &fw_device_rwsem)
+		idr_remove(&fw_device_idr, minor);
 
 	fw_device_put(device);
 }
@@ -958,7 +951,7 @@ static int lookup_existing_device(struct device *dev, void *data)
 	if (!is_fw_device(dev))
 		return 0;
 
-	down_read(&fw_device_rwsem); /* serialize config_rom access */
+	guard(rwsem_read)(&fw_device_rwsem); // serialize config_rom access
 	spin_lock_irq(&card->lock);  /* serialize node access */
 
 	if (memcmp(old->config_rom, new->config_rom, 6 * 4) == 0 &&
@@ -990,7 +983,6 @@ static int lookup_existing_device(struct device *dev, void *data)
 	}
 
 	spin_unlock_irq(&card->lock);
-	up_read(&fw_device_rwsem);
 
 	return match;
 }
@@ -1099,13 +1091,11 @@ static void fw_device_init(struct work_struct *work)
 	device_initialize(&device->device);
 
 	fw_device_get(device);
-	down_write(&fw_device_rwsem);
-	minor = idr_alloc(&fw_device_idr, device, 0, 1 << MINORBITS,
-			GFP_KERNEL);
-	up_write(&fw_device_rwsem);
-
-	if (minor < 0)
-		goto error;
+	scoped_guard(rwsem_write, &fw_device_rwsem) {
+		minor = idr_alloc(&fw_device_idr, device, 0, 1 << MINORBITS, GFP_KERNEL);
+		if (minor < 0)
+			goto error;
+	}
 
 	device->device.bus = &fw_bus_type;
 	device->device.type = &fw_device_type;
@@ -1165,9 +1155,8 @@ static void fw_device_init(struct work_struct *work)
 	return;
 
  error_with_cdev:
-	down_write(&fw_device_rwsem);
-	idr_remove(&fw_device_idr, minor);
-	up_write(&fw_device_rwsem);
+	scoped_guard(rwsem_write, &fw_device_rwsem)
+		idr_remove(&fw_device_idr, minor);
  error:
 	fw_device_put(device);		/* fw_device_idr's reference */
 
-- 
2.43.0


