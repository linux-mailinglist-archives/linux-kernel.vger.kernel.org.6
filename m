Return-Path: <linux-kernel+bounces-553846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1ADA58FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E66188FE15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E21C5F34;
	Mon, 10 Mar 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zy0quUPR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6B22333B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599193; cv=none; b=hHycXQny/7IkzdlBARrqW0lzvZeTueo9pMwM73mlGfykjmmvNFxRtO8NW/JxV7fcW4hfSYclZQggWqOTk4lCcOOejgA5+PeMV4H6qzHSaHskVUADDv6ho4zB/oyKKIKD/yku/9FUqkD8vn3IihPPEoLLo9kOJJiUVekn5ej5b2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599193; c=relaxed/simple;
	bh=wJpaHcARR3YB5XnG3M9UeeHERjXf318a8M9J0vLqzxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbzoadQEaar3/+VLQdvx51x4OeJ0/Ss7rYtJOvyuHkGSiEbKWZ1u3ypPji9+TiCY/81mmqxFeh9vtfgy8yWyflwFdtyT4CxyqcI6IY1l9OBGk0nrr7rQ9RsJX31PGWjFj4UanYp68YFSd56BVE1lr2EBtMShXJKQsNhomI88fQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zy0quUPR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1c5i2Qm2DUrkZQHaLsmF680F9xe+Pb2YDsGrDb31LY=;
	b=Zy0quUPRV6vQ91+oc8A6DQZal7AkWnKtT5vfPVruvkzgLoSAZKI/lTYMB7zwdAKYbYwzH2
	7oReIU6u1ihpbg5BrGGtiM4sDg86q5DqYbhM50WDSG6tQkYNbzeA0SmyyXwQyed0VUYWhC
	VrMKiobkPphJZdu3ywVBIg9v0x5XxyQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-yTqgadkaMc2guXwOjmX5Lg-1; Mon, 10 Mar 2025 05:33:09 -0400
X-MC-Unique: yTqgadkaMc2guXwOjmX5Lg-1
X-Mimecast-MFC-AGG-ID: yTqgadkaMc2guXwOjmX5Lg_1741599188
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438da39bb69so27184515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599186; x=1742203986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1c5i2Qm2DUrkZQHaLsmF680F9xe+Pb2YDsGrDb31LY=;
        b=NR5L9/ZnDz+99jRHYTd3xbQLauo9iY4ZC3ntaJho7Sfol79axRJ7U97oI7TNU0w0o5
         /FttRjjq0G4Zc42mBb6PN4cOyt7MfRb5tUzKUeIKLijJ+9oDJSOY1B+dfMFcOQK9dHF3
         YhjBL6ixFw15+rKoKDQgjWKOFH41iLhX1RQDfNdh0MZtul8lm+lx+8sLTmHnPLq2+z3Q
         HHoqQ7PjCT/6FPe8Aju9H6yutq88jGsUcIzthbFaajGaui/1S7dVPBFooAAnjtCcNtDe
         BEolTE0L97TulgewCjMkwRV45nmGO1J8jpzpzSz+wF03ZvDKW0MVzXHNNF17M3H0lJsg
         kcsQ==
X-Gm-Message-State: AOJu0Yw5G4N+FZ0CFdpnr3/2M53yg4JcGojRSu/X8Vl4dKCdoNkpYCcb
	eA46C5/D1w7K5fzDc0Yw5q3rNZSElzHuVtxiW8UUjwJjV8OUqmf829ceouipvZkVLfB7ThJegxI
	dkvTARb9djgSwBpcwpFbCEOgVPy/nPJmKUgctX1uqXRskqLY57tyY98Td4eQPe8fncRxFQYRhHV
	97DEMu9rPXt+iTjgnrTnCr12keAoKkz4T5/nB3Ok0FNvTQknifous=
X-Gm-Gg: ASbGncs9DUY9TViawQs4bvyE3i6RHQ/XmPbE1GJa74WRsxK4/uWRire7Z2XnD1kuK0e
	Q/wIWvK6crKoCA1LnqCoRejOoacIUuOHlzUHkPgGnrNkKYYTHyWU4JQ9XeGAypzOCbWcIfrMJi6
	3SQhlzEri4w7QRO0B5Dthh+3nAnIVhrBCoOQatAMvDMC04pDf8KcmJSF56DyHae21b3Bt2IL0y5
	yQzpGTUNbMPvavKniDJVITzQqXtVCg9Ch4sdCCYB3A8o9jTY2C0FW15ojIXf4eAGL9JpVo69vKz
	0gQFMRv+H2cHQyBKb23mSU8hmSqoDOlxkbzmGvmO5Q4=
X-Received: by 2002:a05:600c:1f92:b0:43c:e5c2:394 with SMTP id 5b1f17b1804b1-43ce5c2054emr52822565e9.0.1741599185884;
        Mon, 10 Mar 2025 02:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLMiRzgA5hzMsBbSiJbAqQMr/pIjjtP9IG0cEEYXnbRD0gQZrY8zGFUbNgAmgSDjVV8Tx22w==
X-Received: by 2002:a05:600c:1f92:b0:43c:e5c2:394 with SMTP id 5b1f17b1804b1-43ce5c2054emr52822125e9.0.1741599185397;
        Mon, 10 Mar 2025 02:33:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfac24345sm19535045e9.22.2025.03.10.02.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:33:03 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:33:00 +0100
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
Subject: [PATCH v3 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z86xzGyT3av5dh1p@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>

Create wrappers for sched_domains_mutex so that it can transparently be
used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
do.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
v2 -> v3: Add wrappers back for the !SMP case as sched_rt_handler()
          needs them
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


