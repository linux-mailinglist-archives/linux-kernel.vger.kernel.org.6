Return-Path: <linux-kernel+bounces-313816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274CA96AA39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D759F286B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73862AE66;
	Tue,  3 Sep 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL4DE/eK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364823D7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399168; cv=none; b=UWkNvXmpOkb2bhE13CyFWW8enMX+yfCe66ySqLYIIXktOwQpHm95FBHs9OjgxtLnYAKvPBi71oOocgRsTxT0Stoh+5JfanFsaRlbJ4T/y4ZDr4u6nMWF8sbhl8kQiWMQ1YiOJvDpqZFUZ2lZqqvbfMhXxIRMtLrWDWTlp4cuy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399168; c=relaxed/simple;
	bh=GyyndvoREaiM/3ujgK6LwQA/rXrGzNtE/pzmlBIBHtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etW/VjUnxWku6tRJYpnGnbku4FDt8yDO/VUzMi+at5aaYac6nfBRy5daUDS/W8QQypBb08iKwat2p4nQLy6b2rVrwfas+kJmRreCD/00zSV0raMxO2U5RqFf4W6z/8Pp4Ac9kVu/2KgYT0CVEezamGJr/y8GN7C9BPHKN3SzAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL4DE/eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCA9C4CEC4;
	Tue,  3 Sep 2024 21:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725399168;
	bh=GyyndvoREaiM/3ujgK6LwQA/rXrGzNtE/pzmlBIBHtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EL4DE/eKeHj0XxrlvOVCQpq1gvebkl+wxBfua/Z6SnbAvvNxki3higTq0PzL8F3QL
	 yeMrzkFxoukQ29K4H+PYe2mJbLFMkqSJ6YLUaq2XQmYyLCsysIZWmUcN/eBsUk1XR4
	 NyQ8wW0tXHzW6RULl45xD3a0ZzxYU7g6LWrc08eg1qp014zsAn0+3buQ/taZbMlqHc
	 08yeYoU9uniaVXttOjR1yymfDn35uPQNyR/anWBiDukFHPkc4M1t4yt6VujZtb3PPz
	 Au9k4eonjJNBceRgObZD+plnt8Wq5QKqznT/RiPlE/y3V4LpqissakbXKsaQEF2lls
	 HmS4A6d1lxxiw==
Date: Tue, 3 Sep 2024 23:32:45 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <ZteAfUXZd1TgIwiL@pavilion.home>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>

Le Tue, Sep 03, 2024 at 09:24:08AM -0400, Waiman Long a écrit :
> 
> On 9/3/24 09:10, Frederic Weisbecker wrote:
> > Le Sun, Aug 18, 2024 at 07:45:18PM -0400, Waiman Long a écrit :
> > > The HK_FLAG_SCHED/HK_TYPE_SCHED flag is defined and is also used
> > > in kernel/sched/fair.c since commit de201559df87 ("sched/isolation:
> > > Introduce housekeeping flags"). However, the corresponding cpumask isn't
> > > currently updated anywhere. So the mask is always cpu_possible_mask.
> > > 
> > > Add it in nohz_full setup so that nohz_full CPUs will now be removed
> > > from HK_TYPE_SCHED cpumask.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   kernel/sched/isolation.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > index 5891e715f00d..a514994af319 100644
> > > --- a/kernel/sched/isolation.c
> > > +++ b/kernel/sched/isolation.c
> > > @@ -196,7 +196,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
> > >   	unsigned long flags;
> > >   	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> > > -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
> > > +		HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED;
> > >   	return housekeeping_setup(str, flags);
> > >   }
> > find_new_ilb() already has HK_FLAG_MISC to prevent an isolated CPU
> > from being elected as an ilb. So I think we should simply remove HK_FLAG_SCHED.
> 
> There is a check for HK_TYPE_SCHED in nohz_balance_enter_idle() and
> nohz_newidle_balance(), though it is essentially a no-op as the cpumask has
> all the CPUs. If we remove HK_TYPE_SCHED, the question now will be whether
> we should remove the checks at these 2 functions or change them to
> HK_TYPE_MISC.

Just remove those two. They are dead code and the nohz_full handling
of load balancing needs a rethink anyway.

After discussing with Peter lately, the rules should be:

1) If a nohz_full CPU is part of a multi-CPU domain, then it should
   be part of load balancing. Peter even says that nohz_full should be
   forbidden in this case, because the tick plays a role in the
   load balancing.

2) Otherwise, if CPU is not part of a domain or it is the only CPU of all its
   domains, then it can be out of the load balancing machinery.

I'm a bit scared about rule 1) because I know there are existing users of
nohz_full on multi-CPU domains... So I feel a bit trapped.

Thanks.

