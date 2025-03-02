Return-Path: <linux-kernel+bounces-540782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56210A4B4D8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6763A16BE46
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B39A1EE7BD;
	Sun,  2 Mar 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fg69tIDK"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B11D63E1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949548; cv=none; b=cvl9HKUoOxPn0BxNxWT0F7y9piy7zqAP/9iRIOKhImml+xYZ3y0LOj1fkQ+Lp2PXM8JsW3ScVKdr0kyWRtOxyFsw/F/VUqDJBRrKG/HxKMNQ2Hl9uh+s6pY2YSrgI6YeoxhVcRSWcxDExHS3Hazr4er/+hY5uKCA7ChMWf1bUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949548; c=relaxed/simple;
	bh=l6s2K8nye6CHRRRLfb5EYZPGV2XdU8BZngWM9TLpnUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPDAq23vfvFLX3ydSpUIRnw7ND0FDtQjpwfREq4674oQdR3u2QiOSYAujdq1lVHEN8h8QwA0O3rGCDUpe7UeAAGMwPsl+Wani9NHyjfE3azTukH+kdT0OGsc48FLCbmf5HFSDuow2FZy4V2Zf8+YP7bZOhdssTbwBXOsMOpYTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fg69tIDK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2223313f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740949544; x=1741554344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7Qe15dxMfjDnNi0r7cCotARJKXbVAoEJ27P5CWqzBU=;
        b=Fg69tIDKCSuc80syMUKax6N8B+2YG94jJnfTZIpoNgvv4HvkqvieGu8WzXboG8E70N
         n415Pfcs38Lm5L9Mx1v/lxwRv23HTfTI5sB/gqInMqdQQLQE1C4mog44oUNU/+Ff7CUu
         2XUA8D+xQiwPF2lhGHu6sts8jb5HJHZz63CIvmVOHLd9pYZplPqg0jZQXMceLL4uWvk1
         Kl9MhR6pBS508m77M42Vo5inKrFwWQatq/f6dHN8Q4TWMRTaUpzN5o7UEYmRxiGEo36d
         7Fbylpae0IgpRlaV6KTkQyqzd0ovnYhpH+06pZ95M1eTDGam61LrgmqDQpejlZWuxQal
         6M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949544; x=1741554344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7Qe15dxMfjDnNi0r7cCotARJKXbVAoEJ27P5CWqzBU=;
        b=WPDrfjeTIOexGcT7adCzOYvf++pvOMMsHv7/Whr7CyyM+UM94T8W8u1fpZxmAdS9LX
         1z2b1+efB+eoNcl0oXT83AunPxGOy9bGLhlNgi2OpeYF1+v6lrNw8zl+6m2tX71QaJ9W
         wWPXObFvnB45nFKqaWLwk9NAe8yheHksrpwlWAlS7TdVLYH+dDXpCVMWawdigw0TmtCg
         WFaLTaKe/VaH15FZkl9pvO3kpekzXcox+BzYpeyiAQokAoPx7JXjlqe5UXJsSzJN4dKd
         AgkqyqRP+MDfAorV/FA/IGXJOI+dpvAkDIfl558PqWQqsONReLq9PkWI1qnq9J0HkgNu
         QR0g==
X-Forwarded-Encrypted: i=1; AJvYcCVgqSphCnhpbpF5ac0RxcPcDk/b5t2KGg+aIFi+yckIDnNdEzb1XR7DCDbyXEH4RZ7Fm2bc3IsMt07KR2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVZEc7OcPr/A8/8dncE6b6Wpwt++VPgRimTaGjupr4tRQ/ECA
	WKKVUwVtdxz+bNGb51L3qAZdxoOrfO3LTIpjt1Dlxy7qs0RZHQAp+gIeC5/NwGU=
X-Gm-Gg: ASbGnctGvW6sSgmZvDpfO5bmo6pO+0Uxl/QAGKlJ33xP6p5yOVHnSwB3PJR36qLBm7G
	4kUqJsCTVk8ga68L1x74JyUeW3LMHYpdilywA+rvfJ3eiiOv84UFWtFp+QSZhzXyLK9+I4jnm5Y
	bJbvEwE0WcAWaWlJ/1XUza+Tx6ghGgofkA8ZYDCTUUTwiozyQfzNjDlzSVka+tfChxpNd8C2Boa
	L313YR87v6xbsr12Nj8r9gOiM4SpFIx2cy16h7NcpkzRlNSEC99zcPAbRzQYv9OMD6Q2FRRS1Yc
	Q7PYnXiz8NHlsHsOY7Ixr6u3o1yTShsz1pLbfbK/UqxzpKt9PzOl
X-Google-Smtp-Source: AGHT+IFBQimuZNAU6pbDQF7JzTPxywA8zGvVoMza33W1wNrVxLc5yidGK/0ih2DJA/ZQgo0f/SlHBA==
X-Received: by 2002:a05:6000:1882:b0:38f:3b41:c944 with SMTP id ffacd0b85a97d-390ec7c978emr10620473f8f.11.1740949544504;
        Sun, 02 Mar 2025 13:05:44 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e045sm12480923f8f.99.2025.03.02.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 13:05:42 -0800 (PST)
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
Subject: [PATCH 1/7 v5] sched/fair: Filter false overloaded_group case for EAS
Date: Sun,  2 Mar 2025 22:05:33 +0100
Message-ID: <20250302210539.1563190-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302210539.1563190-1-vincent.guittot@linaro.org>
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
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


