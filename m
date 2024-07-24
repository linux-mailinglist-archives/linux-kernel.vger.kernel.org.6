Return-Path: <linux-kernel+bounces-260621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB05C93ABDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB38284880
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7620322;
	Wed, 24 Jul 2024 04:14:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD31BF2B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721794478; cv=none; b=PtGPPV+xi7wq2pnrYiIm2BiYPgPnhNHvHCoImApXBplCxjobjn4T16WnRROvTxi9rh+RBH64C21mfrYtdCrQRGJprD4e9QqAEXWIsbquQLQCpg5Kw5zJ3Wh8kfOBZxQ16cztvdtqkUUPwZv7EzC6yz2IBU5S5EZjC7leVgYVGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721794478; c=relaxed/simple;
	bh=QefLlVm59dq4qd36D3pwzG8AokcDsrpTSvkmS3A4RwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzQjYjQ7UjTMevKm5PTkHgM2UPzqHVXHdmz/XEiSvQErzngXF1GKlWvVMORGnLhZkwsHcXo4CJ0007XduLwbTYzf3tkT+we9TGeZPBKq0Mj8GEYi4xCdOSzQbL69X3wWcExjZdD0ILLHKWdBI807e/WoqfHp/LlpporRXns3cHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C82106F;
	Tue, 23 Jul 2024 21:15:00 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.54.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEFA73F5A1;
	Tue, 23 Jul 2024 21:14:32 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Drop TCR_SMP_FLAGS
Date: Wed, 24 Jul 2024 09:44:28 +0530
Message-Id: <20240724041428.573748-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier TCR_SMP_FLAGS gets conditionally set as TCR_SHARED with CONFIG_SMP.
Currently CONFIG_SMP is always enabled on arm64 platforms, hence drop this
indirection via TCR_SMP_FLAGS and instead always directly use TCR_SHARED.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/proc.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index f4bc6c5bac06..8abdc7fed321 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -36,8 +36,6 @@
 #define TCR_KASLR_FLAGS	0
 #endif
 
-#define TCR_SMP_FLAGS	TCR_SHARED
-
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
@@ -469,7 +467,7 @@ SYM_FUNC_START(__cpu_setup)
 	tcr	.req	x16
 	mov_q	mair, MAIR_EL1_SET
 	mov_q	tcr, TCR_T0SZ(IDMAP_VA_BITS) | TCR_T1SZ(VA_BITS_MIN) | TCR_CACHE_FLAGS | \
-		     TCR_SMP_FLAGS | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
+		     TCR_SHARED | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 		     TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
 
 	tcr_clear_errata_bits tcr, x9, x5
-- 
2.30.2


