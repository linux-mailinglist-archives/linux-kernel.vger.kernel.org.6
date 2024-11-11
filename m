Return-Path: <linux-kernel+bounces-404546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578A9C44F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14E71F221D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0041AA7BA;
	Mon, 11 Nov 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL+aLkKQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572AD1AA79E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349675; cv=none; b=gFQTopaPNBSU6h9T9qM8p6yJy30G8oO9I1VI+U1y13v0A2OL1Jt0OoUPVEVY1dBzaQrHERMYmEM2bfQtRRlnSOvwolySfUMj3CgFLUy6lvReoY24Tso6tmEuXSzskTdMCTCLhu2Ug7UACYFrdqaFY2f8VwCCatwr8rJpXUBbUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349675; c=relaxed/simple;
	bh=TacRJLWtW+il1MlX8++3AWxShM/ENIfN+lQoiOFK7DM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=opw3YbooTLqQ9aOkGag0wBP1VpYxHEAuQ6WI92pWkpvyU7QvkwRqCZxkrhEmPDtY/58Y6F3WZxcj0HDGjemE0kehQqgy0NtaQrzytQcxitpxVafIR9jJYjQE4mFJ35gZ0k7XDioVWUQuuOWi0XxDhZnlnHN3Oq96HejpkUW/ISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TL+aLkKQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshdon.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33aad097so63641787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731349673; x=1731954473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sV6g42oDlhAKo0F1/9c6FybD/fXPCC+K+ARsyW7ToDw=;
        b=TL+aLkKQ7+D1KyRWKmA+GPBbp3WofJKD9ofAizWicRYaGzzrZcZB+jmJfPNi2Rlttp
         k5UojMeWoDEZ8c8QdVrGPj1fKcFn6qyz4Rl9yLk+Rl+l04Imkc+cmWjQGiDH63Ehmlhp
         3K3Cc+ASHmmnI5QLuyiGnDGtnE0fe5N01ITvE/VJx9Nx/zDMRHE6J3LDSmRfl4TpgBUf
         shelsUljnc4xPDxYwZ2V1IVoK5APbVhxa8wzVYFfEGsdwxe1q1GNQa35aHm6Rm23gOuC
         PVxt6xqFkWyDp+VnW+ionTEAIvBfZjV7Ff+N1hkNTW0YNFAh8jsX44L6MnxAOizs7Y6B
         R7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349673; x=1731954473;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sV6g42oDlhAKo0F1/9c6FybD/fXPCC+K+ARsyW7ToDw=;
        b=nvC29/UbGTu9JilqR6PCP9vmwhY7zpWctV1QaCtRY2Pp8sujiLYCdFiulGwYHHr+8N
         8m6o+UmCoaAKGkKMmWn+fLQyDH8vtMX/BhmWU2esZdmmnDLP7DjQUhaCFGGVOikHQqkX
         0uxj2KhV0bPgnmsSKozV45CaCIhReWRpg9r97JvzYsw3p87uj5Pp0gxOq/uGDZeG/4Bb
         PR1obG8XO0XUmRQ/Rzl7MZaqDiuApzfV9kjN1F7FM/vNlWHlVkFkSKiLsD+7ie4YTRFI
         dU6kU+TWgzIrqLRs0BzG5Ncwyo+zrRqHgxHJwUpoBprHhE3hksExhRBkZt+Zm41GrxeJ
         /iiw==
X-Forwarded-Encrypted: i=1; AJvYcCXYDmoC9yr0VexDRlQaoXgHQonU4VQHyHG0WhX53qOdYBbnnBdMEqhZWcuoXI8jQ23iJm/yMkq6j25sX5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjHeg7AVK+ogXAwpKt1gPCy4sJGRN2P/RwX8w24y2dQqIBvh1
	VKOmbwvApQJzHuV2BXsasUXEVaq+jSWNWZ9ViDnAPbzSoUtbNSMCPQgaxyyECFMNg7ji/3WKMjg
	7lyw0vQ==
X-Google-Smtp-Source: AGHT+IGQ/0TQ4fd/2WU8HWEoDI2y4tGavfQznw7zXKsGUDtB13IIwfKqPuAAtNyAkpYUQ3rpB5kGlUABqhhW
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2c5:11:dc4c:1d68:7784:933e])
 (user=joshdon job=sendgmr) by 2002:a5b:350:0:b0:e30:bdc8:567f with SMTP id
 3f1490d57ef6-e338006e989mr73100276.4.1731349673259; Mon, 11 Nov 2024 10:27:53
 -0800 (PST)
Date: Mon, 11 Nov 2024 10:27:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111182738.1832953-1-joshdon@google.com>
Subject: [PATCH] sched: fix warning in sched_setaffinity
From: Josh Don <joshdon@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Josh Don <joshdon@google.com>, Waiman Long <longman@redhat.com>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
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
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Acked-and-tested-by: Vincent Guittot <vincent.guittot@linaro.org>
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


