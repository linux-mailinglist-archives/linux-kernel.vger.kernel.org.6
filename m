Return-Path: <linux-kernel+bounces-374453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E79A6A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DB3281775
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214A61F8F04;
	Mon, 21 Oct 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0q+qn87"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D61EF923;
	Mon, 21 Oct 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517835; cv=none; b=gh6N311bIWIt+Ij1xHtfXpQQhzSoIcpvWl/j6mhVYFoxh61GHTxOI9LX2RNf3eJliMbLQH/VbYZ5V14ssxcfyiEFXdVu6qT72izDX7HlUYB7hmbbTtWbOs0E7xUeHw5LAD5AXZM4vIxnlOiRe2/tiVerKLqikpyoyOIYNJdB0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517835; c=relaxed/simple;
	bh=3MUQhfcoH/nVDWknWR7lxyKol5ZT85TjIh+n55UNxI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVHhfrcoVF+I/BR9ueh2Zfs/b1w1N/uLJHKly028mOAo2jf09428wW40tcIlqsFyGc0T2grs3QhpXdL5Trzk+6Q1IX7+8585Jw9PyLj1rDynKAPs6gHZUIuwSKIIkCt5q26D+9uPlEpSHrRCM4YyO+ibPBf3WhudFlrlp/F+7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0q+qn87; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729517833; x=1761053833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3MUQhfcoH/nVDWknWR7lxyKol5ZT85TjIh+n55UNxI8=;
  b=Z0q+qn87ZE9PhAg+CeMukEkrrNPHpVgrBqZJy4TESj653tV2Nepn/ohn
   rVlYiMKNLsD9SnpnSJ7kYfarzqihBCvXZpBPTGNKbEubhTLHn0N8uLGHE
   K/ZJCa3SCevjym1mxzN/z1tVsQgs7IYvRrKApWKPsiiOQ0paBJm+JdlwS
   ap570DTDeDwp0L7nVIFcwTO0lzfkc/u+aaf0fZBsYrIdIBXkaHzK48hBU
   0Wu8xPIxF/CRVmp9jI3NVPjz94ETr68dx/GTGngvPxADa0jYjudExs6iv
   tov7+QAWQEZtIF7RErNfiuXbuOfd+9aAUpvgakyi8gIUGZZhu6yXdal6t
   A==;
X-CSE-ConnectionGUID: rtNzciWiQ4eH6FpCCA2+Xw==
X-CSE-MsgGUID: CjsBjLeYQpWfHixrQxRK/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29210970"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29210970"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:37:10 -0700
X-CSE-ConnectionGUID: 0cwJbabsQVqhUF0xY3S2SA==
X-CSE-MsgGUID: IlOKi4PtRAeUX2e4GS+hDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="83544887"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 21 Oct 2024 06:37:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 60EE536B; Mon, 21 Oct 2024 16:37:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 3/5] platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
Date: Mon, 21 Oct 2024 16:34:31 +0300
Message-ID: <20241021133705.2933464-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
References: <20241021133705.2933464-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 65 +++++++++++-----------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 290b38627542..9829d4145c58 100644
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
@@ -324,7 +322,6 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 			wbuf[nc] = ipc_data_readl(scu, offset);
 		memcpy(data, wbuf, count);
 	}
-	mutex_unlock(&ipclock);
 	return err;
 }
 
@@ -446,17 +443,15 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
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
@@ -491,12 +486,11 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
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
@@ -515,7 +509,6 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 		memcpy(out, outbuf, outlen);
 	}
 
-	mutex_unlock(&ipclock);
 	if (err)
 		dev_err(&scu->dev, "IPC command %#x failed with %d\n", cmdval, err);
 	return err;
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


