Return-Path: <linux-kernel+bounces-358748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4EB998319
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2007328356D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19D1BDAA5;
	Thu, 10 Oct 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZh88Sje"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720A1BB6B3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554599; cv=none; b=Oa2B7kF5NewNLAonZo6/rTXFv4Sl/x8nzZPeuKedk/GMrjdhiya/WwmgirWA2dUbnr5M11FI6sSeImK4Tio7c60GGsvVX6nv1qOgjOxKWabzE1aakjeQQmoINx2gs9lENNSVEncCV/TZifRSoUd9SB7rmyhsYri+uBb8O0PnSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554599; c=relaxed/simple;
	bh=kM9D2WynxNY2zdfcHayYp2Ctga+NjJjo6fiObtLDi3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEi0GrA6C9p0HI1/16N8DxILhVuSEF3gfOrar228tHVso9SIo6V8pcMnpQQt8AZU5MJPB411WRJSymic7URSgwBgFRtEBQkzihEIG8X5nzktqgabxCF7E9c/7AzuCmsT8s0+e8olw05n7O78O86P9YmsmCoQqvkQM3qaiZCwR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZh88Sje; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=OfDF+4a1L1Mtd5QRVrSUZzHy5Hwtg+gFgPxzjCL3n3U=; b=NZh88SjePCA4ZpTgDYeFTSKCbx
	DIfSttWWf5f8w4vPl55fwjvVuibXPojTrFxhiCfwc52hXFhhKjbfb7vy70hgYUL0bLLsLvyrvbuoc
	rg0ImiiNmUnn9M/vUe1u23pc/TyPKPmwVxCT3v3rpG4pAiWIHSS9iqEz596X1NKl53i7ZDAjpkLeF
	QgVVQ68Z/HOdliIJG6l96BxjITkNb+b2LnRR3dIsQb4oujGtSmSIQf3AmtFM+riu33uL/WQq2OSCz
	vDmFfdMS5YuvdzaELLG1GetA0Ye/vGg6PjJlSYQ6wnUIDsEfFXzOLMtZbCLbQufyu1AcII8kYt5vN
	e4uQK81A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syq0j-00000005L6R-1pCg;
	Thu, 10 Oct 2024 10:03:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0FA55300C1F; Thu, 10 Oct 2024 12:03:09 +0200 (CEST)
Date: Thu, 10 Oct 2024 12:03:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241010100308.GE17263@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010091326.nK71dG4b@linutronix.de>

On Thu, Oct 10, 2024 at 11:13:26AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-10 10:10:32 [+0200], Peter Zijlstra wrote:
> > On Thu, Oct 10, 2024 at 08:32:07AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2024-10-09 11:24:09 [-0700], Paul E. McKenney wrote:
> > > > In order to support systems that currently run CONFIG_PREEMPT=n that
> > > …
> > > > Or am I once again missing your point?
> > > 
> > > The change is:
> > > | config PREEMPT_RCU
> > > |        bool
> > > |-       default y if PREEMPTION
> > > |+       default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> > > 
> > > Now:
> > > - CONFIG_PREEMPT select PREEMPT_BUILD
> > > - PREEMPT_RT select CONFIG_PREEMPTION
> > > - PREEMPT_DYNAMIC selects PREEMPT_BUILD
> > > 
> > > and PREEMPT_BUILD select CONFIG_PREEMPTION
> > > 
> > > so in the end, this change is a nop, right?
> > 
> > PREEMPT_RT selects PREEMPTION *and* has one of PREEMPT / PREEMPT_LAZY /
> > PREEMPT_DYNAMIC, all of which in turn select PREEMPT_BUILD, which
> > selects PREEMPTION.
> > 
> > (arguably we can remove the select PREEMPTION from PREEMPT_RT)
> > 
> > The proposed change is not a nop because the config: PREEMPT_LAZY=y
> > PREEMPT_DYNAMIC=n will result in false, while it will have PREEMPTION.
> 
> I have a config with PREEMPT_LAZY=y PREEMPT_DYNAMIC=n  and
> CONFIG_PREEMPT_RCU=y.
> 
> I can't deselect CONFIG_PREEMPT_RCU=y. This is because LAZY selects
> PREEMPT_BUILD and PREEMPT_RCU selects itself once PREEMPTION is on.

Oh, the entry isn't user selectable? Fix that perhaps?

-	bool
+	bool "Use preemptible RCU"

Or something along those lines -- I forever forget how Kconfig works.

