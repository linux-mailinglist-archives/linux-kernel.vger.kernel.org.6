Return-Path: <linux-kernel+bounces-255215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5C933D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEF51F24FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDEF1802CB;
	Wed, 17 Jul 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5sWHC8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD717F385
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222507; cv=none; b=Y/63ljNMv9HSI98EMR6DszefimuTybRYE8FVgOCtUdViVz5vh/JF6xuLB/u6GQcf5bN4cXRAKCZnGc1Lal6sP0HClqrLdVnUlDQxG1kBbVYsxyxj+mEdXt9GOzdBCMr8HS/HxITerrbFYlhpHuPKu1AMLh0EfmDX6WhPRPyF9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222507; c=relaxed/simple;
	bh=OHVri6oZjBTrYRG/gliZ619AbBRKNl0B4ap97beOBEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+2zfH+IaxnEELR5palCxJWRHCbSGL5ecUr84bDR7okNttz7C3oNWeD2z3QRD8ecfEmE29pb3IKqYLsXNTFR638StDnvuSyG/Qrq/lL6TXekfty76g6g6BxZZXiKE4yA9TcXx+nXSx84cc8bfOyIGdtdxMiFMBtU7iYiO/zuXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5sWHC8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1211C32782;
	Wed, 17 Jul 2024 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721222507;
	bh=OHVri6oZjBTrYRG/gliZ619AbBRKNl0B4ap97beOBEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5sWHC8IWX/GBIYBAtYkJ6E05oiOzhRNnjC3HpDKVRpxJhx7BWzc1wRhu1pxIefns
	 9NQQ3zgCrqtrJVg9O97YQtJYhFuAesaPJWTEZSC22OSB7zpDWJ0uMvIRQJn6JzFKe5
	 zWFx+aG5GeBeekkpSLKC351Ak+b29LFIrpxKWWeeO6scxixkBd4s6l4mLsQLlIengs
	 JrGZRVtGggH5ma2cs9sZvjEohsJXVDMWzoGx2sTiA9xWSBe7HAfdc3n6YWqjt+T6Ti
	 h99P6zb44BcjzQOpywrp49eKE9zVXcgGJQwTovJz5xqZQNEl7b0bx1GoAFasUqeAaA
	 y8LseKEallT6g==
Date: Wed, 17 Jul 2024 15:21:44 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 6/6] mm: Drain LRUs upon resume to userspace on
 nohz_full CPUs
Message-ID: <ZpfFaElo1wwTOpNm@localhost.localdomain>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-7-frederic@kernel.org>
 <ZnrSEf1xuFxKxj1D@tiehlicka>
 <ZoVJhXcR26paUNhX@localhost.localdomain>
 <ZoaffMfFdEgs2N7o@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoaffMfFdEgs2N7o@tiehlicka>

Le Thu, Jul 04, 2024 at 03:11:24PM +0200, Michal Hocko a écrit :
> On Wed 03-07-24 14:52:21, Frederic Weisbecker wrote:
> > Le Tue, Jun 25, 2024 at 04:20:01PM +0200, Michal Hocko a écrit :
> > > On Tue 25-06-24 15:52:44, Frederic Weisbecker wrote:
> > > > LRUs can be drained through several ways. One of them may add disturbances
> > > > to isolated workloads while queuing a work at any time to any target,
> > > > whether running in nohz_full mode or not.
> > > > 
> > > > Prevent from that on isolated tasks with draining LRUs upon resuming to
> > > > userspace using the isolated task work framework.
> > > > 
> > > > It's worth noting that this is inherently racy against
> > > > lru_add_drain_all() remotely queueing the per CPU drain work and
> > > > therefore it prevents from the undesired disturbance only
> > > > *most of the time*.
> > > 
> > > Can we simply not schedule flushing on remote CPUs and leave that to the
> > > "return to the userspace" path?
> > 
> > Do you mean I should add a call on return to the userspace path or can
> > I expect it to be drained at some point already?
> 
> I would make the particular per cpu cache to be drained on return to the
> userspace.

And then we need the patchset from Valentin that defers work to kernel entry?

> 
> > The other limitation with that task work thing is that if the task
> > queueing the work actually goes to sleep and another task go on the CPU
> > and does isolated work in userspace, the drain doesn't happen. Now whether
> > that is a real problem or not, I have no idea.
> 
> Theoretically there is a problem because pages sitting on pcp LRU caches
> cannot be migrated and some other operations will fail as well. But
> practically speaking those pages should be mostly of interest to the
> process allocating them most of the time. Page sharing between isolated
> workloads sounds like a terrible idea to me. Maybe reality hits us in
> this regards but we can deal with that when we learn about those
> workloads.
> 
> So I wouldn't lose too much sleep over that. We are dealing with those
> isolated workloads being broken by simple things like fork now because
> that apparently adds pages on the pcp LRU cache and draining will happen
> sooner or later (very often when the task is already running in the
> userspace).

That sounds good!

Thanks.

> 
> -- 
> Michal Hocko
> SUSE Labs

