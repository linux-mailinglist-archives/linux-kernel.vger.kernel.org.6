Return-Path: <linux-kernel+bounces-297950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1388D95BF86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A65B2379F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E0A1D1F40;
	Thu, 22 Aug 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8EiFFgH"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62851D0DFF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358500; cv=none; b=sI0kkQ9e/rIkc4pmf2dFm9BGn6jn6otipoqSISEj2oL5s/0+z1trgRdNXy9cFuLuk7hNJP4oQfagcd6I1KFXMAO43zqwhHLN/wSqAMr8AGtQ18u4B0e1Ad6H3yvsYOUCkaT/xJopLtEmtwoJrFlCFtec9Vku8U+DPWZNH/F5sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358500; c=relaxed/simple;
	bh=czV01+a0eIjwfx1grTpqwzCDJjgn31W9N6Mn8Nhx8oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUjS2xRJ5JfgbNHJxU3rn5e07uC6XWtgNz8QGFtuOT6lF+z6LFxrV49ojsYx8B2s3HaMUI8mgyxl7UuIP1CL8A85UvLe8huOnX6rhdEfxng5Gf4CeTaQ3F5yQ7GvyVl3j24u4ZK3epU4cN7j9gA6B8Dmq51cUYBBxmuWtOEW5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8EiFFgH; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-709485aca4bso870820a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358497; x=1724963297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN9Dqeft6D+8f3HlmvNpHrHmxwq4si7sL5spWhZXP/0=;
        b=S8EiFFgHneV7/CBh9PTl60+wpXUNJTF0ggyN3z555UXaXoNeAwVlBzbLbOASyVZ1Zo
         oECo611gc1XG6pv6Et+5L06GWmr3BXOlWdUd5eG6gxV8p9MqNCrzjaGtTqLxMZ9FVisH
         K8i8VQT1V1ULpF4ndFESnnPgYhXdN8T1Xo6pFzw+4owTFqh8fLRvrUVqJZsnFxWwXsHP
         a1eRCq2Q6l750eSNFuxLonXPEUglESdX23v6eIWmdvck9CMjtpeJprEiauPK3J2VNWoD
         9tANHK1QxC6aWEqXN4yK98dwQNDjOUmuMh+nPeXZB7SR9oVwwAgNBZwwaElGIDVXRfl9
         UqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358497; x=1724963297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN9Dqeft6D+8f3HlmvNpHrHmxwq4si7sL5spWhZXP/0=;
        b=Xib+MjeaIfEj+3P5CD+uvI0kxIeCQ4trg3KElCprGOIULOc2wh2R3zmOGHLFcS64l6
         B3iwjyI2C5wUunNNOmG2rjIJmR4Ts7eqNdU6PPxb/++aIWP8SJbBd03ulk69gZpnMs52
         UPxY7z5n1IhnRjBPOdSQUd6D5G5px8+txXdJCW0D3bhqFLONio20zN4bjrtTZxCeYudu
         1uie6htA8GVkZI5zoChACblGOF8uO2M6FQ0U9BfcRQ9UPhI7Yo4/neaD9gDtFfniDflr
         nIrwLsJNpM92n8pHu41XDmhqES+kwrPJIa+DjAh5rihoN8q2vkjh8LeMVWbnf67giMH0
         F/ww==
X-Gm-Message-State: AOJu0Yy65d3kz3K2MErssmPgTtuZX4in6YEMcf4YZCZXWcgyQJkQ8tkc
	Ap/lq21DW5Cg0kY8qO4pAwICxoisUl0jO1vJidUP9h7rO4YFT35X1XTxZfNE
X-Google-Smtp-Source: AGHT+IGVMGaJf5A17/+BmjJ2vW4XtZLorWv8OhPuJs/pRN8TEJbUI0Rv/UopCyIInmLEHWlKrzkavA==
X-Received: by 2002:a54:4393:0:b0:3d9:245c:422e with SMTP id 5614622812f47-3de2a869a43mr21710b6e.21.1724358497424;
        Thu, 22 Aug 2024 13:28:17 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:17 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 3/4] driver core: shut down devices asynchronously
Date: Thu, 22 Aug 2024 15:28:04 -0500
Message-Id: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add code to allow asynchronous shutdown of devices, ensuring that each
device is shut down before its parents & suppliers.

Only devices with drivers that have async_shutdown_enable enabled will be
shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/base.h           |  4 +++
 drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |  2 ++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0b53593372d7..aa5a2bd3f2b8 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,6 +10,7 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+#include <linux/async.h>
 #include <linux/notifier.h>
 
 /**
@@ -97,6 +98,8 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @shutdown_after - used during device shutdown to ensure correct shutdown
+ *	ordering.
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -114,6 +117,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	async_cookie_t shutdown_after;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7e50daa65ca0..dd3652ea56fe 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -3531,6 +3532,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4781,6 +4783,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4816,12 +4820,34 @@ static void shutdown_one_device(struct device *dev)
 		put_device(dev->parent);
 }
 
+/**
+ * shutdown_one_device_async
+ * @data: the pointer to the struct device to be shutdown
+ * @cookie: not used
+ *
+ * Shuts down one device, after waiting for shutdown_after to complete.
+ * shutdown_after should be set to the cookie of the last child or consumer
+ * of this device to be shutdown (if any), or to the cookie of the previous
+ * device to be shut down for devices that don't enable asynchronous shutdown.
+ */
+static void shutdown_one_device_async(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+
+	async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
+
+	shutdown_one_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	async_cookie_t cookie = 0;
+	struct device_link *link;
+	int idx;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4852,11 +4878,37 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		shutdown_one_device(dev);
+
+		/*
+		 * Set cookie for devices that will be shut down synchronously
+		 */
+		if (!dev->driver || !dev->driver->async_shutdown_enable)
+			dev->p->shutdown_after = cookie;
+
+		get_device(dev);
+		get_device(parent);
+
+		cookie = async_schedule_domain(shutdown_one_device_async,
+					       dev, &sd_domain);
+		/*
+		 * Ensure parent & suppliers wait for this device to shut down
+		 */
+		if (parent) {
+			parent->p->shutdown_after = cookie;
+			put_device(parent);
+		}
+
+		idx = device_links_read_lock();
+		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
+			link->supplier->p->shutdown_after = cookie;
+		device_links_read_unlock(idx);
+		put_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&sd_domain);
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 1fc8b68786de..2b6127faaa25 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -56,6 +56,7 @@ enum probe_type {
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
+ * @async_shutdown_enable: Enables devices to be shutdown asynchronously.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
  * @probe:	Called to query the existence of a specific device,
@@ -102,6 +103,7 @@ struct device_driver {
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
 	enum probe_type probe_type;
+	bool async_shutdown_enable;
 
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
-- 
2.39.3


