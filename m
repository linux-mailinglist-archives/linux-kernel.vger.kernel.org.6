Return-Path: <linux-kernel+bounces-189806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C88CF520
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF44DB20A24
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D1112B153;
	Sun, 26 May 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4ltMKU5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D0EEC5
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716746227; cv=none; b=B4NbuSzTKvwH9lFSQQMu0NJPBaZg3+baKbomOM4wHHBRyFA5yrLLElgRLGsgomKp7iWUwl47KFojtZOjFSoBUshnnAk4FgHsUkffLE+XzY0hNTtFUgneCMVmMG0TdFfVM6Z0vRIJD6/mIJdy4zkS469SjnALkDl5yoJKtsNQKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716746227; c=relaxed/simple;
	bh=BbvmViwVwJ/KmB08kS0p2rNXTjkvnKUZiDNKPQAi+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvH7qILs7yMSL+hpdLwJYrluEpuYVImbY5mmQfWDDHrfTJl8SoOMySu4lYVd+k1KeGMjNlu20vgaZL5tjk0zKtsEa4ud+49AU+d9No1U+ji6fJRjWge3dhymGOAlzNYJCbGz5AwUYaxeEiHln4RTGj8BphvVkTNR29Ea/HMsHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4ltMKU5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52327368e59so11537215e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716746224; x=1717351024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qVCDGbDE1hxIe+eglZipWL8jWoLwckalVAU3UroUOMI=;
        b=E4ltMKU5a0OXz7SxmH7u3isBftswNQltB0jdifL6bDWphOLBGNZOlXn/NT/GwyAyya
         tb0IsaOWNCxGDFIK4bDs8jI526esIPsLFQq28ohY+eHjxSKYtrIthUkKuG5tTKLhLyv0
         gbyAMqBgmno3KnwgPCUwGe/DOD/sFAjkDN5iNudhZDR96ozk9GTMjcOK/MSUAEUlcZlW
         9G28JPF9fBFfYvkagiROYW8pnPpVT1Bw3ys8SjauNje+I8PnpunRI7M74Hmdy8MVSQ7T
         K+5zFDO6eOi7FuNxPX3YduUixD5SKMTPjy9sP/086W9YOCt//zhGbWfssp+cN60wa5Cp
         b/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716746224; x=1717351024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVCDGbDE1hxIe+eglZipWL8jWoLwckalVAU3UroUOMI=;
        b=O7Mupfcf4ZKThmTzz46LqXVQtksI47/TxaH1KXyYJApm8ZpfeniZyq3ctx1QkCpwJo
         duHP5KlsL08CFxmVXxjvLttjLC0nV84ZcPNVEbSasuMeaEfqn2J5TKj7Ij9xa4zBrem8
         oQRS121Z4wVZoadoCWZHGr5vfOjKTftXNplqF6+rYVbWW9asv0NtmLScmv+wfBmC6ApL
         iX8OQ9ufFAajrHIEdc5bLOhrmJQzUWA0q8MwSOjppqBEF0Mom7gxCq/7JUk6cDOPmGUk
         4Ex64LL2eGG1r1fEGjrRBm6aUXitKQFXj2olmZr6QAims1CA3Z1qjJEtU6pdPkzDwdPS
         BgYA==
X-Forwarded-Encrypted: i=1; AJvYcCXqCK+rVvTl+tduGUeOhaBedTo0amccT9WXQCcyKNQT4yiHshGgtOEc1ie+J5lM4YrYmSJ+FEvhEUvA6ZxLfvKke0AqKlfMX2INzrhu
X-Gm-Message-State: AOJu0YyYRwu1MOThnwDxJuzr6GFz4zPWQMGcPOS3Woqemq64vUvvYo43
	m4RH/kD0/OYia1hRm+T8xY71gmdX8zGch/Mmg+eeAmRIeXYGnUAJ
X-Google-Smtp-Source: AGHT+IFVa1qUR79s4iYKKBSRgnjEmsg+qJzvJ6uTrHbrHoR/ogdT9aBaMVRncpxJ8r9WTnaO3Of8sQ==
X-Received: by 2002:a19:8c07:0:b0:519:5df9:d945 with SMTP id 2adb3069b0e04-529642048d7mr4287411e87.4.1716746223402;
        Sun, 26 May 2024 10:57:03 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817c52sm406424866b.1.2024.05.26.10.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 10:57:02 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH 1/2] x86/percpu: Fix "multiple identical address spaces specified for type" clang warning
Date: Sun, 26 May 2024 19:55:52 +0200
Message-ID: <20240526175655.227798-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clang build with named address spaces enabled currently fails with:

error: multiple identical address spaces specified for type [-Werror,-Wduplicate-decl-specifier]

The warning is emitted when accessing const_pcpu_hot structure,
which is already declared in __seg_gs named address space.

Use specialized accessor for __raw_cpu_read_const() instead, avoiding
redeclaring __seg_gs named address space via __raw_cpu_read().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
---
 arch/x86/include/asm/percpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..aeea5c8a17de 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -160,7 +160,10 @@ do {									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
 } while (0)
 
-#define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
+#define __raw_cpu_read_const(pcp)					\
+({									\
+	*(typeof(pcp) *)(__force uintptr_t)(&(pcp));			\
+})
 
 #else /* !CONFIG_USE_X86_SEG_SUPPORT: */
 
-- 
2.42.0


