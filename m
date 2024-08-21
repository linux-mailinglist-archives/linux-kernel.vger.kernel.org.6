Return-Path: <linux-kernel+bounces-295557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A06959E48
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421681C2218C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA119ABC6;
	Wed, 21 Aug 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="F8yo9b8w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7vIYqvq"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A9199FA3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245945; cv=none; b=jxEoQhJz/K8mV0OV6WcOIENZjiIxdAl6v1vNGF0H6tc9Uyh534iJAlEPJWT/gd3dC6/jFI39JDD1H2H1+Hz0CWbQ0glgyldI7xKmDUOXJ/Jqcnkdw5F/DccKwVSgcy588qtKxFm3fw5ma1ujQGTGp1qUb3TlAajU/jGBWkvn8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245945; c=relaxed/simple;
	bh=S7B6LZy3/Kf1g2cOSXPXSOBLEq5lnrc0TlHYa4johbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvsclypRT9rEVCTUJXEk5jVpKHlsX/WPSzGsOs/AJVtsa77nJwGKDvNmC9edbJzCi2batppgXN0i2/Be9BokSwKsLyqxiHJzX4DRb8gtApn08NwoNV3X7SywKQ4h3bvjqBju4qgc8VvykdbIQXFgaSJ67H/xGRTKTuZVOv3ItVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=F8yo9b8w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7vIYqvq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D12AD114AB0C;
	Wed, 21 Aug 2024 09:12:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 21 Aug 2024 09:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1724245941;
	 x=1724332341; bh=Xb+sHvmmEphBpNXmOPQARN1Yy2INN0tUTy2TyikV/Oc=; b=
	F8yo9b8wxJbpJYjazk4F49Me5bsrHKlVcxmyHTusIORRDdz5/TbI9sKl1PeRpoB/
	KSWF+WzESdAZbDR5glJr0DlB6upkvLugaR9Q2ZnWrMo85uijQQuN+vskbs0l4SFO
	yL40X4rZRss7KMW0b4pDfTM1nkJsoZvm97kkL0yfXBUbtrtBADhBks/kzWMmqx4v
	o+NXRnmlZVCbe+W5OamcVzQ2AvCkDbblQNu+do8vhms+sZ0GSm5dWsNS9WIBwb0Z
	iT+jOvje9Q9aVjOxNwF7UHyal4jo1WKh/gJpcyMgTTVEKpNvb+FuNT1Mo3XttVSs
	PqmEoRc+GtZULHQJJvZkPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724245941; x=
	1724332341; bh=Xb+sHvmmEphBpNXmOPQARN1Yy2INN0tUTy2TyikV/Oc=; b=d
	7vIYqvqUilJ8ubDO3X31jFAVijYrlbv8412pzJPyFBsa9rrKLIESLg2MZ0JzZ+Up
	RED8iBwV3dcFNyssVGcGQD/sKrxc0meoiwmlVq5FzpjZh+C4sKff7Bh5M5/hQzeU
	QjDfPXx76Am+Nuf5sok37gHEinAMTWyoyyc396bj3FqV5TqYpxmhhMOVPuGy0EHD
	j++Wz+UCHEsdTGcEYeQMDrSh6ak3ob0lMKhl2AASsVzs+lX7ubWcXM05MIEsSG6y
	3HvLGq8wFTkLDKFZpH/KN0LYo6SdAYPbD9yTDk/NRzWMbGr4cfqYglzfbuSqm6Xa
	QPVODBNg2okDFqWc/7k3g==
X-ME-Sender: <xms:tefFZm0D9UELEjPqogpJ1JaOjoLQaVcF8ChDL959OnsS6WvGLITdXA>
    <xme:tefFZpF_2CzJ9iDPH9z_badzChzdqAaMQMelLPyDYpiq1iv_Ifudyxl7zd2qfYTfi
    h1Fdyx1LmhciBV9V4I>
