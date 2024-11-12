Return-Path: <linux-kernel+bounces-405710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403EF9C57B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F439B3C909
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD992144D0;
	Tue, 12 Nov 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPX0HHvW"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B82221FA9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408657; cv=none; b=T0DUE4qmPI+BPLjBYTIw1YtEbBbFnVRKqXErYg3hoS8jbHHEHuZdMCDneFOOdkdjZuxF7Blvj+hkWvlZWBKa1NT9yJTP6EUwMPq5PrgF7jxNAkT093IDqHXccuyYpqlhhhXWEMUcaw16N0oGEqV0suZPgY2HkAt0CqnBF/0d9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408657; c=relaxed/simple;
	bh=oWzV/03nYp1x6cwYsHMbk/vrrzEIWX7yUtI5U3uNiSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJXNCNFTX4vksr+GyMFfogUEHezQEGdwf5N2QTYY4Ml1sLl9RUrTRRhvsyphJrk7Qhr8JHuGYEWuqQPGxEuR/Ci23f12n2hLpBw8WJEI9jNqn7yUhAygw7Jz111vGwgMVQY/q3PSSZD21EeNPxUwlY1N8Ae3gZWGBOIleP2N4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uPX0HHvW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315abed18aso46754705e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731408654; x=1732013454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsN1AKfVr0DCt3ea+9xEDMwiA7+bJgbMxbEYUcuak9o=;
        b=uPX0HHvWkAVTcuy3i3kXrZaf/rRLfQkLoHpUtEoOvSbITYZcvW2HbONh+3kdKrxdYp
         jron+Cf+dq22xxcyJnGcT4dAVqhI3mQ4lUCZ+r5YKEa3CkFH/PtPIVd1LUkV9kow3REz
         yFiEynzP5nlT1xtqJQoiZFOX84MUO5/aOkSCfXMhkCGCJ3apr+Qd4GpTVzlybURlcjZl
         EikkjfZFbU18dwLqF5z/1rIjxpmeb84OnkghLZI8uHE6DkfscfPcIp/ZYKF3/c2rKpj7
         zDr2RzlzPILffg4SnpsmsDBXC0ZUlCs1Z7MqW/8yecSsnkNhHlqlA5So+BnVJ9aKDeRS
         utwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731408654; x=1732013454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsN1AKfVr0DCt3ea+9xEDMwiA7+bJgbMxbEYUcuak9o=;
        b=URD5JxPWDykxlbeEMIxYe6EUM0GKBXpqbaXpzZYfcqtN+GxofqRAkTCJ/+i22SXwcK
         Emkfhi9mm9ymhe+s7noR+EFaiVaGXlaDCQofwlpdKHNbPgwNAeJUjiPP2uZR9TfIuvGI
         aFlhbu5cuRoelSsD3H2En9yNKSew7e8TcDFyjS5OVq/rAH2xoc44mlO8ZKMJeeZ/fR1I
         BLAfX9egmX+E6A/UWXxwRZwcCflQucDRFxG5cQqIY2cCiKvPNAMFZXTqwXJsLrdeek91
         +ilDE2t+QFc6CwAoHF7iMPzmhHRm+jqnQHti5AkMSn12+don8Xykb69OeezXzZLBbT9D
         cHug==
X-Forwarded-Encrypted: i=1; AJvYcCUsXuk7fvvPQGfMwzHOgLAXQEC/DM1DrZ5JSOpa8/ibNYRskQDXDpAGt2fohaHmYszC6s1jk1wbK2xy38w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZxQd1g035D6bU3KLPiaDmhUiu6Cp1ooSKjVEWN7cGYDgNDI0
	dytOH3839kjqz8QgECqZwaNZzsG96hiOFBjMmSmvASe4PyHj2egHdnvq1sKLfno=
X-Google-Smtp-Source: AGHT+IEKeBbC4At05ppEunVvuC+fNmBSZ3Q9XWqfiNFLF4QIIvJpGZjKzAWEcxYQGDx0hubsAbMKIw==
X-Received: by 2002:a05:600c:6987:b0:431:3a6d:b84a with SMTP id 5b1f17b1804b1-432bcafc5a6mr109173125e9.4.1731408654402;
        Tue, 12 Nov 2024 02:50:54 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1f8sm248010955e9.30.2024.11.12.02.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:50:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: broonie@kernel.org,
	maz@kernel.org,
	kvmarm@lists.linux.dev
