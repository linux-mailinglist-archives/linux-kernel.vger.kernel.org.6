Return-Path: <linux-kernel+bounces-359343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE9998A67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAAA1C242CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7901CB311;
	Thu, 10 Oct 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKXXT+se"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358091C9ECA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571159; cv=none; b=kKshlzR2bVI3PGc21pVG/62tAXYF0zr8geJkERTetUugxACcr1+i20tkhZRVgr5wCfDLo41LdgKnpdIW++JiIlhsmCpredWACR5xfQKA1Skhr6YDk8eJ8OD+0LFppfvJ4+uxztM+cgkFt6tj1cdr3zyCyr9AZexuvPcLbzuEp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571159; c=relaxed/simple;
	bh=bLAMxmw57v6y43tNw42efrmUPrXjGUltnnJSlL0YENw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWnsvIiSB4m0ev+y7vz7y9R7lRxGVU/ALohNZQH2FCVB+3GTVufwkrfGtqvca+K/h+bgWGHKRW2ldr5ZkugMbJ3+VikBj/FuTx4msbLECZkdYG2cZEDwqyPV17yIZHe38XiMR3ODWrNuhzVoUm2TcGBpgh8YlLU18AVE8tLr3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKXXT+se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B167BC4CEC5;
	Thu, 10 Oct 2024 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728571158;
	bh=bLAMxmw57v6y43tNw42efrmUPrXjGUltnnJSlL0YENw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HKXXT+seYo9I59+hIKRSRmFacXE0SOs84jPEUxWSP+6rGmca8IwUif+nqd3RnZp4q
	 Xds/yqN6vGAaDopEAi8VidW/yfmww1L5A5NYi3pOaHEclxvYOHnPIcNTSoVL+w315v
	 ZdRbcAQP4Y4iI3iPNjrGK0MAER6HEZe/w9Eb49ntihFVEKN2ub5WRgHCMlV/MP/Sy1
	 jA4aoPyTQJf9blka5wBZoH8GHaWzvPm4q1OJrHK2uuQaDYJD73SvLcO6BbzSycEDJ4
	 Bg3hltm5l5JUHODXuUw50MMjeq62pZIIXJLIhnYn0++VbnhG5Rzg0h8MRgUodt0hEa
	 bIfP0bB+yGFIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4526ECE08E5; Thu, 10 Oct 2024 07:39:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:39:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 6/7] osnoise: handle quiescent states for PREEMPT_RCU=n,
 PREEMPTION=y
Message-ID: <1ca086f8-5885-410d-974d-8d9d5ee514fe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-7-ankur.a.arora@oracle.com>
 <20241010065338.sw4zZlbm@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010065338.sw4zZlbm@linutronix.de>

On Thu, Oct 10, 2024 at 08:53:38AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-09 09:54:10 [-0700], Ankur Arora wrote:
> > To reduce RCU noise for nohz_full configurations, osnoise depends
> > on cond_resched() providing quiescent states for PREEMPT_RCU=n
> > configurations. And, for PREEMPT_RCU=y configurations does this
> > by directly calling rcu_momentary_eqs().
> > 
> > With PREEMPT_LAZY=y, however, we can have configurations with
> > (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
> > can help.
> 
> PREEMPTION=y, PREEMPT_RCU=n should not be possible.

PREEMPT_LAZY=y, PREEMPT_RCU=n really does need to be possible in order to
avoid OOM on systems not abundantly endowed with memory.  This gets the
improvement in tail latencies from PREEMPT_LAZY but the OOM resistance
of PREEMPT_RCU=n.  Such systems really do not want to be preempting
RCU readers.

							Thanx, Paul

> > Handle that by fallback to the explicit quiescent states via
> > rcu_momentary_eqs().
> 
> Sebastian

