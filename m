Return-Path: <linux-kernel+bounces-213193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F074B907009
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A86E1F22DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFEE1459F3;
	Thu, 13 Jun 2024 12:23:01 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A2214535B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281380; cv=none; b=b4RoNj9VPW0uk3W+dhTOGexP/bNq9uaMoZzOW4d3pM12w1/GYXctrLRN5B7ihmsQRLouRq2R/eLAS7wrYbpFkMuSuRXXECZxHAeqRC3wLrEt8eg03F5l/FrxlwLs72/CFwQG/Z7Sd0wEH4GK/Q9EjEIKQoDuExTxKNQy4oUFC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281380; c=relaxed/simple;
	bh=oInQ6M0cmPQUqorKLdVrst+EP+vaK3rBdRJuF91krI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnPdYv0nvmhnEyLLlqtrAmT47McgmTDb4TFba0EU+9Lr9O9lbrArtZwvRekhv6rUQ6f3pTfNBTQB447s3XEvr7y7R+2uR+8f7g8lgFUMO0HGg5ZymBEJj56W9kudFRViLRcpzxwA7WEtx2piw/nQb8InHRDUwnbOe39WlbzFc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8CxL_Ce5GpmZ4EGAA--.26409S3;
	Thu, 13 Jun 2024 20:22:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTcec5GpmOLMeAA--.9993S2;
	Thu, 13 Jun 2024 20:22:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: pbonzini@redhat.com,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] LoongArch: KVM: Add PMU support
Date: Thu, 13 Jun 2024 20:05:39 +0800
Message-Id: <20240613120539.41021-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTcec5GpmOLMeAA--.9993S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch, the host and guest have their own PMU CSRs registers
and they share PMU hardware resources. A set of PMU CSRs consists of
a CTRL register and a CNTR register. We can set which PMU CSRs are used
by the guest by writing to the GCFG register [24: 26] bits.

On KVM side:
- Save the host PMU CSRs into structure kvm_context.
- If the host supports the PMU feature.
  - When entering guest mode. save the host PMU CSRs and restore the guest PMU CSRs.
  - When exiting guest mode, save the guest PMU CSRs and restore the host PMU CSRs.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
V6:
  - Implement kvm_arch_vm_ioctl() to check vm pmu feature
    when the virt machine is not created.
  - Link to V5: https://lore.kernel.org/all/20240507120140.3119714-1-gaosong@loongson.cn/

V5:
  - When restoring the PMU context, resotre the CNTR register before the CTRL register.
  - Link to V4: https://lore.kernel.org/all/20240429093401.2612430-1-gaosong@loongson.cn/

V4:
  - Use the macro kvm_read_clear_hw_gcsr to optimize the code
    and remove redundant code.
  - Link to V3: https://lore.kernel.org/all/20240424091813.1471440-1-gaosong@loongson.cn/

V3:
  - When saving the PMU context, clear the CTRL register
     before reading the CNTR register.
  - Put kvm_lose_pmu() in kvm_handler_exit().
  - Link to V2: https://lore.kernel.org/all/20240417065236.500011-1-gaosong@loongson.cn/

V2:
  - Add new vcpu->request flag KVM_REQ_PMU. If we use PMU,
    We need to set this flag;
  - Add kvm_check_pmu() to kvm_pre_enter_guest();
  - On _kvm_setcsr(), after modifying the PMU CSR register value,
     if we use PMU, we need to set KVM_REQ_PMU.
  - Link to V1: https://lore.kernel.org/all/20240410095812.2943706-1-gaosong@loongson.cn/

 arch/loongarch/include/asm/kvm_csr.h   |   7 +
 arch/loongarch/include/asm/kvm_host.h  |  20 +++
 arch/loongarch/include/asm/loongarch.h |   1 +
 arch/loongarch/include/uapi/asm/kvm.h  |   4 +
 arch/loongarch/kvm/exit.c              |   8 ++
 arch/loongarch/kvm/vcpu.c              | 173 ++++++++++++++++++++++++-
 arch/loongarch/kvm/vm.c                |  35 ++++-
 7 files changed, 245 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_csr.h b/arch/loongarch/include/asm/kvm_csr.h
