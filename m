Return-Path: <linux-kernel+bounces-229207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C07916CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EAA28A1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C317624B;
	Tue, 25 Jun 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cv9vTLGw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5116FF4A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328694; cv=none; b=KOmwu1xvicclodxfOCQujZJG677QGswPmg1rczjJzhYaY+fYuH8dOn9KKFlvSE2OTRMvVzpZSVET+v2TJsuSWrk2CBotrHqjN25Rrv+oMl3rQjQnYVFjVWWxA0xCRL9SBgcNtLYxDSo9m3OOZjUXVeq+sKXgVSaYPmbTXWYBJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328694; c=relaxed/simple;
	bh=oygoiBETUJQZnnh6fyNH/YRB5pNrhYh31+kfEH0vXPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoO58s26d9uxRCUTmr0re2MZVZvJqnt6A5Jf2t3SilPHNiiVsGDwla+ZMwqnXrp1/TtKIT1mJPiCXhrM17UHjudul3Bw/SLLV3QEoVpRmwZfvL52GrQnlnkAUe4SwP05c59a6nQbNLu+vKLgVJfTegtIzWMBBFdOVWDLqRkMql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cv9vTLGw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719328692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDDqIqqywCpZgnVzJ2LCa0AlAYA9C7CGtoimbDUxqB8=;
	b=Cv9vTLGwXOWDFURXU0As4WO/6faW5g66a+etXHoU7lu7mw+C9be0gkoDi4qTYwzYhWCrF9
	0bhea0kQ7vJwv5uN6CnkBkRd2BvddEDJ/OFVHnEvW3716z2LrZRTQymH270ogfdiJ70SCf
	/1883tjEBdqc7X3jt1yTmShqfYmM5Ug=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-YwrBamZ8Nsa68HAOAtqung-1; Tue,
 25 Jun 2024 11:18:08 -0400
X-MC-Unique: YwrBamZ8Nsa68HAOAtqung-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9156B1954238;
	Tue, 25 Jun 2024 15:18:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AD3F3300021A;
	Tue, 25 Jun 2024 15:17:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 17:16:29 +0200 (CEST)
Date: Tue, 25 Jun 2024 17:16:25 +0200
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
Message-ID: <20240625151624.GB14254@redhat.com>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-2-frederic@kernel.org>
 <20240625141539.GA14254@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625141539.GA14254@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

And probably task_work_add() should do the same when it returns -ESRCH.

On 06/25, Oleg Nesterov wrote:
>
> On 06/25, Frederic Weisbecker wrote:
> >
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -177,6 +177,7 @@ void task_work_run(void)
> >
> >  		do {
> >  			next = work->next;
> > +			work->next = TASK_WORK_DEQUEUED;
>
> OK, but then the additional change below makes sense too?
>
> Oleg.
> ---
>
> --- x/kernel/task_work.c
> +++ x/kernel/task_work.c
> @@ -106,8 +106,10 @@ task_work_cancel_match(struct task_struc
>  		if (!match(work, data)) {
>  			pprev = &work->next;
>  			work = READ_ONCE(*pprev);
> -		} else if (try_cmpxchg(pprev, &work, work->next))
> +		} else if (try_cmpxchg(pprev, &work, work->next)) {
> +			work->next = TASK_WORK_DEQUEUED;
>  			break;
> +		}
>  	}
>  	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
>


