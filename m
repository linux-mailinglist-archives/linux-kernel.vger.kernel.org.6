Return-Path: <linux-kernel+bounces-177800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A6E8C44C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9921F21FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7615532C;
	Mon, 13 May 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gaPFm7Jm"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36408147C60
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616222; cv=none; b=mXinNLIG9He2azLSgRkSf1K+6WbrZO60yTMIQDJRgMfGDrnQDoR+2dbidkrsuGs8DiWXXY88pSJRjXoA7F8hD8jVUZuvwCTrrPZFLMeS9zD3Y1wacZl3I1b9FU+odTFRkBqtlMEgy8LqB5W4sFRtK56u0ravJpbHFwZUHMOd8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616222; c=relaxed/simple;
	bh=e/Q7gvdaA6FmyizpMC1h5qbKMtq21SvftEqgAozykAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdLzuaS7lqrRNoyfjET3QkXb1MQ1d6OgWMNspIV+y0x1tiYFGj9MDD8Y5Uze5+sdIrX4SXjpWXzqR7yis6do50fqguuC6Lmy9uChLSHRtFLTlrtMWPlRY6yTfSjKiyaTotIxbPBWmuv0uD2EMyuz5S4qEYzn+VNuSB+OTOveHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gaPFm7Jm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-792b94301eeso416564585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715616217; x=1716221017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxiwsA1hr4Hom+qJPEPxhY2pHW6Ol2ceCgE08ByD6Ho=;
        b=gaPFm7JmEGQfDHSx6XhNXC9/PJxLFoQdvdHDEkTttpCorKinhzwnEQSezBs7BnRwbc
         uOw9Ie7K+zvcF6GF54HmhwMfLoQ5QCggq9OCeXO3hz+0WtaMl+KDfxYsXp3ujO91lLeS
         xG5jvylJpdR1OQBxduVAf8Ar5N+sSCxkYyYzRURPGSCqjEk3qVOZlMFBfn/aAJF1uP9E
         wZkYNHXH3FR1BrhyOOBEtbhj1y8zCrOC2LEi9VlhuCHuBVsYPfLolR2q9Mxd2MVqRWs/
         HAqNXsBFq8/a4eU1y8+9bcJSu4W0pZ6HKFkhDu8uIkzhMslj/howPXmFDAzSaQTisS+/
         NJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616217; x=1716221017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxiwsA1hr4Hom+qJPEPxhY2pHW6Ol2ceCgE08ByD6Ho=;
        b=HrQNCW+FTTdQuUJd8Pl6Z+m3zfXrGgk+XQAOfNmv+NacaobhaaOZ79uvyTdpcDk7Db
         o3M9YeY0Y1jjCZfjA5Jkg+DZzTb71Jjs98H/VPuJ2LQQy1VQ15fBxR4jjeryBXFmGsRl
         giCdhh9xiFKjvDZuTlyUCNXICASmIYAHJzDMHpkJRntF+rrYlECn8BrpBjEWAraHd6ur
         v52AseCuJ2gYZQgb0RjUJYKs6/EyQPd0+QVyoiwVjujdRT3UWPMZL5cprFJFV8tOOq24
         qf7JdjTJzLt6xsdW5egjS04dAlY4I6WpfXB+PR3+Ick3PVyrvDPGflSTSUG/7yMpLs00
         T5pA==
X-Forwarded-Encrypted: i=1; AJvYcCX2ypgrjURHa/yBFXkBriyYzgCg43Hyp/eO21Y3znhfdNmGAUte6VvCtJzUDu19MvGAzhdpSImjJssj2KjrUsygUxQNgvON5DHmXzjs
X-Gm-Message-State: AOJu0YwF9ENdPcY25LxkxXK2OPcc/+D//eex2QhczjkhYdem9wVTvGjv
	ewGHa+X3IsxQkKGUfO7NbBBxokgqwkw/AaiMDeBLNRtoLc7b3byvu/ZsWkzKEtQ=
X-Google-Smtp-Source: AGHT+IH/C5ZzA9Li3YVZXr20Zx5KAvXWT3mWgsj0zuwnjh/+ogQxEGuDm9QjJr18QIK6b7aYtBixOA==
X-Received: by 2002:a05:620a:d5a:b0:792:c44e:c272 with SMTP id af79cd13be357-792c75f44f4mr1013654585a.53.1715616216855;
        Mon, 13 May 2024 09:03:36 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf315009sm467959785a.118.2024.05.13.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:03:36 -0700 (PDT)
Date: Mon, 13 May 2024 12:03:31 -0400
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
Message-ID: <20240513160331.GA320190@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>

