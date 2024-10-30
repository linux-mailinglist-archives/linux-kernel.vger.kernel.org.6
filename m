Return-Path: <linux-kernel+bounces-388713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EA9B6371
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA251C20E00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F81EB9E0;
	Wed, 30 Oct 2024 12:54:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412231E906A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292897; cv=none; b=NAgU1BexF+KwXmf7ySIbG80SX6DrCA957u1lOJ40jpZjdeh6AwNo/Ta0Px2zqNIjvq9UWwnKdgKYN3cTHbirZtdG92Gudo79WYRnvhBUpv0cdi89kLNMY+1PcR/pVgMmcxe+fMqvBS74ayosa9AAx/k6yB2xJPDKae4hz10i9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292897; c=relaxed/simple;
	bh=/hxCQSJK9ykx9hD6UnA35QbL4TP2w+ZIDQZJ5L4VnwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtFnL8wZZFnsq4avNI1mCSwAH1xksB55ZSauNbuI8k/l+ILE2AwbYio5JMniGj/ysb3220JZ7K0yENlzXwyaemG1sayMxAJWO5jrtT7yw0qHO46bZR37uDyf4Rer6AFs71zmL5PKe+KX4cjhvbLFWJDKQH+fjp8+Op4pppoUOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xdn8f25pyz10P6Z;
	Wed, 30 Oct 2024 20:52:34 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CE251400DC;
	Wed, 30 Oct 2024 20:54:45 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 30 Oct 2024 20:54:44 +0800
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
Subject: [PATCH v7 1/4] cpu/SMT: Provide a default topology_is_primary_thread()
Date: Wed, 30 Oct 2024 20:54:12 +0800
Message-ID: <20241030125415.18994-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20241030125415.18994-1-yangyicong@huawei.com>
References: <20241030125415.18994-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
!CONFIG_HOTPLUG_SMP. In such case the testing CPU is already
the 1st CPU in the SMT so it's always the primary thread.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/powerpc/include/asm/topology.h |  1 +
 arch/x86/include/asm/topology.h     |  2 +-
 include/linux/topology.h            | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

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
index aef70336d624..3a7c18851016 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -219,11 +219,11 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
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
index 52f5850730b3..9c9f6b9f3462 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -240,6 +240,20 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif
 
+#ifndef topology_is_primary_thread
+#define topology_is_primary_thread topology_is_primary_thread
+static inline bool topology_is_primary_thread(unsigned int cpu)
+{
+	/*
+	 * On SMT hotplug the primary thread of the SMT won't be disabled.
+	 * Architectures do have a special primary thread (e.g. x86) need
+	 * to override this function. Otherwise just make the first thread
+	 * in the SMT as the primary thread.
+	 */
+	return cpu == cpumask_first(topology_sibling_cpumask(cpu));
+}
+#endif
+
 static inline const struct cpumask *cpu_cpu_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
-- 
2.24.0


