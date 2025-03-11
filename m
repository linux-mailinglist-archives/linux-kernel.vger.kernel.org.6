Return-Path: <linux-kernel+bounces-555607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62659A5BA33
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFBE3B0B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F73224244;
	Tue, 11 Mar 2025 07:51:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCE022422A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679517; cv=none; b=WD9aPVaCfCcpa5DMSjzGyBd5X5jO/iqffKPAIQDjfp9i8frW8oJ4ZnpQpCX68cnwRN3rOmr/AgpcoQBax5V4qAD9st3FXH0EPUfxX+bxpbVVjijpf7xjrZh8Sdr3ra8UgXrsWdugjd5ddA6RS6qIsh/9E2mHUxdxOCKSvK8Lj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679517; c=relaxed/simple;
	bh=LTw3sIdttClMYJDhuYcNqZcDUZWinADAyvvfY7o3kng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wm6eXfv2Hwmme0iwn+/mObKKNKCN0jaC2SVkanvMtJDpeuebP4dc4ODRXU16t0yHpcgbd2NThzhhM2JX1PNxiLrFEgaIXgrYXVUYHn79W7O5AYNYDjUDUcae5Gs3yhQ+Bf6P/3Bep68wVlkwAn1aHEJ+5TrnBFZzHErxkKbwqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZBm7h0CXBz2RTR0;
	Tue, 11 Mar 2025 15:47:28 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 27B0F1402CD;
	Tue, 11 Mar 2025 15:51:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Mar 2025 15:51:47 +0800
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
	<guohanjun@huawei.com>, <sshegde@linux.ibm.com>
Subject: [PATCH v12 2/4] arch_topology: Support SMT control for OF based system
Date: Tue, 11 Mar 2025 15:51:41 +0800
Message-ID: <20250311075143.61078-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250311075143.61078-1-yangyicong@huawei.com>
References: <20250311075143.61078-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

On building the topology from the devicetree, we've already gotten the
SMT thread number of each core. Update the largest SMT thread number
and enable the SMT control by the end of topology parsing.

The framework's SMT control provides two interface to the users [1]
through /sys/devices/system/cpu/smt/control:
1) enable SMT by writing "on" and disable by "off"
2) enable SMT by writing max_thread_number or disable by writing 1

Both method support to completely disable/enable the SMT cores so both
work correctly for symmetric SMT platform and asymmetric platform with
non-SMT and one type SMT cores like:
core A: 1 thread
core B: X (X!=1) threads

Note that for a theoretically possible multiple SMT-X (X>1) core
platform the SMT control is also supported as expected but only
by writing the "on/off" method.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/base/arch_topology.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 3ebe77566788..d409d323ee64 100644
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
@@ -506,6 +507,10 @@ core_initcall(free_raw_capacity);
 #endif
 
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+
+/* Used to enable the SMT control */
+static unsigned int max_smt_thread_num = 1;
+
 /*
  * This function returns the logic cpu number of the node.
  * There are basically three kinds of return values:
@@ -565,6 +570,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 		i++;
 	} while (1);
 
+	max_smt_thread_num = max_t(unsigned int, max_smt_thread_num, i);
+
 	cpu = get_cpu_for_node(core);
 	if (cpu >= 0) {
 		if (!leaf) {
@@ -677,6 +684,17 @@ static int __init parse_socket(struct device_node *socket)
 	if (!has_socket)
 		ret = parse_cluster(socket, 0, -1, 0);
 
+	/*
+	 * Reset the max_smt_thread_num to 1 on failure. Since on failure
+	 * we need to notify the framework the SMT is not supported, but
+	 * max_smt_thread_num can be initialized to the SMT thread number
+	 * of the cores which are successfully parsed.
+	 */
+	if (ret)
+		max_smt_thread_num = 1;
+
+	cpu_smt_set_num_threads(max_smt_thread_num, max_smt_thread_num);
+
 	return ret;
 }
 
-- 
2.24.0


