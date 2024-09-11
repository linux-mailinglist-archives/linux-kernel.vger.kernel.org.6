Return-Path: <linux-kernel+bounces-324565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC729974E55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0A81C26ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149F1862BE;
	Wed, 11 Sep 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHqv+usZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C498185938;
	Wed, 11 Sep 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046077; cv=none; b=u5vTuRAC0XaWO4DRqbXMcbfv+YdgQmVVONJFKBz+pjSpv7pqwcM+ZOpRLxOCon3SgpOfU/lYFZzdeTnzLXCKG0vNMlH2iP/7UIvW7Db+PSbOVygTJgBG4t25OctpHxiGrMvRAJavfmks/HOxo1na936H5hMpl3UVWQ2SYnvCZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046077; c=relaxed/simple;
	bh=YLU4xzSaV42y4wECNalFYkcBZIdqUSsMI9mUG/G/+Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGY7Qxw3hMHW/bAKO0k1NcoaB2EfB0kSJOi0vVZwMuSH/F2FR5X0pJPZ84W1lospjhLJ9DgI3p8AGkWLA5S3rL+2ETVkn33GgijXTXdwZOa81wK8mf7mcd7Q5cHMpsZjcVTJEjLH6G0v8o+jhl731+DRPomwGWwqamD+6GoAb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GHqv+usZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YZTQe0B0n8FuRrxJpiUXr7v6VvkARClaJnOd8Pt9hP0=; b=GHqv+usZjCCjfPqau/Mw1miyWp
	DDbS9Qoh9AIE0FNUSqscDxcMvgQo3KZ7PlbEvbe8mA2OV8YEbnkJq8CU2GRqBGpfvkDEpTvRrQsbQ
	BG/xZVMp+sf/oK2PuUcuhnc64mCQQEpoNk8YyqIa237oSg0M5xw0Ld6cmpfNlclJx4wEiD43Fg7BM
	BI9DD0AU/cZneEzFGrj0x2CjYYZ1tgJ2bb5XB4Wb0TN9+JHXxHsjZIjrs0+9BvhLr2nPRwOxayRqX
	HeDxTolunFj72ZZQTWkBsJ9eVvkqvG0bFsyaYIHbLwku7Sf2c/jfEXzqI3XDdzKutNNQ3gZMn5WC8
	8RqgE5Qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1soJQl-00000007hlo-1S1h;
	Wed, 11 Sep 2024 09:14:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA98E300729; Wed, 11 Sep 2024 11:14:30 +0200 (CEST)
Date: Wed, 11 Sep 2024 11:14:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:sched/core 69/70] drivers/cpufreq/cppc_cpufreq.c:227:20:
 error: use of undeclared identifier 'NSER_PER_MSEC'
Message-ID: <20240911091430.GN4723@noisy.programming.kicks-ass.net>
References: <202409110611.dmyDCkoe-lkp@intel.com>
 <f9d838d5-6b3d-4e7c-9bf6-cb2935320467@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d838d5-6b3d-4e7c-9bf6-cb2935320467@arm.com>

On Wed, Sep 11, 2024 at 09:15:24AM +0100, Christian Loehle wrote:
> On 9/10/24 23:20, kernel test robot wrote:
> > Hi Christian,
> > 
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > head:   6cbbb91711c6b17da3802a3cf072d3311828ca33
> > commit: b3a47ff095544af206b8885391a7bad662d06a57 [69/70] cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
> > config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240911/202409110611.dmyDCkoe-lkp@intel.com/config)
> > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409110611.dmyDCkoe-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409110611.dmyDCkoe-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> drivers/cpufreq/cppc_cpufreq.c:227:20: error: use of undeclared identifier 'NSER_PER_MSEC'
> >      227 |                 .sched_runtime  = NSER_PER_MSEC,
> >          |                                   ^
> >>> drivers/cpufreq/cppc_cpufreq.c:229:3: error: member reference base type 'long' is not a structure or union
> >      228 |                 .sched_deadline = 10 * NSEC_PER_MSEC
> >          |                                        ~~~~~~~~~~~~~
> >      229 |                 .sched_period   = 10 * NSEC_PER_MSEC,
> >          |                 ^~~~~~~~~~~~~
> >    2 errors generated.
> > 
> > 
> > vim +/NSER_PER_MSEC +227 drivers/cpufreq/cppc_cpufreq.c
> > 
> >    215	
> >    216	static void __init cppc_freq_invariance_init(void)
> >    217	{
> >    218		struct sched_attr attr = {
> >    219			.size		= sizeof(struct sched_attr),
> >    220			.sched_policy	= SCHED_DEADLINE,
> >    221			.sched_nice	= 0,
> >    222			.sched_priority	= 0,
> >    223			/*
> >    224			 * Fake (unused) bandwidth; workaround to "fix"
> >    225			 * priority inheritance.
> >    226			 */
> >  > 227			.sched_runtime	= NSER_PER_MSEC,
> 
> Sorry, seems I enabled the module, but didn't actually build modules
> before sending it out, anyway this should be s/NSER/NSEC
> 
> >    228			.sched_deadline = 10 * NSEC_PER_MSEC
> and this is missing a comma.
> Peter do you mind fixing that up for me?

I'll fix it up. I need to rebase sched/core anyway.

Thanks!

