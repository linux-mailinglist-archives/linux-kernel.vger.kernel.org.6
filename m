Return-Path: <linux-kernel+bounces-366097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918F99F0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17EF283A75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7E1C4A28;
	Tue, 15 Oct 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udD0Kz0h"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1581B3940
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005300; cv=none; b=isyWWFGhqFZP9s5TSFk3vzXBJTVVI+jTOm7FS/6lVSSWojl30XBcv+UQGyOh+VldnaPBfUr8AlL4Q6n1Xf806V6yKpVIqij0+aTG+FMvddqYYt1I9b2qn9RnNubaQHtUVz4Y/fkZBGI1QL/1+R+hXLiUCYkHMtC4z7204A02mrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005300; c=relaxed/simple;
	bh=YJuTAWbzfzEkY5tnxjA/cxqO44FG6D08+g44dBiovj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECKXdDh4Jyj4w3gUxGo80fKU9fpUWXBfCbPmLvX/xrDRh9Qz1DIlygWIGVQHit+xTCJP/n3p0ohAGzA+wzliJ8+oipKEEubLBe1coyaJvngMVvpEuVh9xd+hFEIG0n4qofr9l9UCRjQPEscMBhC6hpv2zp68zxcfW65JqObkBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udD0Kz0h; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso1192745ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729005298; x=1729610098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX9GKoYWAHpa9ysEIADsrbx0IvSYvOkUeOyeyDQEEAQ=;
        b=udD0Kz0hq0AVM8y4FKyUJTnxpN9ioqPr27ZiMysdp4AWVNDWAZVioOpgltinjo3PRV
         Ts2owFmpFZJVSPCGEUNTg4oudOBe0PVbkl8jVtNYQbMse5nwZW6Z49Iq4JQ3c7gDHGnN
         e6AE+A6Gs72bdjKtTZR6sTErm2jrGQAVzd+jr0v+7o1BwKx4zIDhE4owVbCJdymyK9yH
         oByFbGuFMYDnmXmEniba84VZ8unzdoZPGV3yyv93Rif0PAAZN9aAoBHZSpY5mmhzHrKJ
         tU9xuc2FjruXogsOeVN9XXJNNV31CgX5sXoUpIsy51biALw1xx/vnqgedk1y314oob9W
         hgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729005298; x=1729610098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX9GKoYWAHpa9ysEIADsrbx0IvSYvOkUeOyeyDQEEAQ=;
        b=M+MshOj/KS67XlcDdNy0b3anaqjyIrXD2nZF2aN0Fd3ogm8EMcY3Pt8AIttQijB/P0
         x+OidjzXLY0e0Y4g/WvBtf6Z01cpBE0hY7G+x7Lt/Lr86gwyXAKNoFkiw0GzwLxIJAMM
         yPYbGR+ZWNNgHHxBNZ4/wcrRaH8E7sXTUOl2lStVl3kGUfQq93uZ5JVcJuauZJ7anKTZ
         +tRWx0e+X4WRk65hsCJRpInlCU35lvNz9IS2yES1mp9gz1vn0EqZUt4bpD5XYSYi/ObN
         mVOdw2WcJFD39tv8/pMVfAGfhpBwS2wxNd8ilc5nTF+pzSWfn6fd0sUqHUri/txqBjlG
         Pt1g==
X-Forwarded-Encrypted: i=1; AJvYcCWEW+JaLTYfyqTlqUzr8uCMB2m/TY8OTs26qGb0FbcA2OXH6AWHmMvlD92KOEkvWsb4TCVFqPKvZlRf9DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLrFa/vDyyW4ANecjO4etyPanwUJhLj4qm2PGBdRQ0DtEWIEm
	jm4rV3HcSC8JzayL41IN1YbqoXCjA9hUoRBR2EEV54QEQoQaz+KXpBZhx4hAxI2ldxyuUEmnA5t
	hb8iTndVkB332+blA8V9OoKVYJ8el0xaBzmS2
X-Google-Smtp-Source: AGHT+IHcapq1UQHNvRWE/S8IaAe+w7qwa7HlKHT7LTqC5T18uKQCSvQHXk35kawm1KKOBgjt3+0fr/Z3rQr4JKByzJA=
X-Received: by 2002:a92:c54b:0:b0:3a0:9cb6:cb with SMTP id e9e14a558f8ab-3a3bdd34525mr14545835ab.7.1729005297931;
 Tue, 15 Oct 2024 08:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015145416.583690-1-james.clark@linaro.org> <20241015145416.583690-2-james.clark@linaro.org>
In-Reply-To: <20241015145416.583690-2-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Oct 2024 08:14:41 -0700
Message-ID: <CAP-5=fW7aERe3KHtAoYX9UWsVWrhU95RcCgabgP+DNHi1whjsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid platform
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 7:54=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Since the linked fixes: commit, specifying a CPU on hybrid platforms
> results in an error because Perf tries to open an extended type event
> on "any" CPU which isn't valid. Extended type events can only be opened
> on CPUs that match the type.
>
> Before (working):
>
>   $ perf record --cpu 1 -- true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
>
> After (not working):
>
>   $ perf record -C 1 -- true
>   WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPU=
s 16-27) for event 'cycles:P'
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (cpu_atom/cycles:P/).
>   /bin/dmesg | grep -i perf may provide additional information.
>
> (Ignore the warning message, that's expected and not particularly
> relevant to this issue).
>
> This is because perf_cpu_map__intersect() of the user specified CPU (1)
> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
> CPU map. However for the purposes of opening an event, libperf converts
> empty CPU maps into an any CPU (-1) which the kernel rejects.

Ugh. The cpumap API tries its best to confuse NULL =3D=3D empty but empty
can give you dummy, dummy is also known as 'any' or -1, 'any' sounds a
lot like 'all' but sometimes 'all' is only online CPUs. I tried to
tidy up the naming a while ago, but there is still a mess.

> Fix it by deleting evsels with empty CPU maps in the specific case where
> user requested CPU maps are evaluated.

If we delete evsels than the indices can be broken for certain things.
I'm guessing asan testing is clean but the large number of side data
structures that are indexed by things in another data structure makes
the whole code base brittle and I am nervous around this change.

> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index c6d67fc9e57e..8fae9a157a91 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -47,6 +47,13 @@ static void __perf_evlist__propagate_maps(struct perf_=
evlist *evlist,
>                  */
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus =3D perf_cpu_map__intersect(evlist->user_requ=
ested_cpus, evsel->own_cpus);
> +
> +               /*
> +                * Empty cpu lists would eventually get opened as "any" s=
o remove
> +                * genuinely empty ones before they're opened in the wron=
g place.
> +                */
> +               if (perf_cpu_map__is_empty(evsel->cpus))
> +                       perf_evlist__remove(evlist, evsel);
>         } else if (!evsel->own_cpus || evlist->has_user_cpus ||
>                 (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist=
->user_requested_cpus))) {
>                 /*
> @@ -80,11 +87,11 @@ static void __perf_evlist__propagate_maps(struct perf=
_evlist *evlist,
>
>  static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  {
> -       struct perf_evsel *evsel;
> +       struct perf_evsel *evsel, *n;
>
>         evlist->needs_map_propagation =3D true;
>
> -       perf_evlist__for_each_evsel(evlist, evsel)
> +       list_for_each_entry_safe(evsel, n, &evlist->entries, node)
>                 __perf_evlist__propagate_maps(evlist, evsel);
>  }
>
> --
> 2.34.1
>

