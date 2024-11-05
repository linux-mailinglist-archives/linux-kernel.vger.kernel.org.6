Return-Path: <linux-kernel+bounces-395845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE09BC3D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC3A1C203BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7818183CDD;
	Tue,  5 Nov 2024 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbTtw41F"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68D38DDB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777003; cv=none; b=rnrMxcZ9+hZnZfqfyjwxYfQfiS4Gx8oIGKjb7jTnwFDzo5b8Rk1FKktP25U90o57QMnMYz6kq94kLUmGGwP/F9V4PXIPYg9KPv5QlcOKKaUv56vFFhih4QU8tvqic1rf7t2FNfe1hILUwWoLeDfhsL+XK5MNJnY+jYtrj6fcHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777003; c=relaxed/simple;
	bh=s6t7/lBvk+H4kJvWV1xr5VoU5F2XiLV5lZG0ZhtvGFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyIz52f5Z6Pa02+ntDmFldII67NsndG4XE6cgrucFlDTpFqPcLxfymtKerX3VhDtd7Z+aGteTzY8vMZ+zJm8ZFgfcDJb04PtKGAS1j8/NoCht1pycUj9Txyd7MBb/96c6o/K3RnXWN/boDofP4PAoUeDxMe9CGTHTPbgPMl594Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbTtw41F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e681bc315so3513745b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730777001; x=1731381801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNbWoFxpwOV0AJRi3ESxHu0MAbUNJpATXb5Z8g07utQ=;
        b=KbTtw41FT/NBhaZuXrToHtKUCDAeifXno1FmLv4rCehmaDFKG6QI0mDRf9ejSWjy1A
         v9QG84BZfNP2FLDJsF+BIrcNzxUMB0j7wthW9NKBynJ0gZV1ibWGXDlmByjkowO32v3n
         f8u8je4lNQJkVXRtiln7IZLSsvKAA60nsZLb0+3cGjz3iYh9NZ/6Ftn8fT3tbNLVMfPk
         pqcphe70VZWyoQpWBaJtqa/1R+8tE6uYZVHtuwc4/D9sZVHlbUHPDafrhvEs86KlnCKZ
         iMlx1GNZbk64p92QyJFbelQcLGDGKUaTMNmuqrM/AofVaVawF/YrwYJiZTirLTs9DtJC
         DSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730777001; x=1731381801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNbWoFxpwOV0AJRi3ESxHu0MAbUNJpATXb5Z8g07utQ=;
        b=v7dbgLyRAQwyUA+tPC9jq5JIrOjoFM/n/L5I2EPxShE+RH+5XGMirOPsJ1BYGpFEqw
         A0wkT2EnLIARxDkumu01ECniXaQOn0TcKoq20NkZyiKpTZxg6OoLIDvlmjwYDtOm/vJC
         MSZ0tLMaQMFJx7bgLK/+JLGYeD2iTL6YpqAznZz0wdy9ExWeRYmvzstcdlocQowlUmX0
         deunIiXmJRiio7ZcY9I67BT+EJG8Kev2IJ42umCG3bzNCOrxARn8JZhz/jdDXoRmm/68
         upRgUNxyUo/q9hd1L/kcivJl/OlNSBGyhRPC8ofnyhxPlx7fRFc2Ni72ptCbm25tThtu
         8qXw==
X-Gm-Message-State: AOJu0YzGa9SnBA1Pkz48VQa1hJD3ktwqEnFFc+SxndTR151QZrYRjMQi
	Aqf4fb6CytEtilAbFaJC5DmEvIKyQj5uC7VBdy49MEHHzWcTdUWR
X-Google-Smtp-Source: AGHT+IEoyTlbnyTGnzcr1KQ1k8t6Om11cSSLY3fMneFfYvBYnkupOPuR7yp03nclgXZjA07Su89vKQ==
X-Received: by 2002:a05:6a00:b93:b0:71e:6a99:4732 with SMTP id d2e1a72fcca58-720bcf82bdcmr26209275b3a.11.1730776999722;
        Mon, 04 Nov 2024 19:23:19 -0800 (PST)