X-ME-Received: <xmr:tefFZu7u1ulp0ifp15bOtvsoum8j2J-Ejz4AwQ1NLEiyynWihZcYS5NOYWrmBU1nLN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopegthhgvnhhhuhgrtggr
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishht
    shdrlhhinhhugidruggvvhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:tefFZn37eJehA6V9_Nj_HYAheU5NeIsHIcmUPzLH6uKK2_K3smccUQ>
    <xmx:tefFZpEm9al0nD14Q7naMdl-OC5Sqcfdfa32G7VA0K9iuyDgExIW_Q>
    <xmx:tefFZg9OmmrzqI9rwz8e3Mhd3RktCobKSTSC4vBjchjCzQmcyRTgaA>
    <xmx:tefFZulHRnAR5oMxfxbAqMBViQBOLGBol-p2aSSiYUEqHbCCkXFDog>
    <xmx:tefFZiMkbZ_Kb4F_F3SuEbehbug_nvPWJsUpRIPZaVgL3mN0oSVzwilo>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 09:12:20 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 21 Aug 2024 14:12:17 +0100
Subject: [PATCH 3/3] LoongArch: Convert to arch_numa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-loongarch_archnuma-v1-3-f47b191beee8@flygoat.com>
References: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
In-Reply-To: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=25003;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=S7B6LZy3/Kf1g2cOSXPXSOBLEq5lnrc0TlHYa4johbo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSjzzfUy77ckWZ1P/Oi4uVawV6JD2e19z3fGpw8/UnVx
 YqPhfded5SyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBE5HoZ/lfyKRod9Pq+5ruG
 yabCVqfd3AI5q+ptgz3/VL4Jv2pV+Zjhv9vHcNZ/txN1t7aXzvrYOf+Tbp6++K3TttczE11WJUV
 tZAUA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

LoongArch's NUMA implementation was rooted from MIPS/Loongson64
and x86 implementations.

However in reality the functionality it's closer to other OF & ACPI
architectures, namely RISC-V and Arm64. arch_numa was designed for this
purpose.

Migrating to arch_numa had eliminated massive duplication of code,
and also enabled devicetree based NUMA.

We also removed ACPI NUMA cpu hotplug logic, since for us NUMA node
information is always known from SART for every possible CPU.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/Kconfig                |  10 +-
 arch/loongarch/include/asm/bootinfo.h |   1 -
 arch/loongarch/include/asm/numa.h     |  50 +----
 arch/loongarch/include/asm/topology.h |  13 --
 arch/loongarch/kernel/Makefile        |   2 -
 arch/loongarch/kernel/acpi.c          |  91 ++------
 arch/loongarch/kernel/numa.c          | 394 ----------------------------------
 arch/loongarch/kernel/setup.c         |  19 +-
 arch/loongarch/kernel/smp.c           |  43 +---
 arch/loongarch/mm/init.c              |  12 +-
 10 files changed, 53 insertions(+), 582 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..5301968d5f51 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -159,7 +159,6 @@ config LOONGARCH
 	select HAVE_RUST
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
-	select HAVE_SETUP_PER_CPU_AREA if NUMA
 	select HAVE_STACK_VALIDATION if HAVE_OBJTOOL
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
@@ -170,8 +169,6 @@ config LOONGARCH
 	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_MERGE_VMAS if MMU
 	select MODULES_USE_ELF_RELA if MODULES
-	select NEED_PER_CPU_EMBED_FIRST_CHUNK
-	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select OF
 	select OF_EARLY_FLATTREE
 	select PCI
@@ -188,7 +185,6 @@ config LOONGARCH
 	select SYSCTL_EXCEPTION_TRACE
 	select SWIOTLB
 	select TRACE_IRQFLAGS_SUPPORT
-	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
 	select ZONE_DMA32
 
@@ -476,6 +472,12 @@ config NR_CPUS
 config NUMA
 	bool "NUMA Support"
 	select SMP
+	select GENERIC_ARCH_NUMA
+	select OF_NUMA
+	select HAVE_SETUP_PER_CPU_AREA
+	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select USE_PERCPU_NUMA_NODE_ID
 	help
 	  Say Y to compile the kernel with NUMA (Non-Uniform Memory Access)
 	  support.  This option improves performance on systems with more
diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index 6d5846dd075c..e3079a5b7dc9 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -13,7 +13,6 @@ const char *get_system_type(void);
 extern void init_environ(void);
 extern void memblock_init(void);
 extern void platform_init(void);
-extern int __init init_numa_memory(void);
 
 struct loongson_board_info {
 	int bios_size;
diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
index b5f9de9f102e..d12e21907e33 100644
--- a/arch/loongarch/include/asm/numa.h
+++ b/arch/loongarch/include/asm/numa.h
@@ -16,53 +16,7 @@
 #define pa_to_nid(addr)		(((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
 #define nid_to_addrbase(nid)	(_ULCAST_(nid) << NODE_ADDRSPACE_SHIFT)
 
-#ifdef CONFIG_NUMA
-
-extern int numa_off;
-extern s16 __cpuid_to_node[CONFIG_NR_CPUS];
-extern nodemask_t numa_nodes_parsed __initdata;
-
-struct numa_memblk {
-	u64			start;
-	u64			end;
-	int			nid;
-};
-
-#define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
-struct numa_meminfo {
-	int			nr_blks;
-	struct numa_memblk	blk[NR_NODE_MEMBLKS];
-};
-
-extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
-
-extern void __init early_numa_add_cpu(int cpuid, s16 node);
-extern void numa_add_cpu(unsigned int cpu);
-extern void numa_remove_cpu(unsigned int cpu);
-
-static inline void numa_clear_node(int cpu)
-{
-}
-
-static inline void set_cpuid_to_node(int cpuid, s16 node)
-{
-	__cpuid_to_node[cpuid] = node;
-}
-
-extern int early_cpu_to_node(int cpu);
-
-#else
-
-static inline void early_numa_add_cpu(int cpuid, s16 node)	{ }
-static inline void numa_add_cpu(unsigned int cpu)		{ }
-static inline void numa_remove_cpu(unsigned int cpu)		{ }
-static inline void set_cpuid_to_node(int cpuid, s16 node)	{ }
-
-static inline int early_cpu_to_node(int cpu)
-{
-	return 0;
-}
-
-#endif	/* CONFIG_NUMA */
+#include <asm/topology.h>
+#include <asm-generic/numa.h>
 
 #endif	/* _ASM_LOONGARCH_NUMA_H */
diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index 6bed5001c2e3..3785bff26245 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -9,19 +9,6 @@
 
 #ifdef CONFIG_NUMA
 #include <asm/numa.h>
-
-extern cpumask_t cpus_on_node[];
-
-#define cpumask_of_node(node)  (&cpus_on_node[node])
-
-extern unsigned char node_distances[MAX_NUMNODES][MAX_NUMNODES];
-
-void numa_set_distance(int from, int to, int distance);
-
-#define node_distance(from, to)	(node_distances[(from)][(to)])
-
-#else
-#define pcibus_to_node(bus)	0
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c9bfeda89e40..8ddd3e49027c 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -55,8 +55,6 @@ obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 
-obj-$(CONFIG_NUMA)		+= numa.o
-
 obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 929a497c987e..34414d6d4b93 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -221,39 +221,11 @@ void __init acpi_boot_table_init(void)
 
 #ifdef CONFIG_ACPI_NUMA
 
-static __init int setup_node(int pxm)
-{
-	return acpi_map_pxm_to_node(pxm);
-}
-
-/*
- * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
- * I/O localities since SRAT does not list them.  I/O localities are
- * not supported at this point.
- */
-unsigned int numa_distance_cnt;
-
-static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
-{
-	return slit->locality_count;
-}
-
-void __init numa_set_distance(int from, int to, int distance)
-{
-	if ((u8)distance != distance || (from == to && distance != LOCAL_DISTANCE)) {
-		pr_warn_once("Warning: invalid distance parameter, from=%d to=%d distance=%d\n",
-				from, to, distance);
-		return;
-	}
-
-	node_distances[from][to] = distance;
-}
-
 /* Callback for Proximity Domain -> CPUID mapping */
 void __init
 acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 {
-	int pxm, node;
+	int pxm, node, cpu;
 
 	if (srat_disabled())
 		return;
@@ -263,30 +235,32 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 	}
 	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
 		return;
+
 	pxm = pa->proximity_domain_lo;
 	if (acpi_srat_revision >= 2) {
 		pxm |= (pa->proximity_domain_hi[0] << 8);
 		pxm |= (pa->proximity_domain_hi[1] << 16);
 		pxm |= (pa->proximity_domain_hi[2] << 24);
 	}
-	node = setup_node(pxm);
+	node = acpi_map_pxm_to_node(pxm);
 	if (node < 0) {
 		pr_err("SRAT: Too many proximity domains %x\n", pxm);
 		bad_srat();
 		return;
 	}
 
-	if (pa->apic_id >= CONFIG_NR_CPUS) {
-		pr_info("SRAT: PXM %u -> CPU 0x%02x -> Node %u skipped apicid that is too big\n",
-				pxm, pa->apic_id, node);
+	cpu = get_cpu_for_acpi_id(pa->apic_id);
+	if (cpu < 0) {
+		pr_err("SRAT: CPU apic_id %x not present in MADT\n", pa->apic_id);
+		bad_srat();
 		return;
 	}
 
-	early_numa_add_cpu(pa->apic_id, node);
+	early_map_cpu_to_node(cpu, node);
 
-	set_cpuid_to_node(pa->apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	pr_info("SRAT: PXM %u -> CPU 0x%02x -> Node %u\n", pxm, pa->apic_id, node);
+	pr_info("SRAT: PXM %u -> APIC 0x%02x -> CPU %d -> Node %u\n",
+		 pxm, pa->apic_id, cpu, node);
 }
 
 #endif
@@ -297,55 +271,22 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-
-#include <acpi/processor.h>
-
-static int __ref acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
-{
-#ifdef CONFIG_ACPI_NUMA
-	int nid;
-
-	nid = acpi_get_node(handle);
-	if (nid != NUMA_NO_NODE) {
-		set_cpuid_to_node(physid, nid);
-		node_set(nid, numa_nodes_parsed);
-		set_cpu_numa_node(cpu, nid);
-		cpumask_set_cpu(cpu, cpumask_of_node(nid));
-	}
-#endif
-	return 0;
-}
-
-int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu)
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 apci_id,
+		 int *pcpu)
 {
-	int cpu;
-
-	cpu = set_processor_mask(physid, ACPI_MADT_ENABLED);
-	if (cpu < 0) {
-		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
-		return cpu;
+	/* If an error code is passed in this stub can't fix it */
+	if (*pcpu < 0) {
+		pr_warn_once("Unable to map CPU to valid ID\n");
+		return *pcpu;
 	}
 
-	acpi_map_cpu2node(handle, cpu, physid);
-
-	*pcpu = cpu;
-
 	return 0;
 }
 EXPORT_SYMBOL(acpi_map_cpu);
 
 int acpi_unmap_cpu(int cpu)
 {
-#ifdef CONFIG_ACPI_NUMA
-	set_cpuid_to_node(cpu_logical_map(cpu), NUMA_NO_NODE);
-#endif
-	set_cpu_present(cpu, false);
-	num_processors--;
-
-	pr_info("cpu%d hot remove!\n", cpu);
-
 	return 0;
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
deleted file mode 100644
index 3b69f2b847e0..000000000000
--- a/arch/loongarch/kernel/numa.c
+++ /dev/null
@@ -1,394 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Author:  Xiang Gao <gaoxiang@loongson.cn>
- *          Huacai Chen <chenhuacai@loongson.cn>
- *
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/mmzone.h>
-#include <linux/export.h>
-#include <linux/nodemask.h>
-#include <linux/swap.h>
-#include <linux/memblock.h>
-#include <linux/pfn.h>
-#include <linux/acpi.h>
-#include <linux/efi.h>
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <asm/bootinfo.h>
-#include <asm/loongson.h>
-#include <asm/numa.h>
-#include <asm/page.h>
-#include <asm/pgalloc.h>
-#include <asm/sections.h>
-#include <asm/time.h>
-
-int numa_off;
-unsigned char node_distances[MAX_NUMNODES][MAX_NUMNODES];
-EXPORT_SYMBOL(node_distances);
-
-static struct numa_meminfo numa_meminfo;
-cpumask_t cpus_on_node[MAX_NUMNODES];
-cpumask_t phys_cpus_on_node[MAX_NUMNODES];
-EXPORT_SYMBOL(cpus_on_node);
-
-/*
- * apicid, cpu, node mappings
- */
-s16 __cpuid_to_node[CONFIG_NR_CPUS] = {
-	[0 ... CONFIG_NR_CPUS - 1] = NUMA_NO_NODE
-};
-EXPORT_SYMBOL(__cpuid_to_node);
-
-nodemask_t numa_nodes_parsed __initdata;
-
-#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
-unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
-EXPORT_SYMBOL(__per_cpu_offset);
-
-static int __init pcpu_cpu_to_node(int cpu)
-{
-	return early_cpu_to_node(cpu);
-}
-
-static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
-{
-	if (early_cpu_to_node(from) == early_cpu_to_node(to))
-		return LOCAL_DISTANCE;
-	else
-		return REMOTE_DISTANCE;
-}
-
-void __init pcpu_populate_pte(unsigned long addr)
-{
-	populate_kernel_pte(addr);
-}
-
-void __init setup_per_cpu_areas(void)
-{
-	unsigned long delta;
-	unsigned int cpu;
-	int rc = -EINVAL;
-
-	if (pcpu_chosen_fc == PCPU_FC_AUTO) {
-		if (nr_node_ids >= 8)
-			pcpu_chosen_fc = PCPU_FC_PAGE;
-		else
-			pcpu_chosen_fc = PCPU_FC_EMBED;
-	}
-
-	/*
-	 * Always reserve area for module percpu variables.  That's
-	 * what the legacy allocator did.
-	 */
-	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
-		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-					    PERCPU_DYNAMIC_RESERVE, PMD_SIZE,
-					    pcpu_cpu_distance, pcpu_cpu_to_node);
-		if (rc < 0)
-			pr_warn("%s allocator failed (%d), falling back to page size\n",
-				pcpu_fc_names[pcpu_chosen_fc], rc);
-	}
-	if (rc < 0)
-		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE, pcpu_cpu_to_node);
-	if (rc < 0)
-		panic("cannot initialize percpu area (err=%d)", rc);
-
-	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
-	for_each_possible_cpu(cpu)
-		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
-}
-#endif
-
-/*
- * Get nodeid by logical cpu number.
- * __cpuid_to_node maps phyical cpu id to node, so we
- * should use cpu_logical_map(cpu) to index it.
- *
- * This routine is only used in early phase during
- * booting, after setup_per_cpu_areas calling and numa_node
- * initialization, cpu_to_node will be used instead.
- */
-int early_cpu_to_node(int cpu)
-{
-	int physid = cpu_logical_map(cpu);
-
-	if (physid < 0)
-		return NUMA_NO_NODE;
-
-	return __cpuid_to_node[physid];
-}
-
-void __init early_numa_add_cpu(int cpuid, s16 node)
-{
-	int cpu = __cpu_number_map[cpuid];
-
-	if (cpu < 0)
-		return;
-
-	cpumask_set_cpu(cpu, &cpus_on_node[node]);
-	cpumask_set_cpu(cpuid, &phys_cpus_on_node[node]);
-}
-
-void numa_add_cpu(unsigned int cpu)
-{
-	int nid = cpu_to_node(cpu);
-	cpumask_set_cpu(cpu, &cpus_on_node[nid]);
-}
-
-void numa_remove_cpu(unsigned int cpu)
-{
-	int nid = cpu_to_node(cpu);
-	cpumask_clear_cpu(cpu, &cpus_on_node[nid]);
-}
-
-static int __init numa_add_memblk_to(int nid, u64 start, u64 end,
-				     struct numa_meminfo *mi)
-{
-	/* ignore zero length blks */
-	if (start == end)
-		return 0;
-
-	/* whine about and ignore invalid blks */
-	if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
-		pr_warn("NUMA: Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
-			   nid, start, end - 1);
-		return 0;
-	}
-
-	if (mi->nr_blks >= NR_NODE_MEMBLKS) {
-		pr_err("NUMA: too many memblk ranges\n");
-		return -EINVAL;
-	}
-
-	mi->blk[mi->nr_blks].start = PFN_ALIGN(start);
-	mi->blk[mi->nr_blks].end = PFN_ALIGN(end - PAGE_SIZE + 1);
-	mi->blk[mi->nr_blks].nid = nid;
-	mi->nr_blks++;
-	return 0;
-}
-
-/**
- * numa_add_memblk - Add one numa_memblk to numa_meminfo
- * @nid: NUMA node ID of the new memblk
- * @start: Start address of the new memblk
- * @end: End address of the new memblk
- *
- * Add a new memblk to the default numa_meminfo.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int __init numa_add_memblk(int nid, u64 start, u64 end)
-{
-	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
-}
-
-static void __init node_mem_init(unsigned int node)
-{
-	unsigned long start_pfn, end_pfn;
-	unsigned long node_addrspace_offset;
-
-	node_addrspace_offset = nid_to_addrbase(node);
-	pr_info("Node%d's addrspace_offset is 0x%lx\n",
-			node, node_addrspace_offset);
-
-	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
-	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
-		node, start_pfn, end_pfn);
-
-	alloc_node_data(node);
-}
-
-#ifdef CONFIG_ACPI_NUMA
-
-static void __init add_node_intersection(u32 node, u64 start, u64 size, u32 type)
-{
-	static unsigned long num_physpages;
-
-	num_physpages += (size >> PAGE_SHIFT);
-	pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx Bytes\n",
-		node, type, start, size);
-	pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
-		start >> PAGE_SHIFT, (start + size) >> PAGE_SHIFT, num_physpages);
-	memblock_set_node(start, size, &memblock.memory, node);
-}
-
-/*
- * add_numamem_region
- *
- * Add a uasable memory region described by BIOS. The
- * routine gets each intersection between BIOS's region
- * and node's region, and adds them into node's memblock
- * pool.
- *
- */
-static void __init add_numamem_region(u64 start, u64 end, u32 type)
-{
-	u32 i;
-	u64 ofs = start;
-
-	if (start >= end) {
-		pr_debug("Invalid region: %016llx-%016llx\n", start, end);
-		return;
-	}
-
-	for (i = 0; i < numa_meminfo.nr_blks; i++) {
-		struct numa_memblk *mb = &numa_meminfo.blk[i];
-
-		if (ofs > mb->end)
-			continue;
-
-		if (end > mb->end) {
-			add_node_intersection(mb->nid, ofs, mb->end - ofs, type);
-			ofs = mb->end;
-		} else {
-			add_node_intersection(mb->nid, ofs, end - ofs, type);
-			break;
-		}
-	}
-}
-
-static void __init init_node_memblock(void)
-{
-	u32 mem_type;
-	u64 mem_end, mem_start, mem_size;
-	efi_memory_desc_t *md;
-
-	/* Parse memory information and activate */
-	for_each_efi_memory_desc(md) {
-		mem_type = md->type;
-		mem_start = md->phys_addr;
-		mem_size = md->num_pages << EFI_PAGE_SHIFT;
-		mem_end = mem_start + mem_size;
-
-		switch (mem_type) {
-		case EFI_LOADER_CODE:
-		case EFI_LOADER_DATA:
-		case EFI_BOOT_SERVICES_CODE:
-		case EFI_BOOT_SERVICES_DATA:
-		case EFI_PERSISTENT_MEMORY:
-		case EFI_CONVENTIONAL_MEMORY:
-			add_numamem_region(mem_start, mem_end, mem_type);
-			break;
-		case EFI_PAL_CODE:
-		case EFI_UNUSABLE_MEMORY:
-		case EFI_ACPI_RECLAIM_MEMORY:
-			add_numamem_region(mem_start, mem_end, mem_type);
-			fallthrough;
-		case EFI_RESERVED_TYPE:
-		case EFI_RUNTIME_SERVICES_CODE:
-		case EFI_RUNTIME_SERVICES_DATA:
-		case EFI_MEMORY_MAPPED_IO:
-		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
-			pr_info("Resvd: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx Bytes\n",
-					mem_type, mem_start, mem_size);
-			break;
-		}
-	}
-}
-
-static void __init numa_default_distance(void)
-{
-	int row, col;
-
-	for (row = 0; row < MAX_NUMNODES; row++)
-		for (col = 0; col < MAX_NUMNODES; col++) {
-			if (col == row)
-				node_distances[row][col] = LOCAL_DISTANCE;
-			else
-				/* We assume that one node per package here!
-				 *
-				 * A SLIT should be used for multiple nodes
-				 * per package to override default setting.
-				 */
-				node_distances[row][col] = REMOTE_DISTANCE;
-	}
-}
-
-/*
- * fake_numa_init() - For Non-ACPI systems
- * Return: 0 on success, -errno on failure.
- */
-static int __init fake_numa_init(void)
-{
-	phys_addr_t start = memblock_start_of_DRAM();
-	phys_addr_t end = memblock_end_of_DRAM() - 1;
-
-	node_set(0, numa_nodes_parsed);
-	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
-
-	return numa_add_memblk(0, start, end + 1);
-}
-
-int __init init_numa_memory(void)
-{
-	int i;
-	int ret;
-	int node;
-
-	for (i = 0; i < NR_CPUS; i++)
-		set_cpuid_to_node(i, NUMA_NO_NODE);
-
-	numa_default_distance();
-	nodes_clear(numa_nodes_parsed);
-	nodes_clear(node_possible_map);
-	nodes_clear(node_online_map);
-	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
-
-	/* Parse SRAT and SLIT if provided by firmware. */
-	ret = acpi_disabled ? fake_numa_init() : acpi_numa_init();
-	if (ret < 0)
-		return ret;
-
-	node_possible_map = numa_nodes_parsed;
-	if (WARN_ON(nodes_empty(node_possible_map)))
-		return -EINVAL;
-
-	init_node_memblock();
-	if (!memblock_validate_numa_coverage(SZ_1M))
-		return -EINVAL;
-
-	for_each_node_mask(node, node_possible_map) {
-		node_mem_init(node);
-		node_set_online(node);
-	}
-	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
-
-	setup_nr_node_ids();
-	loongson_sysconf.nr_nodes = nr_node_ids;
-	loongson_sysconf.cores_per_node = cpumask_weight(&phys_cpus_on_node[0]);
-
-	return 0;
-}
-
-#endif
-
-void __init paging_init(void)
-{
-	unsigned int node;
-	unsigned long zones_size[MAX_NR_ZONES] = {0, };
-
-	for_each_online_node(node) {
-		unsigned long start_pfn, end_pfn;
-
-		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
-
-		if (end_pfn > max_low_pfn)
-			max_low_pfn = end_pfn;
-	}
-#ifdef CONFIG_ZONE_DMA32
-	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
-#endif
-	zones_size[ZONE_NORMAL] = max_low_pfn;
-	free_area_init(zones_size);
-}
-
-void __init mem_init(void)
-{
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
-	memblock_free_all();
-}
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 0f0740f0be27..8595db25e8ea 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -346,6 +346,24 @@ static void __init bootcmdline_init(char **cmdline_p)
 	*cmdline_p = boot_command_line;
 }
 
