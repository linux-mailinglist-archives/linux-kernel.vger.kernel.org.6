Return-Path: <linux-kernel+bounces-254708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083993369E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAB91F2273E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E335125DB;
	Wed, 17 Jul 2024 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mVjLtzqw"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52B156E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196341; cv=none; b=T+kBrL9rgHv3Mfz5fiY0mZjdmXCVE9Rc9KGl52cdywe4vcncI2RC7Qk5Hod/D+aMI7XtH/Hy3DPkC/RlcTgL2HJmtICJT9+rRGh+Y90ceIwnUj3hIHDS4/x+uH0wiJYz2WwUufQGqa/ziyNTNBLVNXXHtUKsh21t3Z5na88UaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196341; c=relaxed/simple;
	bh=pNd9EqGFksnIK/7GkzVmDm9ZBVm1ziejUj+6/dwC34s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZBChMzpZ6J01tVaWbLPICkntH/AMjU/xA7NjUHTGsi8w/ViXHJKwEXytGaqeLxtlM7OJNb5Lwz8/mOGB2RCTD5nerdYrBVayRGPTcd0GBGJY+/l6IOW+wYulw4jPrLndl0n2VLAOVKNaOnRJ+0wKAxmmD2tNal7AimYi0wxnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mVjLtzqw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3678f36f154so3812087f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721196338; x=1721801138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQT7T4D4OYiXP5aLvX/ZPT3Ko40XHhQXHQMq6Si+lCQ=;
        b=mVjLtzqwBcKahv1weN+BXuxMqlmeno2SjfHSADpGN4d3oZ35yhE6uUOKOWekkKzGtR
         W78xBD41x3aNX3For33cIXtsg6Ggeczld4Jwf1ZXyYz9MXoCSLNPFe/3N/HlX9M+AaJR
         acIbEwYtFOjZTjDkwTG71E94PjUuq8tnaA6tEost4gS3dr9V4yrG8iYWfGfe61jEBsIn
         f3ZWd5Vs9wxSuZ9KqTAv3RsQV4RnFaMvfZK7s+AoYXR9Ay9nqnC/aiYi6LkNknwtG8z/
         Myyf89CS3A0SEzCBOt5jCQeEXh3KYlkXm5mSE2m/Fq/UVyLyaPDUFxPsQ5gzO3ZJx2Iv
         pklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721196338; x=1721801138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQT7T4D4OYiXP5aLvX/ZPT3Ko40XHhQXHQMq6Si+lCQ=;
        b=qILTqzTUS/IeSRoWOnU5M24vUXvbSvlDnJqyEUZGNSPYvUiaAy2ydVD/RW7AhGrzl2
         dFpijgubvBS/o3A2nDhp0/9pnXKMTNDg7ga62QYJ/OkL9EhFgiHVf0/KkBr3mtiDtmVG
         9I8RD6xnmuCLpgzasdxAmDG2ZZb1zOGi7yeZO1P94F3Jc4lMCAea+7LTHibQD3R+oAUj
         AUe8m+HHWJdNCz8swy4i3bQvPhWWe2pi0diN/bFDrHr3aVcECV6P3/Qdk9juw6qi9UNV
         WbPMOc2EiLbPJGaSSzaHZzIpF719hWCsJ+Mz5L6TcJyonWbfjppZuhjMW5lld5+6Bm5Z
         mXdg==
X-Forwarded-Encrypted: i=1; AJvYcCWFdw+352qD5G6V+FxfaUnTDCTBAuAB3ekesbr2SBcofzRdmE6GpNv6nzcFQYeFNOs3O+ZGr+lI0enlPROYjnwGLa6wInx+eJ0w8JzX
X-Gm-Message-State: AOJu0Yx3mVbVMDVsbivgo+MgYcehvya7+YFGtw5xtJKgOsZSh6d3IqfV
	cfDVn2OWqQa6a0JHaeZszRoB58QIzEc86Qs0oXMtmDJ0/+ER1rugAJYqktXr2gQ=
X-Google-Smtp-Source: AGHT+IEQqqsHVBQzuLlWNCNqvz+HzbR2Qu8oxbxrJwmk7GCmEw2/2fyCAGSldEtDwshPiZQG+MKGzw==
X-Received: by 2002:a5d:624b:0:b0:365:8547:90b1 with SMTP id ffacd0b85a97d-36831657d1amr462626f8f.39.1721196338221;
        Tue, 16 Jul 2024 23:05:38 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3cc6sm10834293f8f.11.2024.07.16.23.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:05:37 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 4/4] riscv: Stop emitting preventive sfence.vma for new userspace mappings with Svvptc
Date: Wed, 17 Jul 2024 08:01:25 +0200
Message-Id: <20240717060125.139416-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717060125.139416-1-alexghiti@rivosinc.com>
References: <20240717060125.139416-1-alexghiti@rivosinc.com>
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
index aad8b8ca51f1..4ed85329317d 100644
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
+svvptc:;
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