Cc: James Clark <james.clark@linaro.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Don't save FP traps in default cptr_el2 value
Date: Tue, 12 Nov 2024 10:50:31 +0000
Message-Id: <20241112105032.793274-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_get_reset_cptr_el2() is called at vcpu init before the vcpu is
loaded. Since the linked commit, the fp state was moved from the vcpu to
host data but it shouldn't be accessed at this point.

Move the bits that require guest_owns_fp_regs() out of the default value
and into just before they're used in activate and deactivate traps. This
fixes the following bug when nvhe && vcpu_has_sve() == true:

 BUG: using smp_processor_id() in preemptible [00000000] code: lkvm/118
 caller is debug_smp_processor_id+0x20/0x30
 CPU: 0 UID: 0 PID: 118 Comm: lkvm Not tainted 6.12.0-rc1+ #35
 Hardware name: FVP Base RevC (DT)
 Call trace:
  dump_backtrace+0xfc/0x120
  show_stack+0x24/0x38
  dump_stack_lvl+0x3c/0x98
  dump_stack+0x18/0x28
  check_preemption_disabled+0xe0/0xe8
  debug_smp_processor_id+0x20/0x30
  guest_owns_fp_regs+0x1c/0xb0
  kvm_arch_vcpu_ioctl+0xcfc/0xe10
  kvm_vcpu_ioctl+0x6c4/0x8a0
  __arm64_sys_ioctl+0x9c/0xe0
  invoke_syscall+0x4c/0x110
  el0_svc_common+0xb8/0xf0
  do_el0_svc+0x28/0x40
  el0_svc+0x4c/0xc0
  el0t_64_sync_handler+0x84/0x100
  el0t_64_sync+0x190/0x198

Fixes: 5294afdbf45a ("KVM: arm64: Exclude FP ownership from kvm_vcpu_arch")
Signed-off-by: James Clark <james.clark@linaro.org>
---

I'm only mildly confident that the logic here is equivalent to before.
Someone with a bit more context about the FP stuff can say, or if there
is a neater way to fix this issue altogether.

 arch/arm64/include/asm/kvm_emulate.h | 15 +++++++++------
 arch/arm64/kvm/hyp/nvhe/switch.c     |  3 ++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index cf811009a33c..0eefb9fb08a0 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -629,16 +629,12 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 			val |= CPACR_EL1_SMEN_EL1EN;
 	} else if (has_hvhe()) {
 		val = CPACR_ELx_FPEN;
-
-		if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs())
+		if (!vcpu_has_sve(vcpu))
 			val |= CPACR_ELx_ZEN;
 		if (cpus_have_final_cap(ARM64_SME))
 			val |= CPACR_ELx_SMEN;
 	} else {
 		val = CPTR_NVHE_EL2_RES1;
-
-		if (vcpu_has_sve(vcpu) && guest_owns_fp_regs())
-			val |= CPTR_EL2_TZ;
 		if (cpus_have_final_cap(ARM64_SME))
 			val &= ~CPTR_EL2_TSM;
 	}
@@ -648,8 +644,15 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 
 static __always_inline void kvm_reset_cptr_el2(struct kvm_vcpu *vcpu)
 {
-	u64 val = kvm_get_reset_cptr_el2(vcpu);
+	u64 val = vcpu->arch.cptr_el2;
 
+	if (has_hvhe()) {
+		if (!guest_owns_fp_regs())
+			val |= CPACR_ELx_ZEN;
+	} else if (!has_vhe()) {
+		if (vcpu_has_sve(vcpu) && guest_owns_fp_regs())
+			val |= CPTR_EL2_TZ;
+	}
 	kvm_write_cptr_el2(val);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index cc69106734ca..296c4155e1fc 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -60,7 +60,8 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 			val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
 
 		__activate_traps_fpsimd32(vcpu);
-	}
+	} else if (!has_hvhe() && vcpu_has_sve(vcpu))
+		val |= CPTR_EL2_TZ;
 
 	kvm_write_cptr_el2(val);
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
-- 
2.34.1


