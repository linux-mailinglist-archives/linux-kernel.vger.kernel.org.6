Return-Path: <linux-kernel+bounces-213601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58265907778
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5935289706
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A114C5BA;
	Thu, 13 Jun 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Os/UdFdc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116214C5A9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293643; cv=none; b=u6leZJXlBO/W19H+Al633j55F4tUYyjco6IWd+WwbENt87j1jaUjd4ITl3VKn9pQHHdmyXbogTBTdvvDvQC4g1W0LHWNlwDpsxImJwxgIImsvpMWIsLBr0XNg9LenwkV75RmFQbXEw6AZWQkULg66KcbC1SuR0kmyqG+SxSVeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293643; c=relaxed/simple;
	bh=o+I79bi8dSxZ6o2hO2AQzLoGNXTTs/sPN/lJIpluxTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+lMYcIQ4zGD5G1bUAD0jhGwI++CpIkK/kQqX5MmY3F8c1jBpU3CR1bOEx5Fz7b1c4fwBL+RlEGxL3iyQ15vqjy/8ZpbdNSI9vAT6z0ZXBEsOraV4phbqG8I2hnkG3+q3VPYBfBUKJSl2KWONRYPkFl2T/gi5qFjpkXKx7wFWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Os/UdFdc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718293640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl4Wqt51Hao3icJ/N+kSJzGNSoJFEPA+Q8HEWG3GloE=;
	b=Os/UdFdcL46JfqxYDS+KGcsAWhiOQOo1Bl0yv4HBGkEu5mgjSQ4r0rYwZOFp3q32Vy9ngI
	x0jvvDU1tNZs/dG0STBwrvnU9T9SQDBLtClmxg2cwzL4yl4qegP8nNyqKecC0ft/jyvwqf
	l5XQeWK8nB1SFSH0/n2FoeRFh7eVF7o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-zZICEuUYPY2Eo3mzVkyGGA-1; Thu,
 13 Jun 2024 11:47:16 -0400
X-MC-Unique: zZICEuUYPY2Eo3mzVkyGGA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99A3E19560B3;
	Thu, 13 Jun 2024 15:47:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B738F1956050;
	Thu, 13 Jun 2024 15:47:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 13 Jun 2024 17:45:45 +0200 (CEST)
Date: Thu, 13 Jun 2024 17:45:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240613154541.GD18218@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610152902.GC20640@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

So...

Eric, do you agree with this patch or not?

Tejun, sorry for delay, I'll try to send the patch which cleanups
(at least in my opinion) the ->dying_tasks logic as soon as I have
time. But just in case... no, cgroup_exit() can't rely on group_exit
passed from the caller, I was wrong ;)


On 06/10, Oleg Nesterov wrote:
>
> Hi Eric, thanks for looking at this.
>
> Let me answer your questions out-of-order. But, before anything else,
> do you see anything wrong in 1/1 ?
>
> On 06/10, Eric W. Biederman wrote:
> >
> > May I ask which direction you are coming at this from?  Are you trying
> > to reduce the cost of do_exit?  Are you interested in untangling the
> > mess that is exiting threads in a process?
>
> I am trying to understand why do we need another counter.
>
> And, I'd like to cleanup the usage of task->signal->live, I think it
> should be avoided (if possible) when task != current. IIRC, we even
> discussed this some time ago but I can't find any reference.
>
> See also another thread about css_task_iter_advance().
>
> > > Eric, I can't understand why the commit ("signal: Guarantee that
> > > SIGNAL_GROUP_EXIT is set on process exit") added the new
> > > quick_threads counter. And why, if we forget about --quick_threads,
> > > synchronize_group_exit() has to take siglock unconditionally.
> > > Did I miss something obvious?
> >
> > At a minimum it is the exact same locking as everywhere else that sets
> > signal->flags, signal->group_exit_code, and signal->group_stop_count
> > uses.
> >
> > So it would probably require some significant reason to not use
> > the same locking and complicate reasoning about the code.  I suspect
> > setting those values without siglock held is likely to lead to
> > interesting races.
>
> I guess I was not clear. Of course, SIGNAL_GROUP_EXIT must be always
> set under ->siglock. But I think synchronize_group_exit() can just
> return if SIGNAL_GROUP_EXIT is already set? If nothing else, this is
> what do_group_exit() does.
>
> Or I misunderstood you?
>
> > That is where signal->quick_threads comes from.  In the work it is a
> > part of I wind up moving the decrement up much sooner to the point where
> > individual threads decide to exit.  The decrement of signal->live comes
> > much too late to be useful in that context.
>
> And that is why this patch moves the decrement of signal->live to the
> start of do_exit().
>
> > It is also part of me wanting to be able to uniformly use
> > SIGNAL_GROUP_EXIT and signal->group_exit_code when talking about the
> > process state, and p->exit_code when talking about the per task state.
>
> Agreed,
>
> > At the moment I am staring at wait_task_zombie and trying to understand
> > how:
> >
> > 	status = (p->signal->flags & SIGNAL_GROUP_EXIT)
> > 		? p->signal->group_exit_code : p->exit_code;
> >
> > works without any locks or barriers.
>
> Agreed, at first glance this looks worrying without siglock... I'll try
> to take a look, perhaps we can simply kill the SIGNAL_GROUP_EXIT check,
> not sure.
>
> But this patch should not make any difference ?
>
> Oleg.


