Return-Path: <linux-kernel+bounces-363288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6190E99C00D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3372811E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671F140E34;
	Mon, 14 Oct 2024 06:33:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEC15588E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887614; cv=none; b=Yb25vEbp+iyJykRzYp3ITZkjENBBVoaG/NbOJFIHfrXY5e7lOuLBip2c5wvy5YO3cLMHYyheoE9Ol3TaeIsd58C4/vThyDV6l7nRpZE1RwdB0khDyXaa95Nv0GE8C8GQT8eyzsZD13iwNKpZQscCLQMXZYwP+v9x4e5sF1RCLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887614; c=relaxed/simple;
	bh=ATFJB2+9v9R3OXCyxBrZXx1J0y4hgsTiPnESDstLL6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8ijqQI/mZOgd747vuzMGSgTN4u+Fh4T3ZuX6WBfVwRoVmH4wKUvzW2vm6wanx4SVBtTPLiz4fmP9px8y4PpsbnvqC89DOcYFex0DcS3KiQqW4g8+vwc/xuntkqZIMPLhxU1CqSo+IrEmrgKDQepl0P2VB7RqarNyFEPs+gVzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axhok5uwxnSEcaAA--.37880S3;
	Mon, 14 Oct 2024 14:33:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMBxXuQ4uwxn09AoAA--.2444S2;
	Mon, 14 Oct 2024 14:33:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH] LoongArch: Fix cpu hotplug issue
Date: Mon, 14 Oct 2024 14:33:28 +0800
Message-Id: <20241014063328.1216497-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxXuQ4uwxn09AoAA--.2444S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch system, there are two places to set cpu numa node. One
is in arch specified function smp_prepare_boot_cpu(), the other is
in generic function early_numa_node_init(). The latter will overwrite
the numa node information.

However for hot-added cpu, cpu_logical_map() fails to its physical
cpuid at beginning since it is not enabled in ACPI MADT table. So
function early_cpu_to_node() also fails to get its numa node for
hot-added cpu, and generic function early_numa_node_init() will
overwrite incorrect numa node.

Here static array __cpu_to_node and api set_early_cpu_to_node()
is added, so that early_cpu_to_node is consistent with function
cpu_to_node() for hot-added cpu.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/numa.h |  2 ++
 arch/loongarch/kernel/numa.c      | 10 +++++++++-
 arch/loongarch/kernel/smp.c       |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
index b5f9de9f102e..e8e6fcfb006a 100644
--- a/arch/loongarch/include/asm/numa.h
+++ b/arch/loongarch/include/asm/numa.h
@@ -50,6 +50,7 @@ static inline void set_cpuid_to_node(int cpuid, s16 node)
 }
 
 extern int early_cpu_to_node(int cpu);
+extern void set_early_cpu_to_node(int cpu, s16 node);
 
 #else
 
@@ -57,6 +58,7 @@ static inline void early_numa_add_cpu(int cpuid, s16 node)	{ }
 static inline void numa_add_cpu(unsigned int cpu)		{ }
 static inline void numa_remove_cpu(unsigned int cpu)		{ }
 static inline void set_cpuid_to_node(int cpuid, s16 node)	{ }
+static inline void set_early_cpu_to_node(int cpu, s16 node)	{ }
 
 static inline int early_cpu_to_node(int cpu)
 {
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 84fe7f854820..62508aace644 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -34,6 +34,9 @@ static struct numa_meminfo numa_meminfo;
 cpumask_t cpus_on_node[MAX_NUMNODES];
 cpumask_t phys_cpus_on_node[MAX_NUMNODES];
 EXPORT_SYMBOL(cpus_on_node);
+static s16 __cpu_to_node[NR_CPUS] = {
+	[0 ... CONFIG_NR_CPUS - 1] = NUMA_NO_NODE
+};
 
 /*
  * apicid, cpu, node mappings
@@ -117,11 +120,16 @@ int early_cpu_to_node(int cpu)
 	int physid = cpu_logical_map(cpu);
 
 	if (physid < 0)
-		return NUMA_NO_NODE;
+		return __cpu_to_node[cpu];
 
 	return __cpuid_to_node[physid];
 }
 
+void set_early_cpu_to_node(int cpu, s16 node)
+{
+	__cpu_to_node[cpu] = node;
+}
+
 void __init early_numa_add_cpu(int cpuid, s16 node)
 {
 	int cpu = __cpu_number_map[cpuid];
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 9afc2d8b3414..998668be858c 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -512,6 +512,7 @@ void __init smp_prepare_boot_cpu(void)
 			set_cpu_numa_node(cpu, node);
 		else {
 			set_cpu_numa_node(cpu, rr_node);
+			set_early_cpu_to_node(cpu, rr_node);
 			rr_node = next_node_in(rr_node, node_online_map);
 		}
 	}

base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
-- 
2.39.3


