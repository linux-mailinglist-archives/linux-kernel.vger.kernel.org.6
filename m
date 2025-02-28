Return-Path: <linux-kernel+bounces-538594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46BA49AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2FC1898500
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4B26D5D0;
	Fri, 28 Feb 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1vKNXhm"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB32686A0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750008; cv=none; b=J+BOAlWuXQYALB1EMNZDFg6/hPq017FVqmArdViIyWIIsQhqm5VRPmi3vJ/6I4bvP7zpull9KNLG3G/yy+XPMLFJ2s9TKGhgkhSpzgnqQdL8+b/JSVgg0nw2MSDciSz2wEDcMW/u5q2PihdQy9Rth3xBwzx2TuIr/wRkbFkx8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750008; c=relaxed/simple;
	bh=l6s2K8nye6CHRRRLfb5EYZPGV2XdU8BZngWM9TLpnUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqIPwst3JIj195iTI/PtV+GBrBXFQs2DCeNUCxUB72V8C5DnvoqIQp4ODCrMoFebc72l0m+7KVsixAjtu/NMGHxtgej0oeW5jyEN8Pl+6pA7+qzkQy3ImIirQwM03MX879C7CfFSkHzXR7UQUn0M3Wx5APz8EVSEQVJqn7j+fdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1vKNXhm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399d14334aso19911225e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740750005; x=1741354805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7Qe15dxMfjDnNi0r7cCotARJKXbVAoEJ27P5CWqzBU=;
        b=J1vKNXhm9MmvNCcQRS3f1GKNlFr1kx7Wv8fyFqo0ESfcvvLw5+EIxt71l8LHgEFv7L
         M+ZLHspA9fdHpW1elsSwVm+RZjIcgmS6NBakkXZmP2SwxBWX4ierPXCifeQqh3MwEjvE
         2gxD3znU4OHyKfh4UrrxYyiUPxP9+cT1IGDgbtEdaEmWoJj+p20vu66wQzVZTV4urln6
         /qHX7f+ZWjCsv7OlbjCjLhH4H/oUs8RznUd1IoSP+m6QHVUBZ3JTWmRmz5c2b4zCYdbH
         UlmEVBSHULm09E1qFaCywEXsN0BraC8mk2CHhka+oT7XAEt0o3fAGgh+lYMq+UVmuhk3
         33RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750005; x=1741354805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7Qe15dxMfjDnNi0r7cCotARJKXbVAoEJ27P5CWqzBU=;
        b=uVyIqJ8Gv3WugvUTCfGx6RkjZViw3p22T80h/F1RDY1PlllFYwCE1jPFKHsWckZTRk
         RVHOipY4x4R9q8Nd1dO78Xcc1evrv7oXL/fQMaKm10CwGgBFQ18trIekf+3zj8J91hhU
         7u5dS3gQpuCW8akyvaStVu1bFLv65caB4pzB3kH/gbWmYfj6wTPQkliHyPe4nfYOQYgH
         hqftSVbgDv5Q1HrKeC+ZWVN1//MrOI5E6PXIYK659uz267LlDv805fG2g7KFAy7zyJfI
         2/LdWCSvpzigJ5GWzM1xp0zgnYQK1TnV2Eym5HyciYsJzvIAonajFd3KCWZumh1ltoVs
         21Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVe4E8SbrwAponp6/+f1qVkbZqwTk9td7roIfR3F2IrSThz18xJ1Oiv01t90F5SUUfChv1BSX+im9oGgFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWjPtZZb3oZAlFFSwOTICdSbItayCv2a7rBmjmH2hAPOsQQ/R
	uxTODATLPpH54CL3LGkVX+mX4z8IgDpcL8PF0Z1Z08vOUdztR4E2WOa/jIVBIC0=
X-Gm-Gg: ASbGncsoOdEHJEbbYTxpta/1nZRqKaOeU3riMc4tfnfSlBJqVp6r41pdF8ZgcSR5W25
	gxEBXLntyOdWXtA5cJZeyTO1s7Erm+WZKzhgqVaigDFmPKotSGR+akESBqvgKUhCfQ6eBlVBzh4
	HbKQgHMSO107vdkL42UdOfwXMjgWfkYYkhhlhhHZa342pYBy+Gw2jioWi9jismqPqDrVHGA/GLd
	LOaAuE6+FCrTuBV2Rb93VBAxBwI90tAqWu/uxDxFy2VXNXswprdywExiO36ivWjVHFRncCrHYX8
	SY3CphyO2Ocm8VVAwAJmZf2OGjb+44PI7A==
X-Google-Smtp-Source: AGHT+IH5FG8AQ6D+64sFGHfe3tHwWw2ntFHIUnyirsKoQY14AoDqBIkyyts2MWqQVEWC51mEK7nJmg==
X-Received: by 2002:a05:600c:3ba8:b0:43a:9ef6:77ec with SMTP id 5b1f17b1804b1-43ba697ef79mr25704955e9.23.1740750004759;
        Fri, 28 Feb 2025 05:40:04 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d4b:473f:a962:e9e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm55984405e9.18.2025.02.28.05.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:40:03 -0800 (PST)
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
Subject: [PATCH 1/7 v3] sched/fair: Filter false overloaded_group case for EAS
Date: Fri, 28 Feb 2025 14:39:54 +0100
Message-ID: <20250228134000.1226665-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228134000.1226665-1-vincent.guittot@linaro.org>
References: <20250228134000.1226665-1-vincent.guittot@linaro.org>
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
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 857808da23d8..d3d1a2ba6b1a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9931,6 +9931,7 @@ struct sg_lb_stats {
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
+	unsigned int group_overutilized;	/* At least one CPU is overutilized in the group */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -10163,6 +10164,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
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
 
@@ -10374,8 +10382,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
 
-		if (cpu_overutilized(i))
+		if (cpu_overutilized(i)) {
 			*sg_overutilized = 1;
+			sgs->group_overutilized = 1;
+		}
 
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
-- 
2.43.0


