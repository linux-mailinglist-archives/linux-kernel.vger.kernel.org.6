Return-Path: <linux-kernel+bounces-551642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04073A56F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB2A16DBF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1732405EC;
	Fri,  7 Mar 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiQdSgC/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4121ADD1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368748; cv=none; b=MYV2eoTHs9uS8bVZtQoMGd97V1zqo/fvQiVBrUov5IeR37r0kd1b4y6Va8nyT14WIefBmMF7t3H92e509Tfqe6itVD6ImG/7v/0Z8Ub8B4UMZ/GlEkVws/KF7CfKDWVoQw32U89Elx3UrI23h8WlW4A6BSapeOHP8A/FsE61+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368748; c=relaxed/simple;
	bh=8XxM+UXs6skvKubtvbBeE4dioGqAL/Wt21pSKFpxnL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muCUeNBa9C7ts65Jflt7Gb9afU15Aod4riIAwPN1UPOQDxVLxQO3N4Rud5m/ZjI1eEQrjwHAf1c+052mrmc7j6QNy5Hq7/SjfQKQtO0UCgWJo71fAT15mYDgYeuIZAOoVvuF/hhTfdTBTPmR3gx2pBeyP4Kab5F3kCcGlc8GzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiQdSgC/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223a0da61easo935ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741368746; x=1741973546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqIi3eUgcKuJONzezWaTQQ5R3JceKvZT0aW4EVwXeiM=;
        b=QiQdSgC/BFFJZH0A+udh9LIT8u2G0MiP9q2w2QeGgYhc19w3ClV29Pf2F/WBC0yb/f
         /HzzS6vqNXJL7psZdYIgPLoaqNogC7snE1OlXuTuGUaHVLT5hiNGzlR2dTQZY3M8UN2k
         OdVzP1XfR8xzLh6zy9sbMewdoxx3uU60tOkYzP9ef2s7CmcQ/y4hjSPbNNbZOlYRXSRf
         m74BB55HB7Gi3+KCoJMJXDi+sfq+SKa96lOoz4hiQPWem2AMhS5m0vBEPT5NdTt94DL8
         xRoxBe8mhmc4MzIfiMdlYNB1kAtGlomay9CMhtruyL5R7xchtWSOwaUR6yF5zEZNqZ5I
         rfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741368746; x=1741973546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqIi3eUgcKuJONzezWaTQQ5R3JceKvZT0aW4EVwXeiM=;
        b=cmWc9OL/qTJxt4sVz5Mafz0FQW59W+/Br31M7oFDKYUzSSEL9TnQ41xWISOm0ahEqr
         Uq1Yets4438FNUSS5qn1jORVBRAYryHO9arSN59LSdAciHSRIHhyGQs3ujzhZ+ZQkExs
         bWgs0/XWeOCvFZ8S7crCanHSMMz8wE5EfEL2CW3qp5n5p5ougFGqqQozCpqtiKb4Tq/W
         GYHPbEyiYqtXgRky17MBkRTv6H5NwwZ6oNEKDM4n9rV4LtocBh6s+1CGCHeh+s+5be4E
         yOhdn/+jfrPNMPtBMT9gDWxRH89v1nas1Zpv7QHZPEFKH7F9c/M3u83KffnGTdatA6By
         xtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtpItga1DohyfRu8mglWnPSkcDPL7j6wi6VDrzuiQAf60linNd6W0RO9RVhfTjV8Ddi9L6aAnKL1g9Ekg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy33lX3E2gssMhwACqDJ2kM3xaEFJhcjgnGFV23wTQFB7MsdC3O
	NF76gQdhjsIrReb8XFwW0MR6x55PQbzwccG1KEzFPnf6najXbG5yzDPS3XturHYtl8K9yjKJ3wl
	LXZXwlGmy18lGpOugcrMKhzndEfqHZCb0aj+p
X-Gm-Gg: ASbGncsi0DcF0GNpUI6moje4ucq7yaV19VlpT1GuXRC4g1TwulsKfFQOpvQK7/bv0cs
	tssBjQqJ6QK4FkZTta5I1+01Uuf3D0dABQguyEEMQMtM/pfX3kG1EJWO8UTDhZQHpGXatuNnAPS
	QbkKCl6W9jjvZfYfNpYV+NjK/Zfwc=
X-Google-Smtp-Source: AGHT+IFFpfCVIaBpSWKZFwIn7l+IfdxUPFNfLp51LskZyc/+m49bu6CbiATC948quvo165zd/aagrh0KZRAGge8PVew=
X-Received: by 2002:a17:902:ea08:b0:220:c905:689f with SMTP id
 d9443c01a7336-22434db57c2mr931045ad.25.1741368745951; Fri, 07 Mar 2025
 09:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307153448.250871-1-acme@kernel.org>
