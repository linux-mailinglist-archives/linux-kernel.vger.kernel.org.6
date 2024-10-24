Return-Path: <linux-kernel+bounces-380098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5149AE8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2242938E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818D18A957;
	Thu, 24 Oct 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hat43mK9"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1571E282C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780196; cv=none; b=SZ614UyMfyTPe+xDasYMw3mcAxogM4DXjHxND7sCJeHdTtiELKx4IEVdIP6hZ/AH/oRIsXP/lN534mqt/hKbsmpwrPmVdrSad86RKSFnMBqpxUQaYHURtKISEzV0Zbn1fDKL3KflmsR96n73TjIJnpA5jzisUtai/mmUC3CG6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780196; c=relaxed/simple;
	bh=Z+AZwQPGvNS99iGWsl15uWDIwTEO1TQJ3OC/4sGGsyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/TipYYj1FQcYPEGw6omKklFltsaqIRIFAbPUlwiclq3u8TfeBySNWJw9UNj5F7GkdLtayGwPDDvJBYCbEBAW5MIinxYebjcHme/0QCJHhQtMcTaYnjL0b/nQEpaTBHXHWAx8ZBZBR7YiwInUXrZF7CAA9+yThAQ9Z3xc6sevY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hat43mK9; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc05007daso538120eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729780191; x=1730384991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jGzft1YUen5dBqLhCOJgDrbvcX8bu3ygkdyqno3M1gM=;
        b=hat43mK9JnybGfYpfZMVSiEcLbUT9fr0SBI42PT6zytQqHqIE83oIqJEgYMk71q7xV
         5MmGEQofVynoDLpWIe4TzBOdvr+zc//ladw02T2dbfDdYOoY6GUR72GH+o9LIn/Lzw0F
         hUw3/SE2MRh5ymPLYuaSDfA8w3a7vDDX4DRcYrNAoPd7vwfLAjrCSonCPpDdtmqps+vE
         +bFp2tT60dNzJeV7Lcrc4wUaboQ3YMnk6a2uFBHw4QtAj+GFgYeJFaNeZldgl47zjYeZ
         y+6+Vw6ySFVdXzM9H1dn2ELD2ZlLU5AEi5LJnv9xlsPVlNTUXOzcxR3+KQTCeC8+p9aY
         zJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780191; x=1730384991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGzft1YUen5dBqLhCOJgDrbvcX8bu3ygkdyqno3M1gM=;
        b=ZhRHpavMVvRofSls64vtNQzD1aN8pv7YC/ZXVJL1evA+HAOw7LVR8wYQGIkANCBYM0
         xLpcsN7hrxqfgD1JBShHHcFsQrWoBfoj1f16OpFSS5CzDQX8vDA5M6VMb71zBVRxHNne
         MIYpRyKPc1n2/FZ6OKv4pyMF3fFvEHvGfsSEWt3miFFG0z5TGIfxhxoQeM9AT05DiN8s
         CMib26kOxS2DN8uy64r28Sgp99od6vOoWq5MPMRe//rU6paP1D8Gkr3nZnsVEmUwbBjh
         jOOfxqXPq5rSalfDaWnMbLfiE3oeszZeV+XkBp4ec1zVQD2UT/069BrE97GN1dLC6Q5k
         4cKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4e5FSU9LgnXUfZFiK2F2DRMcgu3pLo2zJGl/No9GwjZ3ovChU2RQl+j22r1GWYJXqdzcSi+Uavl4raIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUVL6EAe92MDcSipAV6QryLtYXKM24lVvchMtfjP7HJrIgk+M
	+fC3GQHQ9fzmKKPx+U5sfrmOKkxhHT+B4DZUYQ9eYfpntS3JZb3FHNKgROqD6rM=
X-Google-Smtp-Source: AGHT+IGFKnE14XSmpiPPttQLO4SqKVkktAh1DaIv9DpXUOOMPhP25ArsgmyVdcR0G8obfOO2fInY3w==
X-Received: by 2002:a05:6358:419f:b0:1c3:77fc:3bb6 with SMTP id e5c5f4694b2df-1c3d818f7bcmr463942655d.21.1729780190633;
        Thu, 24 Oct 2024 07:29:50 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008acd46sm50609926d6.18.2024.10.24.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:29:47 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:29:42 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, david@redhat.com, hanchuanhua@oppo.com,
	kanchana.p.sridhar@intel.com, kernel-team@meta.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, nphamcs@gmail.com,
	riel@surriel.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
	shakeel.butt@linux.dev, v-songbaohua@oppo.com, willy@infradead.org,
	ying.huang@intel.com, yosryahmed@google.com
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
Message-ID: <20241024142942.GA279597@cmpxchg.org>
References: <cb3f67c3-e8d3-4398-98c9-d5aee134fd4c@gmail.com>
 <20241023233548.23348-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023233548.23348-1-21cnbao@gmail.com>

