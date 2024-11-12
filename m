Return-Path: <linux-kernel+bounces-405668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E37B79C567C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38064B3E188
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DBE3DAC19;
	Tue, 12 Nov 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHCanxu7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01A3DAC04
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407885; cv=none; b=qWMp+60VQWKI3jtIAS1ciIWIeU6UwEuXMckYBaUfr8kkxJj4GbM05ehgnRdHKNOaqMasjchhs5y7PbyweeXBlGNaeqvFNZaqU2WOWdyoU3+Kl2tlwRwdc8slqzDQGi+sYMIh+UW/dNVC4pO8R+76OMwY5n7P/C8TZCX/witFiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407885; c=relaxed/simple;
	bh=B4UZRCXRV6nk93U+Pyu0fOk1GedmMXLLKFUMPaEPN1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gc/OgBzmfem487b/E14G4cGlCmcjxDMo2oKtaeHGa18AcPTxEjR9c//dVbKwGYowdXxigVoHBWX6gPW+1vx+jeTCzNRPQ1H1JdfRyfWA4CAhqVcLNSeGRRJ5Xpxn945nlFaWFdRNLWGYiavXrlNj7+S2T0G0gWrV0sHaXL7u+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHCanxu7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so48382025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407882; x=1732012682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGQZgIecdgJFFuz0ar27zElDtqI8/ASy5Gql7KrbLX0=;
        b=CHCanxu7dstd36UeNPtsxiBLfvKCrV6TOoRLfG5RWnwm7Z8eiU95Vq186XbnU+/h07
         xq+bejczlIOTQV0q2kxXOpXX1bmHnXuKM2VEwvrty/WYsYagjt6SiLpSjoLs9YyswhU8
         NcUg5JWeIInbAJgOzaPcOmiD/l3rriZtxXIZ5uR0OCUoNjYBri8pmRYDxWncq5Us8PWJ
         53SdmzhdyqJi5DBACK4cB/6iJCVV7pebZhKHHGBIVOZN7nQLTApGCCWxo7QjCM9vuTAS
         XhaYH5RXy0Ie0zAWWzPcugk0HkFnrGbAGvKOuNi0TKf1wvizHY5Qd6B3KA4uk9T/27vu
         U6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407882; x=1732012682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGQZgIecdgJFFuz0ar27zElDtqI8/ASy5Gql7KrbLX0=;
        b=DazRlby/lGlnIETUru6REGtD1nJrzetlCaM4lLnPRNcVuNrup9+51cNLPxeMc0KWJH
         d30ekGPaPFHuFRpfLswNrylKANlgrs2N2Y/ZBd/V544WHh/6msNNkyFx3EBoGbvWKw28
         Fyc3h3v2ZLm6ymlJ8wgF2JHz8du/WVDenhmWdYtQ5yJGtJqWFPx+oi1Yaa5i7SSNg465
         0dfA406S/6JMaYBiROXD9npZ63tcbjU+b7PN0KY2Q7XycFGg9IO4I9W3gQKGsTj3o+MX
         6+J/fZggy3g6I6nkIV9vM5cyGpQr5fbP1BVAKuJ+7BHSKC8FYktCpF5S4aqRRNV2hbUh
         s56g==
X-Forwarded-Encrypted: i=1; AJvYcCXeJ0nQTOGGYMhA8vAW2r8JcKDhbkUz3iOuHJze3a9CkF2+xk5KYvKh1PXinGGqQmYT1b0KdRh/aq21Y7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0d2doxnyiNCU9IHmw/PTsmkpLcChNxQxijbCn7cuTgMYtTaSU
	oIImh68Fc/3wztHg82IO+HE7VRQY3Wc6OlxJm3w9RB5bHBFDsGtQ/mHYDcArtE8=
X-Google-Smtp-Source: AGHT+IHGEHyPFWqoNoYrbeGSGMnOBwTa4lfpM6N5kuAUTD0JGTXynuOGzkoJhiocD1Pug6afrml1XA==
X-Received: by 2002:a05:600c:354c:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-432b74fdaeemr135858735e9.1.1731407881909;
        Tue, 12 Nov 2024 02:38:01 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:38:01 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	coresight@lists.linaro.org,
	kvmarm@lists.linux.dev
Cc: James Clark <james.clark@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/12] KVM: arm64: Make vcpu flag macros more generic
Date: Tue, 12 Nov 2024 10:37:03 +0000
Message-Id: <20241112103717.589952-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112103717.589952-1-james.clark@linaro.org>
References: <20241112103717.589952-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename vcpu_* to kvm_* so that the same flags mechanism can be used in
places other than vcpu without being confusing. Wherever macros are
still related to vcpu like vcpu_get_flag() with hard coded v->arch, keep
the vcpu_* name, otherwise change it.

