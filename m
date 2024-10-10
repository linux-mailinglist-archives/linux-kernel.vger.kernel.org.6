Return-Path: <linux-kernel+bounces-359293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F129989D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A9428CF72
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338431CEE93;
	Thu, 10 Oct 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFE3ekTt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFE1CEADA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570582; cv=none; b=ZdsICFvPlXrbcJgREdCLvkkiXAoGdZ2oiqOJM6gvksqCyz9AojLQnb/p7cfFCFnVTiY5CwWLZotT2tZf8gK/UKeDiRFmphxPxGm2iI6qqGWV7a4Yhsu0FZtzo9K/9aZFBL7Ed4e5iouMdsd5FgxXBiU2VDRmNXz+676gImSSbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570582; c=relaxed/simple;
	bh=rtlbjuzcADmgbrzhURitQkm8HfaRBDB1VunjDdEsWsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjU6PrlzvGPzdZ141UzbnZLzQWNYqC61aZQXS55x+s/DicJ9WNtw2IzWTfZszzTC9UqyYcKBYEPpHclM8ZFYgjxYMrLM8zySbZUoNIGpHAERu3tS6quDZYoUSTATbc6rCotXATqrrZEt3v08pyqFC8HUyGTO47WcdxMLnDG53hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFE3ekTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1CAC4CEC5;
	Thu, 10 Oct 2024 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728570582;
	bh=rtlbjuzcADmgbrzhURitQkm8HfaRBDB1VunjDdEsWsA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qFE3ekTto8xRKdtmfwvET7PHIkCRbZsW2VecpjYcf5IXDatWqaelchyr+XPC2J0UZ
	 vL8UrCfuNCbLVXGrojFzcvBN5uTa/h2Rlht94X4bjdmQIBAQLMmRr31rSfAaH58dfh
	 huUz7ou+0csv+Pm5Rjv8iWkewhfrjAZlQfc6Q1wQxhpslz42ztdC+Gw3pD3GPYNLJo
	 rwt8f0DVp0U6SLwbYQeVNBXKUVrs3h1rNyTcN80yrbOU+G9+ZHdaYwuBhTxIeGvqZK
	 5zRitQXTYqFqcteZClOY3Lr8xxdvqAZQV+w5+Tc2VkVY9G3g0iKIf1b3OhaZrJI65P
	 Or7dTVJRfUOEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC01DCE08E5; Thu, 10 Oct 2024 07:29:41 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:29:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 3/7] rcu: fix header guard for rcu_all_qs()
Message-ID: <497e034a-ec03-4aac-ae15-aae1bf30d263@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-4-ankur.a.arora@oracle.com>
 <20241010064123.WJjDYegr@linutronix.de>
 <20241010081129.GB17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010081129.GB17263@noisy.programming.kicks-ass.net>

On Thu, Oct 10, 2024 at 10:11:29AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 08:41:23AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-10-09 09:54:07 [-0700], Ankur Arora wrote:
> > > rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
> > > is conditioned on CONFIG_PREEMPTION.
> > > 
> > > With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
> > > CONFIG_PREEMPT_RCU=y.
> > 
> > From kernel/rcu/Kconfig:
> > | config PREEMPT_RCU
> > |         bool
> > |         default y if PREEMPTION
> > 
> > this looks like PREEMPT_RCU implies PREEMPTION.
> 
> The point was to make PREEMPT_RCU=n possible even when PREEMPTION=y,
> which is fine.

Agreed!

							Thanx, Paul

