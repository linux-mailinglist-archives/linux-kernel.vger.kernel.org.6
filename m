Return-Path: <linux-kernel+bounces-280146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C6B94C655
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6191F252C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BF15B97B;
	Thu,  8 Aug 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="cnCtS0Zm"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105F148318
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152883; cv=none; b=t51QD0QcgkUOkmcxhbXklfdMirDCsWOcHCl2lmwVBazNYBPsDora0+h33epiPZLfLc309IBw5AtHtbxrPL4xiJIbikZNPuEx+jGKRDOk5X2K1xbmEqXFy7Pf7zE8m6jczTrB67gky/1NxKHipqGlhqxS2G8b8Qd/3EcY3Z3G/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152883; c=relaxed/simple;
	bh=RJOegQUHcv+I33+qU7btWGqlaiXtgvR83VFZU3SBof8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yy3gm1Q1fWkFE+hGXl+FfwX/kgV4LiD7aEl7BERW7TAt52p5vglcfqjUN2apzdX08dr4Sbs5CsKGwxDyNkxENQaum80NyA+XrA2dBm1hvQTOKT3bU+XTQmiaTJ8+lWymtQ1+7hZTpjekQt+8vdbAi9oEQFikyojSGJWAXCWC6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=cnCtS0Zm; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bb987d3a98so8027586d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723152880; x=1723757680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Zfyh9sb1bnT5AOZDmCrIADGqpbj2HcF73SygbadHf0=;
        b=cnCtS0ZmTiSzbgaSkNEWrOvGHnFxDvqWb1z6xsgziztfOAHoaKJHUH8X9N3Q5nLBB5
         w5eS9IFhV/llUsmPlDfq4yq/o2qTccRklbsfMOt38/B0/SCNVEfne8YwIIua4OTnpWM+
         d7XjnW/t2ncjwyugvoc8AXJ3OkJzBe/4RPNlT92htq+BgHri5nMSNlqBmf9mL7JftlOH
         nCkrM63w4qbqD5Ra9XObHc7by7wnGTU41XQVM/TvzcNriZWQksPc57+AxNaHCHpA+Gbx
         KjczxmiUa5waHNYeZTcoz+BQDQnL+44o9yDFBU2RPgK8Dgi1OrIK8K7wRGzEduzySAKV
         z/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723152880; x=1723757680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zfyh9sb1bnT5AOZDmCrIADGqpbj2HcF73SygbadHf0=;
        b=fzwqu+mDhksKorrB1J00lDCEcuNQWvDwrJtbrB8hieaUWcL9mw2Nzpgq0d9fz30nt9
         bCd4oTz+t3wFLo8lESjO64Mki1LmhsAsSxN/T3Htb3tNF/DeebSWMuppxC76e7utPDhe
         NdkFupoAqnkGXy7+Bo7hzjkGC9XpQ6+HrkgGSPIo1LYQAgR5JpA5UdNy2DYkX8fLAhU0
         UFS+r1iooTspF+4b+32KQx303UdTtb5ZRGQ1l7nu0BHBDTvPsv1HwdSI/enY+IQ3wZUq
         zg5yN2Mf4k3N7SI3kL/o8GbtSJmVIoDJh5u7uFpWTCbp79tGKv780vyEy1QI57coJocs
         idHA==
X-Forwarded-Encrypted: i=1; AJvYcCWHR0FaoUBfHgfVjsNk4GH1Bftc8dCiV3RTWPxs1e9i7qi1ZC33ycgoyNtKhWf/aI5gUu/fI27AA+q1IO+4Tz2FbOvH3Mwa/acPkI1h
X-Gm-Message-State: AOJu0YzfIoeNsRHN3WzeT+jeKY3IcYMNAOjylmFo34dKAgm8iAes1WTU
	tffPQOprI90mbjKakgnHWDkLQOJeUVFmiuWOOtVwp0V6t0acC0gYaMKTL7/zxkgxjaadcScHmC1
	q
X-Google-Smtp-Source: AGHT+IEYrhxVpzTUFHMNv2JCMahxEtnVaIB4zBU/Fd+nkSIIYgPtSTnsyB+XCR6jRJ7P++5L69WPeQ==
X-Received: by 2002:a05:6214:2b99:b0:6b7:a87b:e9b9 with SMTP id 6a1803df08f44-6bd6bda461fmr32485766d6.48.1723152880168;
        Thu, 08 Aug 2024 14:34:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c762bd1sm70205026d6.29.2024.08.08.14.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:34:39 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v4 1/3] mm: don't account memmap on failure
Date: Thu,  8 Aug 2024 21:34:34 +0000
Message-ID: <20240808213437.682006-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808213437.682006-1-pasha.tatashin@soleen.com>
References: <20240808213437.682006-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we fail to allocate the mmemmap in alloc_vmemmap_page_list(), do
not account any already-allocated pages: we're going to free all them
before we return from the function.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb_vmemmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..4f51e0596197 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 
 	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page) {
-			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
+		if (!page)
 			goto out;
-		}
 		list_add(&page->lru, list);
 	}
-
 	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
 
 	return 0;
-- 
2.46.0.76.ge559c4bf1a-goog


