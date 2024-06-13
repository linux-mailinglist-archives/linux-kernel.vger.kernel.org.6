Return-Path: <linux-kernel+bounces-212396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEE905F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E5E1F226A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4667E1;
	Thu, 13 Jun 2024 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUSiHaRZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911E441D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237282; cv=none; b=dohwE4vYpxZ9ZRBtLyskF4k2MosgeOrrwp+6vV+hWF1yNvw0247wbOdTsKdAT+YRvZbq6qskha2tyqEVYwvwkcu8dARSvJWPg5sB3PlTVsT1YoVR2QWm11R1DFok4ZeFGya3sDajsTGPnynysXk2WvjprI6lfIZMHju2fEZATVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237282; c=relaxed/simple;
	bh=MIJYCIXg4wEjAChU7Wu9NnMe/jbwItlu1Da8lm21jhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwbSafVpw9UfFkoggE9Cn8WD9BLp4zXYpXb127UpfzF3+zi/9Kd6GUdLp6GKZATW5AkylXjtGkGCZvrPKW0w+9u94JAilsI+d0hPr2pheQi4hujYeT7rhyLO2NPTbdg7YMLt7hIfuqSQk90Oy9JllnkES8l+BeHsqtu5TZKQPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUSiHaRZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0fso3661755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718237280; x=1718842080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOir94itApCcnCYgLiAuZL5MLif6sFkW68CX2FRT/Do=;
        b=OUSiHaRZTfcv7IhCW+VnWChvh5wohWS+1WVOVT1KDlauge5Cc1yAOsugE84ZSlry7G
         tRXLae4Q40FSr/WSlFePBR8piV8MZZMFOg09l0dqu5U+Ulzib0/1FutWinjr9iTsDdAK
         y2FGlsuRMsDxIi87vQKng6i9knzlrvdPaoL6mQvNMIuuXRIKx7EFWeDf2aXFby3Q6rNw
         L5hqZ3rT3DBDaDD40hxUjBHFvcmZ9fqLWtHi1rWV3kiHvbmVrEoO6i5No2AqGOHtPFKv
         t/98QMBJw2YwFiuYGAVCvBYHjKBu4HqL2D14bJeiWY+qew/xMZbCefntZ5Dvy6tM3h5c
         l2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718237280; x=1718842080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOir94itApCcnCYgLiAuZL5MLif6sFkW68CX2FRT/Do=;
        b=n2MeUAWUUYCVcQr4k+0dD8pcRXKKBPpR57Vo+A73MHUBrtvZjHRj1o/REE/ra/wfvj
         WPG/PPBoW11vCmP/dt0rC9ryDoZW3SJa80lV67QtuNHUoZihUQ1zfLaOALhJgjrhotrP
         3YO1sDNhBtHVeNRFo7cHU/DgI4MbDDgbd1nZ4EOqiWHpU5rLdEt9kVw03AScxsFiTH4Y
         sjJFXStagPtKUf445U7loCiMxcEN92jRAAEaFOS76WFBAdTEycsY22M73NrWdLLS4f7B
         HzQ3IvRGcnWT93y91DLdr5zPiE+bzQGDuq2cM82Kx5HFLc26HpzPmkXUn83nsIgS9127
         459w==
X-Forwarded-Encrypted: i=1; AJvYcCWnjboGlLhwucZQ6Vnswiiuq989YsMxRCEkcu/pkyavhjCvY9JaI9p813/Lkpkn4YlBzHDHV8umpFcliI/qDlUeckLo8SrsTW3mPOtC
X-Gm-Message-State: AOJu0Yx01vc6OxkbzomMdpKttWqu7/5qxIj0aBDGlI9BcBYh7Q9y0dO0
	zDFy00TEJycv/85pBAzFkK7bEvJLij7sQ0IGusUE3lkDrpqNzijr
X-Google-Smtp-Source: AGHT+IF6Dwth/q4utPM0FRywSk8vwXXsQspGeBZ4bBzg0jTpx0YsRNhvhNn2CVgfUyqsr9q7gfvTsQ==
X-Received: by 2002:a17:902:db11:b0:1f7:3042:9727 with SMTP id d9443c01a7336-1f83b522f7emr36687645ad.4.1718237280269;
        Wed, 12 Jun 2024 17:08:00 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1af16sm525515ad.246.2024.06.12.17.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 17:07:59 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	yosryahmed@google.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yuzhao@google.com
Subject: [PATCH RFC 2/3] mm: do_swap_page: use folio_add_new_anon_rmap() if folio_test_anon(folio)==false
Date: Thu, 13 Jun 2024 12:07:20 +1200
Message-Id: <20240613000721.23093-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613000721.23093-1-21cnbao@gmail.com>
References: <20240613000721.23093-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

For the !folio_test_anon(folio) case, we can now invoke folio_add_new_anon_rmap()
with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This action will
suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() while initiating
the process of bringing up mTHP swapin.

 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
                 struct page *page, int nr_pages, struct vm_area_struct *vma,
                 unsigned long address, rmap_t flags, enum rmap_level level)
 {
         ...
         if (unlikely(!folio_test_anon(folio))) {
                 VM_WARN_ON_FOLIO(folio_test_large(folio) &&
                                  level != RMAP_LEVEL_PMD, folio);
         }
         ...
 }

It also enhances the code’s readability.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 2f94921091fb..9c962f62f928 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4339,6 +4339,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(folio != swapcache && swapcache)) {
 		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
+	} else if (!folio_test_anon(folio)) {
+		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
 	} else {
 		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
 					rmap_flags);
-- 
2.34.1


