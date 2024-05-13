Return-Path: <linux-kernel+bounces-177951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D096E8C46B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43581B21D69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8B72E642;
	Mon, 13 May 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7jXsOGc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993C2C1A9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623846; cv=none; b=mNVAPSy4RlbO5gHq0u/YeUo1oesr8dFPkZkld+lpGwPXxLwsY1uYBodzXAKV+oSv5DbRdmCKPMiCV7bXblFgI4mv09OB45V0hdGlC5Tvj2Sh3fP4JKSYr2hDTBeb+xfivKwSOVlo63bdHSyDjQIwK1RdBXqmK3x67mxrn1PZYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623846; c=relaxed/simple;
	bh=/Ldr6aLOq38oGGljzBtRkAYVaHGI7VU4JsdhemUO4fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lroxNBh+jaKU/u6OXINqi88yMFntyxXDpNV4sJT12RhSlcKQ8gErOa8iMRjNXMr6ELuiVfiCbaapVqa6vYcbF0FvtKR4IXEfl9fuYDbzoWklnD+AZm59oc+Q+q69LwlI85x+Nua3SetD8viFvGNir88AbeGFGQcVc7j1VsNkL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7jXsOGc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42012c85e61so83935e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715623843; x=1716228643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1obXIpFTbK7Mcgk9nQSzyMnbMY4o4pmJSXSmOSDveAg=;
        b=J7jXsOGce9lBNv3aO2yuSKcYxR6kvuq8GPg6sOhZcXfKQTgcjA5Tn9GWFRgeJ6GRkV
         h6xebnnXkoKtIoOdrDh+42gUG7Dp8r0cC2IO6cNBNXaR6RcAEi6qkEoyXGoij/4B7gnb
         PXt/LPhrxRyjH2HPfD4ht4ZuCn2wgui5u2cLnKmZs8B5XDPkJtbNr/UaIVO4xSyuIgc0
         cf94rYDW1kB4wraFM3tp9DXMhvVults56Pe+Q2mGLDHKM17wNirFporNyxpiBxiNluZQ
         j20gDg1zlNhNNeNqd2UmNmzw1JnUTykE1cLJtF7HUmu3U5ApdnSSqTDyCVRYCK4aV8n5
         LXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623843; x=1716228643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1obXIpFTbK7Mcgk9nQSzyMnbMY4o4pmJSXSmOSDveAg=;
        b=h6vN7KGUg+curUIDMsu98GB32FpcjAqQAU8B06WtEG2wh0uBEH9np6BpcWvIfhZWJ0
         86jK4sow0SFinjB7xgwRb/G7K6g4rMJRYW3e+t2nInyc/F8I+yBOxs9mM+U1BdXNZizY
         +biuUD0vTDB9GEdB0JJs+j1EztblmvihTnmolzOc0mKEwZcvyrJgjbEBoljBUrkwCG6m
         3KgR6fRzF/PjQXIpkwOGFwazmD6ufdoJ7xrO0XqiAuOMAEwR5sgewxnOqSqxubyX8oPv
         GRXigFWNOdMmnu323y7RAEvhn+RchZ6ahcj5s04PbPUyD0Dgx9zKGntrBFgzB749MrTw
         FJRg==
X-Forwarded-Encrypted: i=1; AJvYcCVdH7e/uPU5YJrDTilGcKN9GssY6Up0aMDT6KvVkMGU6S0oM7LZL7bf0fO9b5f3XgmrNp1aFImcq4As+ssf9dshTbgAI+2Y6Cy8NdMr
X-Gm-Message-State: AOJu0YxGzn3ywqZlUp2wT2h0D84ZqroawMrhJD2ObWQvGwv13462qCg3
	KRNh7dYC4Va8HL7OuPQoYG9zNcdS9ucZ+hJItgPOKmmVaRWQeZiT/THqyhDk8nBktyXLJmMlLKu
	6ciBC4H3tfU/Q7FknimOapX7y1pJgSoFp0/Ow
X-Google-Smtp-Source: AGHT+IGaiDNjVxJcmjCPG0ym9D8p7YvfB21qu6clVocHjA4sTpmeCIsCnVsfZHB7a6TZGV7ULHLYG8QQZLynnvXqBX4=
X-Received: by 2002:a05:600c:3d0c:b0:41c:ab7:f9af with SMTP id
 5b1f17b1804b1-4200f8ac9c8mr3859505e9.3.1715623842823; Mon, 13 May 2024
 11:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320180429.678181-1-hannes@cmpxchg.org> <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>
 <20240513160331.GA320190@cmpxchg.org>
