Return-Path: <linux-kernel+bounces-554750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8DA59BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322101889F04
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE707232792;
	Mon, 10 Mar 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PuJc+E8W"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F176230D3D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626305; cv=none; b=WUniHv3ZMY797C1GqyasK4L4yqRxzFwyntBKQdlnuIUTOC4hVDkbA5oWEVa6BLT4D+OyYdDPj/Zt4lnGYAkoEU6LSFlQZ3A+CtTi4S8Napjp7ervdzRdMykDyJR/hW6L0UA6RorzLpKPbtgQhpsgS4KSvwaM8gxSpoPVFp8mT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626305; c=relaxed/simple;
	bh=xj17MFlJulz5p0jdPBcalKowBvoJHFJ9677WrwPHzAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeQ+AyJWDkda+y4w33I03xqSMNVaE0CosfuFYaY2rfI8w7j2nZ+7wY3SVCuguEfKirQ22gSw3LWbkj99SWyLxczkaEbirAXbaFki4+ZhQhNpumoEoxJKjBERs7AgzwryE7dbmC4SvfrGY04qh9/g9aOZ7iMQxzHBi7uJSp7cs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PuJc+E8W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39140bd6317so1351189f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626301; x=1742231101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=friAMnSjLY0+SGaIxPPMR2wFL3NaVBwarbQhTRSR7xY=;
        b=PuJc+E8WO4yuf+rBRsFIP0kbzTY/NgODnnaCFZ4qAIObzmcLV69aNSeU5HhqbJz5bX
         ALk2iIbOurCjtiqmIGc2XfRElkZPAY73NhFR52K1OhzVsn5mzuoSMzuDqwWl29xCJ5jI
         J4b4C04cgxorPSG93n5w3jQFNIKjESM5P9Oh4Z4S9UekCP3nQFLiRMJwDnAQlFacCyGH
         /rDA6JQ8dLjQ5bXgUGWGPZU7AZ+Dq3DXVRdharTb8SDI1DvAqWt8scu6VCEtpra1b0BK
         IwpQJmwqjwCc5AMDLTzQDevNE1xzp+Xj9On3EzBy08vAo1KNuta0IHbBr63LmDH1Rf+S
         f/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626301; x=1742231101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=friAMnSjLY0+SGaIxPPMR2wFL3NaVBwarbQhTRSR7xY=;
        b=tRl0EGowfFJwOdf1LD5njGcM5aL/q56CNcnVLtLPLgyZMT0XsvkPYT/vwqly3fejWK
         zPAdaRQO3QnWSu3OACdy2jl0nFVwKf5K8HThFi5YaNx5kmixeqclGYC+Ic50cqZZwtrG
         ApurewE7G6At3fJ+FEZAjrPo5J9Dqfe21wz49lx/gPlPFviXoFf5q9vmrEVoH6K7kTpv
         kmitgtA4YyteAfV0Ld71dPeXOFvtXqBvgbf3U+ZWaFRbCiVw4+KSrDmDzaGR3TFcIqlJ
         ckPHkBpaHGRfADAiQsnPxEd7day2pZNrcsmZa7v4kpzHQdJX/6+FDm/+XpUhFWTPs1td
         vAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVUMoN+FpCNj4NaocqsVJxDGRs+gdGY+X7kQT9hFpaGxWbt5dFabKmFHKpKtK9dltjcjYf2pdk7SYzmXC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCo+UnRZ4h2IQrN8L2HbE7qF8tj4lRcRtUIDn9ZIo4tJCB6qg
	oyqk50EBRy2HPdzdl3+T94Ah6Fi6ozdDWWneXKwacMTErvywnwSqf+6yV7dGgdc=
X-Gm-Gg: ASbGncvuxzvUH/4D5UssrVWlG49qLVQQLFvJh53xD7STho7P5oLb2nrjKle14Btz+nY
	3iA/SSCONKP027izi/2vqwxL8WAvN0xkoSekTaYzJDg12M8Yxk/LW+5M0eQBCnu84e238iSFqI2
	qdmhAlPLFzAwag5fRTu98JUpgplfbsVOvRzJZn3jfwOpTTboB5O5aXy7lfvbo7zAoHbgU6BEZBX
	ptQyADadwU0P5pAVunQC5NM/laWv+t+jo1z+twdyJxakc1DxsZsVIQAwpJXQgmRYyGfOY0/Iyqa
	6NoLc4TrxIiWGQh1OsrBbTr/ysN8yJKKYlyBFBd+NrU08rM=
X-Google-Smtp-Source: AGHT+IGgGIo4ggCkxmgbFu54U8KT/dvev04XZ2xtuqxgDeQn/qpnBz4ws/SgLAqL7IKChTe7TcyYVw==
X-Received: by 2002:a05:6000:1842:b0:391:2e97:577a with SMTP id ffacd0b85a97d-39132de2e83mr8487685f8f.55.1741626301487;
        Mon, 10 Mar 2025 10:05:01 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:01 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 03/10] sched: Always initialize rt_rq's task_group
Date: Mon, 10 Mar 2025 18:04:35 +0100
Message-ID: <20250310170442.504716-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
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
index 17b1fd0bac1d9..dabb26b438e88 100644
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
index 38e0e323dda26..4453e79ff65a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -827,6 +827,8 @@ struct rt_rq {
 	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
+#endif
+#ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg;
 #endif
 };
-- 
2.48.1


