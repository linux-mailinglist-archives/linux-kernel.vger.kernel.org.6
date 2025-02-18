Return-Path: <linux-kernel+bounces-520568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77661A3ABA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DA73B3F22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F611D90D9;
	Tue, 18 Feb 2025 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWeoDM+Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996201DE4E9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917361; cv=none; b=RXqIikYqAXPCH2CJNTLL/lC3D+cDFadYhz8GWA8vSNT2Mm+zWm4pBaw5wGoSd1CLu37aHKVPDfmDsoayWGekaYEE5CUZt9mz4thFLEuS5WBrvohBS6Q9MWt/rDkNqysmhYPZkPmQcLhD6cNnCRP91VpCOHbD9FJBhAq7vYioXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917361; c=relaxed/simple;
	bh=gHCBDboqgHp/mDOI6vbjXgBSoA+DagFAsYJPdvdDxPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsWde6XlFACW5KDzpadSF/m5Ge3m1XhHB31KnYFDFpLdvZuenQ8nHc7EJfa4uzSvPNBsFfGlQ01vkf7HSbZUcRDjnkqulLpDLECYTLsU84ofSAE2copJJcMDASgGg4QVAROjS31CovUABDdzJyQPurAZhrSshwXj5dTChyifOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWeoDM+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739917358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlUtITEYQJv1hpgGQ8C/UoW2nF0g3ARQ77wXP5+0OfU=;
	b=WWeoDM+Q5XyjfswFUuLPPCKRQKjBS6sBICDIC3jzpjb9vmnsVs0TddIBuvwS/8zsU4adR1
	ONLaFBmcjQPOq2yRhDZ9FT30nRBGGCSj32UKJjqplpKuszUbQaB24T/JozA7VRaOk3PRnB
	LbcIqEYSmdKEQpH1EMQuld3LxAi6HHs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-bV8OMXniNsCt5H9n6wIQ_A-1; Tue,
 18 Feb 2025 17:22:34 -0500
X-MC-Unique: bV8OMXniNsCt5H9n6wIQ_A-1
X-Mimecast-MFC-AGG-ID: bV8OMXniNsCt5H9n6wIQ_A_1739917353
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C000180087B;
	Tue, 18 Feb 2025 22:22:33 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD75E300019F;
	Tue, 18 Feb 2025 22:22:30 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	mitchell.augustin@canonical.com,
	clg@redhat.com,
	jgg@nvidia.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	david@redhat.com
Subject: [PATCH v2 5/6] mm: Provide address mask in struct follow_pfnmap_args
Date: Tue, 18 Feb 2025 15:22:05 -0700
Message-ID: <20250218222209.1382449-6-alex.williamson@redhat.com>
In-Reply-To: <20250218222209.1382449-1-alex.williamson@redhat.com>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

follow_pfnmap_start() walks the page table for a given address and
fills out the struct follow_pfnmap_args in pfnmap_args_setup().
The address mask of the page table level is already provided to this
latter function for calculating the pfn.  This address mask can also
be useful for the caller to determine the extent of the contiguous
mapping.

For example, vfio-pci now supports huge_fault for pfnmaps and is able
to insert pud and pmd mappings.  When we DMA map these pfnmaps, ex.
PCI MMIO BARs, we iterate follow_pfnmap_start() to get each pfn to test
for a contiguous pfn range.  Providing the mapping address mask allows
us to skip the extent of the mapping level.  Assuming a 1GB pud level
and 4KB page size, iterations are reduced by a factor of 256K.  In wall
clock time, mapping a 32GB PCI BAR is reduced from ~1s to <1ms.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/mm.h | 2 ++
 mm/memory.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..92b30dba7e38 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2417,11 +2417,13 @@ struct follow_pfnmap_args {
 	 * Outputs:
 	 *
 	 * @pfn: the PFN of the address
+	 * @addr_mask: address mask covering pfn
 	 * @pgprot: the pgprot_t of the mapping
 	 * @writable: whether the mapping is writable
 	 * @special: whether the mapping is a special mapping (real PFN maps)
 	 */
 	unsigned long pfn;
+	unsigned long addr_mask;
 	pgprot_t pgprot;
 	bool writable;
 	bool special;
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..8f0969f132fe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6477,6 +6477,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 	args->lock = lock;
 	args->ptep = ptep;
 	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);
+	args->addr_mask = addr_mask;
 	args->pgprot = pgprot;
 	args->writable = writable;
 	args->special = special;
-- 
2.48.1


