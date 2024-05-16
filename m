Return-Path: <linux-kernel+bounces-181270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34718C79C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0891F22D23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672114E2E1;
	Thu, 16 May 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyWxF0l2"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE214F135
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874586; cv=none; b=oqWMf2ZkjSXe61bwP9FPa4E5Nw8TviSPquwQrGhMLPVKNakUB59xcoinEsJ2KSGbJS+bJBb6ZzMWkT2mx7STXY4oCxknXlGMB+LlY2X/Bx1bA3zF9dBBMHaSorah4OpFIRbBatwqoBx2B+9naVVscrqwJdJPP+M16GhoW0TpXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874586; c=relaxed/simple;
	bh=LUF6oGuFMfH5spi+UBEY6opX99jQwTcQMHo+dM2Fp4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWLUmU3XkSOmpUjWhkPziVVFY6PBRBZBXK/lY7lklB5wqw5EfelVn4hbhj/LDT6cwLUhY3jb7pg7pD3lHF5xlNhZUup8HtYZu2XXSX7PF1K1R1LfxrNQ3L4V1EKuL+wkwI+mnh8xrpesUEd6m8K6Jt1DbuhFIcRxKnZ65yu3PU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyWxF0l2; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b2a2ef4e4cso245539eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874583; x=1716479383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXa9ugcDPjbQT7wpPd+qHkyY+/Gaic2gMm244nq+Jqk=;
        b=YyWxF0l2GzUHekPs1yZNnPINwPBFwx1zbrE6+U0KqZ6lJhHJl7DXRHWpikOEal/YCB
         rJh0wW69WhZIGPBpnQfMgafcARjoSw3yUwazR239LiaT61CX5zKDc0e1SIekcBWEItZG
         K6yFxSQYea3ykICJrPSxdh0DFejrjAm/xj0dLCJYLuY8+5iLtfYcQclMi20x24FnuZ4N
         vba+sXtPqITJHYrkanOspRKODCw0TdJ0sgHC40CUB5lwKLRHgjvrRdvWdyJEJN4GcUf5
         Avpw25DTUeS06xiyOZH0+Eu2Df/zVmYgz/GJgob/ISf8zEuaOc0d/dm1ARNSGTJhci5O
         CUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874583; x=1716479383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXa9ugcDPjbQT7wpPd+qHkyY+/Gaic2gMm244nq+Jqk=;
        b=WOERqtsbFjw/4oYwx0NXGMdMFcw5wqKB+34kp3H7rNzT6HOSTlZ+G7yABhBsqoZmvM
         8Bbh9eWAIAPuh8qZtvSszoQ+caFm/PgIuz10pja/FN/H9bTfbvG5Ia7oQP0KWX4TrgGY
         2tKs2/mUTUQxGb89IIt7g9bkJBP9+z1IHc11++VMPJw/PGSh12aIICZHD9shRwtAeyH4
         Ud6GEwfDeSAXmqYqBP1V8jXRXaKpQ+NhMtgggsZTtriSlYM/FBFx8nEH3Vt3k2qRd0lG
         zb6/PQBH/2V56aHbd94Mw3VwxWmVCgw1eAxrMwfNhK765nEdP0LDhJu7JsNAv0uk31/Y
         ADUQ==
X-Gm-Message-State: AOJu0Yyd6h/4KOOXkzCagu8fEwHbaDH0fETLByR/gxjm/ztaU6zUvZN1
	0l745S0LGGXQGeoqdpFetjI43ip5+fdUEQVscbQXAQNLNRKkH/x/mNvPyxvU
X-Google-Smtp-Source: AGHT+IFVLy3acBgdcHb2N5/+8Adq12aS9hZ4Qh1zyO1bzJItFeguxh3NJD6h5WRqOlNAT7dhreUpqA==
X-Received: by 2002:a05:6870:c69d:b0:239:c163:a400 with SMTP id 586e51a60fabf-24172ba92c4mr22194657fac.29.1715874582873;
        Thu, 16 May 2024 08:49:42 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:42 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
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
Subject: [PATCH v6 3/4] driver core: shut down devices asynchronously
Date: Thu, 16 May 2024 10:49:19 -0500
Message-Id: <20240516154920.221445-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add code to shut down devices asynchronously, while ensuring that each
device is shut down before its parents & suppliers, and allowing devices
that share a driver to be shutdown one at a time if necessary.

