Return-Path: <linux-kernel+bounces-529720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9F2A42A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752BE16C4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32D2265614;
	Mon, 24 Feb 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ASYqjxeK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCD261397
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419119; cv=none; b=l8oiy4voUsKuOdXVmJ84YCbSVyG+FEj4XVopqpYbc42z0DbCC4PE5TExDLJQ8/ejZdFty8Kb3H2n5CKoNk5Av6Dd5hkZOWzmex29sA+Q7njh21a8yU5CNJjAXkqNR8edHM6SjBAVBv4NEBOWXkwHGwt67kMJLiDNUwocwrAnM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419119; c=relaxed/simple;
	bh=CuhsetWGwntbFJLGM7WL30SfPLdwGecEL2EQGjezrto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJnlu2crlcVAmAnTl0fzeCEI3aYiAjHTb9Nmtaz70Rlvwwk0/0HWxaIWKf1x2hZ6Q/TE0XQimp7e5sk1SLSM42BBKhhmzeE4WbW+BZVsbrUNFRXijdR4JZDdkTBVXUG17yuv69cNfZZ9mtwH3NZtuLJt1dP0OLGLgTwSpZmMcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ASYqjxeK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-222def4189aso2675705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419116; x=1741023916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12YXJXd/yEdP4F/xsuPjPUzHYkrMQ/m+SagD7sBuyCE=;
        b=ASYqjxeKhVwNsfi2LUSYEmCuONt9yJ3aP16dqtPUuqBozSfPgHGD9TPs5pdN3eTsOm
         3BHRQJv2ynKUwPhh5AjaIVo0Pi6v762J6iYJu1ze/Ww69hSi0y7aZT5QyxBRgym3HTYI
         MaSWarHnBtqHrTdMjmDlVvUEy/Xkfx/LLa1V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419116; x=1741023916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12YXJXd/yEdP4F/xsuPjPUzHYkrMQ/m+SagD7sBuyCE=;
        b=v5p41X8YmfRyRmFokBuDLRfAV5hqrfYny4PHGG8nVPt8dkjDp922SnBYDE+6RnLr1r
         Y0Uuc0CuhysS3vplMnB1n4zogEYakeJX9o+YRvk49ZuNUpGCCl9F+tPPXs4RuaZ/mXPu
         zJDxdTUV7CtWGCSYeSxLSq1EbPiaVR0s8pLlLAeraprEtb4B21bhQL7V2DNHc+t6lbP/
         zkuefqPoW/Rnu8WmBCRvM9idD4f2T7/c4aXGzJtZmti/2amBlwRGXouwUbKFphvPFTZO
         BgUj1maZ2Jz7T2gppgFFZYP3rtQVgPG8nLMtcBfRcamo5NHdQMGTORuVAPNR8xDQJDAC
         XmCA==
X-Gm-Message-State: AOJu0YwUbaganKh7Qh07FhgE+CMxEn8yoYFeKB2w19pMQtSiM6BcWizA
	qjsAiSqM9/VdT9zaIrdz7SRjljV3WvfXea5Nz/Te56k43w6ZhFGOJAszf+qw/w==
X-Gm-Gg: ASbGncuoW71vbMd3OjrRqawCnpRnzKuOAdlCnrDQlpy4tfljIKC+1hTB8mv1/crniMT
	ZFFYOyHxMOt+mlKflzR3CpNFCBXITU1LeB8UVA2J7fct34ngPoB9e08hf+TSHnUqCQaPZ/uDqLr
	Nsl2Ib6tyks903LfFGG6oVaTzkykdoz8KZW7UM8bDEGQKSoGNmzo2MZ+VIvWvKtHs+SgmXFd/XN
	VP/5Mf+uw8BVOxxRJDpdN7orkXbhMRlwo/xAivtoYLs7UDUbzw66iEmmPWOYWLfGIQdW5IIWC34
	8N9uI7n7h9AbN+SCc/0ud/vqScVUiurSBNchIny8mY0sxVUtdcu26shffDAi
X-Google-Smtp-Source: AGHT+IEM10lFU8wtWJoD9BVg2aWh3maIXwfJyL7OUpA65d05St26KsRXtPBtPPG4VoNhMT8Aot7f1Q==
X-Received: by 2002:a17:902:e881:b0:215:8721:30b7 with SMTP id d9443c01a7336-2219ffbdfcbmr92049895ad.11.1740419116004;
        Mon, 24 Feb 2025 09:45:16 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491d4sm183028425ad.4.2025.02.24.09.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:15 -0800 (PST)
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
Subject: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
Date: Mon, 24 Feb 2025 17:45:07 +0000
Message-ID: <20250224174513.3600914-2-jeffxu@google.com>
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

Provide infrastructure to mseal system mappings. Establish
two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
ARCH_HAS_MSEAL_SYSTEM_MAPPINGS) and MSEAL_SYSTEM_MAPPINGS_VM_FLAG
macro for future patches.

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
and gVisor, rr are also known to change the vdso/vvar mappings.
Consequently, this feature cannot be universally enabled across all
systems. As such, CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled by default.

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
 include/linux/mm.h | 10 ++++++++++
 init/Kconfig       | 18 ++++++++++++++++++
 security/Kconfig   | 18 ++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..0e2a4a45d245 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
+
+/*
+ * mseal of userspace process's system mappings.
+ */
+#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
+#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG	VM_SEALED
+#else
+#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG	VM_NONE
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..07435e33f965 100644
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
+	  special mappings calls to include the sealing flag and confirm
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
index f10dbf15c294..15a86a952910 100644
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
+	  Note: CHECKPOINT_RESTORE, UML, gVisor, rr are known to relocate or
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
2.48.1.601.g30ceb7b040-goog


