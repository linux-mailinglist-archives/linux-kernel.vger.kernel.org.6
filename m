Return-Path: <linux-kernel+bounces-273246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F0794666B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 02:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765751C2125F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1001C01;
	Sat,  3 Aug 2024 00:15:12 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515601876
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722644111; cv=none; b=Mv30Yb+QGpGfv94wed/PxbOuqcKQROEO2AGWpGVhuywYXE2Lww1uOtn84S0zjforMk4OQWXveg5OwKSHB3dQ1+VUfzU7dd+y/0VPk3Es+FEa2fkeeGAHxlK+Et6I1IHYgtJsRa8VLOd3e6XPQnkCDEipLoZdupIec9DuvWpg4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722644111; c=relaxed/simple;
	bh=8bpwOtRB39nncly1Wice35pq/nCFy7U3BQr8+Hao00g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCJoPaZGiLirUieVZo7WobgL50n3aTltdTS+Fisa8CnomVIqRUlEByvKfi+m+IdlnsDH9nNV1xCfk9HiI4rXXOgU1Tv4C0XvxTw+pnXhq0BNzSqussWqm1ArH74hN/FF+ORRnYZqw9Kk6PDAtL3dbLW4XZv6L4wPlwXVohvtEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so2547705a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 17:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722644108; x=1723248908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZOxMqosNtbwa+ZU+9x9fNyuXgpVH+BkoQbPjKYodUY=;
        b=OA/18+Jr7qKdvzYcf4MH7d6T3QoNnDF9l0wTdfgKUIZqCP6rTPkqaJf/5nRimpw8ca
         1NddgCIjfzCkQ0eJVLDahI132buWHO9ZiTNV5Vpyyeo04eNu+ulOmcCUZes5KAGoD/PR
         QykpE8lWh23bfsHLUvvd2S+z82HsrYKnpLign2t9DyyclUdyJXgy+Fwxm1LbWDzYA8BT
         xg3bSFT/bL2QE4yhbkD/ZpnTw+wQFbNB1FcvCPHAVvlje2pYimVGvw3csRhNJiLT62fI
         NHLsoLuXxPz1nQ42OQxU2hrZj6b15ftACy5+u2uXx9rab53bwVGHUhKiMx65hHffkkDs
         Ht5A==
X-Forwarded-Encrypted: i=1; AJvYcCVEmxD4X+4LUQ0srF3yEOJ1Hb02BoQtb+aXsgDTNurBqfmjftmzFvmBlGkJVvV1pxfDqSgDp1VFgfMoqf0oVZhSD4XewKD+p8lXzcMy
X-Gm-Message-State: AOJu0Ywy4lo3p6deKWXQpgKe8hYq5uIw1ZVphmbRlSbd97h4Gj709Pgs
	OrUK7Volp+0N61iHMIogZxNxIGLtNNtjXn2mPo5PIa6LJl7+DkL2zIZMPEtDKVxbDs0+OLN0n3k
	Vb6PQwq60eN5AgFd4yf8QEQRBh4bq6LG0
X-Google-Smtp-Source: AGHT+IHlTebjT3e8lr4+TwlUHBUngcCtkCCb81qQuNCM57Sn3X7UMRzCK0xVfNW7wR2edjnmkL3oqwoF09RZ7QqK0cc=
X-Received: by 2002:a17:90b:1c0e:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2cffa2bc641mr8040534a91.20.1722644108047; Fri, 02 Aug 2024
 17:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703200356.852727-1-kan.liang@linux.intel.com> <20240703200356.852727-6-kan.liang@linux.intel.com>
