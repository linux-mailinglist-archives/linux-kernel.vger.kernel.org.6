Return-Path: <linux-kernel+bounces-359808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DA999105
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078BEB248C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2B209F33;
	Thu, 10 Oct 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNfpTpqi"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD2209675
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584820; cv=none; b=Nk8U6amYeVOzZVlYE2lUfZA9MbVSvs/c1cg9d8v5pQSt/QmdOsIkvsGsgU7vkBDnYwK2Nzi0GGdMrtXYaT6oGVEq1rwVjSyNDNb7m6TqLLa2Au3Hi3lGVXwdaKveO0z7WmKNkuREx34+8vpavWQL9iyXu8Tbgb8bhKhrQ13Ndgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584820; c=relaxed/simple;
	bh=h8Ty3DwV1uJmCoppjwTeaFXY32gukNMrofdCY+cnYhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t1Odvhv7V3WbwTIy1+1XLEE8+CK8b6rEmqVxDrGKjn4oHbUF3OQwfU7UdEak6XUBhq77tUzTtaySTtH/Cv5CASNL+VCCsPcQtckHgc0y1LU4MmpZWtUTA8J/DNbUfdYoPlTnrsagnImqeT5gEoeKyd36cV2anGUoU931Ma3HW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNfpTpqi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso1196103a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584818; x=1729189618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OPPvMTYiUGb6pAXW02Q14XiUF2+KvArosM2sRK6VjAA=;
        b=JNfpTpqiBYBKFLYDya+q/+VqUsSM16GJP14qVcVJBPKXZq4oW86J7IKlLAOiNob6Px
         IEuSrspqaxeP+LwqTSlCTpUpi94WLf5XXZW/QoJCLOugk9sV3+x2J4yYTdzkt3tvnLQx
         nE5oE/+OqR1Yuki9kQowd4XCBCzHiNhnKLTalavt1s+dTpNB4LgxIrPIUAPsx+IFSoQe
         Dxl8Q0gJ0H3By5DV9zN8gz91BDltC3iw79l9V7QEzDzNavm6Mkl165TAaQtIf5TNC1uq
         y5ayftOuatk9cCD2wXS5Rbnu24zhxUq7JElq0/cz+LsUk+p71mBe6JOzZybeoA2rg/hT
         EvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584818; x=1729189618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPPvMTYiUGb6pAXW02Q14XiUF2+KvArosM2sRK6VjAA=;
        b=fYYCqGIBA7ZAbVqC2PI1bW8GAJDI7kmHlb9Mx4f/IcliZe8rp3gvRdFOVzSxjBynxe
         NFknrA4Wbf75m9uATgFIRkl9aLVQC5cqSq4Xeyi3HpLlaD1p78OWVHXyXLcYc2mQJhD1
         ApNPv6FkTgtapRhGn8uwHHUZhiDqm2XbMT3PHYvkbhb37oWkmvB9CV+RrA8zj463OCQ8
         MqbdtF3+dxPAQEPUPM3F5D/1JZwKaENg2jYRVkS7i/irezkxGvye+Uk7r1kiY7qaAlHa
         n8lEXUcU7k1Caep1CP4V/LTZLwrFhr0Xv6PGC1pEBZhiLzyqaO65oQd9++us9GTCapTm
         VKJA==
X-Forwarded-Encrypted: i=1; AJvYcCUd6zuST/H0D4Mv2u9Ud9yosGx7mCxjnAdJu73/isgeW7Tj6f7bgH924bgAaAjwxa9NiUtm0BpBwUNJMCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqSwJpjWT4EnInIhO005df0j2fa30/GuBwYBhRcvgiuayWgGc
	0JVbsUgOKrsPUfgB6wWydHeWDQnhweHQftI4SBk+p8WBVsxD/JleBnh4dp6ShQ/hnxY48COaOmq
	b2g==
X-Google-Smtp-Source: AGHT+IHVZkXcNH8eDb3GIQubykYaXKWHdrpGe/zHTLQHIjPMwQpAN0ra/QncFunLfkL/hgYZuPxk0qgLkH8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:2343:b0:20c:747d:ec15 with SMTP id
 d9443c01a7336-20c747df618mr290175ad.1.1728584817934; Thu, 10 Oct 2024
 11:26:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:24:01 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-60-seanjc@google.com>
Subject: [PATCH v13 59/85] KVM: RISC-V: Use kvm_faultin_pfn() when mapping
 pfns into the guest
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

Convert RISC-V to __kvm_faultin_pfn()+kvm_release_faultin_page(), which
are new APIs to consolidate arch code and provide consistent behavior
across all KVM architectures.

Opportunisticaly fix a s/priort/prior typo in the related comment.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/riscv/kvm/mmu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2e9aee518142..e11ad1b616f3 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -601,6 +601,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
 	bool logging = (memslot->dirty_bitmap &&
 			!(memslot->flags & KVM_MEM_READONLY)) ? true : false;
 	unsigned long vma_pagesize, mmu_seq;
+	struct page *page;
 
 	/* We need minimum second+third level pages */
 	ret = kvm_mmu_topup_memory_cache(pcache, gstage_pgd_levels);
@@ -631,7 +632,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
 
 	/*
 	 * Read mmu_invalidate_seq so that KVM can detect if the results of
-	 * vma_lookup() or gfn_to_pfn_prot() become stale priort to acquiring
+	 * vma_lookup() or __kvm_faultin_pfn() become stale prior to acquiring
 	 * kvm->mmu_lock.
 	 *
 	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
@@ -647,7 +648,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
 		return -EFAULT;
 	}
 
-	hfn = gfn_to_pfn_prot(kvm, gfn, is_write, &writable);
+	hfn = kvm_faultin_pfn(vcpu, gfn, is_write, &writable, &page);
 	if (hfn == KVM_PFN_ERR_HWPOISON) {
 		send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
 				vma_pageshift, current);
@@ -681,11 +682,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
 		kvm_err("Failed to map in G-stage\n");
 
 out_unlock:
-	if ((!ret || ret == -EEXIST) && writable)
-		kvm_release_pfn_dirty(hfn);
-	else
-		kvm_release_pfn_clean(hfn);
-
+	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
 	spin_unlock(&kvm->mmu_lock);
 	return ret;
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


