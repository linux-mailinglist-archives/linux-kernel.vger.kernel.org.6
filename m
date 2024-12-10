Return-Path: <linux-kernel+bounces-439641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0F09EB21D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E911882FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC61AA1D9;
	Tue, 10 Dec 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AcgllPdy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF323DE8D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838202; cv=none; b=Pb5OnBKYR7YdD5USi+Rporw7DjP96G5t+IdsIlHXsrPwdPw1VwfP5Es1zV8RXA7pDhU03Srclt3BscX+hDtIYUxTkNSVnz2CxesEz+kCB6OH7JpGPFmzWpr+zLsSgtHfBhIOT24PPO2ufZvapxd7W3fl0fFi+ZFbVbR0R/f3cqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838202; c=relaxed/simple;
	bh=NBSyX54EoDyqSzw2fDHWMjaZMqSSNkU0PANWU1f65Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fvGdKRUc0pWy2q43TDKfZTWcTBGTwE4EhtQ6aJME/7WBlDwpXugHVpgfaeTjkwp1X8paE3zOPCadpIsu/kYJqnYZk45dt9pflDP5ix+grEgwfBFNdDxKae7pROL7DyyIqIfIhHZoJ+4NcVyiIj7Y8/wUfewdgcCSfWmTKnOqVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AcgllPdy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434e8aa84f7so29902165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733838198; x=1734442998; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2MFbMqDHWriwTjfvfzM1fyrvrwlNmUvKjT2DouEeIM=;
        b=AcgllPdyz/ta2hezg2a6TS/2LuHpJfCcsCzDdn+E2vbpokErraKhVi9XS9um0JcFNN
         C32v1ZM/uNQ6qu9S1+jfIwO74SvXFy4V4y/ReDcgqezuTHsq6kKUCbywYl7NDMs6lbc1
         G5g5jRxOFjr128Ft0NGObM9dYOJGjfiVw1yhHMi6O3OrZcWl7yYDlTviv6BJqXMymJN4
         yCEwgsyciFX8MnlRfHWBxcMIynhq14bUQdf77wPscP8RJ9+jzzQaQjWPgVicgAwYSd1R
         qiNkvrNm9nNvBKcm6NMMRYc1ZBj+6qZqPMPT69vF/1iNJhY1Tk0KqnhFQfM4sxX5FhKm
         cbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838198; x=1734442998;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2MFbMqDHWriwTjfvfzM1fyrvrwlNmUvKjT2DouEeIM=;
        b=wIH8l1efFxhJK7XTP64OORHuBJ3oLHM7uYBOPK4+i9pqpBTbNFqgbggzavSAkmcKvg
         cpjORRlDsLRWZtLaO1pph4CXKbt4otUv51a8A7N5X2u1W7/H9/MqeRZqxhhgKxgUFb3W
         mEosgiqd+OtjXK5aJeKwr/JxgkxY4/J3ndWOOH5gONoq2NfjHasKzmeQHQzbIg8ahL7G
         GB4jJlB3oomi1LFd/fg3T/qfdrZOjwljiiqr5s8axBohuJGDAMbchdPnfzsAXSmudA5W
         kZqlmaOwm7TaPlABXbZCtnXQWSY+RnfQCq8G0beJHxESG37JefQ3XF+HUcuMY/h/161q
         im0w==
X-Gm-Message-State: AOJu0YxCYe14zYnHoNod33hUo3yPa4k8Fmc7Tqj2LNWDrb97aMRFr1T7
	FiMsgn8umnSpNa6VinjQt29mPNEGA/0mNlX0ctTvnWkQBGFORJhqu4sXERx0kZ5Eq4Q269qmrok
	O
X-Gm-Gg: ASbGncspdbqoqNoIn/pge4TqMmVF4n/wXcL9qHD/NwfYBb3As4GIcQGVPY9gABz5MAn
	09520wlK1uQVVgQSj6lrOxpZ0P/u6uoUIXQmpuH7eM0G5qib0ost9em5jTFvtFe6lJTJ3HVwOzG
	8/hd1OT2bmbS0OjYcC/GTOmw5K10uWK/VeoaN61kdNmDeguGkl2myQgYVqpT1e+C/JNz+UmXM+a
	KkaXx6P+3wXfQonJoYzzftkGoim6jmWahVMBW4oZk8yrsw6hJ4+4vQoqvQYvF3tXxdA
