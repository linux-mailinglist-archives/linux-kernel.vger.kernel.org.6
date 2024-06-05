Return-Path: <linux-kernel+bounces-201842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1038FC426
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F7D1F228E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119A18F2CB;
	Wed,  5 Jun 2024 07:09:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D6DDA5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571355; cv=none; b=jPm3yrIQjVZYzpGHQ4H2/U2FnP0EFFrJ2uBl6RDPZ/qGEdeiQN09QRDc7gPF/KrI+yWsjPRuF+wBMgPfdcrbSepuXXmRalU3k7Fp+Xk/2dRKe9xzPd7ssmsICvNt3gxMnBA2SSaOnX+rX8LnPv0UAhLKpUMdx2xdmtlVyBEE8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571355; c=relaxed/simple;
	bh=1wC3bTaI5k8JrT/7KDpwhG0t/5YJ9xbzZeK9/qFQdXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLH6p4X4BMo57zTJJyMY2NlO8q0ogUgr3nJZtSsHeCWOuR2TAdyk+nx6oBZt/V9h35cS75qBu2Aw91UstXpHXsfjuZA47ysxOKWJONnoUYM2B4eEY0gkZOGBwxo+OqQUunFFX6cio1DkT1lU2DFShAJTOXLSDMgLOf1PUzRrI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VvJSd4qyjzcl5F;
	Wed,  5 Jun 2024 15:07:45 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id B4EFD14022E;
	Wed,  5 Jun 2024 15:09:09 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:09:09 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next 3/3] mm/hugetlb_cgroup: switch to the new cftypes
Date: Wed, 5 Jun 2024 07:01:33 +0000
Message-ID: <20240605070133.1941677-4-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605070133.1941677-1-xiujianfeng@huawei.com>
References: <20240605070133.1941677-1-xiujianfeng@huawei.com>
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

The previous patch has already reconstructed the cftype attributes
based on the templates and saved them in dfl_cftypes and legacy_cftypes.
then remove the old procedure and switch to the new cftypes.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/hugetlb.h |   5 --
 mm/hugetlb_cgroup.c     | 163 +++++-----------------------------------
 2 files changed, 17 insertions(+), 151 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 279aca379b95..a951c0d06061 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -686,11 +686,6 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
-#ifdef CONFIG_CGROUP_HUGETLB
-	/* cgroup control files */
-	struct cftype cgroup_files_dfl[8];
-	struct cftype cgroup_files_legacy[10];
-#endif
 	char name[HSTATE_NAME_LEN];
 };
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 56876b61027d..11806736ab62 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -838,164 +838,26 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
 	}
 }
 
-static void __init __hugetlb_cgroup_file_dfl_init(int idx)
+static void __init __hugetlb_cgroup_file_dfl_init(struct hstate *h)
 {
-	char buf[32];
-	struct cftype *cft;
-	struct hstate *h = &hstates[idx];
+	int idx = hstate_index(h);
 
 	hugetlb_cgroup_cfttypes_init(h, dfl_files + idx * DFL_TMPL_SIZE,
 				     hugetlb_dfl_tmpl, DFL_TMPL_SIZE);
-
-	/* format the size */
-	mem_fmt(buf, sizeof(buf), huge_page_size(h));
-
-	/* Add the limit file */
-	cft = &h->cgroup_files_dfl[0];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
-	cft->seq_show = hugetlb_cgroup_read_u64_max;
-	cft->write = hugetlb_cgroup_write_dfl;
-	cft->flags = CFTYPE_NOT_ON_ROOT;
-
-	/* Add the reservation limit file */
-	cft = &h->cgroup_files_dfl[1];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
-	cft->seq_show = hugetlb_cgroup_read_u64_max;
-	cft->write = hugetlb_cgroup_write_dfl;
-	cft->flags = CFTYPE_NOT_ON_ROOT;
-
-	/* Add the current usage file */
-	cft = &h->cgroup_files_dfl[2];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
-	cft->seq_show = hugetlb_cgroup_read_u64_max;
-	cft->flags = CFTYPE_NOT_ON_ROOT;
-
-	/* Add the current reservation usage file */
-	cft = &h->cgroup_files_dfl[3];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.current", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
-	cft->seq_show = hugetlb_cgroup_read_u64_max;
-	cft->flags = CFTYPE_NOT_ON_ROOT;
-
-	/* Add the events file */
-	cft = &h->cgroup_files_dfl[4];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
-	cft->private = MEMFILE_PRIVATE(idx, 0);
-	cft->seq_show = hugetlb_events_show;
-	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
-	cft->flags = CFTYPE_NOT_ON_ROOT;
-
-	/* Add the events.local file */
-	cft = &h->cgroup_files_dfl[5];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
-	cft->private = MEMFILE_PRIVATE(idx, 0);
-	cft->seq_show = hugetlb_events_local_show;
-	cft->file_offset = offsetof(struct hugetlb_cgroup,
-				    events_local_file[idx]);
-	cft->flags = CFTYPE_NOT_ON_ROOT;
-
-	/* Add the numa stat file */
-	cft = &h->cgroup_files_dfl[6];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
-	cft->private = MEMFILE_PRIVATE(idx, 0);
-	cft->seq_show = hugetlb_cgroup_read_numa_stat;
-	cft->flags = CFTYPE_NOT_ON_ROOT;
-
-	/* NULL terminate the last cft */
-	cft = &h->cgroup_files_dfl[7];
-	memset(cft, 0, sizeof(*cft));
-
-	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
-				       h->cgroup_files_dfl));
 }
 
