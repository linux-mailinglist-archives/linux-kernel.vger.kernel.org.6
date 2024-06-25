Return-Path: <linux-kernel+bounces-228904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151B916876
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A5FB23A45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DB15ECE5;
	Tue, 25 Jun 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="l0pphxkQ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBB15A87A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320306; cv=none; b=j4QUYWRgdB+pHiad+aY5DmvgaoJldU2ilel1JabyUq4QZBYCOhuacLyH2m0kI85/w71kezzHVrChobsqB6kQPmNFzA6zTQdxaS5vgTBDdM1t+ShAqX+RxESRBM6nD2hL8D9Vw034T9xYeE5YCka87WkFZGMW1dMtFNE3lOC7LDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320306; c=relaxed/simple;
	bh=yysy+0k4viJZlCgs1FiqKD47K2a53OZQmVhcvIJQp0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGssrdcH7wm3rcLfZTeJYx9z4gOAXzatcdg9AHXeDNe2MRpcqLZS/4b828Hsc4A2rrFFc8AcGQMPrY5GhHvxr8GSfBo2obFbTY5acsL8LAecTDs52V61PWeS7FIywg85gRK/CDgFsJijwHnqhufjEfmAwfrp/gcKIEf5Ixz5H80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=l0pphxkQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1zOlxzHp0smE9UfbcodciZvu33TYDM4Qa9pbUNbyMBc=; b=l0pphxkQFC4KW/uenGEhMUEkcm
	XpB0tL6qB6mak5eVAObHEjmdhoVGolx3KmJ5NuunL4j/OPvIRQa9GAochTiwJoPWs0Eiivm1v8GEx
	jyqhCu+pxtxlGlo2aGOL/MIloUgtCIqudY7kU3e+0tiO+xnkpwlG8fP8XP86BJIZBO/qVb+Fw/ljA
	uqM6+nuemrjoF7NfBvDylTSDRHYOgsc7T9nbaeSHR1Vt4vld5xDInfglha2FB28v+O9kjB/+3HMbk
	N7b6IlnFkWW9Smx6eZr40I2ZKmyukkFoLXyu6Gfc+0jRUyWrjaKSTMCuu5XcHyzv1IsMXmmtbcDNv
	/Afy8rDA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sM5kV-007J4Y-Kc; Tue, 25 Jun 2024 14:58:15 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] numa: Add simple generic NUMA emulation
Date: Tue, 25 Jun 2024 13:58:02 +0100
Message-ID: <20240625125803.38038-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240625125803.38038-1-tursulin@igalia.com>
References: <20240625125803.38038-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

Add some common code for splitting the memory into N emulated NUMA memory
nodes.

Individual architecture can then enable selecting this option and use the
existing numa=fake=<N> kernel argument to enable it.

Memory is always split into equally sized chunks.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Co-developed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: “Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/Kconfig          |  7 ++++
 drivers/base/Makefile         |  1 +
 drivers/base/arch_numa.c      |  6 ++++
 drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++++++++++
 drivers/base/numa_emulation.h | 21 +++++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 drivers/base/numa_emulation.c
 create mode 100644 drivers/base/numa_emulation.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..1f60cd4dd057 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,6 +230,13 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config GENERIC_ARCH_NUMA_EMULATION
+	bool
+	depends on GENERIC_ARCH_NUMA
+	help
+	  Enable NUMA emulation. Note that NUMA emulation will only be used if
+	  the machine has no NUMA node.
+
 config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	bool "sync_state() behavior defaults to timeout instead of strict"
 	help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 3079bfe53d04..34fcf5bd7370 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
+obj-$(CONFIG_GENERIC_ARCH_NUMA_EMULATION) += numa_emulation.o
 obj-$(CONFIG_ACPI) += physical_location.o
 
 obj-y			+= test/
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 5b59d133b6af..6ad08f681b3c 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -15,6 +15,8 @@
 
 #include <asm/sections.h>
 
+#include "numa_emulation.h"
+
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
 nodemask_t numa_nodes_parsed __initdata;
@@ -30,6 +32,8 @@ static __init int numa_parse_early_param(char *opt)
 		return -EINVAL;
 	if (str_has_prefix(opt, "off"))
 		numa_off = true;
+	if (str_has_prefix(opt, "fake="))
+		return numa_emu_cmdline(opt + 5);
 
 	return 0;
 }
@@ -471,6 +475,8 @@ void __init arch_numa_init(void)
 			return;
 		if (acpi_disabled && !numa_init(of_numa_init))
 			return;
+		if (!numa_init(numa_emu_init))
+			return;
 	}
 
 	numa_init(dummy_numa_init);
diff --git a/drivers/base/numa_emulation.c b/drivers/base/numa_emulation.c
new file mode 100644
index 000000000000..df652fa8351b
--- /dev/null
+++ b/drivers/base/numa_emulation.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Simple NUMA emulation.
+ *
+ * Copyright © 2024 Raspberry Pi Ltd
+ *
+ * Author: Maíra Canal <mcanal@igalia.com>
+ * Author: Tvrtko Ursulin <tursulin@igalia.com>
+ */
+#include <linux/memblock.h>
+
+#include "numa_emulation.h"
+
+static unsigned int emu_nodes;
+
+int __init numa_emu_cmdline(char *str)
+{
+	int ret;
+
+	ret = kstrtouint(str, 10, &emu_nodes);
+	if (ret)
+		return ret;
+
+	if (emu_nodes > MAX_NUMNODES) {
+		pr_notice("numa=fake=%u too large, reducing to %u\n",
+			  emu_nodes, MAX_NUMNODES);
+		emu_nodes = MAX_NUMNODES;
+	}
+
+	return 0;
+}
+
+int __init numa_emu_init(void)
+{
+	phys_addr_t start, end;
+	unsigned long size;
+	unsigned int i;
+	int ret;
+
+	if (!emu_nodes)
+		return -EINVAL;
+
+	start = memblock_start_of_DRAM();
+	end = memblock_end_of_DRAM() - 1;
+
+	size = DIV_ROUND_DOWN_ULL(end - start + 1, emu_nodes);
+	size = PAGE_ALIGN_DOWN(size);
+
+	for (i = 0; i < emu_nodes; i++) {
+		u64 s, e;
+
+		s = start + i * size;
+		e = s + size - 1;
+
+		if (i == (emu_nodes - 1) && e != end)
+			e = end;
+
+		pr_info("Faking a node at [mem %pap-%pap]\n", &s, &e);
+		ret = numa_add_memblk(i, s, e + 1);
+		if (ret) {
+			pr_err("Failed to add fake NUMA node %d!\n", i);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/base/numa_emulation.h b/drivers/base/numa_emulation.h
new file mode 100644
index 000000000000..62b38215a2f0
--- /dev/null
+++ b/drivers/base/numa_emulation.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NUMA emulation header
+ *
+ * Copyright © 2024 Raspberry Pi Ltd
+ */
+
+#ifdef CONFIG_GENERIC_ARCH_NUMA_EMULATION
+int numa_emu_cmdline(char *str);
+int __init numa_emu_init(void);
+#else
+static inline int numa_emu_cmdline(char *str)
+{
+	return -EINVAL;
+}
+
+static int __init numa_emu_init(void)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_NUMA_EMU */
-- 
2.44.0


