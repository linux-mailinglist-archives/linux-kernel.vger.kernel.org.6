Return-Path: <linux-kernel+bounces-252849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CA9318DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA04B2260C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBF2BB02;
	Mon, 15 Jul 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZYkCHbX"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B81CAB8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062578; cv=none; b=P+me34t7KzTDfqB32vmkW/xTIuE8RmemZGcNnhg/zXQdYAPdKhg/jEm5GNdO8jr2w0C5eSqO1mSiPetBop7r8GZFFtCRtdEoSgzOdCHblpX4648UFOGHTV6TTMxAVRsOdkSOslLgnXYX1F7fkdn9ujF7f4DXB5YA6aDC4v9oKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062578; c=relaxed/simple;
	bh=b8bjZwB6QeTPAtY832jHAfoqjJVRh8eguL+Cmdzqh6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQSJrIZnjLBVR0WSTPLj4VErqIj65ZiaulQZLueKzrOQipSdPNj3dg8SEMAG/1lY+FxHAPQ557UUV9iEU1lfWYQ3AAsUoWueIuyEqeq44EPZc2AdGxnowa7+FXuDTmh5zCU4jVaCE/Wt9UdIirt+M9Z/UgI+ogkQHteikMD9yO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZYkCHbX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447f8aa87bfso15531cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721062576; x=1721667376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02jBTyIYbhiBgb/Yu2ftb/npqvSP6Ka1Kr7RVDqcuYI=;
        b=vZYkCHbXVguwl/U+Tbh98FyJaESZx5ABa0Eq60htOKSZk4QoeAp+7p+JOlY141xfbd
         N5UtaPtHdIYNTZFxCqT8WEYjK8gHyGt6D8g5EfaJwbM0+1h0sLWPZ3TBuVnhkbROVNEi
         ebbZLnqPZc1jLX/mKKEP5/8erTShg8jpgkRtmTmDm7Yk1B+FU5w+LweVyJiQQ7JCe8dy
         xmuwT6I0ElNtWUIXBR+vD48tET2VqibHEwBxGo72OjZD4z3FwySP4yFZ0U/Uc9EpqHmJ
         pdgUbvNYrA7vVDdld/Z6K9jUtucbQGue1b8hXraRAptbwhsr6sAQRz//85BOqVChZfrK
         /arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062576; x=1721667376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02jBTyIYbhiBgb/Yu2ftb/npqvSP6Ka1Kr7RVDqcuYI=;
        b=Ajibyu/NRCwmPJ0iIJTeh4erJoyB4keIOSLthLMuPnVp1B/XyWghDKEGziGkZiGPRH
         oaysdaki0WHP0gBEXKR2ZxbuvhKiFEyYVKDycGKgP4swKpqZg84GwA8SUwLm8BF0OJEG
         pSygrSnrPHAdSq307ayIPJotRPX/7wolpDlgrUA4f4eyB0wwOpUvkyDj+6e5J0836Stp
         UNRZhBL/DQxHJU7+VkPK6lPKxp1Q5q8nnZZK5bKDOawBkg7ejYWTaed8Y/Xd5XjZ9Kda
         /nPFwFVcqgNg+pa4VDEYOOCoPxntt8vitiUaoCIO02brbwJILMkfajVzKcHSmtLZCA+/
         y8uA==
X-Forwarded-Encrypted: i=1; AJvYcCUeZ781VgBzFhGC1BGpEnHqJ9FoKJFcOYfWVA1CvccDpBPtiTABGHP3w6YFE+sjxJrxfOqVg46SP7gOEgc5DMooxlxLUZiafFqvdrfS
X-Gm-Message-State: AOJu0YyaqhXxV6CaxF3vFm1BuPMNVO8Zn+Opl3XssKow3AHRRqVRTGF5
	EMPGddcvtQS4CHQ278RnwKdON5nuYZ+iCo/LUWoFZxF2SOPa7Nee1ErTuTKpyLYrXEgATQSoH1H
	GNW9BYJezlYbBmbmSphWtPS3BxlfTnu/C35W1
X-Google-Smtp-Source: AGHT+IGga64Ehsgh34xHpgbxZ4XkIMmBA3oeSeXSOSPWRrkTmDK1WjXya3JOHlljMiiiEhUtI9zjO9VfED8ibiHkp3s=
X-Received: by 2002:a05:622a:548f:b0:444:97b7:e3b1 with SMTP id
 d75a77b69052e-44f5ac8ec0amr5581261cf.13.1721062575590; Mon, 15 Jul 2024
 09:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715094715.3914813-1-james.clark@linaro.org>
In-Reply-To: <20240715094715.3914813-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 09:56:04 -0700
Message-ID: <CAP-5=fXug1ht3dVDpuG6hvzEYdexT9eH80E3B2NUraONXcCS=w@mail.gmail.com>
Subject: Re: [PATCH] perf dso: Fix build when libunwind is enabled
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>, 
	Yunseong Kim <yskelg@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 2:48=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Now that symsrc_filename is always accessed through an accessor, we also
> need a free() function for it to avoid the following compilation error:
>
>   util/unwind-libunwind-local.c:416:12: error: lvalue required as unary
>     =E2=80=98&=E2=80=99 operand
>   416 |      zfree(&dso__symsrc_filename(dso));
>
> Fixes: 1553419c3c10 ("perf dso: Fix address sanitizer build")
> Signed-off-by: James Clark <james.clark@linaro.org>

And I wonder how this ever built..

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/dso.c                    | 2 +-
>  tools/perf/util/dso.h                    | 5 +++++
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 2340c4f6d0c2..67414944f245 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1501,7 +1501,7 @@ void dso__delete(struct dso *dso)
>         auxtrace_cache__free(RC_CHK_ACCESS(dso)->auxtrace_cache);
>         dso_cache__free(dso);
>         dso__free_a2l(dso);
> -       zfree(&RC_CHK_ACCESS(dso)->symsrc_filename);
> +       dso__free_symsrc_filename(dso);
>         nsinfo__zput(RC_CHK_ACCESS(dso)->nsinfo);
>         mutex_destroy(dso__lock(dso));
>         RC_CHK_FREE(dso);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 878c1f441868..ed0068251c65 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -602,6 +602,11 @@ static inline void dso__set_symsrc_filename(struct d=
so *dso, char *val)
>         RC_CHK_ACCESS(dso)->symsrc_filename =3D val;
>  }
>
> +static inline void dso__free_symsrc_filename(struct dso *dso)
> +{
> +       zfree(&RC_CHK_ACCESS(dso)->symsrc_filename);
> +}
> +
>  static inline enum dso_binary_type dso__symtab_type(const struct dso *ds=
o)
>  {
>         return RC_CHK_ACCESS(dso)->symtab_type;
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/u=
nwind-libunwind-local.c
> index f6a6f6a91030..16c2b03831f3 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -413,7 +413,7 @@ static int read_unwind_spec_debug_frame(struct dso *d=
so,
>                                                         __func__,
>                                                         dso__symsrc_filen=
ame(dso),
>                                                         debuglink);
> -                                       zfree(&dso__symsrc_filename(dso))=
;
> +                                       dso__free_symsrc_filename(dso);
>                                 }
>                                 dso__set_symsrc_filename(dso, debuglink);
>                         } else {
> --
> 2.34.1
>

