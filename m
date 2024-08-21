Return-Path: <linux-kernel+bounces-295106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C19596E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08E01F22186
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724219ABAA;
	Wed, 21 Aug 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UxLjfJ9P"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164111898E1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228381; cv=none; b=na7lH7s95JmBKnnV4gpUDikBiV6ygF013CW7rbKRbpysqvizZQMgrp6XX9rky8Oyh32Es1wJSDSxhiHihyIkqi7Nmq7lCYxvFwvRDcftFamAwCQsYEyxkUQ0NWvpb5mSU0p20O0kO2k/NMShnPNqOKvU4pSXBoQ80zhwXck19Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228381; c=relaxed/simple;
	bh=uGjiG/CFl2j6ES0y5dOhuNObOgpK8L+F0ILwLT9qNWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwNchM8gmoaqwhWvAteL7Zr5J181MAyti3r3AkTigkuoiUy2OYZv1HqdZfPdQrB14dVRydt51ZxjMHVRVZsu99XQ6AJjOHCJyF8c6QKj4tJqKzJGLB8FUqF9YSQ/5dGW5LO1FTvyooD5NH1dO13OZdNHNZ2ObyEJky9mhMnw0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UxLjfJ9P; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso2899935a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228379; x=1724833179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arLLKSkNLaMIjiTVBc0cMKPJV4f+y4Msx8WJt/66k5c=;
        b=UxLjfJ9PUaE4i6AMxfTPrcPaHALSW3BtNK8Cafv9iUqPeBSpr0cMnh15EefXLe1M2+
         AtK1QcR2+uoJLW3jA1OrWMfs+OMZ8MjBojUfeOCExuUO39jfU1UCrLAXQjhO9wqk2KRA
         SaA08LrViOSfR+ZaTjHG+BbnezHS4JTffQGblIUl0nDkA32y78J3oOCYeu8vc8LMMcnK
         /aUT0Fsn5nJ9xj4V7wIcGiZASzt5r0s98E+TNjnqgnaLPzc7CHLxHPpasNiIfatzWOSN
         /ALWiMF5EnfuQ+h3Me7ENprdvt5GfPG7JnXzHLEWvJN58ZeBci69gFnh6ZT0O+rlVCSL
         ceTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228379; x=1724833179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arLLKSkNLaMIjiTVBc0cMKPJV4f+y4Msx8WJt/66k5c=;
        b=AwWVh75wqjBidRmv+61GrR7P/xb6LHShcrqsL0jK3aLFR7+L4wiYoY7T9knFwKXPQZ
         S+8AiI0ywhN2dwWZh1gXMdZW/Xq+Pd1an1jTKj694cWrd7GmoyUczMKNTf1cUvHDNI/a
         Vd4wuqo5AOOkjZ4v+GuBtPIilJWXExMgnRugVQigrrBpgsJDUlhVbyh3BNRruCJA1l2S
         cPJL95aaoF0+8K0Y+Va9K7ZI4gwvw9GE6MXUOfcGC0wQt/DpafxPFmeFMHWUHT6i95ee
         mbxiKIFPP+rciXcTD3uqrD6b5SDmAZpIHGiADehzE8CpJGbxhUavWIDESIb+zRS2vGju
         Lr9g==
X-Gm-Message-State: AOJu0YxsJHm7nuk22A/i3tjVkNbok0Y3a0MLeu8Uv5/9/G4OknVVDIeX
	j6ijFWN+y77WoMo3tJkFTJPeCyUypRr+qvaG6illNf2GZGaeUYoRjGqkenUuzp4=
X-Google-Smtp-Source: AGHT+IEvHWRxH/KV5glvGK0Xiv2dJ13pnLs9scNXFJwmOSFepkjBPO6rW4EjBZpYY7GPQ4yq94i7jA==
X-Received: by 2002:a05:6a21:168e:b0:1c4:d05c:a967 with SMTP id adf61e73a8af0-1cada179499mr1734402637.51.1724228379371;
        Wed, 21 Aug 2024 01:19:39 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:19:38 -0700 (PDT)
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
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 02/14] arm: adjust_pte() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:45 +0800
Message-Id: <3d151aaf876b93a97fd3f070780345a3bf572123.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_adjust_pte(), we may modify the pte entry. At this time, the write
lock of mmap_lock is not held, and the pte_same() check is not performed
after the PTL held. The corresponding pmd entry may have been modified
concurrently. Therefore, in order to ensure the stability if pmd entry,
use pte_offset_map_maywrite_nolock() to replace pte_offset_map_nolock(),
and do pmd_same() check after holding the PTL.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm/mm/fault-armv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 831793cd6ff94..5371920ec0550 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -94,6 +94,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pmd_t pmdval;
 	int ret;
 
 	pgd = pgd_offset(vma->vm_mm, address);
@@ -112,16 +113,22 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	if (pmd_none_or_clear_bad(pmd))
 		return 0;
 
+again:
 	/*
 	 * This is called while another page table is mapped, so we
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
+	pte = pte_offset_map_maywrite_nolock(vma->vm_mm, pmd, address, &pmdval, &ptl);
 	if (!pte)
 		return 0;
 
 	do_pte_lock(ptl);
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+		do_pte_unlock(ptl);
+		pte_unmap(pte);
+		goto again;
+	}
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-- 
2.20.1


