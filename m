Return-Path: <linux-kernel+bounces-367949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADE9A08B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080D71C229C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEC20820D;
	Wed, 16 Oct 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PARMvzzc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6D2076BA;
	Wed, 16 Oct 2024 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079441; cv=none; b=sGsP60ntubEzkzzN+oJCHy/scL+1dh2h3mcpponvKympa3/nClGVKafWe0XktQHKvAGk0KA7BBviJOQk8xghCkbWGIR+4MEkdjWrz68ETWcGDPYHZWQnYG3jGAMRBfhZHKgxFFLSVgHR9S8qjQ7AFbEdcjxfv1BWAnP9s3VQrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079441; c=relaxed/simple;
	bh=aKOY49hb3WRsd+qIY7bifniPUi/YlDVXp2RWxXuIWr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1NDAxLlPmNQSUfhtwjrHrmck4O/6weexyHTC01HSvQhpGCOPqOLbkfS1VucgVXDjIuTQvrmTkhjkJVC2StYIYGLGpd97JABfqg9ls6xB7FPl6Qq4i8HH8/+b/+vznjstfNJY7upP01ro4DwO1gyRV94oXAhMqkYMdNK4s3jWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PARMvzzc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729079440; x=1760615440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKOY49hb3WRsd+qIY7bifniPUi/YlDVXp2RWxXuIWr8=;
  b=PARMvzzcLUBaa+UVR/B0IJe3U8r93cf1R1HX40UsfQ6tAHfd2CDP++Ze
   nnPrFwG/GtBSgtJTnsX9JvZNfxakb+cUuuYiaG3wQB6/eO/fOYpNqDcdV
   8s7reUmOYF+f+cPEFCNBOMmB265H/lg03gwbyKPAa8r9RF5U/bgfgjr7f
   4kNhpPBqQ+zw9D9EVotGhlM852pVMQg278YwJh/UKT/HipnhASAE44Kk4
   NyQw+eJaUgWjveT7uDhVoWNvUADye5zUMhMS05uMFWZC4I33ptVIpmdWm
   5+XVUOUrwNlRm9IemFOAvb7VsemAtR4YRk5oCkPN+mB34HGG71n9atbF5
   g==;
X-CSE-ConnectionGUID: mxHJXBxjSCWIfZjzeKRsyQ==
X-CSE-MsgGUID: v1zDnfFeQB+krDF76upwaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28306994"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28306994"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:50:38 -0700
X-CSE-ConnectionGUID: 3hUcKA05Rn+k7hl9ugj83w==
X-CSE-MsgGUID: qbR+k8R6Tmqu/RpciFpBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78548800"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 16 Oct 2024 04:50:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C7BB91AC; Wed, 16 Oct 2024 14:50:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v1 2/3] platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
Date: Wed, 16 Oct 2024 14:48:25 +0300
Message-ID: <20241016115033.858574-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
References: <20241016115033.858574-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macros defined in linux/cleanup.h to automate resource lifetime
control in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 102 ++++++++++++---------------
 1 file changed, 44 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 290b38627542..ffb0a2524388 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -13,6 +13,7 @@
  * along with other APIs.
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -99,23 +100,22 @@ static struct class intel_scu_ipc_class = {
  */
 struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void)
 {
-	struct intel_scu_ipc_dev *scu = NULL;
+	guard(mutex)(&ipclock);
 
-	mutex_lock(&ipclock);
 	if (ipcdev) {
 		get_device(&ipcdev->dev);
+
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
 
@@ -289,12 +289,11 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 
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
@@ -319,13 +318,14 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
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
@@ -446,17 +446,15 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
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
@@ -485,18 +483,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
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
@@ -505,20 +502,17 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
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
 
@@ -572,18 +566,15 @@ __intel_scu_ipc_register(struct device *parent,
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
@@ -621,13 +612,11 @@ __intel_scu_ipc_register(struct device *parent,
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
@@ -636,9 +625,6 @@ __intel_scu_ipc_register(struct device *parent,
 	release_mem_region(scu_data->mem.start, resource_size(&scu_data->mem));
 err_free:
 	kfree(scu);
-err_unlock:
-	mutex_unlock(&ipclock);
-
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
@@ -652,12 +638,12 @@ EXPORT_SYMBOL_GPL(__intel_scu_ipc_register);
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


