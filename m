Return-Path: <linux-kernel+bounces-382406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FA9B0D31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49A2289928
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D25216E0D;
	Fri, 25 Oct 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mpQyf5fd"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113E216DE1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880684; cv=none; b=sxynEGTTT5wVVrBSQxp/1pml0EN8FlkwoaSiIxkFIB3MjN8B2BvvliqZMDUZxyKvEoCrQ4NaIk096YKuAASHV4XzW15BZiV0Iw1F5z+r/claFa5j8rg0074OAa0i46TzaKDDX1IKSL4yermhFMjVLkK5Mf7MXTHGJ/qJDaCphQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880684; c=relaxed/simple;
	bh=HOnseCa4w27iSy+w9y5fRHyXmlUTzPh/7iSZeSnZbhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPfd0PWnEv3P+Y5/5kGafAHgoyocs/nycyxSq9aHhgSt8vNBgqnVks9gt7Bg88aKdGhAC89iUJgy+yhkmWE2whg2IeDfcPDPJzJNwjfOqydQmcOw5qQNKTqNkC1oZpQxhBCu0yP7IZ8xmt5AMdqKRb+WAhBHkzn/xAPLtrHFz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mpQyf5fd; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrYN5raZtmWI3hPp7h1MaTZOJ1/CQmOwVJXTIAsdSvU=;
	b=mpQyf5fdkDWX8vMbgGH7PlXuYSF8BTzvlYcX6H0p4IGeZ/kEntusuo+rmuplKHsnkDsTKY
	uD0mK395NR1Pxp3tAQUPu8QC+gmRXi9jHuqH4f6XLrY0hWpEN4a6GHX6XS80Hyg4l5hedH
	8oOuJ78UyWpHzLqYlenhequjjM5IUZM=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 15/18] KVM: arm64: nv: Honor MDCR_EL2.HPME
Date: Fri, 25 Oct 2024 18:23:50 +0000
Message-ID: <20241025182354.3364124-16-oliver.upton@linux.dev>
In-Reply-To: <20241025182354.3364124-1-oliver.upton@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the PMU is configured with split counter ranges, HPME becomes the
enable bit for the counters reserved for EL2.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 03cd1ad7a55a..349886f03fd5 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -620,8 +620,15 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc)
 {
 	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
-	return (kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E) &&
-	       (__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & BIT(pmc->idx));
+	unsigned int mdcr = __vcpu_sys_reg(vcpu, MDCR_EL2);
+
+	if (!(__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & BIT(pmc->idx)))
+		return false;
+
+	if (kvm_pmu_counter_is_hyp(vcpu, pmc->idx))
+		return mdcr & MDCR_EL2_HPME;
+
+	return kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E;
 }
 
 static bool kvm_pmc_counts_at_el0(struct kvm_pmc *pmc)
-- 
2.47.0.163.g1226f6d8fa-goog


