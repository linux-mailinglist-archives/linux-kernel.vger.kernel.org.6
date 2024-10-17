Return-Path: <linux-kernel+bounces-370493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE89A2D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ED2284EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9D422737C;
	Thu, 17 Oct 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7PH0Gz4"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491E17D366
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192546; cv=none; b=WHDMF9xdNNBHSEF46Nf/3fMUMqAmuie0yTrD5TmqrRs5YHNPBq0Ww5hcil3Tvw+ps44kyXulDLruYO4zXZrBwsLQTP2UHa80dmkMnucz6pH4c4LA5TjFzh5BfhvhzR0FeyoqpL7FC2uE2kY9wVGAqZu25wqvUD0vaJ7QxdgjLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192546; c=relaxed/simple;
	bh=WEXAOJtdCE1SNlS/4JT7r7DpDNqxUK5tAb0Muj5O4q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MH0Ns07PSypd8UpISqJwCwUW/VFJvigDND4zOp8OQwZ3KUbSDRwoWAwnLAqTHIaNXUiTCJnQfA3dFm0b3rk2o2PlezvizD9gFNrZ8uf2K76JOq2O9STHa3lOf1VWDy7uHCI7zmeZbMUbBp3hl/07IXGV5Jrk4ASf2rd8DpW+Q4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7PH0Gz4; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so275ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729192541; x=1729797341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MgZetyT7kWa+/yuK0Fr7buErddvwijeezfKA2oUEsk=;
        b=x7PH0Gz41fbExPAdPWqsAXL20JDmNR7uPbkiJgOaWX6VcMwoBKK/5vmpTQuxQoKNwj
         bCrR06kCvrh3uCG2C8Xcb9Lx2k9/K8tFXbyOwHyaF8fLgxou+4vg9NLCQpY905DlPmJP
         xDVG52lCxsLzJoKEEWl/N3WRQbesPzDG0e6G9xAIiuNbsg67sxNlHQqrgrHzVswja3xg
         52IIZpy/9Xt5YbigaJLWEkiO/idou+P6R5GprH9jenE9FtgQyT9vliZQXLfdJCIycjUm
         X7kEpZWHTARlvY6M0mT0pszDTiMrByP1RvGWR6TEtvQOxjB0zsZd0c1Gc/Rtnvo52d9A
         4FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192541; x=1729797341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MgZetyT7kWa+/yuK0Fr7buErddvwijeezfKA2oUEsk=;
        b=cRxEvemgj2/GtTA5LFhFgKd6Lo2LUwmtTNeHZulPfR8oHFTahipxdHo3QTpMzmY0Ac
         R7W9fypPqwL70r/rlIF2vsWSfMOHpLl9mxqbmgkztXbIN4JO+yvAaVk8PxkbSbNiI8li
         m08evA9MFLzW7hufTrYQskvm/R5QUPqSlAZEkEZRx5f9kvnxCWJIIMIGvqVUf0q1mXBg
         EldM1/+FHcp2KyyW7iYyhwVSWIbhVeAQzIeftD2iXExnNrPo+gQT1Fi+sX+UAmqe5YxL
         zkHR4JZj+6VG71+Z3gdF1Hx+ITCTS1n2ykxDYsRXuwYJG8HHFyUEi9dDndLlR4lpt1wZ
         AmXw==
X-Forwarded-Encrypted: i=1; AJvYcCUDMNjiE8t83qnwTai66pune+GmZ7O2K+Jb5zUp3bykgzWIu/LC7HyTvAjAXKFSo4u6uzzXBTuBmGRNP2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuX41YPSU88KKUyE+jzV0F7TISIQ7dVMGISENw6zsX7FmKCu6d
	8qf/u+/GplTHL5hosdjc4u11FP9Fftq8AvfaHtCCtvRmacD0JGO/wIgn/+Pny2s+hHme316434F
	Kt0Ex8/bLddRnLEu8NWuxAZa9i4OvO1HRj1VR
