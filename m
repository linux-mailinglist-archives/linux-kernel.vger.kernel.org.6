Return-Path: <linux-kernel+bounces-443636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE59EFA6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B49D188E51A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC311223316;
	Thu, 12 Dec 2024 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aslPYKtZ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919322C35E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026715; cv=none; b=VT63IYOgKWf1LwJlUaq9EDVOkQMY+LFJCMMB3woyckiSiEe4snxfn3dH/0g0dXOIGswSylA6tVflRhIHrtGzVzQifpKprVLC0THeZDEcTCscr1BwbjAOjo/Z0RRijqB5UrIh8ErD9r9X2cp7uFwkWPfWTbMKvME9iQOavA5rFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026715; c=relaxed/simple;
	bh=a/JQMVUSO4WSIOgI0iyk5RsJwLOyAIeGYUISnRCOPz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V26q9fEZ2tbayzomD0uo7gKbhgrGfzlQMe/7a+aRhfZKIRhe2dY7QF5mbooeEabL82wq+xJs+HbFYb2YNbCYzXX2geHSVPpoquUVEjiFAZttTVWTzh6uNnIGV6zeo93lzxWT/OHgIiOuq6JyEhJYIMzoxf33Ljt13NXXmCOAEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aslPYKtZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so8306345e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026711; x=1734631511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RS8qlDlci8/4Bym+8sOq6f7pGooq251OZRMaf+SOEgY=;
        b=aslPYKtZdW++W0ffprp1QTcZi2efJd9MHDtD6jCVMgL5JMoFaajJ/YCa7FsAUxBwyx
         uqI3+OqbTg2qjMvp/MpvG0ytPm6H0iXBb7fHNLLX5HpCsAEWBDPFo9mlJjNNBG35M6lM
         evNrAjc1etOqjvPR1WkalPvlscbj5zWbvr49J3OetYOpbBdQPoIatvhx4T/F7wUybwMl
         auvlBiPXilH7HIPP7LxEdSf1EFka7fOTIOJlF9I1ZOVxdWFDCoucL/r0Jlq8Ezb0c6Fh
         qK7NwlPXvzvo1joz2iioRT2RSyIhlWrvca7bA72zWSaUzwUokricqRfR+UodSbrjYu9b
         2wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026711; x=1734631511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS8qlDlci8/4Bym+8sOq6f7pGooq251OZRMaf+SOEgY=;
        b=WcbWeQswzp2GY879yZ/z4PyMDq6Sp8jRcQqvBg/Zuji5n58Ffq/d/tYUr6MX5IMbVQ
         vKESm2mFYGiRnNTn8OyQnq0qvaxYB6hrp+r5w9hZ9g/YFxZZKiyPoWue+bU2fWJGtJie
         zTtU3i3zm1/hk6HfJ0omdw8dlLGD01i9pCXUMq1mj7G0L0QKdCifskhyRnEp9sxcHZXV
         IzwylbL0wBn6k4X7f2xNEFaI9xtH6+u4nLhab1mq7sc8Kt/htofhcZd6/sUXAXE+3sZg
         5MIZpUjgnltHnnkGAztWLP0jIhpUW283ElfWuRL1OLLIH1rbdwTeQZv3y2QmlHtRpgjd
         hLQg==
X-Forwarded-Encrypted: i=1; AJvYcCUseWk1W3HZicI2NBSGD9ikze8gm6IT1Vvzl8e9oRIyHz6YibgIIMqp2ELHD5CWqnXgfJlid60N5WYa+30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFA0fWanRqwiGXwf4YEf2RZwD1GTC2LmzvIcobfB+B25Yw49T+
	ngZjckFVExMA+m1XOrZXBf8HRIfWLo1AxewLLXFgfbw4A5cXxu/ViP9Li4qR9yJHyj1Q6qNU4tV
	c7vqg0rT7Qg==
