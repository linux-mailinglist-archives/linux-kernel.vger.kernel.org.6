Return-Path: <linux-kernel+bounces-400065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FF79C086E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48D31C20DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90F212D04;
	Thu,  7 Nov 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhyGov7b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648781E049C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988516; cv=none; b=EXjgxtAMbQCnNyUhtFRaQGHPY+zBfTuOQRC8WjiudnoYWM66SewwHmdeeOfbGn2YR7Nk86z2qqcV+rE0lGmFIOnsOkrJqJTPNDjbSN6ffl8tnaV2fR3UD4BoAaizz3LOmj8P1FL5lJzQszOA3xNRp7ahxQbFWsQ9DrGaK1aq5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988516; c=relaxed/simple;
	bh=Ga5jr0YKhQw5e6CaQPgUwcunVBGmSV6nYbUJY6Qonik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFUN62CiHH/u+0OHXmbnSDUUt2BzXSiP8B9v7oW+QNsqkzjFUWqfKZvP4+JY5OkHl4JAQGN383TxVCRx5t91pkI/MyhbCLR8qpo5xDuEi+8UAbk81sLoQ/uet2wT0MasWTm3LsJDYmX/iv8gAR/JWhqpIXMKC2kPFZKykCK8v3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhyGov7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF6CC4CECD;
	Thu,  7 Nov 2024 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730988515;
	bh=Ga5jr0YKhQw5e6CaQPgUwcunVBGmSV6nYbUJY6Qonik=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RhyGov7btrnZIWbxBrhZo9gUttGnHfDCjJJXnOZnLPooxUP6c9wdZ5rzu6Bb6E/xX
	 GhghYpBHz+cwzoKvaRig2FRIhsSRan/j9XLjduJMeE5IHFBK/uC3+sCukgRLLNkmU9
	 nA2vLWAQGMyY63Zh8NF8zk4GmfWP4Bb/hh7Iiosio1te0fVGArjMadj+AamYrq8gkW
	 8KqRx8s+ZqBXrTJf3jdUOxbYQfyyyD2GyUpGpuVGWiB3fvzANUUeJdHt+VAAcLvvKW
	 AMYhATmJRltpeTj9kyo77wjWo5oJD80xlhwmP6iH13Ip82h9Uy73GhD9nnzSubfGzn
	 7sH73l+zGu/GQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17B8ECE09F6; Thu,  7 Nov 2024 06:08:35 -0800 (PST)
Date: Thu, 7 Nov 2024 06:08:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	sfr@canb.auug.org.au, longman@redhat.com, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, Tomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] scftorture: Use a lock-less list to free memory.
Message-ID: <45725c86-d07f-4422-a6fd-c9f02744ac75@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
 <20241104105053.2182833-1-bigeasy@linutronix.de>
 <20241104105053.2182833-2-bigeasy@linutronix.de>
 <ZyluI0A-LSvvbBb9@boqun-archlinux>
 <20241107112107.3rO2RTzX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107112107.3rO2RTzX@linutronix.de>

On Thu, Nov 07, 2024 at 12:21:07PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-04 17:00:19 [-0800], Boqun Feng wrote:
> > Hi Sebastian,
> Hi Boqun,
> 
> …
> > I think this needs to be:
> > 
> > 		scf_cleanup_free_list(cpu);
> > 
> > or
> > 
> > 		scf_cleanup_free_list(curcpu);
> > 
> > because scfp->cpu is actually the thread number, and I got a NULL
> > dereference:
> > 
> > [   14.219225] BUG: unable to handle page fault for address: ffffffffb2ff7210
> 
> Right. Replaced with cpu.
> …
> > 
> > Another thing is, how do we guarantee that we don't exit the loop
> > eariler (i.e. while there are still callbacks on the list)? After the
> > following scftorture_invoke_one(), there could an IPI pending somewhere,
> > and we may exit this loop if torture_must_stop() is true. And that IPI
> > might add its scf_check to the list but no scf_cleanup_free_list() is
> > going to handle that, right?
> 
> Okay. Assuming that IPIs are done by the time scf_torture_cleanup is
> invoked, I added scf_cleanup_free_list() for all CPUs there.

This statement in scf_torture_cleanup() is supposed to wait for all
outstanding IPIs:

	smp_call_function(scf_cleanup_handler, NULL, 0);

And the scf_cleanup_handler() function is as follows:

	static void scf_cleanup_handler(void *unused)
	{
	}

Does that work, or am I yet again being overly naive?

> Reposted at
> 	https://lore.kernel.org/20241107111821.3417762-1-bigeasy@linutronix.de

Thank you!

I will do some testing on this later today.

							Thanx, Paul

