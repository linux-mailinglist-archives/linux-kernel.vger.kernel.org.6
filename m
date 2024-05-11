Return-Path: <linux-kernel+bounces-176420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B0A8C2FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00218B21F10
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 05:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B4647A57;
	Sat, 11 May 2024 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/+mWIIm"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE20481A4
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715404525; cv=none; b=WA/y1vrA1/nt1Pd1mdeDiluOdD9lesaqZzWszFrTIrTpqj+05RW1LVHeBFz4mBPgfYRLALvexFc+S0rp1ddUSdgCPbwdsArPmEwiNVzl1BSUXuAlCrgXhxuwxMu0+qm1PSS5tKyx9/+Yu9X/O+y84HtHWtCR+RrD5j7xh+jB/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715404525; c=relaxed/simple;
	bh=3jLhf9AN3I4/W2uKbCcyhlAinSRcIf97u3e0Ufz16Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSOe/lVmk6r/zEvn1IbK0684uTdmwe3GD0zJDWbCOQSPW8v09jTS6/kkHDj9SXuYwV146c3jKCdMjsu/llcfFxu0KtMpQHnEHYw0yqAX5TOIKYduEJrUKvD/tAmb2+WhnXEgNDbq0c8ro3GNyBYxeT1EF38TGDlT2Jmw9uRb1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/+mWIIm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so17915e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 22:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715404522; x=1716009322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR2quo6tlZ4enrMTfiyjAw0a+nG2TivaK5vmV5DYmrA=;
        b=A/+mWIImAXgsUevYHbA+t91oS4p/QFaU36mEBMIjOHbqArtV3V9LgtMQsLpF4raDL0
         5aPArzD1bIZBjATbetlfBeTwNWHsEbs8iT5gQ4UeF1QGBSHuue5JTBAiFlo3qTbedP+2
         /vYxK2Qq9ZfhDIbextRUf+5CJvBnss3J3cI5TaCLq5NEDj/RN+pFb6RaXZzYe82dl/Xt
         SZJCX6ISfHu/NInpF1rYHZWuX4SVe3RgKE/NEfjN0ae3/b0L4Tb8glE29V9vqo6WE1qO
         sw4Cnn8wycK88X+8SZUzgmQZowJpxzPgJsX0Rm61//U31Sb44J5VTKbnfhcwYZkDa+eC
         xHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715404522; x=1716009322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR2quo6tlZ4enrMTfiyjAw0a+nG2TivaK5vmV5DYmrA=;
        b=wIZcrT5/cvLie9g6G6OPEqcofajzyIM/2qmyTeTPAYO5YWLE6TqUPdHkflGePVGf8h
         v6oHWJOKC8kKjrS18qfXRmUwWKlM2+526+IGnzZ7wEIJPWMi5fsgRYX3AFQWp6G708te
         Tub5pnOLkTdsNUeMvukwj/WA19FJkgBsdAUcKkjZm6+jxUf1unxnvo4f8B4WOu8cMGSK
         oM3sbFHLyu6d1qLR/Qb4rHnONuak+FeIUnVewR4vuj3bLga/mhbhfiOM4qquPqaa1q1t
         bhAGARNc7zgx+LKQOedW/IHXxhMJimZ+gqNC0yAmiW8nDax97GFGw+BJROcX5lvPbLfY
         HPqA==
X-Forwarded-Encrypted: i=1; AJvYcCWOQgnoQ+9wvSW0z117aDq0tn4sl805uu3TLXgXtiYqofbauJmLGotRmapJinJNGsfajdTnTKWK3hZK67FoVuCrlHWD+POy2GLUFpI7
X-Gm-Message-State: AOJu0YyZgp9H6KK6dogXOOG9zkgk7Zy4iQiaj2HgYm0ZmwHonNLZXEVj
	zrgQVJTqw+seR/TjrmQ9OmrG/NXFNJCHe4/lPgTlqNHNVkrymLbYdIKT5Fel1EOYT4+knE1MGqi
	TjycJ2VvfafkUV72GIJhuxyQVKg0o8OHhvtO+
X-Google-Smtp-Source: AGHT+IFBbUXxWVS/k4A2acQWp/MCTFiIGxGOGHdZ4HqDcNm4MKFFPjKu0aCDg4uXIPnplGVN/UA7gi9I2BjYNoO8ca8=
X-Received: by 2002:a05:600c:4e55:b0:41f:9dd0:7168 with SMTP id
 5b1f17b1804b1-4200ee13359mr899435e9.2.1715404521631; Fri, 10 May 2024
 22:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320180429.678181-1-hannes@cmpxchg.org>
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 10 May 2024 23:14:43 -0600
Message-ID: <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
To: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> V4:
> - fixed !pcp_order_allowed() case in free_unref_folios()
> - reworded the patch 0 changelog a bit for the git log
> - rebased to mm-everything-2024-03-19-23-01
> - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
>
> ---
>
> The page allocator's mobility grouping is intended to keep unmovable
> pages separate from reclaimable/compactable ones to allow on-demand
> defragmentation for higher-order allocations and huge pages.
>
> Currently, there are several places where accidental type mixing
> occurs: an allocation asks for a page of a certain migratetype and
> receives another. This ruins pageblocks for compaction, which in turn
> makes allocating huge pages more expensive and less reliable.
>
> The series addresses those causes. The last patch adds type checks on
> all freelist movements to prevent new violations being introduced.
>
> The benefits can be seen in a mixed workload that stresses the machine
> with a memcache-type workload and a kernel build job while
> periodically attempting to allocate batches of THP. The following data
> is aggregated over 50 consecutive defconfig builds:
>
>                                                         VANILLA          =
       PATCHED
