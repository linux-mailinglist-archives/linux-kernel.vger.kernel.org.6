Return-Path: <linux-kernel+bounces-433811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FCE9E5D67
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605851880295
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0107226EC9;
	Thu,  5 Dec 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXdDDkg+"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068321A42B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420181; cv=none; b=ejA0y/4Wl3bEV0lZjFiI7Wg9Snq/8XlFaQ7qkSTxnLbTProhlsV0gCyYjK4zlcRbrToxzrScPCvJ/3uK4Y8mE6w6QELmjzKd7iCi7bRUD5g36wCj7/DihfKG6p7cvCKYWc3WvbfjNxOZ2lB2Hh5LdO7vrgE72gGJOmbzg4e2nvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420181; c=relaxed/simple;
	bh=Aas/ajivlaQDiUo5j+Z/NgPiKM12BDwIA5NbPuujo/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syeFQPurPTXH0VFFnh2WJVomxn/urFiYVFX8NQMobQFgN3ACT4KqKbr/HGbwHA38oKY+squNUwlMvF1pDSjprKDfpnupRCy8XxcrIN4f7O4Jw8IXpadqfhV1tmuyONh5zgTjO7rdBQxUphzxVyZl1/TacIT9jlgvn1UyHcmrT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXdDDkg+; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso187135ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733420179; x=1734024979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7nvQlDigG3dvOpjmFORt17VFFnaXYt9w+hhTvU6/8s=;
        b=hXdDDkg+I/aGVMlg4txwmOVIf8+1diXr0zzqDB0cKnUHOT/UxyRRVyzTmNNHcGolaT
         w6GDmtmLi4+3VDFMA3Fjc8fTW/DYw8ihuwLqcvtFsLc1Fvqavf7abd4XiddLwZ3Dazk9
         eXGTyRUX+Lz+edxN9iQtL91Cz+WAbfIGeOokTLsOtCpm7pO0r9Tgh6wcS6G/WCKafo2S
         srnxYpXe2NFJ456+E0Bm5prQYCx/uML0IjpzD293RIKieiroEtFJps0iAVs3KC5rXzCK
         OUS/yLqLPxcTlHy4hV3l6bJ1+rMyfhzcavR3PSFm+jKZY7epmMz7WPtyhcI+SwfqaXGl
         t0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420179; x=1734024979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7nvQlDigG3dvOpjmFORt17VFFnaXYt9w+hhTvU6/8s=;
        b=RMLrEWbg402FycSv1gj84f25I37Wyb0q5z+qcWxEblI0w1S3Qw56sBJueWEOY+layF
         Apn56KaOJpXWdryWJ6LaWwhr6RQRLZtNxejBwT84mClUNuawA03NN6jA4PA1hNzGKczn
         5ROLRWOwG1pgGxoxqve9FBRaRRk1vuYQ/gwh78VHWrfhnP7WCmHrEM8BEV3qbSemOnFj
         qY/rdmSIowmrIUCxTvPrxdQ2grsb3t4+7FDut3E1MHeEKOFUX7nYjOzxFDJuqeUB/V4i
         p9LdVR/jKA2JegMpxxT5KcidEd0qObV8vKvDGzDlFZtu+1daXV4vfgxyASn6FyKHX3q/
         vGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXsEeaHBj96vwqJmfaBxbzHeBdJiOU/7rs7IkgzbVPcdH8tmRLir6vdhy6qtVjPmCO/R4qy1KWzmIySyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHlTqhN7f7XplJih4bRKJabAgGSkNxwMpG8ZKfomeptgkt3CU
	8dbOwYHkaR8NlJtAvXZ0ItAvEIeoCn9K9RCs2SedunaXRV/U1lxQuflVs1FoGxU6IabTrTDXjiJ
	PTszFness6NtHEVdDP83L1i1GERhrtLkeUuAS
X-Gm-Gg: ASbGncvlB8f4+iBVrHRd53LmtBxwdHDLOwBTiWRIbd45YFYocDliQiLY99b+a6gchf0
	iMyjdyPC9qrLowyVwakTztKOzrS5c8eap
X-Google-Smtp-Source: AGHT+IEegcO+wovSfhp9z/NpIjr8E7pZIA1J4hOYYj+PTzeqGDpGWNdpUDTc4gpO7KOeubMHQHmfINJxQOz4Xdcz27g=
X-Received: by 2002:a05:6e02:238a:b0:3a7:c997:efdb with SMTP id
 e9e14a558f8ab-3a809342ebcmr3221685ab.17.1733420178610; Thu, 05 Dec 2024
 09:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205165118.153148-1-kyle.meyer@hpe.com>
In-Reply-To: <20241205165118.153148-1-kyle.meyer@hpe.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Dec 2024 09:36:07 -0800
Message-ID: <CAP-5=fXu2Ye22EAOp8jNEaVHmmNSx4gJXNL521ViH5x6w-bLBQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Increase MAX_NR_CPUS to 4096
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:01=E2=80=AFAM Kyle Meyer <kyle.meyer@hpe.com> wrot=
e:
>
> Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.
>
> Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
> and cpus_runtime will increase from 81960B to 163880B.
>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

This is very interesting, thanks Kyle! Just noting, having the same
#define in many places is clearly error prone and there are other
redefinitions of this value:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/bpf_skel/kwork_top.bpf.c?h=3Dperf-tools-next#n21

I wonder I can refactor `tools/lib/perf/cpumap.c` to get rid of that
constant as it is only used when parsing from a file/string.

Could the kwork developers perhaps look at their many uses? The other
uses in the tool may be removable too.

Wrt this change, perhaps bump
`tools/perf/util/bpf_skel/kwork_top.bpf.c` too and then we merge that
while trying to remove other uses.

Thanks,
Ian




> ---
>
> Tested on a 32 socket Sapphire Rapids system with 3840 CPUs.
>
>  tools/lib/perf/include/internal/cpumap.h | 2 +-
>  tools/perf/perf.h                        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/in=
clude/internal/cpumap.h
> index 49649eb51ce4..3cf28522004e 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
>  };
>
>  #ifndef MAX_NR_CPUS
> -#define MAX_NR_CPUS    2048
> +#define MAX_NR_CPUS    4096
>  #endif
>
>  struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index c004dd4e65a3..3cb40965549f 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -3,7 +3,7 @@
>  #define _PERF_PERF_H
>
>  #ifndef MAX_NR_CPUS
> -#define MAX_NR_CPUS                    2048
> +#define MAX_NR_CPUS                    4096
>  #endif
>
>  enum perf_affinity {
> --
> 2.47.1
>

