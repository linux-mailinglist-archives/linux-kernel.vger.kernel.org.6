Return-Path: <linux-kernel+bounces-201882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6E8FC490
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BA81F233F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F6F1922D5;
	Wed,  5 Jun 2024 07:28:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8891922D2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572505; cv=none; b=GDjqBXqGd/1vhz9NjRDZhWgTGQqrbtsaPAVOd8G/h8bE1+YEvJIzClxhIGg6WFYizgIwl1blOTUGjBLFoawxKo0/j86fEBWtKOrCf87hfqvb89j+OL0WLg9h51JB6WFsjhbfn5cCeLLXZTTbBlv1OALgO+9Y0lTZSesRaYVm8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572505; c=relaxed/simple;
	bh=9ntpR1TzKr3JrONGpvZxLgE5SWDnEqFoqOQchJ7+nRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbmBTrjpZDDzLF0z04+9l0isGu7oEPCJ/h2Tyx6NwUDx3cRM1Xlt53rWsyIf5H+Fa2U4s6y2IXD1L7/1qCAb4twe6O6y1rsqkMEosVEsZTjtoZd/h+oE4Y731+SjhXsIMfSMJEYMzkwgoYWdhHCnH34mZ5eyMe8lN1rVRDAkWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VvJQ001tBz355cs;
	Wed,  5 Jun 2024 15:05:28 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 16EC11A016C;
	Wed,  5 Jun 2024 15:09:09 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 15:09:08 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on template
Date: Wed, 5 Jun 2024 07:01:32 +0000
Message-ID: <20240605070133.1941677-3-xiujianfeng@huawei.com>
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

Unlike other cgroup subsystems, the hugetlb cgroup does not provide
a static array of cftype that explicitly displays the properties,
handling functions, etc., of each file. Instead, it dynamically creates
the attribute of cftypes based on the hstate during the startup
procedure. This reduces the readability of the code.

To fix this issue, introduce two templates of cftypes, and rebuild the
attributes according to the hstate to make it ready to be added to
cgroup framework.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/hugetlb_cgroup.c | 155 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 45f94a869776..56876b61027d 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -27,7 +27,16 @@
 #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
 
+#define MEMFILE_OFFSET(t, m)	(((offsetof(t, m) << 16) | sizeof_field(t, m)))
+#define MEMFILE_OFFSET0(val)	(((val) >> 16) & 0xffff)
+#define MEMFILE_FIELD_SIZE(val)	((val) & 0xffff)
+
+#define DFL_TMPL_SIZE		ARRAY_SIZE(hugetlb_dfl_tmpl)
+#define LEGACY_TMPL_SIZE	ARRAY_SIZE(hugetlb_legacy_tmpl)
+
 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
+static struct cftype *dfl_files;
+static struct cftype *legacy_files;
 
 static inline struct page_counter *
 __hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
@@ -702,12 +711,142 @@ static int hugetlb_events_local_show(struct seq_file *seq, void *v)
 	return __hugetlb_events_show(seq, true);
 }
 
