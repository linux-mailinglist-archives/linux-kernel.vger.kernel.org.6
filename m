Return-Path: <linux-kernel+bounces-404486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD599C44B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146AAB24679
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F81A9B2C;
	Mon, 11 Nov 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABfWiFW4"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F41A726F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347760; cv=none; b=u9noasR6t8jdLkaZw8EPsqolX2RCePvfabl9d6Mj+DRBM1UEyjOLKMoqKLsJwn4NZEso1e/RW9mCXGeJAHMPRzhB/fE2TjfCVT5H10pcbN5Qa/+WTdH+E0J8cSpHQemn7I5BQjAYS0LuS5R5XZeEjSNnlLRj6G+nEvfCMJRE5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347760; c=relaxed/simple;
	bh=Gk3Bd65cbPXkb67tabSPVYvDafMdc4UaLcN1JZUm3MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUp32CS7KZMaGfqMsSDFTm6J2mMRhTuMRbqCjXnX2c+YzTMm15PUcoTTgQJr7LpeyZ6GKsFd+PF7Bh0iX1wBbrVomI8m1R02lqa1tZdodAItNC5+o+kfeeqSsRro83FzdtiZeukQXxPo9MOBi3zM9bK9L7Kp3oNFIueze72dzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABfWiFW4; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso2015ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731347758; x=1731952558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWCEpVzPP2C567p2YX+zooGp6OPXofG6vmEFnRTKNhU=;
        b=ABfWiFW4gYDdLyXDhWJfnQF3j0Tnfg9+xjmYm3e1p3ip5lQHh7km/3r77EynbDIyYT
         LgJDMJQZ6tkWXFTNRtZ9JlylGESTW5idOB9L1Gi+K09P0I39+1k+MPQ//QI9rSKGns12
         2i8tAGyPv4xRYPRs0MjaM2Ho+hgfgxUPtHtOEFuepffZE2LK+7i7Tozi+DEMkFu6nasG
         A6F6oPBybmBtbPkEnioppQewtouc8C+OnnuGAwLxowj0IFZXK9sWpSMg5WWfmiwwet3n
         1Dg8dHS9SdEtm1rGnzZ5nUF741bsJXLzupE1XC965Pcmiztf0i8QMWh7UQ2vtGO/Bor1
         0vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347758; x=1731952558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWCEpVzPP2C567p2YX+zooGp6OPXofG6vmEFnRTKNhU=;
        b=Vv/uRFCfSskk+icOzdWeVDjOS+7wg5qanRKyVLZppH50QsmpqRi9yzAXwDGY25wAXN
         386Jalio1xBndhVS7/zzK76xvQekKbshbyDC8I/4eOkOB61xT22pQSB4Ocw0sAgc26iP
         qyhIhRH1606RGE7jv2Hb5lW2YGvawkUq9TX6B5ryp5y3aj+SK6+AUQjHg2LPWq5twts7
         oajeFb1Diz2Ql6ViLHkR5sw3pRC+DIATTq6V61tWzoW/cVq4PBa7S0ZUkKeBAiXLeV46
         NsYRUCOrd81BORz9zL0uZWKRG44ljzegATC3PDYstze2xixcHoWstQK+JWjKyrPrgfdT
         wa1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGYlH/kHsXvqyyjNCH6BPUjLRhTg1feTVZngsmx34862gd3alRKhhPwkQIlQvksyg54o1UitHaMxA0mmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nEpaIkh1nXpsKPihfH/b/JF0gxaZAe98uKKmqVbjC1RkY1lA
	RKIzFWBQpNw4NpZzt0D4QmbQrzJFTs82KDEELMamxxqRgjXprUHfkDFHmfF5/Zcpq7WjhP21yh9
	jtn9Uvu09TExF6rzWh++mYbt6AQ5h19//iaEm
X-Gm-Gg: ASbGncsquLHF366s5F0VV0ar8wxFTCdo5EtCGQOVKOC1t8KQyVNSzphwbMTZlY2s45g
	Z5fV9LR2fBOZWv2pLGg6+5QtitnQn1vtlmjxHO27l55vy1x0COKN4xlbcA4yPDhQ=
X-Google-Smtp-Source: AGHT+IFhSYq0STb5lF6oh/lN0IEV8ozrjpzp1B9XixwyORRQYQpKjw+W9mCRekpu31DkLDY6hY5cBsmbP4Hr0C2pjdg=
X-Received: by 2002:a05:6e02:1605:b0:3a6:b0a3:540b with SMTP id
 e9e14a558f8ab-3a6f8a97e8fmr7613755ab.20.1731347757481; Mon, 11 Nov 2024
 09:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-7-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-7-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:55:46 -0800
Message-ID: <CAP-5=fU8DC+-bS0E+=8UwNtjch8MUNJOx8TshhjcPD+-NMGKNA@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] perf evsel: Assemble offcpu samples
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
> Use the data in bpf-output samples, to assemble offcpu samples.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 695f831b463d..20f07597fac1 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2783,6 +2783,35 @@ static inline bool evsel__has_branch_counters(cons=
t struct evsel *evsel)
>         return false;
>  }
>
> +static int __set_offcpu_sample(struct perf_sample *data)
> +{
> +       u64 *array =3D data->raw_data;
> +       u32 max_size =3D data->raw_size, *p32;
> +       const void *endp =3D (void *)array + max_size;
> +
> +       if (array =3D=3D NULL)
> +               return -EFAULT;
> +
> +       OVERFLOW_CHECK_u64(array);
> +       p32 =3D (void *)array++;
> +       data->pid =3D p32[0];
> +       data->tid =3D p32[1];
> +
> +       OVERFLOW_CHECK_u64(array);
> +       data->period =3D *array++;
> +
> +       OVERFLOW_CHECK_u64(array);
> +       data->callchain =3D (struct ip_callchain *)array++;
> +       OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size=
);
> +       data->ip =3D data->callchain->ips[1];
> +       array +=3D data->callchain->nr;
> +
> +       OVERFLOW_CHECK_u64(array);
> +       data->cgroup =3D *array;
> +
> +       return 0;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>                         struct perf_sample *data)
>  {
> @@ -3134,6 +3163,9 @@ int evsel__parse_sample(struct evsel *evsel, union =
perf_event *event,
>                 array =3D (void *)array + sz;
>         }
>
> +       if (evsel__is_offcpu_event(evsel))
> +               return __set_offcpu_sample(data);
> +
>         return 0;
>  }
>
> --
> 2.43.0
>

