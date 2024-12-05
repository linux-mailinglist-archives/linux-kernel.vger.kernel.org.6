Return-Path: <linux-kernel+bounces-433988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2FB9E5FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1AF164F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E161BD012;
	Thu,  5 Dec 2024 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsyK1tiW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922E192D69
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433397; cv=none; b=TnefP6GJtfaO0aGpacGydjUtmSIunbU9S/s5jMfDyiJbqVrTxjyk4AmdV3HIHC/aobzB048zjSQmcMtOAclgKm87dinJ9gQGeK21OOUcV+LkBL/ArL3ohKSYvWJRN3oNFS9ycvJYsXYWcKrRTY0KaK3XMeUMCiyMWRWMXUrUpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433397; c=relaxed/simple;
	bh=vGGgM0GnyJCtyw6Kg3r8djHZ/md9FSIpwU6Prq00dW8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=js4D1WwKWchBXK2JqzmJ6OzaUDpVoEDvVdNokrJgDUFvk9VTpydI5mF1HHpL41gfj4G/NX/udx+oe9dbrnQB7r/sXJ8+6XElRtCnYeLr0cO8jsI6ogExQuNAqUPyqCGf/SXP2/6fkvkQTudi8NwMtqOHpz3EezSSR0Tn8wpVfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsyK1tiW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so1604688a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733433395; x=1734038195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9gfuhq9D5CBFs4gTUaju4fePCaFnk6ZxoXmZYmnlTMI=;
        b=nsyK1tiWu649r6k6k+DwM7g83XYGuSPJCYGmRvXvZJ5KWLAD/xc32lYyMNEa7CtnvN
         DUV9dNMHgiTnwP7XcQbxL8PCuz47V9sidIB+wyvQKZFF5ERJ/pwJY0CCL+H7ug62guyl
         iMvyQJC+VlGSMi5fJYWdH8GzbOqEzqk3oziBh7ueDAiczMgyWCBo92N1u9MIaNO1vBYt
         q0ss4FAe3VZoYatKqU2sr8vqXXzLPJKpX9PCKiFcmUtpYIyJ199vX2ToHdbv9tJhBmv0
         H0Kg9PljBm3zE/OPafJtbNGQypREcLQw3l/f0F2U3ZQ8RKi7ww7rzuTovKvvuZXpDIa+
         tdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733433395; x=1734038195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gfuhq9D5CBFs4gTUaju4fePCaFnk6ZxoXmZYmnlTMI=;
        b=eKxjoXkij8gkjQ350yCUvZxcY6rV6LYgv5XD3KztNVMzGIUsQ2MK72tGOTBZsyAT3/
         YNHKTBZ6CrGt0l8HL5USdZkHWgToUXIyGbZnmgucbnuAkhh6z570ps8lP+KaMmKq9LEz
         RJfglf7gISsK6tNYnlPWRtYxg5xEtPIwaajBAyW7leWZDpjhGO2SGI7AF15aZ7VMTgKD
         0HFrUBc5FswRMoa00RDKYYeKC2dgZexNd6+a5/UxDv09M0/vksXxi0j0jc/xVvZoI3gp
         lNFf9H7RHfnOa2702gji02GQu5jkcTNw2bZ4CTYb3BjVhT3A3plHA4Jql21qay1tquNx
         up4g==
X-Gm-Message-State: AOJu0YyEoVzoVZCG03H04A09lmwt4p/qES7mbs3jjfJLrkDwaroh345+
	1gfsqz68eK+sSjAOgRwunXEAPCfyk+T5W7uKlRdHrihq9CUltjiEEY+tB4rKeIfi0DK4FjjRM6H
	FHGtSBnfCFR5ZTnSqTBjPtCkdNRYL4PFwNkCaOK9+tbmNfdI6BVOTG7g5tEfj9wLW7jq7fWXsYx
	4BjH9mdu/YUGArYxoX9JS3GV2o9f3HmffF2OjXuq3elP95
X-Google-Smtp-Source: AGHT+IGXhxNDlGUCq2Ye5eKkHlsyF6zNMLSYjESrA6IVrrq9cQ+92LXQrlxFg702sQv2opg5OjKhlxRGZzw+
X-Received: from pjbhl7.prod.google.com ([2002:a17:90b:1347:b0:2ea:adc3:8daa])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfc4:b0:2ee:8c98:a965
 with SMTP id 98e67ed59e1d1-2ef6ab271a0mr743808a91.34.1733433395478; Thu, 05
 Dec 2024 13:16:35 -0800 (PST)
Date: Thu,  5 Dec 2024 13:16:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205211632.1181715-1-jstultz@google.com>
Subject: [RFC][PATCH] sched: deadline: Remove unnecessary goto label in pick_earliest_pushable_dl_task
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Wanpeng Li <wanpeng.li@linux.intel.com>, 
	Todd Kjos <tkjos@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
added an odd goto label that seems to be unnecssary, given its
called unconditionally from the bottom of a while loop and the
label is at the top.

Thus, clean it up and remove the label/goto.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Wanpeng Li <wanpeng.li@linux.intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: kernel-team@android.com
Fixes: 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
Reported-by: Todd Kjos <tkjos@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/deadline.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a61..566a05efa4e57 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2501,8 +2501,6 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 		return NULL;
 
 	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
-
-next_node:
 	if (next_node) {
 		p = __node_2_pdl(next_node);
 
@@ -2510,7 +2508,6 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 			return p;
 
 		next_node = rb_next(next_node);
-		goto next_node;
 	}
 
 	return NULL;
-- 
2.47.0.338.g60cca15819-goog


