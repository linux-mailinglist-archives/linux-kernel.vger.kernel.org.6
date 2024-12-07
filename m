Return-Path: <linux-kernel+bounces-435884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6CD9E7E3D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0198918874F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1E70807;
	Sat,  7 Dec 2024 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAVCq8rT"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE484A2F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733546664; cv=none; b=YcunGGjll0+6kbPWIET6sMjRF1Ynsv1NYDzQtdRJAiDDRZOHdEc5wkpTtr+2LXZJBwTEzwrQfT02hyv7Xxz38gQnQ6UY9PSXchCPTF7vAiY7GqqyvbwqTHMPMZL7D3gUursQn5fJdWkDtTbX6lDAFfJUINYDcx2mlcki10QsRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733546664; c=relaxed/simple;
	bh=wlYspArEZ9y8N+V11YiJ99yceBRNs/k4eHPCDaFVBZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDoFznbrDXNxoZn9a03tdARt0CZBvPrAXO0iN4rZA/UCwRXRpigB+FXvMfbxaZaQ9PCfcHQJOR1JRkdF0SO5ZFNyKpWV4Z7vv+I8EV4PH6unY/Nt7D+5AxQGJwm82sVi+jXToq2yonf6XomkvRekhXEXEtA69E7X4vUB5jl7U8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAVCq8rT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725c0dd1fbcso1219404b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 20:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733546662; x=1734151462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFG4/DDc1t3oTiANV495l58l0n5DpODqKmw31EcAeL0=;
        b=eAVCq8rTcLPZuyRdu3lmELFeCs4JzCvz/zKtv0TUwIEqQpj0ZMDo8aI0E0kWvkUKe9
         lokWo+ExBlwlkr1Ct4uO3owVBF3EXlte5Ms/Rca+/Aq/pvWHutZToli21iA86xuQELd7
         KKhcyW1lpi6vp3Yn8rozKZyjjwnZgikQS+KjkIKdY1k0jBVEleOvy2ZxulzGfELsF8Fj
         /G8/XUjt1DaSTr+5+4tOSWr+lyr5WdzXnZlAXHcZ75YyHcr2o8tfwFNX4vVvfBzFjvIZ
         RKYkYPAizY6hQfAzClyNaX7VCDoiCvLzHlRNUYbJPHkrg8L3OL3bE6GtIJbgkxqXcpcs
         xGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733546662; x=1734151462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFG4/DDc1t3oTiANV495l58l0n5DpODqKmw31EcAeL0=;
        b=JqGGPpyr54+4e8bQjZB0InIr06UZYPc37gqahy8K/y/Wj0K4gw/ms1XZRkSr6euEeD
         PUKscBdqmunNFL7m7fOZvwL4FcH8nstiCcABOgRL7UxkwoNhA8Jz44yIQTnXzrrXydWL
         i5S3Y7KwF/IGBwlz2xBWOv0PN55ZeIPUygyKOQNn7HjkcvREf6lu7oVZ4tkQsR1Gogjf
         Ehj2v8TCbjKomyUIgz9iAW5mdnpxRVqukkUicQJQ1SgVo6UOw/5PiR1vqTiOivAm/Ki8
         IhC+c8lTi9Ov8zwlCqClLkiXSHbqtTgO/AOV6pMUH/O9J4gzAPeHlbbKo47er6DboqPs
         QfKg==
X-Forwarded-Encrypted: i=1; AJvYcCVOTzFpNBY6lV8/6sX1ubFtOP3GpJNPRobpeZqEMcTFMQ6aPqLsufdJN/Z9QsI+V53nAVK+XzlQHd01kiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRFv1auKClaeOH6zfqPAwxYge+X2dbsZeUngLWzYDAG+mpNuZ
	GiFJ9hJvL8UT3O7ZrPrnYHnk0Xg8bUkXXiMORWyYnlnrT14rWwBhcQsMZh99FQ==
X-Gm-Gg: ASbGnctDBoeDfUtZKnKol1jvK8i3iEbTBuNRKZDNqJX+XMEhHW3V45py1qrv/Ops8u1
	3wVFXFINjSHwZTnmk51OFY1GHiS0ExBK2A8INuqZwE03F9vOhcznzt6xX07UQMFJF97K72ax1XU
	FSTI9BN8eGjOWuRdEr/FPS66IAHmv2sau6seLrg0gUV0gxUhU1AxfzCVHlUDHRMXYmzcwCYQkN5
	kYqh8Ya0K2/G+WlX9heO4Mt8iM9Z9abwYRftVKYHpnNPt1dkBub7RMhMxfqVUd3tbEcxpoYLjS/
	zKIY
X-Google-Smtp-Source: AGHT+IH2kG310mYk49qwnHG1UmbpOXayl+lCDmcKkjax9K+JDIj0BMgxcTsXChwYTuPKX7SaehsPsg==
X-Received: by 2002:a17:902:d48c:b0:215:7b06:90db with SMTP id d9443c01a7336-21614d687a6mr65578985ad.13.1733546662069;
        Fri, 06 Dec 2024 20:44:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2e28:6:c5e3:4c27:49a5:9726])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216268c36c8sm8053835ad.253.2024.12.06.20.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 20:44:21 -0800 (PST)