index 724ca8b7b401..0a52f115a87e 100644
--- a/arch/loongarch/include/asm/kvm_csr.h
+++ b/arch/loongarch/include/asm/kvm_csr.h
@@ -30,6 +30,7 @@
 		: [val] "+r" (__v)				\
 		: [reg] "i" (csr)				\
 		: "memory");					\
+	__v;							\
 })
 
 #define gcsr_xchg(v, m, csr)					\
@@ -180,6 +181,7 @@ __BUILD_GCSR_OP(tlbidx)
 
 #define kvm_save_hw_gcsr(csr, gid)	(csr->csrs[gid] = gcsr_read(gid))
 #define kvm_restore_hw_gcsr(csr, gid)	(gcsr_write(csr->csrs[gid], gid))
+#define kvm_read_clear_hw_gcsr(csr, gid)	(csr->csrs[gid] = gcsr_write(0, gid))
 
 int kvm_emu_iocsr(larch_inst inst, struct kvm_run *run, struct kvm_vcpu *vcpu);
 
@@ -208,4 +210,9 @@ static __always_inline void kvm_change_sw_gcsr(struct loongarch_csrs *csr,
 	csr->csrs[gid] |= val & _mask;
 }
 
+#define KVM_PMU_EVENT_ENABLED	(CSR_PERFCTRL_PLV0 |		\
+					CSR_PERFCTRL_PLV1 |	\
+					CSR_PERFCTRL_PLV2 |	\
+					CSR_PERFCTRL_PLV3)
+
 #endif	/* __ASM_LOONGARCH_KVM_CSR_H__ */
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index c87b6ea0ec47..799ab2a4025e 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -57,9 +57,14 @@ struct kvm_arch_memory_slot {
 	unsigned long flags;
 };
 
