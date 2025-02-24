Return-Path: <linux-kernel+bounces-529145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F56A42063
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE29A16E509
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F16233731;
	Mon, 24 Feb 2025 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FipkleQX"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFD221F12
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403266; cv=none; b=rDHb1x2oo7+NMttLSkcZcix5Sl9WXWtw1tBqgyMgj6wOnufxzH3qIbb3WEvoVivCLw7WOvfmxYSznT9oOe7KibVz+axymfQk1yuJJ+v3XTSH9ySeMHYRvpIP+lxYjGN6r+GKfP0RnFdD0IemsQ1N4moyDYTdu4obhow8SkQ14kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403266; c=relaxed/simple;
	bh=hmIezxSkVPoVygsyrxMpG/1bNcEE7Ks35nXLRADKK4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cgx2uef/Gb4LSyU4BLX/WWOueB18BKO0r+zocuPcW+fF8qg8ueVWJhJrz5vuv23guWgLPtAgU88JtEuZrGs0dmq+vdM/d+AftAQliJsiRY0SBdv0O1XoWi3MU+Qg8h2nj8poPbdni5Xx7Qhx5Iigd67k6OoM2E0aexX3U3TybyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FipkleQX; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dca72b752fso3027722a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403262; x=1741008062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JyraTq6idBOcwGmyhTMaAoOgoMyTYbiA32Ni4n9RJms=;
        b=FipkleQXHHiTNMkP/DEb74xEqnPFuH6NK1hs06cTbV/6wuFmGARnhje/fWjeDmZJxY
         uYu7gqdsJaHluFcjit09Ew39wKSynedRa2PREAl4rIO/niKjraiCnqqfqxZNCekP7L/X
         cFwHVlJ7HQAlL27dy1kkSkw8pqUHJfVIGtUUxC/AVGtW9sc8WGbrskMbjGFh4tj938T6
         pYta5iodi0D50f+xyIA1oBsUHgrgj7ryT/Mp2BjjADm5YwwcKxu2/6lcKQEp7IjtiL6X
         WUJqOZVHhwMZjtXXDISaxWlBPhY5mZYOj5BBryuoglOFSVCY+6VSJhK3bthyi5+aiJHj
         aRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403262; x=1741008062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyraTq6idBOcwGmyhTMaAoOgoMyTYbiA32Ni4n9RJms=;
        b=ubnZUmOIbc4pduXbyEt/qNXAjg09zLi8AUxfbJZmT/p+cvvhctAOGMCbMyTbHIh9AD
         4yrAhhCe5GGJbTBiVxVbsW4ZbfioVOAtrlpsaesmqFjlzacrA6+dIMz60zA7U+NDFON4
         dIRp0fdJ3CCbeIu+sxCKaTRRloMN/mi8GmjcvjULuB4ZIQVeafBznJErBqEhB3YALuth
         cFobx3wcO3gcgl7whUovbGd37FvUAWn4KUuRSv5I9flMA+Ie0PS9rSr0gwAbUSkPxe6W
         iVbT84iH1pazOs4cF+rKxM4vMeiTvx3MZWnrdsUY0AZlWy7o6mHGY2WOKGV2bOwm0Xgt
         CSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2nth3ILLRU7QN3CvKcWiz7ek/3JKDZ+yEwFLEUYIx9Wmjby6HeodXeOpcDTJOWGmbZEvRwlKC2i5pNRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuTAAyNM7XfqbJdv/x2DFpDJHUdeqYwc85Xg3gfgGeMsBrVg5
	bVixjiWXgRjlOztyY+7xWY2wKn84sHV82v/PwnV+X38is+f/DxGDeACMDgEv3zi2GXFof+mcYRQ
	FPEK0Ug==
X-Google-Smtp-Source: AGHT+IGmlOdkSrjwloUHpl5gZH+Z/luHXrEOeMO0um4QArIAMQynUveFF9DemRD5SpepJJxyWIBqXViUZL8A
X-Received: from edbfj7.prod.google.com ([2002:a05:6402:2b87:b0:5d8:8209:8769])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:13d2:b0:5e0:8c55:532
 with SMTP id 4fb4d7f45d1cf-5e0b70bbee0mr12717985a12.4.1740403262426; Mon, 24
 Feb 2025 05:21:02 -0800 (PST)
