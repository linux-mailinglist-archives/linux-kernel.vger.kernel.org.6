Return-Path: <linux-kernel+bounces-577045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE89AA717A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87BD3AE480
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934491EDA13;
	Wed, 26 Mar 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHOBi0Jo"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F641ADFE3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996269; cv=none; b=hNungQvGHap7m+Dv8GbCk+HaBBpyFlPxLnCjkChvuAcCEVoA813qhlv/4A4gPoQKB2cb9u6IsjDFTfxlnszCT0UkpQkOy1y03Ez9t5RKX2k/aTEr+2cFEYMJxaROCaajW9TnBQqLdUotb2fRv9HE4FyiIcHCQroNZCyGWA0hTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996269; c=relaxed/simple;
	bh=F0gVAlZt3PFIyMFmwclbSlHQh1ACgb6y5gUJyY/u//0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbSfm0zji5xUXol64fb+jc8/qDeLEcUDbUwV4YpihlcG4M9tN6LpkukFBgR/VfiPia2inewYs6/4F5pAOs9gzlLxjH7LVnbdL6zq2j9mTths/+AA+umSGPc2vl6Ujz5s8GmDfqaO+Ef1uXMV96KV6IKACctsoai6iVEEGddKb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BHOBi0Jo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ikBZoS5Vo9Qpno7GOV1ZtclF7TV6GXjP7ScaDjkRxXA=; b=BHOBi0JoU0tmoxAJjITSfOK7Wz
	gxV4qExHWkTJlBbLei8HPmKgVlALX0+H93uG4z3yKs/OcrbUbPEPu7wPeBO0IkP0faUKFPXNYXLZ6
	fR9X7o0kkICssBtrJWZL0/u3wrzLt4gjOmNaEJanRBDEEJRDeGQq4XL6rb9OV/RAcyxUGcKMY+NnC
	wumuOwYL4DRlKDNBTI9vgEHuZMy5jF4NnR0geZxKJ5z/x6Ic3042IJo33EfhUIEX6hpWwOJtFid6q
	S4H1nLL0Oxm7qj4K+eNY9xc8json8vK/jZwE39/KvxvahnveVpP4YZzZaxhdvybJ2sVW0/UQE+9UC
	jKfWuoGQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txQwr-00000005oNk-090j;
	Wed, 26 Mar 2025 13:37:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 961DA3003C4; Wed, 26 Mar 2025 14:37:36 +0100 (CET)
Date: Wed, 26 Mar 2025 14:37:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
Message-ID: <20250326133736.GF25239@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-21-bigeasy@linutronix.de>
 <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>
 <20250325225600.GP36322@noisy.programming.kicks-ass.net>
 <4d0059f1-d834-44d5-bc57-7425980f5a97@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d0059f1-d834-44d5-bc57-7425980f5a97@linux.ibm.com>

On Wed, Mar 26, 2025 at 06:27:20PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 3/26/25 04:26, Peter Zijlstra wrote:
> > On Wed, Mar 26, 2025 at 01:22:19AM +0530, Shrikanth Hegde wrote:
> > 
> > > > +	return &futex_queues[node][hash & futex_hashmask];
> > 
> >                              ^^^^^^^
> > 
> > > > +	hashsize = 256 * num_possible_cpus();
> > > > +	hashsize /= num_possible_nodes();
> > > 
> > > Wouldn't it be better to use num_online_nodes? each node may get a bigger
> > > hash bucket which means less collision no?
> > 
> > No. There are two problems with num_online_nodes, and both are evident
> > above.
> > 
> > Consider the case of a sparse set.
> 
> I am sorry, i didn't understand. Could you please explain?

I was confused; I should've just gone sleep :-)

The futex_queues[] array is sized MAX_NUMNODES, such that every possible
node_id has a spot. I thought we did dynamic sizing, but not so.

Anyway, using online here would lead to having to deal with hotplug,
which in turn either leads to more over-all hash buckets in the system,
or having to resize and rehash everything.

Neither are really attractive options.


