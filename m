Return-Path: <linux-kernel+bounces-201883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C564A8FC491
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0C01F2171D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB33F9E9;
	Wed,  5 Jun 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUtd4ISU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0C138C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572652; cv=none; b=KI5ws9eDsikMSY4d+2LRCdaUnGO/xIPBh4GiBW8Y33fkv6WQEBtfDftyuu/1s57qZv5XLjeGZjBoUyJICPVW4tNmdaTAGO8XvsA1CxoCy5yCRf+aHmI80fYAcrEDgCANaCau/qwl63T9WcWmW40l84h8+5vvm/obGGovuMcyr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572652; c=relaxed/simple;
	bh=tdIONejAFRv3sLvBPf3dAK2F1P60MyFWiaakQY+FOwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpC/JhhEPtm9LGUtHyqnrNRFwWHm9Ttl+5NnqXOE1u7VxZwYIGqFoq8wvJJnXb45T+nBAwTJtpbgu8bwlTXkfP8ccm+dnAE3nXkk0ZUcsnMhXZE3vLKBJWGMWCz1gjBh1ld/rHzuF5P83A5pe9RBew7KRGlLbxZVJeu+b4kHcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUtd4ISU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A064C4AF09
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717572651;
	bh=tdIONejAFRv3sLvBPf3dAK2F1P60MyFWiaakQY+FOwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RUtd4ISUT256nXOttcIgVu/VCrb6d/J7ndGWGQ9bUrGAg4cgmHGzNsY0UBUWmEOeK
	 9wPZ9+Nw9VIAXQ9Bna61pY5f9d8Avq1kW4pIISOwKPbBAtMx8ApMT6qGsNu9Moon0A
	 JzqGlX5Y8lIuHIUTLublS6y3vFR4MOODGJ3SnN30efY/tKdykENudKRAQqC2d91mCw
	 na0CWq7bttPRvoIgwS/QmIf6ZMJlQ4tv2IdVFm/VKexF5ctfSIAvw1q/k/QdqSHIiI
	 gRscZdJvMVv0G72mGPf3JU4MWMjSi3VQbIw47Z0HbBLFeoWGuwUgw0rxxukq1vSvwr
	 aTnqvNYHgrOWQ==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-374a817a13bso7725705ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:30:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX88qSTfuOmz7gwewoBAOZtYuyf3HDUIIIxMsQ08Qtsoy+0l/HeyVIRyGgJZtFRfHXNwpdhLk7np0EodU55VgmTeBNszwvFj0v47fHo
X-Gm-Message-State: AOJu0YzsJ7/jnNGXUVN2axvX9TOxqi95vp7wjP5xoI8+AdChDvzHAqym
	T+LDDEFpJWdNpcrbFALW/8mZv7ic7r2BQ2cR7HLRvq9qD6270mgpTdXNr6Za8I8VU5cbdkfzVsT
	BsRprJi4bFlm/7waxCVoH7LyeOJBz3inLKPxB
X-Google-Smtp-Source: AGHT+IHR7m8/Ne/rtH9M3WCRRPGTHSXaba3NqVYuxhimwk/JGC16tbocBQWOfRNiQLoA6xPNUAhuPGKbmZ16PnQ4ISQ=
X-Received: by 2002:a05:6e02:1fee:b0:374:a422:baf with SMTP id
 e9e14a558f8ab-374b1ef3102mr19251655ab.12.1717572650560; Wed, 05 Jun 2024
 00:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
 <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7C+rtbbnH+utGkUmwaTzB82zrO8qvotPx9Z6A4fMiO_4A@mail.gmail.com>
In-Reply-To: <CAMgjq7C+rtbbnH+utGkUmwaTzB82zrO8qvotPx9Z6A4fMiO_4A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 5 Jun 2024 00:30:38 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNv06nCpxuvOt50rr4h1cco9Sk+g3nS_ximJFdo54f31Q@mail.gmail.com>
Message-ID: <CAF8kJuNv06nCpxuvOt50rr4h1cco9Sk+g3nS_ximJFdo54f31Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Kairui Song <ryncsn@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 5:40=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, May 31, 2024 at 10:37=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:

