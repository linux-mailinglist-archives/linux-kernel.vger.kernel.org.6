Return-Path: <linux-kernel+bounces-269739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB794364B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A9E1C20DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D49482DD;
	Wed, 31 Jul 2024 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf6MG3GI"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CF3E47B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453295; cv=none; b=gAKACE3eY+ZeRnTijn/ADTxI/vsPsOGGG3zJsLOalaPtKWdB8VRHSQQWrTBeoHKfb+lh7/SLlLKBVfHLq8MzYT7g7qDSsS1wA/cPM2d5Fn5HUNK7mz16CgxM175Nw5RVp+hTs1oZThq3W0iKwul8f4qluzfutJ+VrlHtjpkH/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453295; c=relaxed/simple;
	bh=rRCOCYSmFjKx4SE81PTJy5b4Dil+gdMepEKwHmKSmRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7MvoG1DoDC/KLamVOvzLacGgLKBEE8LTSgl7qYFYb4okRuuj+/hyHjt5iZ1V9LUIellHHD5SGjvdhDhAUNjs06U4kycOOAsY9Buma9+UYylwqVScOedg6Foo3LOdPy+r9K/bEfNAugwD1dOo05HLM7NZ1+/8wgHt28kQK7zOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf6MG3GI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d316f0060so951801b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722453293; x=1723058093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMJuCjjvh0dIEErgaCQdGQqvdNt4+tRNis2AfV6HuQk=;
        b=lf6MG3GI/hmuhp2X8jFVvStSmg5Jbr2NLQyluHkfI6bOrfhU7Mk+vGUcwGZ5p1tORw
         lQJd4OtvgyPJsB0x4b6musnaWCOXOs6T0+fT07UbaHQuzi/ZxPDnUxlRzbv5u77znH5h
         HIm+4+bWBeYTegcIPEpqFkSG4xsJmUAXa72sromqUHy+IXKRZOI9i3wvSDFpLFRweyws
         rGm465KK9jeUFaviAz7R8rSk6GFyakDaFdm3NWbdO75iggzo8UffSlKM1htNuq5wNYA/
         YKrGgOeG4yApgyM+ZjYM+4dJexKRCqzPgzN9VBNYWR+wNuGl+DOVBT3PXCussffGCoki
         /ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722453293; x=1723058093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMJuCjjvh0dIEErgaCQdGQqvdNt4+tRNis2AfV6HuQk=;
        b=efzGYN2qc18tGT1Bnx/jSoIvMXSpbk2fOACZoltXcf14LY8AW9K4DaQ5QPlAUsyzbU
         dDVYijQUrssp79Yksz69SFs3edN09KmQQpq+XlTTI8/+0jS8RYX3iNsdUKlELAx4MNLc
         GSPgsyYm8FBosbyxCbY5V7eFj9lRQsQQBLO6xIJ3HyXB+kV8Z9BZary5Uqy6SdUfHhN2
         4rnbSV+AVZ5PKa+vDfkym6PWiP2CfJyOq6tuh5BYq7uq68WiischjRO5ncIIz3boM1cM
         yTakVVmqn5V+JdYXB7xPlc6Bz3bzN4M87BgJ9GrIWwvu+dX4h4Hd75KRTpY8YllOaxTm
         /Byw==
X-Forwarded-Encrypted: i=1; AJvYcCVXYYKc103luq1Y0O7jS5OShsHSWWEB8hSRAgImhpvt9AyyQlWMlxJdD+eHZwkCt0rh3PtjwdCsm7AxRBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzMBNzFNIX1C15CsYJl5UlRBNda9EvbQa+Dx8PFI+Njg7ETKs
	+/FBF0tvy4nEntAMNqEn9TEyGv8afqu9ShpTtL9lKcKOMIZV3z7gsPmhJg==
