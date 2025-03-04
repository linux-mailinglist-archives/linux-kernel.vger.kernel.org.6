Return-Path: <linux-kernel+bounces-543006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F3FA4D06E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82C9188EC1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F481C6BE;
	Tue,  4 Mar 2025 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDn3QDnX"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7635966
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049931; cv=none; b=M4PrEvtsG3JXqAtc99zycYHewcuvagccxP8ne2Spg/TnvAK060J+S5/ndzOtg/xBYv2CEBYMmj9vnbP4/ppNJfsM9rGADoPoCqMT0VVEcOEWBc+xq1zdnlp72hS6XnZHG70rGsMHUOxzdpPw/Qn3BCkM5VUiwGlbzEFP9pM/FyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049931; c=relaxed/simple;
	bh=46luQe9JdiPiR1kLnZ75VM4rNgoWCv+KWyG4aH7lvyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UycJlvXowwLj+bNO4MxM+pwiaqPrnYzraN94x8ihZJwhv9wMCA893pzau9BuSmZkj0rMeaxJ1Yx2Y8HO92H672rFe1Uv/aj26n9nsxtOabO8pI5d3Ah3Chh/t/lnAJpogcLvVrQDBFOwNHyTPt1LlC1XYWzfQKcfASfXCvUwI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDn3QDnX; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-472098e6e75so67831cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741049929; x=1741654729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/70wsnjQgfBMuwpjoCjlAMX9/8QFV3tye1jnlQ9360=;
        b=hDn3QDnXwGW3nk9bC4XYZhTnEdqQLlP/CKXC0xtJ4n/Lhs7ZuazHlyljcbj5lhx9FH
         YDCPxb/MBv2VGhx9mQRCQE8Gy7FU+QxClOZ2W3NKqbYNj6rkzry0RmqyBs2W2x+mSEtk
         I1d+KmUblbkJA572nrrKjxCAB09ZcuT0X/DDdekwgdpLmQywJR9J8lvZ7Jj7qlw4RP89
         DqSt/e3gRV3DTl3pFQ35yPdiWrypZpAbkBEre2Xny6S2KGRHkE1akGzmp/2xLdx2V4BX
         2lO9nYMaXhNIyIdrfdksek/zNwXawaw48onuBxBLljOia1vjjsiOzf/MbLfmFTkODyxZ
         3dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741049929; x=1741654729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/70wsnjQgfBMuwpjoCjlAMX9/8QFV3tye1jnlQ9360=;
        b=mPhdIE+W9LaSKCbcop1Vx5vuE6BQHZbzlER+WuoGj9yU1C91484zYo/sCWiQo4IMZA
         KgyPxY/jJwFlmk8SplDHYOhwQGKHYskriO9gOOTVBl6tVyxhjGkA7PDHasAk8JL0wxjG
         f51Ozf5ZVDLLVzKECHTrYFgpaX/GgoVELf94w0kUEM0rpyaUQUxRbQsVAP6551vHdBHc
         QO2y7haTdGkV+K73/UW2eDyhth4t5Lm4x8GTbov7lk3MLqr5HpTij2VPzAyqkR773t5m
         rkYKrgah9ztoG9tHBDBmW1VV0JOw4FfSQcAAvIi8PfiK3FUiKwZeiSrYbX1MNt9bpoq5
         8s8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAcvbnkkeVZTTzCIU78QKZYTWP/dkEu9eBbGWGjhBTjcQjJKOmPWSNJ5PBNd0uUJU5Tv/TkhY1IapaB0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDvaSZa6BHjSYkL++/wWp2DGYFJHowUWORie3jkTl3jTCtiGP
	on2RPZndBu/YtLYMIq+ymC/pjTWCuJN4wTNeWJvZUC8dZZqlqacQfuV646uIEVjAuQgstPKK9Ch
	XQ709ah/MYlAocNXxL/RsivV7YH6gvAwonPfT
