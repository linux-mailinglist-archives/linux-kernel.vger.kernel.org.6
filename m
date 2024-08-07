Return-Path: <linux-kernel+bounces-277752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1C94A5D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B109A1C213DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6421DD3B2;
	Wed,  7 Aug 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQDGtJfB"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2F745CB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027231; cv=none; b=r2e5W9xgRSZr0wm7tmC5MILAH3OVkal/9bhKKRY4MVuBWDu/kUen6+UF3Nz0EwZTrGV3O+tVAB2liaUw/yjJSvcraL2n/fCwy16eCkPT9mLIVPT5JYV3w7CnZJxxPhwfD0sxHxRbgOVYUypreMZSJoF+hlWAfsSoP07sG55ndP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027231; c=relaxed/simple;
	bh=xYe/wZvsHHOBYCeOBS1yubrVFmCxXc1PheIPiZ/qc2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iH4DXc43BLc6dzXfCWB+4qVsg27w9u1/J2zemnVjhMow49DXbzTuC9yS0u60Ao0/X4v/7TVpn5IUcuZVHnrtn33vywldzRCKT1iWti5DkTEHMm+yUkCaIuuam0dcmX866rgNbaswBYItQzGNLHcjvmX85U9I03bgmGLrunBeQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQDGtJfB; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8225a1f4d5fso564559241.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723027229; x=1723632029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jMeE7K9O2DS7pnDAgDvtLDpZJCQRKll4W9o5RnUXec=;
        b=RQDGtJfBeylhtrkVKUSGCfn2epE4mn5EU3x2DFSvJBvL7hazanrYZ/WvItQvpnJF/x
         Z+WLcuDF3Cj1YWx17fzFFSqa0/MFSU5M9MFckb3o8MMyrkZe+HdbdcwDuHirlYtuwtpW
         dv9dD1QADkFpeIVyDEOspkZZDd0GmPiVxmWAqTdAEjnOw6NzUBi7Zs20DCguX9UuUiv+
         FKTJg1BNACRU8DH+GKLP8iDBoValrGh9Kk7LHLKiwheAT//RcKDsJEtwtY/JLRqlIX/8
         ipmhbEk7yz3X0GvX1+feBS6U84PyI0qOgwvz7qOS28CD42c/+w1qLHvgSjZgFvbQ1jgd
         ZdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027229; x=1723632029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jMeE7K9O2DS7pnDAgDvtLDpZJCQRKll4W9o5RnUXec=;
        b=MTPYOZlv18OeSuNGuoqdboHud3ZR4K9HsPXy3og8h4ENdzNmJD5LXx50Dx+1vHQOUb
         049MRJwjSury0yCiuq5tMJI58j54PjW/IhlJkXaX1NVf69r0cdOkpQzqkbhvD4ZsDi4s
         x6hQT2AZaKoDYMSyUbMH2KOSlWPQTjmNFldHxksDoRZfZETrfLve5rHLvCylAV9vJq72
         ZhRX5NcseNz58bvBGMdnTSakjYMB0jLhiMynzAiWpo1Fz4iHP2j28Z4bMO6Mmf9fLDJJ
         mqDnjQpM1h0f8UevILzHe8bCvN3e3S7/Y0BNr+VliO6EsB3+vgoSuWK+j9EsXOXOu+bE
         W5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWI7HGWwye6VS9ipaIpE2MRQni8vrYWLICDL8F/IUC8FSZoZROgC8yhkRU+w1CEDumw7+nO4WIucZ13hpVNINNrCriXKprnID3CCFq
X-Gm-Message-State: AOJu0YyWal1LqqE58OHGMOTM/KiYgM4G81hnZFWM2rjboBGpyN34KxkM
	U3J56pipY3uAiwLNGaqWwuTg4hyeTGTFPy8Mk7Yxa1aY2pEQ0nyJwQOAyIUFCl4vm8ognUuoDuc
	q4OZDClOCmg94F728eu+UEvBBKvffIHR0/r7i
X-Google-Smtp-Source: AGHT+IFuS5qpjfEJqkpSA7E8x1j+gUoAcHrZHKoMm8dtxqTwXRqw1Z4JWF+QkTbzIvt+OS+X/mBI1hTuVMHevDtOwyw=
X-Received: by 2002:a05:6102:6d1:b0:48f:95cd:e601 with SMTP id
 ada2fe7eead31-4945bf055e0mr16144512137.25.1723027228674; Wed, 07 Aug 2024
 03:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807025627.37419-1-qiwu.chen@transsion.com>
In-Reply-To: <20240807025627.37419-1-qiwu.chen@transsion.com>
From: Marco Elver <elver@google.com>
Date: Wed, 7 Aug 2024 12:39:50 +0200
Message-ID: <CANpmjNMvdkn8Zw4SQy1n2e+HHvpg33fC9xmYkFD9fi6THNj_tQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: print the elapsed time for allocated/freed track
To: "qiwu.chen" <qiwuchen55@gmail.com>, Alexander Potapenko <glider@google.com>
Cc: dvyukov@google.com, akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, "qiwu.chen" <qiwu.chen@transsion.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 04:56, qiwu.chen <qiwuchen55@gmail.com> wrote:
>
> Print the elapsed time for the allocated or freed track,
> which can be useful in some debugging scenarios.
>
> Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>

Reviewed-by: Marco Elver <elver@google.com>

Thanks for the changes! I think this is more generally useful and much
simpler than v1.

> ---
>  mm/kfence/report.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index c509aed326ce..73a6fe42845a 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -16,6 +16,7 @@
>  #include <linux/sprintf.h>
>  #include <linux/stacktrace.h>
>  #include <linux/string.h>
> +#include <linux/sched/clock.h>
>  #include <trace/events/error_report.h>
>
>  #include <asm/kfence.h>
> @@ -108,11 +109,14 @@ static void kfence_print_stack(struct seq_file *seq, const struct kfence_metadat
>         const struct kfence_track *track = show_alloc ? &meta->alloc_track : &meta->free_track;
>         u64 ts_sec = track->ts_nsec;
>         unsigned long rem_nsec = do_div(ts_sec, NSEC_PER_SEC);
> +       u64 interval_nsec = local_clock() - meta->alloc_track.ts_nsec;
> +       unsigned long rem_interval_nsec = do_div(interval_nsec, NSEC_PER_SEC);
>
>         /* Timestamp matches printk timestamp format. */
> -       seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus:\n",
> +       seq_con_printf(seq, "%s by task %d on cpu %d at %lu.%06lus (%lu.%06lus ago):\n",
>                        show_alloc ? "allocated" : "freed", track->pid,
> -                      track->cpu, (unsigned long)ts_sec, rem_nsec / 1000);
> +                      track->cpu, (unsigned long)ts_sec, rem_nsec / 1000,
> +                      (unsigned long)interval_nsec, rem_interval_nsec / 1000);
>
>         if (track->num_stack_entries) {
>                 /* Skip allocation/free internals stack. */
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240807025627.37419-1-qiwu.chen%40transsion.com.

