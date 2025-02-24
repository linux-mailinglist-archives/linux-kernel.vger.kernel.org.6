Return-Path: <linux-kernel+bounces-529723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9983A42A40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCA9164DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89026656D;
	Mon, 24 Feb 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6799ISL"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C9265CC7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419122; cv=none; b=YJiO63nlpHBHxJ/5TdUarHXhbzAQW2DFDyM9o/gz18op8WkSu9G5O32wvLxnGSLH4NOluDyRhHYd3uBAI4+RVCQzJs/LhUoRfWpgk8KmTeNogXsGlyJp6vWo6H2ukyO5QozUU2kGvVX0r1kxJ+73N5iTBxwu2BiFM0aD4G3/vDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419122; c=relaxed/simple;
	bh=Uk2AWseJqK82pjVKDpunCE3RpWexobHlM85zZUMX3CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWLL+Eb5v93KrMg27ewHSIphF+wRxqQqlfT5m8saSsHudniAcP3SKGMitlj4SyhkHN00l/R1/WLF1+rbo+2b0s98qSaezTtxKnqXUMOgrgNwkABqbVAmY8AJgtHd6CRR2dMelEKcT7ddJ2HYfQZmNq3k98bgeZuGdUjWr99+ZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W6799ISL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22134a64d8cso11339565ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419121; x=1741023921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF6v4BAgInjRNjkqN7tLcQhcZv2LNrGaf63b7a8eFi0=;
        b=W6799ISLIZIQMsswIKItspexqAysbUYphZUwt5VCGMLFuxMdsO9et90LthCg8lIlqK
         F4KU3DFtpbjlVAq+IgkI4yMJubO2Y6eqgOXtLPuu/vCAXKp/S4tIwqzmQY7q7lHL1A79
         2R9UGljo0wdEk00a+Smfak+AsuHZfzidtFHBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419121; x=1741023921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uF6v4BAgInjRNjkqN7tLcQhcZv2LNrGaf63b7a8eFi0=;
        b=nH3vvlsRwjT0DMyKHxSvGD1qZkjcPGIh3p+EcxaMQlKDXSE2P9COREOem6B1pgb2Ar
         cNAysznbifi5ZbzueN6QWxmZj65l8IwiqckDJL3zhRibvY8kJ7d4GKDty0ib9cUjLuog
         oy3ACbATXpvQ5CARFSuHmTPfnviV+vk9BRJXLGrEwQZcKOpeFSOcvjXDhe7eJmV1XSqA
         HEe1bNhcqEwnQ5t7W9gk6o8udRwJBvMWVOC0+LA4bkaCPMKzLw+1VBs3Zpr1syE/97vm
         pqa36HE4M5bGgPm91s9rIsLxBHdSGB14B5JwXZWAkLPb+OTydfFL6BDLE4fAiubphP0Y
         6aYg==
X-Gm-Message-State: AOJu0YyNB+MUABA2rVufvWcgwBctz/GDk0Rb88Z163i2yrPqksU8uzif
	YqXtD9mRo4cOruX4QDW5sACjO2RnOn4+hQX9ZiTdQa8n/KTV0+3OUsDzwx9eUA==
X-Gm-Gg: ASbGncvhqXVgx9RGq8xFPNT4SvkyEdEsMlyvp+CnRqu6oXHteie0jnwBnRh1e5uLLpq
	+78F9Vc0Pj4bk8yWA6Y+UAV8zfxtFgbV/NhXghzF6iUPTPHMQYgGKjuouLSEidMGshrj9GVS5Eu
	lfECNzzrjlw9QlUMz0i99MYgQ/5DKzIZUb8/vPJr4GnHBbvUVwKldYTswUEZwCHSkJHSYA0gQky
	9nyQwW2UBlFBCFVVC6D3T2rtzNG3Q+WqCkSBVv3TUAcQctKp/I14uiaBjytAgbyL3+mSYDm+rgd
	M1NLrp/Z8nK8ARvoXx50b7Syg8ihMIjIlwAaKCYmCvAsouYAwnpyxvNB6crl
X-Google-Smtp-Source: AGHT+IHchQT9dzoJY2LEcYJPdtfWM7ipynXQ721dymkyqhvRjPShYl+mqIPBkEeCSpT4D/DXL4HZjw==
X-Received: by 2002:a17:903:22c8:b0:21f:b7f5:ee58 with SMTP id d9443c01a7336-2219ff5b3e9mr87660905ad.4.1740419120715;
        Mon, 24 Feb 2025 09:45:20 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5586080sm181990315ad.229.2025.02.24.09.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:19 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v6 5/7] mseal, system mappings: enable uml architecture
Date: Mon, 24 Feb 2025 17:45:11 +0000
Message-ID: <20250224174513.3600914-6-jeffxu@google.com>
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

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
the vdso.

Testing passes on UML.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Kconfig        | 1 +
 arch/x86/um/vdso/vma.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 18051b1cfce0..eb2d439a5334 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -10,6 +10,7 @@ config UML
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..ee6d8a58f9f6 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -54,6 +54,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	unsigned long vm_flags;
 	static struct vm_special_mapping vdso_mapping = {
 		.name = "[vdso]",
 	};
@@ -65,9 +66,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	vdso_mapping.pages = vdsop;
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
 	vma = _install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
-		VM_READ|VM_EXEC|
-		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+		vm_flags,
 		&vdso_mapping);
 
 	mmap_write_unlock(mm);
-- 
2.48.1.601.g30ceb7b040-goog


