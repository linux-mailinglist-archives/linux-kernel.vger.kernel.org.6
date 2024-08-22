Return-Path: <linux-kernel+bounces-297505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A495B9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66363B25E08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F41CCEE2;
	Thu, 22 Aug 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTDE6c++"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17911CDA08
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339609; cv=none; b=kx4qKl6Bro5KDPfy/0BHjvekR9K2rDA5KmFkdVV3uC/uuCg/17tsxdPO56HZO0cfpyiTouxOV1xWGkvyhNS27cgZFjCMYxqygMZzEsk1eE+Fe1IjQLqFO54+E5vWKz+VPsBtwv0wmMGWXlzN9MXaMZty82pRuRA1XVGAhbQAqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339609; c=relaxed/simple;
	bh=L+lXKmykCYob4qC/y7DWSoCIjBDm1PtSLk1koI1fLoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqistuCGFeiLimOVr8jxpzkxIcTCMs8ZM3pLm7ytK8OBUOIK0Ac1D3i3c5qQp2F7gTwFDQ3sSZufxXVLdjiC/rrYKAr6gBJsTOSGxtcj/hR6HV0x5BVAR/BFbvjrAtPl9V73TTuBl2GZ/teSAT79mcKALT1A01+Wn71imYaSXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTDE6c++; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fdcd7a622so5937561cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724339604; x=1724944404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8WIaf3Q3cLnhaZNJqkPxJci/umcMRGai0y8Ow1nI+m8=;
        b=QTDE6c++3hmMaVaT1dtzsBe/HnmhdXCaT0KIYkLJX0GwoDk39BksnxC0XoGA0lNrY6
         3XI1/jeB8J2ajNlHkZ3KCOnkGA4V/4k6yzGblUObDfFykxChzHRpzJv6czcrpWl8O9IO
         0ZqptZ9OeTM7J+3X0D39R6mi3tvyH+LEyF0ko3MXT2UIOYp99ZTmiTEWeMzITdF9dm4j
         /Z4CtgqCWCNjLHxG7rtMHDe3xPbXdUDJ/l63eJIpQS97n4+PJ/SjggKWZKZHTy7PIIjs
         RU8/r6/jm8aG3Rtetr76pOOWwUzee+icB7mxTZCUKAK7gYqgNoAIuaVoIlqVNgF5SPdi
         ulZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724339604; x=1724944404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WIaf3Q3cLnhaZNJqkPxJci/umcMRGai0y8Ow1nI+m8=;
        b=ot2WIQ/CMePmhK5L+HFdYnNoKenUgDiy+tFCUNxJNd3aYCd0UTZRU4rQCxtDrVSSfU
         OYUCYOak4HWX/VHVAa5DdPgN8xwSXYNK4RFUlKL8Aha/7qpMhA0SSLe2SzULJW0FxMQ7
         vL2V2iliN1N5ry7Gq9VO9QfAEsdyhTnGeIdYIUOO2CAvKljR5CT1oNSIsFX23iCmg9Cz
         lyi+8Oc0o29Ji+XAEu5VQS46MvEWNWDawERqW6o0NvouXhdvog0pbHlAAKn9yIcXso8y
         iiV4opIfis8d4EWqD70zAf3h0GycVDSexusKPFmfegxxLpxNtfKb2tMAd8E3QuQGMZfz
         0Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCXOtGRK/xLNEgkMa/uk4arpOWzXLi7OYkEWJbOHBca13FPmmIerVQ7TWDnJT49yrouRbViPPfCW/fdosAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGp7IH5z461h6uqOXDAu/hKHXyuGYY3KqpqHxXiXsQwVWFoVg
	OuaCh1jvlY//APh5ZM54ZYler/8KfGWOtPcmOTvvgspj2V00tPAa
X-Google-Smtp-Source: AGHT+IEafk/M6iYKVkuG676Bzj1A7nqIKe/DhEvBYXb0p9RL53prHrzYNlTqW366w2cyYsrJxTGHtA==
X-Received: by 2002:a05:622a:a0c:b0:44f:9ae7:c883 with SMTP id d75a77b69052e-454f269820cmr49386811cf.63.1724339604267;
        Thu, 22 Aug 2024 08:13:24 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::6:7e3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196866sm7540681cf.78.2024.08.22.08.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 08:13:23 -0700 (PDT)
