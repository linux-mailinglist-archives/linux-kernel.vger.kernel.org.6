Return-Path: <linux-kernel+bounces-269276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7149430DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753DEB2201F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DEA1AE843;
	Wed, 31 Jul 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9oXR+8t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D52208E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432660; cv=none; b=ErYbnamR4t7/+r6CJDmH6FSqoG9teDsDpQqSBkLTemUBjcqk6JY9TCVdKzveWpjO9isqPYTE5f6SksbK2wgnD5PebXpJB++nh0nVB4u0zV8ZxYukMBPucqm5qF56FJGXnhBxRovtNuS88QEE+5+ClgjjsMj04xt+GQGsXXqInBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432660; c=relaxed/simple;
	bh=jqJAzaOTm2RScK6GWOAQ/jhR9xZpUHY0WmCTG/7ICOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDI3Rw3el9sCdlTpH9qXPJhTDSwjGyYfciTHUo5TQ/QUMf5GYdsQD5mNLqgBo0v5O0+cLn8CgyidORWUmLvDySUjVvGMQlBa4BmFCcMMcSnGalFYB81pKgo3gG4Dgv50OuscIE+FIe5TxkOP3DHD3cqKmzFgrNWOWNYlfV7st4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9oXR+8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD7FC116B1;
	Wed, 31 Jul 2024 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722432659;
	bh=jqJAzaOTm2RScK6GWOAQ/jhR9xZpUHY0WmCTG/7ICOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9oXR+8t8ToDnC9wqVvIMM3RSXyzHkQkqTTvxaexMs1CT913qzh9RPYc6Bo+zlCzQ
	 T9Ew9WKFnPXraWNdeZK309a/LCyiepL9wE+KyvTpYehrkM/3AnV3zKqljByzI5Ge+x
	 ZXPSKJueE3QTXCIJiQc+DzUaYBl0+xZCcZTCRttmyDksPZ5MBRW/g9unO04ik6HVBP
	 VSbIbcMKddykuzOYZ3HnfdNKy88JN8P+qZBx7ydvs+RFZn/r+gshyqfx2EUgFA22e/
	 dsGslxMulJNJ+n+YTQDKwcDAV6YN4OfP8bB0suZyR02yXxTWyUWqbshkoQDt4kJDcS
	 54m5pzUYOUSSg==
Date: Wed, 31 Jul 2024 10:30:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: kan.liang@linux.intel.com, namhyung@kernel.org, adrian.hunter@intel.com,
	peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] perf jevents: Don't stop at the first matched pmu when
 searching a events table
Message-ID: <Zqo8kVXkN_UaTp6f@x1>
References: <20240716132951.1748662-1-kan.liang@linux.intel.com>
 <CAP-5=fVZVU7kMOHz7CC7O1+2dX844dHqhqMebzEKWMA=59am-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVZVU7kMOHz7CC7O1+2dX844dHqhqMebzEKWMA=59am-g@mail.gmail.com>

On Tue, Jul 16, 2024 at 09:30:01AM -0700, Ian Rogers wrote:
> On Tue, Jul 16, 2024 at 6:29 AM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > The "perf all PMU test" fails on a Coffee Lake machine.
> >
> > The failure is caused by the below change in the commit e2641db83f18
> > ("perf vendor events: Add/update skylake events/metrics").
> >
> > +    {
> > +        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
> > +        "Counter": "FIXED",
> > +        "EventCode": "0xff",
> > +        "EventName": "UNC_CLOCK.SOCKET",
> > +        "PerPkg": "1",
> > +        "PublicDescription": "This 48-bit fixed counter counts the UCLK cycles.",
> > +        "Unit": "cbox_0"
> >      }
> >
> > The other cbox events have the unit name "CBOX", while the fixed counter
> > has a unit name "cbox_0". So the events_table will maintain separate
> > entries for cbox and cbox_0.
> >
> > The perf_pmus__print_pmu_events() calculates the total number of events,
> > allocate an aliases buffer, store all the events into the buffer, sort,
> > and print all the aliases one by one.
> >
> > The problem is that the calculated total number of events doesn't match
> > the stored events in the aliases buffer.
> >
> > The perf_pmu__num_events() is used to calculate the number of events. It
> > invokes the pmu_events_table__num_events() to go through the entire
> > events_table to find all events. Because of the
> > pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
> > the events for cbox and cbox_0 are all counted.
> >
> > When storing events into the aliases buffer, the
> > perf_pmu__for_each_event() only process the events for cbox.
> >
> > Since a bigger buffer was allocated, the last entry are all 0.
> > When printing all the aliases, null will be outputted, and trigger the
> > failure.
> >
> > The mismatch was introduced from the commit e3edd6cf6399 ("perf
> > pmu-events: Reduce processed events by passing PMU"). The
> > pmu_events_table__for_each_event() stops immediately once a pmu is set.
> > But for uncore, especially this case, the method is wrong and mismatch
> > what perf does in the perf_pmu__num_events().
> >
> > With the patch,
> > $ perf list pmu | grep -A 1 clock.socket
> >    unc_clock.socket
> >         [This 48-bit fixed counter counts the UCLK cycles. Unit: uncore_cbox_0
> > $ perf test "perf all PMU test"
> >   107: perf all PMU test                                               : Ok
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/all/202407101021.2c8baddb-oliver.sang@intel.com/
> > Fixes: e3edd6cf6399 ("perf pmu-events: Reduce processed events by passing PMU")
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Awesome sauce, thanks!
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo

