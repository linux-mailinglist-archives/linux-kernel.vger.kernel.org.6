Return-Path: <linux-kernel+bounces-541010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B1A4B76A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956FC3A815D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85311E260D;
	Mon,  3 Mar 2025 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxyG9Nu+"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF21D798E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978574; cv=none; b=XT5Y/Pha/V62WepU6dTWBUawjj2clWxwK3AT5dak5PrQxgftXx8PfF6l0QkAjc7oOgCqvhLmhXgD5uBjx/qdZy3udU6RGFjXy6N2/vk+iTtXdo+sQ5zWlBXRZRhi67WHOHZAmIGysnnKop678pbUlw39uj9uJfFYxItmi561M+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978574; c=relaxed/simple;
	bh=KH+raYnE3o90gaSK0BW7YxNK3IE/rt3ovv0WSnGCp6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMszcEtVJTpH6jYZdieOiUV/c8/9P8bjz4uEanMoT+p3LmcuLWZ0gvP061wGyFV4gGWITaqKgVew3aXm/+q3FEM6WBF6M+BT9TINNxWQrFDlu/Caw0SOM5CeWthIxivDyzbYhwCI7tCYLawBYKzlMUF8ocOpZsU8ROG2ShBcrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxyG9Nu+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dfb26020dbso459926a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978570; x=1741583370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7VSfLjBmGBKkv3gMTnCC363Z9s/33avq58JVEwv99I=;
        b=jxyG9Nu+1sCCNJNmk8J8JO9YTRmxFoePeJh8y+zme3vsVwGHPRxbzFjSfzzBB6REkD
         zq1m/fcdW+mhM9iDlj36y55N1IiaXhhBdVXb2XHvpYYdYDG6IipckpIGrOK1carr1TE3
         YwEavhX8LfF7wWxeaos6SrhWeFBWp7kHvZlMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978570; x=1741583370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7VSfLjBmGBKkv3gMTnCC363Z9s/33avq58JVEwv99I=;
        b=homjS8fky3adF8j0zF2AWVvHFPpxRG8vGTCnb9n/6gNYCUbLBcTFzSZebvfBIpazur
         EqYHNTQHpRYI3UMasGDeIh6lFT7798ko0MjYH6m2Sxa16yqPUtRqoO9rKey97wKxPj3d
         AI1kntzsTP3x4y7RqiziMlmlbu4kk8z1Kk0PXXJSVofHn+smnoE32D0uM+I9nR9z4Xh/
         w9+Umt1AnPPoSUPU9Sb6WuJa4vz48EKeHxx3uStPYXYgW6AijjPImtFqcfBvuZ4KgbOI
         ug5OEAyaWghLP3/t5ayk4JYYlVwXvdHAschk//5S02/Fp5Vhj894lYEIwEBgFQa9WkLx
         UBEw==
X-Gm-Message-State: AOJu0YzpWwjA7/sAsxVQYFfX6PAbZxWihE0G7Hjwo9ZVhGdBi1tdgrJ2
	37fDUBprw/mLtlkYwLyiVcuyw8If0rQLPf2nnyaH2+IyUfh0hP+n86X7L4TIXg==
X-Gm-Gg: ASbGnctBbbFERhyP4PryF664MQhiP+ScDrWVEBUEpTMibBifNCenniyPFPIAsqdvbev
	qHkqdKd6IWW9a4QqPkDJRvJGuXephR0cKS96l7eQiDIbIHndw1seQUU0s4LojsdW10CBUbiBNhc
	EUVm1dob5Vz8On0ZRONmpoTEW6Xcz4APlA6qQ+8ql8tvyUnO5u1o3iZr52MTAhbBIzmDIrfbykR
	NoIz+cLzDhf7TTZG7jjfiR+KNR8/4657yhrG68vDHgvSwM4spZqvMRJD9GneEyzR88/YHyee3ZZ
	tWdZ7Kx/elEOA+AZgkUbLHCW0B7Jmhxw/sOUR3/wBXwCZrJvqQmmPzx2y5biywEWECmtwLB8+e1
	I
X-Google-Smtp-Source: AGHT+IFxN3AMTZ+ZZSJlMVlRP2V4CZGjJgXRJF+0MIbx8rSkks+tYU3Lsh69tJGLjjaubvCJaozFog==
X-Received: by 2002:a05:6402:2790:b0:5e4:b3da:6838 with SMTP id 4fb4d7f45d1cf-5e4d6b85b0amr4672505a12.7.1740978570067;
        Sun, 02 Mar 2025 21:09:30 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:28 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v8 1/7] mseal sysmap: kernel config and header change
Date: Mon,  3 Mar 2025 05:09:15 +0000
Message-ID: <20250303050921.3033083-2-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
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
ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
macro for future patches.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/mm.h | 10 ++++++++++
 init/Kconfig       | 22 ++++++++++++++++++++++
 security/Kconfig   | 21 +++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..8b800941678d 100644
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
+#define VM_SEALED_SYSMAP	VM_SEALED
+#else
+#define VM_SEALED_SYSMAP	VM_NONE
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..c90dd8778993 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
+config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
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
+	  time of the process. The existence of this flag for an architecture
+	  implies that it does not require the remapping of thest system
+	  mappings during process lifetime, so sealing these mappings is safe
+	  from a kernel perspective.
+
+	  After the architecture enables this, a distribution can set
+	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config HAVE_PERF_EVENTS
 	bool
 	help
diff --git a/security/Kconfig b/security/Kconfig
index f10dbf15c294..5311f4a6786c 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
+config MSEAL_SYSTEM_MAPPINGS
+	bool "mseal system mappings"
+	depends on 64BIT
+	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Apply mseal on system mappings.
+	  The system mappings includes vdso, vvar, vvar_vclock,
+	  vectors (arm compact-mode), sigpage (arm compact-mode), uprobes.
+
+	  A 64-bit kernel is required for the memory sealing feature.
+	  No specific hardware features from the CPU are needed.
+
+	  WARNING: This feature breaks programs which rely on relocating
+	  or unmapping system mappings. Known broken software at the time
+	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+	  this config can't be enabled universally.
+
+	  For complete descriptions of memory sealing, please see
+	  Documentation/userspace-api/mseal.rst
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.48.1.711.g2feabab25a-goog


