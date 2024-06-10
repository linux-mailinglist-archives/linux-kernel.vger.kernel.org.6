Return-Path: <linux-kernel+bounces-208486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB29025A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6808728A93C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466C513DDCD;
	Mon, 10 Jun 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Chzo6pAQ"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750A582871
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033323; cv=none; b=qrVYIn7oIrB7F/IKU50XmeKo4hrPUoxXVsTZY0oPGE2KiJLRMiGaGyYwRtjgoh+Rx6QUQrOItldwrqWZIarJPADKI7yW3mMF3hy7mkAq7p8o6u0lgfP0t/6Azy/+qkVICWMpYFoIB6T5P+S4yddG4DU2Vgjej3jtm9stlAlVqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033323; c=relaxed/simple;
	bh=Eg5MXIxFmskfceFeoSMjW5JaXWFMIN6Ka4da5DFW/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwR9cG9gunxGxrEioozT3S5O7d0nQ2yn7dT9pObVXhTIS9j041QoVadXRyRZK6nU+Spc+nZIvb6wIn4nTKAy+LOUtE13rDjW4R4IgxFg7b7Ol7Ynm4w6VaXeWDVdx3rpX/RooRP5b6/ZdYztkbpGggD7PAbTkCfG1QvA7fb16VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Chzo6pAQ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d226c5a157so874302b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1718033319; x=1718638119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fUARyIEpm9mcxUlH5YwBD2HZnjCRC5iHgPIZ1qpIAq8=;
        b=Chzo6pAQE8IwuUce79bz/A55Pv2UyP1kHYEvuoz0MDnGdJPeGHUlZPj8GIB8FPGCIZ
         oYiezWs0nYLqiPjz5gTirG4EJQ+JXid0PwE5HNQv0Ssr+jsSTEHoTg5eHvAn1/iMMkrj
         F7BGBR5Cb/A+r8kpBtwnsHEpoKbtW7lZ3xcbjqAjvn7JaoT6vTMxgoYPBN/3tRWavq6z
         wdOfet7jU+/BbVT0iAyvOtWV84ivXzgHDE+7bNugF/2UXoVwBNY3gRNIQDBlL5GjPHlj
         pMlIR1umgFX7QXqEpwGDprtka8uFG3KmkoWIfCaX9glviQU3wdIEO8eENSKVctRaQ5u7
         afWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718033319; x=1718638119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUARyIEpm9mcxUlH5YwBD2HZnjCRC5iHgPIZ1qpIAq8=;
        b=ed2iNHp/MNHVZOSc97QmXplnm8OBNNv8oAWE7zM1Oxurm9rJnCGpWzv43pvXlBWRWw
         seeMcPeXfn7c5+cKZmPQmU1rKPMBxwvaWXbod/jMP9+mXQOcPH+87KQcVNnEOOT08F3h
         +I45m8ZHzMHfuBIoTcMWyAEbSEgpCgAEnjJMGfd+fp36lKCIZT5K6f4z8SMLGznYs4so
         I5JUcD9Zdblre0hCKaCZBRWd/FK4o65DT1ImWChgtQM3EgP78fE4jL6/ZJLGxm1yCoo4
         o9Fi8aLXqMmtM8NeyQoASaqb2zFRIRGfjDP/wXuBDCQc4VN4/X0yGnlg2yhoKzjJHM9E
         HzSg==
X-Forwarded-Encrypted: i=1; AJvYcCUUzaSHI1tg1T1aJESsRv4suIKhThASn2PNJa3dQuQhvsclIsNg/3qdOWzCQRoSDkateiKnNg/GyDzDet3QyC8gThVn5AtgufQ0Rmpx
X-Gm-Message-State: AOJu0Yz5IDv4n4xvYeVG3qT1cZcEAcGHgGvodFc1bX32XpLiFUS5cJYD
	OabLIlJr2Qf+WvMK3bUoqX1O6ayGGXIRSg6Ok/zbp7YyywZYuxOzBSwWdCqBb00=
X-Google-Smtp-Source: AGHT+IFyT07TFV5Ytc4/MXNzKU3Je9EmZJpvpo4etZVRacJKdSABCIQxDVPoD1j3wxRiIfTWjsN/nQ==
X-Received: by 2002:a05:6808:1596:b0:3c9:6e55:e24c with SMTP id 5614622812f47-3d210d27ed6mr12167562b6e.11.1718033319250;
        Mon, 10 Jun 2024 08:28:39 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79557127817sm210991185a.40.2024.06.10.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 08:28:38 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:28:33 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
	Chun-Tse Shao <ctshao@google.com>
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20240610152833.GA2298848@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>
 <20240513160331.GA320190@cmpxchg.org>
 <CAOUHufaCQPW=p_r-Sg4oeDgtxwEGp6E5j1MhU3OCrTLUZTymZA@mail.gmail.com>
 <20240513190400.GA2270702@cmpxchg.org>
 <CAOUHufb8Daf276SdA2L=fq=LeAWN-JE08F5zW3buC1CBAoS=Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufb8Daf276SdA2L=fq=LeAWN-JE08F5zW3buC1CBAoS=Ww@mail.gmail.com>

