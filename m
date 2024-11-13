Return-Path: <linux-kernel+bounces-407617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE829C6FED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B471F22B74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BDA202638;
	Wed, 13 Nov 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYwHSB9L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C32022CD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502670; cv=none; b=c6Q4s0g/obx7E1rLivHHE5n6LaDWSTtYuFGn8bcHtopzrXPPaFvSnkYwa9z2+Czqt2huZQqRS1hRTtvPkl2GsRuj0hxBRmt8S8iGUNGL63hj0PP+E3tIEVaKjforHC6I4A17dfReHXWf21XMFmvlpbzIj5bPjzephOtZxyhx+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502670; c=relaxed/simple;
	bh=YmiEgT/yi/9glvt++sRIcz8wFH0eUrfmtf5tjePm8dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOBSwg8FQZvHwBR0QtmpXk8p2Kwy3taMVfPo16EXsyugNi3VC+IOW/2FOVUxoVHmMCmwebBIiByPimspwEKytygSHyFYO8UuKx4mMMoH9lgiKBqnOkkRO9pNMY1GRLJDXCcrFH5ZYzEbbaNdaO2QsMaGBVTDFKuEJNU3ZcHHem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYwHSB9L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrrjP0KEDM8lqL2NE1SqjbzvwUoKziuZjRGMfoLwWGw=;
	b=fYwHSB9LcUoXMmChR7Q5rqaTkeMAIahOt/e62+Tw1aC20VTQqXPM+dvzrCVAz8V4SbDlhu
	0NY8JPi5Vpra4X3+NWfHhZ7DU5HqaH7TAWRHpxzTrwRn350p5fGztebbL2aaaZUW4ZybFR
	ARn2dHeUzJ6XrIpgtOy3LoFArETpx4E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-JioCozLvNfCb0TAGg4sqPw-1; Wed, 13 Nov 2024 07:57:47 -0500
X-MC-Unique: JioCozLvNfCb0TAGg4sqPw-1
X-Mimecast-MFC-AGG-ID: JioCozLvNfCb0TAGg4sqPw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4a211177so3858640f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502666; x=1732107466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrrjP0KEDM8lqL2NE1SqjbzvwUoKziuZjRGMfoLwWGw=;
        b=sv/JFlMPfU0DBnB7ZYrS5Ep2ToDn2iJ3734PNkoSo7SBl5kN5s8igfrjp+FOKtoe9p
         PgzgqavDHTH0QMMNpaiEdDihfw0G75lH9UNIDhG+/HgpiUMcQsuuk4Pdb3HdFh5qyEak
         0vV0zlkyMTQcB/GFd0ucwP9Dy0Vtq1vPkXqtqHQT4CTV5yBRzcGoB5Bq/HUpyBnLDpCr
         AHRa9rf4PROWtXcJmTgTMhmUjR5gtns355NtGFnWKQzASVK/KrjR+hYaGB6N0V64YRJn
         xMLT84xDehxV8P/pz8LmFpo1yjL9plDmwCV5sOSrDm5AxdCr9PL2z5NtUY8OTe6f6Q5g
         z7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmtnDPk3d+UGiJeI59+Y4Kc5zUhOCnYUeRFj/4GPE2s59voMWeJc8PLjus2obLQE3ErrGTn+D0XgL3yMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqAwJp5LfLBjd7Joy77F21QK5nerd1VCYs/RDrDx8uLJ6l3j+a
	Z8ec9Pct6aX/aqlkR9GMRJoHv72ne/QWzmvMgzhG+JgtznsuCiZ66qlOayIsTvRTDZyC69+j7vI
	lyG7XFiY8cKIbjR+z6A0tYC4uBLl44s9reLnMoCl4x8N5ILr2bRbw5nMPZPCz1w==
X-Received: by 2002:a05:6000:2ce:b0:37d:4647:154e with SMTP id ffacd0b85a97d-381f1867241mr17448837f8f.9.1731502665556;
        Wed, 13 Nov 2024 04:57:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy2VCUb/YrhOG4sJTtOcm8JAiO69Hn4t+8LeX63EXs9a8zmjJu8QPDcpAHA0nH0c6/qEeDDA==
X-Received: by 2002:a05:6000:2ce:b0:37d:4647:154e with SMTP id ffacd0b85a97d-381f1867241mr17448812f8f.9.1731502665137;
        Wed, 13 Nov 2024 04:57:45 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997391sm18486834f8f.45.2024.11.13.04.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:43 -0800 (PST)
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
	Valentin Schneider <vschneid@redhat.com>
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
Subject: [PATCH 2/2] sched/deadline: Correctly account for allocated bandwidth during hotplug
Date: Wed, 13 Nov 2024 12:57:23 +0000
Message-ID: <20241113125724.450249-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125724.450249-1-juri.lelli@redhat.com>
References: <20241113125724.450249-1-juri.lelli@redhat.com>
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
bandwidht in the calculation since NORMAL tasks will be anyway moved
away from the CPU as a result of the hotplug operation.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c | 33 ++++++++++++++++++++++++---------
 kernel/sched/sched.h    |  2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)

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
index e53208a50279..609685c5df05 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3467,29 +3467,31 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
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
@@ -3498,6 +3500,19 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
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
+		overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+		break;
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -3506,9 +3521,9 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
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


