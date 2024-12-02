Return-Path: <linux-kernel+bounces-427666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9929E0499
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77311685A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB02036EB;
	Mon,  2 Dec 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LerfOYuo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9F202F8C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148491; cv=none; b=mkUzB4bWpNNL/DrG/Ga5491LTCllW8guz1Vyc/brhmZhsNlfthcA+KX1hK4imeZjSWCfrJSEygU1SVf8QAjPl7fqRCyVY6hfoXEUUTjq5O8G8E52l+hgeQU5AhJUNmcCt91pdZiSqEy25tLZodI2CEbAFBBeFGsbqgpl8GNloSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148491; c=relaxed/simple;
	bh=urZqL0IIQs/nJCpHZzmmxLsMB/82JCR8IGuqKHfiajw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nib57kfPzg007Sx5agm8u6xtrPFyEst7QbAJtj1TKS5SxStTAkSofODxT0M8jnW2iriOPpSu9+2p7DMMvpJDfDTMs87z+7zdhPGhopfy9P9HfJBp9zObLaMDr/dIUWTsR4Z5/4TQz7zzMs0PlfNXhMiSOHDSlS3bdiWm5iOhJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LerfOYuo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733148488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMoX0G1hSDcZUUvjrY2vZSqmFJo+w98zvmlvJICE4UA=;
	b=LerfOYuoSbhHIA55ulcNfVoZuGcB7iUVQ2012BVE1dFbIjtN+Yq7P7qU61miITzXvcHnKY
	bPgoeY3MUFp6GxsnwPvDQt6ewsIcUcI1uce9RdCmaIZzUMSEpaT5GdR/D2E7ag90v9YLZG
	Z4SIQVCJILGv7T43a9B3pso8bQY+nu4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-ZB-tYn4CNi-KkxKCLO3hIQ-1; Mon,
 02 Dec 2024 09:08:05 -0500
X-MC-Unique: ZB-tYn4CNi-KkxKCLO3hIQ-1
X-Mimecast-MFC-AGG-ID: ZB-tYn4CNi-KkxKCLO3hIQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0991B1955D91;
	Mon,  2 Dec 2024 14:08:04 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4874195605A;
	Mon,  2 Dec 2024 14:07:59 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/2] sched: Optimise task_mm_cid_work duration
Date: Mon,  2 Dec 2024 15:07:34 +0100
Message-ID: <20241202140735.56368-2-gmonaco@redhat.com>
In-Reply-To: <20241202140735.56368-1-gmonaco@redhat.com>
References: <20241202140735.56368-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The current behaviour of task_mm_cid_work is to loop through all
possible CPUs twice to clean up old mm_cid remotely, this can be a waste
of resources especially on tasks with a CPU affinity.

This patch reduces the CPUs involved in the remote CID cleanup carried
on by task_mm_cid_work.

Using the mm_cidmask for the remote cleanup can considerably reduce the
function runtime in highly isolated environments, where each process has
affinity to a single core.  Likewise, in the worst case, the mask is
equivalent to all possible CPUs and we don't see any difference with the
current behaviour.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..57b50b5952fa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10553,14 +10553,14 @@ static void task_mm_cid_work(struct callback_head *work)
 		return;
 	cidmask = mm_cidmask(mm);
 	/* Clear cids that were not recently used. */
-	for_each_possible_cpu(cpu)
+	for_each_cpu_from(cpu, cidmask)
 		sched_mm_cid_remote_clear_old(mm, cpu);
 	weight = cpumask_weight(cidmask);
 	/*
 	 * Clear cids that are greater or equal to the cidmask weight to
 	 * recompact it.
 	 */
-	for_each_possible_cpu(cpu)
+	for_each_cpu_from(cpu, cidmask)
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
 }
 
-- 
2.47.0


