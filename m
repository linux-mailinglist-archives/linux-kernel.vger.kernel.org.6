Return-Path: <linux-kernel+bounces-373916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE39A5EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4559F1F221D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC731E25EC;
	Mon, 21 Oct 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRUhjDrS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00531E231E;
	Mon, 21 Oct 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500063; cv=none; b=Xn3oEsVJGJNiuCcfYb0LGvB68SBjvsb30QxrnfzMGv4gCiyxBBLElQZTv2B0SEUb54BxRyxbndJ3cTwNowzQiHDrJFEIKi4wtlz9YOUDWebyXgJ5IWDeGt3tTS+JcnAsa7efomko+DRY4+N8T6MKduZq7A82sOKNjHSEB/odYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500063; c=relaxed/simple;
	bh=Uw/SIwF2245678j94ASDHZGPpwER4WoN8ongnmaFp5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeyTVWZdEPB4mn0ULyKie8Sc40dItPi3J5CZQvDMnO1sTG7EcyyBReOgG2vsIeN+XyuDKD4vw7/43VI0d8yZ0qHbvHEo6Tg5CaFsTFlRSP58VayVZCN90ld1vGRuWn63lANdt3UaVivdQrWZvMjGP5xKUwjPzRa24Vp6S2IqH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRUhjDrS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500061; x=1761036061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uw/SIwF2245678j94ASDHZGPpwER4WoN8ongnmaFp5M=;
  b=iRUhjDrSoeEcRmZct7YkPoU5C9tiWxi1Eo3icSX5U+pSh7tnN99U3XG9
   vP8NsVHGKpdjyMAPviYgXAMzW40v5qPydZBB/QSReNd8OFLfZn9qT7O5M
   t3w8E9+Fbo+Ovb1FUElLXBt5ckNd5PsmzU58km2uL6jJsoE7GaUqmLmHW
   FcK3jbxPqKYJ9QQ8KVplNam0gY5s4iHPbYZjujsk7mUjJAnYp4nN0encB
   nxFS906+5AgUwLpQKlZFn/brPGBoQnG7MLaDu3fL/Rtrug4LDYv6eaxM3
   tsDf0v6vXLcWwAEZIAz984kXjCfTqFNYv+HCwwxsNk5bvLaRRiRHwrfRp
   A==;
X-CSE-ConnectionGUID: V4akWeIDQUmxE8jIKldrag==
X-CSE-MsgGUID: ssMcxp0HQeKzginFxi41nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28407186"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="28407186"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:41:01 -0700
X-CSE-ConnectionGUID: y9Hez4PrTYCisd5KBLG3EA==
X-CSE-MsgGUID: wuMUai4+QDCuOOBBwDGNNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="110299464"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 21 Oct 2024 01:40:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D1096299; Mon, 21 Oct 2024 11:40:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v2 2/3] platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
Date: Mon, 21 Oct 2024 11:38:52 +0300
Message-ID: <20241021084053.2443545-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macros defined in linux/cleanup.h to automate resource lifetime
control in the driver. The byproduct of this change is that the
negative conditionals are swapped by positive ones that are being
attached to the respective calls, hence the code uses the regular
pattern, i.e. checking for the error first.

