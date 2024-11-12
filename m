Return-Path: <linux-kernel+bounces-405685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACAE9C56A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B27B3FF73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC41CD208;
	Tue, 12 Nov 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUvsjn3g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F567213EE0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407919; cv=none; b=nPzfK9HNZ0aU5w0LDDIXU+KME0eClKkdDqUrmdN8IKa/njJHWSXUdq1jZVX/lEVt7BhWCZFV+NDGUdX0T3k1HasdI0xu1UPLNBTm2+PEj7ScVnf73inUtuismB7TqyE7sw1W/Em1dIA4u0k6aTJpy9qc7t+VEXZcwpuGEyHcWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407919; c=relaxed/simple;
	bh=VnWsmMKnMInILDBhUOtDjYLT82C4LM+EO+fLcBWjlPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fti2N6T2sE5gIjUN5dligGNG5Z7DDVBuERccGV2GbqDvMeSQLgHAj7le9hzyL7gXAdwUasR0zWR2n3zziU6HlfAmdil7qCryoXlyZyIEWfXq6Iosr+2xL2AQveZmDsLJx2l/o+CMsXx16SWW3vEdtZkqBpjjAKVo+gZghC04A3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUvsjn3g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431688d5127so43358235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407915; x=1732012715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PUUdanfV8/dMTaROo3OjL1mScK+2ashhKsQ/yXMrNE=;
        b=uUvsjn3g83dazk2GBBXh03T8s1xRfSNXBdBIzZrzzfKVPIB2y/U0jjp/GommMyPHc6
         nf6fljAy8clCpXdlRIQOIKDNGLgX1Mm2ywhXd4SAFC2vLqP34UTjRlkQLvd/NiCNtDmS
         XcU6TlGMYmYjvt/e+Jfz/DakzlPpJK3jPLkJOlWNiOCW5yUfYUNyS3xNMDhz/IU0UgNA
         9yNAvt5nKullQDsOQ3pLicdjivn6fbYhVR3d3XWramwIumLSxq7rHH7iCKYsRhXZrc+W
         f1RfZJsGZTeWE50l0qW5o+ayqqungRqulnnSlWKGUFO/BHdE/MbeymBp558Bncy+NF+B
         o2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407915; x=1732012715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PUUdanfV8/dMTaROo3OjL1mScK+2ashhKsQ/yXMrNE=;
        b=CtN1K9JDdwlNoCg0zaZb950HA0RdJ+fw+qu0/Y1ZCwF7yMVgwWp26gMtUsWwWpjL/S
         HaCt8lMatN6Md6ayEKQWNKpEyjtVhZGCOPpOdZwl9orKos20cMVR1Dk2S+tdD5McDbzQ
         LJNY6kwhIJTjz5DyXjzvEmxsb10E8/R01Y2t6cRfEEDRvvmhpAHn3RLlZTGfB2hrmi/H
         yJM+Clo1Q8E/ExUpgEzmBCuIur7ncm0SjBPAbgYLUMRDS4gBQXoZseYXcZGB3RpURNnO
         WqG91u9TA8RO03Wf+bDj/bLIHqRtA/JdJyHfPe9z1rx8O9PpINGgmXsBEXCE/s8PRQ2C
         5rOA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6UZ8eqs7SSpgoXTqSm9+15jwvB0rg84o5erlsZ9OJ2uYSg+R6erByxD10K4kEYNrki2HOPJUqoMGjW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lTfncBhroXGZJd02ZOLS5g7ConywrdVoPs3Pctx1x11mT1nP
	k8kK/7lYuO/iiJta20ZS3d6m+4SrQKutAO0bbX0XjT8YhHyMbqn7RDI1nn8DNu0=
X-Google-Smtp-Source: AGHT+IGRUXiwIphPDLp8SPINsrbnyjqSeYnthdnyXbEy6DX7IRif2HAVNDMi2ra2ERahPrHHXoqCRw==
X-Received: by 2002:a05:600c:35d5:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-432b7503749mr126843845e9.11.1731407915453;
        Tue, 12 Nov 2024 02:38:35 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:38:34 -0800 (PST)
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
	Anshuman Khandual <anshuman.khandual@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Fuad Tabba <tabba@google.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/12] KVM: arm64: Don't hit sysregs to see if SPE is enabled or not
Date: Tue, 12 Nov 2024 10:37:07 +0000
Message-Id: <20241112103717.589952-9-james.clark@linaro.org>
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

Now that the driver tells us whether SPE was used or not we can use
that. Except in pKVM where the host isn't trusted we keep the existing
feature + sysreg check.

The unconditional zeroing of pmscr_el1 if nothing is saved can also be
dropped. Zeroing it after the restore has the same effect, but only
incurs the write if it was actually enabled.

