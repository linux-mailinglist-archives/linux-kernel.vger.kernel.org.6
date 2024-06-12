Return-Path: <linux-kernel+bounces-211272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB5904F58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7EB1F2956F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE516DEDB;
	Wed, 12 Jun 2024 09:32:00 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49E16DEB2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184720; cv=none; b=LTE5JCVgYiZ2QiEdpbK9Z0oPM+GzI25x2lB4FNnkn7ivI1ZokuKE6BXqa2Tcw8q8vBXokW6JhEG7HSdARnFasoD1dUmN6HmANhQmKKCA1MXkIJtT2minuPkhaP33vEuY5VxdOL3P7YyeBhHT4iVs2Ep7Y7RerzT0W6OqaTzaZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184720; c=relaxed/simple;
	bh=ZAPxRrFmaBDIhGEUxMT6pFYhM/l0wMgDXgx/LRaDH2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jV2wj9Rh6LXJCNXZXFEBeWqBJ1JZ5ftqYbMXkaixycLYPNJFIzumARx30kd1Cb7uewIOYjyH76RuPzvDN6yJ99EIn4JkbuN1QptaEtWw32iT6txyldkyyjEa8UmqanABZbnjIcx+FIQlwKBlzwXxrH9Ek1cXYHsNqufqK7/ufww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VzgF13h0Hz1JCj6;
	Wed, 12 Jun 2024 17:27:49 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 217F318007C;
	Wed, 12 Jun 2024 17:31:55 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 17:31:54 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <osalvador@suse.de>
Subject: [PATCH v3 -next 1/3] mm/hugetlb_cgroup: identify the legacy using cgroup_subsys_on_dfl()
Date: Wed, 12 Jun 2024 09:24:07 +0000
Message-ID: <20240612092409.2027592-2-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612092409.2027592-1-xiujianfeng@huawei.com>
References: <20240612092409.2027592-1-xiujianfeng@huawei.com>
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
in the static templates in the next patch.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
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


