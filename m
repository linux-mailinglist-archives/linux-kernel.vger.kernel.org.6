Return-Path: <linux-kernel+bounces-344806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6098AE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B22E2842C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9117332B;
	Mon, 30 Sep 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6SJ3H0M"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3D2C190
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728219; cv=none; b=Hl8TmjU+I0bnEyP5WmtflCpmr6pzH3dplhhQFp055cLPzpCg9P6IBK6Kjd4v6lw6SPKKrKJYlMofnMzk9AbSkpM+rL6gxF2cclBHfOSlXZXHm258XBywVcHIBHWlVE4OzJk+K6/PjYPhCqLU8xF7APSHDIaFsEGd/g8ka9w+Bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728219; c=relaxed/simple;
	bh=rNDRqDikPc2IYySo1aCtAs9nQMqyaVM3HwLOgXMgSE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guN3Cdp/Y6Q6R+Vey3NDuVJiP5+C0OUb/E9AEBVQ5OuLFiz4PyTZJCPYuBUetQLmaTo/+djwYSp+/omeYQ7qDiWWtBkIisy31zpvUEOEz21FkW7DMokGTu5r2xZXFaNv47AETKiaOvdp21KPIhz/u+vParEQxdODHkVOrt6/PAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6SJ3H0M; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so10375ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727728217; x=1728333017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Fl7cAiTg2sI9tTd80towTVUeDdjxO+KskbqaweDfSI=;
        b=z6SJ3H0MS2mKOimXI/tACnDYUWE/bgoyseffYwAECQBRAHIZreIHqoIKPYBRs+YXWO
         c+lFEGn7YbLXvySg1QyVE9pHiayHf892PPVx3GSlyI6RsYFD/SO+GuOJgovYpW09gNCo
         Qma/rRmYW02OxDa2BPxSlXnPujvMj4cNRybXtnQZuooR+4HGJAaf5TX7O+jD0UbbqgcC
         R6X1Dj90Un45l4zIqMTuYpi2ZDQqSLCASfRvY9jimITm4qJNxyOLqkZ/0pGYA4l7ZYEq
         uxT68wfjKUsX7t1yOCLnBJBdYEHAEUNdLjbTUyE1GPg52CfIBGqpPTD4tDccJ+mMsbjx
         qayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728217; x=1728333017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Fl7cAiTg2sI9tTd80towTVUeDdjxO+KskbqaweDfSI=;
        b=tzN2TvYD+lG2qIxAEJdRfrFWum+BKHbHUXr0jfMaggQ/ZhFKc99Wh1cN8X3NbUMMvq
         n/07ZYtJMqiiTQQwBWVqfwxLkmA4S21wIfq9Zx+gPI53SGH7taEnbZJ1MblQQnw5gqUg
         64wDTGB/m3q7MvbRJOVRX/Vh8pA8okYnnRCuBmLwmn2KAQfPN3MsGOmIeA8nNiEYMYaP
         mOZZvTQrx8rP4coJXODrZEBya4++n7zjvKARSFXdvjlnBLu4R4HM5bCADffoHbaG/vbx
         KOTImr/RyzUxaCwAr0Vpe/R3p4EeGvNDmQcGejrfjLRewf/tkWoCh09S7OjpFgWgKfgW
         eGHg==
X-Forwarded-Encrypted: i=1; AJvYcCVxWNZxgSn70qzLLzzQrp5vVwBU/E9gtMhiO2PtKiUUuKV06G34G6AqaUHYL+iwvDPS3PypTpRPD0gJHgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXf/slZlDsf7vv6f9ojKw7O9HQPJ5RYpbBJdk+eQbFzE+9axaj
	rdAn1qRPx9+QrB2me/VGTsVHaiRre+u7dMVvtsItGS3kb7aIGTXTrRMe6oj8+cxUDyLoZEeTidG
	DlJsJUoIgkNAbyvLtY56iJT+nxwfXWRbUy9Hn
X-Google-Smtp-Source: AGHT+IHaJSqFfzSzCScLgy51hTf7tadavCsJ4ZEqlHZIyNexaelz4UidlxPsZZl1djkj9V5fxTO/4FOvU1K9kc2xe2s=
X-Received: by 2002:a92:c26f:0:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-3a36083bae1mr54265ab.23.1727728216768; Mon, 30 Sep 2024
 13:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716132951.1748662-1-kan.liang@linux.intel.com>
 <CAP-5=fVZVU7kMOHz7CC7O1+2dX844dHqhqMebzEKWMA=59am-g@mail.gmail.com>
 <Zqo8kVXkN_UaTp6f@x1> <CAP-5=fX=QR66nQ6VKRMFfiFdueiC1EUGmxSbT9RCkW8dz67e6w@mail.gmail.com>
 <ZvsIgszeRrlWEUj8@google.com>
