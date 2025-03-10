Return-Path: <linux-kernel+bounces-554375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F4A59700
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C443F188BA53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34F22A4EE;
	Mon, 10 Mar 2025 14:04:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052911CBA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615477; cv=none; b=QXRXqKJQQF4bF9r5y1YHnbiXAe2DmlVBHEHQXPXXqPyUZwmGZ4lnD6osU+sUw3o9hOkLE3VGxZG4auXsELtW+eQhBDAcqr+QG5/0Bcl0B9KWdQoZqsk4gOfeqLyUzNLnqaBEIIkdhnt3Vz/POGVHgMtdHqjl4+0SkBhHc4PlxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615477; c=relaxed/simple;
	bh=Asv4npWWTEfAL3DnohBAL7RsGf+eA4DlAlBf8mggrHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAJHULZqeZml0nWTehHVT5ittwQTuYxhlqtETkSkigRry/rAjyGhke+KxH89PdiFPXk9KuuY8DGT5xJddKBcrBMRiHaSPsnDatUsmszyWa9tTBpsWc8lt102xNGXh3YvDZa9ps0O4yJSbG3HUro1UIflKv7n3O9PBNfDaXiRq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E22F916F2;
	Mon, 10 Mar 2025 07:04:45 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46123F673;
	Mon, 10 Mar 2025 07:04:33 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm: use ptep_get() instead of directly dereferencing pte_t*
Date: Mon, 10 Mar 2025 14:04:17 +0000
Message-ID: <20250310140418.1737409-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is best practice for all pte accesses to go via the arch helpers, to
ensure non-torn values and to allow the arch to intervene where needed
(contpte for arm64 for example). While in this case it was probably safe
to directly dereference, let's tidy it up for consistency.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 22e270f727ed..33a22c2d6b20 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -202,7 +202,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
+	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);

 	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
--
2.43.0


