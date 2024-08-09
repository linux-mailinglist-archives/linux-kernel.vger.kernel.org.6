Return-Path: <linux-kernel+bounces-281196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A4894D43A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EB01C2149C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F9199E8F;
	Fri,  9 Aug 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T494QrgN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1219939E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219768; cv=none; b=nPyNa+nTNes+9CfqVc3z0wEh90msENOLiL5N0eziizGu29yNkSGJA4uruOW+cI6Rkw0NDYSiqnuqzBa3JItcN5Ay6/ZkbXX/mNj1HRGb8fOOADwafjZrdiko1oi790J6wud6QvQppkgjqzde59WebnaNLGaEdPqOF5kH6zUdQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219768; c=relaxed/simple;
	bh=3ePjgkaqs/lSLe5ciTxCy/YgQAh2UAoTQVxwiusU8PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mntP30snWVHHO0I26eBcSpShYbbGlOn4gc2uOduVUYa5qlVQ98LfDR5ZD/sZ/zZKCtqnR9azkaEyUVzUnepylp0+ubXOuBwodnAjcP0gh6kndXFWLRav+pcoAHlQs+ne7ald+kUmfW2lRw8GGKLIxv8CFnrAzFzhlRO7vQ1DYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T494QrgN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ip3F/lMuK2on6ujO8FbOHDG+DYlKv6bK2Y5nLIm/Zzk=;
	b=T494QrgNX9xLP4oSjPuFYZLMnvD0G4s9Y60bVuFDDybJC0tc6vw4yCIpomehURCWDiGBgG
	p9MO2k+h4Clz290aq7HHtkiUNy7jWzgFxKaLxQa6oa8B0x+3iT30QIB98g4itGL+LDZc2w
	oHGJb+9zTbGwEWFo84SjC9L1Rz6Ju8E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-_qCoAsnSMT6_y3Dq-_SPNQ-1; Fri, 09 Aug 2024 12:09:24 -0400
X-MC-Unique: _qCoAsnSMT6_y3Dq-_SPNQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44ff25bbfe1so3069561cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219764; x=1723824564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip3F/lMuK2on6ujO8FbOHDG+DYlKv6bK2Y5nLIm/Zzk=;
        b=kQNDZEjbN0FzyVJDEowEModOF5alMAZSbx+o+zRR+N1KQ6ZowWMo7ZrStPIIzEigz3
         oS8aS1PTSdFP/YJKbAdZMoOJrgiU00Hpx6DXfVuK6wCtPMk6e2HOy3CgyXMTqLP8mMOe
         vb/qShozbA4/VLpxvz3oyAo0IFOhSwDF5zH/IusesYQMcRAnM5xN7Br7y7JhsiPzFQTf
         qZpcffQxSSg2eK14qu5DyalBnEfA9gMnpP1J/fPslA9cNWfTMPUOcrfKeRuEu+36ziLB
         pZyPGPwQvWjObSyYE1YF7g6rusrWNKxIqhww714geA+TALXpp4+mXu5sTnzC3rjqjngH
         ldow==
X-Forwarded-Encrypted: i=1; AJvYcCXKp1xnfiOh0IVR7gEqjvf8Fu9pHaBF1zI7/TgA0USLAiW97yYIIChntKYImLAyuIqwUr0cqT16thQcIZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNfYr9g5txqQNf0RgrICZ3u7heXvuDKjRj4totqDD30ZDZL7J
	/79Pq4yIO6srU0WVwjI7evM+aK5m19i29mB0UG95YQFXNuN4sRT1kJHIS3p8ceEnUW7Rto1Dw8M
	Qhtef1lT7HK2evhIByAXWkzlLJ+ylt8/mZy6E9H2SQRZe9sW3glrL0w4PFtC67w==
X-Received: by 2002:a05:622a:1b8e:b0:447:e636:9ea9 with SMTP id d75a77b69052e-4531251c724mr14423271cf.3.1723219764201;
        Fri, 09 Aug 2024 09:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHps50LqsfKl8qXevdYdePG8tewmjaKqGlRovYXRf84yciplQ1RIErbjQjT+BAlToj6EpXuWQ==
X-Received: by 2002:a05:622a:1b8e:b0:447:e636:9ea9 with SMTP id d75a77b69052e-4531251c724mr14422831cf.3.1723219763777;
        Fri, 09 Aug 2024 09:09:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	peterx@redhat.com,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH 04/19] mm: Allow THP orders for PFNMAPs
Date: Fri,  9 Aug 2024 12:08:54 -0400
Message-ID: <20240809160909.1023470-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables PFNMAPs to be mapped at either pmd/pud layers.  Generalize the
dax case into vma_is_special_huge() so as to cover both.  Meanwhile, rename
the macro to THP_ORDERS_ALL_SPECIAL.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 6 +++---
 mm/huge_memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2121060232ce..984cbc960d8b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -76,9 +76,9 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 /*
  * Mask of all large folio orders supported for file THP. Folios in a DAX
  * file is never split and the MAX_PAGECACHE_ORDER limit does not apply to
- * it.
+ * it.  Same to PFNMAPs where there's neither page* nor pagecache.
  */
-#define THP_ORDERS_ALL_FILE_DAX		\
+#define THP_ORDERS_ALL_SPECIAL		\
 	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
 #define THP_ORDERS_ALL_FILE_DEFAULT	\
 	((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
@@ -87,7 +87,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
  * Mask of all large folio orders supported for THP.
  */
 #define THP_ORDERS_ALL	\
-	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
+	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FILE_DEFAULT)
 
 #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
 #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e95b3a468aee..6568586b21ab 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -95,8 +95,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	/* Check the intersection of requested and supported orders. */
 	if (vma_is_anonymous(vma))
 		supported_orders = THP_ORDERS_ALL_ANON;
-	else if (vma_is_dax(vma))
-		supported_orders = THP_ORDERS_ALL_FILE_DAX;
+	else if (vma_is_special_huge(vma))
+		supported_orders = THP_ORDERS_ALL_SPECIAL;
 	else
 		supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
 
-- 
2.45.0


