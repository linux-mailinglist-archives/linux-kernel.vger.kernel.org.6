Return-Path: <linux-kernel+bounces-532047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1469A447E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B043E1892524
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0D5194A6B;
	Tue, 25 Feb 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGg6yrSf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549F18E34A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504012; cv=none; b=K+R+EOKb84baTRZBc4dtFUaNqyoAj37AKyRZgXOyl4XKWeUqOp3m4bWk1/tK+/Yhi6MFwIaniEjsx981VWD5Z78fXR18I4KeH/nQ/n0RmgiZpWYFYw9I3aGM397X7tkszMWaBgwFHB/Sk+0CUa8Oe8HJU55rcHUCJwd+FCEzc6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504012; c=relaxed/simple;
	bh=nYvvvyUkn/NQrJXuHQOgg478+Z6m4uibxctBKt7VFgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RP+WWIYbNubxosYxE9+K2hm1pJQH3OVhiGe6gs4K51UCK0D43PnLxTrm+oLiBlka3h5chr3X80hgYWBfx0n6LjXOaLuaLbRWiTaeeWHZmccc+G+i/ndvu2e/Ewl5Dbk7YUvxVmTSmugFdQydNQQ21rfyxIu8E3yFHpSs7wjsNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGg6yrSf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22117c396baso204955ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740504009; x=1741108809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hb3C7FYdDqsPYEBoq2vFVVUt+W47wHJYO2+QU2YKUI=;
        b=XGg6yrSf1XFnff7d1MLBOdtGFNlqkjY65nJ1acePMU+/LwJjxWjc7IQZ/pIpylvdng
         7Scl1WQECEZw5c8g5EzpASnVxwVSZUy0Y2cMr7yWYcFucGXk2XT2D8rGY5RauCJla2Dj
         F5waNjKbm8E0VGk2XTsPtkL0MVRx9RiXbuZ6dRsyA6tVa/TjIL+IbLfqQcg8sCUcdr3R
         6SYwvAKa4vJFtVsqlVGDicH3QZO+qQPf2Y7D6TTZ5t7uks+0qLDpgmclEo2tyP1qsFM9
         5qLSBAv19l9qUik8+i9krmpjfONavgGJG2a6ZzJXKeA2oyKFgCnk3Sfb30oj4SGLUAYj
         C/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504009; x=1741108809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hb3C7FYdDqsPYEBoq2vFVVUt+W47wHJYO2+QU2YKUI=;
        b=TjUDlgndCngFDc5O6blNUGtnLfvxNYdjHWJMcHBILVkzIXr5Filjt4UqFJPjck6ZCa
         Z/5ck3kG7qy9Ms0OWIAT6GOVSqkkzm+OSGep+UrLqY+q8LSv6Udmf5mdG+fDZF4BxYEE
         M8B5jrqFdKX1XRSNCTjHb3NYixdSPKtuImB98mU3bhe8WnXkfG8ZjpIL1MmzqboHgR37
         uDBwfKac7aW5KY6yTrg2VcaqKCIr+DBv1QtTmT56ZZ+Hbg0ObRxTFpRt8jjCiDstORyr
         Z3dl721qxpGgfKHy+vnGnjxXbnfsV9PIgWqcuJRl4JOVTLeoEu+/43Ux3awxu+bjRzE2
         j2ew==
X-Forwarded-Encrypted: i=1; AJvYcCWq81rPr8BeGc73e9d0rcNJyPQxJ2eQM9zE5q+dif4knm9aLuN9QoOAd+s6HLp0oXJX5bhZag7XLcCxwhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPHafW12W4bq02GD4BQpNiWtQYQQuyMhPDMAqW4+uLkI+AMEU
	DAMLidYNw2COKNpIheQyPkaygkXnokMtxjbwpf1FodmHCdSlm++FKo3C3RYGq88l+DY5qjbRNyf
	2hSS9pjLLhBlYmLbnY+lUnNXEwTL6O77PS9IU
X-Gm-Gg: ASbGncvebX4rTelotmsMRBD74636j3r9kjSP/Y/xTp6v53foPLWjCEmk9DrUI7cam88
	gCEuxB3zbo+vDFBkCF4d/S6tdjQJxD3fphQ0D87Bl83YwiyFxF1j54djglB6vaP1oGfMD20+/nF
	/ubdOS3iNu5pTORQYHK5O+AhZVCz1O66ylfXo=