In-Reply-To: <20250307153448.250871-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Mar 2025 09:32:14 -0800
X-Gm-Features: AQ5f1Jpeu53Av8JRCHrL53sKmcp1rYJ23clcd_69KjyKT-K0q8opkRjRdH0x8-I
Message-ID: <CAP-5=fUHozmMFVCX1Sn+4gsSkXQicLqYWHLrN2DSJgAGdnd0gA@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] perf libunwind: Fixup conversion
 perf_sample->user_regs to a pointer
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Ingo Molnar <mingo@redhat.com>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Tavian Barnes <tavianator@tavianator.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:35=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional=
") misses
> the changes to a file, resulting in this problem:
>
>   $ make LIBUNWIND=3D1 -C tools/perf O=3D/tmp/build/perf-tools-next insta=
ll-bin
>   <SNIP>
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
>   <SNIP>
>   util/unwind-libunwind-local.c: In function =E2=80=98access_mem=E2=80=99=
:
>   util/unwind-libunwind-local.c:582:56: error: =E2=80=98ui->sample->user_=
regs=E2=80=99 is a pointer; did you mean to use =E2=80=98->=E2=80=99?
>     582 |         if (__write || !stack || !ui->sample->user_regs.regs) {
>         |                                                        ^
>         |                                                        ->
>   util/unwind-libunwind-local.c:587:38: error: passing argument 2 of =E2=
=80=98perf_reg_value=E2=80=99 from incompatible pointer type [-Wincompatibl=
e-pointer-types]
>     587 |         ret =3D perf_reg_value(&start, &ui->sample->user_regs,
>         |                                      ^~~~~~~~~~~~~~~~~~~~~~
>         |                                      |
>         |                                      struct regs_dump **
> <SNIP>
>   =E2=AC=A2 [acme@toolbox perf-tools-next]$ git bisect bad
>   dc6d2bc2d893a878e7b58578ff01b4738708deb4 is the first bad commit
>   commit dc6d2bc2d893a878e7b58578ff01b4738708deb4 (HEAD)
>   Author: Ian Rogers <irogers@google.com>
>   Date:   Mon Jan 13 11:43:45 2025 -0800
>
>       perf sample: Make user_regs and intr_regs optional
>
> Detected using:
>
>   make -C tools/perf build-test
>
> Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optio=
nal")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linux.dev>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tavian Barnes <tavianator@tavianator.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sorry for the breakage, thanks for fixing this!

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/unwind-libunwind-local.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/u=
nwind-libunwind-local.c
> index 16c2b03831f39afc..cc0e41f2c2f2ef10 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -579,12 +579,12 @@ static int access_mem(unw_addr_space_t __maybe_unus=
ed as,
>         int ret;
>
>         /* Don't support write, probably not needed. */
> -       if (__write || !stack || !ui->sample->user_regs.regs) {
> +       if (__write || !stack || !ui->sample->user_regs->regs) {
>                 *valp =3D 0;
>                 return 0;
>         }
>
> -       ret =3D perf_reg_value(&start, &ui->sample->user_regs,
> +       ret =3D perf_reg_value(&start, perf_sample__user_regs(ui->sample)=
,
>                              perf_arch_reg_sp(arch));
>         if (ret)
>                 return ret;
> @@ -628,7 +628,7 @@ static int access_reg(unw_addr_space_t __maybe_unused=
 as,
>                 return 0;
>         }
>
> -       if (!ui->sample->user_regs.regs) {
> +       if (!ui->sample->user_regs->regs) {
>                 *valp =3D 0;
>                 return 0;
>         }
> @@ -637,7 +637,7 @@ static int access_reg(unw_addr_space_t __maybe_unused=
 as,
>         if (id < 0)
>                 return -EINVAL;
>
> -       ret =3D perf_reg_value(&val, &ui->sample->user_regs, id);
> +       ret =3D perf_reg_value(&val, perf_sample__user_regs(ui->sample), =
id);
>         if (ret) {
>                 if (!ui->best_effort)
>                         pr_err("unwind: can't read reg %d\n", regnum);
> @@ -741,7 +741,7 @@ static int get_entries(struct unwind_info *ui, unwind=
_entry_cb_t cb,
>         unw_cursor_t c;
>         int ret, i =3D 0;
>
> -       ret =3D perf_reg_value(&val, &ui->sample->user_regs,
> +       ret =3D perf_reg_value(&val, perf_sample__user_regs(ui->sample),
>                              perf_arch_reg_ip(arch));
>         if (ret)
>                 return ret;
> @@ -808,7 +808,7 @@ static int _unwind__get_entries(unwind_entry_cb_t cb,=
 void *arg,
>                 .best_effort  =3D best_effort
>         };
>
> -       if (!data->user_regs.regs)
> +       if (!data->user_regs->regs)
>                 return -EINVAL;
>
>         if (max_stack <=3D 0)
> --
> 2.47.0
>

