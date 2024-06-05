Return-Path: <linux-kernel+bounces-202872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204038FD226
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD3281E34
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5D14BFAB;
	Wed,  5 Jun 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eX7mTPZC"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC82BCF4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602966; cv=none; b=K6Dcn+VTRSTVzvK0Pk1sKYSruoWmkhx+Fm0xbJk6l4L5Fdfu2jpWw6H1tj32KOhNeIzokBbtP39jxnrXbxasyLy2m3OT1oEZ3ShgFwWlWLt2ZtZQvyDjM830h1cma/1VNe0BDF7mPPibl0WrJNhLqSoHt+OzZtqCJIhiSCSVWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602966; c=relaxed/simple;
	bh=YYS8QGeRMThJRa40rT5kCbNOphhU4zs0eXwwEkUjwks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k52c1w4hv+W1ixWxmjBc3wdN/yZQkLfbRlFaygaSn9hu/dYJA80QQcVi2wPScsllFDAtxCnsWNqvSI3ETRX/cLLawUwZNChxXPMUAvFUA1A0xRE7v51mWcRjGV+hAntAN2DSJdjCLjrJvaHkTrFCYtHgJLe6zt4SrC337mWGW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eX7mTPZC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfe020675so395901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717602963; x=1718207763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btX61AmWCkAjCf2u5FJWL0PRbMFY2MMfWVQ+6vK0gD4=;
        b=eX7mTPZCLEk+SjiUv9yF44GY1EgAmYutpP0VLTxTm/XBuyNhyNUXXS/NQHyfObu5rQ
         /GbRJJORvBROOD9tBgwSnTrTV6+m3Qd7tjFx/vFG2P+ALDqIk7q8lpajAl5H2hMFluSk
         XUPfXkCXBZhFi+eoTMxgldNjSaaJW2fUso7jHizGcyCpbC6wDd6Bt8oO3VXxNEr0mzt3
         2V2MIcwMJU3BWj6O5mfi21Jp0XYgd4IQz348lFQbr1TYIwrSygIQSwR+sSX18KWLQmD6
         fqJYqavG0q+rhH4A29zGMTCif1izVuWG5ThCyu/SanPXKZQmUBg/ou2WFO4wbB06oH1b
         guCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602963; x=1718207763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btX61AmWCkAjCf2u5FJWL0PRbMFY2MMfWVQ+6vK0gD4=;
        b=XIQtL3kUCCCyRBAGNSJrzMyUAjcQ5ZSBH9+MFQH9r2fRJTw7bcfFBL60QVgpmJ8ZhT
         VjcraHuFQ8B0IjO63I4ania/9debRzIE4WX5+3sFdzbMpyVKRWKZpi+/bFtS0I0BNFWI
         FObqN/QmP3T4NKJyQTa3Y4E3fin3Eza8aUc6PK7EprbG8+/QhIY3sLGYBP/qsgg+s1ES
         6Yxuvk9Wz9intY0uRl+hVYLKyoZdX0pYD1EbPC3RqYdsskDAmUQMu42hZSON/WLPeDmU
         VaojCP++SffaZTmcm9cYUzzMZF/ZNz3swvTvp302Fbz+080KEFnsZ/xmrm6gJxANhsjZ
         2rJg==
X-Forwarded-Encrypted: i=1; AJvYcCWL+lyAPtS63N4CXXV8GZu/qRxi2EXnbnWhUZDQWCPqxfrtYV02HPnGhItcFojqzkPNFZsnVAYjOx0SkFOEyS802W7pWS6I4YJujCQQ
X-Gm-Message-State: AOJu0YyuBiN9+oDQho4FLImcDygGBStaU9whB1/yek4rIqWkalP/9amb
	1IaFvhgblwK+TEKukUgZMs8b+n5qnrPAjbNuXNLOEI0O9dxndFbwoy2OSAlTsLfnuDF5uCfRqHF
	Oijl16Gp4GcmzWAbqRph83jpzWJf5972OMSkM
