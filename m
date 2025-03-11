Return-Path: <linux-kernel+bounces-555490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE9A5B85C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6605216AEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1981EF38D;
	Tue, 11 Mar 2025 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX3ekQPO"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC41EBA03
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670673; cv=none; b=WoHo8dwZ2Pm8a/MI1LWrCrsKCWtEzVjsiV3GqIXk8kr+jLuaNnbY68nn7akdjF4tLt+yFks2nIvWscUrH1TJgxTs3GlQ7xksCdBoiN+goPj4p2DxXTOp1J0Y9IYbK7vHPC7sg8P9KCPTzxsX2XGOpWeD1C3Mjn+HaIMbusqzf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670673; c=relaxed/simple;
	bh=0dKuVoGVU12SkInDrNv7ZqK0u+ZY4I1QMFuji+rp5PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4LY4ud75WyjilIjclVeOxZj2AAKv8b8xByf9CxYheFblNCc78vrZYGlzS69T4392czmB94YBLa7KmfQc+vrGHjSi2wWO/AZNcMk5186b1QAC7dQJUvdHf4PzIKt2Yond/tY5eAN7BX2N9+YZlZqgNKg9EmwhmMlWD4WJHj+kuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX3ekQPO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so7915414a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741670671; x=1742275471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIw24g5Haw4kmBAR/0m+yBBbk7ikwpRTXaRjaXzRIs4=;
        b=fX3ekQPO5oc9hbgNZKSGq5t6u+MU1jeUUa6jimr0THBmrZ9fjtjh1Hxofv9iAmTUaO
         HpOAEkiwhJN8a+4TSEE2b6lIK3gqUIW0zirYk0rseCCGkOCNCxVJwBWEzlsPUECqTSxs
         9qRvxc1Qg39IxfLzrVWVG241rEJ2ajZmr8WC6Vr8u1xVX9Jc6w+i947/bIOc94LBX096
         7jYgE/uzWT14FY+Aqa80NEhjNQfciX+TrWLo5z0T4NvB2bksVPpyekRblR9RvujuPch4
         Y7GGZSAIATtFCegqzVaPBoRVDwLNj0JV8xDK4iodklPyVR+d0gg8EvFsCHC7s7v7cwlk
         xIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741670671; x=1742275471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIw24g5Haw4kmBAR/0m+yBBbk7ikwpRTXaRjaXzRIs4=;
        b=nZmsGtC4X3geROOk7NeRfXLV50pKnDGlO4Ya0gQkRVzWZBCX52ufYIkdLkD/LP9n9O
         cEGx30egUznCKDas4z+hNtExkQRy0ly4eWQ2DCD6rBmizwb6TQzmhaJvBypCEYumKyu+
         MGcaWMKjRPftw6vkMwjfB9nynTGVXMy+SWE8QqPW6W9a9IGNJEnye1rAvOH4jtzUF/KT
         fvTgUBp7XMKkbjj0UZbBsuTXqh/p88i3IubB49AjdCWTTqY0nZ8WGJYdN2yh7Q/HB/+q
         zAP2NSxzPA4q3+Lv1hIM2e/24i1l7hA67RPsoJSyJ7qolGBqQum8RI6ZapaXKA+dhiS+
         tmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+POolDvpU/a1MGs4nIAFbpZoOrvnQQmP7l/LH+y5ZpS4vygnkAzNPqINeKsaHSHzrgnr5XiGHZ02XdAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvulHb5XY+qBu/za8wOT0p0PDtytwKCq2vSTUnUK8XhBaJa4BV
	h7PHhJzIUXCgRuNZ1Kyk9YF3djyHOHZcIeotr0eWeY3MXWg4/ATn
X-Gm-Gg: ASbGnct+Va+wvkAWdKI3UMdHycEnF5k38ECfz31SQxni5+3X2Gb7hFNS7rDTW0gS7WQ
	2OmakLMo7XnWBSRgKZ7vQGVUdO/sOOTODCh3Z2P4Lr5r3Aagxjtft8K85+Usm9NPu2XYmDRda1j
	fcoqefBXaUwqQhZy0fOEjiiJ4aNPB9T1VqGVP4O8i+4iKM2lU8yOs7Ip0+jtSizbWx5UY8d09nQ
	WvvFIQzRL6vubQenZo70B8aKpYODU3Au1ze502GDbCGT/PlmgEWjiJ0nUFobTig8YtrHp52pxJR
	G5hVUFcgis/ZZQ+cjCVhNWxQxpb8BSf7vsCan3gTZ5JSA4cOMCOb4zw5UOTWC0O4bVU=
