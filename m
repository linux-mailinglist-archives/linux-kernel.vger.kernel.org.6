Return-Path: <linux-kernel+bounces-414373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C29D271F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED502282780
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6E31CCECD;
	Tue, 19 Nov 2024 13:38:26 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47254673
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023506; cv=none; b=HR9o0oTmO7HxD+LukbW/cCrTYYx9dA6zl6IXQyr1yDT8Rc7bZvDN4JkVfA3SzH8PN/6oMeJAriQNY6gcTMN18WwTkSZCr2JSJgeypMRY3flXi2XkPE9rlxmrWlWwpU684ewfL7aPSgUvbk2BP1NXffuFF2VrNPwnEZhg5byECQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023506; c=relaxed/simple;
	bh=xrvTIgBxANM8GpRtftt955m9io5k9G98Ceq1ygmadG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svQY5KhTCsaoPOHwQsktA0lFjR18jHsEejatFeAijyZARqfqpBS0gOePQWlMw6Z8HaYZ73wxgQLGwzZA7THu9da7e9/MZ3rXDwuuJ8uy44oYPyg69aNXZov8MYezJQp4XDbuVv0WmaQMWASjpWIB3rAV03pYhYbyBsp/tzI4+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xt59z4z6VzqSP1;
	Tue, 19 Nov 2024 21:36:23 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 3040818010F;
	Tue, 19 Nov 2024 21:38:15 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Nov
 2024 21:38:14 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
	<xiexiuqi@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v2 2/6] arm_mpam: Create reqPARTIDs resource bitmap
Date: Tue, 19 Nov 2024 21:51:00 +0800
Message-ID: <20241119135104.595630-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241119135104.595630-1-zengheng4@huawei.com>
References: <20241119135104.595630-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The driver checks whether mpam_partid_max and mpam_intpartid_max are equal
as a basis for supporting reqPARTID. If this feature is supported, use a
bitmap to represent whether the target reqPARTID is available or not.
Create the bitmap during monitor initialization, and the destructor is
called during the monitor exit process.

It is noted that the reqpartid_free_map reserves the first reqPARTID under
each intPARTID (which is equal to the corresponding intPARTID itself). By
default, assigns it to the corresponding control group for use in
monitoring.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index ac3d228befcf..dfd4125875d7 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -1005,6 +1005,33 @@ static void mpam_resctrl_monitor_init(struct mpam_class *class,
 	return;
 }
 
+static unsigned long *reqpartid_free_map;
+static int reqpartid_free_map_len;
+
+static int reqpartid_create(void)
+{
+	u32 reqpartid_num = get_num_reqpartid();
+	int i;
+
+	reqpartid_free_map = bitmap_alloc(reqpartid_num, GFP_KERNEL);
+	if (!reqpartid_free_map)
+		return -ENOMEM;
+
+	bitmap_fill(reqpartid_free_map, reqpartid_num);
+
+	/* Reserved for the internal partIDs mapping */
+	for (i = 0; i < resctrl_arch_get_num_closid(NULL); i++)
+		__clear_bit(i, reqpartid_free_map);
+
+	reqpartid_free_map_len = reqpartid_num;
+	return 0;
+}
+
+static void reqpartid_destroy(void)
+{
+	bitmap_free(reqpartid_free_map);
+}
+
 int mpam_resctrl_setup(void)
 {
 	int err = 0;
@@ -1052,6 +1079,10 @@ int mpam_resctrl_setup(void)
 
 	cpus_read_unlock();
 
+	err = reqpartid_create();
+	if (err)
+		return err;
+
 	if (!err && !exposed_alloc_capable && !exposed_mon_capable)
 		err = -EOPNOTSUPP;
 
@@ -1080,6 +1111,8 @@ static void mpam_resctrl_exit(void)
 
 	WRITE_ONCE(resctrl_enabled, false);
 	resctrl_exit();
+
+	reqpartid_destroy();
 }
 
 
-- 
2.25.1


