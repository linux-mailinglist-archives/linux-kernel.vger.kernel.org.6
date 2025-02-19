Return-Path: <linux-kernel+bounces-522057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CCFA3C55F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0B3189E492
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1CC20D4E3;
	Wed, 19 Feb 2025 16:41:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6F1FF61E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983281; cv=none; b=FcPPMcLWMjj/MaMneWk6WSYb7M2HaqolN71t/XN8cN5PMveO5k3DpSxER9InTgU8ug3SaF1XHznyYI23ZLSrsT/XEwGSqutmQVdjJATCtDI9t84bCp868pEKN/AYPXqFS0yvnn0AxV7Qhc4LiQ0C1mWN35HIy1cs3vKgaQ0Rwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983281; c=relaxed/simple;
	bh=wtw1EQJKa3XRYeCPZTX/Hse/1Up+Io1SxYeKG/PS774=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7nHIlqH7ZrbhNvWvY2KSIxHen/R+prj4J3S3ByEi1kZl7COmpkEIXG/ykP7WBkWUN8hujKmL12WmLwgVwWQKvWyTadOK4zpBbncoYoQ0g/bAEW0b0nc+6v7rS4AoYnRXnlI9rDiA08Nb+jf3FfrBFBoOrRqjbUz4rvepAk0IYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15736204C;
	Wed, 19 Feb 2025 08:41:38 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A424F3F6A8;
	Wed, 19 Feb 2025 08:41:18 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 3/3] arm64/sysreg: Move POR_EL0_INIT to asm/por.h
Date: Wed, 19 Feb 2025 16:40:29 +0000
Message-ID: <20250219164029.2309119-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250219164029.2309119-1-kevin.brodsky@arm.com>
References: <20250219164029.2309119-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of POR_EL0_INIT is not architectural, it is a software
decision. Since we have a dedicated header for POR_ELx, we might as
well define POR_EL0_INIT there.

While at it also define POR_EL0_INIT using POR_ELx_PERM_PREP(),
making it clearer that we are setting permissions for POIndex/pkey
0.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/por.h    | 2 ++
 arch/arm64/include/asm/sysreg.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
index e6bf00bd0500..d913d5b529e4 100644
--- a/arch/arm64/include/asm/por.h
+++ b/arch/arm64/include/asm/por.h
@@ -8,6 +8,8 @@
 
 #include <asm/sysreg.h>
 
+#define POR_EL0_INIT	POR_ELx_PERM_PREP(0, POE_RWX)
+
 static inline bool por_elx_allows_read(u64 por, u8 pkey)
 {
 	u8 perm = POR_ELx_PERM_GET(pkey, por);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 034e0576de5a..e3252f8bb465 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1086,9 +1086,6 @@
 #define POR_ELx_PERM_GET(idx, reg)	(((reg) >> POR_ELx_PERM_SHIFT(idx)) & POE_MASK)
 #define POR_ELx_PERM_PREP(idx, perm)	(((perm) & POE_MASK) << POR_ELx_PERM_SHIFT(idx))
 
-/* Initial value for Permission Overlay Extension for EL0 */
-#define POR_EL0_INIT	POE_RWX
-
 /*
  * Definitions for Guarded Control Stack
  */
-- 
2.47.0


