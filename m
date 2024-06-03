Return-Path: <linux-kernel+bounces-199383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B28D8655
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9CA1C215E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6531311A8;
	Mon,  3 Jun 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVzTm802"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578212BF1C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429626; cv=none; b=UmAN+b7xVwg9vZEdxSRGIzHMcf77Oks1zitwUf72seJI7DhF2fpL44pc5k2kJ7xJYm5B5OOhAnlPIhWRi7goW1hKj8M4ZQjW2oBhzV2uuF0JEn8n2mt58rnxW4S0eX/6G6lW6lOzc8iIxhA8XyWr29MzM+LrwGD7cI1N5nFfdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429626; c=relaxed/simple;
	bh=Mg80o7H5UIDnH0+H3rB9+Jub8DUPORLjLI+9sQNkiek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6LP9+XON9l/sEjaZx2RFH2L0mHIc8502EZaXJh8nmM8eiDxx0MvVDZZE21OSTNve4OQMt8st6Is8QyLZ8olCMJJrF6GtTdTPktL/QseG5ikwwlaanoiiECMGYDqEFYXvo3OcYEE6AA9iXFetl0rDL0uLcdj8oDw802FsD+B35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVzTm802; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f66ad03847so206725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717429623; x=1718034423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzGMCbAEFz7sST5Tw3h9EtKJ91Jm/r9MvFW6MwnVD2I=;
        b=vVzTm802sCGYA6gcZHO68UhSPIwosbadIYFom3u4ILFP47Ltpf3jWp5WHqB/TsPe4C
         mY18wt6f3JrmV4T73zwI1HDDEUiCy86C6hj0XPiO8dX7rsNRYr4e3Q+1Ns5iCWQ2AW/W
         9jHMsJg35+AWA3r3NL37DbkSkrFfCATnUDPMS+bEjUlJvJZAvErnEoBAcdUMGe3KP4kr
         LesPMtbHyjYgNYW4yZyJJOYZkHvgWlmIPbfGL+nUMW1UusbwISexCoRy+ifCEGvF4sih
         3FGetF1H3d7V5VCug/Gm9Y9/COvYhz7n2n9USwGom1/VsdHo2Mt3E5YHf+UYKB80UhTD
         yXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717429623; x=1718034423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzGMCbAEFz7sST5Tw3h9EtKJ91Jm/r9MvFW6MwnVD2I=;
        b=qr1uDeZOa4e/3p3SyIoGWz1pntaiNJA6fvtTDh5ye8QuHcfrDyDJ6DhOOs9jzPj47l
         JqL/yccT3AcnZ0muXNAwwCKpz8i+wNsJEhne87N0jwxyrk0Asl7N3HgjRB9k7nnmt7OG
         q+yzVI8G3qvA9r7YXgP5nuyZOBM88I+YtCoGr4mTWePeMf263EXa6C9UvB++9GIOLL1N
         rnFDA0TAnWgjctKDMIErWt5v+gqYD0LrNQA6dR2FKwBdQWhFG6pvLHhCqhvljvlvlG+D
         hJ1n5F07Q2Oq6LYKWcpa+xgYjk5QjEYLifNlGMdjYtvuBmPHhVzXTmjD/JWKOTtBwh+S
         MRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4pZpalBk8r0uMbyoLt0rVBbbsCVRD/edF49gAk8/NT4TFbNceiiCWLj+pVXXIQdLbUuwd/u54mkMIuDuLkx3FGd3rocCfmWKCLVIu
X-Gm-Message-State: AOJu0YzZqLY6aNPuGTOLa81Y/bMw1q7Vnn/WJLSfNNvpAZMsbkNst1W/
	g6lv08QZlEAOSutgbO/CJs9ieUIHcXVayywS612gb8Zt+9/5xg8oAiDqMgmwmcoMe05NkI4VJnq
	FuPc9eLQhS2ihFRZ3wbS7CdzLyN9XA2UN9+0s
X-Google-Smtp-Source: AGHT+IGiaIqxFOuAXfvlbUeMJ3aKV5pmlWuVLlqoe9vC8Z08hp5YfriujSTu0Z3xC8eUVOOrEjdr4z5zKMjLC//6ixs=
X-Received: by 2002:a17:903:24a:b0:1f4:95dc:bc61 with SMTP id
 d9443c01a7336-1f64f3a6e94mr3735205ad.15.1717429622232; Mon, 03 Jun 2024
 08:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525013021.436430-2-irogers@google.com> <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com> <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020>
