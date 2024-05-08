Return-Path: <linux-kernel+bounces-173759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E78C04F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C283285EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974A131184;
	Wed,  8 May 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Vf1rcuPT"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCC130E2B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196407; cv=none; b=LuxMH5iUOUimwiWDa7J15oOOXpsS+W7v+UI8iXUbq/MTJovZ1ru+KUVoJGkm/Y/u7/TmH1FHLAaQ3cHu5KxPFxmZrsqWcK2OgDEOtDmzp9g7hk9NcWKGgH2P7RPcLSOc/cya7LdB+cfBVRqp1ObEo0qVPwNAUf6VM+QkBdAav4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196407; c=relaxed/simple;
	bh=QAMm7iDD+RVBgL6xWmp2oKGGqUu8F8yMrpYtOKhCup4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngIDdABb2JEO/n0RyJDYiQTiqcoC+3yS08r3pOVrBzepQcM0+LQ+JSOpQLZbEYzLqDTaJsaKRSxahuj1ni1YgAef9wYsxGgGSrdUqD84kncPIrnYUNgkt7c+5U9p/Jw1EL7Mxp+XIXTNtox1hl37uwCkvQFdQh5mQAlJ2e/Mun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Vf1rcuPT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34d99ec52e1so25837f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196404; x=1715801204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NXxlYw1RM9+WdFNtDaqsh0kbg9AU8PQDaN/vzezo7A=;
        b=Vf1rcuPT6YthWxYLpMow8FQkLZ4hfLIwlRMMpix+rec3eLkd53bePAfi8LRrG9B54k
         /bBRyveG9AweqpHzqf3gQQ6psbw7JelZpsV0lfgYQ0sh5dPwyKOYhyb542mp0wkON2ya
         NL3Lv2uIv6rjX3YUWGgxVgUz1VoYk57cxQzmzVnQbpZrYWfZHLAz4BfTw7fhAZILZaa4
         n/aIVDlJ9oWhXwmVUTSDzxY5ZDbug/y+B8vaJPHVOPkA1lUQC+mdfd+sYsgIU+EzEgnh
         1o48/3cC91GTdsNKtcTGlhWjhy0D1sVAkfbbPBsBQLVIF6QHjjOp9FgnH34K8KpngZ7L
         iYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196404; x=1715801204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NXxlYw1RM9+WdFNtDaqsh0kbg9AU8PQDaN/vzezo7A=;
        b=F9jY/GjenuIXY6AUDFBsTY2Bdtw1+uXl6A+mBA+m5Cn86qDOb/FmFBUtxGNfObI0dx
         /YxB9yWtv9GmD0Vq+04MxmPfTbDWRsw6kD3ufU6owuvgOC57jSN+kGaUqIbHPJhsui7W
         jOZSijF24cjy8ElP3Hl+nizefKhAwUy66YyhUKfP5zgAP/JI0RT5u6yE8Z0esWHuLqxX
         97MkwfURALJUBC5I/a3sSbIE3ZobmGfJV8cFNvmNiYZjnCSmUGC31rugqOZd/XhY6gfd
         +gLJ3jGDAelZREMdk/ZC4dv8Q7JKmCZjZsOBAa7T2nFVy+QKe85zX/Q5rv4ZbzHDda7N
         LA4A==
X-Forwarded-Encrypted: i=1; AJvYcCVnrTgTItdqMe0zdL0RZcdkrzacLpBHyMo6dQTJQT+rWmWZYWe6ko/SkLqXO3ghares3NFYu9jtK6o6apG2mceCsLyLgIT+QaS5GpVI
X-Gm-Message-State: AOJu0Yxx2mzF4cCZNnJa+K6oSEcX3a3qOqMg4y2QE1MQFkGeZ0m0NiUK
	kdA2rlOFhnHNbrTyvbBWRe3w0DkvRpZFWo6f8VWp0zv+b3vJfAB+zstNaxbU22U=
X-Google-Smtp-Source: AGHT+IGACzzezThLxVMxwcYVQ6pqU/BhrbSjplAZdXD5UPpMsvfoJ1LwcNLet4jFhPFrbMRRJqyyWw==
X-Received: by 2002:a5d:4522:0:b0:34c:bb79:452b with SMTP id ffacd0b85a97d-34fca62159dmr2733749f8f.52.1715196403826;
        Wed, 08 May 2024 12:26:43 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id o16-20020adfcf10000000b0034b1bd76d30sm15921429wrj.28.2024.05.08.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:26:43 -0700 (PDT)
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
Subject: [PATCH 07/12] mm, riscv, arm64: Use common ptep_get_and_clear() function
Date: Wed,  8 May 2024 21:19:26 +0200
Message-Id: <20240508191931.46060-8-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508191931.46060-1-alexghiti@rivosinc.com>
References: <20240508191931.46060-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make riscv use the contpte aware ptep_get_and_clear() function from arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 8 ++------
 arch/riscv/include/asm/pgtable.h | 7 +++++--
 mm/contpte.c                     | 8 ++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 74e582f2884f..ff7fe1d9cabe 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1473,12 +1473,8 @@ static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				unsigned long addr, pte_t *ptep)
-{
-	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-	return __ptep_get_and_clear(mm, addr, ptep);
-}
+extern pte_t ptep_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 41534f4b8a6d..03cd640137ed 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -794,6 +794,9 @@ extern void set_pte(pte_t *ptep, pte_t pte);
 #define set_pte set_pte
 extern void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 #define pte_clear pte_clear
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+extern pte_t ptep_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep);
 
 #else /* CONFIG_THP_CONTPTE */
 
@@ -801,11 +804,11 @@ extern void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 #define set_ptes		__set_ptes
 #define set_pte			__set_pte
 #define pte_clear		__pte_clear
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define ptep_get_and_clear	__ptep_get_and_clear
 
 #endif /* CONFIG_THP_CONTPTE */
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-#define ptep_get_and_clear	__ptep_get_and_clear
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags	__ptep_set_access_flags
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
diff --git a/mm/contpte.c b/mm/contpte.c
index c9eff6426ca0..5bf939639233 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -46,6 +46,7 @@
  *   - ptep_get_lockless()
  *   - set_pte()
  *   - pte_clear()
+ *   - ptep_get_and_clear()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -682,4 +683,11 @@ void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
 	__pte_clear(mm, addr, ptep);
 }
+
+pte_t ptep_get_and_clear(struct mm_struct *mm,
+			 unsigned long addr, pte_t *ptep)
+{
+	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+	return __ptep_get_and_clear(mm, addr, ptep);
+}
 #endif /* CONFIG_THP_CONTPTE */
-- 
2.39.2


