Return-Path: <linux-kernel+bounces-186965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C28CCB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2DE283012
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D353E31;
	Thu, 23 May 2024 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lyoPPAmX"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8021F5E6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437050; cv=none; b=MvcGxNCYHsUVEsOabbMhHbTP02xZHl6i1bI3EMiAlRgmnrwHNIr2kDj44qxyfeMksZOknKkg8SNNH15uBm34rNch1TKZANzeeiKeV7o+rcxerASJ8Ocy+bgaD1c+8M3KskKIVEcIpleX3/7jaOgD9IPIwnHxNG7G/yog30ZgsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437050; c=relaxed/simple;
	bh=XTUe5aCnw3K/pMpLtTkLFD0FKOvZqW9DD/Kq3k7RHg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOoT8n2+AipvRMnT48DkERD3ic07qfjPx6kicaIcGA4IfBrbsSOtaCWC38DaoyTuCKfGNrf7auGVtHOCJVfmqZMgazYiTbbHZLuo81SSPFbXrskc9+KiM66sla9XZ1IWQ3CwL7kRJdPxyBdOM9fo5SXLd9WEb88OOpHhzZKE5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyoPPAmX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfe020675so305831cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716437048; x=1717041848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ0/oTNt/XNBJvSuQqhte1CxCjwKvN4ey33h/UCL+Tc=;
        b=lyoPPAmXARvarbo/wZnblGrnuX6dze7u34Cx9DEyFJ+L+ZHvGTB9nbnRra12vmVV2Z
         3YnDtyYhxJQbLgL+zY4TAARbWzw7Q3JJeEk3izJMhJx8lMrYcWgCsazTbQRA9uU95rYs
         QO04d0a39G25GqfEniFDxfZN+UBllaQolFhzpgHy8D5ziDVJnbc/hxEZ/zkb4hpt/fp2
         AAoNRNhSrkW7NFKLirUc6UCyFoGO8joEmsAfM/6hZbvBzVshYAwvxvKSW8ZAi982+bIR
         tuAKGEOD19gPhM/w2J/jaeOiH7WrefWC6M0wwdjcedtHFUEo4fjbppq33mtI2XmURsjm
         MVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437048; x=1717041848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ0/oTNt/XNBJvSuQqhte1CxCjwKvN4ey33h/UCL+Tc=;
        b=Ype1zEXNCjkXujPzsl3Ocdo6Oz4NS9JJBep1bDbDz7Q7sQXmOjri8qemyMAgPKLy0M
         LEjDHPe6Wwg1rKNr9F1CEaX3Zzj+zb/Pp7ODHwZG1YQ/UeFtN0286q1YuH81c9RVS4fu
         Ln9UySXCP/dIaPrQ3CPt9ImKP2wrDS/CTTFKGAzke2u64A66ET7zk/B9jX5O/KVf0iaD
         qyAhsEPQjCzDGlbmPCn3dgdH7j5sYkuO6D5AeAZpaiemrO3GrBQ3WlmD5ip6OrKE4U8Z
         X/SW3mp+Wwfc/HbhDGB5RBMsqduQsjDwFH7IuhC5EtEFLiySvWG15z50OsCNV2MzEDR0
         4l1A==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ01uKe3dLo7UqMw64dCJi7n2iKB2Fz4vvGWvc/NCyvEzR5yxvhiZbg9pBS3cOA9RDduSuChciB/zYcxmNhOS4jP9bO7r+MwQQdFZ
X-Gm-Message-State: AOJu0YyCCjA+OqxYmE8j1hkcOS+ybsWJjHyRJHSWqj6gWvJ1JtEdFMZb
	jqJS0Fn3AK65vlJfwMqMWX+hTo3rogBQNWa8VV0PbfNnAtY36wng0A0INGl7MdMZaFyO+z+4pbl
	6Pi15jDGAa1FyM5g4xnTZCSAybbpQB73veC97aveDbjkv2X3KKHKB
X-Google-Smtp-Source: AGHT+IGqllYxOUfGCyA3rl6J1Jk1N/Z/YMMqp/pujhDjVukawgCJ2WGf2kAu+w1xf1XXebK+gmnt79RYn0wDxMj7N10=
X-Received: by 2002:a05:622a:418b:b0:43e:3b12:8bb0 with SMTP id
 d75a77b69052e-43fa80bf918mr875721cf.17.1716437047593; Wed, 22 May 2024
 21:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com>
In-Reply-To: <20240521173952.3397644-1-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 May 2024 21:03:56 -0700
Message-ID: <CAP-5=fU2-9WFZAewj_B7phusZyarA3xrenGVz6PMwy5B+B=RPg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 0/7] TPEBS counting mode support
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:39=E2=80=AFAM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Changes in v9:
> - Update the retire_latency result print and metric calculation method. P=
lugin
> the value to evsel so that no special code is required.
> - Update --control:fifo to use pipe instead of named pipe.
> - Add test for TPEBS counting mode.
> - Update Document with more details.
>
> Changes in v8:
> - In this revision, the code is updated to base on Ian's patch on R modif=
ier
> parser https://lore.kernel.org/lkml/20240428053616.1125891-3-irogers@goog=
le.com/

I pulled the first patch of these 3, to clean up the tool events into
its own patch and hopefully addressed Namhyung's feedback:
https://lore.kernel.org/lkml/20240503232849.17752-1-irogers@google.com/
It is looking for review.

