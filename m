Return-Path: <linux-kernel+bounces-324563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A3B974E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C7F283358
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4116B391;
	Wed, 11 Sep 2024 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mj4abAQJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325555339F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046025; cv=none; b=WJh/slRBtP1qX8ALrVZ4YYPO8WpAFWFZTN8HV4eXv9MQtAU24m02AQrg8djR0hqXzY1+2Fewtiz9sgsCiIqpcOMIEdlHZW0Uthl048eS2Xeqor4fSu6UHk+L0JtOJR0YZhTs0bqghu6diSueVm/iZeLBsV7jN4aWsJMkQUoqiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046025; c=relaxed/simple;
	bh=+TPij8FfGpoiqOZVfxF7YnF6MD7c4NnCFj3YmqLJpRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHkwmtKKgHeEmpDaHKpe+0+9ak4N/TEyv95RaNP83QErCl6BRHzSGGbmPn+QQHLPDnhSVs0K5SPffpwxlfLOJMA8L66vuVSEHPw6olojKS3QX8Vmt8lJ1pB8p/Cldr7nNfzLS2Im0qWWes8AyIOwbPktW0tG/LovgZPxxOE+rk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mj4abAQJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=34o6bTM0ZyPEB27rus1S/oT82gPMUgCCbVenuFYnt/c=; b=mj4abAQJXkdF+lR7gclmvb96me
	AUmBwIv8nLgNzWL3hv7LTebQCoELGemqfTudQ0Swv9BAvHDXJfcVRApLXe5M1FpNaNqYR8rlbP326
	gzECLfhSIKqyi8+v8FUyKVhdZGTiy3gHq6RJ6QWQstD6iHNkARuVTWvhoobp03W1Pb4GYatlDNAKJ
	JNq/ZWFkPoC7UOylMTtOjgecSs4KY8J7nUsLGOg4V1J+PYQ0vSCcWEICl/6OpffRpO2WiZbv/buRt
	w7g/e46MRSwtZVF3FS0/WhzIkgkwHmgVU5neqntrHIxrEEPVEKIffSZaz4tYpPu2nouc9iku+gYa7
	Abq3ZEnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1soJPk-00000000963-1jev;
	Wed, 11 Sep 2024 09:13:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1095B300642; Wed, 11 Sep 2024 11:13:28 +0200 (CEST)
Date: Wed, 11 Sep 2024 11:13:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Luis Machado <luis.machado@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com,
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Message-ID: <20240911091328.GM4723@noisy.programming.kicks-ass.net>
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>

On Wed, Sep 11, 2024 at 11:10:26AM +0200, Mike Galbraith wrote:
> On Wed, 2024-09-11 at 10:45 +0200, Peter Zijlstra wrote:
> > On Wed, Sep 11, 2024 at 09:35:16AM +0100, Luis Machado wrote:
> > > > 
> > > > I'm assuming that removing the usage sites restores function?
> > > 
> > > It does restore function if we remove the usage.
> > > 
> > > From an initial look:
> > > 
> > > cat /sys/kernel/debug/sched/debug | grep -i delay                                                                                                                                                                                                                             
> > >   .h_nr_delayed                  : -4
> > >   .h_nr_delayed                  : -6
> > >   .h_nr_delayed                  : -1
> > >   .h_nr_delayed                  : -6
> > >   .h_nr_delayed                  : -1
> > >   .h_nr_delayed                  : -1
> > >   .h_nr_delayed                  : -5
> > >   .h_nr_delayed                  : -6
> > > 
> > > So probably an unexpected decrement or lack of an increment somewhere.
> > 
> > Yeah, that's buggered. Ok, I'll go rebase sched/core and take this patch
> > out. I'll see if I can reproduce that.
> 
> Hm, would be interesting to know how the heck he's triggering that.
> 
> My x86_64 box refuses to produce any such artifacts with anything I've
> tossed at it, including full LTP with enterprise RT and !RT configs,
> both in master and my local SLE15-SP7 branch.  Hohum.

Yeah, my hackbench runs also didn't show that. Perhaps something funny
with cgroups. I didn't test cgroup bandwidth for exanple.

