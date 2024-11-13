Return-Path: <linux-kernel+bounces-408211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90509C7C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E4228648A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797E5205E25;
	Wed, 13 Nov 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="au793zk/"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E820494F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525372; cv=none; b=SJ79eEeSXOiOnXSpAKR9Nr3ospDeColzZuEZ8efn3XGwrFn+IQhjvZpLNqAd6EGBkhVl0bkQV2pTlCdn8vbcQFI/gC785znb5AbYYa23QAFyS2YVEq6SHuFXRlYSEWq8tl7Ik4U7HVHl9tc/VDIha1PDFVnQfcvUQTaIKhBNydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525372; c=relaxed/simple;
	bh=xlK+tOp7MZfx+SLtyS9Qh0zZUOhJgh/VggIAJLv4hmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6rV5Oi6FgL3N31zvjk5XDVxHkghNw3y4wef9xh0jApo2Yns4gUeQR8tz0hrixvqjNCrMdXTog+maXNMMouWWd4C2zQYN7n3zCVIsj5gmbJAkN8862pYBbpzP8JASV7UmPY3bEVIoiG6xvXg0e0IyTo/FDyS9x2UZG8M+SbNrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=au793zk/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e67102283so337558b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731525370; x=1732130170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bn2E6rL2wYZCI4wKkEUP+kNNk1goC17qlLY+yflZowg=;
        b=au793zk/Z/5V3AyP7+Cp3d1YYt1XRTwZHjzD0bFgfVF33E3asuv/GrXm3+ncxFJKrI
         8ckgt7b6YZ1sTYmSwpSBjci8yWRZFeb/IlH7VxH7CduR9+GMkSCAgdDbdcRI+7MLB0S/
         zajwjZTFsa7gmH82P+/et8u6HcCnIZLheznp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731525370; x=1732130170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bn2E6rL2wYZCI4wKkEUP+kNNk1goC17qlLY+yflZowg=;
        b=iUrU13gpbu1JjOIcAEGZXnYSRhOR0is2bLkV9uHbgIX3CCsbDVvP+Zr5NsKAF5YAEI
         kZFH2MsIsyT/54H8mfRy2r5xq/RWxQIjFfOwB05vKu1EUFs9DORuozjR5t46r27ZG9fe
         xj9CpqFiilt0NQmBMHfy6uUrLCmNpcdWmG6Ap7LCjak+GMPxmNluLtdUz/0+5hmRZfFM
         TT/FUYNS5gr2aLty51Pu9WGQuSYU4Sp7Yi3lpaqyoZiZmgTA0tpwUjF3KxBlYExvxJXO
         LpgW8j95jsk/YB7wm56+9fiGwfxs/TkYCj80RcGQwfayaRa17VO+1LQh+IOG6WeJaw7q
         FWyA==
X-Gm-Message-State: AOJu0Yw3/Y3TlhvOf/vTiUjKMeXp6mZRhMlpUfZq+HdpLKR7dxOnPO7Q
	XcwZKPkJ4/1VWotW1lipWg/YZc7yYa6NTZlP6nVOdYRTP3O/Ra50J0PxDjD2zQ==
X-Google-Smtp-Source: AGHT+IEjwSOXUNHmhOLuGYAncEdgOGnW561Ct4JZEuctDeRoO+bnsvsBpmpGsZv2e9Yi5LCKaGE3/g==
X-Received: by 2002:a05:6a00:1797:b0:71e:4ec7:aece with SMTP id d2e1a72fcca58-724133a1cfdmr11762091b3a.7.1731525370297;
        Wed, 13 Nov 2024 11:16:10 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-724079a3b03sm13445412b3a.117.2024.11.13.11.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 11:16:09 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	ojeda@kernel.org,
	adobriyan@gmail.com,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	hch@lst.de,
	peterx@redhat.com,
	hca@linux.ibm.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 1/1] exec: seal system mappings
Date: Wed, 13 Nov 2024 19:16:02 +0000
Message-ID: <20241113191602.3541870-2-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241113191602.3541870-1-jeffxu@google.com>
References: <20241113191602.3541870-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing or unmapped during the life time of the process.
For complete descriptions of memory sealing, please see mseal.rst [1].

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization, and are
sealed after creation.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [1]. It is sealed from creation.

The vdso, vvar, sigpage, and uprobe mappings all invoke the
_install_special_mapping() function. As no other mappings utilize this
function, it is logical to incorporate sealing logic within
_install_special_mapping(). This approach avoids the necessity of
modifying code across various architecture-specific implementations.

The vsyscall mapping, which has its own initialization function, is
sealed in the XONLY case, it seems to be the most common and secure
case of using vsyscall.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the mapping of vdso, vvar, and sigpage during restore
operations. Consequently, this feature cannot be universally enabled
across all systems. To address this, a kernel configuration option has
been introduced to enable or disable this functionality.

