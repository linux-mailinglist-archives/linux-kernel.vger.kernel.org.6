Return-Path: <linux-kernel+bounces-405688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA69C554E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444531F20FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC13213EFA;
	Tue, 12 Nov 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXMCLK2U"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2B20B801
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407945; cv=none; b=XJ89768icjgHqb5XI+p7H6+wBSlzW9tTBuELYMPUO7rTSXX8N/PZb8l+5Bd0SfmSB8NQYER+lBKLM8tp1WmkqTBXVJNmS32c4LV0IIvzCHuj/2EHn87i7/iBkr1xPqD9aTmRoVqt43muqFXQhVY3dataD+Uu8L2i1MJ7XKKrihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407945; c=relaxed/simple;
	bh=p+rbt1X5lUuVjWAL59a43sfuObjYuDVvNvvFXOlyuiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrLUwHbdii7WGWU4iRmS//0sKXe8b9xopgff3LTTY4nQ1AlzydkR5pj8pwBhicJrjFUG0cfs7vOTNb9JbaDDoxajnuf7i0UCEZIthhO4Gto2iybJz4bROWJI1G9xyuRg5zwVUFZNftqqhz47MpuBRz9k7jxCZTNudBS+k+TRXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXMCLK2U; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d47eff9acso3341282f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407942; x=1732012742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTXqo//8eCQsBk4kbAKUkYayo6ux0h+eu3YzsPig2os=;
        b=QXMCLK2UgLXKUXVCmj77WWbzPPuooV6uNDh3V/dJJhAerq/rUGLWOCr67xcwlBpu6f
         +UeOVqLeb5HaAaweAQjXjrUeBOQoHzryvLKV25Ou+1vm96ILUE8cQT1SGO1NJhNwI70o
         rFLPZR2IM7eGstdF4KcOOQpEV37gVkZEYZ7yrT33BevZRfTXyBrwYF0Q78QfQvrz3144
         hSaQOi7Da3naixRpcBB2xXO48SHHjgzdj+z9TivePwsSt6fufz85IIBpQJPVlL/Mdgrh
         AZAc7HByWLivt2P+krjFwvl438AIM8ykRupU2B9hzxffDmHu0AcM/xfFKovg7W2b6s42
         +xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407942; x=1732012742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTXqo//8eCQsBk4kbAKUkYayo6ux0h+eu3YzsPig2os=;
        b=kqKuUnpccSID/wm3TaoUaeos1Wh9RtJhgSL//fmidzRAylNtyonZA2TqVDbq39gtws
         0FH3wDnB3pqbiA6Dt3K/1tVLUg0cwv9fP2z/GBx0TLk7PjMgmOdXu2N9OzDQw6bgNwfu
         5VXdMDMHPnYq9EzY7+/4aFtPFB2oHJL6ACse8TW2kLLB4vAtQPqEmB2ViIsZY97HRtVO
         qa5L3gaPt4VIWXe+8O6XZbl2VG6eRnP0vWes6un282mrObYg73VMvGWSOOjuXDO3NI8t
         faQnLN0A44iornYYc+3M1nNDjyF8ojpmBL5njL9Rh0MWnSYyfFiipAxneeLOfPBhhUEL
         9g0A==
X-Forwarded-Encrypted: i=1; AJvYcCW97bGjhKdTCd6wD9gS3yqdzfg0tp62F4b74CdoNFp8+nEGe4aX+70gdbTml8kM9otkqqQWthLyn5dAWng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90ijhU9z4vTVRN5YNTPpg7lTqEabsUGK6Rs2LgYWgZXEQ1j7C
	pm0RRELBqktFBsNzrLs9ffvfNBxR+ZXecefuOvFnXJEZdflCdnNmvruoSLYJYro=
X-Google-Smtp-Source: AGHT+IFyMdF9zAJjuyhAjQDTA00d8BetxuafJaMqAy1S8MkOFS5uQVVLGbU/acSR5z7cyBVpLtP1iA==
X-Received: by 2002:a5d:5f42:0:b0:37d:4436:4505 with SMTP id ffacd0b85a97d-381f186ccdemr13405089f8f.32.1731407942122;
        Tue, 12 Nov 2024 02:39:02 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:39:01 -0800 (PST)
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
Subject: [PATCH v7 11/12] KVM: arm64: Swap TRFCR on guest switch
Date: Tue, 12 Nov 2024 10:37:10 +0000
Message-Id: <20241112103717.589952-12-james.clark@linaro.org>
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

