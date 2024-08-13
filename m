Return-Path: <linux-kernel+bounces-285548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C29950F67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CCF2856A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4421AAE24;
	Tue, 13 Aug 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJxrfRsY"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535304CE05
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586373; cv=none; b=Uf5Cjd8+IuDxtO6tJTjTD9cK6PqsczoNdN5VfJ38Vp1mVByDf2iJ+r+yhdlIpqQ5laUXK3kp+9m/9XG0gy/rE2fLwR7g7v8IrGnKbDP5zPPMlW6bPBn/5a/fWyM9NFoE3SK9tUeq8/8/7PTjTn2bfFkeVjiS5VmfnJow4Yi8VGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586373; c=relaxed/simple;
	bh=/utoQ7QhykoB3OmPAdObcVrX3Z1NvdQTn/S1AAQy0Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCHPIhdBfarfi9d0j+LV0NHSk1j00bKRV2huV5Qt3JHL3bV5sXtnvggGaZ429M6FDe2JZbulS3MRotPvRSOIn6Nq36cfAFEkGOko3NgqoZkN6Jj0HjpZwO8yXDnKdI6hMSEdUPSuGOWzjltzZ7vM/rpBTNUmumpjsfai+fwwmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJxrfRsY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so756552266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723586369; x=1724191169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue2knfvsIDz2WfMwE8l0p1USDW2XxsIyv+dv3fPEPdw=;
        b=ZJxrfRsYhgXrfOnm6XkGbFX+kH3MaZscvOLRpECnKgR3OajPOPyyEtU4tpuXL5/OpF
         gBrdhrjm25JKbIiOUGsHrfPSGelSlscSpWfEIQ/IbkAtqkGhU8kFh4LSboqbelg1e/bp
         PYfvWJfVYpykq566ub+bIq1KW9pFWMFF+moemMm7rowHCjrY+i+4+/uKWiN8n8gdUn5K
         aCdF0glRxzzU9OEEMZvL3lydKKhRdurt06FKu0AGvAZZx2ybshfMFVN6QHLQEZB/T/8D
         +MW4kfRgp7xVofB44KxxPJ2s0+0UjCIAJYCCwEKigL08a6InAOJ0Tla+GxAqS30Xd5in
         ydUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723586369; x=1724191169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue2knfvsIDz2WfMwE8l0p1USDW2XxsIyv+dv3fPEPdw=;
        b=v/Qfzqt0Bo2plFt/7DldC6IUZjAUcks+ULMBilSuwQ3nOacgWXaGRZwxbouzMBVFPu
         b+IH9ZLxf6RdwJD9LKOXQyO/+BCymFb7dsJSMJVcWBMl6beRyHlE4wrtCMzmZT98g2AN
         CZcS1fTEOugQSHlWxT3O3ZNKR0ufRQVsQx8g+fZ+eOeslClqZYjNbetkv8zuCy7RnOjW
         tm5EZfmyWuFV9GSbmkh+AOq7oCkgSKyMqlcNfGGD7lgv4pxHHebuHDK84PXVgk8uxT1h
         TjB1mnQ5pN2qYV/s7esnyTBBve4CxAL/duTzUKZX+H5zV5IZy/oBnVlS3USPYQH7LlAo
         H3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUJCHSsyuAozEn5ctAwSJo7AzMtTWFHyDj+ZtIQ/8mz7jW7rEBpJyc+spDs6Sav72H6mlgAAql283FmQehBsL7IJY+P4ojCrEjCqiXj
X-Gm-Message-State: AOJu0Ywjh7fL5UvTIl8lz9pvvC/BYCvvxqUksulJGu0zdKwiwjG6wt/+
	5s7K7CM9nDwgjAhB7W0m9BMu8wLeaN3/faZNegevid5PO8sRHnxoePkfb8Zde5aHJeDBDcxaj+j
	QntB0nSYSAmTusQPTGPSpbrC7yt3XSYqIlxLE
