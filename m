Return-Path: <linux-kernel+bounces-510428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1025AA31CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425D0188B289
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0E1E9915;
	Wed, 12 Feb 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZxpavU03"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED91DA60F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330523; cv=none; b=BfCrnAH8VLRoSpNGl+uHGVmKrCD4ZpC0dulpMOQpmVZTCfDUxyrszPyAPpuuqU3PgYysyQQt1gao+DcLaVkSeZk4eLT9l1doP/9Qgz5o09UyiImM85NOzZne4QU4zn3VPSKSUvZqExNSkln/dlyYWWujHLdGWoZJ9rIrGnEUVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330523; c=relaxed/simple;
	bh=rbKCgrhSnltAq4HphfqxDQL2WDHmk7Ibm7vobAi6Ezk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXboqkF8BacApswKnH3PjdUgXuojx7uViDqYU/aMhJS94lObLtEiogadKADd1FYzMk06TE3+mznI+qzGLx8WTDudaeLpcrgNh11YBP1BKiRdqUrie2o2+4wzGtsViq8Vx7kzsQCjTASdT5JUCpbt9J6c4kvfJKdUQJsb4deqLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZxpavU03; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa1c3ac70cso1387782a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330521; x=1739935321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7pPl+80co4+z7JP7yvzolDYDYVYpoOhsDUrxcZkGCI=;
        b=ZxpavU03xFkpCelm5FYcB82bogOeN93OZfk0WyvdJHXoBuBCLZcjLWeCKYOquRgSQ2
         Gzn45gr/KMF1DbDg2DSJIFeFHITzgy4KFc4zq7Ta2rPlOTkNPrdjXRSKI7zK3Jvl2KgN
         l9UM4N3k9cQ7wWtg86ODmAvy8RmOWO65QKhFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330521; x=1739935321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7pPl+80co4+z7JP7yvzolDYDYVYpoOhsDUrxcZkGCI=;
        b=s5R/5557pAhHKa23hqv1ClSAxiYOTutm0OZJ8mv7wwUMK72gyHjaxPqfSOtg+Ggi7C
         Lv56CY/q0M3zFfcs9MSx1EWHgmd9f+p6cdpmGfzu6lAKFB90ByIHyBjOm25RqTR0bhqG
         +aJoXv8mpNqnFKBgCa0oLUqqJ8dMforf4Trp2PIZlI1mO4E1t9aqWArUYa3fdnSlM7c2
         v1208MCFchKsnWVQg4qBXZs+RijRu+3ExIkE49+dJPEqaOzLu8C6e5JDfZkTGrwaVfOw
         RS+ETwVH7QPjTTj1O0x0Mp3PGDeopBOhtWpoGhUFxW8kt1oCILxn7wLw3FdxiaPTrAgb
         Mhjg==
X-Gm-Message-State: AOJu0YzwCc01mFT2waSuvp9kglHG29RzOE+Vhc381QBeCwZ8/Gz8OEUW
	HAthWTpyO16j6fVgSnrC7M0B9qMNn6rJYZHGuH8D+3AC6PbKozoQYe7twJ1bmg==
X-Gm-Gg: ASbGncuE6IMBLswa9ig/S7T4oiw/hRRStrXsGufspXq9NZjS/7rhndsxFPk5st+JVNw
	r5zLIEBULJcmzfwWXCBeD2uKUplqNIBBAQvgMePBLl309DG6hA2O+no3hbNzGwqS8elDs6sURB4
	rPOajXNMCMP/Gunitq3qxBBgJYb1ESoJOlaDgEaCDr3wN/f2YPDTcvgcgnytzDqzYGiyMb8mV0B
	co3KrOGZm3Sk/lr0gJT86hCKedhbJ+6jnLBjYacPUaXlavLK6WJu1M4U4MAtGCMQE9qP0aAGDPZ
	vH3OP/N3t2XcOlveysh5cfigoT08ck11HSlh1MX69SkT1I9DMg==
X-Google-Smtp-Source: AGHT+IEQjI3mXwIsERllpCdgEEkG55fGZ2UKV6IZsw6M1hblfR3OjmOt9QtTdXsaFePhUPJi1BBTqA==
X-Received: by 2002:a05:6a00:ac06:b0:725:46cc:719a with SMTP id d2e1a72fcca58-7322c3780fdmr864380b3a.1.1739330520652;
        Tue, 11 Feb 2025 19:22:00 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7309569d6efsm4018014b3a.92.2025.02.11.19.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:22:00 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v5 4/7] mseal, system mappings: enable arm64
Date: Wed, 12 Feb 2025 03:21:52 +0000
Message-ID: <20250212032155.1276806-5-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
the vdso, vvar, and compat-mode vectors and sigpage mappings.

Production release testing passes on Android and Chrome OS.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/vdso.c | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..39202aa9a5af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5b713b..cfe2f5b344c4 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/userprocess.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
@@ -183,6 +184,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 {
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	unsigned long gp_flags = 0;
+	unsigned long vm_flags;
 	void *ret;
 
 	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
@@ -197,8 +199,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_PFNMAP;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
+				       vm_flags,
 				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -208,9 +212,10 @@ static int __setup_additional_pages(enum vdso_abi abi,
 
 	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso = (void *)vdso_base;
+	vm_flags = VM_READ|VM_EXEC|gp_flags|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
-				       VM_READ|VM_EXEC|gp_flags|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vm_flags,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -326,6 +331,7 @@ arch_initcall(aarch32_alloc_vdso_pages);
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
+	unsigned long vm_flags;
 
 	if (!IS_ENABLED(CONFIG_KUSER_HELPERS))
 		return 0;
@@ -334,9 +340,10 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	 * Avoid VM_MAYWRITE for compatibility with arch/arm/, where it's
 	 * not safe to CoW the page containing the CPU exception vectors.
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
-				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYEXEC,
+				       vm_flags,
 				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
 
 	return PTR_ERR_OR_ZERO(ret);
@@ -345,6 +352,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
+	unsigned long vm_flags;
 	void *ret;
 
 	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
@@ -357,9 +365,10 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	 * VM_MAYWRITE is required to allow gdb to Copy-on-Write and
 	 * set breakpoints.
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC,
+				       vm_flags,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
-- 
2.48.1.502.g6dc24dfdaf-goog


