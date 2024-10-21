Return-Path: <linux-kernel+bounces-373863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3C9A5DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CEE1C21086
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF3B1E1A2C;
	Mon, 21 Oct 2024 08:04:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB021E1A08
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497865; cv=none; b=IVzq7euLzEoKsbbeJQtqQWXUPGS78MpFTROefD2p4hUwWWk6A726vNpGj1hsuNg/yx6tZ8SLJvw6tqJH7ikvs+DIxy38VPseRXf9Y2PSjXl4aVLIciD4t/RVgx/8h+gi9eVlWRp8dWUk4d31Xr1iEjNjLvjrxNoLDyb9vrS2Y+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497865; c=relaxed/simple;
	bh=vstX315IIpoVbrYFM3sNoFE437DJvGOfjow7ypYzYUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYwyRVav0oiZz6WOhS0wsK/w/rVM6Cb5lqeCZ4PQT62RYXT15ukeWfObVmMfOoPIJ7zD51UKWleALIDO39ERRpsF7o+6GIe2gxBAre13kRyIfAahHE6AKsAuaWkZNYhrm6uHGbqRdY69B8B/OCzCJnlMK9Xo9VROeIfhiIg4Hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxYa8DCxZn5noBAA--.3448S3;
	Mon, 21 Oct 2024 16:04:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMCxyOIDCxZnVIECAA--.14813S2;
	Mon, 21 Oct 2024 16:04:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH v2] LoongArch: Fix cpu hotplug issue
Date: Mon, 21 Oct 2024 16:04:18 +0800
Message-Id: <20241021080418.644342-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxyOIDCxZnVIECAA--.14813S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch system, there are two places to set cpu numa node. One
is in arch specified function smp_prepare_boot_cpu(), the other is
in generic function early_numa_node_init(). The latter will overwrite
the numa node information.

With hot-added cpu without numa information, cpu_logical_map() fails
to its physical cpuid at beginning since it is not enabled in ACPI
MADT table. So function early_cpu_to_node() also fails to get its
numa node for hot-added cpu, and generic function
early_numa_node_init() will overwrite with incorrect numa node.

APIs topo_get_cpu() and topo_add_cpu() is added here, like other
architectures logic cpu is allocated when parsing MADT table. When
parsing SRAT table or hot-add cpu, logic cpu is acquired by searching
all allocated logical cpu with matched physical id. It solves such
problems such as:
  1. Boot cpu is not the first entry in MADT table, the first entry
will be overwritten with later boot cpu.
  2. Physical cpu id not presented in MADT table is invalid, in later
SRAT/hot-add cpu parsing, invalid physical cpu detected is added
  3. For hot-add cpu, its logic cpu is allocated in MADT table parsing,
so early_cpu_to_node() can be used for hot-add cpu and cpu_to_node()
is correct for hot-add cpu.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Like other architectures, allocate logic cpu when parsing MADT table.
  2. Add invalid or duplicated physical cpuid parsing with SRAT table or
hot-add cpu DSDT information.
---
 arch/loongarch/include/asm/smp.h |  3 ++
 arch/loongarch/kernel/acpi.c     | 24 ++++++++++------
 arch/loongarch/kernel/setup.c    | 47 ++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/smp.c      |  9 +++---
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 3383c9d24e94..c61b75937a77 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -119,4 +119,7 @@ static inline void __cpu_die(unsigned int cpu)
 #define cpu_logical_map(cpu)	0
 #endif /* CONFIG_SMP */
 
+int topo_add_cpu(int physid);
+int topo_get_cpu(int physid);
+
 #endif /* __ASM_SMP_H */
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index f1a74b80f22c..84d9812d5f38 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -78,10 +78,10 @@ static int set_processor_mask(u32 id, u32 flags)
 		return -ENODEV;
 
 	}
-	if (cpuid == loongson_sysconf.boot_cpu_id)
-		cpu = 0;
-	else
-		cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
+
+	cpu = topo_add_cpu(cpuid);
+	if (cpu < 0)
+		return -EEXIST;
 
 	if (!cpu_enumerated)
 		set_cpu_possible(cpu, true);
@@ -203,8 +203,6 @@ void __init acpi_boot_table_init(void)
 		goto fdt_earlycon;
 	}
 
