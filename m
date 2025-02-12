Return-Path: <linux-kernel+bounces-510425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD1A31CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABAC188B270
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414FD1DC9B5;
	Wed, 12 Feb 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mfShiWRs"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AE1D8DFB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330520; cv=none; b=uFj3ZhfcRyEUqOIJwbaQVqJNMPrT081GOrP6DBE9HDmSl2g4NFvG35jSGkgkPkboSpUyO4Sb2iOFEc+U2PTKFl4zMeV4VLNhFGxn+GkdbXdrqswUqyEK3ZHykWvBh8o6YZYTBDroA5jZTEkQXKuzHrM6iQ6Oe3mduX5YMY5vkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330520; c=relaxed/simple;
	bh=3VXEI9CDqujeRW1KtdOvB9JLbbeUVXm1g3iGikU4Xtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrlVr2tIAu9vW9XV0O5M9kn2YRiWe2WIRxxfQaYAPn+K6GNX314IQM3uBRXJxlD6/zC/ehSfeTFtcbhr28JPXFfnPquZ5xJy++XhTifDxa5P+i45wHScjrdfZNKpcMRstNSpBz1FwLqUsO8BhLTmpGZSA+BQVxke1oke/E02Hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mfShiWRs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f3826e88cso11821265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330518; x=1739935318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGlgtnJud/tm4lyrsEmm3OjwE2GDthkuHJ1JyP15EEc=;
        b=mfShiWRsz7p9LTRqrjCqns4GtsKPBZkJw4/FHb0eg1hga8xrlkfsJU4tmRa+07c079
         m9VoRdh8qg3Sx/jqaUb877lZQPbpaWNekSzjYJZEYRr4lb2cFvFQeZkGgpNsRgkieXsW
         iDsxQTGX8hoW1Fv1Bu+XSi/wacNvQloD8+7zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330518; x=1739935318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGlgtnJud/tm4lyrsEmm3OjwE2GDthkuHJ1JyP15EEc=;
        b=w6ycAGaIYDElZk2SHByJis3MnreFeHbcFra9XgbViX0Q456WOAw3lkXqxz02pKyd5u
         PD7YkXhKHI9CXseGKmA+/RAk5JCG7eRWK2ZzztcV0r1Ia/wx1VRwvmFeyOb6S4YIoFKP
         rZFRN40+5TaG2BOSajJdBqmUxfcm97H62aAapFQpLB654dYaE8gAaahh8eB+XSejAcqo
         h1ij4hUi1o0LoXLvKDoxAUMRq6q97CFhynhC0wQLlaD/0UF4A4rt8VF+uigF/pWo/eb2
         0WgmVqxkanqWUfjj6bWCaKI17Zs5NlhTAE+b0sEfyUuQgvYsWUAXlWKxfBAjad9e4y+8
         kI/g==
X-Gm-Message-State: AOJu0YwocWPbHOxxuRIsxc0qS0EaxKpp/qp8KQi3VAXXqYQHXQbZBzw0
	D3WApDK8doNucCn/DGGrhP4shPogRkfT0OseaM4CHxWXkV35d1Zr9YRJ6CxtOQ==
X-Gm-Gg: ASbGncuT7EEwpEOWJunKbNfg9kQGaTPPQ/lCEVJN5cDgffWdYFZyl9sIT2LpsE0LPc4
	nZwPm91KSHycZTSkoTTxhAsNAervhYJT3lPm0nvw6zo8C72I4LBlp0iTmmuXS4mJfT8lDB4VMqW
	e982Y24REV89b/qjVVMU2CtvEgJnqQoXOF8vHki3sr7FeiNb/wK/qY/o6i6b1tKptMdST6cJ9HR
	Lng4nkfZLp+TgvoWMWtl0BF2b7fa3fTAPuKgskGDrb4MIgS9At36PSx038lJ4jBkVskZifegeDn
	rRyhnJY0ga1vQAKLVAeaxMX4eYm2X4lLp+5hPqx7LHzxV49/PQ==
X-Google-Smtp-Source: AGHT+IEURlNafHcVNKrTKgOcgxh+gG6kKLNCaOgM84jrdUBBOm8abnn5+RM1CQymWz2I341kNGd0sw==
X-Received: by 2002:a17:903:22c5:b0:21b:d105:26a7 with SMTP id d9443c01a7336-220bbb045admr10702145ad.6.1739330517663;
        Tue, 11 Feb 2025 19:21:57 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf999b5cesm299750a91.34.2025.02.11.19.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:21:57 -0800 (PST)
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
Date: Wed, 12 Feb 2025 03:21:49 +0000
Message-ID: <20250212032155.1276806-2-jeffxu@google.com>
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


