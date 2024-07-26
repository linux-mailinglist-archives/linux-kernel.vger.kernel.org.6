Return-Path: <linux-kernel+bounces-263899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8C93DC14
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739681F227F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884A189F32;
	Fri, 26 Jul 2024 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nezcdDbD"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F560188CD8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038087; cv=none; b=Q+A5En5TnJSoC9XoSLa0eg28lLQJ7UqMabyk9zs9F8Jy1q5pYlmbEkNWs4d5DklN9QTey362+irzpdQ65GvyDsQwHxo/kujF6LzhPZKVSV75VY5jKpXV7bgY+yLGiYEqapk75mf+b1y9jtQk9naeY0AidiblgBGvl6YXtX98K0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038087; c=relaxed/simple;
	bh=fhSce6+NlER4lqSnBEsOz4PUKkoojvsuOboKzHVrVQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gshFRcgkP42sjTbxt3wvKLctVZ4BGhy0sV/nTIP/dVhe7K4tsr+dkLRVhKkNsXonU743RtGne5LcjdEMsYqBo3r+Qzkm04jzGwlQPqe1BjNxpdML+18ymFxGToEFQh3+dkUhnodOV7A7AV3ZBWScrlI5Na/R3if3IPHGpOTcYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nezcdDbD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc4fcaa2e8so10527895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038085; x=1722642885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fnzANaCry6VTBaaBvIzLI2Urcy+eNpGQjPUes1ZSEvM=;
        b=nezcdDbDgVw5lnyIoGPFoQ05Y3OKgwxPoFANa005SwcD7jPE45MklIkdQsnaY2CV0L
         51Iiz+W4NmnHH2OQRse7nGPpwXdbb845xRWvEiU1s1639UIXwCCaZFYhAPXEcoUZM1YH
         x7K3dtanINNG/Lwb6tBR27zgOKkQMhBLiTag31eC1DbL27TuQRiLJQWo4YtxJZumO53D
         cL7yfEB142RjLl0yiATVCC9EMVYUuc5accQ6pEVaibjR1U8+wEjWh+7N00DNPAnrKm1y
         98pfP+Be1ILPxiSx0fZjdUSAJxYsbenBpjPmhQN7CY9uSSez5SEu9APABMpDN4HC2k+u
         WGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038085; x=1722642885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnzANaCry6VTBaaBvIzLI2Urcy+eNpGQjPUes1ZSEvM=;
        b=f8JLRCJ2L9Bem+LSNNBQdvc1i6TmE/EOr/pLK9h3XBwX9OVFQNhQWeYinyXN4VoW75
         MPZ6YcCTiM5doUScWU/9tGKMgc2zO+WXvLq2XC1MgOW4PqZw53lkDFSyuaOILO0mmDOY
         4CQjNUYE0Gcamqdul6Xzv1hM45GJk7yjqMILe89QabxLJTxNsv9N0erPXOy5A2kS3p3O
         QE5L11amkDAYMQIyhAaKj4OHJ8Sdlv9t4tSt87p2TMSHG9UOU7ICd1An5AdmQlNzaeTo
         vc8mrMIGXZ+sgP7fPn5jF29DvNPJJI9RCtrYsMnTtYqjafNjqTFkqubXmfmDdBxO+RD7
         7EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYIXHTvvGuS4V14n5jdgEalHMk9DMtbDxvOdA78W5WH9TdkaBktTLUHLKUzp54qdhBdebrjmze5mwzdHO5i2dlWa2fas9vbQJ2NyYM
X-Gm-Message-State: AOJu0Yw1h0dyi2LdZIN/3HLB/RvIGKeAAWSJvqSn1oSjY1Dvacs6JxLA
	3NKx8rBT3W5jSb58T/uUmxX/rAgmwqZ1MzGNRKv2sGHCHuYg1Ep+VLZrbPQFeVg3dXwJ6IJDlTG
	S1w==
