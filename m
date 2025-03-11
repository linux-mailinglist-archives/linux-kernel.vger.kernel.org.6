Return-Path: <linux-kernel+bounces-555608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D64A5BA35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E938E3B0B75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F9A224245;
	Tue, 11 Mar 2025 07:51:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4422422D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679517; cv=none; b=EVTV9Ha/jUe+b9pQdVHXcX/tqtNUZmCiErf8fpWIyi7VaOAv4+SVY1ccIeJCyL9gE2xVE0O0HICQ7hivsHF2zFRH6DgARkJexqxLULipTKiSqLlDslrMOxL6BDJsGEtQtX100LcXYJ3hWawgrC+iHcqMXux5Ozvx/XnfCCsAVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679517; c=relaxed/simple;
	bh=d9Vux/Bh223fkL9NJtsGZZSK4kmK6Mjfi0SOofbOVM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8DcAWPzIJbxSbk+dWDAe4zNAE2ElpAkIIgzr1KUhQadsnhkfVctCyrQc2IggjR9iMU7p7p+Gl0LBdJVp7VhfXJnmRY8yFNJX63donOx3ANeOK0NxFOGGD+ZuKTgIAYtd0OdJGPELjmeOiHWM+ar4QjtJbJEqW/3yp+mhY8aEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZBm7g0hW8z2RTQn;
	Tue, 11 Mar 2025 15:47:27 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 392321A0188;
	Tue, 11 Mar 2025 15:51:47 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Mar 2025 15:51:46 +0800
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
Subject: [PATCH v12 1/4] cpu/SMT: Provide a default topology_is_primary_thread()
Date: Tue, 11 Mar 2025 15:51:40 +0800
Message-ID: <20250311075143.61078-2-yangyicong@huawei.com>
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

Currently if architectures want to support HOTPLUG_SMT they need to
provide a topology_is_primary_thread() telling the framework which
thread in the SMT cannot offline. However arm64 doesn't have a
restriction on which thread in the SMT cannot offline, a simplest
choice is that just make 1st thread as the "primary" thread. So
just make this as the default implementation in the framework and
let architectures like x86 that have special primary thread to
override this function (which they've already done).

There's no need to provide a stub function if !CONFIG_SMP or
!CONFIG_HOTPLUG_SMT. In such case the testing CPU is already
the 1st CPU in the SMT so it's always the primary thread.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Pre questioned in v9 [1] whether this works on architectures not using
CONFIG_GENERIC_ARCH_TOPOLOGY, See [2] for demonstration hacking on LoongArch
VM and this also works. Architectures should use this on their own situation.
[1] https://lore.kernel.org/linux-arm-kernel/427bd639-33c3-47e4-9e83-68c428eb1a7d@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/a5690fee-3019-f26c-8bad-1d95e388e877@huawei.com/

 arch/powerpc/include/asm/topology.h |  1 +
 arch/x86/include/asm/topology.h     |  2 +-
 include/linux/topology.h            | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 16bacfe8c7a2..da15b5efe807 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -152,6 +152,7 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 {
 	return cpu == cpu_first_thread_sibling(cpu);
 }
+#define topology_is_primary_thread topology_is_primary_thread
 
 static inline bool topology_smt_thread_allowed(unsigned int cpu)
 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index ec134b719144..6c79ee7c0957 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -229,11 +229,11 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
 }
+#define topology_is_primary_thread topology_is_primary_thread
 
 #else /* CONFIG_SMP */
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
-static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline unsigned int topology_amd_nodes_per_pkg(void) { return 1; }
 #endif /* !CONFIG_SMP */
 
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3..6ae995e18ff5 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -240,6 +240,30 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
 
+#ifndef topology_is_primary_thread
+
+#define topology_is_primary_thread topology_is_primary_thread
+
+static inline bool topology_is_primary_thread(unsigned int cpu)
+{
+	/*
+	 * When disabling SMT the primary thread of the SMT will remain
+	 * enabled/active. Architectures do have a special primary thread
+	 * (e.g. x86) needs to override this function. Otherwise can make
+	 * the first thread in the SMT as the primary thread.
+	 *
+	 * The sibling cpumask of an offline CPU contains always the CPU
+	 * itself for architectures using the implementation of
+	 * CONFIG_GENERIC_ARCH_TOPOLOGY for building their topology.
+	 * Other architectures not using CONFIG_GENERIC_ARCH_TOPOLOGY for
+	 * building their topology have to check whether to use this default
+	 * implementation or to override it.
+	 */
+	return cpu == cpumask_first(topology_sibling_cpumask(cpu));
+}
+
+#endif
+
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
-- 
2.24.0


