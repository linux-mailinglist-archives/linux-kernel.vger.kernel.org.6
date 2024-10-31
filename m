Return-Path: <linux-kernel+bounces-390800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0189A9B7EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65BD5B21649
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687319FA64;
	Thu, 31 Oct 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hD6+5RZ5"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1513342F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389120; cv=none; b=AoKCE01GURQl5MSlDaNCKU340/+LhIp0pDZG/p8ROUk3T8yamgdi01azRDzJ1Xp+Tl8u1fY05ShIunuusYV3ovGnxinRnOWyF7OdqHNc+h0GJSUL1c4mRLtGnMBGVNLwpbIltCq/vHFadKassaqjt4nMAzrn/BP/j8romwZm4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389120; c=relaxed/simple;
	bh=gQViawQMTDAFpxE6eNjJ/QD7t3JwqVt9vYK+d/7JwH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqj8uTB6oo7/rz9hGgOniJt903MBe1Yl6QiCPBS6g0XEknvrZWFcqiFk19JNBNP7KdQlrxo1n7MMuSl0ya/IaUuIJPyx1hKEncsac+zxHFmPKNnzygOHdk41MpVwy4i02ln2J7sRdPty4lXGlbRE/Du3NT9fyz0tDNZ7mqBfpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hD6+5RZ5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b13ff3141aso79534985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1730389116; x=1730993916; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9gWs9upHHF9CR2nmJmlZ16u/IpRbll0Yw0eHTCqcxKQ=;
        b=hD6+5RZ5mRfRHJoDwijR1AOWEMVd5xEDRTBv77bRSC7rOjhOjrrP85OTP8pfEtAseY
         RfCD0c59LjuSnNPw4y2SK6BVGYPNPAkNP6bCrfRJszY+cGhnEP+l+YLhdhcf66AVxVPV
         kAmFBk9RQCle8x3AFNArmRts50HC0KjKChJiiI36I2y/g6Pnjvau6ibWFExjisTzFKHW
         lX3piCoiTWTzyMAj1CPrO7KGWDyVfZT9pdRwyijIki4gOJhp/wOj5yCfdGc2sXySco9E
         Byz19WAjLHPMz1QCef2S4Q4qME5F6uhZ6cPOKQ/55c11R5alOhEVUQW1FwVXnGqgWc5Y
         nmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389116; x=1730993916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gWs9upHHF9CR2nmJmlZ16u/IpRbll0Yw0eHTCqcxKQ=;
        b=XM3Z06z+l71qY6YgV+OKFzUIwCM18XW2o8C2K94Nq6u9x8gK20Qwf1IKlC55z7sWul
         9OwTaiFzMqDVm/1pdtQT74p+H4Q8uuOB540QpYSJgB7JLRV3D7HJNuN+81R+pTpAUuEd
         9Egx8l5QUTKtEAIuENEVWRyVsUdD7+SigKAXRRc4CL31JxTVuOgbcmYZZvIyo3bp5j6a
         ZclYNw3JuKdoKKmaQhH3K3KPWZwJOd1Tkj2IYoi9I4+8qQwUtjW6tkRJpSpq1Z1d8wX8
         25VweTAexjyMWfwSBQA4K+Pxo2JXsDFEskEtUGAyY8nGLydv/gkUFIz0zMef3RHu/ist
         NbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCURFYjAzkZTXq5vhyNKULwN75AVQ4swWbGn5VFZSRa79XGW5kYHnyXeZz/UlwbqbTIP5D4iSWLKRfbwuAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0tnAacjmZSjj/5CqC6b+qddIJcAovON2zgq+nDNwgRujX1O5
	EFcLWeCs29OM5LDosBq0nlF109PKUWLoeV5dnRQN6kse2MperiK9J3pGY/g3lNs=
X-Google-Smtp-Source: AGHT+IEycZbJnyH99AKtQ3mz3WwXxE1TxDuqTuwE9LZ0+n/8BJk+f+Aj1aFZZEyuEntgRoxjJFMrtw==
X-Received: by 2002:a05:620a:2996:b0:7b1:55ae:a9bb with SMTP id af79cd13be357-7b1aed6f6a3mr886139685a.13.1730389115774;
        Thu, 31 Oct 2024 08:38:35 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a83159sm78740285a.116.2024.10.31.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:38:34 -0700 (PDT)