In-Reply-To: <20240513160331.GA320190@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 13 May 2024 12:10:04 -0600
Message-ID: <CAOUHufaCQPW=p_r-Sg4oeDgtxwEGp6E5j1MhU3OCrTLUZTymZA@mail.gmail.com>
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:03=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, May 10, 2024 at 11:14:43PM -0600, Yu Zhao wrote:
> > On Wed, Mar 20, 2024 at 12:04=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > V4:
> > > - fixed !pcp_order_allowed() case in free_unref_folios()
> > > - reworded the patch 0 changelog a bit for the git log
> > > - rebased to mm-everything-2024-03-19-23-01
> > > - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
> > >
> > > ---
> > >
> > > The page allocator's mobility grouping is intended to keep unmovable
> > > pages separate from reclaimable/compactable ones to allow on-demand
> > > defragmentation for higher-order allocations and huge pages.
> > >
> > > Currently, there are several places where accidental type mixing
> > > occurs: an allocation asks for a page of a certain migratetype and
> > > receives another. This ruins pageblocks for compaction, which in turn
> > > makes allocating huge pages more expensive and less reliable.
> > >
> > > The series addresses those causes. The last patch adds type checks on
> > > all freelist movements to prevent new violations being introduced.
> > >
> > > The benefits can be seen in a mixed workload that stresses the machin=
e
> > > with a memcache-type workload and a kernel build job while
> > > periodically attempting to allocate batches of THP. The following dat=
a
> > > is aggregated over 50 consecutive defconfig builds:
> > >
> > >                                                         VANILLA      =
           PATCHED
> > > Hugealloc Time mean                      165843.93 (    +0.00%)  1130=
25.88 (   -31.85%)
> > > Hugealloc Time stddev                    158957.35 (    +0.00%)  1147=
16.07 (   -27.83%)
> > > Kbuild Real time                            310.24 (    +0.00%)     3=
00.73 (    -3.06%)
> > > Kbuild User time                           1271.13 (    +0.00%)    12=
59.42 (    -0.92%)
> > > Kbuild System time                          582.02 (    +0.00%)     5=
59.79 (    -3.81%)
> > > THP fault alloc                           30585.14 (    +0.00%)   408=
53.62 (   +33.57%)
> > > THP fault fallback                        36626.46 (    +0.00%)   263=
57.62 (   -28.04%)
> > > THP fault fail rate %                        54.49 (    +0.00%)      =
39.22 (   -27.53%)
> > > Pagealloc fallback                         1328.00 (    +0.00%)      =
 1.00 (   -99.85%)
> > > Pagealloc type mismatch                  181009.50 (    +0.00%)      =
 0.00 (  -100.00%)
> > > Direct compact stall                        434.56 (    +0.00%)     2=
57.66 (   -40.61%)
> > > Direct compact fail                         421.70 (    +0.00%)     2=
49.94 (   -40.63%)
> > > Direct compact success                       12.86 (    +0.00%)      =
 7.72 (   -37.09%)
> > > Direct compact success rate %                 2.86 (    +0.00%)      =
 2.82 (    -0.96%)
> > > Compact daemon scanned migrate          3370059.62 (    +0.00%) 36120=
54.76 (    +7.18%)
> > > Compact daemon scanned free             7718439.20 (    +0.00%) 53863=
85.02 (   -30.21%)
> > > Compact direct scanned migrate           309248.62 (    +0.00%)  1767=
21.04 (   -42.85%)
> > > Compact direct scanned free              433582.84 (    +0.00%)  3157=
27.66 (   -27.18%)
> > > Compact migrate scanned daemon %             91.20 (    +0.00%)      =
94.48 (    +3.56%)
> > > Compact free scanned daemon %                94.58 (    +0.00%)      =
94.42 (    -0.16%)
> > > Compact total migrate scanned           3679308.24 (    +0.00%) 37887=
75.80 (    +2.98%)
> > > Compact total free scanned              8152022.04 (    +0.00%) 57021=
12.68 (   -30.05%)
> > > Alloc stall                                 872.04 (    +0.00%)    51=
56.12 (  +490.71%)
> > > Pages kswapd scanned                     510645.86 (    +0.00%)    33=
94.94 (   -99.33%)
> > > Pages kswapd reclaimed                   134811.62 (    +0.00%)    27=
01.26 (   -98.00%)
> > > Pages direct scanned                      99546.06 (    +0.00%)  3764=
07.52 (  +278.12%)
> > > Pages direct reclaimed                    62123.40 (    +0.00%)  2895=
35.70 (  +366.06%)
> > > Pages total scanned                      610191.92 (    +0.00%)  3798=
02.46 (   -37.76%)
> > > Pages scanned kswapd %                       76.36 (    +0.00%)      =
 0.10 (   -98.58%)
