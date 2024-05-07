Return-Path: <linux-kernel+bounces-172168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA68BEE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571EA1C228A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B53E476;
	Tue,  7 May 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MfeUpE8Z"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C7187340
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114923; cv=none; b=K8Iy+jM9+JGWi7v8BWv0cGJAdjIjtexvbcxqwgVyxUfdL8P+LxQiNk7s8LJDvsg4C1xfBd1nd57wI1wIRahYuQCHbZB3WI3UyTaFibsSMp2gbcFqKh6xdUZkxFLvoZfDsq6liufQQYvHN/LhyTVX5Noag4EGFripaHe+zdP5j1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114923; c=relaxed/simple;
	bh=iUUdr7fhCVOI+1ibDZ5tRP+GhfUTN43KYFgHaolG4gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWdDYZvekUA2eZ4XyX58Yanq0Yu1GZz+AR2vbiuCOYuwc15JOOa5yFHCbVW1OQLKErkgot926PnnlUJtaZGp3O+dWeLzk3CEVMZqDybi4SQBvqwjJNjJdqng6T083pcAI5g2HwB9CeC9Wx2grWIIj9/R1+kic9W7oIPb7ubaATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfeUpE8Z; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43d361a2124so104331cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715114920; x=1715719720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDIYEkb0FYawx5ZH+GJAkoheI/wUxCabyNLHuNba9lE=;
        b=MfeUpE8ZMRM3sQQS1rA5ezmVfM4zc3hyt9tnfGi9XZ7yls2px2zz/YVds0GYKHOt5Z
         i31W7RdfdFVs+OBqIZ3nP64dNb12VW8kc4AKHZxy8xotXNsjLtU/1LK0sk67kzPdgGpg
         CNZWIILp1nKG52nUPPV/lYidTpEvkSwP53bTFfpJ+I/WD/Ul81QIIXZP0ijDukEIpEF2
         nplIVSQECKr9otACQROb29/8ZFhfBGAVZgpdu8zSJ+/OKvlwWJt7oFVO/17NScPvqN8/
         LZcRxnhWF3EwMcDwbHJDgIK10Pxykd4YdYBMK7uix8y8lbIvb7poqluGdD6oSARbgs36
         yh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715114920; x=1715719720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDIYEkb0FYawx5ZH+GJAkoheI/wUxCabyNLHuNba9lE=;
        b=HAYAMcWeikiQIFNWtSZPmqnkzsFr5nBmoIpictesChkYtrgl8QoW8QxlsmEX7sLtZr
         xNeJGaTFty5vVI/sCKzh37Qq4zXuzDacjPQeE4VqD4DfOIPu7yOW+ajKpRSbIc76ODOq
         jLf2Pvx8ikEpumy+8xbdVW4IgmZdlIm7WHP5CpXIwmSH03U8qvHLN2TKx4mk2ReT44Lu
         2ymWSza4pqHEE84r7JCmiPxtQgoAhgZ7mjxpOOAJjjU7r0FPlizvCroE8LFl2Vn56htQ
         ncdNMZSklLxRD0aUqUel6d+q1N8GAOOC6UlSvPZOOdXV9ewNak4yrf8tCuEaNZrwkkv1
         DJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHNDHzThzE+SdeNU65uauPYRgH9nBci/9knXLG8ZJvSn76HdIU5z2CGYwmqNj37sbT4L9gBTYoKlePD9ATVbAnL8xTt+lf/mKUm6v/
X-Gm-Message-State: AOJu0YzUSp+ahblSR0DWIWPIYfaKpoD9UjYDkdCGKMKLjCon1MywszFg
	KLgHzuQL8kO7QqxuoKHpSYEm2sGA5kdpbQ7VGCIxmcFzKc6g4L0IQQxNi/mcJZx07+2toaO50oL
	oTA5hGFCUxIU9D23bTB/k/Uvuz+/F5DN2TBPs
X-Google-Smtp-Source: AGHT+IHYVTVw519J5HjMjJscr+9j6QPQ+Q4IKK+EOhtcR81a3b8spdMzPQ/rt9h508aXsNa+gNr8ObkegSWiC/mcRws=
X-Received: by 2002:a05:622a:181d:b0:439:a979:ccb2 with SMTP id
 d75a77b69052e-43dc2ef4340mr598981cf.16.1715114920158; Tue, 07 May 2024
 13:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com> <20240507183545.1236093-2-irogers@google.com>
 <ZjqNKPgWR7mBFaV4@x1> <ZjqNjrJ2ElrT11iB@x1>
In-Reply-To: <ZjqNjrJ2ElrT11iB@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 May 2024 13:48:28 -0700
Message-ID: <CAP-5=fUsQwKsCi3us+dp-Tj+PayNPrYTqTQeo-YLbvSuOt1=9w@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack memory
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, James Clark <james.clark@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 1:22=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, May 07, 2024 at 05:20:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
> > > ui_browser__show is capturing the input title that is stack allocated
> > > memory in hist_browser__run. Avoid a use after return by strdup-ing
> > > the string.
> >
> > But everything happens in that context, i.e. hist_brower__run() will
> > call ui_browser__ methods and then exit.
> >
> > We end up having browser->title pointing to returned stack memory
> > (invalid) but there will be no references to it, no?
> >
> > If we return to hist_browser__run() we then call ui_browser__show
> > passing a new title, for "live" stack memory, rinse repeat. Or have you
> > noticed an actual use-after-"free"?
>
> And I'll take the patch, I'm just trying to figure it out if it fixed a
> real bug or if it just makes the code more future proof, i.e. to avoid
> us adding code that actually uses invalid stack memory.