> >
> > For specific configuration, I believe that we can get reasonable
> > high-order swap entry allocation success rate for specific use cases.
> > For example, if we only do limited maximum number order-0 swap entries
> > allocation, can we keep high-order clusters?
>
> Isn't limiting order-0 allocation breaks the bottom line that order-0
> allocation is the first class citizen, and should not fail if there is
> space?

We need to have high order and low order swap allocation working. Able
to recover from the swapfile full case.

>
> Just my two cents...
>
> I had a try locally based on Chris's work, allowing order 0 to use
> nonfull_clusters as Ying has suggested, and starting with low order
> and increase the order until nonfull_cluster[order] is not empty, that
> way higher order is just better protected, because unless we ran out
> of free_cluster and nonfull_cluster, direct scan won't happen.

That does not help the Android test case Barry is running because
Android tries to keep the swapfile full.
It will hit the case both empty and nonfull list all used up.
When it performs the low memory kill. There will be a big change in
the ratio of low vs high order swap.
Allocating high order swap entries should be able to recover from that.

>
> More concretely, I applied the following changes, which didn't change
> the code much:
> - In scan_swap_map_try_ssd_cluster, check nonfull_cluster first, then
> free_clusters, then discard_cluster.

I consider high the nonfull list before the empty list. The current
allocation tries to make the HAS_CACHE only swap entry stay in the
disk for a longer time before recycling it. If the folio is still in
swap cache and not dirty, it can skip the write out and directly reuse
the swap slot during reclaim. I am not sure this code path is
important now, it seems when the swap slot is free, it will remove the
HAS_CACHE as well. BTW, I noticed that the discard cluster doesn't
check if the swap cache has a folio point to it. After discarding it
just set the swap_map to 0. I wonder if swap cache has a folio in that
discarded slot that would hit the skip writeback logic. If that is
triggerable, it would be a corruption bug.

The current SSD allocation also has some command said old SSD can
benefit from not writing to the same block too many times to help the
wear leveling. I don't think that is a big deal now, even cheap SD
cards have wear leveling nowadays.

> - If it's order 0, also check for (int i =3D 0; i < SWAP_NR_ORDERS; ++i)
> nonfull_clusters[i] cluster before scan_swap_map_try_ssd_cluster
> returns false.

Ideally to have some option to reserve some high order swap space so
order 0 can't pollute high order clusters.


Chris

>
> A quick test still using the memtier test, but decreased the swap
> device size from 10G to 8g for higher pressure.
>
> Before:
> hugepages-32kB/stats/swpout:34013
> hugepages-32kB/stats/swpout_fallback:266
> hugepages-512kB/stats/swpout:0
> hugepages-512kB/stats/swpout_fallback:77
> hugepages-2048kB/stats/swpout:0
> hugepages-2048kB/stats/swpout_fallback:1
> hugepages-1024kB/stats/swpout:0
> hugepages-1024kB/stats/swpout_fallback:0
> hugepages-64kB/stats/swpout:35088
> hugepages-64kB/stats/swpout_fallback:66
> hugepages-16kB/stats/swpout:31848
> hugepages-16kB/stats/swpout_fallback:402
> hugepages-256kB/stats/swpout:390
> hugepages-256kB/stats/swpout_fallback:7244
> hugepages-128kB/stats/swpout:28573
> hugepages-128kB/stats/swpout_fallback:474
>
> After:
> hugepages-32kB/stats/swpout:31448
> hugepages-32kB/stats/swpout_fallback:3354
> hugepages-512kB/stats/swpout:30
> hugepages-512kB/stats/swpout_fallback:33
> hugepages-2048kB/stats/swpout:2
> hugepages-2048kB/stats/swpout_fallback:0
> hugepages-1024kB/stats/swpout:0
> hugepages-1024kB/stats/swpout_fallback:0
> hugepages-64kB/stats/swpout:31255
> hugepages-64kB/stats/swpout_fallback:3112
> hugepages-16kB/stats/swpout:29931
> hugepages-16kB/stats/swpout_fallback:3397
> hugepages-256kB/stats/swpout:5223
> hugepages-256kB/stats/swpout_fallback:2351
> hugepages-128kB/stats/swpout:25600
> hugepages-128kB/stats/swpout_fallback:2194
>
> High order (256k) swapout rate are significantly higher, 512k is now
> possible, which indicate high orders are better protected, lower
> orders are sacrificed but seems worth it.
>

