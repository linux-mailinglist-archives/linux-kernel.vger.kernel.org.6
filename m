Return-Path: <linux-kernel+bounces-393056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59189B9B6E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A091F21A50
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2084D3E;
	Sat,  2 Nov 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SBSydhBI"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E479184F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506131; cv=none; b=jjF4YsC7fK6Oep6OBsaSnJqzJyU8Bl9/CQVXhJSdQqJyNO3ER7+EO3zo0vcOYwkqNs6KxsvF+rHV0jASp839vHakfE8XgRI1f6lYgMSdfpNlLmv+0Ks3A/SFLb7TbufwZB17P8+R7UC5qMQNxyNMWNZplX37+GsAkaLGPyzzAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506131; c=relaxed/simple;
	bh=9SdpRQ4d5cKw4nVGXLEGccsaUZTbKYpWdgnvbD7MjsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqFodk/U0TJf5TODbzXCLnVyIONFTSdd2QennWdtjhvYxO3ZmKdqog9Fx4QEtIlEUTpJEFIRLZf2jdsAxpn0UmoMwNCgwOs1lHGImyicI9jZu5QuSqKTHAteEyAREK4Q+KPBfEz2Zjc8WqrEXlhZ9Tv/F/4fLu1DTNOKI68f6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SBSydhBI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1796427a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730506129; x=1731110929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lekxDnwARtrYdlJ1Ne7TEw2fH4iE05/E7poMDP757sA=;
        b=SBSydhBIQoWztap/Y7H73uM3tAcNeocg2QTbEucC99Jb7ILbHnXaRr5T4qzovZtXZa
         39uFjtKyjw4xDSZTUl4Q+tEXI1Ljgv1hSF0bf2ja9FQ7dCJpY3PIWS70ZVbpuZDh2/fw
         L3O/KpPiAXyDePUtSEaOPt+c0QbWsJwwH/d8ijXod9vb5GT2PIe2dn56RY0BC4m09CC9
         YTd3f7/6bHJEZ2NVlJKw64uCWfikH+02+bamDjJ0lM/i1VZt4kNDZLCBf+799KN/uT+f
         BqkkYMf8nj7K/UKgAgFD1g/EUrg9r0sUJV6vDlFRHI/jgckuOobep26JbmybVfMelFxS
         Jzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506129; x=1731110929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lekxDnwARtrYdlJ1Ne7TEw2fH4iE05/E7poMDP757sA=;
        b=WWj5ejOnqYGzgVNUHoiPzHVEg4x+4G1MQNbWj/TJiTOYrNpckaKRG8BveEEcc5L/+o
         bnpNeyTThzw2+fH/8teQmS6Gzm/5JChnKBijt1ef8FwzHoAK30gxuF0bvuhwaHBS2L/1
         gtVFplebxPnh0CNeaacxfR3ZiO2NUlcfhMIgDs2TZZ/huvnDf90eRA6vp5P7RK7MctsD
         7keSXScWRdeVO7Is2yfw0zngkBuIYo/j+OPyAO+r9o3RdYB3r+aOE+9KaXhy7xRc88NS
         cK8hCQDaoKEZk2RifBBNDaM8hMpLfg1fKH712gny7howmZre2SwAsN7h0kYEZh5h9N2K
         KTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo7WGWv1PNiPRSP0M/xOGomlBs1GNMV9bXsQxwZ6eCXNtX8N1HwMNjizTSsXjbQQNnKu5y4rKXousZZm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0syZO0YoC++gF2117SEJztYr5u/PpBC49BCWtKup9+uIANwxg
	Xn7QsP/OpTI8dkq2aDeEAph9LHGggmJjLG+Mv6zeX7Ag4pG/gk1tnfOM6vEt/1c=
X-Google-Smtp-Source: AGHT+IFIFmJ6HbS9Ca94WbQx+pPA5itCw4zhwiKe4XcgzfhIEgH9OEfG0R25JvEsk6agnHfgYMkYmA==
X-Received: by 2002:a17:90b:53c3:b0:2e2:d859:1603 with SMTP id 98e67ed59e1d1-2e93c1d39b0mr11018955a91.25.1730506128809;
        Fri, 01 Nov 2024 17:08:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fc00856sm5505749a91.54.2024.11.01.17.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:48 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 02/11] riscv: mm: Increment PFN in place when splitting mappings
