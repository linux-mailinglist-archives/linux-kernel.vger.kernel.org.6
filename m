Return-Path: <linux-kernel+bounces-568331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA68A69406
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332E81B600E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509A1D61A5;
	Wed, 19 Mar 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUPXSPJ/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0F189906
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398997; cv=none; b=uxjOvsSyCGkay02SmVj4L2ogav6wkuvjm3UFsZv27cbdkcdtxpe8AYzU3lFetBCbFEcltPMa2UJzowyloJx7xD1gBMpWJ0ZV9vr2pL2Ised/Jwwjb0cHohdjDeWaey6tBrdcwCgDMeUKnaDjWFrVxYsRM3QIEsu9K7ELZVe0hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398997; c=relaxed/simple;
	bh=7n7coIRSnIIUb70FGA+XX4U1DxR53yWq+cl7ObqvJ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiH02YOakACxEpgBv/WphJVA6iGVZFBjzkzN22YnpN+NJj90me+x8Bf8myzY301Xy4OWt+rp3BYIB+0esKnaQ4UCiAKc85T8xeJKePlYuz8PN/H9I8n1g46120m9jhhLzX+9Cc6/nQsV2qr/Dz+hgc3bLbCzZDMxGK2yAVrIyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUPXSPJ/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so271255ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742398995; x=1743003795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruRlgxoG6v9cNtBSfSIFgCF68XbtgVeUTkhXsZTDt+4=;
        b=BUPXSPJ/MXMpoUtuK0ii8H4BA4MEnFsVxKQ48tAivGXisYW0mZp3Mwy+/Hpcug0han
         lNquvEwahAjH3+M3VaU9NzL+FkpK5dDLeOuqWTNk9ZHLABFKzdqkeuTgnzg7F/Hy60h6
         UNipxjLVtaCzjkzmaqA/cx2NZVxvNsRgnYwZbz1GcL/nonI4vBhxNBaW5vfPF72re/1T
         7B0D51ygbdRhsS4bChRgqNpQdnZNrJZWlo7l8fO6InhKBtYaGkQmHLb2PrqhUaGzFR6R
         i7fNzNANKN3VReVBG09BIGNISSUCy7hC8xW6DrvkONwBplVnIgnFP3gUZ9BnTpEcOO+U
         dzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398995; x=1743003795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruRlgxoG6v9cNtBSfSIFgCF68XbtgVeUTkhXsZTDt+4=;
        b=kckpG341XlszL531lwnCAkPdQNKNdbBGmHf5OokWQEOcHeF70YLlNHAhxRAYhTQNQL
         pzoUDAm6zXrcxdKCYvVBtxAbfGk1cldhf0xXjhs+uvEMuAO0ktg9EwRkCZyecvjHgGgg
         QDdCLVSNNJzG46lcX16+ZItIH3RdJ6QqqeQydZpth0+qRj6Q3dH+Pl5dpdfdtCR1kYQm
         takHeQxRKl+v7rmxnZn1XXyKfxxwHqJBJGr1ohAWQ6fNtsyTCeomySOftHJlVHFKPcE6
         ftHFKrJggZTMnw4FDgMJvdMLWfKWMH9t3UFale4nfBz0GrgnATzuaf8QkDL+GbELQQBE
         R5aw==
X-Forwarded-Encrypted: i=1; AJvYcCXlO83bwCHaGsFGXuY7yteU8fmRj4PftmLf70/rvvhT64MsgahvcGc7t0Mzq4x9Sz7AczO6eamO8v6lcWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3ups23+cLdGTrs63/6z3LyqREfS+kLMLRYQC2pjHFlW5GWXX
	SNv0CZbaV6UNTPsETlPh9sjaxQ6bjUv5x3urPNoGpcRfATs31TCYYXZ5+SNYfMCA3e+DGuhRxyZ
	bRyIsODUZE6BTJT6Hy5LwLrr4t0nMtDIT3G7D
X-Gm-Gg: ASbGncvOKJG0nJ4YxBa9B+Mlr4u2/Zz8arABA3gURU4kDdyI6QY6BNT6F0CsP0noRmn
	jWHEmCp+HerQtPaWlOr43dNjbdWfMw8j0B0ZV+ndfvEErWw/UwYxO2YQz4TwRKanQkXpjSpGoPU
	CxNZR0WhDWUUi3rZaJj1bCUIWi6I7g4MOKTwx12yWtOE4nUB4W6ysiBQ==
X-Google-Smtp-Source: AGHT+IHWuHkIvSY7Z7leEA5ObRosRaPTXfKMrBJgStcMtBCk03WBIodbKRyZj0G2hp2kbvK9CAx9KYC8ulnXyu8DMX0=
X-Received: by 2002:a17:902:dac4:b0:224:38a:bd39 with SMTP id
 d9443c01a7336-2264c6695b2mr1643575ad.20.1742398995201; Wed, 19 Mar 2025
 08:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319114009.417865-1-james.clark@linaro.org>
In-Reply-To: <20250319114009.417865-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Mar 2025 08:43:04 -0700
X-Gm-Features: AQ5f1JqhweX5mSsHqDCo1dNNZ_4dvCD1fV5lK-3_zkFLf6aJz7th2SNf3IvmKUs
Message-ID: <CAP-5=fVHGryhBtt9SANOdyw3JijvefgqAHgZuiFBEuPmSdoTxA@mail.gmail.com>
Subject: Re: [PATCH] libperf: Don't remove -g when EXTRA_CFLAGS are used
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 4:40=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> When using EXTRA_CFLAGS, for example "EXTRA_CFLAGS=3D-DREFCNT_CHECKING=3D=
1",
> this construct stops setting -g which you'd expect would not be affected
> by adding extra flags. Additionally, EXTRA_CFLAGS should be the last
> thing to be appended so that it can be used to undo any defaults. And no
> condition is required, just +=3D appends to any existing CFLAGS and also
> appends or doesn't append EXTRA_CFLAGS if they are or aren't set.
>
> It's not clear why DEBUG=3D1 is required for -g in Perf when in libperf
> it's always on, but I don't think we need to change that behavior now
> because someone may be depending on it.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/perf/Makefile | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 3a9b2140aa04..478fe57bf8ce 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -54,13 +54,6 @@ endif
>
>  TEST_ARGS :=3D $(if $(V),-v)
>
> -# Set compile option CFLAGS
> -ifdef EXTRA_CFLAGS
> -  CFLAGS :=3D $(EXTRA_CFLAGS)
> -else
> -  CFLAGS :=3D -g -Wall
> -endif

I suspect this was cargo culted from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/bpf/Makefile?h=3Dperf-tools-next#n81
I'm not clear why it was ever that way, but perhaps a wider cleanup is
necessary than just this one patch.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  INCLUDES =3D \
>  -I$(srctree)/tools/lib/perf/include \
>  -I$(srctree)/tools/lib/ \
> @@ -70,11 +63,12 @@ INCLUDES =3D \
>  -I$(srctree)/tools/include/uapi
>
>  # Append required CFLAGS
> -override CFLAGS +=3D $(EXTRA_WARNINGS)
> -override CFLAGS +=3D -Werror -Wall
> +override CFLAGS +=3D -g -Werror -Wall
>  override CFLAGS +=3D -fPIC
>  override CFLAGS +=3D $(INCLUDES)
>  override CFLAGS +=3D -fvisibility=3Dhidden
> +override CFLAGS +=3D $(EXTRA_WARNINGS)
> +override CFLAGS +=3D $(EXTRA_CFLAGS)
>
>  all:
>
> --
> 2.34.1
>

