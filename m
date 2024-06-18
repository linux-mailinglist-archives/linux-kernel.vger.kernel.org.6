Return-Path: <linux-kernel+bounces-218848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF890C6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0851B21D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A814C5A3;
	Tue, 18 Jun 2024 08:16:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C73C13A272;
	Tue, 18 Jun 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698610; cv=none; b=kLr/r5LkuukWsZG8bDE5nx+zd28dtB7OwE1ltuD60mhtDSNfPTumxl7W6pYhUuq5gSb+lkWv6qEmXazSVgBayH44OlzyIGCrEfSmhffn7D/+ZLTPMnJ4ZRyTl1tL9K8OemGGRROMebaIQcaSRiV5N4Xtp24d45dpeI6BZvBc2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698610; c=relaxed/simple;
	bh=QkCmAAUod9n4KGAifdFH23eiokidB9zlzC26O9n+bgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQnTqJX8TmTHVlk2WgIcNXVXe9Aq/x0EVL9NW4HKAVQ6ID0GOW0FKhLwLKK3clcAXUl8ieaoj+yij7vbLpZKdxah4w0KnhTcFqKkYzyLhHr13sFNMvbFfNBmf8imQKPhVbTjk3utdAsWJqN8N++TgIuXwhbyKz4a0t3+/t+3Odw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C61C3277B;
	Tue, 18 Jun 2024 08:16:47 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Always enumerate MADT and setup logical-physical CPU mapping
Date: Tue, 18 Jun 2024 16:16:30 +0800
Message-ID: <20240618081630.3997018-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers want to use cpu_logical_map(), early_cpu_to_node() and some
other CPU mapping APIs, even if we use "nr_cpus=1" to hard limit the CPU
number. This is strongly required for the multi-bridges machines.

Currently, we stop parsing the MADT if the nr_cpus limit is reached, but
to achieve the above goal we should always enumerate the MADT table and
setup logical-physical CPU mapping whether there is a nr_cpus limit.

Rework the MADT enumeration:

1. Define a flag "cpu_enumerated" to distinguish the first enumeration
   (cpu_enumerated=0) and the physical hotplug case (cpu_enumerated=1)
   for set_processor_mask().

2. If cpu_enumerated=0, stop parsing only when NR_CPUS limit is reached,
   so we can setup logical-physical CPU mapping; if cpu_enumerated=1,
   stop parsing when nr_cpu_ids limit is reached, so we can avoid some
   runtime bugs. Once logical-physical CPU mapping is setup, we will let
   cpu_enumerated=1.

3. Use find_first_zero_bit() instead of cpumask_next_zero() to find the
   next zero bit (free logical CPU id) in the cpu_present_mask, because
   cpumask_next_zero() will stop at nr_cpu_ids.

4. Only touch cpu_possible_mask if cpu_enumerated=0, this is in order to
   avoid some potential crashes, because cpu_possible_mask is marked as
   __ro_after_init.

5. In prefill_possible_map(), clear cpu_present_mask bits greater than
   nr_cpu_ids, in order to avoid a CPU be "present" but not "possible".

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/acpi.c  | 22 ++++++++++++++++------
 arch/loongarch/kernel/setup.c |  4 +++-
 arch/loongarch/kernel/smp.c   |  7 +++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 5cf59c617126..929a497c987e 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -57,15 +57,22 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		return ioremap_cache(phys, size);
 }
 
+static int cpu_enumerated = 0;
+
 #ifdef CONFIG_SMP
 static int set_processor_mask(u32 id, u32 flags)
 {
-
+	int nr_cpus;
 	int cpu, cpuid = id;
 
-	if (num_processors >= nr_cpu_ids) {
-		pr_warn(PREFIX "nr_cpus/possible_cpus limit of %i reached."
-			" processor 0x%x ignored.\n", nr_cpu_ids, cpuid);
+	if (!cpu_enumerated)
+		nr_cpus = NR_CPUS;
+	else
+		nr_cpus = nr_cpu_ids;
+
+	if (num_processors >= nr_cpus) {
+		pr_warn(PREFIX "nr_cpus limit of %i reached."
+			" processor 0x%x ignored.\n", nr_cpus, cpuid);
 
 		return -ENODEV;
 
@@ -73,11 +80,13 @@ static int set_processor_mask(u32 id, u32 flags)
 	if (cpuid == loongson_sysconf.boot_cpu_id)
 		cpu = 0;
 	else
-		cpu = cpumask_next_zero(-1, cpu_present_mask);
+		cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
+
+	if (!cpu_enumerated)
+		set_cpu_possible(cpu, true);
 
 	if (flags & ACPI_MADT_ENABLED) {
 		num_processors++;
-		set_cpu_possible(cpu, true);
 		set_cpu_present(cpu, true);
 		__cpu_number_map[cpuid] = cpu;
 		__cpu_logical_map[cpu] = cpuid;
@@ -138,6 +147,7 @@ static void __init acpi_process_madt(void)
 	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
 			acpi_parse_eio_master, MAX_IO_PICS);
 
+	cpu_enumerated = 1;
 	loongson_sysconf.nr_cpus = num_processors;
 }
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 3d048f1be143..0f0740f0be27 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -576,8 +576,10 @@ static void __init prefill_possible_map(void)
 
 	for (i = 0; i < possible; i++)
 		set_cpu_possible(i, true);
-	for (; i < NR_CPUS; i++)
+	for (; i < NR_CPUS; i++) {
+		set_cpu_present(i, false);
 		set_cpu_possible(i, false);
+	}
 
 	set_nr_cpu_ids(possible);
 }
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 1436d2465939..03b2b7669cf5 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -271,11 +271,10 @@ static void __init fdt_smp_setup(void)
 		if (cpuid >= nr_cpu_ids)
 			continue;
 
-		if (cpuid == loongson_sysconf.boot_cpu_id) {
+		if (cpuid == loongson_sysconf.boot_cpu_id)
 			cpu = 0;
-		} else {
-			cpu = cpumask_next_zero(-1, cpu_present_mask);
-		}
+		else
+			cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
 
 		num_processors++;
 		set_cpu_possible(cpu, true);
-- 
2.43.0


