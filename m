Return-Path: <linux-kernel+bounces-436827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152799E8B67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D529B1885B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149E214817;
	Mon,  9 Dec 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlC6cO4a"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3822147F6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724958; cv=none; b=C+zrAQ1xFaBjHeNHsZ7iADOG1o1xwl60YC9P784YDRFsGgjRjBNHGOOkGVWPJPtvt8YXM0jgjDacCDpmI2d+jaP8no3WmZ91Uo14El7caCsISaDVluAPK7FNM8bKhBukPy1HuZayVjb7443VdUbdtzVlbTrC7r7DImj698NGF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724958; c=relaxed/simple;
	bh=5Z8mZYF8p+Smo6Mg7rjZn0niYCgmWyYNROi2qqxdffk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTb5hQl/xZJvU5wVd49XFVggAEBXJiRm+Eqx26kVZWIkhDrpHfzjJbkM2bplhZINrds5+Ib/0rEMg/A0Q7z0AHJVMyvnFuV/JFMYZ4BeWDU78QHlLMgHhLsGOQORixtirS+afpMR5Rk3CZYn/KJWxYunaEIUDL9finK86YUpgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlC6cO4a; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216426b0865so6038115ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724956; x=1734329756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTjz7Q36fm+eHR0LrCJEPj1whyTvpK9Y0P7GSkq40Sk=;
        b=YlC6cO4aIdlnykct+80WCS8Lg5IDKeNkV5yE76JbUvaB7+dAG3BKCmP7FyOBd9Ba1X
         v/9QW+QXcL8/QUdnOHCK+nCteL4DvaPeBAyryj5olWUe2G/wtMEtB7X02Zyu7ro0mmLA
         bGsTWRz/4nX8qRH7HPWl6hplH71F8haY/4bh9tQEo0WRFPOqaCy7xWQUKZVDVkU2o/oP
         8ImtSi5BdN8S77V6i9g8rvlAfl43YtOwifVH2jjxXfr8uNPok03/SEt0GpZrWVhpxF3K
         25arbphA5acI8wO8ijhMm3sICm3pLt93CQQYWpAa1iBp93C7XQ2glgDr3coz5x3IZVTw
         3DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724956; x=1734329756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTjz7Q36fm+eHR0LrCJEPj1whyTvpK9Y0P7GSkq40Sk=;
        b=Wu6u58+aylHxTQVDhxdhejIKWmi3QaO5oxIQu2tAwIJz10j/pCVQUiq1eXBdl9DgV5
         VcJEjqv4QCfNyCe9mJzu8WRmi8N9wINPGPA9Fs08LFg6fH3ndHQcVGjKx/CqXLDCYJAh
         EwmpQQGBn1ENl+WnWGvmz1zw7TLNjxnxEJzJYPZVtHc5euaoBH5DmLMx2WutOyIYL2sb
         Zu/SBNcEN5kMx6aOu2LIzgTsWP4DHVmZ5gsTWsK5RSxZhNIrqU4yW66iF5PDGxSQ/1et
         kSGw/KGnc3Uy8ZA1Py4kfUFG1DLQ1YMolf0iQYH56ZZD4W6IDF8kEWVsuTlXxgGfVcg8
         lFRg==
X-Forwarded-Encrypted: i=1; AJvYcCUTkfuCesNRp/IDjlYEd6Fm/R8GhGXbpLvYHwIFrBfPtqS/yA1w6iNRNnN4g3y64Q+2jK9Wr8qDG//jhPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZf0aSp7VDNHduQ13SEEIHTwFN7JDfbcA3HPtP4iAX3fq0wZQ
	0OLn3nK28DRGL2+9mgVu0KfivPvbq8U5TPte0ISiyexwmSLTfBUB