X-Google-Smtp-Source: AGHT+IE1RaV7OCaO7Y77s7Er+P2FwEe04/RQQP2OoKb+qfEdy2MJMKz/himqGxxbEE9m1xYHpnMeHg==
X-Received: by 2002:a5d:64cb:0:b0:385:fd07:8616 with SMTP id ffacd0b85a97d-3864536c2f0mr3460203f8f.0.1733838197750;
        Tue, 10 Dec 2024 05:43:17 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f337:e8ca:8b65:dbc7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3862190966bsm16229991f8f.75.2024.12.10.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:43:17 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Dec 2024 14:43:12 +0100
Subject: [PATCH] driver core: auxiliary bus: add device creation helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-aux-device-create-helper-v1-1-5887f4d89308@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAG9FWGcC/x2MwQqDQAwFf0VyNmDierC/Ij0s61MDYiVrRRD/v
 UuPAzNzU4YbMr2qmxynZftsBaSuKC1xm8E2FiZtNIhKw/F78VjEBE6OeIAXrDuc+1aCdBrQaUs
 l3x2TXf/18H6eH1LU3mRqAAAA
X-Change-ID: 20241210-aux-device-create-helper-93141524e523
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=NBSyX54EoDyqSzw2fDHWMjaZMqSSNkU0PANWU1f65Jg=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnWEVz1xe2StdxQLlY67K1PmLzJI5qy81SVuDs/
 UC3EKEmoDaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ1hFcwAKCRDm/A8cN/La
 hbVvD/9C4VeNwTqvkV/Z8VfRrp7GiWhD/TUsSwIqeVmNMGbC1Uy3VPnpEQN8bPapxZvsgFxWwBs
 rcI2WTJgzAiGq6IZdqBAF/wTYTMrFuvJIjHsdVluNbX4OWbschiS3btemWYYtIHJu1wVlZqFqfv
 NE4qFxjL+79tKU0wtGFZHdncjZMm5M/Hd0SStTnAGb8EWCKfvENM5Q7XoNmWPfSHYk9g35X+iv+
 yQborL3pmurYFYXoP5nbdC2aakVxiv6pl7ndd4VRFkfFdjwhC1D7qCQUusIugrtXzR81zLFYksY
 m3gq+rqYTvqsiXqD6IgxCsD5YLmZ7VuZSxUJG7+CAlreFYA6R5CFlxHu57U/OvlrQSKkoEAiA2U
 LQV5xw62eE6zIUFRH1iDnao7KxscTBD8LcMqrlYtoBKDpA+nlgFwidgEC/VI7xkBVMKBFhe3GlA
 6uUH9UMFJcbLaAqPU/NwzhDonB0WiU65Wsoq6Wy+QhQ7aNjTu3A8fXHjnKqhzThmE7rqKJO00Eo
 v+WPeUTHwWFoIEdRDaA+TZRDdfd5vMJ5RufqGc/Rpi1DbVkE27oq8WXRCUbox9VksW6oHsuH4zK
 cxxdKySH5Fy1PrzX7oLzYZTY31yLShc0kfDBJHINNFUnLnZdPf30eE/NMTJm8ipyUtBDJY8aSu8
 ljoi5T07XTR8Lzg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add an function helper to create a device on the auxiliary bus.
This should avoid having the same code repeated in the different drivers
registering auxiliary devices.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
The suggestion for this change was initially discussed here: [1]

I was not sure if the managed variant should return the auxiliary device or
just the error. This initial version returns the auxiliary device, allowing
it to be further (ab)used. Please let me know if you prefer to just return
the error code instead.

Also the non managed variant of the helper is not exported but it could
easily be, if necessary.

