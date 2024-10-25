Return-Path: <linux-kernel+bounces-382402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A8A9B0D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B27288F29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EDD20BB50;
	Fri, 25 Oct 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A4y2jPMP"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387F215C5E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880674; cv=none; b=rPuDWfk2t6TzFVu3FXJI1WcAmsrwEzx3TrlHj0482k2KauWSBsjRmdVpg3vEPkNw9LJHIeUJCEx+cjkRfZxUX7dgIcbj/Ov9R7euFN1rWdjTbDPVEPILU9bYrn5k7xq7DANJfYQQ+TAfixST6DRVJq4Tdl3QFadT8BJ0pP1RRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880674; c=relaxed/simple;
	bh=Q7vBKgIbIND4zk/PaL6BpQwZYWCwg8LD8P5zBonajQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqQdl9pNP7PAuwxzi6/XkyHzXL31FvV3NAYAoiIMAOSgcFQC/6wYoxThMLdCmdlwKc/4urnNEPY7lL4UxuhwDlHVQkvxTLd9oS80VcHMFv/aLQdpt0aCrKkN16auoxiB9TtjjtGfYtfkGQVCmG42AU1K/88HQiAI8+9EAWg/PqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A4y2jPMP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Zy6kGgU90OTXWFjrU27ot0S1ZKtGk6pNy9r56UsKD0=;
	b=A4y2jPMPE4BmR7TzBqQJGkn0DYhVlj3aXzkH85lk5syb6tnnb3I9YfE0upgTkJycKdcsUt
	HiS5Mu4JobQdcE6BNtc4hFKCajIzc5Hfb33q4Loxpv9Wzpc4y5p7Ff1PHzFvx76rPVVTdW
	GTCsQzpR30nsm4olM5vTfbpCJhh60Qw=
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
Subject: [PATCH v4 11/18] KVM: arm64: nv: Advertise support for FEAT_HPMN0
Date: Fri, 25 Oct 2024 18:23:46 +0000
Message-ID: <20241025182354.3364124-12-oliver.upton@linux.dev>
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

Everything is in place now for KVM to actually handle MDCR_EL2.HPMN. Not
only that, the emulation is capable of doing FEAT_HPMN0. Advertise
support for the feature in the VM's ID registers. It is possible to
emulate FEAT_HPMN0 on hardware that doesn't support it since KVM
currently traps all PMU registers. Having said that, let's only
advertise the feature on supporting hardware in case KVM ever provides
'direct' PMU support to VMs w/o involving host perf.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/nested.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index d256a495a6ba..762f3ea8126d 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -892,12 +892,13 @@ static void limit_nv_id_regs(struct kvm *kvm)
 				  ID_AA64MMFR4_EL1_E2H0_NI_NV1);
 	kvm_set_vm_id_reg(kvm, SYS_ID_AA64MMFR4_EL1, val);
 
-	/* Only limited support for PMU, Debug, BPs and WPs */
+	/* Only limited support for PMU, Debug, BPs, WPs, and HPMN0 */
 	val = kvm_read_vm_id_reg(kvm, SYS_ID_AA64DFR0_EL1);
 	val &= (NV_FTR(DFR0, PMUVer)	|
 		NV_FTR(DFR0, WRPs)	|
 		NV_FTR(DFR0, BRPs)	|
-		NV_FTR(DFR0, DebugVer));
+		NV_FTR(DFR0, DebugVer)	|
+		NV_FTR(DFR0, HPMN0));
 
 	/* Cap Debug to ARMv8.1 */
 	tmp = FIELD_GET(NV_FTR(DFR0, DebugVer), val);
-- 
2.47.0.163.g1226f6d8fa-goog


