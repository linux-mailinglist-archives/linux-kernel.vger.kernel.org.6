Return-Path: <linux-kernel+bounces-449552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10699F50B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDDA1640CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C711F8AC1;
	Tue, 17 Dec 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmJAV8Lv"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2231F7567
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451652; cv=none; b=dodJ4Mwvq2c4EZu/WvfUyce0W58dk4N7Cf4TKAbmmMatdlLpnAv/H6JG1NhR+BzzPWv3096UCdVnwA3mHPr0UiwbW4Rd5+mgxFwTOjP2nMg0e3AHP6OQqKfsUUEEK2z9S7T0aoUgZ3vpOR7czKVxrs0BCGbQccvkZ7pUuh2zrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451652; c=relaxed/simple;
	bh=c3zWzhwojLapLr1olTwpw0RmvisvZwlMKkuDXpbB+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjeQUuinJKu11ovBNYmm6XI9reUo+NrlH2fgSbS/ds9E8XBcL4jp6vvHtvKKQe/swG3cKp3kbrZVnktvx17yLiwLd+HvqRBjpbOl8X67oIjx1RyLXIcOhBhIekU0bC4ZMD0UfcjpMuhCyoLOmfpIxdpPTuH4324sWL1OoQE0JkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hmJAV8Lv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43634b570c1so27245065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451649; x=1735056449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yYtcd3NRaEEw3oDJfxwV6/iDpwV3++qcV52i0y9Uddg=;
        b=hmJAV8LvwvGodsG/NOJUHeWgtW5rYUFmuXs0SAQxEwbUTWJdUfT6FdGsDmZm/N+FE/
         jx1JZzDnNpbYtKch1NIdIpybDnHODZUKlE3+Ru2elT5cCnj53WZUs73NLSSAh2MiMgfo
         NRJAqp+Gtn6/oHKEyl3BVN5E7BrlnSI/xlQ1bqe4Mtfa/fQpdYkpDe0JuU3tsfk3KaCi
         jojcc/QjJjKP9BzH3ydX200lN/1Dq3bEcx8ehwmkAthq03OAUDlIn1xt7wrqN0TPJ7Ew
         Z4Q9LtLBQR//BQQbZTitNou6/H+w+KFuKxfG8TqgNm5WOsCOEdi/9NhHQxNicQb/myZK
         6cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451649; x=1735056449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYtcd3NRaEEw3oDJfxwV6/iDpwV3++qcV52i0y9Uddg=;
        b=EmiTXi/s/YcF78tlz6WXTV04e1C2SInhZwONNsZgZasBdXdVa3PPfS42+EB7qN2v6q
         lOEQBO5+kXLH9yqgPWXkNBtKRTZIHpWmVHtPA7YeADzBV57BYGDQZkkj/ZHPxJ+8oCZM
         Dc+thv2Bfj1SBKFtX4c3CBXQsszqoXVqLGPHjabSnz8LxBJRZ3ITmr+YDvIGxItgZ7Lo
         qIGyy+IdKEWl0Y0asNqRVDhwqvm1x/Za/h8QzVDITix33E9mPeGv3RmaEWvGDkwHj+ha
         dbleEo70hnccOAqBB9PlSQ+E/h12UTGIW6IHmQBlVajZ5GLL+/9Lafx3YIBO4aajL+g8
         VB0w==
X-Forwarded-Encrypted: i=1; AJvYcCXo3+Um1eFo88S6U6GTXn5eunquqIJttLNu3IhJnukj3dJcOpGAVeatPx0wX2x6AypjyzYHVd3piW/cVQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcHs2zLJlHKSZQDsoyNJeCAQ9nbjrcUCFHukR2ePkVFrnNJzL
	r6Q80frdsk+qy5q7FsHkf7PI8K7dFfWIJcnx2n0CaT5tk+Ezm7Mv36H9Bt6iNY4=
X-Gm-Gg: ASbGncsfVYpowgEdYtF32Udg0e9lqehsV0K0dlbskTvI3AKwGuzFtM4NFD1o0ykIlQj
	dAifz5nJKa6sPeUDuVo8Dlyqx8UmH30iryVYI/mIldl5PSxaWi1HE3bIEmMiq+TOZRp/AbgFE8A
	xUWiSCqSunJbtEO6cRG/rDPnOO8Q3BIpecNg3jnKXy0t+LSLY3blQ71v99438Fj5DXZnPtHJS9H
	U2Tx+nxJ847fiIATftJCfbFAfvnKrxxdMPDLsWO42xwnL29KDjbH/B+kD7dAC4tdQ==
X-Google-Smtp-Source: AGHT+IFujrqFbNChY1lxcq7bwh8qMNlR2GBm+gG69zjAZIWOuQITRLKsH5UsV4p5u8UtBrBRa2m+tQ==
X-Received: by 2002:a05:600c:cc9:b0:434:fec5:4ef5 with SMTP id 5b1f17b1804b1-4362aa43bcbmr173266125e9.14.1734451648535;
        Tue, 17 Dec 2024 08:07:28 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:4e5f:e8c8:aade:2d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257176a4sm176739435e9.38.2024.12.17.08.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:07:27 -0800 (PST)
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
	pierre.gondois@arm.com,
	christian.loehle@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/7 v2] sched/fair: Rework EAS to handle more cases
Date: Tue, 17 Dec 2024 17:07:13 +0100
Message-ID: <20241217160720.2397239-1-vincent.guittot@linaro.org>
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
tip/sched/core  13001    (+/- 1.2%)
+ patches 1-3   14349    (+/- 5.4%)  +10.4%


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
  sched/fair: Add push task callback for EAS
  sched/fair: Add misfit case to push task callback for EAS
  sched/fair: Update overutilized detection

 include/linux/energy_model.h | 112 ++----
 kernel/sched/fair.c          | 707 +++++++++++++++++++++++------------
 kernel/sched/sched.h         |   2 +
 3 files changed, 503 insertions(+), 318 deletions(-)

-- 
2.43.0


