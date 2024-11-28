Return-Path: <linux-kernel+bounces-424462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A19DB4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22212282581
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C157156238;
	Thu, 28 Nov 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4xQqxE9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D5154BEC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786078; cv=none; b=jHPp31T1ttkd0IYoxH8nJ5hk7oPkWmHqG+aAk9aVMj1RaRRbQpXKK0hjEHnaWiRiyvdyf2mKIKYuvDF2irAb36Wj8HKrBuC8dryarvByIBVIncm6sTzCCOfnwcJG+Hs2jk7EhmGjC1ZiYLUWp4QrlmMIOPgGhmGxVPytnvETRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786078; c=relaxed/simple;
	bh=oGMhf69GknjTosSdbUA8KgmrgJV7fnXe8ttaVeA2Jnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STVq8eCMXXpuWoFuI6AcNM1K05FhED2W7cUgorK9i9rMh1USpFtFL+hBbk6rTdAkpwb90JMDLdCly23IA35apW39JXipoNHenvoxMr3DTav33RZX6WqaevT+jXsFjqMtpVpOzIapNIPxV9MYxlL6Daacoe18bdt7AUgWm4YaQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4xQqxE9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a766b475so5265735e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786075; x=1733390875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rt39wWl8ZSC0cSx9R7mnrUI5zsiXsuLLFaEGCM1FhI=;
        b=N4xQqxE9/Ym915pGXrw/juOzEVyp2ELpF3YQa1gu9T7rrkgex/XBR1RZ6UMmLqVieZ
         8Jnu/XE4kr3enJy6zMhNSYmeSSuA79AxsLUopFYxMdAVqGrKvK95CbwcWZL/94KgmPtC
         k28sIomQWYk3lBFZi3e1tB5LIP8d6LiY3Hg/Jnpal949S+q3MwUAZcpDg2JWSuQIwiqz
         t6pj2Ea6QANuyuGEd4/p87VTjx5ff7lUKDpKSQuedLAwlscT0qQsKY+BmQIS8udMroXL
         ylo/xg15S8YL0ON8zOiMB1jfYT1t3SUsEI5a7U/20AidI02+JInyfVLtXslbtbUM9gLm
         gtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786075; x=1733390875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rt39wWl8ZSC0cSx9R7mnrUI5zsiXsuLLFaEGCM1FhI=;
        b=jVqsYGGXTv88waR7WVRBiSOelYASyptvbs7K6wiNJWdMww4cJMA+CqHkYU+39wyMTy
         UlBNE3hEus6fr4GesbyWpXPa2Xv1mOjIcCA7jCEoEzArAyiN64lkrQng3zDSfcYdorRH
         eXLkYe6WRaM8JBi34R2TE1/VySC08wab8ozv8zuSzyXuUYPl7gU74o4D0Fhvok+rMTjd
         w6Mh1397Ez5/iuxD7yFMpPtINUYZViHo1KYg8OKL4lqHGbeQmvK+8R7RBR8jYf3wGutx
         +vyhLFpr+Ag/nuUJgLZpkmu9RxsY7aRUWAqfTKkim7IWvKLBEmbbX9oRDpg8PTN/Zn91
         w1vg==
X-Forwarded-Encrypted: i=1; AJvYcCUk0T69mj8yAebrxmL0Ce8JqjQN779epwRFPWzObK2cm1qtSwa2ZAbVoAd92x332MZ+MS3CxXuLkNgK9PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+h01ai7iQ8mJNiOegw8L8Fia7yRcZZwCycJ15CYkQbxRWzEzk
	49KhlrEuSMhvJ89dmvq7bylXkZOR3y4TpZu/HPw7DEOxZVVYoCBYK63nEVRndI/5hoAKU4RF4Gm
	2W9I=
X-Gm-Gg: ASbGnctYWdm+bKelWpBspnH43GnJgBPjXzrr0ue4OWYcpaogF+yTAaoMOh829YFOwVa
	414RYUz2kp+fScPiH0ClsD0kBW9oMHys7MXMNthiQU+QgdOYpAkKwet4/wd9gfS9xSDpCfPCNjN
	Vag9yksU8hAv7DhAy1ysPtP4d62qliprpzaXlSi6OD/dyCp9ogPHMNVXxuMeAoiq2tubjVjIrCY
	v2rspAsc9LN4q7C54lcgfnzap5bfc/pa+VdT/cWmqQGyj5UOXcBebSuCQo=
X-Google-Smtp-Source: AGHT+IHAq+zDi569R1OrCn4Ly8QRXEG07y8GNm6vmmgyR325cQ/iDgDpAQylV/Ut7gcSZDvyDHyiUg==
X-Received: by 2002:a05:600c:588c:b0:434:a7e3:db50 with SMTP id 5b1f17b1804b1-434a9df26cbmr48165965e9.21.1732786075048;
        Thu, 28 Nov 2024 01:27:55 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:27:54 -0800 (PST)
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
Subject: [PATCH 0/9] sched/fair: Fix statistics with delayed dequeue
Date: Thu, 28 Nov 2024 10:27:41 +0100
Message-ID: <20241128092750.2541735-1-vincent.guittot@linaro.org>
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

This serie fixes those metrics by creating a new h_nr_enqueued that tracks
all enqueued tasks and restore the behavior of h_nr_running i.e. tracking
the number of fair tasks that want to run.

h_nr_running is used in several places to make decision on load balance:
  - PELT runnable_avg
  - deciding if a group is overloaded or has spare capacity
  - numa stats
  - reduced capacity management
  - load balance between groups

While fixing h_nr_running, some fields have been renamed to follow the
same pattern. We now have:
  - cfs.h_nr_running : running tasks in the hierarchy
  - cfs.h_nr_enqueued : enqueued tasks in the hierarchy either running or
      delayed dequeue
  - cfs.h_nr_idle : enqueued sched idle tasks in the hierarchy

cfs.nr_running has been rename cfs.nr_enqueued because it includes the
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


Peter Zijlstra (1):
  sched/eevdf: More PELT vs DELAYED_DEQUEUE

Vincent Guittot (8):
  sched/fair: Add new cfs_rq.h_nr_enqueued
  sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
  sched/fair: Remove unused cfs_rq.idle_nr_running
  sched/fair: Rename cfs_rq.nr_running into nr_enqueued
  sched/fair: Removed unsued cfs_rq.h_nr_delayed
  sched/fair: Do not try to migrate delayed dequeue task
  sched/fair: Fix sched_can_stop_tick() for fair tasks
  sched/fair: Fix variable declaration position

 kernel/sched/core.c  |   4 +-
 kernel/sched/debug.c |  13 ++-
 kernel/sched/fair.c  | 214 +++++++++++++++++++++++++------------------
 kernel/sched/sched.h |   8 +-
 4 files changed, 138 insertions(+), 101 deletions(-)

-- 
2.43.0