Add /sys/kernel/async_shutdown to allow user control of this feature:

  safe: shut down all devices synchronously, unless driver prefers async
	shutdown (driver opt-in) (default)
  on:	shut down all devices asynchronously, unless disabled by the driver
	(driver opt-out)
  off:	shut down all devices synchronously

Add async_shutdown to struct device_driver, and expose it via sysfs.
This will be used to view or change driver opt-in/opt-out of asynchronous
shutdown, if it is globally enabled.

 async:   driver opt-in to async device shutdown (devices will be shut down
          asynchronously if async_shutdown is "on" or "safe")
 sync:    driver opt-out of async device shutdown (devices will always be
          shut down synchronously)
 default: devices will be shutdown asynchronously if async_shutdown is "on"

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/base.h           |   3 +
 drivers/base/bus.c            |  47 +++++++++++++
 drivers/base/core.c           | 129 +++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |   8 +++
 4 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0738ccad08b2..ab80a0721b2e 100644
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
+ * @shutdown_after - used during async shutdown to ensure correct shutdown ordering.
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
index daee55c9b2d9..403eecab22a3 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/async.h>
+#include <linux/capability.h>
 #include <linux/device/bus.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -635,6 +636,46 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
+static ssize_t async_shutdown_show(struct device_driver *drv, char *buf)
+{
+	char *output;
+
+	switch (drv->shutdown_type) {
+	case SHUTDOWN_DEFAULT_STRATEGY:
+		output = "default";
+		break;
+	case SHUTDOWN_PREFER_ASYNCHRONOUS:
+		output = "enabled";
+		break;
+	case SHUTDOWN_FORCE_SYNCHRONOUS:
+		output = "disabled";
+		break;
+	default:
+		output = "unknown";
+	}
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t async_shutdown_store(struct device_driver *drv, const char *buf,
+			      size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (!strncmp(buf, "disabled", 8))
+		drv->shutdown_type = SHUTDOWN_FORCE_SYNCHRONOUS;
+	else if (!strncmp(buf, "enabled", 2))
+		drv->shutdown_type = SHUTDOWN_PREFER_ASYNCHRONOUS;
+	else if (!strncmp(buf, "default", 4))
+		drv->shutdown_type = SHUTDOWN_DEFAULT_STRATEGY;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static DRIVER_ATTR_RW(async_shutdown);
+
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -697,6 +738,12 @@ int bus_add_driver(struct device_driver *drv)
 		}
 	}
 
+	error = driver_create_file(drv, &driver_attr_async_shutdown);
+	if (error) {
+		pr_err("%s: async_shutdown attr (%s) failed\n",
+			__func__, drv->name);
+	}
+
 	return 0;
 
 out_del_list:
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e76cba51513a..1f71282741f8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -46,6 +47,65 @@ static bool fw_devlink_drv_reg_done;
 static bool fw_devlink_best_effort;
 static struct workqueue_struct *device_link_wq;
 
