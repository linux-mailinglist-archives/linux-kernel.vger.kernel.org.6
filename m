Return-Path: <linux-kernel+bounces-377407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED789ABE65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750FA1F24A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B214A0B5;
	Wed, 23 Oct 2024 06:07:30 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AE41448E0;
	Wed, 23 Oct 2024 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663650; cv=none; b=HyLPROSmV/Z6acljgDN4O0RaNQj1/XWbuZEjOoCRD0uLr50x51t2QUQD+Ga2tXY09GKSdAitEUAwJlBJR1d70pRpgxD2SnCdkL3sQ1A0KrrsX5z4uISrR3e67gmxtR+nE9nLUvp8fIasJiN8MV8B1NrCw2izBSIoK8ENd/d4lEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663650; c=relaxed/simple;
	bh=4jfMWaT+qUSZpzXlDP3FNMIhV8u/fRXXViI6c01XeZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKPAGdUlSAEkwdT1MCl5B4zqiobDeGx+eBIgOVrb94hYnd/TlfBbjjK58OTr0PHO8nCr1uswN9MTXPG0MPo3VrKFNW/+/8SrJTyBlDYPKVyPOfrSYZN5SKFpe3bAKcwDzdq8JfeQ+/ME4xoL2kwUnwNTBW0YjUPcS+1Wv+7GxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB149227A88; Wed, 23 Oct 2024 08:07:15 +0200 (CEST)
Date: Wed, 23 Oct 2024 08:07:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <20241023060715.GA2468@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com> <20241022061805.GA10573@lst.de> <ZxhsD2zZLnZVaGZf@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxhsD2zZLnZVaGZf@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 23, 2024 at 11:22:55AM +0800, Ming Lei wrote:
> > > 2) model blk_enter_queue() as down_read()
> > > - it is shared lock, so concurrent blk_enter_queue() are allowed
> > > - it is read lock, so dependency with blk_mq_freeze_queue() is modeled
> > > - blk_queue_exit() is often called from other contexts(such as irq), and
> > > it can't be annotated as rwsem_release(), so simply do it in
> > > blk_enter_queue(), this way still covered cases as many as possible
> > > 
> > > NVMe is the only subsystem which may call blk_mq_freeze_queue() and
> > > blk_mq_unfreeze_queue() from different context, so it is the only
> > > exception for the modeling. Add one tagset flag to exclude it from
> > > the lockdep support.
> > 
> > rwsems have a non_owner variant for these kinds of uses cases,
> > we should do the same for blk_mq_freeze_queue to annoate the callsite
> > instead of a global flag.
>  
> Here it isn't real rwsem, and lockdep doesn't have non_owner variant
> for rwsem_acquire() and rwsem_release().

Hmm, it looks like down_read_non_owner completely skips lockdep,
which seems rather problematic.  Sure we can't really track an
owner, but having it take part in the lock chain would be extremely
useful.  Whatever we're using there should work for the freeze
protection.

> Another corner case is blk_mark_disk_dead() in which freeze & unfreeze
> may be run from different task contexts too.

Yes, this is a pretty questionable one though as we should be able
to unfreeze as soon as the dying bit is set.  Separate discussion,
though.

Either way the non-ownership should be per call and not a queue or
tagset flag.


