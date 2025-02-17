Return-Path: <linux-kernel+bounces-517790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324ACA3859E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E041898435
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1147C22069C;
	Mon, 17 Feb 2025 14:08:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813E2253E2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801335; cv=none; b=UjpfJPcqf9xXoLNMp5r/DyP9j6XagCQn+dFTVQWE/BpkR44TzdQu7SfArzm+USYu1pfnWooZebtX12srXWVIv59B40r1bDT7K/jgopU2HER3oJW0m9wec8PdEGc4gftsvP1pCowdCLewPI+soUNPDO4MvIQDhdOj/0y7PPB/U5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801335; c=relaxed/simple;
	bh=8VKq54zpMKk4Nr1Bz/Wz65bRb+7KWdR8hYgY/ifxGqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDg7mhnDMpIC6Yz8yiT8ViL161uE0PKO4+4JWgAfqmcHJGyIudH0Z/+vvALXfSeMB3tlHWjzrte1tJTUKg9ji44sMSjWn42JrrBhOGOmUWD40F/Oppiw82YjEUoG+D8R5S9tG9cJ6D5oqYk/J6IjzTdL60K9uV6/DJJDY4Ty87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B39F6244C;
	Mon, 17 Feb 2025 06:09:12 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459AE3F6A8;
	Mon, 17 Feb 2025 06:08:51 -0800 (PST)
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
Subject: [PATCH v2 13/14] mm: Only call arch_update_kernel_mappings_[begin|end]() for kernel mappings
Date: Mon, 17 Feb 2025 14:08:05 +0000
Message-ID: <20250217140809.1702789-14-ryan.roberts@arm.com>
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

arch_update_kernel_mappings_[begin|end]() is called from
__apply_to_page_range(), which operates both on kernel and user
mappings. Previously arch_update_kernel_mappings_[begin|end]() was
called unconditionally for both user and kernel mappings.

The existing arch implementations of arch_sync_kernel_mappings() (which
is called by the default implementation of
arch_update_kernel_mappings_end()) filter on kernel address ranges so
this change is still correct for those users. But given
"kernel_mappings" is in the function name, we really shouldn't be
calling it for user mappings. This change will also make the upcoming
arm64 implementation simpler.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f80930bc19f6..4e299d254a11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3035,7 +3035,8 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 	if (WARN_ON(addr >= end))
 		return -EINVAL;
 
-	arch_update_kernel_mappings_begin(start, end);
+	if (mm == &init_mm)
+		arch_update_kernel_mappings_begin(start, end);
 
 	pgd = pgd_offset(mm, addr);
 	do {
@@ -3057,7 +3058,8 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 			break;
 	} while (pgd++, addr = next, addr != end);
 
-	arch_update_kernel_mappings_end(start, end, mask);
+	if (mm == &init_mm)
+		arch_update_kernel_mappings_end(start, end, mask);
 
 	return err;
 }
-- 
2.43.0


