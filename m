Return-Path: <linux-kernel+bounces-425757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270CC9DEAC2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C986A163BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0F14884D;
	Fri, 29 Nov 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2SYQP0Q"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93721B95B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897084; cv=none; b=OwNGhzkOSCGewyAXAblkB6URexQ13PZsIaFgfE7Zju9WJ7u3IZGt2Tv7frNxWU72mEeZxIQ8EMn+mhwRyMm0iu8p3+qbUiECSUTLFwUdQ1liDZRwl8+UXYPd05o7paYmV82rYCwiZ3k+vo9sTDkV4Cu3G6iw+axbUA/1/KJIaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897084; c=relaxed/simple;
	bh=roLgGOXe80LCkb7io5v9Zxq35t3VrtIQwBD2oOtFWsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwV9UIew7xywCkusynmEK77/Sst/xG2itIPrFB7u02wjty/TvoKqrqp8StaWVu+wY0Wqhsndv+OPEoKItN7ZsduKC3IX+048zjSJSQMZ/B7P0BssB3ujBW4ifYQw1Jo/76HB2TL/xR38ZYtwHsC0jJ2JqXRM+2CWYBtO39888uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2SYQP0Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a742481aso18499725e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897081; x=1733501881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pgAcs630TzDTKDtObcfoo94+cezV0ZoWFH+WNcOUWs=;
        b=w2SYQP0QY9+HUfwFdr6O3aNPpHehDc1UfHPuc71xQrz01u39XVtuaYW46QQIaXW8DW
         ZMBBC52CUR8vrje9z0E0U5ph78a0RmKyLXkVodwWNlkOkSE/PhqM7dLanN5QdoQOvwnf
         N3B4cyeKuQ2YmVgZwiCSRg+Q08FgmkZxX+fZem3oVE0fXmkHsJGYl/3ICTQ+v0ulijFH
         0I7HI4NFG6Ci3qvCjkYrBS8mcDt3dumhZnB4MnBTqWICj+uzLNvChjaN4FcMTSbTc5X1
         P39OFLKErZOLn9IRQQnU6BSwNgisDnr0/72Q4/KW037Xo/dWbBR0go2oWutV/iNmDcyW
         FsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897081; x=1733501881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pgAcs630TzDTKDtObcfoo94+cezV0ZoWFH+WNcOUWs=;
        b=VekbhKBoTqrq9jITvLoUT3TXB6OwDEf3718hT7uAGliffjr288ogjPUTDDTEyWCr8+
         DtqZCGl+7Wo20J7+PBZfG2AF9TD/+fu9YXsFQtY1AfN0mySlSvlc8l9knpJ1GpJuk1mI
         lV7Wf98n7LQ6OIW/ESfrh1GUFie01WRCZkFevrhmLgmQ5RK+2TmpR5wf3HOoZ//+dQtx
         iHjUCk5esl1gi3ktHXFFrylKqrFmvU0gOz5V0JpRNxpmcrMWeGXweET86tYtCAnFWgjF
         9sVuz8LkPrg1yzHXOCNpj/gzINOzyIRaRiWIuBObErVkrw+0MX40Hld6JN+bN7A36v62
         hySw==
X-Forwarded-Encrypted: i=1; AJvYcCXYzOmHm16uQlS0rGVLEbx4ADO+f5aWM+/dn/N8dCU95CZEOOtcHMFtFmB6z4AbTAtANztE7tzWW+ptaCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+QuMRh6DSQaviMqjg0As1Fei/NYsVIxTuWhw1GkpXtWvQUnd
	WZoLvkhT0zsTMpL/T6HI7RwPDaCBq1AehJxJJ1GoekLltQkUzpYePG9S1q5kGQk=