Date: Thu, 31 Oct 2024 11:38:30 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	Kairui Song <kasong@tencent.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
Message-ID: <20241031153830.GA799903@cmpxchg.org>
References: <20241027001444.3233-1-21cnbao@gmail.com>
 <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com>
 <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
 <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com>
 <CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
 <c76635d7-f382-433a-8900-72bca644cdaa@gmail.com>
 <CAJD7tkYSRCjtEwP=o_n_ZhdfO8nga-z-a=RirvcKL7AYO76XJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYSRCjtEwP=o_n_ZhdfO8nga-z-a=RirvcKL7AYO76XJw@mail.gmail.com>

On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
> On Wed, Oct 30, 2024 at 2:13 PM Usama Arif <usamaarif642@gmail.com> wrote:
> > On 30/10/2024 21:01, Yosry Ahmed wrote:
> > > On Wed, Oct 30, 2024 at 1:25 PM Usama Arif <usamaarif642@gmail.com> wrote:
> > >>>> I am not sure that the approach we are trying in this patch is the right way:
> > >>>> - This patch makes it a memcg issue, but you could have memcg disabled and
> > >>>> then the mitigation being tried here wont apply.
> > >>>
> > >>> Is the problem reproducible without memcg? I imagine only if the
> > >>> entire system is under memory pressure. I guess we would want the same
> > >>> "mitigation" either way.
> > >>>
> > >> What would be a good open source benchmark/workload to test without limiting memory
> > >> in memcg?
> > >> For the kernel build test, I can only get zswap activity to happen if I build
> > >> in cgroup and limit memory.max.
> > >
> > > You mean a benchmark that puts the entire system under memory
> > > pressure? I am not sure, it ultimately depends on the size of memory
> > > you have, among other factors.
> > >
> > > What if you run the kernel build test in a VM? Then you can limit is
> > > size like a memcg, although you'd probably need to leave more room
> > > because the entire guest OS will also subject to the same limit.
> > >
> >
> > I had tried this, but the variance in time/zswap numbers was very high.
> > Much higher than the AMD numbers I posted in reply to Barry. So found
> > it very difficult to make comparison.
> 
> Hmm yeah maybe more factors come into play with global memory
> pressure. I am honestly not sure how to test this scenario, and I
> suspect variance will be high anyway.
> 
> We can just try to use whatever technique we use for the memcg limit
> though, if possible, right?

You can boot a physical machine with mem=1G on the commandline, which
restricts the physical range of memory that will be initialized.
Double check /proc/meminfo after boot, because part of that physical
range might not be usable RAM.

I do this quite often to test physical memory pressure with workloads
that don't scale up easily, like kernel builds.

> > >>>> - Instead of this being a large folio swapin issue, is it more of a readahead
> > >>>> issue? If we zswap (without the large folio swapin series) and change the window
> > >>>> to 1 in swap_vma_readahead, we might see an improvement in linux kernel build time
> > >>>> when cgroup memory is limited as readahead would probably cause swap thrashing as
> > >>>> well.

+1

I also think there is too much focus on cgroup alone. The bigger issue
seems to be how much optimistic volume we swap in when we're under
pressure already. This applies to large folios and readahead; global
memory availability and cgroup limits.

It happens to manifest with THP in cgroups because that's what you
guys are testing. But IMO, any solution to this problem should
consider the wider scope.

> > >>> I think large folio swapin would make the problem worse anyway. I am
> > >>> also not sure if the readahead window adjusts on memory pressure or
> > >>> not.
> > >>>
> > >> readahead window doesnt look at memory pressure. So maybe the same thing is being
> > >> seen here as there would be in swapin_readahead?
> > >
> > > Maybe readahead is not as aggressive in general as large folio
> > > swapins? Looking at swap_vma_ra_win(), it seems like the maximum order
> > > of the window is the smaller of page_cluster (2 or 3) and
> > > SWAP_RA_ORDER_CEILING (5).
> > Yes, I was seeing 8 pages swapin (order 3) when testing. So might
> > be similar to enabling 32K mTHP?
> 
> Not quite.

Actually, I would expect it to be...

> > > Also readahead will swapin 4k folios AFAICT, so we don't need a
> > > contiguous allocation like large folio swapin. So that could be
> > > another factor why readahead may not reproduce the problem.
> 
> Because of this ^.

...this matters for the physical allocation, which might require more
reclaim and compaction to produce the 32k. But an earlier version of
Barry's patch did the cgroup margin fallback after the THP was already
physically allocated, and it still helped.

So the issue in this test scenario seems to be mostly about cgroup
volume. And then 8 4k charges should be equivalent to a singular 32k
charge when it comes to cgroup pressure.

