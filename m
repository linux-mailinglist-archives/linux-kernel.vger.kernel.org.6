Return-Path: <linux-kernel+bounces-517785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FCBA3859F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FD7175BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584122333C;
	Mon, 17 Feb 2025 14:08:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1BE223704
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801322; cv=none; b=n16IUnjWyOWyGV3HQaKFxpRZffFxc/Vmt9P7sACQHVlogi2nncpPFAZTnGCzm3k2f8iUJ4Xu0K8Xdk+XC7wUsZAXgHlY+N2lpMZ19Kum277+eaIGN5jEdd13VpIOyLQ+9aW2RopGTMgA1R6mji9OzvFVZbMK1xTlHIkZmtRL/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801322; c=relaxed/simple;
	bh=a3hGh6kU7tv8vHXQe8SD0l6uUPbsq+Y8wNEnCpqpNWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnLWq50nysssR1MAvaiTa3MdpaG5VgSzfavKDhsWjzOEj6oev88HLgCgNIFA4RLaFgnPyOXyFyhmcO8rNzMR2FLdOpQC4hh0/Qc43pfUf8G10RWPYaGDpAwMsca7MdmzX2XtOqNnQcdOykuCDnapzwfGRht0Hrez6fatrifHFuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD4D61E5E;
	Mon, 17 Feb 2025 06:08:59 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FF853F6A8;
	Mon, 17 Feb 2025 06:08:38 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] mm/vmalloc: Warn on improper use of vunmap_range()
Date: Mon, 17 Feb 2025 14:08:00 +0000
Message-ID: <20250217140809.1702789-9-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140809.1702789-1-ryan.roberts@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to vmalloc_huge() may cause memory blocks to be mapped at pmd or
pud level. But it is possible to subsequently call vunmap_range() on a
sub-range of the mapped memory, which partially overlaps a pmd or pud.
In this case, vmalloc unmaps the entire pmd or pud so that the
no-overlapping portion is also unmapped. Clearly that would have a bad
outcome, but it's not something that any callers do today as far as I
can tell. So I guess it's just expected that callers will not do this.

However, it would be useful to know if this happened in future; let's
add a warning to cover the eventuality.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61981ee1c9d2..a7e34e6936d2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -374,8 +374,10 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		if (cleared || pmd_bad(*pmd))
 			*mask |= PGTBL_PMD_MODIFIED;
 
-		if (cleared)
+		if (cleared) {
+			WARN_ON(next - addr < PMD_SIZE);
 			continue;
+		}
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		vunmap_pte_range(pmd, addr, next, mask);
@@ -399,8 +401,10 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (cleared || pud_bad(*pud))
 			*mask |= PGTBL_PUD_MODIFIED;
 
-		if (cleared)
+		if (cleared) {
+			WARN_ON(next - addr < PUD_SIZE);
 			continue;
+		}
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		vunmap_pmd_range(pud, addr, next, mask);
-- 
2.43.0