[1] Documentation/userspace-api/mseal.rst
[2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 ++++-
 include/linux/mm.h                            | 12 ++++++
 mm/mmap.c                                     | 10 +++++
 mm/mseal.c                                    | 39 +++++++++++++++++++
 security/Kconfig                              | 11 ++++++
 6 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e7bfe1bde49e..469a65b3cf50 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1538,6 +1538,16 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
+	exec.seal_system_mappings = [KNL]
+			Format: { no | yes }
+			Seal system mappings: vdso, vvar, sigpage, vsyscall,
+			uprobe.
+			This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPINGS
+			- 'no':  do not seal system mappings.
+			- 'yes': seal system mappings.
+			If not specified or invalid, default is the KCONFIG value.
+			This option has no effect if CONFIG_64BIT=n
+
 	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
 			stages so cover more early boot allocations.
 			Please note that as side effect some optimizations
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 2fb7d53cf333..185553376f39 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -366,8 +366,13 @@ void __init map_vsyscall(void)
 		set_vsyscall_pgtable_user_bits(swapper_pg_dir);
 	}
 
-	if (vsyscall_mode == XONLY)
-		vm_flags_init(&gate_vma, VM_EXEC);
+	if (vsyscall_mode == XONLY) {
+		unsigned long vm_flags = VM_EXEC;
+
+		vm_flags |= seal_system_mappings();
+
+		vm_flags_init(&gate_vma, vm_flags);
+	}
 
 	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
 		     (unsigned long)VSYSCALL_ADDR);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index df0a5eac66b7..f787d6c85cbb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
+#ifdef CONFIG_64BIT
+/*
+ * return VM_SEALED if seal system mapping is enabled.
+ */
+unsigned long seal_system_mappings(void);
+#else
+static inline unsigned long seal_system_mappings(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 57fd5ab2abe7..bc694c555805 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
 	unsigned long addr, unsigned long len,
 	unsigned long vm_flags, const struct vm_special_mapping *spec)
 {
+	/*
+	 * At present, all mappings (vdso, vvar, sigpage, and uprobe) that
+	 * invoke the _install_special_mapping function can be sealed.
+	 * Therefore, it is logical to call the seal_system_mappings_enabled()
+	 * function here. In the future, if this is not the case, i.e. if certain
+	 * mappings cannot be sealed, then it would be necessary to move this
+	 * check to the calling function.
+	 */
+	vm_flags |= seal_system_mappings();
+
 	return __install_special_mapping(mm, addr, len, vm_flags, (void *)spec,
 					&special_mapping_vmops);
 }
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..0a9d1e9faa28 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -7,6 +7,7 @@
  *  Author: Jeff Xu <jeffxu@chromium.org>
  */
 
+#include <linux/fs_parser.h>
 #include <linux/mempolicy.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
@@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
 {
 	return do_mseal(start, len, flags);
 }
+
+/*
+ * Kernel cmdline overwrite for CONFIG_SEAL_SYSTEM_MAPPINGS
+ */
+enum seal_system_mappings_type {
+	SEAL_SYSTEM_MAPPINGS_DISABLED,
+	SEAL_SYSTEM_MAPPINGS_ENABLED
+};
+
+static enum seal_system_mappings_type seal_system_mappings_v __ro_after_init =
+	IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_ENABLED :
+	SEAL_SYSTEM_MAPPINGS_DISABLED;
+
+static const struct constant_table value_table_sys_mapping[] __initconst = {
+	{ "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
+	{ "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
+	{ }
+};
+
+static int __init early_seal_system_mappings_override(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	seal_system_mappings_v = lookup_constant(value_table_sys_mapping,
+			buf, seal_system_mappings_v);
+	return 0;
+}
+
+early_param("exec.seal_system_mappings", early_seal_system_mappings_override);
+
+unsigned long seal_system_mappings(void)
+{
+	if (seal_system_mappings_v == SEAL_SYSTEM_MAPPINGS_ENABLED)
+		return VM_SEALED;
+
+	return 0;
+}
diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..63b87a218943 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -51,6 +51,17 @@ config PROC_MEM_NO_FORCE
 
 endchoice
 
+config SEAL_SYSTEM_MAPPINGS
+	bool "seal system mappings"
+	default n
+	depends on 64BIT
+	depends on !CHECKPOINT_RESTORE
+	help
+	  Seal system mappings such as vdso, vvar, sigpage, vsyscall, uprobes.
+	  Note: CHECKPOINT_RESTORE might relocate vdso mapping during restore,
+	  and remap will fail if the mapping is sealed, therefore
+	  !CHECKPOINT_RESTORE is added as dependency.
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.47.0.277.g8800431eea-goog


