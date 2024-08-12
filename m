Return-Path: <linux-kernel+bounces-282479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBDC94E488
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101E21C20FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E767A0D;
	Mon, 12 Aug 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Ftb8xj+f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EuK/Fy7o"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493E22638
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723426980; cv=none; b=QDO+fqj7f2bHwK5RnsfafVaW092oajWSOrNEPDx6HkQGhCsZKHOA++YzJGcZ7OoisEc0RgDihzSgzAYxSu78lc7wcueOdhLNTgLm2ZwmsDZbGVCLKZk6w/CucHkc2k09hb4IcwKoAq2eOvtKKx758XV72L4zI5ThESrWiW+3Z8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723426980; c=relaxed/simple;
	bh=PYQ1jIab+DAWLIEOngr/G0WZ+P2lmVZYoE01Sx8SjiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp/Oc7xskv0aZe4+uYHsgfCFGwTa0Y59Tsgm0DdKRWEZp4CNGGH/dUFsZMcoZZgfxGd5hDHWdB7AvkiAYAmghDIQIQMqvo1n2JDEyIG9op/3c6jK84Q/CEhlximflec5vBuIUTM5btqscLotlD8jPRa6jwpXBsdhHlw+G83SURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Ftb8xj+f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EuK/Fy7o; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4C4A0138CCB0;
	Sun, 11 Aug 2024 21:42:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 11 Aug 2024 21:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723426977; x=
	1723513377; bh=d+Q8xmS6L9yVQUeDWKp7OwnnCRhmxeh/w4QcD6dPneg=; b=F
	tb8xj+fz5gAeltKKXo71CJsgc+Eer0cl1tywhxKkb0CAYWR807qrZKgfW+nHWCLt
	AGi4rZ0l/L/mXNuhqsSr9F4KNShGCAvc7sqhvjgj2evZtoyKYtl39UHkrsIuK3Sh
	jcixFH4wQX2pbwAtHgKTc8rp13ssZa/9u+J6kFSl8BweTMLITDZrD5F51akCGe0q
	5O5EnyEDkvu7rPkFcbjSHe4mfwoZyTctCDkGXGFkFpw6BUxSAnSO/awvoMEYkysv
	rLEjfmlSVjzWw+5JRrDJPFvFbPThHZ8lxksKrX+4eUZSvhiewDJNOWkvHm5BXN0i
	SYTFdE/JqYspkvAYg+Etg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723426977; x=
	1723513377; bh=d+Q8xmS6L9yVQUeDWKp7OwnnCRhmxeh/w4QcD6dPneg=; b=E
	uK/Fy7oAqLdKpnJtwbXlrqXII2WB3HfG01D9L2K03df3z4/1mPZKYjpV+bM/EPNf
	/0DJqqFwoJy11O3tlexCIeJ4X/he/W/91KGjLizR4eC6WQ0vOFle4cNw8NMOS/YK
	f+c9cjK+ZGkR78pQNOciTZYBtXxToF+UePSInzZ8TaN2/OAMxu0aO9o2mWGBRjW3
	Yf5/Z34rHCf/SfwfRrXDEtv4jrSho34AtXZnP5wuYxqAQXEuQUXBCtO9O8EK1ffz
	cgLwf/xDF+rTHguWO5m+9BQTJ/C/eLfrcsr+y9PdKAL1wlTYjeajM9Q1ULM7ZqJb
	oR1UjDKoCf0ba/5KOccOw==
X-ME-Sender: <xms:oWi5ZnD8yCu1pGo6mqRiTFnTzeziCmmIO90-DkDpKBEgZ2eQKoC4mQ>
    <xme:oWi5Ztg3llYDcX7T1QnBVPDiYf6DdWQ2Oy4g1tW17KFz_CN4Ov42COP8dQSDmIyd7
    sOW_eX6ldGXxTwmls4>
X-ME-Received: <xmr:oWi5ZikvopaskXT1vPjSwM4du6ugnVDg4ToDPaajGFJx6J66kgJ22z4kCmH8eVvGBSTrLPa5JJFDKrGMCm5m3POtpOu1eYH3Qq596u5LHWOn9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhho
    thhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrth
    htvghrnhepvdejgfejuedvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffek
    vddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepoh
    dqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlh
    eslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oWi5ZpxWHCbYzD68YXyZqFVJMfh141NnTWUzms47DDKTWoeMypxnwQ>
    <xmx:oWi5ZsTM9AurROQgxpDyF4e91ZEvsbJpC6x5fuQXftF_e_VOGM5MhQ>
    <xmx:oWi5ZsbjyUThU-_TCSEL5ojtSMHVKKWUvA4KMHad2QMbSMEGoKlSCw>
    <xmx:oWi5ZtRwv81JnWh1inBB6r7lI7G104xBdT2CQCo0nqL1ZhVaUedUbw>
    <xmx:oWi5Zncu26Zh7TDVVzHO2k0f2YJjWzFwoITj-h_w9LWkmkE49m-x_kKL>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Aug 2024 21:42:56 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: replace IDR with XArray to maintain fw_device
