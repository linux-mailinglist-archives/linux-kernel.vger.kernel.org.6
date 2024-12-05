Return-Path: <linux-kernel+bounces-433498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5A9E5946
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E922815C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD121D58C;
	Thu,  5 Dec 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgwyTkSV"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D7C21C9FD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411004; cv=none; b=TRj+90/lz2o5ALgnG3vADszIYoTYRjT2E3bPhQkcsxWlAi935ZRz/nI+qHkRMX8uEL2iR2PLNb6WROb1ghjmDjhkXQPuEz+eRi9juxbSmyK2kurQ5/y2nkJ/r+aPb6haO4sh/gzK+ZYlLieGztJFFMBy3cRGffq7R4GqIDHcwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411004; c=relaxed/simple;
	bh=q2KLanADgQW3WhFbuHSK62kzEWc781N0Ubrp5UCqwkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kbr0PSXpzu8df3FLVFnFDvzgm2KJFFrraUjQPWKAiKBGg9kwLwp/zy1/BPY7jP9Ec1cVqnLqwI6XyemgrGSSZTfNa7loIkzv6yZZEl13Vc7WZZZs8hszt8YNrttebUAJFVTpc/mloUiSYMCcNPuXSgwjzX7+UlRil8XYttdZoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgwyTkSV; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385df115288so514100f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733411001; x=1734015801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSmMzjbQjkryanRY9ZazdGejohWYD6afgp49C2Ru5Dk=;
        b=OgwyTkSVVFKqt9SlGRFYcw82jLiDk4FmRw3RopUNw3EbhWGx28fi655FGdT4R3diuF
         VtWxRWxW7FLNNGWwc0kbAyNFNNwMtMlNT0Gn5T8ILePgMpX17rW0F5jeLU49Row9xH9K
         AW7PMXCWU9HXZP2G7e4id6Rg/uLegY8A6ed2hFoOQZnghWkKq2p1iLXKQK7garLO+GW2
         LtOukHZbhPTrgpK4S0A6sdV1uPRQ+z9fPSFdylmUEcy5xPpIHFBhW/365WQGEK3g3FXX
         VJlxMFI7YDqBPo6qx9Y3fspH4slD5APh5smQ5r/iUZS9xXbQhgyPXDh+I/uNuWN5IJkn
         K7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411001; x=1734015801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSmMzjbQjkryanRY9ZazdGejohWYD6afgp49C2Ru5Dk=;
        b=votWFMKpcpyly+cW7pIKMDtgMqUz2dKtuKgdvrXjRjowW+4zlKdV44IXENVHEO6CJ5
         yon+MZxXgL9+uXoBegvE6aLd4vyiVyO5PGIfVjgy30UxNvJl5Dwix4nfFBj1u3vkMelS
         aaOo5PO5pP6fIEJpwEYlrMAK9q9kmaU6e4SkVv3BQo2++CyZTbMrAlSLJYH4PqoiCxAB
         BTzMM2TdiFSlCn9Jpaj/8kZGrEdw25LxYmvrJgmI/hSaesbyt12SglQ0nmAODS6NhV3+
         P1nHIWBs4fRTx9MsGa3gIqVKydFd3muRuX+JnfCveFk159ReErKBRdccPdcE2Yf6mIfs
         9vkg==
X-Gm-Message-State: AOJu0YwFj/M8dVKDnsWBWJjms3cQ4/O7LmbhX21YeVg9fQ/K7cBezXGb
	IMD8j7KER+Ie5ld1JypZDutK40HlcDS7FzWMx7FaBk8VK1ZLCC5y+VyBTlP4p7IlkI4GAQ==
X-Google-Smtp-Source: AGHT+IGeyIS11CyHaOaxzh7fmzkABKWg8TLqFcdiY2/yzqapgMZvhTcty/d5/9mQdd+Tbhk0hutQNOin
X-Received: from wrco4.prod.google.com ([2002:a5d:47c4:0:b0:37d:3332:8544])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1866:b0:385:dc45:ea06
 with SMTP id ffacd0b85a97d-385fd3e7b28mr10077509f8f.13.1733411001451; Thu, 05
 Dec 2024 07:03:21 -0800 (PST)