X-Google-Smtp-Source: AGHT+IHmHH2jIucYiOpERpDS4ASgx5TvMHlaOIj1nvo/BSmO2/veDdrUl5Q72dqDHu1wFellCWvE9VI+k4Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:11d0:b0:1fb:6b70:8f6a with SMTP id
 d9443c01a7336-1ff04917c5dmr841815ad.11.1722038084875; Fri, 26 Jul 2024
 16:54:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:52:10 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-62-seanjc@google.com>
Subject: [PATCH v12 61/84] KVM: PPC: Drop unused @kvm_ro param from kvmppc_book3s_instantiate_page()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Drop @kvm_ro from kvmppc_book3s_instantiate_page() as it is now only
written, and never read.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/include/asm/kvm_book3s.h  | 2 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 6 ++----
 arch/powerpc/kvm/book3s_hv_nested.c    | 4 +---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 3e1e2a698c9e..34e8f0b7b345 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -203,7 +203,7 @@ extern bool kvmppc_hv_handle_set_rc(struct kvm *kvm, bool nested,
 extern int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 				unsigned long gpa,
 				struct kvm_memory_slot *memslot,
-				bool writing, bool kvm_ro,
+				bool writing,
 				pte_t *inserted_pte, unsigned int *levelp);
 extern int kvmppc_init_vm_radix(struct kvm *kvm);
 extern void kvmppc_free_radix(struct kvm *kvm);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 14891d0a3b73..b3e6e73d6a08 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -821,7 +821,7 @@ bool kvmppc_hv_handle_set_rc(struct kvm *kvm, bool nested, bool writing,
 int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 				   unsigned long gpa,
 				   struct kvm_memory_slot *memslot,
-				   bool writing, bool kvm_ro,
+				   bool writing,
 				   pte_t *inserted_pte, unsigned int *levelp)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -931,7 +931,6 @@ int kvmppc_book3s_radix_page_fault(struct kvm_vcpu *vcpu,
 	struct kvm_memory_slot *memslot;
 	long ret;
 	bool writing = !!(dsisr & DSISR_ISSTORE);
-	bool kvm_ro = false;
 
 	/* Check for unusual errors */
 	if (dsisr & DSISR_UNSUPP_MMU) {
@@ -984,7 +983,6 @@ int kvmppc_book3s_radix_page_fault(struct kvm_vcpu *vcpu,
 					ea, DSISR_ISSTORE | DSISR_PROTFAULT);
 			return RESUME_GUEST;
 		}
-		kvm_ro = true;
 	}
 
 	/* Failed to set the reference/change bits */
@@ -1002,7 +1000,7 @@ int kvmppc_book3s_radix_page_fault(struct kvm_vcpu *vcpu,
 
 	/* Try to insert a pte */
 	ret = kvmppc_book3s_instantiate_page(vcpu, gpa, memslot, writing,
-					     kvm_ro, NULL, NULL);
+					     NULL, NULL);
 
 	if (ret == 0 || ret == -EAGAIN)
 		ret = RESUME_GUEST;
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 05f5220960c6..771173509617 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -1527,7 +1527,6 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 	unsigned long n_gpa, gpa, gfn, perm = 0UL;
 	unsigned int shift, l1_shift, level;
 	bool writing = !!(dsisr & DSISR_ISSTORE);
-	bool kvm_ro = false;
 	long int ret;
 
 	if (!gp->l1_gr_to_hr) {
@@ -1607,7 +1606,6 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 					ea, DSISR_ISSTORE | DSISR_PROTFAULT);
 			return RESUME_GUEST;
 		}
-		kvm_ro = true;
 	}
 
 	/* 2. Find the host pte for this L1 guest real address */
@@ -1629,7 +1627,7 @@ static long int __kvmhv_nested_page_fault(struct kvm_vcpu *vcpu,
 	if (!pte_present(pte) || (writing && !(pte_val(pte) & _PAGE_WRITE))) {
 		/* No suitable pte found -> try to insert a mapping */
 		ret = kvmppc_book3s_instantiate_page(vcpu, gpa, memslot,
-					writing, kvm_ro, &pte, &level);
+					writing, &pte, &level);
 		if (ret == -EAGAIN)
 			return RESUME_GUEST;
 		else if (ret)
-- 
2.46.0.rc1.232.g9752f9e123-goog


