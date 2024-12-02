Return-Path: <linux-kernel+bounces-428111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B779E0A57
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C91281FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D742B1DB548;
	Mon,  2 Dec 2024 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVRhPnPS"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8691D9A78
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161575; cv=none; b=XZpePMD2s8QLbry2C0nB1l7q8Y4g4qIA0b+uB0IPmUgiB2wvdunvJgXyJyGVMK+/hkF9lWD1GvO7nQQI04JVZ3ua+NhyTLZgg34fe1JZJj8t5UlTtlQZ/1u+5tnSfAbMCs6646Z2eZUFZQ0vW1QtdQaxSJlEMtd40JNt8VFStLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161575; c=relaxed/simple;
	bh=BRy2wt4JBba0S2mWDSr7du7tuFzYUS8MnYSoLfvOjAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtHwnoCVxTohz+Q6ESjyS1g6lLji3ifKNsY9pC2Ef2jse9kHTqN9itb7a520ZykaKthd0trl5ecTBHsQpgQHXRl99QboQuO8uCb1XCVhlU6+f54e3rLxD5CCdPdi5s1iDpDGQAaly0ZYvLoQV4W+ufLVuitw/hUXAoAmy18OT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVRhPnPS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df1d1b6f8so5242570e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161571; x=1733766371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iw/xxvds+w2MWh0sjhTuvDVbBhBs5XVmK6TyYshqU6A=;
        b=BVRhPnPSfX/TZOwKwZFSzNSu/AbFCfYsnZ2p0ylM1MZc3KJEpG7ghc0jGGLzTj8tj6
         QobIN6D3DR/hQTcEn7jtDH4zo+XfJ0b8Ftdg93erRdd/zJTD8tilGoN7E5gzEXt6BUUY
         Ppw1uUc2vGucP+FqrtcYPD4TJgUZYB3qPpuDu9ACkiGA64/fxLFa1MwOeSSiHfLm/UUE
         2JQs/feMAw6vbGiKHo5MLEFqotjn7sCLOgaaQlDAjBSrWL6EpBmlVm/i04NXiJaztkOq
         DG9fh63Np8itj5HePjvCwg2lR+tAMZg0nMCayaugu+po91Fyetm9b6gP5W5SngoQNDcO
         Lk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161571; x=1733766371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iw/xxvds+w2MWh0sjhTuvDVbBhBs5XVmK6TyYshqU6A=;
        b=U5HybIG0tDPL5URn4y6QKP7/4bRatSLH61GbqgkKO/gWRD7+dFH5zjSucG/tZlHs+O
         lZ/piBJ5EJqJ/JABlOjDbG86H+rJLeXjf2QnNQ4sBVenDvDtcRdWS/79+yaBOjjqj+iK
         E5uFXP3ejO0SB+kR4EvNVg08T6z+CrSp08+vzqTp1o0+oSeiDSbIfGtStRo7L6lQFDpB
         1GYlifKm6RKsuWzX2uBWWJ4AixLR2lds1Xh772jtt0A5Fystpxl0OLQaswX3opmwHEM2
         0WaQNrlTyRs/EopIE2PKoyPUCFA7NmJYBoXy4yxPkQJcpxaJf8pegcnQMfSiZ1Sg2/eN
         f82w==
X-Forwarded-Encrypted: i=1; AJvYcCWFj+nbVj7WRVtkwXGwL26TEzMEWBjuyAGVSEoIP/hilC7B5B1eCUp8ItA5H+W/a0K3m6A/hvBfQjS/f3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyCAecgt+BzYYeG0qXonQILbehD8Mb9iPpP4qPi/JxzBQrS5i
	yTIhnw0AUuEnT8C9/Pi0lY+fQQBNR+RhyKkpZB1XIi0V+QtQYGlnywN2AE1EG4Q=
X-Gm-Gg: ASbGncvxNRuifIsVjKsSCvBrU0Qjw3D03w2sDc48wtsuxcUUYObTTrwE+PIUiucZwqH
	muEpKsbVTJCEbACqOEMmuPc2P/pGq5eBkjNqoAoQs2o/DM4UhhyGVR9dr4Sufj7xfmGyHBmi2q4
	r3NFvw/Y/EXudXxC8TM2TCVWAUxJsVonHTsRNBAx3ApHvkNm1DURBM0ZLZyJ9vluwON74uZt+wW
	ZqTDFY6P5aCoxAsgtKqeFWc0fD5AdpNzSSCiIl+ncJo6cTMdOwL1QSWmy0=
X-Google-Smtp-Source: AGHT+IG5m1sNFbzV0jvCtEDAw9SN64pi0uGmcEIYTY1TLttXsxBoCi5G/jpRVN/yNsEDZbonEvYAwg==
X-Received: by 2002:a05:6512:3b90:b0:53d:a248:983b with SMTP id 2adb3069b0e04-53df0106be7mr13322032e87.42.1733161571325;
        Mon, 02 Dec 2024 09:46:11 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:10 -0800 (PST)
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
	tj@kernel.org,
	void@manifault.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/11 v3] sched/fair: Fix statistics with delayed dequeue
Date: Mon,  2 Dec 2024 18:45:55 +0100
Message-ID: <20241202174606.4074512-1-vincent.guittot@linaro.org>
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

This serie fixes those metrics by creating a new h_nr_runnable that tracks
only tasks that want to run. It renames h_nr_running into h_nr_runnable.

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
sleeping delayed dequeue one. delayed dequeue tasks are considered only
when migrating load as they continue to impact it.

It should be noticed that this serie doesn't fix the problem of delayed
dequeued tasks that can't migrate at wakeup.

Some additional cleanups have been added:
  - move variable declaration at the beginning of pick_next_entity()
    and dequeue_entity() 
  - sched_can_stop_tick() should use cfs.h_nr_queued instead of
    cfs.nr_queued (previously cfs.nr_running) to know how many tasks
    are running in the whole hierarchy instead of how many entities at
    root level

Changes since v2:
- Fix h_nr_runnable after removing h_nr_delayed (reported by Mike and Prateek)
- Move "sched/fair: Fix sched_can_stop_tick() for fair tasks" at the
  beginning of the series so it can be easily backported (asked by Prateek)
- Split "sched/fair: Add new cfs_rq.h_nr_runnable" in 2 patches. One
  for the creation of h_nr_runnable and one for its use (asked by Peter)
- Fix more variable declarations (reported Prateek)


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

Vincent Guittot (10):
  sched/fair: Fix sched_can_stop_tick() for fair tasks
  sched/fair: Rename h_nr_running into h_nr_queued
  sched/fair: Add new cfs_rq.h_nr_runnable
  sched/fair: Use the new cfs_rq.h_nr_runnable
  sched/fair: Removed unsued cfs_rq.h_nr_delayed
  sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
  sched/fair: Remove unused cfs_rq.idle_nr_running
  sched/fair: Rename cfs_rq.nr_running into nr_queued
  sched/fair: Do not try to migrate delayed dequeue task
  sched/fair: Fix variable declaration position

 kernel/sched/core.c  |   4 +-
 kernel/sched/debug.c |  14 ++-
 kernel/sched/fair.c  | 240 ++++++++++++++++++++++++-------------------
 kernel/sched/pelt.c  |   4 +-
 kernel/sched/sched.h |  12 +--
 5 files changed, 153 insertions(+), 121 deletions(-)

-- 
2.43.0


