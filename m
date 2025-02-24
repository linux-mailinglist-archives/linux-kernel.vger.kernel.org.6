Return-Path: <linux-kernel+bounces-529721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93675A42A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9337A6CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4641B265CBF;
	Mon, 24 Feb 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hToPXKij"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2420264A94
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419120; cv=none; b=loIsBQG34Xh97WO0YOAcP/NcJOkYK0fZZ9ter905HfQ1kXniE+Zobn0e2GwMb2v8yAPtugUUD/ldAXrHZmxGUcjboc1hLliSenSbeS3pWcFqNIq4qnot+wecS36hO4K0zuwKshg8otyARpbyMKdvvIYZIRAz5DGqzVtZAiq7xEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419120; c=relaxed/simple;
	bh=xmzHvPBJYWRbOVSjpydPwly34jcpZ8PFFtLOGdMVeNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgQojhsHF4YwO74ZfVe4CuM/yuZlYpOmxbIOBUi+xsLc1x0kTCgVTGSz4WLrD1lIQhCBd9euKShx7Dpgz51STbiweCPKN62rcrbwxJ/QB5yCD5hf07AJtoARp1/MZ7XkN46ARuV55RlEDNvA7eHnBtfC7cUkwQKnt32TtWzBk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hToPXKij; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d27d490dso11076125ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419118; x=1741023918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X21CnZpPkRdzfQTLm/xqoLd+RlCmfK8svSgo70Yr8/I=;
        b=hToPXKij9wa2grAVlezoNjVExcAYcEXvkLIATh9k4Stl4adHeYafdPoY0cwjtBvjdF
         b56FYlvthXEU7Vbr7aSo88/RH+nZ/ofXgZ29PPEYH1uylC9bpBoZ9mA4Phsz9M/lRj5E
         Q3stZmCfqy0kT8QVMgZojJ+lpnq3zcLeOawRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419118; x=1741023918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X21CnZpPkRdzfQTLm/xqoLd+RlCmfK8svSgo70Yr8/I=;
        b=p9wF8T4ufIUcUfG/QCfG6RwW9IwxigS62yIX2tQZHmqzVeEbIUMEJOKZ2jDQ3CgSE+
         0R+r+GtmBxesft6/CcEEWypG97uTVpD8xusIm8/SmHdX2yRRe99ZGQL/PAoyiGk82+9p
         XyocNM+eTchDC83K956wo3WmDVI5DSQUECfn1CHNuhCnz5GImEwX46CcHmUo1uYUNaGL
         RReiPZhrST5C9/jY0FlJSKWB7r70wsk/nhIzJaxV1YvSHe1KTzB4VDxJmiiaZJSQiyYh
         b3yM6/LUT+J3d/jAdhWCiw0xcTSQIP1wPbbSnbD+PZEwP0pIvcJbEJDLfclACaSAXT7/
         bwoQ==
X-Gm-Message-State: AOJu0YyXI7aGfnURIvmuKv4SQsIBXLYIP7n/ws6oVhekjlSs0fZ47HDg
	jRh4lL2cS6zR5EVyaRPxPfcTCZugK/taU+Yqq/pRirQH/R5njuNd/wiDm8n+/BXeKqMnugczGuk
	=
X-Gm-Gg: ASbGnctHNFD8iwp1BEAbc4YNlNwSQlalaIOjzq+HgQpsiFpoROiS6kJg6bfx9ChC4rv
	lkGp+Xt66u8cqMx4/3j3cghyRyyHfyOyKPHRdyEtMiVG8PvTP2MBi1k8vJi3tjn0rEkPz1dm5+O
	Prbo2GBQTE0fiA1Vy+vnhuHDOFIqbVvPe6K65WRrMElrz1Z/KWxlyd4aQ4Rj9RbbHl3u5ap+mPn
	tKFlP1yyvQZKS4ocSphLnBiqZOYBnv8BVWzMzSuyGyC2ewZzzHA6XXjo2yj5Ci6LA+/VfJ+93Fa
	Wytl+A89e1QwnLbU6GJgBABk50QubrgRkT5YIggEEz6NCv1Ze+tU4CZAp1n9
X-Google-Smtp-Source: AGHT+IEIEwr4JLc08uaTem+ZJWi2exsrefWwA9KhDKMeXGKBmCEayibfQPpqr5pLiU9niDft6DfzOQ==
X-Received: by 2002:a05:6a21:999f:b0:1ee:e16a:cfa0 with SMTP id adf61e73a8af0-1eef3dd0ddemr9610048637.9.1740419118151;
        Mon, 24 Feb 2025 09:45:18 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adb5a92c6d8sm19248497a12.65.2025.02.24.09.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:17 -0800 (PST)
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
Subject: [PATCH v6 3/7] mseal, system mappings: enable x86-64
Date: Mon, 24 Feb 2025 17:45:09 +0000
Message-ID: <20250224174513.3600914-4-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
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
 arch/x86/entry/vdso/vma.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

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
index 39e6efc1a9ca..54677964d0b5 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -247,6 +247,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long text_start;
+	unsigned long vm_flags;
 	int ret = 0;
 
 	if (mmap_write_lock_killable(mm))
@@ -264,11 +265,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
 	 */
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
 	vma = _install_special_mapping(mm,
 				       text_start,
 				       image->size,
-				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+				       vm_flags,
 				       &vdso_mapping);
 
 	if (IS_ERR(vma)) {
@@ -276,11 +278,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
 	vma = _install_special_mapping(mm,
 				       addr,
 				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       vm_flags,
 				       &vvar_mapping);
 
 	if (IS_ERR(vma)) {
@@ -289,11 +292,12 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		goto up_fail;
 	}
 
+	vm_flags = VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
 	vma = _install_special_mapping(mm,
 				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       vm_flags,
 				       &vvar_vclock_mapping);
 
 	if (IS_ERR(vma)) {
-- 
2.48.1.601.g30ceb7b040-goog


