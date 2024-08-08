Return-Path: <linux-kernel+bounces-279349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33E94BC1E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BB82835F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66E18C926;
	Thu,  8 Aug 2024 11:19:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD218C337
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115943; cv=none; b=bXfKSCt6UxZthwd5jdE3v0sCKqe/dC//PfdtnN79RHnneoI7ht56w7MaktJq5Y3JNSAMS4QKMjpbLv8ZAiaKZehkusZgip1FfilT+MuEHoFgCo9ZEKHuk2Lo7tit0AHxlUAQ6fGoJKqqm5EN8CcwUWBWpITrBYq+tGujUA+qSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115943; c=relaxed/simple;
	bh=XVvQeBUz27N0FgchdGrG0itzCFqwQD8rnk79VCeiyps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rROlc4R9lCr/yjJ+LaTO6x5AibaDB0hoik2sPZmPD0VZ3gJ1hNrzaZsiYegehV9WzbTdexcBs53WKsJ+uoJ48H5hrV5dSlGUyElxYSSp63xMz7Cr37fWS0ngPy8HvU77moiZxPbeAJZBEzxNW93xWp2AC6Qw7I0ImyarvIIz0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97797139F;
	Thu,  8 Aug 2024 04:19:26 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EACD3F71E;
	Thu,  8 Aug 2024 04:18:59 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/2] mm: Tidy up shmem mTHP controls and stats
Date: Thu,  8 Aug 2024 12:18:47 +0100
Message-ID: <20240808111849.651867-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808111849.651867-1-ryan.roberts@arm.com>
References: <20240808111849.651867-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously we had a situation where shmem mTHP controls and stats were
not exposed for some supported sizes and were exposed for some
unsupported sizes. So let's clean that up.

Anon mTHP can support all large orders [2, PMD_ORDER]. But shmem can
support all large orders [1, MAX_PAGECACHE_ORDER]. However, per-size
shmem controls and stats were previously being exposed for all the anon
mTHP orders, meaning order-1 was not present, and for arm64 64K base
pages, orders 12 and 13 were exposed but were not supported internally.

Tidy this all up by defining ctrl and stats attribute groups for anon
and file separately. Anon ctrl and stats groups are populated for all
orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.

Additionally, create "any" ctrl and stats attribute groups which are
populated for all orders in (THP_ORDERS_ALL_ANON |
THP_ORDERS_ALL_FILE_DEFAULT). swpout stats use this since they apply to
anon and shmem.

The side-effect of all this is that different hugepage-*kB directories
contain different sets of controls and stats, depending on which memory
types support that size. This approach is preferred over the
alternative, which is to populate dummy controls and stats for memory
types that do not support a given size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/huge_memory.c | 144 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 30 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0c3075ee00012..082d86b7c6c2f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -482,8 +482,8 @@ static void thpsize_release(struct kobject *kobj);
 static DEFINE_SPINLOCK(huge_anon_orders_lock);
 static LIST_HEAD(thpsize_list);
 
-static ssize_t thpsize_enabled_show(struct kobject *kobj,
-				    struct kobj_attribute *attr, char *buf)
+static ssize_t anon_enabled_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
 {
 	int order = to_thpsize(kobj)->order;
 	const char *output;
@@ -500,9 +500,9 @@ static ssize_t thpsize_enabled_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%s\n", output);
 }
 
-static ssize_t thpsize_enabled_store(struct kobject *kobj,
-				     struct kobj_attribute *attr,
-				     const char *buf, size_t count)
+static ssize_t anon_enabled_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t count)
 {
 	int order = to_thpsize(kobj)->order;
 	ssize_t ret = count;
@@ -544,19 +544,35 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
 	return ret;
 }
 
-static struct kobj_attribute thpsize_enabled_attr =
-	__ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store);
+static struct kobj_attribute anon_enabled_attr =
+	__ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
 
