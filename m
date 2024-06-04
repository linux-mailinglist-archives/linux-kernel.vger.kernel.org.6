Return-Path: <linux-kernel+bounces-199952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060E8FA823
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2333C1C23C3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2324713E052;
	Tue,  4 Jun 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xat/sStf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3113DDD1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466778; cv=none; b=XccZyO1TQAJ97TKBcvsNZ+ky5ZzvFnBazf0D7zygmApz4eCR0SzOckAwklUCHJOsqHM/cIxvcnsYqtP0BA0OVZR8E5lwvIac18WPL2/TTh1C53RL/9mvToCiaUEuM03c4IUEF5aSSY6e6bFDpDEj6FDgs/KNqtnW+Z0Ab9tPulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466778; c=relaxed/simple;
	bh=jMjcWKQ200vzGtXDYHEO2KK7tPtckVQowNHX8THkLrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oy8T/VQ9/bCWigrpBPH1adX5bq7dJZRj5Ap1maKYW/0ZLn400Uu1hAwCNVEpdnJESPSkx1r9it8x+f/CAq56NTUFaJvbWD0PhgKhdfQEmPo5HGCpaT8ioMFASU3+wgQASlht27P/eVYQeqB3KNBp0Vwk1cxpZ/PPFpWmzgEzyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xat/sStf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df77196089eso7737323276.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 19:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717466774; x=1718071574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pSleViApJ1HtHahn3WgRlaq3aZcfr2+vjvy3KUqVlAc=;
        b=Xat/sStfTYxl9v9TuSfddh62UrF0ql6ra1Y/4qofyqgNbbnR6W0n7gff3MRNxYquSc
         XgL2UvlPXZCbnOgufv9eRp1HpgJzv1ftlWbTJukehCxa3M5siFBJt7F6XmZwdc5qiAAD
         sXk3cMy8yFfGBBhmrVF2xaR8n9KbcDjq4TFDtBSigE46ZFwY1PawMsYVfKkT12Fu/dCF
         RT33ccriz6KF6N6mdwTDRZU4XV1XMF16B8jOpRT60ISkI/usKZ4qbtQoZcgCi/t23z7P
         fF1ZgxgeJIezzKJX4DMXaIWN7uY1uAqCKSewRVzZgxEhTrQMEcH/ImHmM/qPLR/8Us/v
         627g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717466774; x=1718071574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSleViApJ1HtHahn3WgRlaq3aZcfr2+vjvy3KUqVlAc=;
        b=qgFfYOzwCyUzdwiBAtPK0vu4jOPkQs+F7K+Tgk25LNd/ZrKW7iUXFV7I1m0kE44xR5
         QOk2RBFwG0BOBtTZAqCcMi+Us7kfVsr/4ceKmT6gAyUUzd3pTHAXDFzxHdpjTLLXV3c6
         DcBrWyAHtjXwx2KZDkZB5tggO7fs4uUc54ofo+Gi8hsQYQi5MyIB9QuZqB+N+7r4gE5I
         fhgcMmPj5AJUDO9fGZXHEerW3gkYMAEAlXux5XHP4rT/Kb/D9FUojdN+3pU+2pDkkswv
         aGEjlC1biwn1fO1fntOB3bDAq508sW2Yv7eMaX8C8fh2XGKFFWbSFg11MowymyGVrsuX
         9KpA==
X-Forwarded-Encrypted: i=1; AJvYcCUfzxTCBsKCqESEJB7O1d3ZM5HzIUWvtgiWsMsG7g2VhWOcObriCztfGcjlgSqNseKU5afD2IPThSoeYUwWRT4xbMDCwPcFO1z1qKIu
X-Gm-Message-State: AOJu0Yz7h5jzCWt9c0b6uOJpFbsmuQn/HRSXpBQOTQfciTw0IZzgjb3v
	Exhro/KnsKG7Kq9puhpxRCB+PpAX++GFtteCT58sN7pkLYO0QYBECa+gAMsEGCBhbNM9Dl+9SMy
	9CmQ2Yw==
X-Google-Smtp-Source: AGHT+IHvvDuGpbRREo0VJ2AwDl8RRdoBG5TFOYaDueQhzCeuZnnIw7idyIAR3QbgubkDUEdsnEZqQs0sZPOl
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:367f:7387:3dd2:73f1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:2b03:b0:dfa:4b1f:56f6 with SMTP
 id 3f1490d57ef6-dfa73bf78b3mr1338312276.5.1717466774166; Mon, 03 Jun 2024
 19:06:14 -0700 (PDT)
Date: Mon,  3 Jun 2024 19:05:45 -0700
In-Reply-To: <20240604020549.1017540-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604020549.1017540-5-yuanchu@google.com>
Subject: [PATCH v2 4/8] mm: report workingset during memory pressure driven scanning
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a node reaches its low watermarks and wakes up kswapd, notify all
userspace programs waiting on the workingset page age histogram of the
memory pressure, so a userspace agent can read the workingset report in
time and make policy decisions, such as logging, oom-killing, or
migration.

