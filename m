Return-Path: <linux-kernel+bounces-540619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94DA4B2F7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC14116E8A6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC41EA7C0;
	Sun,  2 Mar 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0iCrK0q"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B201E98FE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932010; cv=none; b=bKOGzw4Cy+rD/n2jkQgyEzDelxdbZU161gm3+WH8tmOcT1P8SUihVjS2kv79ibxPrdSLADwPRkNvsSBtmfUad6rnHw6GsK9qoQ+JTRArL5/wun4ev7q8OX2AXF1pQuiXuQV0RZfVs2RA9os4NLlrmCWiJKMeWF0SMINKxRThzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932010; c=relaxed/simple;
	bh=l6s2K8nye6CHRRRLfb5EYZPGV2XdU8BZngWM9TLpnUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXVA0Jw8lylKdu73sr6nDU4VsAUTFWjtQqao/M+cwJS327aiN9witq0fyCTn9ZYS/aUvc9NU37CgQxWCxbWUECXCqAYoagjrQFRNWvr7YFhiZzeewOUpcohT129B1y1zN77q+FdsYi/viXa8kA4N0bHbkeBuVYraozQshLGg2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0iCrK0q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4398ec2abc2so32828665e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740932006; x=1741536806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7Qe15dxMfjDnNi0r7cCotARJKXbVAoEJ27P5CWqzBU=;
        b=R0iCrK0qCjVt6zB9xG3cSQGOXlamx1mEl0UjqkLRv/wX8PDxxHNHZfbyJcqDoHJCC8
         Nw8X+e1NY+EXjnJFCamO+nW3CZX5v/AptaYt9OvLa1zBS9wiBssMreETTw9fcZdcuhYW
         z5O5GFDzygrz4ZnA9lAh7yRW7Mv/Bm1DVmLhNdPYnbymEzgf+xgWBLXlzkb0tLXELldh
         Fx4Cc5SxpvLO/oxygVWHRbsQV7fULNmxvkEbbgX940XL6QOfbGwAsI9mb0U5cucZCP79
         4020CYd0GOKgpg3x+7tWAQ/MBNBE3m/3EOfKbPvJ3SPljxjv4ixEQA5Bu5+4T2KSvHbp
         lQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932006; x=1741536806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7Qe15dxMfjDnNi0r7cCotARJKXbVAoEJ27P5CWqzBU=;
        b=ZiWSMKAD4tlbPeu6Ufs+x3IOKtVCXej3kIa/YJOEoD4J8qt2cmDO35vb2lDqc+W9cd
         CEgd5Vg9lqyPi8PiEQAFUjcKwjsc39jPaf7EsJlUtN1QkoeOuTP58mE1SMr59w43jXHo
         7knJuat3ELUhkPrwrBzTnxO9+latRUiUlSXWzchQ3eE9COri2V4AyBvSC0odWGkdFHiE
         EB0O87Ty4eG1wTfEGtQhuvHKAjGdm76JMlDp7b5G0pbrscDdZafmaDT76AAe0MohmDCM
         doTgrHqJFii3JpVsLM75UflaC83NJcLu2dQfylgofwvTuzCuilzAy3vdeGTrOKjLGVjU
         Jk1g==
X-Forwarded-Encrypted: i=1; AJvYcCXJw0Z59roytcq1icy6WWZgSzv2Y08aPFy6pfOVKuzv5AmeJ8EMlYbSMbFHexz+5v7UypjyHe4V3RVTjbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEo2C8M1xfWzPsV+hUqQxj1RAJBo8DHwYrKEZuI9kPj8CkYJPy
	slA0l5FD39zwL973+VvKiGDgOb35QwLoGRZJ0Httw497Tc5fVM6eaWCWTtLo74o=
X-Gm-Gg: ASbGncsxxS3V8zx6J8Xkp3WBu4YSjBarOB0a+HdAQsBt7TkOFF/61lyXLziaOA8LIPy
	F9VIpWQOoos74gqoCVc8t1Nj+htrrd2q0VK+/9ApRaibLuM3B7cpOoVvMUoXXXwB5NnVuIdUJ9l
	6NgqsvlGd1TYQ8t0dTvaGsbjWdccQN8F5TK+VI/FdVn79PjfuGje7/h2yqJxKNxlTzwWu5W/Rpu
	9jxUyo0LMljv+LHJexrjzjkdqUIMEDySloJQAejFtR8NCywTxeq4yRqvumQMIo2RVY+mBp0eGfW
	gaa+Ddx/l7dM8C1C8Vkq+sxna9SIIndnir+8ihroSSd/b/yNTUDx
X-Google-Smtp-Source: AGHT+IF6XC/WmtRJHedti5yg8T9FNDoqw2mcBAb+8JYNpd7jF2eQc/5JlOrYZYYcPtqGmBa334nu8g==
X-Received: by 2002:a05:600c:4509:b0:43b:c2d7:44d with SMTP id 5b1f17b1804b1-43bc2d706cfmr745975e9.21.1740932006529;
        Sun, 02 Mar 2025 08:13:26 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm25530245e9.18.2025.03.02.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:13:25 -0800 (PST)
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
Subject: [PATCH 1/7 v4] sched/fair: Filter false overloaded_group case for EAS
Date: Sun,  2 Mar 2025 17:13:15 +0100
Message-ID: <20250302161321.1476139-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302161321.1476139-1-vincent.guittot@linaro.org>
References: <20250302161321.1476139-1-vincent.guittot@linaro.org>
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


