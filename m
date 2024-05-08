Return-Path: <linux-kernel+bounces-173854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF76F8C067D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DC8282E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2F1327F0;
	Wed,  8 May 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7LissJW"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F513281A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204669; cv=none; b=h9uUGFx57QqHtbm+15FWXZcVhbZOOYTcPmluy2g1LqDbZMAx4OQRu7IRjKFYs3Grfl4dl+11n8otWD9Vh1ikCyBMMFJN6PaKTVXXqYHeUGg7Qaqw/5kgiMPp5Uo18ddku2Q8VNSFNh+N2D608qSZLX4MRz4GLvBmFHwnRzocx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204669; c=relaxed/simple;
	bh=+GqhfbCWo1/rL5WMUZWC0dKWAFYfQARQY4h2Wx1maBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUBWnscdOMG6ek2aU8CClRNTdL/N9H9g0dIcSq62LzYds9yMV6HV8qM06e6VE1mUucm1F3GeqYazoLC9gL/FZbR3PEbDTN0IgY6wftamEIUDLjAfwtfJxR7XrYIyYYme8kSGRBz3R1CRf5MEZLDucZ1ff3eaxWuiOKKhrCbKfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7LissJW; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43d55133609so39751cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715204660; x=1715809460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNz33LRukOuC2TAVQ91flMmJhD+luZs+qYkSeJGKPFs=;
        b=p7LissJW2l94uE6++IZCGBm5cIuf+2Bq4sm0wKUNlGmpgkbqmhxNs1ljG+MUK2nAH8
         /AtMnTiZ8GdU5CI4QFdNG1mCvk4zgPWtf7qqr4h+hEJUOjR0Arx/ZSATLskniHad657Y
         cbSZyTwuSt0lZu5cBMu/Kda8R/a5NjZsVbJ8R+gl8SkYv1+xGg0opaOJI2QL4TU6lmjk
         GCcewSBdfESwyJAOP1gUiUBpe7AS29Eicf49WWeFDIdlmN62DaZ+RHpk2ywWiP6YsHMn
         h1aWkI+GFhAeivGgkg/ZvZsIElSd8UyzzunHiZ6i5AkUHWgs4MpfkjS4O4Lg8YoLFAXi
         pwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204660; x=1715809460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNz33LRukOuC2TAVQ91flMmJhD+luZs+qYkSeJGKPFs=;
        b=qR+5JY3+aMDQLDEg+XVAZkWDmBAUtu3Hybh1SM26x0mX5dKa+q7+baf+DOBkn/iPyU
         HxNV62m4MFWyF7wrA2ihS3DgLPnatE8wnhp5xQ7sZ3utyX4FaWwC5SUZ+1FVXLRD5UoZ
         +BHeJ4dU6aSaDFf/QtQIcFwADqXEhX7OBXmPkXq+mJWoyDqHrvwZ7WYBw5Cwt8OTbXWY
         +cwcznc5pRvKGUAWF5+L1eF763X7ht6yNivbV31efjkjetkPI3ZsySTwnv8/eVmqVgTh
         4G2Dx7gxR3itd325S+VKBxz1vbAOHPvLUgoqccr3CZVxm/brM59BiVw2lK7QgVdIQZrs
         R6ug==
X-Forwarded-Encrypted: i=1; AJvYcCW21BgZ/KHwr3PLC2lS6oDYV2Qh6faKnIdMK+Ao6qeIYTf4yk1OHpepUj3MjbFY+3p75Z7kn3oJgEOacBo9s4HznzwRMzAbJV6hsVWO
X-Gm-Message-State: AOJu0Yy5V4JT7A5RvEcbVnbksgtGmoJ6PFuNP/Q+1029iwwCEUa32rJa
	qjMVwNnRNOjolOmX4NU4q6NxVXl2KEcJnb1hxQiYjxwsvBKwoVWUnDCZMpCRBBz7dzYAkFONNgs
	pzJ2wlv763S2cBCcMtJ1RDjXfiFxgEMg7BBl0
X-Google-Smtp-Source: AGHT+IG4V8Ro6H7VLFiSiWMxVSXvKP2tZ5kz1hDy9s6imtx4QHxTmnCi3+YTDPOrrDiAYIGEDIZLIhogA0rDgA99sXo=
X-Received: by 2002:ac8:6f1b:0:b0:43c:de95:6258 with SMTP id
 d75a77b69052e-43defba092bmr1278391cf.18.1715204659725; Wed, 08 May 2024
 14:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org> <20240505-perf_digit-v2-3-6ece307fdaad@codewreck.org>
In-Reply-To: <20240505-perf_digit-v2-3-6ece307fdaad@codewreck.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 14:44:08 -0700
Message-ID: <CAP-5=fWUm9X1_Yj_sqHQqCqfSpcrXsDggJRO+GN2jo=km-0bBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf parse: Allow names to start with digits
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:14=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Tracepoints can start with digits, although we don't have many of these:
>
> $ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
> net/mac802154/trace.h
> 53:TRACE_EVENT(802154_drv_return_int,
> ...
>
> net/ieee802154/trace.h
> 66:TRACE_EVENT(802154_rdev_add_virtual_intf,
> ...
>
> include/trace/events/9p.h
> 124:TRACE_EVENT(9p_client_req,
> ...
>
> Just allow names to start with digits too so e.g. perf trace -e '9p:*'
> works
>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 5 +++++
>  tools/perf/util/parse-events.l  | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index ef056e8740fe..6cf055dd5c09 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2280,6 +2280,11 @@ static const struct evlist_test test__events[] =3D=
 {
>                 .check =3D test__checkevent_breakpoint_2_events,
>                 /* 3 */
>         },
> +       {
> +               .name =3D "9p:9p_client_req",
> +               .check =3D test__checkevent_tracepoint,
> +               /* 4 */
> +       },
>  };
>
>  static const struct evlist_test test__events_pmu[] =3D {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index e86c45675e1d..c36f8dbf593a 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -158,8 +158,8 @@ event               [^,{}/]+
>  num_dec                [0-9]+
>  num_hex                0x[a-fA-F0-9]{1,16}
>  num_raw_hex    [a-fA-F0-9]{1,16}
> -name           [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
> -name_tag       [\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=3D]*[\']
> +name           [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
> +name_tag       [\'][a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=3D]*[\']
>  name_minus     [a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>  drv_cfg_term   [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*?\.:]+)?
>  /*
>
> --
> 2.44.0
>

