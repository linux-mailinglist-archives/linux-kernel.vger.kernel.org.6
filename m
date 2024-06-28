Return-Path: <linux-kernel+bounces-234324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8913E91C535
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0567A288E32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3F1CCCC5;
	Fri, 28 Jun 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oh8L48dM"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8E158219
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597140; cv=none; b=EhhpSlfBWXyr9DL+yKR0d/jWP3eqfqrPyG8DvcDajmmlHadZi8VMS83xvRBPY3xe6fVAliyu1ePRPEZKUIB5y54+YmF4ApE9U8ne1DjY72F3HhEkzevZ0rwjWpNurxVfVmqJGrYXQYzGN4DsW5DrIUvB8kjffCvPMkCkzELUDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597140; c=relaxed/simple;
	bh=gFvyB44eZxW+rZLLLtn4UtRbw9O0gdT48JudAO1dRQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyB6uS5H/k4wZGmzm8DCGQKgDUUXyZkpJ2uPrTCKmRJNu+PgZBYf1ETwFMQw75qGc37YoF4sZ9/BCfuaJd9h6XOuhNfPMUqkzuWWVkcnqsB/dei85XZ/RJwIgG804xi6SixMjOQUuT0zrfmSSfNdL7SCeN9LI6R4IhfMcLD8hKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oh8L48dM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3762775e9ebso13755ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719597138; x=1720201938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg9T/mfcnl1CD0r165TjIqJmT4cASY+E7dxfeveE1u0=;
        b=oh8L48dMZO8vwG33ZZNphxYK57ZakgYTpvWzK+/gMV0/Aqp42W+OML6w5NkL6+QUfE
         E3mlyGFc1kDReRxbNVPcHNTAZkPfnEmcKCLX86zEgrt4ACI/04MistrN/Fj5dCESSXVf
         rFpoKj5nX5PpYBjc9aX0SoPcSNYPopA1VCGUDoaWm6W6HY4T+Xe8ngVukWySP/CKa6qU
         ErKSbMb34PUFJMPyF+1hw2JoGNc4fvJmhI9CnDa66UpqM5E7H0etF+IEnvH3ZAGrEwyY
         +N20pLSGHuzcwSco7aIfn6wO9k095oyxQ0w9b++dSMhXr7oy4Wr83ElYV/XVHljxZRMq
         Uuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719597138; x=1720201938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg9T/mfcnl1CD0r165TjIqJmT4cASY+E7dxfeveE1u0=;
        b=aFUqoHq+wUtyRG1RwPyh/zu6FtGqt3wiq3Vh/rFn7qfv5q/JFvx/uuDcPWviSKC30Y
         Nd/1+pGfZ69xSTtRBvum869Q9DgCr/3FKXp6o+8MFljZcD4Bi7mt98AUC2TPSpzf6DWS
         3gXOvaQoW3JWrHCkL2ybvEPBUPylDOvpyWVqRZ6gJr/5ei/B/qM8zuvPWYzmC8VgKv1A
         MZgy+XCVhIOcUSUq8EkTKm7S4U5a4zhV4nlkooaovbG6zsZtlyFIKPa4i7WQMFpg/qx8
         DBE3+0Zv3/ukyfaLzA8CrOAw68jxcqNM83+jFFVJmPldpbiR1onglpcACtxgNdMAutLd
         3ymg==
X-Forwarded-Encrypted: i=1; AJvYcCVl1zK5ajWWUdgeN1bF4RSl6K6yHYgUEiiRMH5mQfX/fCp7T6waHE7is96V7WmycFuvhf7ZQJe0MbKh/3Gb8C986tWPBjN8kvWJN9JO
X-Gm-Message-State: AOJu0YwMNYaqaqzBxridXbjHchyHVE7NpMVckpyhNj+4d6BGb30Rqo2q
	yWs/jaUiaiytCp51b4cDcXE2f/xEEYZTi7NQeLaZQFYrZx/f/mOuQK0NCA3c8f3bcoykmDVNbZD
	tl7kzkgQr8R4UHTC/BM4kdwad0bwXgBaYFIc4
X-Google-Smtp-Source: AGHT+IH/9la8ID59tweWNYIiYUYSkt6KsWUDgv0y1VttYV5sTQwJHmCUkqes6fLoxa8JK68vFQ/bUOHL6uTiABBZlT4=
X-Received: by 2002:a05:6e02:17ca:b0:376:44b9:c363 with SMTP id
 e9e14a558f8ab-37c3d4a8b3bmr119375ab.6.1719597138302; Fri, 28 Jun 2024
 10:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com> <Zn7x6u7cedoFIHSi@google.com>
In-Reply-To: <Zn7x6u7cedoFIHSi@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jun 2024 10:52:06 -0700
Message-ID: <CAP-5=fXQ3nFZQRMTd+7wp2jEecRt2ykJ57oBO2=qqbnEeyQRvA@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Constify tool pointers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Jun 26, 2024 at 01:36:02PM -0700, Ian Rogers wrote:
> > struct perf_tool provides a set of function pointers that are called
> > through when processing perf data. To make filling the pointers less
> > cumbersome, if they are NULL perf_tools__fill_defaults will add
> > default do nothing implementations.
> >
> > This change refactors struct perf_tool to have an init function that
> > provides the default implementation. The special use of NULL and
> > perf_tools__fill_defaults are removed. As a consequence the tool
> > pointers can then all be made const, which better reflects the
> > behavior a particular perf command would expect of the tool and to
> > some extent can reduce the cognitive load on someone working on a
> > command.
>
> I thought you actually wanted to make the tool const (rodata) but it
> seems you leave it as is but treat it as const.

So I think that is a next step on top of these changes but it would
need something a bit special as we want to default initialize some
fields but then initialize others. Something like (which wouldn't
work):

.tool =3D DEFAULT_TOOL_STUBS({
               .sample         =3D process_sample_event,
               .fork           =3D perf_event__process_fork,
               .exit           =3D perf_event__process_exit,
               .comm           =3D perf_event__process_comm,
               .namespaces     =3D perf_event__process_namespaces,
               .mmap           =3D build_id__process_mmap,
               .mmap2          =3D build_id__process_mmap2,
               .itrace_start   =3D process_timestamp_boundary,
               .aux            =3D process_timestamp_boundary})

Being const is just saying hey all these event callbacks aren't going
to mutate the tool, something I wanted to rule out as part of a change
I'm working on.

> I'm curious if we can change the event delivery code something like:
>
>   if (tool->func)
>       tool->func(...);
>   else
>       stub_func(...);
>
> Then probably we don't need to touch the tool and make it const.
> Thoughts?

It works but the approach needs to change all tool func callers. I
think it is also more obvious as an API to have a default value and
override it, rather than giving special properties to NULL that
callers should adhere to - we're doing a kind of poor man's virtual
method dispatch and you wouldn't typically expect a NULL check as part
of that.

Thanks,
Ian

> Thanks,
> Namhyung

