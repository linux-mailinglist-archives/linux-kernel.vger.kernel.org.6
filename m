Return-Path: <linux-kernel+bounces-561801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863ABA61666
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F49C19C3429
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D120487E;
	Fri, 14 Mar 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGdU/cef"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B1204683
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970190; cv=none; b=cS5O60qoIgf0z48hBoxDoaL9975eJ59Gc+MSw5TeANxthMhXAAY4esiwshQ+nDfaOMlyGTANyn18AwJTrvG1y8Pro5ilT/DeyGQasW3XOicAa1Ve30S2Rik1GBReJICfEV/voB8jIUYyyfW15RSea+7S+l34DX9lIUvVbCmiHbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970190; c=relaxed/simple;
	bh=lWkbNwnU42/3UeHrOSQyV7bTNoivQuIxQ1vjh4Mq5ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J61uWwMmRW2/gqGEVJDtYNtb3xJlwC3jQR+zYkogwjEoaob67qzoQfd9KkCCPCIZlVbKQL56qcTo2u6uanfShDqgmG/8DpCEhsnZ9edYcOtNOT5BXpTGP/POoy6UJ32q+gdbqMpOC2d+VlU2Hhe4UXF5bPOpNIX0s+l9KRLzbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGdU/cef; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1307615f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970186; x=1742574986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HssPI0cKmc3x85MzrxtPJaiP5XP5Yw7gWJ7O5ruEo5I=;
        b=xGdU/ceflSxWPuMrWc8VKWaeDHspRWExWxfqP0o7eDVQIXZUzfPx+UdUrgTXZd8iDv
         Zsn6ZBuP2IJOerCa7TpJXrSDw39gzLn26TI6ai/fXrBn78glRmMszBDdJ8lYTSMSrVGv
         /E+2bXhy8dKyep+uoet4FKPuPLErgm22efqTvHweypAXtOnqiQTL+RW3966AqMBhE+tH
         4cvm1q9RysD+jbG07kBufkNYQfQqS5LRWqwMPlgQk3fx/h63RHd6/B+jf2shFk2izLnn
         wrD4s+yTiw2so6Kn4FvFtwr2vvqisSjK61+3IYhsO+QaFbWTN4j30EBi2mlYVRD46SpS
         rWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970186; x=1742574986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HssPI0cKmc3x85MzrxtPJaiP5XP5Yw7gWJ7O5ruEo5I=;
        b=TJVPzNBZZMofycZWKnunaGBm91Q3BlPEwEIbgp966ZhiHbBntd9l/VG04P7sDgsY4z
         2yiUAzgVFbHQf7u5dN2+TbqsAMYR/nRIcAFUrXEybapB+4MvvuA4DuPB+SvuFy1mln6P
         lrFn5OhCiE7O/qbokzluJMJi0SjhXJlQt4Lysum7OnZrMplSZn7WJGI0nticSdy4njT2
         arMUqsIa6BlYVcDvdy2k729TUzxfdevTqjFincs9a/JPcYMnxDUoMp/TgqIt7uuB1AEL
         l6PE7WEJcTAbklST9kTrrZHau0fR05/TndXFiwVuuP1EcXN0qNeY3Fg1Oh/fozsdppL3
         HKNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVchhRROc2ZcYkFRcBDDRhjzemaGey81f2i+MUmJS1eayn+VfeD5nZfRMqwVeE9syq8wIOaf7hU4ytKZ4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOes2pK7Rv4KLOLrm2nXXfUjxt4PZf0BHQYIfE01JemjNBnSV8
	Bzs7WSnBYd5WC5Bj59GQ/lTYS6D+emi8yA/zuwA2BtF0y58UbkLEITjLrOcZUEQ=
