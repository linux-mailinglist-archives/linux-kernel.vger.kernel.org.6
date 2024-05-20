Return-Path: <linux-kernel+bounces-183839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACA8C9EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88478B2177C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284D136E00;
	Mon, 20 May 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="sTxyvAZd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FB136675
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215463; cv=none; b=j5WJefsG4AHEt+8bc7abUG5fX3b19HjYsYn0u9bO07qizKLgzsld5TS8EjEhkTGbOmTcc9uth2u9AC3PVU2gEAyTkakHlI8xkXq+08PHAbPKMEteS4SsLfi3/yIFxyLOKmkROEgcXQkSAV58FdyIVWpFBGAaBocbHJYwKyHsuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215463; c=relaxed/simple;
	bh=SPNUsdWPNb7uUPi8wdjq/rK1Z6r20OQmFJEdmTAxbjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9JxXNqecfbJvsmhnJX95LfbrY+pUIES94PEySUzElhhrF2ejsrLIQncPb9AgkzeMmp0SlJPwD7EoAKQlOUqLd5OsN0klhEZaw9KE36ZRL4B56hIwjQp+xUDdmiEAl6a2It8eN9Mez8OI3miRfMgh1dt14e99bRi6MGleEifmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=sTxyvAZd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f2f566a7c7so44670315ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1716215461; x=1716820261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgG60yw+644Q9f46uPp0EOPx6ucs+cfRwGlUwKjTcF8=;
        b=sTxyvAZdm6zyENMnrqiFu3kVuUz1crddhyNnz7D7EZDs9AFxssSjbzHPJRVlRgpKOm
         eW5UFfFgI09VL7cFMNWlk8uAC2Hr/u/38uQqDt4a69cDTDlC97dahNITEIrahIlqh+T6
         YCcPyiwl2Kj6QiOnoNp+u1V5tTbcRSvNXP/08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716215461; x=1716820261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgG60yw+644Q9f46uPp0EOPx6ucs+cfRwGlUwKjTcF8=;
        b=IGv2vi8v6Lc4v6728Y7OFfBBqkl5o2JdjdRYitHKISv3zMOq/XglFllYYP69bGWjlY
         9MEl5WECXPz2amgi8Hp5oD4URKUJw+FHUoNGpvjVbTYVZAzSFJdX5givYmnkWTYOEBJr
         9J/HxldzaFFuva8HMdnmRREl23v+VVa8ytj7xQWe5eftcWTeauY294mYTwZ6RrjjuoYN
         xRC2Wp1nlqdi2sbuxpLevMrVZNo8BZ1FLQsbtyuVj+6SMoLQ1VFHRjW8q36seC6J1JVW
         2rcWnXAGFFWHhKyWuZNr6/m/vUuumWxkzFjgVZL2jK7xc8Prax+Jcrrb02FyRLXt/ec3
         Z1og==
X-Forwarded-Encrypted: i=1; AJvYcCVF5ruS/+o91peVCpt7XDrL4ygbMbF/wOWkyXN4Oshj9fYOrBogzQ6TmlvbbDZdrUK+FuRwfHj6+l9XXE553koPoro5v4JvoEw7pYRV
X-Gm-Message-State: AOJu0YzePCYb/UgbMPl57E969XoPiD2YaH2FFCX4h672p9TQD+GXDuPk
	zOlmYLVbTuE/lxc5fElRp1SnCwrJOhX1/4qhu9R+n6XD3NUVuZGPKGcNpQmtLOc=
X-Google-Smtp-Source: AGHT+IHhyPIYEInSJJMQSqbbK4ccOXIi7SNOnrFzx6T0fm27CNPx6pkiV3fzoajJO67ANnolLzKRgw==
X-Received: by 2002:a05:6a21:3414:b0:1b1:d371:335d with SMTP id adf61e73a8af0-1b1d3713568mr4247425637.19.1716215460580;
        Mon, 20 May 2024 07:31:00 -0700 (PDT)
