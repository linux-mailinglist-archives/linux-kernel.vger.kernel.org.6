Return-Path: <linux-kernel+bounces-308836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D596627C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0081C2384B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD551AF4D8;
	Fri, 30 Aug 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyWUvcvj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B01AD5EB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022998; cv=none; b=M9M1slGfMswVgOLCN7W//xiJfHLL5/QOMrQLRoveWEtM+q2C1QlBPIKk67ZrzdTLlsDHySfE7QhVE0DjGMgXKpCHcM1k0cMrANlYxZyGOuQLcVmA4PYwSGDuwsx6ZSNZedbo5qz29Cr+Bf5mWYFK74Me5i1vFw0v5ht31+rH1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022998; c=relaxed/simple;
	bh=nEQ/BNXrGDcClMnNclni9NyGDtBrGSdNO912g0teXu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZL2EEdMat417KHoF9dRIMOKN5Fj0KTHtR1UCPDgoM9pYrY6EBsc/F2z/pLyrNhsAxHqorymJGjeyMCPVf123D6rkV0QPSaxy5SFlGdq0U7wJHVu/iaYIZdJokXEBXPiPc1vXIy7oyajX+5Vm5i4PVOAk2H3TPbM2J/J8PBOQZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xyWUvcvj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bb4f8a4bfso10281965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725022994; x=1725627794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbvwHvRVX+KThqt4ft3z2luaMqPOwnHyb18WZNjn3hI=;
        b=xyWUvcvjvCFU+SyApRzPrRRjCJOtxw2/mu3MxYRk7yNO8sLAqddGxUODa3gEOAq0Kk
         a9vzwWEVORBGasd0hpKA8onw/VCztvyQlj57kGpKsvpIne3iKFVQtPZUjOx7wb9bvje5
         A7QGrdvvqgsU1nYzJmnN0PE92wVsMyGsTkwn020a9GmsASB5rc+qp+JCv6etRrX2P6ne
         dk4EGxrR8WobuEBLa82szuZS4j0/RrLOy7BOdOHA4LqadHaAQaEOQAflOdilxvqbIZP7
         tqGjTkrkgSFAOu2qNEWtiDSSnouyPqLpQlMV1PZG0n0xtyFXB9o1ZY01/yGxCIY+R0d8
         lpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022994; x=1725627794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbvwHvRVX+KThqt4ft3z2luaMqPOwnHyb18WZNjn3hI=;
        b=eZQoE37PF7x8KR749B+zOhhaJ02OlxZ9kGN8QlaoLgws+/gvInMj8Z5lD7mXLTTUwl
         Z9ZoFy/njTkHXmSas7gFp3f/nkQG5IofvBa2liRdW33jonVcT+RuAORMqk13RYEcvVa8
         bEQzlgKDoFId/ojYExjqxkdsyADons9yrk4dP5fwwpJ11+wwHEty9fqZ18q5kEDqnQe0
         hbVQDVwfUjZAnMJrC6I7U5EiuLR+1q2YyZh3JONnsUKiq3RFyWPHAJgmyN5zGZdughVr
         xeW1apvWJ31rldKXCgkffeJWEbECYzTqDshgIPryknJmEiz9iCfXzU1/BiTROxqIaZ+j
         MEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm7TpKPZm+fantaLcUxKR3yHaDmemCLAfsblN0Jge9Im5PzuNMrW9MjNlMqc8hOUoK+KzWp4F95l6iZBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYLFCZNtG+r9fTdAgleseyzBG5yMwjg/wJ0NjneTUob+Z0hiA
	YPHv74dTKa5Bp1zLUG4NxfY4VDIL7h/ALUeqfUTiuJ5mix9bA3nwBdBGtL1qZ88=
X-Google-Smtp-Source: AGHT+IF7ajeRVMBXX1GVp+1gy3VO+NSzn0uptXTTzJtkj82wWAWUP5APx7lIZaf8nDEvacogaHte0A==
X-Received: by 2002:adf:f302:0:b0:362:23d5:3928 with SMTP id ffacd0b85a97d-3749c1da581mr3664802f8f.17.1725022994153;
        Fri, 30 Aug 2024 06:03:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3cfc:139d:f91:133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efaf35asm3954076f8f.90.2024.08.30.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:03:13 -0700 (PDT)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/5] sched/fair: Rework EAS to handle more cases
Date: Fri, 30 Aug 2024 15:03:04 +0200
Message-Id: <20240830130309.2141697-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
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
and then the most performant CPU between CPUs.

