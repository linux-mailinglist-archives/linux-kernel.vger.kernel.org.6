Return-Path: <linux-kernel+bounces-525530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C1A3F0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09B019C76FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809520AF64;
	Fri, 21 Feb 2025 09:45:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A420551D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131109; cv=none; b=XKbPj8VAD/Q3by7k6IdEojrpHlrATSP4yurbXTskBaGsqGmMkl5XR2yfJp43upVCTQtrWW7ZgtP2MaV0omHsujXVjiKFLxIB/Emnabc5GyLhyiGfamk6oCApqqrkjGwYeGktJgVWtFjw7EsmWjLdn/AcwCXgdM2QdyOwW92Dy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131109; c=relaxed/simple;
	bh=PfXp5R5o7Je7/PbcelDsQAhWY+QXfQgKBwWvdyTHRqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQcVqf8KarppBPsAahO2KZhGQAXHivi8SEsGYyevvRXbdtiPmnS0oQjS8YVhFed8FVl2X+BRsiuezkxMBs56yBGXpV7od8c8ljMR4dq/3lt70MYcrt9m3LcSuJ2KLK+T3ZwjbHOMPFWcfd+dqfOkeRWEeJqHGVxRIr6s5lmujr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77981113E;
	Fri, 21 Feb 2025 01:45:19 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 999703F59E;
	Fri, 21 Feb 2025 01:44:58 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64/mm/hotplug: Drop redundant [pgd|p4d]_present()
Date: Fri, 21 Feb 2025 15:14:48 +0530
Message-Id: <20250221094449.1188427-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221094449.1188427-1-anshuman.khandual@arm.com>
References: <20250221094449.1188427-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[pgd|p4d]_present() are inverse to their corresponding [pgd|p4d]_none(). So
[pgd|p4d]_present() test right after corresponding [pgd|p4d]_none() inverse
test does not make sense. Hence just drop these redundant checks.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4df5bc5b1b8..66906c45c7f6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -952,7 +952,6 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 		if (p4d_none(p4d))
 			continue;
 
-		WARN_ON(!p4d_present(p4d));
 		unmap_hotplug_pud_range(p4dp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
@@ -978,7 +977,6 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 		if (pgd_none(pgd))
 			continue;
 
-		WARN_ON(!pgd_present(pgd));
 		unmap_hotplug_p4d_range(pgdp, addr, next, free_mapped, altmap);
 	} while (addr = next, addr < end);
 }
@@ -1114,7 +1112,6 @@ static void free_empty_p4d_table(pgd_t *pgdp, unsigned long addr,
 		if (p4d_none(p4d))
 			continue;
 
-		WARN_ON(!p4d_present(p4d));
 		free_empty_pud_table(p4dp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 
@@ -1153,7 +1150,6 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 		if (pgd_none(pgd))
 			continue;
 
-		WARN_ON(!pgd_present(pgd));
 		free_empty_p4d_table(pgdp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 }
-- 
2.30.2


