Return-Path: <linux-kernel+bounces-255734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D55934479
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766A61F21DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0385579F;
	Wed, 17 Jul 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok+gCgue"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0844C76
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253755; cv=none; b=jOsSQZRiQMcKaD7mQ1UXW2Ol7E0WkWjs83M83MJvyjnuFQb+SPWVVKafOOrGK5MhVBO6Lc1fQFiYFNITBQeh+xYNnxPT6GM9YIlb7wlClw+VfFhcp1+2fiG2oC8ihPH1l7P8GhdA3DEvwdEaRI+cPL1n2tGCGGdNc9+HQRgYLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253755; c=relaxed/simple;
	bh=K7ProdCJxZcSwLnZoqcS+egwgE3aFeaAcBdG7Gygzyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGezNSjzTBdTkONAlyNH9U8S64bvhkMvYCfZQVrUrBGGWAd6rbHc1AslcaDMABh5QQba0EVYGBo1ZkDoR/rfC0PWNUJ8/72yZYoKYVzHaqXlzao+l5zLfAm3CIpjCqSUSx9BpLc7xkykQD72mwrzG/JA0BMk6hS0s7rDXagLhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ok+gCgue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721253749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QImmTBB9J6ICz0B3Smrm8OMXXoPNwmhbbZRF0rUpNQ=;
	b=Ok+gCgueoeGOmdMU23B/ol8y4MLLZJgEPRrVdjR0OLfhq3BSCARYSyIlJKUzlZWzHEYyba
	PmjAEYtzoUe3d540Pw7I7Pvx6x9mSllVxYn9j3o35sDePB4yz1sp4nuFh5S+jDWFgN6LKa
	3296/AgWKFD+5+QSuVuEMWyMc6BnE/Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hHUBwzcvNFGSAa_InbhxXQ-1; Wed, 17 Jul 2024 18:02:28 -0400
X-MC-Unique: hHUBwzcvNFGSAa_InbhxXQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-448335bb53aso257741cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253747; x=1721858547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QImmTBB9J6ICz0B3Smrm8OMXXoPNwmhbbZRF0rUpNQ=;
        b=elK3y5WkQuQ2U4X2DC+vBxoCQgdoT62xEfsePZO+1X5QHpFaJL9LqBFbLQp3HwbgPJ
         X+TkRCsCVAhA8c+fRFRmhHYvMR1LPxcM3nvGhNnUAjvlOXP2oj336vraXFGkFbgkMiak
         nVtRGTZSfCC3MD6ZgTsrJrnl8hAZU6PjgQKrRyQqQfmNEf+CYoHQTGdmKT5v9Y3Pcn3S
         EnLdlKe63QmXPTNr2U2LhV/ml0ZqiYs3c5RvIu02FTA8hvEaB9FGiH94Oa9FHK5aU3bK
         Cw6RE7vZVWFp4uCRa9qeVpK5I6vXPmBtUc4DQlQFqPmA4N98w+rHU3nL/U5+FkBcajUz
         cIwQ==
X-Gm-Message-State: AOJu0YwgLy+oNZLoQ7442ebPvTda2NaOec/rewJJJ9kwcJ2MYKEk/WHs
	BnrRVi+gZAnS7kGzlnTNVMUkPjwYO5lFLr0IxBy4bwlB22R8MP+Rp7jNSdDDiQxbOLrgrRJVvTh
	SgJ/z6lo+WYWNMGjts3JBZEiewPOeavm254tv4ZkoLoBm1uqVPlGzVRQXDJEc+/nQOwE4poqSj2
	pW4kC5QnOxmVkY/icFyjMCtOgIw2nSf9o9gSwvCOEfhW0=
X-Received: by 2002:a05:622a:3cd:b0:44f:89e3:e8d3 with SMTP id d75a77b69052e-44f89e3ebf3mr16473001cf.10.1721253746989;
        Wed, 17 Jul 2024 15:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7KLWkbU1UwJKSHrhdblARNi4OMqfXeCTcT+ovTUhvRHwOTG0GQKyZtUb2OdQ3d+/fWLwEbg==
X-Received: by 2002:a05:622a:3cd:b0:44f:89e3:e8d3 with SMTP id d75a77b69052e-44f89e3ebf3mr16472521cf.10.1721253746301;
        Wed, 17 Jul 2024 15:02:26 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83f632sm53071651cf.85.2024.07.17.15.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:02:25 -0700 (PDT)
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
Subject: [PATCH RFC 2/6] mm: PGTABLE_HAS_P[MU]D_LEAVES config options
Date: Wed, 17 Jul 2024 18:02:15 -0400
Message-ID: <20240717220219.3743374-3-peterx@redhat.com>
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

Introduce two more sub-options for PGTABLE_HAS_HUGE_LEAVES:

  - PGTABLE_HAS_PMD_LEAVES: set when there can be PMD mappings
  - PGTABLE_HAS_PUD_LEAVES: set when there can be PUD mappings

It will help to identify whether the current build may only want PMD
helpers but not PUD ones, as these sub-options will also check against the
arch support over HAVE_ARCH_TRANSPARENT_HUGEPAGE[_PUD].

Note that having them depend on HAVE_ARCH_TRANSPARENT_HUGEPAGE[_PUD] is
still some intermediate step.  The best way is to have an option say
"whether arch XXX supports PMD/PUD mappings" and so on.  However let's
leave that for later as that's the easy part.  So far, we use these options
to stably detect per-arch huge mapping support.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 10 +++++++---
 mm/Kconfig              |  6 ++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 711632df7edf..37482c8445d1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -96,14 +96,18 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
 
-#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
-#define HPAGE_PMD_SHIFT PMD_SHIFT
+#ifdef CONFIG_PGTABLE_HAS_PUD_LEAVES
 #define HPAGE_PUD_SHIFT PUD_SHIFT
 #else
-#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
 #endif
 
+#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
+#define HPAGE_PMD_SHIFT PMD_SHIFT
+#else
+#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
+#endif
+
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
diff --git a/mm/Kconfig b/mm/Kconfig
index 60796402850e..2dbdc088dee8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -860,6 +860,12 @@ endif # TRANSPARENT_HUGEPAGE
 config PGTABLE_HAS_HUGE_LEAVES
 	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
 
+config PGTABLE_HAS_PMD_LEAVES
+	def_bool HAVE_ARCH_TRANSPARENT_HUGEPAGE && PGTABLE_HAS_HUGE_LEAVES
+
+config PGTABLE_HAS_PUD_LEAVES
+	def_bool HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD && PGTABLE_HAS_HUGE_LEAVES
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.45.0


