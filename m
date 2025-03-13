Return-Path: <linux-kernel+bounces-558841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE7A5EBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CEE1897DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4397E792;
	Thu, 13 Mar 2025 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="2G3zVrgq"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFE1FC7C8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849096; cv=none; b=G70Sncc+obGyGn2EpNPO4WZ7gSkAcZXyNuPh0lIW2c0gohKVI9+b7UlbX7Q/mOiJwQ98wp/A/64FgPRFcwGNLEqFu8cqdQCeUU/UxCILkzw7oXidamtFg5uIQspOfBTliFrP7OZe1zTpFF5qQkptgJxHdhOI6YdbbmPj5JoTCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849096; c=relaxed/simple;
	bh=F3X6D6K8/IleFxaVTYcfc5YrfdKG3utxmjKEiJ5rrmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqsPjEeKv/yux71O0v28FD0qR2I32GEEEVk9vXVnJBtV1CS/WDfdAz+MAUQ3BPrVd9OYJwbZsm8RXLiD9ISKPXt0Ml9pl2TmQruCGtV+m0/xafxSQcoEUur7NfRcKeJWPyjsvWJgfnsBM7Pn7I3SWsE4wm4L4gvtkYN+2ImHUyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=2G3zVrgq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2241053582dso15436605ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849094; x=1742453894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ov1QC08xmBeOUCrm+sZTVT7zWaIK1Z9CIL8k0jXnjDA=;
        b=2G3zVrgqqJda4DwEu5al4kFEA+scGHPfYiLWgRXflNZFLCvqavyMwzdvk2f9CvwP6J
         pFPvWbg+bZ3b8mJ+uKoOAmTpp2piwCQyyeX9ZcvlcnVtXke5+pn/ceNTgyFS1WS/VMBm
         hxTXjOgiGz+Ks8aZuKfQuesUsz+2EcbckYWKhydx0dIZ8UnZHbjxR9ESYqoKj4RbcqP1
         22IsvZb2qHdGMRRhAZ6BosMYdUmd+BUQ2E51JEY4XBm3xn+RxAWAq+DylFoo+uUEHAWY
         KWIXD6eAR6K1trJ7Qxvp9qbrHCSOem4Dz+N/ogyxQG0m4WmJV3BxH8oGx//1LMHn7e/V
         Ba7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849094; x=1742453894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov1QC08xmBeOUCrm+sZTVT7zWaIK1Z9CIL8k0jXnjDA=;
        b=f0PI5JjQ0XlhVqDlW8VEmh+TapI0Olld27qnko9I0z1JDKyfJf/m9sSdeADwptExcE
         H3F/6MJymD484qNlWQVlFGEbvGOvJVrnIIcYspt39kgsc1dYY1AdUTrQo0rAedEiNauN
         /IA4XdJn+SbZFw3jkJE0AcJKUFMgk8TRjcl+v5B16fe2q1XaPEbH7qpCjSJEkFLbht85
         auhCLq+49crSm6fhvQEN6I5m+ad+ri250jWUaLYo7j3x6zOhjv2FbiSb1de2jV8pvYt0
         +e59U/6xtl9fT5fqV3C61KESHMHWiT9+d5RdmB3N69R5O82P1azuuAu2DFqJ12WDdKCD
         32UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7qtrZ2Dl+c3c347kQQEfCti8+RnGUMcJFFpNzA05aprvv7DUwmhXpGL7PgExVXgrWZGbHJ70zdmImTi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxrr5Myu2bdd55bAWN0QCGEI3km9zWuBIZcmMgxUmhD9rjkPV
	Eqy3Q6GT+ID4ZfXNbFbNNdKFVEUnvR7KWCLH0ywUvXmuzpMFvhFWZ2eNDIkkfc8=
X-Gm-Gg: ASbGncuC94jmQKgLggR7/8MDakwbmL45NDaBt87i2uvVO5l5XGUnnDjkrQVgXTKGcxv
	enK7dDz0Y68ObppAxU09lMDy5D5VP4dOmV63m2tfJH0sR5qHymctaYDEFMmROvB93vS1DqtFqRC
	LiOo4K9qEudcE3VK7s6ffWL8Jyo8PUZ97a7a2nqAjz9NMYsbpr8ydmhjtjn0zbqY4aZoEcxElte
	IH8hid4V7MuP4hhK9LX/iEEebe21TQO5Ew4Hxy1IGgf6j4PAiGfIohdI7Y9c6E7XuVSVayd+SJY
	rQiUvbXTij0edZSv6ei86+HhBDK6Q6jpXJYsMX+ozyXP10bE
X-Google-Smtp-Source: AGHT+IFPWy7B2BUY2WAUGm0CDCmAcyU/PA9aOMoalJWaDBeBLNlBGUj9py5eigGDQ0JyyV1QjpJmAw==
X-Received: by 2002:aa7:88c6:0:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-736aaadf9c1mr39387147b3a.24.1741849094416;
        Wed, 12 Mar 2025 23:58:14 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7371167df97sm627290b3a.114.2025.03.12.23.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:58:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:57:45 +0900
Subject: [PATCH v4 4/7] KVM: arm64: PMU: Reload when user modifies
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pmc-v4-4-2c976827118c@daynix.com>
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

Commit d0c94c49792c ("KVM: arm64: Restore PMU configuration on first
run") added the code to reload the PMU configuration on first run.

It is also important to keep the correct state even if system registers
are modified after first run, specifically when debugging Windows on
QEMU with GDB; QEMU tries to write back all visible registers when
resuming the VM execution with GDB, corrupting the PMU state. Windows
always uses the PMU so this can cause adverse effects on that particular
OS.

The usual register writes and reset are already handled independently,
but register writes from userspace are not covered.
Trigger the code to reload the PMU configuration for them instead so
that PMU configuration changes made by users will be applied also after
the first run.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 3 ---
 arch/arm64/kvm/sys_regs.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 1b91e5188d52..3ed8b74d9925 100644
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
index 26182cae4ac7..11718c635e2f 100644
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
 

-- 
2.48.1


