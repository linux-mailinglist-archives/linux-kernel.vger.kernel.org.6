Return-Path: <linux-kernel+bounces-235310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7265B91D370
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CA928123F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D8155A43;
	Sun, 30 Jun 2024 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn98S5H4"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67C155A21
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719776008; cv=none; b=dAkbl3M8jLc2njBvjvoAejhFcNF1ACT+31ArndWjMql2tb6AQ66wX8KZBzEnwzILWWtjFSxOYM6U6/qBsRc0PasNTzh+271urzZFDxnTZ7GWkFVOAMdTbqiFOjeFQMJBQbPfFQrgeb0NSrA46qbmJ38EHGLeq16WLEs4I1HEpfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719776008; c=relaxed/simple;
	bh=9StqqK/FyFjjIQ3Wt3gRMJwQpG9CYap21wy3SrrOGrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrttOt2DuQeHIWuAcwYucATCLByeRPrvBopOpRBbDCz+Xg53antFxoxEkdz9CNx9CdRi3cUFZqeEwX/RPYzcbzCZI0p/Uu9nvUKM1PoPz/yNdRorVLIfn5D+14/REXE9S+5ZoHy9QdhFVZse8+vIFxOT2ToKBKu0xg6P+K0omx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wn98S5H4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-63186c222eeso23215977b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719776006; x=1720380806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5jFZosVLQ5njavRkbtKkWFfcQaMI48MvNy4kw/eY0g=;
        b=Wn98S5H4VWhSzKD/YAaEy7rhbeCI/gUg+ueMBW/SrmLf2vp2CDpDlnLaie9aRfuCRm
         29Haj6X3U95PRD+nlYOSTfwXc9e2eUrB+9kcQWf6VyGTIV/G7Co59pQ1RGkMXcKHl/K8
         vE8YEeoZoeisMFUF5q5LCPsive1XbC98osEyhiWKQjP7rc+bNLhljFFeC1KYMqWLcS6T
         Fpg+M01zyM7yd8CJLOiF04k296fcp1DauFAMAw+wt2K4Ygz0kRxPW6ovY/cYGXq3IiLB
         oAJrVBFEa6dj4sVk9snu5WTKP5uVSHsQSvTFpJinVi0hfeftLMZVSW6YntVhrPoCThBd
         jvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719776006; x=1720380806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5jFZosVLQ5njavRkbtKkWFfcQaMI48MvNy4kw/eY0g=;
        b=J5013fMGp/NtyzG+qiJHpQJwJt8fTISdJ3JidLuO7ejkq0yQxRoDSO7XzhgUey8RmZ
         LNtKM/gsyFVjj38qsPMHJrqY+pvCXMWzYIf1CN3e85SsS2+nIrvI/N3kS4xqOtHtmHKI
         pV3iU3gO5BJWLG7Nr4RK3ui3pJjscHF5VgpOXe2XZ0vir0XtP57OsuxP1Numq4y/MpFK
         gfy99e69zbSih+HDeUwyc/QPoW0JNO1Hiea13uH2KaiDFtHRa+MUPb8MB6Dn19wfX4BJ
         vDTy54p1J21QNulzbhap9PcPlwU/G8zhrOj+4fXxvg86l3FbZRDQwp2NH/6Gqy0YyUwG
         zrHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnPQFdtWGUhzveP83AFTTtw0vOevpSlyPddZIGgpW9PMK+W/N/eeOqQK/DrrCsl87GBOmN4BMlqMZiBN0OzvQwUZ/9LUC7ePtf4pNg
X-Gm-Message-State: AOJu0YzOI6s2bdVmUTjqXEnI69IamClqkKyDDU+ORG8vtZID+kUDfM4K
	P88JUUOxYYpT3UqZRFIkdBoY06jTkpRFR0ikfjB/pTrqb0nSGwCkdSdd51oP/MblQQoXIwc0S1x
	oB48kNuTA4R3YuZa+eBKMckf5FSFU8hvOA96oR+V2X8x3hPIyqT4N