Date: Fri,  1 Nov 2024 17:07:56 -0700
Message-ID: <20241102000843.1301099-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241102000843.1301099-1-samuel.holland@sifive.com>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code separates page table entry values into a PFN and a
pgprot_t before incrementing the PFN and combining the two parts using
pfn_pXX(). On some hardware with custom page table formats or memory
aliases, the pfn_pXX() functions need to transform the PTE value, so
these functions would need to apply the opposite transformation when
breaking apart the PTE value.

However, both transformations can be avoided by incrementing the PFN in
place, as done by pte_advance_pfn() and set_ptes().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/mm/pageattr.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 271d01a5ba4d..335060adc1a6 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -109,9 +109,8 @@ static int __split_linear_mapping_pmd(pud_t *pudp,
 			continue;
 
 		if (pmd_leaf(pmdp_get(pmdp))) {
+			pte_t pte = pmd_pte(pmdp_get(pmdp));
 			struct page *pte_page;
-			unsigned long pfn = _pmd_pfn(pmdp_get(pmdp));
-			pgprot_t prot = __pgprot(pmd_val(pmdp_get(pmdp)) & ~_PAGE_PFN_MASK);
 			pte_t *ptep_new;
 			int i;
 
@@ -121,7 +120,7 @@ static int __split_linear_mapping_pmd(pud_t *pudp,
 
 			ptep_new = (pte_t *)page_address(pte_page);
 			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
-				set_pte(ptep_new, pfn_pte(pfn + i, prot));
+				set_pte(ptep_new, pte_advance_pfn(pte, i));
 
 			smp_wmb();
 
@@ -149,9 +148,8 @@ static int __split_linear_mapping_pud(p4d_t *p4dp,
 			continue;
 
 		if (pud_leaf(pudp_get(pudp))) {
+			pmd_t pmd = __pmd(pud_val(pudp_get(pudp)));
 			struct page *pmd_page;
-			unsigned long pfn = _pud_pfn(pudp_get(pudp));
-			pgprot_t prot = __pgprot(pud_val(pudp_get(pudp)) & ~_PAGE_PFN_MASK);
 			pmd_t *pmdp_new;
 			int i;
 
@@ -162,7 +160,8 @@ static int __split_linear_mapping_pud(p4d_t *p4dp,
 			pmdp_new = (pmd_t *)page_address(pmd_page);
 			for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new)
 				set_pmd(pmdp_new,
-					pfn_pmd(pfn + ((i * PMD_SIZE) >> PAGE_SHIFT), prot));
+					__pmd(pmd_val(pmd) +
+					      (i << (PMD_SHIFT - PAGE_SHIFT + PFN_PTE_SHIFT))));
 
 			smp_wmb();
 
@@ -198,9 +197,8 @@ static int __split_linear_mapping_p4d(pgd_t *pgdp,
 			continue;
 
 		if (p4d_leaf(p4dp_get(p4dp))) {
+			pud_t pud = __pud(p4d_val(p4dp_get(p4dp)));
 			struct page *pud_page;
-			unsigned long pfn = _p4d_pfn(p4dp_get(p4dp));
-			pgprot_t prot = __pgprot(p4d_val(p4dp_get(p4dp)) & ~_PAGE_PFN_MASK);
 			pud_t *pudp_new;
 			int i;
 
@@ -215,7 +213,8 @@ static int __split_linear_mapping_p4d(pgd_t *pgdp,
 			pudp_new = (pud_t *)page_address(pud_page);
 			for (i = 0; i < PTRS_PER_PUD; ++i, ++pudp_new)
 				set_pud(pudp_new,
-					pfn_pud(pfn + ((i * PUD_SIZE) >> PAGE_SHIFT), prot));
+					__pud(pud_val(pud) +
+					      (i << (PUD_SHIFT - PAGE_SHIFT + PFN_PTE_SHIFT))));
 
 			/*
 			 * Make sure the pud filling is not reordered with the
-- 
2.45.1


