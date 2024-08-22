Return-Path: <linux-kernel+bounces-296781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC195AF21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F232871AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D679C8;
	Thu, 22 Aug 2024 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nj8KKCHk"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133C188A06
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310910; cv=none; b=glRXcNpGcOPpQ+FdAufovJz41FonDI8Th+Xp5Qb8xBgBBZZRJaTDgh1HLTHuTI9AtNFS2GWkvLmZ0AX8plxQATtwJpUJ4qUoR7F5RCcajCeFZ/4ryf935SsEPo1cvaKUgrTtMocQyCNSvXJR9tKPhyW4qGB33iGpSPgddnbudC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310910; c=relaxed/simple;
	bh=Inuyknc0CoWbp4f/hNsXEVlWUN283GegYS4zgy+gX3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJe1mWz3pKBFybD9HHoCDYDxOiDD6JYlP7fLhUcXemugvVfM52fSrliCeZI8lpUPlq0ETzCuNlddmYyhd48/nTaHZ6xqFJNQOudX6UWqp9GkdRZLycQHZrWz1Zk/zRFG954NCq5Ed7/aYs1ooMWqJal64xQ7/Md4rppuHHu78cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nj8KKCHk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-714261089c1so332089b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310908; x=1724915708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XLeH1tU+payUby5GohREupClIvRGZdbeLsp/8eA5FY=;
        b=Nj8KKCHk/bC4TSv1CV6IhulMO1Iak0Utmn3Kve7+g3rdo6xGFFLyoAkOjZlKmwRRi6
         aPW9AkWRcigEIjpOGqE/fx7K68ZZQpM0zVJN0nLRQLtbbJd7F4XGq94S9L+x0YIPmYdc
         TXkNAVJpYxYuyAXG5XkOzOQIIFaefCJl2KGT2eZgEKqs4iVgJU/2PcBOTyfy3JL+cS3Y
         B7MF7mzfZzkG22GvIOzjgued2uU2YhDVWz7uR5wSDyOFSL7AZK8OpKLOG10PlF5/kWKA
         vRG3tOE1yoQTiPKfgJcin4FPzfnzbUGCtgXQpUO6n+2k5PetaMYSq5zEdWlerk8eMz1I
         kISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310908; x=1724915708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XLeH1tU+payUby5GohREupClIvRGZdbeLsp/8eA5FY=;
        b=pmH5YuOL8H7voZoL6JTBWQuy21a5FuZb71JpotzQfYzNww1vEb8rY2yKvrpjK+ThDS
         IpM8UANkN12VffCCUwgJDjcE4H0p1tiUhNYT68bUaBYbTArJwMP/sR0fWY6KgZf6J5eu
         QjMw+JmozdUhAC/KSOPss894Efob0puOL5FcO5uQ+9c9yHMORsvemb+J2FQibY61NE9X
         ZOZJiCcIFoBBM3UfI1G9bSXZJ6TfN238KijXc+EwQeMNneXWlhI8lsX789lepqCccFl8
         M5/udVtVzHHZ3JCaS0Sa4bfBiOOwpA06VCV8O9qxxZ66qBfQF5lYi3QWjdESrC3MEv9y
         O+vA==
X-Gm-Message-State: AOJu0YwK2UTHwhVKqtwkdl2EsVV/CMPDcVm5+ldO+g4RgnVrX8//5LyR
	Rk0bS1la3YMgIx9CGbF0QX8g1tDYpF8U+n7oyQHkxjYVahjebNc/57zerzwM2G4=
X-Google-Smtp-Source: AGHT+IGjO58kdb6JjGpOfA0UnXFn2ByeOkp/uIZzxQt7YtlV+9PVIdBNBOEj4fOrvZDCpXHiWUn49Q==
X-Received: by 2002:aa7:8244:0:b0:710:d294:a2b with SMTP id d2e1a72fcca58-7143176773amr3032765b3a.8.1724310908168;
        Thu, 22 Aug 2024 00:15:08 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:15:07 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 14/14] mm: khugepaged: retract_page_tables() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:29 +0800
Message-Id: <fa0f9e54339a6966c346ca97a83656a72580cdad.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In retract_page_tables(), we may modify the pmd entry after acquiring the
pml and ptl, so we should also check whether the pmd entry is stable.
Using pte_offset_map_rw_nolock() + pmd_same() to do it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 15d3f7f3c65f2..799412041d262 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1723,6 +1723,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool skipped_uffd = false;
+		pte_t *pte;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1758,11 +1759,25 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 					addr, addr + HPAGE_PMD_SIZE);
 		mmu_notifier_invalidate_range_start(&range);
 
+		pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pgt_pmd, &ptl);
+		if (!pte) {
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
+
 		pml = pmd_lock(mm, pmd);
-		ptl = pte_lockptr(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			pte_unmap_unlock(pte, ptl);
+			if (ptl != pml)
+				spin_unlock(pml);
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
+		pte_unmap(pte);
+
 		/*
 		 * Huge page lock is still held, so normally the page table
 		 * must remain empty; and we have already skipped anon_vma
-- 
2.20.1


