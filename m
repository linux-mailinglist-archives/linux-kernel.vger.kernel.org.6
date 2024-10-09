Return-Path: <linux-kernel+bounces-357662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DE9973DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7B328641C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F991A256B;
	Wed,  9 Oct 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJa9n2J3"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE571E0DA8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496681; cv=none; b=LafQBWV1Kbgb6ScXF1MIBzJwWrbCPdvVUkUzey5zH06WEH0tEuVCwrAINUfqpbA/rAZnCb/HxJKtqBICuhv3ml/j+k228Ak4ceJiOjDFcywLOkf4YQtddJopFt1MDyh0fSFFd8yGhS8KZQavbb4c3aCJrHA6sPcy9FQ6N1fRCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496681; c=relaxed/simple;
	bh=pWDG5wKcqqnqRQbHr/2elXDqtzsVTOSauHHyjuqzGQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiEa11/1pvtRtr82i9Fc5NSQH0vxSZLR25PW/m0quSG2ZvGhO+U3AA7+qyqb7OOTCtPICCG/MjTvf9BuupCX82qYxePJXwyFvoDBnkqAHD+D6bhKijrmvR8D8i7IcOk9q1hrLAzttnAiqu7NJLZ0OznlTEPXTaHhvYTEjZ16CNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJa9n2J3; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-716a7d5c9fbso60301a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496678; x=1729101478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbKbrq2eBZoafCjGOvWmirCqOvc1rlNEfL7PzJ9PmSg=;
        b=MJa9n2J3pc5w687pEtOt6eChERqkYg6ZXsvOlNWONTKXV4N9Hbl4vrjQXgRqCRW5SD
         jH73bObZHHvkjRVHTEi9TQ61//9sRLPSbc6OUsqRIDYTcbVxdqjy+YVsC2R/wMIRaWVA
         8WTKn/K4jRbpZcg5y4257suBZSLlrpqwO92qYmVzaHNkOFqFJNDb0oZ9aaDZ0abPUxhV
         59rbdA8Sh0CwAe0P7gXHdOuUscQlLx1E4tQKwvkCGVQMBTxdMQqP0R6Bar5rDoJ5WOhe
         F2cE+9QKgqI1rrGgKVa40PGyuNK0BJ4V07VJSCJeJCB1oJ0+Fgf/VQr1/2i5mquv/uzt
         yOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496678; x=1729101478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbKbrq2eBZoafCjGOvWmirCqOvc1rlNEfL7PzJ9PmSg=;
        b=bDTJhEEzsZhQ81n/QfoavTv2gz9/u2okkhFgK5XWi7Dz6luo7bt+IPXyIPiafTfxsy
         bCfiI1riAU824xFG5jEwKYePti8PDFuDLEjcUDULwiFc905by0U0GgGaRZ9PSyU8Ep9I
         WQRBuPHN1U6KHAdjNP2lEmNzcgYRXn2QWJu9gE7dKYdwWnryNwdVH4rSkmEzJhVVgcNE
         /MwElCoJ8YB/gGEIOEsa2lQImbrHpeb1rwF9VUP81a0f/4plbfwOq8+89sIgDfXWbfh+
         n8/1VyjFIHh/QxJj0p01iNfXgNj5ILGidXRB6yeak7sQyPefm4NTXYS2ZTy43B4GsDbN
         PNQA==
X-Gm-Message-State: AOJu0Yxuu8qHjgaOLUPD9xKAL5Ve6rJUnGylbCvJ/X4LznvUfau4+Wcw
	i3TRkpbThOeWzXQTYB3qX31wcSY1YAAQnXsLXFBerS4gP1DT7qv2RMgtXkG+
X-Google-Smtp-Source: AGHT+IHsDJkfTNGPYZjTJw4QewG2zd6CFF2l5EXBDuN2TTJHxDt9CybyyYW3NqGWR12c/J4eH2GThw==
X-Received: by 2002:a05:6830:380c:b0:715:4e38:a1ad with SMTP id 46e09a7af769-716a9ffae17mr1682332a34.21.1728496678513;
        Wed, 09 Oct 2024 10:57:58 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:58 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v9 3/4] driver core: shut down devices asynchronously
Date: Wed,  9 Oct 2024 12:57:45 -0500
Message-Id: <20241009175746.46758-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add code to allow asynchronous shutdown of devices, ensuring that each
device is shut down before its parents & suppliers. Any devices that are
ordered in the devices_kset list such that a parent or supplier would
shut down before its child or consumer are shut down synchronously (as
they are without this patch).

Only devices with drivers that have async_shutdown_enable enabled will be
shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/base.h           |  4 ++
 drivers/base/core.c           | 81 ++++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |  2 +
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 8cf04a557bdb..ea18aa70f151 100644
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
index 4482382fb947..bde3fdeafbdb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/cleanup.h>
 #include <linux/cpufreq.h>
@@ -3524,6 +3525,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4779,6 +4781,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4814,12 +4818,61 @@ static void shutdown_one_device(struct device *dev)
 		put_device(dev->parent);
 }
 
+static bool device_wants_async_shutdown(struct device *dev)
+{
+	if (dev->driver && dev->driver->async_shutdown_enable)
+		return true;
+
+	return false;
+}
+
+/**
+ * shutdown_one_device_async
+ * @data: the pointer to the struct device to be shutdown
+ * @cookie: not used
+ *
+ * Shuts down one device, after waiting for previous device to shut down (for
+ * synchronous shutdown) or waiting for device's last child or consumer to
+ * be shutdown (for async shutdown).
+ *
+ * shutdown_after is set to the shutdown cookie of the last child or consumer
+ * of this device (if any).
+ */
+static void shutdown_one_device_async(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+	async_cookie_t wait = cookie;
+
+	if (device_wants_async_shutdown(dev)) {
+		wait = dev->p->shutdown_after + 1;
+		/*
+		 * To prevent system hang, revert to sync shutdown in the event
+		 * that shutdown_after would make this shutdown wait for a
+		 * shutdown that hasn't been scheduled yet.
+		 *
+		 * This can happen if a parent or supplier is not ordered in the
+		 * devices_kset list before a child or consumer, which is not
+		 * expected.
+		 */
+		if (wait > cookie) {
+			wait = cookie;
+			dev_warn(dev, "Unsafe shutdown ordering, forcing sync order\n");
+		}
+	}
+
+	async_synchronize_cookie_domain(wait, &sd_domain);
+	shutdown_one_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	async_cookie_t cookie;
+	struct device_link *link;
+	int idx;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4850,11 +4903,37 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		shutdown_one_device(dev);
+		get_device(dev);
+		get_device(parent);
+
+		cookie = async_schedule_domain(shutdown_one_device_async,
+					       dev, &sd_domain);
+		/*
+		 * Ensure any parent & suppliers will wait for this device to
+		 * shut down
+		 */
+		if (parent) {
+			parent->p->shutdown_after = cookie;
+			put_device(parent);
+		}
+
+		idx = device_links_read_lock();
+		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
+			/*
+			 * sync_state_only devlink consumers aren't dependent on
+			 * suppliers
+			 */
+			if (!device_link_flag_is_sync_state_only(link->flags))
+				link->supplier->p->shutdown_after = cookie;
+		}
+		device_links_read_unlock(idx);
+		put_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&sd_domain);
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 5c04b8e3833b..14c9211b82d6 100644
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