+#define KVM_REQ_PMU			KVM_ARCH_REQ(0)
+#define HOST_MAX_PMNUM			16
 struct kvm_context {
 	unsigned long vpid_cache;
 	struct kvm_vcpu *last_vcpu;
+	/* Save host pmu csr */
+	u64 perf_ctrl[HOST_MAX_PMNUM];
+	u64 perf_cntr[HOST_MAX_PMNUM];
 };
 
 struct kvm_world_switch {
@@ -132,6 +137,8 @@ enum emulation_result {
 #define KVM_LARCH_LASX		(0x1 << 2)
 #define KVM_LARCH_SWCSR_LATEST	(0x1 << 3)
 #define KVM_LARCH_HWCSR_USABLE	(0x1 << 4)
+#define KVM_GUEST_PMU_ENABLE	(0x1 << 5)
+#define KVM_GUEST_PMU_ACTIVE	(0x1 << 6)
 
 struct kvm_vcpu_arch {
 	/*
@@ -169,6 +176,9 @@ struct kvm_vcpu_arch {
 	/* CSR state */
 	struct loongarch_csrs *csr;
 
+	/* Guest max PMU CSR id */
+	int max_pmu_csrid;
+
 	/* GPR used as IO source/target */
 	u32 io_gpr;
 
@@ -228,6 +238,16 @@ static inline bool kvm_guest_has_lasx(struct kvm_vcpu_arch *arch)
 	return arch->cpucfg[2] & CPUCFG2_LASX;
 }
 
+static inline bool kvm_guest_has_pmu(struct kvm_vcpu_arch *arch)
+{
+	return arch->cpucfg[LOONGARCH_CPUCFG6] & CPUCFG6_PMP;
+}
+
+static inline int kvm_get_pmu_num(struct kvm_vcpu_arch *arch)
+{
+	return (arch->cpucfg[LOONGARCH_CPUCFG6] & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT;
+}
+
 /* Debug: dump vcpu state */
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index eb09adda54b7..fc6fabd15c0b 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -119,6 +119,7 @@
 #define  CPUCFG6_PMP			BIT(0)
 #define  CPUCFG6_PAMVER			GENMASK(3, 1)
 #define  CPUCFG6_PMNUM			GENMASK(7, 4)
+#define  CPUCFG6_PMNUM_SHIFT		4
 #define  CPUCFG6_PMBITS			GENMASK(13, 8)
 #define  CPUCFG6_UPM			BIT(14)
 
diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/include/uapi/asm/kvm.h
index f9abef382317..58850eced2dc 100644
--- a/arch/loongarch/include/uapi/asm/kvm.h
+++ b/arch/loongarch/include/uapi/asm/kvm.h
@@ -83,6 +83,10 @@ struct kvm_fpu {
 #define KVM_IOC_CPUCFG(REG)		LOONGARCH_REG_64(KVM_REG_LOONGARCH_CPUCFG, REG)
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
 
+/* Device Control API on vm fd */
+#define KVM_LOONGARCH_VM_FEAT_CTRL     0
+#define  KVM_LOONGARCH_VM_FEAT_PMU     0
+
 struct kvm_debug_exit_arch {
 };
 
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index c86e099af5ca..cf468ba4f883 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -124,6 +124,14 @@ static int kvm_handle_csr(struct kvm_vcpu *vcpu, larch_inst inst)
 	rj = inst.reg2csr_format.rj;
 	csrid = inst.reg2csr_format.csr;
 
+	if (csrid >= LOONGARCH_CSR_PERFCTRL0 && csrid <= vcpu->arch.max_pmu_csrid) {
+		if (kvm_guest_has_pmu(&vcpu->arch)) {
+			vcpu->arch.pc -= 4;
+			kvm_make_request(KVM_REQ_PMU, vcpu);
+			return EMULATE_DONE;
+		}
+	}
+
 	/* Process CSR ops */
 	switch (rj) {
 	case 0: /* process csrrd */
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 9e8030d45129..1f380ee8d8ad 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -31,6 +31,131 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
+static inline void kvm_save_host_pmu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_context *context;
+
+	context = this_cpu_ptr(vcpu->kvm->arch.vmcs);
+	context->perf_ctrl[0] = write_csr_perfctrl0(0);
+	context->perf_ctrl[1] = write_csr_perfctrl1(0);
+	context->perf_ctrl[2] = write_csr_perfctrl2(0);
+	context->perf_ctrl[3] = write_csr_perfctrl3(0);
+	context->perf_cntr[0] = read_csr_perfcntr0();
+	context->perf_cntr[1] = read_csr_perfcntr1();
+	context->perf_cntr[2] = read_csr_perfcntr2();
+	context->perf_cntr[3] = read_csr_perfcntr3();
+}
+
+static inline void kvm_restore_host_pmu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_context *context;
+
+	context = this_cpu_ptr(vcpu->kvm->arch.vmcs);
+	write_csr_perfcntr0(context->perf_cntr[0]);
+	write_csr_perfcntr1(context->perf_cntr[1]);
+	write_csr_perfcntr2(context->perf_cntr[2]);
+	write_csr_perfcntr3(context->perf_cntr[3]);
+	write_csr_perfctrl0(context->perf_ctrl[0]);
+	write_csr_perfctrl1(context->perf_ctrl[1]);
+	write_csr_perfctrl2(context->perf_ctrl[2]);
+	write_csr_perfctrl3(context->perf_ctrl[3]);
+}
+
+
+static inline void kvm_save_guest_pmu(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	kvm_read_clear_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
+	kvm_read_clear_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
+	kvm_read_clear_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
+	kvm_read_clear_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR0);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR1);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR2);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR3);
+}
+
+static inline void kvm_restore_guest_pmu(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR0);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR1);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR2);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR3);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
+}
+
+static void kvm_lose_pmu(struct kvm_vcpu *vcpu)
+{
+	unsigned long val;
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	if (!(vcpu->arch.aux_inuse & KVM_GUEST_PMU_ENABLE))
+		return;
+	if (!(vcpu->arch.aux_inuse & KVM_GUEST_PMU_ACTIVE))
+		return;
+
+	kvm_save_guest_pmu(vcpu);
+	/* Disable pmu access from guest */
+	write_csr_gcfg(read_csr_gcfg() & ~CSR_GCFG_GPERF);
+
+	/*
+	 * Clear KVM_GUEST_PMU_ENABLE if the guest is not using PMU CSRs
+	 * when exiting the guest, so that the next time trap into the guest.
+	 * we don't need to deal with PMU CSRs contexts.
+	 */
+	val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
+	val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
+	val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
+	val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
+	if (!(val & KVM_PMU_EVENT_ENABLED))
+		vcpu->arch.aux_inuse &= ~KVM_GUEST_PMU_ENABLE;
+	kvm_restore_host_pmu(vcpu);
+
+	/* KVM_GUEST_PMU_ACTIVE needs to be cleared when exiting the guest */
+	vcpu->arch.aux_inuse &= ~KVM_GUEST_PMU_ACTIVE;
+}
+
+static void kvm_own_pmu(struct kvm_vcpu *vcpu)
+{
+	unsigned long val;
+
+	kvm_save_host_pmu(vcpu);
+	/* Set PM0-PM(num) to guest */
+	val = read_csr_gcfg() & ~CSR_GCFG_GPERF;
+	val |= (kvm_get_pmu_num(&vcpu->arch) + 1) << CSR_GCFG_GPERF_SHIFT;
+	write_csr_gcfg(val);
+	kvm_restore_guest_pmu(vcpu);
+}
+
+static void kvm_restore_pmu(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.aux_inuse & KVM_GUEST_PMU_ENABLE))
+		return;
+
+	kvm_make_request(KVM_REQ_PMU, vcpu);
+}
+
+static void kvm_check_pmu(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_check_request(KVM_REQ_PMU, vcpu))
+		return;
+
+	kvm_own_pmu(vcpu);
+
+	/*
+	 * Set KVM_GUEST PMU_ENABLE and GUEST_PMU_ACTIVE
+	 * when guest has KVM_REQ_PMU request.
+	 */
+	vcpu->arch.aux_inuse |= KVM_GUEST_PMU_ENABLE;
+	vcpu->arch.aux_inuse |= KVM_GUEST_PMU_ACTIVE;
+}
+
 /*
  * kvm_check_requests - check and handle pending vCPU requests
  *
@@ -101,6 +226,7 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		/* Make sure the vcpu mode has been written */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 		kvm_check_vpid(vcpu);
+		kvm_check_pmu(vcpu);
 		vcpu->arch.host_eentry = csr_read64(LOONGARCH_CSR_EENTRY);
 		/* Clear KVM_LARCH_SWCSR_LATEST as CSR will change when enter guest */
 		vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
