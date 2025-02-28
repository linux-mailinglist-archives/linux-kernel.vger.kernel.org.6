Return-Path: <linux-kernel+bounces-539173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A94A4A1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC5E3B3413
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334A277014;
	Fri, 28 Feb 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uz3XWyWf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C527AA61
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767426; cv=none; b=AL2yxodqOvqz+dH9B9XvrBgUbnfagd5gjwZZj/cu1oyxmTaqpIVOrMK9pchjuqDtIn6I5ZDLk7nKf8hHQLJtxqiycqr75Uf1zP9Y82DNfoauaZX5TeO50nEmVaLpHqbG/mqMF2A1VwObpAOKW3gDk8y7EgWJfxnk9LZC7ybGwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767426; c=relaxed/simple;
	bh=8GUE6c39N0/vGXgmG14efZlKjAYbe0xbfmj7LVTyYUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XGFMoClmWEE960u3CM65l9bcPBEIIZ/DsUOMs/F3yhJ9wJN7bBQW6XpYZ+x+92TC6mET582WvCb3t7aEY16OJ1Wg1mVkGf/n4yduIV4UsPuVq3kHK7cx/G1Z4jav6eIyVfbycLFv9UmTgNLz1qFjUDeBUq1xIujkzXHxMpEZ5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uz3XWyWf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f816a85facso5031417a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767424; x=1741372224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pj/N1+GF3Q+15wlANDSI128u4evupABN+ixVt0HlBM=;
        b=uz3XWyWffHFRvWCksLH1rCtSx/ChyOlQAMOPZJbEfhdN4x9Ilr/k470buIFnDycbzv
         3eQhsDiCkHfJXY7YUIkd7/mzWP8jnW20Xh/HHtSGazRHw5Dq+koubYC6WX4uBZWt6u1+
         HJXfoX/yDTWE3RzMm2lr32hhFnd4YAO73NkpqecQKXmo6wpnR7SV2hgpbhQB8hjBsoKi
         ClEO+BCy4O15ZqTeTXIzCVyqxk7hpLfJKp1kIRtPA4KnVD85nK7pmoh8lxT5sIKQSZcr
         GeIk3+rfX9SNqVgSab1rIWKfUKrWPcSh35LpG7YjvOCIkkvokZsdBpTJY+dOf0VjAto5
         QZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767424; x=1741372224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pj/N1+GF3Q+15wlANDSI128u4evupABN+ixVt0HlBM=;
        b=nGxRVbvEfDZh7B+DkqkprhYJYHMU80SgEczA0f8fo9if8SIk0VoMAyQflHfFbixcwB
         FVawEhfCCssvK8d+lco53jnV7hnWa/nYIfxCREBHYklqQ66xuFXDeOH78oDbl4xAQNot
         t41CyxmelNtFtH0n1ItPvw3+3HiHD8vVhI9r7qhOH9J0W3XM2r/qZfEIV86EIxVq8A2p
         OaRrZT9bwaZZJjUxEjSYP9a32jhmSxLrrACW/hvb8B/Ti8GbSOGexx9QhwH0UUd1Dy0p
         fQimeKubjUMi2Ua/bPVROx2gOBTF9YMZDfqNzGu1ry0gUYk/qunH+C1dYy5yhWAHaBaN
         AO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUq8SL93wwgwUTu0xDZ394dS6BJXKrz0heQRWb2VA4Wop9QXiSCXhPYmSdSIzbiKicLUZtjSh6BtIhSCfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4R/4+YI5o9e4o1Nxdqou+oy/B8iBvPcyPDh91JS7DgW0+5Ip2
	aJWJH/nr8Xm1WIn07J2YVVcmDQIeb1WiQeIzKNiNh3+tusmM3e6r1HzxHpasqmXcYUVKWA==
X-Google-Smtp-Source: AGHT+IF24dXL3LJ+F8+s7hLTj4qoGxn/r2uY+HJ8KpKKTOzotTZzgKMLzWfSEpexnlD+Bvn5pLcYDA3/
X-Received: from pgwb25.prod.google.com ([2002:a65:6699:0:b0:af1:44fa:2fc3])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:600e:b0:1f1:1cd1:e3fa
 with SMTP id adf61e73a8af0-1f2f4c9c728mr8137086637.6.1740767424601; Fri, 28
 Feb 2025 10:30:24 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:23 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-23-fvdl@google.com>
Subject: [PATCH v5 22/27] mm/cma: simplify zone intersection check
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

cma_activate_area walks all pages in the area, checking
their zone individually to see if the area resides in
more than one zone.

Make this a little more efficient by using the recently
introduced pfn_range_intersects_zones() function. Store
the NUMA node id (if any) in the cma structure to facilitate
this.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/cma.c | 13 ++++++-------
 mm/cma.h |  2 ++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 8dc46bfa3819..61ad4fd2f62d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -103,7 +103,6 @@ static void __init cma_activate_area(struct cma *cma)
 {
 	unsigned long pfn, base_pfn;
 	int allocrange, r;
-	struct zone *zone;
 	struct cma_memrange *cmr;
 
 	for (allocrange = 0; allocrange < cma->nranges; allocrange++) {
@@ -124,12 +123,8 @@ static void __init cma_activate_area(struct cma *cma)
 		 * CMA resv range to be in the same zone.
 		 */
 		WARN_ON_ONCE(!pfn_valid(base_pfn));
-		zone = page_zone(pfn_to_page(base_pfn));
-		for (pfn = base_pfn + 1; pfn < base_pfn + cmr->count; pfn++) {
-			WARN_ON_ONCE(!pfn_valid(pfn));
-			if (page_zone(pfn_to_page(pfn)) != zone)
-				goto cleanup;
-		}
+		if (pfn_range_intersects_zones(cma->nid, base_pfn, cmr->count))
+			goto cleanup;
 
 		for (pfn = base_pfn; pfn < base_pfn + cmr->count;
 		     pfn += pageblock_nr_pages)
@@ -261,6 +256,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	cma->ranges[0].base_pfn = PFN_DOWN(base);
 	cma->ranges[0].count = cma->count;
 	cma->nranges = 1;
+	cma->nid = NUMA_NO_NODE;
 
 	*res_cma = cma;
 
@@ -497,6 +493,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	}
 
 	cma->nranges = nr;
+	cma->nid = nid;
 	*res_cma = cma;
 
 out:
@@ -684,6 +681,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t base,
 	if (ret)
 		memblock_phys_free(base, size);
 
+	(*res_cma)->nid = nid;
+
 	return ret;
 }
 
diff --git a/mm/cma.h b/mm/cma.h
index 5f39dd1aac91..ff79dba5508c 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -50,6 +50,8 @@ struct cma {
 	struct cma_kobject *cma_kobj;
 #endif
 	bool reserve_pages_on_error;
+	/* NUMA node (NUMA_NO_NODE if unspecified) */
+	int nid;
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
-- 
2.48.1.711.g2feabab25a-goog


