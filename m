Return-Path: <linux-kernel+bounces-403706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05009C394B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B54282195
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7D315990C;
	Mon, 11 Nov 2024 07:52:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EE9B67F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311578; cv=none; b=Mew7OKLCz70bWHTlEqOCHxb0EdRM9FkUqCZEmiY8BaphFAxLTwD629gUPzR71UXV2UE4cLkCOJ2FjxsqxoiRyF0xQcWdqGSUD+o9FAQ+72gInnNrvccsu75JnBeSu/tjRlEamjUw4B6Lbp2Q7ngLuWnfuhv1OKkTxNlP317fgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311578; c=relaxed/simple;
	bh=Ys4OCF2deyCqZjMUjhOfkC5Gwml9HKL1MjNCHufN5tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ndxR0Ea0bbc6aJaXb0EJtO/VH3u9fKKswJhOT2TOSP6XM+OK2iSD1ruAuyqvZbNgzIhxuhCRVGXk5O+LaKosx0AOZneNgqWNjlEBk/7MVoTfajYRj/36lj/kKwUYXPoxGO31f9myRAtpTOpE7Tq6/OCwbGqFFd6v3MQovNdu5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DC61D14;
	Sun, 10 Nov 2024 23:53:24 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.44.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED6893F6A8;
	Sun, 10 Nov 2024 23:52:51 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Change protval as 'pteval_t' in map_range()
Date: Mon, 11 Nov 2024 13:22:49 +0530
Message-Id: <20241111075249.609493-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pgprot_t has been defined as an encapsulated structure with pteval_t as its
element. Hence it is prudent to use pteval_t as the type instead of via the
size based u64. Besides pteval_t type might be different size later on with
FEAT_D128.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.12-rc7

 arch/arm64/kernel/pi/map_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 5410b2cac590..2b69e3beeef8 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -30,7 +30,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 		      int level, pte_t *tbl, bool may_use_cont, u64 va_offset)
 {
 	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
-	u64 protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
+	pteval_t protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
 	int lshift = (3 - level) * (PAGE_SHIFT - 3);
 	u64 lmask = (PAGE_SIZE << lshift) - 1;
 
-- 
2.30.2