I think in general it'd be useful when posting the series to include
the patches it is dependent on, that way we can also make changes to
those patches (for example the missed perf-list documentation of the
'R' modifier).

Thanks,
Ian



> After this change, there is no special code required for R modifier in
> metricgroup.c and metricgroup.h files.
>
> Caveat of this change:
>   Ideally, we will need to add special handling to skip counting events w=
ith R
> modifier in evsel. Currently, this is not implemented so the event with :=
R will
> be both counted and sampled. Usually, in a metric formula that uses retir=
e_latency,
> it would already require to count the event. As a result, we will endup c=
ount the
> same event twice. This should be able to be handled properly when we fina=
lize our
> design on evsel R modifier support.
>
> - Move TPEBS specific code out from main perf stat code to separate files=
 in
> util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
> - Use --control:fifo to ack perf stat from forked perf record instead of =
sleep(2) [Namhyung]
> - Add introductions about TPEBS and R modifier in Documents. [Namhyung]
>
>
> Changes in v7:
> - Update code and comments for better code quality [Namhyung]
> - Add a separate commit for perf data [Namhyung]
> - Update retire latency print function to improve alignment [Namhyung]
>
> Changes in v6:
> - Update code and add comments for better code quality [Namhyung]
> - Remove the added fd var and directly pass the opened fd to data.file.fd=
 [Namhyung]
> - Add kill() to stop perf record when perf stat exists early [Namhyung]
> - Add command opt check to ensure only start perf record when -a/-C given=
 [Namhyung]
> - Squash commits [Namhyung]
>
> Changes in v5:
> - Update code and add comments for better code quality [Ian]
>
> Changes in v4:
> - Remove uncessary debug print and update code and comments for better
> readability and quality [Namhyung]
> - Update mtl metric json file with consistent TmaL1 and TopdownL1 metricg=
roup
>
> Changes in v3:
> - Remove ':' when event name has '@' [Ian]
> - Use 'R' as the modifier instead of "retire_latency" [Ian]
>
> Changes in v2:
> - Add MTL metric file
> - Add more descriptions and example to the patch [Arnaldo]
>
> Here is an example of running perf stat to collect a metric that uses
> retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a MTL s=
ystem.
>
> In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES samp=
le.
> Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_latenc=
y value
> are all 0.
>
> ./perf stat -M tma_dtlb_store -a -- sleep 1
>
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.000 MB - ]
>
>  Performance counter stats for 'system wide':
>
>        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tm=
a_dtlb_store
>          3,195,608      cpu_core/topdown-retiring/
>         40,156,649      cpu_core/topdown-mem-bound/
>          3,550,925      cpu_core/topdown-bad-spec/
>        117,571,818      cpu_core/topdown-fe-bound/
>         57,118,087      cpu_core/topdown-be-bound/
>             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
>              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
>         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
>         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
>            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
>               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0
>
>        1.003105924 seconds time elapsed
>
> v1:
> TPEBS is one of the features provided by the next generation of Intel PMU=
.
> Please refer to Section 8.4.1 of "Intel=C2=AE Architecture Instruction Se=
t Extensions
> Programming Reference" [1] for more details about this feature.
>
> This set of patches supports TPEBS in counting mode. The code works in th=
e
> following way: it forks a perf record process from perf stat when retire_=
latency
> of one or more events are used in a metric formula. Perf stat would send =
a
> SIGTERM signal to perf record before it needs the retire latency value fo=
r
> metric calculation. Perf stat will then process sample data to extract th=
e
> retire latency data for metric calculations. Currently, the code uses the
> arithmetic average of retire latency values.
>
> [1] https://www.intel.com/content/www/us/en/content-details/812218/intel-=
architecture-instruction-set-extensions-programming-reference.html?wapkw=3D=
future%20features
>
>
> Weilin Wang (7):
>   perf vendor events intel: Add MTL metric json files
>   perf data: Allow to use given fd in data->file.fd
>   perf stat: Fork and launch perf record when perf stat needs to get
>     retire latency value for a metric.
>   perf stat: Plugin retire_lat value from sampled data to evsel
>   perf stat: Add command line option for enabling tpebs recording
>   perf Document: Add TPEBS to Documents
>   perf test: Add test for Intel TPEBS counting mode
>
>  tools/perf/Documentation/perf-list.txt        |    1 +
>  tools/perf/Documentation/topdown.txt          |   30 +
>  tools/perf/arch/x86/util/evlist.c             |    6 +
>  tools/perf/builtin-stat.c                     |   24 +
>  .../arch/x86/meteorlake/metricgroups.json     |  127 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |   27 +
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/data.c                        |    7 +-
>  tools/perf/util/evsel.c                       |   53 +
>  tools/perf/util/evsel.h                       |    5 +
>  tools/perf/util/intel-tpebs.c                 |  301 ++
>  tools/perf/util/intel-tpebs.h                 |   30 +
>  tools/perf/util/stat.h                        |    1 +
>  14 files changed, 3163 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroup=
s.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics=
json
>  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
>  create mode 100644 tools/perf/util/intel-tpebs.c
>  create mode 100644 tools/perf/util/intel-tpebs.h
>
> --
> 2.43.0
>

