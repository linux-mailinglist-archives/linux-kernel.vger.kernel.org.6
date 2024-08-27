Return-Path: <linux-kernel+bounces-303389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A89960B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BFA286659
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5941C6F5B;
	Tue, 27 Aug 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8tqisc6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C441C68A4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764116; cv=none; b=PHAVYWnBycYBfcAPm5glSfB4lEjBYNtr4Hi6GOASS2SGmB6MaP6vx2wA9VoxiC84tju/DKvB5dIdlR29+wdFCSqn4gPZHyg8MzEmsbtp9w8YNRXhxRUw6MvEcw07kQxzC3+21+IKqxC7TutX7pJvjc5tTzm0V+e7QUQOWhdjP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764116; c=relaxed/simple;
	bh=K+TlnW9Omwb4YI1ixYapWz1zvuIl+jvuJ8oEax/y7lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9crqRvWCZlSM5gHMmmMEpSQxe8uHcD3//msI9Gyu/RONToRtR0fsWA5Z3GcByJBh3DD6oCFbFjhOYdO37xSEUBm5wKD/db252PJ+T2viyghxCGg2XVMwAz6jfR9T/cs/ftAWpyC/hx/B+DmBzwqx5NhU+xiXcqY6oS8MhHQB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q8tqisc6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso34705285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724764112; x=1725368912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVI5R+WdttBIprX1m04d9bNMFDDS+NINGmtqeG2h9Pk=;
        b=q8tqisc6qvwC9MpIGhu5X3sDpdVxWzf1pz8gsEjWmXCciikURaEpsv63Wnu+Lyyhiz
         y9c+9wWkOpjefQg+VDZHUlBHs48x55NpWBY7aZoFtQ6CJlfTfUIXXjkiUwZbytfFGmni
         2IgrJmypXc7PyWxJGCw9AkFwYiJF3r5o3MArh6duTOL7v0xpb8LaOJaqZS3r36/zs3OE
         vV51T8rkS2jmLCvGZLo09gxb3GBA4sbfiOysyJmd46zriiUu1zwJRKeuJn3Q6VmIqZLm
         380GFYZ1y6QdszPJdpJVYsJccbiaCLRNeQxq+PotlwOFNku2AINR+dXJ0ATTdLLPeG9J
         tp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764112; x=1725368912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVI5R+WdttBIprX1m04d9bNMFDDS+NINGmtqeG2h9Pk=;
        b=nZ7iFgKGMYOhwg9fJ/0GIj/UauWePI7OKIdIgJoncok5XrnjYd5AW6DnmW5qlnnwuW
         k2mjE84qberM2zyke1J2QOQTfMG2bFt01f4MHgdXxuWnfbyuI9pcMb/dsFN2CVRxoQM9
         x2J23D9WrpP3sg0FBYpfo+n7hndCZNgyZm+WmTCJBWve+PDs9WrEPp0E26lj9PlmOIs+
         knBUD0kw+Vvcy6SDDhdL4N1e5qASYqF/bkmQRJzYpyeWvJ4AY5G6Eq9jY2s1oROobetL
         lxLizrjDERuM2n5N3HUoWMDnWJqDjMQPpCS5VMobWPA2qtI2+EewEkNWZTkL4et7RhTH
         Jjyg==
X-Gm-Message-State: AOJu0Yy+qev0IvcR3AL0ADwAMtMIxH3mDN+6/F4ak1YR31X3B/tuKfs5
	dntrlsLEWRc12mbYBO4sp0qBbEYShnEElfaZzaWnThMwylH3PX8iym1nwMP2zWM=
X-Google-Smtp-Source: AGHT+IE8YdSXKOIj7u+2bEQxKE7kkLyia2JoNSH9WemPGkONFgqu20dBwFvHn7im4jBKQqBOOuvFvA==
X-Received: by 2002:a05:600c:19c7:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-42b9a682241mr16687955e9.14.1724764111836;
        Tue, 27 Aug 2024 06:08:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefcb674sm221517205e9.32.2024.08.27.06.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:08:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 29A415F9F9;
	Tue, 27 Aug 2024 14:08:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	maz@kernel.org,
	arnd@linaro.org,
	D Scott Phillips <scott@os.amperecomputing.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/3] ampere/arm64: Work around Ampere Altra erratum #82288 PCIE_65
Date: Tue, 27 Aug 2024 14:08:28 +0100
Message-Id: <20240827130829.43632-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827130829.43632-1-alex.bennee@linaro.org>
References: <20240827130829.43632-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: D Scott Phillips <scott@os.amperecomputing.com>

Altra's PCIe controller may generate incorrect addresses when receiving
writes from the CPU with a discontiguous set of byte enables. Attempt to
work around this by handing out Device-nGnRE maps instead of Normal
Non-cacheable maps for PCIe memory areas.

Upstream-Status: Pending
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 arch/arm64/Kconfig               | 22 +++++++++++++++++++++-
 arch/arm64/include/asm/io.h      |  3 +++
 arch/arm64/include/asm/pgtable.h | 27 ++++++++++++++++++++++-----
 arch/arm64/mm/ioremap.c          | 27 +++++++++++++++++++++++++++
 drivers/pci/quirks.c             |  9 +++++++++
 include/asm-generic/io.h         |  4 ++++
 mm/ioremap.c                     |  2 +-
 7 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3fc891f15442..01adb50df214e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -440,6 +440,27 @@ config AMPERE_ERRATUM_AC03_CPU_38
 config ARM64_WORKAROUND_CLEAN_CACHE
 	bool
 