@@ -131,6 +257,8 @@ static int kvm_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	/* Set a default exit reason */
 	run->exit_reason = KVM_EXIT_UNKNOWN;
 
+	kvm_lose_pmu(vcpu);
+
 	guest_timing_exit_irqoff();
 	guest_state_exit_irqoff();
 	local_irq_enable();
@@ -393,6 +521,21 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
 
 	kvm_write_sw_gcsr(csr, id, val);
 
+	/*
+	 * After modifying the PMU CSR register value of the vcpu.
+	 * If the PMU CSRs are used, we need to set KVM_REQ_PMU.
+	 */
+	if (id >= LOONGARCH_CSR_PERFCTRL0 && id <= LOONGARCH_CSR_PERFCNTR3) {
+		unsigned long val;
+
+		val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
+		val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
+		val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
+		val |= kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
+		if (val & KVM_PMU_EVENT_ENABLED)
+			kvm_make_request(KVM_REQ_PMU, vcpu);
+	}
+
 	return ret;
 }
 
@@ -431,6 +574,12 @@ static int _kvm_get_cpucfg_mask(int id, u64 *v)
 	case LOONGARCH_CPUCFG5:
 		*v = GENMASK(31, 0);
 		return 0;
+	case LOONGARCH_CPUCFG6:
+		if (cpu_has_pmp)
+			*v = GENMASK(14, 0);
+		else
+			*v = 0;
+		return 0;
 	case LOONGARCH_CPUCFG16:
 		*v = GENMASK(16, 0);
 		return 0;