In-Reply-To: <ZvsIgszeRrlWEUj8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Sep 2024 13:30:03 -0700
Message-ID: <CAP-5=fXk8QJjP7iDsSrS5GZz-uHYheeLg2DHCWHjD5z+jZk+9A@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Don't stop at the first matched pmu when
 searching a events table
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, kan.liang@linux.intel.com, adrian.hunter@intel.com, 
	peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Sep 26, 2024 at 02:34:43PM -0700, Ian Rogers wrote:
> > On Wed, Jul 31, 2024 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 09:30:01AM -0700, Ian Rogers wrote:
> > > > On Tue, Jul 16, 2024 at 6:29=E2=80=AFAM <kan.liang@linux.intel.com>=
 wrote:
> > > > >
> > > > > From: Kan Liang <kan.liang@linux.intel.com>
> > > > >
> > > > > The "perf all PMU test" fails on a Coffee Lake machine.
> > > > >
> > > > > The failure is caused by the below change in the commit e2641db83=
f18
> > > > > ("perf vendor events: Add/update skylake events/metrics").
> > > > >
> > > > > +    {
> > > > > +        "BriefDescription": "This 48-bit fixed counter counts th=
e UCLK cycles",
> > > > > +        "Counter": "FIXED",
> > > > > +        "EventCode": "0xff",
> > > > > +        "EventName": "UNC_CLOCK.SOCKET",
> > > > > +        "PerPkg": "1",
> > > > > +        "PublicDescription": "This 48-bit fixed counter counts t=
he UCLK cycles.",
> > > > > +        "Unit": "cbox_0"
> > > > >      }
> > > > >
> > > > > The other cbox events have the unit name "CBOX", while the fixed =
counter
> > > > > has a unit name "cbox_0". So the events_table will maintain separ=
ate
> > > > > entries for cbox and cbox_0.
> > > > >
> > > > > The perf_pmus__print_pmu_events() calculates the total number of =
events,
> > > > > allocate an aliases buffer, store all the events into the buffer,=
 sort,
> > > > > and print all the aliases one by one.
> > > > >
> > > > > The problem is that the calculated total number of events doesn't=
 match
> > > > > the stored events in the aliases buffer.
> > > > >
> > > > > The perf_pmu__num_events() is used to calculate the number of eve=
nts. It
> > > > > invokes the pmu_events_table__num_events() to go through the enti=
re
> > > > > events_table to find all events. Because of the
> > > > > pmu_uncore_alias_match(), the suffix of uncore PMU will be ignore=
d. So
> > > > > the events for cbox and cbox_0 are all counted.
> > > > >
> > > > > When storing events into the aliases buffer, the
> > > > > perf_pmu__for_each_event() only process the events for cbox.
> > > > >
> > > > > Since a bigger buffer was allocated, the last entry are all 0.
> > > > > When printing all the aliases, null will be outputted, and trigge=
r the
> > > > > failure.
> > > > >
> > > > > The mismatch was introduced from the commit e3edd6cf6399 ("perf
> > > > > pmu-events: Reduce processed events by passing PMU"). The
> > > > > pmu_events_table__for_each_event() stops immediately once a pmu i=
s set.
> > > > > But for uncore, especially this case, the method is wrong and mis=
match
> > > > > what perf does in the perf_pmu__num_events().
> > > > >
> > > > > With the patch,
> > > > > $ perf list pmu | grep -A 1 clock.socket
> > > > >    unc_clock.socket
> > > > >         [This 48-bit fixed counter counts the UCLK cycles. Unit: =
uncore_cbox_0
> > > > > $ perf test "perf all PMU test"
> > > > >   107: perf all PMU test                                         =
      : Ok
> > > > >
> > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > Closes: https://lore.kernel.org/all/202407101021.2c8baddb-oliver.=
sang@intel.com/
> > > > > Fixes: e3edd6cf6399 ("perf pmu-events: Reduce processed events by=
 passing PMU")
> > > > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > >
> > > > Awesome sauce, thanks!
> > > >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks, applied to tmp.perf-tools-next,
> >
> > Did this get applied? I'm not seeing it in perf-tools-next:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next
>
> I'm seeing this build failure after applying this.
>
>     TEST    pmu-events/empty-pmu-events.log
>   --- pmu-events/empty-pmu-events.c     2024-09-26 10:27:15.600055460 -07=
00
>   +++ pmu-events/test-empty-pmu-events.c        2024-09-30 13:20:34.63135=
7001 -0700
>   @@ -380,7 +380,7 @@
>                            continue;
>
>                    ret =3D pmu_events_table__for_each_event_pmu(table, ta=
ble_pmu, fn, data);
>   -                if (pmu || ret)
>   +                if (ret)
>                            return ret;
>            }
>            return 0;
>   make[3]: *** [pmu-events/Build:42: pmu-events/empty-pmu-events.log] Err=
or 1
>   make[3]: *** Deleting file 'pmu-events/empty-pmu-events.log'
>   make[2]: *** [Makefile.perf:765: pmu-events/pmu-events-in.o] Error 2
>   make[2]: *** Waiting for unfinished jobs....

Need to copy pmu-events/test-empty-pmu-events.c to
pmu-events/empty-pmu-events.c, do you need the patch resent with this
done?

Thanks,
Ian

