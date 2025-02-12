Return-Path: <linux-kernel+bounces-510427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D5A31CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5331616837F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C741E7C07;
	Wed, 12 Feb 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DvKsIggC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE551DB933
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330522; cv=none; b=OzL1QEehq53asuyGc5tWPO1RuEYHBZcORUAPL4QuTlxOlwrRMrQd6JUPfWNnzULP5kTjYnnHNBs94rvD9tfKGKskJTayQspR+FMr8pJz979C4sVJNbrwVPR0TLDmayQLGTUKGK6NUDhfa13osSPNTCF+KoH7bH5FqF9v3mMMIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330522; c=relaxed/simple;
	bh=l7hq5FUIDAkHBVw6OKr53T6zReeP1iwdJbypvd6CNes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjWyTjJigMig03oBII/gNicmJIm9Im/liLxEo1p7clgNufHoqolFJMbx8z4r0oLgKIAEU7mY+rKI8dHxu7e7WW2HgVCx+fCCHt8hfeXmtJ6GPDQZ2CR3EAGscmh3YZBcgwVpDVTaZfsTWy9NmwsAH8vyQYEj72zmu//EwcsIcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DvKsIggC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f6fb68502so7469875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330520; x=1739935320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF+XsAOZtoeX6mlWsDERSJyrasHSdBo5DRJV2HHqSDI=;
        b=DvKsIggCl4elQjG5VJYQlLuE59jue/Pr6e8h4fPvq5X1W+UcbT91teA1Dkr8QjZXVN
         D8KAGlfnSnQOIPNkAqvolth3KVcMybise8IgMIksvXSAIIZ9Hh24jPluiIug3j51im6B
         NHfvMrFYfYu7d81+w8evXpprkxvHPbzujRa+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330520; x=1739935320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF+XsAOZtoeX6mlWsDERSJyrasHSdBo5DRJV2HHqSDI=;
        b=QTpfA4I3Ssspvj5ijVj3Mqtvg6e7uzOz+obpB09PjFxHJ1w9o9k+w1/UWmgOsZMibG
         xO4Y1TtoDabxPvsACvhz1577ZbLDn2PF+hlD36YIikPCQigyOyOhbF2JwpGuHJUUlzT0
         mtR+FEA+J9NlD5CRqEyFekyKZTDNZ7Y2cR+xjoW66xDy2hXZ+vEsOk2vNgMkY3TO4U1d
         uKPyu8XI/w6/kQkQSx7HN6x8PHOPPNFxtuqI6dQUpZ7tPy0r54lhweLp4BTSkKvSSwIN
         e54eJLdrwq3lxFVD4mNej0BC5LgAZajEbBZBZ70t7FQTEg2UBXJZfXThE4CENcU4R6I5
         x74Q==
X-Gm-Message-State: AOJu0YxTzMdUT4B0aZ4NE3d8DYIUo7E77Syl0pEquxUta8LZ3zdkop2/
	U4AL3+LaoaNDbCCnH38noO5IIUVBTomche04a1W88nQ7+F5TF9BGhEt44BYsQA==
X-Gm-Gg: ASbGncvDsfmq7avXnsvvNaVht5kIbzgYmVLldKfyngcpdg4xEUkmuSw2lfUvpdFmhQz
	j0c2RcA/ceijOyAOTeFETK410YQnww6L8QOUZwr6zl/wlDxjrMIvr/jqyEnuek8l55sZiNLipkT
	qdNaAqosenjvsBYgChS7OlDfnbeGbPsiRoDN+KhTXxXFiz3chcV/h5uwTo2nfatlRL/WkszuJna
	bPMw6dccziyK01L77S+ATJKoj0BWaDozkbMZn4NLZkDXe5i60xNDPE2Fsiua7e/1PL48PayxbBm
	DDFTxp16rVVhcHWiO/A7e8H0ZbbKBzcuYmw8oJJ9tVx1VmVg1Q==
X-Google-Smtp-Source: AGHT+IHHM7M1gkeTK0DkmrzJae9kr1fBnAHXJ9XN96tPbv9kYILCpzpkfCEUqgGotDXyfntPOksCow==
X-Received: by 2002:a17:902:f68f:b0:21f:207:bd88 with SMTP id d9443c01a7336-220bbf0220fmr10761195ad.3.1739330519734;
        Tue, 11 Feb 2025 19:21:59 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683db25sm102503155ad.134.2025.02.11.19.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:21:59 -0800 (PST)
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
Subject: [RFC PATCH v5 3/7] mseal, system mappings: enable x86-64
Date: Wed, 12 Feb 2025 03:21:51 +0000
Message-ID: <20250212032155.1276806-4-jeffxu@google.com>
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

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
covering the vdso, vvar, vvar_vclock.

Production release testing passes on Android and Chrome OS.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 arch/x86/Kconfig          |  1 +
 arch/x86/entry/vdso/vma.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f..8fa17032ca46 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,6 +26,7 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc1a9ca..b5273dadd64a 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -13,6 +13,7 @@
 #include <linux/random.h>
 #include <linux/elf.h>
 #include <linux/cpu.h>
+#include <linux/userprocess.h>
 #include <linux/ptrace.h>
 #include <linux/time_namespace.h>
 
@@ -247,6 +248,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long text_start;
+	unsigned long vm_flags;
 	int ret = 0;
 
 	if (mmap_write_lock_killable(mm))
@@ -264,11 +266,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	vma = _install_special_mapping(mm,
 				       text_start,
 				       image->size,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vm_flags,
 				       &vdso_mapping);
 
 	if (IS_ERR(vma)) {
@@ -276,11 +279,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
+	vm_flags |= mseal_system_mappings();
 	vma = _install_special_mapping(mm,
 				       addr,
 				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       vm_flags,
 				       &vvar_mapping);
 
 	if (IS_ERR(vma)) {
@@ -289,11 +293,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
+	vm_flags |= mseal_system_mappings();
 	vma = _install_special_mapping(mm,
 				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       vm_flags,
 				       &vvar_vclock_mapping);
 
 	if (IS_ERR(vma)) {
-- 
2.48.1.502.g6dc24dfdaf-goog


