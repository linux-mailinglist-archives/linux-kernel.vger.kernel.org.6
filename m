Return-Path: <linux-kernel+bounces-418520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E19D6280
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ABE5B23F92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BDC13AA4E;
	Fri, 22 Nov 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZWlh0sN"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C02D638
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294036; cv=none; b=fohyLh/+m9rOpWcW8cqErs0kh7Dng86IK8sw51GXQV0kA3iRDQ6RkMdonk4K6dYk626BZ9mrFG0womPF7iadsSPB8+44GI1dKUZYJec0npRB4eDVzSkqbgjcAvNY4t2IzHEcvvtcQNFHJZy8cn0pewnLFtRra7arVs8KB8R9S4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294036; c=relaxed/simple;
	bh=u/avhju8ZiLbU2V29l1YNg6nH1/y9XIL6wCj4z25zsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cNB6uGWhxnE1nZZmwY33s1n8rVoENmDC3QNunB5oawi4+i98edBeaYxA5E8ufdrUU9DvJBZgWn0889Yd7bwhfzMPc3PZw/VmnfKJ8K0OYbW7EWLz+8Df3gkOpLuHfkVppemAdIsiWPyL56No7kOYXhR8NoSkZ6giVZXEzuUbdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZWlh0sN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3825a721ae5so1250178f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732294032; x=1732898832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJeINAZHCBu2Qf4xyRN0jajeOXOn86gSYL/Mvl+4mzU=;
        b=JZWlh0sNMeSwCXHuzp/W4K/MVfK7aS6Hq4aJjQHQQf5YTz07ikHdgjJarlJGBtTGob
         8feAcNlQ27kBqCHCUWcXkjDeigqd4xGcO1odycldbw6UmwwJUOnkenC2QWR+sDrmmszN
         HdyJJb3/FsaAYI4+eCA5KCps1ThSWjdkarlPkb76yjBetO7u1vNXZ7JU//L8OoBWqIPg
         welzSnhUmrWNz66dCNJbN1z/O4aqAmgG4/jEI+BZUxwHHaoTo+8NmIYVvUYf55GHTqNa
         VbHeu0VlMjaQfK6bJMvQuU49wPCJULjWyo0Lbf5Vza2sHNldpvflcOXKcKXunV6xtjX4
         Rgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732294032; x=1732898832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJeINAZHCBu2Qf4xyRN0jajeOXOn86gSYL/Mvl+4mzU=;
        b=XMgIkQkjJ6lFAzCxpvDvsZ1N/o/doyZ8/xM0Cqj8OgyHdkOhTMWTFi16N199iQVZ/F
         ES0rc2um43ja/RV7gXsChq4eV1ApA8pgAWdJ6qDs1KqbhlbOMcsZB0CeX5/KSDR7raJZ
         1K8ISZrVpb3a9NVxXs3B8jJJw8/ZHCk3/2EJUsvVU37cQX2D3yn1SF/+pNNPgPPuIcE8
         jFmXZjesymS9oHeFeMRllVhGKiO+3zqqE9aw+VOCeR92xiyAtdpDOiL3a0piqmu880ez
         A3kIcLYEgncdyebck/IP7+y2B8J6AVErhhz9B2OXyr3MAHKa02pnf99tCgPrjbsRPaI9
         Hb1g==
X-Forwarded-Encrypted: i=1; AJvYcCWepIvpAWk7OQT6kVYvChPKI8U8XsWyE6qc684oSDlp7mFfrOWNd7sCTsh1ga3lMeXS6oxAQ3cY5f6NotQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxFSjdR1zLNHU+QXjPNC+ZVLxMofAZngtzAMoJdIezZ+GlutW
	NwWTPqYJ0v1AiIYSVWI+uNuQ7Lv3nrWE1HKxt7AGtfED0G1VKi3PS/BLCf9Iu+8=
