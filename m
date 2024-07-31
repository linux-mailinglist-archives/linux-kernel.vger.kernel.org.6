Return-Path: <linux-kernel+bounces-269692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF4F9435DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0231F2302F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576EE4EB5E;
	Wed, 31 Jul 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St/1xIZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3454084E;
	Wed, 31 Jul 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451988; cv=none; b=rS+LXw9p4OCDV35QMYw39cJBlV37qRe1rTyguhxFk+xLr9KGDGesA+TmT3tF2ZoqFxzDKE4TY2blhVFhbSM6T54x08gf1T/eC/pClbDoT2stracTC25H1X0ewxxr50OlhCauKjeM7onjIyOCExgqfmSpD1Wwc6sqaduXRfJPGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451988; c=relaxed/simple;
	bh=/JSVcS6VVmFsrriJSGRG8BZoUd070lPD2Oa5aSzbwdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxKEg2U17rQn+YXaW/0ppuifkTQwzfU2KZ4F8wWuaY27O1VqxBvHY7Q9kTVmfGk+udZ+grAttPkGNS4wCNV2aHKY0EPCtuPz84lLIauBfn/36J9L5IIrWfn+cO6y7S9Ne49bRt9J4pidLKddJSv4HFya6d4SALBt+tOFmxi43dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St/1xIZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDADC116B1;
	Wed, 31 Jul 2024 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722451988;
	bh=/JSVcS6VVmFsrriJSGRG8BZoUd070lPD2Oa5aSzbwdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=St/1xIZQ++s81ewttk/TPXmmrPUKW2vWF7XgjLyq1QK6oY0OAZ59J03V0Zwt3wbIW
	 LFQrV0rPhKDT+yNGoh/xtBTr4dldE8CKaY1PS8vv1t0OodboAA9PU4JNSBaiHLz33l
	 sv7zaXc4z/AeiubhVdbaTlw+Eq361scHp4LcnFUc0i4I6em4EdTrGdTQxWmxtid+r5
	 SEWtuI2LhA5jK8d/7PTivvGzpqz42kcteFOmlasy0SBB2esnIcW4N6wlK6jzBoyAVQ
	 7tPmt4Z4c0dZkgiV5vUC6H7VrKni+eAjhXXv7S0zBmPrkgyuGO4oH4U4cxDqq9lB1q
	 3SxOHloQGNSDA==
Date: Wed, 31 Jul 2024 15:53:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	philip.li@intel.com, oliver.sang@intel.com,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
Message-ID: <ZqqIEckIXQEAd9xr@x1>
References: <20240730191744.3097329-1-irogers@google.com>
 <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1>
 <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
 <ZqpZWywTe2j3U9Pl@x1>
 <ZqpcRIzzBb5KC6Zb@x1>
 <CAP-5=fVm5FkLDOLk4cbD9K6VPZ088f3Yk3bG8LT79E_OLLN4Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVm5FkLDOLk4cbD9K6VPZ088f3Yk3bG8LT79E_OLLN4Lw@mail.gmail.com>

On Wed, Jul 31, 2024 at 08:58:43AM -0700, Ian Rogers wrote:
> On Wed, Jul 31, 2024 at 8:46 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Jul 31, 2024 at 12:33:50PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Jul 31, 2024 at 07:08:18AM -0700, Ian Rogers wrote:
> > > > On Wed, Jul 31, 2024 at 6:18 AM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > > > > > empty-pmu-events.c exists so that builds may occur without python
> > > > > > being installed on a system. Manually updating empty-pmu-events.c to
> > > > > > be in sync with jevents.py is a pain, let's use jevents.py to generate
> > > > > > empty-pmu-events.c.
> > > > >
> > > > > What am I missing here?
> > > > >
> > > > > If it exists so that we can build on a system without python how can we
> > > > > use python to generate it?
> > > > >
> > > > > Now having python in the system is a requirement and thus we don't need
> > > > > empty-pmu-events.c anymore?
> > > > >
> > > > > Can you guys please clarify that?
> > > >
> > > > The requirement for python hasn't changed.
> > > >
> > > > Case 1: no python or NO_JEVENTS=1
> > > > Build happens using empty-pmu-events.c that is checked in, no python
> > > > is required.
> > > >
> > > > Case 2: python
> > > > pmu-events.c is created by jevents.py (requiring python) and then built.
> > > > This change adds a step where the empty-pmu-events.c is created using
> > > > jevents.py and that file is diffed against the checked in version.
> > > > This stops the checked in empty-pmu-events.c diverging if changes are
> > > > made to jevents.py. If the diff causes the build to fail then you just
> > > > copy the diff empty-pmu-events.c over the checked in one.
> > >
> > > I'll try and add your explanation to the log message, thanks for
> > > clarifying it!
> >
> > So, with it in place I'm now noticing:
> >
> > ⬢[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> > ⬢[acme@toolbox perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make -k CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test python'
> > ⬢[acme@toolbox perf-tools-next]$ m
> > <SNIP>
> >   GEN     /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
> >   MKDIR   /tmp/build/perf-tools-next/arch/x86/util/
> >   CC      /tmp/build/perf-tools-next/util/annotate.o
> >   CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
> >   CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
> >   CC      /tmp/build/perf-tools-next/util/block-info.o
> >   CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test.o
> >   CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
> >   MKDIR   /tmp/build/perf-tools-next/ui/browsers/
> >   CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
> >   CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
> >   CC      /tmp/build/perf-tools-next/util/block-range.o
> >   TEST    /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.log
> > --- pmu-events/empty-pmu-events.c       2024-07-31 12:44:14.355042296 -0300
> > +++ /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c       2024-07-31 12:45:35.048682785 -0300
> > @@ -380,7 +380,7 @@
> >                          continue;
> >
> >                  ret = pmu_events_table__for_each_event_pmu(table, table_pmu, fn, data);
> > -                if (pmu || ret)
> > +                if (ret)
> 
> Right, you need to copy:
>  /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
> to
> tools/perf/pmu-events/empty-pmu-events.c
> to fix this.
> 
> This change has happened as you are testing with:
> https://lore.kernel.org/lkml/20240716132951.1748662-1-kan.liang@linux.intel.com/
> which isn't in the git repo yet (therefore, I can't make a patch set
> on it). The change is WAI as it is telling you empty-pmu-events.c has
> become stale and needs Kan's fix applying to it.

ok, I'll remove Kan's patch, publish perf-tools-next and wait for the
now normal flow of patches.

- Arnaldo