perf sched pipe on a dragonboard rb5 has been used to compare the overhead
of the new feec() vs current implementation.
sidenote: delayed dequeue has been disable for all tests.

9 iterations of perf bench sched pipe -T -l 80000
                ops/sec  stdev 
tip/sched/core  13490    (+/- 1.7%)
+ patches 1-3   14095    (+/- 1.7%)  +4.5%


When overutilized, the scheduler stops looking for an energy efficient CPU
and fallback to the default performance mode. Although this is the best
choice when a system is fully overutilized, it also breaks the energy
efficiency when one CPU becomes overutilized for a short time because of
kworker and/or background activity as an example.
Patch 4 calls feec() everytime instead of skipping it when overutlized,
and fallback to default performance mode only when feec() can't find a
suitable CPU. The main advantage is that the task placement remains more
stable especially when there is a short and transient overutilized state.
The drawback is that the overhead can be significant for some CPU intensive
use cases.

The overhead of patch 4 has been stressed with hackbench on dragonboard rb5

                               tip/sched/core        + patches 1-4
			       Time    stdev         Time    stdev
hackbench -l 5120 -g 1         0.724   +/-1.3%       0.765   +/-3.0% (-5.7%)
hackbench -l 1280 -g 4         0.740   +/-1.1%       0.768   +/-1.8% (-3.8%)
hackbench -l 640  -g 8         0.792   +/-1.3%       0.812   +/-1.6% (-2.6%)
hackbench -l 320  -g 16        0.847   +/-1.4%       0.852   +/-1.8% (-0.6%)

hackbench -p -l 5120 -g 1      0.878   +/-1.9%       1.115   +/-3.0% (-27%)
hackbench -p -l 1280 -g 4      0.789   +/-2.6%       0.862   +/-5.0% (-9.2%)
hackbench -p -l 640  -g 8      0.732   +/-1.9%       0.801   +/-4.3% (-9.4%)
hackbench -p -l 320  -g 16     0.710   +/-4.7%       0.767   +/-4.9% (-8.1%)

hackbench -T -l 5120 -g 1      0.756   +/-3.9%       0.772   +/-1.63 (-2.0%)
hackbench -T -l 1280 -g 4      0.725   +/-1.4%       0.737   +/-2.0% (-1.3%)
hackbench -T -l 640  -g 8      0.767   +/-1.5%       0.809   +/-2.6% (-5.5%)
hackbench -T -l 320  -g 16     0.812   +/-1.2%       0.823   +/-2.2% (-1.4%)

hackbench -T -p -l 5120 -g 1   0.941   +/-2.5%       1.190   +/-1.6% (-26%) 
hackbench -T -p -l 1280 -g 4   0.869   +/-2.5%       0.931   +/-4.9% (-7.2%)
hackbench -T -p -l 640  -g 8   0.819   +/-2.4%       0.895   +/-4.6% (-9.3%)
hackbench -T -p -l 320  -g 16  0.763   +/-2.6%       0.863   +/-5.0% (-13%)

Side note: Both new feec() and current feec() give similar overheads with
patch 4.

Although the highest reachable CPU throughput is not the only target of EAS,
the overhead can be significant in some cases as shown in hackbech results
above. That being said I still think it's worth the benefit for the stability
of tasks placement and a better control of the power.


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

This push callback doesn't replace the current misfit task mecanism which
is already implemented but this could be considered as a follow up serie.


This push callback mecanism with the new feec() algorithm ensures that
tasks always get a chance to migrate on the best suitable CPU and don't
stay stuck on a CPU which is no more the most suitable one. As examples:
- A task waking on a big CPU with a uclamp max preventing it to sleep and
  wake up, can migrate on a smaller CPU once it's more power efficient.
- The tasks are spread on CPUs in the PD when they target the same OPP.

This series implements some of the topics discussed at OSPM [1]. Other
topics will be part of an other serie

[1] https://youtu.be/PHEBAyxeM_M?si=ZApIOw3BS4SOLPwp

Vincent Guittot (5):
  sched/fair: Filter false overloaded_group case for EAS
  energy model: Add a get previous state function
  sched/fair: Rework feec() to use cost instead of spare capacity
  sched/fair: Use EAS also when overutilized
  sched/fair: Add push task callback for EAS

 include/linux/energy_model.h |  18 +
 kernel/sched/fair.c          | 693 +++++++++++++++++++++++------------
 kernel/sched/sched.h         |   2 +
 3 files changed, 488 insertions(+), 225 deletions(-)

-- 
2.34.1


