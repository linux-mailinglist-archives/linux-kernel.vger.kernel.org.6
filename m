Return-Path: <linux-kernel+bounces-202969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333B8FD3DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A081D1C23A84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703513A250;
	Wed,  5 Jun 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBhdOLxt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BF2770E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608086; cv=none; b=Tu3+CB+gltaLrdcF8XnA3pO2YQtvZLs3RgsQ9c1wMwUOh9sDpOK9fPtVhGmpppjH+n8CA5urEqyJDadYZpmuM18pjh9o3NJ2nxTJ+mf0HwwAP9/9ebt0n8hS+hZnIwujhKoMBCCX1I/8EufJuSwAJj6VXGbbFmR8zTrk3/3/kHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608086; c=relaxed/simple;
	bh=Tcwq5dn9T53VXyu2UVdw5TjGv2V1CJsT9RFq6hlk9QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Boi8sj6sMgzZfhBJb3UQW7vEm5X1oJs/4FZkHPZDFd+kn/9YZCRNqTaVtHHMisr6HwNt+0NpID6o0dX9Edui4pvG+OodwtmK1DA3QRB0RVT8XrmJH3FCYeI8U5Fr54gzVPynUjG6PlumBZiNBfCQzCU+aj5b5UglZ3PVsguuNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBhdOLxt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee5f3123d8so5965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717608083; x=1718212883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYCo0S4v9XF6m0fRGRV3IsBGozW86ded8JzpR7EngjU=;
        b=nBhdOLxtqLb/6IDbSQ7cbc5oFvALnCWkUFIjJpsMkQMjQOE7dXBUGCuCe0F70vOJTp
         zhzuMjL9el0GaUd0i1WJEHri3+EanWtrRKxyHidjzQ/6xr2O0L2TViyOyN0qBsugfwTj
         s7BOzVznQsc5gt6LIzggVG1PffrMGNOJQJA7unbUKbvQDovJqfLwcqst9FQsGz+3PSfe
         TLQYIoltUHGQjUYDr/ayFtWklpnSuTK6pSXJNMna13LdoLTI7TJ2Yw72OMKZym5NiaFL
         lh0TjaY3qEEj8VMMdZZwvnfvJTPGh3hKLdiDydhLBno8R8tW+5J4LyVpNlx4xBPGKOOW
         /YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608083; x=1718212883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYCo0S4v9XF6m0fRGRV3IsBGozW86ded8JzpR7EngjU=;
        b=TsXglhq5nCB/JFI9WLAClvBaUAAAegfhxCq/vN9AMOMyji4Crxb9Ll0cyhITfkH4Zt
         2dXZTV045S9VsnG+XfJYQ9HpujOkHVk5oxRwXc4Llbaus9LtkXSMWKDQtCz9IuJGf3TH
         5ujdBDh4y6WzzVF1Q9VI9438oZz5m6h49MRI3WFgiL/l6QrQd91nny7ur8efSp6kCrqO
         ZM4LLAg33ByVhGQe9pCP9I1pcS4fl4+ojUC4m2hvmSiFVE/bGH3rIlSYra6+sjVP3WG4
         DSCSgQqlORBI8fCvRA+cOoiWbE3+VpWmJqxjlVWikeEcDwCziW3dRWBVeYEOkzIR+7xP
         Rhcg==
X-Forwarded-Encrypted: i=1; AJvYcCVenVpZkHA9HKZ9RUs/mL+qBCTMbjyKcZv/Y8JQ4yZ5usRj26efpItcs2ABEPWEajHdwC1wVr6jZQ+FV+buGUgvVkl7xU1J+wmAHBKj
X-Gm-Message-State: AOJu0YxZcmQE5O63GX0uIqoytEqG0nP961KHkRw6S932kdFE90PjCx3Y
	7k1M2+YnsTvGBDFARXIiVLgCK5GkIfxPOf0YSnJDjnAl2kRyuTFxKODXI9NT1+A0YvNOfn7cBk6
	YxVhiTXWiVwwY7r1hzxE3LZjvAq86oTBy/qBz
X-Google-Smtp-Source: AGHT+IE2SZkPszq0YruXeZgdwMZcRiyinGSYCRMCQ+02rAZyYrQw99myRkawq4RdPGWs6JBjFpE5FIBN0Whl5kn7mus=
X-Received: by 2002:a17:902:ee8a:b0:1f6:5bba:8ea3 with SMTP id
 d9443c01a7336-1f6a7b01893mr3570835ad.25.1717608083107; Wed, 05 Jun 2024
 10:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605160848.4116061-1-kan.liang@linux.intel.com>
In-Reply-To: <20240605160848.4116061-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 10:21:10 -0700
Message-ID: <CAP-5=fV+-ytA2st17Ar-jQ5xYqrWtxnF2TcADKrC5WoPyKz4wQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix the hard-coded metrics calculation on the hybrid
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Khalil, Amiri" <amiri.khalil@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:10=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The hard-coded metrics is wrongly calculated on the hybrid machine.
>
> $ perf stat -e cycles,instructions -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>         18,205,487      cpu_atom/cycles/
>          9,733,603      cpu_core/cycles/
>          9,423,111      cpu_atom/instructions/     #  0.52  insn per cycl=
e
>          4,268,965      cpu_core/instructions/     #  0.23  insn per cycl=
e
>
> The insn per cycle for cpu_core should be 4,268,965 / 9,733,603 =3D 0.44.
>
> When finding the metric events, the find_stat() doesn't take the PMU
> type into account. The cpu_atom/cycles/ is wrongly used to calculate
> the IPC of the cpu_core.
>
> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
> Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Cc: stable@vger.kernel.org
> ---
>  tools/perf/util/stat-shadow.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..4d0edc061f1a 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -176,6 +176,10 @@ static double find_stat(const struct evsel *evsel, i=
nt aggr_idx, enum stat_type
>                 if (type !=3D evsel__stat_type(cur))
>                         continue;
>
> +               /* Ignore if not the PMU we're looking for. */
> +               if (evsel->pmu !=3D cur->pmu)
> +                       continue;
> +
>                 aggr =3D &cur->stats->aggr[aggr_idx];
>                 if (type =3D=3D STAT_NSECS)
>                         return aggr->counts.val;
> --
> 2.35.1
>

