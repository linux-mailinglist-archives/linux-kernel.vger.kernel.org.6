Return-Path: <linux-kernel+bounces-442743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D519EE115
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B03168F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1420C018;
	Thu, 12 Dec 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzQmzfwB"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C920C01D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991540; cv=none; b=ndlttzWKeHiZUkHS9VUL8kc69kdiOqFmY+E3GD+fzGnq6ZaJiw97Zzdk4PUhVGPeBVJah0dHByiJpSmICJvQ6P+1dGvJY/0YQLXqstODgRl4yrjfmYJ8bhceKA6+dzVCzl+NlsGBgZStccZ3uWK5N6YESPeCODu8SPGvaXcsD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991540; c=relaxed/simple;
	bh=pSLcxLRju0Lxto/hVvMD2o4yhEFN040w70IVS/l+2Gs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XY+lBiduL+FCCL+dWSI0rvpu9XpCU4TQPglp/OU73nWUjOWkS81s9j8VHYxfiC3CP+avLVzC5Ddq64Z4xrsZRpGcNzWMZ2gOWCsIHTXWBkS5SoxFZ2muaLNdHBaXGOh0HP/KcCFwvx8mYPIeserQSVZ9f77o1DwsasXR1dZ2Xss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzQmzfwB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso2866535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733991537; x=1734596337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eZxIxb08AFzTWoKrgKOX13TiM2yGibM60AZ71EJbzeU=;
        b=NzQmzfwB13mocIWp0EwItIdlzc1O9faQwJ2SxG/3UKtom9Yr2B+0r2HpdWajvBZPXk
         3Jsu9eGrd2TwJtNvwHtKOaMcPyKZok5olmqYf1t2OJrYIzyroPkEHAZ8w9vFscZxLJt3
         iZFsjo7qDpPWWQHx2xUsKcS727b6zSflRonmre5d2rCMmxe6UEzRoxeWsCrAiCDhvUP8
         YM72t4BxxDFw77lmw1G/2YtEhh3gSsgPgp9vkFqa9NYPjJD6oSrEOq1VKKIMGD3cb2pI
         yy6E5ipG0k58it/V2JZqu6km5JqMQjfX/NtfW3PINt8yhxcCQTM7qbZroqkzL3OMCHtn
         HBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991537; x=1734596337;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZxIxb08AFzTWoKrgKOX13TiM2yGibM60AZ71EJbzeU=;
        b=izlkzPuykXxYJKlE+VKZP/CJpXmszEF5B8XEWAtw0qIZ5pqbZVnSAzvK2niYUIaLo+
         fY8SXcaBhUt4hVPOOKiKcorn0+eWBD23hx9Xca3RMvQ9f36L1YwRIgK3rV+6vqfzz/lC
         ISii1a+SCubk/ECMnhQKGaz7QKWEjnu+cXcgH3DHVWQB7X3oc37dFKGf9fiR9blcZk3N
         4FupEtcqehNEcpiQrREJdpxTRAxoZQlZdw79HxYErP3PiBJt91ztpTlJIkXQ7Mqxsi1o
         Po3B9nT8Lo1pPhGoXfzQw2Qn6pVz0TOz3SZpBlu7c4B/62id2ielTZ6M7L/fS5WKymCG
         m2sw==
X-Gm-Message-State: AOJu0YxyUdwoFeFsctC0XhVT6M8nODeOCqysga1MwuITn07hQXnO0mgR
	QBhmHMC+vTGcsIpekZktL1YvupK+UoR7hvxTqRFSliImcbJ8Hr6Y0qJYDY7dG26V4smUZw==
X-Google-Smtp-Source: AGHT+IF2vmDSiNp6YQveUxSHd4dHnzmu0hMH4N0O/nDHLokka+n8/j7E8uKPq55GrDTrh9brZQc0gsZM
X-Received: from wmqd1.prod.google.com ([2002:a05:600c:34c1:b0:434:f350:9fc])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c16:b0:434:a386:6cf
 with SMTP id 5b1f17b1804b1-4361c344b7emr48469835e9.2.1733991537221; Thu, 12
 Dec 2024 00:18:57 -0800 (PST)
Date: Thu, 12 Dec 2024 09:18:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=ardb@kernel.org;
 h=from:subject; bh=eoER92ARiF/hRhV403UkEurD5/0joQIOstiB5pr57tY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1qTtKkmgc2N9Idr01x/DpX6Nrn5+87Ns2feNV4bsvuK
 dX7Tu4711HKwiDGwSArpsgiMPvvu52nJ0rVOs+ShZnDygQyhIGLUwAmkhPL8N8xe0NlmojhwkKJ
 AHsjt5scUmE7Hty+pfNo+VduF1k3V35GhsdmCjFvvaRmtLBkyae1y/w0X8lppZoh8Cbt4XK+v2U VLAA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212081841.2168124-8-ardb+git@google.com>
Subject: [PATCH v3 0/6] arm64: Clean up and simplify PA space size handling
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

Changes since v2:
- add a definition of MAX_POSSIBLE_PHYSMEM_BITS to fix a build error in
  zsmalloc (#1)
- rename 'owner_update' to 'annotation' (#4)

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
 arch/arm64/include/asm/sparsemem.h     |  5 ++-
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
 19 files changed, 64 insertions(+), 117 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