> > > Swap out                                  12057.54 (    +0.00%)   150=
22.98 (   +24.59%)
> > > Swap in                                     209.16 (    +0.00%)     2=
56.48 (   +22.52%)
> > > File refaults                             17701.64 (    +0.00%)   117=
65.40 (   -33.53%)
> > >
> > > Huge page success rate is higher, allocation latencies are shorter an=
d
> > > more predictable.
> > >
> > > Stealing (fallback) rate is drastically reduced. Notably, while the
> > > vanilla kernel keeps doing fallbacks on an ongoing basis, the patched
> > > kernel enters a steady state once the distribution of block types is
> > > adequate for the workload. Steals over 50 runs:
> > >
> > > VANILLA         PATCHED
> > > 1504.0          227.0
> > > 1557.0          6.0
> > > 1391.0          13.0
> > > 1080.0          26.0
> > > 1057.0          40.0
> > > 1156.0          6.0
> > > 805.0           46.0
> > > 736.0           20.0
> > > 1747.0          2.0
> > > 1699.0          34.0
> > > 1269.0          13.0
> > > 1858.0          12.0
> > > 907.0           4.0
> > > 727.0           2.0
> > > 563.0           2.0
> > > 3094.0          2.0
> > > 10211.0         3.0
> > > 2621.0          1.0
> > > 5508.0          2.0
> > > 1060.0          2.0
> > > 538.0           3.0
> > > 5773.0          2.0
> > > 2199.0          0.0
> > > 3781.0          2.0
> > > 1387.0          1.0
> > > 4977.0          0.0
> > > 2865.0          1.0
> > > 1814.0          1.0
> > > 3739.0          1.0
> > > 6857.0          0.0
> > > 382.0           0.0
> > > 407.0           1.0
> > > 3784.0          0.0
> > > 297.0           0.0
> > > 298.0           0.0
> > > 6636.0          0.0
> > > 4188.0          0.0
> > > 242.0           0.0
> > > 9960.0          0.0
> > > 5816.0          0.0
> > > 354.0           0.0
> > > 287.0           0.0
> > > 261.0           0.0
> > > 140.0           1.0
> > > 2065.0          0.0
> > > 312.0           0.0
> > > 331.0           0.0
> > > 164.0           0.0
> > > 465.0           1.0
> > > 219.0           0.0
> > >
> > > Type mismatches are down too. Those count every time an allocation
> > > request asks for one migratetype and gets another. This can still
> > > occur minimally in the patched kernel due to non-stealing fallbacks,
> > > but it's quite rare and follows the pattern of overall fallbacks -
> > > once the block type distribution settles, mismatches cease as well:
> > >
> > > VANILLA:        PATCHED:
> > > 182602.0        268.0
> > > 135794.0        20.0
> > > 88619.0         19.0
> > > 95973.0         0.0
> > > 129590.0        0.0
> > > 129298.0        0.0
> > > 147134.0        0.0
> > > 230854.0        0.0
> > > 239709.0        0.0
> > > 137670.0        0.0
> > > 132430.0        0.0
> > > 65712.0         0.0
> > > 57901.0         0.0
> > > 67506.0         0.0
> > > 63565.0         4.0
> > > 34806.0         0.0
> > > 42962.0         0.0
> > > 32406.0         0.0
> > > 38668.0         0.0
> > > 61356.0         0.0
> > > 57800.0         0.0
> > > 41435.0         0.0
> > > 83456.0         0.0
> > > 65048.0         0.0
> > > 28955.0         0.0
> > > 47597.0         0.0
> > > 75117.0         0.0
> > > 55564.0         0.0
> > > 38280.0         0.0
> > > 52404.0         0.0
> > > 26264.0         0.0
> > > 37538.0         0.0
> > > 19671.0         0.0
> > > 30936.0         0.0
> > > 26933.0         0.0
> > > 16962.0         0.0
> > > 44554.0         0.0
> > > 46352.0         0.0
> > > 24995.0         0.0
> > > 35152.0         0.0
> > > 12823.0         0.0
> > > 21583.0         0.0
> > > 18129.0         0.0
> > > 31693.0         0.0
> > > 28745.0         0.0
> > > 33308.0         0.0
> > > 31114.0         0.0
> > > 35034.0         0.0
> > > 12111.0         0.0
> > > 24885.0         0.0
> > >
> > > Compaction work is markedly reduced despite much better THP rates.
> > >
> > > In the vanilla kernel, reclaim seems to have been driven primarily by
> > > watermark boosting that happens as a result of fallbacks. With those
> > > all but eliminated, watermarks average lower and kswapd does less
> > > work. The uptick in direct reclaim is because THP requests have to
> > > fend for themselves more often - which is intended policy right
> > > now. Aggregate reclaim activity is lowered significantly, though.
> >
> > This series significantly regresses Android and ChromeOS under memory
> > pressure. THPs are virtually nonexistent on client devices, and IIRC,
> > it was mentioned in the early discussions that potential regressions
> > for such a case are somewhat expected?
>
> This is not expected for the 10 patches here. You might be referring
> to the discussion around the huge page allocator series, which had
> fallback restrictions and many changes to reclaim and compaction.

