Return-Path: <linux-kernel+bounces-231419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C2919881
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A69B22744
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18519192B8A;
	Wed, 26 Jun 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8ac2TrO"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A61119307D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431237; cv=none; b=nyCoIW4/HHArD+r70RbX3WPPm6PVHC0LNh7aNcBTCxPKhN+2qPrck3JMk4XD1rLqYSSggKBH2y/z48T4IZ7/lGpPG+k9khNPoTVSUhc7TKJkjL+95DOdYCCOE32fdNRzkQ4nnY+24R7bvewRWV9eBt3PgTRYZE9Q32y4wzm/Yuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431237; c=relaxed/simple;
	bh=i3WX7/RSaA4I81jbiK9gsiNoB5j4kNcBfACp8dfK87A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AzZzw/9Zb9loSUT+kmhD2dEYBkgLYOQO1w9V10wEoWaYRAsLXK7BKkGVUH9Kpw5pHZupzBmRMVwnXJK5p0m65ksb4gUUrluXfzp0ucaZOL9H1M0E4z3yQYbGtOT3L17+2bvwNFyjy5ygLtM9WalrOYvi/f1F4bpyBy32RgjcVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8ac2TrO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso7090795276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431234; x=1720036034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng2WmGXQZql1jDXPW/vYyFeh8nYeJu3JtauFqQLagBk=;
        b=D8ac2TrOqfRqXExLXZhD1TZAlo/JV2UvSgYDTxbbZBtyGXaV1Cn6o0nWC91xNoQIDW
         oC1DrF+z9ByJKsWmjz6bT6JZEqTpTxLm8rJ80cUp5/UNaFbEjd/p/EVJDKWr8eDkT6Pz
         KH/j3FGJczEVQpUFB6F8tUpd1RGkI3eY6Pmu88B/5uAVg9PqxAotqfBS7GJNrRNTj+c0
         93jM3DBH+yFMr3rKnVrfjjwA5Gjth2RVSw9VVEA+SN1dfXsYaTtV1md7Zs6hgZrsEHHL
         UVmy9XI7RI6vpbaQ0JS/O35+Dtr65VddJ6hvhUiK+hgLeh8eWDmPSfk7ejwZL2io7hWd
         fsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431234; x=1720036034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ng2WmGXQZql1jDXPW/vYyFeh8nYeJu3JtauFqQLagBk=;
        b=prHwdMDLAKVeFmWO7JFOhUv80FyCNM/H2YPprFCRBRTI470RjSCXc8+qMm3hytuCt3
         wGE3JsVOLS7JZobCaNPRqyw5qnsDA83AKSpzlxQAbzVausYz5nDTCPNrtg+A+epYBlML
         cHru5syc8raLRt24+CtGrmpYCa1TuIl3LaUM+AfcUZP8mffCr2TnNU5t1wGYZwhzH2Hr
         KC6VW69ge0FmKLFCW+VO5kLiEEZhyaNyTcKPeqSnLeZNys+QRplrHfLkzBEpxwCCMmnd
         +FRQpe8vYrqZEuYSGFiZbuV/ayCyjSyb4rTzbuiM4JD77G5fiA6ZfdrTnPhzXPguDABg
         cpQw==
X-Gm-Message-State: AOJu0YxjOUg62qzQmz8jFM74gkFLjB42f3YB0FKkyTn80b7QNFDpZ1G1
	rB5NHR/RzW9WSG4wN5WTRYs49+7No5WXl4I8QrhWmHUZcSsLTwSw/Wi/iAns
X-Google-Smtp-Source: AGHT+IHl9hABe7xX2H7iF4FE+OsGRaWYvA0ZYF+mCybXMF3BftUU+kXejmxt9lePOISoscwqnHSTSw==
X-Received: by 2002:a81:8904:0:b0:63b:ee94:1eb7 with SMTP id 00721157ae682-6433e906b0bmr109055207b3.25.1719431234276;
        Wed, 26 Jun 2024 12:47:14 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:13 -0700 (PDT)
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
Subject: [PATCH v7 3/4] driver core: shut down devices asynchronously
Date: Wed, 26 Jun 2024 14:46:49 -0500
Message-Id: <20240626194650.3837-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add code to allow asynchronous shutdown of devices, ensuring that each
device is shut down before its parents & suppliers.

Add async_shutdown_enable to struct device_driver, and expose it via sysfs.
This can be used to view or change driver opt-in to asynchronous shutdown.
Only devices with drivers that have async_shutdown_enable enabled will be
shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/base.h           |  3 ++
 drivers/base/bus.c            | 26 +++++++++++++++++
 drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |  2 ++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index db4f910e8e36..6f65f159d039 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,6 +10,7 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+#include <linux/async.h>
 #include <linux/notifier.h>
 
 /**
@@ -97,6 +98,7 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @shutdown_after - used during device shutdown to ensure correct shutdown ordering.
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -114,6 +116,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	async_cookie_t shutdown_after;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2..97fd02cff888 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/async.h>
+#include <linux/capability.h>
 #include <linux/device/bus.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -635,6 +636,25 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
+static ssize_t async_shutdown_enable_show(struct device_driver *drv, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", drv->async_shutdown_enable);
+}
+
+static ssize_t async_shutdown_enable_store(struct device_driver *drv, const char *buf,
+			      size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (kstrtobool(buf, &drv->async_shutdown_enable) < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+static DRIVER_ATTR_RW(async_shutdown_enable);
+
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -702,6 +722,12 @@ int bus_add_driver(struct device_driver *drv)
 		}
 	}
 
+	error = driver_create_file(drv, &driver_attr_async_shutdown_enable);
+	if (error) {
+		pr_err("%s: async_shutdown attr (%s) failed\n",
+			__func__, drv->name);
+	}
+
 	return 0;
 
 out_detach:
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4be6071c2175..1eb5a7286c79 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -3528,6 +3529,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4778,6 +4780,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4813,12 +4817,34 @@ static void shutdown_one_device(struct device *dev)
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
@@ -4849,11 +4875,37 @@ void device_shutdown(void)
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
index 7738f458995f..1e78f2ab1366 100644
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


