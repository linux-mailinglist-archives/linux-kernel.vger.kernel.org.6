Return-Path: <linux-kernel+bounces-404456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328E9C43E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB1D2821F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4D1AB6FC;
	Mon, 11 Nov 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZZcG0L9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE831AB6C8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346848; cv=none; b=b8PIMf8oZgkHqd0wrgt4V7uXPlQ80AvIxB1i5p16slcHTdFKEFOMxDV9fKtdPfc90mMe4I6hq0EDCm+6Wu458eRE8s4/8rBzys13NVmAIeZD1Ay2emEBYNY9ur1vQqanShbjM7xe3YyIrbaM/3NZDMwc/rXFgMWykW2HHG1Q+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346848; c=relaxed/simple;
	bh=9mFrNoW93/rX0XAeqSLwO5oHi/lHzq36cxBpxa6J2JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnfpDGvGJ5DOgE4GMNrZC/Kng3Mk12M+ze475FaQzo0GNWAjROVwXgWNQxEi6FhLviZDaYg7ehNWShiqbW6L2wfeFfFBGSkZxiy2Lc3XILEI6CClbgTheo/0NPqEQ6TY0nJ8HNjbiHGuaLKGKGaMMbbgKHQgTwe4txsSM1Jiqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZZcG0L9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c87b0332cso339015ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346846; x=1731951646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HXhfLBhO3coI1dHk269DsGEIZcTKNlot53AmZg4T9M=;
        b=GZZcG0L9euxbtZOpSQ7EOi0tbFL5YEV58cpicx2HtSNqNrrzccH1fZ+JfHwen6CdOB
         YpPoVQSKRTWvOt3lqo7hfUf1tBZbKm4K0HFMPNubUtzgwq5MeY0046l5ILcbh0k/vyGg
         lzoQg2p4kZRKUuCSRju7+cwltniXty0mAnuUDdeWplY6Be1kIrWHGBGZ+okRAZ/z9Zxn
         SnBWaGyEmYTbAeCFDdC17mbfLKDpuZ+hBAEyN8yg1/8ppNbBxCzkEGeK2Lj4deI6kRkw
         D5/KeXbVU7VARjVTh/10aeI1sZoUQuckn7N7zk65y2QDwn+DOWZwJes1illnKnQyqZ+W
         DTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346846; x=1731951646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HXhfLBhO3coI1dHk269DsGEIZcTKNlot53AmZg4T9M=;
        b=Fue1Tec5BH8YJWhq34dUHdoBEn2T6zQmfcgolhcBMxTiN8PEdRw1RvfdEg95fRMkHd
         n3zKNBgXPF/scPI8vOL+UymCNNr3SGjUGGbEoXd5jgUOs27KewUCX4l4iRpj9CTlwJht
         74qbUEbgSVlxiMQf5RcesNwPMejmqBIBY/cQKPvl6zOUNQ7loOQmeGyyCkFyGBRfcJmG
         5WnL7WK4neb6X0wixJFxFg5JcASWPuesE8Bhu4gOcsUQnSHQZhIzmP7JIMzlfeS7cUZg
         1UpdL1s1ijDuOaKBPMiMQgk8AtOO2Na4iQuipkqkP/H+w+OGVzhAweO4pjDwXz8R6e3o
         M8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVij0xSu8HIn2rPxGkk349tDKlehhGclZ+HrG+crujTs7eKaE+s4xsK8BCmdChrjjjSNZ1ahjT8j5iw57I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NhxyM898gDcyxjqJV47iWYjdJ56gI2g3+ae92aYYwXLl/6fu
	6osB57vR/fm5X9YClklrJLpIaWM0jiBiKCI5jDorXwsz2Sxf8TPag7CZ6nccbV0ITqkXXBwHGGH
	EQmLkS1LLtwyojtssMOrzIMvZDvpxg74VhJgP
