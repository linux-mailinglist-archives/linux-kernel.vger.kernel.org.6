Return-Path: <linux-kernel+bounces-214200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE345908121
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32E41C21A08
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE718309D;
	Fri, 14 Jun 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFVpE8XM"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78093211
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329940; cv=none; b=f/07EsJPpm7qfjFQ51Wv+U+0rBQfJN7l5nDve5qcuBkcW8vH4B0a6mTNsozvcUAUejHoUb0njnicdNo4QDno7ug3C/iMopbpYc4ofCfLIErlTnYTiVgqFirV3XQo5SuZil1Iyu/FYHWcr2F9mzPb9+srXO5LoKPig+kuGWQKskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329940; c=relaxed/simple;
	bh=VZqa4zADlu9+pC2waDrwt0SmYu8//eJvgaKcQLCz2Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foMLm+sStf+p7UJxsfWzlPjt6GYexhfBSmMSmWr6IaTkmy7eBR9+n5OS/8lTtBbux7Xj8mpMeEgzbp2jhde+aFZZN0EWeUlPBPiSf5ZvCo2yjqkIneVvMpwYU2uSsTngIiwDnqQJgc5fIDRkz8/26knFFUe4WXa4UGG59tH+KLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFVpE8XM; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ebe019b9cdso41511739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718329938; x=1718934738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFmbQRPvNrnsz2JY0mzqRjOemINJxJOX/iTkOKnCHs0=;
        b=cFVpE8XM/73NqG8mwUEQKIkazEzcIUfXbvpkElJHrKjs2Ww8CqL9ZsO8RnKbTlB1C4
         lFyASEx5tV5ZdN93ChNu3Jdg/X/71AGkizg6RL8Z+7VA4Y0R7PXC/Ppz2FsWRorgNALG
         SRa5MliPoia4WUEVSJk+kSfWp1XvFHJ6jh4aT16/iFNbklu3ojIG0jnffA3uYGoJPcIm
         d7BcninxRk5HL7YGFcN+7tsqfNgmHCdNuSPwd4dESvx7LESgGiRezx1yTtArEhoezMeY
         xcVCON7lUv33BwAudQjyN0eAOSpCuq7WlHmya6hk28t7QxNNpI2bmINxrEnAO0UtC8sU
         NTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718329938; x=1718934738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFmbQRPvNrnsz2JY0mzqRjOemINJxJOX/iTkOKnCHs0=;
        b=YrOpuijin1A9SSZOk8cfegbZKVB+M7AgIK4DV7mW2o662X7AybH22dDtWN6CvYvBM9
         I1f8acozUpJAUlQIfyBQ3T2xJdRMhOzKRY31DSNtuu8qQYAhVnLVf846J/0B1mIzfOY+
         ROZX1k1tFfyduNYVN4TZ+OmZ83lCljBaqDeAa044tpjVoS2iij6r82Pla1mMcb1l+jXq
         MvkuDqtktErLZZIK4u3DTiR/YEXBue6xhMd2Ueu7UUCYu0COSRV1AQFlPYBkxUysLHvA
         7y6+E426PsOt7hrdiys+NEW168Xn5M4I+linjFYCCMS1MLFf1Ex+PU6ba2WwiOm1u0e5
         ksww==
X-Forwarded-Encrypted: i=1; AJvYcCU5YW903+tP3PxHjSrH/mW8yA4/VuJgK7LBP2o7t/8yUBMVh0Hv9/90GA8fipXe7obpDBCbWoMYff3NRAserrDeAEMC2qWLtpR07vfH
X-Gm-Message-State: AOJu0Yy0w5iHHHACC0swOJK9Uox225kIQjGzIn1R5TqI3N4ojyJ9l1x7
	0QBX4TY8P16yPwkmfIHumASqFognaqrGfBC3TNVQ7y70dPtwd0Pw
X-Google-Smtp-Source: AGHT+IFDhw5CyPF+647vuIacpDoCF7sesz2n+pQxSAMpRsRTA2HDFMORH760KNbesaRHRf86R06Y5w==
X-Received: by 2002:a05:6602:2d81:b0:7eb:6cbc:8856 with SMTP id ca18e2360f4ac-7ebeb49bc4bmr137386739f.2.1718329937806;
        Thu, 13 Jun 2024 18:52:17 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96d4c3sm2000912b3a.59.2024.06.13.18.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 18:52:17 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>,
	Barry Song <baohua@kernel.org>
Subject: [PATCH v8 1/3] mm/rmap: remove duplicated exit code in pagewalk loop
Date: Fri, 14 Jun 2024 09:51:36 +0800
Message-Id: <20240614015138.31461-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240614015138.31461-1-ioworker0@gmail.com>
References: <20240614015138.31461-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the labels walk_done and walk_abort as exit points to eliminate
duplicated exit code in the pagewalk loop.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/rmap.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ae250b2b4d55..2d778725e4f5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1681,9 +1681,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			/* Restore the mlock which got missed */
 			if (!folio_test_large(folio))
 				mlock_vma_folio(folio, vma);
-			page_vma_mapped_walk_done(&pvmw);
-			ret = false;
-			break;
+			goto walk_abort;
 		}
 
 		pfn = pte_pfn(ptep_get(pvmw.pte));
@@ -1721,11 +1719,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			if (!anon) {
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
-				if (!hugetlb_vma_trylock_write(vma)) {
-					page_vma_mapped_walk_done(&pvmw);
-					ret = false;
-					break;
-				}
+				if (!hugetlb_vma_trylock_write(vma))
+					goto walk_abort;
 				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
 					hugetlb_vma_unlock_write(vma);
 					flush_tlb_range(vma,
@@ -1740,8 +1735,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					 * actual page and drop map count
 					 * to zero.
 					 */
-					page_vma_mapped_walk_done(&pvmw);
-					break;
+					goto walk_done;
 				}
 				hugetlb_vma_unlock_write(vma);
 			}
@@ -1813,9 +1807,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			if (unlikely(folio_test_swapbacked(folio) !=
 					folio_test_swapcache(folio))) {
 				WARN_ON_ONCE(1);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_abort;
 			}
 
 			/* MADV_FREE page check */
@@ -1854,23 +1846,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				folio_set_swapbacked(folio);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_abort;
 			}
 
 			if (swap_duplicate(entry) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_abort;
 			}
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_abort;
 			}
 
 			/* See folio_try_share_anon_rmap(): clear PTE first. */
@@ -1878,9 +1864,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			    folio_try_share_anon_rmap_pte(folio, subpage)) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_abort;
 			}
 			if (list_empty(&mm->mmlist)) {
 				spin_lock(&mmlist_lock);
@@ -1920,6 +1904,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
+		continue;
+walk_abort:
+		ret = false;
+walk_done:
+		page_vma_mapped_walk_done(&pvmw);
+		break;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.33.1


