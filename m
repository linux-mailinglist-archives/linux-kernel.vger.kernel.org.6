Return-Path: <linux-kernel+bounces-560047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C24CA5FCFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9862D19C26C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85E26A0E4;
	Thu, 13 Mar 2025 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJyuB84h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63107269812
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885425; cv=none; b=sWlOQB6EHZZUfqJA2c2gLQ8BB0c/f5DsapTRoeoMGrtnP7wkWsYfJ0r2VmdNzLI2wl4ZK9ZsmJay4/Revu/FCHoDruuCYWK/FA8h3+fuoRi1B4YZX8s71AFjfAiDMzvjCug9YHsv5slR6SVfWM39uQ/E3AA5UTvUi091EdK5L4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885425; c=relaxed/simple;
	bh=rWzzcRlgHWgNn6FgV0nYpza0tAY2jpiBU7Yx3Kp/uJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTf9FDQYt/wwAWFhYBeP3drp954vP4CIV0n6zL+StHcNERNdE4q8susuWRuVfzjBWSmJpI03GmxQZSDHAtKOoBwKWhE2X62vnD7dHu0578MEup0kugRoGCNCnC3BKlM21viDF1r0CocyYTesi7d3XUdZ68BGz2jCYXj590fOo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJyuB84h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpKB27UpoppNUohxUmSpnADUhWYwKjiQjBLjD49aA4Q=;
	b=XJyuB84hGZfvpYalPB/YVMfjRbQhbWwe4hZmZKYkwibqd3LyRgw5tBTFSpEinE8R/7DjJ6
	1FB8Id9HOfNzbE1Txg1gx5HAXHamU9h4l8sn/dTc11+0TeQRbuUBQEpgvbjPwk94GnqV1W
	/4KVaCtgN2afvBF0Wpz46xFPZ53ZzTo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-gbnkQrdUPkWnU_b5nEyKtg-1; Thu, 13 Mar 2025 13:03:41 -0400
X-MC-Unique: gbnkQrdUPkWnU_b5nEyKtg-1
X-Mimecast-MFC-AGG-ID: gbnkQrdUPkWnU_b5nEyKtg_1741885420
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so8505835e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885418; x=1742490218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpKB27UpoppNUohxUmSpnADUhWYwKjiQjBLjD49aA4Q=;
        b=WeKhH6GZppPgC+KnFstF121N8ujcrBJ+Ej9A5wlfdhm6MI6N3r04gqr/MfJ2xhvsFx
         xtyzG/iULc4Rx/51OXWIMsmFpndtqEjhLV1k4jjrEJzaRKQxxn/B2xd6sOCpIuUgIrmW
         YOlaWh4AEcP8JmDRg7ftH3TB0ptyt8l5NtAwoOCj5qDuIAfTGLkQPWxyFN8xiilETuU7
         YlaOB7SecrsS+Y6kXdaD+hlBr5mdDqvq5/9ZabQolNXIVOKvRVMXlBow1h7B3ryhOiCt
         UJldWsAIFORCK67FHPM00ZtlOGJvhcAHync01bOUP5errcix8bHR5rEcFI8/vOer4O4R
         zLvQ==
X-Gm-Message-State: AOJu0YxG8F6nrvNd2XhMsQsyJ5mIJ5oueAJJhMbPwEN9nI2Cq0xu91QS
	NgXrKdYLTojJ1QZsx0vPqQYjQf+mNXEJsoQfSJbddpRwAFw7HoNOUkHobLQmUb0+KdIKZ3o9ezT
	JrnbcfdmWXgWg8BBjYLyrgujz1Tt35u8OV+Cv/jIAu2sE2g9hty3TuhkOcFHPN8nNC5ketap0Ul
	7tVCv9Eq66TM2Zo1nAqkBIW+NmrQ6l9oxpImpDm9uFy3lJ4xI+
X-Gm-Gg: ASbGnctC9z4//PQtvJhEfmxF9c0FIKQcOSJByoU+o+Gb0WF1kEELVYlX9VX1oZTcykn
	y4KRxFwgBpbdbqGWiOBHHRzffIA8YdKfBJuUHeOfafsVjRVCokZ2a8pCr1CLMJWJMMhPJe0gSGw
	+4yYVzOwGyBp60/BFFkc5SeyOVNhXhQaVavN/OGL+qDbvsu6djRPxsAmL7J2OwgyeaG1VY02bqN
	PntY1wNe6yeyGr7iCmv7J3O8BRuqbum8A7nrFtOJ3W55ek7n6JlJd9K6hCh0fpsuBqA3b8L1se/
	yxG8+x3dO6FVKgu9Nwwwja2okoGiSOuqMRK70QCuqZU=
X-Received: by 2002:a05:600c:1ca4:b0:43c:f575:e305 with SMTP id 5b1f17b1804b1-43d1d897558mr4273375e9.8.1741885417546;
        Thu, 13 Mar 2025 10:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE30aiOWpsPCl2pqvgKR9tHw0iFo0nuAsz0qQ6ZBddzYfWJm0vgp05kaC7GI1re3vo/9t8k9g==
X-Received: by 2002:a05:600c:1ca4:b0:43c:f575:e305 with SMTP id 5b1f17b1804b1-43d1d897558mr4272595e9.8.1741885416975;
        Thu, 13 Mar 2025 10:03:36 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm2737097f8f.71.2025.03.13.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:03:35 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:03:32 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z9MP5Oq9RB8jBs3y@jlelli-thinkpadt14gen4.remote.csb>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>

Create wrappers for sched_domains_mutex so that it can transparently be
used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
do.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched.h   |  5 +++++
 kernel/cgroup/cpuset.c  |  4 ++--
 kernel/sched/core.c     |  4 ++--
 kernel/sched/debug.c    |  8 ++++----
 kernel/sched/topology.c | 12 ++++++++++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9c15365a30c0..4659898c0299 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -382,6 +382,11 @@ enum uclamp_id {
 #ifdef CONFIG_SMP
 extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
+extern void sched_domains_mutex_lock(void);
+extern void sched_domains_mutex_unlock(void);
+#else
+static inline void sched_domains_mutex_lock(void) { }
+static inline void sched_domains_mutex_unlock(void) { }
 #endif
 
 struct sched_param {
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
index 67189907214d..58593f4d09a1 100644
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
index c49aea8c1025..296ff2acfd32 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -6,6 +6,14 @@
 #include <linux/bsearch.h>
 
 DEFINE_MUTEX(sched_domains_mutex);
+void sched_domains_mutex_lock(void)
+{
+	mutex_lock(&sched_domains_mutex);
+}
+void sched_domains_mutex_unlock(void)
+{
+	mutex_unlock(&sched_domains_mutex);
+}
 
 /* Protected by sched_domains_mutex: */
 static cpumask_var_t sched_domains_tmpmask;
@@ -2791,7 +2799,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
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


