Return-Path: <linux-kernel+bounces-399639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C2D9C020A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C6B1F221EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CCB1EE00D;
	Thu,  7 Nov 2024 10:15:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE121E907E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974499; cv=none; b=SXApFM9RaOOraKAfog/L/5YEhGSAz415iwehMo1R6/TsHRIgN4GxLUSV/ceJYtx2aQUXSuIH/j6dk9DbXl0PCEY1E1Jpx9l3tEcwzzg8i4xSWL5jTrttS5wtzkfJZyxs44dK/5F40kBwOzK+zm3VWsOOb1RzjYWlXxzgKAQ6zw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974499; c=relaxed/simple;
	bh=3GHhvAdJEEy5WKbIRQ1tlkm4pwEDdjfXboD2AW5Jbxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaLwRJXQJnt0GP1mDdsUuH4JWO/uD//ywl2oiUoFKl9Z1o57Vkm5vd6YqPlDp6QveWW1KJJo/2yhHVCBBF6D2lOahcXFhzRuvLU5M5kt+Cabt91zw0WJD/5zoKh+w/BCLqbJudqH+gXvmSyj7tEZbb1ELgVtSO34PAoSj/rqwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2435C497;
	Thu,  7 Nov 2024 02:15:19 -0800 (PST)
Received: from [10.57.26.139] (unknown [10.57.26.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06ADF3F66E;
	Thu,  7 Nov 2024 02:14:45 -0800 (PST)
Message-ID: <22c7f8cb-41a1-4004-9017-fb9a313f80ae@arm.com>
Date: Thu, 7 Nov 2024 11:14:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] sched/fair: Rework EAS to handle more cases
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240830130309.2141697-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,
Related to feec(), but not to this patchset, I think there might be a
concurrency issue while running feec().

Feec() doesn't have any locking mechanism. This means that multiple CPUs
might run the function at the same time.
If:
- 2 tasks with approximately the same utilization wake up at the same time
- some space on an energy efficient CPU is available
feec() will likely select the same target for the 2 tasks.

Once feec() determined a target for a task, util signals are updated in
enqueue_task_fair(). The delta between running feec() <-> enqueue_task_fair()
is ~20us (on a Pixel6). This is not much, but this still allows some other
CPUs to run feec() util signals that will be wrong in no time.

Note that it is also possible for one CPU to run feec() for 2 different tasks,
decide to migrate the 2 tasks to another target CPU, and then start enqueueing
the tasks. Meaning one single CPU will run feec() using util signals it knows
are wrong.

The issue is problematic as it creates some instability. Once a
'parallel selection' is done, the following scenarios can happen:
- the system goes overutilized, and EAS is disabled
- a frequency spike happen to handle the unexpected load.
   Then the perf. domain becomes less energy efficient compared to other
   perf. domains, and tasks are migrated out of this perf. domain

I made the following prototype to avoid 'parallel selections'. The goal here
is to tag CPUs that are under pending migration.
A target CPU is tagged as 'eas_pending_enqueue' at the end of feec(). Other
CPUs should therefore not consider this CPU as valid candidate.

The implementation is a bit raw, but it gives some good results. Using rt-app
workloads, and trying not to have tasks waking up at the same timing during
the whole test:
Workload1:
N tasks with a period of 16ms and a util of 4/8. Each task starts with a
4ms delay. Each workload lasts 20s and is run over 5 iterations.

Workload2:
N tasks with a period of (8 +n)ms and a util of 4/8. I.e. the first task
has a period of 8ms, the second task a period of 9ms, etc. Each workload lasts
20s and is run over 5 iterations.

Are presented:
- the measured energy consumed, according to the Pixel6 energy meters
- the estimated energy consumed, lisa uses the util signals along with
   the CPU frequencies and the Energy Model to do an estimation.
- the amount of time spent in the overutilized state, in percentage.

------

Workload1:

Measured energy:
+------+-------+--------------+--------------+------------+
| util | count | without      | with         | ratio      |
+------+-------+--------------+--------------+------------+
| 4    | 8     | 3220.970324  | 3312.097508  | 2.829184   |
| 4    | 12    | 5942.486726  | 5016.106047  | -15.589108 |
| 4    | 16    | 10412.26692  | 10017.633658 | -3.79008   |
| 8    | 8     | 7524.271751  | 7479.451427  | -0.595677  |
| 8    | 12    | 14782.214144 | 14567.282266 | -1.45399   |
| 8    | 16    | 21452.863497 | 19561.143385 | -8.818031  |
+------+-------+--------------+--------------+------------+
Std:
+------+-------+-------------+-------------+
| util | count | without     | with        |
+------+-------+-------------+-------------+
| 4    | 8     | 165.563394  | 48.903514   |
| 4    | 12    | 518.609612  | 81.170952   |
| 4    | 16    | 329.729882  | 192.739245  |
| 8    | 8     | 105.144497  | 336.796522  |
| 8    | 12    | 384.615323  | 339.86986   |
| 8    | 16    | 1252.735561 | 2563.268952 |
+------+-------+-------------+-------------+

Estimated energy:
+------+-------+-----------+-----------+------------+
| util | count | without   | with      | ratio      |
+------+-------+-----------+-----------+------------+
| 4    | 8     | 1.4372e10 | 1.2791e10 | -11.000273 |
| 4    | 12    | 3.1881e10 | 2.3743e10 | -25.526193 |
| 4    | 16    | 5.7663e10 | 5.4079e10 | -6.215679  |
| 8    | 8     | 2.5622e10 | 2.5337e10 | -1.109823  |
| 8    | 12    | 6.4332e10 | 6.9335e10 | 7.776814   | [1]
| 8    | 16    | 9.5285e10 | 8.2331e10 | -13.594508 |
+------+-------+-----------+-----------+------------+
Std:
+------+-------+----------+-----------+
| util | count | without  | with      |
+------+-------+----------+-----------+
| 4    | 8     | 1.3896e9 | 5.4265e8  |
| 4    | 12    | 4.7511e9 | 5.1521e8  |
| 4    | 16    | 3.5486e9 | 1.2625e9  |
| 8    | 8     | 3.0033e8 | 2.3168e9  |
| 8    | 12    | 8.7739e9 | 3.0743e9  |
| 8    | 16    | 6.7982e9 | 2.2393e10 |
+------+-------+----------+-----------+

Overutilized ratio (in % of the 20s test):
+------+-------+-----------+-----------+------------+
| util | count | without   | with      | ratio      |
+------+-------+-----------+-----------+------------+
| 4    | 8     | 0.187941  | 0.015834  | -91.575158 |
| 4    | 12    | 0.543073  | 0.045483  | -91.624815 |
| 4    | 16    | 8.510734  | 8.389077  | -1.429448  |
| 8    | 8     | 1.056678  | 0.876095  | -17.089643 |
| 8    | 12    | 36.457757 | 9.260862  | -74.598378 | [1]
| 8    | 16    | 72.327933 | 78.693558 | 8.801061   |
+------+-------+-----------+-----------+------------+
Std:
+------+-------+-----------+-----------+
| util | count | without   | with      |
+------+-------+-----------+-----------+
| 4    | 8     | 0.232077  | 0.016531  |
| 4    | 12    | 0.338637  | 0.040252  |
| 4    | 16    | 0.729743  | 6.368214  |
| 8    | 8     | 1.702964  | 1.722589  |
| 8    | 12    | 34.436278 | 17.314564 |
| 8    | 16    | 14.540217 | 33.77831  |
+------+-------+-----------+-----------+

------

Workload2:

Measured energy:
+------+-------+--------------+--------------+-----------+
| util | count | without      | with         | ratio     |
+------+-------+--------------+--------------+-----------+
| 4    | 8     | 3357.578785  | 3324.890715  | -0.973561 |
| 4    | 12    | 5024.573746  | 4903.394533  | -2.411731 |
| 4    | 16    | 10114.715431 | 9762.803821  | -3.479204 |
| 8    | 8     | 7485.230678  | 6961.782086  | -6.993086 |
| 8    | 12    | 13720.482516 | 13374.765825 | -2.519712 |
| 8    | 16    | 24846.806317 | 24444.012805 | -1.621108 |
+------+-------+--------------+--------------+-----------+
Std:
+------+-------+------------+------------+
| util | count | without    | with       |
+------+-------+------------+------------+
| 4    | 8     | 87.450628  | 76.955783  |
| 4    | 12    | 106.062839 | 116.882891 |
| 4    | 16    | 182.525881 | 172.819307 |
| 8    | 8     | 874.292359 | 162.790237 |
| 8    | 12    | 151.830636 | 339.286741 |
| 8    | 16    | 904.751446 | 154.419644 |
+------+-------+------------+------------+

Estimated energy:
+------+-------+-----------+-----------+------------+
| util | count | without   | with      | ratio      |
+------+-------+-----------+-----------+------------+
| 4    | 8     | 1.4778e10 | 1.4805e10 | 0.184658   |
| 4    | 12    | 2.6105e10 | 2.5485e10 | -2.374486  |
| 4    | 16    | 5.8394e10 | 5.7177e10 | -2.083208  |
| 8    | 8     | 3.0275e10 | 2.5973e10 | -14.211178 |
| 8    | 12    | 7.0616e10 | 6.9085e10 | -2.168347  |
| 8    | 16    | 1.3133e11 | 1.2891e11 | -1.839725  |
+------+-------+-----------+-----------+------------+
Std:
+------+-------+----------+----------+
| util | count | without  | with     |
+------+-------+----------+----------+
| 4    | 8     | 3.5449e8 | 8.2454e8 |
| 4    | 12    | 9.4248e8 | 1.1364e9 |
| 4    | 16    | 8.3240e8 | 1.2084e9 |
| 8    | 8     | 9.0364e9 | 5.0381e8 |
| 8    | 12    | 9.9112e8 | 3.0836e9 |
| 8    | 16    | 4.9429e8 | 1.9533e9 |
+------+-------+----------+----------+

Overutilized ratio (in % of the 20s test):
+------+-------+-----------+----------+------------+
| util | count | without   | with     | ratio      |
+------+-------+-----------+----------+------------+
| 4    | 8     | 0.154992  | 0.049429 | -68.108419 |
| 4    | 12    | 0.132593  | 0.061762 | -53.420202 |
| 4    | 16    | 6.798091  | 4.606102 | -32.244179 |
| 8    | 8     | 1.360703  | 0.174626 | -87.166465 |
| 8    | 12    | 0.519704  | 0.250469 | -51.805502 |
| 8    | 16    | 12.114269 | 8.969281 | -25.961019 |
+------+-------+-----------+----------+------------+
Std:
+------+-------+----------+----------+
| util | count | without  | with     |
+------+-------+----------+----------+
| 4    | 8     | 0.212919 | 0.036856 |
| 4    | 12    | 0.069696 | 0.060257 |
| 4    | 16    | 0.63995  | 0.542028 |
| 8    | 8     | 2.158079 | 0.211775 |
| 8    | 12    | 0.089159 | 0.187436 |
| 8    | 16    | 0.798565 | 1.669003 |
+------+-------+----------+----------+

------

Analysis:

- [1]
Without the patch, 2 tasks end up on one little CPU. This consumes
less energy than using the medium/big CPU according to the energy model,
but EAS should not be capable of doing such task placement as the little
CPU becomes overutilized.
Without the patch, the system is overutilized a lot more than with the patch.

-
Looking at the overutilized ratio, being overutilized 0.5% of the time or
0.05% of the time might seem close, but it means that EAS ended up
doing a bad task placement multiple, independent times.

-
The overutilized ratio should be checked along the energy results as it
shows how much EAS was involved in the task placement.

-
Overall, the energy consumed is less. The quantity of energy saved varies
with the workload.

------

On another note, I wanted to ask if there would be a v2 of this present
patchset (sched/fair: Rework EAS to handle more cases),

Regards,
Pierre

------


diff --git a/include/linux/sched.h b/include/linux/sched.h
index bb343136ddd0..812d5bf88875 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1592,6 +1592,12 @@ struct task_struct {
         struct user_event_mm            *user_event_mm;
  #endif
  
+       /*
+        * Keep track of the CPU feec() migrated this task to.
+        * There is a per-cpu 'eas_pending_enqueue' value to reset.
+        */
+       int eas_target_cpu;
+
         /*
          * New fields for task_struct should be added above here, so that
          * they are included in the randomized portion of task_struct.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c157d4860a3b..34911eb059cf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6945,6 +6945,8 @@ requeue_delayed_entity(struct sched_entity *se)
         se->sched_delayed = 0;
  }
  
+DEFINE_PER_CPU(atomic_t, eas_pending_enqueue);
+
  /*
   * The enqueue_task method is called before nr_running is
   * increased. Here we update the fair scheduling stats and
@@ -7064,6 +7066,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                 check_update_overutilized_status(rq);
  
  enqueue_throttle:
+       if (p->eas_target_cpu != -1) {
+               atomic_set(&per_cpu(eas_pending_enqueue, p->eas_target_cpu), 0);
+               p->eas_target_cpu = -1;
+       }
+
         assert_list_leaf_cfs_rq(rq);
  
         hrtick_update(rq);
@@ -8451,6 +8458,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
                         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
                                 continue;
  
+                       /* Skip this CPU as its util signal will be invalid soon. */
+                       if (atomic_read(&per_cpu(eas_pending_enqueue, cpu)) &&
+                           cpu != prev_cpu)
+                               continue;
+
                         util = cpu_util(cpu, p, cpu, 0);
                         cpu_cap = capacity_of(cpu);
  
@@ -8560,6 +8572,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
             ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
                 target = best_energy_cpu;
  
+       /*
+        *'Lock' the target CPU if there is a migration. Prevent other feec()
+        * calls to use the same target CPU until util signals are not updated.
+        */
+       if (prev_cpu != target) {
+               if (!atomic_cmpxchg_acquire(&per_cpu(eas_pending_enqueue, target), 0, 1))
+                       p->eas_target_cpu = target;
+               else
+                       target = prev_cpu;
+       }
+
         return target;
  
  unlock:

