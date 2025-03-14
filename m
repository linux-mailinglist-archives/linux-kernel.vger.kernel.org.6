Return-Path: <linux-kernel+bounces-562153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D0A61D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC47189B8B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D691ACED3;
	Fri, 14 Mar 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ppmFsx0t"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9419E7D0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986367; cv=none; b=Z8AKzW0SD/gfE5HFF1KGfAjQKdibP9xvu3w5uVumqIAROZpeW8iX/wnbch3Vmoou3zxyjDCnAhj1kDHiZJDpxzQ83qFiY3/Yoz1AmPjp7ouY9vTaYBze78avCqyV/UDLyUfwHWDf9OK4zH3voZLo5hwKWhmic3JEYCGzWJHCWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986367; c=relaxed/simple;
	bh=dODjm/3Gs1B+O1SNWuDcmxAG3onfL3WVYYyd5SsMec0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF6cYtsbKQ6mhElGo3A7lLisHkA73IPIVbpj3z4jxNC5LQNh2p9YxqQlzdMixp3FMKpoeRIR32KtSNn3Xue7dlbvAsvbGQDLJRz0cw5PA1d5/ZclENGCZZDcGuKB0zQNNRY//WCHpXsv59NeW8Kb8Rd0yNu1y0enR0SYcDx3Xlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ppmFsx0t; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c54a9d3fcaso253953585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741986363; x=1742591163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wouJWyoqE8ZpbRdKYnwSI+aPBYLXbj4bary9x6Givhk=;
        b=ppmFsx0tcyuypfsxlgv6+bSpWkB20j68ms53rbXl7+KxJSqEwg2RDMUqekLVSu19X3
         VRqZdeFPYywkts1y+OQAn/1LRtLlu9XIJjZPgbBq+/UWB9E5mFW64hpCXI4dO9rdNYUr
         PrlnUKOPPMA0g+3ILV29kMqXhjFfpoUDa866lImYsapTlAA2UhryE4SCKCaHSuJCCuJ4
         /3MTm5jB0fhwY5Kdh2AUDIi2Os+EHKl3YY3qXBIARt+UBrZKbWk6DAZyDf+XdEN2ePT5
         0tIvUXnv6E19A9w7AL8Kb1i9GyNW8smoo8aFNflGLAk3wnD855+n1AtIR4n2TQiFN/6c
         6Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741986363; x=1742591163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wouJWyoqE8ZpbRdKYnwSI+aPBYLXbj4bary9x6Givhk=;
        b=R2U2wNSBhX50ePpaOxoVY2kRgvobZqX2cRHkkS5VayFmBscwBaKBcnzdZD0TnDPRFs
         +bC1wjVTVlBnB/kGr3oye8Z27+MuQT0HTnFDqmCj5wrZaklQixWtQgt/al96v3RrtHxT
         ZbU2Hm5DbzgOfd6qJDnzOcGK+o2bHAgOz2bg4o37JmR2LNC/6PrnfFygzXIbKEXxtOpY
         RgqXr2p2AaHrM3ZRPWw3Lb9lfRMEFHiSWCfo2yomkEinR0nzwDFR4xiENyvRArbZLXrf
         /tT8KvB77fooB/yqq6eeIyl13WPT6vrOjRdGzcLWhFg+oBP5j+xCp+8gW44kSEA99oTC
         WhPw==
X-Forwarded-Encrypted: i=1; AJvYcCXxbM/4H+FB5wo0tzWuhG9HpGPkoBHzYhWQhDAJWit29SfShIuB26Q8yG+byHah0zV5sv/vE31PSMqhXNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyktPQTe31jhmiUE1hIPjsLe/kfe9g5vLrXubO8Us5wISwr6XDj
	1MVWy2kPZlHO552qgzoyv31By4Kl/tKLOJTNTMGEqvWDcuqRQ7lYhSP6E6rhTOQ=
X-Gm-Gg: ASbGnctGad4uPPLPtew4rAPItHFT4ZIaAhDNevECMwIvK0ZVfkSr//L8kShBHGSrgC7
	XZ5MbUMdMoqdpxhipwdYeP7H7TPhTAca+2SiCbeWFTOSLc1KIw5O4Np/KsE4OD7MykOskrtA164
	IgWULZtmdcM3Hh8rd+FhEgb0qGDQwcewBJLehjh/Lvz6WcNLTKkyVnEuynFQtNaYB8H5XF6NEBz
	yLcTDcHIvIdbL9Jvt5M2AiBXdPkrxog+4vLPRdHFYen+TJQTulF89L1rmpZJnDODfYl3732HNYF
	GAsHr2V6MH8+bLvxKHFg0KY7LFtCOTOOJX3pn65rkUo=
