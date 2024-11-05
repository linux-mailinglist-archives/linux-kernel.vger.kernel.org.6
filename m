Return-Path: <linux-kernel+bounces-395882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5439BC467
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2891F1C212C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF3B1925A0;
	Tue,  5 Nov 2024 04:42:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129818EAD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730781735; cv=none; b=HMkForlgIYZOo01PYQnyM33p6gd5GMtn5W8ZM+GNyKt7HPlaOV0540rH6z//yiDdkEg+1XpFFClWsA2vfX8kd7whVVGsn+HW7CK02Ulv0kjmpgWccWi8cBGQjrfcqxEVT6CsdM0R5qr+Huaac10SAkepOSTE8V13v+GHgDKFW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730781735; c=relaxed/simple;
	bh=KYdKWG+4BlRhbZlGabYii9qMbqXI/8M3GyffK2NTq7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tc200O/AD2I2GAvud5t9v9ycF/slnRSrN6w05AXrzqX2WEQeXHTqxAEjQ7/WvKw3aVSJBpdHqIK5A2b3SAjsTVh05QHVRQSGIl7RUpBe+r7OQ3l09MyHqS7NwD0FkgaIh7zgq6ltjBVYNI2128w+c5Yno75mUVyAgzKWPtJev7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8F5DFEC;
	Mon,  4 Nov 2024 20:42:35 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.45.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F5073F66E;
	Mon,  4 Nov 2024 20:42:00 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/ptdump: Test both PTE_TABLE_BIT and PTE_VALID for block mappings
Date: Tue,  5 Nov 2024 10:11:54 +0530
Message-Id: <20241105044154.4064181-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test both PTE_TABLE_BIT and PTE_VALID for block mappings, similar to KVM S2
ptdump. This ensures consistency in identifying block mappings, both in the
S1 and the S2 page tables. Besides being kernel page tables, there will not
be any unmapped (!PTE_VALID) block mappings.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.12-rc6

 arch/arm64/mm/ptdump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 264c5f9b97d8..688fbe0271ca 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -80,10 +80,10 @@ static const struct ptdump_prot_bits pte_bits[] = {
 		.set	= "CON",
 		.clear	= "   ",
 	}, {
-		.mask	= PTE_TABLE_BIT,
-		.val	= PTE_TABLE_BIT,
-		.set	= "   ",
-		.clear	= "BLK",
+		.mask	= PTE_TABLE_BIT | PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= "BLK",
+		.clear	= "   ",
 	}, {
 		.mask	= PTE_UXN,
 		.val	= PTE_UXN,
-- 
2.30.2


