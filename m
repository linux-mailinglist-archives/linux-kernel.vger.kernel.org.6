Return-Path: <linux-kernel+bounces-255732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C36934471
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07651F2187C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8EB47F53;
	Wed, 17 Jul 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CigecfCP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F91E889
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253749; cv=none; b=d0uPX+sYRXG+zDGURyS0auLZ4W5fGxmV0bNXOnRTKc1+tB5jkQKS/jUUkQcf4m17AK60ypiJmnvOCOoYV0n3irfxFOjVDWT6f59iH83he/uMwMiHgtDiYwAvKdD1vPK1fF6WfooDqExZymXpcYOGwdQTnFpPXX6KfglaK4/4Tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253749; c=relaxed/simple;
	bh=NcfwDzo/WAY/ja+2Q9yeFepQLgCd/NmFOsGANafDbuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Gk1okmsNDc+JFSoFS5Kl8ts8gxdWuhcasJ2cpxJ+vNpVM5oxiGulD5wx2qyz2Wg5TaFYLElV4HqaX41BTsDTI5+W/5Fc3TIZ0WUShOZLIPD4CdZId5ycgGYwNRbwgznYMho19Btyf3ZWWYbf+TaYDEKub7VTKNXX/MINkCx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CigecfCP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721253747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jtsZY5Ha1GOE7eeXCKiwGrLCKWt0M5FAlFhM8vgy8I=;
	b=CigecfCPEDj3W2HyNOM6736TqH3jBqe4JxetJly7rDjInXeqet/cnsTRSQwJL/6UQlahZh
	IPFZpl04QKbR8VEVZkQ3dCrUdCiJikLWAXyjNxxLDfp+8iZm6gc4Z/vLEJzF2NvRpkCD0Q
	bYTJUj4KhXhddtQM/MSw4FymoiLJc9I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-UqfaevkeMgWW7rwZjtlixg-1; Wed, 17 Jul 2024 18:02:26 -0400
X-MC-Unique: UqfaevkeMgWW7rwZjtlixg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-448335bb53aso257561cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253745; x=1721858545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jtsZY5Ha1GOE7eeXCKiwGrLCKWt0M5FAlFhM8vgy8I=;
        b=b1xfvMNIOB5M1P//GXqEaqm/11bhu1hmXGQ4us3aj70rVCVIM/e2IOvBsocCoo7SS2
         PAvRZamrB4gBtBE6oXG8aAKRfaSbcRZHhR71N80mlXV1oHvojnmdtuqqcVZPc9J7r1bw
         VCTvjI1jY3ytTuQP6cLyFPJunls4LU7gxXZd8dWZr3MPsT9ec0blPrWLAPGZggBUyrlo
         P/F2/qmbtG56jkY/DVmkx5vWqsY6Ul94ULTPeSEuCbxzDYh1yC6fbd/LytQNLiLCRAIr
         Tbt36i6/tYGBaTeb3v+AXNI9xlMYK78yR+Z9FTQeu+hZFAtk9w/c64s75WdEoPqr5US3
         z9LQ==
X-Gm-Message-State: AOJu0YzpWDi8/SZ4dzjFH1zVx4NYMqIncSw+cTBOOAj/BcXqopW85i+V
	KUX6/FHeRr5cwUFt6gkt6alpWBHrQn+SM3+al+HPq5W3LIwH/JcRJiO2o/SuxLPAFUUhDxXf3ey
	eKIhJ7lXaH5oeXVpePCkOFnalEPR+zm3K21hrLrQ1qiT4e/LCIwRl9Gv5wug+dr3R9XfdsNAKMu
	tPQkcC4I4OfLqYFCz13mW1DC6ZmK8icxGnYnr0lndKZc8=
X-Received: by 2002:a05:622a:19a8:b0:446:5a29:c501 with SMTP id d75a77b69052e-44f864afa6cmr22369601cf.1.1721253744731;
        Wed, 17 Jul 2024 15:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUvRqkcMnpaLn941R1BXuIssxTrm35f8/3mo50id9Lq3VPmnZD9wDrl4u3hs2U9BoucnNtpA==
X-Received: by 2002:a05:622a:19a8:b0:446:5a29:c501 with SMTP id d75a77b69052e-44f864afa6cmr22369171cf.1.1721253744329;
        Wed, 17 Jul 2024 15:02:24 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83f632sm53071651cf.85.2024.07.17.15.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:02:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-s390@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH RFC 1/6] mm/treewide: Remove pgd_devmap()
Date: Wed, 17 Jul 2024 18:02:14 -0400
Message-ID: <20240717220219.3743374-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240717220219.3743374-1-peterx@redhat.com>
References: <20240717220219.3743374-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's always 0 for all archs, and there's no sign to even support p4d entry
in the near future.  Remove it until it's needed for real.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h             | 5 -----
 arch/powerpc/include/asm/book3s/64/pgtable.h | 5 -----
 arch/x86/include/asm/pgtable.h               | 5 -----
 include/linux/pgtable.h                      | 4 ----
 mm/gup.c                                     | 2 --
 5 files changed, 21 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..5d5d1b18b837 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1119,11 +1119,6 @@ static inline int pud_devmap(pud_t pud)
 {
 	return 0;
 }
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_CHECK
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 5da92ba68a45..051b1b6d729c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1431,11 +1431,6 @@ static inline int pud_devmap(pud_t pud)
 {
 	return pte_devmap(pud_pte(pud));
 }
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 701593c53f3b..0d234f48ceeb 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -311,11 +311,6 @@ static inline int pud_devmap(pud_t pud)
 	return 0;
 }
 #endif
-
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2289e9f7aa1b..0a904300ac90 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1626,10 +1626,6 @@ static inline int pud_devmap(pud_t pud)
 {
 	return 0;
 }
-static inline int pgd_devmap(pgd_t pgd)
-{
-	return 0;
-}
 #endif
 
 #if !defined(CONFIG_TRANSPARENT_HUGEPAGE) || \
diff --git a/mm/gup.c b/mm/gup.c
index 54d0dc3831fb..b023bcd38235 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3149,8 +3149,6 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	BUILD_BUG_ON(pgd_devmap(orig));
-
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
-- 
2.45.0


