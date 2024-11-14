Return-Path: <linux-kernel+bounces-409451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9E9C8CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91101F23063
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A013BC26;
	Thu, 14 Nov 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRz2CA8u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796A13C9A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594516; cv=none; b=tXLWo1KDHRDDVvTVQ4tILPgZ3/kHWMtwEQlMYstNFKbga9jc6NbSfQ/oC9JGRzXH70Al18wAxZqGQWQlx9y9D19r+j2UFY5TOY3RZTnMMO/9d93m4qQCV3u4fMYk0qpE4PzvVVbaDEp4QhJuAP/NbdV9JDGPbC6SvJ5SxCDz1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594516; c=relaxed/simple;
	bh=UiCzCEVKSisB0ZWNuCYSdhK6YcxXJHJ5x6Li45J8UlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT3eaHkqKvyVS/qxHaYWe8hxiHHd65qwKtCGw4Bs1IEYHOqGtXUVTicF7yn3rI4T4yDxU4LjWHQGsV1SALD8Sh7oLUjwcQ80fIS7xHgkZB7Mrb2O2VRJjoSaPwRGpg3srPYeW75+XJeliRpTkwlvpU9/LscD3JW2P8K659V9upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRz2CA8u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731594513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Wu0O/IV5FSWLxTneVq+fA0iAC4oYeWy3hed+ynIa4I=;
	b=eRz2CA8usc32Veu9wfkyshSCePrNejpV/QfiCVklEiawajKcAB4BX9ADFBab62+y/HIrsi
	Ha2vjnLFTWIoggvrqmVeJpNJx3KqlTmijid3zwnEpEwKzHCtmDoGx2Iv5Sdv45O3cjNWlL
	JvfdqZt6AVUxe0MAHVk3EYeNso12Kko=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-a81wtlGAPfK0DpIhZNNhfw-1; Thu, 14 Nov 2024 09:28:32 -0500
X-MC-Unique: a81wtlGAPfK0DpIhZNNhfw-1
X-Mimecast-MFC-AGG-ID: a81wtlGAPfK0DpIhZNNhfw
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb742a18ebso466679eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594511; x=1732199311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Wu0O/IV5FSWLxTneVq+fA0iAC4oYeWy3hed+ynIa4I=;
        b=Jp3HtlhLLlbmzk7tXXklUf3UYB8a8HjuAVaeag6xcg5mR0DoRMZfduWzM/pUR3utkA
         lSePQkamNalBVP7hs/f9ZglTgZr7wudYX4giM0Y3t4Wi9yAKja2Rp0f3sokQnRqfj4RJ
         M5EQdID2S30TTtyV96+Qn0Gb6QS9GO4cYlbsI/3o1PLmbFnT2HRZ3O+5jTbuTzWX/iYI
         zDEZ9/w/5yLlcgylSwLepZlcbJQN6NoOLyY6WAYvL5yY0z4ZwF+snxo7YCJBA5bECSg5
         1sP/LgP+Gz0eTazH++aZk6t48dMSQo31dPr2WjhA71CK9FtpyH8blX6hV51ILKDFvRGJ
         NdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwC+zjdspi/2cH7EuQPqJ872OK+Y6PUhMOf0p41AuD7suSyHmTzSRNJK9rnAYZa+HcHVBqdLvjzw/ho20=@vger.kernel.org
X-Gm-Message-State: AOJu0YySFXC7nTwp3GyZ1cKbteMWPmJks0guHtF93wIANayICpZyTUH1
	cs5L3ClJBiUHo+N20gXWgwzEJUVrM5C0vp4dBUqW1IXMttqyAL437lH+3fEFkq3jlRRKs8ToFez
	XRoIyaTn/p8UQtqX6TBkP23kVtO+uiya12jk+SQZXwAiXBm9gkr3yVH5hWiS/Wg==