X-Google-Smtp-Source: AGHT+IG3qe4RBp6yih7xeBopBmdco+vobtIEA3W4mJpaQ+zhslefPZeOKb/083gQOy/7r1Dvv69YjQ==
X-Received: by 2002:a17:90b:4d12:b0:2fe:8c22:48b0 with SMTP id 98e67ed59e1d1-2ff7cea6125mr26317224a91.15.1741670670579;
        Mon, 10 Mar 2025 22:24:30 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:eb9f:29c2:9ede:46d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693f7f0bsm9023649a91.46.2025.03.10.22.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 22:24:30 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v3 3/3] driver core: fix potential NULL pointer dereference in dev_uevent()
Date: Mon, 10 Mar 2025 22:24:16 -0700
Message-ID: <20250311052417.1846985-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
References: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If userspace reads "uevent" device attribute at the same time as another
threads unbinds the device from its driver, change to dev->driver from a
valid pointer to NULL may result in crash. Fix this by using READ_ONCE()
when fetching the pointer, and take bus' drivers klist lock to make sure
driver instance will not disappear while we access it.

Use WRITE_ONCE() when setting the driver pointer to ensure there is no
tearing.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v3: addressed Rafael's feedback and split device_set_driver() helper
into a separate patch.
 
v2: addressed Rafael's feedback by introducing device_set_driver()
helper that does WRITE_ONCE() to prevent tearing. 

I added Cc: stable however I do not think we need to worry too much
about backporting it to [very] old kernels: the race window is very
small, and in real life we do not unbind devices that often.

I believe there are more questionable places where we read dev->driver
pointer, those need to be adjusted separately.


 drivers/base/base.h | 13 ++++++++++++-
 drivers/base/bus.c  |  2 +-
 drivers/base/core.c | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb203cf8370b..123031a757d9 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp)
 		kset_put(&sp->subsys);
 }
 
+struct subsys_private *bus_to_subsys(const struct bus_type *bus);
 struct subsys_private *class_to_subsys(const struct class *class);
 
 struct driver_private {
@@ -182,8 +183,18 @@ void device_driver_detach(struct device *dev);
 
 static inline void device_set_driver(struct device *dev, const struct device_driver *drv)
 {
+	/*
+	 * Majority (all?) read accesses to dev->driver happens either
+	 * while holding device lock or in bus/driver code that is only
+	 * invoked when the device is bound to a driver and there is no
+	 * concern of the pointer being changed while it is being read.
+	 * However when reading device's uevent file we read driver pointer
+	 * without taking device lock (so we do not block there for
+	 * arbitrary amount of time). We use WRITE_ONCE() here to prevent
+	 * tearing so that READ_ONCE() can safely be used in uevent code.
+	 */
 	// FIXME - this cast should not be needed "soon"
-	dev->driver = (struct device_driver *)drv;
+	WRITE_ONCE(dev->driver, (struct device_driver *)drv);
 }
 
 int devres_release_all(struct device *dev);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 5ea3b03af9ba..5e75e1bce551 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -57,7 +57,7 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
  * NULL.  A call to subsys_put() must be done when finished with the pointer in
  * order for it to be properly freed.
  */
-static struct subsys_private *bus_to_subsys(const struct bus_type *bus)
+struct subsys_private *bus_to_subsys(const struct bus_type *bus)
 {
 	struct subsys_private *sp = NULL;
 	struct kobject *kobj;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b000ee61c149..cbc0099d8ef2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2624,6 +2624,35 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 	return NULL;
 }
 
+/*
+ * Try filling "DRIVER=<name>" uevent variable for a device. Because this
+ * function may race with binding and unbinding the device from a driver,
+ * we need to be careful. Binding is generally safe, at worst we miss the
+ * fact that the device is already bound to a driver (but the driver
+ * information that is delivered through uevents is best-effort, it may
+ * become obsolete as soon as it is generated anyways). Unbinding is more
+ * risky as driver pointer is transitioning to NULL, so READ_ONCE() should
+ * be used to make sure we are dealing with the same pointer, and to
+ * ensure that driver structure is not going to disappear from under us
+ * we take bus' drivers klist lock. The assumption that only registered
+ * driver can be bound to a device, and to unregister a driver bus code
+ * will take the same lock.
+ */
+static void dev_driver_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (sp) {
+		scoped_guard(spinlock, &sp->klist_drivers.k_lock) {
+			struct device_driver *drv = READ_ONCE(dev->driver);
+			if (drv)
+				add_uevent_var(env, "DRIVER=%s", drv->name);
+		}
+
+		subsys_put(sp);
+	}
+}
+
 static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	const struct device *dev = kobj_to_dev(kobj);
@@ -2655,8 +2684,8 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Add "DRIVER=%s" variable if the device is bound to a driver */
+	dev_driver_uevent(dev, env);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


