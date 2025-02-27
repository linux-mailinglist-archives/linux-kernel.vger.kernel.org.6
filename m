Return-Path: <linux-kernel+bounces-535215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362DAA47038
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC2D7A8325
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D2749A;
	Thu, 27 Feb 2025 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCLogDf1"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840D6FBF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616398; cv=none; b=awHcmUS2/X4NwHvhBCVS+rD9jMkefby1J8eprZY6nxyuEe7etjs2viWnFutv3u7YxVsh9e9dED8IQ1MU1hO6aiaxMQvH4zPM0ZZPL1kw28GmQZWsuXNhGJZV4+T2fEch5vuUr7TYTUqJTepXe/XukEpReOhc+s+rWok5jGmoYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616398; c=relaxed/simple;
	bh=oJPtYm8a9NJewkREbq9VadrFsmWB8AXYZ5A8G3HTEtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCp6DhEJix+fvivz5C1BjQvdPZetk+FNo1fe2l0Y8QIwTLSJ9SGLA16ySwnyvbEGT81I7N92wpGOFsyjRJCi7Hccv9ngo2vGgaQ7uyMqPkIuyX5cCVw7UIo6pthkE/5KG1UF2sVOSKlQ3fx91nFmI1yxxJn/Nrrw9mefLFwRA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCLogDf1; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abb9d1c8113so33459666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616394; x=1741221194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnSi0QZnCKAvL+73Iyi2doPe04c0Ox90ZdzmLMLkEvI=;
        b=eCLogDf1Sr5cjqIpCPfH3Be9bJftYUZVIaEPMBRqSgy4PyeWNiF/3Xhjl9Toihk3Hl
         goVz0/aWuipey5gkvKcu6Matuz2vWwGOb8OS+vmo//eDmIATYpOSfXM1NptVbyxcRUco
         io+0tkPMWa15U2h6r9czFDIe8rEgrji5oeGwjXAYRrEzV2PLHbiQng8yi70nRpGJZrdq
         w62pMv671HypDwYXI6IbOQE17C+O7NuZWaI08qt4Gu/1oB9TUJ70b/4dV4mWLo0JHWhD
         mhH8FyBItdn3aqFBqMehAIRjCk2l6h4/G7UKuMjAv1CIB2oOXLAlAAFAFfnPB33wxSWm
         QXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616394; x=1741221194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnSi0QZnCKAvL+73Iyi2doPe04c0Ox90ZdzmLMLkEvI=;
        b=Ybfju6DG2Y9HsXQrChf/17H7CpUIuo7CE6s/0TnHGUubG9kXpgKN2qpWxvmEJcgpvJ
         GftOOZ49qTh+PP58jpJ3M5ruupu7TLEei8EnVa27plYQgdecohlzaJf+v4HB0TcXZWgP
         xBrRmA1Y2HTHcM+1CEFdJ/ANqOXXp316Yu98p/iT5NwG1mkqCVqvPKpsxvKN/R0ZDH6S
         yzSvCGPv+SOON29bMugEU5c1te6mBB6chjMy5HLIlaDLu4/HaHlg8H98jUEBvzST9pm+
         i9I4QrCIZRZBTmsYVnGYAJ61Wbu7hMeYJm/xS98g3S6rqGo2PtT3mrtpBwjLXf0MFhyc
         sawg==
X-Forwarded-Encrypted: i=1; AJvYcCVF0Qg9p3MUsg6xHZmVVly3uP3ml3nTHYAQ7g4Ds3MX1V8QQqUg+y9zNZ8wV20FzQ5gbFr6MNEl9ROYAo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCFTY28bWqYfqqD/QonvX7SVmzPOfZs1z40sfU3+eCC/B/CEw
	rfhQPZV3sWlhuEdBUmrhcYkf1wvWaSTEhfAMMhU+VjcVwRTYCgRY0Xq/LjDq1vvZrDovbqB56RZ
	Mcj+VfA==
X-Google-Smtp-Source: AGHT+IFnzWlAoWfe7gVv/3yG2kJPIQ7pfQ+/eZHRD7MANnsJ1+erytT4JEEh5E6KoQuNIQGX7Bdb2AUdqKfL
X-Received: from ejcsk13.prod.google.com ([2002:a17:906:630d:b0:abe:e921:5690])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:cf86:b0:ab7:ec8b:c642
 with SMTP id a640c23a62f3a-abeeecf6f79mr771155666b.5.1740616394645; Wed, 26
 Feb 2025 16:33:14 -0800 (PST)
Date: Thu, 27 Feb 2025 00:33:05 +0000
In-Reply-To: <20250227003310.367350-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227003310.367350-1-qperret@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003310.367350-2-qperret@google.com>
Subject: [PATCH 1/6] KVM: arm64: Track SVE state in the hypervisor vcpu structure
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Fuad Tabba <tabba@google.com>

When dealing with a guest with SVE enabled, make sure the host SVE
state is pinned at EL2 S1, and that the hypervisor vCPU state is
correctly initialised (and then unpinned on teardown).