+#ifdef CONFIG_NUMA
+static void __init init_numa_memory(void)
+{
+	int cpu;
+
+	arch_numa_init();
+	loongson_sysconf.nr_nodes = nr_node_ids;
+	loongson_sysconf.cores_per_node = 0;
+
+	for_each_possible_cpu(cpu) {
+		int nid = cpu_to_node(cpu);
+
+		if (nid == 0)
+			loongson_sysconf.cores_per_node++;
+	}
+}
+#endif
+
 void __init platform_init(void)
 {
 	arch_reserve_vmcore();
@@ -359,7 +377,6 @@ void __init platform_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 	unflatten_and_copy_device_tree();
-
 #ifdef CONFIG_NUMA
 	init_numa_memory();
 #endif
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab86aae..c14f067ce65b 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -296,8 +296,7 @@ static void __init fdt_smp_setup(void)
 		__cpu_number_map[cpuid] = cpu;
 		__cpu_logical_map[cpu] = cpuid;
 
-		early_numa_add_cpu(cpu, 0);
-		set_cpuid_to_node(cpuid, 0);
+		early_map_cpu_to_node(cpu, of_node_to_nid(node));
 	}
 
 	loongson_sysconf.nr_cpus = num_processors;
@@ -366,9 +365,7 @@ void loongson_init_secondary(void)
 
 	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
 
