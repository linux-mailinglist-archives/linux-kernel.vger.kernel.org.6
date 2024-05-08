Return-Path: <linux-kernel+bounces-173746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE58C04CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F2A1F227F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86C2130A4C;
	Wed,  8 May 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1/i2io5o"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A7130A43
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195976; cv=none; b=VGhoKt7Zp3hfktt+f+byynm/uFbGQJohB1cnkffXfeO8NQJVg4THX+T4gjeKAmBkTRcSLWUup7y1wIF8uHHV7hn89BzIrBKIbFEL6omMLQ/5FXiyyE1edM90h22l4D4nuFjgfbascKypPtSsupJyRsximkfrV7qFiKAoRvxg77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195976; c=relaxed/simple;
	bh=YIVNY41R8E3i0qyQzpYxu5vSIyMEkNoTli1SIL3s7xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B9YQmRc6eB7GMm9ekUa/tvk4wWcn93l42GQcLWLUZvNknduHpv5SAmgu9zjrr+mt1tVtjq+to+4d5hik3fv49wr17iJrn6GjgML5Dk3OL3fY6tEJsERzXVrmu/S9Kez+dToHaJqUYiubAMdzBugW5/YxGFAPGHQzFBIRo0y9Pls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1/i2io5o; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so1208361fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715195973; x=1715800773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1uKlYjMTe4xfHBkLhM4fwrAS4H0Wd2FQ2UyNN+YPgM=;
        b=1/i2io5o+yUAKNufrkNKnrlHRqEG7ucxRXgpH73zSfgZfkeMZg57mnB621KbEn7E9x
         LB12510yD8FiUHF+NU2xhSjYmUsksbihYzx49T5XdqR/M/9G5V4kHAlKwW5Nvu3nyX7H
         d+ttaO01uRO8Tm/DNxzWLYiFduch/OirW0ngKcpbTvYm4kHHdbLBQB1igrhdzp/+aJOd
         72j3FRE7xSsVS6sOkyGs7OYiXlH2dF5eQ8/5nylLlDLjjk3ZCtvMxgCLE5mFqEvk0jzr
         yjT6PCxfvGN6tUEjZma4DuEwtXYHEzk5AlFVNTBUUhSKOeOMkvHmn5HkQzumj9ef1g0t
         6tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715195973; x=1715800773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1uKlYjMTe4xfHBkLhM4fwrAS4H0Wd2FQ2UyNN+YPgM=;
        b=FeBmi66/JorgJh/U9DM4q576OTda3+5Kue/kNo1XgkeBg5clrIZtEEQbcQuVn9hE0M
         5RTMrm4ymE20mugwpPvw9ebRXMiHaaxWMMrxyVVn5WHYniPo89fa7u/RwiNz9uTkmvQU
         chmJ1jlefPdwSKiKjK9IwLOVH+AiESLMGVftEHAdQRsoBhmd50XvhDZ9NcqSPb/ETbaK
         VisevO5uz7/9Fo8rSG+hFZE5B4uReSBNyZLS9jPvKFGJjvXJh3EiJzcFrp+kZRJXvz/z
         rgAKpw0DmbSH3br2EViQm7Q6U0Cavm11Ji5XhAlIohjpSsojHK2aK4H09KxPYQsvWgyl
         C7wA==
X-Forwarded-Encrypted: i=1; AJvYcCWsm0L+rX1W0TNTQgmLgsb6m5wVCu7dtz4jfj/O89Kw8qh3Bf4F6fXb/SeHLd8M7AaaIeGeQsDeLs0RwKn2XxqYLC5HfGtUF14MKIaZ
X-Gm-Message-State: AOJu0Yx730tSETlTpOEuYNsN4hTvnsVKdAYPjfeYLeJ6mCyo9NBRC0AT
	BTwkdRrNT84cSSB7/ClT9Od9yIzwqt8MMILU8CKFuFldRkJh1N5rgqpUSZVr9AU=
X-Google-Smtp-Source: AGHT+IHeP5I15KzeyyHS9QyEylQJKB8BxwDLerdVkeWn4X1OoVdiknVfTODJicHq4kG+uWiKxO6g7A==
X-Received: by 2002:a2e:81a:0:b0:2e0:12f1:f827 with SMTP id 38308e7fff4ca-2e4479a2ca4mr23591601fa.43.1715195973157;
        Wed, 08 May 2024 12:19:33 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm32622515e9.29.2024.05.08.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:19:32 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 00/12] Make riscv use THP contpte support for arm64
Date: Wed,  8 May 2024 21:19:19 +0200
Message-Id: <20240508191931.46060-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows riscv to support napot (riscv equivalent to contpte) THPs by
moving arm64 contpte support into mm, the previous series [1] only merging
riscv and arm64 implementations of hugetlbfs contpte.

riscv contpte specification allows for different contpte sizes, although
only 64KB is supported for now. So in this patchset is implemented the
support of multiple contpte sizes, which introduces a few arch specific
helpers to determine what sizes are supported. Even though only one size
is supported on riscv, the implementation of the multi size support is to
show what it will look like when we support other sizes, and make sure
it does not regress arm64.

I tested arm64 using the cow kselftest and a kernel build with 4KB base
page size and 64KB contpte. riscv was tested with the same tests on *all*
contpte sizes that fit in the last page table level (support for PMD sizes
is not present here). Both arch were only tested on qemu.

Alexandre Ghiti (12):
  mm, arm64: Rename ARM64_CONTPTE to THP_CONTPTE
  mm, riscv, arm64: Use common ptep_get() function
  mm, riscv, arm64: Use common set_ptes() function
  mm, riscv, arm64: Use common ptep_get_lockless() function
  mm, riscv, arm64: Use common set_pte() function
  mm, riscv, arm64: Use common pte_clear() function
  mm, riscv, arm64: Use common ptep_get_and_clear() function
  mm, riscv, arm64: Use common ptep_test_and_clear_young() function
  mm, riscv, arm64: Use common ptep_clear_flush_young() function
  mm, riscv, arm64: Use common ptep_set_access_flags() function
  mm, riscv, arm64: Use common ptep_set_wrprotect()/wrprotect_ptes()
    functions
  mm, riscv, arm64: Use common
    get_and_clear_full_ptes()/clear_full_ptes() functions

 arch/arm64/Kconfig               |   9 -
 arch/arm64/include/asm/pgtable.h | 318 +++++---------
 arch/arm64/mm/Makefile           |   1 -
 arch/arm64/mm/contpte.c          | 408 ------------------
 arch/arm64/mm/hugetlbpage.c      |   6 +-
 arch/arm64/mm/mmu.c              |   2 +-
 arch/riscv/include/asm/kfence.h  |   4 +-
 arch/riscv/include/asm/pgtable.h | 206 +++++++++-
 arch/riscv/kernel/efi.c          |   4 +-
 arch/riscv/kernel/hibernate.c    |   2 +-
 arch/riscv/kvm/mmu.c             |  26 +-
 arch/riscv/mm/fault.c            |   2 +-
 arch/riscv/mm/init.c             |   4 +-
 arch/riscv/mm/kasan_init.c       |  16 +-
 arch/riscv/mm/pageattr.c         |   8 +-
 arch/riscv/mm/pgtable.c          |   6 +-
 include/linux/contpte.h          |  37 ++
 mm/Kconfig                       |   9 +
 mm/contpte.c                     | 685 ++++++++++++++++++++++++++++++-
 19 files changed, 1056 insertions(+), 697 deletions(-)
 delete mode 100644 arch/arm64/mm/contpte.c
 create mode 100644 include/linux/contpte.h

-- 
2.39.2


