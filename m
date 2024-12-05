Return-Path: <linux-kernel+bounces-433496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73239E5948
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB3F18813A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0321A42B;
	Thu,  5 Dec 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzDh9Fwk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212802F85C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411000; cv=none; b=rlotZWMj68JN+YAKQr1JPfVcr29NCqJc/J/d/tsw9M3a2rz8lPwQeWkwdTlxgTcxyhYRX/WBeH1Vk3/MQTVdTz/BZlogw30Kd2k6aF+zNJpUjbheGnopGjX69oQHD5zMAATUqItGEePzmD61R+CPhPnXudFDC8Jh7EiHhZEV1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411000; c=relaxed/simple;
	bh=D6Y7UB/C4hDo9E6h3VZooFVyxnhqXbWJ7eno9Us7o+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QQ6iKI+xQdmugZfsE9wppjsXZ3IXmprwUSECJDY46YKGd2RYb7kSQVF9Z+skgsFT8R1bFvcj50rRp0srj+GDzSIQKWt4Ynw490z5qTdTxD3vuGc36JN0iiHy7fmOi9JkqbYc+Rb1/F4Nucq1iuZSR9zsnNAKMmtfCt5oezQ3NtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzDh9Fwk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43499c1342aso8741365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733410997; x=1734015797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BwJubUT8Tdc7oClPWEPhghjrfw8jIX6vzdGr4YCz4uQ=;
        b=GzDh9FwkCB+w0PE4hvv0PgHsSoSRRx0vLcmXdofttb7/UtUTzx3XGo+42v0DKv9qO7
         ozG2wDIKBmQUJo1eDQrMyrHGxGQCQetzK66P2ZhyQYmQpz0OcYgM1qTBs/dburJuBCLy
         M5OgpGWRFwsR0Wc/fjAWZe4mVSsFKwFZki3V/vCbN+X6/qQQmD60ewgvDCeP7CsbvATI
         0KOuMlp0fRi+Wc5OPfNWhG9vtKOMjv4ugLiIQCkLLVwpPN/lVNFoFQPkOJ407HPMupaB
         pszM8Ng4HSr9/JW6H85dCFgEjPIuTTGsT79Ptj/e/UwxS20vRdrCohHVwXla6RdTd3ot
         RW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410997; x=1734015797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwJubUT8Tdc7oClPWEPhghjrfw8jIX6vzdGr4YCz4uQ=;
        b=d4SEHB+UQ4wViw+L6TTDFyu53lSThl37Yv+fC46diA+itySla49PlH/zr3b7SMWWld
         1RaOQYiEeqNEUTzYPGH3qPUsZ+FP1VcEGQZF3dWR0WHGfplKbuREM3nNfwMGqRbIWaWn
         zANE8nQ3sgFup5InqMgvroekC2vQ9K7i4xeKB5rKMDCLYKjJZlV251d4jqLbN/qR/rZW
         zHwJUP7crVGuZ25SIWd9miBd/yx1/Y7KvPshgA9YD6RuC2qVzwLuSrt90koug/ptqRMm
         o/nYpSfsp4K62eOSxHQcwmDzdO0Ez2GYWSNbOfrFELVVTrFsAOEipipcM5nPEn8TtJcn
         XrJA==
X-Gm-Message-State: AOJu0YxDE0N7RQQCRPAvNcTEUDseEGiVgqzKca1JVjYG/4GyfilX3+te
	cscPbskaVOtRU5Xm4lSM0mIyI9HtiASQWA0omFI2LVWwJev00LtlYZ3mz7jvC+FF/u5kkQ==
X-Google-Smtp-Source: AGHT+IGioVJCoK8zYYqTywuPhQi+8Z7KdiKyqo2KQn5SY2N3fSHvvtqHDwjOOZi2i4b0vvNS4g5Z3uNA
X-Received: from wmaw15.prod.google.com ([2002:a05:600c:6d4f:b0:434:a158:2c03])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3151:b0:434:9936:c828
 with SMTP id 5b1f17b1804b1-434d09b64e4mr97941255e9.12.1733410997284; Thu, 05
 Dec 2024 07:03:17 -0800 (PST)
Date: Thu,  5 Dec 2024 16:02:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; i=ardb@kernel.org;
 h=from:subject; bh=mRRjZP9KtZpr0axKuxzKvK9RQGNYQZdHxwWtIVX9O9g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3wQFt27UZV6ejOY/n/qh7kyFwzN7runGb/7++ucI8DR
 xKclFI6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwES+f2Nk2HLcccoTi9fqjpdS
 9VUlpu3Ly6855nl+OoNuy5sqw2/McowMBx++35G/o+9JM0+o1TWRFfeu3hBr/fjj5fLmkvdLJ9/ fxgQA
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205150229.3510177-8-ardb+git@google.com>
Subject: [PATCH v2 0/6] arm64: Clean up and simplify PA space size handling
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This series addresses a number of buglets related to how we handle the
size of the physical address space when building LPA2 capable kernels:

- reject 52-bit physical addressess in the mapping routines when LPA2 is
  configured but not available at runtime
- ensure that TCR.IPS is not set to 52-bits if LPA2 is not supported
- ensure that TCR_EL2.PS and DS match the host, regardless of whether
  LPA2 is available at stage 2
- don't rely on kvm_get_parange() and invalid physical addresses as
  control flags in the pKVM page donation APIs

Finally, the configurable 48-bit physical address space limit is dropped
entirely, as it doesn't buy us a lot now that all the PARange and {I}PS
handling is done at runtime.

Changes since v1:
- rebase onto v6.13-rc1
- add Anshuman's ack to patch #1
- incorporate Anshuman's feedback on patches #1 and #2
- tweak owner_update logic in patch #4

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Quentin Perret <qperret@google.com>

Ard Biesheuvel (6):
  arm64/mm: Reduce PA space to 48 bits when LPA2 is not enabled
  arm64/mm: Override PARange for !LPA2 and use it consistently
  arm64/kvm: Configure HYP TCR.PS/DS based on host stage1
  arm64/kvm: Avoid invalid physical addresses to signal owner updates
  arm64: Kconfig: force ARM64_PAN=y when enabling TTBR0 sw PAN
  arm64/mm: Drop configurable 48-bit physical address space limit

 arch/arm64/Kconfig                     | 37 ++------------------
 arch/arm64/include/asm/assembler.h     | 14 +++-----
 arch/arm64/include/asm/cpufeature.h    |  3 +-
 arch/arm64/include/asm/kvm_pgtable.h   |  3 +-
 arch/arm64/include/asm/pgtable-hwdef.h | 12 +------
 arch/arm64/include/asm/pgtable-prot.h  |  7 ++++
 arch/arm64/include/asm/pgtable.h       | 11 +-----
 arch/arm64/include/asm/sparsemem.h     |  4 ++-
 arch/arm64/include/asm/sysreg.h        |  6 ----
 arch/arm64/kernel/cpufeature.c         |  2 +-
 arch/arm64/kernel/pi/idreg-override.c  |  9 +++++
 arch/arm64/kernel/pi/map_kernel.c      |  6 ++++
 arch/arm64/kvm/arm.c                   |  8 ++---
 arch/arm64/kvm/hyp/pgtable.c           | 33 ++++++-----------
 arch/arm64/mm/init.c                   |  7 +++-
 arch/arm64/mm/pgd.c                    |  9 ++---
 arch/arm64/mm/proc.S                   |  2 --
 scripts/gdb/linux/constants.py.in      |  1 -
 tools/arch/arm64/include/asm/sysreg.h  |  6 ----
 19 files changed, 63 insertions(+), 117 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