-#ifdef CONFIG_NUMA
 	numa_add_cpu(cpu);
-#endif
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
 	cpu_data[cpu].package =
 		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
@@ -393,9 +390,7 @@ int loongson_cpu_disable(void)
 	if (io_master(cpu))
 		return -EBUSY;
 
-#ifdef CONFIG_NUMA
 	numa_remove_cpu(cpu);
-#endif
 	set_cpu_online(cpu, false);
 	clear_cpu_sibling_map(cpu);
 	calculate_cpu_foreign_map();
@@ -478,42 +473,17 @@ core_initcall(ipi_pm_init);
 /* Preload SMP state for boot cpu */
 void smp_prepare_boot_cpu(void)
 {
-	unsigned int cpu, node, rr_node;
-
 	set_cpu_possible(0, true);
 	set_cpu_online(0, true);
 	set_my_cpu_offset(per_cpu_offset(0));
 	numa_add_cpu(0);
-
-	rr_node = first_node(node_online_map);
-	for_each_possible_cpu(cpu) {
-		node = early_cpu_to_node(cpu);
-
-		/*
-		 * The mapping between present cpus and nodes has been
-		 * built during MADT and SRAT parsing.
-		 *
-		 * If possible cpus = present cpus here, early_cpu_to_node
-		 * will return valid node.
-		 *
-		 * If possible cpus > present cpus here (e.g. some possible
-		 * cpus will be added by cpu-hotplug later), for possible but
-		 * not present cpus, early_cpu_to_node will return NUMA_NO_NODE,
-		 * and we just map them to online nodes in round-robin way.
-		 * Once hotplugged, new correct mapping will be built for them.
-		 */
-		if (node != NUMA_NO_NODE)
-			set_cpu_numa_node(cpu, node);
-		else {
-			set_cpu_numa_node(cpu, rr_node);
-			rr_node = next_node_in(rr_node, node_online_map);
-		}
-	}
 }
 
 /* called from main before smp_init() */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	int cpu;
+
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
 	loongson_prepare_cpus(max_cpus);
@@ -523,6 +493,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 #ifndef CONFIG_HOTPLUG_CPU
 	init_cpu_present(cpu_possible_mask);
 #endif
+
+	for_each_possible_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+
+		numa_store_cpu_info(cpu);
+	}
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 8a87a482c8f4..f4b40a17e825 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -60,7 +60,6 @@ int __ref page_is_ram(unsigned long pfn)
 	return memblock_is_memory(addr) && !memblock_is_reserved(addr);
 }
 
-#ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
@@ -78,12 +77,11 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-	max_mapnr = max_low_pfn;
+	set_max_mapnr(max_low_pfn);
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	memblock_free_all();
 }
-#endif /* !CONFIG_NUMA */
 
 void __ref free_initmem(void)
 {
@@ -117,14 +115,6 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 		page += vmem_altmap_offset(altmap);
 	__remove_pages(start_pfn, nr_pages, altmap);
 }
-
-#ifdef CONFIG_NUMA
-int memory_add_physaddr_to_nid(u64 start)
-{
-	return pa_to_nid(start);
-}
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
-#endif
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP

-- 
2.46.0


