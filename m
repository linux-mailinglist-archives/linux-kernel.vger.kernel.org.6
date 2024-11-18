Return-Path: <linux-kernel+bounces-412657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ABF9D0C17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39838282E56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD51922EE;
	Mon, 18 Nov 2024 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBg1hy01"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED722083
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923077; cv=none; b=ryJv5qUJsUuEiwkloKEId6snheqm2tfVVO1zbOXvLAoD1gXkXtRvnPk23vHtTspdAuGNEM5QWGqkNf7OW/Icb6jV9XjiO004R6zP72wMnoKaR2V6wtSaTSELqIiyWkAqmh94Nye1qzco0Za6ZabDsG8SZAlLbUfat5lYngf3y0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923077; c=relaxed/simple;
	bh=c/cNDda+c2ZztQGnDLypsmQgMZ1SgsGVrJ9TLVn05mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/6UVXDa24jF4S7uVV+FGZefgp+DE/LHuLwI7lF1lxcJ7OSwr4ijHAEh7ChW+pEFsAhV9fbJRJYpuWI8U7XoaWhyR4YllBa4X5nuF1k0VD/KD7vuJcR5cXL6TlYoH1nVoW3YC1b795eMtgfifOhPl0uQhMd5ss2Cz0YBDccOLMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZBg1hy01; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p6dtGgRu5p/Y/tUUJMog6ygXcicYdvCmarvDu41vCTg=; b=ZBg1hy01ALV0rU3pV7S1A7iMkb
	FNH39qP0n0Fbl2sOifG2smRgLpL/rbrH1dPO376Rprb9hV3PoImW/THvzIUzp9/Le2D0eAUEW5c6q
	Dwo0955to3lCX1KGFxUbKx0obYo6SGkSJRXnl1GhuT1ga1no9+k5+9+Lr/HTYlpC2nk6YRfHuCcog
	Gk6JezD9EO9XJ+UVd7bgzS0WRAuyKQfZEz9HNZdaDdyuWMXzDJEaxlGqsZWTe/yi6m/sGv8HhCjL9
	ntsslNaMoKNfJuF4Jl5H5A0zGkqzV+f6UzHG5uqczaj8fh++w3dDeP4gSLAKm2V8tmfP4IWnEXpAJ
	1QK8DWLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCyJ4-00000000D3z-48U9;
	Mon, 18 Nov 2024 09:44:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9C4A130049D; Mon, 18 Nov 2024 10:44:30 +0100 (CET)
Date: Mon, 18 Nov 2024 10:44:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
Message-ID: <20241118094430.GH39245@noisy.programming.kicks-ass.net>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-4-changwoo@igalia.com>
 <20241116193123.GP22801@noisy.programming.kicks-ass.net>
 <cd08dc10-1763-415f-b9b9-54c0ebc5e32b@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd08dc10-1763-415f-b9b9-54c0ebc5e32b@igalia.com>

On Mon, Nov 18, 2024 at 12:48:35AM +0900, Changwoo Min wrote:
> Hello,
> 
> On 24. 11. 17. 04:31, Peter Zijlstra wrote:
> > Have you seen the insides of kernel/sched/clock.c ?
> 
> Of course. :-) It would be super helpful if you could let me know
> specific questions or comments.

Well, mostly I don't understand anything about what you're doing.
Perhaps if you explain what's wrong with the bits we have ?

If you're looking at the scheduler, then rq->clock really should be
sufficient.

If you're looking at rando BPF crud, then what's wrong with
local_clock()?

Also, why are we still caring about systems that have crazy TSC?

