Return-Path: <linux-kernel+bounces-545961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B1A4F48E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4316FBC4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC316CD1D;
	Wed,  5 Mar 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X0uEI65v"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E7166F06
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141048; cv=none; b=tGvp4N76oMzSwjNaXrf8Xm79qnhU1WSVE6wx2JBfPxQdjtmt9KNWxlSplHA5nG3AEiiVrFfv8+bF1qCDvAUiMJZ4QCxmJaBYwRgu/CKaiXE+r2vVafVW5Pvx/WtIK6ubspT062s0zCFls05p92sM+a5wYA4UQ31Jg6AWTsgdcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141048; c=relaxed/simple;
	bh=17TYpxsHR2yIAUNCly1/RHbcZ1y0Qmn1Aow5fCa+oLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI8FMeaBJmiDAf5LFnRzgc6jzCB8EdDt6FedrCTRgLogz1lSR4hdfHfmU53R4tBw6/5pdRSg/W7X3IhOs98y/Mvh5lCu0K4YfBYBhvmEJCe3BDh2gBhGqsz9fboLE4gmFuzNcJ47gVNtiZkjcF8oO5mMl784ISvYHj/vGksahH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X0uEI65v; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so762378a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141045; x=1741745845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIfu2VJ/9GSAopmZ9uLbsgWzSODFEibXXKBGhDuMgAs=;
        b=X0uEI65vxKi6/sN6/K1Jo/7KTgwTwiHKW02dg+LVhAlua+78z35J5a8Imf82mdutkA
         U38Ery4joem8RDm0zOF/KTq6zwmucLEzp5RzzdwPhkgITzCXN1EOJat+5Fi9lz4DbFJM
         DAuVZgHilxTCljYoO/ezA86ElLA0Vuttxgfzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141045; x=1741745845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIfu2VJ/9GSAopmZ9uLbsgWzSODFEibXXKBGhDuMgAs=;
        b=PxfQNX/jgSIIq5R0hIIz7FSYOsVk+0LVaA/QDe+MXCC6x1udH3PvwOtSYNiP/M4eUk
         roVLVOYJgI1YzkOnPWChxblfVSAwGLPQ2jnMm0RjBn/jyH77i4W/MGrHlQSm/4RKjwnS
         +SXA0vnoj8xnRAgUSmpfRDcik9Iw4WGbxdTP9pb5Rtvr5QGwGUaVS0L+LZPbvOjgvvft
         Ywc4Va3LDJZJlnNIA3425AF6l3rfK5mvTpuZRume0bCS/+94S0FT56+HxrCSZ5rQAUdw
         j5+YQgSpuD0sJRH1XvAt79aIZy5fA3eTozA+ffNCbbgxeRrZbbA+kM027QyyqqA6z8JW
         1D4g==
X-Gm-Message-State: AOJu0YxPrDcUpAH56p+fw2iQMUfvETMiLBOZXjnk39cyPAEM39PKtOj1
	0aSN8IzEIkXQmnfuZsc8bb9aUzhpx01WYr6yE8Bs1rpFQ5Lmvt7wu577VWX8Yw==
X-Gm-Gg: ASbGncvooDxRMOHZxd3Ei3sSyOKyJaRGs1o9859xLymNeUVN58A3+SdRGOim3BorKZg
	IrC2xW4A27WmeS/bpLUCHKadHGiQ18kjXrBtaAXfwoqUA084GXAPQLst1u9kG93I9jLgKyaDn+F
	hX6EIwXLjxKwgcTSWjVw3vJ6C2si6t1O8HLDTcDlpftuyusRhOkeqr8FLw4vCMutR//QdYCDjAQ
	EvTV2/ytzJu7ZYLBcjmfoZCoc4lGa7m3b/sTQqj/JMzYBaVWM81qaouBIC0kYagwBAMAWSSz1i5
	5t+4D/lKTlUkPnvYtZFTvrY9sNw8dlcH2eR5Z4kREBDCMdwYYPbLfLnlnTwZ6M77d1cjtV41PJp
	K
X-Google-Smtp-Source: AGHT+IFHeVdtZZm39HngPtsoUTVZKgS46cdM+ArsIPjMeSkmmvxRRZxLnRcUV5g0ohNg3kMW3ta20Q==
X-Received: by 2002:a05:6402:34d5:b0:5e4:c4a1:412f with SMTP id 4fb4d7f45d1cf-5e59f3a8028mr450765a12.3.1741141044679;
        Tue, 04 Mar 2025 18:17:24 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:24 -0800 (PST)
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
Subject: [PATCH v9 3/7] mseal sysmap: enable x86-64
Date: Wed,  5 Mar 2025 02:17:07 +0000
Message-ID: <20250305021711.3867874-4-jeffxu@google.com>
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

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
covering the vdso, vvar, vvar_vclock.

Production release testing passes on Android and Chrome OS.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/x86/Kconfig          | 1 +
 arch/x86/entry/vdso/vma.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..c6f9ebcbe009 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,6 +26,7 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc1a9ca..a4f312495de1 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -268,7 +268,8 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       text_start,
 				       image->size,
 				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				       VM_SEALED_SYSMAP,
 				       &vdso_mapping);
 
 	if (IS_ERR(vma)) {
@@ -280,7 +281,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       addr,
 				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       VM_PFNMAP|VM_SEALED_SYSMAP,
 				       &vvar_mapping);
 
 	if (IS_ERR(vma)) {
@@ -293,7 +294,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       VM_PFNMAP|VM_SEALED_SYSMAP,
 				       &vvar_vclock_mapping);
 
 	if (IS_ERR(vma)) {
-- 
2.48.1.711.g2feabab25a-goog


