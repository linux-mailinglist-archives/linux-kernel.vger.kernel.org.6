Return-Path: <linux-kernel+bounces-566594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F61A67A48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399043B9EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3AB212B3B;
	Tue, 18 Mar 2025 17:02:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA4B191F92
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317357; cv=none; b=HK8wirsZFxrMRXVj3l6NkzkODWB8pKoCC882vM9HYgdIA3/3782hT7kXWAx2MAiXAPMxOlmTyklyR5IpdvBG76dwSxU7klfAwcsE1IuqKkL33V0tI0fZ9aXTX4kQrQGjMwu7pvxJrr5BROOqrlwuQyggmP4lz3xd4MqI3Dz5694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317357; c=relaxed/simple;
	bh=3Rfe8x11K1hDNckFVUjLg8e85l+1UVRzlqA4I/qqaKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5WV+zebnOEBh27dB0YJQnadZpLGYVH+DfZj0bxYnulxlumCHSpn7BLPHn1fDSylLDVg13spC8M4JqfAZlW2xr57cx9Iz7SwZnJj+vE9S+w88m9r3eoM0qi6yWBZJVYbfdKAd8/Pd8qxF8PDySE5qvGNjzpm/NmbViPcWNGw+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4917152B;
	Tue, 18 Mar 2025 10:02:39 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBA233F673;
	Tue, 18 Mar 2025 10:02:30 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 18 Mar 2025 17:01:39 +0000
Subject: [PATCH v2 1/8] driver core: add helper macro for
 module_faux_driver() boilerplate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-plat2faux_dev-v2-1-e6cc73f78478@arm.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2927; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=3Rfe8x11K1hDNckFVUjLg8e85l+1UVRzlqA4I/qqaKU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2acit4KF7FrO7h9Ph/unfFe5tmfL40Vj6F4l9
 naD9oG/2HmJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIgAKCRAAQbq8MX7i
 mN/lD/0XqRFrVRFkPqjLxeN7LtpaLytOPYDPwd2UzrOpQ+qMLu8evCO+xCBKuw4z8IzW5E1wxJz
 qLFLwlnwBz9NGxJiJZJyqw0vSw1JtJk+cgPbstNgA2RnGI48XyQ1H0t6FU3ZW3xarPIJdLe4hQu
 dmbpxx3rwBDtS58Uz9zHWGe3scRTfHtLvw6PRRn96CxMR/bmRmhvqtSF1JVs5TSvifC+WyZN0vO
 6AY5xedLcmsutOyMGIu+3R2IRg5MPbtnoYIP1oOQr5lnTLN0hp4XubXvnQS2tnt49xt6jlWieDG
 lGphhpppmNT8jwhrk/xBh6Bc3Cx9PFj3arHDg9B51whGP540AxemPuzKrY2d075gvAVVDa3/j1+
 A1lzZfHsBIuFRKyUE5EE0P54++dVaaTXUSk+wAaF5I44WPfpdpOlm5zGMXSEcTjyLDpyPw5Resj
 FIn46SmSXYavQdppxo4E+x7Y/koBysaBDcgcWeipMaHIsdgWQUDN07GjH3Z8Spd/aiBeMlMZdyL
 vDoT0Wga6ALUUHJA8gFj38P/0TIEThaoNpGVW12bgpOi9tvZsKZM4jFQKMP7tHyLIa1PSGZLIJm
 tdWiEvffZvlqLMZjMzOEsr87K2Uff/vDeqw/IA/oF8wKQu/w3lMAqduN0OlzjBYZCLoGGkVfPNi
 r7xw360aIPu6xRw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

For simple modules that needs to create a faux device without any
additional setup code ends up being a block of duplicated boilerplate.

Add a new macro, module_faux_driver(), which help to replaces the
those duplicated boilerplate.

This macro use the same idea of module_platform_driver() but adds this
initial condition to avoid creation of faux device if not necessary.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/device/faux.h | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/device/faux.h b/include/linux/device/faux.h
index 9f43c0e46aa45bf492788adcdc081df5cc0c5fc0..4a54736d86595e46c98ac3ab9c45a7e5a344333e 100644
--- a/include/linux/device/faux.h
+++ b/include/linux/device/faux.h
@@ -15,6 +15,7 @@
 
 #include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/stringify.h>
 
 /**
  * struct faux_device - a "faux" device
@@ -66,4 +67,52 @@ static inline void faux_device_set_drvdata(struct faux_device *faux_dev, void *d
 	dev_set_drvdata(&faux_dev->dev, data);
 }
 
+#define FAUX_DEVICE(__faux_devname) \
+static struct faux_device *__faux_devname##_dev;
+
+#define FAUX_DEVICE_OPS(__faux_devname, __faux_probe, __faux_remove) \
+static const struct faux_device_ops __faux_devname##_ops = {	\
+	.probe = __faux_probe,					\
+	.remove = __faux_remove,				\
+};								\
+FAUX_DEVICE(__faux_devname)
+
+static inline int
+__faux_device_register(struct faux_device **faux_dev, const char *name,
+		       const struct faux_device_ops *faux_ops, bool condition)
+{
+	struct faux_device *fdev;
+
+	if (!condition)
+		return 0;
+
+	fdev = faux_device_create(name, NULL, faux_ops);
+	if (!fdev)
+		return -ENODEV;
+
+	*faux_dev = fdev;
+	return 0;
+}
+
+#define faux_device_register(faux_dev, faux_devname, init_condition) \
+	__faux_device_register(faux_dev, __stringify(faux_devname), \
+			       &faux_devname##_ops, init_condition)
+
+#define faux_device_unregister(faux_dev, ...) \
+		faux_device_destroy(*faux_dev)
+
+/* module_faux_driver() - Helper macro for faux drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit(). The module init
+ * creates a faux device if the init condition is met and module exit
+ * destroys the created device. FAUX_DEVICE_OPS must be used to declare
+ * faux device ops and the device pointer.
+ */
+#define module_faux_driver(__faux_devname, __faux_probe, __faux_remove, \
+			   __init_condition) \
+	FAUX_DEVICE_OPS(__faux_devname, __faux_probe, __faux_remove) \
+	module_driver(__faux_devname##_dev, faux_device_register, \
+		      faux_device_unregister, __faux_devname, __init_condition)
+
 #endif /* _FAUX_DEVICE_H_ */

-- 
2.34.1


