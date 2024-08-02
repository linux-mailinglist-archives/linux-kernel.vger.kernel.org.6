Return-Path: <linux-kernel+bounces-273077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22495946452
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E351C20D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD5E4F615;
	Fri,  2 Aug 2024 20:26:14 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB8335C0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630374; cv=none; b=bclyRKw1sl1pleFBO8/pzDGnLHdv8wsxx34ZNLG1FCTEOtlJGhwYE3pQv0PN433FlxPybj7H6BekHTpjn5FbWnT2v18ev85uy442dt4nnoqmTqFQ2l4O+tUfLTa5WSQLt5d7AMvZtNob3jZZ9hegBYCmHj7D5TjUiX4AZM3ksq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630374; c=relaxed/simple;
	bh=sThfl6nTMCNCw3oBuUUxaX0P2Kj1jgjfza2xccZ2CXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a28oAAkMC/iDOGWYeUo4feke3DVr2FJIBjtiribfWlVgDiyC8Latx/PpEWkQnazbaKjBaYPhbnvlEQCd8FlfZGYKQAlucfmiqwrYgWzWpZWJA3c5ujIxwPYFjuojB1HjWz7HRDVcbtOUSnaTWizVa1Xf48GEs0+56cMnuRdFDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso5887097a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722630372; x=1723235172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXDqI+2fwuhHPgRrH2oEhxmVOTy+TGqLq1DnsDXfzKg=;
        b=WJAy4HD08neuBh2RsPjgdxcQIJA09jyqIHUHfC5/W7I04S2gQt11FjlWKSEZK9r0LZ
         i0lzlsDyLJQpKHBlV07Mz9IYeSY+CkMXk2Pl45ILFWHB1cwsvIXewQmJmXhh/R8pofbg
         UzSFIOHO7VgGlQgQDDyyNT2NPJhf7yUmRqY3xaVod5WKdPCGbDI/tzlRo9dw1IrbajP8
         XeA67pO+9X9S3TNPUVfLBgACgijQq7yj2M/Oaf4Xj0rJiSLB3zejw4isWhwafnJu0Mpb
         REXmMTRGfA7F2XLYUkqDpkU69jS4RhUsqGmjKPPjJZgrpnGvQQNPqLOzmHTPr6zyWruy
         tiSw==
X-Forwarded-Encrypted: i=1; AJvYcCWya430Qa7IrkECnvuhSMFB6cB5e8laSodAbFsIa89lWGfvpRYQWYDwTuK1RM3z39ib5hYzMtBAq1ntGvPvYwAN/CsX/RHmMpIW9ols
X-Gm-Message-State: AOJu0YxZlfoSUQDW7LRU4mlo9JKAQx/wzWCZrTbtLWoncnMSEFhqGJvB
	qVomLreNsUcGIP/cRZNNT/tjZatPQCxyHCK86G626lddgaKZPgGNj0aQjxi3fj1jz9ukvprR0Vs
	gqOL8JM14vcjhA04q09dxe7krsdk=
X-Google-Smtp-Source: AGHT+IGwIoqbRT3gL1U2v51GnI2zDzFy/XP31amFPLsPgB2FLe8pLxi/LRSk9ENWYtIIJbdx3JynaMTf6/bjsHGnILQ=
X-Received: by 2002:a17:90b:1c03:b0:2c9:9fdf:f72e with SMTP id
 98e67ed59e1d1-2cff9547ea1mr5544672a91.26.1722630372122; Fri, 02 Aug 2024
 13:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703200356.852727-1-kan.liang@linux.intel.com> <20240703200356.852727-3-kan.liang@linux.intel.com>
In-Reply-To: <20240703200356.852727-3-kan.liang@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Aug 2024 13:26:01 -0700
Message-ID: <CAM9d7chyCh3pEnrFFdBv2xFZqJm9uaaw+PtuFMs0DaOB1T6kjQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf report: Remove the first overflow check for
 branch counters
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
> A false overflow warning is triggered if a sample doesn't have any LBRs
> recorded and the branch counters feature is enabled.
>
> The current code does OVERFLOW_CHECK_u64() at the very beginning when
> reading the information of branch counters. It assumes that there is at
> least one LBR in the PEBS record. But it is a valid case that 0 LBR is
> recorded especially in a high context switch.
>
> Remove the OVERFLOW_CHECK_u64(). The later OVERFLOW_CHECK() should be
> good enough to check the overflow when reading the information of the
> branch counters.
>
> Fixes: 9fbb4b02302b ("perf tools: Add branch counter knob")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/evsel.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index bc603193c477..a5dd031c9080 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2810,8 +2810,6 @@ int evsel__parse_sample(struct evsel *evsel, union =
perf_event *event,
>                 array =3D (void *)array + sz;
>
>                 if (evsel__has_branch_counters(evsel)) {
> -                       OVERFLOW_CHECK_u64(array);
> -
>                         data->branch_stack_cntr =3D (u64 *)array;
>                         sz =3D data->branch_stack->nr * sizeof(u64);
>
> --
> 2.38.1
>

