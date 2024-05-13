Return-Path: <linux-kernel+bounces-178005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1858C475A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FC21F240D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3DC57C8A;
	Mon, 13 May 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="jbOzztEl"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE054F8C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627050; cv=none; b=eb6sLTgvd2DfxvHY86VmMu/IjFsawy4Xylx3+TDOm2xi3XTWHUZ4u8GYYhlyqxaiqhBM0akJdAV92h8VYglERUVOQaJRY8kduaakeBoYwFFGSq7g1Z0smgmUrCXYDYiKd09ta6VOxz3mUalurPAymF8pY9hn1CvIif6/4JRqsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627050; c=relaxed/simple;
	bh=kjFAMX6oxqGkoP0FmFMDKDipAwe8lFVIG1ZBMjZCJk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFrMmqt1ag/JVAO2CEGC4EOTmDWYWfZIXlKPUhlVaefULolkKKX/e+Kp3PoKnoFVTg32GrjXs5gEQ2mgTDJmZAJ8VoyhGDk8YcY3IPJhbMBuDYxHS5+YnqcF/mKLAF1P8cSg6rX3/QQuXXY+2j9RCAL6X5RNoC10hvTdNYaASCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=jbOzztEl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43e1581e81cso10540171cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715627046; x=1716231846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=drMW1Rvo4MuRn1Lfhy57d4TZ2XCivd8Q9I2KUmulD74=;
        b=jbOzztEl06VSsaJqYAoyTJX2b9uOLsy7/wHmYwimrRVJGYzUj5atAvMlsrYG/IeOo6
         Akse4regtrkfemi1Nrnm8cBcurMhKoEZupoOtxNvadW4azKcIUaWfwavEkL1uVb0Fj+H
         Esoeolbyc925Ildu3/s2Os28uz5+r5kgc53jmmqvP7gYSGCvkaYlztUj4wbGEj2UAeiH
         Wk+fwcfk1eBYH1y+wSGFIXz/b4/qkXEfVizVfI+ZmremIEVGn4gtmSxdRn836B+y60iI
         BKPWS2EeW6l+6VfKfTVvSCDet28N9tJJN0rl7ELSaxLBhgeTCwd/mKBJTZ8IpecgWWCS
         FQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715627046; x=1716231846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drMW1Rvo4MuRn1Lfhy57d4TZ2XCivd8Q9I2KUmulD74=;
        b=vzbPga2GtAVqVYD+MtMYGkeawp9qhRDYbw81DzB3JvL86WRH5RIlOYWoSoIVPWagcj
         yFm35Lm6cCEcZcuuRldGqLhaYfPQ/wg168Ygy1WaY9PvnaLRgel5daXgy2TiQ9zodEIZ
         4p+wUIbxIkiDRU/IfCnUflYaQbHKaZ5nhLKvDr7y/L1UbjTWXLlwpDM6G6UmkbapWh6m
         wf7jIZw8J8CmoITml5LDoxrR3DK9rUkDmLuxq3UUR1h//+O0q3jbIOs4pIeNOzIHAlc8
         uhBzFCHQagkLmNNuh9u+Uzo8xXwPRbhIzV/TvTuQnoUVtesYDUOkUkilmUD14rW787WE
         s9CA==
X-Forwarded-Encrypted: i=1; AJvYcCU5xN7gRJPJPTjR2i/d1pvPXPHrvNDhb9HdgN1amxTVqBhwWy6+r+rrODUXCvEV3+2jipXu+MdA9qm3kcPZ7zUwAM7+G7RMVB8ap6+n
X-Gm-Message-State: AOJu0YwKbuCrOCT2e2WgrQ26tuYb7qApLH8G5ZHhZjZEffnyGoANPCnf
	7ng5HgPXN8A/N9w0h8Gp1Oigb9pqeLMIc6Jy4HPTA+4AfkaG4tB7lftRmo+87SQ=
X-Google-Smtp-Source: AGHT+IEunh2dcp1cZ5uxQ2yBrWkYWT2OqJsI9TTKMv+F7V69dqBz4GriLD3T7C3jhUQlM92IwHdipA==
X-Received: by 2002:a05:622a:1354:b0:43e:1a17:10f9 with SMTP id d75a77b69052e-43e1a1746a4mr39523081cf.52.1715627045895;
        Mon, 13 May 2024 12:04:05 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0daba775sm28888361cf.63.2024.05.13.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:04:05 -0700 (PDT)
