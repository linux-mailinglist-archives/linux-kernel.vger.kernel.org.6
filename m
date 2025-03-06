Return-Path: <linux-kernel+bounces-549092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609CA54D16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563BD188B0DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403716130C;
	Thu,  6 Mar 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTzLXF9G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057F155308
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270269; cv=none; b=oxnR4MfALCNZQWKLVWsAFFa4wNzDZsNgluo0OKPVCFxJ15Z0wsIOwALzPk1S7iU/w7C5D8eFKVmZG4PuqMrCA0NSE8RAorYgZ98Do42bQR66osDXBNbViHRnvqYC7fA+ygjdbAuSU2BIls1lYvSLn3c4Mmux/d2DOe9nTiBiVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270269; c=relaxed/simple;
	bh=cplnuDUbV4SAYo0qglwwGQchejE9iVs1NjhsTNgnpto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Id0Dadc3Qqut8iugJ0gAYPW+oGc1wjLLZRpoLna/14f50qlyl8Kd9tKl/rEuAKs7FKxZ7G3ab5L+4bUSWszyg1Xet7I5hVZ/Z6plq5orVLzhS5I/LNSCdVhKc3BTq6svf9tqlPS9ibD+vGlxbTMG4W5icqF0LaZjlMPCNGPDIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTzLXF9G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCUje7imDL8b0wxv56NHBIYICMyM6jGJVE452JEQ/Q=;
	b=dTzLXF9GHpk06HuCwmg1dm85ewtfsGAQQK5/Uf+cmEj5srQaqg5jVnAh4o70W0ICHMvMDE
	31pTg0MQMe+zH8qCabMlERLtOIP/03Wem4HBRWIC4sXLQqd/xfBH5w0Aop3hOG5NQwdin2
	LnIMAdI5JwMUtp9RxXhPVbtnouKRXM0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-9nW-f7elNjWlaVCzXQoL4w-1; Thu, 06 Mar 2025 09:11:05 -0500
X-MC-Unique: 9nW-f7elNjWlaVCzXQoL4w-1
X-Mimecast-MFC-AGG-ID: 9nW-f7elNjWlaVCzXQoL4w_1741270265
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0a89afcaaso147400785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270265; x=1741875065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kCUje7imDL8b0wxv56NHBIYICMyM6jGJVE452JEQ/Q=;
        b=AtdIfhjzu0OpFcjy3GkSNCyjTvl7eq5sRcQKRJCDD7eX+fTCVCydJzju+fcHaXTicX
         k135rp/eIb2z4p4UMmYYFym1dtKDjk5WeLxRrPzgZ/qDype45Dz/IXKRHLpKDFFUnBmo
         8tRIadQ3X1J9Db8BqCfX3BTWvFod1z3VOcG0DPTVWiXcYv29NUqclar4i+iY9tJvJ7Eh
         vuFi8GkzEJOZBun1uVzqN43ewGRkNa7p4SB0nUUc6bxfi/nU04hYHC+jpd03Xtg4khX6
         Gpbhq4mpiMXUL4rl2N+Qr2GYq/To5enYe0Fyi8ZOJne7iTN88XjJWJ87MQcJJzw/BCbu
         +MVg==
X-Gm-Message-State: AOJu0Yx3pk6pt4jybZc6i9YR0/c5kkm7qYfbVn7HyWiPAniCU4SWIrBE
	pkPmnYH+4ehg/kSXdOrGcz/qFMMAMVYOAz3yqZ/67Qrq+sK4cG6BQC3IOpf/A/bdOWloldtWYDc
	i56btQoRbi0tDVLmP5nImQ8Flr8cD2V5s1SN/jnMZxvUUGP3K3GqSz/e19uoIBc99SUk0tUKiHJ
	YqSIkvlRd7vZIrTvf6GImWYYz987DUTqUDk6a9y8GBYgHsViApcRA=
X-Gm-Gg: ASbGnctvdUKViKgoZ9Fydh1KS5NpOyxwlYRBkv+1RC1k02hDSkufTb/r0GkLunEXaLF
	vki2zeBdqxNE/xclIj2TqPHLcnhYeg2OdCijWwTYNvbtc+n+lsceHYaH/rDkoPck2CZun59hmYz
	CV8W1WJ6D2Mf17R0FE42hBhP5QdKTVGQnzoEl7L3iUcB80t8/bAPWUhzlBX6CeKcn6OdW61BaCG
	ZN9CBpNl7rghzWcdb+RDZvess4uIhJy9BtH8AYHv2rg/lOJuGEgWQe1nzfLyLeeoWy/nwpLo4t+
	2Nl0KcV5W6QBi2xtCK1oH7mECBj+PerCg1OsyefkD5/tPQQj1IL07NA9YX7SGQskbzUF0v5sgWi
	0deS7
X-Received: by 2002:a05:620a:6287:b0:7c0:9fab:bee with SMTP id af79cd13be357-7c3e39d9226mr498957285a.10.1741270265145;
        Thu, 06 Mar 2025 06:11:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyPK8COEy50ocv6BjRYPq5igje9OSBoylwKnvL6uU29QylUOyC7S13wYPM+quAriw2L+vvEw==
X-Received: by 2002:a05:620a:6287:b0:7c0:9fab:bee with SMTP id af79cd13be357-7c3e39d9226mr498952285a.10.1741270264818;
        Thu, 06 Mar 2025 06:11:04 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:02 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 5/8] sched/topology: Remove redundant dl_clear_root_domain call
Date: Thu,  6 Mar 2025 14:10:13 +0000
Message-ID: <20250306141016.268313-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/topology.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 363ad268a25b..df2d94a57e84 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2720,21 +2720,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
-			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
-				struct root_domain *rd;
-
-				/*
-				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.
-				 * Tasks contribution will be then recomputed
-				 * in function dl_update_tasks_root_domain(),
-				 * dl_servers contribution in function
-				 * dl_restore_server_root_domain().
-				 */
-				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
-				dl_clear_root_domain(rd);
+			    dattrs_equal(dattr_cur, i, dattr_new, j))
 				goto match1;
-			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
-- 
2.48.1