Right, now I remember.

> Can you confirm that you were testing the latest patches that are in
> mm-stable as of today? There was a series of follow-up fixes.

Here is what I have on top of 6.8.y, which I think includes all the
follow-up fixes. The performance delta was measured between 5 & 22.

     1 mm: convert free_unref_page_list() to use folios
     2 mm: add free_unref_folios()
     3 mm: handle large folios in free_unref_folios()
     4 mm/page_alloc: remove unused fpi_flags in free_pages_prepare()
     5 mm: add alloc_contig_migrate_range allocation statistics
     6 mm: page_alloc: remove pcppage migratetype caching
     7 mm: page_alloc: optimize free_unref_folios()
     8 mm: page_alloc: fix up block types when merging compatible blocks
     9 mm: page_alloc: move free pages when converting block during isolati=
on
    10 mm: page_alloc: fix move_freepages_block() range error
    11 mm: page_alloc: fix freelist movement during block conversion
    12 mm-page_alloc-fix-freelist-movement-during-block-conversion-fix
    13 mm: page_alloc: close migratetype race between freeing and stealing
    14 mm: page_alloc: set migratetype inside move_freepages()
    15 mm: page_isolation: prepare for hygienic freelists
    16 mm-page_isolation-prepare-for-hygienic-freelists-fix
    17 mm: page_alloc: consolidate free page accounting
    18 mm: page_alloc: consolidate free page accounting fix
    19 mm: page_alloc: consolidate free page accounting fix 2
    20 mm: page_alloc: consolidate free page accounting fix 3
    21 mm: page_alloc: change move_freepages() to __move_freepages_block()
    22 mm: page_alloc: batch vmstat updates in expand()

> Especially, please double check you have the follow-up fixes to
> compaction capturing and the CMA fallback policy. It sounds like the
> behavior Baolin described before the CMA fix.

Yes, that one was included.

> Lastly, what's the base you backported this series to?

It was 6.8, we can potentially try 6.9 this week and 6.10-rc in a few
weeks when it's in good shape for performance benchmarks.

> > On Android (ARMv8.2), app launch time regressed by about 7%; On
> > ChromeOS (Intel ADL), tab switch time regressed by about 8%. Also PSI
> > (full and some) on both platforms increased by over 20%. I could post
> > the details of the benchmarks and the metrics they measure, but I
> > doubt they would mean much to you. I did ask our test teams to save
> > extra kernel logs that might be more helpful, and I could forward them
> > to you.
>
> If the issue persists with the latest patches in -mm, a kernel config
> and snapshots of /proc/vmstat, /proc/pagetypeinfo, /proc/zoneinfo
> before/during/after the problematic behavior would be very helpful.

Assuming all the fixes were included, do you want the logs from 6.8?
We have them available now.

