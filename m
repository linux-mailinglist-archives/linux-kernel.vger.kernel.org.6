Return-Path: <linux-kernel+bounces-449956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368749F58AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CC31703E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F81FA17A;
	Tue, 17 Dec 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hYPr2gbp"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCB1DA61D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470468; cv=none; b=fTFy5R0klF8uEC3361bf12V0l0IuwT+EnFbe/L0C1Xp97hHCUf79ivm/54C8LHpOSM4lWgLkhJt3vU1kjdrMwTdlS/2/OvCNmlpCo58OHNhvgfvdM9pz/bTAlg4yWkDnSicC46zme+2qxaaS1J7D+op/iu6oTS49S+QHIq4Lrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470468; c=relaxed/simple;
	bh=JwzBZ7oalDLHpD5BqDpabadr1mzyOW1XCymQ+1AHYgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3f9M19Oeu8TjWt6XuliRCeFRRV4xd2T14Jk4WQas1pQWWP9NK5xNj+qdRhQVnhf+mJevsv/7j2s0AdPmgCsZO2UylUmyJxW4TqgmWqPkYVaj5dI58TjagduoSH2AHhuvMH1EE/pueg/NG8jcuremgiE86EhVnMUH+3EHKA0owY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hYPr2gbp; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qhjrvfbT10T4ib4bSsYSy2qtieNec7luPdoIC3wwps=;
	b=hYPr2gbpzrhMY50ScvyOtwrCEDpHjj/9XEnJKW/qUObs9G47i99w3yA8GscuW6noHQ0uX5
	yghgGf/RhYMmwmPHZHSbQ6lQLWi5G9OwXzo6HGoO0lPee7gt1E+CFwhqLPMj1YT2Sxn8zs
	Ugi4jCe+cvnX4qdGazBaw/suiI3TkX0=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	Colton Lewis <coltonlewis@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 01/18] drivers/perf: apple_m1: Refactor event select/filter configuration
Date: Tue, 17 Dec 2024 13:20:31 -0800
Message-Id: <20241217212048.3709204-2-oliver.upton@linux.dev>
In-Reply-To: <20241217212048.3709204-1-oliver.upton@linux.dev>
References: <20241217212048.3709204-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Supporting guest mode events will necessitate programming two event
filters. Prepare by splitting up the programming of the event selector +
event filter into separate headers.

Opportunistically replace RMW patterns with sysreg_clear_set_s().

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/apple_m1_pmu.h |  1 +
 drivers/perf/apple_m1_cpu_pmu.c       | 52 ++++++++++++++++-----------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
index 99483b19b99f..02e05d05851f 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -37,6 +37,7 @@
 #define PMCR0_PMI_ENABLE_8_9	GENMASK(45, 44)
 
 #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
+#define SYS_IMP_APL_PMCR1_EL12	sys_reg(3, 1, 15, 7, 2)
 #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
 #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
 #define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 1d4d01e1275e..ecc71f6808dd 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -325,11 +325,10 @@ static void m1_pmu_disable_counter_interrupt(unsigned int index)
 	__m1_pmu_enable_counter_interrupt(index, false);
 }
 
-static void m1_pmu_configure_counter(unsigned int index, u8 event,
-				     bool user, bool kernel)
+static void __m1_pmu_configure_event_filter(unsigned int index, bool user,
+					    bool kernel)
 {
-	u64 val, user_bit, kernel_bit;
-	int shift;
+	u64 clear, set, user_bit, kernel_bit;
 
 	switch (index) {
 	case 0 ... 7:
@@ -344,19 +343,24 @@ static void m1_pmu_configure_counter(unsigned int index, u8 event,
 		BUG();
 	}
 
-	val = read_sysreg_s(SYS_IMP_APL_PMCR1_EL1);
-
+	clear = set = 0;
 	if (user)
-		val |= user_bit;
+		set |= user_bit;
 	else
-		val &= ~user_bit;
+		clear |= user_bit;
 
 	if (kernel)
-		val |= kernel_bit;
+		set |= kernel_bit;
 	else
-		val &= ~kernel_bit;
+		clear |= kernel_bit;
 
-	write_sysreg_s(val, SYS_IMP_APL_PMCR1_EL1);
+	sysreg_clear_set_s(SYS_IMP_APL_PMCR1_EL1, clear, set);
+}
+
+static void __m1_pmu_configure_eventsel(unsigned int index, u8 event)
+{
+	u64 clear = 0, set = 0;
+	int shift;
 
 	/*
 	 * Counters 0 and 1 have fixed events. For anything else,
@@ -369,21 +373,29 @@ static void m1_pmu_configure_counter(unsigned int index, u8 event,
 		break;
 	case 2 ... 5:
 		shift = (index - 2) * 8;
-		val = read_sysreg_s(SYS_IMP_APL_PMESR0_EL1);
-		val &= ~((u64)0xff << shift);
-		val |= (u64)event << shift;
-		write_sysreg_s(val, SYS_IMP_APL_PMESR0_EL1);
+		clear |= (u64)0xff << shift;
+		set |= (u64)event << shift;
+		sysreg_clear_set_s(SYS_IMP_APL_PMESR0_EL1, clear, set);
 		break;
 	case 6 ... 9:
 		shift = (index - 6) * 8;
-		val = read_sysreg_s(SYS_IMP_APL_PMESR1_EL1);
-		val &= ~((u64)0xff << shift);
-		val |= (u64)event << shift;
-		write_sysreg_s(val, SYS_IMP_APL_PMESR1_EL1);
+		clear |= (u64)0xff << shift;
+		set |= (u64)event << shift;
+		sysreg_clear_set_s(SYS_IMP_APL_PMESR1_EL1, clear, set);
 		break;
 	}
 }
 
+static void m1_pmu_configure_counter(unsigned int index, unsigned long config_base)
+{
+	bool kernel = config_base & M1_PMU_CFG_COUNT_KERNEL;
+	bool user = config_base & M1_PMU_CFG_COUNT_USER;
+	u8 evt = config_base & M1_PMU_CFG_EVENT;
+
+	__m1_pmu_configure_event_filter(index, user, kernel);
+	__m1_pmu_configure_eventsel(index, evt);
+}
+
 /* arm_pmu backend */
 static void m1_pmu_enable_event(struct perf_event *event)
 {
@@ -398,7 +410,7 @@ static void m1_pmu_enable_event(struct perf_event *event)
 	m1_pmu_disable_counter(event->hw.idx);
 	isb();
 
-	m1_pmu_configure_counter(event->hw.idx, evt, user, kernel);
+	m1_pmu_configure_counter(event->hw.idx, event->hw.config_base);
 	m1_pmu_enable_counter(event->hw.idx);
 	m1_pmu_enable_counter_interrupt(event->hw.idx);
 	isb();
-- 
2.39.5