-	loongson_sysconf.boot_cpu_id = read_csr_cpuid();
-
 	/*
 	 * Process the Multiple APIC Description Table (MADT), if present
 	 */
@@ -257,7 +255,7 @@ void __init numa_set_distance(int from, int to, int distance)
 void __init
 acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 {
-	int pxm, node;
+	int pxm, node, cpu;
 
 	if (srat_disabled())
 		return;
@@ -286,6 +284,11 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		return;
 	}
 
+	cpu = topo_get_cpu(pa->apic_id);
+	/* Check whether apic_id exists in MADT table */
+	if (cpu < 0)
+		return;
+
 	early_numa_add_cpu(pa->apic_id, node);
 
 	set_cpuid_to_node(pa->apic_id, node);
@@ -324,12 +327,17 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu
 {
 	int cpu;
 
-	cpu = set_processor_mask(physid, ACPI_MADT_ENABLED);
+	cpu = topo_get_cpu(physid);
+	/* Check whether apic_id exists in MADT table */
 	if (cpu < 0) {
 		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
 		return cpu;
 	}
 
+	num_processors++;
+	set_cpu_present(cpu, true);
+	__cpu_number_map[physid] = cpu;
+	__cpu_logical_map[cpu] = physid;
 	acpi_map_cpu2node(handle, cpu, physid);
 
 	*pcpu = cpu;
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 00e307203ddb..649e98640076 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -65,6 +65,8 @@ EXPORT_SYMBOL(cpu_data);
 
 struct loongson_board_info b_info;
 static const char dmi_empty_string[] = "        ";
+static int possible_cpus;
+static bool bsp_added;
 
 /*
  * Setup information
@@ -346,10 +348,55 @@ static void __init bootcmdline_init(char **cmdline_p)
 	*cmdline_p = boot_command_line;
 }
 
+int topo_get_cpu(int physid)
+{
+	int i;
+
+	for (i = 0; i < possible_cpus; i++)
+		if (cpu_logical_map(i) == physid)
+			break;
+
+	if (i == possible_cpus)
+		return -ENOENT;
+
+	return i;
+}
+
+int topo_add_cpu(int physid)
+{
+	int cpu;
+
+	if (!bsp_added && (physid == loongson_sysconf.boot_cpu_id)) {
+		bsp_added = true;
+		return 0;
+	}
+
+	cpu = topo_get_cpu(physid);
+	if (cpu >= 0) {
+		pr_warn("Adding duplicated physical cpuid 0x%x\n", physid);
+		return -EEXIST;
+	}
+
+	if (possible_cpus >= nr_cpu_ids)
+		return -ERANGE;
+
+	__cpu_logical_map[possible_cpus] = physid;
+	cpu = possible_cpus++;
+	return cpu;
+}
+
+static void __init topo_init(void)
+{
+	loongson_sysconf.boot_cpu_id = read_csr_cpuid();
+	__cpu_logical_map[0] = loongson_sysconf.boot_cpu_id;
+	possible_cpus++;
+}
+
 void __init platform_init(void)
 {
 	arch_reserve_vmcore();
 	arch_reserve_crashkernel();
+	topo_init();
 
 #ifdef CONFIG_ACPI
 	acpi_table_upgrade();
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 9afc2d8b3414..a3f466b89179 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -291,10 +291,9 @@ static void __init fdt_smp_setup(void)
 		if (cpuid >= nr_cpu_ids)
 			continue;
 
-		if (cpuid == loongson_sysconf.boot_cpu_id)
-			cpu = 0;
-		else
-			cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
+		cpu = topo_add_cpu(cpuid);
+		if (cpu < 0)
+			continue;
 
 		num_processors++;
 		set_cpu_possible(cpu, true);
@@ -302,7 +301,7 @@ static void __init fdt_smp_setup(void)
 		__cpu_number_map[cpuid] = cpu;
 		__cpu_logical_map[cpu] = cpuid;
 
-		early_numa_add_cpu(cpu, 0);
+		early_numa_add_cpu(cpuid, 0);
 		set_cpuid_to_node(cpuid, 0);
 	}
 

base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
-- 
2.39.3


