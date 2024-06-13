Return-Path: <linux-kernel+bounces-212615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119159063F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832BCB22590
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A71386B7;
	Thu, 13 Jun 2024 06:18:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064C5137777;
	Thu, 13 Jun 2024 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259507; cv=none; b=Qn5kJRoYFBejexF6ffD2rbTUNYZCXmpccwljmKZyJaB6Qe7h0TrUPGaN5Q64nRpvyAgYmqty/5qBJBZaJ9vtQU379Qyc+FTJpZ36RzuQpxv34W7T/b2MS3XffWURq/77IPFtp5cg2FBt1BeXFssdREHJNeAPWT/Dq0t8Qr84p90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259507; c=relaxed/simple;
	bh=Ayximh36XHEjtq/+N5q+7aSkB3R77KaSLxol4rkOPEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKxR+EhiPsk10C5VHNvcLyZI7qFkgef0mplRVy2ieMW+RRciqeuqqDg0RGU+CB/gl7XF3mRSawRgIEgXNaagNubgFkIcK33SP0i1Jgy2ZAq3rGpYnOL3/V6SXITS8mv/LpomB95iLGpW9m8vBLDlc9SNZht4i21fgalaYxhOI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10B071477;
	Wed, 12 Jun 2024 23:18:50 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.44.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5760A3F5A1;
	Wed, 12 Jun 2024 23:18:18 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	kvmarm@lists.linux.dev
Subject: [PATCH V18 6/9] KVM: arm64: nvhe: Disable branch generation in nVHE guests
Date: Thu, 13 Jun 2024 11:47:28 +0530
Message-Id: <20240613061731.3109448-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613061731.3109448-1-anshuman.khandual@arm.com>
References: <20240613061731.3109448-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the BRBE before we enter the guest, saving the status and enable it
back once we get out of the guest. This avoids capturing branch records in
the guest kernel or userspace, which would be confusing the host samples.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
----
Changes in V18:

- Used host_data_ptr() to access host_debug_state.brbcr_el1 register
- Changed DEBUG_STATE_SAVE_BRBE to use BIT(7)
- Reverted back iflags as u8

 arch/arm64/include/asm/kvm_host.h  |  3 +++
 arch/arm64/kvm/debug.c             |  5 +++++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 31 ++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 36b8e97bf49e..db922c10bd2a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -579,6 +579,7 @@ struct kvm_host_data {
 		u64 trfcr_el1;
 		/* Values of trap registers for the host before guest entry. */
 		u64 mdcr_el2;
+		u64 brbcr_el1;
 	} host_debug_state;
 };
 
@@ -842,6 +843,8 @@ struct kvm_vcpu_arch {
 #define DEBUG_STATE_SAVE_SPE	__vcpu_single_flag(iflags, BIT(5))
 /* Save TRBE context if active  */
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
+/* Save BRBE context if active  */
+#define DEBUG_STATE_SAVE_BRBE	__vcpu_single_flag(iflags, BIT(7))
 
 /* SVE enabled for host EL0 */
 #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index ce8886122ed3..8fa648943f0f 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -336,10 +336,15 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
 	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+
+	/* Check if we have BRBE implemented and available at the host */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT))
+		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
 }
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 {
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 53efda0235cf..97e861df1b45 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -79,6 +79,32 @@ static void __debug_restore_trace(u64 trfcr_el1)
 	write_sysreg_el1(trfcr_el1, SYS_TRFCR);
 }
 
+static void __debug_save_brbe(u64 *brbcr_el1)
+{
+	*brbcr_el1 = 0;
+
+	/* Check if the BRBE is enabled */
+	if (!(read_sysreg_el1(SYS_BRBCR) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
+		return;
+
+	/*
+	 * Prohibit branch record generation while we are in guest.
+	 * Since access to BRBCR_EL1 is trapped, the guest can't
+	 * modify the filtering set by the host.
+	 */
+	*brbcr_el1 = read_sysreg_el1(SYS_BRBCR);
+	write_sysreg_el1(0, SYS_BRBCR);
+}
+
+static void __debug_restore_brbe(u64 brbcr_el1)
+{
+	if (!brbcr_el1)
+		return;
+
+	/* Restore BRBE controls */
+	write_sysreg_el1(brbcr_el1, SYS_BRBCR);
+}
+
 void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	/* Disable and flush SPE data generation */
@@ -87,6 +113,9 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 	/* Disable and flush Self-Hosted Trace generation */
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
 		__debug_save_trace(host_data_ptr(host_debug_state.trfcr_el1));
+	/* Disable BRBE branch records */
+	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_BRBE))
+		__debug_save_brbe(host_data_ptr(host_debug_state.brbcr_el1));
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -100,6 +129,8 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 		__debug_restore_spe(*host_data_ptr(host_debug_state.pmscr_el1));
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
 		__debug_restore_trace(*host_data_ptr(host_debug_state.trfcr_el1));
+	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_BRBE))
+		__debug_restore_brbe(*host_data_ptr(host_debug_state.brbcr_el1));
 }
 
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
-- 
2.25.1


