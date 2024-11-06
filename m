Return-Path: <linux-kernel+bounces-398401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6B9BF0DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8C51F21E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647232022FE;
	Wed,  6 Nov 2024 14:55:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0531B201114
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904917; cv=none; b=XOHTNkCLOEZgY/ax2sR8FcjSxjDbfz0SKLdDTeNrf58CTzhNs7fU6HkMgCHHXKVOaQlZX4jnullT1McZTyDiDS4SGQT1DIq/L/YrWH2/TlbjMvZIECrL5DhuXGtITh8fMwrq21lJWlzW/arfezBTufBb5hD6j49ESYvAYYlhB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904917; c=relaxed/simple;
	bh=tlkQ0Q6FAsW16XNHRC6KeTWuYOazgsHoYGdof4Il5jk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q5rx/4ob3cQC77t/tOikNetiGWPUbuXkPpMlpFjIUNZIB38v6s5yFMvu5z8E7K6sBzFEj9VchuwqVJ5Fg4++pMAvNCSwEc4tqqNUazGzBo3/ecEQt3z4WAmVUvSu9aDEB4W/wXPXXmMeS/Aq7rGlW0aD6bwqnKLLoEfPLUY73eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01CDC497;
	Wed,  6 Nov 2024 06:55:43 -0800 (PST)
Received: from [10.1.29.71] (e127648.arm.com [10.1.29.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A7C23F6A8;
	Wed,  6 Nov 2024 06:55:11 -0800 (PST)
Message-ID: <633c2972-1171-4caa-8825-758d094c0ce9@arm.com>
Date: Wed, 6 Nov 2024 14:55:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [RESEND][PATCHv2] cpufreq/schedutil: Only bind threads if needed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove the unconditional binding of sugov kthreads to the affected CPUs
if the cpufreq driver indicates that updates can happen from any CPU.
This allows userspace to set affinities to either save power (waking up
bigger CPUs on HMP can be expensive) or increasing performance (by
letting the utilized CPUs run without preemption of the sugov kthread).

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
---
- RESEND: pick up tags
- v2: Add comment for the dl_task_check_affinity return (Juri)
v2: https://lore.kernel.org/lkml/a4a70646-98a4-4b85-955e-62d66ba68927@arm.com/
v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com/

 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 kernel/sched/syscalls.c          | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c6ba15388ea7..10faab849a3e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -691,7 +691,11 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 	}
 
 	sg_policy->thread = thread;
-	kthread_bind_mask(thread, policy->related_cpus);
+	if (policy->dvfs_possible_from_any_cpu)
+		set_cpus_allowed_ptr(thread, policy->related_cpus);
+	else
+		kthread_bind_mask(thread, policy->related_cpus);
+
 	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 24f9f90b6574..bd2208dcd15d 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1177,6 +1177,13 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
 	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
 		return 0;
 
+	/*
+	 * The special/sugov task isn't part of regular bandwidth/admission
+	 * control so let userspace change affinities.
+	 */
+	if (dl_entity_is_special(&p->dl))
+		return 0;
+
 	/*
 	 * Since bandwidth control happens on root_domain basis,
 	 * if admission test is enabled, we only admit -deadline
-- 
2.34.1