X-Google-Smtp-Source: AGHT+IF2ituGclZUQVgZyjra1vetAEU5cqIpN/7SgKa+p4y3RiJpbtzwgqR3s1PICs8l9kRHLP9lqRhGy/Vxf0GGYCw=
X-Received: by 2002:a05:622a:418a:b0:43f:d9b6:a93d with SMTP id
 d75a77b69052e-4402b66cd50mr4385761cf.20.1717602963385; Wed, 05 Jun 2024
 08:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605140453.614862-1-clement.legoffic@foss.st.com>
In-Reply-To: <20240605140453.614862-1-clement.legoffic@foss.st.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 08:55:51 -0700
Message-ID: <CAP-5=fUW6UWw=0iRe+r4JxrxZ3Yqnpd0_ZhrQx0SidfRDf5YgA@mail.gmail.com>
Subject: Re: [RFC PATCH] perf: parse-events: Fix compilation error while
 defining DEBUG_PARSER
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:06=E2=80=AFAM Cl=C3=A9ment Le Goffic
<clement.legoffic@foss.st.com> wrote:
>
> Compiling perf tool with 'DEBUG_PARSER=3D1' leads to errors:
>
> $> make -C tools/perf PARSER_DEBUG=3D1 NO_LIBTRACEEVENT=3D1
> ...
>   CC      util/expr-flex.o
>   CC      util/expr.o
> util/parse-events.c:33:12: error: redundant redeclaration of =E2=80=98par=
se_events_debug=E2=80=99 [-Werror=3Dredundant-decls]
>    33 | extern int parse_events_debug;
>       |            ^~~~~~~~~~~~~~~~~~
> In file included from util/parse-events.c:18:
> util/parse-events-bison.h:43:12: note: previous declaration of =E2=80=98p=
arse_events_debug=E2=80=99 with type =E2=80=98int=E2=80=99
>    43 | extern int parse_events_debug;
>       |            ^~~~~~~~~~~~~~~~~~
> util/expr.c:27:12: error: redundant redeclaration of =E2=80=98expr_debug=
=E2=80=99 [-Werror=3Dredundant-decls]
>    27 | extern int expr_debug;
>       |            ^~~~~~~~~~
> In file included from util/expr.c:11:
> util/expr-bison.h:43:12: note: previous declaration of =E2=80=98expr_debu=
g=E2=80=99 with type =E2=80=98int=E2=80=99
>    43 | extern int expr_debug;
>       |            ^~~~~~~~~~
> cc-1: all warnings being treated as errors
>
> Remove extern declaration from the parse-envents.c file as there is a
> conflict with the ones generated using bison and yacc tools from the file
> parse-events.[ly].

I encounter the same problem and routinely just do a local change to
comment out the declaration. The definition comes from the original
patch adding debug support, Commit 82ba1f2f6148 ("perf tools: Add
support for displaying event parser debug info") and so I believe
older flex/yacc tools needed the declaration. I think the right thing
to do is to remove them.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Signed-off-by: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>
> ---
> I don't know how bison and yacc work together.
> To me if those symbols are already generated (I don't know how), we
> should get rid of them in the source file `parse-events.c`.
> For my knowledge, if someone has the explanation of how they are
> generated, I am interested as I didn't find any link to some part of
> parse-events.[yl] files.
>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: "Liang, Kan" <kan.liang@linux.intel.com>
> To: John Garry <john.g.garry@oracle.com>
> To: James Clark <james.clark@arm.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/util/expr.c         | 4 ----
>  tools/perf/util/parse-events.c | 3 ---
>  2 files changed, 7 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index b8875aac8f87..b2536a59c44e 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -25,10 +25,6 @@
>  #include <math.h>
>  #include "pmu.h"
>
> -#ifdef PARSER_DEBUG
> -extern int expr_debug;
> -#endif
> -
>  struct expr_id_data {
>         union {
>                 struct {
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 6ed0f9c5581d..8d5fb05f20c2 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -31,9 +31,6 @@
>
>  #define MAX_NAME_LEN 100
>
> -#ifdef PARSER_DEBUG
> -extern int parse_events_debug;
> -#endif
>  static int get_config_terms(const struct parse_events_terms *head_config=
,
>                             struct list_head *head_terms);
>  static int parse_events_terms__copy(const struct parse_events_terms *src=
,
>
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> --
> 2.34.1
>

