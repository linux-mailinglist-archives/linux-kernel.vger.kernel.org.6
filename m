Return-Path: <linux-kernel+bounces-377260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808289ABC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FB71C20BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B213211A;
	Wed, 23 Oct 2024 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+wP1Bon"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761512F59C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653796; cv=none; b=pWmNju1xlK+vtPPtQPE4QB1D5Wp1H3hVJVsYIlvnr4Q59s1Rk8xC6SrgjgFbvTcXOCEpGJF3lDIkbEhfSUDY8hmvqQTsMrTdJZs9l4Ca2nu6z+4TnnbE9IJqgLIkZdt7g60IEjGig9TR9cfRIbfyq5202VNEzRq6iaywU31rN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653796; c=relaxed/simple;
	bh=t9lNahGFV8NdSVZWuVwyMZgm9MDu+bR/QurKTTeg/Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0X0QjFpTjCACpC6JZjRj+W94JzhiQXeUnSAXbfAub4fZzzyQ/+5c50D6y7mEtCdV2ICmv9goHh80FxgvtkgOOWEtXaqW/iY0IBUZwvacyIZeZNmmGGleOOholIcYGggP4fiC846k93sRmfFvXb6O7ZJtjiEmCZ6nyUFBF+f/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+wP1Bon; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729653793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ0RljsDGbBNjTnk6unO9qKRihhjfvUKCsiacIDZhR0=;
	b=Q+wP1Bon1UVP9jl0X3drLbWv5GtoEUqqvFEqcm/sY962TrmV4M57fYSxqJjjrPAhZ6vy8r
	RK5P7SKIcCGt9Gb8sQoAPQln6jfQg2Yb5EmvF9jnEvx7lJ4mSA9+J8Gy0Gqxmzn7m43hgW
	p+o2L6Mmm1XJGM3kZ84CjpW6gnEGJ9E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-kh2HjzS_OQyQLpWU8h4Muw-1; Tue,
 22 Oct 2024 23:23:10 -0400
X-MC-Unique: kh2HjzS_OQyQLpWU8h4Muw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4E281956096;
	Wed, 23 Oct 2024 03:23:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CF0019560AE;
	Wed, 23 Oct 2024 03:23:00 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:22:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <ZxhsD2zZLnZVaGZf@fedora>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
 <20241022061805.GA10573@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022061805.GA10573@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Oct 22, 2024 at 08:18:05AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 18, 2024 at 09:35:42AM +0800, Ming Lei wrote:
> > Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> > and blk_enter_queue().
> > 
> > Turns out the two are just like one rwsem, so model them as rwsem for
> > supporting lockdep:
> > 
> > 1) model blk_mq_freeze_queue() as down_write_trylock()
> > - it is exclusive lock, so dependency with blk_enter_queue() is covered
> > - it is trylock because blk_mq_freeze_queue() are allowed to run concurrently
> 
> Is this using the right terminology?  down_write and other locking
> primitives obviously can run concurrently, the whole point is to
> synchronize the code run inside the criticial section.
> 
> I think what you mean here is blk_mq_freeze_queue can be called more
> than once due to a global recursion counter.
> 
> Not sure modelling it as a trylock is the right approach here,
> I've added the lockdep maintainers if they have an idea.

Yeah, looks we can just call lock_acquire for the outermost
freeze/unfreeze.

> 
> > 
> > 2) model blk_enter_queue() as down_read()
> > - it is shared lock, so concurrent blk_enter_queue() are allowed
> > - it is read lock, so dependency with blk_mq_freeze_queue() is modeled
> > - blk_queue_exit() is often called from other contexts(such as irq), and
> > it can't be annotated as rwsem_release(), so simply do it in
> > blk_enter_queue(), this way still covered cases as many as possible
> > 
> > NVMe is the only subsystem which may call blk_mq_freeze_queue() and
> > blk_mq_unfreeze_queue() from different context, so it is the only
> > exception for the modeling. Add one tagset flag to exclude it from
> > the lockdep support.
> 
> rwsems have a non_owner variant for these kinds of uses cases,
> we should do the same for blk_mq_freeze_queue to annoate the callsite
> instead of a global flag.
 
Here it isn't real rwsem, and lockdep doesn't have non_owner variant
for rwsem_acquire() and rwsem_release().

Another corner case is blk_mark_disk_dead() in which freeze & unfreeze
may be run from different task contexts too.


thanks,
Ming


