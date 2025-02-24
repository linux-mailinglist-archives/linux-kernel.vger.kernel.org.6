Return-Path: <linux-kernel+bounces-530190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03178A43046
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235E1175BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15120C02C;
	Mon, 24 Feb 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oe9D7obk"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694D20AF9F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437573; cv=none; b=NCXclVXRCsHetWX0Bt2LQTpNt3BnTtm2PUIxU4n+4tgcrAMK1kNx0CzMtdGvoCzAIh1KXqMTnj3yJ26JTfu/Lku0AWKlU8Fc8siN1+FfUwBOm4FfyLh20yAboBhCx7p87EtfP4cFw3dcAPrx9ZLpDnaTcq0g3jbqfbBvfS0dCQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437573; c=relaxed/simple;
	bh=+Jr8v23L6iLuA3vKByURp4sY8Lw7JmuAhQkX6WPaKi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+gjdIg24Lwt/i+wz2SpLONSjnDOCSIA18NAvTzz14LUaQpFG4YJr7yIo/SzAX5CnbEuWRCV6fVflefYoo1vooyNjhUKxXb6e7shm8n3VGQTak55iouJBJigXWYclt5hH0B+H3fi+8a0/6K1ZE+dixg5yf13ARBGuAWcaxij4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oe9D7obk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d47b035fso11398585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437571; x=1741042371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HehPKH2HS0HzCH0hQSNM2QcWWpZkmDJGAEgO0vW2y+g=;
        b=Oe9D7obks1l1oooUS0SKe1ImDoOxar+pdTfmQbHaUw47+iKARS4qwt0ktRD/8p6zoo
         4qqpqLZxxV5hdh67zOhfNIRRz6rYZcsvg9qTDO9kiacHbOjhB8oOYu031f1tzckZLmAy
         N50wvIKwPm0l37eVna1HA98qAo8jjGbgl1UEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437571; x=1741042371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HehPKH2HS0HzCH0hQSNM2QcWWpZkmDJGAEgO0vW2y+g=;
        b=AfzPfMcq7PxKE35CNMiO3TsBB75khjnzwFJKu8L2F+P2rdZTHHLDBQsGYbeaDiJxz0
         tQ/LdUkOrrgvYP1Ku81JIjIHvVXdUR9aiqrIoDpRSkQsVQTFYp8y78J68FrjbYkx+jaH
         wWSB1AIS6/1CUiJk+CmcmNbAfS6UB8nh6QPTrAM+G6LQjFHx/NKhdiKs/ZJR2VsdOgU+
         WwoOJQbtp7+w5VEFB+XvxRdjhfyhwi8DFvpyvosYXcEorSttioWrEznGdZv4vJiDitRS
         b3AXZPMbJCH6Fqq6oYQQm+3LYH5fh/rHt5FyNB0JRxeKrfxdmjqeZdCSP2Kvbp25H/Rh
         60xQ==
X-Gm-Message-State: AOJu0YxmEb41AYq0PrDW7Y3fqi4QboFbPY3KSySBr8HpfefA+lHuPBJN
	JEVXT+14vtmJ3mYsk5z8chydTAnWDDJsCltfSLZym55VTpJLrit5Z9mwIfBkIw==
X-Gm-Gg: ASbGncugJIXETSz6hZxjzjmswjfB+lHOYkS3mKhoyjHIhgjUUS95/8flLF/BlHSYBsK
	3EoWvx1R9PPauM7HJgJRJEn1dR3ilCpXhwcbdRZM406vhiC+DVxfVQTWJj8RDQOvVLJumopI4ni
	aupHSJ4siazNmAUuubBvZe94pwni7upOBNB2iMlwrDQyYWNoB8i4DivNf8UMXWVWB2x+KUqs+2o
	izLKNVGpbabr0lRkPh+EO8NvCdZ11DI+63Wwh07KTGzQNK1N3eK1xETq0xGZcwcdbZe4aFX6+HX
	WIgrmv/1f7DdEXbw72Dcw8hwlUz/Ew+pF5gT8zdnFXw8gFgvZFH1JDuqF5AC
X-Google-Smtp-Source: AGHT+IHvxyCpkXXkYjTLWWPzvLXpjBHCjYNwj83VFoOFzg3xddNwivdcqHIMBcGsWOCoYPcqKcpgHA==
X-Received: by 2002:a17:902:e5d0:b0:215:9a73:6c4f with SMTP id d9443c01a7336-2219ff50d56mr94813075ad.6.1740437570374;
        Mon, 24 Feb 2025 14:52:50 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0ae9acsm1300615ad.225.2025.02.24.14.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:49 -0800 (PST)
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
Subject: [PATCH v7 3/7] mseal, system mappings: enable x86-64
Date: Mon, 24 Feb 2025 22:52:42 +0000
Message-ID: <20250224225246.3712295-4-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
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
index 39e6efc1a9ca..1b1c009f20a8 100644
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
+	vm_flags |= VM_SEALED_SYSMAP;
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
+	vm_flags |= VM_SEALED_SYSMAP;
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
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm,
 				       addr + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
+				       vm_flags,
 				       &vvar_vclock_mapping);
 
 	if (IS_ERR(vma)) {
-- 
2.48.1.658.g4767266eb4-goog


