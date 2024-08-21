Return-Path: <linux-kernel+bounces-296095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC40295A58A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C767B21876
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E14D16F0E7;
	Wed, 21 Aug 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL0PmgDi"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4209165F04
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270005; cv=none; b=Qhv8oLi1JqCVgCmoOu+LUfEiQAtVC8X9OjiOA0Tz08FlzCiNiY3cDITLjparCTC30NvGH50zTh/zRmMiua0cWK80RDkmw8uAwh5bpeCjommHNzysm5wVHvhyfr/2Ftz9aegU8oyCQdYNNxbP20v8X6+uCtngW1nK4s4dG3cFdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270005; c=relaxed/simple;
	bh=oKAFDRQvHOrqmpuMdC3MyDSZv740IrdLiSDVVb9RLM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLPy5L2JJ2IoIujrB4mdKv273moqvW7m9kYI81tkAwYBjUxrbsxLSO8RkQ4/ATEBWUQtwewLJebxB0HcESTCvJ1QN6YAB9QysM8iiouuqMAj6GWIMILM6PreM6l4fjvd0Ij05Oa/CQY6wk7pdAxpcJpneLRBciTd2Lo5JP0ccjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL0PmgDi; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso16286d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724270003; x=1724874803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4AbeBp16nw4czVn9kz+rOchj8v+XTaUYNOBx/r7ZHg=;
        b=aL0PmgDiFPAEFg+W0s+yFc8DntDy+iN8b/W+cJePIl+x3Gf669x36rtRU3t+xu8Gfv
         HhKfeiLHNciwf13ZrAeM8H5f5s+Cz+UwCKaper0fj7q6Ubfg/k2fY0iwSTqgbZhOOPJp
         up/hQnBJyHrfgKHUZQZudB4idY1tWLRbfZ5hzn1F+uV+/MKKMBQjEiDLu9OJDelGJh6r
         9BL62LvY7ViVKpQT8ZiGTbB7LutCjNAcWI4+zaFZDjrZf4lj6wtFhROLge7n/m2FsLFq
         z5CMxrZJq7Ss6KHm45Vj/yUqOpvucarTk/o3kueIVqG+1tnVcPeNFqIgiBrrNVnWMAo4
         i2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724270003; x=1724874803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4AbeBp16nw4czVn9kz+rOchj8v+XTaUYNOBx/r7ZHg=;
        b=bXADFRGZXMD27IQq8Xq6mNKj4tuM3EwyvI/QyZn42FZor1StPZ2SupZQDIvwzsEHjS
         5PUuuatrGpUYNXJB58K5CS+gqNuenyfUVqpq9+Hp5nX+blVzp96tj/+PZ86J5gz1E1HG
         1SWt3+5RSfE+6Xmj+QwGzKQhVDR7F5QcCDrlRtXM2f8eGfcpnxN+wJ+liMvYPqY4Mo5F
         QAoL36NZL7RZH3SmB1ZXbZGFXHCZjzp7/8kFqXioT3/po8estxIHuQEkP04/l/Z3BID2
         Qa7xkJTMWDhuvUWeOExpRx4nfZakDG/LNEFO3L1GAwoM+oJykxXHDe030vVhMYN+lUB8
         mUHw==
X-Forwarded-Encrypted: i=1; AJvYcCWsIL34udSc85JNu13yT+oSksTDdcF4AJLxIJr7f8VVS22jG20ob74AePu3ExjQYcOR74qG/3W0m97eOnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMA9qqBZH0SsgJDKLo7EO/nlGQoqAtF5FgCUZougtyw5+JMF8h
	mfusd3vIhoHXT+CxsUOiMiUCf06gmAIZJDEbgLGIGYp8FqcmV+X2
X-Google-Smtp-Source: AGHT+IEMiQjoQXqoIyu/7ESqiQuISzW644WZkZxy1Jju73xg1e/UiwIn2csfFUZQvJ0W3v4PIVTGRw==
X-Received: by 2002:a05:6214:4a8c:b0:6bf:8186:be32 with SMTP id 6a1803df08f44-6c155e09dd1mr42955886d6.38.1724270002500;
        Wed, 21 Aug 2024 12:53:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::4:d08d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162de8354sm217726d6.135.2024.08.21.12.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 12:53:22 -0700 (PDT)
Message-ID: <9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com>
Date: Wed, 21 Aug 2024 15:53:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mm: skip CMA pages when they are not available"
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, riel@surriel.com, zhaoyang.huang@unisoc.com,
 yuzhao@google.com, david@redhat.com, leitao@debian.org,
 huangzhaoyang@gmail.com, bharata@amd.com, willy@infradead.org,
 vbabka@suse.cz, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240821193506.1525996-1-usamaarif642@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240821193506.1525996-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21/08/2024 15:35, Usama Arif wrote:
> This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b.
> 
> lruvec->lru_lock is highly contended and is held when calling
> isolate_lru_folios. If the lru has a large number of CMA folios
> consecutively, while the allocation type requested is not
> MIGRATE_MOVABLE, isolate_lru_folios can hold the lock for a very long
> time while it skips those. For FIO workload, ~150million order=0
> folios were skipped to isolate a few ZONE_DMA folios [1].
> This can cause lockups [1] and high memory pressure for extended periods
> of time [2].
> 
> [1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
> [2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  mm/vmscan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5dc96a843466..78ad4a141409 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1690,8 +1690,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
> -				skip_cma(folio, sc)) {
> +		if (folio_zonenum(folio) > sc->reclaim_idx) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
>  			goto move;


Actually, I didn't build test this with other config options before sending this patch.
skip_cma is only neeeded with MGLRU after this patch, we need to move the definition of
the function to be guarded under CONFIG_LRU_GEN, so that we don't get 
‘skip_cma’ defined but not used error. Below patch should be good:


From 1aae7f04a5cb203ea2c3ede7973dd9eddbbd7a8b Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Wed, 21 Aug 2024 20:26:07 +0100
Subject: [PATCH] Revert "mm: skip CMA pages when they are not available"

This reverts commit 5da226dbfce3a2f44978c2c7cf88166e69a6788b.

lruvec->lru_lock is highly contended and is held when calling
isolate_lru_folios. If the lru has a large number of CMA folios
consecutively, while the allocation type requested is not
MIGRATE_MOVABLE, isolate_lru_folios can hold the lock for a very long
time while it skips those. For FIO workload, ~150million order=0
folios were skipped to isolate a few ZONE_DMA folios [1].
This can cause lockups [1] and high memory pressure for extended periods
of time [2].

[1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
[2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/vmscan.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5dc96a843466..53372f726a1b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1625,25 +1625,6 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
 
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
@@ -1690,8 +1671,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx ||
-				skip_cma(folio, sc)) {
+		if (folio_zonenum(folio) > sc->reclaim_idx) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
@@ -4297,6 +4277,25 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 
 #endif /* CONFIG_MEMCG */
 
+#ifdef CONFIG_CMA
+/*
+ * It is waste of effort to scan and reclaim CMA pages if it is not available
+ * for current allocation context. Kswapd can not be enrolled as it can not
+ * distinguish this scenario by using sc->gfp_mask = GFP_KERNEL
+ */
+static bool skip_cma(struct folio *folio, struct scan_control *sc)
+{
+	return !current_is_kswapd() &&
+			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
+			folio_migratetype(folio) == MIGRATE_CMA;
+}
+#else
+static bool skip_cma(struct folio *folio, struct scan_control *sc)
+{
+	return false;
+}
+#endif
+
 /******************************************************************************
  *                          the eviction
  ******************************************************************************/
-- 
2.43.5





