Return-Path: <linux-kernel+bounces-285225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6358A950AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876AF1C219E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509861A2C2B;
	Tue, 13 Aug 2024 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cf6TjRSD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54591A2C01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568382; cv=none; b=tWxuU4LWi+a6J3nTEoSWRiQDjbcMPDawRL1JN1oTz5a7IG2vKGBFickMMRg9+LobEB1fj+5dQoBBisLNeOTCnv2dMehhsxEyZE6rj9ffC6YdwaZ7K1cMcRrXE6glkP9aFe6ZrCEBmRdmIZb79bcWzTyIUgN9QBfzJWHFUiR/MlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568382; c=relaxed/simple;
	bh=FnqAQTPwgBVVzDcbida/hFCCtbq3A4I5BvukZxTAxKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jj9HNT3GZqI7WHPfFBk/g+/MxEvsdROc4MVCoYEnlaG9RF4mKx4hQLQF43LXOPsXiDbCJVIc3afYW6EG+vzN4bOOoWVT3Cz1ovG0IjvOXkwIbO49TYYU9WIF87U8R3ux3VdVukyuXpXF7jssqkUJaAUHzuU7zu12xIU/OieFKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cf6TjRSD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664fc7c4e51so116144807b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723568380; x=1724173180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqd1jKx+q5wvRHFsKe7RtJaTNM99zPu8YKm8b61Swh4=;
        b=cf6TjRSD7hGi1Z7Qu23XIG7vOAiRc4PCOA0hLBhX5rg3pFiqeJto/+2dl2U1fEBCYI
         3Won33Z1AGzKo2aSR5vWaq23zzlSFoGFFa7elnDhiXcQ1/vRt7Hv7drl/fwyi+SZ3Aq7
         R63j0YsMj/uct3npuDxpuH0oSbbf7c9nu5otOOiaYrcnJwAeuzAOrJ4ieOwVD9oTSaWq
         wlQM36pGs6XohQSi17G8MNmqceVsglySsmvk4QW0TniIK4vrekUW5U+9jmTQcq0rYJ+S
         poJuF4sX8Q2nnyhdkD6joiLR6V1mWT6lKPgESp7azd0Fu9njgBPuABW/i+pGPXJcNoY/
         Y6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568380; x=1724173180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqd1jKx+q5wvRHFsKe7RtJaTNM99zPu8YKm8b61Swh4=;
        b=OZDbEIprO+UvH6NKfDEVdkrZqhTbYP7AvHs4dlDWK6m3sfgd2jGalLvdZceFKKmBx4
         ta/cxp2fJUdBFuUkKLGLUgmKXqv1O6cna2oQxnJAmkuUtB2es3oF8EZjov7bls7V+QlW
         1cz4tv6ZKYNLBNyU8o49sZkPVo0/nLw8kRsDumNdBOWMmD5fL+iMxIl/In1ANgnBR+7w
         QIiUgsGZXKT98fhcBdvz3s/s/mULxPtuA88G4DpW+F+UKLMxGMGGpas73BXp3gEOfSpm
         bHSWQBjAdD/wLgfx045UCpbF7Tv+7aX/bawED20UJOwd2ql5nrgMsC5t7oN6bux46Gg5
         OT/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNh/g8puuTfWbDeZKEwfp4qx47i1NVRxm7e10029RVtwza6XMJsw356SLGNgcfrWt9R/zpvbIQOXiHb5xLx6VQCJR1xaFurVSNDt0M
X-Gm-Message-State: AOJu0YypvRaoU2FAQdcqkUESCypYGmjXxDI6Wq+T7Nl59P5fLcyXwdU3
	usdnwvBgcoPSPFFvtb/8O84o3hPO/WWUERkmi/pkr0j/w7rCo+gC52xSYHWYAplwIVYT1kW5imu
	ABa+K5w==
X-Google-Smtp-Source: AGHT+IHcXqA8D3zvHAIQfVpeQAXseyth/6ohOvX1sAG9G57GDA3x2krpy7DDbUSjGWDUUw5XpHr8rLgkLnqj
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a0d:ce43:0:b0:62f:f535:f41 with SMTP id
 00721157ae682-6ac9bd76ef6mr1297b3.9.1723568379605; Tue, 13 Aug 2024 09:59:39
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:56:13 -0700
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813165619.748102-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813165619.748102-3-yuanchu@google.com>
Subject: [PATCH v3 2/7] mm: use refresh interval to rate-limit workingset
 report aggregation
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
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

The refresh interval is a rate limiting factor to workingset page age
histogram reads. When a workingset report is generated, a timestamp
is noted, and the same report will be read until it expires beyond
the refresh interval, at which point a new report is generated.

