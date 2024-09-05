Return-Path: <linux-kernel+bounces-317446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D8F96DE69
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199391F27C70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C7319DF9E;
	Thu,  5 Sep 2024 15:31:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA647F7FC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550303; cv=none; b=fhETlxvTazzrw+bJ9Ez+nn94rpZn1NHirtfvVrSZus5bqjHVCsRfEpy+ZkTB1MJJotzvGqSf5+wQGq5gxqyuGC6JeG1EU2PgmQE4x1NclAW7TpUkdzLTtC3zA68JoOjyH2shJhCCTiL5273/ws1w8a6DzaMEab9uGG7YlqVB7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550303; c=relaxed/simple;
	bh=CyQoR3kWejAH7ZpCGKeZ/T42HR1Hd5lWwkcO+FwmPzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZvAOSs+rCsR44W1XOZm06YW0t1C3vc/cwGkKZ5zThLCaEecbDCq7+ae5/nF+5eyqzoTNiXB+tDsAzb641EpK/O+IeEP6eGojqk+mQjXbOLun0qZMcsHKrpVKITEtfwsXcbZco/PYBJuSnMWucLGLY06xpUcubSRySZy4c4kkb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X03Gq3qvbzyRWB;
	Thu,  5 Sep 2024 23:30:59 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id DDEA818006C;
	Thu,  5 Sep 2024 23:31:38 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 5 Sep
 2024 23:31:38 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH] mm: thp: simplify split_huge_pages_pid()
Date: Thu, 5 Sep 2024 23:30:28 +0800
Message-ID: <20240905153028.1205128-1-sunnanyong@huawei.com>
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
 kwepemm600003.china.huawei.com (7.193.23.202)

The helper find_get_task_by_vpid() can totally replace the task_struct
find logic in split_huge_pages_pid(), so use it to simplify the code.
Also delete the needless comments for the helper function name already
explains what it's doing here.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 mm/huge_memory.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 67c86a5d64a6..c5349c2a8275 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3480,16 +3480,11 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 	vaddr_start &= PAGE_MASK;
 	vaddr_end &= PAGE_MASK;
 
-	/* Find the task_struct from pid */
-	rcu_read_lock();
-	task = find_task_by_vpid(pid);
+	task = find_get_task_by_vpid(pid);
 	if (!task) {
-		rcu_read_unlock();
 		ret = -ESRCH;
 		goto out;
 	}
-	get_task_struct(task);
-	rcu_read_unlock();
 
 	/* Find the mm_struct */
 	mm = get_task_mm(task);
-- 
2.33.0