X-Google-Smtp-Source: AGHT+IGpsu2gE6OHJh6wFHMikBC+V7A4sdMucnJSErx5tMIoel4ur2peTYL89qPCpXByYo8PvF55LuvZuIZemHPc5Wc=
X-Received: by 2002:a17:902:ce05:b0:21b:b3b3:ef5f with SMTP id
 d9443c01a7336-22307a973d5mr3609785ad.22.1740504008965; Tue, 25 Feb 2025
 09:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225164639.522741-1-james.clark@linaro.org> <20250225164639.522741-2-james.clark@linaro.org>
In-Reply-To: <20250225164639.522741-2-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Feb 2025 09:19:57 -0800
X-Gm-Features: AWEUYZnYh0D9XwWJZPJZL4jHRJTeBa1LnRgouzF4MQP99jNCAKe6CUlFHsXbSU8
Message-ID: <CAP-5=fW1NkeZjBpNijV1oKNjZ_F480wahmUPfEN9vrxYjwD=9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf pmu: Dynamically allocate tool PMU
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, cyy@cyyself.name, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:47=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> perf_pmus__destroy() treats all PMUs as allocated and free's them so we
> can't have any static PMUs that are added to the PMU lists. Fix it by
> allocating the tool PMU in the same way as the others. Current users of
> the tool PMU already use find_pmu() and not perf_pmus__tool_pmu(), so
> rename the function to add 'new' to avoid it being misused in the
> future.
>
> perf_pmus__fake_pmu() can remain as static as it's not added to the
> PMU lists.
>
> Fixes the following error:
>
>   $ perf bench internals pmu-scan
>
>   # Running 'internals/pmu-scan' benchmark:
>   Computing performance of sysfs PMU event scan for 100 times
>   munmap_chunk(): invalid pointer
>   Aborted (core dumped)
>
> Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PM=
U")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/pmus.c     |  2 +-
>  tools/perf/util/tool_pmu.c | 23 +++++++++++------------
>  tools/perf/util/tool_pmu.h |  2 +-
>  3 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 8a0a919415d4..c1815edaca37 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -268,7 +268,7 @@ static void pmu_read_sysfs(unsigned int to_read_types=
)
>
>         if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) !=3D 0 &&
>             (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) =3D=3D 0) {
> -               tool_pmu =3D perf_pmus__tool_pmu();
> +               tool_pmu =3D perf_pmus__new_tool_pmu();
>                 list_add_tail(&tool_pmu->list, &other_pmus);
>         }
>         if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) !=3D 0 &&
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index 3a68debe7143..45eae810b205 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -490,17 +490,16 @@ int evsel__tool_pmu_read(struct evsel *evsel, int c=
pu_map_idx, int thread)
>         return 0;
>  }
>
> -struct perf_pmu *perf_pmus__tool_pmu(void)
> +struct perf_pmu *perf_pmus__new_tool_pmu(void)
>  {
> -       static struct perf_pmu tool =3D {
> -               .name =3D "tool",
> -               .type =3D PERF_PMU_TYPE_TOOL,
> -               .aliases =3D LIST_HEAD_INIT(tool.aliases),
> -               .caps =3D LIST_HEAD_INIT(tool.caps),
> -               .format =3D LIST_HEAD_INIT(tool.format),
> -       };
> -       if (!tool.events_table)
> -               tool.events_table =3D find_core_events_table("common", "c=
ommon");
> -
> -       return &tool;
> +       struct perf_pmu *tool =3D zalloc(sizeof(struct perf_pmu));
> +
> +       tool->name =3D strdup("tool");
> +       tool->type =3D PERF_PMU_TYPE_TOOL;
> +       INIT_LIST_HEAD(&tool->aliases);
> +       INIT_LIST_HEAD(&tool->caps);
> +       INIT_LIST_HEAD(&tool->format);
> +       tool->events_table =3D find_core_events_table("common", "common")=
;
> +
> +       return tool;
>  }
> diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
> index a60184859080..268f05064d03 100644
> --- a/tools/perf/util/tool_pmu.h
> +++ b/tools/perf/util/tool_pmu.h
> @@ -51,6 +51,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
>                          int start_cpu_map_idx, int end_cpu_map_idx);
>  int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int threa=
d);
>
> -struct perf_pmu *perf_pmus__tool_pmu(void);
> +struct perf_pmu *perf_pmus__new_tool_pmu(void);

I think for consistency this should be "tool_pmu__new" although pmus
have odd function names like "lookup" which is basically "new". I was
trying to be smart by avoiding the allocation, but I also don't think
it matters and correct is more important. Thanks for doing this.

Reviewed-by: Ian Rogers <irogers@google.com>

Ian

>
>  #endif /* __TOOL_PMU_H */
> --
> 2.34.1
>