Sysfs interface
/sys/devices/system/node/nodeX/workingset_report/refresh_interval
	time in milliseconds specifying how long the report is valid for

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
Change-Id: Iabacec2845a7fac7280ffc5f4faed55186cfa7a2
---
 include/linux/workingset_report.h |  1 +
 mm/workingset_report.c            | 84 +++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index d7c2ee14ec87..8bae6a600410 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -37,6 +37,7 @@ struct wsr_page_age_histo {
 };
 
 struct wsr_state {
+	unsigned long refresh_interval;
 	/* breakdown of workingset by page age */
 	struct mutex page_age_lock;
 	struct wsr_page_age_histo *page_age;
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index a4dcf62fcd96..fe553c0a653e 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -195,7 +195,8 @@ static void collect_page_age(struct wsr_page_age_histo *page_age,
 
 /* First step: hierarchically scan child memcgs. */
 static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
-			 struct pglist_data *pgdat)
+			 struct pglist_data *pgdat,
+			 unsigned long refresh_interval)
 {
 	struct mem_cgroup *memcg;
 	unsigned int flags;
@@ -208,12 +209,15 @@ static void refresh_scan(struct wsr_state *wsr, struct mem_cgroup *root,
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 		unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq);
+		int gen = lru_gen_from_seq(max_seq);
+		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
 
 		/*
 		 * setting can_swap=true and force_scan=true ensures
 		 * proper workingset stats when the system cannot swap.
 		 */
-		try_to_inc_max_seq(lruvec, max_seq, true, true);
+		if (time_is_before_jiffies(birth + refresh_interval))
+			try_to_inc_max_seq(lruvec, max_seq, true, true);
 		cond_resched();
 	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
 
@@ -270,17 +274,25 @@ bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 			struct pglist_data *pgdat)
 {
 	struct wsr_page_age_histo *page_age;
+	unsigned long refresh_interval = READ_ONCE(wsr->refresh_interval);
 
 	if (!READ_ONCE(wsr->page_age))
 		return false;
 
-	refresh_scan(wsr, root, pgdat);
+	if (!refresh_interval)
+		return false;
+
 	mutex_lock(&wsr->page_age_lock);
 	page_age = READ_ONCE(wsr->page_age);
-	if (page_age) {
-		copy_node_bins(pgdat, page_age);
-		refresh_aggregate(page_age, root, pgdat);
-	}
+	if (!page_age)
+		goto unlock;
+	if (page_age->timestamp &&
+	    time_is_after_jiffies(page_age->timestamp + refresh_interval))
+		goto unlock;
+	refresh_scan(wsr, root, pgdat, refresh_interval);
+	copy_node_bins(pgdat, page_age);
+	refresh_aggregate(page_age, root, pgdat);
+unlock:
 	mutex_unlock(&wsr->page_age_lock);
 	return !!page_age;
 }
@@ -299,6 +311,52 @@ static struct wsr_state *kobj_to_wsr(struct kobject *kobj)
 	return &mem_cgroup_lruvec(NULL, kobj_to_pgdat(kobj))->wsr;
 }
 
+static ssize_t refresh_interval_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+	unsigned int interval = READ_ONCE(wsr->refresh_interval);
+
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(interval));
+}
+
+static ssize_t refresh_interval_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t len)
+{
+	unsigned int interval;
+	int err;
+	struct wsr_state *wsr = kobj_to_wsr(kobj);
+
+	err = kstrtouint(buf, 0, &interval);
+	if (err)
+		return err;
+
+	mutex_lock(&wsr->page_age_lock);
+	if (interval && !wsr->page_age) {
+		struct wsr_page_age_histo *page_age =
+			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
+
+		if (!page_age) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+		wsr->page_age = page_age;
+	}
+	if (!interval && wsr->page_age) {
+		kfree(wsr->page_age);
+		wsr->page_age = NULL;
+	}
+
+	WRITE_ONCE(wsr->refresh_interval, msecs_to_jiffies(interval));
+unlock:
+	mutex_unlock(&wsr->page_age_lock);
+	return err ?: len;
+}
+
+static struct kobj_attribute refresh_interval_attr =
+	__ATTR_RW(refresh_interval);
+
 static ssize_t page_age_intervals_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
 {
@@ -382,13 +440,6 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 	int ret = 0;
 	struct wsr_state *wsr = kobj_to_wsr(kobj);
 
-
-	mutex_lock(&wsr->page_age_lock);
-	if (!wsr->page_age)
-		wsr->page_age =
-			kzalloc(sizeof(struct wsr_page_age_histo), GFP_KERNEL);
-	mutex_unlock(&wsr->page_age_lock);
-
 	wsr_refresh_report(wsr, NULL, kobj_to_pgdat(kobj));
 
 	mutex_lock(&wsr->page_age_lock);
@@ -414,7 +465,10 @@ static ssize_t page_age_show(struct kobject *kobj, struct kobj_attribute *attr,
 static struct kobj_attribute page_age_attr = __ATTR_RO(page_age);
 
 static struct attribute *workingset_report_attrs[] = {
-	&page_age_intervals_attr.attr, &page_age_attr.attr, NULL
+	&refresh_interval_attr.attr,
+	&page_age_intervals_attr.attr,
+	&page_age_attr.attr,
+	NULL
 };
 
 static const struct attribute_group workingset_report_attr_group = {
-- 
2.46.0.76.ge559c4bf1a-goog