+static struct cftype hugetlb_dfl_tmpl[] = {
+	{
+		.name = "max",
+		.private = RES_LIMIT,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.write = hugetlb_cgroup_write_dfl,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "rsvd.max",
+		.private = RES_RSVD_LIMIT,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.write = hugetlb_cgroup_write_dfl,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "current",
+		.private = RES_USAGE,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "rsvd.current",
+		.private = RES_RSVD_USAGE,
+		.seq_show = hugetlb_cgroup_read_u64_max,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "events",
+		.seq_show = hugetlb_events_show,
+		.file_offset = MEMFILE_OFFSET(struct hugetlb_cgroup, events_file[0]),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "events.local",
+		.seq_show = hugetlb_events_local_show,
+		.file_offset = MEMFILE_OFFSET(struct hugetlb_cgroup, events_local_file[0]),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "numa_stat",
+		.seq_show = hugetlb_cgroup_read_numa_stat,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	/* don't need terminator here */
+};
+
+static struct cftype hugetlb_legacy_tmpl[] = {
+	{
+		.name = "limit_in_bytes",
+		.private = RES_LIMIT,
+		.read_u64 = hugetlb_cgroup_read_u64,
+		.write = hugetlb_cgroup_write_legacy,
+	},
+	{
+		.name = "rsvd.limit_in_bytes",
+		.private = RES_RSVD_LIMIT,
+		.read_u64 = hugetlb_cgroup_read_u64,
+		.write = hugetlb_cgroup_write_legacy,
+	},
+	{
+		.name = "usage_in_bytes",
+		.private = RES_USAGE,
+		.read_u64 = hugetlb_cgroup_read_u64,
+	},
+	{
+		.name = "rsvd.usage_in_bytes",
+		.private = RES_RSVD_USAGE,
+		.read_u64 = hugetlb_cgroup_read_u64,
+	},
+	{
+		.name = "max_usage_in_bytes",
+		.private = RES_MAX_USAGE,
+		.write = hugetlb_cgroup_reset,
+		.read_u64 = hugetlb_cgroup_read_u64,
+	},
+	{
+		.name = "rsvd.max_usage_in_bytes",
+		.private = RES_RSVD_MAX_USAGE,
+		.write = hugetlb_cgroup_reset,
+		.read_u64 = hugetlb_cgroup_read_u64,
+	},
+	{
+		.name = "failcnt",
+		.private = RES_FAILCNT,
+		.write = hugetlb_cgroup_reset,
+		.read_u64 = hugetlb_cgroup_read_u64,
+	},
+	{
+		.name = "rsvd.failcnt",
+		.private = RES_RSVD_FAILCNT,
+		.write = hugetlb_cgroup_reset,
+		.read_u64 = hugetlb_cgroup_read_u64,
+	},
+	{
+		.name = "numa_stat",
+		.seq_show = hugetlb_cgroup_read_numa_stat,
+	},
+	/* don't need terminator here */
+};
+
+static void __init
+hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
+			     struct cftype *tmpl, int tmpl_size)
+{
+	char buf[32];
+	int i, idx = hstate_index(h);
+
+	/* format the size */
+	mem_fmt(buf, sizeof(buf), huge_page_size(h));
+
+	for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
+		*cft = *tmpl;
+		/* rebuild the name */
+		snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
+		/* rebuild the private */
+		if (tmpl->private)
+			cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
+		/* rebuild the file_offset */
+		if (tmpl->file_offset) {
+			unsigned int offset = tmpl->file_offset;
+			cft->file_offset = MEMFILE_OFFSET0(offset) +
+					   MEMFILE_FIELD_SIZE(offset) * idx;
+		}
+	}
+}
+
 static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 {
 	char buf[32];
 	struct cftype *cft;
 	struct hstate *h = &hstates[idx];
 
+	hugetlb_cgroup_cfttypes_init(h, dfl_files + idx * DFL_TMPL_SIZE,
+				     hugetlb_dfl_tmpl, DFL_TMPL_SIZE);
+
 	/* format the size */
 	mem_fmt(buf, sizeof(buf), huge_page_size(h));
 
@@ -779,6 +918,9 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
 	struct cftype *cft;
 	struct hstate *h = &hstates[idx];
 
+	hugetlb_cgroup_cfttypes_init(h, legacy_files + idx * LEGACY_TMPL_SIZE,
+				     hugetlb_legacy_tmpl, LEGACY_TMPL_SIZE);
+
 	/* format the size */
 	mem_fmt(buf, sizeof(buf), huge_page_size(h));
 
@@ -856,10 +998,23 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	__hugetlb_cgroup_file_legacy_init(idx);
 }
 
+static void __init __hugetlb_cgroup_file_pre_init(void)
+{
+	int cft_count;
+
+	cft_count = hugetlb_max_hstate * DFL_TMPL_SIZE + 1; /* add terminator */
+	dfl_files = kcalloc(cft_count, sizeof(struct cftype), GFP_KERNEL);
+	BUG_ON(!dfl_files);
+	cft_count = hugetlb_max_hstate * LEGACY_TMPL_SIZE + 1; /* add terminator */
+	legacy_files = kcalloc(cft_count, sizeof(struct cftype), GFP_KERNEL);
+	BUG_ON(!legacy_files);
+}
+
 void __init hugetlb_cgroup_file_init(void)
 {
 	struct hstate *h;
 
+	__hugetlb_cgroup_file_pre_init();
 	for_each_hstate(h)
 		__hugetlb_cgroup_file_init(hstate_index(h));
 }
-- 
2.34.1


