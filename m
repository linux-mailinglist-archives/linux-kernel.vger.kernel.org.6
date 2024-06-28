Return-Path: <linux-kernel+bounces-233696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2626391BBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396001C20DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99171155C94;
	Fri, 28 Jun 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KIxFtS2J"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE415575D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567493; cv=none; b=u/ZEQ0uFg3sglAg8LKAqHzFogDsrjC/yEFlNGn6bIAdLMK37d+/F4OTt0ZfwZUeR6hf9MB+Ce0pnRag8YoYTnCppqCthFTdPpjxzjqxwCGecVRziVSwpg8SBLbxuhAuBm0KSqmAXDLIm1XUOugEyV8UDQyu133VM2cqW3BgqvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567493; c=relaxed/simple;
	bh=pqlexpUvH8SdD7gCfl41+7ECvKrO2BeW1xpubtVDq1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Nmg7TWqdvZNkU30F2D7x/OaNN+9a5kW2n7wEYA6P3/2jXaj5f0prFiZrCaZJqcg1+6gdEmSlAgyplyLfQt5AWz5mmrDLGpWLuLFhyrHRlaNICYhUypnV+VsPsJFvOMUo6vigtD9zB3vgdMrPPJQYPqdXI8qfR7bnUTlb+2wIyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KIxFtS2J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f64ecb1766so2251145ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719567491; x=1720172291; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qOZOdNqYBv8WGomeUEUfCET+0Nz9/2nmPAIIjSAFF/o=;
        b=KIxFtS2J6R9etRL8J7mSKBJUKptCY1jGOdKS0zTAUWZ0FMm+9Zh7y6ChsCB9J+eSj2
         PZLeIazmLJ1oZLSDR+vK4y9LLw92kQYoQIgKZthqzOjqoKYL30MCrhgR2VnABh0Ii2w9
         CMg8ZH6Q9hBUsNl05eeLzMREqhOojsLiZVb4Xd1zF9BmL177N3T+XCij9aD/4C6aNWaD
         +NadVOaepBMeKScGFxzdPP5Z70bcMVIoGI0R7KPqrw8f/AS5YdCDg9mZ88WGUuTXI1PC
         A1f9R11w9qXN4dJvlNWgWDR/aUJX0GJxDPZC97RZEkrD4dUX5lwOlCwRo3W11XaX+qi1
         g08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567491; x=1720172291;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOZOdNqYBv8WGomeUEUfCET+0Nz9/2nmPAIIjSAFF/o=;
        b=JkDxRJIGQW+kGuVE3xlWsodb+U6er9GKdHG++71VUyWnd41JC6hmGDhflGzNnc40Fj
         dKSm3BGcRX6/9ryV3XqIytCruCio4dz7/Sm6C+ayqJzp7KFkqLT+QAEZrqaTi6Vd1Nrv
         4nfDZ+C0aB0QDPoYnWjY9evk+tYzf2viFAlorQkK2FyJsjTipBNhUdBjjmr+YYrXelOA
         tRojWADcbUPEORrz7+ejnT6QX8pVyGE9luY2BUCYDzJPFfoQ2JtZtICh0+Y78tloJsLw
         pcVKWM02OL8KJPHex5xArWDk4qgENCGdE1R3FOIXcA4bzmC/gBQgbehWPg7kCvfRiQri
         uyAA==
X-Gm-Message-State: AOJu0YyecmfjXQEshRIIaoPbDVn+JIrZa+WKLB7ZLYw/tP9VZw9zONgU
	ahehf/hce01wtePodso3oi9NKTppKm4BCOnZtmOjKDSzUNNODcyn6GFQyPkA6TNvK5GwkK8qf3/
	as4VtdivyVixuHxWLBCbJnGqyO2824Q+ejx76vEmAND021bkr51o2BlfzA6hlNUjLaGMuFyeXNQ
	fFkyqmIqRlaPRI7jtPcO/EvrKZulfW9FXI3fXVjhBWJIdLrpoqVsM=
X-Google-Smtp-Source: AGHT+IHJemzKEqsK4QPwmDux/9zJJPho19aSvba61TOUwNSisECiHK7vsJX8ZHqMBWD3kWK4cZyMOw==
X-Received: by 2002:a17:903:18d:b0:1fa:2001:d8ff with SMTP id d9443c01a7336-1fa2001dad7mr178136225ad.52.1719567491232;
        Fri, 28 Jun 2024 02:38:11 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c8dsm11087155ad.26.2024.06.28.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:38:10 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v6 3/4] RISC-V: KVM: Add Svade and Svadu Extensions Support for Guest/VM
Date: Fri, 28 Jun 2024 17:37:07 +0800
Message-Id: <20240628093711.11716-4-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628093711.11716-1-yongxuan.wang@sifive.com>
References: <20240628093711.11716-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We extend the KVM ISA extension ONE_REG interface to allow VMM tools to
detect and enable Svade and Svadu extensions for Guest/VM. Since the
henvcfg.ADUE is read-only zero if the menvcfg.ADUE is zero, the Svadu
extension is available for Guest/VM and the Svade extension is allowed
to disabledonly when arch_has_hw_pte_young() is true.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h |  2 ++
 arch/riscv/kvm/vcpu.c             |  3 +++
 arch/riscv/kvm/vcpu_onereg.c      | 15 +++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e878e7cc3978..a5e0c35d7e9a 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -168,6 +168,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_SSCOFPMF,
+	KVM_RISCV_ISA_EXT_SVADE,
+	KVM_RISCV_ISA_EXT_SVADU,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 17e21df36cc1..64a15af459e0 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -540,6 +540,9 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
 	if (riscv_isa_extension_available(isa, ZICBOZ))
 		cfg->henvcfg |= ENVCFG_CBZE;
 
+	if (riscv_isa_extension_available(isa, SVADU))
+		cfg->henvcfg |= ENVCFG_ADUE;
+
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
 		cfg->hstateen0 |= SMSTATEEN0_HSENVCFG;
 		if (riscv_isa_extension_available(isa, SSAIA))
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 62874fbca29f..474fdeafe9fe 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -15,6 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/kvm_vcpu_vector.h>
+#include <asm/pgtable.h>
 #include <asm/vector.h>
 
 #define KVM_RISCV_BASE_ISA_MASK		GENMASK(25, 0)
@@ -38,6 +39,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SSAIA),
 	KVM_ISA_EXT_ARR(SSCOFPMF),
 	KVM_ISA_EXT_ARR(SSTC),
+	KVM_ISA_EXT_ARR(SVADE),
+	KVM_ISA_EXT_ARR(SVADU),
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
 	KVM_ISA_EXT_ARR(SVPBMT),
@@ -105,6 +108,12 @@ static bool kvm_riscv_vcpu_isa_enable_allowed(unsigned long ext)
 		return __riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSAIA);
 	case KVM_RISCV_ISA_EXT_V:
 		return riscv_v_vstate_ctrl_user_allowed();
+	case KVM_RISCV_ISA_EXT_SVADU:
+		/*
+		 * The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero.
+		 * Guest OS can use Svadu only when host os enable Svadu.
+		 */
+		return arch_has_hw_pte_young();
 	default:
 		break;
 	}
@@ -167,6 +176,12 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	/* Extensions which can be disabled using Smstateen */
 	case KVM_RISCV_ISA_EXT_SSAIA:
 		return riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN);
+	case KVM_RISCV_ISA_EXT_SVADE:
+		/*
+		 * The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero.
+		 * Svade is not allowed to disable when the platform use Svade.
+		 */
+		return arch_has_hw_pte_young();
 	default:
 		break;
 	}
-- 
2.17.1


