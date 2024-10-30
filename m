Return-Path: <linux-kernel+bounces-389663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D229B6F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47F2B2561E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8C215029;
	Wed, 30 Oct 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sagxZCVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4311DC1A2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324385; cv=none; b=i6tgXFFhUZTHjCGBBbOkDpLuN1OwOLDIiL42DeedyRDag0sn8m8XggL1wRK1t1vx2dk6svDQh/jOgJgE3tEJppDUgsCiyqavTWNOHu08RhGSgQ53lkvF/szOZp4ib8/Y1GcPxLCz8oYfURgtZW8TTmnNMBaWQaDk0CL++8MT3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324385; c=relaxed/simple;
	bh=0dxJRqTXqaADiuHQubrorXUseA6nJ1mkSFAaSA/Jn2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+5H83ttsn5R2z+zZQIWNFcx9GFBJENWAZizj3hFaUZ5l8UWu2UIRT1ZkJGXXjZaSFOVGIgONG0WcjCMKB5uFolc6KwgzFNRfvxw+jIoNZoyZ+RNc7aCCW2EWqEo9+p7wNspm086S0FLujthnV0JOpF3Ihttn66UdLNTBa8nfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sagxZCVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF32C4CECE;
	Wed, 30 Oct 2024 21:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730324384;
	bh=0dxJRqTXqaADiuHQubrorXUseA6nJ1mkSFAaSA/Jn2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sagxZCVdrAUqn3FwM0NBU1GvbFwSIT+ts6NmIAukvhLXbKHLFkNxoTqmVfXrrHDif
	 WmJwOPtPK+4nYwZ8a93hZoRaaEsl5d1jSKw/pchfJAiDoURL3O3coCvtIIWxMRU+pt
	 uFFtFB+ZTlDTqyEE8sX/6qkza6L9q8A971V3MmUglWeB0qvakWw7hswgtMK3dJQ9MU
	 xHEaEpRrNfQIwRBpJ+ZTDA9gTdpS2BuKLIePOfuKZmsqCokuTZK8pp56563VXUqqd2
	 BtHXik+uDZjkhfpHRkS5iPesEGY8bgBK6JsnunH0WNR2DNQfmNOtqw96U78bvNwkM1
	 kTQQHmTShsJXQ==
Date: Wed, 30 Oct 2024 11:39:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/6] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <ZyKnn39g3KKSKqa_@slm.duckdns.org>
References: <20241030151255.300069509@infradead.org>
 <20241030152142.711768679@infradead.org>
 <ZyKhQFuMItKsmsnh@slm.duckdns.org>
 <20241030211506.GR14555@noisy.programming.kicks-ass.net>
 <ZyKlJXgXUqDpaQXp@slm.duckdns.org>
 <20241030213735.GS14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030213735.GS14555@noisy.programming.kicks-ass.net>

Hello,

On Wed, Oct 30, 2024 at 10:37:35PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 30, 2024 at 11:29:09AM -1000, Tejun Heo wrote:
> > On Wed, Oct 30, 2024 at 10:15:06PM +0100, Peter Zijlstra wrote:
> > ...
> > > > > +		if (!(queue_flags & DEQUEUE_CLASS))
> > > > > +			check_prio_changed(task_rq(p), p, p->prio);
> > > > 
> > > > Maybe prio_changed can be moved into scoped_guard?
> > > 
> > > It wasn't before -- do you have need for it to be inside?
> > 
> > No, was just wondering whether that'd make things a bit more compact. Either
> > way is fine.
> 
> Oh, did you perhaps mean into sched_change_end() ? I suppose that's
> possible indeed. Initially I thought that would require yet another

Oh yeah, that's what I meant. Sorry about not being clearer.

> flags, but looking at it again, that doesn't seem to be the case. All
> sched_change users lacking it never change the prio anyway.
> 
> I'll have a look at doing that tomorrow, with a slightly fresher brain.
> 
> I also think that adding flags to the switch*() methods isn't at all
> needed, but perhaps it makes sense anyway.

Fantastic. Thanks.

-- 
tejun

