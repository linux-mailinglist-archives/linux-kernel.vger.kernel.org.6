Return-Path: <linux-kernel+bounces-539162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 510B0A4A1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AF9176280
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C51F8735;
	Fri, 28 Feb 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EG1buTcf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4EE276046
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767409; cv=none; b=Pi8bnOROCn+ypXqN4cuty1QMtdX4f1Inrg4AmTyD5bMVPW9JqZMYtLuEmzv/daoJ/nk7nrrjyylX6boSbUezMK4/3Ny+YuPf09omw58ONIwj+sb3A5EHHoHFKpHHOBAfsJW+D0Jkcw4DJ6FAEPqugWxIinjrBUS5PPjh9DHPPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767409; c=relaxed/simple;
	bh=rfDCDTCZR1vjOAMrrN+kyOgyhP5uaFXoA6YPneWMxAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lK6hoXydOjcHCiWMRtnfx5J7F6UPYxcgGmUrmHF+nz0aKZWw5gizwttQuv9Ii67mAnNACYiKh20+s/qDJRghx0rpxTAJn8a4IyiiQ7gwmaSZ1YgLaVbQLb9api8/D+K4/xkuZOjLzhw0nd8OefXB2edkvPyVYsK9XfjWeQJmVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EG1buTcf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2feb019b13aso6136533a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767407; x=1741372207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbowoUPJCyiQsizxpkD6Ny3B5kmia3e97FJeeBCM/C8=;
        b=EG1buTcfCMMPbS+T/zSxeNYMHxXezbZSlnwd2W24ZG4q8eyd+h9TMoMlo8gsspTe2P
         oHsuOGsVp4PE1eMtdz+PGMBSvhtnWj83AMiVWATj70PKHo30ID8ya3FfxrkREhFExnCG
         zGjE0GIPGRMzlt/50cWAoC/p/bxYKbblBG2Sg3sg4H1jUvJ7g7lzSB72aYyZMq9dwD4t
         awtV8baGG8t1pkCi8xYPKlFFRrxVjIv2/gu45X+IoQmO6ThjxMZOptTu623QzkkM92WR
         UU5gShORSVal6KqmSuygESsw0/+zJG2iATgfIf4K98mHdVcKNA6+x1VPGCRm7cyGCJG6
         hd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767407; x=1741372207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbowoUPJCyiQsizxpkD6Ny3B5kmia3e97FJeeBCM/C8=;
        b=uhQb8OrbFmcF6adPZPX7Ej+tiHpfe7EPVQjnn7OCAORuNFYHM6liu6PpztYzoDvKIZ
         WOTLIJH5+lC12vm4X3qD1DJ4he3QlP18lDmI9VDjex5yFAEXxhsTPEhRICAdUS2dHPOc
         VI+kQgDk6Ihl13iGC58eJEXXQDvbNEiLOEKFCfjP7m6QnGvb7/oL7wxMCN13RZRzJ4+P
         fVTu2CpBQdQlkpkkXvZ2KhjlT/cboWrGvuCRVroflvtSe1t1o6VyDrEn1iZGq05aWwdH
         qKYBEU7ZnND0pUonI11b7o5sFGD33KDaJzkyPZ02ywGMk/l762NcOXToHWhiTALxY+Gj
         nUpA==
X-Forwarded-Encrypted: i=1; AJvYcCXRbbHbpXYS46DeQbwMpgYe3h4sgUGTaOZ8cY24zH/Q5KpLVsBDgtFBFPz8ZgXwQSYXgx7f/aVwZU4MasI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+B/6ehQVLKtZhthFAuOFbGHqcUbjgBDZsgRqpQxJp1V9q/ec
	hbm1wrl90mEmViXzOAv+9ieXw+X/I7biIzPMlf8ORaQmJeJd3HuP7AXRl7gpydPAJ4eW0A==
X-Google-Smtp-Source: AGHT+IGKuB3uJBVlbNU/F3YmwsBG4OICoUNsGFAqYF88KK7BiOQo3YRtYFp6xhdAPgZNqpSARz9qCLce
X-Received: from pjbsn4.prod.google.com ([2002:a17:90b:2e84:b0:2fc:13d6:b4cb])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1804:b0:2fe:8c22:48b0
 with SMTP id 98e67ed59e1d1-2febab7876amr7870153a91.15.1740767407364; Fri, 28
 Feb 2025 10:30:07 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:12 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-12-fvdl@google.com>
Subject: [PATCH v5 11/27] mm/hugetlb: set migratetype for bootmem folios
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

The pageblocks that back memblock allocated hugetlb folios might
not have the migrate type set, in the CONFIG_DEFERRED_STRUCT_PAGE_INIT
case.

memblock allocated hugetlb folios might be given to the buddy allocator
eventually (if nr_hugepages is lowered), so make sure that the migrate
type for the pageblocks contained in them is set when initializing them.
Set it to the default that memmap init also uses (MIGRATE_MOVABLE).

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1a200f89e21a..19a7a795a388 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3254,6 +3254,26 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
 
+/*
+ * memblock-allocated pageblocks might not have the migrate type set
+ * if marked with the 'noinit' flag. Set it to the default (MIGRATE_MOVABLE)
+ * here.
+ *
+ * Note that this will not write the page struct, it is ok (and necessary)
+ * to do this on vmemmap optimized folios.
+ */
+static void __init hugetlb_bootmem_init_migratetype(struct folio *folio,
+							  struct hstate *h)
+{
+	unsigned long nr_pages = pages_per_huge_page(h), i;
+
+	WARN_ON_ONCE(!pageblock_aligned(folio_pfn(folio)));
+
+	for (i = 0; i < nr_pages; i += pageblock_nr_pages)
+		set_pageblock_migratetype(folio_page(folio, i),
+					  MIGRATE_MOVABLE);
+}
+
 static void __init prep_and_add_bootmem_folios(struct hstate *h,
 					struct list_head *folio_list)
 {
@@ -3275,6 +3295,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 					HUGETLB_VMEMMAP_RESERVE_PAGES,
 					pages_per_huge_page(h));
 		}
+		hugetlb_bootmem_init_migratetype(folio, h);
 		/* Subdivide locks to achieve better parallel performance */
 		spin_lock_irqsave(&hugetlb_lock, flags);
 		__prep_account_new_huge_page(h, folio_nid(folio));
-- 
2.48.1.711.g2feabab25a-goog


