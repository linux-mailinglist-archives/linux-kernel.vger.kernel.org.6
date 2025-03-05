Return-Path: <linux-kernel+bounces-546982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66131A50171
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5643016CCBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BEA24BC1C;
	Wed,  5 Mar 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/cxe7Ab"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168224BC07
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183628; cv=none; b=sOBlv9j7n7EPooa+wNIk0xO0MAYxSXaEVqDFb3S+InWZ3IDd7EksYv//IHM19HPqrqUTNdL94wTHLzWqjBGEkBl/ef+7BLqtb1R3wKcSEYHYj0u/1HEXuyknF9u50s+5C2UtM3urakRPtckdtD4G//fL7qo4V639dfTDuSWYx/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183628; c=relaxed/simple;
	bh=FjaeIhTNdKMmPpFK6XfmpXumPWRdtaSKMyBsnUumCQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9cXFS3kycZ3uMxMRBb3BKMigCh/aTGL7XdDi2/pxzT9ZcgrLAVgpCs4buDGhVXY8s0L3Ookqcp77BlgiOOQ+PwU5iSKlfZeC//QbMs+d64dEzm2V11Tw5g4nrgUlDCrtz9xjXUgDvKQ8/WC7j4Clu9Ok2Hs6q+wmEn9MWtBqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/cxe7Ab; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22342c56242so166685ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741183626; x=1741788426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/6W12xTgoKBwdDU6FZ6FI7BGZR4+Y6EvyzLeszV9vQ=;
        b=M/cxe7Abfvuxa5WmLdQBJfnTvOeORUUVcZ2C4sd2C2yOaGXcKY0SDUtidBk+cS9Csv
         9wgCusQSM50SNSR8VMrj4MSA4zSNezuA0LHtCmckXfiSG8BLAIkpdyInMnMPxlf/RJf4
         Q2anBZqEtmMHmZSHWPM9oK9hakmKy9EcMut/GBNihlOswyckO0EsV8KqwY/VPN1SOLp6
         SfhKNvxZ5zFVQBox5DPa0ht6JT5LOCIV5pKpzvSiw4Gycp3priOiw41W2HMcSW50+6fl
         ChO0Vb0DICWT29FMdFUi2ppDNsLcp+84ehWgPufGFqIJWDNgc8uCeBh4/F7D0gcOjh7p
         9o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741183626; x=1741788426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/6W12xTgoKBwdDU6FZ6FI7BGZR4+Y6EvyzLeszV9vQ=;
        b=S34qXEjttk1udwzrq/TExDHc1XCJSlLfunC2YxGGemdeRv4JMGL1R1PGLF06Rce1dE
         fb0D+PJExWg0QgWcijgDLbi0q8hyUYx5E2ZcbFSLgayx681aGKQRCsjGsifbwpTRw0LP
         NvfhcSqLilpaWtZkF4pv1yN6ucVMkTvWsBHR3o4eSvJ57QLMdnYMicfnte9n1pHEeF0r
         A/bqfZXNNeg+EBFYCXLa9i02nomcZaYMbKaNkTqWPd50RwDviVPB48ids6AXcHxUL9i6
         ImlZg0M1r3gVFBCsgM67mj1rryhAjNTWoRlbyYR+5aWDmSV9QGGO/uXkICHwOjuRAZM4
         XNWw==
X-Forwarded-Encrypted: i=1; AJvYcCVoqQDeJWLjqyHVl1l38OWFPoZAl06YYX9dMF9/7tycNenu7pQlYkqrIysYq14J6MUlqwaG7ojnU68w9EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWljeQ3Kl+rn62+3X+Jx1sFf2jEyNMEtM95v8/MpyDwdU/ZpO
	AQGkfQp6DzAdbqXLtnDckDAHpU3dzB6yAGSxcW1b4RkT8U4wwIPm9uYYmgbA5UuHeNgBbsKBAI4
	+CptyodoBsJeRM2wB1nhhQKS9DKoTzCRXoIfX
X-Gm-Gg: ASbGnctSotIFVmvVpgGvIiR7DE6kFKvJfRP48OHo66WMCFWt4gSYXQCrX86RkYs80zR
	ug5Bvs57vm2S5i29Jn0MHmiEzGZ0Zz5mnhEd9+ChnFbnN9ClS2Drr8UvFtzpijZ1vf8Xbw6tBaM
	txIt2bdiLmBvpj8EObaD8NqGNpjmU=
