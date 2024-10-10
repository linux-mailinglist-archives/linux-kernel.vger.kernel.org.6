Return-Path: <linux-kernel+bounces-359810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830B99910A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C9F1F2242C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0420A5EA;
	Thu, 10 Oct 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STJqucsL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E52209F55
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584824; cv=none; b=da56Sc9CpjQhAaq2jQtZ5g+AdpFkc/F7/gj0hIdtgdS1LwTD59WsYL2OTRtVTzIQk+JmkTemUNqVYsymvFTJ15Ex/snv3vExVGRrWHGfm2dD25Ut2jlnq4+u6a700IcOKfCde9Ik4EY6ZvjPiNCRsZxVmfbYBMv4NeU0fQR3muY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584824; c=relaxed/simple;
	bh=fHLEjIjpsClQjytVJZuAJLLMS5Q01wz8isn/MOvrB+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAEw2cGJ6qmCAvJEPCvmPtGilQ+k8fiMALFJeNSQSb6sav5lHjtWLfotv3zPaumUXbNholBjh5bqoJQ+YmzfwsNSPklNwY4Up3hoQC43kjCRmYcx0vNgT2TwUsCvucMnWitNfQBwWMIqWepjY091jp+W5X0Y83RrC0uBdu3WRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STJqucsL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so2139792276.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584822; x=1729189622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YGpJ+GsXH4oG8p6vIrNjfshF8svSSAFECmaA34wp4no=;
        b=STJqucsL1kdpv+t2aaRSW8Dsd/k9W8Xwx0z/3KChOk2f7SqOVYc8Fpu9FgNXp5fiLv
         U2zVArrxm+zFzt6S1ZnESa2Fakw84zykbu9yrPyt4txY5HGwhVwXFA7Q0M1ej5kOsfTF
         cOdyNhQsGU94JfmwxOT9eZyARvp1cSidtXQIDBSmdrHrJCdXoEDgKL9knbEsHRoX8+Q7
         x+Vw3mSWTwWjREDYZH57XAFRL/3RValbk71y72Jep2YJ1nJzbIRF8212ST78cHKuXiCE
         RyAFsegZWGTdL8tf6s6VHlUs9C4I+kaJpsg8j16L/FE68+XPw0gkSDLsBwjx5xn1Kv6y
         vMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584822; x=1729189622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGpJ+GsXH4oG8p6vIrNjfshF8svSSAFECmaA34wp4no=;
        b=fXOGZvPGG1WK5TzHhYkEyBF69uEcbJAxBV4yBYn5u7DcMnNzuJNJH7MkyjK6OTRqRE
         ll0vJMNZUeLtbwJWQDliw3npZnNpv8oEecnSJ5vRizE6eZZzcODUEUGTw6Q7vVhkim5i
         1YF4NKTxalw4IxDLEraZJ5GYKO5fu5AneoewW9TjwS0Z/W95BprBeynQCDr0f2+DClDi
         M/tA7oHw8iJpC1ClhWZVPWr7eO/TRT9QXdrKOl6Xvy2Ys6HpwZesMKGfdFfO5ajhmtSS
         pe5piYKzEP25Amub4QAUp9m2w0G6Z/oFHTJZlFdvdiBnthhDoguJtU9jRF4AdI9PGRG6
         iiIg==
X-Forwarded-Encrypted: i=1; AJvYcCWM/ii0Nq53JqbL+jqAaAVgy4cVVhv1FHpJl268gWQ7vTsiJ8RXK2OyNDyA1VWVj+pVke7KOOQ8fPHAn74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLy5A/ZwNeRxmETxhQkZ/R6d8xEcMG2vvbNmgYB6B2H4ULtbBW
	g/1ConXN4fT2Uihx+uXg7Ntx0Hde98aJhnJccJaKjo3wsyOABwcUewkHPqQbCVjWaNdw2BK51nJ
	2yg==
X-Google-Smtp-Source: AGHT+IFyzgxXPfejJoY0SZCQ3T+Vo8hzb1HJlB5l94FFDfZID39IeT9MHN/ZgR4beqIvxQ/gO8qC3c4Qafk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4ac:b0:e28:fdfc:b788 with SMTP id
 3f1490d57ef6-e28fe4426b8mr4979276.9.1728584821558; Thu, 10 Oct 2024 11:27:01
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:24:03 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-62-seanjc@google.com>
Subject: [PATCH v13 61/85] KVM: PPC: Use __kvm_faultin_pfn() to handle page
 faults on Book3s Radix
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

Replace Book3s Radix's homebrewed (read: copy+pasted) fault-in logic with
__kvm_faultin_pfn(), which functionally does pretty much the exact same
thing.

Note, when the code was written, KVM indeed didn't do fast GUP without
"!atomic && !async", but that has long since changed (KVM tries fast GUP
for all writable mappings).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 29 +++++---------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 8304b6f8fe45..14891d0a3b73 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -829,40 +829,21 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 	unsigned long mmu_seq;
 	unsigned long hva, gfn = gpa >> PAGE_SHIFT;
 	bool upgrade_write = false;
-	bool *upgrade_p = &upgrade_write;
 	pte_t pte, *ptep;
 	unsigned int shift, level;
 	int ret;
 	bool large_enable;
+	kvm_pfn_t pfn;
 
 	/* used to check for invalidations in progress */
 	mmu_seq = kvm->mmu_invalidate_seq;
 	smp_rmb();
 
-	/*
-	 * Do a fast check first, since __gfn_to_pfn_memslot doesn't
-	 * do it with !atomic && !async, which is how we call it.
-	 * We always ask for write permission since the common case
-	 * is that the page is writable.
-	 */
 	hva = gfn_to_hva_memslot(memslot, gfn);
-	if (!kvm_ro && get_user_page_fast_only(hva, FOLL_WRITE, &page)) {
-		upgrade_write = true;
-	} else {
-		unsigned long pfn;
-
-		/* Call KVM generic code to do the slow-path check */
-		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
-					   writing, upgrade_p);
-		if (is_error_noslot_pfn(pfn))
-			return -EFAULT;
-		page = NULL;
-		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-			if (PageReserved(page))
-				page = NULL;
-		}
-	}
+	pfn = __kvm_faultin_pfn(memslot, gfn, writing ? FOLL_WRITE : 0,
+				&upgrade_write, &page);
+	if (is_error_noslot_pfn(pfn))
+		return -EFAULT;
 
 	/*
 	 * Read the PTE from the process' radix tree and use that
-- 
2.47.0.rc1.288.g06298d1525-goog