X-Gm-Gg: ASbGnct+dugOqnCCrUU9VfB0xHAXyk+GtP8x1IhBj52yTD5Z4u6vT8i4ABQg9vUxam3
	AxdXAKxcPN4l1B72n7j2w3hdAtzI6syDhR3XxzSklq/W9K70j5A3Mk++ToAZHWr7bK4ZmboGaIn
	PuuBftQbciLypPg+R9bVt4lv7H7phJUHz/8zAA587nxu3d/lLH+fJE2U1SyW/A88/IG1x+UoI+R
	gJAk9r+gJHM1Wtle7TA/LAMjihIwW7pXHFsvh3DpjGQb7KUl6pTffQ7Q3I=
X-Google-Smtp-Source: AGHT+IFhJKhDc7fN7OPbIMEkzbQNlVjeqjAyU9BQ63czvdPQf8UqJLg0lNIAnU76dNuh0sk0oLkm9Q==
X-Received: by 2002:a05:600c:1d18:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-434a9dbbcc7mr121957555e9.4.1732897080704;
        Fri, 29 Nov 2024 08:18:00 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:00 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
Date: Fri, 29 Nov 2024 17:17:46 +0100
Message-ID: <20241129161756.3081386-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
lag has elapsed. As a result, it stays also visible in the statistics that
are used to balance the system and in particular the field h_nr_running.

This serie fixes those metrics by creating a new h_nr_queued that tracks
all queued tasks. It renames h_nr_running into h_nr_runnable and restores
the behavior of h_nr_running i.e. tracking the number of fair tasks that
 want to run.

h_nr_runnable is used in several places to make decision on load balance:
  - PELT runnable_avg
  - deciding if a group is overloaded or has spare capacity
  - numa stats
  - reduced capacity management
  - load balance between groups

While fixing h_nr_running, some fields have been renamed to follow the
same pattern. We now have:
  - cfs.h_nr_runnable : running tasks in the hierarchy
  - cfs.h_nr_queued : enqueued tasks in the hierarchy either running or
      delayed dequeue
  - cfs.h_nr_idle : enqueued sched idle tasks in the hierarchy

cfs.nr_running has been rename cfs.nr_queued because it includes the
delayed dequeued entities

The unused cfs.idle_nr_running has been removed

Load balance compares the number of running tasks when selecting the
busiest group or runqueue and tries to migrate a runnable task and not a
sleeping delayed dequeue one.

It should be noticed that this serie doesn't fix the problem of delayed
dequeued tasks that can't migrate at wakeup.

Some additional cleanups have been added:
  - move variable declaration at the beginning of pick_next_entity() 
  - sched_can_stop_tick() should use cfs.h_nr_enqueued instead of
    cfs.nr_enqueued (previously cfs.nr_running) to know how many tasks
    are running in the whole hierarchy instead of how many entities at
    root level

Changes since v1:
- reorder the patches
- rename fields into:
  - h_nr_queued for all tasks queued both runnable and delayed dequeue
  - h_nr_runnable for all runnable tasks
  - h_nr_idle for all tasks with sched_idle policy
- Cleanup how h_nr_runnable is updated in enqueue_task_fair() and
  dequeue_entities

Peter Zijlstra (1):
  sched/eevdf: More PELT vs DELAYED_DEQUEUE

Vincent Guittot (9):
  sched/fair: Rename h_nr_running into h_nr_queued
  sched/fair: Add new cfs_rq.h_nr_runnable
  sched/fair: Removed unsued cfs_rq.h_nr_delayed
  sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
  sched/fair: Remove unused cfs_rq.idle_nr_running
  sched/fair: Rename cfs_rq.nr_running into nr_queued
  sched/fair: Do not try to migrate delayed dequeue task
  sched/fair: Fix sched_can_stop_tick() for fair tasks
  sched/fair: Fix variable declaration position

 kernel/sched/core.c  |   4 +-
 kernel/sched/debug.c |  15 ++-
 kernel/sched/fair.c  | 236 +++++++++++++++++++++++++------------------
 kernel/sched/pelt.c  |   4 +-
 kernel/sched/sched.h |  12 +--
 5 files changed, 152 insertions(+), 119 deletions(-)

-- 
2.43.0


