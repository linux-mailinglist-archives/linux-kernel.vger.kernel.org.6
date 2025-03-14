Return-Path: <linux-kernel+bounces-561794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E43A6165C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8BB3A9871
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F62036ED;
	Fri, 14 Mar 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7SruKKl"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9E802
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970181; cv=none; b=BigaTixZPbfJfDYatu5lQ3FVyC4L07I/eS//rOupWOBZ/RsEZgmthbyPha94owzylbooZnuXoYfVxvX2IT4n21pdXZY6WuNgFksabLwOd9Uy8wtxT5qMOX4qdrExWFoB/J0eOc++gS94kl9ZlLkoom5W6bV2si4ai4+J1fCCjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970181; c=relaxed/simple;
	bh=oTEtLlgPA1kJbFWZbRPOGoLaWhB3dtDOx9QzUEAAGmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iaw2RChO4Q++H15wOIrIqm42BjVtx/jDrBUIvihdYVB/vL/iVfDfsPlj6nGbPdXZxzR4Vw0zSgnBvP1/m8sr+g8AfexEqVmah4zmKfwHUiqElqyKBIQPLj1z8bGtweeuDQ73G/b2FKYjyoyroSq1u8OVF3MNgFGm3G+YhEvZenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w7SruKKl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so15938095e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970177; x=1742574977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuLOnTq3z0MhOY73qU4I+ilaryLZHI6JYqRsBIZCPzI=;
        b=w7SruKKlsCJMAj4Ct7wLZO+6LW2fSSgiSZhJrqZ9cPj8WY30FeA/uz73iqMROarjem
         gLB/vSmL8eE43Cz7hWHBaxFXOxGWO18VHc8UOAET+IcEsW2xgDLFPMhyXDH3d1qSu6hG
         mGhK4su1fp8IpigGHOK1CFjM0HWxB3WEkL7hIYQ8jgcpB8s46UdKrtqb0eziI5A/RVXW
         lphkr7falQaZnv58Qj8D/8pu0n++iDPkXTHj8iEmWoHsyhRIcQBWlnbZ7oWhoFjEjnWl
         Qiz31AR81d2Z9xBlJJjIELOBqaTMRQ8Qfgv85V94dDpVmdo4rDQMOpxBOiiXvzELFe40
         TBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970177; x=1742574977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuLOnTq3z0MhOY73qU4I+ilaryLZHI6JYqRsBIZCPzI=;
        b=AorZXGJ52iNWT/fhMUDjvL+8wXPqaLSpNBC89gP0j1ZLlIY7EjrEm+XvoHCyOwxwyV
         lZtKsTIkjylpu1azZ4kjnB7Nn9velw/6rTAXWESJcntWHxcmzD4L6ROnShFvZu17EQnG
         6CJHs6hPeRob9s74/5Wwh+Zw9GLQgRGxGF3Z28aJqQU3+JcGP6zk4hGkNVCJp31c0xCi
         rIjxknUOIVNDDfE384d6sizkBHf7g6MVwycmGe10sNbK+SWLtT/uRyWHwB33E6BuHixD
         FaH6XRo74lqCx4ofnJwQX4ZQa+NpLstjLcyqQadvyrJwoLhGuNSpj+nhzeGTTzewuUt+
         +9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUOzGyYy90/nYfltyd109Lqmt3S5GVMfXrJWifGaSPNqBJA6RvwvYteipb088ow0+LBc9cI0hpVmw7l/3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxvG1+dnM5/JmAGtsonm2oejo3nECPPnJlpILjbcRHoOtPFy1
	KY4+dK6s74LW64J61v5+FBYJDrtKBFOUSlyAvNdE9r1yC/02njZHjC60D4gyMg0=
X-Gm-Gg: ASbGncteM/8Ev3e5u9xxtUS6VGN3t9M8c0Zu0UOo78PYjGA9OXWnb+U+eudtiwYix3w
	B/a8q4V8zobN0X9v1C1Ea05qBa6IZwkte7vDOnZOMVvDjasFJ6PQskJQP7EBYFDeClhPOZUZMFR
	Tsp2M0xxgQg9DbIA26FWRuwIw8QCmQwYAkV/9ofl9N5YzLBSuVUnk45vm+x1vZYyiz1gm0JlRc6
	1MgvHIi4Xh//OTjdUaFN81QP3IgyTpINMmKS3rzV964EKOPiYaWB32n0Ne17dJQw+1q4Y1LTafj
	RHPAoaibz67BQ8z9LtpisxJRgvhIlUDE0Hirll0fFTaUX1FAdaj6
X-Google-Smtp-Source: AGHT+IEFwBWPpvkCl4DZ7CS0jvNj8kTM+do+3YtNUp4zuPCxKoQYcsei/04bFUHS9KAyNkC9iea8Hw==
X-Received: by 2002:a05:6000:1fa7:b0:390:e85b:a8ee with SMTP id ffacd0b85a97d-3971d03ee30mr3657504f8f.1.1741970176984;
        Fri, 14 Mar 2025 09:36:16 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:329b:9a6:20f4:3754])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm6072925f8f.78.2025.03.14.09.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:16 -0700 (PDT)
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
Subject: [PATCH 0/7 v6] sched/fair: Rework EAS to handle more cases
Date: Fri, 14 Mar 2025 17:36:07 +0100
Message-ID: <20250314163614.1356125-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current Energy Aware Scheduler has some known limitations which have
became more and more visible with features like uclamp as an example. This
serie tries to fix some of those issues:
- tasks stacked on the same CPU of a PD
- tasks stuck on the wrong CPU.

