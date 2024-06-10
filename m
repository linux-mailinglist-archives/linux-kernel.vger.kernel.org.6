Return-Path: <linux-kernel+bounces-208489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FCE9025AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7641F275CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5385626;
	Mon, 10 Jun 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzo0oYLe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385B12FB34
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033443; cv=none; b=Dm6HEGB925ONKpM81JxHbsXVGqjoS9EEcmzsfX18B9SbfDiQVV5iNIaP2y15Io/gI0G0YFfbFJps1kf9pKgldm1kMTfPoggvOGdtu6qPTOmkajh5hKiTRXe0Hvuu0KAUJcZ/s9BRU3OOw5f2nGc+MFxdg7j2ho8nEFzxLfGNwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033443; c=relaxed/simple;
	bh=Istud4qCqYqq73UZC0sVn9z3Zj4w5osCP+6Eby9OE1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XovdTeg+KaMx0Fpuyvke9Y98x32Gfh42DUJG/cuFLU/aWxRxgb0bW6I6ka2OEmBZerMm4XIRPXxU5x9ibiVmMTSoc2ytOvcAhtfAl6uF4D8krtYTHK91AfzUlbMhZOA1qxfd6q0D9xgNTIHv2glROJV/TSaRcjOHfMSpo64bZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzo0oYLe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718033441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7PZDk4vp4nL/ROlBCKtZCvfKec6ibW5k+B7eKz8dX1I=;
	b=Yzo0oYLeeinMaJt3jhXhwHKZuj0/RdZQkNv/KE0tlOGBV/HqM4ZCh/NpuOW5w6xaMZRmRd
	uiro/ZXSXX0ku/J3Bwk1wnmX/m5iNKFh1ygTsihpAiblM+ultL9kxeyrqGoA+zTFK9DNvI
	sISdRZSiEt2EgatkHK2HO1uXTr67qh0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-gBFvI-MjPHexSoZMvQn31A-1; Mon,
 10 Jun 2024 11:30:37 -0400
X-MC-Unique: gBFvI-MjPHexSoZMvQn31A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A69411956063;
	Mon, 10 Jun 2024 15:30:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C018B1956055;
	Mon, 10 Jun 2024 15:30:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Jun 2024 17:29:05 +0200 (CEST)
Date: Mon, 10 Jun 2024 17:29:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240610152902.GC20640@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Eric, thanks for looking at this.

Let me answer your questions out-of-order. But, before anything else,
do you see anything wrong in 1/1 ?

On 06/10, Eric W. Biederman wrote:
>
> May I ask which direction you are coming at this from?  Are you trying
> to reduce the cost of do_exit?  Are you interested in untangling the
> mess that is exiting threads in a process?

I am trying to understand why do we need another counter.

And, I'd like to cleanup the usage of task->signal->live, I think it
should be avoided (if possible) when task != current. IIRC, we even
discussed this some time ago but I can't find any reference.

See also another thread about css_task_iter_advance().

> > Eric, I can't understand why the commit ("signal: Guarantee that
> > SIGNAL_GROUP_EXIT is set on process exit") added the new
> > quick_threads counter. And why, if we forget about --quick_threads,
> > synchronize_group_exit() has to take siglock unconditionally.
> > Did I miss something obvious?
>
> At a minimum it is the exact same locking as everywhere else that sets
> signal->flags, signal->group_exit_code, and signal->group_stop_count
> uses.
>
> So it would probably require some significant reason to not use
> the same locking and complicate reasoning about the code.  I suspect
> setting those values without siglock held is likely to lead to
> interesting races.

I guess I was not clear. Of course, SIGNAL_GROUP_EXIT must be always
set under ->siglock. But I think synchronize_group_exit() can just
return if SIGNAL_GROUP_EXIT is already set? If nothing else, this is
what do_group_exit() does.

Or I misunderstood you?

> That is where signal->quick_threads comes from.  In the work it is a
> part of I wind up moving the decrement up much sooner to the point where
> individual threads decide to exit.  The decrement of signal->live comes
> much too late to be useful in that context.

And that is why this patch moves the decrement of signal->live to the
start of do_exit().

> It is also part of me wanting to be able to uniformly use
> SIGNAL_GROUP_EXIT and signal->group_exit_code when talking about the
> process state, and p->exit_code when talking about the per task state.

Agreed,

> At the moment I am staring at wait_task_zombie and trying to understand
> how:
>
> 	status = (p->signal->flags & SIGNAL_GROUP_EXIT)
> 		? p->signal->group_exit_code : p->exit_code;
>
> works without any locks or barriers.

Agreed, at first glance this looks worrying without siglock... I'll try
to take a look, perhaps we can simply kill the SIGNAL_GROUP_EXIT check,
not sure.

But this patch should not make any difference ?

Oleg.