Co-authored-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_host.h  | 12 ++++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |  4 ---
 arch/arm64/kvm/hyp/nvhe/pkvm.c     | 54 +++++++++++++++++++++++++++---
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3a7ec98ef123..90b58f87b107 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -930,20 +930,22 @@ struct kvm_vcpu_arch {
 #define vcpu_sve_zcr_elx(vcpu)						\
 	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
 
-#define vcpu_sve_state_size(vcpu) ({					\
+#define sve_state_size_from_vl(sve_max_vl) ({				\
 	size_t __size_ret;						\
-	unsigned int __vcpu_vq;						\
+	unsigned int __vq;						\
 									\
-	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+	if (WARN_ON(!sve_vl_valid(sve_max_vl))) {			\
 		__size_ret = 0;						\
 	} else {							\
-		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
-		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
+		__vq = sve_vq_from_vl(sve_max_vl);			\
+		__size_ret = SVE_SIG_REGS_SIZE(__vq);			\
 	}								\
 									\
 	__size_ret;							\
 })
 
+#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
+
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
 				 KVM_GUESTDBG_USE_HW | \
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2c37680d954c..59db9606e6e1 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -123,10 +123,6 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
-	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
-	/* Limit guest vector length to the maximum supported by the host.  */
-	hyp_vcpu->vcpu.arch.sve_max_vl	= min(host_vcpu->arch.sve_max_vl, kvm_host_sve_max_vl);
-
 	hyp_vcpu->vcpu.arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWI | HCR_TWE);
 	hyp_vcpu->vcpu.arch.hcr_el2 |= READ_ONCE(host_vcpu->arch.hcr_el2) &
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 3927fe52a3dd..3ec27e12b043 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -356,13 +356,29 @@ static void unpin_host_vcpu(struct kvm_vcpu *host_vcpu)
 		hyp_unpin_shared_mem(host_vcpu, host_vcpu + 1);
 }
 
+static void unpin_host_sve_state(struct pkvm_hyp_vcpu *hyp_vcpu)
+{
+	void *sve_state;
+
+	if (!vcpu_has_feature(&hyp_vcpu->vcpu, KVM_ARM_VCPU_SVE))
+		return;
+
+	sve_state = kern_hyp_va(hyp_vcpu->vcpu.arch.sve_state);
+	hyp_unpin_shared_mem(sve_state,
+			     sve_state + vcpu_sve_state_size(&hyp_vcpu->vcpu));
+}
+
 static void unpin_host_vcpus(struct pkvm_hyp_vcpu *hyp_vcpus[],
 			     unsigned int nr_vcpus)
 {
 	int i;
 
-	for (i = 0; i < nr_vcpus; i++)
-		unpin_host_vcpu(hyp_vcpus[i]->host_vcpu);
+	for (i = 0; i < nr_vcpus; i++) {
+		struct pkvm_hyp_vcpu *hyp_vcpu = hyp_vcpus[i];
+
+		unpin_host_vcpu(hyp_vcpu->host_vcpu);
+		unpin_host_sve_state(hyp_vcpu);
+	}
 }
 
 static void init_pkvm_hyp_vm(struct kvm *host_kvm, struct pkvm_hyp_vm *hyp_vm,
@@ -376,12 +392,40 @@ static void init_pkvm_hyp_vm(struct kvm *host_kvm, struct pkvm_hyp_vm *hyp_vm,
 	pkvm_init_features_from_host(hyp_vm, host_kvm);
 }
 
-static void pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *host_vcpu)
+static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *host_vcpu)
 {
 	struct kvm_vcpu *vcpu = &hyp_vcpu->vcpu;
+	unsigned int sve_max_vl;
+	size_t sve_state_size;
+	void *sve_state;
+	int ret = 0;
 
-	if (!vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
+	if (!vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE)) {
 		vcpu_clear_flag(vcpu, VCPU_SVE_FINALIZED);
+		return 0;
+	}
+
+	/* Limit guest vector length to the maximum supported by the host. */
+	sve_max_vl = min(READ_ONCE(host_vcpu->arch.sve_max_vl), kvm_host_sve_max_vl);
+	sve_state_size = sve_state_size_from_vl(sve_max_vl);
+	sve_state = kern_hyp_va(READ_ONCE(host_vcpu->arch.sve_state));
+
+	if (!sve_state || !sve_state_size) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = hyp_pin_shared_mem(sve_state, sve_state + sve_state_size);
+	if (ret)
+		goto err;
+
+	vcpu->arch.sve_state = sve_state;
+	vcpu->arch.sve_max_vl = sve_max_vl;
+
+	return 0;
+err:
+	clear_bit(KVM_ARM_VCPU_SVE, vcpu->kvm->arch.vcpu_features);
+	return ret;
 }
 
 static int init_pkvm_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu,
@@ -416,7 +460,7 @@ static int init_pkvm_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu,
 	if (ret)
 		goto done;
 
-	pkvm_vcpu_init_sve(hyp_vcpu, host_vcpu);
+	ret = pkvm_vcpu_init_sve(hyp_vcpu, host_vcpu);
 done:
 	if (ret)
 		unpin_host_vcpu(host_vcpu);
-- 
2.48.1.658.g4767266eb4-goog


