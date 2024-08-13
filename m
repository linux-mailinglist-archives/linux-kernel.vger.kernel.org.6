Return-Path: <linux-kernel+bounces-285576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE3950FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B644BB23556
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD51AC42C;
	Tue, 13 Aug 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k71KYgKA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633861AB512
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589440; cv=none; b=IU649i0gffxT9sIiKOsQCbjudgMiMT8DXBlpn2JBQ5JBMI87ozKuvS3vvszQhzq088oPjozY8exViA+T1HtZFEc0rPoepR2YbNjodYSAUzYFXEynnYg/+tmIVp7NwYsafowErIHD7tJhQcEbTvsgdXYa92Dx4YvHu8SlmfW1QeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589440; c=relaxed/simple;
	bh=IjGyIR1ybwl2f+NOIyS2e5TbqO3Xbxq3C7XGh+QuLF0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iA0jhnUaxt9cvyG3ybmz+zIji37XzLeD/zhWrEYfibm983J2xuOiEmSjmPDDKlfUOygN7AlCPm/N0MqdCY7rF5o9i8D5LZU1qcc4SozTBNtLfuMQdMy86bLH23FAi/koIv43DhQwkrQu1NgTDUKx9zWExsGhfBaAEC9mOkLdR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k71KYgKA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=3hSSlKjAiFgV8m6vC2/ajtpmW/+xwn+/awkIsESMp/4=; b=k71KYgKAgU0+6lt5+AqrNwQpt0
	VpQ+Q0wLE8Vy+TZ3HLPgiXbqprNM44oi6CCKpsIYTxorxdRQ2teq4dSuiO8wN2rhryQbdFUWGRKbq
	SGC11grIk3HHZwXnX33Y3MlUI0mntawW7C4nV4iavQSnOX+FDHI6ssJiGEftr8BUtmjYlPTshpS4V
	yUyvbkI0q9Fz3YY25m7zw3iSUPFDNe5M6OZAqf9+mqCoCzjBL3ONSqc37cCHDJRCIb4jN6eTc97vp
	sGKkSYlW7w0+LfHGFyBJgRjA/Ss0JshjCWGgIp9b06BBusECKY4vi9sLxPFg51L7p60Ggo7ksRYjW
	m0fnH4Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LW-0000000H9ZU-0KWH;
	Tue, 13 Aug 2024 22:50:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 314FA300230; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224015.614146342@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 tj@kernel.org,
 void@manifault.com
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 joelaf@google.com
Subject: [PATCH 1/9] sched: Use set_next_task(.first) where required
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Turns out the core_sched bits forgot to use the
set_next_task(.first=true) variant. Notably:

  pick_next_task() := pick_task() + set_next_task(.first = true)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |    4 ++--
 kernel/sched/sched.h |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6010,7 +6010,7 @@ pick_next_task(struct rq *rq, struct tas
 		next = rq->core_pick;
 		if (next != prev) {
 			put_prev_task(rq, prev);
-			set_next_task(rq, next);
+			set_next_task_first(rq, next);
 		}
 
 		rq->core_pick = NULL;
@@ -6184,7 +6184,7 @@ pick_next_task(struct rq *rq, struct tas
 	}
 
 out_set_next:
-	set_next_task(rq, next);
+	set_next_task_first(rq, next);
 out:
 	if (rq->core->core_forceidle_count && next == rq->idle)
 		queue_core_balance(rq);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2363,6 +2363,10 @@ static inline void set_next_task(struct
 	next->sched_class->set_next_task(rq, next, false);
 }
 
+static inline void set_next_task_first(struct rq *rq, struct task_struct *next)
+{
+	next->sched_class->set_next_task(rq, next, true);
+}
 
 /*
  * Helper to define a sched_class instance; each one is placed in a separate