X-Google-Smtp-Source: AGHT+IHzAK5TurTbeJNlYYY/Gy5+4Uau1jNFIkO8qge0TCNONcogZCW2HlHi8miPmY46e06XC0SziQ==
X-Received: by 2002:a05:620a:8003:b0:7c5:4eee:5405 with SMTP id af79cd13be357-7c57c8fc474mr560621285a.35.1741986363439;
        Fri, 14 Mar 2025 14:06:03 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d9256asm296990185a.106.2025.03.14.14.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:06:02 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:05:58 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: page_alloc: defrag_mode kswapd/kcompactd
 watermarks
Message-ID: <20250314210558.GD1316033@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-6-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313210647.1314586-6-hannes@cmpxchg.org>

Andrew, could you please fold this delta patch?

---

From 3d2ff7b72df9e4f1a31b3cff2ae6a4584c06bdca Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 14 Mar 2025 11:38:41 -0400
Subject: [PATCH] mm: page_alloc: defrag_mode kswapd/kcompactd watermarks fix

Fix squawks from rebasing that affect the behavior of !defrag_mode.

FWIW, it seems to actually have slightly helped the vanilla kernel in
the benchmark. But the point was to not change the default behavior:

                                                VANILLA        WMARKFIX-VANILLA
Hugealloc Time mean               52739.45 (    +0.00%)   62758.21 (   +19.00%)
Hugealloc Time stddev             56541.26 (    +0.00%)   76253.41 (   +34.86%)
Kbuild Real time                    197.47 (    +0.00%)     197.25 (    -0.11%)
Kbuild User time                   1240.49 (    +0.00%)    1241.33 (    +0.07%)
Kbuild System time                   70.08 (    +0.00%)      71.00 (    +1.28%)
THP fault alloc                   46727.07 (    +0.00%)   41492.73 (   -11.20%)
THP fault fallback                21910.60 (    +0.00%)   27146.53 (   +23.90%)
Direct compact fail                 195.80 (    +0.00%)     260.93 (   +33.10%)
Direct compact success                7.93 (    +0.00%)       6.67 (   -14.18%)
Direct compact success rate %         3.51 (    +0.00%)       2.76 (   -16.78%)
Compact daemon scanned migrate  3369601.27 (    +0.00%) 3827734.27 (   +13.60%)
Compact daemon scanned free     5075474.47 (    +0.00%) 5910839.73 (   +16.46%)
Compact direct scanned migrate   161787.27 (    +0.00%)  168271.13 (    +4.01%)
Compact direct scanned free      163467.53 (    +0.00%)  222558.33 (   +36.15%)
Compact total migrate scanned   3531388.53 (    +0.00%) 3996005.40 (   +13.16%)
Compact total free scanned      5238942.00 (    +0.00%) 6133398.07 (   +17.07%)
Alloc stall                        2371.07 (    +0.00%)    2478.00 (    +4.51%)
Pages kswapd scanned            2160926.73 (    +0.00%) 1726204.67 (   -20.12%)
Pages kswapd reclaimed           533191.07 (    +0.00%)  537963.73 (    +0.90%)
Pages direct scanned             400450.33 (    +0.00%)  450004.87 (   +12.37%)
Pages direct reclaimed            94441.73 (    +0.00%)   99193.07 (    +5.03%)
Pages total scanned             2561377.07 (    +0.00%) 2176209.53 (   -15.04%)
Pages total reclaimed            627632.80 (    +0.00%)  637156.80 (    +1.52%)
Swap out                          47959.53 (    +0.00%)   45186.20 (    -5.78%)
Swap in                            7276.00 (    +0.00%)    7109.40 (    -2.29%)
File refaults                    138043.00 (    +0.00%)  145238.73 (    +5.21%)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 4a2ccb82d0b2..a481755791a9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3075,6 +3075,8 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 	struct zone *zone;
 	enum zone_type highest_zoneidx = pgdat->kcompactd_highest_zoneidx;
 	enum compact_result ret;
+	unsigned int alloc_flags = defrag_mode ?
+		ALLOC_WMARK_HIGH : ALLOC_WMARK_MIN;
 
 	for (zoneid = 0; zoneid <= highest_zoneidx; zoneid++) {
 		zone = &pgdat->node_zones[zoneid];
@@ -3084,7 +3086,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 
 		ret = compaction_suit_allocation_order(zone,
 				pgdat->kcompactd_max_order,
-				highest_zoneidx, ALLOC_WMARK_MIN,
+				highest_zoneidx, alloc_flags,
 				false, true);
 		if (ret == COMPACT_CONTINUE)
 			return true;
@@ -3108,7 +3110,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.mode = MIGRATE_SYNC_LIGHT,
 		.ignore_skip_hint = false,
 		.gfp_mask = GFP_KERNEL,
-		.alloc_flags = ALLOC_WMARK_HIGH,
+		.alloc_flags = defrag_mode ? ALLOC_WMARK_HIGH : ALLOC_WMARK_MIN,
 	};
 	enum compact_result ret;
 
-- 
2.48.1


