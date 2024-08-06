Return-Path: <linux-kernel+bounces-276132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4A3948EEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B641F22F97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E661C578D;
	Tue,  6 Aug 2024 12:16:01 +0000 (UTC)
Received: from njjs-sys-mailin01.njjs.baidu.com (mx313.baidu.com [180.101.52.140])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203AC1C5788
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946561; cv=none; b=qCLlYawaybITNC5fU8rLptbQ6X1id1vtPG9XDm3xKok5mm4YSswcvWCCYvzE5SGjYlF6RWofkWp2juqlsHZpr5haXPB88bTFiV8yHAAWeNFGCbpMcO4V8jH+/7jZrKH2F8+o3V250ityv9HrpcVRk5duwHc+06BO3aC+a8QkC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946561; c=relaxed/simple;
	bh=TytV68QddyNnY52A7MdFl09H9DUSm5ch6y9xQ/iisug=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tBucajCKxNIezWcAM/JmljhaJK2997CLnXN2X4WqO9ko6478rxFuNW7+3DaB6hyHbZfnhNLBX7dHAT9VcdlG9eO6UG53/gbQsV3soVZWFI69+ZD2aZhJbJblAL3cbspXKsEUiX5Lf0rOXVg/ZJv/+SnNTUTKsBd0Jvvon85wTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 056127F0003D;
	Tue,  6 Aug 2024 20:08:25 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: mingo@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] x86/mm: Don't print out SRAT table information
Date: Tue,  6 Aug 2024 20:08:23 +0800
Message-Id: <20240806120823.17111-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This Per-CPU log is becoming longer with more and more CPUs in system,
so don't print it, to make the CPU bootup faster; If people want to
know SRAT information, they can find it by lscpu

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/mm/srat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 9c52a95..6f8e0f2 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -57,8 +57,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
-	       pxm, apic_id, node);
+	pr_debug("SRAT: PXM %u -> APIC 0x%04x -> Node %u\n", pxm, apic_id, node);
 }
 
 /* Callback for Proximity Domain -> LAPIC mapping */
@@ -98,8 +97,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
-	       pxm, apic_id, node);
+	pr_debug("SRAT: PXM %u -> APIC 0x%02x -> Node %u\n", pxm, apic_id, node);
 }
 
 int __init x86_acpi_numa_init(void)
-- 
2.9.4


