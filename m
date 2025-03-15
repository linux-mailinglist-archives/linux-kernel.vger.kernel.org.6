Return-Path: <linux-kernel+bounces-562497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668BA629AE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5CF174538
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217361F4CB6;
	Sat, 15 Mar 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ge13XMhN"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085901F76A8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029982; cv=none; b=PBvvaS5rghCUV1Ifu0iM/2I8469MS/hZCvH1cyuD5BM8dCdagtpv4PgyjjerzuHm7WifhUaIhQIf+JkHnv/U1qkq55+qV5K3/6CHVfbR7RyrCxkwDqXTSGWdgrj9ShL67H0Toe3+nvpnjBcRIiBDtDAP49aFhvruOJInj31xs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029982; c=relaxed/simple;
	bh=UIs9U4gwmL5870YLJcYNAyG53WiYxibycuWPw35RO2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/QfOMxqHnor6xyE6MiWnEMCuk2H5CLfztbqbF19oS6Nqjie1K9C10N14GHVvEtGKrkau6oZZlZCMxXdBUtWQtNm/ZchMVG9KUWrSYAASTmYtz2C9qi3vZdOCtbYNIS9QsSlNWYq+DV7r3HLOwqgLAs10zNIpzIWifJ/S030h5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ge13XMhN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so1157976a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742029980; x=1742634780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FbB5lDaUNvpC7XuDXTEGvGqSXp+ZEz8J1AwcsET8uY=;
        b=ge13XMhNQoOiq2Z7rlFyMUPb3SZbgnIkK5FzDvCdBmX+tJ79Cuv0P9/KJo3i3eBjPV
         jHWXO92YExV6iq8PIOF/C01b7ByLP5WKKAwDiJ0jWbox+sBDNVKHsjQQg1irrcaARX3t
         iDckjVqZktiQx9lMTjCnbv8bIHcaK096oPkEFZzo/Vq5w6MSU8BmB9iGYQaqnPxz5Vjn
         GDfCJfYIbw5Z5j+d3eEUUItkuUeaBk2dLdTwqmdU4Tfb67+9DqQkHPkedG72RuhD13tL
         zzjGKSK/Oy5yCq9Yt1HUn9+FLfRt2lrdE6cGMKokw0FltxgV9tuhJQ1Fo9JXszKG4u0k
         6meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029980; x=1742634780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FbB5lDaUNvpC7XuDXTEGvGqSXp+ZEz8J1AwcsET8uY=;
        b=wdOzsNuyGRhgdg1XZjsVeqfyN9Oy9Ah/NOyEw6wECbDNDZ1ucdFCa/UpMzBIFPyODO
         aylluuRCc/t7UcbQ+UjMQZZdBanCbFLnKMnbLhbcuSLQgObTWvcibMjW2JbdZ1wb0JgR
         /G+/mAWwNY/DalFCrkvKnW/foZ8zvfQyIEmJp7LFiywXCzmQIizxe4ZyqB7K+pT/y15I
         bOJA7dYUP2cngmC04LFQ+kJ193tHHU2vYdF3zNuKYjkn2LWeZUVwt6cuKJYrQC1InTD5
         PaJGaPQmADTV/31Z2HvnUmJJyvONfpLw2DPgu/U7+jjhk+5EEjd/8D96nLrS0LPz53eZ
         /VNw==
X-Forwarded-Encrypted: i=1; AJvYcCWo41Fu0Rj9YwauQgu3BLrR6DLjuJwNXbk/EhAFOOPOX/xVQy2hz46+a13Dh0CEL+6afObr4J8Q8mYDUcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFumAl+58iL6Q6RrNsU7fK0TYTFvtRb0nx7OuQ6PurSFA2wGXQ
	oFRAodDG1hRWsaCe8jLGCxs3b2h+EOGdMU02ap4tw/cajXG8ToEZ8+Ti597lU/6od1tp+Fddje1
	XCvY=
X-Gm-Gg: ASbGncu6xmsqmAu9TQuKp9ceEyp6NhwvRPh9+5K4IWCL3OiTTWVG57WnB5HHxIMMk20
	PktxcuYuTYa04yXOR/Pqg7IDw3X088V+7/WKGDjOzbMY59hSu44I2jCocLH1prWtqe0RMknDLoL
	4e9ChSR7t9n3JUZo2xUmyU3sxsvMEWnFRQ0OVRPoUu17KXyu7Kn7Zzum1lKKkzqKhXMhkoN/nYx
	94pX2sraUUqEdOqSvcIELF6oWr8aqbGMhk5/qLdDuGBpMjRj6hrsFIn1aH8uQ4H0fKKN6wZLegp
	JlkqJrExqHd6Co3IzrdbXjtavCIm6A+cdXxRPFZ2n52cWgsroiFFa8i3SKU=
X-Google-Smtp-Source: AGHT+IHaYE3C8lcppzvNgVq++/gQW7jqz6vA6hT6Z68AyNtCpi+E5uRU4W2Fjw9r55KOhScD/9aGrg==
X-Received: by 2002:a17:90b:4b83:b0:2ff:6f88:b04a with SMTP id 98e67ed59e1d1-30151ca6de6mr7547868a91.15.1742029980303;
        Sat, 15 Mar 2025 02:13:00 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3015364ec2bsm2630846a91.46.2025.03.15.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 02:12:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 15 Mar 2025 18:12:13 +0900
Subject: [PATCH v5 4/5] KVM: arm64: PMU: Reload when user modifies
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-pmc-v5-4-ecee87dab216@daynix.com>
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
 arch/arm64/kvm/sys_regs.c | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 593216bc14f0..8e10124a7420 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -917,9 +917,6 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 		   return -EINVAL;
 	}
 
-	/* One-off reload of the PMU on first run */
-	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
-
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4d1ef47d0049..727579acc7f6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1070,6 +1070,8 @@ static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 va
 	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
 
 	__vcpu_sys_reg(vcpu, r->reg) = val & mask;
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
 	return 0;
 }
 
@@ -1228,6 +1230,8 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 		val |= ARMV8_PMU_PMCR_LC;
 
 	__vcpu_sys_reg(vcpu, r->reg) = val;
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+
 	return 0;
 }
 

-- 
2.48.1