On Fri, May 10, 2024 at 11:14:43PM -0600, Yu Zhao wrote:
> On Wed, Mar 20, 2024 at 12:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > V4:
> > - fixed !pcp_order_allowed() case in free_unref_folios()
> > - reworded the patch 0 changelog a bit for the git log
> > - rebased to mm-everything-2024-03-19-23-01
> > - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
> >
> > ---
> >
> > The page allocator's mobility grouping is intended to keep unmovable
> > pages separate from reclaimable/compactable ones to allow on-demand
> > defragmentation for higher-order allocations and huge pages.
> >
> > Currently, there are several places where accidental type mixing
> > occurs: an allocation asks for a page of a certain migratetype and
> > receives another. This ruins pageblocks for compaction, which in turn
> > makes allocating huge pages more expensive and less reliable.
> >
> > The series addresses those causes. The last patch adds type checks on
> > all freelist movements to prevent new violations being introduced.
> >
> > The benefits can be seen in a mixed workload that stresses the machine
> > with a memcache-type workload and a kernel build job while
> > periodically attempting to allocate batches of THP. The following data
> > is aggregated over 50 consecutive defconfig builds:
> >
> >                                                         VANILLA                 PATCHED
> > Hugealloc Time mean                      165843.93 (    +0.00%)  113025.88 (   -31.85%)
> > Hugealloc Time stddev                    158957.35 (    +0.00%)  114716.07 (   -27.83%)
> > Kbuild Real time                            310.24 (    +0.00%)     300.73 (    -3.06%)
> > Kbuild User time                           1271.13 (    +0.00%)    1259.42 (    -0.92%)
> > Kbuild System time                          582.02 (    +0.00%)     559.79 (    -3.81%)
> > THP fault alloc                           30585.14 (    +0.00%)   40853.62 (   +33.57%)
> > THP fault fallback                        36626.46 (    +0.00%)   26357.62 (   -28.04%)
> > THP fault fail rate %                        54.49 (    +0.00%)      39.22 (   -27.53%)
> > Pagealloc fallback                         1328.00 (    +0.00%)       1.00 (   -99.85%)
> > Pagealloc type mismatch                  181009.50 (    +0.00%)       0.00 (  -100.00%)
> > Direct compact stall                        434.56 (    +0.00%)     257.66 (   -40.61%)
> > Direct compact fail                         421.70 (    +0.00%)     249.94 (   -40.63%)
> > Direct compact success                       12.86 (    +0.00%)       7.72 (   -37.09%)
> > Direct compact success rate %                 2.86 (    +0.00%)       2.82 (    -0.96%)
> > Compact daemon scanned migrate          3370059.62 (    +0.00%) 3612054.76 (    +7.18%)
> > Compact daemon scanned free             7718439.20 (    +0.00%) 5386385.02 (   -30.21%)
> > Compact direct scanned migrate           309248.62 (    +0.00%)  176721.04 (   -42.85%)
> > Compact direct scanned free              433582.84 (    +0.00%)  315727.66 (   -27.18%)
> > Compact migrate scanned daemon %             91.20 (    +0.00%)      94.48 (    +3.56%)
> > Compact free scanned daemon %                94.58 (    +0.00%)      94.42 (    -0.16%)
> > Compact total migrate scanned           3679308.24 (    +0.00%) 3788775.80 (    +2.98%)
> > Compact total free scanned              8152022.04 (    +0.00%) 5702112.68 (   -30.05%)
> > Alloc stall                                 872.04 (    +0.00%)    5156.12 (  +490.71%)
> > Pages kswapd scanned                     510645.86 (    +0.00%)    3394.94 (   -99.33%)
> > Pages kswapd reclaimed                   134811.62 (    +0.00%)    2701.26 (   -98.00%)
> > Pages direct scanned                      99546.06 (    +0.00%)  376407.52 (  +278.12%)
> > Pages direct reclaimed                    62123.40 (    +0.00%)  289535.70 (  +366.06%)
> > Pages total scanned                      610191.92 (    +0.00%)  379802.46 (   -37.76%)
> > Pages scanned kswapd %                       76.36 (    +0.00%)       0.10 (   -98.58%)
> > Swap out                                  12057.54 (    +0.00%)   15022.98 (   +24.59%)
> > Swap in                                     209.16 (    +0.00%)     256.48 (   +22.52%)
> > File refaults                             17701.64 (    +0.00%)   11765.40 (   -33.53%)
> >
> > Huge page success rate is higher, allocation latencies are shorter and
> > more predictable.
> >
> > Stealing (fallback) rate is drastically reduced. Notably, while the
> > vanilla kernel keeps doing fallbacks on an ongoing basis, the patched
> > kernel enters a steady state once the distribution of block types is
> > adequate for the workload. Steals over 50 runs:
> >
> > VANILLA         PATCHED
> > 1504.0          227.0
> > 1557.0          6.0
> > 1391.0          13.0
> > 1080.0          26.0
> > 1057.0          40.0
> > 1156.0          6.0
> > 805.0           46.0
> > 736.0           20.0
> > 1747.0          2.0
> > 1699.0          34.0
> > 1269.0          13.0
> > 1858.0          12.0
> > 907.0           4.0
> > 727.0           2.0
> > 563.0           2.0
> > 3094.0          2.0
> > 10211.0         3.0
> > 2621.0          1.0
> > 5508.0          2.0
> > 1060.0          2.0
> > 538.0           3.0
> > 5773.0          2.0
> > 2199.0          0.0
> > 3781.0          2.0
> > 1387.0          1.0
> > 4977.0          0.0
> > 2865.0          1.0
> > 1814.0          1.0
> > 3739.0          1.0
> > 6857.0          0.0
> > 382.0           0.0
> > 407.0           1.0
> > 3784.0          0.0
> > 297.0           0.0
> > 298.0           0.0
> > 6636.0          0.0
> > 4188.0          0.0
> > 242.0           0.0
> > 9960.0          0.0
> > 5816.0          0.0
> > 354.0           0.0
> > 287.0           0.0
> > 261.0           0.0
> > 140.0           1.0
> > 2065.0          0.0
> > 312.0           0.0
> > 331.0           0.0
> > 164.0           0.0
> > 465.0           1.0
> > 219.0           0.0
> >
> > Type mismatches are down too. Those count every time an allocation
> > request asks for one migratetype and gets another. This can still
> > occur minimally in the patched kernel due to non-stealing fallbacks,
> > but it's quite rare and follows the pattern of overall fallbacks -
> > once the block type distribution settles, mismatches cease as well:
> >
> > VANILLA:        PATCHED:
> > 182602.0        268.0
> > 135794.0        20.0
> > 88619.0         19.0
> > 95973.0         0.0
> > 129590.0        0.0
> > 129298.0        0.0
> > 147134.0        0.0
> > 230854.0        0.0
> > 239709.0        0.0
> > 137670.0        0.0
> > 132430.0        0.0
> > 65712.0         0.0
> > 57901.0         0.0
> > 67506.0         0.0
> > 63565.0         4.0
> > 34806.0         0.0
> > 42962.0         0.0
> > 32406.0         0.0
> > 38668.0         0.0
> > 61356.0         0.0
> > 57800.0         0.0
> > 41435.0         0.0
> > 83456.0         0.0
> > 65048.0         0.0
> > 28955.0         0.0
> > 47597.0         0.0
> > 75117.0         0.0
> > 55564.0         0.0
> > 38280.0         0.0
> > 52404.0         0.0
> > 26264.0         0.0
> > 37538.0         0.0
> > 19671.0         0.0
> > 30936.0         0.0
> > 26933.0         0.0
> > 16962.0         0.0
> > 44554.0         0.0
> > 46352.0         0.0
> > 24995.0         0.0
> > 35152.0         0.0
> > 12823.0         0.0
> > 21583.0         0.0
> > 18129.0         0.0
> > 31693.0         0.0
> > 28745.0         0.0
> > 33308.0         0.0
> > 31114.0         0.0
> > 35034.0         0.0
> > 12111.0         0.0
> > 24885.0         0.0
> >
> > Compaction work is markedly reduced despite much better THP rates.
> >
> > In the vanilla kernel, reclaim seems to have been driven primarily by
> > watermark boosting that happens as a result of fallbacks. With those
> > all but eliminated, watermarks average lower and kswapd does less
> > work. The uptick in direct reclaim is because THP requests have to
> > fend for themselves more often - which is intended policy right
> > now. Aggregate reclaim activity is lowered significantly, though.
> 
> This series significantly regresses Android and ChromeOS under memory
> pressure. THPs are virtually nonexistent on client devices, and IIRC,
> it was mentioned in the early discussions that potential regressions
> for such a case are somewhat expected?

This is not expected for the 10 patches here. You might be referring
to the discussion around the huge page allocator series, which had
fallback restrictions and many changes to reclaim and compaction.

Can you confirm that you were testing the latest patches that are in
mm-stable as of today? There was a series of follow-up fixes.

Especially, please double check you have the follow-up fixes to
compaction capturing and the CMA fallback policy. It sounds like the
behavior Baolin described before the CMA fix.

Lastly, what's the base you backported this series to?

> On Android (ARMv8.2), app launch time regressed by about 7%; On
> ChromeOS (Intel ADL), tab switch time regressed by about 8%. Also PSI
> (full and some) on both platforms increased by over 20%. I could post
> the details of the benchmarks and the metrics they measure, but I
> doubt they would mean much to you. I did ask our test teams to save
> extra kernel logs that might be more helpful, and I could forward them
> to you.

If the issue persists with the latest patches in -mm, a kernel config
and snapshots of /proc/vmstat, /proc/pagetypeinfo, /proc/zoneinfo
before/during/after the problematic behavior would be very helpful.

