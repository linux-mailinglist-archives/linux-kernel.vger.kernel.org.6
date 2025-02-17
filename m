Return-Path: <linux-kernel+bounces-517939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63374A387DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82921898A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADB224B01;
	Mon, 17 Feb 2025 15:39:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB9022577B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806777; cv=none; b=Q0lRd7Vm8D86zLxqzFsoGdcv+AEEUw172U4RZi6cknUeHwAKBr/CZh7tknEkkHOSPdXxhzmeRW1IuCv0mDS68++y9FYM5jcTXeZjvogN+511D4Sne26z0jBvv+RKuzi/j8KZ3WQ45ZtDk2mEo6jaQbJgRpLXuyonnh0t1EKQ7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806777; c=relaxed/simple;
	bh=4dfr91AKCjn01WZT79ojy8261ESSeOs8AyY7PVfWDgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=E7oAUnEB+0AxJtZwilvGQkPi6nhXL2rBcCBIvKD88VZsxI+1Q9aESURvASd2WxVVU6a/hB8Nd8/LbZPQs59HLRLm9awuHcW3NmrB5fvoIRKAh4w9XmYn/+RslajFZKiJutTrztcsv574m3jUaOYMbmZCKdU/o2WLFBtRXioxTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9F0176C;
	Mon, 17 Feb 2025 07:39:54 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A9BD3F6A8;
	Mon, 17 Feb 2025 07:39:34 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:47 +0000
Subject: [PATCH v3 06/19] firmware: arm_ffa: Refactor addition of partition
 information into XArray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-6-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=0rtRvJYON+bBWGuI7xH2qiK+GlnT4NIkX7bmwfVc55I=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1guRY129t9hXimLHH74gX733HjYK1vFoEV4y
 d/024VfviOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mMHKEADOvrF2of7ReK/hGLkBM+iIObw4IIA0HmrXAFytlxoBicuIytplDbeoHH79vLASlI/rxRH
 RpQTqCpnksJoCYpvbxG5VdmoT8OyNFcXiqqk8VefIf12hdJ0Gk9aeFcBPFTS+S+hNoyWfIxG6bD
 R14rbzRMW5EdcHjMfF6WmMDtwD/3O30WKnPI/lwPXnEXybXM+Xk3mluoLJqRZ7JuoaHXw2Fck+S
 nUhpNqofZpD7ZRh0iSEIjh7huhnndAtmBLnspDBZc3Jam1E4IXpBOup8J28856MA8tla1GY4E+3
 34W01AUozEa4nBRE3i0C9cuoBBvdDso8ttYfyRgp8DJAnULg+pBO4474v8gpa8sOYRdreg9Ld7n
 brF9PGKN7J/BPecen8nTeHDH6c58ZgNFz0IB157P8VPM48IaFMUEUgBeZ1/DBc7Ddsf8Xi0Wq91
 oEmJzoHf8T54WGQVu+W5YRt8LXwAMiI4Q954zF9R/n8OBducc+4U93WwIlDsO54/yUE5iEaP4sK
 saT4p2yXQ4CEVCnFiB40T2QEJIQpCDsgBkLKjtUQn96d+3iz/ZNiidEpQy1ZMiCMacwpWSlWqTF
 dZh7pbCu/nGirN5ZNj1pHcTL1y5SSY2jZXPfuLG/Vuo862zQztTYD+CyIgruVdY3PEnj14lP0+P
 Fs8G1PXRgcaYCBw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

From: Viresh Kumar <viresh.kumar@linaro.org>

Move the common code handling addition of the FF-A partition information
into the XArray as a new routine. No functional change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 47 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 87e106c728b89f3ce7c11219cf7cad9cc166dda2..2994b5ee63bc7feafc15e535cf8a2d46e6003968 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1423,11 +1423,30 @@ static struct notifier_block ffa_bus_nb = {
 	.notifier_call = ffa_bus_notifier,
 };
 
+static int ffa_xa_add_partition_info(int vm_id)
+{
+	struct ffa_dev_part_info *info;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	rwlock_init(&info->rw_lock);
+	ret = xa_insert(&drv_info->partition_info, vm_id, info, GFP_KERNEL);
+	if (ret) {
+		pr_err("%s: failed to save partition ID 0x%x - ret:%d. Abort.\n",
+		       __func__, vm_id, ret);
+		kfree(info);
+	}
+
+	return ret;
+}
+
 static int ffa_setup_partitions(void)
 {
 	int count, idx, ret;
 	struct ffa_device *ffa_dev;
-	struct ffa_dev_part_info *info;
 	struct ffa_partition_info *pbuf, *tpbuf;
 
 	if (drv_info->version == FFA_VERSION_1_0) {
@@ -1461,39 +1480,17 @@ static int ffa_setup_partitions(void)
 		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
 			ffa_mode_32bit_set(ffa_dev);
 
-		info = kzalloc(sizeof(*info), GFP_KERNEL);
-		if (!info) {
+		if (ffa_xa_add_partition_info(ffa_dev->vm_id)) {
 			ffa_device_unregister(ffa_dev);
 			continue;
 		}
-		rwlock_init(&info->rw_lock);
-		ret = xa_insert(&drv_info->partition_info, tpbuf->id,
-				info, GFP_KERNEL);
-		if (ret) {
-			pr_err("%s: failed to save partition ID 0x%x - ret:%d\n",
-			       __func__, tpbuf->id, ret);
-			ffa_device_unregister(ffa_dev);
-			kfree(info);
-		}
 	}
 
 	kfree(pbuf);
 
 	/* Allocate for the host */
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		/* Already registered devices are freed on bus_exit */
-		ffa_partitions_cleanup();
-		return -ENOMEM;
-	}
-
-	rwlock_init(&info->rw_lock);
-	ret = xa_insert(&drv_info->partition_info, drv_info->vm_id,
-			info, GFP_KERNEL);
+	ret = ffa_xa_add_partition_info(drv_info->vm_id);
 	if (ret) {
-		pr_err("%s: failed to save Host partition ID 0x%x - ret:%d. Abort.\n",
-		       __func__, drv_info->vm_id, ret);
-		kfree(info);
 		/* Already registered devices are freed on bus_exit */
 		ffa_partitions_cleanup();
 	}

-- 
2.34.1


