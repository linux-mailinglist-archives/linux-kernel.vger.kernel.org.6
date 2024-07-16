Return-Path: <linux-kernel+bounces-253854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5619327E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828FE2821D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040219B5AF;
	Tue, 16 Jul 2024 13:59:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FED19B3FF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138361; cv=none; b=P89ZM7SYrPoILAcQijCdF6NxJfUSXHsK7mGeiPBM0irvtNFUC2VqI/tPUX/dYzZK94S0PVeLUnt1eNG1l6nSnlcihykiRxaMQVhZQGwSrj1vJyPCEoLE8alpxDpMjl7OjiPAafmBbhdxL1se8P/3RbvrltOiEeSfzskjxBJcKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138361; c=relaxed/simple;
	bh=s/Yi/2bhcdoSH95wnhhoWS18pSn9Bg5vCLqOBPZfl6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSBxMGO0fep7QtAdhnH6f/3NRb2ZsoRCqkjHJYD38kqgdY3YT+OrTBHGErK3uNoAdsvqpH0o5QX5Wp00II0yX8p2iDY+yqAzhWboxpq9ATdUjJReENoWn9yaBoWkPSouRuVRPI8VTg0tDfRLv5Auk4uzCrKvIEgZs1MlRq87RGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76C89113E;
	Tue, 16 Jul 2024 06:59:44 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADBC33F762;
	Tue, 16 Jul 2024 06:59:17 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/3] mm: Tidy up shmem mTHP controls and stats
Date: Tue, 16 Jul 2024 14:59:05 +0100
Message-ID: <20240716135907.4047689-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716135907.4047689-1-ryan.roberts@arm.com>
References: <20240716135907.4047689-1-ryan.roberts@arm.com>
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

Anon mTHP can support all large orders (2, PMD_ORDER). But shmem can
support all large orders (1, MAX_PAGECACHE_ORDER). However, per-size
shmem controls and stats were previously being exposed for all the anon
mTHP orders, meaning order-1 was not present, and for arm64 64K base
pages, orders 12 and 13 were exposed but were not supported internally.

Tidy this all up by defining ctrl and stats attribute groups for anon
and file separately. Anon ctrl and stats groups are populated for all
orders in THP_ORDERS_ALL_ANON and file ctrl and stats groups are
populated for all orders in THP_ORDERS_ALL_FILE_DEFAULT.

The side-effect of all this is that different hugepage-*kB directories
contain different sets of controls and stats, depending on which memory
types support that size. This approach is preferred over the
alternative, which is to populate dummy controls and stats for memory
types that do not support a given size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/huge_memory.c | 110 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 80 insertions(+), 30 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..578ac212c172 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -463,8 +463,8 @@ static void thpsize_release(struct kobject *kobj);
 static DEFINE_SPINLOCK(huge_anon_orders_lock);
 static LIST_HEAD(thpsize_list);
 
-static ssize_t thpsize_enabled_show(struct kobject *kobj,
-				    struct kobj_attribute *attr, char *buf)
+static ssize_t anon_enabled_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
 {
 	int order = to_thpsize(kobj)->order;
 	const char *output;
@@ -481,9 +481,9 @@ static ssize_t thpsize_enabled_show(struct kobject *kobj,
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
@@ -525,19 +525,27 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
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
 };
 
 static const struct kobj_type thpsize_ktype = {
@@ -583,57 +591,99 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 
-static struct attribute *stats_attrs[] = {
+static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
-	&shmem_alloc_attr.attr,
-	&shmem_fallback_attr.attr,
-	&shmem_fallback_charge_attr.attr,
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
 	.name = "stats",
-	.attrs = stats_attrs,
+	.attrs = file_stats_attrs,
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
@@ -673,7 +723,7 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 		goto remove_hp_group;
 	}
 
-	orders = THP_ORDERS_ALL_ANON;
+	orders = THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DEFAULT;
 	order = highest_order(orders);
 	while (orders) {
 		thpsize = thpsize_create(order, *hugepage_kobj);
-- 
2.43.0