Date: Mon, 12 Aug 2024 10:42:50 +0900
Message-ID: <20240812014251.165492-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812014251.165492-1-o-takashi@sakamocchi.jp>
References: <20240812014251.165492-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In core function, the instances of fw_device corresponding to firewire device
node in system are maintained by IDR. As of kernel v6.0, IDR has been
superseded by XArray and deprecated.

This commit replaces the usage of IDR with XArray to maintain the device
instances. The instance of XArray is allocated statically, and
initialized with XA_FLAGS_ALLOC so that the index of allocated entry starts
with zero and available as the minor identifier of device node.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c      | 21 +++++++++++----------
 drivers/firewire/core-transaction.c |  3 +--
 drivers/firewire/core.h             |  3 ++-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index bec7e05f6ab8..9f3276aa463a 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/firewire.h>
 #include <linux/firewire-constants.h>
-#include <linux/idr.h>
 #include <linux/jiffies.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
@@ -813,7 +812,7 @@ static int shutdown_unit(struct device *device, void *data)
  */
 DECLARE_RWSEM(fw_device_rwsem);
 
-DEFINE_IDR(fw_device_idr);
+DEFINE_XARRAY_ALLOC(fw_device_xa);
 int fw_cdev_major;
 
 struct fw_device *fw_device_get_by_devt(dev_t devt)
@@ -822,7 +821,7 @@ struct fw_device *fw_device_get_by_devt(dev_t devt)
 
 	guard(rwsem_read)(&fw_device_rwsem);
 
-	device = idr_find(&fw_device_idr, MINOR(devt));
+	device = xa_load(&fw_device_xa, MINOR(devt));
 	if (device)
 		fw_device_get(device);
 
@@ -858,7 +857,6 @@ static void fw_device_shutdown(struct work_struct *work)
 {
 	struct fw_device *device =
 		container_of(work, struct fw_device, work.work);
-	int minor = MINOR(device->device.devt);
 
 	if (time_before64(get_jiffies_64(),
 			  device->card->reset_jiffies + SHUTDOWN_DELAY)
@@ -877,7 +875,7 @@ static void fw_device_shutdown(struct work_struct *work)
 	device_unregister(&device->device);
 
 	scoped_guard(rwsem_write, &fw_device_rwsem)
-		idr_remove(&fw_device_idr, minor);
+		xa_erase(&fw_device_xa, MINOR(device->device.devt));
 
 	fw_device_put(device);
 }
@@ -1049,7 +1047,8 @@ static void fw_device_init(struct work_struct *work)
 		container_of(work, struct fw_device, work.work);
 	struct fw_card *card = device->card;
 	struct device *revived_dev;
-	int minor, ret;
+	u32 minor;
+	int ret;
 
 	/*
 	 * All failure paths here set node->data to NULL, so that we
@@ -1087,9 +1086,11 @@ static void fw_device_init(struct work_struct *work)
 	device_initialize(&device->device);
 
 	fw_device_get(device);
+
 	scoped_guard(rwsem_write, &fw_device_rwsem) {
-		minor = idr_alloc(&fw_device_idr, device, 0, 1 << MINORBITS, GFP_KERNEL);
-		if (minor < 0)
+		// The index of allocated entry is used for minor identifier of device node.
+		ret = xa_alloc(&fw_device_xa, &minor, device, XA_LIMIT(0, MINORMASK), GFP_KERNEL);
+		if (ret < 0)
 			goto error;
 	}
 
@@ -1152,9 +1153,9 @@ static void fw_device_init(struct work_struct *work)
 
  error_with_cdev:
 	scoped_guard(rwsem_write, &fw_device_rwsem)
-		idr_remove(&fw_device_idr, minor);
+		xa_erase(&fw_device_xa, minor);
  error:
-	fw_device_put(device);		/* fw_device_idr's reference */
+	fw_device_put(device);		// fw_device_xa's reference.
 
 	put_device(&device->device);	/* our reference */
 }
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 14af84541e83..e141d24a7644 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -13,7 +13,6 @@
 #include <linux/firewire-constants.h>
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/idr.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -1359,7 +1358,7 @@ static void __exit fw_core_cleanup(void)
 	unregister_chrdev(fw_cdev_major, "firewire");
 	bus_unregister(&fw_bus_type);
 	destroy_workqueue(fw_workqueue);
-	idr_destroy(&fw_device_idr);
+	xa_destroy(&fw_device_xa);
 }
 
 module_init(fw_core_init);
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 189e15e6ba82..8cace026090c 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/mm_types.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
@@ -133,7 +134,7 @@ void fw_cdev_handle_phy_packet(struct fw_card *card, struct fw_packet *p);
 /* -device */
 
 extern struct rw_semaphore fw_device_rwsem;
-extern struct idr fw_device_idr;
+extern struct xarray fw_device_xa;
 extern int fw_cdev_major;
 
 static inline struct fw_device *fw_device_get(struct fw_device *device)
-- 
2.43.0


