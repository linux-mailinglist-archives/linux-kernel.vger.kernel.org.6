Return-Path: <linux-kernel+bounces-177279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B718C3C53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5878F280E32
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D8146D56;
	Mon, 13 May 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM7YNwBA"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD5146D50
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586476; cv=none; b=h6uXJaX6GM7S4AXmwC/n5xnhlrpIIdSBtPDwJ2P/RXCyadrC5JcPueR5tD51L7TSgr6o+e1Gu8YtebIPiDXAApMRbh+54E4W/142p2H2/15WYuu+iyQ98nmvydl9I8GPCKKKO7vWFT7pzo8ED6HbmcHrXaySmoF5qvUzhOuY3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586476; c=relaxed/simple;
	bh=w+SWe0CjxDy05oILGpGi77r8YDWsD/ip9mkRGbM1fGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2xcqOaQFnoaZN9z6Yu74L+O5GwsiRi+toScljHcdyj0qgDzHAj/8FseWmKFWVoF+eH4geW6eV/x2HmuLUZPFSAXS2XZo622xCTW7fvxwR54kTQMzfN0xS5k6LRZpF9ijxM/AVGLZRh+lVepkCx8uiKt8UnfoMn/hXWEsCshduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM7YNwBA; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c99a70250cso1624269b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715586474; x=1716191274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRqSGx+LZLYZmMM1dtm6DE8QjEfHEddJV2Al3d0Qb2M=;
        b=nM7YNwBAIoDmMPBJd2OLizA6GozkpW64DM7w3wVSDZJ3EJtLzQ8oatR01ql/oV+caw
         bujH7p1Odelr0BzM7sUYiTj2V+yNRZ0k9tl2o2NRkZFERDLV4K22Co5kUQt5lUyEeFCg
         h5mwS/AITmffUNipK+TpHC+re6AqbrnkuFFuaMbLHzx44sSb2W8fJbHfQ4y+7Fpk/r/v
         jk3Ypx3xzV/UXZHK2BvpC7cfcmLlCkshYkH88h86VqpoRNkRv+oh6NJy56EWjx5A2+3R
         9xBCznMqnB9IJ2ebb0lKHBCZHgkY5cuylFZDe5Q0E/sh07R/c9erfkbbVKFYzyBIx6oP
         gq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586474; x=1716191274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRqSGx+LZLYZmMM1dtm6DE8QjEfHEddJV2Al3d0Qb2M=;
        b=Hef3Njh3Phj/cXzPuvdPnXpQ4GZgScmCGMekryxEI9GxZSdPZkH39vFYHa/FdfkSoD
         pCX6kTD2gHj+qnNEUfSHn5XI7SahRdIN19zS7l0My2lC2oJwDun/8zhg6zXMY6zvPlZp
         3H/xfSTv6DSfmw0tl5rdQ2Lr1NK8giqspM7M7YkIOWGoD0UmHYtewKj2KnJhKINepdUJ
         WGsGQYaWw/uE3piaVa2dyBL/K088yPwDROh8K4KM+ep8ytPYE9pDIiRLEibDmgC4UGD5
         K084pAWzWwcrkN7gkHf08EZ/2dvr59UFbaaAiB4On2BklwNCXFxyoC1BnURPFsYc7vLA
         NfqA==
X-Forwarded-Encrypted: i=1; AJvYcCWqBEwK/mVNTroW2+0KiMrBLZXuSHzf4QDjlOBxwgxOap4yLEEmcxmuNgDMvz9EgHQE7yyMm+JUQddU7ZnIDcmuCoWKLh3NyUOgkBOt
X-Gm-Message-State: AOJu0Yxh9mmlBg6ObgvqkRaFEptjSYU1qehD0tz22heDTOKmYXWyFZ0t
	MgUKXYVmRUBIkK8Eb5KsYP8uh/5mWJRi9s7UcdnySDkt3b+bXRy0
X-Google-Smtp-Source: AGHT+IGY+Awn4udMPhFiQz9yDb+p0ggUx+6DZOemAXrpevayvvkrNDj+S4e4smtqNCGCuoBLk6sOgQ==
X-Received: by 2002:a05:6808:3099:b0:3c7:5146:c4e5 with SMTP id 5614622812f47-3c9970b0ff3mr11673420b6e.41.1715586474027;
        Mon, 13 May 2024 00:47:54 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66621sm7008967b3a.13.2024.05.13.00.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:47:53 -0700 (PDT)
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
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH RESEND v5 1/4] mm/rmap: remove duplicated exit code in pagewalk loop
Date: Mon, 13 May 2024 15:47:09 +0800
Message-Id: <20240513074712.7608-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240513074712.7608-1-ioworker0@gmail.com>
References: <20240513074712.7608-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the labels walk_done and walk_done_err as exit points to
eliminate duplicated exit code in the pagewalk loop.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/rmap.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..ddffa30c79fb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1679,9 +1679,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			/* Restore the mlock which got missed */
 			if (!folio_test_large(folio))
 				mlock_vma_folio(folio, vma);
-			page_vma_mapped_walk_done(&pvmw);
-			ret = false;
-			break;
+			goto walk_done_err;
 		}
 
 		pfn = pte_pfn(ptep_get(pvmw.pte));
@@ -1719,11 +1717,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			if (!anon) {
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
-				if (!hugetlb_vma_trylock_write(vma)) {
-					page_vma_mapped_walk_done(&pvmw);
-					ret = false;
-					break;
-				}
+				if (!hugetlb_vma_trylock_write(vma))
+					goto walk_done_err;
 				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
 					hugetlb_vma_unlock_write(vma);
 					flush_tlb_range(vma,
@@ -1738,8 +1733,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					 * actual page and drop map count
 					 * to zero.
 					 */
-					page_vma_mapped_walk_done(&pvmw);
-					break;
+					goto walk_done;
 				}
 				hugetlb_vma_unlock_write(vma);
 			}
@@ -1811,9 +1805,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			if (unlikely(folio_test_swapbacked(folio) !=
 					folio_test_swapcache(folio))) {
 				WARN_ON_ONCE(1);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			/* MADV_FREE page check */
@@ -1852,23 +1844,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				folio_set_swapbacked(folio);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			if (swap_duplicate(entry) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			/* See folio_try_share_anon_rmap(): clear PTE first. */
@@ -1876,9 +1862,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			    folio_try_share_anon_rmap_pte(folio, subpage)) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 			if (list_empty(&mm->mmlist)) {
 				spin_lock(&mmlist_lock);
@@ -1918,6 +1902,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
+		continue;
+walk_done_err:
+		ret = false;
+walk_done:
+		page_vma_mapped_walk_done(&pvmw);
+		break;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.33.1