X-Google-Smtp-Source: AGHT+IEBRN1K/plIqsXb/K1MyLsFF+JdwEJJrbd5ljEbZT4hYhRrTUCF07gzxpJnAS2CZizqvknI2SOE39UIDkrMt84=
X-Received: by 2002:a17:906:d7d2:b0:a77:f2c5:84bf with SMTP id
 a640c23a62f3a-a8366c2f1eamr54414566b.2.1723586368927; Tue, 13 Aug 2024
 14:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813215358.2259750-1-shakeel.butt@linux.dev>
In-Reply-To: <20240813215358.2259750-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 13 Aug 2024 14:58:51 -0700
Message-ID: <CAJD7tkbm6GxVpRo+9fBreBJxJ=VaQbFoc6PcnQ+ag5bnvqE+qA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The Meta prod is seeing large amount of stalls in memcg stats flush
> from the memcg reclaim code path. At the moment, this specific callsite
> is doing a synchronous memcg stats flush. The rstat flush is an
> expensive and time consuming operation, so concurrent relaimers will
> busywait on the lock potentially for a long time. Actually this issue is
> not unique to Meta and has been observed by Cloudflare [1] as well. For
> the Cloudflare case, the stalls were due to contention between kswapd
> threads running on their 8 numa node machines which does not make sense
> as rstat flush is global and flush from one kswapd thread should be
> sufficient for all. Simply replace the synchronous flush with the
> ratelimited one.
>
> One may raise a concern on potentially using 2 sec stale (at worst)
> stats for heuristics like desirable inactive:active ratio and preferring
> inactive file pages over anon pages but these specific heuristics do not
> require very precise stats and also are ignored under severe memory
> pressure.
>
> More specifically for this code path, the stats are needed for two
> specific heuristics:
>
> 1. Deactivate LRUs
> 2. Cache trim mode
>
> The deactivate LRUs heuristic is to maintain a desirable inactive:active
> ratio of the LRUs. The specific stats needed are WORKINGSET_ACTIVATE*
> and the hierarchical LRU size. The WORKINGSET_ACTIVATE* is needed to
> check if there is a refault since last snapshot and the LRU size are
> needed for the desirable ratio between inactive and active LRUs. See the
> table below on how the desirable ratio is calculated.
>
> /* total     target    max
>  * memory    ratio     inactive
>  * -------------------------------------
>  *   10MB       1         5MB
>  *  100MB       1        50MB
>  *    1GB       3       250MB
>  *   10GB      10       0.9GB
>  *  100GB      31         3GB
>  *    1TB     101        10GB
>  *   10TB     320        32GB
>  */
>
> The desirable ratio only changes at the boundary of 1 GiB, 10 GiB,
> 100 GiB, 1 TiB and 10 TiB. There is no need for the precise and accurate
> LRU size information to calculate this ratio. In addition, if
> deactivation is skipped for some LRU, the kernel will force deactive on
> the severe memory pressure situation.
>
> For the cache trim mode, inactive file LRU size is read and the kernel
> scales it down based on the reclaim iteration (file >> sc->priority) and
> only checks if it is zero or not. Again precise information is not
> needed.
>
> This patch has been running on Meta fleet for several months and we have
> not observed any issues. Please note that MGLRU is not impacted by this
> issue at all as it avoids rstat flushing completely.
>
> Link: https://lore.kernel.org/all/6ee2518b-81dd-4082-bdf5-322883895ffc@ke=
rnel.org [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Just curious, does Jesper's patch help with this problem?

> ---
> Changes since v1:
> - Updated the commit message.
>
>  mm/vmscan.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 008b62abf104..82318464cd5e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2282,10 +2282,11 @@ static void prepare_scan_control(pg_data_t *pgdat=
, struct scan_control *sc)
>         target_lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat)=
;
>
>         /*
> -        * Flush the memory cgroup stats, so that we read accurate per-me=
mcg
> -        * lruvec stats for heuristics.
> +        * Flush the memory cgroup stats in rate-limited way as we don't =
need
> +        * most accurate stats here. We may switch to regular stats flush=
ing
> +        * in the future once it is cheap enough.
>          */
> -       mem_cgroup_flush_stats(sc->target_mem_cgroup);
> +       mem_cgroup_flush_stats_ratelimited(sc->target_mem_cgroup);
>
>         /*
>          * Determine the scan balance between anon and file LRUs.
> --
> 2.43.5
>