My command line using tui is:
$ sudo bash -c 'rm /tmp/asan.log*; export
ASAN_OPTIONS=3D"log_path=3D/tmp/asan.log"; /tmp/perf/perf mem record -a
sleep 1; /tmp/perf/perf mem report'
I then go to the perf annotate view and quit. This triggers the asan
error (from the log file):
```
=3D=3D1254591=3D=3DERROR: AddressSanitizer: stack-use-after-return on addre=
ss
0x7f2813331920 at pc 0x7f28180
65991 bp 0x7fff0a21c750 sp 0x7fff0a21bf10
READ of size 80 at 0x7f2813331920 thread T0
    #0 0x7f2818065990 in __interceptor_strlen
./../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
inc:461
    #1 0x7f2817698251 in SLsmg_write_wrapped_string
(/lib/x86_64-linux-gnu/libslang.so.2+0x98251)
    #2 0x7f28176984b9 in SLsmg_write_nstring
(/lib/x86_64-linux-gnu/libslang.so.2+0x984b9)
    #3 0x55c94045b365 in ui_browser__write_nstring ui/browser.c:60
    #4 0x55c94045c558 in __ui_browser__show_title ui/browser.c:266
    #5 0x55c94045c776 in ui_browser__show ui/browser.c:288
    #6 0x55c94045c06d in ui_browser__handle_resize ui/browser.c:206
    #7 0x55c94047979b in do_annotate ui/browsers/hists.c:2458
    #8 0x55c94047fb17 in evsel__hists_browse ui/browsers/hists.c:3412
    #9 0x55c940480a0c in perf_evsel_menu__run ui/browsers/hists.c:3527
    #10 0x55c940481108 in __evlist__tui_browse_hists ui/browsers/hists.c:36=
13
    #11 0x55c9404813f7 in evlist__tui_browse_hists ui/browsers/hists.c:3661
    #12 0x55c93ffa253f in report__browse_hists tools/perf/builtin-report.c:=
671
    #13 0x55c93ffa58ca in __cmd_report tools/perf/builtin-report.c:1141
    #14 0x55c93ffaf159 in cmd_report tools/perf/builtin-report.c:1805
    #15 0x55c94000c05c in report_events tools/perf/builtin-mem.c:374
    #16 0x55c94000d96d in cmd_mem tools/perf/builtin-mem.c:516
    #17 0x55c9400e44ee in run_builtin tools/perf/perf.c:350
    #18 0x55c9400e4a5a in handle_internal_command tools/perf/perf.c:403
    #19 0x55c9400e4e22 in run_argv tools/perf/perf.c:447
    #20 0x55c9400e53ad in main tools/perf/perf.c:561
    #21 0x7f28170456c9 in __libc_start_call_main
./sysdeps/nptl/libc_start_call_main.h:58
    #22 0x7f2817045784 in __libc_start_main_impl ../csu/libc-start.c:360
    #23 0x55c93ff544c0 in _start (/tmp/perf/perf+0x19a4c0) (BuildId:
84899b0e8c7d3a3eaa67b2eb35e3d8b2f8cd4c93)

Address 0x7f2813331920 is located in stack of thread T0 at offset 32 in fra=
me
    #0 0x55c94046e85e in hist_browser__run ui/browsers/hists.c:746

  This frame has 1 object(s):
    [32, 192) 'title' (line 747) <=3D=3D Memory access at offset 32 is
inside this variable
HINT: this may be a false positive if your program uses some custom
stack unwind mechanism, swapcontext or vfork
```
hist_browser__run isn't on the stack so the asan error looks legit.
There's no clean init/exit on struct ui_browser so I may be trading a
use-after-return for a memory leak, but that seems look a good trade
anyway.

Thanks,
Ian

> - Arnaldo
>
> > - Arnaldo
> >
> > > Fixes: 05e8b0804ec4 ("perf ui browser: Stop using 'self'")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/ui/browser.c | 4 +++-
> > >  tools/perf/ui/browser.h | 2 +-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> > > index 603d11283cbd..c4cdf2ea69b7 100644
> > > --- a/tools/perf/ui/browser.c
> > > +++ b/tools/perf/ui/browser.c
> > > @@ -287,7 +287,8 @@ int ui_browser__show(struct ui_browser *browser, =
const char *title,
> > >     mutex_lock(&ui__lock);
> > >     __ui_browser__show_title(browser, title);
> > >
> > > -   browser->title =3D title;
> > > +   free(browser->title);
> > > +   browser->title =3D strdup(title);
> > >     zfree(&browser->helpline);
> > >
> > >     va_start(ap, helpline);
> > > @@ -304,6 +305,7 @@ void ui_browser__hide(struct ui_browser *browser)
> > >     mutex_lock(&ui__lock);
> > >     ui_helpline__pop();
> > >     zfree(&browser->helpline);
> > > +   zfree(&browser->title);
> > >     mutex_unlock(&ui__lock);
> > >  }
> > >
> > > diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
> > > index 510ce4554050..6e98d5f8f71c 100644
> > > --- a/tools/perf/ui/browser.h
> > > +++ b/tools/perf/ui/browser.h
> > > @@ -21,7 +21,7 @@ struct ui_browser {
> > >     u8            extra_title_lines;
> > >     int           current_color;
> > >     void          *priv;
> > > -   const char    *title;
> > > +   char          *title;
> > >     char          *helpline;
> > >     const char    *no_samples_msg;
> > >     void          (*refresh_dimensions)(struct ui_browser *browser);
> > > --
> > > 2.45.0.rc1.225.g2a3ae87e7f-goog

