Return-Path: <linux-kernel+bounces-269684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8909435BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A841F22D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F3B49626;
	Wed, 31 Jul 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FK8oVVlQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68857381AD;
	Wed, 31 Jul 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451381; cv=none; b=JwbaijztBH5HtRCzjnsl5+0DMfW/TBOPSPRhSnibR0itfTnjXH8PN7FrwPZgxTcfwabMQSkKX64znIhv6JK3LA5GChCe6d9iOC60ZnmT4De4yp8L8W92g4wujIzjVUE36erBbAOXUt/IM42qC4iXDlGNL4DKBV6xb9LqKkFpFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451381; c=relaxed/simple;
	bh=gT1ojs+HfsdojP33vEn+OJfDKKuLIhtMiC7HnCT+qOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elfJXjqFN7fHQRCY7X8Ei8ttPbeTsl79ZZjt4mCnFxp80np2leQPHysCS1D9vB5tNh5RBa3oZqHXCkmRp9LXeoTnJoxusVDupyo84eesiGQvW+O1REyW/tjFfFbaeCoUP+B5u1ncRsNmLRIfeSE5AMZdkQYXEAgOJARN+xML+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FK8oVVlQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722451380; x=1753987380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gT1ojs+HfsdojP33vEn+OJfDKKuLIhtMiC7HnCT+qOY=;
  b=FK8oVVlQcBKVoLmMB2O1VgHs9W02e9w6b68N6Mne1M7gMkcjimqVCVKF
   bw1SwEmXfvTKoW7DJoRw8WT8A3jZZsLH06yW9fNBG5ez2fICpFgUccST5
   2hduhqMS8WVKEe+utl0PZj/R5YJMLDu3bonqkbL9l7ZR9jYRnz8jzsJyi
   eRSww/+KLwV/q7+baVlFBO01QKEuJ4AZ47+Zgye6iYy1l5N2Pa2TUljG2
   6WqFx0UVKiZOrREH4TsdssYVseI9RA6LioCBhJ4UUCcSj8jPsrGNOzkc6
   95WTSFGjKbVlaafxDAdI70HjR9MqRe67I7rOTQcUH2b9Rxj3Ff6m7QSO0
   w==;
X-CSE-ConnectionGUID: AgfyOjprTxWmDJCePHdl6Q==
X-CSE-MsgGUID: GCgwH3UXT52GU2FV8PNV1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="23270214"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="23270214"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 11:42:59 -0700
X-CSE-ConnectionGUID: l4+teZzUSmaLaonzjyo7LQ==
X-CSE-MsgGUID: uxjy+WVvR8CgcMt1r71ZDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85399134"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa002.jf.intel.com with ESMTP; 31 Jul 2024 11:42:58 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Simplify isst_misc_reg() and isst_misc_unreg()
Date: Wed, 31 Jul 2024 11:42:56 -0700
Message-ID: <20240731184256.1852840-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit '1630dc626c87 ("platform/x86: ISST: Add model specific
loading for common module")' isst_misc_reg() and isst_misc_unreg() can be
simplified. Since these functions are only called during module_init()
and module_exit() respectively, there is no contention while calling
misc_register()/misc_deregister or isst_if_cpu_info_init()/
isst_if_cpu_info_exit().

Hence remove mutex and reference counting.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/speed_select_if/isst_if_common.c    | 42 +++++--------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 3065f149e721..febfd5eeceb4 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -651,10 +651,6 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 
 /* Lock to prevent module registration when already opened by user space */
 static DEFINE_MUTEX(punit_misc_dev_open_lock);
-/* Lock to allow one shared misc device for all ISST interfaces */
-static DEFINE_MUTEX(punit_misc_dev_reg_lock);
-static int misc_usage_count;
-static int misc_device_ret;
 static int misc_device_open;
 
 static int isst_if_open(struct inode *inode, struct file *file)
@@ -720,39 +716,23 @@ static struct miscdevice isst_if_char_driver = {
 
 static int isst_misc_reg(void)
 {
-	mutex_lock(&punit_misc_dev_reg_lock);
-	if (misc_device_ret)
-		goto unlock_exit;
-
-	if (!misc_usage_count) {
-		misc_device_ret = isst_if_cpu_info_init();
-		if (misc_device_ret)
-			goto unlock_exit;
-
-		misc_device_ret = misc_register(&isst_if_char_driver);
-		if (misc_device_ret) {
-			isst_if_cpu_info_exit();
-			goto unlock_exit;
-		}
-	}
-	misc_usage_count++;
+	int ret;
 
-unlock_exit:
-	mutex_unlock(&punit_misc_dev_reg_lock);
+	ret = isst_if_cpu_info_init();
+	if (ret)
+		return ret;
 
-	return misc_device_ret;
+	ret = misc_register(&isst_if_char_driver);
+	if (ret)
+		isst_if_cpu_info_exit();
+
+	return ret;
 }
 
 static void isst_misc_unreg(void)
 {
-	mutex_lock(&punit_misc_dev_reg_lock);
-	if (misc_usage_count)
-		misc_usage_count--;
-	if (!misc_usage_count && !misc_device_ret) {
-		misc_deregister(&isst_if_char_driver);
-		isst_if_cpu_info_exit();
-	}
-	mutex_unlock(&punit_misc_dev_reg_lock);
+	misc_deregister(&isst_if_char_driver);
+	isst_if_cpu_info_exit();
 }
 
 /**
-- 
2.43.0


