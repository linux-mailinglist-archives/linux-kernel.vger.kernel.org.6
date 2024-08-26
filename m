Return-Path: <linux-kernel+bounces-302169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A895FAC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71EE28565F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D619D098;
	Mon, 26 Aug 2024 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/IvSmSi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE419D075
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705050; cv=none; b=okp+3SLCPvaJVGVc2W6+HqGNhS2rnFPziJ5e0SnfFbK78gBgc6so0I6WLZI4yLVxXCndjr+JVvaRapd/Ic1d2uaLll4eBIRoAJEfFgDtj/ky2PjEC3dENWhiN2Zv7/yq20kWwJ2Lni/lorotn32NrCSdJNO8qFsH6yqYsWwUVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705050; c=relaxed/simple;
	bh=aAVG1dQkK4CK+bGKDFmGiwLRBBmSB50x/ZhpxKIy1+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgCUhjn/hNOXOEuzujiQvHqIemIogDXCluorzFQD0I0K5JaV5+Yg32XcB3xdj7k+5x8BbzekfnpoW70wfNnTiKQatSbv54xwey6Q5KQr43Ue8cxMXsOV4GELn/tNyPDkH0g00hul03wtFsFWK6/FLaPuDZU0k/8w3WtP4Bq6PTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/IvSmSi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p41Ko1t0SYR+aQ+NnkPoKcQjWVRbF5iAoso+I7QNClw=;
	b=U/IvSmSirmaWE7Ef8vFO/UCoqdpHgwXgcB21EQ0xYAHCKX4ww5M7QJgkYHrqhIRaZVKKDt
	oQsRiF5dePjh3ynn/KKuf9gP/RuOtqkhCP+sSewgmtLnNcouhljEO/itrzqKrSM+9bj9kx
	oM5DnUZpkoWk8wulDD2hQSsA9asi9Sk=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-IbEQQn_8Pt2o-fsa8U2Uww-1; Mon, 26 Aug 2024 16:44:06 -0400
X-MC-Unique: IbEQQn_8Pt2o-fsa8U2Uww-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-26823e7e16eso10889817fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705044; x=1725309844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p41Ko1t0SYR+aQ+NnkPoKcQjWVRbF5iAoso+I7QNClw=;
        b=Jp6ydELLv1ConluF+gkkSt8H/rPj+QxFIczg5d3ReahH8T4GdB7B5dgOO3zD0wyWL9
         IBJBR1O/PvSbTnbeWuVqrz8SW1EChL5Cw4jyWWSZs5jS0YrayAWguPCrJvbLQZYCXJUK
         0tQR/6EF+BoBwEDFUCzAdKQ77r5MO5zoG1BVJPC/MoHrOgDzWzeu+7nYrqb09k4Wi2SP
         6B8/dmOwD2kptao0hg05bfXABujbGVkpMMtqbT6qevVIHae9LHt8kH8YDw0gPvXYZ6EL
         iNGl4Oq0cWvkxMk1SqAlUsv0a7KL8DAjNDNb7gDdHR+godayoXocTPI8R2NaedlVcZet
         bs0g==
X-Gm-Message-State: AOJu0Yx2D3hvslrM/h5vNozkJ5swFAGA5liHIlhwsjf9eBt5JiXf/OCo
	hu6NORgzVVVGgXKbSkuh9plSHtCQt974In91OlXrefcB7ZH0AnbrsaIAHDf5vbud6IQK7RiFFzG
	I+B5bpKl4tFkskKD2F2jgpKKwRFTZ/NK3Q20PGZF951Zou0nWykg/f7m44fZ38vH0nSblCkXPiM
	UATH8uupe746lDPSZHRhO+msv0ukC8t5OF2D06Q6Eb+bU=
X-Received: by 2002:a05:6358:ca5:b0:1b5:ecce:b760 with SMTP id e5c5f4694b2df-1b5ecceb805mr68657855d.21.1724705044596;
        Mon, 26 Aug 2024 13:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqSprkmyPyKIDES0Mxu2D+0b60kqL8Leav+5Mf5w5kuR6qgHz2l36Zs0Y1NhYRXD/bnn90Fg==
X-Received: by 2002:a05:6358:ca5:b0:1b5:ecce:b760 with SMTP id e5c5f4694b2df-1b5ecceb805mr68653955d.21.1724705044223;
        Mon, 26 Aug 2024 13:44:04 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v2 04/19] mm: Allow THP orders for PFNMAPs
Date: Mon, 26 Aug 2024 16:43:38 -0400
Message-ID: <20240826204353.2228736-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826204353.2228736-1-peterx@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 6 +++---
 mm/huge_memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b550b5a248bb..4da102b74a8c 100644
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
index dec17d09390f..e2c314f631f3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -96,8 +96,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
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


