Return-Path: <linux-kernel+bounces-246123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978292BDD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35491F27178
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF119D09C;
	Tue,  9 Jul 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qr1CqDCp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A319CCE1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537614; cv=none; b=XsG4BJsrAqwgTfHnPRNVoFqxzKik0JpUafV98OjtkvSW3ak9sPJXeRzi+GzoqGBr+Vw60pAjQGGz6iLwzZdAC1xVbNoJ5+eLROylOorTWdqzqwN93R0GLm6aXj12cfgLGVTop+gjQmpi8QoAzCDKs1CPzt10T7EDbsFcO5yiQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537614; c=relaxed/simple;
	bh=51kUKee66GC78kVNFb48z+4FmZxQlPv3lIlopAqxUSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAaPveCLPz1sO+/vUx+cTYIutnKMfL0FfSMUxyZtYRyb09bvmSk//yDDErFXe19jUwl/Q5KPYQXAsqtQML5EwB3ANd4GCjgeo3EHTS5o7CyhreZ/+NEhAC5l8pwukldsFNpHmG96T4knsgrIc0x1WXQ6XxZWtzXpnRIkVGYWyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qr1CqDCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720537611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9g5A7SXqltxpQ8rMmUVgyuk85viXZ5bqucOss47RPM4=;
	b=Qr1CqDCpRuxnb+RxljFI+DXszMvjpZaBMYDBnP0+zTP4BbgKmDFX0HaWv6dQ3+zuTW/YxP
	BqvP9bwRpj9qbtZ/NmKavLshwqHZNdIHCh6o7pc5LvEZbDJbJD4bx4noGURWPZZbVnjcme
	A+NCA5u8eFEMKwUGIVQ4/1ou1atpD8Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-cOYatm8PN1Sd9vhHauD-7g-1; Tue,
 09 Jul 2024 11:06:48 -0400
X-MC-Unique: cOYatm8PN1Sd9vhHauD-7g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060C21955F3D;
	Tue,  9 Jul 2024 15:06:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 983BE3000183;
	Tue,  9 Jul 2024 15:06:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 17:05:08 +0200 (CEST)
Date: Tue, 9 Jul 2024 17:05:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240709150504.GF28495@redhat.com>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.695619684@infradead.org>
 <20240709120551.GK27299@noisy.programming.kicks-ass.net>
 <20240709133349.GC28495@redhat.com>
 <20240709143218.GM27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709143218.GM27299@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/09, Peter Zijlstra wrote:
>
> On Tue, Jul 09, 2024 at 03:33:49PM +0200, Oleg Nesterov wrote:
> > On 07/09, Peter Zijlstra wrote:
> > >
> > > > +	guard(srcu)(&uprobes_srcu);
> > > > +
> > > > +	for_each_consumer_rcu(uc, uprobe->consumers) {
> > > >  		int rc = 0;
> > > >
> > > >  		if (uc->handler) {
> > > > @@ -2116,7 +2126,6 @@ static void handler_chain(struct uprobe
> > > >  		WARN_ON(!uprobe_is_active(uprobe));
> > > >  		unapply_uprobe(uprobe, current->mm);
> > >
> > >    ^^^ this remove case needs more thought.
> >
> > Yeah... that is why the current code doesn't use ->consumer_rwsem, iirc.
>
> AFAICT something like the below should work. Concurrent
> remove_breakpoint() should already be possible today and doesn't appear
> to be a problem.

Sorry, I don't understand how can this patch help. Yes, it removes the
uprobe->consumers != NULL check, but this is minor.

To simplify, suppose we have a single consumer which is not interested
in this task/mm, it returns UPROBE_HANDLER_REMOVE.

For example, event->hw.target != NULL and the current task is the forked
child which hits the breakpoint copied by dup_mmap().

Now. We need to ensure that another (say system-wide) consumer can't come
and call register_for_each_vma() before unapply_uprobe().

But perhaps I missed your point...

Oleg.

> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1260,6 +1260,10 @@ int uprobe_apply(struct inode *inode, lo
>  	return ret;
>  }
>
> +/*
> + * Can race against uprobe_unregister() / register_for_each_vma(), and relies
> + * on duplicate remove_breakpoint() being a no-op.
> + */
>  static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  {
>  	VMA_ITERATOR(vmi, mm, 0);
> @@ -2101,6 +2105,7 @@ static void handler_chain(struct uprobe
>  	struct uprobe_consumer *uc;
>  	int remove = UPROBE_HANDLER_REMOVE;
>  	bool need_prep = false; /* prepare return uprobe, when needed */
> +	bool had_handler = false;
>
>  	down_read(&uprobe->register_rwsem);
>  	for (uc = uprobe->consumers; uc; uc = uc->next) {
> @@ -2115,16 +2120,26 @@ static void handler_chain(struct uprobe
>  		if (uc->ret_handler)
>  			need_prep = true;
>
> +		/*
> +		 * A single handler that does not mask out REMOVE, means the
> +		 * probe stays.
> +		 */
> +		had_handler = true;
>  		remove &= rc;
>  	}
>
> +	/*
> +	 * If there were no handlers called, nobody asked for it to be removed
> +	 * but also nobody got to mask the value. Fix it up.
> +	 */
> +	if (!had_handler)
> +		remove = 0;
> +
>  	if (need_prep && !remove)
>  		prepare_uretprobe(uprobe, regs); /* put bp at return */
>
> -	if (remove && uprobe->consumers) {
> -		WARN_ON(!uprobe_is_active(uprobe));
> +	if (remove)
>  		unapply_uprobe(uprobe, current->mm);
> -	}
>  	up_read(&uprobe->register_rwsem);
>  }
>
>