+config ALTRA_ERRATUM_82288
+	bool "Ampere Altra: 82288: PCIE_65: PCIe Root Port outbound write combining issue"
+	default y
+	help
+	  This option adds an alternative code sequence to work around
+	  Ampere Altra erratum 82288.
+
+	  PCIe device drivers may map MMIO space as Normal, non-cacheable
+	  memory attribute (e.g. Linux kernel drivers mapping MMIO
+	  using ioremap_wc). This may be for the purpose of enabling write
+	  combining or unaligned accesses. This can result in data corruption
+	  on the PCIe interface’s outbound MMIO writes due to issues with the
+	  write-combining operation.
+
+	  The workaround modifies software that maps PCIe MMIO space as Normal,
+	  non-cacheable memory (e.g. ioremap_wc) to instead Device,
+	  non-gatheringmemory (e.g. ioremap). And all memory operations on PCIe
+	  MMIO space must be strictly aligned.
+
+	  If unsure, say Y.
+
 config ARM64_ERRATUM_826319
 	bool "Cortex-A53: 826319: System might deadlock if a write cannot complete until read data is accepted"
 	default y
@@ -2388,4 +2409,3 @@ endmenu # "CPU Power Management"
 source "drivers/acpi/Kconfig"
 
 source "arch/arm64/kvm/Kconfig"
-
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 41fd90895dfc3..403b65f2f44de 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -273,6 +273,9 @@ __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 
 #define ioremap_prot ioremap_prot
 
+pgprot_t ioremap_map_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
+#define ioremap_map_prot ioremap_map_prot
+
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
 
 #define ioremap_wc(addr, size)	\
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7a4f5604be3f7..f4603924390eb 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -236,11 +236,6 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_AF));
 }
 
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	return set_pte_bit(pte, __pgprot(PTE_SPECIAL));
-}
-
 static inline pte_t pte_mkcont(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_CONT));
@@ -682,6 +677,28 @@ static inline bool pud_table(pud_t pud) { return true; }
 				 PUD_TYPE_TABLE)
 #endif
 
+#ifdef CONFIG_ALTRA_ERRATUM_82288
+extern bool __read_mostly have_altra_erratum_82288;
+#endif
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+#ifdef CONFIG_ALTRA_ERRATUM_82288
+	phys_addr_t phys = __pte_to_phys(pte);
+	pgprot_t prot = __pgprot(pte_val(pte) & ~PTE_ADDR_LOW);
+
+	if (unlikely(have_altra_erratum_82288) &&
+	    (phys < 0x80000000 ||
+	     (phys >= 0x200000000000 && phys < 0x400000000000) ||
+	     (phys >= 0x600000000000 && phys < 0x800000000000))) {
+		pte = __pte(__phys_to_pte_val(phys) | pgprot_val(pgprot_device(prot)));
+	}
+#endif
+
+	return set_pte_bit(pte, __pgprot(PTE_SPECIAL));
+}
+
+
 extern pgd_t init_pg_dir[];
 extern pgd_t init_pg_end[];
 extern pgd_t swapper_pg_dir[];
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 269f2f63ab7dc..8965766181359 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,6 +3,33 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
+#ifdef CONFIG_ALTRA_ERRATUM_82288
+
+bool have_altra_erratum_82288 __read_mostly;
+EXPORT_SYMBOL(have_altra_erratum_82288);
+
+static bool is_altra_pci(phys_addr_t phys_addr, size_t size)
+{
+	phys_addr_t end = phys_addr + size;
+
+	return (phys_addr < 0x80000000 ||
+		(end > 0x200000000000 && phys_addr < 0x400000000000) ||
+		(end > 0x600000000000 && phys_addr < 0x800000000000));
+}
+#endif
+
+pgprot_t ioremap_map_prot(phys_addr_t phys_addr, size_t size,
+                          unsigned long prot_val)
+{
+	pgprot_t prot = __pgprot(prot_val);
+#ifdef CONFIG_ALTRA_ERRATUM_82288
+	if (unlikely(have_altra_erratum_82288 && is_altra_pci(phys_addr, size))) {
+		prot = pgprot_device(prot);
+	}
+#endif
+	return prot;
+}
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot)
 {
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5a..8baf90ee3357c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6234,6 +6234,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
 
+#ifdef CONFIG_ALTRA_ERRATUM_82288
+static void quirk_altra_erratum_82288(struct pci_dev *dev)
+{
+	pr_info_once("Write combining PCI maps disabled due to hardware erratum\n");
+	have_altra_erratum_82288 = true;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMPERE, 0xe100, quirk_altra_erratum_82288);
+#endif
+
 /*
  * For a PCI device with multiple downstream devices, its driver may use
  * a flattened device tree to describe the downstream devices.
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af4..75670d7094537 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1047,6 +1047,10 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
+#ifndef ioremap_map_prot
+#define ioremap_map_prot(phys_addr, size, prot) __pgprot(prot)
+#endif
+
 void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 				   pgprot_t prot);
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 3e049dfb28bd0..a4e6950682f33 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -52,7 +52,7 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot)
 {
-	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+	return generic_ioremap_prot(phys_addr, size, ioremap_map_prot(phys_addr, size, prot));
 }
 EXPORT_SYMBOL(ioremap_prot);
 #endif
-- 
2.39.2