X-Google-Smtp-Source: AGHT+IE9XADz7SYrkz/q6qJJWYfl2s+CVkOMZmpSx+y3jeduyIakJqEHs9UZoAMhmSQK84cbs9wbRfXeEkLmNV5i69g=
X-Received: by 2002:a05:6e02:1d0f:b0:3a0:be64:a351 with SMTP id
 e9e14a558f8ab-3a3f340b605mr597285ab.10.1729192540574; Thu, 17 Oct 2024
 12:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com> <ZxFVYvDTtmz_JbMU@google.com>
In-Reply-To: <ZxFVYvDTtmz_JbMU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Oct 2024 12:15:26 -0700
Message-ID: <CAP-5=fVicsN1_k5nycOzHnRxdmwdEk9Y==OSAaxdDL5wnX7_jg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] CSV/JSON metric thresholds, fix printf modifiers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:20=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Thu, Oct 17, 2024 at 10:53:49AM -0700, Ian Rogers wrote:
> > Metric thresholds are being computed for CSV and JSON output but not
> > displayed. Rename the color that encodes the threshold as enum values
> > and use to generate string constants for a json dictionary
> > value. Disable metric thresholds with CSV output.
> >
> > Add printf attribute to functions in color.h that could support
> > it. Fix bad printf format strings that this detected.
>
> Thanks for the quick fix, I'll take this.
>
> >
> > v5. Switch some u64 printf flags to PRIx64 rather than llx (kernel
> >     convention) to resolve 32-bit build issues.
> > v4. Drop CSV metric thresholds due to formatting variation on
> >     hypervisors (broken counters) and not as detected by
> >     tests/shell/stat+csv_output.sh.
>
> I'm ok with dropping CSV support for now, but could you explain
> a bit more detail about the problem?  Is it possible to see the
> same problem on host if it has a unsupported event?

It would be. The issue is the stat-display code being a rat's nest and
adding a column to CSV should be straightforward but causes --thread
to behave in odd ways with an uncounted/unsupported event. Where the
column counts differ from supported to not supported causing the CSV
stat output check to fail. Fixing one issue leads to other issues and
my usual desire to rewrite stat-display which can wait for another
occasion. Here I'm trying to address that we may compute the metric
threshold, use extra events, but then never even show the output.

Thanks,
Ian

>
> > v3. Rebase.
> > v2. Don't display metric-value for json output if there is no unit.
> >
> > Ian Rogers (7):
> >   perf color: Add printf format checking and resolve issues
> >   perf stat: Fix/add parameter names for print_metric
> >   perf stat: Display "none" for NaN with metric only json
> >   perf stat: Drop metric-unit if unit is NULL
> >   perf stat: Change color to threshold in print_metric
> >   perf stat: Add metric-threshold to json output
> >   perf stat: Disable metric thresholds for CSV and JSON metric-only mod=
e
> >
> >  tools/perf/arch/x86/util/iostat.c             |   2 +-
> >  tools/perf/builtin-sched.c                    |   2 +-
> >  tools/perf/builtin-script.c                   |   6 +-
> >  tools/perf/builtin-stat.c                     |   8 ++
> >  tools/perf/builtin-trace.c                    |   2 +-
> >  .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
> >  tools/perf/util/arm-spe.c                     |   2 +-
> >  tools/perf/util/color.h                       |   9 +-
> >  tools/perf/util/intel-bts.c                   |   2 +-
> >  tools/perf/util/intel-pt.c                    |   2 +-
> >  tools/perf/util/s390-cpumsf.c                 |   2 +-
> >  tools/perf/util/s390-sample-raw.c             |   8 +-
> >  tools/perf/util/stat-display.c                |  73 +++++++---
> >  tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
> >  tools/perf/util/stat.h                        |  16 ++-
> >  15 files changed, 170 insertions(+), 97 deletions(-)
> >
> > --
> > 2.47.0.105.g07ac214952-goog
> >

