Return-Path: <linux-kernel+bounces-275914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B34948BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F0E1C22EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD61BE846;
	Tue,  6 Aug 2024 08:59:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3701BD507
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934778; cv=none; b=l/d9pFL+L2lz9rwKHW6OC7nGMSxnAO4vzdKjjbyfGLr+3kDNj8NKqjshqyC1dCBUGDCUfDmZ+YbzZEmFJlTTVVY3pSk6XEdNcZpGFxwMoZAw4kyBwG/d3JyrxX05SOWVE04r5AHcZDPEHSMbaA9ii7bS5U0RjhSjJoMxkvHtFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934778; c=relaxed/simple;
	bh=ug6TQ0Oc1jLSDCX8oHX8vABMdkpnSFcNVdIGOcgjyDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMA24dwWRnp+KXICpuSjK2r4RP0/iZ8obvw0oVM0zTqDEAjKMUGN/HdQNHbRRIIxhW7pzX+IAGloP3rje+6zamDvwzPZJfxhL/JhDTHgeJLsoVtfAoNIh3hBA6w4zNVK/Fv7106yZ55UnQ4Q/XDj1UnmaI1ZTjK4jEI1oopeW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WdRvv15sVzQngm;
	Tue,  6 Aug 2024 16:55:07 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id A30A118009B;
	Tue,  6 Aug 2024 16:59:32 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 6 Aug 2024 16:59:31 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>
Subject: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI based system
Date: Tue, 6 Aug 2024 16:53:19 +0800
Message-ID: <20240806085320.63514-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240806085320.63514-1-yangyicong@huawei.com>
References: <20240806085320.63514-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

For ACPI we'll build the topology from PPTT and we cannot directly
get the SMT number of each core. Instead using a temporary xarray
to record the SMT number of each core when building the topology
and we can know the largest SMT number in the system. Then we can
enable the support of SMT control.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/kernel/topology.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a2c72f3e7f8..f72e1e55b05e 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -15,8 +15,10 @@
 #include <linux/arch_topology.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_smt.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/xarray.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -43,11 +45,16 @@ static bool __init acpi_cpu_is_threaded(int cpu)
  */
 int __init parse_acpi_topology(void)
 {
+	int thread_num, max_smt_thread_num = 1;
+	struct xarray core_threads;
 	int cpu, topology_id;
+	void *entry;
 
 	if (acpi_disabled)
 		return 0;
 
+	xa_init(&core_threads);
+
 	for_each_possible_cpu(cpu) {
 		topology_id = find_acpi_cpu_topology(cpu, 0);
 		if (topology_id < 0)
@@ -57,6 +64,20 @@ int __init parse_acpi_topology(void)
 			cpu_topology[cpu].thread_id = topology_id;
 			topology_id = find_acpi_cpu_topology(cpu, 1);
 			cpu_topology[cpu].core_id   = topology_id;
+
+			entry = xa_load(&core_threads, topology_id);
+			if (!entry) {
+				xa_store(&core_threads, topology_id,
+					 xa_mk_value(1), GFP_KERNEL);
+			} else {
+				thread_num = xa_to_value(entry);
+				thread_num++;
+				xa_store(&core_threads, topology_id,
+					 xa_mk_value(thread_num), GFP_KERNEL);
+
+				if (thread_num > max_smt_thread_num)
+					max_smt_thread_num = thread_num;
+			}
 		} else {
 			cpu_topology[cpu].thread_id  = -1;
 			cpu_topology[cpu].core_id    = topology_id;
@@ -67,6 +88,9 @@ int __init parse_acpi_topology(void)
 		cpu_topology[cpu].package_id = topology_id;
 	}
 
+	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
+
+	xa_destroy(&core_threads);
 	return 0;
 }
 #endif
-- 
2.24.0


