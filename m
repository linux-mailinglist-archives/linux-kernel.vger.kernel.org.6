Return-Path: <linux-kernel+bounces-542816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222CDA4CE1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D768D3AD2C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DF23A995;
	Mon,  3 Mar 2025 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Soi9THCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A823957C;
	Mon,  3 Mar 2025 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040255; cv=none; b=ksEHxMMna3yWFKXo5IyWCV8vNJRjmWoYVKV7vDLUWka+bpeQ4FjveB74wf7GvISHN2dnnV2Z515kdFJS/Z4OXpTPbUcEBbeNdAshpCvlBjOsMZvk6f4Zfdlfv8gH7lOSmFyb42LtxxJFNbMs9dz62OAhzqg+Os2ANTs918cnW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040255; c=relaxed/simple;
	bh=oYTrlxmiR5BNoFrioFop/hpnftvDsKcm3PmL/H0/UqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mI2oaJtznHKNymVvSB3O1bu48B0K2TL0Wk/G3Z9OtvACTFMqb+CpIebDTfGl+kjC5PhZM7N1GznV/bVqtiZivAU4b4nH9iKMZwTPUzn+qqPG0c87nTE4RBIeIeQ9THqWuxDkfTwOFpoNyoAEL6oVpPnvEfBa7PU9hY5jKrbe230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Soi9THCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C63DC4CED6;
	Mon,  3 Mar 2025 22:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040255;
	bh=oYTrlxmiR5BNoFrioFop/hpnftvDsKcm3PmL/H0/UqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Soi9THCj2vEwCsPhfxxhbpnWH+DVFLPZsuCOYAcBSoInfDeSLhlJZDv24GLuUGw5W
	 a2NOwqyU4qvSt+5s828s9NElO2yk9Ead4EfEC07tplzZBHpUDUmEVJlzAPHR7nA3YO
	 IBJUYVhP64Ofv/tcQ3HrufgwhxzsB9mgYeoJ2sri319uJnS/2fjG95acUTeCnmJyvv
	 CfOElNg8IijVJ/uEB4CKfT+7O5zMbf3VQPfqKpcZGT57mO9UBsIx0kY/CADLhPI/oZ
	 SNGeJ+rbJk3Pbe4+vTX5b8zQdtyNMmHd6v5616QfD5Nshzp8ZITkND+USL0rVp5H4k
	 YhwvrbXH2TU9A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/damon/sysfs: implement intervals tuning goal directory
Date: Mon,  3 Mar 2025 14:17:21 -0800
Message-Id: <20250303221726.484227-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON sysfs interface directory and its files for setting
DAMON sampling and aggregation intervals auto-tuning goal.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 189 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index deeab04d3b46..a772060300b4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -408,6 +408,164 @@ static const struct kobj_type damon_sysfs_targets_ktype = {
 	.default_groups = damon_sysfs_targets_groups,
 };
 
