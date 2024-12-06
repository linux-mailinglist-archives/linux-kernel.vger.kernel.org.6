Return-Path: <linux-kernel+bounces-434800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1769E6B80
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB428351D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437FA1FF7D7;
	Fri,  6 Dec 2024 10:13:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D91FA25E;
	Fri,  6 Dec 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480000; cv=none; b=mfiFGh+RZxfzhbp0vBK0NSWw+jrjPboMppcQOV2omodTrWQYH9+967WCj8IPF+zw7G9TAtUrcsUieDkjd+Cv3K7Zq7RJGaRPfCuoPRSBRuhxO4wgfJB2f3X7Ai9k896W3S+oj0QwsZH73pj/hofrNiq6v7fpLq5dLEs26ufs63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480000; c=relaxed/simple;
	bh=7o/YxOZsIhN/aNc0H3Etle3tQOIFUSqCs8q2bJDNRlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeFziEHM0TCVdXnp/LqB5SzjQlNqmdEVno0UayGY+esdnUrGAEm99hfd5uvFrX1lsrdwAwBGm4eK7xGt76+ig/y85Ybhn6CkorX8ur/Di1C+AjaPpl9z8h5eM2zWoThHSRj7gwgboHRGSn1P5Bi3mPs7RwEK61dRQEEvd5DYdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFAEC15A1;
	Fri,  6 Dec 2024 02:13:43 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E643D3F71E;
	Fri,  6 Dec 2024 02:13:12 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	jannh@google.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	kees@kernel.org,
	maz@kernel.org,
	pierre.langlois@arm.com,
	qperret@google.com,
	ryan.roberts@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH 01/16] mm: Introduce kpkeys
Date: Fri,  6 Dec 2024 10:10:55 +0000
Message-ID: <20241206101110.1646108-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206101110.1646108-1-kevin.brodsky@arm.com>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kpkeys is a simple framework to enable the use of protection keys
(pkeys) to harden the kernel itself. This patch introduces the basic
API in <linux/kpkeys.h>: a couple of functions to set and restore
the pkey register and a macro to define guard objects.

kpkeys introduces a new concept on top of pkeys: the kpkeys level.
Each level is associated to a set of permissions for the pkeys
managed by the kpkeys framework. kpkeys_set_level(lvl) sets those
permissions according to lvl, and returns the original pkey
register, to be later restored by kpkeys_restore_pkey_reg(). To
start with, only KPKEYS_LVL_DEFAULT is available, which is meant
to grant RW access to KPKEYS_PKEY_DEFAULT (i.e. all memory since
this is the only available pkey for now).

Because each architecture implementing pkeys uses a different
representation for the pkey register, and may reserve certain pkeys
for specific uses, support for kpkeys must be explicitly indicated
by selecting ARCH_HAS_KPKEYS and defining the following functions in
<asm/kpkeys.h>, in addition to the macros provided in
<asm-generic/kpkeys.h>:

- arch_kpkeys_set_level()
- arch_kpkeys_restore_pkey_reg()
- arch_kpkeys_enabled()

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/asm-generic/kpkeys.h |  9 +++++
 include/linux/kpkeys.h       | 67 ++++++++++++++++++++++++++++++++++++
 mm/Kconfig                   |  2 ++
 3 files changed, 78 insertions(+)
 create mode 100644 include/asm-generic/kpkeys.h
 create mode 100644 include/linux/kpkeys.h

diff --git a/include/asm-generic/kpkeys.h b/include/asm-generic/kpkeys.h
new file mode 100644
index 000000000000..3404ce249757
--- /dev/null
+++ b/include/asm-generic/kpkeys.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_KPKEYS_H
+#define __ASM_GENERIC_KPKEYS_H
+
+#ifndef KPKEYS_PKEY_DEFAULT
+#define KPKEYS_PKEY_DEFAULT	0
+#endif
+
+#endif	/* __ASM_GENERIC_KPKEYS_H */
diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
new file mode 100644
index 000000000000..bcc063425926
--- /dev/null
+++ b/include/linux/kpkeys.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_KPKEYS_H
+#define _LINUX_KPKEYS_H
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/set_memory.h>
+
+#define KPKEYS_LVL_DEFAULT	0
+
+#define KPKEYS_LVL_MIN		KPKEYS_LVL_DEFAULT
+#define KPKEYS_LVL_MAX		KPKEYS_LVL_DEFAULT
+
+#define KPKEYS_GUARD(_name, set_level, restore_pkey_reg)		\
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, false);			\
+	DEFINE_CLASS(_name, u64,					\
+		     restore_pkey_reg, set_level, void);		\
+	static inline void *class_##_name##_lock_ptr(u64 *_T)		\
+	{ return _T; }
+
+#ifdef CONFIG_ARCH_HAS_KPKEYS
+
+#include <asm/kpkeys.h>
+
+/**
+ * kpkeys_set_level() - switch kpkeys level
+ * @level: the level to switch to
+ *
+ * Switches the kpkeys level to the specified value. @level must be a
+ * compile-time constant. The arch-specific pkey register will be updated
+ * accordingly, and the original value returned.
+ *
+ * Return: the original pkey register value.
+ */
+static inline u64 kpkeys_set_level(int level)
+{
+	BUILD_BUG_ON_MSG(!__builtin_constant_p(level),
+			 "kpkeys_set_level() only takes constant levels");
+	BUILD_BUG_ON_MSG(level < KPKEYS_LVL_MIN || level > KPKEYS_LVL_MAX,
+			 "Invalid level passed to kpkeys_set_level()");
+
+	return arch_kpkeys_set_level(level);
+}
+
+/**
+ * kpkeys_restore_pkey_reg() - restores a pkey register value
+ * @pkey_reg: the pkey register value to restore
+ *
+ * This function is meant to be passed the value returned by kpkeys_set_level(),
+ * in order to restore the pkey register to its original value (thus restoring
+ * the original kpkeys level).
+ */
+static inline void kpkeys_restore_pkey_reg(u64 pkey_reg)
+{
+	arch_kpkeys_restore_pkey_reg(pkey_reg);
+}
+
+#else /* CONFIG_ARCH_HAS_KPKEYS */
+
+static inline bool arch_kpkeys_enabled(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_ARCH_HAS_KPKEYS */
+
+#endif /* _LINUX_KPKEYS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 84000b016808..f51dffca9d4e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1104,6 +1104,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_KPKEYS
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
-- 
2.47.0


