Return-Path: <linux-kernel+bounces-555289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300E0A5B356
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06EA3AB944
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE11C69D;
	Tue, 11 Mar 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6Sf/XFL"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61917991
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652941; cv=none; b=Tapk6WVcrhgewhaENd0fIsJj08k9A0NMwftgtLZAsxWJsMGwjwL4i4JgW0b18L6uuPTQUt5cn/zzM+RqYONDPylc3MZb7QnGcxIoAnrBSrT6rDhLFaB0P2U8XahE5V36aL54yCwqi44VwI1gXgoUqDLcAvu7yYp6iqeM0uwV0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652941; c=relaxed/simple;
	bh=H7jZ8AJWpuYWzp+yJpA8zo+LB4yon8C+Vs0avmU6EPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm9FOlr8HVe+NF3xfqBGAm6Fnpc3sYpKipLInOeBo/Vrvbb7EEawG1sw3mvS8QnDAZ9a2x5WxqaKS7LpW7MAN/bfX+fVySCr27CkRwbjjf0mG2E2vnTO9q0cjmKZkQsuZBGiuMqa3rTh9uuUbLq0cfinnmfwL71a5qi5s4Zxe7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6Sf/XFL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso35555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741652939; x=1742257739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UABuFrQuI44iACwIy3HnqNxQ3GKqEJj4Y7sE4lcn2r4=;
        b=m6Sf/XFLAKPAYy1UzTiQSR8adN0d2pYU9h1HDB8BVv50cfuXpoAhtW2o0e3Rf7KjDV
         88B8m2f3wQQGCjQ/aWdkcuJaxewb/7ayBbOm+JotKefzS6oPv+C/geu99ZoyrPHsF9kx
         Nro29Kzqleo4hm+atr4c/GPI/UlEv0bqq8DKjoxUOiT9x0P45pOuJCQkec7Z/VmMiWUP
         5k4g6/Nzy/hGm3x8shz5dSnl+GaRiQms+OGzJ0/119YIZAVmRfrFRj8CpI0pNL5KmK6X
         8TuAPmuJXHEeBEkpesJro2FiNWLCbTA9fct+QTcs+22HxILv/Ap9rciIyYhM6XesbbKd
         QM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652939; x=1742257739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UABuFrQuI44iACwIy3HnqNxQ3GKqEJj4Y7sE4lcn2r4=;
        b=RhIWpNKhoPMx/oA0T3VIW3tV3vRIZVs4CVH3JFo/AoWkE0Fbf6z6PES8KKjVzsboJn
         awvPZ9HbGRu1UoIWO5qX5wqPmyLI/Ta9dMkXt27Pd97Jz7qg9ZGZUCiwvgHayZlKfa3/
         6fjHwdclsoXmkbf5/IYzzONnuBwam2CEXgzvkBknaFOkaKfPns4EeSPHhcGYYOjKEbJ/
         vE8VGGbVqf2W4LIQMuKTMvvQbZ7WOxlODIPMNJq8kUO+3YAF+47fOsHhZVFxxCpMDXB/
         rdh3Ml+1YKryEz4+Sx5vx0nMCd1Nx+f1vcDlk1PMv7dVs1XLfbDVAB+xb3xqZGV2vM3f
         3CBg==
X-Forwarded-Encrypted: i=1; AJvYcCVxpWx1g92dJ0Asqb2jyvXqcVIYgH71NT5Bkd5splFD26zaND8xStLOEcM24jjwNzemHVt/unT0qOU9fTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6neTkgUDCr25CyiuopU2ZuuKdYfRwtZMk4xn+4y3ZsChd+i+o
	PSAEDV77hcbYFkMqT2MsD5llLfQa0kN7sj84EmoAt3vCO4lzOrA+AFQHAuBIIzqiXA+k2TCddYn
	UItJmK1s0mhtO+3sb3PAs+cnh2+dpov0WVqjl
X-Gm-Gg: ASbGncsvxQy+cDJCoY+kAXRoDgOfSyHD/QR/v6SW1LG6pKQVjJ4m7kfu/AIZrH38QbT
	3DNGUn6/BUxNAdhVCJRemzDS7L/VnSEbbGDNYgthQCCBT9CiNfBavXdh++qWTYO9wpTxhGO8vRe
	/XutrRzp6sXzMf6aEG+mfAx4Cw/BI=
X-Google-Smtp-Source: AGHT+IGZFYC9l0qSMoTNOCNTKIWeDhgcqZC3Ph7NAr2gIW3VS6y0oQX5vid8Fwv244/bp66pOd+Sbl+r4VXrIV9rhcc=
X-Received: by 2002:a17:902:d4c6:b0:21b:b3c4:7e0a with SMTP id
 d9443c01a7336-225477f2f60mr5635095ad.13.1741652939394; Mon, 10 Mar 2025
 17:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com> <20250228222308.626803-7-irogers@google.com>
 <Z89jxAMEpYea9Qom@google.com>
In-Reply-To: <Z89jxAMEpYea9Qom@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Mar 2025 17:28:48 -0700
X-Gm-Features: AQ5f1JpMTIqotVW_qaSlsLG95MiiipTuuoYyviXscstDHkVRcjpAY_dd3vnQQAc
Message-ID: <CAP-5=fXniy+Ye=xYdGzr4NKMjh=zQpgZuL=X3Y4DC6ATM5t5Pw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] perf python: Add optional cpus and threads
 arguments to parse_events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 28, 2025 at 02:23:03PM -0800, Ian Rogers wrote:
> > Used for the evlist initialization.
> >
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/python.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index b600b6379b4e..4a3015e7dc83 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1339,12 +1339,18 @@ static PyObject *pyrf__parse_events(PyObject *s=
elf, PyObject *args)
> >       struct evlist evlist =3D {};
> >       struct parse_events_error err;
> >       PyObject *result;
> > +     PyObject *pcpus =3D NULL, *pthreads =3D NULL;
> > +     struct perf_cpu_map *cpus;
> > +     struct perf_thread_map *threads;
> >
> > -     if (!PyArg_ParseTuple(args, "s", &input))
> > +     if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
> >               return NULL;
> >
> > +     threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->thre=
ads : NULL;
> > +     cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
>
> I wonder if it needs any type checks before accessing them.

Agreed. We don't do it yet elsewhere:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n769
although there keywords potentially avoid ambiguity. Given this I
think improving the typing is follow up work.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> >       parse_events_error__init(&err);
> > -     evlist__init(&evlist, NULL, NULL);
> > +     evlist__init(&evlist, cpus, threads);
> >       if (parse_events(&evlist, input, &err)) {
> >               parse_events_error__print(&err, input);
> >               PyErr_SetFromErrno(PyExc_OSError);
> > --
> > 2.48.1.711.g2feabab25a-goog
> >