In-Reply-To: <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 08:46:49 -0700
Message-ID: <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:19=E2=80=AFAM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Ian,
>
> On Fri, May 31, 2024 at 09:38:01AM -0700, Ian Rogers wrote:
> > On Fri, May 31, 2024 at 1:16=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> > >
> > >
> > > hi, Ian Rogers,
> > >
> > > we actually want to seek your advice. in our env, there is no problem=
 to build
> > > parent.
> > >
> > > * 3249f8b84526d (linux-review/Ian-Rogers/perf-jevents-Autogenerate-em=
pty-pmu-events-c/20240525-093240) perf jevents: Autogenerate empty-pmu-even=
ts.c
> > > * 7d88bd0d22746 perf jevents: Use name for special find value   <--- =
parent
> > >
> > > however, failed to build perf upon 3249f8b84526d. but there is not ma=
ny useful
> > > information in below detail log.
> > >
> > > is there any dependency or env setting for us to build this commit? T=
hanks!
> >
> > Hi Oliver,
> >
> > Thanks for the report and the work testing! Seeing the output:
> >
> > [..snip..]
> > > --- pmu-events/empty-pmu-events.c       2024-05-30 08:20:10.000000000=
 +0000
> > > +++ pmu-events/test-empty-pmu-events.c  2024-05-30 15:55:37.332495538=
 +0000
> > > @@ -136,7 +136,7 @@
> > >  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > >  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache=
_miss_cycles\000\000\000\000\000\000\000\00000 */
> > >  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_reti=
red.any\000\000\000\000\000\000\000\00000 */
> > > -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_r=
etiredany\000\000\000\000\000\000\000\00000 */
> > > +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_r=
etired.any\000\000\000\000\000\000\000\00000 */
> > >
> > >  };
> > >
> > > @@ -373,7 +373,7 @@
> > [..snip..]
> >
> > It appears the version of empty-pmu-events.c the patch adds and the
> > version generated in your test configuration are differing because of
> > whitespace. Perhaps a hex editor will show what the exact difference
> > is, it must relate to locales or something. Like you mention this
> > could be resolved by an env change.
> >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20240531/202405311548.1e881de=
a-oliver.sang@intel.com
> >
> > I didn't see the generated test-empty-pmu-events.c there and so
> > couldn't follow up on the locale/env exploration. I wonder that a
> > suitable workaround is to change from the patch:
> >
> > +$(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_E=
VENTS_C)
> > +       $(call rule_mkdir)
> > +       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> >
> > to instead of invoking "diff -u" to invoke "diff -w -u", that is to
> > ignore whitespace. I can send a v3 with this.
>
> I tried below patch
>
> commit a79a41133a41adc2d69c8f603c7d880b3796cbf7
> Author: 0day robot <lkp@intel.com>
> Date:   Mon Jun 3 16:35:45 2024 +0800
>
>     fix from Ian Rogers: invoke "diff -w -u" instead of "diff -u"
>
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index c3fa43c497069..54d19b492db5c 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -39,7 +39,7 @@ $(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVE=
NTS_PY) $(METRIC_PY) $(ME
>
>  $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVE=
NTS_C)
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> +       $(Q)$(call echo-cmd,test)diff -w -u $? 2> $@ || (cat $@ && false)
>
>  $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRI=
C_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
>         $(call rule_mkdir)
>
>
> but make still failed. I still saw below in our build log
>
> --- pmu-events/empty-pmu-events.c       2024-06-03 08:41:16.000000000 +00=
00
> +++ pmu-events/test-empty-pmu-events.c  2024-06-03 13:47:19.522463482 +00=
00
> @@ -136,7 +136,7 @@
>  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
>  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\00000 */
>  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\00000 */
> -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
edany\000\000\000\000\000\000\000\00000 */
> +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\00000 */
>
>  };
>
>
> I will try to get generated test-empty-pmu-events.c tomorrow.

Thanks Oliver, if you could get the environment variables that would
probably also be useful.

Ian

> >
> > Thanks,
> > Ian

