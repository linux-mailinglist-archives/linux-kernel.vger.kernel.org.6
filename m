Return-Path: <linux-kernel+bounces-344777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792598AE29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CB41C22316
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6365E1A0BCF;
	Mon, 30 Sep 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp+jErUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD75619882F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727748; cv=none; b=qcpe9BQ6Lwxg4SDE8+ub1ObDJ1I0Ua8fR1nxmAfIqQdg3rqrF0v8BUPHCJKDcQ9fXKsOwaNEUMHgNLqADC8eeDiIhR8cXF9OC5aUlZwkaOTH0+QCJ2tc3VA1ssGTBnrYZ9W7tSE1J+LbLH103dQTGuo8UCbgoIELKRIGwv7VxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727748; c=relaxed/simple;
	bh=A1wHnKiaTlaypR5dONAN1Xy73fJmQWSKqqtUSv7ruNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItaT13GcAEmZmpJrzFGxTKBsMQUn1jJ7CfxruZjAXZ8s7lEk0BoavOJUNP9wesumAR9GCdWMCO8fFBhpZhoUmtiF05y5KwrtZ8tTJWBomqbQTanWOgqcz7GH4qaeSRVdwAY5K3duH1xPPJLwKI43zUME656+toN977Q2Y1cNL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp+jErUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A204C4CEC7;
	Mon, 30 Sep 2024 20:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727748;
	bh=A1wHnKiaTlaypR5dONAN1Xy73fJmQWSKqqtUSv7ruNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xp+jErUBnN4FRGCPZ00b7N2Qfq0C7hHCUCs6Hxx8K/lKAh3I+fQ5MK+9ynMKArF99
	 9lqsfhxlErN+k/V6+G+M4hlDozJJXDkNGMH5QZx6BrYA7bGYU8aS1APlOo7Wqr05Mk
	 5jZESEs/RSu4+puT0XnLplS82XQHtsaJp3X9FTuObdgmIShyTDi8aEtcO/Fw8S64kz
	 LwncCYSJKjWwtd0wnbBALoTAIW3gzf3HVDMGnA1Vv67qiuki70HZD1WC/qwtG4jCvI
	 REgVz/lunJPtwR0Zsy0o8EXoOAQHzSxwa5pmPfrIBgvhcGOhc012ZhwqaSpIzDi4so
	 AdgRYtjlmzUzA==
Date: Mon, 30 Sep 2024 13:22:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, kan.liang@linux.intel.com,
	adrian.hunter@intel.com, peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] perf jevents: Don't stop at the first matched pmu when
 searching a events table
Message-ID: <ZvsIgszeRrlWEUj8@google.com>
References: <20240716132951.1748662-1-kan.liang@linux.intel.com>
 <CAP-5=fVZVU7kMOHz7CC7O1+2dX844dHqhqMebzEKWMA=59am-g@mail.gmail.com>
 <Zqo8kVXkN_UaTp6f@x1>
 <CAP-5=fX=QR66nQ6VKRMFfiFdueiC1EUGmxSbT9RCkW8dz67e6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX=QR66nQ6VKRMFfiFdueiC1EUGmxSbT9RCkW8dz67e6w@mail.gmail.com>

On Thu, Sep 26, 2024 at 02:34:43PM -0700, Ian Rogers wrote:
> On Wed, Jul 31, 2024 at 6:31 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Jul 16, 2024 at 09:30:01AM -0700, Ian Rogers wrote:
> > > On Tue, Jul 16, 2024 at 6:29 AM <kan.liang@linux.intel.com> wrote:
> > > >
> > > > From: Kan Liang <kan.liang@linux.intel.com>
> > > >
> > > > The "perf all PMU test" fails on a Coffee Lake machine.
> > > >
> > > > The failure is caused by the below change in the commit e2641db83f18
> > > > ("perf vendor events: Add/update skylake events/metrics").
> > > >
> > > > +    {
> > > > +        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
> > > > +        "Counter": "FIXED",
> > > > +        "EventCode": "0xff",
> > > > +        "EventName": "UNC_CLOCK.SOCKET",
> > > > +        "PerPkg": "1",
> > > > +        "PublicDescription": "This 48-bit fixed counter counts the UCLK cycles.",
> > > > +        "Unit": "cbox_0"
> > > >      }
> > > >
> > > > The other cbox events have the unit name "CBOX", while the fixed counter
> > > > has a unit name "cbox_0". So the events_table will maintain separate
> > > > entries for cbox and cbox_0.
> > > >
> > > > The perf_pmus__print_pmu_events() calculates the total number of events,
> > > > allocate an aliases buffer, store all the events into the buffer, sort,
> > > > and print all the aliases one by one.
> > > >
> > > > The problem is that the calculated total number of events doesn't match
> > > > the stored events in the aliases buffer.
> > > >
> > > > The perf_pmu__num_events() is used to calculate the number of events. It
> > > > invokes the pmu_events_table__num_events() to go through the entire
> > > > events_table to find all events. Because of the
> > > > pmu_uncore_alias_match(), the suffix of uncore PMU will be ignored. So
> > > > the events for cbox and cbox_0 are all counted.
> > > >
> > > > When storing events into the aliases buffer, the
> > > > perf_pmu__for_each_event() only process the events for cbox.
> > > >
> > > > Since a bigger buffer was allocated, the last entry are all 0.
> > > > When printing all the aliases, null will be outputted, and trigger the
> > > > failure.
> > > >
> > > > The mismatch was introduced from the commit e3edd6cf6399 ("perf
> > > > pmu-events: Reduce processed events by passing PMU"). The
> > > > pmu_events_table__for_each_event() stops immediately once a pmu is set.
> > > > But for uncore, especially this case, the method is wrong and mismatch
> > > > what perf does in the perf_pmu__num_events().
> > > >
> > > > With the patch,
> > > > $ perf list pmu | grep -A 1 clock.socket
> > > >    unc_clock.socket
> > > >         [This 48-bit fixed counter counts the UCLK cycles. Unit: uncore_cbox_0
> > > > $ perf test "perf all PMU test"
> > > >   107: perf all PMU test                                               : Ok
> > > >
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Closes: https://lore.kernel.org/all/202407101021.2c8baddb-oliver.sang@intel.com/
> > > > Fixes: e3edd6cf6399 ("perf pmu-events: Reduce processed events by passing PMU")
> > > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > Awesome sauce, thanks!
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks, applied to tmp.perf-tools-next,
> 
> Did this get applied? I'm not seeing it in perf-tools-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/perf/pmu-events/jevents.py?h=perf-tools-next

I'm seeing this build failure after applying this.

    TEST    pmu-events/empty-pmu-events.log
  --- pmu-events/empty-pmu-events.c	2024-09-26 10:27:15.600055460 -0700
  +++ pmu-events/test-empty-pmu-events.c	2024-09-30 13:20:34.631357001 -0700
  @@ -380,7 +380,7 @@
                           continue;
   
                   ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
  -                if (pmu || ret)
  +                if (ret)
                           return ret;
           }
           return 0;
  make[3]: *** [pmu-events/Build:42: pmu-events/empty-pmu-events.log] Error 1
  make[3]: *** Deleting file 'pmu-events/empty-pmu-events.log'
  make[2]: *** [Makefile.perf:765: pmu-events/pmu-events-in.o] Error 2
  make[2]: *** Waiting for unfinished jobs....

Thanks,
Namhyung


