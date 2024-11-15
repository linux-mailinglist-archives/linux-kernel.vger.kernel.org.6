Return-Path: <linux-kernel+bounces-411187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC109CF4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CF6B2B462
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5E1DDA0E;
	Fri, 15 Nov 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMt5K5NX"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188817BB32
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697094; cv=none; b=HsBVk8MhxAbRXo5xQsnMpT5mMUDD7ICcAdYyGvkRDMkhxBlDmzi5LehfCHP+PeuXs8kcqofMF8Q4al8TU5rmLQUZBeviOpUxy0crRISmOqDGo2ZHmU5jVSrFIsW3fGHWXw5PQgqH72pqJeCOddKHYXLL6SCsibGN2yNy/J7fM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697094; c=relaxed/simple;
	bh=KrhyjO33ThupBbnqrRTfxztSiUsXDj70GcuMwEDZmeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFlSbon1UGjfUbm+Q/9Z99aulvL1Ar2hHTMvDbCZdbSa0fGjlWhNKG5L2L3B+esHsP/tzdpz1xkwbDqS87VaIHBFW2aSGJU8ujYEFX8wJFq+TXv7ScT16RIAxu+7Mt3L64Gn8Al7jsFSeiP0c2zAeU3XwrhCtcrtW/dCwTJWoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMt5K5NX; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a716d74c28so8305ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731697091; x=1732301891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80PGuzrHXAm66euHvfJsgwFOI4nxtZeFwme2x5gfn88=;
        b=SMt5K5NXbAgR1ZBxZh6Io/eK03Ktdejcw7ca3fd3t0SrY3YC8FFhVU/b3f9SInCR0z
         lKkxm+w/pKT8Dlp2XuSZx/LeQ6SnMaODu3SceKzigYrLhmqKJ+UzVNTb8m/DP3YS7nYu
         KVX5mm01DtiR/nkrG4mlatAU/RAucjQLRhyxf0+OgTTleANcU6/n2naZL+yS+AKADkar
         c8ZjqnKAoXWEDy1jYG3J9BadYbJkpVTbJEuhjhvu4tDdNrsyUX0gRSmj4OGDfXRdEbrd
         P0jIH/e5pO3HKkGom5IM6e+WcDYJYwZekOarYetUCLB240JKvg/lwZOj4kxdljiFcSgU
         1XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731697091; x=1732301891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80PGuzrHXAm66euHvfJsgwFOI4nxtZeFwme2x5gfn88=;
        b=Hon1OYjhHVm0lAlN7dLzR/iFzE3rzTahWfbdmc+lGpifnppiOgNCnBGfA2QRknpRKf
         VvaQG4sHFPXXANKFdmj+Kxk7roankvvR0qEYdwK5DYqrigvfdJHbiLt0lIjPuNJV5XGu
         lClbUA+c/KAYtQuiNzMlkrcfJzWv1zulskmsv9s9XoL1251eFLG+eGa5Pj/lAvzZ0xsG
         XRDXBufn33lR+Ey83x+2RvPbjNcS1Zpl1nHwnbGan7m0uXa/k0yvvwSAHKYqRc/4WW7+
         jsfbdlejESXy4GVZSrFySk8S2sk4Ugqn7JCU8yoywVy+aRNdpKdJB+QmpL/m/aHhO6k6
         NL0g==
X-Forwarded-Encrypted: i=1; AJvYcCX2eBw+p0rQHcZeB4EekgmBUXdU0MwMVsJ7DMEYZZPHLQlH8tu0Ch3MAD2s+Y+C4ceFEkUo1xzjoOfZ91Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTGj/irw00c2z3ASeaGieQ47QVdrpeInwpsgWbexePyV4Q6tp
	EsOD5ZgsWiEZqhJwST0g0VYMjPr6IEa+gJWjFnfsRXPWnz9S+cTQAJEAhOCz8LzluymbFpDk1l6
	DWxifCBHDTyGT0Huy1jigCPlf3hjKh6VvVROV
X-Gm-Gg: ASbGncuv+6JLWSdVZFS/NCH/B4mb2KU5MiNbDWBf5i7GOJ7ITN/KTgmY6Pxfbbde2yW
	TMF5+hNMtog4Q8z1TDAptKxWGprJHg3fe
X-Google-Smtp-Source: AGHT+IFnY+LIlDAfB5Pm+G15TjoxMYR74ZP43lguL34LO9a7ABotmMVMvEPWcOYvOMTlZ3m4eULUKz5ADnLx6x+cyK8=
X-Received: by 2002:a05:6e02:1d9c:b0:3a0:9def:a87a with SMTP id
 e9e14a558f8ab-3a74f75d822mr980045ab.3.1731697090877; Fri, 15 Nov 2024
 10:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115091527.128923-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20241115091527.128923-1-jiapeng.chong@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 Nov 2024 10:57:59 -0800
Message-ID: <CAP-5=fXPe9277agFqyEQsOG8h_wM5zFh3Sz+NFpsacU+A5MOuA@mail.gmail.com>
Subject: Re: [PATCH -next] perf tests: Fix an incorrect type in append_script()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:15=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The return value from the call to readlink() is ssize_t. However, the
> return value is being assigned to an size_t variable 'len', so making
> 'len' an ssize_t.
>
> ./tools/perf/tests/tests-scripts.c:182:5-8: WARNING: Unsigned expression =
compared with zero: len < 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D11909
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/tests-scripts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index cf3ae0c1d871..1d5759d08141 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -174,7 +174,7 @@ static void append_script(int dir_fd, const char *nam=
e, char *desc,
>         char filename[PATH_MAX], link[128];
>         struct test_suite *test_suite, **result_tmp;
>         struct test_case *tests;
> -       size_t len;
> +       ssize_t len;
>         char *exclusive;
>
>         snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> --
> 2.32.0.3.g01195cf9f
>