-static struct attribute *thpsize_attrs[] = {
-	&thpsize_enabled_attr.attr,
+static struct attribute *anon_ctrl_attrs[] = {
+	&anon_enabled_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group anon_ctrl_attr_grp = {
+	.attrs = anon_ctrl_attrs,
+};
+
+static struct attribute *file_ctrl_attrs[] = {
 #ifdef CONFIG_SHMEM
 	&thpsize_shmem_enabled_attr.attr,
 #endif
 	NULL,
 };
 
-static const struct attribute_group thpsize_attr_group = {
-	.attrs = thpsize_attrs,
+static const struct attribute_group file_ctrl_attr_grp = {
+	.attrs = file_ctrl_attrs,
+};
+
+static struct attribute *any_ctrl_attrs[] = {
+	NULL,
+};
+
+static const struct attribute_group any_ctrl_attr_grp = {
+	.attrs = any_ctrl_attrs,
 };
 
 static const struct kobj_type thpsize_ktype = {
@@ -595,64 +611,132 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
+#ifdef CONFIG_SHMEM
 DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
 DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
+#endif
 DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 
-static struct attribute *stats_attrs[] = {
+static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
+#ifndef CONFIG_SHMEM
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
-	&shmem_alloc_attr.attr,
-	&shmem_fallback_attr.attr,
-	&shmem_fallback_charge_attr.attr,
+#endif
 	&split_attr.attr,
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
 	NULL,
 };
 
-static struct attribute_group stats_attr_group = {
+static struct attribute_group anon_stats_attr_grp = {
+	.name = "stats",
+	.attrs = anon_stats_attrs,
+};
+
+static struct attribute *file_stats_attrs[] = {
+#ifdef CONFIG_SHMEM
+	&shmem_alloc_attr.attr,
+	&shmem_fallback_attr.attr,
+	&shmem_fallback_charge_attr.attr,
+#endif
+	NULL,
+};
+
+static struct attribute_group file_stats_attr_grp = {
+	.name = "stats",
+	.attrs = file_stats_attrs,
+};
+
+static struct attribute *any_stats_attrs[] = {
+#ifdef CONFIG_SHMEM
+	&swpout_attr.attr,
+	&swpout_fallback_attr.attr,
+#endif
+	NULL,
+};
+
+static struct attribute_group any_stats_attr_grp = {
 	.name = "stats",
-	.attrs = stats_attrs,
+	.attrs = any_stats_attrs,
 };
 
+static int sysfs_add_group(struct kobject *kobj,
+			   const struct attribute_group *grp)
+{
+	int ret = -ENOENT;
+
+	/*
+	 * If the group is named, try to merge first, assuming the subdirectory
+	 * was already created. This avoids the warning emitted by
+	 * sysfs_create_group() if the directory already exists.
+	 */
+	if (grp->name)
+		ret = sysfs_merge_group(kobj, grp);
+	if (ret)
+		ret = sysfs_create_group(kobj, grp);
+
+	return ret;
+}
+
 static struct thpsize *thpsize_create(int order, struct kobject *parent)
 {
 	unsigned long size = (PAGE_SIZE << order) / SZ_1K;
 	struct thpsize *thpsize;
-	int ret;
+	int ret = -ENOMEM;
 
 	thpsize = kzalloc(sizeof(*thpsize), GFP_KERNEL);
 	if (!thpsize)
-		return ERR_PTR(-ENOMEM);
+		goto err;
+
+	thpsize->order = order;
 
 	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
 				   "hugepages-%lukB", size);
 	if (ret) {
 		kfree(thpsize);
-		return ERR_PTR(ret);
+		goto err;
 	}
 
-	ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
-	if (ret) {
-		kobject_put(&thpsize->kobj);
-		return ERR_PTR(ret);
+
+	ret = sysfs_add_group(&thpsize->kobj, &any_ctrl_attr_grp);
+	if (ret)
+		goto err_put;
+
+	ret = sysfs_add_group(&thpsize->kobj, &any_stats_attr_grp);
+	if (ret)
+		goto err_put;
+
+	if (BIT(order) & THP_ORDERS_ALL_ANON) {
+		ret = sysfs_add_group(&thpsize->kobj, &anon_ctrl_attr_grp);
+		if (ret)
+			goto err_put;
+
+		ret = sysfs_add_group(&thpsize->kobj, &anon_stats_attr_grp);
+		if (ret)
+			goto err_put;
 	}
 
-	ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
-	if (ret) {
-		kobject_put(&thpsize->kobj);
-		return ERR_PTR(ret);
+	if (BIT(order) & THP_ORDERS_ALL_FILE_DEFAULT) {
+		ret = sysfs_add_group(&thpsize->kobj, &file_ctrl_attr_grp);
+		if (ret)
+			goto err_put;
+
+		ret = sysfs_add_group(&thpsize->kobj, &file_stats_attr_grp);
+		if (ret)
+			goto err_put;
 	}
 
-	thpsize->order = order;
 	return thpsize;
+err_put:
+	kobject_put(&thpsize->kobj);
+err:
+	return ERR_PTR(ret);
 }
 
 static void thpsize_release(struct kobject *kobj)
@@ -692,7 +776,7 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 		goto remove_hp_group;
 	}
 
-	orders = THP_ORDERS_ALL_ANON;
+	orders = THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DEFAULT;
 	order = highest_order(orders);
 	while (orders) {
 		thpsize = thpsize_create(order, *hugepage_kobj);
-- 
2.43.0


