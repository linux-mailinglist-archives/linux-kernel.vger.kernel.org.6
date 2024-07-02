Return-Path: <linux-kernel+bounces-237456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACB9238F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B64B2225D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3641F14F9FD;
	Tue,  2 Jul 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bxOoCfWm"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1C14E2C2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910502; cv=none; b=OY5ww0mZmX286VEy2CnUdGhciIAoh33B3vrODAbY9CgFsO6YM1ivDPgyDpzfUKaGNjf0oN5T5523XSJZOV8egAFf+/p1Z+zsutY/cJiYLX6Rs6a8V/mCgFGrnwWIB8ydcQ6SJA62KgMepCmAebSZwTu15x6SoKJbmCdY7TLQ9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910502; c=relaxed/simple;
	bh=NtT6gw2gmAZGxUgPXoRr7YQ72rpYmMN4iv8VIrPB2ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCu1O+PJE9b+Bn3Cy4Tv+ZdgFtYhEQIcqsGo6V9CblnEc5VQ006kPxTNVfATUj/Er4ZRE9zqjsT6Y8HqqW++fvLvJ7BhosdJHHRUllhwoRDdSlEVOZwOk3ay4SI9hO6cxQQ46nm74iv92oWCwegNG9eSgutrPcZddHlbzTeLNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bxOoCfWm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42138eadf64so27971625e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719910499; x=1720515299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIThDSMu0YHhK3Il5EBAYEpaIGUwsTH7rJyBDsaK5V0=;
        b=bxOoCfWmURyNxZKknkb/djDDT4TqbS+D9+htykOa3H8ywGWqYOAQN/nlBvaQqUIKWR
         1DgbCw6g+i5a4V//V1+NBP7oK6HzNSYX2ZX32FL0Mn5IHp3EcW7fKI2qNdZrTLLTJaVr
         JjatIopwCFx8zz2dUIanoMUmYx3tnrBBFmuITrmWxFE+AIpe5hwkdcPjhGKpHkuekKPh
         fF+PsWNAdkkh4EVddU3vm2g3zZGXt2+NQX3bkr9zP+RDMH9rkxyt/95sRfnieIvKCXyc
         WvhkY96jXCBmRPiL+6hlpZiEA0iXdqtwjl0JcaJ0g10mcfzzsvz5NsOj/BSLKljI/Aim
         HAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719910499; x=1720515299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIThDSMu0YHhK3Il5EBAYEpaIGUwsTH7rJyBDsaK5V0=;
        b=WgI62b2jGI1HZv/0DruzXcVUBTWWmZZpQ2e+nZAuH9qUr5wGxhHAQ2OcummGR8/Y8M
         DUR5hygbuxFnZOosl/qXseBuICy3t4XkoYBjHllDYohFfWRizSZeb8VcUDSeo2lMJ6D7
         6/yn1lCIXyiPzlYu7uA23Njv7R5FPN3vQbIxBdn1p/AgNM0XTqk0SRFOT4pnCt6KZRHA
         pkmTo9bBw1FliG/9kCXjqxGPyrBkOalSFJsvgcdDp59yD8jLFbvy4awrafR2Mt+MYf9v
         rd7IbKThrevuJd5XinY/607aJbrUpHBJm53hN/PWpDVxEv5pnbHMgZ77yThkPQTU28wa
         D9fA==
X-Forwarded-Encrypted: i=1; AJvYcCUg8vlKBtKrffdZ53mqe+4xKr9nYAC/Mkcm+fHKHEXjnxrU0bSQVTKScz21UugGeLn69KPWOJDGvjSReDy+S+XlWkw0RBDGv/dt4iVy
X-Gm-Message-State: AOJu0YxgRQx1ECV0BBRM8GrsAvBLJZKsA5J2bUQUMUkHcMGp7i2TrLIb
	CaWGE5m6CvwMpy+4LjxYGkSI2oEU+k+7/8DFcjXh3SuWAlVT8VOfV3s+o/2qBHM=
X-Google-Smtp-Source: AGHT+IEDGO5lSYXzrNCtUPjdOzG/kBq6PyIV7c530qUlaMBb/cLWp/uOV4WEq8k/ROEiTkODEzbQXA==
X-Received: by 2002:a05:600c:2147:b0:425:6b8a:7013 with SMTP id 5b1f17b1804b1-4257a074a93mr50887735e9.35.1719910499045;
        Tue, 02 Jul 2024 01:54:59 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af552bbsm189623875e9.13.2024.07.02.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:54:58 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 4/4] riscv: Stop emitting preventive sfence.vma for new userspace mappings with Svvptc
Date: Tue,  2 Jul 2024 10:50:34 +0200
Message-Id: <20240702085034.48395-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702085034.48395-1-alexghiti@rivosinc.com>
References: <20240702085034.48395-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The preventive sfence.vma were emitted because new mappings must be made
visible to the page table walker but Svvptc guarantees that it will
happen within a bounded timeframe, so no need to sfence.vma for the uarchs
that implement this extension, we will then take gratuitous (but very
unlikely) page faults, similarly to x86 and arm64.

This allows to drastically reduce the number of sfence.vma emitted:

* Ubuntu boot to login:
Before: ~630k sfence.vma
After:  ~200k sfence.vma

* ltp - mmapstress01
Before: ~45k
After:  ~6.3k

* lmbench - lat_pagefault
Before: ~665k
After:   832 (!)

* lmbench - lat_mmap
Before: ~546k
After:   718 (!)

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 16 +++++++++++++++-
 arch/riscv/mm/pgtable.c          | 13 +++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index aad8b8ca51f1..816147e25ca9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -476,6 +476,9 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 		struct vm_area_struct *vma, unsigned long address,
 		pte_t *ptep, unsigned int nr)
 {
+	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
+		 : : : : svvptc);
+
 	/*
 	 * The kernel assumes that TLBs don't cache invalid entries, but
 	 * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
@@ -485,12 +488,23 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 	 */
 	while (nr--)
 		local_flush_tlb_page(address + nr * PAGE_SIZE);
+
+svvptc:
+	/*
+	 * Svvptc guarantees that the new valid pte will be visible within
+	 * a bounded timeframe, so when the uarch does not cache invalid
+	 * entries, we don't have to do anything.
+	 */
 }
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
-#define update_mmu_tlb update_mmu_cache
+static inline void update_mmu_tlb(struct vm_area_struct *vma,
+				  unsigned long address, pte_t *ptep)
+{
+	flush_tlb_range(vma, address, address + PAGE_SIZE);
+}
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 533ec9055fa0..4ae67324f992 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -9,6 +9,9 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
 {
+	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
+		 : : : : svvptc);
+
 	if (!pte_same(ptep_get(ptep), entry))
 		__set_pte_at(vma->vm_mm, ptep, entry);
 	/*
@@ -16,6 +19,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	 * the case that the PTE changed and the spurious fault case.
 	 */
 	return true;
+
+svvptc:
+	if (!pte_same(ptep_get(ptep), entry)) {
+		__set_pte_at(vma->vm_mm, ptep, entry);
+		/* Here only not svadu is impacted */
+		flush_tlb_page(vma, address);
+		return true;
+	}
+
+	return false;
 }
 
 int ptep_test_and_clear_young(struct vm_area_struct *vma,
-- 
2.39.2