[1]: https://lore.kernel.org/linux-clk/df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org
---
 drivers/base/auxiliary.c      | 89 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/auxiliary_bus.h |  4 ++
 2 files changed, 93 insertions(+)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index afa4df4c5a3f371b91d8dd8c4325495d32ad1291..60ca3f0da329fb7f8e69ecdf703b505e7cf5085c 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -385,6 +385,95 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv)
 }
 EXPORT_SYMBOL_GPL(auxiliary_driver_unregister);
 
+static DEFINE_IDA(auxiliary_device_ida);
+
+static void auxiliary_device_release(struct device *dev)
+{
+	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
+
+	ida_free(&auxiliary_device_ida, auxdev->id);
+	kfree(auxdev);
+}
+
+static struct auxiliary_device *auxiliary_device_create(struct device *dev,
+							const char *name,
+							void *platform_data)
+{
+	struct auxiliary_device *auxdev;
+	int ret;
+
+	auxdev = kzalloc(sizeof(*auxdev), GFP_KERNEL);
+	if (!auxdev)
+		return ERR_PTR(-ENOMEM);
+
+	ret = ida_alloc(&auxiliary_device_ida, GFP_KERNEL);
+	if (ret < 0)
+		goto auxdev_free;
+
+	auxdev->id = ret;
+	auxdev->name = name;
+	auxdev->dev.parent = dev;
+	auxdev->dev.platform_data = platform_data;
+	auxdev->dev.release = auxiliary_device_release;
+	device_set_of_node_from_dev(&auxdev->dev, dev);
+
+	ret = auxiliary_device_init(auxdev);
+	if (ret)
+		goto ida_free;
+
+	ret = __auxiliary_device_add(auxdev, dev->driver->name);
+	if (ret) {
+		auxiliary_device_uninit(auxdev);
+		return ERR_PTR(ret);
+	}
+
+	return auxdev;
+
+ida_free:
+	ida_free(&auxiliary_device_ida, auxdev->id);
+auxdev_free:
+	kfree(auxdev);
+	return ERR_PTR(ret);
+}
+
+static void auxiliary_device_destroy(void *_auxdev)
+{
+	struct auxiliary_device *auxdev = _auxdev;
+
+	auxiliary_device_delete(auxdev);
+	auxiliary_device_uninit(auxdev);
+}
+
+/**
+ * devm_auxiliary_device_create - create a device on the auxiliary bus
+ * @dev: parent device
+ * @name: auxiliary bus driver name
+ * @platform_data: auxiliary bus device platform data
+ *
+ * Device managed helper to create an auxiliary bus device.
+ * The parent device KBUILD_MODNAME is automatically inserted before the
+ * provided name for the modname parameter of the auxiliary device created.
+ */
+struct auxiliary_device *devm_auxiliary_device_create(struct device *dev,
+						      const char *name,
+						      void *platform_data)
+{
+	struct auxiliary_device *auxdev;
+	int ret;
+
+	auxdev = auxiliary_device_create(dev, name, platform_data);
+	if (IS_ERR(auxdev))
+		return auxdev;
+
+	ret = devm_add_action_or_reset(dev, auxiliary_device_destroy,
+				       auxdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return auxdev;
+}
+EXPORT_SYMBOL_GPL(devm_auxiliary_device_create);
+
 void __init auxiliary_bus_init(void)
 {
 	WARN_ON(bus_register(&auxiliary_bus_type));
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 65dd7f15437474468acf0e28f6932a7ff2cfff2c..3ba11b3658833917a225916a508bddbd291bb545 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -254,6 +254,10 @@ int __auxiliary_driver_register(struct auxiliary_driver *auxdrv, struct module *
 
 void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv);
 
+struct auxiliary_device *devm_auxiliary_device_create(struct device *dev,
+						      const char *name,
+						      void *platform_data);
+
 /**
  * module_auxiliary_driver() - Helper macro for registering an auxiliary driver
  * @__auxiliary_driver: auxiliary driver struct

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241210-aux-device-create-helper-93141524e523

Best regards,
-- 
Jerome