On Tue, Jun 04, 2024 at 10:53:55PM -0600, Yu Zhao wrote:
> On Mon, May 13, 2024 at 1:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Mon, May 13, 2024 at 12:10:04PM -0600, Yu Zhao wrote:
> > > On Mon, May 13, 2024 at 10:03 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > On Fri, May 10, 2024 at 11:14:43PM -0600, Yu Zhao wrote:
> > > > > This series significantly regresses Android and ChromeOS under memory
> > > > > pressure. THPs are virtually nonexistent on client devices, and IIRC,
> > > > > it was mentioned in the early discussions that potential regressions
> > > > > for such a case are somewhat expected?
> > > >
> > > > This is not expected for the 10 patches here. You might be referring
> > > > to the discussion around the huge page allocator series, which had
> > > > fallback restrictions and many changes to reclaim and compaction.
> > >
> > > Right, now I remember.
> > >
> > > > > On Android (ARMv8.2), app launch time regressed by about 7%; On
> > > > > ChromeOS (Intel ADL), tab switch time regressed by about 8%. Also PSI
> > > > > (full and some) on both platforms increased by over 20%. I could post
> > > > > the details of the benchmarks and the metrics they measure, but I
> > > > > doubt they would mean much to you. I did ask our test teams to save
> > > > > extra kernel logs that might be more helpful, and I could forward them
> > > > > to you.
> > > >
> > > > If the issue persists with the latest patches in -mm, a kernel config
> > > > and snapshots of /proc/vmstat, /proc/pagetypeinfo, /proc/zoneinfo
> > > > before/during/after the problematic behavior would be very helpful.
> > >
> > > Assuming all the fixes were included, do you want the logs from 6.8?
> > > We have them available now.
> >
> > Yes, that would be helpful.
> >
> > If you have them, it would also be quite useful to have the vmstat
> > before-after-test delta from a good kernel, for baseline comparison.
> 
> Sorry for taking this long -- I wanted to see if the regression is
> still reproducible on v6.9.
> 
> Apparently we got the similar results on v6.9 with the following
> patches cherry-picked cleanly from v6.10-rc1:
> 
>      1  mm: page_alloc: remove pcppage migratetype caching
>      2  mm: page_alloc: optimize free_unref_folios()
>      3  mm: page_alloc: fix up block types when merging compatible blocks
>      4  mm: page_alloc: move free pages when converting block during isolation
>      5  mm: page_alloc: fix move_freepages_block() range error
>      6  mm: page_alloc: fix freelist movement during block conversion
>      7  mm: page_alloc: close migratetype race between freeing and stealing
>      8  mm: page_alloc: set migratetype inside move_freepages()
>      9  mm: page_isolation: prepare for hygienic freelists
>     10  mm: page_alloc: consolidate free page accounting
>     11  mm: page_alloc: change move_freepages() to __move_freepages_block()
>     12  mm: page_alloc: batch vmstat updates in expand()
> 
> Unfortunately I just realized that that automated benchmark didn't
> collect the kernel stats before it starts (since it always starts on a
> freshly booted device). While this is being fixed, I'm attaching the
> kernel stats collected after the benchmark finished. I grabbed 10 runs
> for each (baseline/patched), and if you need more, please let me know.
> (And we should have the stats before the benchmark soon.)

Thanks for grabbing these, and sorry about the delay, I was traveling
last week.

You mentioned "THPs are virtually non-existant". But the workload
doesn't seem to allocate anon THPs at all. For file THP, the patched
kernel's median for allocation success is 90% of baseline, but the
inter-run min/max deviation from the median in baseline is 85%/108%
and in patched and 85%/112% in patched, so this is quite noisy. Was
that initial comment regarding a different workload?

This other data point has me stumped. Comparing medians, there is a
1.5% reduction in anon refaults and a 4.8% increase in file
refaults. And indeed, there is more files and less anon being scanned.
I think this could explain the PSI delta, since AFAIK you have zram or
zswap, and anon decompression loads are cheaper than filesystem IO.

The above patches don't do anything that directly influences the
anon-file reclaim balance. However, if file THPs fall back to 4k file
pages more, that *might* be able to explain a shift in reclaim
balance, if some hot subpages in those THPs were protecting colder
subpages from being reclaimed and refaulting.

In that case, the root cause would still be a simple THP success rate
regression. To confirm this theory, could you run the baseline and the
patched sets both with THP disabled entirely?

Can you elaborate more on what the workload is doing exactly? What are
the parameters of the test machine (CPUs, memory size)? It'd be
helpful if I could reproduce this locally as well.