Date: Mon, 13 May 2024 15:04:00 -0400
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
Message-ID: <20240513190400.GA2270702@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>
 <20240513160331.GA320190@cmpxchg.org>
 <CAOUHufaCQPW=p_r-Sg4oeDgtxwEGp6E5j1MhU3OCrTLUZTymZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufaCQPW=p_r-Sg4oeDgtxwEGp6E5j1MhU3OCrTLUZTymZA@mail.gmail.com>

On Mon, May 13, 2024 at 12:10:04PM -0600, Yu Zhao wrote:
> On Mon, May 13, 2024 at 10:03 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, May 10, 2024 at 11:14:43PM -0600, Yu Zhao wrote:
> > > On Wed, Mar 20, 2024 at 12:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > V4:
> > > > - fixed !pcp_order_allowed() case in free_unref_folios()
> > > > - reworded the patch 0 changelog a bit for the git log
> > > > - rebased to mm-everything-2024-03-19-23-01
> > > > - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
> > > >
> > > > ---
> > > >
> > > > The page allocator's mobility grouping is intended to keep unmovable
> > > > pages separate from reclaimable/compactable ones to allow on-demand
> > > > defragmentation for higher-order allocations and huge pages.
> > > >
> > > > Currently, there are several places where accidental type mixing
> > > > occurs: an allocation asks for a page of a certain migratetype and
> > > > receives another. This ruins pageblocks for compaction, which in turn
> > > > makes allocating huge pages more expensive and less reliable.
> > > >
> > > > The series addresses those causes. The last patch adds type checks on
> > > > all freelist movements to prevent new violations being introduced.
> > > >
> > > > The benefits can be seen in a mixed workload that stresses the machine
> > > > with a memcache-type workload and a kernel build job while
> > > > periodically attempting to allocate batches of THP. The following data
> > > > is aggregated over 50 consecutive defconfig builds:
> > > >
> > > >                                                         VANILLA                 PATCHED
> > > > Hugealloc Time mean                      165843.93 (    +0.00%)  113025.88 (   -31.85%)
> > > > Hugealloc Time stddev                    158957.35 (    +0.00%)  114716.07 (   -27.83%)
> > > > Kbuild Real time                            310.24 (    +0.00%)     300.73 (    -3.06%)
> > > > Kbuild User time                           1271.13 (    +0.00%)    1259.42 (    -0.92%)
> > > > Kbuild System time                          582.02 (    +0.00%)     559.79 (    -3.81%)
> > > > THP fault alloc                           30585.14 (    +0.00%)   40853.62 (   +33.57%)
> > > > THP fault fallback                        36626.46 (    +0.00%)   26357.62 (   -28.04%)
> > > > THP fault fail rate %                        54.49 (    +0.00%)      39.22 (   -27.53%)
> > > > Pagealloc fallback                         1328.00 (    +0.00%)       1.00 (   -99.85%)
> > > > Pagealloc type mismatch                  181009.50 (    +0.00%)       0.00 (  -100.00%)
> > > > Direct compact stall                        434.56 (    +0.00%)     257.66 (   -40.61%)
> > > > Direct compact fail                         421.70 (    +0.00%)     249.94 (   -40.63%)
> > > > Direct compact success                       12.86 (    +0.00%)       7.72 (   -37.09%)
> > > > Direct compact success rate %                 2.86 (    +0.00%)       2.82 (    -0.96%)
> > > > Compact daemon scanned migrate          3370059.62 (    +0.00%) 3612054.76 (    +7.18%)
> > > > Compact daemon scanned free             7718439.20 (    +0.00%) 5386385.02 (   -30.21%)
> > > > Compact direct scanned migrate           309248.62 (    +0.00%)  176721.04 (   -42.85%)
> > > > Compact direct scanned free              433582.84 (    +0.00%)  315727.66 (   -27.18%)
> > > > Compact migrate scanned daemon %             91.20 (    +0.00%)      94.48 (    +3.56%)
> > > > Compact free scanned daemon %                94.58 (    +0.00%)      94.42 (    -0.16%)
> > > > Compact total migrate scanned           3679308.24 (    +0.00%) 3788775.80 (    +2.98%)
> > > > Compact total free scanned              8152022.04 (    +0.00%) 5702112.68 (   -30.05%)
> > > > Alloc stall                                 872.04 (    +0.00%)    5156.12 (  +490.71%)
> > > > Pages kswapd scanned                     510645.86 (    +0.00%)    3394.94 (   -99.33%)
> > > > Pages kswapd reclaimed                   134811.62 (    +0.00%)    2701.26 (   -98.00%)
> > > > Pages direct scanned                      99546.06 (    +0.00%)  376407.52 (  +278.12%)
> > > > Pages direct reclaimed                    62123.40 (    +0.00%)  289535.70 (  +366.06%)
> > > > Pages total scanned                      610191.92 (    +0.00%)  379802.46 (   -37.76%)
> > > > Pages scanned kswapd %                       76.36 (    +0.00%)       0.10 (   -98.58%)
> > > > Swap out                                  12057.54 (    +0.00%)   15022.98 (   +24.59%)
> > > > Swap in                                     209.16 (    +0.00%)     256.48 (   +22.52%)
> > > > File refaults                             17701.64 (    +0.00%)   11765.40 (   -33.53%)

