Return-Path: <linux-kernel+bounces-263878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706CE93DBCC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A061F21726
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C166155CAE;
	Fri, 26 Jul 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oP14WA9W"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0813181B8C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038043; cv=none; b=FmsOkPY5fPGb6FTvkoQb2xvvcL9KnODWniZGTH1+jgGGPqIMoEDCL9a2MkQaRhOWpqKs8kUYrx3E+j2KGcfoZr1tZkeaLID0Ob2BXhnS/1sIhEyie+maPVWj+H6ZyxO77EUzOyt2IT+82HkWoBwjEbjFVi2AaHPLMYbc7VcdmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038043; c=relaxed/simple;
	bh=I21AIIPQRJE/LHqjT9YPoKMi3QRQyqy6GfrC1Ir9UhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AvCc5g391sBsLZQ3ZF8kpmsspHnijdKQ+sjpS3JyAsm2cTycK7DJJHu5InAEMk2DrsROTSO9oeQmb/LxNSC7S2OSbgNpnuyTmD1MmKW4LPGTyAvTetpzR9qiN+FW930pdgC7djkRbFpiVOzYUniUaWfdbdGccZhm+oRbFSg9Giw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oP14WA9W; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc5e61f0bbso13362525ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038040; x=1722642840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kjY6k542G0oo6Yjo2zUiSEPku2YJftlYNe05DeRMCZs=;
        b=oP14WA9WQjKMwJ3SmM9yDyF5evZPqDAdielp/u4IOvMY/lhacM4Mzg8V8jZFQUea21
         8y9XJk0PcM7MxuxhQeyHX+mpdaXeC/5cJRS7RF0u2is7ZLR1GoMvfNgsnpyrskhdOgn7
         RJ+SsT/32rrzzNs4uu5gyBx4beiPzkC1FbzRJwrv/leFGPytTC6Br0MpcImPzGBR5RyX
         aopJnhf7RZZP/X4gq1hCKf92VVjA0V+LEoRodQmzVmwkTeTu8YQ9mYNtLIb8+6s4Us6T
         Q7x5KVkHyR0ArslJxqqitqgnN01kZSWur5vLJtDQFKZ66QpRgMxA1NaK+VdL1RFlxssf
         A3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038040; x=1722642840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjY6k542G0oo6Yjo2zUiSEPku2YJftlYNe05DeRMCZs=;
        b=nX8I9oVwhT+o1uAf7/0gFjGAm4/PL+6WQT1GWfdQ0UmDDeAp8NGjdp/LZHL2VbiFMG
         EQjRsP3irhQLw0j5Hvg+cEGiR0T6gtlGZIAz2ysLCxwMuH6oRHt9QP+4hQ5U46xdtnC3
         meUuoPAYQFi9OMe+7Sq1k5JTJiKTciDIiLl6t0pLAYJAiUvzoQUlZbQ1F3NvmRd28NsT
         g+6dpM6mU4sM1G+FZJO8JUOjNAZkkGnJJElEhNCiO4FtUBfBgHJDL0/Cq2CY9tZFWFTn
         lGdeGj00A1MIqMVqhslzNCGOMTQskWueNXRd4C6Tiggffdclua+xd6iu4MPwKzN34/VL
         PoDg==
X-Forwarded-Encrypted: i=1; AJvYcCU/qSieoqF08oTfESgIY2wjXInibRut4gSbZnaVAK+iJH4VzgK0SS+hk6zV56NRreNPvdZWk1RwGBTGdo94N/+m1pKQo+HrpJUP2w77
X-Gm-Message-State: AOJu0Yw/7HZRRiLHBxSd1ekX9er3TFWbY+SAXO6oJiWK9KQzFQOPWUs8
	vn/WeG1KLxOC6ueNfDNK772Vg2OIdavDhHPd/U7PB/Pi73gqWNePNtlvjVyPVJpqXFBrfMqS3Yb
	qpg==
X-Google-Smtp-Source: AGHT+IHzv0Ay1s7/D5RlCraUOAPppGpx+9DOe5Wc2TnAqa2oJae5LaRq2mY8TBHhwH7zU/okRdoTzatzS5o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f60c:b0:1f8:6c64:3575 with SMTP id
 d9443c01a7336-1ff046dcdffmr290425ad.0.1722038040140; Fri, 26 Jul 2024
 16:54:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:51:49 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-41-seanjc@google.com>
Subject: [PATCH v12 40/84] KVM: x86/mmu: Add helper to "finish" handling a
 guest page fault
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

Add a helper to finish/complete the handling of a guest page, e.g. to
mark the pages accessed and put any held references.  In the near
future, this will allow improving the logic without having to copy+paste
changes into all page fault paths.  And in the less near future, will
allow sharing the "finish" API across all architectures.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 12 +++++++++---
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e76f64f55c4a..1cdd67707461 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4311,6 +4311,12 @@ static u8 kvm_max_private_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 	return req_max_level;
 }
 
+static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
+				      struct kvm_page_fault *fault, int r)
+{
+	kvm_release_pfn_clean(fault->pfn);
+}
+
 static int kvm_mmu_faultin_pfn_private(struct kvm_vcpu *vcpu,
 				       struct kvm_page_fault *fault)
 {
@@ -4476,7 +4482,7 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	 * mmu_lock is acquired.
 	 */
 	if (mmu_invalidate_retry_gfn_unsafe(vcpu->kvm, fault->mmu_seq, fault->gfn)) {
-		kvm_release_pfn_clean(fault->pfn);
+		kvm_mmu_finish_page_fault(vcpu, fault, RET_PF_RETRY);
 		return RET_PF_RETRY;
 	}
 
@@ -4552,8 +4558,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	r = direct_map(vcpu, fault);
 
 out_unlock:
+	kvm_mmu_finish_page_fault(vcpu, fault, r);
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
 	return r;
 }
 
@@ -4641,8 +4647,8 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 	r = kvm_tdp_mmu_map(vcpu, fault);
 
 out_unlock:
+	kvm_mmu_finish_page_fault(vcpu, fault, r);
 	read_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
 	return r;
 }
 #endif
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index e1c2f098d9d5..b6897916c76b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -835,8 +835,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	r = FNAME(fetch)(vcpu, fault, &walker);
 
 out_unlock:
+	kvm_mmu_finish_page_fault(vcpu, fault, r);
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
 	return r;
 }
 
-- 
2.46.0.rc1.232.g9752f9e123-goog


