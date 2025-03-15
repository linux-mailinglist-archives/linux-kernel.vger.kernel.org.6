Return-Path: <linux-kernel+bounces-562498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600DAA629AF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCFA1895542
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725CA1F8733;
	Sat, 15 Mar 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xbqEMg4R"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F291F8697
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029986; cv=none; b=eZDtnptQio30pxwQuva++g597v87whph989QH+vscV2+xAyf8tjk/8Hfan3PzPqSxFo1+twVWqXOgdng6WhiD0DSG3wFzDqFfhlAgNKNxUH25puzFYnRMEEE47xWq43iRi9iBeeGJKiIiuP5mvh3Ht5XHkyG4YIiIRDZ8W5OAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029986; c=relaxed/simple;
	bh=cpCjePvPaysnhttxyP2q0T1A8fwc/2SmBzZwgVCNmyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lnc2hrjKrj1EwabZt4CjsEpK4xx6HuwqswIbbEkBTe3qlPWWQelZiNhH+Hp63Be1T1eYBfACZpq2AGxEFR/DbW8ME+rSsoGoX5UEW3bxQos7iXr7KkBNy0Iy91WgsCOCty0grgVqXTY1xmpQ2B+L94+7i7iuc/PBilHvuwBJLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xbqEMg4R; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso639248a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742029984; x=1742634784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+bMpkAVOynda5P7ydoOSXioxAp6dNXrbOmJ322faHM=;
        b=xbqEMg4RNZLbQ/ffdW5prQiAnFGEIC5Uq2A81cy16kH40LM1lVqJ1BEXw58Q0lwfFN
         5IZ0dz9Z7uLuPaHiLfq/lfBvjvCujCdbrcnGrpUZfwSj+qvTEb+0nTbHYV74U7D9zDcE
         OOs1ME98suwMyWh2uBU5pIypUJc12Y5Yt2x+QDqXwXM231vzbNMLTGYYrmGHAm47rBhB
         hgAHQ3oWVppkU6y8VMi0MuypqUjOa0AVSaVdJMzglGhfoqIyRH41NJEjzy73lobKu+Sg
         3c/CUN8Y+gLpk2qPWxUeDl5RMA4XlTxjZDTIdEuh1qchLPkpmogZJxpjdE0Cb/0LMxME
         NaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029984; x=1742634784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+bMpkAVOynda5P7ydoOSXioxAp6dNXrbOmJ322faHM=;
        b=Y8lbvmgHN6F3SzAnfiUKoUGsNPnPDKh1qSEmkf/PluMLD7pJcFsu6abwCcr5pF44g9
         Tj3LOGLuUc9Bh6/KcnW4XD/8PEyRALFN8yx2u/8nZwWqHDCL8nj1Ptt1nHf+QfjwXVcI
         o/odTZuAB9xtvu/P7IU5SPUxYZS71TPNuc60lN2YPE/pvrbCE+LsjxN4L2Qahe4Ax2dg
         hpb7M8qfHm05qBKDMEAluI4dIzGvuJuCmrb0sWZGiBV829T2Votdgi8WMgqTVIJz8PPH
         3M7MjabFw5Jvti4G1mcFDZRUKf5vP64fgrGJflnui1H8gC9x4vsTRbVYrmtqFYm0mIoX
         ih2w==
X-Forwarded-Encrypted: i=1; AJvYcCV3yLwwbuTY9HI5wpRrEoeMrK3NwjB93PVnI9Dzw3bPDda3A9uVcBEIoMd1W18LpNY0zRO/csEarwn6Htw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AI15VwauC4oigCxzRXFiEr6F+vppGaTBqOyM2kP5ouiyING1
	Ii9rhWUIIUqrHZ8N7Rp9n9SKQHtc78WDhJ/SQGSf8aKATHTPLwrVSs1jYnMk8HM=
X-Gm-Gg: ASbGncuTe2yVpGcTRhgZ9BsU2b8lZ6+HgN1PHRUXbIMEefTrXyTb8ZhNMAQRdpZR53I
	HpqxhxcFun1NmgKWENHnpCiwGAirk0ISt8hRTd8r2eClddesDuokiAlP2JLOmEOufePqPficeuA
	r6stdhpGcmJbOr7FZdau4BaaL+DucZ8TZsXgFbI11n8aA2hRicgpYJcPI6uX1nkD5a6xX3C6/Cy
	ezj9EcWiPfgbkvlqjJ5TrF13myUSmyj25CnDGcGq9psqI3jUUU630h3PQSZPx2U4oPqKtJyJ2k+
	ESi++CuwkngS0EVaY/nI5JNuDk39UL4An71SGlJM/hUYFgTroyacjQBnAvI=
X-Google-Smtp-Source: AGHT+IF0dYo0boBR+9bl0vawDxMBgd8T0cqY/hF/tRnsNt/62E4WUY/Xos2ArXYf2sRSNXond0EV3Q==
X-Received: by 2002:a05:6a21:69b:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-1f5c2952640mr6319263637.13.1742029984462;
        Sat, 15 Mar 2025 02:13:04 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7371155aa8bsm4082744b3a.70.2025.03.15.02.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 02:13:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 15 Mar 2025 18:12:14 +0900
Subject: [PATCH v5 5/5] KVM: arm64: PMU: Reload when resetting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-pmc-v5-5-ecee87dab216@daynix.com>
References: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
In-Reply-To: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
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
index 8e10124a7420..aae5713d8993 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -254,20 +254,6 @@ void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
 		pmu->pmc[i].idx = i;
 }
 
-/**
- * kvm_pmu_vcpu_reset - reset pmu state for cpu
- * @vcpu: The vcpu pointer
- *
- */
-void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
-{
-	unsigned long mask = kvm_pmu_implemented_counter_mask(vcpu);
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
index 803e11b0dc8f..f82fcc614e13 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -196,9 +196,6 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.reset_state.reset = false;
 	spin_unlock(&vcpu->arch.mp_state_lock);
 
-	/* Reset PMU outside of the non-preemptible section */
-	kvm_pmu_vcpu_reset(vcpu);
-
 	preempt_disable();
 	loaded = (vcpu->cpu != -1);
 	if (loaded)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 727579acc7f6..14f66c7a4545 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4480,6 +4480,9 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	}
 
 	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
+
+	if (kvm_vcpu_has_pmu(vcpu))
+		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 }
 
 /**
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index b6d0a682505d..d6ad13925978 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -53,7 +53,6 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
 void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
-void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
 void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
@@ -126,7 +125,6 @@ static inline u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 	return 0;
 }
 static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}

-- 
2.48.1