Tested-by: Ferry Toth <fntoth@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 101 ++++++++++++---------------
 1 file changed, 43 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 290b38627542..3a1584ed7db8 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -13,6 +13,7 @@
  * along with other APIs.
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -99,23 +100,21 @@ static struct class intel_scu_ipc_class = {
  */
 struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void)
 {
-	struct intel_scu_ipc_dev *scu = NULL;
+	guard(mutex)(&ipclock);
 
-	mutex_lock(&ipclock);
 	if (ipcdev) {
 		get_device(&ipcdev->dev);
 		/*
 		 * Prevent the IPC provider from being unloaded while it
 		 * is being used.
 		 */
-		if (!try_module_get(ipcdev->owner))
-			put_device(&ipcdev->dev);
-		else
-			scu = ipcdev;
+		if (try_module_get(ipcdev->owner))
+			return ipcdev;
+
+		put_device(&ipcdev->dev);
 	}
 
-	mutex_unlock(&ipclock);
-	return scu;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(intel_scu_ipc_dev_get);
 
@@ -289,12 +288,11 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 
 	memset(cbuf, 0, sizeof(cbuf));
 
-	mutex_lock(&ipclock);
+	guard(mutex)(&ipclock);
+
 	scu = intel_scu_ipc_get(scu);
-	if (IS_ERR(scu)) {
-		mutex_unlock(&ipclock);
+	if (IS_ERR(scu))
 		return PTR_ERR(scu);
-	}
 
 	for (nc = 0; nc < count; nc++, offset += 2) {
 		cbuf[offset] = addr[nc];
@@ -319,13 +317,14 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 	}
 
 	err = intel_scu_ipc_check_status(scu);
-	if (!err) { /* Read rbuf */
-		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
-			wbuf[nc] = ipc_data_readl(scu, offset);
-		memcpy(data, wbuf, count);
-	}
-	mutex_unlock(&ipclock);
-	return err;
+	if (err)
+		return err;
+
+	for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
+		wbuf[nc] = ipc_data_readl(scu, offset);
+	memcpy(data, wbuf, count);
+
+	return 0;
 }
 
 /**
@@ -446,17 +445,15 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 	u32 cmdval;
 	int err;
 
-	mutex_lock(&ipclock);
+	guard(mutex)(&ipclock);
+
 	scu = intel_scu_ipc_get(scu);
-	if (IS_ERR(scu)) {
-		mutex_unlock(&ipclock);
+	if (IS_ERR(scu))
 		return PTR_ERR(scu);
-	}
 
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
-	mutex_unlock(&ipclock);
 	if (err)
 		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
 	return err;
@@ -485,18 +482,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 {
 	size_t outbuflen = DIV_ROUND_UP(outlen, sizeof(u32));
 	size_t inbuflen = DIV_ROUND_UP(inlen, sizeof(u32));
-	u32 cmdval, inbuf[4] = {};
+	u32 cmdval, inbuf[4] = {}, outbuf[4] = {};
 	int i, err;
 
 	if (inbuflen > 4 || outbuflen > 4)
 		return -EINVAL;
 
-	mutex_lock(&ipclock);
+	guard(mutex)(&ipclock);
+
 	scu = intel_scu_ipc_get(scu);
-	if (IS_ERR(scu)) {
-		mutex_unlock(&ipclock);
+	if (IS_ERR(scu))
 		return PTR_ERR(scu);
-	}
 
 	memcpy(inbuf, in, inlen);
 	for (i = 0; i < inbuflen; i++)
@@ -505,20 +501,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 	cmdval = (size << 16) | (sub << 12) | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
-
-	if (!err) {
-		u32 outbuf[4] = {};
-
-		for (i = 0; i < outbuflen; i++)
-			outbuf[i] = ipc_data_readl(scu, 4 * i);
-
-		memcpy(out, outbuf, outlen);
+	if (err) {
+		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
+		return err;
 	}
 
-	mutex_unlock(&ipclock);
-	if (err)
-		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
-	return err;
+	for (i = 0; i < outbuflen; i++)
+		outbuf[i] = ipc_data_readl(scu, 4 * i);
+
+	memcpy(out, outbuf, outlen);
+
+	return 0;
 }
 EXPORT_SYMBOL(intel_scu_ipc_dev_command_with_size);
 
@@ -572,18 +565,15 @@ __intel_scu_ipc_register(struct device *parent,
 	struct intel_scu_ipc_dev *scu;
 	void __iomem *ipc_base;
 
-	mutex_lock(&ipclock);
+	guard(mutex)(&ipclock);
+
 	/* We support only one IPC */
-	if (ipcdev) {
-		err = -EBUSY;
-		goto err_unlock;
-	}
+	if (ipcdev)
+		return ERR_PTR(-EBUSY);
 
 	scu = kzalloc(sizeof(*scu), GFP_KERNEL);
-	if (!scu) {
-		err = -ENOMEM;
-		goto err_unlock;
-	}
+	if (!scu)
+		return ERR_PTR(-ENOMEM);
 
 	scu->owner = owner;
 	scu->dev.parent = parent;
@@ -621,13 +611,11 @@ __intel_scu_ipc_register(struct device *parent,
 	err = device_register(&scu->dev);
 	if (err) {
 		put_device(&scu->dev);
-		goto err_unlock;
+		return ERR_PTR(err);
 	}
 
 	/* Assign device at last */
 	ipcdev = scu;
-	mutex_unlock(&ipclock);
-
 	return scu;
 
 err_unmap:
@@ -636,9 +624,6 @@ __intel_scu_ipc_register(struct device *parent,
 	release_mem_region(scu_data->mem.start, resource_size(&scu_data->mem));
 err_free:
 	kfree(scu);
-err_unlock:
-	mutex_unlock(&ipclock);
-
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
@@ -652,12 +637,12 @@ EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
  */
 void intel_scu_ipc_unregister(struct intel_scu_ipc_dev *scu)
 {
-	mutex_lock(&ipclock);
+	guard(mutex)(&ipclock);
+
 	if (!WARN_ON(!ipcdev)) {
 		ipcdev = NULL;
 		device_unregister(&scu->dev);
 	}
-	mutex_unlock(&ipclock);
 }
 EXPORT_SYMBOL_GPL(intel_scu_ipc_unregister);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


