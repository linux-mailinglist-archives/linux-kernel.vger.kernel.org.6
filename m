Return-Path: <linux-kernel+bounces-525380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86770A3EF44
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157D73B9D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF73202C23;
	Fri, 21 Feb 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbPzM8zr"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF233EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128267; cv=none; b=M/ZUAILRXrJ7/ob1sqocHhCMv0x5ftcvaKPnxrH4gRuMTkqlYWiOoyXdmyUZx5JxBI8V7YAVHCKGK36hMRidLdB2OsWTAMLlN/2dKYvr8SIPnl1yV2oSgrLYO+GYm/AaGTTwh+kyz1Zs6ziAIaBGBZN8QfAZN6cXlCeFgsKtpQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128267; c=relaxed/simple;
	bh=NU/hkrqoZ5jzQmEQiGl0NYzgGLmACZcdobkKFKgALLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dy3kOoux763WQ79YIltdk1CKAFZ0GZLF9rzvWefoxNDFbZtCtOBg+ft1ckIxkBgni38A7aY1aggy5Wd3guw8+VTYoH1KhFX/ngdDnBWQFT1E8lGKu2QLRth5rbmos13ax/lpr+xivg6ruw5IZeiUxorgGO1CVyawmbn78BRl77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbPzM8zr; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-221050f3f00so39174475ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740128265; x=1740733065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkbJqFXXVa6R8LsAKTwnnxnNWPxmP+opdk/XTuZUT9c=;
        b=XbPzM8zrhIMDooKy1IqDdjvejHZcPkeha3ccxvMp3I9voVqMPkuFBPr+ku7wb5vTH8
         z10J/P5brLDb/oTRprXyqAvlhbEjwDKMmmvWcO5EHHQ10NzmHbbHBA8x81Zt8a1M07tA
         hLzTPrJka+Mp1Q4Pb2B/9QzjSAbdfk2aKrpDUq80Mk82cFPpd/wHKP8LgrsitxOo5geS
         Nt8C9xbnTzRDGkRj1YgcCjYlR5QANhk1jfSXLcnukq3JAfkxUewSYm560GaJ6nenXP1f
         p2s7Yu7W1G1fyLlKbyb9OlMUdJw8hYnOhiw5+9MUUIXUqjtBFvCg1NOClFJoL3eqFyEV
         J9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740128265; x=1740733065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkbJqFXXVa6R8LsAKTwnnxnNWPxmP+opdk/XTuZUT9c=;
        b=Q0cqVPBK2nXccpEJEX/SvDVFcfOleyGfTGN+kwuVSUE8JiPkd4m7oZqYh44I4heiZq
         r74Lj5RS+eOJ/srXtZAPC78GPAjlGGCjldzL5V2zF02tuTuR7HOu5/3S5llKra3/XZ2s
         G3f7EQzMPKgkGqPsl6p0PntF0OEhQlqPzyw4FdL769vR80gm8ReponploWYztaeUhZdO
         owRKyAr2wK8otOsGINhmJ+SEKD4/Gb/fCrD2liG2+Miwsmv8Kr1oZMYtDvRK46xN/2ra
         mxfJvjN9IfEEIv4PB12KbWyTDLdMw2FdmlSCeaWRmOwZ+VEnjw8ZNqfqbab9um08ieyP
         WD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuCPfzIyv05tOfatcL9ITMClG6MwxVm/+1xlCLORagQOjDvJPbxqb73IpbEy+DrCqbmjlqsjvheRkSD/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDq8R3VKGah29FNazVPHr8897VLCgjI5zQ/1vyPmoF+RAfuD3
	+elKUeKgTL05t69thsjbSXBNy7XW/rpQYROFpEhBfG0lhmPLgPrz
X-Gm-Gg: ASbGncuuPTqVAqV0S8iVn1i8KPjZMocgTGlvYfiK/a9f9zdnjqeik+pl+zdlAdvWK5E
	2bMCSVEcIinSUuPpnyd/bzj8T4qkKBPTgvREOvAtA8b/o5B+UAPxOv/va2NO3cDr4DOVfbdLaIv
	nmlYqg62J9UGPO2syqZkj+sLPkSNKAMS1b/JPzJna0h5Wmli96I8xQnaD0OAg3R8YBmEXFQa3Pi
	9kT7FjrUGNJklW67zZBHHOb7jGat6zwzu9+0Ewh6OxeDfzhqcsTNB6JyxZlWSy1a9geCaiWIsgZ
	IoBVyB0NVg7XdvwhunnXEVaOGm3Fdwztyg==
X-Google-Smtp-Source: AGHT+IFr1cySoaKCX7EeEXfWp3iKzTGJ/lI6Iaj5xm3KEjWwKvAn1t5QCWl37DL6w0m3Y0XokVI9dw==
X-Received: by 2002:a17:903:2a8d:b0:220:eade:d773 with SMTP id d9443c01a7336-2219ff5e60cmr50134045ad.24.1740128264852;
        Fri, 21 Feb 2025 00:57:44 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366242sm132919715ad.87.2025.02.21.00.57.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 00:57:44 -0800 (PST)
