Return-Path: <linux-kernel+bounces-448064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19599F3A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1737A4405
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF81D54EF;
	Mon, 16 Dec 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GFS9j/hU"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B821D1730
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379998; cv=none; b=uqy4/BSxX0YrF2HTPmHjkBcvsSVhnjC+D0Rsu0hI6r7eFnfuyowZkhTWKvTHqeng06Pn2lskvk6In0rPRRDwdbSUotYp8DuoH5RUllGxHp2A9CrXLMq/6Scer1tgUAYCntaS+KGkBSJx2/6kCbItPZ9G9RmL2N5/F3xvVBzfEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379998; c=relaxed/simple;
	bh=RYk23+XCY5BrG85isbX7d7sB012sPIA2IgncWgxuiqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPWI3aGFPTPm9MKJ4qg27V0jpyRoHMLBAssaZ0iff7ns/tPb7QLCEv8YISR6qY80EdBu+mIQoNniLr5mVVPMwpolwgKdBxR/HDPWI5qEW9G61UoRYEswZZnBa08ZsJMQzWvVJgT941eMoM8akDRWbEq2PwYdq2c4Wo+pARJpYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GFS9j/hU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso24238215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379995; x=1734984795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWohpvsaidJAImWnCCb6nIgTAJEp6TGh7j1uXezpKLk=;
        b=GFS9j/hUxZi7Nts6eGzuXbKr+jHXI/SNhfH5FkHHdePGaYX0hcwH5QGIlcAK7jNe7b
         I0chkwGBOiqx/JKMEEUIP5oNweEhKPXF1K0JceG8GcS5wj1PIDHUKTRaYZf7VSZMs523
         LQRJcs8aCSjR7MK0Nau2gnzqc6AEZMT2StQrXWaTOymXQf43RfZB/jTF0ywQkJASRLx7
         tOuAEHkrziM8JqN7cC/r9fJAdxZ1K4HP9bV5MuTQJV1Q1fWxfdseOSbG+ybaiGIqXfAu
         5tJSPTTXhF8JW2tKGfQ08nPpgLy+DeUc+/7C+suQF6LnCi30fWKVWv6BTRYPFZxjeshG
         qt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379995; x=1734984795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWohpvsaidJAImWnCCb6nIgTAJEp6TGh7j1uXezpKLk=;
        b=wQ+/qrtRQfGr4ykWaL1NaVI0BbIjCoz5XEkHs6XEPm3nwSalgtqOl/DCHrHjLz4t2H
         k49miuVDIAYZk6HpiAE7JkpgEkie2h5KAOdGKH+bm1PU+FvMu4VZXP3mXqH5zLMeJJdr
         m/XQGVsdeuzJvbr0wEPk2+MFajVBEc67m57VBv+cUIuh1EUCsnFHZ6FBeChg+WWQDpSh
         qdikdyXsijeHXBzlRAdzPjzlmq3V3tDVU2myF1eifJ1nnkjixAodl3oo9X08OlG4zF9P
         BH/gFLClVGfDZSEgMWongG5A+RzEgZMIRAUMhha9xGJIEWNzDVRCRn7nB7L6FwwFyBui
         idqw==
X-Forwarded-Encrypted: i=1; AJvYcCVXMw+4MndmjLz9sdVJs+lkxfI8n3RmHK9ATHCtCR0aAtEHFPUOvT4dYWolm/ySfFiGPVE+mv4spxpcYTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RLLl4i4+uECjHsrkIbsKqGs5CDe2EZwynpa5bSh1Plb0b7ki
	rjM/Jpin447QwyWbtF9OsE1Y73fGZIlhe03rH92Z5w+oI+uxu3EHYyLGqcad/FA=
X-Gm-Gg: ASbGnctIOUY/m1I44CzPSk7touPCPq016A2uSTovyk4AcSu7j3vHFgacDUhyMvOm1RK
	UMKfDJsrpos7XbyMyeLOyA+99ufsQczM0cLWn8Z2uD2Mh7QIt2OsZVi8vM4ghF5UxJUThxVJsel
	b/YiNZYRro89aRyxGQfHwe8FaJ+0iVHWVHHJxPyfjoWpEQZVnUWsYCuEk4oPGczI8Pbef/exlL1
	H9zIes8CLdA5vLqtiMuD4XeJ7PTKpb2srhkaNTE5NKQyj7pU4GVwU+5dQ==
X-Google-Smtp-Source: AGHT+IHJNXDQlYkb8clBBC3f+NAsF9zFsTHuTzAExcEQsQ+x/QllJKlwA0cXeJSh82Dvjt73cqZ58g==
X-Received: by 2002:a05:600c:1c1c:b0:434:f953:eed with SMTP id 5b1f17b1804b1-4362aab0ec4mr135894205e9.30.1734379994894;
        Mon, 16 Dec 2024 12:13:14 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:14 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 3/9] sched: Always initialize rt_rq's task_group
Date: Mon, 16 Dec 2024 21:12:59 +0100
Message-ID: <20241216201305.19761-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rt_rq->tg may be NULL which denotes the root task_group.
Store the pointer to root_task_group directly so that callers may use
rt_rq->tg homogenously.

root_task_group exists always with CONFIG_CGROUPS_SCHED,
CONFIG_RT_GROUP_SCHED depends on that.

This changes root level rt_rq's default limit from infinity to the
value of (originally) global RT throttling.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c    | 7 ++-----
 kernel/sched/sched.h | 2 ++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1940301c40f7d..41fed8865cb09 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -89,6 +89,7 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	rt_rq->rt_throttled = 0;
 	rt_rq->rt_runtime = 0;
 	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
+	rt_rq->tg = &root_task_group;
 #endif
 }
 
@@ -484,9 +485,6 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
 {
-	if (!rt_rq->tg)
-		return RUNTIME_INF;
-
 	return rt_rq->rt_runtime;
 }
 
@@ -1156,8 +1154,7 @@ inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	if (rt_se_boosted(rt_se))
 		rt_rq->rt_nr_boosted++;
 
-	if (rt_rq->tg)
-		start_rt_bandwidth(&rt_rq->tg->rt_bandwidth);
+	start_rt_bandwidth(&rt_rq->tg->rt_bandwidth);
 }
 
 static void
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645fc..38325bd32a0e0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -820,6 +820,8 @@ struct rt_rq {
 	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
+#endif
+#ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg;
 #endif
 };
-- 
2.47.1


