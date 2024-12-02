Return-Path: <linux-kernel+bounces-427079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088E9DFC14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD8162D89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB41F9F49;
	Mon,  2 Dec 2024 08:39:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC81F9ED8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128743; cv=none; b=k+MbFBM8bsiH2JH1Fo9kFHHh836ulqhzdLAwOCo5YRgiSFTi1tB8Z9mreJQTXYo26sLQIMLnteYaEHsyOJe6IkfIahShf2jY3gA4OIziM4tzpw4B+s20lrvJGY7F+xfnNNE4YLV7zTn/ctrp1xMkYDq2CqAQWePDnf8fKnLcmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128743; c=relaxed/simple;
	bh=hEGdud7c7bh/jYjcv1q0/EyBkdfRmz9jOoUwNelxMPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JqbB4F22T3lcWXkR5e5UUsQ50PUk7+C+Mu0A3M2V3t/v3tLZL+0KZrqWD5GO5UMSi/A/NM8KsIMMGdMn9xpq9+xny8iSDmf/82yzWogPIMvMEIDjIFFM/Jzn2JccJusevfs6gyevbl9rVEVF02pCikiaWSqDVxRXRA900N7hhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C891063;
	Mon,  2 Dec 2024 00:39:28 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E1733F58B;
	Mon,  2 Dec 2024 00:38:57 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Replace open encodings with PXD_TABLE_BIT
Date: Mon,  2 Dec 2024 14:08:50 +0530
Message-Id: <20241202083850.73207-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[pgd|p4d]_bad() helpers have open encodings for their respective table bits
which can be replaced with corresponding macros. This makes things clearer,
thus improving their readability as well.

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

 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6986345b537a..e20b80229910 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -896,7 +896,7 @@ static inline bool mm_pud_folded(const struct mm_struct *mm)
 	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
 
 #define p4d_none(p4d)		(pgtable_l4_enabled() && !p4d_val(p4d))
-#define p4d_bad(p4d)		(pgtable_l4_enabled() && !(p4d_val(p4d) & 2))
+#define p4d_bad(p4d)		(pgtable_l4_enabled() && !(p4d_val(p4d) & P4D_TABLE_BIT))
 #define p4d_present(p4d)	(!p4d_none(p4d))
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
@@ -1023,7 +1023,7 @@ static inline bool mm_p4d_folded(const struct mm_struct *mm)
 	pr_err("%s:%d: bad p4d %016llx.\n", __FILE__, __LINE__, p4d_val(e))
 
 #define pgd_none(pgd)		(pgtable_l5_enabled() && !pgd_val(pgd))
-#define pgd_bad(pgd)		(pgtable_l5_enabled() && !(pgd_val(pgd) & 2))
+#define pgd_bad(pgd)		(pgtable_l5_enabled() && !(pgd_val(pgd) & PGD_TABLE_BIT))
 #define pgd_present(pgd)	(!pgd_none(pgd))
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
-- 
2.30.2