Sysfs interface:
/sys/devices/system/node/nodeX/workingset_report/report_threshold
	time in milliseconds that specifies how often the userspace
	agent can be notified for node memory pressure.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 include/linux/workingset_report.h |  4 +++
 mm/internal.h                     | 12 ++++++++
 mm/vmscan.c                       | 46 +++++++++++++++++++++++++++++++
 mm/workingset_report.c            | 43 ++++++++++++++++++++++++++++-
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index 8bae6a600410..2ec8b927b200 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -37,7 +37,11 @@ struct wsr_page_age_histo {
 };
 
 struct wsr_state {
+	unsigned long report_threshold;
 	unsigned long refresh_interval;
+
+	struct kernfs_node *page_age_sys_file;
+
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
diff --git a/mm/internal.h b/mm/internal.h
index b5cd86b3fec8..3246384317f6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -399,6 +399,18 @@ bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq, bool can_swap,
 			bool force_scan);
 void set_task_reclaim_state(struct task_struct *task, struct reclaim_state *rs);
 
+#ifdef CONFIG_WORKINGSET_REPORT
+/*
+ * in mm/wsr.c
+ */
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat);
+#else
+static inline void notify_workingset(struct mem_cgroup *memcg,
+				     struct pglist_data *pgdat)
+{
+}
+#endif
+
 /*
  * in mm/rmap.c:
  */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a05f1e8e5cb3..9bba7c05c128 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2559,6 +2559,15 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
 	return can_demote(pgdat->node_id, sc);
 }
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static void try_to_report_workingset(struct pglist_data *pgdat, struct scan_control *sc);
+#else
+static inline void try_to_report_workingset(struct pglist_data *pgdat,
+					    struct scan_control *sc)
+{
+}
+#endif
+
 #ifdef CONFIG_LRU_GEN
 
 #ifdef CONFIG_LRU_GEN_ENABLED
@@ -3962,6 +3971,8 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
 		return;
 
+	try_to_report_workingset(pgdat, sc);
+
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -5637,6 +5648,38 @@ static int __init init_lru_gen(void)
 };
 late_initcall(init_lru_gen);
 
+#ifdef CONFIG_WORKINGSET_REPORT
+static void try_to_report_workingset(struct pglist_data *pgdat,
+				     struct scan_control *sc)
+{
+	struct mem_cgroup *memcg = sc->target_mem_cgroup;
+	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
+	unsigned long threshold = READ_ONCE(wsr->report_threshold);
+
+	if (sc->priority == DEF_PRIORITY)
+		return;
+
+	if (!threshold)
+		return;
+
+	if (!mutex_trylock(&wsr->page_age_lock))
+		return;
+
+	if (!wsr->page_age) {
+		mutex_unlock(&wsr->page_age_lock);
+		return;
+	}
+
+	if (time_is_after_jiffies(wsr->page_age->timestamp + threshold)) {
+		mutex_unlock(&wsr->page_age_lock);
+		return;
+	}
+
+	mutex_unlock(&wsr->page_age_lock);
+	notify_workingset(memcg, pgdat);
+}
+#endif /* CONFIG_WORKINGSET_REPORT */
+
 #else /* !CONFIG_LRU_GEN */
 
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
@@ -6167,6 +6210,9 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
+
+		if (!sc->proactive)
+			try_to_report_workingset(zone->zone_pgdat, sc);
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index fe553c0a653e..801ac8e5c1da 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -311,6 +311,33 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
 	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
 }
 
+static ssize_t report_threshold_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned int threshold = READ_ONCE(wsr->report_threshold);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(threshold));
+}
+
+static ssize_t report_threshold_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t len)
+{
+	unsigned int threshold;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+	if (kstrtouint(buf, 0, &threshold))
+		return -EINVAL;
+
+	WRITE_ONCE(wsr->report_threshold, msecs_to_jiffies(threshold));
+
+	return len;
+}
+
+static struct kobj_attribute report_threshold_attr =
+	__ATTR_RW(report_threshold);
+
 static ssize_t refresh_interval_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -465,6 +492,7 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
+	&report_threshold_attr.attr,
 	&refresh_interval_attr.attr,
 	&page_age_intervals_attr.attr,
 	&page_age_attr.attr,
@@ -486,8 +514,13 @@ void wsr_init_sysfs(struct node *node)
 
 	wsr = kobj_to_wsr(kobj);
 
-	if (sysfs_create_group(kobj, &workingset_report_attr_group))
+	if (sysfs_create_group(kobj, &workingset_report_attr_group)) {
 		pr_warn("Workingset report failed to create sysfs files\n");
+		return;
+	}
+
+	wsr->page_age_sys_file =
+		kernfs_walk_and_get(kobj->sd, "workingset_report/page_age");
 }
 EXPORT_SYMBOL_GPL(wsr_init_sysfs);
 
@@ -500,6 +533,14 @@ void wsr_remove_sysfs(struct node *node)
 		return;
 
 	wsr = kobj_to_wsr(kobj);
+	kernfs_put(wsr->page_age_sys_file);
 	sysfs_remove_group(kobj, &workingset_report_attr_group);
 }
 EXPORT_SYMBOL_GPL(wsr_remove_sysfs);
+
+void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
+{
+	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
+
+	kernfs_notify(wsr->page_age_sys_file);
+}
-- 
2.45.1.467.gbab1589fc0-goog


