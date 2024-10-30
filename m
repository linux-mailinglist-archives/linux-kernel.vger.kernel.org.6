Return-Path: <linux-kernel+bounces-388448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA349B5FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D61F21F01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9C1E3DC6;
	Wed, 30 Oct 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaX7How2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD581E32DE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283510; cv=none; b=eIoLUIKs4y5AncMHwSYkWcDYPzs3wE4unc2sBYhwKQ856bhshATWDwCQHIaSJamjCVPKnEAF1fW0+8Ar3PSvyZUKAZ0e+RTxYdwZe2kbHCoM9WktJ7rKleTNLH6SjcrYWBeGBN9c6LIM+XFBVKyV8KOYHSiV8TQ7Ecz5meOFqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283510; c=relaxed/simple;
	bh=3n7RtXea6exk7ub8+eMg3npSuXNUaKLy/1AMlPPqz7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dYERfDnidpCXYA/IetwCfAPCYtWBeECelJ/t/CgPFYE1OH11AWxLpv+kylqdJGxvz9J/FCn7zR2Bo1qN7HozELC0OOyIAIloSExqblmWTjXCi7GdOqGSJJIgdxw2t34wjmEUGesU2q2odCDzPYtTZ4ljj5HCs8CDPFzRVfGHguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaX7How2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d660a1afso114005007b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283506; x=1730888306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bGuQbCJqzSWR/P9KHK12m51X+pkq64dpNQ+veH3h4CY=;
        b=zaX7How2U8dwnqZqlff8nXw+tG+VrplX62ZDthCUX2SEPFGTy68UGf9N6/haXHAcXd
         GGhKgLJ8Tgqx3FmFmVXdL/MNbN8l0fCiuEfoGO8x1fg3Jtw2P1X1hHDIA8QXAcEXcMAx
         YlfEWZYE7d3ca4U++boB9dehyowHtrpbbhhtCpFF3DTdTRmF+Qpsa6nU7XBkelTepKZt
         gAQRTB+uS0XcYg2ZU2TGYlYTgP1Ijh8YS61PBxMuFDh7/LDrY6mfQGtsLREVuuOrY3lQ
         CCNLztW+/0sYRR45nmIwU5EH8xSjhrK/Rp4VqZNYYMxxv6nBsz3CaaU+3cfUyD0g+LYy
         QVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283506; x=1730888306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGuQbCJqzSWR/P9KHK12m51X+pkq64dpNQ+veH3h4CY=;
        b=GdqY6pwLSBrlZQLE5bQv6Vr0ky+hQD60Z//tq2pf3JH9mLRV1nqifZJt/32k3L/4ds
         w0fdRJG++45gKE+HQv2SkCPEMN1woGQImGVd9DTI8qBgcgryR/G97vzr9NnnHYZ1hxXg
         975TzJeZwMu6zaNXNRaxIdnH30NJw58MmmZeF7FU5oWnKihpFyQ2RWXKkYb8M5WFaHC1
         tklidPZ1ZCtsCH3nnHiXW3CFuA6S9aMd35zJidNOujCi7pd1Co66UMG3ESr+Io2kv0zu
         +uAsM1LU8s+vHW/GKWNsKbFs+KandDTTLB/k0RKBEC/ZxKXoIhUCC+iHoUXNCCA3Nuoh
         BB/A==
X-Gm-Message-State: AOJu0YzDn4/0DE7mJZO/+RWlIeI/JTn5NUovRyU8Zq8TWXt/tZmMBYJr
	njdo0Cm3rFdRxqYnHMeQIlaICyLOjPZXgxXv/lAeVfScRYXQToQ+wdv45hq0KZYykeCtBQ==
X-Google-Smtp-Source: AGHT+IHtlhBLo3bbEhs1wF7v+cIpaCJgFs3yINNS6BC1NQanIJtbkye+dpCYL0tYjl6tOSWNY4FY4k9o
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:3297:b0:e2e:2e79:207c with SMTP id
 3f1490d57ef6-e3087728d56mr13735276.0.1730283506265; Wed, 30 Oct 2024 03:18:26
 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2684; i=ardb@kernel.org;
 h=from:subject; bh=nOLFU4fVeqjBBVbYqOn8j3eNn//s20k3b7v6vSDc/tE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/c7HrMULbjVuyex5a9d5ZUr4lSvt+iHzp0+cMWeP8
 Ja1sakCHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi/+cw/LPs268tdWH/guai
 PT6aD5hNrvE/EdHRPiJ7appPyjJT3zuMDH8MJxotVSoPZu6fd76/vWDlnQq5XJ6HH1o+Xto7YVH AEgYA
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-10-ardb+git@google.com>
Subject: [RFC PATCH 0/8] arm64: Simplify VA space configurations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

For historical reasons, we currently support many combinations of page
size and virtual address space size:
- the original arm64 port used only 3 levels of paging (4k/39 bits), and
  the 4 level configuration was only added later
- LVA support on 64k pages could not be disabled at boot, and so it was
  added as a completely separate configuration, even though the number
  of translation levels is the same
- 16k pages gains only 1 bit of VA space when going from 3 to 4 levels
  of translation, and so both are supported
- 16k/36 bits is supported under CONFIG_EXPERT, but 36 bits is a bit on
  the small side for the kernel.

Let's simplify this, by
- removing the configurations that are also the fallbacks on LPA/LPA2
  capable hardware,
- converting 36, 42 and 39 bit configurations into reduced definitions
  of TASK_SIZE, while keeping the larger VA space on the kernel side,
- dropping 16k/48 bits altogether.

The remaining configurations always support up to 52-bit virtual
addressing on the kernel side, and implement the reduced userland VA
space sizes by skipping levels when programming TTBR0_EL1. This is a
quick and dirty hack, but sufficient for the purposes of this RFC.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kees Cook <keescook@chromium.org>

Ard Biesheuvel (8):
  arm64/Kconfig: force ARM64_PAN=y when enabling TTBR0 sw PAN
  arm64/Kconfig: fix ARCH_MMAP_RND_BITS_MAX for 52-bit virtual
    addressing
  arm64/Kconfig: eliminate 64k/48-bit VA combination
  arm64/Kconfig: eliminate 4k/48-bit VA combination
  arm64/Kconfig: Drop support for 47-bit virtual addressing
  arm64/Kconfig: Drop support for 48-bit virtual addressing
  arm64/mm: Use reduced VA sizes (36/39/42 bits) only for user space
  arm64/mm: Account for reduced VA sizes in T0SZ and skip the levels

 arch/arm64/Kconfig                     | 89 ++++++++------------
 arch/arm64/include/asm/assembler.h     |  2 +-
 arch/arm64/include/asm/memory.h        |  4 -
 arch/arm64/include/asm/mmu_context.h   |  9 +-
 arch/arm64/include/asm/pgtable-hwdef.h |  2 -
 arch/arm64/include/asm/processor.h     |  6 +-
 arch/arm64/kernel/cpufeature.c         |  2 -
 arch/arm64/kernel/head.S               |  4 -
 arch/arm64/mm/init.c                   |  4 +-
 arch/arm64/mm/pgd.c                    |  9 +-
 arch/arm64/mm/proc.S                   |  2 -
 11 files changed, 52 insertions(+), 81 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