+/*
+ * intervals goal directory
+ */
+
+struct damon_sysfs_intervals_goal {
+	struct kobject kobj;
+	unsigned long access_bp;
+	unsigned long aggrs;
+	unsigned long min_sample_us;
+	unsigned long max_sample_us;
+};
+
+static struct damon_sysfs_intervals_goal *damon_sysfs_intervals_goal_alloc(
+		unsigned long access_bp, unsigned long aggrs,
+		unsigned long min_sample_us, unsigned long max_sample_us)
+{
+	struct damon_sysfs_intervals_goal *goal = kmalloc(sizeof(*goal),
+			GFP_KERNEL);
+
+	if (!goal)
+		return NULL;
+
+	goal->kobj = (struct kobject){};
+	goal->access_bp = access_bp;
+	goal->aggrs = aggrs;
+	goal->min_sample_us = min_sample_us;
+	goal->max_sample_us = max_sample_us;
+	return goal;
+}
+
+static ssize_t access_bp_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->access_bp);
+}
+
+static ssize_t access_bp_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->access_bp = nr;
+	return count;
+}
+
+static ssize_t aggrs_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->aggrs);
+}
+
+static ssize_t aggrs_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->aggrs = nr;
+	return count;
+}
+
+static ssize_t min_sample_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->min_sample_us);
+}
+
+static ssize_t min_sample_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->min_sample_us = nr;
+	return count;
+}
+
+static ssize_t max_sample_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->max_sample_us);
+}
+
+static ssize_t max_sample_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_intervals_goal *goal = container_of(kobj,
+			struct damon_sysfs_intervals_goal, kobj);
+	unsigned long nr;
+	int err = kstrtoul(buf, 0, &nr);
+
+	if (err)
+		return err;
+
+	goal->max_sample_us = nr;
+	return count;
+}
+
+static void damon_sysfs_intervals_goal_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damon_sysfs_intervals_goal, kobj));
+}
+
+static struct kobj_attribute damon_sysfs_intervals_goal_access_bp_attr =
+		__ATTR_RW_MODE(access_bp, 0600);
+
+static struct kobj_attribute damon_sysfs_intervals_goal_aggrs_attr =
+		__ATTR_RW_MODE(aggrs, 0600);
+
+static struct kobj_attribute damon_sysfs_intervals_goal_min_sample_us_attr =
+		__ATTR_RW_MODE(min_sample_us, 0600);
+
+static struct kobj_attribute damon_sysfs_intervals_goal_max_sample_us_attr =
+		__ATTR_RW_MODE(max_sample_us, 0600);
+
+static struct attribute *damon_sysfs_intervals_goal_attrs[] = {
+	&damon_sysfs_intervals_goal_access_bp_attr.attr,
+	&damon_sysfs_intervals_goal_aggrs_attr.attr,
+	&damon_sysfs_intervals_goal_min_sample_us_attr.attr,
+	&damon_sysfs_intervals_goal_max_sample_us_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_intervals_goal);
+
+static const struct kobj_type damon_sysfs_intervals_goal_ktype = {
+	.release = damon_sysfs_intervals_goal_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_intervals_goal_groups,
+};
+
 /*
  * intervals directory
  */
@@ -417,6 +575,7 @@ struct damon_sysfs_intervals {
 	unsigned long sample_us;
 	unsigned long aggr_us;
 	unsigned long update_us;
+	struct damon_sysfs_intervals_goal *intervals_goal;
 };
 
 static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
@@ -436,6 +595,32 @@ static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
 	return intervals;
 }
 
+static int damon_sysfs_intervals_add_dirs(struct damon_sysfs_intervals *intervals)
+{
+	struct damon_sysfs_intervals_goal *goal;
+	int err;
+
+	goal = damon_sysfs_intervals_goal_alloc(0, 0, 0, 0);
+	if (!goal)
+		return -ENOMEM;
+
+	err = kobject_init_and_add(&goal->kobj,
+			&damon_sysfs_intervals_goal_ktype, &intervals->kobj,
+			"intervals_goal");
+	if (err) {
+		kobject_put(&goal->kobj);
+		intervals->intervals_goal = NULL;
+		return err;
+	}
+	intervals->intervals_goal = goal;
+	return 0;
+}
+
+static void damon_sysfs_intervals_rm_dirs(struct damon_sysfs_intervals *intervals)
+{
+	kobject_put(&intervals->intervals_goal->kobj);
+}
+
 static ssize_t sample_us_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -569,6 +754,9 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	err = kobject_init_and_add(&intervals->kobj,
 			&damon_sysfs_intervals_ktype, &attrs->kobj,
 			"intervals");
+	if (err)
+		goto put_intervals_out;
+	err = damon_sysfs_intervals_add_dirs(intervals);
 	if (err)
 		goto put_intervals_out;
 	attrs->intervals = intervals;
@@ -599,6 +787,7 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
 {
 	kobject_put(&attrs->nr_regions_range->kobj);
+	damon_sysfs_intervals_rm_dirs(attrs->intervals);
 	kobject_put(&attrs->intervals->kobj);
 }
 
-- 
2.39.5

