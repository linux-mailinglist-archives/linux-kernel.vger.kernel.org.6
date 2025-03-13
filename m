Return-Path: <linux-kernel+bounces-558844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B0A5EC01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E8016C08F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8B1FC0E6;
	Thu, 13 Mar 2025 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mND6Y5s7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078001FCD08
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849110; cv=none; b=tkG7zErxNAl1/B/gGmYU5MsTDAA+qcLczF/oevima/hHMgVS/8WWEZ2+ofk16ZMTW/W+yUisUEqxN0L0L55Js6qe0HyQwdRPFUh1dWic1csawl37GPOSpAzY9Hz0HL0uW6jj+fn/zMIMDA55AQF8nGTfW7oDqnUWKCB8gnOUonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849110; c=relaxed/simple;
	bh=UG93/JN+C4uzEWrf1epKiCm9PjOLeEr0WUFlntrYe/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atghY3Aw1UBYs1T307HbNPXCxo0zfYcoh16IVV65padAyWyURXIpq+rB97yZsIOs2i6OLI6HGgMRSCenFxxAq0h1G5GvC9s5WlJzku2i/znBKOBM5IKMhGG8+x26WKbTBsp8CTiNgdCc4r0C3XuOumImmuRBbSAvH3gNJWelQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=mND6Y5s7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22438c356c8so11029455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849108; x=1742453908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7fhBUFv13S4cZKboUgbYf/t6ZbQKDXA1phxFoEaqP4=;
        b=mND6Y5s7Vx4+aEoxZ7gbttc2sJtowpoYFncKWNJR/aIx4z2j6JDuP9YEPK+oUTkEjI
         +eApXwhhHHJv4nK+oVEmYbiQ/8yhRCoCgEIacYp8DZeNVtW3Mgv2+nTFKFaTs4k+kMfV
         5wAK//3Y0Z1kOqb54P1rrquLdoMA7NUE52+B7lbWAFec7OISt+IfpReeofz5Kepd1d5D
         /3vZg6KKfF/O+R1QuZhJNI5oCkc9MbiiI2+Ur6F1r19V4cXGcpbuK6uGc7OQbB/81hm3
         1iF+kBIe9yCjZwhxSB/cgPsXnsxw/NM0nrqKM6EE6A7Qj1H36HhMWIoa32EemcI9LgQL
         293w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849108; x=1742453908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7fhBUFv13S4cZKboUgbYf/t6ZbQKDXA1phxFoEaqP4=;
        b=ErahBQ2PgRlsH973eZx08ZMUxVZ1jIaxfESNTSkgVl6Vy+86te8n1KIBVQ3c+p7GV3
         w3xJyUcI+BOuJsZhnX80Sv8gbCoKyU+dr+TZl1ZghdM3PA5dGO/A2Syn8tPcdiftA4BT
         jjQ2nBBXyCEywAbVTarhyOTnrV86ffcvaeLIVNLVDs3E0WgQ9rQe2Gx4G/FrutVZA5LN
         FZd2IzvVxmiSxZ3d6G/xQFuifbP8qctjFAIVuwxMV73kl0r7WLfUWWY7dJypQ+kZP4Sk
         IdUWUbTXnIa7REpwQknTWavLHRLg3npJyZFEKJSftGousgMx/cufgjPKpZBUU1MuUb+g
         JcsA==
X-Forwarded-Encrypted: i=1; AJvYcCUM1+TuRBlMMy4xkX2xC4inIAVaONI5o4YlmpweKIPHO+w7TH0S9AIsX8GduArgZ4+j76tG6a9v1RGK7f8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0DXgiTEV1RFUbxO7Y/JL2JO4IvGyw/0vzK/3tboxdVXRPDaJ
	k+36Bn0GBxFmnEEQBbP82eS0ASgwnuXQ8P91nWz8sNtlIqSyhGJUsxMIHUAR+Nk=
X-Gm-Gg: ASbGncv0dG5DvjbQXvkVFm32tJRPr3mOe4hsdvquaMKkAbQ0XpSO6IzP31X1PfuCs/m
	EpSKUMadj59F/N9HTTa8IqzZbz1boFo0lSuGNdj3GsZDmymxxycbU4IVvN2zwh51gYJOQkWRTk0
	ajejzL0Yaqaz5dq/BsWfkkiWUJx/zcbwM8Q4Rq8l1AOU+4Ty/Kas1p+ZuP29gkha5BQ794sVIBG
	eyQ+FY8z4y547S6vGEr1+m+LAKnJCrbTJKYCikrulbMisHoJ9dNwngwPPHKtY3e3h2EXGq8lNDZ
	SLiA0y914gxZ4mNtVdVKRiIKpN5lFB3VcXxkvKIq+/ZPdvUP
X-Google-Smtp-Source: AGHT+IF+TgNoMe5M/byYKEN+EBcKDv/E4YdTnk5/x7Qy9/IKHZJiaku/6SW8IuLAbysNFNl6dwBYew==
X-Received: by 2002:a17:902:ec91:b0:223:5e54:c521 with SMTP id d9443c01a7336-22428407e93mr350878545ad.0.1741849108400;
        Wed, 12 Mar 2025 23:58:28 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd4dabsm6447105ad.233.2025.03.12.23.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:58:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:57:48 +0900
Subject: [PATCH v4 7/7] KVM: arm64: PMU: Reload when resetting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pmc-v4-7-2c976827118c@daynix.com>
References: <20250313-pmc-v4-0-2c976827118c@daynix.com>
In-Reply-To: <20250313-pmc-v4-0-2c976827118c@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Replace kvm_pmu_vcpu_reset() with the generic PMU reloading mechanism to
ensure the consistency with system registers and to reduce code size.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 14 --------------
 arch/arm64/kvm/reset.c    |  3 ---
 arch/arm64/kvm/sys_regs.c |  3 +++
 include/kvm/arm_pmu.h     |  2 --
 4 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index dfa7048a3e2a..62b1deba9856 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -248,20 +248,6 @@ void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
 		pmu->pmc[i].idx = i;
 }
 
-/**
- * kvm_pmu_vcpu_reset - reset pmu state for cpu
- * @vcpu: The vcpu pointer
- *
- */
-void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
-{
-	unsigned long mask = kvm_pmu_valid_counter_mask(vcpu);
-	int i;
-
-	for_each_set_bit(i, &mask, 32)
-		kvm_pmu_stop_counter(kvm_vcpu_idx_to_pmc(vcpu, i));
-}
-
 /**
  * kvm_pmu_vcpu_destroy - free perf event of PMU for cpu
  * @vcpu: The vcpu pointer
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 0b0ae5ae7bc2..7f44539bc822 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -201,9 +201,6 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.reset_state.reset = false;
 	spin_unlock(&vcpu->arch.mp_state_lock);
 
-	/* Reset PMU outside of the non-preemptible section */
-	kvm_pmu_vcpu_reset(vcpu);
-
 	preempt_disable();
 	loaded = (vcpu->cpu != -1);
 	if (loaded)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 11718c635e2f..307ce37d0434 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4262,6 +4262,9 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	}
 
 	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
+
+	if (kvm_vcpu_has_pmu(vcpu))
+		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 }
 
 /**
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 9c062756ebfa..8ec6296c5917 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -45,7 +45,6 @@ void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 v
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
 void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
-void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val);
@@ -108,7 +107,6 @@ static inline u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 	return 0;
 }
 static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}

-- 
2.48.1


