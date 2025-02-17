Return-Path: <linux-kernel+bounces-517367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08DA37FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5877A1372
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007D19E7FA;
	Mon, 17 Feb 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OO3VBxZd"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540221767B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787472; cv=none; b=Sv7EtnHep3FM8/yIIwd7nd//HaSdJ0uWZMoA7XdXkg5Xv34b5Ep5aInVS/5hy00rIzsIT7dwyDqTFmTF2o40ZiugNZ1e6SEqWeCRtb7JkH0q62p1y3kKw0gEKfeSti8t8sZ9zz94bLnCShPNqGNEnh6W6/Y0xGFhIOZb1ix+FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787472; c=relaxed/simple;
	bh=1hkKPUWrxq7K5LZ+JEA021QIrfwfKcgoOdedz+W5Q9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtvxsSNFeOZZ22EXfNLFbVSbkFv2YE9YgBAj3HjqhMW+D7zXDysU43jD5tPAAufemNVsrHiKxGSSYdgYAP83ngZf24d/IYMOFnBzn0/iT2Sa8u7umh7R0LHXS/P1dTi67eX81+5p+Da4cRwGclj+aDwFewG1AFR7D/nnKYbRCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OO3VBxZd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abba1b74586so89116266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787468; x=1740392268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO0IV1Fa2w4jRN2VF1J5DC4vESX9Rcd9+LGQ+k/6XZk=;
        b=OO3VBxZd2S8Aj8r1yxFIR8d5NhbGf1AJ2aOLJ0kLtZRSLbhB1k99nuC/RsU9mzdfIz
         UG/xoi5Y/PsG04GKdC85Hs4CtQGEiuhUGl62pEK87rBcZ3BfGK/UX4FWB5FvqC6X4CAM
         yegjLcNhdxx78BoqFgMiDF1jVQ8GME9UbnbbUiWnaWyMJEQhOD951NbFE8x+E/L9BGJY
         AI316Ot9PtKkLIdC/pTG/U8tX5CR0lQfirAhevjpiGF66fevZ0bihC4B7ybMGeKsm7xJ
         DfoAj3kFeWgV+h94BRlhi+jp1lFxkbOCl41ux4MtXnELW9+XTtOkMejD7DPIeHa81s9r
         ZYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787468; x=1740392268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO0IV1Fa2w4jRN2VF1J5DC4vESX9Rcd9+LGQ+k/6XZk=;
        b=RdGlwedTufabmg1Ig7YL5oBLey9HWVIJC3ZN6cyVUzh7ePCoXeSfUYqdLKgmpFpBkL
         ewg7p/jFGCz4w1bfjZaovkPfurQszmIg8j0yCcTxfczKR3UnE9Ro8TMEaYpxOnkG0R4H
         r6nI4OzKRWj5EsRks0T0AgpW0MWPv1/6Wp+qD1B3k/dychifzOgO0lC/NAJax7DC5zkU
         jCFU7bj8wpO87xUMBLEVi1eG37uGApdf1ZcKW4ukbBZHWf3MeE8Yw5LBo63JwkYmzX+N
         4DlSDLKN73QgmsRKisibHoKbcmaW7IFABrv7gUZS6LQOIIrgL/FQ9hc7dT0uQT0Ks9wj
         FLPw==
X-Gm-Message-State: AOJu0YyIj3SAR5na7cWIdpyQHOzsbTYGPWkVK5v9rbIe0ypbRkoZS5p4
	U7Wzw2vJ9F14UpNQqq1DytCW57KSn/o1f1oZnLPvnqrb4gC4PDSB48UpRNvOvWc=
X-Gm-Gg: ASbGnct9cm1KlCwxm2HR+isn0b6TU6Q8JtShFmIDyAV8xJmO0GluwiyPejr979E0UDt
	KoqZbe6hphzrZLHf3JS5CDztfqUdnmIdMoRhICuyDsCvQ1xSjacVW0WuPO8Jh1gjvlU0QAKc6IO
	INYvJ/K/Jka+sFmBXc2kulFtSDYRmmDRzc9iJKoA9GozDKUrb4jPC5c9gVOKxbi987yQm/r2Ujh
	plrQgyeFJZ5r5jHST6se2gAfqjaIXjjoBdT8YMbGW6oj2SxdCKS/26CAuRfJRe01YJ4IGKOCW5h
	HRyeJvKRCAi+1kzb5lFMcguk
X-Google-Smtp-Source: AGHT+IFeqQRmHtufh/hnET9/WDBmQ08tktpUPlNNW2f16K2ts13CoRF9gAnCjQkfdJKdSGt+WA/5Ug==
X-Received: by 2002:a17:906:3290:b0:ab7:d179:2496 with SMTP id a640c23a62f3a-abb70a791dcmr775286966b.6.1739787468349;
        Mon, 17 Feb 2025 02:17:48 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:48 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 02/10] pstore/smem: add new pstore/smem type of pstore
