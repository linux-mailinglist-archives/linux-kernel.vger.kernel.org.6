Return-Path: <linux-kernel+bounces-561795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F40A6165D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B79519C3491
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A1203713;
	Fri, 14 Mar 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfAyqtZJ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C24202F67
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970182; cv=none; b=ggSDTLPyAhv2hqmOD3ScVt+13QLU7HxmBRMeuLqxLWaLJAbPUc/YwdGPJ/Otiywe7oFBodrbY1MWmUwKBqnZvwVvvTqTKMh0v5S8pI6cE7/IqsMgKZ29arS2i6XL056wMF+tbqV4C3DDcu9IQ7KIGisxMW21lDLNAYCzwpO2uvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970182; c=relaxed/simple;
	bh=AQWMzvVK8cK9k7Epz3rAFhaFaIaia/otULNIrgfc61Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPM8M8Z96OYZyECd5ap5W1CmRdKaH8Sa37lrPuaDyeRuoeYkxNEP2HP32UREArB1olA+TmTFUHQNyFoubyBb4TDNhhJwNmcjNsfUzpyZxkGVjAnQFyvKUQUUKga7yjqPKMM07s9+RmPOaAMg+vibyhIjJOlqJe+WHtMzDh6dqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DfAyqtZJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso2265021f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970178; x=1742574978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcF4yJAbrfhrGVD+YO2tfOQrmlU39QTS3nRDjBtarC8=;
        b=DfAyqtZJu+wMuLkLOlZN25e9N33KOm7BKP/M/wdHgRwcUyyXadHVSSu10JJ+EEQXvt
         daPLSTyZAFAX1HrAeLSwPLLkdw27AVLqDEdD87HvzE2t0rhaqh+OyScxqw9+ovNPJqUI
         KFONtaSXHC1Ll0gp15n0dzpw75YFFDYWtKJYtQmFCAr5GZaQzbTjkk+pIanA5pJkAHFP
         S+IGj0Q7l7HehHjSkz8sAogLackRgrIKh5a/0xLlZv5ExL52CzIjY3kc2OIO+PH6hPQI
         lNliww/cWph2pNKG+FVk+XkbblmI+hLlflK45dgjvG21l5Zrq1JSocyP1dVw0LHHTc8w
         A8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970178; x=1742574978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcF4yJAbrfhrGVD+YO2tfOQrmlU39QTS3nRDjBtarC8=;
        b=CaIf2SKa1LdGKGGMluhVy31zTOMBTjryWvYk0DuTr6qExtdMvMwNm4D88NQwxQxGiA
         GUBN7aFYU1berKcl+EmXvhxjNkudsXgv39N4D2gl9eIFxxxB5169i9woHzY5tnoKNopL
         55z1EMHMAQFuggCYxCjNdvXpxi/So4rPETz2xki1hIW3pnQHRToz8NOkxhfkAlGsPASr
         BZnvU7JEsQZK55pI6TAySjq+TqxYPuBTCjs+vaHIzXcG069i7TPALpkHguYb6QDM5cbx
         heJyDlQwGZN6zz1L4tiMVokDTkywRA0+5t5ix9AyBBLcKA1oaov4LWjseD63BF4mQUWQ
         jF5g==
X-Forwarded-Encrypted: i=1; AJvYcCUuboDQf/XJUg1d+sq2VJDEm6du52F1FDNpnvPemlx9cZHy6Ie/bls5wuJveAEAnxSmqVYntr1wstNS8is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VOP6wrbb0V6wQrfnYJN6fyEcOnnApzal2cGcgBj6co5hNMml
	5cWEk5nAddOfHvI8/qOMZEc8/yOzGxJTAvXIw6Pcnb2F43sdFoRHANcxsuillxk=
X-Gm-Gg: ASbGncvoBDrLus92TNfZ0PMo6CSn3ReXtoGZK/Mbrrdb9Je2ENeCfSl8M792rv5ewzs
	Ky+FAwfnxhR8eT/klpQyJx4OobKbmog0VKNV5OKehgUnc9kOgmEbyz8n2pvy/g8oZaO9mf/jP5B
	RljGVx3lSrNkXg177i2GQ0AL6hI2UOge831ib690IkT8Pdf8IUbrHUDC1w32JdBKX7X11M+EJiF
	MzgECoGwPKEhOWN+cejPixHLvw9TbOAyYXxUPnFsSxIZQtBXrdm6QktUqx2/ZERaorbpH/t0OFD
	YTFCF/viaksKE1H7uBaW6Ocp8hrCgXAKkpVwLb6kzybRbOyPOMdZ
X-Google-Smtp-Source: AGHT+IE6dPkTW1b75/6adxw1FQ30TXIVwRMkleReJ18sF6NIv87zraP01nVtN/NbEL6PSZwUNp3/bA==
X-Received: by 2002:a05:6000:18a9:b0:38d:e0a9:7e5e with SMTP id ffacd0b85a97d-395b70b6f9cmr7689449f8f.6.1741970178493;
        Fri, 14 Mar 2025 09:36:18 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:329b:9a6:20f4:3754])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm6072925f8f.78.2025.03.14.09.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:17 -0700 (PDT)
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
Subject: [PATCH 1/7 v6] sched/fair: Filter false overloaded_group case for EAS
Date: Fri, 14 Mar 2025 17:36:08 +0100
Message-ID: <20250314163614.1356125-2-vincent.guittot@linaro.org>
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

With EAS, a group should be set overloaded if at least 1 CPU in the group
is overutilized but it can happen that a CPU is fully utilized by tasks
because of clamping the compute capacity of the CPU. In such case, the CPU
is not overutilized and as a result should not be set overloaded as well.

group_overloaded being a higher priority than group_misfit, such group can
be selected as the busiest group instead of a group with a mistfit task
and prevents load_balance to select the CPU with the misfit task to pull
the latter on a fitting CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9dafb374d76d..2eba6258a518 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9933,6 +9933,7 @@ struct sg_lb_stats {
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
+	unsigned int group_overutilized;	/* At least one CPU is overutilized in the group */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -10165,6 +10166,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
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
 
@@ -10348,14 +10356,12 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
  * @sg_overloaded: sched_group is overloaded
- * @sg_overutilized: sched_group is overutilized
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
-				      bool *sg_overloaded,
-				      bool *sg_overutilized)
+				      bool *sg_overloaded)
 {
 	int i, nr_running, local_group, sd_flags = env->sd->flags;
 	bool balancing_at_rd = !env->sd->parent;
@@ -10377,7 +10383,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_nr_running += nr_running;
 
 		if (cpu_overutilized(i))
-			*sg_overutilized = 1;
+			sgs->group_overutilized = 1;
 
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
@@ -11048,13 +11054,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded);
 
 		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
 		}
 
+		sg_overutilized |= sgs->group_overutilized;
+
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
-- 
2.43.0