X-Gm-Gg: ASbGncv0qcpXX7OkwedVoJ0bhgV2bb/DqN7zrP9MrSxa41Mw2s1ecyIa+cNTvU01JGo
	8U9dKFoLj9hm+h6iYaZGlhnygOelzAs0Nqren4RWs30F83gWOibvgyyiUWA8fTrL+nn3J7uSYD6
	SDSBXJmA5sTXJbycBTsogyqbkfNrEZLxhTXYaZ+2IuGH921J57PjmIiaU1bNg=
X-Google-Smtp-Source: AGHT+IH8tSN6WogYmeFmiAzv6zZwUO7HwDNdjwYDf6A6iDplmPJLcITq4uh061ZHOieg8FkqBgAhWqTWTv1Fnw6O26Y=
X-Received: by 2002:a05:622a:44a:b0:474:b44f:bb88 with SMTP id
 d75a77b69052e-474fd867558mr772201cf.27.1741049928469; Mon, 03 Mar 2025
 16:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213211718.2406744-1-kan.liang@linux.intel.com>
In-Reply-To: <20250213211718.2406744-1-kan.liang@linux.intel.com>
From: Stephane Eranian <eranian@google.com>
Date: Mon, 3 Mar 2025 16:58:36 -0800
X-Gm-Features: AQ5f1JopnpNIFE5_C1n7nuxX7GKLwgYiYIjM7XEjGT34a9lLsyr4GF5uCFzXJ-U
Message-ID: <CABPqkBQcKgsrVD+MLYrgiemc2_THOGKi+E1YayFw_pT4VQWGEQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] Support auto counter reload
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, 
	ak@linux.intel.com, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kan,


