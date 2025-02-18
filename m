Return-Path: <linux-kernel+bounces-520055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A65A3A525
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E883B108E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC27C281346;
	Tue, 18 Feb 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxJBws+h"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492E280A2A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902646; cv=none; b=OLJNf9+PWKzYccvZgt634QZfA6tSa7nghfsvc47AvaNadkPZ535tbqmKVYdq2p5awItyJTyQj+ryZLC0skD5xnD90kdH9ovZ6NPhEzYltIpbA7cY12ZCJTXRVtwP2I2ACATEh85LaKkiw1u+E/B0VgfOmT4yytKl60jWJZi3OJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902646; c=relaxed/simple;
	bh=oeQhmW2D/gwAfVZB9AkQ1wNHAriVbFxcPjYqNcvqL5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g1VwbrBMpzzEGQjPdveb90ApeyruQf3sBlsCRtvZ8YNOWkwZH8cuni4juz/J61fRGt0ctzK0zTRkr3uV2Kf2aOQdm9FJYZA4QV9V7Cuox1dtlo/dmsUr8B7Ll0VWSjp/xvaWEMqs7WfTsIaI5G6c9yz9oYlqYhA0+lv8Sixu+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxJBws+h; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220c86e46ebso86385305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902644; x=1740507444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai+2PcLhfWXOAXIqdyoXE98yT4B7cK2/aFq2Flf4tfI=;
        b=oxJBws+hRoXv0vu+z/a8mopddMHCQ/S5WuMJb9/sQFIH6QWYKtJ+nwClkdEOdVOeTQ
         /N32glfP1nUiNO9aKTtTufQvkJfjDgOkUeNPLiAUSvggVevzkBTR5dRAtObGFUHACKjx
         7jUYwFMJZFmwPYtXfRwUrkOLRoeiMNdkRKrsppQMPJvmVHiu5i3iOkBotGXbHRm/G7t1
         RtCYi1oh65FflhOh7Q59NdODPIsnLggqeubogPmadOrdzo4TRq0fc9xRNC6hJdWDDo47
         v53Y2k1y8WKTUhibepVfI8KZaimYE8gu+jymR+1LaUHPLTq7fqPQLTCnRVy+aGaJmnMO
         mF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902644; x=1740507444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai+2PcLhfWXOAXIqdyoXE98yT4B7cK2/aFq2Flf4tfI=;
        b=fczXYt/PG+i7FA3nc0DmkWkxg/BYzbfHPgHUEsjjgYJzYJ6SHHuqsdU4BGCqL4TcFg
         GrL1YZo/QmxAWW6BZXnI6ST2xYzTovF8iFfNssDuL+Eimmx+e8fcyGomN7Krpejj6kqA
         p/BXfJgKzrlHtk/Y0ovSXQRTyYnsrxPaTdf4CwpZLXwWV8Ann+zG8kuj+YPBsICwHNt1
         B5bwE9wA1PJ9ntl3BKSMwYSt+taWIyOwgpVYFyZtmj8oTzXL+fDriBiVHg4mrXbyjTQX
         8HzBJEgMiQGcqvr6iM6cNgBBrutHfBToX3HgySj4w1KtcdBbvVVUzmxJ6zBXdBA+r/jR
         x7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX0bSm2wRGmTASNLiJtjFw1MWQjNnFye6OVA0nf9ONh6DchlXBmXw4QIFpOTo1fkJaayUz1zWHODhJ6+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlnq28lXNRIdcmfpBSGcmMchTqFMPqqNmb3oFNtaiDgsQrpaiI
	O8/tVpnTsc7STOVIsVpD4HtCBTp7lYI72nyg8a9p8zvx/J9Bt3ieV8vpgLf0iLH9fe9Eaw==
X-Google-Smtp-Source: AGHT+IF2lNuKdgyZ+cnrzIuVV9ax0N34a1mxx5ftlrEwON3P4oKuHyNrXFqevuyZxYmpfAFSTaHfDRgc
X-Received: from plblb8.prod.google.com ([2002:a17:902:fa48:b0:220:e952:af68])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5d0:b0:220:d601:a6dc
 with SMTP id d9443c01a7336-2210405ccbamr231723465ad.22.1739902644058; Tue, 18
 Feb 2025 10:17:24 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:39 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-12-fvdl@google.com>
Subject: [PATCH v4 11/27] mm/hugetlb: set migratetype for bootmem folios
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
2.48.1.601.g30ceb7b040-goog