-static void __init __hugetlb_cgroup_file_legacy_init(int idx)
+static void __init __hugetlb_cgroup_file_legacy_init(struct hstate *h)
 {
-	char buf[32];
-	struct cftype *cft;
-	struct hstate *h = &hstates[idx];
+	int idx = hstate_index(h);
 
 	hugetlb_cgroup_cfttypes_init(h, legacy_files + idx * LEGACY_TMPL_SIZE,
 				     hugetlb_legacy_tmpl, LEGACY_TMPL_SIZE);
-
-	/* format the size */
-	mem_fmt(buf, sizeof(buf), huge_page_size(h));
-
-	/* Add the limit file */
-	cft = &h->cgroup_files_legacy[0];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.limit_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-	cft->write = hugetlb_cgroup_write_legacy;
-
-	/* Add the reservation limit file */
-	cft = &h->cgroup_files_legacy[1];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.limit_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-	cft->write = hugetlb_cgroup_write_legacy;
-
-	/* Add the usage file */
-	cft = &h->cgroup_files_legacy[2];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-
-	/* Add the reservation usage file */
-	cft = &h->cgroup_files_legacy[3];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.usage_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-
-	/* Add the MAX usage file */
-	cft = &h->cgroup_files_legacy[4];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
-	cft->write = hugetlb_cgroup_reset;
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-
-	/* Add the MAX reservation usage file */
-	cft = &h->cgroup_files_legacy[5];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max_usage_in_bytes", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_MAX_USAGE);
-	cft->write = hugetlb_cgroup_reset;
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-
-	/* Add the failcntfile */
-	cft = &h->cgroup_files_legacy[6];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_FAILCNT);
-	cft->write = hugetlb_cgroup_reset;
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-
-	/* Add the reservation failcntfile */
-	cft = &h->cgroup_files_legacy[7];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.failcnt", buf);
-	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_FAILCNT);
-	cft->write = hugetlb_cgroup_reset;
-	cft->read_u64 = hugetlb_cgroup_read_u64;
-
-	/* Add the numa stat file */
-	cft = &h->cgroup_files_legacy[8];
-	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
-	cft->private = MEMFILE_PRIVATE(idx, 0);
-	cft->seq_show = hugetlb_cgroup_read_numa_stat;
-
-	/* NULL terminate the last cft */
-	cft = &h->cgroup_files_legacy[9];
-	memset(cft, 0, sizeof(*cft));
-
-	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
-					  h->cgroup_files_legacy));
 }
 
-static void __init __hugetlb_cgroup_file_init(int idx)
+static void __init __hugetlb_cgroup_file_init(struct hstate *h)
 {
-	__hugetlb_cgroup_file_dfl_init(idx);
-	__hugetlb_cgroup_file_legacy_init(idx);
+	__hugetlb_cgroup_file_dfl_init(h);
+	__hugetlb_cgroup_file_legacy_init(h);
 }
 
 static void __init __hugetlb_cgroup_file_pre_init(void)
@@ -1010,13 +872,22 @@ static void __init __hugetlb_cgroup_file_pre_init(void)
 	BUG_ON(!legacy_files);
 }
 
+static void __init __hugetlb_cgroup_file_post_init(void)
+{
+	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
+				       dfl_files));
+	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
+					  legacy_files));
+}
+
 void __init hugetlb_cgroup_file_init(void)
 {
 	struct hstate *h;
 
 	__hugetlb_cgroup_file_pre_init();
 	for_each_hstate(h)
-		__hugetlb_cgroup_file_init(hstate_index(h));
+		__hugetlb_cgroup_file_init(h);
+	__hugetlb_cgroup_file_post_init();
 }
 
 /*
-- 
2.34.1