On Thu, Oct 24, 2024 at 12:35:48PM +1300, Barry Song wrote:
> On Thu, Oct 24, 2024 at 9:36 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 8:47 AM Usama Arif <usamaarif642@gmail.com> wrote:
> > >
> > >
> > >
> > > On 23/10/2024 19:52, Barry Song wrote:
> > > > On Thu, Oct 24, 2024 at 7:31 AM Usama Arif <usamaarif642@gmail.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 23/10/2024 19:02, Yosry Ahmed wrote:
> > > >>> [..]
> > > >>>>>> I suspect the regression occurs because you're running an edge case
> > > >>>>>> where the memory cgroup stays nearly full most of the time (this isn't
> > > >>>>>> an inherent issue with large folio swap-in). As a result, swapping in
> > > >>>>>> mTHP quickly triggers a memcg overflow, causing a swap-out. The
> > > >>>>>> next swap-in then recreates the overflow, leading to a repeating
> > > >>>>>> cycle.
> > > >>>>>>
> > > >>>>>
> > > >>>>> Yes, agreed! Looking at the swap counters, I think this is what is going
> > > >>>>> on as well.
> > > >>>>>
> > > >>>>>> We need a way to stop the cup from repeatedly filling to the brim and
> > > >>>>>> overflowing. While not a definitive fix, the following change might help
> > > >>>>>> improve the situation:
> > > >>>>>>
> > > >>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > >>>>>>
> > > >>>>>> index 17af08367c68..f2fa0eeb2d9a 100644
> > > >>>>>> --- a/mm/memcontrol.c
> > > >>>>>> +++ b/mm/memcontrol.c
> > > >>>>>>
> > > >>>>>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct folio
> > > >>>>>> *folio, struct mm_struct *mm,
> > > >>>>>>                 memcg = get_mem_cgroup_from_mm(mm);
> > > >>>>>>         rcu_read_unlock();
> > > >>>>>>
> > > >>>>>> -       ret = charge_memcg(folio, memcg, gfp);
> > > >>>>>> +       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
> > > >>>>>> MEMCG_CHARGE_BATCH)
> > > >>>>>> +               ret = -ENOMEM;
> > > >>>>>> +       else
> > > >>>>>> +               ret = charge_memcg(folio, memcg, gfp);
> > > >>>>>>
> > > >>>>>>         css_put(&memcg->css);
> > > >>>>>>         return ret;
> > > >>>>>> }
> > > >>>>>>
> > > >>>>>
> > > >>>>> The diff makes sense to me. Let me test later today and get back to you.
> > > >>>>>
> > > >>>>> Thanks!
> > > >>>>>
> > > >>>>>> Please confirm if it makes the kernel build with memcg limitation
> > > >>>>>> faster. If so, let's
> > > >>>>>> work together to figure out an official patch :-) The above code hasn't consider
> > > >>>>>> the parent memcg's overflow, so not an ideal fix.
> > > >>>>>>
> > > >>>>
> > > >>>> Thanks Barry, I think this fixes the regression, and even gives an improvement!
> > > >>>> I think the below might be better to do:
> > > >>>>
> > > >>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > >>>> index c098fd7f5c5e..0a1ec55cc079 100644
> > > >>>> --- a/mm/memcontrol.c
> > > >>>> +++ b/mm/memcontrol.c
> > > >>>> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
> > > >>>>                 memcg = get_mem_cgroup_from_mm(mm);
> > > >>>>         rcu_read_unlock();
> > > >>>>
> > > >>>> -       ret = charge_memcg(folio, memcg, gfp);
> > > >>>> +       if (folio_test_large(folio) &&
> > > >>>> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
> > > >>>> +               ret = -ENOMEM;
> > > >>>> +       else
> > > >>>> +               ret = charge_memcg(folio, memcg, gfp);
> > > >>>>
> > > >>>>         css_put(&memcg->css);
> > > >>>>         return ret;
> > > >>>>
> > > >>>>
> > > >>>> AMD 16K+32K THP=always
> > > >>>> metric         mm-unstable      mm-unstable + large folio zswapin series    mm-unstable + large folio zswapin + no swap thrashing fix
> > > >>>> real           1m23.038s        1m23.050s                                   1m22.704s
> > > >>>> user           53m57.210s       53m53.437s                                  53m52.577s
> > > >>>> sys            7m24.592s        7m48.843s                                   7m22.519s
> > > >>>> zswpin         612070           999244                                      815934
> > > >>>> zswpout        2226403          2347979                                     2054980
> > > >>>> pgfault        20667366         20481728                                    20478690
> > > >>>> pgmajfault     385887           269117                                      309702
> > > >>>>
> > > >>>> AMD 16K+32K+64K THP=always
> > > >>>> metric         mm-unstable      mm-unstable + large folio zswapin series   mm-unstable + large folio zswapin + no swap thrashing fix
> > > >>>> real           1m22.975s        1m23.266s                                  1m22.549s
> > > >>>> user           53m51.302s       53m51.069s                                 53m46.471s
> > > >>>> sys            7m40.168s        7m57.104s                                  7m25.012s
> > > >>>> zswpin         676492           1258573                                    1225703
> > > >>>> zswpout        2449839          2714767                                    2899178
> > > >>>> pgfault        17540746         17296555                                   17234663
> > > >>>> pgmajfault     429629           307495                                     287859
> > > >>>>
> > > >>>
> > > >>> Thanks Usama and Barry for looking into this. It seems like this would
> > > >>> fix a regression with large folio swapin regardless of zswap. Can the
> > > >>> same result be reproduced on zram without this series?
> > > >>
> > > >>
> > > >> Yes, its a regression in large folio swapin support regardless of zswap/zram.
> > > >>
> > > >> Need to do 3 tests, one with probably the below diff to remove large folio support,
> > > >> one with current upstream and one with upstream + swap thrashing fix.
> > > >>
> > > >> We only use zswap and dont have a zram setup (and I am a bit lazy to create one :)).
> > > >> Any zram volunteers to try this?
> > > >
> > > > Hi Usama,
> > > >
> > > > I tried a quick experiment:
> > > >
> > > > echo 1 > /sys/module/zswap/parameters/enabled
> > > > echo 0 > /sys/module/zswap/parameters/enabled
> > > >
> > > > This was to test the zRAM scenario. Enabling zswap even
> > > > once disables mTHP swap-in. :)
> > > >
> > > > I noticed a similar regression with zRAM alone, but the change resolved
> > > > the issue and even sped up the kernel build compared to the setup without
> > > > mTHP swap-in.
> > >
> > > Thanks for trying, this is amazing!
> > > >
> > > > However, I’m still working on a proper patch to address this. The current
> > > > approach:
> > > >
> > > > mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio))
> > > >
> > > > isn’t sufficient, as it doesn’t cover cases where group A contains group B, and
> > > > we’re operating within group B. The problem occurs not at the boundary of
> > > > group B but at the boundary of group A.
> > >
> > > I am not sure I completely followed this. As MEMCG_CHARGE_BATCH=64, if we are
> > > trying to swapin a 16kB page, we basically check if atleast 64/4 = 16 folios can be
> > > charged to cgroup, which is reasonable. If we try to swapin a 1M folio, we just
> > > check if we can charge atleast 1 folio. Are you saying that checking just 1 folio
> > > is not enough in this case and can still cause thrashing, i.e we should check more?
> >
> > My understanding is that cgroups are hierarchical. Even if we don’t
> > hit the memory
> >  limit of the folio’s direct memcg, we could still reach the limit of
> > one of its parent
> > memcgs. Imagine a structure like:
> >
> > /sys/fs/cgroup/a/b/c/d
> >
> > If we’re compiling the kernel in d, there’s a chance that while d
> > isn’t at its limit, its
> > parents (c, b, or a) could be. Currently, the check only applies to d.
> 
> To clarify, I mean something like this:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 17af08367c68..cc6d21848ee8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4530,6 +4530,29 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  	return 0;
>  }
> 
> +/*
> + * When the memory cgroup is nearly full, swapping in large folios can
> + * easily lead to swap thrashing, as the memcg operates on the edge of
> + * being full. We maintain a margin to allow for quick fallback to
> + * smaller folios during the swap-in process.
> + */
> +static inline bool mem_cgroup_swapin_margin_protected(struct mem_cgroup *memcg,
> +		struct folio *folio)
> +{
> +	unsigned int nr;
> +
> +	if (!folio_test_large(folio))
> +		return false;
> +
> +	nr = max_t(unsigned int, folio_nr_pages(folio), MEMCG_CHARGE_BATCH);
> +	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> +		if (mem_cgroup_margin(memcg) < nr)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
>   * @folio: folio to charge.
> @@ -4547,7 +4570,8 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  {
>  	struct mem_cgroup *memcg;
>  	unsigned short id;
> -	int ret;
> +	int ret = -ENOMEM;
> +	bool margin_prot;
> 
>  	if (mem_cgroup_disabled())
>  		return 0;
> @@ -4557,9 +4581,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
>  	memcg = mem_cgroup_from_id(id);
>  	if (!memcg || !css_tryget_online(&memcg->css))
>  		memcg = get_mem_cgroup_from_mm(mm);
> +	margin_prot = mem_cgroup_swapin_margin_protected(memcg, folio);
>  	rcu_read_unlock();
> 
> -	ret = charge_memcg(folio, memcg, gfp);
> +	if (!margin_prot)
> +		ret = charge_memcg(folio, memcg, gfp);
> 
>  	css_put(&memcg->css);
>  	return ret;

I'm not quite following.

The charging code DOES the margin check. If you just want to avoid
reclaim, pass gfp without __GFP_DIRECT_RECLAIM, and it will return
-ENOMEM if there is no margin.

alloc_swap_folio() passes the THP mask, which should not include the
reclaim flag per default (GFP_TRANSHUGE_LIGHT). Unless you run with
defrag=always. Is that what's going on?