> Hugealloc Time mean                      165843.93 (    +0.00%)  113025.8=
8 (   -31.85%)
> Hugealloc Time stddev                    158957.35 (    +0.00%)  114716.0=
7 (   -27.83%)
> Kbuild Real time                            310.24 (    +0.00%)     300.7=
3 (    -3.06%)
> Kbuild User time                           1271.13 (    +0.00%)    1259.4=
2 (    -0.92%)
> Kbuild System time                          582.02 (    +0.00%)     559.7=
9 (    -3.81%)
> THP fault alloc                           30585.14 (    +0.00%)   40853.6=
2 (   +33.57%)
> THP fault fallback                        36626.46 (    +0.00%)   26357.6=
2 (   -28.04%)
> THP fault fail rate %                        54.49 (    +0.00%)      39.2=
2 (   -27.53%)
> Pagealloc fallback                         1328.00 (    +0.00%)       1.0=
0 (   -99.85%)
> Pagealloc type mismatch                  181009.50 (    +0.00%)       0.0=
0 (  -100.00%)
> Direct compact stall                        434.56 (    +0.00%)     257.6=
6 (   -40.61%)
> Direct compact fail                         421.70 (    +0.00%)     249.9=
4 (   -40.63%)
> Direct compact success                       12.86 (    +0.00%)       7.7=
2 (   -37.09%)
> Direct compact success rate %                 2.86 (    +0.00%)       2.8=
2 (    -0.96%)
> Compact daemon scanned migrate          3370059.62 (    +0.00%) 3612054.7=
6 (    +7.18%)
> Compact daemon scanned free             7718439.20 (    +0.00%) 5386385.0=
2 (   -30.21%)
> Compact direct scanned migrate           309248.62 (    +0.00%)  176721.0=
4 (   -42.85%)
> Compact direct scanned free              433582.84 (    +0.00%)  315727.6=
6 (   -27.18%)
> Compact migrate scanned daemon %             91.20 (    +0.00%)      94.4=
8 (    +3.56%)
> Compact free scanned daemon %                94.58 (    +0.00%)      94.4=
2 (    -0.16%)
> Compact total migrate scanned           3679308.24 (    +0.00%) 3788775.8=
0 (    +2.98%)
> Compact total free scanned              8152022.04 (    +0.00%) 5702112.6=
8 (   -30.05%)
> Alloc stall                                 872.04 (    +0.00%)    5156.1=
2 (  +490.71%)
> Pages kswapd scanned                     510645.86 (    +0.00%)    3394.9=
4 (   -99.33%)
> Pages kswapd reclaimed                   134811.62 (    +0.00%)    2701.2=
6 (   -98.00%)
> Pages direct scanned                      99546.06 (    +0.00%)  376407.5=
2 (  +278.12%)
> Pages direct reclaimed                    62123.40 (    +0.00%)  289535.7=
0 (  +366.06%)
> Pages total scanned                      610191.92 (    +0.00%)  379802.4=
6 (   -37.76%)
> Pages scanned kswapd %                       76.36 (    +0.00%)       0.1=
0 (   -98.58%)
> Swap out                                  12057.54 (    +0.00%)   15022.9=
8 (   +24.59%)
> Swap in                                     209.16 (    +0.00%)     256.4=
8 (   +22.52%)
> File refaults                             17701.64 (    +0.00%)   11765.4=
0 (   -33.53%)
>
> Huge page success rate is higher, allocation latencies are shorter and
> more predictable.
>
> Stealing (fallback) rate is drastically reduced. Notably, while the
> vanilla kernel keeps doing fallbacks on an ongoing basis, the patched
> kernel enters a steady state once the distribution of block types is
> adequate for the workload. Steals over 50 runs:
>
> VANILLA         PATCHED
> 1504.0          227.0
> 1557.0          6.0
> 1391.0          13.0
> 1080.0          26.0
> 1057.0          40.0
> 1156.0          6.0
> 805.0           46.0
> 736.0           20.0
> 1747.0          2.0
> 1699.0          34.0
> 1269.0          13.0
> 1858.0          12.0
> 907.0           4.0
> 727.0           2.0
> 563.0           2.0
> 3094.0          2.0
> 10211.0         3.0
> 2621.0          1.0
> 5508.0          2.0
> 1060.0          2.0
> 538.0           3.0
> 5773.0          2.0
> 2199.0          0.0
> 3781.0          2.0
> 1387.0          1.0
> 4977.0          0.0
> 2865.0          1.0
> 1814.0          1.0
> 3739.0          1.0
> 6857.0          0.0
> 382.0           0.0
> 407.0           1.0
> 3784.0          0.0
> 297.0           0.0
> 298.0           0.0
> 6636.0          0.0
> 4188.0          0.0
> 242.0           0.0
> 9960.0          0.0
> 5816.0          0.0
> 354.0           0.0
> 287.0           0.0
> 261.0           0.0
> 140.0           1.0
> 2065.0          0.0
> 312.0           0.0
> 331.0           0.0
> 164.0           0.0
> 465.0           1.0
> 219.0           0.0
>
> Type mismatches are down too. Those count every time an allocation
> request asks for one migratetype and gets another. This can still
> occur minimally in the patched kernel due to non-stealing fallbacks,
> but it's quite rare and follows the pattern of overall fallbacks -
> once the block type distribution settles, mismatches cease as well:
>
> VANILLA:        PATCHED:
> 182602.0        268.0
> 135794.0        20.0
> 88619.0         19.0
> 95973.0         0.0
> 129590.0        0.0
> 129298.0        0.0
> 147134.0        0.0
> 230854.0        0.0
> 239709.0        0.0
> 137670.0        0.0
> 132430.0        0.0
> 65712.0         0.0
> 57901.0         0.0
> 67506.0         0.0
> 63565.0         4.0
> 34806.0         0.0
> 42962.0         0.0
> 32406.0         0.0
> 38668.0         0.0
> 61356.0         0.0
> 57800.0         0.0
> 41435.0         0.0
> 83456.0         0.0
> 65048.0         0.0
> 28955.0         0.0
> 47597.0         0.0
> 75117.0         0.0
> 55564.0         0.0
> 38280.0         0.0
> 52404.0         0.0
> 26264.0         0.0
> 37538.0         0.0
> 19671.0         0.0
> 30936.0         0.0
> 26933.0         0.0
> 16962.0         0.0
> 44554.0         0.0
> 46352.0         0.0
> 24995.0         0.0
> 35152.0         0.0
> 12823.0         0.0
> 21583.0         0.0
> 18129.0         0.0
> 31693.0         0.0
> 28745.0         0.0
> 33308.0         0.0
> 31114.0         0.0
> 35034.0         0.0
> 12111.0         0.0
> 24885.0         0.0
>
> Compaction work is markedly reduced despite much better THP rates.
>
> In the vanilla kernel, reclaim seems to have been driven primarily by
> watermark boosting that happens as a result of fallbacks. With those
> all but eliminated, watermarks average lower and kswapd does less
> work. The uptick in direct reclaim is because THP requests have to
> fend for themselves more often - which is intended policy right
> now. Aggregate reclaim activity is lowered significantly, though.

This series significantly regresses Android and ChromeOS under memory
pressure. THPs are virtually nonexistent on client devices, and IIRC,
it was mentioned in the early discussions that potential regressions
for such a case are somewhat expected?

On Android (ARMv8.2), app launch time regressed by about 7%; On
ChromeOS (Intel ADL), tab switch time regressed by about 8%. Also PSI
(full and some) on both platforms increased by over 20%. I could post
the details of the benchmarks and the metrics they measure, but I
doubt they would mean much to you. I did ask our test teams to save
extra kernel logs that might be more helpful, and I could forward them
to you.

Note that the numbers above were from the default LRU, not MGLRU,
which I specifically asked our test teams to disable to double check
the regressions.

Given the merge window will be open soon, I don't plan to stand in its
way. If we can't fix the regression after a reasonable amount of time,
can we find a way to disable this series runtime/build time?

