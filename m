Return-Path: <linux-kernel+bounces-263860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465393DB8D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35FB28688E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760917D347;
	Fri, 26 Jul 2024 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wdW9ZL3g"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F417BB20
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038007; cv=none; b=Hb3mg9sKfBA0HTtZCdOjVjuByim2UrUiBBbxPQ6eErd238nxs6x6//UTmBfTEWV8Hw5bFfynyh65nGr6qp9Q/Y3MrVnMELT8GNisWZpzP1t/rOpgTSi8FbLtuTks5Ao4BOgslG7pZAaLx2itEk72hA12H5Ue1LXXKg4aq+DLM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038007; c=relaxed/simple;
	bh=hTCJS839o2gRLTMMefhng3YEMkDWbv7HNmHQt1L2Wh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7SVhv0zp9P+txmvgNLVA+aJkab1uPbtQ1ybnioMbV+hvghmEei15WaLnZnYk6tDaPC7qyYvLcgbMYa4VdepQeCNlfaB2pCZvFmscd85ezcaTnT8HcupeL3OX1Xp3Duy7uZjUBsUEF3uNvpnkGqIDDfB6mRBSJycCXEYLKuAxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wdW9ZL3g; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b5296507eso434296276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722038005; x=1722642805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xlV4Qu7sFx9TmbqoV45yeLGjyM3cIO8KzptAxLEtfNk=;
        b=wdW9ZL3gef1d/Bn2y90XBdXSoI3mt8rx5Ebty0Vs51AUyh03zbJohgowbTiAEmwNFd
         AJ1DHrUwaCJG7pjqP7Y4Isouc2Ntq/zRUfC4HbWryGny3FFIIQ43O4IOJo4vDv+0/oFa
         BPjXWcm+2wqjvbDpS7XTJbbhAwia6Md5xdBa0VdDjHKvTxsDCSutFLf8twi5AYcNari5
         TYwWYS/rupun/ETbDvq0vgRlikOypL1tBmC42QgWiM8OLoIjQtGcApvMQQ0sFi7PrNK3
         uzs/QLxd90RrH/HcuHB3I4xkGx4shBUd/A8NbLr4rAxVuTzJPBTHwi+wOUMnTGMUGVpn
         CJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038005; x=1722642805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlV4Qu7sFx9TmbqoV45yeLGjyM3cIO8KzptAxLEtfNk=;
        b=ccQsZETqaJW6xffcjMSTZvFqRVP30fGQQs9KCmKNHeGgxULwJ+0UBW1QCPS6nGoQPW
         NXdlziu4Y9r0KW+cLuq5LBU5NGy8Np8weOzR62O79LVkvAMeVXRJU15FkKsZFdJZssL+
         xP9Dk9FUcma1bljwnbes07czvk52qKHcHRPTCF1yfg8a0HZeVhu2HemiuakFBu1fBHcH
         Zq96w4VGGTjYMcPedXhYpKydBLfvFYgwP3q04m5gCoKJEJcQT60ej04md3foInK2pvi7
         DAwdE845I+tNwAgI0vzvny7D/MRNiTA8cn6NUGlt8hIKRrYrPTRloP/VO9ZA4zszIURK
         U8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUcso1RuFPeRQV+6jrhPetJmhQb3Em6tn2YeVRmozGiaVO+BkimIIPBl6uuWYpflrNtPvvuJCnwzdIOjG3x+qwAPR5DJzcf/Bq1zXb1
X-Gm-Message-State: AOJu0YzQJ4xIDXJ3Jkcf9G/c+7Ta0Lyn1Ig8RWGQz9CNjIYTy8Jjmsst
	Hu/QqZpX3lCq7GH3gf22jGr/KH+fZ3xfyZWv2BSlvVsEQQbw6tE41f/T5X8CBr7BE+JkczXLyH6
	vxA==
X-Google-Smtp-Source: AGHT+IGzjee8SmO1Sa/b53YWKn3FsBJYizAY4tObHxd1ZNVi3RptE5IxRlqmItgGIGNjjqk15j+5giHmBC8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:8d2:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e0b5454c840mr15153276.10.1722038004800; Fri, 26 Jul 2024
 16:53:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jul 2024 16:51:32 -0700
In-Reply-To: <20240726235234.228822-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726235234.228822-24-seanjc@google.com>
Subject: [PATCH v12 23/84] KVM: nVMX: Add helper to put (unmap) vmcs12 pages
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

Add a helper to dedup unmapping the vmcs12 pages.  This will reduce the
amount of churn when a future patch refactors the kvm_vcpu_unmap() API.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 372d005e09e7..8d05d1d9f544 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -314,6 +314,21 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	vcpu->arch.regs_dirty = 0;
 }
 
+static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	/*
+	 * Unpin physical memory we referred to in the vmcs02.  The APIC access
+	 * page's backing page (yeah, confusing) shouldn't actually be accessed,
+	 * and if it is written, the contents are irrelevant.
+	 */
+	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map, false);
+	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
+	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
+	vmx->nested.pi_desc = NULL;
+}
+
 /*
  * Free whatever needs to be freed from vmx->nested when L1 goes down, or
  * just stops using VMX.
@@ -346,15 +361,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.cached_vmcs12 = NULL;
 	kfree(vmx->nested.cached_shadow_vmcs12);
 	vmx->nested.cached_shadow_vmcs12 = NULL;
-	/*
-	 * Unpin physical memory we referred to in the vmcs02.  The APIC access
-	 * page's backing page (yeah, confusing) shouldn't actually be accessed,
-	 * and if it is written, the contents are irrelevant.
-	 */
-	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map, false);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
-	vmx->nested.pi_desc = NULL;
+
+	nested_put_vmcs12_pages(vcpu);
 
 	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
 
@@ -4942,11 +4950,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		vmx_update_cpu_dirty_logging(vcpu);
 	}
 
-	/* Unpin physical memory we referred to in vmcs02 */
-	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map, false);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
-	vmx->nested.pi_desc = NULL;
+	nested_put_vmcs12_pages(vcpu);
 
 	if (vmx->nested.reload_vmcs01_apic_access_page) {
 		vmx->nested.reload_vmcs01_apic_access_page = false;
-- 
2.46.0.rc1.232.g9752f9e123-goog