+enum async_device_shutdown_enabled {
+	ASYNC_DEV_SHUTDOWN_DISABLED,
+	ASYNC_DEV_SHUTDOWN_SAFE,
+	ASYNC_DEV_SHUTDOWN_ENABLED,
+};
+
+static enum async_device_shutdown_enabled
+			async_device_shutdown_enabled = ASYNC_DEV_SHUTDOWN_SAFE;
+
+static ssize_t async_device_shutdown_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	const char *output;
+
+	switch (async_device_shutdown_enabled) {
+	case ASYNC_DEV_SHUTDOWN_DISABLED:
+		output = "off";
+		break;
+	case ASYNC_DEV_SHUTDOWN_SAFE:
+		output = "safe";
+		break;
+	case ASYNC_DEV_SHUTDOWN_ENABLED:
+		output = "on";
+		break;
+	default:
+		output = "unknown";
+	}
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t async_device_shutdown_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (!strncmp(buf, "off", 3))
+		async_device_shutdown_enabled = ASYNC_DEV_SHUTDOWN_DISABLED;
+	else if (!strncmp(buf, "safe", 4))
+		async_device_shutdown_enabled = ASYNC_DEV_SHUTDOWN_SAFE;
+	else if (!strncmp(buf, "on", 2))
+		async_device_shutdown_enabled = ASYNC_DEV_SHUTDOWN_ENABLED;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static struct kobj_attribute async_device_shutdown_attr = __ATTR_RW(async_device_shutdown);
+
+static int __init async_shutdown_sysfs_init(void)
+{
+	return sysfs_create_file(kernel_kobj, &async_device_shutdown_attr.attr);
+}
+
+late_initcall(async_shutdown_sysfs_init);
+
 /**
  * __fwnode_link_add - Create a link between two fwnode_handles.
  * @con: Consumer end of the link.
@@ -3569,6 +3629,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4819,6 +4880,23 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
+static bool async_shutdown_allowed(struct device *dev)
+{
+	if (!dev->driver)
+		return false;
+
+	switch (async_device_shutdown_enabled) {
+	case ASYNC_DEV_SHUTDOWN_ENABLED:
+		return !(dev->driver->shutdown_type == SHUTDOWN_FORCE_SYNCHRONOUS);
+	case ASYNC_DEV_SHUTDOWN_SAFE:
+		return (dev->driver->shutdown_type == SHUTDOWN_PREFER_ASYNCHRONOUS);
+	default:
+		return false;
+	}
+}
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4854,12 +4932,30 @@ static void shutdown_one_device(struct device *dev)
 		put_device(dev->parent);
 }
 
+/**
+ * shutdown_one_device_async
+ * @data: the pointer to the struct device to be shutdown
+ * @cookie: not used
+ *
+ * Shuts down one device, after waiting for dev's shutdown_after to
+ * complete first.
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
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4890,11 +4986,42 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		shutdown_one_device(dev);
+		if (async_device_shutdown_enabled) {
+			struct device_link *link;
+			int idx;
+
+			/*
+			 * Wait for previous device to shut down if synchronous
+			 */
+			if (!async_shutdown_allowed(dev))
+				dev->p->shutdown_after = cookie;
+
+			get_device(dev);
+			get_device(parent);
+
+			cookie = async_schedule_domain(shutdown_one_device_async,
+						       dev, &sd_domain);
+			/*
+			 * Ensure parent & suppliers wait for this device to shut down
+			 */
+			if (parent) {
+				parent->p->shutdown_after = cookie;
+				put_device(parent);
+			}
+
+			idx = device_links_read_lock();
+			list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+					device_links_read_lock_held())
+				link->supplier->p->shutdown_after = cookie;
+			device_links_read_unlock(idx);
+			put_device(dev);
+		} else
+			shutdown_one_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&sd_domain);
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..f414c8a6f814 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -48,6 +48,12 @@ enum probe_type {
 	PROBE_FORCE_SYNCHRONOUS,
 };
 
+enum shutdown_type {
+	SHUTDOWN_DEFAULT_STRATEGY,
+	SHUTDOWN_PREFER_ASYNCHRONOUS,
+	SHUTDOWN_FORCE_SYNCHRONOUS,
+};
+
 /**
  * struct device_driver - The basic device driver structure
  * @name:	Name of the device driver.
@@ -56,6 +62,7 @@ enum probe_type {
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
+ * @shutdown_type: Type of the shutdown (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
  * @probe:	Called to query the existence of a specific device,
@@ -102,6 +109,7 @@ struct device_driver {
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
 	enum probe_type probe_type;
+	enum shutdown_type shutdown_type;
 
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
-- 
2.39.3