Date: Fri, 6 Dec 2024 21:44:15 -0700
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH mm-unstable v2 6/6] mm/mglru: rework workingset protection
Message-ID: <Z1PSn79GPcCxeI_g@google.com>
References: <20241206003126.1338283-1-yuzhao@google.com>
 <20241206003126.1338283-7-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206003126.1338283-7-yuzhao@google.com>

On Thu, Dec 05, 2024 at 05:31:26PM -0700, Yu Zhao wrote:
> With the aging feedback no longer considering the distribution of
> folios in each generation, rework workingset protection to better
> distribute folios across MAX_NR_GENS. This is achieved by reusing
> PG_workingset and PG_referenced/LRU_REFS_FLAGS in a slightly different
> way.
> 
> For folios accessed multiple times through file descriptors, make
> lru_gen_inc_refs() set additional bits of LRU_REFS_WIDTH in
> folio->flags after PG_referenced, then PG_workingset after
> LRU_REFS_WIDTH. After all its bits are set, i.e.,
> LRU_REFS_FLAGS|BIT(PG_workingset), a folio is lazily promoted into the
> second oldest generation in the eviction path. And when
> folio_inc_gen() does that, it clears LRU_REFS_FLAGS so that
> lru_gen_inc_refs() can start over. For this case, LRU_REFS_MASK is
> only valid when PG_referenced is set.
> 
> For folios accessed multiple times through page tables,
> folio_update_gen() from a page table walk or lru_gen_set_refs() from a
> rmap walk sets PG_referenced after the accessed bit is cleared for the
> first time. Thereafter, those two paths set PG_workingset and promote
> folios to the youngest generation. Like folio_inc_gen(), when
> folio_update_gen() does that, it also clears PG_referenced. For this
> case, LRU_REFS_MASK is not used.
> 
> For both of the cases, after PG_workingset is set on a folio, it
> remains until this folio is either reclaimed, or "deactivated" by
> lru_gen_clear_refs(). It can be set again if lru_gen_test_recent()
> returns true upon a refault.
> 
> When adding folios to the LRU lists, lru_gen_distance() distributes
> them as follows:
> +---------------------------------+---------------------------------+
> |    Accessed thru page tables    | Accessed thru file descriptors  |
> +---------------------------------+---------------------------------+
> | PG_active (set while isolated)  |                                 |
> +----------------+----------------+----------------+----------------+
> | PG_workingset  | PG_referenced  | PG_workingset  | LRU_REFS_FLAGS |
> +---------------------------------+---------------------------------+
> |<--------- MIN_NR_GENS --------->|                                 |
> |<-------------------------- MAX_NR_GENS -------------------------->|
> 
> After this patch, some typical client and server workloads showed
> improvements under heavy memory pressure. For example, Python TPC-C,
> which was used to benchmark a different approach [1] to better detect
> refault distances, showed a significant decrease in total refaults:
>                             Before      After      Change
>   Time (seconds)            10801       10801      0%
>   Executed (transactions)   41472       43663      +5%
>   workingset_nodes          109070      120244     +10%
>   workingset_refault_anon   5019627     7281831    +45%
>   workingset_refault_file   1294678786  554855564  -57%
>   workingset_refault_total  1299698413  562137395  -57%
> 
> [1] https://lore.kernel.org/20230920190244.16839-1-ryncsn@gmail.com/
> 
> Reported-by: Kairui Song <kasong@tencent.com>
> Closes: https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=2TQo7T4Gr-QYLujn4RA@mail.gmail.com/
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  include/linux/mm_inline.h |  94 +++++++++++++------------
>  include/linux/mmzone.h    |  82 +++++++++++++---------
>  mm/swap.c                 |  23 +++---
>  mm/vmscan.c               | 142 +++++++++++++++++++++++---------------
>  mm/workingset.c           |  29 ++++----
>  5 files changed, 209 insertions(+), 161 deletions(-)

Some outlier results from LULESH (Livermore Unstructured Lagrangian
Explicit Shock Hydrodynamics) [1] caught my eye. The following fix
made the benchmark a lot happier (128GB DRAM + Optane swap):
                            Before    After    Change
  Average (z/s)             6894      7574     +10%
  Deviation (10 samples)    12.96%    1.76%    -86%

[1] https://asc.llnl.gov/codes/proxy-apps/lulesh

Andrew, can you please fold it in? Thanks!

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 90bbc2b3be8b..5e03a61c894f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -916,8 +916,7 @@ static enum folio_references folio_check_references(struct folio *folio,
 		if (!referenced_ptes)
 			return FOLIOREF_RECLAIM;
 
-		lru_gen_set_refs(folio);
-		return FOLIOREF_ACTIVATE;
+		return lru_gen_set_refs(folio) ? FOLIOREF_ACTIVATE : FOLIOREF_KEEP;
 	}
 
 	referenced_folio = folio_test_clear_referenced(folio);
@@ -4173,11 +4172,7 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 			old_gen = folio_update_gen(folio, new_gen);
 			if (old_gen >= 0 && old_gen != new_gen)
 				update_batch_size(walk, folio, old_gen, new_gen);
-
-			continue;
-		}
-
-		if (lru_gen_set_refs(folio)) {
+		} else if (lru_gen_set_refs(folio)) {
 			old_gen = folio_lru_gen(folio);
 			if (old_gen >= 0 && old_gen != new_gen)
 				folio_activate(folio);