On Thu, Feb 13, 2025 at 1:17=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Changes since V2:
> - Rebase on top of several new features, e.g., counters snapshotting
>   feature. Rewrite the code for the ACR CPUID-enumeration, configuration
>   and late setup.
> - Patch 1-3 are newly added for clean up.
>
> Changes since V1:
> - Add a check to the reload value which cannot exceeds the max period
> - Avoid invoking intel_pmu_enable_acr() for the perf metrics event.
> - Update comments explain to case which the event->attr.config2 exceeds
>   the group size
>
> The relative rates among two or more events are useful for performance
> analysis, e.g., a high branch miss rate may indicate a performance
> issue. Usually, the samples with a relative rate that exceeds some
> threshold are more useful. However, the traditional sampling takes
> samples of events separately. To get the relative rates among two or
> more events, a high sample rate is required, which can bring high
> overhead. Many samples taken in the non-hotspot area are also dropped
> (useless) in the post-process.
>
> The auto counter reload (ACR) feature takes samples when the relative
> rate of two or more events exceeds some threshold, which provides the
> fine-grained information at a low cost.
> To support the feature, two sets of MSRs are introduced. For a given
> counter IA32_PMC_GPn_CTR/IA32_PMC_FXm_CTR, bit fields in the
> IA32_PMC_GPn_CFG_B/IA32_PMC_FXm_CFG_B MSR indicate which counter(s)
> can cause a reload of that counter. The reload value is stored in the
> IA32_PMC_GPn_CFG_C/IA32_PMC_FXm_CFG_C.
> The details can be found at Intel SDM (085), Volume 3, 21.9.11 Auto
> Counter Reload.
>
> Example:
>
> Here is the snippet of the mispredict.c. Since the array has a random
> numbers, jumps are random and often mispredicted.
> The mispredicted rate depends on the compared value.
>
> For the Loop1, ~11% of all branches are mispredicted.
> For the Loop2, ~21% of all branches are mispredicted.
>
> main()
> {
> ...
>         for (i =3D 0; i < N; i++)
>                 data[i] =3D rand() % 256;
> ...
>         /* Loop 1 */
>         for (k =3D 0; k < 50; k++)
>                 for (i =3D 0; i < N; i++)
>                         if (data[i] >=3D 64)
>                                 sum +=3D data[i];
> ...
>
> ...
>         /* Loop 2 */
>         for (k =3D 0; k < 50; k++)
>                 for (i =3D 0; i < N; i++)
>                         if (data[i] >=3D 128)
>                                 sum +=3D data[i];
> ...
> }
>
> Usually, a code with a high branch miss rate means a bad performance.
> To understand the branch miss rate of the codes, the traditional method
> usually samples both branches and branch-misses events. E.g.,
> perf record -e "{cpu_atom/branch-misses/ppu, cpu_atom/branch-instructions=
/u}"
>                -c 1000000 -- ./mispredict
>
> [ perf record: Woken up 4 times to write data ]
> [ perf record: Captured and wrote 0.925 MB perf.data (5106 samples) ]
> The 5106 samples are from both events and spread in both Loops.
> In the post-process stage, a user can know that the Loop 2 has a 21%
> branch miss rate. Then they can focus on the samples of branch-misses
> events for the Loop 2.
>
> With this patch, the user can generate the samples only when the branch
> miss rate > 20%. For example,
> perf record -e "{cpu_atom/branch-misses,period=3D200000,acr_mask=3D0x2/pp=
u,
>                  cpu_atom/branch-instructions,period=3D1000000,acr_mask=
=3D0x3/u}"
>                 -- ./mispredict
>
> (Two different periods are applied to branch-misses and
> branch-instructions. The ratio is set to 20%.
> If the branch-instructions is overflowed first, the branch-miss
> rate < 20%. No samples should be generated. All counters should be
> automatically reloaded.
> If the branch-misses is overflowed first, the branch-miss rate > 20%.
> A sample triggered by the branch-misses event should be
> generated. Just the counter of the branch-instructions should be
> automatically reloaded.
>
> The branch-misses event should only be automatically reloaded when
> the branch-instructions is overflowed. So the "cause" event is the
> branch-instructions event. The acr_mask is set to 0x2, since the
> event index of branch-instructions is 1.
>
What is your definition of 'event index' here? Is it the position on
the cmdline?


> The branch-instructions event is automatically reloaded no matter which
> events are overflowed. So the "cause" events are the branch-misses
> and the branch-instructions event. The acr_mask should be set to 0x3.)
>
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.098 MB perf.data (2498 samples) ]
>
>  $perf report
>
> Percent       =E2=94=82154:   movl    $0x0,-0x14(%rbp)
>               =E2=94=82     =E2=86=93 jmp     1af
>               =E2=94=82     for (i =3D j; i < N; i++)
>               =E2=94=8215d:   mov     -0x10(%rbp),%eax
>               =E2=94=82       mov     %eax,-0x18(%rbp)
>               =E2=94=82     =E2=86=93 jmp     1a2
>               =E2=94=82     if (data[i] >=3D 128)
>               =E2=94=82165:   mov     -0x18(%rbp),%eax
>               =E2=94=82       cltq
>               =E2=94=82       lea     0x0(,%rax,4),%rdx
>               =E2=94=82       mov     -0x8(%rbp),%rax
>               =E2=94=82       add     %rdx,%rax
>               =E2=94=82       mov     (%rax),%eax
>               =E2=94=82    =E2=94=8C=E2=94=80=E2=94=80cmp     $0x7f,%eax
> 100.00   0.00 =E2=94=82    =E2=94=9C=E2=94=80=E2=94=80jle     19e
>               =E2=94=82    =E2=94=82sum +=3D data[i];
>
> The 2498 samples are all from the branch-misses events for the Loop 2.
>
> The number of samples and overhead is significantly reduced without
> losing any information.
>
> Kan Liang (5):
>   perf/x86: Add dynamic constraint
>   perf/x86/intel: Track the num of events needs late setup
>   perf: Extend the bit width of the arch-specific flag
>   perf/x86/intel: Add CPUID enumeration for the auto counter reload
>   perf/x86/intel: Support auto counter reload
>
>  arch/x86/events/core.c             |   3 +-
>  arch/x86/events/intel/core.c       | 260 ++++++++++++++++++++++++++++-
>  arch/x86/events/intel/ds.c         |   3 +-
>  arch/x86/events/intel/lbr.c        |   2 +-
>  arch/x86/events/perf_event.h       |  33 ++++
>  arch/x86/events/perf_event_flags.h |  41 ++---
>  arch/x86/include/asm/msr-index.h   |   4 +
>  arch/x86/include/asm/perf_event.h  |   1 +
>  include/linux/perf_event.h         |   4 +-
>  9 files changed, 320 insertions(+), 31 deletions(-)
>
> --
> 2.38.1
>