Date: Thu,  5 Dec 2024 16:02:32 +0100
In-Reply-To: <20241205150229.3510177-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205150229.3510177-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4458; i=ardb@kernel.org;
 h=from:subject; bh=V2Mgw1B4fdeIa/VDXTw8dxEemYc3zLOlxi/YHPnanpA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3wQGf5Bd4Hn53srYxftN/4VjjXbSLLleot29JX/i0I8
 bGQ/VbaUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZS3Mnwzzj7+c40sVwXvmCx
 rJiTv3USRC9ve9SrNMXqoG5Gyo3TBxkZdvLoqTcm3WLunn+y2i+ucbnKnc1vZrlp+U41E1jGIxr ECAA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205150229.3510177-10-ardb+git@google.com>
Subject: [PATCH v2 2/6] arm64/mm: Override PARange for !LPA2 and use it consistently
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When FEAT_LPA{,2} are not implemented, the ID_AA64MMFR0_EL1.PARange and
TCR.IPS values corresponding with 52-bit physical addressing are
reserved.

Setting the TCR.IPS field to 0b110 (52-bit physical addressing) has side
effects, such as how the TTBRn_ELx.BADDR fields are interpreted, and so
it is important that disabling FEAT_LPA2 (by overriding the
ID_AA64MMFR0.TGran fields) also presents a PARange field consistent with
that.

So limit the field to 48 bits unless LPA2 is enabled, and update
existing references to use the override consistently.

Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h    | 5 +++++
 arch/arm64/kernel/cpufeature.c        | 2 +-
 arch/arm64/kernel/pi/idreg-override.c | 9 +++++++++
 arch/arm64/kernel/pi/map_kernel.c     | 6 ++++++
 arch/arm64/mm/init.c                  | 7 ++++++-
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3d8d534a7a77..ad63457a05c5 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -343,6 +343,11 @@ alternative_cb_end
 	// Narrow PARange to fit the PS field in TCR_ELx
 	ubfx	\tmp0, \tmp0, #ID_AA64MMFR0_EL1_PARANGE_SHIFT, #3
 	mov	\tmp1, #ID_AA64MMFR0_EL1_PARANGE_MAX
+#ifdef CONFIG_ARM64_LPA2
+alternative_if_not ARM64_HAS_VA52
+	mov	\tmp1, #ID_AA64MMFR0_EL1_PARANGE_48
+alternative_else_nop_endif
+#endif
 	cmp	\tmp0, \tmp1
 	csel	\tmp0, \tmp1, \tmp0, hi
 	bfi	\tcr, \tmp0, \pos, #3
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed8..f8cb8a6ab98a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3478,7 +3478,7 @@ static void verify_hyp_capabilities(void)
 		return;
 
 	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
-	mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 	mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
 
 	/* Verify VMID bits */
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 22159251eb3a..c6b185b885f7 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -83,6 +83,15 @@ static bool __init mmfr2_varange_filter(u64 val)
 		id_aa64mmfr0_override.val |=
 			(ID_AA64MMFR0_EL1_TGRAN_LPA2 - 1) << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
 		id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_TGRAN_SHIFT;
+
+		/*
+		 * Override PARange to 48 bits - the override will just be
+		 * ignored if the actual PARange is smaller, but this is
+		 * unlikely to be the case for LPA2 capable silicon.
+		 */
+		id_aa64mmfr0_override.val |=
+			ID_AA64MMFR0_EL1_PARANGE_48 << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
+		id_aa64mmfr0_override.mask |= 0xfU << ID_AA64MMFR0_EL1_PARANGE_SHIFT;
 	}
 #endif
 	return true;
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index f374a3e5a5fe..e57b043f324b 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -136,6 +136,12 @@ static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
 {
 	u64 sctlr = read_sysreg(sctlr_el1);
 	u64 tcr = read_sysreg(tcr_el1) | TCR_DS;
+	u64 mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+	u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
+							   ID_AA64MMFR0_EL1_PARANGE_SHIFT);
+
+	tcr &= ~TCR_IPS_MASK;
+	tcr |= parange << TCR_IPS_SHIFT;
 
 	asm("	msr	sctlr_el1, %0		;"
 	    "	isb				;"
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d21f67d67cf5..2b2289d55eaa 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -280,7 +280,12 @@ void __init arm64_memblock_init(void)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
-		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+
+		/*
+		 * Use the sanitised version of id_aa64mmfr0_el1 so that linear
+		 * map randomization can be enabled by shrinking the IPA space.
+		 */
+		u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 		int parange = cpuid_feature_extract_unsigned_field(
 					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
 		s64 range = linear_region_size -
-- 
2.47.0.338.g60cca15819-goog


