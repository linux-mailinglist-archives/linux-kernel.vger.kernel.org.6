Return-Path: <linux-kernel+bounces-359751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A95999010
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB581C24D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83F1CEEAB;
	Thu, 10 Oct 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDkmO6HR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8D1E490B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584709; cv=none; b=YB92T3JFAPogJtJEhL7upiPGH/4GQWrGU3IEtwStaIzVzcL/4lW7FS1hcrFeTmMGhCKUgjmXe+HPfBD8QmigFkZ4teGzlXz+c1RFGvVq8ziKLXrX+/haYHPLugLvtCee08NI7vZG6k+bFNyDpECS8Hpq4zONy4MfCBJbCZ262Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584709; c=relaxed/simple;
	bh=zZ6qnR3p2Ej0Et0EkgjdDF1APVKDfMggaSwqeFMbAB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s7gTXsV6tlu8MsBR1ho/V/tXfIAMVmQfFzV9/EJen1Pu/MkTFYCdmPkcMxTVVES+8o/F7LfjmQbEbCMF0/o0MkrB0KCjsBrI1pnfT0ls7TqrsZhyjWsXSO/MfZZdRIgwCn926s3JGPyS5fESklqkJgtelb/+riVfiDS4oTYhB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDkmO6HR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e295559c37so1096521a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584707; x=1729189507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GZoCfd92gqYHwqsSYOai9KQfQ7K6dxh+JWKccmiJTPU=;
        b=IDkmO6HRVmabgOlLjqCh29oQFT1bfBQbkp3F1tpeC5Cl5RH4yKJjEzu/fRdCPtY2LJ
         8alxmLe/e6YwD8u37nx2cwxVWQGc05WHH8rhdocEO3m0ZILY2McAVy6C7ivAMxZD63lA
         5rm83irlLcGgCTPE12ygB+5N8x12ZhG5hm21exX/zmXXDmPJm1UnrJS16qHVBYfIHr2O
         AobpACM+F+Sg7RjUSd+L/3V/uhbi11gyOc4mNHGNjscaAcXfUW6mW3Qzc8IqRRoIOJrz
         mQEaeoC3Oe07Txd1htL8K8SnhqjKEfbT3WNRYv4Ca+fTxlJk2zb0kfgWcERlJ9Sm7PG8
         lEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584707; x=1729189507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZoCfd92gqYHwqsSYOai9KQfQ7K6dxh+JWKccmiJTPU=;
        b=WFOGAnuQbfTHF1kh4ikIH2+c0wGKjiMxMpmSwX5E+TTgzHlj6rOO4FpvTZDQTWzGIH
         uXu4Zs30j8pgrWk2118BBghHGP4RpaBJdPttMbJKDrqfFEzSifVqUUXVhBKvoy2VPmMg
         5ASxBmqFZUR1I/qGImBA8yQY3tcuAOTOTVdlYLzDlEsIk9o/ANt0FAxYjIbpIdqRIRHp
         JOOUx9JaP3JSppvWcA57uP/vy/oLYl2+171zLyTXfWIdkg0xi1WRpB062gFKaQZQXQY8
         YZtdtaYNBfMLyHaA5HyrLOJQmKJwVJ8fHb7NggSuOdc5hu6y29uVEEuw8Bz3HH1Uc+iV
         FUXw==
X-Forwarded-Encrypted: i=1; AJvYcCUI8KD55XIHSwolEtnP9zgFwHBGMW8cX1WzEKH/TM0zhuNQyxSAN/DLKx+vj3S7j3yxqVCuw/dy67e+1yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1o+bUYtZFz7MhoLFqQEZPpQwJYm2MYXiXhu51doeRl0ihDaXW
	sI63fhwlIr/i8dITQpBpXTLoJSd8IRnC4IW+ItUr9W6nWaKj4bmG3zuCQVK3ZWmBglF1cDAyuM2
	PrA==
X-Google-Smtp-Source: AGHT+IH8UDk7ruln14ZDsSWqbj1uDcx7028dIle1wpc1As3ec3XNWN4cizl8I1jAsp9rsgJdiTjtCNc1iNw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fa84:b0:2e2:da81:40c6 with SMTP id
 98e67ed59e1d1-2e2f0a524d4mr44a91.2.1728584705592; Thu, 10 Oct 2024 11:25:05
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:09 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-8-seanjc@google.com>
Subject: [PATCH v13 07/85] KVM: x86/mmu: Mark new SPTE as Accessed when
 synchronizing existing SPTE
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

Set the Accessed bit when making a "new" SPTE during SPTE synchronization,
as _clearing_ the Accessed bit is counter-productive, and even if the
Accessed bit wasn't set in the old SPTE, odds are very good the guest will
access the page in the near future, as the most common case where KVM
synchronizes a shadow-present SPTE is when the guest is making the gPTE
read-only for Copy-on-Write (CoW).

Preserving the Accessed bit will allow dropping the logic that propagates
the Accessed bit to the underlying struct page when overwriting an existing
SPTE, without undue risk of regressing page aging.

Note, KVM's current behavior is very deliberate, as SPTE synchronization
was the only "speculative" access type as of commit 947da5383069 ("KVM:
MMU: Set the accessed bit on non-speculative shadow ptes").

But, much has changed since 2008, and more changes are on the horizon.
Spurious clearing of the Accessed (and Dirty) was mitigated by commit
e6722d9211b2 ("KVM: x86/mmu: Reduce the update to the spte in
FNAME(sync_spte)"), which changed FNAME(sync_spte) to only overwrite SPTEs
if the protections are actually changing.  I.e. KVM is already preserving
Accessed information for SPTEs that aren't dropping protections.

And with the aforementioned future change to NOT mark the page/folio as
accessed, KVM's SPTEs will become the "source of truth" so to speak, in
which case clearing the Accessed bit outside of page aging becomes very
undesirable.

Suggested-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 0e47fea1a2d9..618059b30b8b 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -178,7 +178,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		spte |= SPTE_TDP_AD_WRPROT_ONLY;
 
 	spte |= shadow_present_mask;
-	if (!prefetch)
+	if (!prefetch || synchronizing)
 		spte |= spte_shadow_accessed_mask(spte);
 
 	/*
@@ -259,7 +259,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		spte |= spte_shadow_dirty_mask(spte);
 
 out:
-	if (prefetch)
+	if (prefetch && !synchronizing)
 		spte = mark_spte_for_access_track(spte);
 
 	WARN_ONCE(is_rsvd_spte(&vcpu->arch.mmu->shadow_zero_check, spte, level),
-- 
2.47.0.rc1.288.g06298d1525-goog


