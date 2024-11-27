Return-Path: <linux-kernel+bounces-423091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7C9DA2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC212B240A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526C7146580;
	Wed, 27 Nov 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alYw+ENe"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081928EB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691185; cv=none; b=NdEdelMFpTiC/F9JR2ry2m3+sMnKhPpxrW0g3d5oSztPqzBJwDnFqQ2f7dHi3atAwlEF+ibyFoXVT0SuF8ThT87MgKYc0Lw9dXY5JTv+Rrlcbw5sbsBTAOo1TicQYByfSeIMeKmDNhxj5b4k1UX3uq0zohAQQcmmv5+nS5emfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691185; c=relaxed/simple;
	bh=MrTLoKp/nCSJgKhZIaN9jyCjy2an1JoHZ+kZrLdurEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFSfcwt+s5ViXJmlDFKAK4GgmDBymBszs7kFxFGVbu2JIlrNQir6HOsv2lfPXKA/xeOkPPa4WYStIxIXaO4+dFRhRwig+takUhtGI/1DnEJrpI0xosCrcOmJnI3ZveCq3BXKACnf0YygonqXdAhOCMlwLua1d4ZIN8jB41NbWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alYw+ENe; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so5440104a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732691183; x=1733295983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xihi9GYJ+aBC94bbCyQu86UWowIQKbvf9SGp5q9iNC4=;
        b=alYw+ENegEzR1R4Bui/W8qSvjyEEYg8bOu9QsFNe71utW+/rAmiZQRFVxjIbc5LR+N
         p5gBwuxoecBeOhgRoDk1N7n1JkWO+m3HPiGMvZhz6SAcznVytjKZX5sXGMNo+EAiMH2f
         2Prurg/pAvnG2q+J3hDyH6VVQmOCOadMrk+2klps7hDkxlKdikjf2Ks2hNQShdMfmjQk
         MwTb+51cmA9Dfb9KqCNJwCZHCESK57mtktlEDk6m18drPAoSKG6hQd260+EYS8pce/BR
         /pTkxGj2CoielS/rQoOi4a1mV1Ls3Nx3YISVVUcT4UAw+28r1VcZ7hjyyetCsHMH2Dy2
         umxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691183; x=1733295983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xihi9GYJ+aBC94bbCyQu86UWowIQKbvf9SGp5q9iNC4=;
        b=VBd3GYpkVdWFqSe4buQVG8sl8PTFPemaRWYWBXl+YRSnV0KE6WEeDpynC3JnLcqVlp
         fjHzcjq++Wnomk+DERGbehd6UciezbidIV+zltcnEvAfRbHD6ZQ+P+wfx3wMttQqsdIo
         6szPDl5jNQ8DKQZkHYDVuVH3fl2pkaPbeXUDg0dpLNRMRLkA64YSj3OpN2v1GpiOJUyX
         xv29sv9v6LbYHsZkqKU1mZJqhr94NxDkYJYtJMqecZMAU5Dwo9GalOrXn6A8miLCj4ow
         nOFyYiL5tteWT/7Gu1JFeVyvrXDiDHjtF2cr/0P2iCYwOdQWaLCo032ssQCLIeXSGntN
         Fu0w==
X-Forwarded-Encrypted: i=1; AJvYcCVPRXIQGvdjK32hq6c5aeYTxEmVm+9adYHakt2hUT7Hyo3G+0PjP4vjHowVq08UqUn+gO4D1r642HE2L1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+DjQBzlpZvr1gEuauJ/f4uS1CyD6iETzYvtKMcUOcspht2FK
	OSizGWNg81oq0ft/gXI1o5s1q4GhY1Rpc4ngujAXM7HAfVNFlAAvhCAQqW/qnj0Geyfr
X-Gm-Gg: ASbGncvSW9mStISwH+fWbSSSABIlRMUkt6zSCHHHn6LtJ+p0lDCr2BfkkYgZtdRRsb7
	0DIGw0cYQAXLq6ptc60ZV35cwuhZteLMXpP6Xy4QPnAV6rVmOmo2xbkbZYCaBDfKlWysJthXWCs
	kptE2IfDmhFQojf/9nOP5BxJGKlulGbjsfc+ZMDvnJNb8yvAbXhSq5JUFlv+grn9tKPxLJLQGs3
	ZE/FsoKwMwZzoQl1ZiJokamvq5ulh0TJ0wJLxCnz1rc6K8aWQ==
X-Google-Smtp-Source: AGHT+IFBz/Jlr5SUs6gB0bYGDfK+BCdfZbQP/GDGqtwt4j3Vx9OYMTQyHe9sz9wipB1CigTpT3zDrA==
X-Received: by 2002:a17:90b:3c12:b0:2ea:8c5c:ff6c with SMTP id 98e67ed59e1d1-2ee097bf2damr2335248a91.23.1732691183269;
        Tue, 26 Nov 2024 23:06:23 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa66ebcsm747563a91.30.2024.11.26.23.06.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Nov 2024 23:06:22 -0800 (PST)
From: zhouzihan30 <15645113830zzh@gmail.com>
X-Google-Original-From: zhouzihan30 <zhouzihan30@jd.com>
To: peterz@infradead.org
Cc: 15645113830zzh@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yaozhenguo@jd.com,
	zhouzihan30@jd.com
