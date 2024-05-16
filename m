Return-Path: <linux-kernel+bounces-181299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19338C7A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3AA284512
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3A14D713;
	Thu, 16 May 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2lsMc+p"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E014D718
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875891; cv=none; b=npLEL8MCxEuJ19PbLkg7yUyPYXIkbBsKMsSBiKLHSvvy8hQm0cQOT0HLoqrJzdSu10WFZHsMrWTS2LzQh9/bpJpWbl+slaiCH+zjiNZppqP+1hL61mGYCePlDs60nCjqzHrzpI4io9PIzbbMK8R5OR/VCFoAS5LM0ts9IplJtfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875891; c=relaxed/simple;
	bh=KOWrJV7sZB7BW+XiwAgmgvw/gxT5eUyy4zK/OgczSaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIYamk5j9THuvoHfACgp8IzS5HF7ZfB6UHJ9eXNIbLg8SMKQCKuFbRBbH3K8+ycQ13lmFiDOQimi3DjdpEhTL+xzbn9XhJ7vxKSdhRoJAVijIfXGAfUp2jsQ+JJtJShUYEOOXtHW2v0MzJfEb0W+MogZsF3swJotW1XeA5x7I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2lsMc+p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec76185c0fso906685ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715875889; x=1716480689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi2qQgRZiJ5JZUb6RUMF3EpGhmXXz9TrZaZuZSjvq3w=;
        b=I2lsMc+pE8QJe9TV6uj4GPvyDFXpNzN9pnpSkZ9UszfeZwN9Fq+5mcswwXOAW+laGo
         wI5VvYIctJNu4sn1otGkvFUnAZGDYd7yKlSEZoo7cGzfGAmNj6MN7yAi2i2ionpp6N7t
         clqJq+b8k4QuD+Ag4dKLTJCDdUW3KpI8ELO6x/gMcRelh46t9TsChHyPIu8llmx2GQ2H
         fwV94dbBDmjwV0Tfku3LG85Iir+lNupCCoGD1yx8LpN2fIwQpqnnLp6zhTVIyo9AJWl3
         us99qkexNhlpEdURu+w+2O+sL8mdz27s5hRSYPGYWkedE89QNb4nzfHG92+QxCxSAqW7
         t/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875889; x=1716480689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi2qQgRZiJ5JZUb6RUMF3EpGhmXXz9TrZaZuZSjvq3w=;
        b=TXsOUf97hpe1gAhEZ3NQr37G/CKy9ZQiZcysPAboPlNhzlI0AjEpXaiuicZMgh5Pmx
         ssMaFtjIT9UcSc9tvT+kJFt3XQ9wJGj3wZ18n/ZcMeX87Yf5YOEIjOh99+/Kgf3BOYCi
         VzoEPvYDGDPmy72dfZUmELZxdnX/tVss2ApIQB3yHbD+qZy0E6FalZeq0ffxWtslrv1l
         HO55400hDmJ3fjIxUI5AcaKpc3TNc/YayqGDA2l38wdWf/WWAiEx2uQeyvo4vlwEdVm2
         QVwGjw6U9onN2Rl09+nLvMEC6+Tk26u4ulmT6ibvsQ+c6sHQdcdXNcQ11hc8cqet32JZ
         orvg==
X-Forwarded-Encrypted: i=1; AJvYcCWDxruKKu1bCxhnVjuleER4A1HsK4OhlFfllHOz8sWBUXV+yurL/hFJpRjb5qv9/zd+NIWCllsV1+vamwN3XQzy9Yl4U5YFFpoNZbZ1
X-Gm-Message-State: AOJu0Yy9IpbXw46iGZi4HmMUmdNlWD/gMyO+Of/Bv38QIUpH0yFk8sJt
	fA+btdVKnIPh3cFFfiKreHe8ASpYYIVNo7EF47EeIo0P9RSrTu6cvep0x1BzCCN/YRAI9NCjaQu
	iATJ1Z76vOU+0ulR6S6XHIuds4RGmrvE8JXDi
X-Google-Smtp-Source: AGHT+IFRyHkQgYr5jjrcF5qYtfSAVdRBMCqzUeIHo06PoydzRvkbrJ4hVzy9D9CNYhYASGKmMWTgj9ELT0rXtXIpsh8=
X-Received: by 2002:a17:902:6808:b0:1e2:73a9:7df6 with SMTP id
 d9443c01a7336-1f060bab7e0mr12034005ad.23.1715875888772; Thu, 16 May 2024
 09:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-3-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-3-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:11:15 -0700
Message-ID: <CAP-5=fXcdUYY8KBTTq3QNxkBF2K6YjuQGtLSujRoRfehgLLKgA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 2/7] perf data: Allow to use given fd in data->file.fd
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> When in PIPE mode, allow to use fd dynamically opened and asigned to
> data->file.fd instead of STDIN_FILENO or STDOUT_FILENO.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/data.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 08c4bfbd817f..98661ede2a73 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -204,7 +204,12 @@ static bool check_pipe(struct perf_data *data)
>                                 data->file.fd =3D fd;
>                                 data->use_stdio =3D false;
>                         }
> -               } else {
> +
> +               /*
> +                * When is_pipe and data->file.fd is given, use given fd
> +                * instead of STDIN_FILENO or STDOUT_FILENO
> +                */
> +               } else if (data->file.fd <=3D 0) {
>                         data->file.fd =3D fd;
>                 }
>         }
> --
> 2.43.0
>

