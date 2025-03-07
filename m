Return-Path: <linux-kernel+bounces-550351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2DAA55E41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668C517818C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0E18DB3E;
	Fri,  7 Mar 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ie24wf0i"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60215E5AE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317716; cv=none; b=G1QX4qQ7ruQXYpV6hj8J+M3wi0RixqFEq5hTjaY3zXOkpzdFlaQP39jFaa2SeL6tUhllPDP1nP8JQpfkGg9NaYTIxFrtH1poRShgOBxpNrgQqX1tXRTIyBvcafOy5RDzV9sMBPdebpZNegJ2RhAcbtvNJMPd24LxY7LaeBduKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317716; c=relaxed/simple;
	bh=vfUupWuT/CI0y8dqXmfwSKYp5cJgBBCdx3FEo5K1txk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCMWq808bMwcT688+f9by8EOSU5UHk4bEe1AHaAj43RJeF7u4zjYJguddZs29+FC5Zl5qLMLwY4g5nz9RLN4xoAwbqv7mYj9VtJbYwbRnP7msLzcFS1/SKjJ/nyPicC4EKfzkbVKkxsJBpX74ct0jCzuq887r9IaHSG3uoyfk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ie24wf0i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2241c95619eso3273365ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 19:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741317714; x=1741922514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMCdRYxU3jIDJTt8GhTn3MSCJbkgxvlunWLY2pxOQfg=;
        b=ie24wf0iuAh3lq33C24Pjsp97pbmFOQEMTsz3BWVMuU1I6N7N0azJQwAOhXt/37n16
         EHPGy6IIjBcrwOEnb3+ES4nNtaXLS+PvFjlO8pYqIPulSvPNk4dH7sFRf7Fyvp4OigIm
         q7w2+D72wiRlNjmIEV9kaRIcg/fT9drTTPQZXL3lG7MNh9tdX50L4l/Kkb2l4+cLYKrl
         ViVKxGpwphtQHB59yNdJQ62Zg3dVstQg7d5mmM692FnQz/sZ0P/5EE5BYrMGtvU11oX8
         yGV+Kv+EtjCW4zMf1+DmUgFZs/Ke7jpUzfklH+4AIjDtEKUczonCNSnYX/ymCKNOOnpn
         Pk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317714; x=1741922514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMCdRYxU3jIDJTt8GhTn3MSCJbkgxvlunWLY2pxOQfg=;
        b=AVCbOQtnshHNTouckiXp3E3wW2BigyggqtVlo59HUp9HhMTz78qtRvLBBUtYkm+lRp
         Gkf1AhljzU8zMTuGyu427z3BRz1V2FHttP3yWsLzPYPa2Uz7Fy9XrgALd+G+qZ20LPj8
         CrWG5UJvhxv94PXuAjPp8kAnu2JE2yE1c7VgaO5+E6JoFmKGHQ9+XLsHfeBenJdQkKed
         jDBRYDpzuOdR5TP5dFfpIo7tyaOSZbZsjidokLIats49d7VZAlXtQzaJ6C/U9beaCTTX
         fNSiYNbrOrPLQMuAZ8eRlh8tiXRFiU/7niu69XF9lVx/oYXZGzj4arRDn7/Y0r4mDW3B
         ZpDg==
X-Forwarded-Encrypted: i=1; AJvYcCUegPFVFWeCc0ajzirHKcuqQYFLA7KV4JBrVjMniE2fMS9qa6hLhstQp04lSj5XWRD2x4tuiGdOPM2SWcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxguc8PJZ1di9DoElRak2CiPmd0lnc13PnjS4Wazh9yksTf+0tI
	eKQ+CQY0YMxWPkYBvioLVy4wzjHW4XaGrX7mzCN0cRhjaCNpH/66XIYRMYPjxF4=
X-Gm-Gg: ASbGncuTZhHUiiGHuIL0pCySoD+w1m+x3bkiU/aKqYC2kLEj/YCZif4uHoFP9LUu4xu
	rnbqgtTcNs5jfT3OHSNgC6J2QNmsmZ25UXUVbJulUaj8QB16OTHLGQxjNOwTS9UlVGmKOYLUNPJ
	f87ciqFo8k96Z9dHPAc7UY+CHlQe7IEpMUtrgHu5qZb2cgPW4uqCDAcbaeyYFFYzjbStQwm8Qw2
	0Gilqx/ix+3Sl/w9mQ6VabhWr8T5i9u1hp+1JTPz7soGPRHpfwMbAV5RsqSlMh8griZAKI4fDtU
	4bV7OlArGCOXZ5h7eWC/bZM7v68PvtRBVsvm3zD7Ir8c2yC2k99I4htMDSMCOxqPscaPdzAh+dG
	f7eR5eXw=
X-Google-Smtp-Source: AGHT+IGmaIpY0Z/CQY7ulPPXkteBnBxDuGNgmPn2D9OfMaqfNH7ddsQ/p8By3MAMdHnRkOth6uUQDw==
X-Received: by 2002:a17:903:2284:b0:223:5e86:efa9 with SMTP id d9443c01a7336-2242889e934mr10475105ad.8.1741317714532;
        Thu, 06 Mar 2025 19:21:54 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8a86sm19847605ad.240.2025.03.06.19.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:21:53 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH v3 1/2] sched/fair: Do not let idle entities preempt others
Date: Fri,  7 Mar 2025 11:21:15 +0800
Message-Id: <20250307032118.30364-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250307032118.30364-1-wuyun.abel@bytedance.com>
References: <20250307032118.30364-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task with SCHED_IDLE policy doesn't preempt others by definition, and
the semantics are intended to be preserved when extending to cgroups
introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").

But current implementation allows idle entities to preempt each other
on wakeup, which seems not behave as expected especially after
commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
so fix this by explicitly skip wakeup preemption for idle entities.

Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Josh Don <joshdon@google.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae0350088ac1..19ae870cbeda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8797,8 +8797,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	pse_is_idle = se_is_idle(pse);
 
 	/*
-	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
-	 * in the inverse case).
+	 * Preempt an idle entity in favor of a non-idle entity.
 	 */
 	if (cse_is_idle && !pse_is_idle) {
 		/*
@@ -8809,7 +8808,10 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		goto preempt;
 	}
 
-	if (cse_is_idle != pse_is_idle)
+	/*
+	 * IDLE entities do not preempt others.
+	 */
+	if (unlikely(pse_is_idle))
 		return;
 
 	/*
-- 
2.37.3