Message-ID: <357ac325-4c61-497a-92a3-bdbd230d5ec9@gmail.com>
Date: Thu, 22 Aug 2024 11:13:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mm: skip CMA pages when they are not available"
To: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org
Cc: riel@surriel.com, zhaoyang.huang@unisoc.com, yuzhao@google.com,
 david@redhat.com, leitao@debian.org, huangzhaoyang@gmail.com,
 bharata@amd.com, willy@infradead.org, vbabka@suse.cz,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240821193506.1525996-1-usamaarif642@gmail.com>
 <9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com>
 <20240822104323.GA315708@cmpxchg.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240822104323.GA315708@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/08/2024 06:43, Johannes Weiner wrote:
> On Wed, Aug 21, 2024 at 03:53:21PM -0400, Usama Arif wrote:
>> From 1aae7f04a5cb203ea2c3ede7973dd9eddbbd7a8b Mon Sep 17 00:00:00 2001
>> From: Usama Arif <usamaarif642@gmail.com>
>> Date: Wed, 21 Aug 2024 20:26:07 +0100
>> Subject: [PATCH] Revert "mm: skip CMA pages when they are not available"
>>
>> This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b.
>>
>> lruvec->lru_lock is highly contended and is held when calling
>> isolate_lru_folios. If the lru has a large number of CMA folios
>> consecutively, while the allocation type requested is not
>> MIGRATE_MOVABLE, isolate_lru_folios can hold the lock for a very long
>> time while it skips those. For FIO workload, ~150million order=0
>> folios were skipped to isolate a few ZONE_DMA folios [1].
>> This can cause lockups [1] and high memory pressure for extended periods
>> of time [2].
>>
>> [1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
>> [2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I think this is the right move for now, until there is a robust
> solution for the original issue.
> 
> But hould b7108d66318abf3e060c7839eabcba52e9461568 be reverted along
> with it? From its changelog:
> 
>     No observable issue without this patch on MGLRU, but logically it make
>     sense to skip the CMA page reclaim when those pages can't be satisfied for
>     the current allocation context.
> 
> Presumably it has the same risk reward profile as it does on
> conventional reclaim, with long skip runs while holding the
> lruvec->lock.

Yes makes sense to remove it from there a well, Just doing it in a single commit below:

From 9ad9fb73edf2c04ef932d128fc2729dfd8391c0c Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Wed, 21 Aug 2024 20:26:07 +0100
Subject: [PATCH] Revert "mm: skip CMA pages when they are not available"

This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b and
b7108d66318abf3e060c7839eabcba52e9461568.

lruvec->lru_lock is highly contended and is held when calling
isolate_lru_folios.  If the lru has a large number of CMA folios
consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
isolate_lru_folios can hold the lock for a very long time while it skips
those.  For FIO workload, ~150million order=0 folios were skipped to
isolate a few ZONE_DMA folios [1].  This can cause lockups [1] and high
memory pressure for extended periods of time [2].

Remove skipping CMA for MGLRU as well, as it was introduced in
sort_folio for the same resaon as 5da226dbfce3a2f44978c2c7cf88166e69a6788b.

[1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
[2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

Link: https://lkml.kernel.org/r/9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com
Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..bd489c1af228 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1604,25 +1604,6 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
 
 }
 
-#ifdef CONFIG_CMA
-/*
- * It is waste of effort to scan and reclaim CMA pages if it is not available
- * for current allocation context. Kswapd can not be enrolled as it can not
- * distinguish this scenario by using sc->gfp_mask = GFP_KERNEL
- */
-static bool skip_cma(struct folio *folio, struct scan_control *sc)
-{
-	return !current_is_kswapd() &&
-			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
-			folio_migratetype(folio) == MIGRATE_CMA;
-}
-#else
-static bool skip_cma(struct folio *folio, struct scan_control *sc)
-{
-	return false;
-}
-#endif
-
 /*
  * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
  *
@@ -1669,8 +1650,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx ||
-				skip_cma(folio, sc)) {
+		if (folio_zonenum(folio) > sc->reclaim_idx) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
@@ -4320,7 +4300,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
+	if (zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
-- 
2.43.5