X-Google-Smtp-Source: AGHT+IEXzXpQhlLFADFsSKXZo9irA4liP3Y9eVpRtNsKhNXeGfOrD877Mo3P2mHA18Npm95BG/JFoGOJUDSq9w==
X-Received: from wmbd18.prod.google.com ([2002:a05:600c:58d2:b0:434:a98d:6a1c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:cc7:b0:434:f753:600f with SMTP id 5b1f17b1804b1-4361c3a6062mr66983595e9.19.1734026711336;
 Thu, 12 Dec 2024 10:05:11 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:37 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-14-smostafa@google.com>
Subject: [RFC PATCH v2 13/58] KVM: arm64: Introduce IOMMU driver infrastructure
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

To establish DMA isolation, KVM needs an IOMMU driver which provide
certain ops, these ops are defined outside of the iommu_ops,
and has 2 components:
- kvm_iommu_driver (kernel): Implements simple interaction with
  the kernel (init, remove,...)
- kvm_iommu_ops (hypervisor): Implements paravirtual interface
  (map, unmap, attach, detach,...)

Only one driver can be used and is registered with
kvm_iommu_register_driver() by passing pointers to both ops.

KVM will initialise the driver after it initialises and before the
de-privilege point, which is a suitable point to establish trusted
interaction between the host and the hypervisor, this also allows
the host kernel to do one initialization from the kernel and avoid
such complexity in the hypervisor as the kernel is still trusted at
this point.

Also, during the registration call, the pointer for the hypervisor
ops will be initialised.

The hypervisor init part is called from the finalise hypercall which
is executed after the kernel kvm IOMMU driver init.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h       | 11 ++++++
 arch/arm64/kvm/Makefile                 |  2 +-
 arch/arm64/kvm/arm.c                    |  8 ++++-
 arch/arm64/kvm/hyp/include/nvhe/iommu.h | 13 +++++++
 arch/arm64/kvm/hyp/nvhe/Makefile        |  2 +-
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 18 ++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c         |  5 +++
 arch/arm64/kvm/iommu.c                  | 47 +++++++++++++++++++++++++
 8 files changed, 103 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/iommu.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
 create mode 100644 arch/arm64/kvm/iommu.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 53916a7f0def..54416cfea573 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1628,4 +1628,15 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 
 unsigned long __pkvm_reclaim_hyp_alloc_mgt(unsigned long nr_pages);
 
+struct kvm_iommu_driver {
+	int (*init_driver)(void);
+	void (*remove_driver)(void);
+};
+
+struct kvm_iommu_ops;
+int kvm_iommu_register_driver(struct kvm_iommu_driver *kern_ops,
+			      struct kvm_iommu_ops *el2_ops);
+int kvm_iommu_init_driver(void);
+void kvm_iommu_remove_driver(void);
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index f9e208273031..440897366e88 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,7 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
 	 vgic/vgic-mmio.o vgic/vgic-mmio-v2.o \
 	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
-	 vgic/vgic-its.o vgic/vgic-debug.o
+	 vgic/vgic-its.o vgic/vgic-debug.o iommu.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 94b210f36573..4b486323c0c9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2510,9 +2510,15 @@ static int __init kvm_hyp_init_protection(u32 hyp_va_bits)
 	if (ret)
 		return ret;
 
+	ret = kvm_iommu_init_driver();
+	if (ret < 0)
+		return ret;
+
 	ret = do_pkvm_init(hyp_va_bits);
-	if (ret)
+	if (ret) {
+		kvm_iommu_remove_driver();
 		return ret;
+	}
 
 	free_hyp_pgds();
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
new file mode 100644
index 000000000000..1ac70cc28a9e
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_NVHE_IOMMU_H__
+#define __ARM64_KVM_NVHE_IOMMU_H__
+
+#include <asm/kvm_host.h>
+
+struct kvm_iommu_ops {
+	int (*init)(void);
+};
+
+int kvm_iommu_init(void);
+
+#endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 415cc51fe391..9e1b74c661d2 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -8,7 +8,7 @@ CFLAGS_switch.nvhe.o += -Wno-override-init
 hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o alloc.o early_alloc.o page_alloc.o \
 	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o \
-	 serial.o alloc_mgt.o
+	 serial.o alloc_mgt.o iommu/iommu.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
new file mode 100644
index 000000000000..3bd87d2084e9
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU operations for pKVM
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <nvhe/iommu.h>
+
+/* Only one set of ops supported, similary to the kernel */
+struct kvm_iommu_ops *kvm_iommu_ops;
+
+int kvm_iommu_init(void)
+{
+	if (!kvm_iommu_ops || !kvm_iommu_ops->init)
+		return -ENODEV;
+
+	return kvm_iommu_ops->init();
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 9d09f5f471b9..4d36616a7f02 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -14,6 +14,7 @@
 #include <nvhe/early_alloc.h>
 #include <nvhe/ffa.h>
 #include <nvhe/gfp.h>
+#include <nvhe/iommu.h>
 #include <nvhe/memory.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
@@ -360,6 +361,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = kvm_iommu_init();
+	if (ret)
+		goto out;
+
 	ret = fix_host_ownership();
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
new file mode 100644
index 000000000000..ed77ea0d12bb
--- /dev/null
+++ b/arch/arm64/kvm/iommu.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Google LLC
+ * Author: Mostafa Saleh <smostafa@google.com>
+ */
+
+#include <asm/kvm_mmu.h>
+#include <linux/kvm_host.h>
+
+struct kvm_iommu_driver *iommu_driver;
+extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
+
+int kvm_iommu_register_driver(struct kvm_iommu_driver *kern_ops, struct kvm_iommu_ops *el2_ops)
+{
+	int ret;
+
+	if (WARN_ON(!kern_ops || !el2_ops))
+		return -EINVAL;
+
+	/*
+	 * Paired with smp_load_acquire(&iommu_driver)
+	 * Ensure memory stores happening during a driver
+	 * init are observed before executing kvm iommu callbacks.
+	 */
+	ret = cmpxchg_release(&iommu_driver, NULL, kern_ops) ? -EBUSY : 0;
+	if (ret)
+		return ret;
+
+	kvm_nvhe_sym(kvm_iommu_ops) = el2_ops;
+	return 0;
+}
+
+int kvm_iommu_init_driver(void)
+{
+	if (WARN_ON(!smp_load_acquire(&iommu_driver))) {
+		kvm_err("pKVM enabled without an IOMMU driver, do not run confidential workloads in virtual machines\n");
+		return -ENODEV;
+	}
+
+	return iommu_driver->init_driver();
+}
+
+void kvm_iommu_remove_driver(void)
+{
+	if (smp_load_acquire(&iommu_driver))
+		iommu_driver->remove_driver();
+}
-- 
2.47.0.338.g60cca15819-goog


