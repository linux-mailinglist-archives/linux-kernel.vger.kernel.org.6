Return-Path: <linux-kernel+bounces-307761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3296529F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C241284FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C81BAECB;
	Thu, 29 Aug 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DClS5cU0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9713AC28
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969098; cv=none; b=ZgY8tfj7w9gSAUYrZbX6Au4jZHYkNCXzru5IZm1qwLsrqlIZEyYFdQVOzdz0DFPaeoXJWKZXtWlUALRUvMPNodiWgkF83U4NZ51q0wenbKtfjyqHrKiS5kIPWMg70yfgXxN60DCYOuxb6FvOwneTUwPnzQxgryZPH7StiHAZ9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969098; c=relaxed/simple;
	bh=zhcjouZHwCISY2IJdiD52KCYqgDNhFs8X/qRYb472QA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L5ZUFNChjFILaikAeaB3OSbW6nsvCNYAYYHSz6ckAfJvWDzCyj7wIP7GDqy406YXy7qyE/GCiCUOPEX5Pi3CdVGb6fe+wgaDKqHEXEjdEIS7eArv55HO6l7GJ3zv7jZa6jfijqbGjd/8yptv0Z4XD3rT/lPIeqEw8anmzaZlXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DClS5cU0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b46d8bc153so22994347b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724969096; x=1725573896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0HFVJ/GJxZ1gAo+c0QJO2FJ3bTYiTMd2A5zv8fPeza8=;
        b=DClS5cU02bhqZXAh01Gm5APU1OzH2Gf4w/WPOPwVWbVxQcr8i1h4ZuP+ylJVZtSEp+
         tumStCVowgEEpJjUpkTAogp8edwWVPVfjajqxACEU98tJpEttp+wbNFLe3BRp1XJUUuk
         csv1PzqC4VIckl30EWMysHHDiQw34kbUuiZlak4b2IgrFNno9TCIkifSW6/r26BZXa4w
         a0+ExR4bhyKJhGMthUYx2zhGTrZ/7fPTSmaLgoz1zUS7kZy8QD3hc/g12XznI8Y2u2ET
         yIoMaQMQU2VaX8pPdPq4okKStXQlh53Mo1SU2bcMV3YUhqclO4HiY1AHV2nV6JGZrNoq
         PUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724969096; x=1725573896;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HFVJ/GJxZ1gAo+c0QJO2FJ3bTYiTMd2A5zv8fPeza8=;
        b=BD0gReH6MBb3CJnQibnfy3mU3Uf/FwPiXgEAyjeDyQsm1qTRIsz5icwEYI3/K5rdKa
         z5EEg/MtBfpqckYYR532luIG2VC8a1xWgIQxLgLvg5VG4j4q6IOoqFKVQVtqw7F1GAzx
         WDG4DVZqzGm9ulVqB5R1aQPGLuIRESrblbpOpHYwDg/P7T0+RKxHRi8GbP+u2YAWMmFq
         o9NwDkBajg98LvjWgDVQomzrqbwQkhlSZsoJEiozI8y/e/jM8LqjYyIVzKnkX8VuWPQw
         +7o8YG78TqphS26l9B2c3FHzLAfHMAMzxntU2vAJBHjCbFveNy1te+fEbDldrqBDQ063
         ZqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1ENbsbotr87zTP1/aC0K6IKuyLMvfO5vM1v5QAQ/Ukdsjgt+cbl3TALqyGRG7DH1oPRfRe8NRxPGuh50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ggQCZgC8Ns4gN832XrrlTFK4kmd0HqnzKOKCtnGA7Hsl6OYq
	y7/G8TS1svtn8rQdnxqlgMvVrP21ChZonr5Sxz79nr0++qDLEfcK3xQDj6WYLxWWW4JqT8HsVih
	VpTZ5pQ==
X-Google-Smtp-Source: AGHT+IGcl57kd1LqtJtYsdt3M24id4lK1gTtRsfYiUjko/3W67c5XhgUPNEl2/0ENVi0RqyJ7Vcnmid/mgvX
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:d6:f7ce:2240:638e])
 (user=joshdon job=sendgmr) by 2002:a25:2e46:0:b0:e11:5a2a:8067 with SMTP id
 3f1490d57ef6-e1a7a15be13mr375276.6.1724969096011; Thu, 29 Aug 2024 15:04:56
 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:04:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829220427.2764399-1-joshdon@google.com>
Subject: [PATCH] sched: fix warning in sched_setaffinity
From: Josh Don <joshdon@google.com>
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
a WARN when a per-task affinity assignment races with a cpuset update.

Specifically, we can have a race where a cpuset update results in the
task affinity no longer being a subset of the cpuset. That's fine; we
have a fallback to instead use the cpuset mask. However, we have a WARN
set up that will trigger if the cpuset mask has no overlap at all with
the requested task affinity. This shouldn't be a warning condition; its
trivial to create this condition.

Reproduced the warning by the following setup:

- $PID inside a cpuset cgroup
- another thread repeatedly switching the cpuset cpus from 1-2 to just 1
- another thread repeatedly setting the $PID affinity (via taskset) to 2

Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask")
Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 4fae3cf25a3a..3a88f7c0cb69 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1321,7 +1321,7 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 			bool empty = !cpumask_and(new_mask, new_mask,
 						  ctx->user_mask);
 
-			if (WARN_ON_ONCE(empty))
+			if (empty)
 				cpumask_copy(new_mask, cpus_allowed);
 		}
 		__set_cpus_allowed_ptr(p, ctx);
-- 
2.46.0.469.g59c65b2a67-goog


