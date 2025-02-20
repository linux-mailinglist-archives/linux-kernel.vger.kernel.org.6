Return-Path: <linux-kernel+bounces-523060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8651DA3D185
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07AE188E964
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9E1E3DFE;
	Thu, 20 Feb 2025 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSIiXWbh"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F32862B3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034020; cv=none; b=tnTBetsW3cUZkqHmV/TIHoQA3cwuo3B8TFvTypK9wpqrrsYsaWx/HNDPoYI/fjIyXynTxWZDKLecEI/UkFUhoqLXvzax96121lqgp7Z7qlIp0hQsTOR+NfzL4+FTv7OD403fRDQMoBqh/iJ9lhyUfQWMCKqIsgT04QJxV5snmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034020; c=relaxed/simple;
	bh=ywufwpgMUcHGt355dshNCODWxUZaWHk5arZtuPssCs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQmiShjJLmu8oMV53hsFBzlxUNXZM08cID92nUgIXolThzAQQ7sAiP3/FwAk0heMcuiSUpp/2NuBCKGBKcstH5XsnkqRaNnn2vU2YMOuyeC2DbqpF0A4cAjRHdmspbzG9AMt4+lNp/PyFy3c67FprmTk+ujQ1YVoYCru32RimOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSIiXWbh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so915009a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740034018; x=1740638818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sErrUt5MRYLXd8pFL6SJj9cH8LlLprUSbWPiR6LrbG0=;
        b=mSIiXWbhNQLGTCwIkKe+7mkoGzyeOgnMf40OtbUOCJPZq9+qO2o7vrL2EPsWg/DV0C
         RrgAhq+JAD5kpWDkm9K0NbQt9/2KP/quxdY6eOFyCKNXD3YAuSK4aDSPg3dwXA54xUOJ
         YERTITjS4pnSZNe960V8fJX/WCphFqbqFqVzaf8KrziJDxNUJ1yaT/zymgAziAkgOfSX
         2JHhh/Lt6Yh5yOaW9UAqLVsRVG+cdk9ppPtRyb4jG9hP4zBDwKX6Vdv8d2kNg9WLJiVx
         pqT/RMCTyc9JJ+NgxsCquOevg8Ly6KVgbUPo2q503MdGth4c9Zl6KhTW08Kud1FsWwXZ
         Zqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740034018; x=1740638818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sErrUt5MRYLXd8pFL6SJj9cH8LlLprUSbWPiR6LrbG0=;
        b=Aq0DgbJGBHtxJ914+hii55M1p/Y+hkdu8NNs+R9PRJiqozvFT8iZnKEqZ1BdTl9JxL
         7/fpkE+zELEeeLUwi19d6Q23hlyFvm/Bys/KLUV3eBgyoGTbke9x3xYIl75VNBX7/4Mm
         9m9z1iHj6PJJ24Ji2iS425jtCrDC8+H+Bf3FsB0Kcvs6gr1gpWKHTclt+cmJAmXasbOh
         GheWXWru50EVqe7x22Hvu7iOssEUeaWAmSZiAyzXwApMtwyd+niwSeV4CKtli/3KckBN
         X64YfZipopJTZHtn6AVcO2ITzF8YcNbPzQy2OOfbTGfRrVxeLjDJkDetwyLZklJwXpyq
         ll3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHlXd3DKgYUfVbYEkDhbWxwljGArSEdMd+zwl4VcJG7N6+ofD2Va2jwsXdRUk1YTa9cHu3Mo8qBmHcyJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuByq4acsOt3JqVTwSU8mmV4PIVP4Mgti9dpmkFdqyVDAEZpmA
	8cpZ12IqUglmxZ6Etb3qIfqPfGS3KRQuJD7OtxACCv51RuYMdbAc
X-Gm-Gg: ASbGncvXMtkpbR1LOg9O5A1kdprqY0FyMhSbLgjgJzXFLMH0FXOhmHUUPP3ef4frsUr
	ymBPetpnmbh14YY6+OE+Ua+8O6XuM8CklN4TLmbbCO0ZoqD4dklEIWyk8sDfxd4eaX9pGHKcBnP
	kwn6jocXnngivVK+uh1ZRzYLIyahJQRJKNvgFpnh5FieGc6B1P2+MfvjVjdey1U4oHRRQEUq3z2
	79mF235HHT3bXUEQrygHACkR87WlX8H+g0x7UPkZlDXzfqwKxlB5oz0aNAuZJkF+Xd98lFNA0tV
	QrmvsDzgFWktAWh0/pTXaLBxBeKElFsN1paAkQQ=
X-Google-Smtp-Source: AGHT+IG/rUEkB6PxJg1sl0le5ujFkvJOV9euWX3cAR0wROfSogjHQlL3Ll7pk3M55css9vBf/CQxug==
X-Received: by 2002:a17:90b:1b4b:b0:2f6:be57:49cd with SMTP id 98e67ed59e1d1-2fc41045d3amr31622383a91.25.1740034018204;
        Wed, 19 Feb 2025 22:46:58 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:a028:2c35:8941:966f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534903csm115162125ad.32.2025.02.19.22.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:46:57 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/2] driver core: fix potential NULL pointer dereference in dev_uevent()
Date: Wed, 19 Feb 2025 22:46:45 -0800
Message-ID: <20250220064647.2437048-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>
References: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>
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

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/base.h |  1 +
 drivers/base/bus.c  |  2 +-
 drivers/base/core.c | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 8cf04a557bdb..91b786891209 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -73,6 +73,7 @@ static inline void subsys_put(struct subsys_private *sp)
 		kset_put(&sp->subsys);
 }
 
+struct subsys_private *bus_to_subsys(const struct bus_type *bus);
 struct subsys_private *class_to_subsys(const struct class *class);
 
 struct driver_private {
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 6b9e65a42cd2..c8c7e0804024 100644
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
index 9f4d4868e3b4..670f77b9b378 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2623,6 +2623,34 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 	return NULL;
 }
 
+/*
+ * Try filling "DRIVER=<name>" uevent variable for a device. Because this
+ * function may race with binding and unbinding device from a driver we need to
+ * be careful. Binding is generally safe, at worst we miss the fact that device
+ * is already bound to a driver (but the driver information that is delivered
+ * through uevents is best-effort, it may become obsolete as soon as it is
+ * generated anyways). Unbinding is more risky as driver transitioning to NULL,
+ * so READ_ONCE() should be used to make sure we are dealing with the same
+ * pointer, and to ensure that driver structure is not going to disappear from
+ * under us we take bus' drivers klist lock. The assumption that only registered
+ * driver can be bound to a device, and to unregister a driver bus code will
+ * take the same lock.
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
@@ -2654,8 +2682,8 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Add "DRIVER=%s" variable if the device is bound to a driver */
+	dev_driver_uevent(dev, env);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
-- 
2.48.1.601.g30ceb7b040-goog


