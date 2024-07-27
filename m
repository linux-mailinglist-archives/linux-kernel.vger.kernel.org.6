Return-Path: <linux-kernel+bounces-264113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD993DF0D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41350286DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907513B286;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iwRCEgP5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8274077
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078150; cv=none; b=mWiRXwJELuPE5wxEVHzgDXX8N9ZwwXUZXneCFr+YowlbvD8++WPV99eJaaSamserZPJSSjSRqAMcdYnsgsO40Cw/32GsT25m1v6dJYqHJ3zORmbG75wDTaVMNrM7Tu8V0l/lyxodQ5f+CKPPvMjAMqH3INUIVeiTrP42ygSqd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078150; c=relaxed/simple;
	bh=0cZialdLEZNPbZyDkuZzRylWBeVlYoMizeLnDMVUCxE=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FKGAX1X39ikj1LJc3bzvcjDMJ4ZB2/eQR4/OkF0ZNc2RQyIBzRgkMFC7wmudr2lvye0M8z1DYpngjpkqR8pD0rmYmX7qCC8PXkBijoFDeo7jejW7up+EyRCq2BsiHd6vK1NwKyjC7doiBEDnObNeOLfbdENXC1qMV5qYztymn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iwRCEgP5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=xsLAhVPjLFIx3JQF2Hi98IC3K1z3J6cnu59IuKi2zBo=; b=iwRCEgP51b3UB9r+vmmjav5IOR
	7r0orQ2pI8tZ0SOHQTGW4kbu8VfQUUrpELfo5hxzyVN+cM4hjseLNtQkG64sw5XE0vt/aRRezrriX
	ZPtg/zH7NvGvM1fTDZF/ld1R+/B5KDpgwCdOdbpvhKdWDUO4bqOcun60FuZ7wxJ2T7JchzogURFQ4
	ORsykQHmT2kfNhvVm3EIZqVvzRdVkPJbW2t+Ydnh2jZb8Mvt5g/DOCvmp7lONQYcVIVsjIzLm6VVd
	MkBTKx5/7+N/dTohmsHDtJ0ZKt+upMaSwRxKt1sQ7A69gqt8ATc2mZBL5WUAKDnhzBAvu5ycSDpxM
	+7myWJ4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-0000000BGJR-1ak0;
	Sat, 27 Jul 2024 11:02:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BC62D303DD8; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.486423066@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 11/24] sched/fair: Assert {set_next,put_prev}_entity() are properly balanced
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Just a little sanity test..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5432,6 +5432,7 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	}
 
 	update_stats_curr_start(cfs_rq, se);
+	SCHED_WARN_ON(cfs_rq->curr);
 	cfs_rq->curr = se;
 
 	/*
@@ -5493,6 +5494,7 @@ static void put_prev_entity(struct cfs_r
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
+	SCHED_WARN_ON(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
 }
 



