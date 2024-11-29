Return-Path: <linux-kernel+bounces-425434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA09DC201
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE14B20E50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B49416A95B;
	Fri, 29 Nov 2024 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g54yiayq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FA143C40
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875355; cv=none; b=hfRLVFIpbjQwImMhPiPD2eyxZbvo6mJQIMOUX1mnZ4oLYPosKXGcYzL/XsM1NKUqRvRJRtFaiw23xyM6GmwRKW+PnDKoZcbFVzbipWd7SG6bvDDZJ7kwyno+A3uf7cvE2WEOSb74XIKPKPRYLFhwSLosCTnxiZKz42VCqeD9cNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875355; c=relaxed/simple;
	bh=LvRZHtwr7NQGBpmS83O3y5MSQ3yHx/Md4Sz0v6BSaNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeuod6/OvMXmEpUUcLKFJDGdk6T5nRf24juZTMD0wo5tq2YjkHjrobKazgeq8hMzG/Qd/PjRavxckJ4vBkwrwLMN8X1iJtKenTJ1CiseWwSnLWXABFNuTPeVwvRrG0uvdg2C5JpFTfEiTg1PAspTjOEUeNXuaCPOWIVJMQ9zHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g54yiayq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FT9P5mB6wZ+ilUmkcp5LzqjA3Y4z/iGrJD4SK4+4b7Q=; b=g54yiayqC/Fu+BEJl3RZ5QEmgf
	ngJ85Lx3XqwI4/+qP0NncfRjdHAIYmYfxcKFNP87Rmuc2InU7+L5e/DFoDJ8ert/OLW6UejHfrhPu
	CfAFiC0/SEw/nJ+gaYCe5c7pGmEub4snGCrR0x78UIAquMdToOa5qhhefF6AgsVYHWgnw5FiUBsGi
	6sqlcnxkXGndvJDI3cXOYXs4bq7k5wFhIlKJ3LiN8OHEsLWwayHTsxikHfBLF8Q51iOXDfu56zVfO
	1B01NoEtRU2lbl+1lOclUNSoLg16iRRX+w8tZy1Q0EQNky2vNc39mNL3iPkz4KXnt9FIZo1Slxc6i
	hpqb4PPA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGy2G-00000003six-3vXF;
	Fri, 29 Nov 2024 10:15:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF4C630026A; Fri, 29 Nov 2024 11:15:41 +0100 (CET)
Date: Fri, 29 Nov 2024 11:15:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
	vineethr@linux.ibm.com
Subject: [PATCH] sched/fair: Untangle NEXT_BUDDY and pick_next_task()
Message-ID: <20241129101541.GA33464@noisy.programming.kicks-ass.net>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-2-adamli@os.amperecomputing.com>
 <670a0d54-e398-4b1f-8a6e-90784e2fdf89@amd.com>
 <20241129095500.GD15382@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129095500.GD15382@noisy.programming.kicks-ass.net>

On Fri, Nov 29, 2024 at 10:55:00AM +0100, Peter Zijlstra wrote:

> Anyway..  I'm sure I started a patch series cleaning up the whole next
> buddy thing months ago (there's more problems here), but I can't seem to
> find it in a hurry :/

There was this..

---
Subject: sched/fair: Untangle NEXT_BUDDY and pick_next_task()
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Nov 29 10:36:59 CET 2024

There are 3 sites using set_next_buddy() and only one is conditional
on NEXT_BUDDY, the other two sites are unconditional; to note:

  - yield_to_task()
  - cgroup dequeue / pick optimization

However, having NEXT_BUDDY control both the wakeup-preemption and the
picking side of things means its near useless.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |    4 ++--
 kernel/sched/features.h |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5613,9 +5613,9 @@ static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	/*
-	 * Enabling NEXT_BUDDY will affect latency but not fairness.
+	 * Picking the ->next buddy will affect latency but not fairness.
 	 */
-	if (sched_feat(NEXT_BUDDY) &&
+	if (sched_feat(PICK_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
 		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -32,6 +32,15 @@ SCHED_FEAT(PREEMPT_SHORT, true)
 SCHED_FEAT(NEXT_BUDDY, false)
 
 /*
+ * Allow completely ignoring cfs_rq->next; which can be set from various
+ * places:
+ *   - NEXT_BUDDY (wakeup preemption)
+ *   - yield_to_task()
+ *   - cgroup dequeue / pick
+ */
+SCHED_FEAT(PICK_BUDDY, true)
+
+/*
  * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
  */
> 
> 

