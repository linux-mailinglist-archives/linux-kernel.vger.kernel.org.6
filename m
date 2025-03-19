Return-Path: <linux-kernel+bounces-568681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EAA69936
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE74E4807B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83F2135DD;
	Wed, 19 Mar 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBY9CxFS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2D2135A1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412375; cv=none; b=BKUBda2T/LZ9XKrHa7usKVJkHLIlN+jyOWgX8aIrsUn9ZOBFZuyDnW9HL0azCZ4XQC7QPvx3OBt4kjEQKD4jiJzie3PQ2eNfNNzPhKm0zYR47WENAd5owHx/umAuSUIO/NzuCA/bpBCmfHfkeoFGVyy3zVyi9Y+lSZ9Q3EAIweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412375; c=relaxed/simple;
	bh=GvFsmhBDZEcGO9ihRB+pSMnqcxqyDfa3kayemAa2VEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyaMVnDTgLmwcRfcq2SJQk3XdZlKSW8GipuhrbZhsXvo5I9LGTx981kvBiM8rqSzWoDq5MhxdWboUdgLzYgcYywGuWU2leNnYWMyrLNOc3GIfKS7WvU+UV2nY1E4PljVmHnq4L+BXGltKgBZ56gg1lcRibKZAm/HqWygovAYOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBY9CxFS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742412372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgusXYM/CKW53Ur/ReEOdqo4jO1Deq64tqRsToALntY=;
	b=WBY9CxFS0pK7XZdoBbsf4g9fELKBYW/UsB3fFPdZA4cfdvNaGZLYkpo7rp4AS2CkaBgv1i
	VMuw4f2sRt1glJXWRzM/jCZZ+dAjoRT+VmpqqCW/KPhKAXqSm93id+ptbo82lwOdySr4zh
	KbEM6RTfWYDWltqCOE5RIfru0YSrL2g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-QkugjRwYMReTi-mucPkFew-1; Wed,
 19 Mar 2025 15:26:10 -0400
X-MC-Unique: QkugjRwYMReTi-mucPkFew-1
X-Mimecast-MFC-AGG-ID: QkugjRwYMReTi-mucPkFew_1742412369
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BFE71800263;
	Wed, 19 Mar 2025 19:26:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C7F0419560AD;
	Wed, 19 Mar 2025 19:26:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 20:25:36 +0100 (CET)
Date: Wed, 19 Mar 2025 20:25:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exit: combine work under lock in
 synchronize_group_exit() and coredump_task_exit()
Message-ID: <20250319192533.GG26879@redhat.com>
References: <20250319185433.1859030-1-mjguzik@gmail.com>
 <20250319190950.GF26879@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319190950.GF26879@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/19, Oleg Nesterov wrote:
>
> On 03/19, Mateusz Guzik wrote:
> >
> > +	spin_lock_irq(&sighand->siglock);
> > +	synchronize_group_exit(tsk, code);
> > +	core_state = coredump_task_exit_prep(tsk);
> > +	spin_unlock_irq(&sighand->siglock);
>
> Well, but why do we need the new (and trivial) coredump_task_exit_prep?
>
> Can't synchronize_group_exit() be
>
> 	static struct core_state *synchronize_group_exit(struct task_struct *tsk, long code)
> 	{
> 		struct sighand_struct *sighand = tsk->sighand;
> 		struct signal_struct *signal = tsk->signal;
> 		struct core_state *core_state = NULL;
>
> 		spin_lock_irq(&sighand->siglock);
> 		signal->quick_threads--;
> 		if ((signal->quick_threads == 0) &&
> 		    !(signal->flags & SIGNAL_GROUP_EXIT)) {
> 			signal->flags = SIGNAL_GROUP_EXIT;
> 			signal->group_exit_code = code;
> 			signal->group_stop_count = 0;
> 		}
> 		/*
> 		 * Serialize with any possible pending coredump.
> 		 * We must hold siglock around checking core_state
> 		 * and setting PF_POSTCOREDUMP.  The core-inducing thread
> 		 * will increment ->nr_threads for each thread in the
> 		 * group without PF_POSTCOREDUMP set.
> 		 */
> 		tsk->flags |= PF_POSTCOREDUMP;
> 		core_state = tsk->signal->core_state;
> 		spin_unlock_irq(&sighand->siglock);
>
> 		return core_state;
> 	}
>
> ?

Or even better,


static void synchronize_group_exit(struct task_struct *tsk, long code)
{
	struct sighand_struct *sighand = tsk->sighand;
	struct signal_struct *signal = tsk->signal;
	struct core_state *core_state = NULL;

	spin_lock_irq(&sighand->siglock);
	signal->quick_threads--;
	if ((signal->quick_threads == 0) &&
	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
		signal->flags = SIGNAL_GROUP_EXIT;
		signal->group_exit_code = code;
		signal->group_stop_count = 0;
	}
	/*
	 * Serialize with any possible pending coredump.
	 * We must hold siglock around checking core_state
	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
	 * will increment ->nr_threads for each thread in the
	 * group without PF_POSTCOREDUMP set.
	 */
	tsk->flags |= PF_POSTCOREDUMP;
	core_state = tsk->signal->core_state;
	spin_unlock_irq(&sighand->siglock);

	if (core_state)
		coredump_task_exit(tsk, core_state);
}

> No need to shift spin_lock_irq(siglock) from synchronize_group_exit() to do_exit(),
> no need to rename coredump_task_exit...

do_exit() is already big enough...

Oleg.