In-Reply-To: <20240703200356.852727-6-kan.liang@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Aug 2024 17:14:56 -0700
Message-ID: <CAM9d7ciC54X5dth=6uziMS8kKHu=wfZFX8j_et3Gzvgeq3M-cw@mail.gmail.com>
Subject: Re: [PATCH 5/9] perf evsel: Assign abbr name for the branch counter events
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:03=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> There could be several branch counter events. If perf tool output the
> result via the format "event name + a number", the line could be very
> long and hard to read.
>
> An abbreviation is introduced to replace the full event name in the
> display. The abbreviation starts from 'A' to 'Z9', which can support
> up to 286 events. The same abbreviation will be assigned if the same
> events are found in the evlist. The next patch will utilize the
> abbreviation name to show the branch counter events in the output.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/evlist.c | 53 +++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h  |  4 +++
>  2 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 6f5311d01a14..028169dcb53d 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -33,6 +33,7 @@
>  #include "util/bpf-filter.h"
>  #include "util/stat.h"
>  #include "util/util.h"
> +#include "util/env.h"
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sched.h>
> @@ -1262,15 +1263,65 @@ u64 evlist__combined_branch_type(struct evlist *e=
vlist)
>         return branch_type;
>  }
>
> +static struct evsel *
> +evlist__find_dup_event_from_prev(struct evlist *evlist, struct evsel *ev=
ent)
> +{
> +       struct evsel *pos;
> +
> +       evlist__for_each_entry(evlist, pos) {
> +               if (event =3D=3D pos)
> +                       break;
> +               if ((pos->core.attr.branch_sample_type & PERF_SAMPLE_BRAN=
CH_COUNTERS) &&
> +                   !strcmp(pos->name, event->name))
> +                       return pos;
> +       }
> +       return NULL;
> +}
> +
> +#define MAX_NR_ABBR_NAME       (26 * 11)
> +
> +/*
> + * The abbr name is from A to Z9. If the number of event
> + * which requires the branch counter > MAX_NR_ABBR_NAME,
> + * return NA.
> + */
> +static char *evlist__new_abbr_name(void)
> +{
> +       static int idx;
> +       char str[3];
> +       int i =3D idx / 26;
> +
> +       if (idx >=3D MAX_NR_ABBR_NAME)
> +               return strdup("NA");
> +
> +       str[0] =3D 'A' + (idx % 26);
> +
> +       if (!i)
> +               str[1] =3D '\0';
> +       else {
> +               str[1] =3D '0' + i - 1;
> +               str[2] =3D '\0';
> +       }
> +
> +       idx++;
> +       return strdup(str);
> +}
> +
>  void evlist__update_br_cntr(struct evlist *evlist)
>  {
> -       struct evsel *evsel;
> +       struct evsel *evsel, *dup;
>         int i =3D 0;
>
>         evlist__for_each_entry(evlist, evsel) {
>                 if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRA=
NCH_COUNTERS) {
>                         evsel->br_cntr_idx =3D i++;
>                         evsel__leader(evsel)->br_cntr_nr++;
> +
> +                       dup =3D evlist__find_dup_event_from_prev(evlist, =
evsel);
> +                       if (dup)
> +                               evsel->abbr_name =3D strdup(dup->abbr_nam=
e);
> +                       else
> +                               evsel->abbr_name =3D evlist__new_abbr_nam=
e();
>                 }
>         }
>         evlist->nr_br_cntr =3D i;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a733d3407b35..bf37442002aa 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -152,9 +152,13 @@ struct evsel {
>          * br_cntr_idx: The idx of the branch counter event in the evlist
>          * br_cntr_nr:  The number of the branch counter event in the gro=
up
>          *              (Only available for the leader event)
> +        * abbr_name:   The abbreviation name assigned to an event which =
is
> +        *              logged by the branch counter.
>          */
>         int                     br_cntr_idx;
>         int                     br_cntr_nr;
> +       char                    *abbr_name;

I think it's better to have an array (of 4 characters?) instead of a
pointer as it's supposed to be a short string.

Thanks,
Namhyung

> +
>         /*
>          * bpf_counter_ops serves two use cases:
>          *   1. perf-stat -b          counting events used byBPF programs
> --
> 2.38.1
>

