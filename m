Return-Path: <linux-kernel+bounces-389964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA49B73C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950202814D4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D84135A54;
	Thu, 31 Oct 2024 04:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+ohxmP4"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E811B95B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730348286; cv=none; b=crgQpAZIRwEG1mKgOWJTakCD0LOQQpG8Gznr69w79fMZRTHJvhUOwF0OwwrBTjhh4+6EtGBKrG2/aFoRICDK2qv5UfhlCALUGC0Zn26IPvFnBQJ8vh0hgRKfnuS6Ki+axOb0jIr/CoJvexEThB0kM4w9HbXD//qZixCF+daFzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730348286; c=relaxed/simple;
	bh=fTsV0Arf05s8ipgk8AIaMKQ3/ewrlFnnTjXlvrNkzSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsRMvXmVDXJYOdb3XjivpEdQSUKFPluKD4AQfeMx83i5l0xPen7iQvJbMNRB01XwAmYCN8DH9WojW3D/s7wW1jcwWuI7zWU52FR9po3hKXOEC/7ONS+Qye/lLd34E04NMd5O/b8yIqISSql0pESxV+d5Y+XqHPlzgMJxm+Ak2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+ohxmP4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so42035ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730348284; x=1730953084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdr3ttCC1d0Nzs/hMGVxxTIcSH4KN8n2mVPMAeK2k48=;
        b=G+ohxmP4WKlGRiS9M2GrcuzxKJ8i1PRFdyPs3MKPDuiBl2zSyPyGVVSexmjbT5KYvO
         CAc8NSdtWJTH0QQOQDj/E9UZJrgiH6rJKUPaMqFKq1hizOxqaYu8ibk1o6qx3k/aqjDu
         d9WPFF3Xs3wi54mdb1IftYU/KMM50Gy1+CDnWurD5oaUlghQlOUnfuFzc2K2diAmRZyc
         viihuAottSV5RxHQOLn6adezcnzR10EK/oUeVncEEBvhqMSlvKxGpi4bYUWrln9kYVrA
         mMWsKhN3+1U0hGx3tKDwKpfhte7Zlczba1e6e8y7P5PqqcGiHxOxmmDPSpWLnM7xhfQV
         RZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730348284; x=1730953084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdr3ttCC1d0Nzs/hMGVxxTIcSH4KN8n2mVPMAeK2k48=;
        b=F07mAiSE6K6DFmMsGv/+wuX0uXAvzTUugCzndRMocmIGN3nWag9Hcpnr3S1v8xic6R
         XlOv4JHrDorC6QyaXPRLYTZr1Ku5mt3mE2BTFbgaaSH4HJAvN02wrtwdoA7aT+GfnuSw
         eKo5rx7NLM8NBz9ywjZyqEc54lGn+6OwoeA/YD0WG8qMvD5Uq+uMjsZhU2egkMZBd8AC
         W3mOgIuU7ytaAlqTjCv8IiNqzIZvmfgOHH95TgJkdoJKRy2yhoFz6+vLuGvd84crN8FG
         VLP59MJgkYMe3jjr2Gwpxca0b7NFjlBbfF+7bRLGhEaB0Nd1Wg8CS5T2Fkd1AlZgDqiC
         MJQg==
X-Forwarded-Encrypted: i=1; AJvYcCV/d0xKmZmumm8SLpaaxo+NXKFqokrOH45WifFbNItIWnYp3X3l2Itmx+fl13VS9FzbGmg0+m8Uu6vTwkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxffwr2MzH/AgxKS/bmeq/PLqWAxiGu/YrjMlHiUJwJ+UAyHKY9
	6C2fyvRXplozzNLlZGwheCZxE95yrtqCpNYbiFc0Am0VGZ4AZB241sp4T7/KZQUuQMA1DPECP5p
	SSk0eu42nEJChv9OD2uag7yECiqXNf9ZaQLZ0
X-Gm-Gg: ASbGncsxL8ehCjqLA/z0HRN1tYUw7n41rAnFSXaIKuvOesmFAJAOBErezAjPCc1SJFJ
	eZz0eD155/UyO+fmTKbzgo6hO8p0a0KVx
X-Google-Smtp-Source: AGHT+IEwrxFNAf0lepdvSGEs2bsxhKvkMyAihkdfdeQcJc25/sLJ+asWr1d1F3cbpjuDCyizt+P0isZVi1H56joUzo8=
X-Received: by 2002:a05:6e02:1d97:b0:3a0:a224:eb2c with SMTP id
 e9e14a558f8ab-3a6a945307amr1291475ab.25.1730348283592; Wed, 30 Oct 2024
 21:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030113946.229361-1-james.clark@linaro.org> <20241030113946.229361-3-james.clark@linaro.org>
In-Reply-To: <20241030113946.229361-3-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Oct 2024 21:17:52 -0700
Message-ID: <CAP-5=fWO3B9HT3oQ_7qtd=pQBpcUK7VRtcpLoBbKkGsnaH1YRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf stat: Also hide metric-units from JSON when
 event didn't run
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:40=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> We decided to hide NULL metric-units rather than showing it as "(null)"
> when a dependent event for a metric doesn't exist. But on hybrid systems
> if the process doesn't hit a PMU you get an empty string metric unit
> instead. To make it consistent change all empty strings to NULL.
>
> Note that metric-threshold is already hidden in this case without this
> change.
>
> Where a process only runs on cpu_core and never hits cpu_atom:
> Before:
>  $ perf stat -j -- true
>  ...
>  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/bra=
nch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : =
"0.000000", "metric-unit" : ""}
>  {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branc=
h-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-valu=
e" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "g=
ood"}
>  ...
>
> After:
>  ...
>  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/bra=
nch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
>  {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branc=
h-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-valu=
e" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "g=
ood"}
>  ...
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index a5d72f4a515c..0e16eecfbad8 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -854,7 +854,8 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>
>         if (run =3D=3D 0 || ena =3D=3D 0 || counter->counts->scaled =3D=
=3D -1) {
>                 if (config->metric_only) {
> -                       pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", =
0);
> +                       pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=
=3D*/NULL,
> +                          /*unit=3D*/NULL, /*val=3D*/0);
>                         return;
>                 }
>
> @@ -909,7 +910,7 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>                         perf_stat__print_shadow_stats(config, counter, uv=
al, aggr_idx,
>                                                       &out, &config->metr=
ic_events);
>         } else {
> -               pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=3D*/NUL=
L, /*unit=3D*/"", /*val=3D*/0);
> +               pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=3D*/NUL=
L, /*unit=3D*/NULL, /*val=3D*/0);
>         }
>
>         if (!config->metric_only) {
> --
> 2.34.1
>