X-Google-Smtp-Source: AGHT+IHPO34FOZWGU5tBOTf9EpO302U9/tKO9iLfbVU2UZG2QqSR0FEip02DdXEWZTJJiYBRKdhq/JWqYK64DKKvbmU=
X-Received: by 2002:a05:690c:ec1:b0:64a:e7ec:f3d with SMTP id
 00721157ae682-64c72682f11mr43522187b3.18.1719776005709; Sun, 30 Jun 2024
 12:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617153250.9079-1-00107082@163.com>
In-Reply-To: <20240617153250.9079-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 30 Jun 2024 12:33:14 -0700
Message-ID: <CAJuCfpGaEJLaWYPidiAG1vtayugQY5vJoFv9Opauh1TrofOv7Q@mail.gmail.com>
Subject: Re: [PATCH] Add accumulated call counter for memory allocation profiling
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:33=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
> Accumulated call counter can be used to evaluate rate
> of memory allocation via delta(counters)/delta(time).
> This metrics can help analysis performance behaviours,
> e.g. tuning cache size, etc.

Sorry for the delay, David.
IIUC with this counter you can identify the number of allocations ever
made from a specific code location. Could you please clarify the usage
a bit more? Is the goal to see which locations are the most active and
the rate at which allocations are made there? How will that
information be used?
I'm a bit cautious here because each counter will take more space and
use some additional cpu cycles.
Thanks,
Suren.

>
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  include/linux/alloc_tag.h | 11 +++++++----
>  lib/alloc_tag.c           |  7 +++----
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index abd24016a900..62734244c0b9 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -18,6 +18,7 @@
>  struct alloc_tag_counters {
>         u64 bytes;
>         u64 calls;
> +       u64 accu_calls;
>  };
>
>  /*
> @@ -102,14 +103,15 @@ static inline bool mem_alloc_profiling_enabled(void=
)
>
>  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag =
*tag)
>  {
> -       struct alloc_tag_counters v =3D { 0, 0 };
> +       struct alloc_tag_counters v =3D { 0, 0, 0 };
>         struct alloc_tag_counters *counter;
>         int cpu;
>
>         for_each_possible_cpu(cpu) {
> -               counter =3D per_cpu_ptr(tag->counters, cpu);
> -               v.bytes +=3D counter->bytes;
> -               v.calls +=3D counter->calls;
> +               counter         =3D per_cpu_ptr(tag->counters, cpu);
> +               v.bytes         +=3D counter->bytes;
> +               v.calls         +=3D counter->calls;
> +               v.accu_calls    +=3D counter->accu_calls;
>         }
>
>         return v;
> @@ -145,6 +147,7 @@ static inline void __alloc_tag_ref_set(union codetag_=
ref *ref, struct alloc_tag
>          * counter because when we free each part the counter will be dec=
remented.
>          */
>         this_cpu_inc(tag->counters->calls);
> +       this_cpu_inc(tag->counters->accu_calls);
>  }
>
>  static inline void alloc_tag_ref_set(union codetag_ref *ref, struct allo=
c_tag *tag)
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 11ed973ac359..c4059362d828 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -66,8 +66,8 @@ static void allocinfo_stop(struct seq_file *m, void *ar=
g)
>  static void print_allocinfo_header(struct seq_buf *buf)
>  {
>         /* Output format version, so we can change it. */
> -       seq_buf_printf(buf, "allocinfo - version: 1.0\n");
> -       seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
> +       seq_buf_printf(buf, "allocinfo - version: 1.1\n");
> +       seq_buf_printf(buf, "#     <size>  <calls> <tag info> <accumulate=
d calls>\n");
>  }
>
>  static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
> @@ -78,8 +78,7 @@ static void alloc_tag_to_text(struct seq_buf *out, stru=
ct codetag *ct)
>
>         seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
>         codetag_to_text(out, ct);
> -       seq_buf_putc(out, ' ');
> -       seq_buf_putc(out, '\n');
> +       seq_buf_printf(out, " %llu\n", counter.accu_calls);
>  }
>
>  static int allocinfo_show(struct seq_file *m, void *arg)
> --
> 2.39.2
>

