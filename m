Return-Path: <linux-kernel+bounces-442748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA319EE11E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B24E16512F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD0E20E6F5;
	Thu, 12 Dec 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZD4C5fYk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45B20E32A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991550; cv=none; b=VXBKfszoCsRsRJoWlazgtJnWSOnsECR8KzAHE77Wf1/uLuMZorZwiagmRxm6pigmbI3jmyk6fjmSJGzEbZwtrZMYo5Z8l0T30qKV+I4NfGlqR9uJUyN6KVfF7pO2G+9PSOVixFmBdPbtUU+/PxeQYaBjwHACjIWCf0fyU6iM9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991550; c=relaxed/simple;
	bh=rJox4UKc5PUt22rL72LAJ3+UpcvjdFOHhc+p89nZv98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DQ+KkvDHUD69zi2x6KJ50IS0jAJ2k3gIqMvt6SG3I5zTdCsw4+jSpbXTuS5P+yK9whMEBwQLn586DTff7zQRSGr3L/X0Nrd6eMPJAbkn4S4wdKsiYtGD4vSS/ei/G/GDLVlBuLnEziJAS/b60Ho/dR0B2l1io8N5Z8yp5WDEH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZD4C5fYk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434f387f346so1883185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733991547; x=1734596347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdgtdUqEBd5LKxpewIKQlxiAPN7TmKSwfgktC1/nR3M=;
        b=ZD4C5fYkV5GqqnDYxS7JF4pyssXPAv0KQoP7PtZXaE+3RSxmz4ZRy4CZadOblTDyte
         Eqy9+kUcNZ4WJ69m48vOksbHk/HeifA6pT3fS+oWWvPAlD2szwXBY8vYqrkqGKWxNdY0
         MIkmI8dbSNdLHrNXkE3+AgUEIROX73bHF/kDth+JGkc1XokkRfjAqAz2uynbJLZfJ8sq
         Qo8msUwwvElGFPIQn3n0rtKJ2xSplwOEJkP+4OEECj2Eo1o7EEPbT3nED1i1G9SQF7TU
         Ts3hfA0KrpS/cHk5vIP1/exlG12li9xtuL58HmEvNtXC+bQGIqd/vfSkiL7FfCBPmoet
         7ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991547; x=1734596347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdgtdUqEBd5LKxpewIKQlxiAPN7TmKSwfgktC1/nR3M=;
        b=m1rbV7z7do4etIm2lPHaeFGlOdpB/c98M1a3e4vpP+00msVRyuckK4agURRF1MNKpp
         tULuQt39hIrVeIS8lHZ8uegkWhC9UxBBFyAkm7SG/BP1JGUFNiGAdmN1g4F/YwxyRkjs
         JF/Yiwku3I6Rx0moKuz2decMUjq/utlxV+Tn30Ty5hCH1+RWX6+TMejOdaNJLo48ypng
         w1kvAsRKLMSyEbThJa8l64elpQ6SN7Ev21rxtp/qBCfPATDwMdtNMx7WY2NPeUu95u3R
         Orhmznj8jjjXnzVTcBgLc5OfwYBvZtvuWofC1S+38KHjgW8zju4r1/NhZO0no7Z6eJEZ
         6Wow==
X-Gm-Message-State: AOJu0YyJmQDvhU1ZaLoCMijzeyKxCaSWfSrbZtdDcVJbhBt8hLdcogEH
	SfFoUtdScBZA1HOOF4CRDZHIEGtWjhew4NqwD1dNMsAOYE71dSCBDfCCYAIjJ8ZilRm7XQ==
X-Google-Smtp-Source: AGHT+IGWPJvO6+9CCQmmFw3OSCuh5I3iyCbxp28yrcBF8dbr114C30A5zZAFQgAChqfAkJPHTDhYBmac
X-Received: from wmqy11.prod.google.com ([2002:a05:600c:364b:b0:434:fc6f:e8c3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:ac7:b0:436:aaf:7eb9
 with SMTP id 5b1f17b1804b1-4362285f79fmr17388455e9.20.1733991547419; Thu, 12
 Dec 2024 00:19:07 -0800 (PST)
Date: Thu, 12 Dec 2024 09:18:47 +0100
In-Reply-To: <20241212081841.2168124-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212081841.2168124-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2690; i=ardb@kernel.org;
 h=from:subject; bh=vw43pFoSabaJKFXhQUhpwCIEl+ZhAtorVG0O+2+nOWw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1qTub9hSnTjk48PK1RpV2XYXXNlqrNtyyiLh7s1n/+4
 PPZT7ZRHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiFxUZGQ6vfyod9Ht3of+P
 SYo920KmBTy4duOD/dJ7dlxsCjaKSv8Y/im7pDU+c+SIbvS/7bu477PN5Snpd9uubteI6Nf3Tlj byQIA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212081841.2168124-13-ardb+git@google.com>
Subject: [PATCH v3 5/6] arm64: Kconfig: force ARM64_PAN=y when enabling TTBR0
 sw PAN
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

There are a couple of instances of Kconfig constraints where PAN must be
enabled too if TTBR0 sw PAN is enabled, primarily to avoid dealing with
the modified TTBR0_EL1 sysreg format that is used when 52-bit physical
addressing and/or CnP are enabled (support for either implies support
for hardware PAN as well, which will supersede PAN emulation if both are
available)

Let's simplify this, and always enable ARM64_PAN when enabling TTBR0 sw
PAN. This decouples the PAN configuration from the VA size selection,
permitting us to simplify the latter in subsequent patches. (Note that
PAN and TTBR0 sw PAN can still be disabled after this patch, but not
independently)

To avoid a convoluted circular Kconfig dependency involving KCSAN, make
ARM64_MTE select ARM64_PAN too, instead of depending on it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a048c5..c1ca21adddc1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1379,7 +1379,6 @@ config ARM64_VA_BITS_48
 
 config ARM64_VA_BITS_52
 	bool "52-bit"
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable 52-bit virtual addressing for userspace when explicitly
 	  requested via a hint to mmap(). The kernel will also use 52-bit
@@ -1431,7 +1430,6 @@ config ARM64_PA_BITS_48
 config ARM64_PA_BITS_52
 	bool "52-bit"
 	depends on ARM64_64K_PAGES || ARM64_VA_BITS_52
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable support for a 52-bit physical address space, introduced as
 	  part of the ARMv8.2-LPA extension.
@@ -1681,6 +1679,7 @@ config RODATA_FULL_DEFAULT_ENABLED
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	depends on !KCSAN
+	select ARM64_PAN
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved
@@ -1937,7 +1936,6 @@ config ARM64_RAS_EXTN
 config ARM64_CNP
 	bool "Enable support for Common Not Private (CNP) translations"
 	default y
-	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Common Not Private (CNP) allows translation table entries to
 	  be shared between different PEs in the same inner shareable
@@ -2132,7 +2130,7 @@ config ARM64_MTE
 	depends on AS_HAS_ARMV8_5
 	depends on AS_HAS_LSE_ATOMICS
 	# Required for tag checking in the uaccess routines
-	depends on ARM64_PAN
+	select ARM64_PAN
 	select ARCH_HAS_SUBPAGE_FAULTS
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_USES_PG_ARCH_2
-- 
2.47.1.613.gc27f4b7a9f-goog