Received: from swarm07.ajou.ac.kr ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa017dsm19714531b3a.96.2024.05.20.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:31:00 -0700 (PDT)
From: Jonghyeon Kim <tome01@ajou.ac.kr>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Jonghyeon Kim <tome01@ajou.ac.kr>
Subject: [RFC PATCH v2 1/3] mm/damon: Add new metric type and target node for watermark
Date: Mon, 20 May 2024 14:30:36 +0000
Message-Id: <20240520143038.189061-2-tome01@ajou.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520143038.189061-1-tome01@ajou.ac.kr>
References: <20240520143038.189061-1-tome01@ajou.ac.kr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For NUMA systems, there is a need to allow damos to select watermark
options for monitoring a target NUMA node or total system memory.

This patch adds new watermark metric type, DAMOS_WMARK_NODE_FREE_MEM_RATE,
and its target node. By doing so, DAMON can avoid that kdamond is not
waked up although the free memory of the target node is between mid and
low watermark.

Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
---
 include/linux/damon.h    | 11 +++++++++--
 mm/damon/core.c          | 11 ++++++++---
 mm/damon/sysfs-schemes.c | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5881e4ac3..d8daa30d7 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -206,11 +206,14 @@ struct damos_quota {
  *
  * @DAMOS_WMARK_NONE:		Ignore the watermarks of the given scheme.
  * @DAMOS_WMARK_FREE_MEM_RATE:	Free memory rate of the system in [0,1000].
+ * @DAMOS_WMARK_NODE_FREE_MEM_RATE: Free memory rate of the system in [0,1000]
+ *				    for specific NUMA node.
  * @NR_DAMOS_WMARK_METRICS:	Total number of DAMOS watermark metrics
  */
 enum damos_wmark_metric {
 	DAMOS_WMARK_NONE,
 	DAMOS_WMARK_FREE_MEM_RATE,
+	DAMOS_WMARK_NODE_FREE_MEM_RATE,
 	NR_DAMOS_WMARK_METRICS,
 };
 
@@ -221,11 +224,14 @@ enum damos_wmark_metric {
  * @high:	High watermark.
  * @mid:	Middle watermark.
  * @low:	Low watermark.
+ * @target_nid:	Target NUMA node id for the watermarks.
  *
  * If &metric is &DAMOS_WMARK_NONE, the scheme is always active.  Being active
  * means DAMON does monitoring and applying the action of the scheme to
- * appropriate memory regions.  Else, DAMON checks &metric of the system for at
- * least every &interval microseconds and works as below.
+ * appropriate memory regions.  Else if $metric is $DAMOS_WMARK_FREE_MEM_RATE,
+ * DAMON checks &metric of the system for at least every &interval microseconds
+ * and works as below. If $metric is $DAMOS_WMARK_NODE_FREE_MEM_RATE, DAMON
+ * only chceks $metric of the $target_nid.
  *
  * If &metric is higher than &high, the scheme is inactivated.  If &metric is
  * between &mid and &low, the scheme is activated.  If &metric is lower than
@@ -237,6 +243,7 @@ struct damos_watermarks {
 	unsigned long high;
 	unsigned long mid;
 	unsigned long low;
+	int target_nid;
 
 /* private: */
 	bool activated;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5b325749f..b1c8ed5fd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1380,12 +1380,17 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 	return true;
 }
 
-static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
+static unsigned long damos_wmark_metric_value(struct damos_watermarks wmarks)
 {
-	switch (metric) {
+	switch (wmarks.metric) {
 	case DAMOS_WMARK_FREE_MEM_RATE:
 		return global_zone_page_state(NR_FREE_PAGES) * 1000 /
 		       totalram_pages();
+	case DAMOS_WMARK_NODE_FREE_MEM_RATE:
+		if (wmarks.target_nid == NUMA_NO_NODE)
+			return 0;
+		return sum_zone_node_page_state(wmarks.target_nid, NR_FREE_PAGES) *
+			1000 / node_present_pages(wmarks.target_nid);
 	default:
 		break;
 	}
@@ -1403,7 +1408,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
 		return 0;
 
-	metric = damos_wmark_metric_value(scheme->wmarks.metric);
+	metric = damos_wmark_metric_value(scheme->wmarks);
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index ae0f0b314..b65291e4a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -656,11 +656,13 @@ struct damon_sysfs_watermarks {
 	unsigned long high;
 	unsigned long mid;
 	unsigned long low;
+	int target_nid;
 };
 
 static struct damon_sysfs_watermarks *damon_sysfs_watermarks_alloc(
 		enum damos_wmark_metric metric, unsigned long interval_us,
-		unsigned long high, unsigned long mid, unsigned long low)
+		unsigned long high, unsigned long mid, unsigned long low,
+		int target_nid)
 {
 	struct damon_sysfs_watermarks *watermarks = kmalloc(
 			sizeof(*watermarks), GFP_KERNEL);
@@ -673,6 +675,7 @@ static struct damon_sysfs_watermarks *damon_sysfs_watermarks_alloc(
 	watermarks->high = high;
 	watermarks->mid = mid;
 	watermarks->low = low;
+	watermarks->target_nid = target_nid;
 	return watermarks;
 }
 
@@ -680,6 +683,7 @@ static struct damon_sysfs_watermarks *damon_sysfs_watermarks_alloc(
 static const char * const damon_sysfs_wmark_metric_strs[] = {
 	"none",
 	"free_mem_rate",
+	"node_free_mem_rate",
 };
 
 static ssize_t metric_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -784,6 +788,27 @@ static ssize_t low_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t target_nid_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+
+	return sysfs_emit(buf, "%d\n", watermarks->target_nid);
+}
+
+static ssize_t target_nid_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_watermarks *watermarks = container_of(kobj,
+			struct damon_sysfs_watermarks, kobj);
+	int err = kstrtoint(buf, 0, &watermarks->target_nid);
+
+	if (err)
+		return -EINVAL;
+	return count;
+}
+
 static void damon_sysfs_watermarks_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_watermarks, kobj));
@@ -804,12 +829,16 @@ static struct kobj_attribute damon_sysfs_watermarks_mid_attr =
 static struct kobj_attribute damon_sysfs_watermarks_low_attr =
 		__ATTR_RW_MODE(low, 0600);
 
+static struct kobj_attribute damon_sysfs_watermarks_target_nid_attr =
+		__ATTR_RW_MODE(target_nid, 0600);
+
 static struct attribute *damon_sysfs_watermarks_attrs[] = {
 	&damon_sysfs_watermarks_metric_attr.attr,
 	&damon_sysfs_watermarks_interval_us_attr.attr,
 	&damon_sysfs_watermarks_high_attr.attr,
 	&damon_sysfs_watermarks_mid_attr.attr,
 	&damon_sysfs_watermarks_low_attr.attr,
+	&damon_sysfs_watermarks_target_nid_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_watermarks);
@@ -1471,7 +1500,7 @@ static int damon_sysfs_scheme_set_quotas(struct damon_sysfs_scheme *scheme)
 static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
 {
 	struct damon_sysfs_watermarks *watermarks =
-		damon_sysfs_watermarks_alloc(DAMOS_WMARK_NONE, 0, 0, 0, 0);
+		damon_sysfs_watermarks_alloc(DAMOS_WMARK_NONE, 0, 0, 0, 0, NUMA_NO_NODE);
 	int err;
 
 	if (!watermarks)
@@ -1951,6 +1980,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		.high = sysfs_wmarks->high,
 		.mid = sysfs_wmarks->mid,
 		.low = sysfs_wmarks->low,
+		.target_nid = sysfs_wmarks->target_nid,
 	};
 
 	damos_sysfs_set_quota_score(sysfs_quotas->goals, &quota);
@@ -2002,6 +2032,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->wmarks.high = sysfs_wmarks->high;
 	scheme->wmarks.mid = sysfs_wmarks->mid;
 	scheme->wmarks.low = sysfs_wmarks->low;
+	scheme->wmarks.target_nid = sysfs_wmarks->target_nid;
 
 	err = damon_sysfs_set_scheme_filters(scheme, sysfs_scheme->filters);
 	if (err)
-- 
2.34.1