Now in the normal nVHE case, SPE saving is gated by a single flag read
on kvm_host_data.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_hyp.h   |  2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 52 ++++++++++++++++++------------
 arch/arm64/kvm/hyp/nvhe/switch.c   |  2 +-
 3 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index c838309e4ec4..4039a42ca62a 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -105,7 +105,7 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu);
 void __debug_switch_to_host(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_NVHE_HYPERVISOR__
-void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu);
+void __debug_save_host_buffers_nvhe(void);
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 #endif
 
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 89f44a51a172..578c549af3c6 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -14,24 +14,23 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
-static void __debug_save_spe(u64 *pmscr_el1)
+static bool __debug_spe_enabled(void)
 {
-	u64 reg;
-
-	/* Clear pmscr in case of early return */
-	*pmscr_el1 = 0;
-
 	/*
-	 * At this point, we know that this CPU implements
-	 * SPE and is available to the host.
-	 * Check if the host is actually using it ?
+	 * Check if the host is actually using SPE. In pKVM read the state,
+	 * otherwise just trust that the host told us it was being used.
 	 */
-	reg = read_sysreg_s(SYS_PMBLIMITR_EL1);
-	if (!(reg & BIT(PMBLIMITR_EL1_E_SHIFT)))
-		return;
+	if (unlikely(is_protected_kvm_enabled()))
+		return host_data_get_flag(HOST_FEAT_HAS_SPE) &&
+		       (read_sysreg_s(SYS_PMBLIMITR_EL1) & PMBLIMITR_EL1_E);
+	else
+		return host_data_get_flag(HOST_STATE_SPE_EN);
+}
 
-	/* Yes; save the control register and disable data generation */
-	*pmscr_el1 = read_sysreg_el1(SYS_PMSCR);
+static void __debug_save_spe(void)
+{
+	/* Save the control register and disable data generation */
+	*host_data_ptr(host_debug_state.pmscr_el1) = read_sysreg_el1(SYS_PMSCR);
 	write_sysreg_el1(0, SYS_PMSCR);
 	isb();
 
@@ -39,8 +38,14 @@ static void __debug_save_spe(u64 *pmscr_el1)
 	psb_csync();
 }
 
-static void __debug_restore_spe(u64 pmscr_el1)
+static void __debug_restore_spe(void)
 {
+	u64 pmscr_el1 = *host_data_ptr(host_debug_state.pmscr_el1);
+
+	/*
+	 * PMSCR was set to 0 to disable so if it's already 0, no restore is
+	 * necessary.
+	 */
 	if (!pmscr_el1)
 		return;
 
@@ -49,6 +54,13 @@ static void __debug_restore_spe(u64 pmscr_el1)
 
 	/* Re-enable data generation */
 	write_sysreg_el1(pmscr_el1, SYS_PMSCR);
+
+	/*
+	 * Disable future restores until a non zero value is saved again. Since
+	 * this is called unconditionally on exit, future register writes are
+	 * skipped until they are needed again.
+	 */
+	*host_data_ptr(host_debug_state.pmscr_el1) = 0;
 }
 
 static void __debug_save_trace(u64 *trfcr_el1)
@@ -79,11 +91,12 @@ static void __debug_restore_trace(u64 trfcr_el1)
 	write_sysreg_el1(trfcr_el1, SYS_TRFCR);
 }
 
-void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
+void __debug_save_host_buffers_nvhe(void)
 {
 	/* Disable and flush SPE data generation */
-	if (host_data_get_flag(HOST_FEAT_HAS_SPE))
-		__debug_save_spe(host_data_ptr(host_debug_state.pmscr_el1));
+	if (__debug_spe_enabled())
+		__debug_save_spe();
+
 	/* Disable and flush Self-Hosted Trace generation */
 	if (host_data_get_flag(HOST_FEAT_HAS_TRBE))
 		__debug_save_trace(host_data_ptr(host_debug_state.trfcr_el1));
@@ -96,8 +109,7 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
 
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
-	if (host_data_get_flag(HOST_FEAT_HAS_SPE))
-		__debug_restore_spe(*host_data_ptr(host_debug_state.pmscr_el1));
+	__debug_restore_spe();
 	if (host_data_get_flag(HOST_FEAT_HAS_TRBE))
 		__debug_restore_trace(*host_data_ptr(host_debug_state.trfcr_el1));
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index cc69106734ca..edd657797463 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -300,7 +300,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * translation regime to EL2 (via MDCR_EL2_E2PB == 0) and
 	 * before we load guest Stage1.
 	 */
-	__debug_save_host_buffers_nvhe(vcpu);
+	__debug_save_host_buffers_nvhe();
 
 	/*
 	 * We're about to restore some new MMU state. Make sure
-- 
2.34.1