Patch 1 fixes the case where a CPU is wrongly classified as overloaded
whereas it is capped to a lower compute capacity. This wrong classification
can prevent periodic load balancer to select a group_misfit_task CPU
because group_overloaded has higher priority.

Patch 2 creates a new EM interface that will be used by Patch 3

Patch 3 fixes the issue of tasks being stacked on same CPU of a PD whereas
others might be a better choice. feec() looks for the CPU with the highest
spare capacity in a PD assuming that it will be the best CPU from a energy
efficiency PoV because it will require the smallest increase of OPP.
This is often but not always true, this policy filters some others CPUs
which would be as efficients because of using the same OPP but with less
running tasks as an example.
In fact, we only care about the cost of the new OPP that will be
selected to handle the waking task. In many cases, several CPUs will end
up selecting the same OPP and as a result having the same energy cost. In
such cases, we can use other metrics to select the best CPU with the same
energy cost. Patch 3 rework feec() to look 1st for the lowest cost in a PD
and then the most performant CPU between CPUs. At now, this only tries to
evenly spread the number of runnable tasks on CPUs but this can be
improved with other metric like the sched slice duration in a follow up
series.

perf sched pipe on a dragonboard rb5 has been used to compare the overhead
of the new feec() vs current implementation.

9 iterations of perf bench sched pipe -T -l 80000
                ops/sec  stdev 
tip/sched/core  16634    (+/- 0.5%)
+ patches 1-3   17434    (+/- 1.2%)  +4.8%


Patch 4 removed the now unused em_cpu_energy()

Patch 5 solves another problem with tasks being stuck on a CPU forever
because it doesn't sleep anymore and as a result never wakeup and call
feec(). Such task can be detected by comparing util_avg or runnable_avg
with the compute capacity of the CPU. Once detected, we can call feec() to
check if there is a better CPU for the stuck task. The call can be done in
2 places:
- When the task is put back in the runnnable list after its running slice
  with the balance callback mecanism similarly to the rt/dl push callback.
- During cfs tick when there is only 1 running task stuck on the CPU in
  which case the balance callback can't be used.

This push callback mecanism with the new feec() algorithm ensures that
tasks always get a chance to migrate on the best suitable CPU and don't
stay stuck on a CPU which is no more the most suitable one. As examples:
- A task waking on a big CPU with a uclamp max preventing it to sleep and
  wake up, can migrate on a smaller CPU once it's more power efficient.
- The tasks are spread on CPUs in the PD when they target the same OPP.

Patch 6 adds task misfit migration case in the cfs tick and push callback
mecanism to prevent waking up an idle cpu unnecessarily.

Patch 7 removes the need of testing uclamp_min in cpu_overutilized to
trigger the active migration of a task on another CPU.

Compared to v5:
- Fixed pushable_task for !SMP
- remove sg_overutlized param from update_sg_lb_stats()

Compared to v4:
- Fixed check_pushable_task for !SMP

Compared to v3:
- Fixed the empty functions

Compared to v2:
- Renamed the push and tick functions to ease understanding what they do.
  Both are kept in the same patch as they solve the same problem.
- Created some helper functions
- Fixing some typos and comments
- The task_stuck_on_cpu() condition remains unchanged. Pierre suggested to
  take into account the min capacity of the CPU but the is not directly
  available right now. It can trigger feec() when uclamp_max is very low
  compare to the min capacity of the CPU but the feec() should keep 
  returning the same CPU. This can be handled in a follow on patch

Compared to v1:
- The call to feec() even when overutilized has been removed
from this serie and will be adressed in a separate series. Only the case
of uclamp_min has been kept as it is now handled by push callback and
tick mecanism.
- The push mecanism has been cleanup, fixed and simplified.

This series implements some of the topics discussed at OSPM [1]. Other
topics will be part of an other serie

[1] https://youtu.be/PHEBAyxeM_M?si=ZApIOw3BS4SOLPwp

Vincent Guittot (7):
  sched/fair: Filter false overloaded_group case for EAS
  energy model: Add a get previous state function
  sched/fair: Rework feec() to use cost instead of spare capacity
  energy model: Remove unused em_cpu_energy()
  sched/fair: Add push task mechanism for EAS
  sched/fair: Add misfit case to push task mecanism for EAS
  sched/fair: Update overutilized detection

 include/linux/energy_model.h | 111 ++----
 kernel/sched/fair.c          | 727 ++++++++++++++++++++++++-----------
 kernel/sched/sched.h         |   2 +
 3 files changed, 520 insertions(+), 320 deletions(-)

-- 
2.43.0


