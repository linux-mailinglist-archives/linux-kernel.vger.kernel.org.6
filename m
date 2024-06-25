Return-Path: <linux-kernel+bounces-228990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7886916979
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22912B23ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4121916B747;
	Tue, 25 Jun 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3f+cNs0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E81607B0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323576; cv=none; b=NUOkNBWTIXd0zysHU73zYN4GFy19ctUn5PS0shjh/c4wICBI+w5t7p2xeb0OwfupnxHaTM38K6PDmRBpccXKll8LPe/pHXzlRQm3ehRf+5LtA5cKhwVHjjk9kR2BurkK829WpXsZ/r/fmsRLgXsXj17R441tote47Qed5UcG8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323576; c=relaxed/simple;
	bh=ku8xq4mkvyOVgfWzpgtzoN0rLYNOKZuKetn2NDoCUSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZaaynqqH0J5/TFIurHAHHmwEnOxmdvLxQdX6XYQ1yVrZXemZ5S4WxJVb65k1QxsUdzBr7I3JcyeZUu/DtX8432cQwOveOru9KV3KkiXfuWVb3Jh67G4SPSVEsH/xs6Kat7qCaFFh2KMQNcJ/yz8O0Dl93cdcjswxuYTtfwhVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3f+cNs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C06C32786;
	Tue, 25 Jun 2024 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323576;
	bh=ku8xq4mkvyOVgfWzpgtzoN0rLYNOKZuKetn2NDoCUSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3f+cNs0CJ6m1YlCQXcy1Leh2t4bIXi63yq905R2Up5s7E+Q3et4XpbCFSWDpMEus
	 ogivtCtNLGLFrqL3BXUXRBfN6DudgsSDNrI3loJAzN86jpNC1/C2I+nmSd/3Jv1gQC
	 8T0fNrK2vLZ2gExC01nOcc5AvhQ3Avw00W7socnThgl2rsYU+M3hLzMzPRo8neEjPQ
	 7+E1eNzdzZzhDNC05QTGoMUw9Y5OhukcW69JsXnnTdmQNLNT7znCFsMCqaZWkherKB
	 QtOWRs3XRgpjFSRvlYGxdylPJT9qX7lJJLT1YNum5D1Ks5lBCggC/ohG+WFm8RJsmo
	 Xp3o/BRk0QwBA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 2/6] sched/fair: Use task_work_queued() on numa_work
Date: Tue, 25 Jun 2024 15:52:40 +0200
Message-ID: <20240625135244.20227-3-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625135244.20227-1-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the ad-hoc implementation of task_work_queued().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..619ef8bd1486 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3213,7 +3213,6 @@ static void task_numa_work(struct callback_head *work)
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
-	work->next = work;
 	/*
 	 * Who cares about NUMA placement when they're dying.
 	 *
@@ -3456,7 +3455,6 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
 	p->numa_migrate_retry		= 0;
 	/* Protect against double add, see task_tick_numa and task_numa_work */
-	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
 	p->numa_pages_migrated		= 0;
 	p->total_numa_faults		= 0;
@@ -3497,7 +3495,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	/*
 	 * We don't care about NUMA placement if we don't have memory.
 	 */
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || task_work_queued(work))
 		return;
 
 	/*
-- 
2.45.2