@@ -449,7 +598,7 @@ static int _kvm_get_cpucfg_mask(int id, u64 *v)
 
 static int kvm_check_cpucfg(int id, u64 val)
 {
-	int ret;
+	int ret, host;
 	u64 mask = 0;
 
 	ret = _kvm_get_cpucfg_mask(id, &mask);
@@ -475,6 +624,18 @@ static int kvm_check_cpucfg(int id, u64 val)
 			/* LASX architecturally implies LSX and FP but val does not satisfy that */
 			return -EINVAL;
 		return 0;
+	case LOONGARCH_CPUCFG6:
+		if (val & CPUCFG6_PMP) {
+			host = read_cpucfg(LOONGARCH_CPUCFG6);
+			if ((val & CPUCFG6_PMBITS) != (host & CPUCFG6_PMBITS))
+				/* Guest pmbits must be the same with host */
+				return -EINVAL;
+			if ((val & CPUCFG6_PMNUM) > (host & CPUCFG6_PMNUM))
+				return -EINVAL;
+			if ((val & CPUCFG6_UPM) && !(host & CPUCFG6_UPM))
+				return -EINVAL;
+		}
+		return 0;
 	default:
 		/*
 		 * Values for the other CPUCFG IDs are not being further validated
@@ -560,6 +721,10 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
 		if (ret)
 			break;
 		vcpu->arch.cpucfg[id] = (u32)v;
+		if (id == LOONGARCH_CPUCFG6) {
+			vcpu->arch.max_pmu_csrid = LOONGARCH_CSR_PERFCTRL0 +
+							2 * kvm_get_pmu_num(&vcpu->arch) + 1;
+		}
 		break;
 	case KVM_REG_LOONGARCH_KVM:
 		switch (reg->id) {
@@ -653,7 +818,8 @@ static int kvm_loongarch_cpucfg_has_attr(struct kvm_vcpu *vcpu,
 					 struct kvm_device_attr *attr)
 {
 	switch (attr->attr) {
-	case 2:
+	case LOONGARCH_CPUCFG2:
+	case LOONGARCH_CPUCFG6:
 		return 0;
 	default:
 		return -ENXIO;
@@ -1085,6 +1251,9 @@ static int _kvm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	/* Control guest page CCA attribute */
 	change_csr_gcfg(CSR_GCFG_MATC_MASK, CSR_GCFG_MATC_ROOT);
 
+	/* Restore hardware PMU CSRs */
+	kvm_restore_pmu(vcpu);
+
 	/* Don't bother restoring registers multiple times unless necessary */
 	if (vcpu->arch.aux_inuse & KVM_LARCH_HWCSR_USABLE)
 		return 0;
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 6b2e4f66ad26..b66db4f0d2b0 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -99,7 +99,40 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	return r;
 }
 
+static int kvm_vm_feature_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	switch (attr->attr) {
+	case KVM_LOONGARCH_VM_FEAT_PMU:
+		if (cpu_has_pmp)
+			return 0;
+		return -ENXIO;
+	default:
+		return -ENXIO;
+	}
+}
+
+static int kvm_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
+{
+	switch (attr->group) {
+	case KVM_LOONGARCH_VM_FEAT_CTRL:
+		return kvm_vm_feature_has_attr(kvm, attr);
+	default:
+		return -ENXIO;
+	}
+}
+
 int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
-	return -ENOIOCTLCMD;
+	struct kvm *kvm =filp->private_data;
+	void __user *argp =(void __user *)arg;
+	struct kvm_device_attr attr;
+
+	switch (ioctl) {
+	case KVM_HAS_DEVICE_ATTR:
+		if (copy_from_user(&attr, argp, sizeof(attr)))
+			return -EFAULT;
+		return kvm_vm_has_attr(kvm, &attr);
+	default:
+		return -EINVAL;
+	}
 }
-- 
2.39.3


