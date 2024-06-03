Return-Path: <linux-kernel+bounces-199267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4A8D849B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189C01F23400
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE8D12E1C2;
	Mon,  3 Jun 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbmXj7P+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0012DD90
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423688; cv=none; b=Zx+zUssdTg66ereXwu3Q5BUL1s1yp5cmg3hXZStPf1NFM04dE3p2qHEqKeMgC5vBlveaYlMa49T/erGecJ9Cs8HFlR91JOkCowaJE5aRgIe5lZm+qqNs6pSMadTwggNchA6hbGmzYZvULwH1TgfaOufadpyPxbes+BjCDBjZ/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423688; c=relaxed/simple;
	bh=vSLLTL/8LxJ1KVB88t55S1GYjPOZn8cv4psq6PcaoLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gwPSmuRM+UslgDBiLqBxrsLlxW2xYp//WkpwIXi8S7lhR+6us/e2BKOExgDxQKAEKeBi9sabB2wnwbDeABrukHP5gxf2fsWmnSePfoTzEXMhbSTxAFsoCZoYFjJcQQ9lbAvpgSdl8hl6L92qZ/hKwTjdTLZKN0stWeAPfGiNOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbmXj7P+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f63642ab8aso23498295ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717423686; x=1718028486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j58eNeNH7rsPU3MjTHYc+gexQAkNzCD+uWaIEfNn8EM=;
        b=WbmXj7P+gsckJ1ttAYU5i5G3spzpWD3a4qW6e8JfzKvgJ/ttXNUCQBU/tH472q/r1f
         aHhHJH1t0PrHBGMPCd778kXOnlMDhahU30rzBBVkWcKiqdb7TPfAjifnyRzQ63fZR3iW
         JpH69Pto/fGGmhzjeI0bY91MPgzE/IDfe87bOLZ3DbmpWDs9VP96oAhDNLvfQkzBqVdj
         5nZRB9cSJ0jZkzUnoaZKhRs/lwziXPq3sszBFwD1197+nW7LKz4AlKojxcKI9KFNtgP3
         hRVkFPF3Ke1zz38Tlr7A7zosmyQ1LAP3v+qA5ksWj9VGxq9PEzNxAkss0wy+VbuxgXB7
         gZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423686; x=1718028486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j58eNeNH7rsPU3MjTHYc+gexQAkNzCD+uWaIEfNn8EM=;
        b=u5vl1IdUQXeZlKVFgGxwylw7C3tXZbqtKTU4fZZNwnPBEFKDj+sE8saDDnIQG4So04
         a6/K94WAgniVbA8fXShQ9NZJ+Ewb/5LyrHPLan9FD7z/GeLIq7fopujnZydpQBizz1P9
         e5mTAv/s5eE90BR24S7Z2mhPdtd98Zu/jHhQZ7pgtJn9q4RSrkieAH/Vyk8CkoIxbyhl
         e64hR97twcnqplRz+UYPMUEVVgGCwoP6zdbJPsgVq9tYToJUGXIbKJ3eE3BpR4hoCZ8q
         SIWN5/6yX8XfbOY56kfF2yUd5rhr1toc2Gd86EhS2acB6T1ULwayuPYYPVw8ONas8+sh
         7d4g==
X-Forwarded-Encrypted: i=1; AJvYcCWTmLFDpO9X7S/VMkhE/TPDaok+m44ECt7Xn2dSm/Dx+wxG78LeylrpmOHoXHR6MsYRb5aFstJIHS4rz4jxscgw6Vhc9HvpI5Dq18qG
X-Gm-Message-State: AOJu0YxDMAm9YzbBEGBqVvcCXQnQ91dslKQoqMlU+NswyDk2RkrOcpYr
	vcvH8endm7AcTIa27KceZIfTiOOfzV3rqBPbIXBL2kTfClFEZpAjzGJCVuwZ
X-Google-Smtp-Source: AGHT+IHlLzn+EplsEOgPQIlc0aZVcgcXn/VkhWI9rGprxUKyJdZQeE82lsMwbmTU2WwZstwh/3UlcQ==
X-Received: by 2002:a17:902:e54a:b0:1f4:a52a:dca4 with SMTP id d9443c01a7336-1f6370eee8fmr107153315ad.69.1717423686295;
        Mon, 03 Jun 2024 07:08:06 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::3039])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f67aa290fesm20624485ad.289.2024.06.03.07.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 07:08:05 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com,
	fengwei.yin@intel.com,
	ying.huang@intel.com,
	libang.li@antgroup.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
Date: Mon,  3 Jun 2024 22:07:45 +0800
Message-Id: <20240603140745.83880-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's make folio_mlock_step() simply a wrapper around folio_pte_batch(),
which will greatly reduce the cost of ptep_get() when scanning a range of
contptes.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
v1 -> v2:
 - Remove the likely() hint (per Matthew)
 - Keep type declarations at the beginning of the function (per Matthew)
 - Make a minimum change (per Barry)
 - Pick RB from Baolin - thanks!
 - Pick AB from David - thanks!

 mm/mlock.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 30b51cdea89d..52d6e401ad67 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
 static inline unsigned int folio_mlock_step(struct folio *folio,
 		pte_t *pte, unsigned long addr, unsigned long end)
 {
-	unsigned int count, i, nr = folio_nr_pages(folio);
-	unsigned long pfn = folio_pfn(folio);
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+	unsigned int count = (end - addr) >> PAGE_SHIFT;
 	pte_t ptent = ptep_get(pte);
 
 	if (!folio_test_large(folio))
 		return 1;
 
-	count = pfn + nr - pte_pfn(ptent);
-	count = min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
-
-	for (i = 0; i < count; i++, pte++) {
-		pte_t entry = ptep_get(pte);
-
-		if (!pte_present(entry))
-			break;
-		if (pte_pfn(entry) - pfn >= nr)
-			break;
-	}
-
-	return i;
+	return folio_pte_batch(folio, addr, pte, ptent, count, fpb_flags, NULL,
+			       NULL, NULL);
 }
 
 static inline bool allow_mlock_munlock(struct folio *folio,
-- 
2.33.1