X-Gm-Gg: ASbGnctwtbwvkK4h4GXuriX+6CpgotCUnssucXb0YL+XDa1oNMSdbNc1Mcy1RPZ86p0
	cFsaTrCKLxllgXSDpYB7ykgbJsT6FmHn3YZTl+6PGA0g1+LbTc76Ag8wiAdmdky5L5PcSy73aTQ
	f6uS3fvHhfkNP3hiQrT4rjG4PUyBd8S8jtXTUjvsSpRW7BRJI1AVLntUoUrF3tWuvYQ1wtRYjGk
	TcmA4ReLtr8kneS7CtwniTWWv0FtXQjtfxfF/YA41xPUtKQ82VB773+5O652jaF25vKdUhA+uGq
	QV2TkoehSCHdCYJUrdngPLZ83Fp1TAcS5Sjf7z2OAN6+CxS/cOWo4+3BHaF61m0=
X-Google-Smtp-Source: AGHT+IEfcbaC7/dP12XC4RIyye8JyqalwZZXx4m/QKC8CumMgy5dhoxCd5fKQUNt5trjL+7P/A45EA==
X-Received: by 2002:a05:6000:1a87:b0:390:f0ff:2c1c with SMTP id ffacd0b85a97d-3971e96b183mr3622548f8f.18.1741970185902;
        Fri, 14 Mar 2025 09:36:25 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:329b:9a6:20f4:3754])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm6072925f8f.78.2025.03.14.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:24 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	christian.loehle@arm.com,
	luis.machado@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/7 v6] sched/fair: Add misfit case to push task mecanism for EAS
Date: Fri, 14 Mar 2025 17:36:13 +0100
Message-ID: <20250314163614.1356125-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314163614.1356125-1-vincent.guittot@linaro.org>
References: <20250314163614.1356125-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some task misfit cases can be handled directly by the push mecanism
instead of triggering an idle load balance to pull the task on a better
CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a95d2eb168e..81b4d09c6c5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8510,6 +8510,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
 			target_stat.capa = capacity_of(cpu);
 			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_runnable;
+			if ((p->on_rq) && (!p->se.sched_delayed) && (cpu == prev_cpu))
+				target_stat.nr_running--;
 
 			/* If the target needs a lower OPP, then look up for
 			 * the corresponding OPP and its associated cost.
@@ -8615,6 +8617,9 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return false;
 
+	if (!task_fits_cpu(p, cpu_of(rq)))
+		return true;
+
 	if (is_rd_overutilized(rq->rd))
 		return false;
 
@@ -8626,33 +8631,33 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
 
 static int active_load_balance_cpu_stop(void *data);
 
-static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
+static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
 {
 	int new_cpu, cpu = cpu_of(rq);
 
 	if (!sched_energy_enabled())
-		return;
+		return false;
 
 	if (WARN_ON(!p))
-		return;
+		return false;
 
 	if (WARN_ON(!task_current(rq, p)))
-		return;
+		return false;
 
 	if (is_migration_disabled(p))
-		return;
+		return false;
 
 	/* If there are several task, wait for being put back */
 	if (rq->nr_running > 1)
-		return;
+		return false;
 
 	if (!sched_energy_push_task(p, rq))
-		return;
+		return false;
 
 	new_cpu = find_energy_efficient_cpu(p, cpu);
 
 	if (new_cpu == cpu)
-		return;
+		return false;
 
 	/*
 	 * ->active_balance synchronizes accesses to
@@ -8663,13 +8668,15 @@ static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
 		rq->active_balance = 1;
 		rq->push_cpu = new_cpu;
 	} else
-		return;
+		return false;
 
 	raw_spin_rq_unlock(rq);
 	stop_one_cpu_nowait(cpu,
 		active_load_balance_cpu_stop, rq,
 		&rq->active_balance_work);
 	raw_spin_rq_lock(rq);
+
+	return true;
 }
 
 static inline int has_pushable_tasks(struct rq *rq)
@@ -8954,7 +8961,11 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return sched_balance_newidle(rq, rf) != 0;
 }
 #else
-static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
+static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
+{
+	return false;
+}
+
 static inline void fair_queue_pushable_tasks(struct rq *rq) {}
 static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
 static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
@@ -13362,9 +13373,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
-	check_pushable_task(curr, rq);
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!check_pushable_task(curr, rq)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.43.0