[...]

> > >
> > > This series significantly regresses Android and ChromeOS under memory
> > > pressure. THPs are virtually nonexistent on client devices, and IIRC,
> > > it was mentioned in the early discussions that potential regressions
> > > for such a case are somewhat expected?
> >
> > This is not expected for the 10 patches here. You might be referring
> > to the discussion around the huge page allocator series, which had
> > fallback restrictions and many changes to reclaim and compaction.
> 
> Right, now I remember.
> 
> > Can you confirm that you were testing the latest patches that are in
> > mm-stable as of today? There was a series of follow-up fixes.
> 
> Here is what I have on top of 6.8.y, which I think includes all the
> follow-up fixes. The performance delta was measured between 5 & 22.
> 
>      1 mm: convert free_unref_page_list() to use folios
>      2 mm: add free_unref_folios()
>      3 mm: handle large folios in free_unref_folios()
>      4 mm/page_alloc: remove unused fpi_flags in free_pages_prepare()
>      5 mm: add alloc_contig_migrate_range allocation statistics
>      6 mm: page_alloc: remove pcppage migratetype caching
>      7 mm: page_alloc: optimize free_unref_folios()
>      8 mm: page_alloc: fix up block types when merging compatible blocks
>      9 mm: page_alloc: move free pages when converting block during isolation
>     10 mm: page_alloc: fix move_freepages_block() range error
>     11 mm: page_alloc: fix freelist movement during block conversion
>     12 mm-page_alloc-fix-freelist-movement-during-block-conversion-fix
>     13 mm: page_alloc: close migratetype race between freeing and stealing
>     14 mm: page_alloc: set migratetype inside move_freepages()
>     15 mm: page_isolation: prepare for hygienic freelists
>     16 mm-page_isolation-prepare-for-hygienic-freelists-fix
>     17 mm: page_alloc: consolidate free page accounting
>     18 mm: page_alloc: consolidate free page accounting fix
>     19 mm: page_alloc: consolidate free page accounting fix 2
>     20 mm: page_alloc: consolidate free page accounting fix 3
>     21 mm: page_alloc: change move_freepages() to __move_freepages_block()
>     22 mm: page_alloc: batch vmstat updates in expand()

It does look complete to me. Did you encounter any conflicts during
the backport? Is there any chance you can fold the fixes into their
respective main patches and bisect the sequence?

Again, it's not expected behavior given the fairly conservative
changes above. It sounds like a bug.

> > Especially, please double check you have the follow-up fixes to
> > compaction capturing and the CMA fallback policy. It sounds like the
> > behavior Baolin described before the CMA fix.
> 
> Yes, that one was included.

Ok.

> > Lastly, what's the base you backported this series to?
> 
> It was 6.8, we can potentially try 6.9 this week and 6.10-rc in a few
> weeks when it's in good shape for performance benchmarks.

If you could try 6.9 as well, that would be great. I backported the
series to 6.9 the other day (git cherry-picks from mm-stable) and I
didn't encounter any conflicts.

> > > On Android (ARMv8.2), app launch time regressed by about 7%; On
> > > ChromeOS (Intel ADL), tab switch time regressed by about 8%. Also PSI
> > > (full and some) on both platforms increased by over 20%. I could post
> > > the details of the benchmarks and the metrics they measure, but I
> > > doubt they would mean much to you. I did ask our test teams to save
> > > extra kernel logs that might be more helpful, and I could forward them
> > > to you.
> >
> > If the issue persists with the latest patches in -mm, a kernel config
> > and snapshots of /proc/vmstat, /proc/pagetypeinfo, /proc/zoneinfo
> > before/during/after the problematic behavior would be very helpful.
> 
> Assuming all the fixes were included, do you want the logs from 6.8?
> We have them available now.

Yes, that would be helpful.

If you have them, it would also be quite useful to have the vmstat
before-after-test delta from a good kernel, for baseline comparison.

Thanks

