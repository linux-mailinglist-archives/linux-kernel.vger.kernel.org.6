Return-Path: <linux-kernel+bounces-196813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3238D620D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8122897FF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B211586D5;
	Fri, 31 May 2024 12:42:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41BA155C94
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159325; cv=none; b=bFJZniK40NkImmOilJclAHRVunCLPE4C3xE1no7PDNZY2eg059FcBM6QhhD97wkVwmdYj/lbY5DASfgnzcdRrp8/iJaa3yxgKmAh7eFTd9M2T75SLVeqERxn6KxedmZFIR8xySu3SemvE0G6OIBW3I5IYs9ptY9kh/bBGjW0k3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159325; c=relaxed/simple;
	bh=hZtLtDq3z1qzw0IqqgNSz0ZkCA2NrxCX/CKkC0yeM24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IA9Jvzp+mDS/x8gYJwt/md4VxmQ7MVQfnlnasp5yg9MTY2wAnWZJlzQ/d/oE1MEOrtp1Zd4O/9s/UJ+SlYlOjPMuh3fFoIiSOWzcHlaW4ZPkh6MpDNXdqRAUxm12B32pdUVc7BYCYa5XDOuXPTkkjOPngv3nJS+WylJRCCLmLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 588231424;
	Fri, 31 May 2024 05:42:27 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE60B3F792;
	Fri, 31 May 2024 05:42:00 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] mm: sparse: Consistently use _nr
Date: Fri, 31 May 2024 18:11:44 +0530
Message-Id: <20240531124144.240399-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistenly name the return variable with an _nr suffix, whenever calling
pfn_to_section_nr(), to avoid confusion with a (struct mem_section *).

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/sparse.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index de40b2c73406..731f781e91b6 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -192,13 +192,13 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 
 void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
 {
-	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
-	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
+	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
+	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
 
 	if (!nr_pages)
 		return;
 
-	for (nr = start_sec; nr <= end_sec; nr++) {
+	for (nr = start_sec_nr; nr <= end_sec_nr; nr++) {
 		struct mem_section *ms;
 		unsigned long pfns;
 
@@ -229,17 +229,17 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
 	start &= PAGE_SECTION_MASK;
 	mminit_validate_memmodel_limits(&start, &end);
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
-		unsigned long section = pfn_to_section_nr(pfn);
+		unsigned long section_nr = pfn_to_section_nr(pfn);
 		struct mem_section *ms;
 
-		sparse_index_init(section, nid);
-		set_section_nid(section, nid);
+		sparse_index_init(section_nr, nid);
+		set_section_nid(section_nr, nid);
 
-		ms = __nr_to_section(section);
+		ms = __nr_to_section(section_nr);
 		if (!ms->section_mem_map) {
 			ms->section_mem_map = sparse_encode_early_nid(nid) |
 							SECTION_IS_ONLINE;
-			__section_mark_present(ms, section);
+			__section_mark_present(ms, section_nr);
 		}
 	}
 }
-- 
2.30.2