This implements exclude/include guest rules of the active tracing
session. Only do it if a different value is required for the guest,
otherwise the filters remain untouched.

In VHE we can just directly write the value.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h  |  4 ++++
 arch/arm64/kvm/debug.c             | 16 ++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 17 +++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a8846689512b..9109d10c656e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -949,6 +949,8 @@ struct kvm_vcpu_arch {
 #define HOST_STATE_TRBE_EN	__kvm_single_flag(state, BIT(1))
 /* Hyp modified TRFCR */
 #define HOST_STATE_RESTORE_TRFCR __kvm_single_flag(state, BIT(2))
+/* Host wants a different trace filters for the guest */
+#define HOST_STATE_SWAP_TRFCR	__kvm_single_flag(state, BIT(3))
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
@@ -1392,6 +1394,7 @@ void kvm_clr_pmu_events(u64 clr);
 bool kvm_set_pmuserenr(u64 val);
 void kvm_set_pmblimitr(u64 pmblimitr);
 void kvm_set_trblimitr(u64 trblimitr);
+void kvm_set_trfcr(u64 host_trfcr, u64 guest_trfcr);
 #else
 static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u64 clr) {}
@@ -1401,6 +1404,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
 }
 static inline void kvm_set_pmblimitr(u64 pmblimitr) {}
 static inline void kvm_set_trblimitr(u64 trblimitr) {}
+static inline void kvm_set_trfcr(u64 host_trfcr, u64 guest_trfcr) {}
 #endif
 
 void kvm_vcpu_load_vhe(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index e99df2c3f62a..9acec1b67d5f 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -380,3 +380,19 @@ void kvm_set_trblimitr(u64 trblimitr)
 		host_data_clear_flag(HOST_STATE_TRBE_EN);
 }
 EXPORT_SYMBOL_GPL(kvm_set_trblimitr);
+
+void kvm_set_trfcr(u64 host_trfcr, u64 guest_trfcr)
+{
+	if (kvm_arm_skip_trace_state())
+		return;
+
+	if (has_vhe())
+		write_sysreg_s(guest_trfcr, SYS_TRFCR_EL12);
+	else
+		if (host_trfcr != guest_trfcr) {
+			*host_data_ptr(host_debug_state.trfcr_el1) = guest_trfcr;
+			host_data_set_flag(HOST_STATE_SWAP_TRFCR);
+		} else
+			host_data_clear_flag(HOST_STATE_SWAP_TRFCR);
+}
+EXPORT_SYMBOL_GPL(kvm_set_trfcr);
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 17c23e52f5f4..47602c4d160a 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -100,6 +100,15 @@ static void __debug_save_trace(void)
 	host_data_set_flag(HOST_STATE_RESTORE_TRFCR);
 }
 
+static void __debug_swap_trace(void)
+{
+	u64 trfcr = read_sysreg_el1(SYS_TRFCR);
+
+	write_sysreg_el1(*host_data_ptr(host_debug_state.trfcr_el1), SYS_TRFCR);
+	*host_data_ptr(host_debug_state.trfcr_el1) = trfcr;
+	host_data_set_flag(HOST_STATE_RESTORE_TRFCR);
+}
+
 static void __debug_restore_trace(void)
 {
 	u64 trfcr_el1;
@@ -124,10 +133,14 @@ void __debug_save_host_buffers_nvhe(void)
 	if (!host_data_get_flag(HOST_FEAT_HAS_TRF))
 		return;
 
-	/* Disable and flush Self-Hosted Trace generation */
+	/*
+	 * Disable and flush Self-Hosted Trace generation for pKVM and TRBE,
+	 * or swap if host requires different guest filters.
+	 */
 	if (__debug_should_save_trace())
 		__debug_save_trace();
-
+	else if (host_data_get_flag(HOST_STATE_SWAP_TRFCR))
+		__debug_swap_trace();
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
-- 
2.34.1