Date: Mon, 24 Feb 2025 14:20:45 +0100
In-Reply-To: <cover.1740403209.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <68427864e0ca38af06482c96728216c3e0973418.1740403209.git.dvyukov@google.com>
Subject: [PATCH v4 1/4] pkeys: add API to switch to permissive/zero pkey register
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The API allows to switch to permissive pkey register that allows accesses
to all PKEYs, and to a value that allows acccess to the 0 (default) PKEY.
This functionality is already used in x86 signal delivery, and will be
needed for rseq.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")

---
Changes in v4:
 - Added Fixes tag

Changes in v3:
 - Renamed API functions to write_permissive_pkey_val/write_pkey_val
 - Added enable_zero_pkey_val for rseq
 - Added Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Changes in v2:
 - Fixed typo in commit description
---
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/pkeys.h | 33 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/pkru.h  | 10 +++++++---
 include/linux/pkeys.h        | 31 +++++++++++++++++++++++++++++++
 mm/Kconfig                   |  2 ++
 5 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118d..43af2840d098f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1881,6 +1881,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_PERMISSIVE_PKEY
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
 	  page-based protections, but without requiring modification of the
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2e6c04d8a45b4..d6e35ab5c3d22 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#include "pkru.h"
+
 /*
  * If more than 16 keys are ever supported, a thorough audit
  * will be necessary to ensure that the types that store key
@@ -123,4 +125,35 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+typedef u32 pkey_reg_t;
+
+static inline pkey_reg_t write_permissive_pkey_val(void)
+{
+	return write_pkru(0);
+}
+
+static inline pkey_reg_t enable_zero_pkey_val(void)
+{
+	u32 pkru;
+
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return 0;
+	/*
+	 * WRPKRU is relatively expensive compared to RDPKRU,
+	 * avoid it if possible.
+	 */
+	pkru = rdpkru();
+	if ((pkru & (PKRU_AD_BIT|PKRU_WD_BIT)) != 0)
+		wrpkru(pkru & ~(PKRU_AD_BIT|PKRU_WD_BIT));
+	return pkru;
+
+
+	return write_pkru(0);
+}
+
+static inline void write_pkey_val(pkey_reg_t val)
+{
+	write_pkru(val);
+}
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 74f0a2d34ffdd..b9bf9b7f2753b 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -39,16 +39,20 @@ static inline u32 read_pkru(void)
 	return 0;
 }
 
-static inline void write_pkru(u32 pkru)
+static inline u32 write_pkru(u32 pkru)
 {
+	u32 old_pkru;
+
 	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
-		return;
+		return 0;
 	/*
 	 * WRPKRU is relatively expensive compared to RDPKRU.
 	 * Avoid WRPKRU when it would not change the value.
 	 */
-	if (pkru != rdpkru())
+	old_pkru = rdpkru();
+	if (pkru != old_pkru)
 		wrpkru(pkru);
+	return old_pkru;
 }
 
 static inline void pkru_write_default(void)
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 86be8bf27b41b..262d60f6a15f8 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -48,4 +48,35 @@ static inline bool arch_pkeys_enabled(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#ifndef CONFIG_ARCH_HAS_PERMISSIVE_PKEY
+
+/*
+ * Common name for value of the register that controls access to PKEYs
+ * (called differently on different arches: PKRU, POR, AMR).
+ */
+typedef char pkey_reg_t;
+
+/*
+ * Sets PKEY access register to the most permissive value that allows
+ * accesses to all PKEYs. Returns the current value of PKEY register.
+ * Code should generally arrange switching back to the old value
+ * using write_pkey_val(old_value).
+ */
+static inline pkey_reg_t write_permissive_pkey_val(void)
+{
+	return 0;
+}
+
+/*
+ * Sets PKEY access register to a value that allows access to the 0 (default)
+ * PKEY. Returns the current value of PKEY register.
+ */
+static inline pkey_reg_t enable_zero_pkey_val(void)
+{
+	return 0;
+}
+
+static inline void write_pkey_val(pkey_reg_t val) {}
+#endif /* ! CONFIG_ARCH_HAS_PERMISSIVE_PKEY */
+
 #endif /* _LINUX_PKEYS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db064172..9e874f7713a2b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1147,6 +1147,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_PERMISSIVE_PKEY
+	bool
 
 config ARCH_USES_PG_ARCH_2
 	bool
-- 
2.48.1.601.g30ceb7b040-goog


