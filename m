Return-Path: <linux-kernel+bounces-346432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B598C4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CF21F25742
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393F1CBE88;
	Tue,  1 Oct 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uet9Q78X"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095671CBE96
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804531; cv=none; b=U7XjJXDyovJFDlaYgesYe2hw1b7kSwrdgnEBytAeskOSPgW25qFn8ePOepzsU8Wa52a5y0y+b1KbyJR3OUAvz7cJVZOIOCi96A5s23uI0wI72Blgabz3H2nInfSfIWZeK6mGhgHPTF9EgsWjSRsfOjDXpqUZEQr2Qm6KxGPpid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804531; c=relaxed/simple;
	bh=zW5KV8ZRwmjfWWswWoMCjQ0afxU/ksOKQ/4mdv7ZxL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/QdA5tziCYBdF43vVWl5ZHUXw8EMit5zzVebMYPD/Bo6B4I33/AdvZEuDV7p+iF6tBl6fCeYsVB5O4+p2Z6ZVjY97a3O+PFUzVB+Lqt3owFFqecX9fwZXvU6ARfERH8WBnbYs/jOz/BRuFIgedlkHtaGiu8GVfgJhZOyO6ZYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uet9Q78X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b061b7299so13135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727804529; x=1728409329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jj30EJtZ5WxgXrHQ/WJ4/hPDyRIandsUeefNdO7SQM=;
        b=Uet9Q78XH6uwA4otzfbP8/+fyrfNFQ8uR9x3HFR5PpEPnplH5yNmJIs3Ni5zD1MI3X
         mYbNf4mfNj5qxo9Rc4yyo0MA1kXVho2qwbUok9W9vpcJSjnbyTQvT268Z1HsOS5D4HhC
         KKFOtpE/yh8uwSwwJlY8G30vWO0X1Z+XO6X5GjgS1tO0WaiQPNM2rsVgEXme+eT8eWdh
         M0OFhaH5WiocQoHG9JLJmo9JIZ7mDYi/kxJ+hOUqwbuXU9qPpOHHKXMgtkSjcxmJvlLv
         P8zGVEs0TBPS1iISKyMMP8cPZ+DvcjYbLEaSKxt6C3PrNmNhXz+F7jLc93b9CUvCtrx+
         xCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804529; x=1728409329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Jj30EJtZ5WxgXrHQ/WJ4/hPDyRIandsUeefNdO7SQM=;
        b=ITUVciVhtzE7LpiwDWGSx6DK39X1hlzzvZzcoZJfRKezhOyR+Ulf+6YvZTcVAvdQqw
         MIX8y0MsCAF9wzNXL9XjZPvi6tEgXS3a3N4GL9ayFlcHgND7QJXbSnGvgJIVEaV/Iegi
         pUSCe63nPXd5R1AP8kivP240uA/X64yrfHyyFVHXkUg9+5GeQEE4wr1X8sVIGsRx+lDw
         YQSdyYImkEJTG/Dt2+ob0b/XSMLB0D2sTBcwpz3tI8JVrn2OvJYx49Zjx8/j2HvbFvX5
         7cutBc6ARdAHQlVERPpYqVa83PZJiLZfgDAuuAjkG1yrZNdkSCkC5eKUBsL9843PJR5K
         XZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWMreEXXjuJ7x+lLtj1Jw3IgCAj2ZyiO82+RBBxolTRNvZFQrfavyh9nRCDs+Ui6IYXwa4GWIXITX1WBP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUy12OMnol/pasl0eRn6l/d7Xc1zPgwlvuNauRFIvNMmZJxJTN
	N4jAuZx4kQiy8PcKP5v6hI68IvCey3Q5aZ/2cmw4fykN1FQhD6wePVvZGI5ZZY1LE8ndH6FxuvO
	6sBv3BlmdaBHJTO9Eth2zs6OlsfjWiPo7XqCQ
