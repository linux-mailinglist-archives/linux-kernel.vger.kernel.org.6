Return-Path: <linux-kernel+bounces-438095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F39E9CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F1C1887878
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130114F9F8;
	Mon,  9 Dec 2024 17:12:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5E313AA2F;
	Mon,  9 Dec 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764333; cv=none; b=M6+ou6rfmSxFScQBh58IUxJEmVJLOzq/pc/AMnTD5rT8JwhH2ZRKIHzfswQ/M3Hm/ZAwgL/7m+OLyNJG8taMz5DzgOu9pf6WhAhdctPyrnxXa5gCxOFug8qzGUl84Pvs1YB/prm1R49y+MoRCpIRW9glC0ox9kpBrrUtOhRwuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764333; c=relaxed/simple;
	bh=hzUyGNVfCQBZvBO5ORr/vOicfzOFSqA0ThYtXXos5fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRJiCnCMIx7NcMbwltKh9nA4ciDVcOmz7BFmS2v1hQQw8VY14d7pDxW8MlZa4w+eyrUBAXp47FCP7R/g+V+IP0/0C7iabYa1xB2KgbplCJ7LjB9LEB9n+cXaoB1vthH+HgCbPYQdsdS3/DdOiTkz3X2jdSXa8xWWBNArsKgsddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0EE6113E;
	Mon,  9 Dec 2024 09:12:38 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469FA3F720;
	Mon,  9 Dec 2024 09:12:09 -0800 (PST)
Date: Mon, 9 Dec 2024 17:12:06 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Cristian Marussi" <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: round rate bisecting in
 discrete rates
Message-ID: <Z1ck5tFkb41wReZP@bogus>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-3-etienne.carriere@foss.st.com>
 <Z1bKlOeHJFHpe9ZU@bogus>
 <ed164b6704ab4086b2fb22ae51658f31@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed164b6704ab4086b2fb22ae51658f31@foss.st.com>

On Mon, Dec 09, 2024 at 12:59:58PM +0000, Etienne CARRIERE - foss wrote:
> Hello Sudeep,
> 
>  On Monday, December 9, 2024 11:46 AM, Sudeep Holla wrote: 
> > On Tue, Dec 03, 2024 at 06:39:08PM +0100, Etienne Carriere wrote:
> > > Implement clock round_rate operation for SCMI clocks that describe a
> > > discrete rates list. Bisect into the supported rates when using SCMI
> > > message CLOCK_DESCRIBE_RATES to optimize SCMI communication transfers.
> > 
> > Let me stop here and try to understand the requirement here. So you do
> > communicate with the firmware to arrive at this round_rate ? Does the
> > list of discreet clock rates changes at the run-time that enables the
> > need for it. Or will the initial list just include max and min ?
> 
> I don't expect the list to change at run-time. The initial list is
> expected to describe all supported rates. But because this list may
> be big, I don't think arm_scmi/clock.c driver should store the full list
> of all supported rates for each of the SCMI clocks. It would cost to
> much memory. Therefore I propose to query it at runtime, when
> needed, and bisect to lower the number of required transactions
> between the agent and the firmware.
>

Ah so, this is nothing to do with set_parent, but just an optimisation.
This change optimises for space but some other platform may have all the
space but the communication with SCMI platform is not good enough to make
runtime calls like this change. How do we cater that then ?

We need some spec-ed way or a unique way to identify what is best for
the platform IMO. We can change the way you have done in this change set
as someone else may complain in the future that it is costly to send
such command every time a clock needs to be set. I am just guessing here
may not be true.

> > 
> > > Parse the rate list array when the target rate fit in the bounds
> > > of the command response for simplicity.
> > >
> > 
> > I don't understand what you mean by this.
> 
> I meant here that we bisect into supported rates when communicating
> with the firmware but once the firmware response provides list portion
> when target rate fits into, we just scan into that array instead of bisecting
> into. We could also bisect into that array but it is likely quite small
> (<128 byte in existing SCMI transport drivers) and that would add a bit
> more code for no much gain IMHO.
> 
> 
> > 
> > > If so some reason the sequence fails or if the SCMI driver has no
> > > round_rate SCMI clock handler, then fallback to the legacy strategy that
> > > returned the target rate value.
> > >
> > 
> > Hmm, so we perform some extra dance but we are okay to fallback to default.
> > I am more confused.
> 
> Here, I propose to preserve the exiting sequence in clk/clk-scmi.c in case
> arm_scmi/clock.c does not implement this new round_rate SCMI clock 
> operation (it can be the case if these 2 drivers are .ko modules, not
> well known built-in drivers).
>

I don't think it would work if it is not built on the same kernel anyways.
I don't work much about this use-case.

> > 
> > > Operation handle scmi_clk_determine_rate() is change to get the effective
> > > supported rounded rate when there is no clock re-parenting operation
> > > supported. Otherwise, preserve the implementation that assumed any
> > > clock rate could be obtained.
> > >
> > 
> > OK, no I think I am getting some idea. Is this case where the parent has
> > changed and the describe rates can give a different result at run-time.
> 
> This does not deal with whether parent has changed or not. I would expect
> the same request sent multiple times to provide the very same result. But
> as I said above, I don't think arm_scmi/clock.c should consume a possibly
> large array of memory to store all supported rate each of the SCMI clocks
> (that describe discrete rates).
>

Right, my assumption was totally wrong. Thanks for confirming.

> An alternate way could be to add an SCMI Clock protocol command in the
> spec allowing agent to query a closest supported rate, in 1 shot. Maybe
> this new command could return both rounded rate and the SCMI parent
> clock needed to reach that rounded rate, better fitting clk_determine_rate()
> expectations.
>

May be that would be ideal but you need to make a case for such a spec change.

> > 
> > I need to re-read the part of the spec, but we may need some clarity so
> > that this implementation is not vendor specific. I am yet to understand this
> > fully. I just need to make sure spec covers this aspect and anything we
> > add here is generic solution.
> > 
> > I would like to avoid this extra query if not required which you seem to
> > have made an attempt but I just want to be thorough and make sure that's
> > what we need w.r.t the specification.
> 
> Sure, I indeed prefer clear and robust implementation in the long term,
> being the one I propose here or another one.
> 

Good then, we can work towards achieving that. If you can specify how slow
or memory hungry is it without these changes and how much this change helps
your platform, we can take it up with spec authors and see if they are happy
to provide some alternative to deal with this in a generic way.

--
Regards,
Sudeep