Received: from luna.chapman.edu (sac35.chapman.edu. [206.211.154.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc209163sm8667330b3a.92.2024.11.04.19.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:23:19 -0800 (PST)
From: Nataniel Farzan <natanielfarzan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Nataniel Farzan <natanielfarzan@gmail.com>
Subject: [PATCH] Improve consistency of '#error' directive messages
Date: Mon,  4 Nov 2024 19:22:32 -0800
Message-Id: <20241105032231.28833-1-natanielfarzan@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the use of contractions and use proper punctuation in #error
directive messages that discourage the direct inclusion of header files.

Signed-off-by: Nataniel Farzan <natanielfarzan@gmail.com>
---
 arch/alpha/include/asm/spinlock_types.h          | 2 +-
 arch/arm/include/asm/spinlock_types.h            | 2 +-
 arch/arm64/include/asm/spinlock_types.h          | 2 +-
 arch/hexagon/include/asm/spinlock_types.h        | 2 +-
 arch/powerpc/include/asm/simple_spinlock_types.h | 2 +-
 arch/powerpc/include/asm/spinlock_types.h        | 2 +-
 arch/s390/include/asm/spinlock_types.h           | 2 +-
 arch/sh/include/asm/spinlock_types.h             | 2 +-
 arch/xtensa/include/asm/spinlock_types.h         | 2 +-
 include/acpi/platform/aclinux.h                  | 2 +-
 include/linux/compiler-clang.h                   | 2 +-
 include/linux/compiler-gcc.h                     | 2 +-
 include/linux/pm_wakeup.h                        | 2 +-
 include/linux/rwlock.h                           | 2 +-
 include/linux/rwlock_api_smp.h                   | 2 +-
 include/linux/spinlock_api_smp.h                 | 2 +-
 include/linux/spinlock_types_up.h                | 2 +-
 include/linux/spinlock_up.h                      | 2 +-
 tools/include/linux/compiler-gcc.h               | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/alpha/include/asm/spinlock_types.h b/arch/alpha/include/asm/spinlock_types.h
index 2526fd3be5fd..05a444d77c53 100644
--- a/arch/alpha/include/asm/spinlock_types.h
+++ b/arch/alpha/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #define _ALPHA_SPINLOCK_TYPES_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 typedef struct {
diff --git a/arch/arm/include/asm/spinlock_types.h b/arch/arm/include/asm/spinlock_types.h
index 0c14b36ef101..5404a2a96bf3 100644
--- a/arch/arm/include/asm/spinlock_types.h
+++ b/arch/arm/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #define __ASM_SPINLOCK_TYPES_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 #define TICKET_SHIFT	16
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 11ab1c077697..7cde3d8bd0ad 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -6,7 +6,7 @@
 #define __ASM_SPINLOCK_TYPES_H
 
 #if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 #include <asm-generic/qspinlock_types.h>
diff --git a/arch/hexagon/include/asm/spinlock_types.h b/arch/hexagon/include/asm/spinlock_types.h
index d5f66495b670..63add2d863e8 100644
--- a/arch/hexagon/include/asm/spinlock_types.h
+++ b/arch/hexagon/include/asm/spinlock_types.h
@@ -9,7 +9,7 @@
 #define _ASM_SPINLOCK_TYPES_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 typedef struct {
diff --git a/arch/powerpc/include/asm/simple_spinlock_types.h b/arch/powerpc/include/asm/simple_spinlock_types.h
index 08243338069d..391fc19f7272 100644
--- a/arch/powerpc/include/asm/simple_spinlock_types.h
+++ b/arch/powerpc/include/asm/simple_spinlock_types.h
@@ -3,7 +3,7 @@
 #define _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 typedef struct {
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index 40b01446cf75..569765fa16bc 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #define _ASM_POWERPC_SPINLOCK_TYPES_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 #ifdef CONFIG_PPC_QUEUED_SPINLOCKS
diff --git a/arch/s390/include/asm/spinlock_types.h b/arch/s390/include/asm/spinlock_types.h
index b69695e39957..3653ff57d6d9 100644
--- a/arch/s390/include/asm/spinlock_types.h
+++ b/arch/s390/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #define __ASM_SPINLOCK_TYPES_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 typedef struct {
diff --git a/arch/sh/include/asm/spinlock_types.h b/arch/sh/include/asm/spinlock_types.h
index 907bda4b1619..7cb50e68448f 100644
--- a/arch/sh/include/asm/spinlock_types.h
+++ b/arch/sh/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #define __ASM_SH_SPINLOCK_TYPES_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 typedef struct {
diff --git a/arch/xtensa/include/asm/spinlock_types.h b/arch/xtensa/include/asm/spinlock_types.h
index 797aed7df3dd..6baaeac6248b 100644
--- a/arch/xtensa/include/asm/spinlock_types.h
+++ b/arch/xtensa/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #define __ASM_SPINLOCK_TYPES_H
 
 #if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 #include <asm-generic/qspinlock_types.h>
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 565341c826e3..f3249b7df5cb 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -15,7 +15,7 @@
 /* ACPICA external files should not include ACPICA headers directly. */
 
 #if !defined(BUILDING_ACPICA) && !defined(_LINUX_ACPI_H)
-#error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
+#error "Please do not include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
 #endif
 
 #endif
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 4c1a39dcb624..2e7c2c282f3a 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_COMPILER_TYPES_H
-#error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
+#error "Please do not include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
 /* Compiler specific definitions for Clang compiler */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cd6f9aae311f..d0ed9583743f 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_COMPILER_TYPES_H
-#error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
+#error "Please do not include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
 #endif
 
 /*
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 76cd1f9f1365..222f7530806c 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -10,7 +10,7 @@
 #define _LINUX_PM_WAKEUP_H
 
 #ifndef _DEVICE_H_
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 #include <linux/types.h>
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index c0ef596f340b..5b87c6f4a243 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -2,7 +2,7 @@
 #define __LINUX_RWLOCK_H
 
 #ifndef __LINUX_INSIDE_SPINLOCK_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 /*
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index dceb0a59b692..31d3d1116323 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -2,7 +2,7 @@
 #define __LINUX_RWLOCK_API_SMP_H
 
 #ifndef __LINUX_SPINLOCK_API_SMP_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 /*
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 89eb6f4c659c..9ecb0ab504e3 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -2,7 +2,7 @@
 #define __LINUX_SPINLOCK_API_SMP_H
 
 #ifndef __LINUX_INSIDE_SPINLOCK_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 /*
diff --git a/include/linux/spinlock_types_up.h b/include/linux/spinlock_types_up.h
index 7f86a2016ac5..fc4e2d017c20 100644
--- a/include/linux/spinlock_types_up.h
+++ b/include/linux/spinlock_types_up.h
@@ -2,7 +2,7 @@
 #define __LINUX_SPINLOCK_TYPES_UP_H
 
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 /*
diff --git a/include/linux/spinlock_up.h b/include/linux/spinlock_up.h
index c87204247592..1e84e71ca495 100644
--- a/include/linux/spinlock_up.h
+++ b/include/linux/spinlock_up.h
@@ -2,7 +2,7 @@
 #define __LINUX_SPINLOCK_UP_H
 
 #ifndef __LINUX_INSIDE_SPINLOCK_H
-# error "please don't include this file directly"
+# error "Please do not include this file directly."
 #endif
 
 #include <asm/processor.h>	/* for cpu_relax() */
diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index 62e7c901ac28..e20f98e14e81 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _TOOLS_LINUX_COMPILER_H_
-#error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
+#error "Please do not include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
 #endif
 
 /*
-- 
2.35.3


