Return-Path: <linux-kernel+bounces-449553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D39F50AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030471884629
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FEE1F8935;
	Tue, 17 Dec 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuuY8fuc"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C01F8934
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451654; cv=none; b=YEfdvaXUT2RdLn28CQnVYwFaAu2cA6ky+ehjfUXzKo63nvZRSBmk6aeu26vBkeSy3KqXGAmZS5hS/7LaQFpVIgizYQRNrN2j8bV5VW1h/9g5uG3fCh45jSezClFueff95YYs3nUkJBlVWQD1d67L/bWqLSIq8NuhKWF+NigsMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451654; c=relaxed/simple;
	bh=ChB9rkCJalnir+1cQs2OVh2xTgbBQH3OQ1gRFUyeu5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhKv7in6FCiPeN7D1Rlw1Bj//D45GC10QsYhiL67iHlxpxnGRJPNXQU+pxt2uGF92kxxx0NH+ImuqixNEMoB0arDHZZFE4+bZf7b3TQnWP1rC6TH+216UlGup+77YT2gGzHvsz86JMKSXDrrLq9Wd0BE7UnD4kpsNNp5fnl9Q6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tuuY8fuc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a766b475so58080695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451651; x=1735056451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrPmZowSuU/OPzeWslOE/34oeJTgBYavScUT3YyMJo8=;
        b=tuuY8fucclpOSaz8GkWRj9NwwH/PL5pC4oUyQIZvaRzNm/VBot1HpruL6iA4xRvCzV
         vuXYz+unBpsHceiJfustvhSLim8aND//f/QTtpYrUL5pXQP8FzgboCzn9O25Ke3UIY0A
         IXwn8rXdsinCSCScPla4BixYvvT1UbRb9mv3xihnaKe+pSRSoqqUtrLSKVRkxISgTgOB
         ZwgvwX8u2B98jhJYYFzEinOB2h7ahjSRUXOTF/+5a1ovWRtXJUzb6SguQswPbMyvC4X1
         nAEq4tc0MDNMi+4k5rLT5RLv9E50Kik3Dog67CntAOhWUw9s/j0iLHM0XExZTGNR//Iz
         tQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451651; x=1735056451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrPmZowSuU/OPzeWslOE/34oeJTgBYavScUT3YyMJo8=;
        b=LMpVrVOJBB2mALzWhdKXu2Hp3ubv3UkOjYG604+yn+LnvQynhtXHR/X+jnsPaRNnC5
         hsNrMmKSm5FUQLoR2hGCKJ5uiR2taaXh6k4D0AQDEm1OFN05xQ03unavfPVoRjxrvQsj
         GmjbusVUGFDETr4+wNqGNyBl0yM0e6LqU8UriICq31mBultgnEKjg2I2BKKZgIt1AWYv
         c7EtdkY0zZX2PtY6YjQ0sSATCLG5PqItDTO4VGNQZFQpdRDj0aS5JA+tCcZ+X+UG0c18
         r944nOuFEfFuCNrdiHDqxB2TCA/3ubv823a9tlBk0iPbK0GvoLD38GOUbhe9cDp4ZXDX
         I+zA==
X-Forwarded-Encrypted: i=1; AJvYcCU04aGBiJXkd2f9SwxbQfyQS0MTjAMBTkQP/5MlaWk8UZCAk/1fKSrCbQC+vGz7OwveyD34n+OTyZgeWQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVtT856Xm4Yt5aqnyYIYIGcIweS8XcQfoCpZ0mNBrjV8UujBR
	ap9GKXo+umESbiEciH23YjpJRPRwashclBgLDYa6uqsMsoEkcDHuBOroH/vGZa4=
X-Gm-Gg: ASbGncurFcvNffgXYuZBd/pt/Uwkhq10Jk2ZkZxZ/KZydcbyp0nsZaeS/Vgey6a8f6C
	SuVbJ8W0zkRVQy18z9bUv9FrW+ixyIOTZyCSMoEW/1RjUKESYxpsuCaFMHea4N+rMTBXjRAf5To
	0FgzlnumcvNc7FTEXiwxiTArVvG/UgfPZxpWUSgqpAcdn+OC0vxmK8jGHCz4yXCufbq2H4vREAk
	q0BCqp9MIGwd7iV0rb7TdlhqyoxZWepU1OquYrEblEYT9owkIKLI46ABBHxR1CDsQ==
X-Google-Smtp-Source: AGHT+IHJFtSwOUMIGtwqFV8KL7qRzDMmi7hU8fXSsk8NvThtMKigae0XsX3vEZ8XECa7t0FCwcDzrQ==
X-Received: by 2002:a05:600c:5023:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-4362aa9789dmr129842055e9.26.1734451650627;
        Tue, 17 Dec 2024 08:07:30 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:4e5f:e8c8:aade:2d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257176a4sm176739435e9.38.2024.12.17.08.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:07:29 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	pierre.gondois@arm.com,
	christian.loehle@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/7 v2] sched/fair: Filter false overloaded_group case for EAS
Date: Tue, 17 Dec 2024 17:07:14 +0100
Message-ID: <20241217160720.2397239-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217160720.2397239-1-vincent.guittot@linaro.org>
References: <20241217160720.2397239-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With EAS, a group should be set overloaded if at least 1 CPU in the group
is overutilized bit it can happen that a CPU is fully utilized by tasks
because of clamping the compute capacity of the CPU. In such case, the CPU
is not overutilized and as a result should not be set overloaded as well.

group_overloaded being a higher priority than group_misfit, such group can
be selected as the busiest group instead of a group with a mistfit task
and prevents load_balance to select the CPU with the misfit task to pull
the latter on a fitting CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c4ebfc82917..893eb6844642 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9916,6 +9916,7 @@ struct sg_lb_stats {
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
+	unsigned int group_overutilized;	/* At least one CPU is overutilized in the group */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -10148,6 +10149,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 {
+	/*
+	 * With EAS and uclamp, 1 CPU in the group must be overutilized to
+	 * consider the group overloaded.
+	 */
+	if (sched_energy_enabled() && !sgs->group_overutilized)
+		return false;
+
 	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
@@ -10361,8 +10369,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (nr_running > 1)
 			*sg_overloaded = 1;
 
-		if (cpu_overutilized(i))
+		if (cpu_overutilized(i)) {
 			*sg_overutilized = 1;
+			sgs->group_overutilized = 1;
+		}
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
-- 
2.43.0


