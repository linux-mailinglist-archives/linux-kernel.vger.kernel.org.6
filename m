Return-Path: <linux-kernel+bounces-229041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698F916A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85BF1C22277
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914C130AFF;
	Tue, 25 Jun 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNGRFV+W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E0BE71
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325131; cv=none; b=uMlC6QNeeqRJBvYpZnENDmcB9zw9a72DcR3xkt8Fsow6u159+K59cwPWwnVw1UTdUOJH47CUwPh0l6Hn9i/N04/bailWo1ocWDOdM7J6/JrTGete00PUpMGRyFxpEfL4zumH3BrREMqtLWmkZe9/XW1TjsYLqNGSPBQOpaIIbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325131; c=relaxed/simple;
	bh=+kgCw8pTWMAs/9+U/PTwL3LexQ+5maDizI3iW1dcE9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHRsEX0mCdSEf5PjGpTHXc1yfzxpQgTyr71eyAvjO538qmZACUmL+zOnBH0yCHNPKEEIexPeMQ9FuFYAK2vnlvuBzp6gffejzUGq3OP1onXfBPnl1VHSLYFNzsOLAJYeOWlXpBHi8AyVIgouwcixJCbDnZUERWiQckdu9hxozw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNGRFV+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719325129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjpx78rmMvRPtMOT3YYa62STbuCVr9mJAxrDHMrndEI=;
	b=QNGRFV+W7OW9ybCvBNlMPlyzL7Ov96bpOGtVLU+EVCw+ptjKHuaSqsmbmcYXc5FGmVJc8j
	98IF4cFo1Da+CFSTXio5YFgzr/C6FOxVWQzeXPGJEPgWMedDzv7nZhSCwh2GnDvoVIrl/r
	mJJhTXkJIcplYqnFKAzATf3a4s6XCTY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-htf-QfOIPLmF7OO1CwLSoA-1; Tue,
 25 Jun 2024 10:18:43 -0400
X-MC-Unique: htf-QfOIPLmF7OO1CwLSoA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 009071955D89;
	Tue, 25 Jun 2024 14:18:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 72D191944EB5;
	Tue, 25 Jun 2024 14:17:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 16:15:44 +0200 (CEST)
Date: Tue, 25 Jun 2024 16:15:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/6] task_work: Provide means to check if a work is
 queued
Message-ID: <20240625141539.GA14254@redhat.com>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625135244.20227-2-frederic@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/25, Frederic Weisbecker wrote:
>
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -177,6 +177,7 @@ void task_work_run(void)
>
>  		do {
>  			next = work->next;
> +			work->next = TASK_WORK_DEQUEUED;

OK, but then the additional change below makes sense too?

Oleg.
---

--- x/kernel/task_work.c
+++ x/kernel/task_work.c
@@ -106,8 +106,10 @@ task_work_cancel_match(struct task_struc
 		if (!match(work, data)) {
 			pprev = &work->next;
 			work = READ_ONCE(*pprev);
-		} else if (try_cmpxchg(pprev, &work, work->next))
+		} else if (try_cmpxchg(pprev, &work, work->next)) {
+			work->next = TASK_WORK_DEQUEUED;
 			break;
+		}
 	}
 	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 