X-Received: by 2002:a05:6359:4d09:b0:1ac:f7ac:e302 with SMTP id e5c5f4694b2df-1c66f235a86mr632516955d.18.1731594511366;
        Thu, 14 Nov 2024 06:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcj+J1hQbqvcwXRZ2BZ8q1EL+mAKWdvpM8kRrxL7q/E504BpvzMDS1gACKQRZp8UTh4mIGLQ==
X-Received: by 2002:a05:6359:4d09:b0:1ac:f7ac:e302 with SMTP id e5c5f4694b2df-1c66f235a86mr632512455d.18.1731594511029;
        Thu, 14 Nov 2024 06:28:31 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab25bc8sm6068211cf.69.2024.11.14.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 06:28:30 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 2/2] sched/deadline: Correctly account for allocated bandwidth during hotplug
Date: Thu, 14 Nov 2024 14:28:10 +0000
Message-ID: <20241114142810.794657-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114142810.794657-1-juri.lelli@redhat.com>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For hotplug operations, DEADLINE needs to check that there is still enough
bandwidth left after removing the CPU that is going offline. We however
fail to do so currently.

Restore the correct behavior by restructuring dl_bw_manage() a bit, so
that overflow conditions (not enough bandwidth left) are properly
checked. Also account for dl_server bandwidth, i.e. discount such
bandwidth in the calculation since NORMAL tasks will be anyway moved
away from the CPU as a result of the hotplug operation.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---
v1->v2: special case when total_bw = 0 (discounting dl_servers)
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c | 48 +++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h    |  2 +-
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..d1049e784510 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8057,7 +8057,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_check_overflow(cpu);
+		int ret = dl_bw_deactivate(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a9cdbf058871..267ea8bacaf6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3470,29 +3470,31 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 }
 
 enum dl_bw_request {
-	dl_bw_req_check_overflow = 0,
+	dl_bw_req_deactivate = 0,
 	dl_bw_req_alloc,
 	dl_bw_req_free
 };
 
 static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags;
+	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
+	u64 fair_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
 
-	if (req == dl_bw_req_free) {
+	cap = dl_bw_capacity(cpu);
+	switch (req) {
+	case dl_bw_req_free:
 		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
-	} else {
-		unsigned long cap = dl_bw_capacity(cpu);
-
+		break;
+	case dl_bw_req_alloc:
 		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
 
-		if (req == dl_bw_req_alloc && !overflow) {
+		if (!overflow) {
 			/*
 			 * We reserve space in the destination
 			 * root_domain, as we can't fail after this point.
@@ -3501,6 +3503,34 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 			 */
 			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
 		}
+		break;
+	case dl_bw_req_deactivate:
+		/*
+		 * cpu is going offline and NORMAL tasks will be moved away
+		 * from it. We can thus discount dl_server bandwidth
+		 * contribution as it won't need to be servicing tasks after
+		 * the cpu is off.
+		 */
+		if (cpu_rq(cpu)->fair_server.dl_server)
+			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+
+		/*
+		 * Not much to check if no DEADLINE bandwidth is present.
+		 * dl_servers we can discount, as tasks will be moved out the
+		 * offlined CPUs anyway.
+		 */
+		if (dl_b->total_bw - fair_server_bw > 0) {
+			/*
+			 * Leaving at least one CPU for DEADLINE tasks seems a
+			 * wise thing to do.
+			 */
+			if (dl_bw_cpus(cpu))
+				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+			else
+				overflow = 1;
+		}
+
+		break;
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -3509,9 +3539,9 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	return overflow ? -EBUSY : 0;
 }
 
-int dl_bw_check_overflow(int cpu)
+int dl_bw_deactivate(int cpu)
 {
-	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+	return dl_bw_manage(dl_bw_req_deactivate, cpu, 0);
 }
 
 int dl_bw_alloc(int cpu, u64 dl_bw)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588a8f00..1fee840f1bab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -362,7 +362,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_bw_check_overflow(int cpu);
+extern int  dl_bw_deactivate(int cpu);
 extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec);
 /*
  * SCHED_DEADLINE supports servers (nested scheduling) with the following
-- 
2.47.0


