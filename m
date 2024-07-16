Return-Path: <linux-kernel+bounces-253308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066C931F63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5B283ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C513FF9;
	Tue, 16 Jul 2024 03:39:56 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8926FBE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101196; cv=none; b=WVUNJ1vnDrbM7KZ38M1zlc/zcAlpgKzgYG7w0uRYU3tt9bx4UXZSLYbCzhFLTEuIGjwU8DHIgpYX2xKOOQdykdatS5tD30h6O0VxsiITLtEuhO0y35jpzf0mAclX3NUh/mNxZMW6uSzUO5Bkc/gmvzt519Ka2KJlPvIQNV4nIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101196; c=relaxed/simple;
	bh=AECL3245aH9LasPOKsBDeo/aDvM87K8dxPjag1rojiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6x1sNRW93zFaZgvWzGMSfV+FAjN5joVf3hClfiMWYF188FumyXqCNNq3trr0RK0iWnEm4TPCvtrlxah9lSX9Q3MhwlSt5GSgCbZM6PFOI6Tp+LbRQCORGdQkuxnoT8u2xYEmD6nhyYeJuZAzW/a1Mlv0fw7q/2fbfA7o6Mu7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WNPrt2XRKz1HFJr;
	Tue, 16 Jul 2024 11:37:18 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 63F7314011B;
	Tue, 16 Jul 2024 11:39:50 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Jul
 2024 11:39:49 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mm/hwpoison: reset hwpoison filter parameters in pfn_inject_exit()
Date: Tue, 16 Jul 2024 11:35:16 +0800
Message-ID: <20240716033516.606582-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

When hwpoison_inject module is removed, hwpoison_filter_* parameters
should be reset. Otherwise these parameters will have non-default values
at next insmod time.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v2:
 Add missing call to reset_hwpoison_filter() per Andrew. Thanks.
---
 mm/hwpoison-inject.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 7ecaa1900137..0b855cd3433a 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -64,10 +64,22 @@ static int hwpoison_unpoison(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
 DEFINE_DEBUGFS_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
 
-static void __exit pfn_inject_exit(void)
+static inline void reset_hwpoison_filter(void)
 {
 	hwpoison_filter_enable = 0;
+	hwpoison_filter_dev_major = ~0U;
+	hwpoison_filter_dev_minor = ~0U;
+	hwpoison_filter_flags_mask = 0;
+	hwpoison_filter_flags_value = 0;
+#ifdef CONFIG_MEMCG
+	hwpoison_filter_memcg = 0;
+#endif
+}
+
+static void __exit pfn_inject_exit(void)
+{
 	debugfs_remove_recursive(hwpoison_dir);
+	reset_hwpoison_filter();
 }
 
 static int __init pfn_inject_init(void)
-- 
2.33.0


