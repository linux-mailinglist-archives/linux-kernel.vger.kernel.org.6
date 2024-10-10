Return-Path: <linux-kernel+bounces-359242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1491B99893D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DDE283DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A01CC17A;
	Thu, 10 Oct 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDUawtWm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32431A2643
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569622; cv=none; b=nZ8j9ZIMNN6z1VPf3S3SMAU22PFAZGz68Tr2Dr+Ic7g9qYJGQN6o/cnzH8sQkKkRu5wdzOjd+tiPL+KUTchaZV5XMRAgpO4SIPi682vLQtv3lLPzSG6Qp3nHs/eKTGYqEhDwvs4iq1m7IQX/gYDjlyXNMkrXkkZXHacmBfSXtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569622; c=relaxed/simple;
	bh=EEInlXUjEsC6T3m86u8x4gLk0sy+yycZpWA4o1aU6qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwDl2RcMsT3jfObhh8lfMAqmqGZwkSpmtknYFAXgdGj3v/83m8r26p/HAX76gkJxF3gXv9A/unaSmilUk4BOvr2a33n4mRp0WwfvRDeUUyS9lwVlojfcWHFCU+c7u2keel5U18xtE2KcuA2/l6l4gAU6xunKmt/W5/lXjipeqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDUawtWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F6DC4CEC5;
	Thu, 10 Oct 2024 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728569622;
	bh=EEInlXUjEsC6T3m86u8x4gLk0sy+yycZpWA4o1aU6qs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PDUawtWmXLPfxxJn6Hk869I5Q9NioxEbiPxvDXagY0j7B32CDG8i3rn5Va2/VVGi9
	 4RItMto6vIzTm6TJISPSFg3oCQlYA8LQoRo6+gHc9vvW0p3dYv5jGmBICxmU5f3oaz
	 dTPqWp310tO14ZQQz8wkhj9riXqFCnTSPXs0K5HvpES4qC1dQWiLGszncDUtVGbC+T
	 +Djc+Qr0dZ66ggP/g+JTCYj2SMek63+EJxIpgwzEcgLPL0zfHNymhQGY08ksf4FNxr
	 YVeJCH9pmQx46s1XlJdhHsDv5ievyEAi5Y8Zr/36gJ6VZEIXsCmRIBDw7MqOw6vXwf
	 I5vkcvl3+6ICg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7822CE044D; Thu, 10 Oct 2024 07:13:41 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:13:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
	riel@surriel.com, leobras@redhat.com, tglx@linutronix.de,
	qiyuzhu2@amd.com
Subject: Re: locking/csd-lock: Switch from sched_clock() to
 ktime_get_mono_fast_ns()
Message-ID: <3fcaa57b-72a2-4b20-8e8a-6238fbba1a78@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <da9e8bee-71c2-4a59-a865-3dd6c5c9f092@paulmck-laptop>
 <20241009180708.GU17263@noisy.programming.kicks-ass.net>
 <663ad810-3318-43af-8607-17ff7fe26e4a@paulmck-laptop>
 <20241010112132.GF17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010112132.GF17263@noisy.programming.kicks-ass.net>

On Thu, Oct 10, 2024 at 01:21:32PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2024 at 11:18:34AM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 09, 2024 at 08:07:08PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 09, 2024 at 10:57:24AM -0700, Paul E. McKenney wrote:
> > > > Currently, the CONFIG_CSD_LOCK_WAIT_DEBUG code uses sched_clock()
> > > > to check for excessive CSD-lock wait times.  This works, but does not
> > > > guarantee monotonic timestamps. 
> > > 
> > > It does if you provide a sane TSC
> > 
> > What is this "sane TSC" of which you speak?  ;-)
> > 
> > More seriously, the raw reads from the TSC that are carried out by
> > sched_clock() are not guaranteed to be monotonic due to potential
> > instruction reordering and the like.  This is *not* a theoretical
> > statement -- we really do see this on the fleet.  Very rarely for any
> > given system, to be sure, but not at all rare across the full set of them.
> > 
> > This results in false-positive CSD-lock complaints claiming almost 2^64
> > nanoseconds of delay, which are not good complaints to have.
> 
> Ooh, so the real difference is that clocksource_tsc ends up using
> rdtsc_ordered() while sched_clock() ends up using rdtsc(), and you're
> actually seeing that reordering happen.

You got it!

> *urgh*.
> 
> Yes, please put that in the Changelog.

I will do so on my next rebase.  And thank you for looking this over!

							Thanx, Paul

