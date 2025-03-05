Return-Path: <linux-kernel+bounces-545962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81001A4F48F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89B53A9C03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AA18FC9F;
	Wed,  5 Mar 2025 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1TBFy6f"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612A189B9D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141049; cv=none; b=m190Tqkhqz/FTuSUSlZt76fRiNRItinlIMC0k6ZpRdJGfPMRyAgOWLMc5o3HsIYtfqTkt2jEB4vfiloxRxHko1hx3OXKChbgMZYTQkDMH2zslX+LrxiIVbcHw83azvfKQqftMELgpv4clTrCZzvwJGfUzFIEf5chpIFPDIe/yjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141049; c=relaxed/simple;
	bh=ZAnJcNAE0RBecudUUh8uu90jecNEuyMqoLyI4jqjchU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ45xb2ajTTT7IQNHEgE9kR2R+5G5XjjQEoBd4VsKM1iFvRRMV3RNOK1x28+VcT312DoT1Ce7ju/JbH1N4IWuroj5UT/dTEYdfK1T7Rh6XEgMjEuWlqtKEY5ELFVYzoI8ASBZqHEykgpaIS0Dcqt5ulDxVLSBDc4NvOPXMHEzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X1TBFy6f; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so974367a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141046; x=1741745846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAD8cO652vqhuw2yI/B0NaFEiQTnRzt1qnI3Rgts5M4=;
        b=X1TBFy6fyOIykD4hhqQObvcmUdGxA77ViAdfT3UQK8Laiceh9ngOpbBE5xSJEzZ2Vj
         6ScPU9eime5XGq0LeuPbm5aE01MatSd0Gr8Qup3+BX/0HhE7GyVk1NFUjKPgFJ8d6TC5
         wdWxxQbEAQj3gLNFSnllWYprrFpjVN6dXRyeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141046; x=1741745846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAD8cO652vqhuw2yI/B0NaFEiQTnRzt1qnI3Rgts5M4=;
        b=J2W/tMRsG2dvHgQ9x0aSbmpuFCfRZyM2w3HQpfjdOoE8dy0R4eF4o9kNGNfDEREonK
         KZHqWPqSCx8MRXbtrERLgOw1DL2TSbE61S+ATd2KO4aUFhYvqWlQ4bQKIoLUNR40fmhI
         lf5W2kICv4Es4ErxF6LZKX5PAZgxBGNAnM2jz2L5tyVN8PYqUTPqrWGg9c8SPRhh/kUy
         R2I8AnjG+Pt941mUZePKvKyP3AnaJ3rpNnj8+IAzHxzFBEpIdEHTHc6zcakRmQuxA6Ij
         YnAlk6t/vAbP1QEU+T/pqrxyHrgGQHpZSvCbHNszLnvaVQvbZiP6o6t6vxJCRpyW7/Jy
         qGVA==
X-Gm-Message-State: AOJu0Yzqs0phcbp8xGy5bMDj94A1DbH5ans8ET5GUtyruYSdTbv+zyF4
	bk9Tw9/u+v9XXr2zmTrhlPF32QX1SkZSeSwwDXlHWIdTPEG3fqYwNCCcSioitA==
X-Gm-Gg: ASbGncvig4DDnprUtq7LQtEdvk/ZfPIBKNsCpvuM6MeNTK9RvPQwKxvPiL2j8AAS8je
	zqF1GzgSDJ8DaZhcV4Q4mzcbi2dgiQsHuY1Pj8Mr36AuZbiQT3x12ARKJ0UOcN6N95c3SAF6xfn
	GTionA+J/QhOXV6mkpjJFxB0Eo8Ah8HbtNuywE2adqzPidCjppiTBXRsoiyolqsNZ0uwb3U6YCO
	GwJXYkmufPFA9kcfInm8qE2g4yDVMkE7gN2BbO/GT3UhBdn2MZ0XAWoUO6Iauo7d8s+rE8ZPOXE
	Su2gKiflbGSGN+pZAQodd0EJlB5rgbLCD/J4/DekRM/AsXp+KoJk75ExVIX/9Oy0cmU4VMNtdD/
	A
X-Google-Smtp-Source: AGHT+IG5pY9ZWt/x42cTmKktAWQXU77r3g1NJ93PY1cEg+ZgzNoMnGCHYfwW1EvcG+ghtIB8aggB5g==
X-Received: by 2002:a05:6402:5214:b0:5e0:e335:2f08 with SMTP id 4fb4d7f45d1cf-5e59f38b512mr484401a12.2.1741141046235;
        Tue, 04 Mar 2025 18:17:26 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:25 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
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
	Jeff Xu <jeffxu@chromium.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v9 4/7] mseal sysmap: enable arm64
Date: Wed,  5 Mar 2025 02:17:08 +0000
Message-ID: <20250305021711.3867874-5-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
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
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/vdso.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..282d6cb13cfb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5b713b..69d2b5ceb092 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -198,7 +198,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	}
 
 	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
+				       VM_READ|VM_MAYREAD|VM_PFNMAP|
+				       VM_SEALED_SYSMAP,
 				       &vvar_map);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -210,7 +211,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				       VM_SEALED_SYSMAP,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -336,7 +338,8 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
 				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYEXEC,
+				       VM_MAYREAD | VM_MAYEXEC |
+				       VM_SEALED_SYSMAP,
 				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
 
 	return PTR_ERR_OR_ZERO(ret);
@@ -359,7 +362,8 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC,
+				       VM_MAYWRITE | VM_MAYEXEC |
+				       VM_SEALED_SYSMAP,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
-- 
2.48.1.711.g2feabab25a-goog


