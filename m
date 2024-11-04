Return-Path: <linux-kernel+bounces-394929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBB9BB633
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A5F1C2157B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD42146A69;
	Mon,  4 Nov 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpDLhbYr"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C312DD8A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727143; cv=none; b=NyzXsoUGcBH6GXMZMib87F/j70qZB/mSSIWv+gmfIKD2TQmKmvSO46qx5iWPNjZiYi2hm2gzSaub+QLkFJdPJj+H8Xrq/+YRWKPw6qtm/pBIncyeh2Rb7H3pzUX52BiQGFZ6RZyYAmvc42SJVZW4NR/Q7DeeGehX54/N4fXCwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727143; c=relaxed/simple;
	bh=8Ka3uHmCTynLgF2f84rI4B+GMS/jz9B90udr8d7Wndo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VoPwzctTu2f40+ftT85eSpsXjWozM97E+nziHzuDjda3FA85PK81eYMULUmrZ+lJA50f6AObNTEnnCEPNLy/3j8XaEwmHrhXi6SvQTh1UDF+wPIyY6OgA32kWD2WQ1jAbq2CqfyVXSIY4vxfW9r65hJ5fN8T1uGoOY7b5znsy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpDLhbYr; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a9a157d028aso341744866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727140; x=1731331940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp5y0+Rq0WHrDia4bvFK9Du9WgLZRQc3oKl++fsdJMA=;
        b=OpDLhbYrBo/055gR1NbZRXDPFYaHOX0I0E1eRwvOOFUn0w4vWxYmLyWxLDnOJuDu+R
         QjPGimjn1I+wbyUyK3qhFAOxxOgCwkVggGO0sODaeqt7f/9NeUE5/0Yjc6Sn1Gq5doZA
         Lg+Xwn4F2DuTEQXc/UmBJKxHRifZY7bzMy5gE8ZZlM7qgo36qd1ZCRfMw180rk4nZvxN
         xekRJRwridGCX9coEhBSi70lT0Vqh0zEqF4aD3SV0sgpzG7vNz6BrO37Dlyy5DzYXaw4
         0WrjEjtde05YXF3FufoDjDlOdIVG0Cz8QRiN1nrK6Y3ocbonP1q+k08Urc8yUL/xmxjC
         rDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727140; x=1731331940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp5y0+Rq0WHrDia4bvFK9Du9WgLZRQc3oKl++fsdJMA=;
        b=T+/KhbxE2mIO5c+7SWANmy6UUhFxZLZUI4ki9hgRdnWPvDpGoNL2sK9X9RHgp5iHVL
         vN8OeVSt7GltIKLO/4Hr+HasoAVPUY05xAvXom9u8LtqUR9RhCBXmzthPcAjKYQdtCbS
         4MCJKtRXDL7a1FB5d5GlI+wPWBz4i0A1Fh3AUJnHeCUEW8NejgDnpqvQfYPfK7JM8VOF
         cssB4N+mMjGyDWIHDbWfHESJ633En8JLbTJqccX9zXSuBFu1nt5C0fSDfxAjnmMTHm84
         JStilXmAlKnWkNlSUTfukY5u+keK5ktGuwLVSBQ2DvP+oQiq4zxd5NM9x2YT2ESrglCq
         BzWw==
X-Forwarded-Encrypted: i=1; AJvYcCUGqHpcV58YzkpFMAbnZXRZHIVcs/yoV+6ULOOoF9H3DpNdRugGQXQO9N3Y3HnZd57+fchoD6rFYbrDq/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTi1E2fzlsEgxel1nnleSo8huzSnNFKEBFHKUz9iP9hofU9VGQ
	Z9UbFwOt8cRwo+3tPyyAY+1Fk4zGC7yN3IMbsRWwI37yR+TDpG5k0teTm2+PQub2iq2UbL3fbEN
	jtCs+nQ==
X-Google-Smtp-Source: AGHT+IGu3UcssODTNd0NubVJlZtWwwslOS4Fc2l45eu0iucEanXM8xQBrQzJXKGVO4SXDuAu4FLnrjRPKE4G
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:906:ca0b:b0:a99:f617:af50 with SMTP id
 a640c23a62f3a-a9e6581e0ebmr285966b.10.1730727139947; Mon, 04 Nov 2024
 05:32:19 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:51 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-6-qperret@google.com>
Subject: [PATCH 05/18] KVM: arm64: Pass walk flags to kvm_pgtable_stage2_mkyoung
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kvm_pgtable_stage2_mkyoung currently assumes that it is being called
from a 'shared' walker, which will not be true once called from pKVM.
To allow for the re-use of that function, make the walk flags one of
its parameters.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 4 +++-
 arch/arm64/kvm/hyp/pgtable.c         | 7 +++----
 arch/arm64/kvm/mmu.c                 | 3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 03f4c3d7839c..442a45d38e23 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -669,6 +669,7 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
  * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address to identify the page-table entry.
+ * @flags:	Flags to control the page-table walk (ex. a shared walk)
  *
  * The offset of @addr within a page is ignored.
  *
@@ -677,7 +678,8 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
  *
  * Return: The old page-table entry prior to setting the flag, 0 on failure.
  */
-kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
+kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr,
+				     enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_test_clear_young() - Test and optionally clear the access
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b11bcebac908..fa25062f0590 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1245,15 +1245,14 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
 					NULL, NULL, 0);
 }
 
-kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
+kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr,
+				     enum kvm_pgtable_walk_flags flags)
 {
 	kvm_pte_t pte = 0;
 	int ret;
 
 	ret = stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
-				       &pte, NULL,
-				       KVM_PGTABLE_WALK_HANDLE_FAULT |
-				       KVM_PGTABLE_WALK_SHARED);
+				       &pte, NULL, flags);
 	if (!ret)
 		dsb(ishst);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0f7658aefa1a..27e1b281f402 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1708,6 +1708,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 /* Resolve the access fault by making the page young again. */
 static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 {
+	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
 	kvm_pte_t pte;
 	struct kvm_s2_mmu *mmu;
 
@@ -1715,7 +1716,7 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 
 	read_lock(&vcpu->kvm->mmu_lock);
 	mmu = vcpu->arch.hw_mmu;
-	pte = kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
+	pte = kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa, flags);
 	read_unlock(&vcpu->kvm->mmu_lock);
 
 	if (kvm_pte_valid(pte))
-- 
2.47.0.163.g1226f6d8fa-goog


