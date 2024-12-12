Return-Path: <linux-kernel+bounces-442744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB499EE119
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2C1188B876
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5920CCEE;
	Thu, 12 Dec 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/04cR4F"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3720C483
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991542; cv=none; b=gy6C3eABAUriGQZtt6/T62P9AAnv6OXpDZmEg4G6PokkyHg4Lfv0uVcgmNaTYmM9kHxQLKKM6Ze8xWPfFbnZa2NyKXeoVJ9byfvWBm1s+gDFXANHgK361WI5hL0d1NXk5wVuOD91hHBYzYwiJrrw9qTh7Izx+Og7aBmmUqSD3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991542; c=relaxed/simple;
	bh=9+QLuCvgFOP32pIRaIn85zZ8715Ha5/MHwje3j6rLlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gr0Dn/Oxu1uz3Sz8Xinn/hatevvd22YEdhEZBuXZ0wEuVCe/4I2kFhkoQh/so/4VjbVPHmFryPASkduDaltgDbkirOLAdnTdisfkhB8fG1tD1iR4dDeDirl02UPONaCdJURunlqOql2fnalU1YfbkiUauC2tWrpg3tJl+snW8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/04cR4F; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so2860345e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733991539; x=1734596339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1eR/nZYWDy7JnUFA+IXxK3QIAKZs/ki75z6WryhmEE=;
        b=0/04cR4FF3/0GE2XiQKT42rlJgw6nwb608HzWPNaonG2GU5GOcUFXI/dnq29dJJJi2
         oCTtp+cr0AIPf8RmnWx6C7wQIhALCna4K2KaL99YjSaAN3vxCa9DX5GqJybXNLvfqXGw
         Xc+0YTXsUp96KF3ZyBp55GldSNk9x5u98O7YOkS2kWLpvEungMmeELZ9J4SaQAlZN9O9
         YBmdKOltt1WJfE+TH+D6kTAprxbb6O+a7609rtLMNNAx3elotsizd27NUxThjX9BCqMT
         Yg1yg1yfUZC6U04R+E5yEkmHMrOFjspXCKaUcM2tiFdLCn6wMJzf5cYdx+zmIGUv8qlm
         E9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991539; x=1734596339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1eR/nZYWDy7JnUFA+IXxK3QIAKZs/ki75z6WryhmEE=;
        b=eaiGTrMBsEuOeo8HlnGs83G+h7TLraJa3qVFuEejKAk6+mbz9VYIKkAH2IJek7Z5UJ
         IW0jMZY2/sOJ9QRi9q8f+9xhQmRcLS6j2lkA8WH8wIsQyW4F+IMPk0gEDKEH766BdUjn
         XsLQB32+CJoBS8abqETblUmCUDxfIQcnB5rmRrNSFb3QYPxGsnP8XCDpOsaFYz9Q/vhb
         Gdol7YujbqxmAOOU3okno3YvJ04VZAQ3snaxCi+zvecU0bbuC3lE8XyRFf5SrXaUmb/o
         BBOfz263j+7nAO6LafH8Y8KK1Z6+x08VgPHqnV3i9wAvbxLC34JHIc8YPZrGzsajcHN5
         yMwQ==
X-Gm-Message-State: AOJu0YylHE3HnwBfqMkiul7Vc5G8uHZ6CIYPR5y3xrEj2nNo+CvUsHkf
	M7pHzunsQa/kKaWN/8k6mImZ5RWflG7j3wu8yD6qN0nLjn9R0DUokaqtAlyx7iAmoxE/Xw==
X-Google-Smtp-Source: AGHT+IGFCr+ILtDVl2I89l402u827GSiQNpyuMXKvIlTJVWCnPRqtE/rGoww4lT3RPPpvSl62IgYuB0T
X-Received: from wmbjl17.prod.google.com ([2002:a05:600c:6a91:b0:434:f1d0:7dc9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3acf:b0:434:f8a0:9dd8
 with SMTP id 5b1f17b1804b1-4361c345006mr43908945e9.1.1733991539243; Thu, 12
 Dec 2024 00:18:59 -0800 (PST)
Date: Thu, 12 Dec 2024 09:18:43 +0100
In-Reply-To: <20241212081841.2168124-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212081841.2168124-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310; i=ardb@kernel.org;
 h=from:subject; bh=6f63k+zdnDPwoV97pZOXKmLYrRvOc+ffRW8gf6CiYQc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1qTrKo0a3oN1wHTtdf0f30szBTp23N+v4dx//IP2pct
 76saO2UjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR0Q+MDPfPvVh+Tmqatu21
 lEWKL1c0BX40+O93iFvmyIV32WHP6nkZGeYtYw8WiPs7dbfhv+4oo5aJWVEfv7yODYy2tFBMnl5 RwgsA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212081841.2168124-9-ardb+git@google.com>
Subject: [PATCH v3 1/6] arm64/mm: Reduce PA space to 48 bits when LPA2 is not enabled
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, LPA2 kernel support implies support for up to 52 bits of
physical addressing, and this is reflected in global definitions such as
PHYS_MASK_SHIFT and MAX_PHYSMEM_BITS.

This is potentially problematic, given that LPA2 hardware support is
modeled as a CPU feature which can be overridden, and with LPA2 hardware
support turned off, attempting to map physical regions with address bits
[51:48] set (which may exist on LPA2 capable systems booting with
arm64.nolva) will result in corrupted mappings with a truncated output
address and bogus shareability attributes.

This means that the accepted physical address range in the mapping
routines should be at most 48 bits wide when LPA2 support is configured
but not enabled at runtime.

Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
Cc: <stable@vger.kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 6 ------
 arch/arm64/include/asm/pgtable-prot.h  | 7 +++++++
 arch/arm64/include/asm/sparsemem.h     | 5 ++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index c78a988cca93..a9136cc551cc 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -222,12 +222,6 @@
  */
 #define S1_TABLE_AP		(_AT(pmdval_t, 3) << 61)
 
-/*
- * Highest possible physical address supported.
- */
-#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
-#define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
-
 #define TTBR_CNP_BIT		(UL(1) << 0)
 
 /*
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9f9cf13bbd95..a95f1f77bb39 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -81,6 +81,7 @@ extern unsigned long prot_ns_shared;
 #define lpa2_is_enabled()	false
 #define PTE_MAYBE_SHARED	PTE_SHARED
 #define PMD_MAYBE_SHARED	PMD_SECT_S
+#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
 #else
 static inline bool __pure lpa2_is_enabled(void)
 {
@@ -89,8 +90,14 @@ static inline bool __pure lpa2_is_enabled(void)
 
 #define PTE_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PTE_SHARED)
 #define PMD_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PMD_SECT_S)
+#define PHYS_MASK_SHIFT		(lpa2_is_enabled() ? CONFIG_ARM64_PA_BITS : 48)
 #endif
 
+/*
+ * Highest possible physical address supported.
+ */
+#define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
+
 /*
  * If we have userspace only BTI we don't want to mark kernel pages
  * guarded even if the system does support BTI.
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 8a8acc220371..84783efdc9d1 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -5,7 +5,10 @@
 #ifndef __ASM_SPARSEMEM_H
 #define __ASM_SPARSEMEM_H
 
-#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
+#include <asm/pgtable-prot.h>
+
+#define MAX_PHYSMEM_BITS		PHYS_MASK_SHIFT
+#define MAX_POSSIBLE_PHYSMEM_BITS	(52)
 
 /*
  * Section size must be at least 512MB for 64K base
-- 
2.47.1.613.gc27f4b7a9f-goog


