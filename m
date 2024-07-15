Return-Path: <linux-kernel+bounces-253171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50AD931DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F0C282AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED2143892;
	Mon, 15 Jul 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIF261wP"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136E1E890
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087466; cv=none; b=oAT2q6ShQedHhrojdXmBd4oaE7Kd6wNqV08Inw1aXE9zVW1E6Ddse9oyYSJ0Mec9QFHgjMs4WnDMa4pHCGZi8UOKe6jcTpwjdNd3GA3IQmLvgn5NCTCxdDNIDvluZTya9S8YQprK/lihms/6/zuQm0a2gbBgmEHDQ/w+Gccb/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087466; c=relaxed/simple;
	bh=qdom0NuCa3187ALcj9ybW3J+X29ZeIZM4Dgr3Yz7pyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e9tIGhxJG8a4+6OriG+NLV+GyEYkoff5w5AGPUhA4fk6Eddfvy5pYkG1D7ZSv0oDZSzVx/eNS7Q/O3pk+9eCFBIPKws2iSapV7wmNcT+uMAzd0tSB0jlWoIsLfi6ezjvJU9zld37MNdTAmq5m8c0BzKR+7DK4a2BEc22ZbsVtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIF261wP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so28808895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721087463; x=1721692263; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dGHXS8JW++t29bOwoTx/430nyCQ1DooHiumVdS49QGQ=;
        b=iIF261wPOe/25kuYWQ4dHHfEYH84TcShEkRxZGz9NB65KHZZC0oRntxkah48ea+Fcn
         jTlz8JFn01K5nzBKP/wC4dXMmFcAycPjI9N/OAHhtTiFHhzpq77Y+LUPt9wuhvvV538J
         XmSl++9AVzVPxkGV097dlpP1SdWUueQzcYq/89AY4NSKxUoZRS8d8M2O9Ioaanp44Pwo
         IDGaX75v+ASOToe+1UEJRi9sy8l3Dx7IqbZbrWPuU1tqewcTJO7nUJCtTn0M69ggFxYn
         WfTJUP012OpYFzsUs8PGUoMVcT4OGpVEDTzPRC0Wdg4Rddhgr4wfTHA483oWj7QVfdAy
         HjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721087463; x=1721692263;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGHXS8JW++t29bOwoTx/430nyCQ1DooHiumVdS49QGQ=;
        b=MGASp74gc8ahRGZnV1JN45OiUwur9Na/rKLmKmO/W8dJUfkBQWSZHvGZYoGCBhVa6c
         Z4QGOHhAqbkqFJZanUFyECOGXOhgJ5k1+BsT6pWb35eEfLrJUZN4fM3sH3jeMilxoR6e
         40geveCrSjg74orQfKpCZjijUf5O1ae4h2NMpF4ILWSbgeUi2bMAREZwXiLk/SQD9f0K
         bbh9e0ChAmIk/4Oeq2m6tfcsTDOIXQbnKv9QqIpY/+1yb5pDv6LHS25ZHVI+gQhWIO03
         rIlD0rrV+QPRGmMlO++A7hSWEmQV48vu1pIDvioPRDoIukBRs1/xL6rntYyrf9Kscgk8
         xvGA==
X-Gm-Message-State: AOJu0YyNQEfuyOJCkOe03RR1NeDxDJdVGv6DVHGSPxI04YD/YWji7u2E
	CzIC2KRMu0h6+9mhDKIwVqkAoHX0MqK1+SWheidqC+bDokZEnb+C
X-Google-Smtp-Source: AGHT+IELfrUaMA52kKiZ0rjmxmjzGXsW/WwYcL7B04BFv8u6UNOdaVNd4L50Bwcg1zv7ioe4qeIP9Q==
X-Received: by 2002:a05:600c:1988:b0:426:6327:5a16 with SMTP id 5b1f17b1804b1-427bb8ebebamr1002685e9.18.1721087463044;
        Mon, 15 Jul 2024 16:51:03 -0700 (PDT)
Received: from gmail.com (195-38-112-86.pool.digikabel.hu. [195.38.112.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e983dbsm102457915e9.24.2024.07.15.16.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:51:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 16 Jul 2024 01:50:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [GIT PULL] Scheduler changes for v6.11
Message-ID: <ZpW146UsrWo_leh0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest sched/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-07-16

   # HEAD: db43a609d01e8bf9b812d45dc2945c65b57dd793 sched: Update MAINTAINERS and CREDITS

Scheduler changes for v6.11:

 - Update Daniel Bristot de Oliveira's entry in MAINTAINERS,
   and credit him in CREDITS.

 - Harmonize the lock-yielding behavior on dynamically selected
   preemption models with static ones.

 - Reorganize the code a bit: split out sched/syscalls.c to reduce
   the size of sched/core.c

 - Micro-optimize psi_group_change()

 - Fix set_load_weight() for SCHED_IDLE tasks

 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Christian Loehle (1):
      idle: Remove stale RCU comment

Ingo Molnar (5):
      sched/syscalls: Split out kernel/sched/syscalls.c from kernel/sched/core.c
      sched: Fix spelling in comments
      sched/core: Simplify prefetch_curr_exec_start()
      sched/core: Clean up kernel/sched/sched.h a bit
      sched/headers: Move struct pre-declarations to the beginning of the header

Peter Zijlstra (1):
      sched: Update MAINTAINERS and CREDITS

Sean Christopherson (2):
      sched/core: Move preempt_model_*() helpers from sched.h to preempt.h
      sched/core: Drop spinlocks on contention iff kernel is preemptible

Tejun Heo (1):
      sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks

Tim Chen (1):
      sched/balance: Skip unnecessary updates to idle load balancer's flags

Tvrtko Ursulin (1):
      sched/psi: Optimise psi_group_change a bit


 CREDITS                                         |    3 +
 Documentation/admin-guide/kernel-parameters.txt |    4 +-
 MAINTAINERS                                     |    1 -
 include/linux/preempt.h                         |   41 +
 include/linux/sched.h                           |   41 -
 include/linux/spinlock.h                        |   14 +-
 kernel/sched/build_policy.c                     |    1 +
 kernel/sched/clock.c                            |    4 +-
 kernel/sched/core.c                             | 1874 +----------------------
 kernel/sched/core_sched.c                       |    2 +-
 kernel/sched/cputime.c                          |   14 +-
 kernel/sched/deadline.c                         |    8 +-
 kernel/sched/fair.c                             |   18 +-
 kernel/sched/idle.c                             |   12 +-
 kernel/sched/loadavg.c                          |    4 +-
 kernel/sched/pelt.c                             |    4 +-
 kernel/sched/psi.c                              |   60 +-
 kernel/sched/rt.c                               |   22 +-
 kernel/sched/sched.h                            |  434 ++++--
 kernel/sched/stats.h                            |    2 +-
 kernel/sched/syscalls.c                         | 1699 ++++++++++++++++++++
 kernel/sched/topology.c                         |   12 +-
 kernel/sched/wait_bit.c                         |    4 +-
 23 files changed, 2183 insertions(+), 2095 deletions(-)
 create mode 100644 kernel/sched/syscalls.c