X-Google-Smtp-Source: AGHT+IEKSHHYr8188K9ntmJciY47CcWvf6ZohiVQ/T+y3MDsXI32//5qi0ZmXcjGDzT7A1Fuf5ToO2bW8eZG8xGReGI=
X-Received: by 2002:a17:902:f809:b0:21f:40e8:6398 with SMTP id
 d9443c01a7336-223f2700461mr2875315ad.26.1741183625420; Wed, 05 Mar 2025
 06:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305083735.393333-1-irogers@google.com> <20250305083735.393333-2-irogers@google.com>
 <e2ea3776-12d2-41c2-9b7b-836c7c249c45@linaro.org>
In-Reply-To: <e2ea3776-12d2-41c2-9b7b-836c7c249c45@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 06:06:54 -0800
X-Gm-Features: AQ5f1JoxD1jbTg08KjqHao7OjOP92CCi6YqUvtq1vHnaNmgjvf06g2yd9I0-Rfg
Message-ID: <CAP-5=fW0LESRaZkGv-UCZGU_ttYi6kdF=dxJZP8KmVTiTwBM+Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:44=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 05/03/2025 8:37 am, Ian Rogers wrote:
> > In the case of '{instructions,slots},faults,topdown-retiring' the
> > first event that must be grouped, slots, is ignored causing the
> > topdown-retiring event not to be adjacent to the group it needs to be
> > inserted into. Don't ignore the group members when computing the
> > force_grouped_index.
> >
> > Make the force_grouped_index be for the leader of the group it is
> > within and always use it first rather than a group leader index so
> > that topdown events may be sorted from one group into another.
> >
> > Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@=
linux.intel.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Testing on Arm seems ok, but presumably this doesn't change anything
> there because arch_evsel__must_be_in_group() is always false.
>
> On x86 I ran into the topdown metrics not opening on cpu_core at all, so
> I'm not sure if I'm able to test that the original issue is fixed on my
> machine. From looking at the link the issue is that the ungrouped
> topdown event is "<not supported>", but I always see that regardless of
> grouping despite perf list saying it exists:
>
>   $ perf list --unit cpu_core | grep -i topdown
>    topdown-bad-spec OR cpu_core/topdown-bad-spec/     [Kernel PMU event]
>    topdown-be-bound OR cpu_core/topdown-be-bound/     [Kernel PMU event]
>    topdown-br-mispredict OR cpu_core/topdown-br-mispredict/[Kernel PMU
> event]
>    topdown-fe-bound OR cpu_core/topdown-fe-bound/     [Kernel PMU event]
>    topdown-fetch-lat OR cpu_core/topdown-fetch-lat/   [Kernel PMU event]
>    topdown-heavy-ops OR cpu_core/topdown-heavy-ops/   [Kernel PMU event]
>    topdown-mem-bound OR cpu_core/topdown-mem-bound/   [Kernel PMU event]
>    topdown-retiring OR cpu_core/topdown-retiring/     [Kernel PMU event]
>    topdown.backend_bound_slots
>    topdown.bad_spec_slots
>    topdown.br_mispredict_slots
>    topdown.memory_bound_slots
>         [TOPDOWN.MEMORY_BOUND_SLOTS. Unit: cpu_core]
>
>
>   $ sudo perf stat -e topdown-retiring -- true
>   Performance counter stats for 'true':
>       <not counted>   cpu_atom/topdown-retiring/           (0.00%)
>     <not supported>   cpu_core/topdown-retiring/
>
>
>   $ sudo perf stat -e topdown-retiring -vvv -- true
> Control descriptor is not initialized
> Opening: topdown-retiring
> ------------------------------------------------------------
> perf_event_attr:
>    type                             10 (cpu_atom)
>    size                             136
>    config                           0xc2 (topdown-retiring)
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8 =3D 3
> Opening: topdown-retiring
> ------------------------------------------------------------
> perf_event_attr:
>    type                             4 (cpu_core)
>    size                             136
>    config                           0x8000 (topdown-retiring)
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off exclude_guest for PMU cpu_core
> Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
> falling back to no-inherit.
> Warning:
> topdown-retiring event is not supported by the kernel.

Yep, unfortunately there is a requirement that a topdown event like
topdown-retiring is always programmed with slots on performance cores.
The slots event must be the group leader. You can see in metrics the
slots event as "+ 0 * slots":
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=3Dperf-t=
ools-next#n754
```
        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0
* slots",
```
and making it the group leader is done by the sorting:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/util/evlist.c?h=3Dperf-tools-next#n67

We could probably add something to
parse_events__sort_events_and_fix_groups to inject the slots event,
but this hasn't been done yet.

My main concern with this change is there is some sensitivity to the
event ordering when parsing them in scripts. There's some context in:
https://lore.kernel.org/all/20230719001836.198363-1-irogers@google.com/
This change makes the topdown events appear first in the group always,
but as you say you only see that if you use those events, otherwise
things are unchanged.

Thanks for testing!
Ian