Also move the "v->arch" access one macro higher for the same reason.

This will be used for moving flags to host_data in a later commit.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h | 88 +++++++++++++++----------------
 arch/arm64/kvm/hyp/exception.c    | 12 ++---
 arch/arm64/kvm/inject_fault.c     |  4 +-
 arch/arm64/kvm/mmio.c             | 10 ++--
 4 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f333b189fb43..34aa59f498c4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -790,22 +790,22 @@ struct kvm_vcpu_arch {
 /*
  * Each 'flag' is composed of a comma-separated triplet:
  *
- * - the flag-set it belongs to in the vcpu->arch structure
+ * - the flag-set it belongs to in the structure pointed to by 'v'
  * - the value for that flag
  * - the mask for that flag
  *
- *  __vcpu_single_flag() builds such a triplet for a single-bit flag.
- * unpack_vcpu_flag() extract the flag value from the triplet for
+ *  __kvm_single_flag() builds such a triplet for a single-bit flag.
+ * unpack_kvm_flag() extract the flag value from the triplet for
  * direct use outside of the flag accessors.
  */
-#define __vcpu_single_flag(_set, _f)	_set, (_f), (_f)
+#define __kvm_single_flag(_set, _f)	_set, (_f), (_f)
 
 #define __unpack_flag(_set, _f, _m)	_f
-#define unpack_vcpu_flag(...)		__unpack_flag(__VA_ARGS__)
+#define unpack_kvm_flag(...)		__unpack_flag(__VA_ARGS__)
 
 #define __build_check_flag(v, flagset, f, m)			\
 	do {							\
-		typeof(v->arch.flagset) *_fset;			\
+		typeof(v.flagset) *_fset;			\
 								\
 		/* Check that the flags fit in the mask */	\
 		BUILD_BUG_ON(HWEIGHT(m) != HWEIGHT((f) | (m)));	\
@@ -813,11 +813,11 @@ struct kvm_vcpu_arch {
 		BUILD_BUG_ON((sizeof(*_fset) * 8) <= __fls(m));	\
 	} while (0)
 
-#define __vcpu_get_flag(v, flagset, f, m)			\
+#define __kvm_get_flag(v, flagset, f, m)			\
 	({							\
 		__build_check_flag(v, flagset, f, m);		\
 								\
-		READ_ONCE(v->arch.flagset) & (m);		\
+		READ_ONCE(v.flagset) & (m);		\
 	})
 
 /*
@@ -826,64 +826,64 @@ struct kvm_vcpu_arch {
  */
 #ifdef __KVM_NVHE_HYPERVISOR__
 /* the nVHE hypervisor is always non-preemptible */
-#define __vcpu_flags_preempt_disable()
-#define __vcpu_flags_preempt_enable()
+#define __kvm_flags_preempt_disable()
+#define __kvm_flags_preempt_enable()
 #else
-#define __vcpu_flags_preempt_disable()	preempt_disable()
-#define __vcpu_flags_preempt_enable()	preempt_enable()
+#define __kvm_flags_preempt_disable()	preempt_disable()
+#define __kvm_flags_preempt_enable()	preempt_enable()
 #endif
 
-#define __vcpu_set_flag(v, flagset, f, m)			\
+#define __kvm_set_flag(v, flagset, f, m)			\
 	do {							\
-		typeof(v->arch.flagset) *fset;			\
+		typeof(v.flagset) *fset;			\
 								\
 		__build_check_flag(v, flagset, f, m);		\
 								\
-		fset = &v->arch.flagset;			\
-		__vcpu_flags_preempt_disable();			\
+		fset = &v.flagset;			\
+		__kvm_flags_preempt_disable();			\
 		if (HWEIGHT(m) > 1)				\
 			*fset &= ~(m);				\
 		*fset |= (f);					\
-		__vcpu_flags_preempt_enable();			\
+		__kvm_flags_preempt_enable();			\
 	} while (0)
 
-#define __vcpu_clear_flag(v, flagset, f, m)			\
+#define __kvm_clear_flag(v, flagset, f, m)			\
 	do {							\
-		typeof(v->arch.flagset) *fset;			\
+		typeof(v.flagset) *fset;			\
 								\
 		__build_check_flag(v, flagset, f, m);		\
 								\
-		fset = &v->arch.flagset;			\
-		__vcpu_flags_preempt_disable();			\
+		fset = &v.flagset;			\
+		__kvm_flags_preempt_disable();			\
 		*fset &= ~(m);					\
-		__vcpu_flags_preempt_enable();			\
+		__kvm_flags_preempt_enable();			\
 	} while (0)
 
-#define vcpu_get_flag(v, ...)	__vcpu_get_flag((v), __VA_ARGS__)
-#define vcpu_set_flag(v, ...)	__vcpu_set_flag((v), __VA_ARGS__)
-#define vcpu_clear_flag(v, ...)	__vcpu_clear_flag((v), __VA_ARGS__)
+#define vcpu_get_flag(v, ...)	__kvm_get_flag(((v)->arch), __VA_ARGS__)
+#define vcpu_set_flag(v, ...)	__kvm_set_flag(((v)->arch), __VA_ARGS__)
+#define vcpu_clear_flag(v, ...)	__kvm_clear_flag(((v)->arch), __VA_ARGS__)
 
 /* SVE exposed to guest */
-#define GUEST_HAS_SVE		__vcpu_single_flag(cflags, BIT(0))
+#define GUEST_HAS_SVE		__kvm_single_flag(cflags, BIT(0))
 /* SVE config completed */
-#define VCPU_SVE_FINALIZED	__vcpu_single_flag(cflags, BIT(1))
+#define VCPU_SVE_FINALIZED	__kvm_single_flag(cflags, BIT(1))
 /* PTRAUTH exposed to guest */
-#define GUEST_HAS_PTRAUTH	__vcpu_single_flag(cflags, BIT(2))
+#define GUEST_HAS_PTRAUTH	__kvm_single_flag(cflags, BIT(2))
 /* KVM_ARM_VCPU_INIT completed */
-#define VCPU_INITIALIZED	__vcpu_single_flag(cflags, BIT(3))
+#define VCPU_INITIALIZED	__kvm_single_flag(cflags, BIT(3))
 
 /* Exception pending */
-#define PENDING_EXCEPTION	__vcpu_single_flag(iflags, BIT(0))
+#define PENDING_EXCEPTION	__kvm_single_flag(iflags, BIT(0))
 /*
  * PC increment. Overlaps with EXCEPT_MASK on purpose so that it can't
  * be set together with an exception...
  */
-#define INCREMENT_PC		__vcpu_single_flag(iflags, BIT(1))
+#define INCREMENT_PC		__kvm_single_flag(iflags, BIT(1))
 /* Target EL/MODE (not a single flag, but let's abuse the macro) */
-#define EXCEPT_MASK		__vcpu_single_flag(iflags, GENMASK(3, 1))
+#define EXCEPT_MASK		__kvm_single_flag(iflags, GENMASK(3, 1))
 
 /* Helpers to encode exceptions with minimum fuss */
-#define __EXCEPT_MASK_VAL	unpack_vcpu_flag(EXCEPT_MASK)
+#define __EXCEPT_MASK_VAL	unpack_kvm_flag(EXCEPT_MASK)
 #define __EXCEPT_SHIFT		__builtin_ctzl(__EXCEPT_MASK_VAL)
 #define __vcpu_except_flags(_f)	iflags, (_f << __EXCEPT_SHIFT), __EXCEPT_MASK_VAL
 
@@ -907,28 +907,28 @@ struct kvm_vcpu_arch {
 #define EXCEPT_AA64_EL2_FIQ	__vcpu_except_flags(6)
 #define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
 /* Guest debug is live */
-#define DEBUG_DIRTY		__vcpu_single_flag(iflags, BIT(4))
+#define DEBUG_DIRTY		__kvm_single_flag(iflags, BIT(4))
 /* Save SPE context if active  */
-#define DEBUG_STATE_SAVE_SPE	__vcpu_single_flag(iflags, BIT(5))
+#define DEBUG_STATE_SAVE_SPE	__kvm_single_flag(iflags, BIT(5))
 /* Save TRBE context if active  */
-#define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
+#define DEBUG_STATE_SAVE_TRBE	__kvm_single_flag(iflags, BIT(6))
 
 /* SVE enabled for host EL0 */
-#define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
+#define HOST_SVE_ENABLED	__kvm_single_flag(sflags, BIT(0))
 /* SME enabled for EL0 */
-#define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
+#define HOST_SME_ENABLED	__kvm_single_flag(sflags, BIT(1))
 /* Physical CPU not in supported_cpus */
-#define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(2))
+#define ON_UNSUPPORTED_CPU	__kvm_single_flag(sflags, BIT(2))
 /* WFIT instruction trapped */
-#define IN_WFIT			__vcpu_single_flag(sflags, BIT(3))
+#define IN_WFIT			__kvm_single_flag(sflags, BIT(3))
 /* vcpu system registers loaded on physical CPU */
-#define SYSREGS_ON_CPU		__vcpu_single_flag(sflags, BIT(4))
+#define SYSREGS_ON_CPU		__kvm_single_flag(sflags, BIT(4))
 /* Software step state is Active-pending */
-#define DBG_SS_ACTIVE_PENDING	__vcpu_single_flag(sflags, BIT(5))
+#define DBG_SS_ACTIVE_PENDING	__kvm_single_flag(sflags, BIT(5))
 /* PMUSERENR for the guest EL0 is on physical CPU */
-#define PMUSERENR_ON_CPU	__vcpu_single_flag(sflags, BIT(6))
+#define PMUSERENR_ON_CPU	__kvm_single_flag(sflags, BIT(6))
 /* WFI instruction trapped */
-#define IN_WFI			__vcpu_single_flag(sflags, BIT(7))
+#define IN_WFI			__kvm_single_flag(sflags, BIT(7))
 
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index 424a5107cddb..6bb61e933644 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -320,13 +320,13 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_el1_is_32bit(vcpu)) {
 		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
-		case unpack_vcpu_flag(EXCEPT_AA32_UND):
+		case unpack_kvm_flag(EXCEPT_AA32_UND):
 			enter_exception32(vcpu, PSR_AA32_MODE_UND, 4);
 			break;
-		case unpack_vcpu_flag(EXCEPT_AA32_IABT):
+		case unpack_kvm_flag(EXCEPT_AA32_IABT):
 			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 12);
 			break;
-		case unpack_vcpu_flag(EXCEPT_AA32_DABT):
+		case unpack_kvm_flag(EXCEPT_AA32_DABT):
 			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
 			break;
 		default:
@@ -335,15 +335,15 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 		}
 	} else {
 		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
-		case unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC):
+		case unpack_kvm_flag(EXCEPT_AA64_EL1_SYNC):
 			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
 			break;
 