Date: Mon, 17 Feb 2025 12:16:58 +0200
Message-ID: <20250217101706.2104498-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add shared memory type of pstore.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/Kconfig           |  13 ++++
 fs/pstore/Makefile          |   3 +
 fs/pstore/smem.c            | 115 ++++++++++++++++++++++++++++++++++++
 include/linux/pstore_smem.h |   9 +++
 4 files changed, 140 insertions(+)
 create mode 100644 fs/pstore/smem.c
 create mode 100644 include/linux/pstore_smem.h

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 3acc38600cd1..84f87edf9b8f 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -81,6 +81,19 @@ config PSTORE_RAM
 
 	  For more information, see Documentation/admin-guide/ramoops.rst.
 
+config PSTORE_SMEM
+	tristate "Log panic/oops to a shared memory buffer"
+	depends on PSTORE
+	select PSTORE_ZONE
+	help
+	  This enables panic and oops messages to be logged to memory
+	  that is shared between different hardware blocks in the system.
+	  This shared memory can be a static ram, a part of dynamic RAM,
+	  a dedicated cache or memory area specific for crash dumps,
+	  or even a memory on an attached device.
+
+	  if unsure, say N.
+
 config PSTORE_ZONE
 	tristate
 	depends on PSTORE
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index c270467aeece..f2a314ca03a0 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -18,3 +18,6 @@ obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
 
 pstore_blk-objs += blk.o
 obj-$(CONFIG_PSTORE_BLK)	+= pstore_blk.o
+
+pstore_smem-objs += smem.o
+obj-$(CONFIG_PSTORE_SMEM)	+= pstore_smem.o
diff --git a/fs/pstore/smem.c b/fs/pstore/smem.c
new file mode 100644
index 000000000000..9eedd7df5446
--- /dev/null
+++ b/fs/pstore/smem.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implements pstore backend driver for shared memory devices,
+ * using the pstore/zone API.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/string.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pstore_smem.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init_syscalls.h>
+#include <linux/mount.h>
+
+/*
+ * All globals must only be accessed under the pstore_smem_lock
+ * during the register/unregister functions.
+ */
+static DEFINE_MUTEX(pstore_smem_lock);
+static struct pstore_device_info *pstore_device_info;
+
+static int __register_pstore_device(struct pstore_device_info *dev)
+{
+	int ret;
+
+	lockdep_assert_held(&pstore_smem_lock);
+
+	if (!dev) {
+		pr_err("NULL device info\n");
+		return -EINVAL;
+	}
+	if (!dev->zone.total_size) {
+		pr_err("zero sized device\n");
+		return -EINVAL;
+	}
+	if (!dev->zone.read) {
+		pr_err("no read handler for device\n");
+		return -EINVAL;
+	}
+	if (!dev->zone.write) {
+		pr_err("no write handler for device\n");
+		return -EINVAL;
+	}
+
+	/* someone already registered before */
+	if (pstore_device_info)
+		return -EBUSY;
+
+	/* zero means not limit on which backends to attempt to store. */
+	if (!dev->flags)
+		dev->flags = UINT_MAX;
+
+	/* Initialize required zone ownership details. */
+	dev->zone.name = KBUILD_MODNAME;
+	dev->zone.owner = THIS_MODULE;
+
+	ret = register_pstore_zone(&dev->zone);
+	if (ret == 0)
+		pstore_device_info = dev;
+
+	return ret;
+}
+/**
+ * register_pstore_smem_device() - register smem device to pstore
+ *
+ * @dev: smem device information
+ *
+ * Return:
+ * * 0		- OK
+ * * Others	- some error.
+ */
+int register_pstore_smem_device(struct pstore_device_info *dev)
+{
+	int ret;
+
+	mutex_lock(&pstore_smem_lock);
+	ret = __register_pstore_device(dev);
+	mutex_unlock(&pstore_smem_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_pstore_smem_device);
+
+static void __unregister_pstore_device(struct pstore_device_info *dev)
+{
+	lockdep_assert_held(&pstore_smem_lock);
+	if (pstore_device_info && pstore_device_info == dev) {
+		unregister_pstore_zone(&dev->zone);
+		pstore_device_info = NULL;
+	}
+}
+
+/**
+ * unregister_pstore_smem_device() - unregister smem device from pstore
+ *
+ * @dev: smem device information
+ */
+void unregister_pstore_smem_device(struct pstore_device_info *dev)
+{
+	mutex_lock(&pstore_smem_lock);
+	__unregister_pstore_device(dev);
+	mutex_unlock(&pstore_smem_lock);
+}
+EXPORT_SYMBOL_GPL(unregister_pstore_smem_device);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@linaro.org>");
+MODULE_DESCRIPTION("pstore backend for smem devices");
diff --git a/include/linux/pstore_smem.h b/include/linux/pstore_smem.h
new file mode 100644
index 000000000000..f0ad23e117c4
--- /dev/null
+++ b/include/linux/pstore_smem.h
@@ -0,0 +1,9 @@
+#ifndef PSTORE_SMEM_H
+#define PSTORE_SMEM_H
+
+#include <linux/pstore_zone.h>
+
+int register_pstore_smem_device(struct pstore_device_info *dev);
+void unregister_pstore_smem_device(struct pstore_device_info *dev);
+
+#endif
-- 
2.43.0


