Return-Path: <linux-kernel+bounces-359832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D678F99914B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79E4282EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5321BB18;
	Thu, 10 Oct 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LR0bZlhg"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089621BAFA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584870; cv=none; b=rjTzRdwsyFCp+S/loQlYAU66rUPOFLtRzWq4PeIf6evlm16DUe1nnc5YZjlftkbxQzLnuC7sjj5MQ8k/+SeNn7R0d8zZS8DEhv6JhGE3UOcFcaTdgapYd6I87wfZ8rLtDAUFIACi5B6/2ILQCht7jrwMSZVheuwhHCJmqOG0AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584870; c=relaxed/simple;
	bh=4ce0ST1uTErGaf3Fu8uQPVTe9dXk8k7UaRtdo8iN0BA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qt5chIigUlgJ3widx395+swIXD/+80KFdBGvORaw21sM3aN+FtMgVY/Ai5EecBxbz4LZaH4VzX2ci3OYDXPOBjWMGM27ghYIkE7muwziNtgptSwbo7tjuTPs7/7V4Efa6Wh7EcRoUWPEFvyC2FcIfvl4w6V73qogKplxqVKLJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LR0bZlhg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c8a637b77so13075015ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584868; x=1729189668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYRk8t9w2U8aQ/ID4AWjouVrA1tdB4hWvcNmB/sB3HQ=;
        b=LR0bZlhgBqqlK/AxVHUnYDgdPVeVfg62ritjsHW4icLlp2VXJMdBEQpqQ2DjaOB4Vo
         BMk5u0CdNiJU47xxEKEBNDUg1VIzyKQFA0lEenO//nWQFutF6qqNsjqYWpd0KkluabCG
         scoWgGmVwMXCV2bJcO3DxVbQdljLpb0S7K+9zHipw5iopVLZ5O/Et9tquTm7UfUH/R3W
         Tzhi8J9rL8rJ6Zw+R2IdaOJPRXvC3k33WFcoS6zAsYYyRLTyXGYrquN21MhPyyOeIlNt
         k76iPpUznp7HqqlLd6wYwP+ZU1DkIHHgVTgrkh+gxlQpcl0jRX8rnB7ytNb8WRs+Wq5s
         9Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584868; x=1729189668;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qYRk8t9w2U8aQ/ID4AWjouVrA1tdB4hWvcNmB/sB3HQ=;
        b=IPM15wGNU4Yf1G+hJlZ5GKukRUhWR4R5NztbwxsBg68JNMNQdsWGN7xvmMG4mifFBE
         gM0/fYJ+2InpeEnUAox7jR/6QgbE0H8+n9z39rUXIAOpGalBmlGWbA7o08ox2fifwfFD
         z8NWLKFolnNIyprRi5kpNwy82HbGx5QcRmn4TH79/IvSYv05jcOPE/pXis6IVUMuqJMS
         eCtiZeLnDZkdbUx71Jf/yNQRyVM851glv1Glo/EKkWbHt8IKpFKgUDWz5NR5g7c0sgd7
         GRq3TDcMtHSIGownqsfit+2O5pstoOf4LInKJ6buGqa0E6q05/X67P7xXNMu+N1pXRsy
         HjIA==
X-Forwarded-Encrypted: i=1; AJvYcCW9gp3dMwPk9TCjb85Vw0pxyT86/lRqg8lxNpBdUcJBeTrj2YlrkcMEFQKEUJeEUWrpa42aGfuZKmXJu9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9GtYcxvTeYoXJXQgz3SXkc04YM5cci3x+5vhxEPahC0+NRpZ
	z10A0oy+VclnTbRuc/F7mXgSpZyjYki+D4p/awuxdptqnrfO19KYh0GX2WyPLzsTcxxZjGvC07l
	EKg==
X-Google-Smtp-Source: AGHT+IHfwq/leOSDpGNmElHsEevN2NLhktzxL5WWYsNV7s51yqV4fIBatX1NQsHzbv29AfLNcoyCuLVeClM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:e745:b0:20c:857b:5dcb with SMTP id
 d9443c01a7336-20c857b62ffmr639275ad.4.1728584868183; Thu, 10 Oct 2024
 11:27:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:24:25 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-84-seanjc@google.com>
Subject: [PATCH v13 83/85] KVM: arm64: Don't mark "struct page" accessed when
 making SPTE young
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
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Don't mark pages/folios as accessed in the primary MMU when making a SPTE
young in KVM's secondary MMU, as doing so relies on
kvm_pfn_to_refcounted_page(), and generally speaking is unnecessary and
wasteful.  KVM participates in page aging via mmu_notifiers, so there's no
need to push "accessed" updates to the primary MMU.

Dropping use of kvm_set_pfn_accessed() also paves the way for removing
kvm_pfn_to_refcounted_page() and all its users.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 4 +---
 arch/arm64/kvm/hyp/pgtable.c         | 7 ++-----
 arch/arm64/kvm/mmu.c                 | 6 +-----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/=
kvm_pgtable.h
index 03f4c3d7839c..aab04097b505 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -674,10 +674,8 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *p=
gt, u64 addr, u64 size);
  *
  * If there is a valid, leaf page-table entry used to translate @addr, the=
n
  * set the access flag in that entry.
- *
- * Return: The old page-table entry prior to setting the flag, 0 on failur=
e.
  */
-kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
+void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
=20
 /**
  * kvm_pgtable_stage2_test_clear_young() - Test and optionally clear the a=
ccess
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b11bcebac908..40bd55966540 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1245,19 +1245,16 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable=
 *pgt, u64 addr, u64 size)
 					NULL, NULL, 0);
 }
=20
-kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
+void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
 {
-	kvm_pte_t pte =3D 0;
 	int ret;
=20
 	ret =3D stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF=
, 0,
-				       &pte, NULL,
+				       NULL, NULL,
 				       KVM_PGTABLE_WALK_HANDLE_FAULT |
 				       KVM_PGTABLE_WALK_SHARED);
 	if (!ret)
 		dsb(ishst);
-
-	return pte;
 }
=20
 struct stage2_age_data {
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 4054356c9712..e2ae9005e333 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1706,18 +1706,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, ph=
ys_addr_t fault_ipa,
 /* Resolve the access fault by making the page young again. */
 static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_i=
pa)
 {
-	kvm_pte_t pte;
 	struct kvm_s2_mmu *mmu;
=20
 	trace_kvm_access_fault(fault_ipa);
=20
 	read_lock(&vcpu->kvm->mmu_lock);
 	mmu =3D vcpu->arch.hw_mmu;
-	pte =3D kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
+	kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
 	read_unlock(&vcpu->kvm->mmu_lock);
-
-	if (kvm_pte_valid(pte))
-		kvm_set_pfn_accessed(kvm_pte_to_pfn(pte));
 }
=20
 /**
--=20
2.47.0.rc1.288.g06298d1525-goog


