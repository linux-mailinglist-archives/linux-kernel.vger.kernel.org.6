Return-Path: <linux-kernel+bounces-520067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D14A3A539
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB263B3D33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6EB231820;
	Tue, 18 Feb 2025 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jb6Vqz7G"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67F22F5B2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902664; cv=none; b=avgKJoCuMXjkRIC9JdY+ila+4LCQt05OLIokl5Db07G51acRCsSRWuGAWBuWk3KXDO6NddqX9kj09uRs1UiQOsO+yKMfpKYSSf2eiJgJ1inzC6v74GLiZXM6gdgGk1MhpOyzBj5eNJkSnI8NTrZAxXO0D5neojwRJE/vbuJrtZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902664; c=relaxed/simple;
	bh=xPnZnnY3CPIFatHJh/oavQKg/qEGwCZu1izRKQ8gE+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/11mvmRXSaWNsuM8KigWm/UzksLrHSX4HQEx45eg+KyteYC/rt1VzAyj6N+AioK5ArRV5trmExL369YA3CG+XRdbqOqcQ+wbUziy2ulBlB7X+Ix0iYUeUr5mmQ03HIacYgQyuTiXqwoeexZWk3NMqErc4sjD636SM+GCg2jZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jb6Vqz7G; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so12308678a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902661; x=1740507461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGTbfuDhtOfrmTloe9TGps+4hlek0DMBo1K39iEQF0Q=;
        b=Jb6Vqz7GZSGFKNyPhptd2XQFRbxP5a4JoyIAM+Of9BvSMC6qTCgJC6SYCexQjp7Py5
         lwKOjv4hgNco/1vizuh9B0n9c6B72HfE97CfItwqcbY1Q2YGB1sszxU8EMA+Ryc/S+zh
         krJeTck6K61pCUEAiTu1Wd20sN/4k87QyC6ZLQr5P1/YgI1sAIlNGhm6+l5NaaftvKL3
         L+fZwpQrel0ymmo//4OaXdbi5mEBbVnAYNUX9nShldWKCW29U4ZjVbvu+JXzavzmmGWG
         flYRdbcg8C1a+tcNmLgzksw+VEwOCJ+aMqY5ULOufhtaDta2oDzHw9druOEeTCDkzxbL
         Zb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902661; x=1740507461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGTbfuDhtOfrmTloe9TGps+4hlek0DMBo1K39iEQF0Q=;
        b=LXmPwG00TFjkl2IO7WIL3Xfkpn9QGoFSgO23pBXGHdefbRpWEStcUVDpSiL1WL7X2d
         3ug1W1BmprISda57k/uPbNFK2CE2zU3STVSoljpQ3CNxDVQRiUMghEmYpgVfJYW1P2tU
         TaRkeRHMeUMqBm1RRfq3Pl70TCuL+PkCrdoKgkoxw5Fcu9UCQR2H4hBzOIf1Zw5/t2er
         sGVHO2AOnb7rmAIE/wGr9S6em96qOmljKBDqVwoB/7lEDGQKIvPISupshSdlooAJ5OMc
         l2x/I+Bgs+H28V8jPgkqKP0ZtzRVABkrblhAcw2JCPS8HGa6m/1ik6T806wJCILp6K2b
         tp0w==
X-Forwarded-Encrypted: i=1; AJvYcCVwOgmV+i4V6r2bo8xxNbMgyoNQHLzYTVI0e9Va2M/ULe+6t+d7cgppsAUz/ogFRW7eGMtzRHbc+UxWLHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXpmiQiOS9dmCGDmR93KJDDAWpZnmK8YpG/xMz3I4Ld4Np3Uo
	dkmhxoLKjWfzsZnm15tILTfFts6w1at24lvFd9Y4X+PSkYu47fzacRO5qmDzjrExI8QL9A==
X-Google-Smtp-Source: AGHT+IGC76au004/aFeR5ds1UoSeoi/FYjc7RFTvfNZAi/zas3b2Y6TZXHmBA5s4wW0uV/fN5KqM21qn
X-Received: from pfbf7.prod.google.com ([2002:a05:6a00:ad87:b0:730:7500:ab0c])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2443:b0:732:2923:b70f
 with SMTP id d2e1a72fcca58-7329de80bbemr370375b3a.11.1739902661113; Tue, 18
 Feb 2025 10:17:41 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:50 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-23-fvdl@google.com>
Subject: [PATCH v4 22/27] mm/cma: simplify zone intersection check
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
index c7116a5819c5..d0227af4bb71 100644
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
2.48.1.601.g30ceb7b040-goog


