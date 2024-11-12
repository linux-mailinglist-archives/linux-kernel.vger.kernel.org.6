Return-Path: <linux-kernel+bounces-405687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C29C554B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388FA1F21517
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1820D4F5;
	Tue, 12 Nov 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifzObf1H"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F451C1AD1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407937; cv=none; b=bnI+T8Xmnh68BM++zrQhoPiMHVH/eu6yxqSdIIkmChiM5h1ZTEIRB8wxTydGMFrglZgdRP8SfsEjE6OrQNPYkB2EOIJxQlY1OGuprXxWP3hNdgHJaPvK01MIzNIZ0IezWlyQA+o+QSBKtcMn9u01l98lmoxECjhRvm/n0Jqj0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407937; c=relaxed/simple;
	bh=gJX4fpAnmRlIzwVuBDoaMY8pi4WArGBc4Po0d2y33so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EEYHOe72PZJYW1fNOGCDs4gjhI2e4rCMnTASquPPOg33gFsTy7Z+mUeLgx9Ekc+Mm0AyMpNjGmvsQiCzpoT37rOxWsGzqbBdkSS/opBq3gVl5Si6dn8ZrLYN08h6UPql2cbBYnHZqb/ueCASzj1vkqyaaIIPiUbrAbTRcqmvvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ifzObf1H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so47495465e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407934; x=1732012734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4Y12830R+W7ydXEFfviSLc+JWTSWnSDcOvb7pMp1YA=;
        b=ifzObf1HmwUXyxtXevj8uqE6lPZ2Oz/EAoTAAJoTfrNPu6yY5WBcdAHH95+APFvGlZ
         lO1ExafcmtOmhluwZK0dDDofU4hgTfSx6L0Gb2Q/LrcfsmW0s1CllnwpkykBu7GP4KZZ
         gTTUH/AGp24L8dbCsUb79qLyQdFbTAEQXWu+H7mvXomKnxciOhWCHyYgJ63WxThE7E6e
         cgLQ+2xU3ZkmzxInJcSfoDyYFubTaHIypXHhIRDdHiMZnBSULqdYa5SX0XoChRMhB0BO
         ngr05vvYfJgYhcs4zt/TDxkSoJIgkQEFgBGMrIP3evd1plP/GYiGAEaPp/ueWWcDEuo5
         j9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407934; x=1732012734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4Y12830R+W7ydXEFfviSLc+JWTSWnSDcOvb7pMp1YA=;
        b=e9FD2GhO629CKF21ACMH1gt6yiRGbayHKBLZuEK7MHULaC1NL5FnrTsAoWNKok4reB
         hConKzHMPgrxNz9ebuQ+05XYFcrFy9qm7j6D1l829UdjAhbABMJBsTyKWcoGVYQsXoF5
         YKxxQ/i3h5g3VOA/Besf3bUqooUqrFbiWIluejDUbZaw7+7kZQaWrw/xidLv/OYw2Q0c
         8nw7tGiywPx87xjuLNsY5KpKYJursd4gunGiExm2Ipd5eYogomzOWduyZ9dESMIQFFRZ
         cvDmNkEmx7vfGX4knGiXn05PE+tLqQXTAACCryElPNNxpZjDw5dgviGTm63A+v04RaZL
         3xwA==
X-Forwarded-Encrypted: i=1; AJvYcCVbqK+4qBDYI+HvQt2HiBXhRPjA0iyqoqIG1pfPs60VeG3IZjJLZcWmZ+SnSkF6A16WpI7m3J9s9pVil6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT59r6WJgX1dkemTFyoQkTjZFWANV+doCu0HIGSXwAvxMkD9KN
	9iR/PRVgBrdz5WUlB5qIh9B+6kCldXAAqd0RFKWM3u5hiJ3ddMUp7upJA4ORRak=
X-Google-Smtp-Source: AGHT+IFFrkKNgQSMLjx9o9fyzR37XC2Gr6CvPJDOYVlojhp8ArNiU1b7bN0q0qpEMeG5HrMUFygnww==
X-Received: by 2002:a5d:6c64:0:b0:37d:4a82:6412 with SMTP id ffacd0b85a97d-381f1885db0mr12627127f8f.46.1731407933761;
        Tue, 12 Nov 2024 02:38:53 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:38:53 -0800 (PST)
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
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Fuad Tabba <tabba@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/12] KVM: arm64: Don't hit sysregs to see if TRBE is enabled or not
Date: Tue, 12 Nov 2024 10:37:09 +0000
Message-Id: <20241112103717.589952-11-james.clark@linaro.org>
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

