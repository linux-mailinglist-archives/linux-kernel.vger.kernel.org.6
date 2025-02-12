Return-Path: <linux-kernel+bounces-510444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D413A31CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA5D3A8D38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B61DDA3C;
	Wed, 12 Feb 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HoBx/Gz3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76963597E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331153; cv=none; b=n02QiUYs8lHT5FYdaSTYG2BjaudQZhz1RAxdzL0+P0kT0mZH+y/B51KNMpG/R3FbC9N6IYBAM+/hApOp2d1DsSLSbImLWK40irXPJ17cSm5tJ0m17lqSKgvq0kjzzjWDBQrHjI/P1O72Ys+2M3k/SvDG5bSnRmFkIEVURwDgptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331153; c=relaxed/simple;
	bh=3VXEI9CDqujeRW1KtdOvB9JLbbeUVXm1g3iGikU4Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhsOisO+b9Mifh24olBXDgvvE+q8stcAS5zsQHbvOWCKqzL9CssR/xuN2pyYHRssfxtA4kIBEx4dcF6rBVOuSnJ7x7L642ILXOxHA3ItaeWz22mCgZkBtE77pNZXQKoloBe0C3RiqpBnoMgt9yCSkQIqZLcfMJ/WCjOjOEUuQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HoBx/Gz3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2162b5d2e1fso13269355ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739331149; x=1739935949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGlgtnJud/tm4lyrsEmm3OjwE2GDthkuHJ1JyP15EEc=;
        b=HoBx/Gz31zTOjG6oBHmvhBWxgSHTylLCFaTMtWnU0d6Bi9Zdi4cFJicQDio8CICHe1
         pmjJWVxZprwUpt+1TOFaMiOTH/YqFkEDgIkkVnVFn3atfwuK37FhhMrUGaS/Nr5mI214
         f7Hb8ncUbkdoQgglpcFBHGnjv/oPn0oC190MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739331149; x=1739935949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGlgtnJud/tm4lyrsEmm3OjwE2GDthkuHJ1JyP15EEc=;
        b=gwWG3XubsTSg7vU/TGkXK25K/fOUuhQj49LxAQsl9qc3uXEI8egY54VTDZK5mCVbOj
         VWW8A5AFYRd/arXTL9qwEqJuc37cSgS6l6BMf2oE72RqbmpmkPF7Jr+KVzPnX4IfxaIn
         FOePQ2TDty8zZMIQ17qYxBIenS5iZkxXVHF1SWdQzCnPmTaJ6zan9KtG4clyup/1k6Cx
         Ilr2gd5hZqDTAt2oDX+HvBF7uvMEUsMZeaY5l3Eet4XXksYo+RTSBJ/POzw1Cvk13tpN
         dtc//x1NoFIj3NrohYZZLlfR9XVKM6lmKieOoqV3NoIB1QFs8DANsFI2bSREdqb8XEAd
         aXig==
X-Gm-Message-State: AOJu0YxD0r/soILHBhkHstH61m7PKCdtGIntAP6zGMSR4SJb6X8bB77k
	ojwW6WfOCM+oJUcrEwqKaaNB1zoRTTeMxY9R8Kl04QTJGi/EJzSuPLXNi3ODqA==
X-Gm-Gg: ASbGncsru/C2CDt+JwqYWk41ZgvteIX9z5KuDwVix0HoJ3niUXgpZ0WddvNjxlr9G+5
	R24nEtKVANMaRkgnDyk7ySyjQoIPLjNTmzsmErKR2dFZwUnOgFOv0Hb6rIFU1j+EHD8mPeWRunq
	QvbPZQpLykpih5IqSRCq7TzQvqrdbNx1KwgasEfsw/Rwz2FdC/x/RoLIZaceSrSezIeTs008K49
	HwMpuwx0CiCTemHxEjchB2LutcvU4qxu4NitjEzoERwraI0uwlYXzKG06z4Mg2ERD4czT3houQv
	XJezXkurCT66nA3hsCXXu5jgDd7j8BGBeh32tW9aAON45vnGwQ==
X-Google-Smtp-Source: AGHT+IGVcM+htLLcpbNgjUbcjXQYeQo4AXcXda4j6NqZW7sel0rVEkNJe7o+Y3bimML1ZQ9aKnT/ng==
X-Received: by 2002:a05:6a21:6e49:b0:1ed:acb6:7fb4 with SMTP id adf61e73a8af0-1ee5c73e279mr1276829637.3.1739331149090;
        Tue, 11 Feb 2025 19:32:29 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ad555e8f22bsm3393465a12.68.2025.02.11.19.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:32:28 -0800 (PST)
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
Subject: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and header change
Date: Wed, 12 Feb 2025 03:32:21 +0000
Message-ID: <20250212033227.1279141-2-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212033227.1279141-1-jeffxu@google.com>
References: <20250212033227.1279141-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide infrastructure to mseal system mappings. Establish
two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and a header file (userprocess.h)
for future patches.

As discussed during mseal() upstream process [1], mseal() protects
the VMAs of a given virtual memory range against modifications, such
as the read/write (RW) and no-execute (NX) bits. For complete
descriptions of memory sealing, please see mseal.rst [2].

The mseal() is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped.

The system mappings are readonly only, memory sealing can protect
them from ever changing to writable or unmmap/remapped as different
attributes.

System mappings such as vdso, vvar, and sigpage (arm), vectors (arm)
are created by the kernel during program initialization, and could
be sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [3]. It could be sealed from creation.

