Return-Path: <linux-kernel+bounces-402193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C49C24EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B15DB22F85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DFC199EB2;
	Fri,  8 Nov 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVJPPh5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6475233D6E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090810; cv=none; b=tYhuAmZACTqwLemF0mrkFe0F23gWp5eZJXaPmHSj5+Lsy/58w/p5vHUeMgclTdKPSiFBoz7ekshFeTy/6CaqL8BwjmMg0TMeJJB1EggpmhVpURPCgaMGZnU6G1goVf1o7dVgdjZ9cOfnMFrMjMgIJMwZuwJIJhJQvOnNAE9YQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090810; c=relaxed/simple;
	bh=ZnnP3TJUy8XOOKGAyDmqnCFgzbiZaQ2OFC3bYeXIWjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJELLJO+yHW0TZnj5euq+dw4xjYq9wv2zDaxXgHyQM5CpV/2n3JCvsRyAuQCjDStvqbbpUTgWvdJVuJnRCB6cBavu4oiaBrvnNXKCEvPxJrV3v51YARwz+C8VYyDP4W2VM0sV6EL7t5MWjRkqIjxvmCJe04OvbJS6H5WS63o/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVJPPh5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A23C4CECD;
	Fri,  8 Nov 2024 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731090810;
	bh=ZnnP3TJUy8XOOKGAyDmqnCFgzbiZaQ2OFC3bYeXIWjM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MVJPPh5jUl5T+CC0kBAxzzbwEq+GSYJrd/YPTDf19DxGNKFkpWnFa67JXNTWboi2W
	 DJx6DIMGkf7pOAWlczoG9OA957+F+/W3smtklIrOYpTUY6OUBDbT9SVj7zNqb8SyZd
	 fqN/UAOQn+Ao2prEDjgyOIdvg6LzQCDUxG2AN5VUIQoX7mKnnuoq26FfmC2LBbaf04
	 XvVntHjjPWKbUg4YYo3tBj7F+X56eYu/O7cCxuaTs3sWeknV7f1A/7EzE9pF3NzUdy
	 q9HZDWaIHF/is5Gp7+maz9rfTsECbbTREy8HXoLDbXKfAWkPFW0/B55yQX0oBOK/jx
	 Bu5L/6o4HL4Lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 00191CE09E4; Fri,  8 Nov 2024 10:33:29 -0800 (PST)
Date: Fri, 8 Nov 2024 10:33:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v3 0/4] scftorture: Avoid kfree from IRQ context.
Message-ID: <18b237cf-d510-49bf-b21b-78f9cebd1e3d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
 <Zy5OX5Wy0LsFPdjO@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy5OX5Wy0LsFPdjO@Boquns-Mac-mini.local>

On Fri, Nov 08, 2024 at 09:46:07AM -0800, Boqun Feng wrote:
> On Fri, Nov 08, 2024 at 11:39:30AM +0100, Sebastian Andrzej Siewior wrote:
> > Hi,
> > 
> > Paul reported kfree from IRQ context in scftorture which is noticed by
> > lockdep since the recent PROVE_RAW_LOCK_NESTING switch.
> > 
> > The last patch in this series adresses the issues, the other things
> > happened on the way.
> > 
> > v2...v3:
> >   - The clean up on module exit must not be done with thread numbers.
> >     Reported by Boqun Feng.
> >   - Move the clean up on module exit prior to torture_cleanup_end().
> >     Reported by Paul.
> > 
> > v1...v2:
> >   - Remove kfree_bulk(). I get more invocations per report without it.
> >   - Pass `cpu' to scf_cleanup_free_list in scftorture_invoker() instead
> >     of scfp->cpu. The latter is the thread number which can be larger
> >     than the number CPUs leading to a crash in such a case. Reported by
> >     Boqun Feng.
> >   - Clean up the per-CPU lists on module exit. Reported by Boqun Feng.
> > 
> > Sebastian
> > 
> 
> For the whole series:
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Tested-by: Boqun Feng <boqun.feng@gmail.com>

Thank you both!

Sebastian, I am guessing that the Kconfig change exposing the bugs fixed
by your series is headed to mainline for the upcoming merge window?

If so, I should of course push these in as well.

							Thanx, Paul

