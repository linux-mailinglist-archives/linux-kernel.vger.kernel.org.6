Return-Path: <linux-kernel+bounces-252370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EAF93124E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610031F22AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A56B18733F;
	Mon, 15 Jul 2024 10:32:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCB13B5BD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039569; cv=none; b=XFkpI6up79k8eWw64EVYRrnL31L71fWYRPZ8oBziUjxPR1TK1DPpF/Yynma1SvZ8RMSMWnHFahGaXPhN+2QzxGGno/QVkkrKJXMl1skS+sDmED567Pb1wirYKF9H3+vRvWEZCyvfCSjvlLZ5AV6dQVjmr9KSofjXBazFVr6BpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039569; c=relaxed/simple;
	bh=5mCBLfBnGQpZGaBAHNxZ63K14sw7U6cjzlge2sw5lgA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h/BRAzLX1VSf5R8uxeNa2rm/ddaxucp/eWSM2w4RZyGPudV+gqMymlXoRqNIFJqDXw0L3gjJHVJ/3nQTUi7JHlgG1q5FJGajeEFQ22EFEM5rESVFVASWnFsZCa9Knv3DfJKezZE65p6jIIAaJM+DzdPP4Ncg3lafG/pBYSnJudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WMz102pwRzxSsd;
	Mon, 15 Jul 2024 18:27:48 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id A5D2318006C;
	Mon, 15 Jul 2024 18:32:37 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Jul
 2024 18:32:36 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/hwpoison: reset hwpoison filter parameters in pfn_inject_exit()
Date: Mon, 15 Jul 2024 18:28:06 +0800
Message-ID: <20240715102806.2638849-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200019.china.huawei.com (7.221.188.193)

When hwpoison_inject module is removed, hwpoison_filter_* parameters
should be reset. Otherwise these parameters will have non-default values
at next insmod time.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hwpoison-inject.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 7ecaa1900137..b0bd11133a1d 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -64,9 +64,20 @@ static int hwpoison_unpoison(void *data, u64 val)
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
 }
 
-- 
2.33.0