X-Gm-Gg: ASbGncvPmDmDCkw+/DvQ3+ZZrKjrElGp03btRYbwtoPsbVmHbT6K7yuTci4y/QCEkp5
	Azqd/pnvtL4uPTDVCW7meZa7qs6ZWlCn01rPQ4MmkMMt4ifVWUk1fjKUgFRMTksP2+EEjs+Kd/+
	uaWFdWYrxafJWmSKSimve27xG61+gsaJcegAi4neMzQgBEpn4vNbmOAJn7tOmnDJ9DGguZNVtBq
	09K0DS5hVkEteSIXDlZ5m/4sZt2lJrf1kLH2pJzOgbHp2q7X/914qydXoz8rGv8oGmxIYFWzAyd
	JoKSSg==
X-Google-Smtp-Source: AGHT+IGFnKTrwnNVlNBi0pRWyTxWgXXUXcq6GWbamGHw2JM+Z0reYdmXkftL6UEPzYa40jTFM969+w==
X-Received: by 2002:a17:903:2a8b:b0:215:ba2b:cd51 with SMTP id d9443c01a7336-21614d3ace3mr179685945ad.15.1733724956327;
        Sun, 08 Dec 2024 22:15:56 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0913bsm65491515ad.185.2024.12.08.22.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:15:56 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] sched_ext: Manage the validity of scx_rq_clock
Date: Mon,  9 Dec 2024 15:15:28 +0900
Message-ID: <20241209061531.257531-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209061531.257531-1-changwoo@igalia.com>
References: <20241209061531.257531-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An rq clock becomes valid when it is updated using update_rq_clock()
and invalidated when the rq is unlocked using rq_unpin_lock().

Let's suppose the following timeline in the scheduler core:

   T1. rq_lock(rq)
   T2. update_rq_clock(rq)
   T3. a sched_ext BPF operation
   T4. rq_unlock(rq)
   T5. a sched_ext BPF operation
   T6. rq_lock(rq)
   T7. update_rq_clock(rq)

For [T2, T4), we consider that rq clock is valid (SCX_RQ_CLK_VALID is
set), so scx_bpf_now_ns() calls during [T2, T4) (including T3) will
return the rq clock updated at T2. For duration [T4, T7), when a BPF
scheduler can still call scx_bpf_now_ns() (T5), we consider the rq clock
is invalid (SCX_RQ_CLK_VALID is unset at T4). So when calling
scx_bpf_now_ns() at T5, we will return a fresh clock value by calling
sched_clock() internally.

One example of calling scx_bpf_now_ns(), when the rq clock is invalid
(like T5), is in scx_central [1]. The scx_central scheduler uses a BPF
timer for preemptive scheduling. In every msec, the timer callback checks
if the currently running tasks exceed their timeslice. At the beginning of
the BPF timer callback (central_timerfn in scx_central.bpf.c), scx_central
gets the current time. When the BPF timer callback runs, the rq clock could
be invalid, the same as T5. In this case, scx_bpf_now_ns() returns a fresh
clock value rather than returning the old one (T2).

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_central.bpf.c

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/core.c  | 6 +++++-
 kernel/sched/sched.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..ab8015c8cab4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -789,6 +789,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
+	u64 clock;
 
 	lockdep_assert_rq_held(rq);
 
@@ -800,11 +801,14 @@ void update_rq_clock(struct rq *rq)
 		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |= RQCF_UPDATED;
 #endif
+	clock = sched_clock_cpu(cpu_of(rq));
+	scx_rq_clock_update(rq, clock);
 
-	delta = sched_clock_cpu(cpu_of(rq)) - rq->clock;
+	delta = clock - rq->clock;
 	if (delta < 0)
 		return;
 	rq->clock += delta;
+
 	update_rq_clock_task(rq, delta);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7e71d8685fcc..b9d7c638ec60 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1781,7 +1781,7 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 	if (rq->clock_update_flags > RQCF_ACT_SKIP)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
-
+	scx_rq_clock_stale(rq);
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
-- 
2.47.1


