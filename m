Return-Path: <linux-kernel+bounces-382407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86549B0D32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5BE1F215A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EDC217444;
	Fri, 25 Oct 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TcH6DeFL"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEF216E04
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880686; cv=none; b=mFez0KRZDl+u7cZKZnK5oaMM8SXD7z5Kba5pnaiUO0ovN1VsWaxfY/j+1bOqZFrrwKnn6pozTkS+cSSSXwziTzwp6L8wRtqAuo1wl/sRGDdeVM2RL86VkOWyeR4tLTUOcx6o4LU9idvfEWt/wU5Yl73W/4Ld+iol+tjwNSHimu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880686; c=relaxed/simple;
	bh=WYsNVCFGAHBmLIR5ZwVMA7UgwETHZyDsk9g7TP4BdGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVetqVw1h9T+FE66k2U/eY8czok4Yrkdgz3iyIBc3vEcz/AtNLOceDCXW8r9g2pG99fGcOnCvdC+H9kVh+QU1f1vG/abGAPbSqRAX9EaFZ2TNIf+PPdoDaOddVaeTl2e2y35k8w77/1icrK6eYbiEsEZ/1G+lx9U3jLh6cHryZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TcH6DeFL; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Owyw17gWiY/wAB+tVVFDbqz1mQh4LseuhIiRcAFPnCo=;
	b=TcH6DeFLIlJxfOvvh2g2c8lQNf63nJ1xNdujBUnCnhFJANWPjwhf3LJFZXDluQntM4Rk/H
	PcB85ZdAIMr3VD+fyZQM715VWN6peLMTHM4T1xAhsUp1C4wNOEBsq1aqR4LN5QWB26C5bR
	vHfvYTYR28NWFj03/2ihe3LkPxPapCY=
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
Subject: [PATCH v4 16/18] KVM: arm64: nv: Honor MDCR_EL2.HLP
Date: Fri, 25 Oct 2024 18:23:51 +0000
Message-ID: <20241025182354.3364124-17-oliver.upton@linux.dev>
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

Counters that fall in the hypervisor range (i.e. N >= HPMN) have a
separate control for enabling 64 bit overflow. Take it into account.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 349886f03fd5..1e9cdbc235a8 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -89,7 +89,11 @@ static bool kvm_pmc_is_64bit(struct kvm_pmc *pmc)
 
 static bool kvm_pmc_has_64bit_overflow(struct kvm_pmc *pmc)
 {
-	u64 val = kvm_vcpu_read_pmcr(kvm_pmc_to_vcpu(pmc));
+	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
+	u64 val = kvm_vcpu_read_pmcr(vcpu);
+
+	if (kvm_pmu_counter_is_hyp(vcpu, pmc->idx))
+		return __vcpu_sys_reg(vcpu, MDCR_EL2) & MDCR_EL2_HLP;
 
 	return (pmc->idx < ARMV8_PMU_CYCLE_IDX && (val & ARMV8_PMU_PMCR_LP)) ||
 	       (pmc->idx == ARMV8_PMU_CYCLE_IDX && (val & ARMV8_PMU_PMCR_LC));
-- 
2.47.0.163.g1226f6d8fa-goog