From: zihan zhou <15645113830zzh@gmail.com>
To: 15645113830zzh@gmail.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH V1 4/4] sched: add feature PREDICT_NO_PREEMPT
Date: Fri, 21 Feb 2025 16:57:26 +0800
Message-Id: <20250221085725.33943-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250221084437.31284-1-15645113830zzh@gmail.com>
References: <20250221084437.31284-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 4/4 is independent. It is an attempt to use the predict load.

I observed that some tasks were almost finished, but they were preempted
and had to spend more time running.

This task can be identified by load prediction, that is, the load when
enqueue is basically equal to the load when dequeue.

If the se to be preempted is such a task and the pse should have
preempted the se, PREDICT_NO_PREEMPT prevents pse from preempting and
compensates pse (set_next_buddy).

This is a protection for tasks that are executed immediately. If we find
that our prediction fails later, we will resched the se.

It can be said that this is a way to automatically adjust to
SCHED_BATCH, The performance of hackbench has improved a little.

./hackbench -g 8 -l 10000
orig: 2.063s   with PREDICT_NO_PREEMPT: 1.833s
./hackbench -g 16 -l 10000                                        
orig: 3.658s   with PREDICT_NO_PREEMPT: 3.479s

The average latency of cyclictest (with hackbench) has increased, but the
maximum latency is no different.

orig:
I:1000 C: 181852 Min:      4 Act:   59 Avg:  212 Max:   21838
with PREDICT_NO_PREEMPT:
I:1000 C: 181564 Min:      8 Act:   80 Avg:  457 Max:   22989

I think this kind of scheduling protection can't increase the scheduling
delay over 1ms (every tick will check whether the prediction is correct).
And it can improve the overall throughput, which seems acceptable.
Of course, this patch is still experimental, and welcome to put forward
suggestions.

(Seems to predict util better?)

In addition, I found that even if a high load hackbench was hung in
the background, the terminal operation was still very smooth.

Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
---
 kernel/sched/fair.c     | 92 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  4 ++
 2 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d22d47419f79..21bf58a494ba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1258,6 +1258,9 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	resched = update_deadline(cfs_rq, curr);
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	resched |= predict_error_should_resched(curr);
+#endif
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -8884,6 +8887,60 @@ static void set_next_buddy(struct sched_entity *se)
 	}
 }
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+static bool predict_se_will_end_soon(struct sched_entity *se)
+{
+	struct predict_load_data *pldp = se->pldp;
+
+	if (pldp == NULL)
+		return false;
+	if (pldp->predict_load_normalized == NO_PREDICT_LOAD)
+		return false;
+	if (pldp->predict_load_normalized > pldp->load_normalized_when_enqueue)
+		return false;
+	if (se->avg.load_avg >= get_predict_load(se))
+		return false;
+	return true;
+}
+
+void set_in_predict_no_preempt(struct sched_entity *se, bool in_predict_no_preempt)
+{
+	struct predict_load_data *pldp = se->pldp;
+
+	if (pldp == NULL)
+		return;
+	pldp->in_predict_no_preempt = in_predict_no_preempt;
+}
+
+static bool get_in_predict_no_preempt(struct sched_entity *se)
+{
+	struct predict_load_data *pldp = se->pldp;
+
+	if (pldp == NULL)
+		return false;
+	return pldp->in_predict_no_preempt;
+}
+
+static bool predict_right(struct sched_entity *se)
+{
+	struct predict_load_data *pldp = se->pldp;
+
+	if (pldp == NULL)
+		return false;
+	if (pldp->predict_load_normalized == NO_PREDICT_LOAD)
+		return false;
+	if (se->avg.load_avg <= get_predict_load(se))
+		return true;
+	return false;
+}
+
+bool predict_error_should_resched(struct sched_entity *se)
+{
+	return get_in_predict_no_preempt(se) && !predict_right(se);
+}
+
+#endif
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -8893,6 +8950,10 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
+	bool if_best_se;
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	bool predict_no_preempt = false;
+#endif
 
 	if (unlikely(se == pse))
 		return;
@@ -8954,6 +9015,21 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (unlikely(!normal_policy(p->policy)))
 		return;
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	/*
+	 * If If we predict that se will end soon, it's better not to preempt it,
+	 * but wait for it to exit by itself. This is undoubtedly a grievance for
+	 * pse, so if pse should preempt se, we will give it some compensation.
+	 */
+	if (sched_feat(PREDICT_NO_PREEMPT)) {
+		if (predict_error_should_resched(se))
+			goto preempt;
+
+		if (predict_se_will_end_soon(se))
+			predict_no_preempt = true;
+	}
+#endif
+
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 	/*
@@ -8966,10 +9042,18 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (do_preempt_short(cfs_rq, pse, se))
 		cancel_protect_slice(se);
 
-	/*
-	 * If @p has become the most eligible task, force preemption.
-	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if_best_se = (pick_eevdf(cfs_rq) == pse);
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	if (predict_no_preempt) {
+		if (if_best_se && !pse->sched_delayed) {
+			set_next_buddy(pse);
+			set_in_predict_no_preempt(se, true);
+			return;
+		}
+	}
+#endif
+	if (if_best_se)
 		goto preempt;
 
 	return;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f93331..8a78108af835 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -121,3 +121,7 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+SCHED_FEAT(PREDICT_NO_PREEMPT, true)
+#endif
-- 
2.33.0


