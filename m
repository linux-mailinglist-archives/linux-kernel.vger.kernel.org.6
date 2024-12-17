Return-Path: <linux-kernel+bounces-449967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA59F58B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDE166576
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D140E1FC7DD;
	Tue, 17 Dec 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Auta5Qq2"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B781FC7D2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470498; cv=none; b=PuN5nwU2kibik5z/rk3uOMP6woyaXs07s9pWociNE+XsSdcPoEtyreq1sHY57cJSXDf5KC8C7cea3J19kpK5wd3gfPRwbxNdkdfbcSWs8IinTR9B3jed7/IJeJNx8VDRlJ2rK2vPXW45OPGbl5aAroVqveZpDMb2fEqGK0JgMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470498; c=relaxed/simple;
	bh=+PCEKzJasw8AkjeutmkmAB6tX4dV1GuYLClM918Nj6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pji1/FtV1jMRt3L+oV3DovvoMwv4DW6LfCCwKyKnJJ6hI8KtME+1JK7tZqu8tnqcDRC4trF71zsRFCeGn4TWIyHQVkNHO5dzZ0PxgW54ru5V9h4CtCdmnVsQSzhYVBXx7XYBp53DtBY6Okp6B46xX62vmHNYfs5YI7DL9vbbNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Auta5Qq2; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMkV/pqTTQ4xGbpkYJlRc+3Uzn+DOzgWu1oY5Quf894=;
	b=Auta5Qq2NMz0LH5WmRLKJ5t04wTor8Egy9qmTw8Atvbo53rvzzeuNvhfnb5roEQcye7yet
	D61M1bRMsZbDLJS6/oJWRgjafVum6cc+MFoDfKsMNaApxw+h5Y2PeBPsxA+yRRX2mfp1e3
	PW5GxVB/fk/10BojjFqGp0e/vnO5Uvs=
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
Subject: [PATCH 12/18] KVM: arm64: Compute synthetic sysreg ESR for Apple PMUv3 traps
Date: Tue, 17 Dec 2024 13:20:42 -0800
Message-Id: <20241217212048.3709204-13-oliver.upton@linux.dev>
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

Apple M* CPUs provide an IMPDEF trap for PMUv3 sysregs, where ESR_EL2.EC
is a reserved value (0x3F) and a sysreg-like ISS is reported in
AFSR1_EL2.

Compute a synthetic ESR for these PMUv3 traps, giving the illusion of
something architectural to the rest of KVM.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/hyp/vhe/switch.c | 22 ++++++++++++++++++++++
 arch/arm64/tools/cpucaps        |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 80581b1c3995..da2ccaefaf6f 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -418,6 +418,25 @@ static bool kvm_hyp_handle_sysreg_vhe(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return kvm_hyp_handle_sysreg(vcpu, exit_code);
 }
 
+static bool kvm_hyp_handle_impdef(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	u64 iss;
+
+	if (!cpus_have_final_cap(ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS))
+		return false;
+
+	/*
+	 * Compute a synthetic ESR for a sysreg trap. Conveniently, AFSR1_EL2
+	 * is populated with a correct ISS for a sysreg trap. These fruity
+	 * parts are 64bit only, so unconditionally set IL.
+	 */
+	iss = ESR_ELx_ISS(read_sysreg_s(SYS_AFSR1_EL2));
+	vcpu->arch.fault.esr_el2 = FIELD_PREP(ESR_ELx_EC_MASK, ESR_ELx_EC_SYS64) |
+				   FIELD_PREP(ESR_ELx_ISS_MASK, iss) |
+				   ESR_ELx_IL;
+	return false;
+}
+
 static const exit_handler_fn hyp_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
@@ -429,6 +448,9 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_ERET]		= kvm_hyp_handle_eret,
 	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
+
+	/* Apple shenanigans */
+	[0x3F]				= kvm_hyp_handle_impdef,
 };
 
 static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index b291eb73f5e0..a9c7111b831e 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -105,6 +105,7 @@ WORKAROUND_CAVIUM_TX2_219_TVM
 WORKAROUND_CLEAN_CACHE
 WORKAROUND_DEVICE_LOAD_ACQUIRE
 WORKAROUND_NVIDIA_CARMEL_CNP
+WORKAROUND_PMUV3_IMPDEF_TRAPS
 WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
-- 
2.39.5


