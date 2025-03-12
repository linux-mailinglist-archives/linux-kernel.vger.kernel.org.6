Return-Path: <linux-kernel+bounces-557657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6177A5DC14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EDF17A2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3D24397A;
	Wed, 12 Mar 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="dx/65MS1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293B243376
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780590; cv=none; b=gXwT3nd/rqINCKL5ZHsGRf5CBFCnKTKXJ/Ab4/X/ewzkLMaNsz6ze25XFVnOmCVLwtROMALdQ5XdPBHJCcb5oXOHrHW89PR5GlD+5fXHmKrWzZDcN3U6+2ue3ALyinnoXrRDcwMbVWMkm0gR2K0eX4+dVbFzMwQe6wvg+d/0nGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780590; c=relaxed/simple;
	bh=4v1s/durCkfELOZpL2W2ey0P23M5dti6CGsoLaBi280=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqQlwJSjQ3ipCU66Ijk4B/4WCAycX3+a80pPQXP+qZUJjIB/k1M24/bFX6oy525My557+qIrAqEbho1GxcJOE+cl2YaCig7tKoUZGjLPEvU1y4jNbeNXQKOOSUzHKpIbog7RDKwGPn5GwjIbciXUagG4AjVh/fpywVEYFW974Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=dx/65MS1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de12bso35933215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741780588; x=1742385388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=batJW7N99udsH5or2fGgRKZ12NqGfXHTrvw8DYDS8OY=;
        b=dx/65MS1Ffjus05hWhBIKH4qVPJdYGygxxgbHUHZHStOt1li5mSeuxsy7sGk6ErF4O
         8z6VnyDKcOZ3qZhE3oxCouI9M/Z6raZ2clFLd1OHZJ3+aEz/seWh5g9WFK51WbaCoLNf
         wKsW2tMCHYJ4AnQEMptbwHmHEq9+yexf8veHibo6JWRGDS1OBABnp3rEaC48r8+AOyYF
         wfFVNCFkn2lWYYI3WaeHoISzAfbADXx+KSavj6rC4ael56T8u16pm9zeUlZEe0u5PKhe
         thC+HPyrVyzF5makbgTWBSj3Nl0bEKBCS+77CjZLm6n1O3hgtKRKQ/fa2lkqxtyAMEZ7
         i/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780588; x=1742385388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=batJW7N99udsH5or2fGgRKZ12NqGfXHTrvw8DYDS8OY=;
        b=a4S0xVb2dbgMV3bE3VauFIELClGtZA0z+DcmcykjxybC2RQVNcDdX9HM3o2mCOhpjY
         HXJxNvwBVFW39I4Z6GdH4zkOVQMGdadJA10IZilEm8s4UbQgOvsdzD1Lk2eF1xGJCg/E
         jZmEDbBrfQG8IBOb3Tv91UqitM+jA3Rv4WBbF11MuNNyx6Wiq8Aeo5O8eYfmwh0hbdeL
         gdS/IuMG5+yxUk3YIrLrWtsaXFQRlUg7HW6DiQMum5AZmag2yOsrDQY6N434Qly27OxD
         EwdeFujJzlyg4Dq4+LC6Qy6NyxcC706Mz/9T84wKeUXAixW5tcQUKCIdLRYsJlrtR1j8
         yXog==
X-Forwarded-Encrypted: i=1; AJvYcCXlKrWDrArzB+8+zozONUT6GbK66chTTfBBLyMqwx1RQn92jvYCxtakIqfEzCz2/9ovo6yOEFm68GFmQZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzczgSBsXYZkND5tC+fyJ70wlBDC61fWgAFvg9VqiTBlYJ6oJdN
	fdsHzAS5guFu/qMeszva2vsdaiY5u97CmcIo/ILiu1Ss22rW23gW3/ijnyYK1zE=
X-Gm-Gg: ASbGncs6XGUl+su/5OA+SNHxYYZYurpdfvYdk8jCLldnOzG++PAUGwknuXEhto2Dgin
	7wiBy2LugPDcq5qW5E9vQUf7c4UnTepsRysmzI1aL1XKfYzkgvdaHZ7C2VzuXpGP0HfHE5KJu1R
	AiKPkYzF9NNU5/oIMWNc+UOlfZ6N8V6NM4z8e9LVZcvEmFdDBw6Kg06fWk9y9wxUkBa24w7UqR5
	l2yPGtjcJPL95phIQteE5aADNOui7u1LK3J7w6KJlvjRyEcnygfbwvL5zztgU3oQQJO5HBtUoE4
	Rg774oVIrop2FEfaEZ5uLf/jt9l1KO00TGSuN+JYYQbyvc3m
X-Google-Smtp-Source: AGHT+IFrXL/c2aUmiggWa0jbXOlzV9E33S5G3t7pznZh6+1oFT+Cw3t/yJk10DJ41f3H26UTFexAtg==
X-Received: by 2002:a17:903:40cb:b0:21f:85ee:f2df with SMTP id d9443c01a7336-2242888adfemr319563085ad.15.1741780588669;
        Wed, 12 Mar 2025 04:56:28 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410aa457csm114113705ad.212.2025.03.12.04.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:56:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 12 Mar 2025 20:55:58 +0900
Subject: [PATCH v3 4/6] KVM: arm64: PMU: Reload when user modifies
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pmc-v3-4-0411cab5dc3d@daynix.com>
References: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
In-Reply-To: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Commit d0c94c49792c ("KVM: arm64: Restore PMU configuration on first
run") added the code to reload the PMU configuration on first run.

It is also important to keep the correct state even if system registers
are modified after first run, specifically when debugging Windows on
QEMU with GDB; QEMU tries to write back all visible registers when
resuming the VM execution with GDB, corrupting the PMU state. Windows
always uses the PMU so this can cause adverse effects on that particular
OS.

The usual register writes are already handled independently, but
register writes from userspace and ones for reset are not covered.
Trigger the code to reload the PMU configuration in these code paths
instead so that PMU configuration changes made by users will be applied
also after the first run.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 3 ---
 arch/arm64/kvm/sys_regs.c | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 1cfe53b6353e..78cfa8b0964d 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -862,9 +862,6 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 		   return -EINVAL;
 	}
 
-	/* One-off reload of the PMU on first run */
-	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
-
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 26182cae4ac7..307ce37d0434 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1143,6 +1143,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
 {
 	__vcpu_sys_reg(vcpu, r->reg) = val & kvm_pmu_valid_counter_mask(vcpu);
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 	return 0;
 }
 
@@ -1303,6 +1304,8 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 		val |= ARMV8_PMU_PMCR_LC;
 
 	__vcpu_sys_reg(vcpu, r->reg) = val;
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
 	return 0;
 }
 
@@ -4259,6 +4262,9 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 	}
 
 	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
+
+	if (kvm_vcpu_has_pmu(vcpu))
+		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 }
 
 /**

-- 
2.48.1


