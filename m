Return-Path: <linux-kernel+bounces-407265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B38E9C6B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EA0B25B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2518BBA2;
	Wed, 13 Nov 2024 08:58:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A8185936
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488286; cv=none; b=RPoH6CNwcILGg7X3wDzi5oResRJwO4+Uzy2kjG/0+C5uL/zPWyu153rY1JQ0kIC89p3YADoZy8r7iSU5uGntR45AOBDgBO7VnvHa0QX6PrVN0HK41oB2WvV+8SLCfkUttbe/wC5YXjIS+wIAJKhYASrbCuvw0rq5R1PUknyXHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488286; c=relaxed/simple;
	bh=nXIoM2Ginl3Q2I224VFn1HMh0EjvzcaH4pfKg4jngko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q0RyR+cCK+yyjg9rIkfiPtl94Bt41hrANojfPnNn04qwGkidwyHyWGAkR+5wDD8+UphdRySvrMshy4sv+o1YqAlPG/nr5bAFl2DdHf+zUrBM84UOiYLlauL8Qf1RfMJNMu+UEw/dFZS9tTjZr5bG8Rj87/0gc/+HZJDpC5q/vA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XpHFQ51B7z1jy0d;
	Wed, 13 Nov 2024 16:56:10 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B135180042;
	Wed, 13 Nov 2024 16:58:00 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 16:57:59 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <gregkh@linuxfoundation.org>, <tiantao6@hisilicon.com>
CC: <rafael@kernel.org>, <Jonathan.Cameron@huawei.com>, <baohua@kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH] topology: Keep the cpumask unchanged when printing cpumap
Date: Thu, 14 Nov 2024 00:59:00 +0800
Message-ID: <20241113165900.78095-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500004.china.huawei.com (7.202.181.242)

During fuzz testing, the following warning was discovered:

 different return values (15 and 11) from vsnprintf("%*pbl
 ", ...)

 test:keyward is WARNING in kvasprintf
 WARNING: CPU: 55 PID: 1168477 at lib/kasprintf.c:30 kvasprintf+0x121/0x130
 Call Trace:
  kvasprintf+0x121/0x130
  kasprintf+0xa6/0xe0
  bitmap_print_to_buf+0x89/0x100
  core_siblings_list_read+0x7e/0xb0
  kernfs_file_read_iter+0x15b/0x270
  new_sync_read+0x153/0x260
  vfs_read+0x215/0x290
  ksys_read+0xb9/0x160
  do_syscall_64+0x56/0x100
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

The call trace shows that kvasprintf() reported this warning during the
printing of core_siblings_list. kvasprintf() has several steps:

 (1) First, calculate the length of the resulting formatted string.

 (2) Allocate a buffer based on the returned length.

 (3) Then, perform the actual string formatting.

 (4) Check whether the lengths of the formatted strings returned in
     steps (1) and (2) are consistent.

If the core_cpumask is modified between steps (1) and (3), the lengths
obtained in these two steps may not match. Indeed our test includes cpu
hotplugging, which should modify core_cpumask while printing.

To fix this issue, cache the cpumask into a temporary variable before
calling cpumap_print_{list, cpumask}_to_buf(), to keep it unchanged
during the printing process.

Fixes: bb9ec13d156e ("topology: use bin_attribute to break the size limitation of cpumap ABI")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 drivers/base/topology.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b9..70dbd7ef038d 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -27,9 +27,17 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
 			   loff_t off, size_t count)				\
 {										\
 	struct device *dev = kobj_to_dev(kobj);                                 \
+	cpumask_var_t mask;							\
+	ssize_t n;								\
 										\
-	return cpumap_print_bitmask_to_buf(buf, topology_##mask(dev->id),	\
-					   off, count);                         \
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
+		return 0;							\
+										\
+	cpumask_copy(mask, topology_##mask(dev->id));				\
+	n = cpumap_print_bitmask_to_buf(buf, mask, off, count);			\
+	free_cpumask_var(mask);							\
+										\
+	return n;								\
 }										\
 										\
 static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
@@ -37,9 +45,17 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
 				loff_t off, size_t count)			\
 {										\
 	struct device *dev = kobj_to_dev(kobj);					\
+	cpumask_var_t mask;							\
+	ssize_t n;								\
+										\
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
+		return 0;							\
+										\
+	cpumask_copy(mask, topology_##mask(dev->id));				\
+	n = cpumap_print_list_to_buf(buf, mask, off, count);			\
+	free_cpumask_var(mask);							\
 										\
-	return cpumap_print_list_to_buf(buf, topology_##mask(dev->id),		\
-					off, count);				\
+	return n;								\
 }
 
 define_id_show_func(physical_package_id, "%d");
-- 
2.25.1


