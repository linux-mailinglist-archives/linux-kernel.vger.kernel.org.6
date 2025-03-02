Return-Path: <linux-kernel+bounces-540781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBC7A4B4D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E18B1890B05
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034A41EB9EF;
	Sun,  2 Mar 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmgYNBrd"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C61D54FE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949546; cv=none; b=hd8eXKqnmkecmmV+OaWtKuQnLa9+gYfwmRfhgTqEoWYz3358t4cHganp/AqpaK37XhUpYY939jpKLIFGkoFT328jNhC6XKA1VoU2xUluH/Xs/JwXOUySSHmys4TWCzzX1NcK6txOUUOs2cwowouBufNpTLRB59qQ2JYxcHFvu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949546; c=relaxed/simple;
	bh=JsjVUB451SlgsihDR9Uc1Sq5yyqehTkp2t1+ZYSrdrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgcCM+8X2mlKZ07RtkA97L5vVYyMXYojHes9DWmcYIMk0K/JVj9rwT3vXFxR9M7pKyO5jqoSeuaqNhz7VIJ5JkdDGXK5kdBKDp+0UZVSIcsvc8wktt1q+1/zFAaKvbEygcufGAx4JGXM0+kFTkaXebgHO1yMyzFKnFhmMgu9FcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmgYNBrd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1940247f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740949542; x=1741554342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUarImRBQDaNjtBwqFegG1V1RKFJhM1pfbCGKbRMA4E=;
        b=GmgYNBrd3vvYtQdupqWT474pVLJAo7xQn7ScsjJYA72cA8GcEYbbJEl9jf/RYOY0Pj
         RczcYaVOijzE011XHJ0TzxAhoFXRQJc9YcB2lBRkm9RyOo9H4LAJo9wI5JrMGd1T3oQj
         PVoxcto/7aUHeYNWOjiAgfAxCPfIIzRvGfvZmr/CCqMAgk5jtRZJjFBLFbD/dP77BeTX
         4SqvN0WeSnVuznO/zMokyAi0gIEfpAFIGybf9Btg3RaHQbe6f97eS0F/lCieQbiyC+zJ
         WVrSw14qD40DUtrc325lB5yef033orYZcsTlvbdytL2Ku1+8xdFVgegM2OokV5jE8meo
         b5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949542; x=1741554342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUarImRBQDaNjtBwqFegG1V1RKFJhM1pfbCGKbRMA4E=;
        b=B8VTD0HlMiBIl7VVFJfkMsZsWb4F9Ajvrpr11UKBO99vDNjYqu/iSpaZneX/6iQMk2
         fj4vpYFpkAjclSM7Qb+CM95eL+ic2N3D4NFgv2WTh4+pWXcLHz9eqrJXLXXD8i1rDTSR
         SE20YEVGYW78trHeAJ7yAxFFwovtxzlSbINyWBUA31l0X51EW1qocpDFUW0nR46p+8t9
         QfBG+jz8yLhiQgvzBxdFQD7lN3ZUXhWnghXzVK3QOCIqI+YvNRpHqFebnXIpGu7IhjoO
         YPxR2aAl+s3B+jhxDC8SRDkXwZD16QA//XmkJQTZZzYpT2k4E6vUCFKfQzL91lcHFv6p
         7feQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1E93yniLKSIvleiqL9d9z0iByNAH4rtptkfrFaMEAcHIkqSgaPf9xnwgYkW3wgyFE8NuTzPGUD/dP57A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/XbXLrBaXDFuQo/K5zHerY+vO1WlXso7Uv3vPFxGqRDMDBUv
	1cFhyEbZsvHCaj5MeklvwnmF8GPHTSWdqJci5DDtyu9JWX5pFTNFg5SWstUd5A8=
X-Gm-Gg: ASbGncuXFkSjeLF8BTwnAOmBovB0ipwz/0IoKOMqRrK/ewZB9bBzPi+51pT5A7K2Dwm
	0oHjkEy6qj69V1YFBszmk2QGM6u5MIM0C5RVfNXATHbnpXp3aGkfGo6SiUNGP7l2+QUAWtIFOGc
	3cqTeqkJAwcaae5TIj9jaa6qd+3pToDn/LpAzsYPQV5yLmGYpwmW1qK79siMN83o0vLyD/Lo0so
	Yj7hkSfpEVvyv+snpZBi2ayR3gDnSj7Qzw6l/j4T57sswEfCLk9NZM7SxXqhBtp4F3KNN7d+LRI
	Qf13ZvEJ4ZNY4Hg9sGHvdumQHAwbPp6k1HbUyXF+QZK5fWLVgHHg
X-Google-Smtp-Source: AGHT+IEqXN4tnyyPhO6fSZMn9Jogy4MAcAvx3OCXZBWgiUwilofvvWX0l/0rBPp3LkeXo4P31bmVHw==
X-Received: by 2002:a05:6000:400c:b0:38f:3a89:fdb5 with SMTP id ffacd0b85a97d-390ec7ca9b2mr10647817f8f.11.1740949542147;
        Sun, 02 Mar 2025 13:05:42 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e045sm12480923f8f.99.2025.03.02.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 13:05:41 -0800 (PST)
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
Subject: [PATCH 0/7 v5] sched/fair: Rework EAS to handle more cases
Date: Sun,  2 Mar 2025 22:05:32 +0100
Message-ID: <20250302210539.1563190-1-vincent.guittot@linaro.org>
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
 kernel/sched/fair.c          | 721 ++++++++++++++++++++++++-----------
 kernel/sched/sched.h         |   2 +
 3 files changed, 518 insertions(+), 316 deletions(-)

-- 
2.43.0


