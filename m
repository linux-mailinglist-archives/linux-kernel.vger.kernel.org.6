Return-Path: <linux-kernel+bounces-540618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B05A4B2F6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86593AEFF7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D161E9B1A;
	Sun,  2 Mar 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edUiJpT2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166B1E8327
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932008; cv=none; b=E0Hv6B6z9YRFHjoL1xwKxCjBtz1V26XfASOrjMlKDZej6mNJQOZ/35V0IH6dV4wHRi042jFkhFOjPzYS5oKQNTZwv9BOWXrF7quUrHUkcUVdK9gxK6zkOaeQx8aKssGE8WkEemxl6vpZko5A4Wt+vrd4F2U0wdR8VSb47ntHRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932008; c=relaxed/simple;
	bh=PV6oVIGTRiwqi6gFLFuw1fsCjgG5hJ20Qxe6K/Kot0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqP+7oNLECjRSzWKSflUKO9F2u01zTYXOncB22CsqugwGoyOt4xckAMjqNO4++OvF7jA6PhiYXNcmu4eBnJJeQpIOOd4QNsbnL+Ul7Uyjd0ydsh6GSQHRDtkYfYszojiIy3wMZLz2hDsYToNNpEvR0PZccaqOlUtLDPDwI8HwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edUiJpT2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43948021a45so33754675e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 08:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740932005; x=1741536805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wE0p5aMJXldGt4TuBoVBJ0A6lnlehsp8A8NK2iQSZBQ=;
        b=edUiJpT2CSanuOqFvMbOroL/2T8zmTKnAiWqbGBd7oozerLUTSJzWbXUX5yli606eg
         6tIlfn8dqd4tZgsYbuaWLAhS8r1+lLV6t4JUZLOdO20iFnVC5/4aEJ+amBHyuftqTZAy
         HPlPmUM30xDM3GMvPYa1Ml0qpYcTjBNUzoMx8mVCojAp7e+hAfKnVnBmK//6ys/LIdcS
         rer5bsiWA8ny7J8kf7dPv5zX3ReaVA7OQj+M1kjMHgeQD5lu1GIGYpXvN1/UGxV53Wuw
         WEpHXP2Bvqd0LCzEgvpZYPl37YYZUgOFMJoMTrPsal9BmokfhX/pNIGx2njaM0iethmO
         SpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932005; x=1741536805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wE0p5aMJXldGt4TuBoVBJ0A6lnlehsp8A8NK2iQSZBQ=;
        b=uBxqX3lt3vnLeGa4wUp8ikMpW4tAL1wBJxbLC9iFf0ijp/iemxGaHEO3J957XJG+r+
         eiFM/ghKBwK7mPOzfaMNgvZ6tf00Ow0lwQ1Go2ucsz3Q1bAxtaCNmsCbt0gGBY8W5s+5
         +zA72IeWED5P7WeKnw2+B5ZfFIGpdhpFLUwImvw4V8vI+hM0Zq8deSo3ysfsWyx93Lhe
         5BLX3m7ubfMNva6fKC1T+FTeyYX0AcmKCE1J7p89GPrBHsEJoNdxxGbYDHwHJcJ0l2fd
         4ClS1SHJSZwLMYKvs+s1sqeLCKych4OP6zlDczw1WhQKszWg7KLz07a23n0baZNGJ6qL
         vCYg==
X-Forwarded-Encrypted: i=1; AJvYcCXzy5CW6a1aiCRU2KOg5hc/WQjMLlb35drLrqvT65OMYiZo8eWvusB9mCe1mnBs+kXg/LIk5bpftVmI64I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRoJwJjBuisYUp4G9s0feLjl0tjyIq5dX7H1eiikG6Vo3g68w
	qGF1XRr16ZzeligOrwvgDUp5BD2RlmnAY1vqtr3hKDKRG9zhj663fhywxU3zHMo=
X-Gm-Gg: ASbGncs8GZBFdkihmhUxiM6JxltPGPFX5svJ8OQIKsZ6Mm5kQKLQAD3w0Y2wcHAQzTS
	APz7sTiJQzb2QqwO3QPETuxVIFy+bzWktp9tZRB7oEWJWMttVqhiXlAzfOgXFGPWEFFJXJkBE+9
	X59kAyoMeejIUBs+g56ZoLCIYs+5gjeN2NrD/HtgO33sRKiVf9ErpIKCZChuQdt4gCgZqPEx8uG
	WrfLJdI00rustYWt4SJqU338tnlpBlf1DdBLtutoaPFi8Mv9UF4h3FTeOXcpTElN9HfYBov67pG
	eAlpsWPlwU72EfCtZYs769KDCxzUD9x8w6uMuxz+xq3Sf5v4hYCI
X-Google-Smtp-Source: AGHT+IHxViuvCK0YVjoP0xuMqSbVWC3/pfmkgsLys6zB51mFHA5DKivqFURFvtwHjCGL23FJlIT9Ig==
X-Received: by 2002:a05:600c:c09:b0:439:87d2:b0fd with SMTP id 5b1f17b1804b1-43ba74908b3mr82628955e9.12.1740932004621;
        Sun, 02 Mar 2025 08:13:24 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm25530245e9.18.2025.03.02.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:13:23 -0800 (PST)
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
Subject: [PATCH 0/7 v4] sched/fair: Rework EAS to handle more cases
Date: Sun,  2 Mar 2025 17:13:14 +0100
Message-ID: <20250302161321.1476139-1-vincent.guittot@linaro.org>
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
 kernel/sched/fair.c          | 721 ++++++++++++++++++++++++-----------
 kernel/sched/sched.h         |   2 +
 3 files changed, 518 insertions(+), 316 deletions(-)

-- 
2.43.0