Subject: Re: [PATCH] sched: Forward deadline for early tick
Date: Wed, 27 Nov 2024 15:05:35 +0800
Message-Id: <20241127070534.62903-1-zhouzihan30@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241126103513.GK38837@noisy.programming.kicks-ass.net>
References: <20241126103513.GK38837@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: zhouzihan <zhouzihan30@jd.com>

Thank you very much for your reply, which has brought me lots
 of thoughts.

I have reconsidered this issue and believe that the root cause is that
 the kernel is difficult and unnecessary to implement an ideal eevdf
 due to real hardware:
for example,
an ideal eevdf may bring frequent switching, its cost makes kernel can't
 really do it.

So I see that the kernel has a very concise and clever implementation:
 update_deadline, which allows each task to use up the request size
 as much as possible in one go.

Here, the kernel has actually slightly violated eevdf: we are no longer
 concerned about whether a task is eligible for the time being.

In the prev patch, it was mentioned that due to tick errors, some tasks
 run longer than requested. So if we can do this: when a task vruntime
 approaches the deadline, we check if the task is eligible.
If it is eligible, we follow the previous logic and do not schedule it.
However, if it is ineligible, we schedule it because eevdf has the
 responsibility to not exec ineligible task.

In other words, the kernel has given the task a "benefit" based on the
 actual situation, and we still have the right to revoke this benefit.

In this way, it actually brings the kernel closer to an ideal eevdf,
and at the same time, your reply made me realize my mistake:
The deadline update should be updated using the following function,
which is more reasonable:
    vd_i += r_i / w_i
By using it, our scheduler is still fair,
 and each task can obtain its own time according to its weight.

About tolerance, I think min(vslice/128, tick/2) is better,
as your reply, vslice maybe too big, so use it.

However, there is still a new issue here:
If a se 1 terminates its deadline prematurely due to ineligible,
and then a se 2 runs, after the end of the run,
se 1 becomes eligible, but its deadline has already been pushed back,
which is not earliest eligible,
so se 1 can't run. This seems to not comply with eevdf specifications.

But I think this is acceptable. In the past, the logic causes a task to
 run an extra tick (ms), which means other tasks have to wait for an
 extra tick. Now, a task maybe run less time (us), but it will be
 compensated for in the next scheduling. In terms of overall accuracy,
 I think it has improved.

By the way, we may try to solve this by delaying the deadline update,
which means we schedule a task but not update its deadline,
util next exec it.
I am not sure if it is necessary to implement such complex logic here.
I think it is actually unnecessary,
because the ideal eevdf may not be suitable for the kernel.
It is no need to spend so much to solve the error of few time.
If there is a truly completely accurate system, it should not have
 tick error, and just closes the FORWARD_DEADLINE feature.
Of course, if you think it is necessary, I am willing try to implement it.

Signed-off-by: zhouzihan30 <zhouzihan30@jd.com>
---
 kernel/sched/fair.c     | 41 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/features.h |  7 +++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d16c8545c71..e6e58c7d6d4c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1006,8 +1006,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  */
 static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if ((s64)(se->vruntime - se->deadline) < 0)
-		return false;
+
+	u64 vslice;
+	u64 tolerance = 0;
+	u64 next_deadline;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -1016,11 +1018,42 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (!se->custom_slice)
 		se->slice = sysctl_sched_base_slice;
+	vslice = calc_delta_fair(se->slice, se);
+
+	next_deadline = se->vruntime + vslice;
+
+	if (sched_feat(FORWARD_DEADLINE))
+		tolerance = min(vslice>>7, TICK_NSEC/2);
+
+	if ((s64)(se->vruntime + tolerance - se->deadline) < 0)
+		return false;
 
 	/*
-	 * EEVDF: vd_i = ve_i + r_i / w_i
+	 * when se->vruntime + tolerance - se->deadline >= 0
+	 * but se->vruntime - se->deadline < 0,
+	 * there is two case: if entity is eligible?
+	 * if entity is not eligible, we don't need wait deadline, because
+	 * eevdf don't guarantee
+	 * an ineligible entity can exec its request time in one go.
+	 * but when entity eligible, just let it run, which is the
+	 * same processing logic as before.
 	 */
-	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+
+	if (sched_feat(FORWARD_DEADLINE) && (s64)(se->vruntime - se->deadline) < 0) {
+		if (entity_eligible(cfs_rq, se)) {
+			return false;
+		} else {
+			/*
+			 * in this case, entity's request size does not use light，
+			 * but considering it is not eligible, we don't need exec it.
+			 * and we let vd_i += r_i / w_i, make scheduler fairness.
+			 */
+			next_deadline = se->deadline + vslice;
+		}
+	}
+
+
+	se->deadline = next_deadline;
 
 	/*
 	 * The task has consumed its request, reschedule.
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 290874079f60..5c74deec7209 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -24,6 +24,13 @@ SCHED_FEAT(RUN_TO_PARITY, true)
  */
 SCHED_FEAT(PREEMPT_SHORT, true)
 
+/*
+ * For some cases where the tick is faster than expected,
+ * move the deadline forward
+ */
+SCHED_FEAT(FORWARD_DEADLINE, true)
+
+
 /*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
-- 
2.39.3 (Apple Git-146)