X-Gm-Gg: ASbGnctHw0HS6umWqzRs2UcQPU2hh3Oi/M60nGcPXJDYb781QRxgYpwENo06pIulCzk
	sv3Bf5+KM6BN88N+i4pI4YKZuab1Xjrpy7O6whs8U/HbpNqvC8q1gntGIthFNs4o=
X-Google-Smtp-Source: AGHT+IFMpzgDfvNQa5JrCz2VZmXgBLmq/P+th3f1MUkeCqgKU1qfRAQ2N1x7WN3i/oVzWilxwXlZCxrnO6Q6cY80vW0=
X-Received: by 2002:a17:902:d4cb:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-2118dea0992mr4437325ad.6.1731346845810; Mon, 11 Nov 2024
 09:40:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-2-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-2-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:40:34 -0800
Message-ID: <CAP-5=fUpm9Y86qvxGs4p6nG9QPW4FKbzRh_Oot4dEUXWdLGQ4g@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] perf record --off-cpu: Add --off-cpu-thresh option
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> the unit is us (microsecond). Default value is 500000us (500ms, 0.5s).
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-record.c | 26 ++++++++++++++++++++++++++
>  tools/perf/util/off_cpu.h   |  1 +
>  tools/perf/util/record.h    |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f83252472921..ee04fdd7f2ca 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct o=
ption *opt,
>         return ret;
>  }
>
> +static int record__parse_off_cpu_thresh(const struct option *opt,
> +                                       const char *str,
> +                                       int unset __maybe_unused)
> +{
> +       struct record_opts *opts =3D opt->value;
> +       char *endptr;
> +       u64 off_cpu_thresh;
> +
> +       if (!str)
> +               return -EINVAL;
> +
> +       off_cpu_thresh =3D strtoull(str, &endptr, 10);
> +
> +       /* threshold isn't string "0", yet strtoull() returns 0, parsing =
failed */
> +       if (*endptr || (off_cpu_thresh =3D=3D 0 && strcmp(str, "0")))
> +               return -EINVAL;
> +       else
> +               opts->off_cpu_thresh =3D off_cpu_thresh;
> +
> +       return 0;
> +}
> +
>  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __=
maybe_unused)
>  {
>  }
> @@ -3342,6 +3364,7 @@ static struct record record =3D {
>                 .ctl_fd              =3D -1,
>                 .ctl_fd_ack          =3D -1,
>                 .synth               =3D PERF_SYNTH_ALL,
> +               .off_cpu_thresh      =3D OFFCPU_THRESH,
>         },
>  };
>
> @@ -3564,6 +3587,9 @@ static struct option __record_options[] =3D {
>         OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analys=
is"),
>         OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
>                    "BPF filter action"),
> +       OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> +                    "Dump off-cpu samples if off-cpu time reaches this t=
hreshold. The unit is microsecond (default: 500000)",
> +                    record__parse_off_cpu_thresh),
>         OPT_END()
>  };
>
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 2dd67c60f211..c6edc0f7c40d 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -16,6 +16,7 @@ struct record_opts;
>                               PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN =
| \
>                               PERF_SAMPLE_CGROUP)
>
> +#define OFFCPU_THRESH 500000ull
>
>  #ifdef HAVE_BPF_SKEL
>  int off_cpu_prepare(struct evlist *evlist, struct target *target,
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index a6566134e09e..3c11416e6627 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -79,6 +79,7 @@ struct record_opts {
>         int           synth;
>         int           threads_spec;
>         const char    *threads_user_spec;
> +       u64           off_cpu_thresh;

nit: I know existing style doesn't do this but it would be nice if
this were off_cpu_thresh_us (ie the unit is at the end of the variable
name). Most programming languages have gone for having explicit
time/duration types to remove ambiguity. We're peasants so it'd be
nice if the variable name were hinting me in the write direction.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  };
>
>  extern const char * const *record_usage;
> --
> 2.43.0
>

