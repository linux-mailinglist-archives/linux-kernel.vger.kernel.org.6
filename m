Return-Path: <linux-kernel+bounces-225617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB99132F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB031C21129
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2C14B948;
	Sat, 22 Jun 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5/gZdx9"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466F4A20
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719050495; cv=none; b=LFGk3RpJzUcFj8K3ZnW96sguf0iC3LY4FwnfbRYQEOJYNFECkKtulmngI3iv4ga121e0BQXdxmIRyJpxzkEW7DZP7wEg/HxIV25tNk2LmqXXn2yCx52KJ19mpFZwv9CcAVTeq0ppb393n5apcAdY6vb1GvaIlfLCkNS2Z3z7dbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719050495; c=relaxed/simple;
	bh=SngcoCWwa17YMlF9y7iUlKcCdVe2vTc0YyJJ4ug3gkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMqOKc9ta7CEjzumycV1CEC9+pAUSs2ti1HJPBkWQhOFAPY8H8Ul56xijMHvOdqDK9Y0CbuWVClEIUbLGv1hc1a9eqSRn2dZPMCfWTBG+ZlueJcvN75mp0I5tfsMXzTYHI1buzbQolqYhy4Ts/wmw9Cz455/LF6QJr7Onby2a+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5/gZdx9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066a4a611dso168312b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719050494; x=1719655294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqMTUZuiEpOFDB1baLxpBZo9bkFoxkrSKRZCo1yWC2s=;
        b=g5/gZdx9SN6qhecGh4WiOYKeRC9jRyCq7RsICtjOs2DGINeASaqfE3AVbidIFjye3x
         JFthZbUkxt5nsT1DgKrpgXlEfn5N8pGicgRGWxru+qQbQtYpS1ftwnk8cn+XVELOTLw/
         05MmvqRopj/dbtu2s6YRmauFrWRe5Lamn84lg+rIlOlmw1RjiqSGw3x0gS75pCPdkTla
         dGIWv0hTyRvAR6xykZeAC5nuyYEQFPhqdYGKICYWxSQkJd2G4Ds2vCBOytrtlGgrw5T2
         SKBjVEnSNGOozjbWxDx4xecEQ2I7Z5D6wX9SnClaDNqBsqr7hdhjEse7iu196Ug/2bxY
         E+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719050494; x=1719655294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqMTUZuiEpOFDB1baLxpBZo9bkFoxkrSKRZCo1yWC2s=;
        b=BTcuZxCFla84+kygcPpuqtxWbZQxYy+/ufcLHzbIlFs04vkYQ7g2CEvc3tZ3zGVeK2
         NH0JpQG2fx4Uys6pjO6IsB1gdF2hom6qKBvkzpy67bbdyIg8YnMQuypTXNXlowCBU+2U
         gwqgM53xbjDD4yPEq2vTjl+a3n2LLbJvFNr2EnB6VpqNeRGvcuZY6UZzPDdi03a5c7O7
         2lnnD5dy6MS2uJsxTHKyFZYa67jagoEZM6tEPoTeZNHs0rRMifgNgHAcueXHacMbhMlA
         ug4Vc48wXJIx9YqhKQlkSkefLYYnCQFgJ5C9d6BSYdhhMfYBGKwbJVnqpwmVPZzHzBU5
         IZCw==
X-Forwarded-Encrypted: i=1; AJvYcCX9xFrflQ7b8QwS2a7iHQGTSWlVouZzBJdrARexwLEqpJY01ggVCVQRHgQl1obgL5T4gYo/nbm26FKDbFjYLlWPb9XqdUkBOSk7sKXp
X-Gm-Message-State: AOJu0YwRQmLy8OcKBYvQV5TvUoJI4T6vqU72WaGwk50H9cvWbUYuzdux
	RsACsRvxLlrSvyJlKPR3g/vP6hqjwJKte8QKDSa0FUMRUFHboI7q
X-Google-Smtp-Source: AGHT+IG5+gqUJ0pcMtEkBAAeVC8MQVAyDbxFzNmRYBsf3upGPEwH2mux8H1fv5kZLq2BlXcL6pgK2Q==
X-Received: by 2002:a05:6a00:1701:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-7066c3833b6mr516508b3a.8.1719050493620;
        Sat, 22 Jun 2024 03:01:33 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:6::3057])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065129b9edsm2838593b3a.148.2024.06.22.03.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:01:33 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org
Cc: 21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	fengwei.yin@intel.com,
	ioworker0@gmail.com,
	libang.li@antgroup.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maskray@google.com,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	sj@kernel.org,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiehuan09@gmail.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: Re: [PATCH v8 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Sat, 22 Jun 2024 18:00:57 +0800
Message-Id: <20240622100057.3352-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <e7c0aff1-b690-4926-9a34-4e32c9f3faaa@redhat.com>
References: <e7c0aff1-b690-4926-9a34-4e32c9f3faaa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

I made some minor changes suggested by David[1]. Could you please fold the
following changes into this patch?

[1] https://lore.kernel.org/linux-mm/e7c0aff1-b690-4926-9a34-4e32c9f3faaa@redhat.com/

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4b2817bb2c7d..0cb52ae29259 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2693,21 +2693,11 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 					    unsigned long addr, pmd_t *pmdp,
 					    struct folio *folio)
 {
-	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
-	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
-
 	struct mm_struct *mm = vma->vm_mm;
 	int ref_count, map_count;
 	pmd_t orig_pmd = *pmdp;
 	struct page *page;
 
-	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
-		return false;
-
-	page = pmd_page(orig_pmd);
-	if (unlikely(page_folio(page) != folio))
-		return false;
-
 	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
 		return false;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index df1a43295c85..b358501fb7e8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1678,9 +1678,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				/*
-				 * We temporarily have to drop the PTL and start
-				 * once again from that now-PTE-mapped page
-				 * table.
+				 * We temporarily have to drop the PTL and
+				 * restart so we can process the PTE-mapped THP.
 				 */
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, false, folio);
-- 

Thanks,
Lance