-		case unpack_vcpu_flag(EXCEPT_AA64_EL2_SYNC):
+		case unpack_kvm_flag(EXCEPT_AA64_EL2_SYNC):
 			enter_exception64(vcpu, PSR_MODE_EL2h, except_type_sync);
 			break;
 
-		case unpack_vcpu_flag(EXCEPT_AA64_EL2_IRQ):
+		case unpack_kvm_flag(EXCEPT_AA64_EL2_IRQ):
 			enter_exception64(vcpu, PSR_MODE_EL2h, except_type_irq);
 			break;
 
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index a640e839848e..a7a2540cc507 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -83,7 +83,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 
 	esr |= ESR_ELx_FSC_EXTABT;
 
-	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC))) {
+	if (match_target_el(vcpu, unpack_kvm_flag(EXCEPT_AA64_EL1_SYNC))) {
 		vcpu_write_sys_reg(vcpu, addr, FAR_EL1);
 		vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
 	} else {
@@ -105,7 +105,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	if (kvm_vcpu_trap_il_is32bit(vcpu))
 		esr |= ESR_ELx_IL;
 
-	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC)))
+	if (match_target_el(vcpu, unpack_kvm_flag(EXCEPT_AA64_EL1_SYNC)))
 		vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
 	else
 		vcpu_write_sys_reg(vcpu, esr, ESR_EL2);
diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index ab365e839874..1728e37739fe 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -79,17 +79,17 @@ static bool kvm_pending_sync_exception(struct kvm_vcpu *vcpu)
 
 	if (vcpu_el1_is_32bit(vcpu)) {
 		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
-		case unpack_vcpu_flag(EXCEPT_AA32_UND):
-		case unpack_vcpu_flag(EXCEPT_AA32_IABT):
-		case unpack_vcpu_flag(EXCEPT_AA32_DABT):
+		case unpack_kvm_flag(EXCEPT_AA32_UND):
+		case unpack_kvm_flag(EXCEPT_AA32_IABT):
+		case unpack_kvm_flag(EXCEPT_AA32_DABT):
 			return true;
 		default:
 			return false;
 		}
 	} else {
 		switch (vcpu_get_flag(vcpu, EXCEPT_MASK)) {
-		case unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC):
-		case unpack_vcpu_flag(EXCEPT_AA64_EL2_SYNC):
+		case unpack_kvm_flag(EXCEPT_AA64_EL1_SYNC):
+		case unpack_kvm_flag(EXCEPT_AA64_EL2_SYNC):
 			return true;
 		default:
 			return false;
-- 
2.34.1