X-Google-Smtp-Source: AGHT+IFFjGmMG8WYzI8pVUSK+usVdKaBPH2TY+a3VPUvhcBnK/FGcdWn7mMp8Z8rqQv2gDI5vS2QnQ==
X-Received: by 2002:a05:6a21:32a7:b0:1c0:f09c:1b98 with SMTP id adf61e73a8af0-1c4e47755bemr12173711637.16.1722453293432;
        Wed, 31 Jul 2024 12:14:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c6ff4bsm9383091a12.4.2024.07.31.12.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:14:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jul 2024 09:14:52 -1000
From: Tejun Heo <tj@kernel.org>
To: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12] sched_ext: Allow p->scx.disallow only
 while loading
Message-ID: <ZqqNLNWLfjsJ2E02@slm.duckdns.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
 <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
 <ZpgERphu--gPn235@slm.duckdns.org>
 <7d39f26d-3c9f-4ee4-977c-87f9bed0bac1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d39f26d-3c9f-4ee4-977c-87f9bed0bac1@huawei.com>

p->scx.disallow provides a way for the BPF scheduler to reject certain tasks
from attaching. It's currently allowed for both the load and fork paths;
however, the latter doesn't actually work as p->sched_class is already set
by the time scx_ops_init_task() is called during fork.

This is a convenience feature which is mostly useful from the load path
anyway. Allow it only from the load path.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
Link: http://lkml.kernel.org/r/20240711110720.1285-1-zhangqiao22@huawei.com
Fixes: 7bb6f0810ecf ("sched_ext: Allow BPF schedulers to disallow specific tasks from joining SCHED_EXT")
---
 include/linux/sched/ext.h |   11 ++++++-----
 kernel/sched/ext.c        |   14 ++++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -181,11 +181,12 @@ struct sched_ext_entity {
 	 * If set, reject future sched_setscheduler(2) calls updating the policy
 	 * to %SCHED_EXT with -%EACCES.
 	 *
-	 * If set from ops.init_task() and the task's policy is already
-	 * %SCHED_EXT, which can happen while the BPF scheduler is being loaded
-	 * or by inhering the parent's policy during fork, the task's policy is
-	 * rejected and forcefully reverted to %SCHED_NORMAL. The number of
-	 * such events are reported through /sys/kernel/debug/sched_ext::nr_rejected.
+	 * Can be set from ops.init_task() while the BPF scheduler is being
+	 * loaded (!scx_init_task_args->fork). If set and the task's policy is
+	 * already %SCHED_EXT, the task's policy is rejected and forcefully
+	 * reverted to %SCHED_NORMAL. The number of such events are reported
+	 * through /sys/kernel/debug/sched_ext::nr_rejected. Setting this flag
+	 * during fork is not allowed.
 	 */
 	bool			disallow;	/* reject switching into SCX */
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3399,18 +3399,17 @@ static int scx_ops_init_task(struct task
 
 	scx_set_task_state(p, SCX_TASK_INIT);
 
-	if (p->scx.disallow) {
+	if (!fork && p->scx.disallow) {
 		struct rq *rq;
 		struct rq_flags rf;
 
 		rq = task_rq_lock(p, &rf);
 
 		/*
-		 * We're either in fork or load path and @p->policy will be
-		 * applied right after. Reverting @p->policy here and rejecting
-		 * %SCHED_EXT transitions from scx_check_setscheduler()
-		 * guarantees that if ops.init_task() sets @p->disallow, @p can
-		 * never be in SCX.
+		 * We're in the load path and @p->policy will be applied right
+		 * after. Reverting @p->policy here and rejecting %SCHED_EXT
+		 * transitions from scx_check_setscheduler() guarantees that if
+		 * ops.init_task() sets @p->disallow, @p can never be in SCX.
 		 */
 		if (p->policy == SCHED_EXT) {
 			p->policy = SCHED_NORMAL;
@@ -3418,6 +3417,9 @@ static int scx_ops_init_task(struct task
 		}
 
 		task_rq_unlock(rq, p, &rf);
+	} else if (p->scx.disallow) {
+		scx_ops_error("ops.init_task() set task->scx.disallow for %s[%d] during fork",
+			      p->comm, p->pid);
 	}
 
 	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;

