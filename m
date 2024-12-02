Return-Path: <linux-kernel+bounces-426906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497BF9DF9F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F54B218DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C11F8AE1;
	Mon,  2 Dec 2024 04:36:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A828399
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114170; cv=none; b=jvgilXaprAYjzLATfLuEHef2WKwVhjmRPw/Y1KNFfl2TysPrk+jhmQ6V1pOP6K4vw14a0024TsauSgy4zqiadXgnPhMZF1xkejeVxNBzl4O0ebRzXChb17Y6obLd54ZL/J9MgB2MBZYhNmbEbSvd4qWAfD8FhXIoToYXmHHKefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114170; c=relaxed/simple;
	bh=D6YHoRrs9tfBhGdYJuAY3VpagmGWywUIPYux8LI90rM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dPv1zyAp8ddFKuCaguo1hVFKKuE5UD83CNsAEsW4Ge6mn39ZJig3n+AfOC8NzYsc3xEF699ojFvhd0Y/IRhNj8RXw9HMY5aDnr4hH+x1WRcDaAcsg0lecRfpDZwJlusTCwqremK7GxxmdzavodbdALXBRDrwXSQQG8anXUkakKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E32E106F;
	Sun,  1 Dec 2024 20:36:30 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 222283F58B;
	Sun,  1 Dec 2024 20:35:58 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop INIT_MM_CONTEXT()
Date: Mon,  2 Dec 2024 10:05:53 +0530
Message-Id: <20241202043553.29592-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform override for INIT_MM_CONTEXT() is redundant because swapper_pg_dir
always gets assigned as the pgd during init_mm initialization. So just drop
this override on arm64.

Originally this override was added via the 'commit 2b5548b68199 ("arm64/mm:
Separate boot-time page tables from swapper_pg_dir")' because non standard
init_pg_dir was assigned as the pgd. Subsequently it was changed as default
swapper_pg_dir by the 'commit ba5b0333a847 ("arm64: mm: omit redundant
remap of kernel image")', which might have also just dropped this override.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.13-rc1

 arch/arm64/include/asm/mmu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 2ec96d91acc6..662471cfc536 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -109,8 +109,5 @@ static inline bool kaslr_requires_kpti(void)
 	return true;
 }
 
-#define INIT_MM_CONTEXT(name)	\
-	.pgd = swapper_pg_dir,
-
 #endif	/* !__ASSEMBLY__ */
 #endif
-- 
2.30.2