Now that the driver tells us whether TRBE was used or not we can use
that. Except in pKVM where the host isn't trusted we keep the existing
feature + sysreg check.

Now in the normal nVHE case, TRBE save and restore are gated by flag
checks on kvm_host_data.

Instead of using a magic value of host_debug_state.trfcr_el1 to
determine whether to restore, add a flag. This will also simplify the
logic in the next commit where restoration but no disabling is required.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h  |  2 ++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 51 +++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b1dccac996a6..a8846689512b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -947,6 +947,8 @@ struct kvm_vcpu_arch {
 #define HOST_STATE_SPE_EN	__kvm_single_flag(state, BIT(0))
 /* TRBLIMITR_EL1_E is set (TRBE trace buffer enabled) */
 #define HOST_STATE_TRBE_EN	__kvm_single_flag(state, BIT(1))
+/* Hyp modified TRFCR */
+#define HOST_STATE_RESTORE_TRFCR __kvm_single_flag(state, BIT(2))
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 578c549af3c6..17c23e52f5f4 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -63,32 +63,55 @@ static void __debug_restore_spe(void)
 	*host_data_ptr(host_debug_state.pmscr_el1) = 0;
 }
 
-static void __debug_save_trace(u64 *trfcr_el1)
+static bool __debug_should_save_trace(void)
 {
-	*trfcr_el1 = 0;
+	/* pKVM reads the state for itself rather than trusting the host */
+	if (unlikely(is_protected_kvm_enabled())) {
+		/* Always disable any trace regardless of TRBE */
+		if (read_sysreg_el1(SYS_TRFCR) &
+		    (TRFCR_ELx_E0TRE | TRFCR_ELx_ExTRE))
+			return true;
+
+		/*
+		 * Trace could already be disabled but TRBE buffer
+		 * might still need to be drained if it was in use.
+		 */
+		if (host_data_get_flag(HOST_FEAT_HAS_TRBE))
+			return read_sysreg_s(SYS_TRBLIMITR_EL1) &
+			       TRBLIMITR_EL1_E;
+	}
+
+	return host_data_get_flag(HOST_STATE_TRBE_EN);
+}
 
-	/* Check if the TRBE is enabled */
-	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
-		return;
+static void __debug_save_trace(void)
+{
 	/*
 	 * Prohibit trace generation while we are in guest.
 	 * Since access to TRFCR_EL1 is trapped, the guest can't
 	 * modify the filtering set by the host.
 	 */
-	*trfcr_el1 = read_sysreg_el1(SYS_TRFCR);
+	*host_data_ptr(host_debug_state.trfcr_el1) = read_sysreg_el1(SYS_TRFCR);
 	write_sysreg_el1(0, SYS_TRFCR);
 	isb();
 	/* Drain the trace buffer to memory */
 	tsb_csync();
+
+	host_data_set_flag(HOST_STATE_RESTORE_TRFCR);
 }
 
-static void __debug_restore_trace(u64 trfcr_el1)
+static void __debug_restore_trace(void)
 {
-	if (!trfcr_el1)
+	u64 trfcr_el1;
+
+	if (!host_data_get_flag(HOST_STATE_RESTORE_TRFCR))
 		return;
 
 	/* Restore trace filter controls */
+	trfcr_el1 = *host_data_ptr(host_debug_state.trfcr_el1);
+	*host_data_ptr(host_debug_state.trfcr_el1) = read_sysreg_el1(SYS_TRFCR);
 	write_sysreg_el1(trfcr_el1, SYS_TRFCR);
+	host_data_clear_flag(HOST_STATE_RESTORE_TRFCR);
 }
 
 void __debug_save_host_buffers_nvhe(void)
@@ -97,9 +120,14 @@ void __debug_save_host_buffers_nvhe(void)
 	if (__debug_spe_enabled())
 		__debug_save_spe();
 
+	/* Any trace filtering requires TRFCR register */
+	if (!host_data_get_flag(HOST_FEAT_HAS_TRF))
+		return;
+
 	/* Disable and flush Self-Hosted Trace generation */
-	if (host_data_get_flag(HOST_FEAT_HAS_TRBE))
-		__debug_save_trace(host_data_ptr(host_debug_state.trfcr_el1));
+	if (__debug_should_save_trace())
+		__debug_save_trace();
+
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -110,8 +138,7 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	__debug_restore_spe();
-	if (host_data_get_flag(HOST_FEAT_HAS_TRBE))
-		__debug_restore_trace(*host_data_ptr(host_debug_state.trfcr_el1));
+	__debug_restore_trace();
 }
 
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
-- 
2.34.1


