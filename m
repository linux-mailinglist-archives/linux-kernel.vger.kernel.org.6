Return-Path: <linux-kernel+bounces-525651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543BAA3F2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD0164B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D36207E1A;
	Fri, 21 Feb 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K4zR8dRf"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC57208961
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136373; cv=none; b=Ayn648xHetsCbHijjDN9p6Ijj3nambQyzfFkIKJbrBuRDIzaqt5xYLImP+J1MbIoAs5l5Ab4DFMG2CU5G/AFT2QS/uoOWF1dBCZJ7Z7kESjPrDW/yHD3QbV9s79dIxz4ilNlQ4V9exLZcyvUmftxSwQt0aOkRiZuxUZ0X8cwtzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136373; c=relaxed/simple;
	bh=n2XIF+litsGuwVQLw+v5xnfU6FW8+elEQ6Z9GZ63Mcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWEcGzcgQUnLL9mX1dMV+O/RR9HFfX90wjl7Z/ONVrgVkZ+m6JGr/R+WJn4fgb+OFG3DyLTEeczkitvm1yuaNkcnv61IAdcE3vfEDenMzUpEW7s00ZEODvd0dtBQUrUtb7uxTyAb6fy/7qvEIgh1589QQluJJjIuy0/XW26UtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K4zR8dRf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d27d490dso4795975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740136370; x=1740741170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS/kC7dQmBwIzQRQbCRLPPtT/HavRaNRpTsagDYMcRE=;
        b=K4zR8dRfouB1VpEhFzejxMzqHrvI742klkn8HU0/wZlHnBLkLWJ7aXMNGEHma8gCsx
         Az7GTxHYw/YVDMdeoJX0X9/YckiqUwvkiKqntSN1U2jfEh9zWcTw4ImQUheFrZgT9UiV
         diiYujqXRdeatMlE4U63Y3TJNqx0Kvm4M+M20ON70zqwLM9RWZbrXN8RHMB6XxTWYzUM
         woMQJ+kQU1ZxgfeU0vPQigcpLkiJBJfXK81jXm++2ANTgwikLgYsyLb0kDyFXwqasHQT
         p9eerx4LWZspb0o3j7D9R2WVidMBWpzvNIAd/ceTrai3Bs/xDvLX+rNvcBW1dkFwGhBn
         0n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136370; x=1740741170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS/kC7dQmBwIzQRQbCRLPPtT/HavRaNRpTsagDYMcRE=;
        b=Fm5D7LedcWBW0Et1l1Bkvg6dVpURmv/wl2f2ZbNXIGjp9OZc1nw+cbnDgHOCs2Byd+
         YeVsOEyt1Tpn/NFZVPOkaze1ugwUdjFB84EXTt6Zc8Gyjwx7YRxsa++S9zq3jiUMOg9K
         Jtf13lsy4tUCFg5l5UBL1D1gFHwlR1/bEDzsQ7/CWEt1yeOcELfNgMT7FsXHKRgwgHyo
         M9ewYRx71+D4aZa0Ho4jnjApfc4I54YRG5twoSmOKX2obnYxA+CwPql+/u2id2OswFyB
         1h9JoMiTVKacYKk4KBzJ+JZ8p3gc0LPDDgYmsNvXCjZP85uvnVga+VA3FmcsG5UmMBmD
         SgGw==
X-Forwarded-Encrypted: i=1; AJvYcCX9LZ4QfW329R5b2gKAX1z5ozd60sfbfoMqcUnWFRNBQuJj2CcODpRfs60HuqUIOVmQaEtrWRqxjw2grzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKDcri8ncq3MLrbqTShNHXYXVPlMDeUKKZu0FRLMGrXfUyNGkJ
	c82IXisuQoNKO8XonphVEDwvM9Oe4AJgui1C/+IV/Es9t92PSoD4p38P7uSawfc=
X-Gm-Gg: ASbGncuq1LiofacsdNnB3VlUuLMp5fRJ8EqxrovpevtFww3SD6twY39itb+n5qCq8Ow
	ipglr5dDl2g0t7bUcLoMo8Bt8Aoa8svn+cyWFZ3SqlfWDJTA2UJtMpNMsW/VWc90le9jo971qMV
	yL+EcoTFTfAY85ecY4lHzHbSYXoIj3zErOAfHf1R+GBv/bQC05+QybvHvhWUMEoYg5XDfzY9xax
	fr8Dy4CEjQCSo7aFKi1iMg2+YYHgGwy1OvMelWGLDvd1J74MMakiT5ptn+WLvSeyAKDVxCF/8+O
	skV3oRRWuytsK0wMSTqcaoS3Kdtym2pQOCprofZjhI7Fp3eRC0yF/ZHLAJYEbsTw
X-Google-Smtp-Source: AGHT+IH0FbzwDddGKmMRaWxNk7OVeZNLz7Jw3i8I1qvlbpliwyyXZY6yfFS7P+/KEn1fJFnHhsh76w==
X-Received: by 2002:a05:6a21:618f:b0:1ee:d7b1:38b5 with SMTP id adf61e73a8af0-1eef3c728admr1953665637.2.1740136370520;
        Fri, 21 Feb 2025 03:12:50 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327237a5efsm10205145b3a.127.2025.02.21.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 03:12:50 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH 1/2] sched/fair: Do not let idle entities preempt others
Date: Fri, 21 Feb 2025 19:12:23 +0800
Message-Id: <20250221111226.64455-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250221111226.64455-1-wuyun.abel@bytedance.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task with SCHED_IDLE policy doesn't preempt others by definition, and
the semantics are intended to be preserved when extending to cgroups
introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").

But current implementation allows idle entities to preempt each other
on wakeup, which seems not behave as expected especially after
commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
so fix this by explicitly skip wakeup preemption for idle entities.

Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..4340178f29b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8778,12 +8778,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	pse_is_idle = se_is_idle(pse);
 
 	/*
-	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
-	 * in the inverse case).
+	 * Preempt an idle entity in favor of a non-idle entity.
 	 */
 	if (cse_is_idle && !pse_is_idle)
 		goto preempt;
-	if (cse_is_idle != pse_is_idle)
+
+	/*
+	 * IDLE entities do not preempt others.
+	 */
+	if (unlikely(pse_is_idle))
 		return;
 
 	/*
-- 
2.37.3


