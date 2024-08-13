Return-Path: <linux-kernel+bounces-284974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDA950784
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5772E281811
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF319D088;
	Tue, 13 Aug 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8NVb/cO"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCC19D085
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559301; cv=none; b=I0vgKM+x1syjhpcOXodT0G8O6GeZUSHI6BSuHVa/Zk6pFrO5TY26iSIQos/EOsFi4OBeAeaxKfpwD/Ao1K/dWop4e2oKbcmNDu4jmXPFC2flSEav9Ac+WEwpgKZuVRqjYE+Ez+adGD7NuCCQ69AKdklwujYn2wKZgEsMLUOlTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559301; c=relaxed/simple;
	bh=MGfamdGAk8HrKfaDqakpaY7IT3Ti3k5iPmyzw0pKF6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzRm5uYydg+RysNPX7xb102ZN7xUxIA8tg4tdjP088zXuRk4Ube5hTNcAM2HVy/e984nAbkIz7PF2LVT07gmFtC+qnFjd3Ku/9XkjWtYHow7YTrny/9GiEyNi90jrx+ZoH09z1APybh6APa9ysFoEEkaxrAfoHyQ9oF1oZFnX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8NVb/cO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fdc70e695so206531cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723559298; x=1724164098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwMwCe9XraET4qEmC7d2hSRU8Grm1zoGQun5Yl3pIFQ=;
        b=r8NVb/cOhvjkNZQrbDxyVUlbNZ8bbxIJfuFeWeFN9hJUq/EIPqvRvLbDTBqX3/o12V
         drsOn1vmyVrfuXEKZLg6NeeTMbBhb26UojjehAVUQngQJvgByFIuvFlUPWwT6Ako7xnV
         eOZoI0qATA6hQWQ04PDvmoFLfM+PROg8Kw9mo4njh5yFhfN10UPk+9D2v60hwSDvd6+U
         bBNlnmh2UvB2CLaq5tNpqplPJaBuIwcQ7ZdZDA92ytv4vIlz6W0F17d4hLwjqy7xdSxE
         7j4euz3tc/bFp22DvCqdofhVX7UnICj6d2FE9bQAaM2sgVApawTxQw0RtEJiG4xQ2cgS
         UAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559298; x=1724164098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwMwCe9XraET4qEmC7d2hSRU8Grm1zoGQun5Yl3pIFQ=;
        b=n3ABEIDCnWba8IZzU7A+iyt0eEmkJs9WKkBBXIQJa/0ARrtQJVe7vuWXltI/UKWCA8
         Hm7muMB2sr4cRI0FWPup7GZ9yytYzLIrX0/4zZ07W08IFuExgNBDkcErJIY5kWGoht+t
         Ny8brpMTRcSlzOlCrnKE280ZgEwkhA01KlDDpIUFmYT0zAPn5POky+Ep2gZdLDv0PDE8
         qWYywUEO/fbyS1twoQ5BzQ/hq3bj+A6px1B0qDv6R5o2HwZBNySXvQKO+srzw36xKzvN
         iX2GvhnFI6ieRT+ZvrGSWw2xO11gxe15cW4Q6O4+kfhqZXhR9hDLGk3ETIMcJW9RkW1y
         FATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVyi6YQmgHjlW9sdcM+KR+5+CeKmT8MnWrkg/sXXbaAQApMN5BkmFFnaUeFTCX2DOSzIZlum9JL40FIMWR/2oyzDOV7rzkKJS/okpz
X-Gm-Message-State: AOJu0YwlIr+EyANSP2mPjzACWCsTL4KXEoMWBw59Tnl9dPdbAVogyU1I
	cihuVs4fBiFnSPi/eggIs66T2S4k2SIEp72YhND6abgtuWg4DOHqk5y2b9JYGmt/XEqCH2ogzjy
	WqmE71Em1CboNR9vV7WpCtRl9cVaULpWdNX85
X-Google-Smtp-Source: AGHT+IEHcwqV4cFmhHUR8wPvObTxmaxWalQoPmmrv/9ZEE67XYps098QKeZ/3rcuQ+XnEfwzoGkAkOkUdzIssDWVrWg=
X-Received: by 2002:a05:622a:102:b0:447:e497:95d0 with SMTP id
 d75a77b69052e-4534f9d9f38mr1372091cf.17.1723559298338; Tue, 13 Aug 2024
 07:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813132323.98728-1-james.clark@linaro.org> <20240813132323.98728-2-james.clark@linaro.org>
In-Reply-To: <20240813132323.98728-2-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 07:28:05 -0700
Message-ID: <CAP-5=fX-m3mhi0sGsGo9biWmFV_U=35Tp7h9X0reg3zHMEsy_Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf stat: Initialize instead of overwriting clock event
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:24=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> This overwrite relies on the clock event remaining at index 0 and is
> quite a way down from where the array is initialized, making it easy to
> miss. Just initialize it with the correct clock event to begin with.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-stat.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 1f92445f7480..a65f58f8783f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1817,7 +1817,9 @@ static int add_default_attributes(void)
>  {
>         struct perf_event_attr default_attrs0[] =3D {
>
> -  { .type =3D PERF_TYPE_SOFTWARE, .config =3D PERF_COUNT_SW_TASK_CLOCK  =
           },
> +  { .type =3D PERF_TYPE_SOFTWARE, .config =3D target__has_cpu(&target) ?
> +                                               PERF_COUNT_SW_CPU_CLOCK :
> +                                               PERF_COUNT_SW_TASK_CLOCK =
       },

Hand crafting perf_event_attr when we have an event name to
perf_event_atttr parser doesn't make sense. Doing things this way
means we need to duplicate logic between event parsing and these
default configurations. The default configurations are also using
legacy events which of course are broken on Apple ARM M? (albeit for
hardware events, here it is software). Event and metric parsing has to
worry about things like grouping topdown events. All-in-all let's have
one way to do things, event parsing, otherwise this code is going to
end up reinventing all the workarounds the event parsing has to have.
Lots of struct perf_event_attr also contribute to binary size.

If you are worried about a cycles event being opened on arm_dsu PMUs,
there is this patch:
https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/

Thanks,
Ian

