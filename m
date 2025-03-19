Return-Path: <linux-kernel+bounces-568802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A87A69A99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588807AB59F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04470219A67;
	Wed, 19 Mar 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJFUpwIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FE218585
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418595; cv=none; b=AulT62dYYZ0WKYY6iUnWiY4gLNKDzvwhpCAHMlhcVtwGYl4c8929PrskYXLj7ywHFt12gHIDzBt4v3anYDQm4J5Dc4f24j0/kaVrNmWxf5Ga0JiXzUl7VgprNoUGAFq05YBVlRcGEqF9h3jXGuoJkurAXhzi1suhSOLmLfbI56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418595; c=relaxed/simple;
	bh=DtLzZ995TqoFa4x3we3CV5CTIUxWi8A16R0Kegkh084=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuTlneInkLtFEnvKt0qAkA6vp9R71z2h0f9pmHYsnqvDwK8R4VReebOwJyaN8xqotZQzcg64uqfhSfphVxIfGtrbUwARlaIpwgEaUlHA7levpFrFm74n2ISXs7OGveHj236uX7q1T+31AhDynZh7sXhU5HrCQdu8JlCQsQF91do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJFUpwIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79089C4CEE4;
	Wed, 19 Mar 2025 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742418594;
	bh=DtLzZ995TqoFa4x3we3CV5CTIUxWi8A16R0Kegkh084=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJFUpwIFAHSM9zvzskh2nspytZzzXOJ8K6k/D6kmADfKNBL3AXGYGIA+kJQM/kKU5
	 POfMGgc6WO5lY5BU3LIOp1FxDDmz3lIYx+2AKdwWq8fQ/5r0Afrtnlv5AX3hOslYJk
	 XSU0bZYPkFwaZ16qjrskLf4rJuJ8BxyylXe0kD7KVy7xC5vQbWBMPP4j0w+eTdrdIN
	 7kKxXEDkITv7G+wzL8DxLbmZkMMtvWBvhW9rDhafZ071KAzRtwAwTlvF+AYwWrgv0P
	 AwJOtwoNMqNW4X/49WEby45yB3kabe0SrommZ3yOWLDmeTpRGhBlb3eDtQaJQAk6QQ
	 BUxeSRIJZkGFQ==
Date: Wed, 19 Mar 2025 22:09:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
Message-ID: <Z9syncxlUbb_oj4Q@gmail.com>
References: <20250317104257.3496611-1-mingo@kernel.org>
 <xhsmh4izppfqw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh4izppfqw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>


* Valentin Schneider <vschneid@redhat.com> wrote:

> On 17/03/25 11:42, Ingo Molnar wrote:
> > For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
> > in all the major Linux distributions:
> >
> >    /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y
> >
> > The reason is that while originally CONFIG_SCHED_DEBUG started
> > out as a debugging feature, over the years (decades ...) it has
> > grown various bits of statistics, instrumentation and
> > control knobs that are useful for sysadmin and general software
> > development purposes as well.
> >
> > But within the kernel we still pretend that there's a choice,
> > and sometimes code that is seemingly 'debug only' creates overhead
> > that should be optimized in reality.
> >
> > So make it all official and make CONFIG_SCHED_DEBUG unconditional.
> > This gets rid of a large amount of #ifdefs, so good riddance ...
> >
> 
> Pretty much every distro I'm aware of has CONFIG_SCHED_DEBUG=y; a quick check
> tells me it's been like so for RHEL since at least 2013, and that's from a
> commit copying configs from RHEL-6 to RHEL-7.
> 
> Two things however come to mind:
> 
> 1) What does this mean for the debug stuff we've repeatedly said wasn't ABI
>    because it was under CONFIG_SCHED_DEBUG? I've been burned by making
>    sched_domain.flags read-only, and there's still writable stuff:
> 
>    # ls -al /sys/kernel/debug/sched/domains/cpu0/domain0/
>    total 0
>    drwxr-xr-x. 2 root root 0 Mar 19 04:36 .
>    drwxr-xr-x. 3 root root 0 Mar 19 04:36 ..
>    -rw-r--r--. 1 root root 0 Mar 19 04:36 busy_factor
>    -rw-r--r--. 1 root root 0 Mar 19 04:36 cache_nice_tries
>    -r--r--r--. 1 root root 0 Mar 19 04:36 flags
>    -r--r--r--. 1 root root 0 Mar 19 04:36 groups_flags
>    -rw-r--r--. 1 root root 0 Mar 19 04:36 imbalance_pct
>    -r--r--r--. 1 root root 0 Mar 19 04:36 level
>    -rw-r--r--. 1 root root 0 Mar 19 04:36 max_interval
>    -rw-r--r--. 1 root root 0 Mar 19 04:36 max_newidle_lb_cost
>    -rw-r--r--. 1 root root 0 Mar 19 04:36 min_interval
>    -r--r--r--. 1 root root 0 Mar 19 04:36 name
> 
>    + all the non topology related debug knobs.

Yeah, I don't think these or other sysctls are as contentious as 
previously thought. We might want to put '/debug/' into the directory 
name above, or we could move it over to debugfs entirely - but we 
should make it clear via the name that these are debugging knobs in 
essence.

> 2) Peter mentioned a few times that, last time it was benchmarked, there
>    were noticeable perf differences between CONFIG_SCHED_DEBUG=n and
>    CONFIG_SCHED_DEBUG=y. This would be an occasion to re-measure that and
>    potentially move (some of) these checks to e.g. a sched_debug_verbose
>    static key.

Yeah, and this is an argument strongly *in favor* of eliminating 
CONFIG_SCHED_DEBUG: in a way the CONFIG_SCHED_DEBUG "option" created a 
false sense of "it's only debug code". But it's not a genuine debug 
option, it's actual overhead for the vast majority of Linux distros and 
users.

So let's just eliminate SCHED_DEBUG, and fix any overhead. It's exactly 
what we should do anyway - nothing changes IMHO, just the appearance of 
urgency. :-)

Thanks,

	Ingo