X-Google-Smtp-Source: AGHT+IG5ORqB0lYAZbuxHAuQKXbl7IkWQxu+L+QOqPVZTLw7LHJWx3rPs3pXlvXyhp4JfYFYA3h2SoddLOPJm+tCf+Q=
X-Received: by 2002:a17:903:120d:b0:20b:81bb:4a81 with SMTP id
 d9443c01a7336-20bb07eb0d9mr2916195ad.7.1727804528347; Tue, 01 Oct 2024
 10:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-2-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 10:41:54 -0700
Message-ID: <CAP-5=fXiaHAEGc4GsBXQBPjKsQnj4iT5eod6nY1_Qw1gHMhi4Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf tools: Add fallback for exclude_guest
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Commit 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> changed to parse "cycles:P" event instead of creating a new cycles
> event for perf record.  But it also changed the way how modifiers are
> handled so it doesn't set the exclude_guest bit by default.
>
> It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
> if not.  Let's add a fallback so that it can work with default events.
>
> Fixes: 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 18 +++++++++++++++---
>  tools/perf/util/evsel.c   | 21 +++++++++++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 1521b6df26065ccf..fd9ea15f6b1c0809 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -639,8 +639,7 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>          * (behavior changed with commit b0a873e).
>          */
>         if (errno =3D=3D EINVAL || errno =3D=3D ENOSYS ||
> -           errno =3D=3D ENOENT || errno =3D=3D EOPNOTSUPP ||
> -           errno =3D=3D ENXIO) {
> +           errno =3D=3D ENOENT || errno =3D=3D ENXIO) {
>                 if (verbose > 0)
>                         ui__warning("%s event is not supported by the ker=
nel.\n",
>                                     evsel__name(counter));
> @@ -658,7 +657,7 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>                 if (verbose > 0)
>                         ui__warning("%s\n", msg);
>                 return COUNTER_RETRY;
> -       } else if (target__has_per_thread(&target) &&
> +       } else if (target__has_per_thread(&target) && errno !=3D EOPNOTSU=
PP &&
>                    evsel_list->core.threads &&
>                    evsel_list->core.threads->err_thread !=3D -1) {
>                 /*
> @@ -679,6 +678,19 @@ static enum counter_recovery stat_handle_error(struc=
t evsel *counter)
>                 return COUNTER_SKIP;
>         }
>
> +       if (errno =3D=3D EOPNOTSUPP) {
> +               if (verbose > 0) {
> +                       ui__warning("%s event is not supported by the ker=
nel.\n",
> +                                   evsel__name(counter));
> +               }
> +               counter->supported =3D false;
> +               counter->errored =3D true;
> +
> +               if ((evsel__leader(counter) !=3D counter) ||
> +                   !(counter->core.leader->nr_members > 1))
> +                       return COUNTER_SKIP;
> +       }
> +
>         evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
>         ui__error("%s\n", msg);
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index da0bada62140d9b0..0ddd77c139e89a2e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3259,6 +3259,27 @@ bool evsel__fallback(struct evsel *evsel, struct t=
arget *target, int err,
>                 evsel->core.attr.exclude_kernel =3D 1;
>                 evsel->core.attr.exclude_hv     =3D 1;
>
> +               return true;
> +       } else if (err =3D=3D EOPNOTSUPP && !evsel->core.attr.exclude_gue=
st &&
> +                  !evsel->exclude_GH) {
> +               const char *name =3D evsel__name(evsel);
> +               char *new_name;
> +               const char *sep =3D ":";
> +
> +               /* Is there already the separator in the name. */
> +               if (strchr(name, '/') ||
> +                   (strchr(name, ':') && !evsel->is_libpfm_event))
> +                       sep =3D "";
> +
> +               if (asprintf(&new_name, "%s%sH", name, sep) < 0)
> +                       return false;
> +
> +               free(evsel->name);
> +               evsel->name =3D new_name;
> +               /* Apple M1 requires exclude_guest */
> +               scnprintf(msg, msgsize, "trying to fall back to excluding=
 guest samples");
> +               evsel->core.attr.exclude_guest =3D 1;
> +
>                 return true;
>         }
>
> --
> 2.46.1.824.gd892dcdcdd-goog
>

