Return-Path: <linux-kernel+bounces-365011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDAF99DC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E932834B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002DC171E70;
	Tue, 15 Oct 2024 02:19:10 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5ED21364
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958749; cv=none; b=m1ip71yHHm7Q8PLLnJwTN2lGz5vJcr1w9qt6/a5VQ459pHSLN/povyqVqb7kAHmUogOitbXt3c57fVlTVDBxsnP75GsYecZFi5i8Tax1/CJQRfIdEHOFZgakXRuYsgso7X56gu/1FOGhJ0pH6/OfaSiXmmL9oqZtFmIkHIH0EWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958749; c=relaxed/simple;
	bh=i4Ezsk4sswXmM8+75vLQ+XIw4KUArIJcmLv5eTEIPmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkC1PfV6XXShtgmFDFZ4xrbgsGeAir26AuDCJoM/mkLAFv8FaKX/fR6yai0w47VKjGARfCD7IGAaJKYA32qiWPDoPGUhBOGiutf2F+0EFdM/aYen6tnaxSd9/te2zJw3pC2+oxMgebz1HcUxCSVuOCFXy21TkNNpIcKrODPNF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XSHpd5cThz1ymC8;
	Tue, 15 Oct 2024 10:19:05 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DE6A1400D4;
	Tue, 15 Oct 2024 10:19:00 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 15 Oct 2024 10:18:59 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<dietmar.eggemann@arm.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>
Subject: [PATCH v6 2/4] arch_topology: Support SMT control for OF based system
Date: Tue, 15 Oct 2024 10:18:39 +0800
Message-ID: <20241015021841.35713-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20241015021841.35713-1-yangyicong@huawei.com>
References: <20241015021841.35713-1-yangyicong@huawei.com>
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

On building the topology from the devicetree, we've already
gotten the SMT thread number of each core. Update the largest
SMT thread number and enable the SMT control by the end of
topology parsing.

The core's SMT control provides two interface to the users [1]:
1) enable/disable SMT by writing on/off
2) enable/disable SMT by writing thread number 1/max_thread_number

If a system have more than one SMT thread number the 2) may
not handle it well, since there're multiple thread numbers in the
system and 2) only accept 1/max_thread_number. So issue a warning
to notify the users if such system detected.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/base/arch_topology.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 75fcb75d5515..5eed864df5e6 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -11,6 +11,7 @@
 #include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_smt.h>
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/slab.h>
@@ -28,6 +29,7 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
+static unsigned int max_smt_thread_num;
 DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
 EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
@@ -561,6 +563,17 @@ static int __init parse_core(struct device_node *core, int package_id,
 		i++;
 	} while (1);
 
+	if (max_smt_thread_num < i)
+		max_smt_thread_num = i;
+
+	/*
+	 * If max_smt_thread_num has been initialized and doesn't match
+	 * the thread number of this entry, then the system has
+	 * heterogeneous SMT topology.
+	 */
+	if (max_smt_thread_num && max_smt_thread_num != i)
+		pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
+
 	cpu = get_cpu_for_node(core);
 	if (cpu >= 0) {
 		if (!leaf) {
@@ -673,6 +686,14 @@ static int __init parse_socket(struct device_node *socket)
 	if (!has_socket)
 		ret = parse_cluster(socket, 0, -1, 0);
 
+	/*
+	 * Notify the CPU framework of the SMT support. A thread number of 1
+	 * can be handled by the framework so we don't need to check
+	 * max_smt_thread_num to see we support SMT or not.
+	 */
+	if (max_smt_thread_num)
+		cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
+
 	return ret;
 }
 
-- 
2.24.0


