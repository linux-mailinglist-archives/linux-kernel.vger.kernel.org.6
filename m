Return-Path: <linux-kernel+bounces-318918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818F96F50F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1B01F24828
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457721CDA20;
	Fri,  6 Sep 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhzRh/AN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79621E49B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725628235; cv=none; b=D0ayg+wB6DKYC2945Ui9OWKZMt04AO1xFvy+lxzpyL8pZ6Dk2oAFxKF1CIoUk7t37eH1cENGbUO7wi6AbD7NAB4eh9N3cfl8T/R1GxWf+z+8f0ZVvv07kXQ1XdvbfJjova0N3o+yE2RAIjwklL9b5cCLuFyOR4e7YTcFcI9ZsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725628235; c=relaxed/simple;
	bh=SjCpK4YxhA4NFDel93EF/tr7xjh4cKtGoeGBmBY/kDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmndjlNMlHD/EyamTiKbUK4MJnTyl8xobJH7CFKhPKTpa2Tt/Tbf4lLbTirUWBFjcoYNxPRoiS2iIZOXOtaEiqlffwNWEp4J4XyLa3NF/BBwHHwCbFLZjORWNJqEKPnQWL5leHmP74yNaO+YolhBcLANuUDlCo9Hv2AffT/cr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhzRh/AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7496C4CECD;
	Fri,  6 Sep 2024 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725628235;
	bh=SjCpK4YxhA4NFDel93EF/tr7xjh4cKtGoeGBmBY/kDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhzRh/ANRwLypdO8NJt/7t6WYIbdg/dIye9Dc36AXUuOm0fD6WreSgzI0acKbuOaG
	 Xhi4ypLKD8DApjIN4zavJea51BP5TKRJG7wBAk3++ikOq2EaZ3meK50aN4MIenXoxX
	 b38ri9eqDng+UcA3Z041J5nxfaxjNJbjkBF7LPyYnGu0Dc8uxiVZK3r81I20qExgIH
	 DsazoKf6zl6b6jWI5zdEA0Ygjy6zbaz4Bf/IT555Tkq+hJsX1PZ2JRl8RciyHBFdWy
	 kvM9bmlhQ528y4H7EKTcHaF+957mIOpCrdVyXYbz2f+CEF7VNyJq9YoiMp0OVipp27
	 5UmacX5MiH8pg==
Date: Fri, 6 Sep 2024 15:10:32 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v3 2/2] sched/isolation: Consolidate housekeeping
 cpumasks that are always identical
Message-ID: <Ztr_SIwkOK1MXTIW@pavilion.home>
References: <20240904183650.1053708-1-longman@redhat.com>
 <20240904183650.1053708-3-longman@redhat.com>
 <ZtjOmPV0V7jbYqfO@pavilion.home>
 <4b976f7c-b105-4093-8838-eae26fc7de85@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b976f7c-b105-4093-8838-eae26fc7de85@redhat.com>

Le Wed, Sep 04, 2024 at 07:57:13PM -0400, Waiman Long a écrit :
> > > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > > index 499d5e480882..e2c42172de82 100644
> > > --- a/include/linux/sched/isolation.h
> > > +++ b/include/linux/sched/isolation.h
> > > @@ -7,15 +7,21 @@
> > >   #include <linux/tick.h>
> > >   enum hk_type {
> > > -	HK_TYPE_TIMER,
> > > -	HK_TYPE_RCU,
> > > -	HK_TYPE_MISC,
> > >   	HK_TYPE_TICK,
> > >   	HK_TYPE_DOMAIN,
> > > -	HK_TYPE_WQ,
> > >   	HK_TYPE_MANAGED_IRQ,
> > > -	HK_TYPE_KTHREAD,
> > > -	HK_TYPE_MAX
> > > +	HK_TYPE_KERNEL_NOISE,
> > > +	HK_TYPE_MAX,
> > > +
> > > +	/*
> > > +	 * The following housekeeping types are only set by the nohz_full
> > > +	 * boot commandline option. So they can share the same value.
> > > +	 */
> > > +	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
> > > +	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
> > > +	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
> > > +	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
> > > +	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
> > Why not removing them entirely and only keep HK_TYPE_KERNEL_NOISE ?
> 
> All these HK_TYPE_* types are still used in other parts of kernel. We need
> to clean them all up before we can remove them, but that is outside the
> scope of this series.

If that can help, I posted this a while ago:

https://lore.kernel.org/lkml/20230203232409.163847-2-frederic@kernel.org/

I think it is very much needed. People keep getting confused about these individual
bits.

> Cheers,
> Longman
> 
> 

