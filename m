Return-Path: <linux-kernel+bounces-263019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD693CFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDDDB22A43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84079178CE8;
	Fri, 26 Jul 2024 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IlSpURJy"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CF17839F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983796; cv=none; b=RIHJA0dPZXh3OGdX5yQfvGzTxiT5E1a8JhLUK4+KhtHJsUDO2Bz2o9dy4Bvakw7JH/oNV5rq4wFrAPUkB3q1CEkXIz3kJdBq4N2qKxIwfbOm70q0NbkGxv/FO2DDgq/ujmJ6XWp8w6Itg9V/JtjnfoZJRh2o4M754jb7KwYlO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983796; c=relaxed/simple;
	bh=DIBSkAyKBd3D8uYoYD7uVG9VrUtkXQY9MnQFWDRTPX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eNmufCwJsxhgxMr+1IPUt7edmY11M21RB7ykBMgcNp6HX8PuhFGPFbLtOZfH5xfCq/28rLC3pNt0emhjBKksY8KwKU9iYXlsO/iQmdrN0GdU0K8eaXlw7GuFHw0xJzC8J6SUCxxiPtGNGm15rY98G2nnfPwiNK5bAZbYAaLH8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IlSpURJy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so528377a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721983794; x=1722588594; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=34BL/sh0DZ6mInNrtxWV/KGc2m1HMCFv7aaLw74E+qY=;
        b=IlSpURJyAtcHFgWLVIfGCB8ky6Zm27p+rHywQi4d3D2HyRNab5Hutyuqs4dTPhvFp2
         oyOiQ20qeyUolVdf9pfnJMdfIPptoTZ1/B8+K5JmDKOSGGAmV3FeZyQjgxk1yTbervcM
         cTecCpq0RMoq54BK9J9GezPjpsug2gekqwSJoyjQWr1W0STI5Vumv8jQis/+hzt53Kty
         tt/iwgVsTL3St0BACmLTFzKy4Rx6QAnLLhT39smIY6btD8Lh2w6SVDRwLOLrAAj0awcF
         RF1B2e2kCRxuao/QH0TLCk4+ZwoZI3T15/FPROPm44pJohf4mXq9MtkoCPUNuG9IgpPP
         vaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721983794; x=1722588594;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34BL/sh0DZ6mInNrtxWV/KGc2m1HMCFv7aaLw74E+qY=;
        b=aDATSbCX+d1vn9Li4XrS2x/mDD7nwaS8PfmZQfl/BL9wryNqhMYyab3EwYCjjGDYtD
         GkZlfPONrjFnGOulFwjJleh7RCOEH3ZZ/yArWuJIlSkNt+vbK4Lz2CeWnyEvZVWZeLaN
         viuCICQ7ti1yQTP+tGxeD059otC1bUjq38X0/mQkqQayrq/cIFsMtKsxlV6sS6Xoh1MT
         5wvejTfHZJ4BSGp5maLTLI+ykTyTe/TRaYbdxJgxie20POsIDjq3UOJqdZbk0UERgJTr
         tHoyKYNdmZ/P+dMjx1xrX9C5bzPYXS0iEYdGWh7VLzvUWLD8Z9bc5JvuX+9n4Koemrnk
         hvRQ==
X-Gm-Message-State: AOJu0YwPuqOJ7RrMT4soVq3H/7Z+zlGZ6MWoMHab40XgwMeUl2qiew7u
	iUFyDnT77/6mI+1+T5S87iGSsy0HIq7qV97EFCYpXPrZHnkSyTWKGgiVSPY3XdKivbktLTmSnEb
	DyIjb4bK1YOy+99a/pAWhN3G4Tzo9fcQ86ttVyX3Jgv6YIRkugC+5ssJPX+1e+v6dOGZlaZhBKo
	EChzIA/wAFh5embqmdS9G1vfL467yw35XKiRqexHL2bCh9XRL9fNRA8Q==
X-Google-Smtp-Source: AGHT+IEsc2Lj8N3rTxeNWx9ih1V5tMTbZiHBB2CSobNOVFD8y6Tw1gE2nmjH3/iQ9cJEnLEnKggdVw==
X-Received: by 2002:a05:6a20:a115:b0:1c2:8904:14c2 with SMTP id adf61e73a8af0-1c47b2d151amr5398963637.37.1721983794278;
        Fri, 26 Jul 2024 01:49:54 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816db18sm2049645a12.33.2024.07.26.01.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:49:54 -0700 (PDT)
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
Subject: [PATCH v8 3/5] RISC-V: KVM: Add Svade and Svadu Extensions Support for Guest/VM
Date: Fri, 26 Jul 2024 16:49:28 +0800
Message-Id: <20240726084931.28924-4-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726084931.28924-1-yongxuan.wang@sifive.com>
References: <20240726084931.28924-1-yongxuan.wang@sifive.com>
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
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/include/uapi/asm/kvm.h |  2 ++
 arch/riscv/kvm/vcpu.c             |  4 ++++
 arch/riscv/kvm/vcpu_onereg.c      | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e97db3296456..85bbc472989d 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -175,6 +175,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCF,
 	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_ZAWRS,
+	KVM_RISCV_ISA_EXT_SVADE,
+	KVM_RISCV_ISA_EXT_SVADU,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 8d7d381737ee..c78061a6d68b 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -544,6 +544,10 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
 	if (riscv_isa_extension_available(isa, ZICBOZ))
 		cfg->henvcfg |= ENVCFG_CBZE;
 
+	if (riscv_isa_extension_available(isa, SVADU) &&
+	    !riscv_isa_extension_available(isa, SVADE))
+		cfg->henvcfg |= ENVCFG_ADUE;
+
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN)) {
 		cfg->hstateen0 |= SMSTATEEN0_HSENVCFG;
 		if (riscv_isa_extension_available(isa, SSAIA))
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index b319c4c13c54..b3f58908902a 100644
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
@@ -110,6 +113,12 @@ static bool kvm_riscv_vcpu_isa_enable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_SSCOFPMF:
 		/* Sscofpmf depends on interrupt filtering defined in ssaia */
 		return __riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSAIA);
+	case KVM_RISCV_ISA_EXT_SVADU:
+		/*
+		 * The henvcfg.ADUE is read-only zero if menvcfg.ADUE is zero.
+		 * Guest OS can use Svadu only when host OS enable Svadu.
+		 */
+		return arch_has_hw_pte_young();
 	case KVM_RISCV_ISA_EXT_V:
 		return riscv_v_vstate_ctrl_user_allowed();
 	default:
@@ -181,6 +190,12 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
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