The vsyscall on x86-64 uses a special address (0xffffffffff600000),
which is outside the mm managed range. This means mprotect, munmap, and
mremap won't work on the vsyscall. Since sealing doesn't enhance
the vsyscall's security, it is skipped in this patch. If we ever seal
the vsyscall, it is probably only for decorative purpose, i.e. showing
the 'sl' flag in the /proc/pid/smaps. For this patch, it is ignored.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the system mappings during restore operations. UML(User Mode Linux)
and gVisor are also known to change the vdso/vvar mappings. Consequently,
this feature cannot be universally enabled across all systems. As such,
CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.

To support mseal of system mappings, architectures must define
CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS and update their special mappings
calls to pass mseal flag. Additionally, architectures must confirm they
do not unmap/remap system mappings during the process lifetime.

In this version, we've improved the handling of system mapping sealing from
previous versions, instead of modifying the _install_special_mapping
function itself, which would affect all architectures, we now call
_install_special_mapping with a sealing flag only within the specific
architecture that requires it. This targeted approach offers two key
advantages: 1) It limits the code change's impact to the necessary
architectures, and 2) It aligns with the software architecture by keeping
the core memory management within the mm layer, while delegating the
decision of sealing system mappings to the individual architecture, which
is particularly relevant since 32-bit architectures never require sealing.

Additionally, this patch introduces a new header,
include/linux/usrprocess.h, which contains the mseal_system_mappings()
function. This function helps the architecture determine if system
mapping is enabled within the current kernel configuration. It can be
extended in the future to handle opt-in/out prctl for enabling system
mapping sealing at the process level or a kernel cmdline feature.

A new header file was introduced because it was difficult to find the
best location for this function. Although include/linux/mm.h was
considered, this feature is more closely related to user processes
than core memory management. Additionally, future prctl or kernel
cmd-line implementations for this feature would not fit within the
scope of core memory management or mseal.c. This is relevant because
if we add unit-tests for mseal.c in the future, we would want to limit
mseal.c's dependencies to core memory management.

Prior to this patch series, we explored sealing special mappings from
userspace using glibc's dynamic linker. This approach revealed several
issues:
- The PT_LOAD header may report an incorrect length for vdso, (smaller
  than its actual size). The dynamic linker, which relies on PT_LOAD
  information to determine mapping size, would then split and partially
  seal the vdso mapping. Since each architecture has its own vdso/vvar
  code, fixing this in the kernel would require going through each
  archiecture. Our initial goal was to enable sealing readonly mappings,
  e.g. .text, across all architectures, sealing vdso from kernel since
  creation appears to be simpler than sealing vdso at glibc.
- The [vvar] mapping header only contains address information, not length
  information. Similar issues might exist for other special mappings.
- Mappings like uprobe are not covered by the dynamic linker,
  and there is no effective solution for them.

This feature's security enhancements will benefit ChromeOS, Android,
and other high security systems.

Testing:
This feature was tested on ChromeOS and Android for both x86-64 and ARM64.
- Enable sealing and verify vdso/vvar, sigpage, vector are sealed properly,
  i.e. "sl" shown in the smaps for those mappings, and mremap is blocked.
- Passing various automation tests (e.g. pre-checkin) on ChromeOS and
  Android to ensure the sealing doesn't affect the functionality of
  Chromebook and Android phone.

I also tested the feature on Ubuntu on x86-64:
- With config disabled, vdso/vvar is not sealed,
- with config enabled, vdso/vvar is sealed, and booting up Ubuntu is OK,
  normal operations such as browsing the web, open/edit doc are OK.

In addition, Benjamin Berg tested this on UML.

Link: https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/ [1]
Link: Documentation/userspace-api/mseal.rst [2]
Link: https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/ [3]

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/userprocess.h | 18 ++++++++++++++++++
 init/Kconfig                | 18 ++++++++++++++++++
 security/Kconfig            | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 include/linux/userprocess.h

diff --git a/include/linux/userprocess.h b/include/linux/userprocess.h
new file mode 100644
index 000000000000..bd11e2e972c5
--- /dev/null
+++ b/include/linux/userprocess.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_USER_PROCESS_H
+#define _LINUX_USER_PROCESS_H
+#include <linux/mm.h>
+
+/*
+ * mseal of userspace process's system mappings.
+ */
+static inline unsigned long mseal_system_mappings(void)
+{
+#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
+	return VM_SEALED;
+#else
+	return 0;
+#endif
+}
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..892d2bcdf397 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
+config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
+	bool
+	help
+	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  To enable this feature, the architecture needs to update their
+	  speical mappings calls to include the sealing flag and confirm
+	  that it doesn't unmap/remap system mappings during the life
+	  time of the process. After the architecture enables this, a
+	  distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage access
+	  to the feature.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config HAVE_PERF_EVENTS
 	bool
 	help
diff --git a/security/Kconfig b/security/Kconfig
index f10dbf15c294..bfb35fc7a3c6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -51,6 +51,24 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
+config MSEAL_SYSTEM_MAPPINGS
+	bool "mseal system mappings"
+	depends on 64BIT
+	depends on ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Seal system mappings such as vdso, vvar, sigpage, uprobes, etc.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  Note: CHECKPOINT_RESTORE, UML, gVisor are known to relocate or
+	  unmap system mapping, therefore this config can't be enabled
+	  universally.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.48.1.502.g6dc24dfdaf-goog