X-Gm-Gg: ASbGncsmJXM4v7u0xfZKS6uQ/7Nm2OCKdi5mK+c5o0DBYwUPRO0yZMHaXLBPD6EvqPF
	pzrN6EIpzeOpjz6p8tVFKOkNF1wcbJkaWjshIQ8rgXF4hYOdhTtu96YqC44VvXohMTILxuy3JbE
	O0mKraGp6OxNAUKGBX9BPT9bsdbSHmW23G7n/jFCZIgASfNqOoqn4e9GuB3kmUVOuM/X2giY+j+
	fywj/xgfuPUOP6gnA6U++Gv6iIcOXyQL5h0YJUg4qyIpURb9oc=
X-Google-Smtp-Source: AGHT+IHcQ74w3L8E5gBsmMqb9rkz/2NNvWSY9aaHifqJFdgHc67xg00mFf+1ZhdtlpPb45JX0tyD6g==
X-Received: by 2002:a05:6000:1acc:b0:382:42d7:eec4 with SMTP id ffacd0b85a97d-382601132ccmr2984325f8f.4.1732294032116;
        Fri, 22 Nov 2024 08:47:12 -0800 (PST)
Received: from pop-os.. ([209.198.129.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe91a6sm2897458f8f.86.2024.11.22.08.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 08:47:11 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: will@kernel.org,
	maz@kernel.org,
	kvmarm@lists.linux.dev,
	oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: James Clark <james.clark@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Fuad Tabba <tabba@google.com>,
	James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Fix usage of new shifted MDCR_EL2 values
Date: Fri, 22 Nov 2024 16:46:35 +0000
Message-Id: <20241122164636.2944180-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes commit, these masks are already shifted so remove
the shifts. One issue that this fixes is SPE and TRBE not being
available anymore:

 arm_spe_pmu arm,spe-v1: profiling buffer owned by higher exception level

Fixes: 641630313e9c ("arm64: sysreg: Migrate MDCR_EL2 definition to table")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/el2_setup.h | 4 ++--
 arch/arm64/kernel/hyp-stub.S       | 4 ++--
 arch/arm64/kvm/hyp/nvhe/pkvm.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 4cd41464be3f..f134907d3c08 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -79,7 +79,7 @@
 		      1 << PMSCR_EL2_PA_SHIFT)
 	msr_s	SYS_PMSCR_EL2, x0		// addresses and physical counter
 .Lskip_spe_el2_\@:
-	mov	x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
+	mov	x0, #MDCR_EL2_E2PB_MASK
 	orr	x2, x2, x0			// If we don't have VHE, then
 						// use EL1&0 translation.
 
@@ -92,7 +92,7 @@
 	and	x0, x0, TRBIDR_EL1_P
 	cbnz	x0, .Lskip_trace_\@		// If TRBE is available at EL2
 
-	mov	x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
+	mov	x0, #MDCR_EL2_E2TB_MASK
 	orr	x2, x2, x0			// allow the EL1&0 translation
 						// to own it.
 
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 65f76064c86b..ae990da1eae5 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -114,8 +114,8 @@ SYM_CODE_START_LOCAL(__finalise_el2)
 
 	// Use EL2 translations for SPE & TRBE and disable access from EL1
 	mrs	x0, mdcr_el2
-	bic	x0, x0, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
-	bic	x0, x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
+	bic	x0, x0, #MDCR_EL2_E2PB_MASK
+	bic	x0, x0, #MDCR_EL2_E2TB_MASK
 	msr	mdcr_el2, x0
 
 	// Transfer the MM state from EL1 to EL2
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 01616c39a810..071993c16de8 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -126,7 +126,7 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 	/* Trap SPE */
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMSVer), feature_ids)) {
 		mdcr_set |= MDCR_EL2_TPMS;
-		mdcr_clear |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
+		mdcr_clear |= MDCR_EL2_E2PB_MASK;
 	}
 
 	/* Trap Trace Filter */
@@ -143,7 +143,7 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 
 	/* Trap External Trace */
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_ExtTrcBuff), feature_ids))
-		mdcr_clear |= MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT;
+		mdcr_clear |= MDCR_EL2_E2TB_MASK;
 
 	vcpu->arch.mdcr_el2 |= mdcr_set;
 	vcpu->arch.mdcr_el2 &= ~mdcr_clear;
-- 
2.34.1


