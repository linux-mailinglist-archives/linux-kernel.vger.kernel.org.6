Return-Path: <linux-kernel+bounces-260121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D893A354
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA53A1C22570
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED18156F27;
	Tue, 23 Jul 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVp7hrQo"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B753156C70
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746663; cv=none; b=MgOACopXJqudTX2gJOvOr3PaILSz5DGppNyC/SnuPs7dihQjEdO8B7YrqhIcFfDYKPNEoANONkJN2Ia1T32hJ2OrfCZC6YG5mKH04wpON12yrUlgZ10GPShJthn96UMaCMQjPzR4J8NYgg2cpvA7RwKLTiUfeQAcu/0ztvV65Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746663; c=relaxed/simple;
	bh=iEhm9/9xLKg6GaZQCc+MM9yVFxWsVzlmo5ZoEYVZUmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lN8p9BVaRrspmJyp5/TtTtC8pjbR1QM0XSeO7w35Co6GBJNGsu/q9FFqJxiFxoagyMDFby7r5FKoOBzb0GYNnyQH6MpoDKoRnzdy619LeemWM7Y9qkE7d6GRjH+23YcBqHuvoEEgXbkdgbbq1g2rnuR8Nz28B+O9mNiXPreST5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVp7hrQo; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-398b599593eso134735ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721746661; x=1722351461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOO8rTGxuXP8p8sxBPSAP2u2AgeXwG2nl1LkN5RKC9U=;
        b=fVp7hrQopELTQq/PY7dFe8u9HUQj4CqV8O9ASJG4vWq6yIE7sa15CFXFw16L7gOVLz
         p8189J+0h9iOEO0ePIQ/OSXV2b0a/bPe96SOxNn8oec7190t3unfmmwH3/Kl6GjdjBxM
         sLePT8Dqgu1B2GlMuDlahnuUWcBCOZsdhm9OkYt50lvmPn7RYdVEeIZ+ILArYH3xWmWH
         bxMgzjmJw2G2yQDiJ4x4cMSOEcfA4tUNwYjuF7IxnRnjsPLjyWLyHa72mlqJvsCpdfKv
         /KlnrpRxdrlkt2C1YzbsKVzO8u1CCZ0bEz2ug5y5rQQvvVN4k9KDCKlGCH96reoPfKNm
         bB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746661; x=1722351461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOO8rTGxuXP8p8sxBPSAP2u2AgeXwG2nl1LkN5RKC9U=;
        b=nJaOFHOYovgKnIyL3RWue6ImE6zr+PpfRJ8Ogj2es5N5VgC6VWu4AK2hhgZBsQmZn0
         cPoFiJiFzkr8d6Xsfm2dHfZec+yAv0Z3nZtoLDCfDs2waJtnIx5xWaGKHxyRgqzO2rZ8
         DpEMqPPUrJyAGxZQpK5fsM3H9/rqnkb6KRWRAJUUvwww3J0HUd2YUyv1qkjGQEko16A3
         XSv5x2OSgVYRwVr60BXYfQuNPE0UJ76BfuingJwLt+0sbrq+u+vsDs47hj/NmFouuK8X
         G8DyDtjJpjnCx7bCHwQ+W3d2ii9B4p0Jwh9DjB0O0lb2wzYUCtN024UW4oNK1D6cG3P9
         A4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCX4KJUB7VKx5RgSF4ewzYsQ5qCleySZ1JCUXAPnHn461RwhinEdG4HegG3K34+/ei9mPobyKVMjvu29OzekboaD6vIw5LNZv9sVo1W7
X-Gm-Message-State: AOJu0YyT4TbSDMCreLC1drLSg83kwYCqIzJqMlAPsZTeX7JEnxiElQmB
	Ath+pHunPF6aktdSt+ot+Pz1ZexUUk8ebgLKgxTt6Je7kFcAJEK6Rrp/rDBzaLAWRSZwgCxMQ1h
	c3ZNxsLq6bFKpFAUopasO+ydPvSoKoBB3u7SF
X-Google-Smtp-Source: AGHT+IH/RpMY9dkipDwHt7eC8aSysGJbBXGF2Ss3iyuxo9ET10fPeoN4bU+sC777ajTWlkewT5mGlhe9GeTDLraUxjs=
X-Received: by 2002:a05:6e02:388f:b0:375:d7d7:bfc with SMTP id
 e9e14a558f8ab-39942180057mr7732145ab.27.1721746661348; Tue, 23 Jul 2024
 07:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720074552.1915993-1-irogers@google.com> <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
In-Reply-To: <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 07:57:29 -0700
Message-ID: <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: James Clark <james.clark@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:41=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 20/07/2024 8:45 am, Ian Rogers wrote:
> > Andi Kleen reported a regression where `perf script +F metric` would
> > crash. With this change the output is:
> >
> > ```
> > $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
> >
> >        21.229620 GB/sec
> >
> >        15.751008 GB/sec
> >
> >        16.009221 GB/sec
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
> > $ perf --no-pager script -F +metric
> >              perf 1912464 [000] 814503.473101:       6325       cycles:=
  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
> >              perf 1912464 [000] 814503.473101:   metric:    0.06  insn =
per cycle
> >              perf 1912464 [000] 814503.473101:        351 instructions:=
  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
> >              perf 1912464 [000] 814503.473101:   metric:    0.03  insn =
per cycle
> > ...
> > ```
>
> For some reason I only get the metric: lines when I record with -a. I
> noticed this because Andi's test doesn't use -a so it fails.
>
> I'm not sure if that's expected or it's related to your disclaimer below?

It is. When you don't do -a the cpu map just contains -1 and for some
reason it is busted. The whole indirections to arrays of arrays,
counts, stats, aggregations, with indices into various other arrays
and a lack of helpers. The code works for perf stat, but there is a
lot of complexity that I don't fully grok in that. Here I've tried to
kind of break down what the code is trying to do in the comments, but
the old code never did sample_read_group__for_each so was is broken
with leader sampling? Is the leader sampling pretending the read
counts are periods and calling process sample multiple times. Andi
likely knows this code better than me so I was hoping he could fix it
up. We may want to take the patches anyway in order to not have a
segv.

Thanks,
Ian

> >
> > The change fixes perf script to update counts and thereby aggregate
> > values which then get consumed by unchanged metric logic in the shadow
> > stat output. Note, it would be preferential to switch to json metrics.
> >
> > Reported-by: Andi Kleen <ak@linux.intel.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378=
-1-ak@linux.intel.com/
> > Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than save=
d_value")'
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > The code isn't well tested nor does it support non-leader sampling
> > reading of counts based on periods that seemed to present in the
> > previous code. Sending out for the sake of discussion. Andi's changes
> > added a test and that should certainly be added.
> > ---
> >   tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++------=
-
> >   1 file changed, 93 insertions(+), 21 deletions(-)
> >

