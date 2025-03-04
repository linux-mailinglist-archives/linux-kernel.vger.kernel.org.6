Return-Path: <linux-kernel+bounces-543525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EBAA4D6C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755EE174506
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F71FCCEB;
	Tue,  4 Mar 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bi/EBiqf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE81FC0FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077695; cv=none; b=b6FEeWVUJY4hkUsA0trhQHutYgcONwUz50LRqxJ10YJxC0cXngU+4wu5ULkssquvm0Ujc52NkdrIG7wKCkjaeM87ewdamTGUQmUrDCfpBDKaEnOrYV0YVlKYMEjXIRUxdjtAR1C8IiACG6nvjF7uzYtUrHrJAKWThSQDE8ChH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077695; c=relaxed/simple;
	bh=2OdxPjBtShQTPyHN8NcfqpKvYvdCrpr/1DGz7fpEkaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfP7uZIMNly5IrzU5Ww82MHP/kGP8KNdDbAAJKGMSAowfOZrnP324SzcICsJHgGiEdmXCMFND1FLkWpybl37iUfdxERpKYFsINfUTSxQzH0dRIM45aSR6FQnSJZl9+07L9q3Vsoqi7HvXB4dN0xqLMNl/tD1T7HbHpNjm4Wm9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bi/EBiqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khI8Y+GNMlGI4nyBCsweph1yNgRlDOyD6T4E6SKR/uA=;
	b=bi/EBiqf3VBESVAH5FxvNiw9YB/wNA86JI21JM29q6M4kZ9eg1M7MDgTFz9Dkn+pEnMMTY
	TbEXjH/lgKSlnFZJ6lQmmp6IDb+0FzaAYxfl9RQXW+sSA/i1SK4/jxjj/37nbCTVikSiBt
	XGqTgMeOXdkJk3pqlD5rdDKRQ0qnk3M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-fxhwscdiMqKFAt-wIAmx_w-1; Tue, 04 Mar 2025 03:41:21 -0500
X-MC-Unique: fxhwscdiMqKFAt-wIAmx_w-1
X-Mimecast-MFC-AGG-ID: fxhwscdiMqKFAt-wIAmx_w_1741077681
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0a8583e60so1044198385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077678; x=1741682478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khI8Y+GNMlGI4nyBCsweph1yNgRlDOyD6T4E6SKR/uA=;
        b=DyHNb+/AxNNOrCet0oFrJFsYOH5sKurUfePhUef9za8rzAyjD3nVEhsQfs9Gxpy2EN
         CvfWDRrcd48PR+uRBoy2qHjjEBo80nKBi6mynQVMLwXfRZiBrd4RD6xatSxDYX2YQWxs
         SSxRRZljfSDGCD40rHbWLIHwDoENIdUHQiUogeXYfWQYlzmihOOeeuoRPRPvAkJW/7va
         Ft7CvIZyteKjztmz2m+56WgWdM5HThN5RB0sLunYFDc+0iwHRySuYd/T0n7t3gEuVffg
         v9HtxkVKI5ODKXag6uL0wGL0Ha7IrAtmTV9e4TtJF6iGjnm49IvUI232rY4crx9DDYoF
         V7LQ==
X-Gm-Message-State: AOJu0YxacprS/a/razzxj4Rsh8RY0y+lrQ5QKG+EKSFYYdgdnSMJRRd3
	fB5jcIMce+wF7088UYgSzOC0Yl4Ym22v+ap0PZeCTQZeL926cO8Ez1u3Q1AYXB9GzuLQ5XEivWI
	UpyI4yW1x09Xc2fMCi2cs9f1j37Q2Seu5U9Qy8kmrSrK1nLpZ102S80OussEV7cbOA2nOJgR92H
	5LRkpq/2pLDXW+kDUFVaKiMk88oH/tcwT0X+pD8b6NyKc2i0eCnlYISg==
X-Gm-Gg: ASbGncskSV9rqjb+7SqWVRZWALJ0dGnZjIfBlrm7LRBiKmWDo3sNXVrkzbzWwNAfNnv
	FdSTuXs3HDYOplejy2Pbpn6zP5h/I7lWmn/cKXfmeDvVmf4zl6qTKOd2REenAxD7FnB2yeN9DK/
	/656dnQe0sjEhJzk0E4rom0YzZYcZvfO/mWsD9soqvUm4TtE70scWe9nc3AnGB4G+ue8gV17lHu
	4GpsmsKCY7urM1ltRY4KKJc0qz8VHHVkarYITv2htXXRf4W143gNCY3fCxecbe5+icYwi2IBcpu
	O4qTOEklOU88xWaCxdMLox9qSQ9djM++nyUMT5JdRwnKAnrDz8YI1pMy5BrGFQGqdIOElqH+mCe
	8fli3
X-Received: by 2002:a05:620a:4803:b0:7c3:c7a6:cf33 with SMTP id af79cd13be357-7c3c7a6d582mr642146885a.44.1741077677978;
        Tue, 04 Mar 2025 00:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+ZRnOSkJPb3pUSFJp1khxekA5ckD6U6RwBZseGWQ1If920oExHtAQHufEewSrz+n2y3uI+g==
X-Received: by 2002:a05:620a:4803:b0:7c3:c7a6:cf33 with SMTP id af79cd13be357-7c3c7a6d582mr642142385a.44.1741077677648;
        Tue, 04 Mar 2025 00:41:17 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:15 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
Date: Tue,  4 Mar 2025 08:40:42 +0000
Message-ID: <20250304084045.62554-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create wrappers for sched_domains_mutex so that it can transparently be
used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
do.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched.h   |  2 ++
 kernel/cgroup/cpuset.c  |  4 ++--
 kernel/sched/core.c     |  4 ++--
 kernel/sched/debug.c    |  8 ++++----
 kernel/sched/topology.c | 17 +++++++++++++++--
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..d5f8c161d852 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -383,6 +383,8 @@ enum uclamp_id {
 extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
 #endif
+extern void sched_domains_mutex_lock(void);
+extern void sched_domains_mutex_unlock(void);
 
 struct sched_param {
 	int sched_priority;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973..f87526edb2a4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -994,10 +994,10 @@ static void
 partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	dl_rebuild_rd_accounting();
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..7b14500d731b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8424,9 +8424,9 @@ void __init sched_init_smp(void)
 	 * CPU masks are stable and all blatant races in the below code cannot
 	 * happen.
 	 */
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	sched_init_domains(cpu_active_mask);
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..a0893a483d35 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -292,7 +292,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 	bool orig;
 
 	cpus_read_lock();
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 
 	orig = sched_debug_verbose;
 	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
@@ -304,7 +304,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 		sd_dentry = NULL;
 	}
 
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 	cpus_read_unlock();
 
 	return result;
@@ -515,9 +515,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
 
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	update_sched_domain_debugfs();
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..e2b879ec9458 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -6,6 +6,19 @@
 #include <linux/bsearch.h>
 
 DEFINE_MUTEX(sched_domains_mutex);
+#ifdef CONFIG_SMP
+void sched_domains_mutex_lock(void)
+{
+	mutex_lock(&sched_domains_mutex);
+}
+void sched_domains_mutex_unlock(void)
+{
+	mutex_unlock(&sched_domains_mutex);
+}
+#else
+void sched_domains_mutex_lock(void) { }
+void sched_domains_mutex_unlock(void) { }
+#endif
 
 /* Protected by sched_domains_mutex: */
 static cpumask_var_t sched_domains_tmpmask;
@@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			     struct sched_domain_attr *dattr_new)
 {
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 }
-- 
2.48.1


