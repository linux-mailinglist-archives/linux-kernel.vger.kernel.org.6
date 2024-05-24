Return-Path: <linux-kernel+bounces-188191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535158CDF05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D0F1F2220D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF063CB;
	Fri, 24 May 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC3bwDM6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029302C9A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512105; cv=none; b=G8aqta8UUqKOgdd8KgyfqDVg0ifGo4uHBnMjkS9QJ5Sy+g65BdF9/Qpo70fVTklN7rtbTZRooCjvw/Mo9bZX+GFAmuirDIKS+T3iVxZN+UOu4Od2aAlti25TcrSXFEVoBXM1CP+MgRFoi9kLAvL46qe51G853rpl39wgKMUpoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512105; c=relaxed/simple;
	bh=i/X7vfVzszREoH7LEU3tywFJJJRVwFpzHn/HKGf+APM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=joNGefFjvvzT/wC6x6rlKu2ywcJNr0CL7AbpMwRBOjP6mZK7Z5vyWLv7ICsNn3ly7V0FCFphr9n7hJIJC4rgzu6+Pd2SL0Vm9bSanWOTQtoyFLBEvEvuBnweAGD5pbb4gKp46xQdda/Iik31Ze123Yw4Sl5CqSKtrokApYXyc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC3bwDM6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f6a045d476so2757599b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716512103; x=1717116903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btdOk87mswYXidZeRThBlXVYcnXj0Y1fcw2iEYiTWQ4=;
        b=bC3bwDM6xIFalUabyQ6wMvIc6AKNIDBzy6sEO6ZAXq1JKubfaawbO1IiM+EY6GP+TC
         AOv6mk8MZnWvD7ieFz2k5NmkNZDTLLPV7cnUWOrOnZz6mzJrW48DweE43RjB39StKRVs
         jiTp22L4Q0haaUGpxu0V/MP9IGTX2StbF3Re+6nLgL7sNazEENRlv9Y782KuHyUsBWwb
         +MEiadJzK3ol+YuMGDE6Oi32ONs+TKEKAygKmxikDvcRFJBZU5D4oAhB8bmAIyqjHxwv
         PIhW3OVHkJjDNwn+v5zd+FZjjhmSbx8zG/WseA05wNvDOvOsnUGzSxzbtmJQRqEgdBLA
         Xjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716512103; x=1717116903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btdOk87mswYXidZeRThBlXVYcnXj0Y1fcw2iEYiTWQ4=;
        b=kz6vZ9Imn/KMczoOS3gKMuU8B0YmVyA5iSXck6HSKJA7ZVLgdrmudOxgQUuivjr7Xo
         Z7oKBJQpzY0iuqiR6TFTG9cxDvIgEyh0QLVM/zm/hUYQEilFYUP+2atxKghpLmCa4/UW
         hPMUsvyiUT47162uebO0AnX57Izx26L0lYUtLMiYpWm1aRyI7nonYxkVqWrnlmsmXYVI
         oJ5CGt8/sP3cQXj8VEXBU922Ru8ib1sOpJLyg2y1SWCYSYNDgxoqgQLZ3ygEb8JGg/JL
         fDXPgQ39E5xzy9m2QB15jAJTRcvqruVvgImxGmoAc03D1opxAYF3SMUyw6/WhpE0b4gM
         vebQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWyzv/i74BKod5c0edrXsqM1N5PB+qHDmFqcFKtOuRyUH9gK2Jr7qWa/eNvFezYqq3IL9u8csDCK78wT2/HDNWvzTrO4/NC5GV2rFC
X-Gm-Message-State: AOJu0Yw7LamhwxgR8F4e5tKpFNySsw+EoZMbKFIhfy4G+3gjAT78DSFb
	L2xOpiiPkUraDQZiYCfWU2YBbl61orhvUEPa+3GOemNYsw2BXbiw
X-Google-Smtp-Source: AGHT+IFvwAGrb1aoG1lN2VJQK7/vDKkqVmBwD8ukAXrSTWGhK6vhiW+LH9ZzbgawCxVlb6aETJ7N1w==
X-Received: by 2002:a05:6a20:9684:b0:1af:aeaa:6db4 with SMTP id adf61e73a8af0-1b212f19e21mr994255637.47.1716512103027;
        Thu, 23 May 2024 17:55:03 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9c9065sm1881425ad.280.2024.05.23.17.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:55:02 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Barry Song <21cnbao@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Jeff Xie <xiehuan09@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Peter Xu <peterx@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Zach O'Keefe <zokeefe@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] mm: arm64: Fix the out-of-bounds issue in contpte_clear_young_dirty_ptes
Date: Fri, 24 May 2024 12:54:44 +1200
Message-Id: <20240524005444.135417-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

We are passing a huge nr to __clear_young_dirty_ptes() right
now. While we should pass the number of pages, we are actually
passing CONT_PTE_SIZE. This is causing lots of crashes of
MADV_FREE, panic oops could vary everytime.

Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch helper")
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jeff Xie <xiehuan09@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Zach O'Keefe <zokeefe@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/mm/contpte.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 9f9486de0004..a3edced29ac1 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -376,7 +376,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
 	 * clearing access/dirty for the whole block.
 	 */
 	unsigned long start = addr;
-	unsigned long end = start + nr;
+	unsigned long end = start + nr * PAGE_SIZE;
 
 	if (pte_cont(__ptep_get(ptep + nr - 1)))
 		end = ALIGN(end, CONT_PTE_SIZE);
@@ -386,7 +386,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
 		ptep = contpte_align_down(ptep);
 	}
 
-	__clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
+	__clear_young_dirty_ptes(vma, start, ptep, (end - start) / PAGE_SIZE, flags);
 }
 EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
 
-- 
2.34.1


