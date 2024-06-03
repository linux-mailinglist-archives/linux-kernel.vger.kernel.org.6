Return-Path: <linux-kernel+bounces-199089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF058D81FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D528520F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B68665A;
	Mon,  3 Jun 2024 12:12:50 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5D128820
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416770; cv=none; b=Srwxyj5j9t2AXrUmY95L/mamj6Vgie50EONuvSOaYifXL0eZhVyF+HGirqTr0bTDMK/OS2WnGVNRPUsf8MC1z9owxPH6waYD/lHVaZWfq6QnJ2s/OHYC2Xx+Hj7n5UOM+JrUuHHflts+0gzTtaCpy9XC71YfPg4gBQR05EVd30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416770; c=relaxed/simple;
	bh=OAIaQ6JZgKz5GOYpBFjTY8RlwKi7yq66Tt48HkB10iM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vF4OIFVyUIC/+sy5C+Gspcg4wzkxx1FvpSEGJj8pe/nqtG8MuL0DmYR8uA3SiSbjD8Xg9dWuQZWn6gWnckLlVFu3P/nhs4U3yctn/L3zM2Tg3lPgieItKebplM0gZ9OYkrYAYFaZynYYs8FsjDORF4uJycpydC8rRwK/9yMn/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VtCDz2xwGz1S91k;
	Mon,  3 Jun 2024 20:08:51 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 55926140109;
	Mon,  3 Jun 2024 20:12:45 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:12:45 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/3] mm/hugetlb_cgroup: identify the legacy using cgroup_subsys_on_dfl()
Date: Mon, 3 Jun 2024 12:05:04 +0000
Message-ID: <20240603120506.1837322-2-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603120506.1837322-1-xiujianfeng@huawei.com>
References: <20240603120506.1837322-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Currently the numa_stat file encodes 1 into .private using the micro
MEMFILE_PRIVATE() to identify the legacy. Actually, we can use
cgroup_subsys_on_dfl() instead. This is helpful to handle .private
in the static array in the next patch.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/hugetlb_cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index e20339a346b9..45f94a869776 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -460,7 +460,7 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
 	int nid;
 	struct cftype *cft = seq_cft(seq);
 	int idx = MEMFILE_IDX(cft->private);
-	bool legacy = MEMFILE_ATTR(cft->private);
+	bool legacy = !cgroup_subsys_on_dfl(hugetlb_cgrp_subsys);
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
 	struct cgroup_subsys_state *css;
 	unsigned long usage;
@@ -839,7 +839,7 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
 	/* Add the numa stat file */
 	cft = &h->cgroup_files_legacy[8];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
-	cft->private = MEMFILE_PRIVATE(idx, 1);
+	cft->private = MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show = hugetlb_cgroup_read_numa_stat;
 
 	/* NULL terminate the last cft */
-- 
2.34.1


