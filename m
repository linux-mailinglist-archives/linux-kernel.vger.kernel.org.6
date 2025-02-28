Return-Path: <linux-kernel+bounces-538593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E5A49AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DA33BA337
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714C26BDBA;
	Fri, 28 Feb 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7CpURzV"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F51E4A9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750007; cv=none; b=PxdNFDTT54csai8KiLG701xjHwtkZPkog4cJp/dGw1KKQKzGYQJrPYqxVXsmiUJE7NPeLBmSPWj7YsdfaA3slM5roUvzMSCpcZ1loabfGufUv8rwvKM6vT3s4YBLiL/ARoxklgQbvomnIYjLU6LY5vSUwNQNVyQjil9eHWrwIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750007; c=relaxed/simple;
	bh=NAwPmZbi0UHTWKbjxp/L84/WGlh9ifKyccVSGokzDvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqJGQX3m8uSWV+v0oEPBJJ+AeMbOQt5VCfWEOckqGci15kUVVi7FFcnctIVQ5vsFNJJTDDo/4+tCLjcVRSQLRjBI+IA7FOW/RAXzZlTPDm+UXZz67KHOLaUqB3hNRCBJNlxUDJhlaGg5UDm8AZHoQJi0iN4sXA917lvIIMQpu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7CpURzV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a39e659cso14951665e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740750003; x=1741354803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHpaguigQqtfUfKYwzCOyMDHP0j6yDmxg20Be5goi7w=;
        b=O7CpURzVzLEv13CijOWH8a36DORkpnN1pGnltOmmVf6SBWdi+/yT6ccfIYm30l7qJV
         zFp2hK52Z0Nd9LJw7QSr0JZPRPo/4wcvRXoHKIpZ3Q6kptUm9fdbFy90gs5uyAYNz+a8
         U6Djv5a9taw+vmWXbDIHDufFyY//pYqIiyWlUULH+w/8vUJA5gETm6UmarXeX1CVnztV
         1LbJggEtsJ+/MDiq+eUvYkVhGeWGq1W+Yv5RVeGYIU6aOdMjkccmijIN+mVRF3wQMU6l
         LFboxNfnvnpp5cPfrdtE0JH+c3VBfuOqqQdI0h/oorscblakaAQn9rkNPmOC6aOtFlUx
         TNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750003; x=1741354803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHpaguigQqtfUfKYwzCOyMDHP0j6yDmxg20Be5goi7w=;
        b=G5oeyohPFJG3pjt3xQzwp+GJm8Q/HVmlhZDNXneI2H+Os8W4tW3Lx3lSWkJqfXfEoK
         WW66xFWj1c0hIWvdNueF2IVGW9jalYH4pL3t3BRfkKj+YDky6sn7DUb4f8ubO+BbUDoU
         ATGUia8QIzhio0hv0qVWXDyVjP1g88YG3tfwVyPyU9I83BwmKr85Piyhu0oPNtCQ803o
         fbmTJ6jlekRQBak4PtFxCQ/4dI3l8UuJOZJDw6SL558EG6YQAAsMJv1Bn24wlMSB1GZ6
         ynaT99IJG8V5KX2gy0IBniFyRRSb9ywVP3enJfruQ5uELiiwD1MfhhXCoigPu7CxPOfM
         KKbg==
X-Forwarded-Encrypted: i=1; AJvYcCWj2+56mI6yXC+7nThqwXUU73XfAonfK+6ZxfVjBpa5FbhRGjCgbx4qVQZ16kwrxYnlQtX2VYDOOElKmzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyODZOS14TlGoiYzJp56oKadJEHtXPKGeFaBfJlIeVidDyfim0A
	DYf40RZF5/paMdPL0VuFS6zV+Jick2jF5qRKqdUU7o8uOeq/gvRRdX4OcyQC4ZM=
X-Gm-Gg: ASbGncvcuAwuNa3Kg1jAMX9EodVXjwrVhOVuF4Ipcbt/4iNnT2EesGsQQvD/L5c+KLb
	Ws+0JNYganJoPNVSXQxEadvUB3WqZlAkf6dlUaS2hCCdtcgZZo9UZMBb0uNg/MSRaz/gSm5Yj1y
	F0N0ufmBFzWJ3qFPLTOWLypA/X0oypNODmEL29iln5vF/f2B9B4BkGh6N2JIwu31HbL93Xn++/r
	nvCGQMQSpI2caYOynks81wEJP2HTKju4tJU8IQncsBJte24v8FBhPMJbTuVA2xySTCswLjopqJn
	tnOBQhdewC2tyHEmRSvNEHQ95wcCMAoFxQ==
X-Google-Smtp-Source: AGHT+IGFakDKepvfZnv+mo2cfbk3P8TvRoq1sekBuqWFxjkZG8MzQu0uxXW4xPiVCaIR6bhU773bOg==
X-Received: by 2002:a05:600c:3b9a:b0:439:8e95:795b with SMTP id 5b1f17b1804b1-43ba6a77357mr30084545e9.31.1740750003179;
        Fri, 28 Feb 2025 05:40:03 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d4b:473f:a962:e9e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm55984405e9.18.2025.02.28.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:40:02 -0800 (PST)
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
Subject: [PATCH 0/7 v3] sched/fair: Rework EAS to handle more cases
Date: Fri, 28 Feb 2025 14:39:53 +0100
Message-ID: <20250228134000.1226665-1-vincent.guittot@linaro.org>
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

 include/linux/energy_model.h | 112 ++----
 kernel/sched/fair.c          | 717 ++++++++++++++++++++++++-----------
 kernel/sched/sched.h         |   2 +
 3 files changed, 515 insertions(+), 316 deletions(-)

-- 
2.43.0


