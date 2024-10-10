Return-Path: <linux-kernel+bounces-359819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D985999126
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E961F25718
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55170210C26;
	Thu, 10 Oct 2024 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEyF0Eo2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E68210C23
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584843; cv=none; b=SgR9B5NvvoUyCg0AYai8+OIzbE1NqjXpcl9KtyWMRzfHdlRxt0QhEAn5naAR6ArV7yi8DNowAOH78W48lU+BJJefizqpJ8IR+f56UMDXhY58NHXQS8sDXyEAorr22o2SlAo1NgSbhTJus+bCTa+V2WBw/qLKsm8fFMA5eWHaNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584843; c=relaxed/simple;
	bh=TVe3szAAU/4RHYDireJVG9Y8gE1GRTl7yNXWTsweF6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ozn7fe+vSrxi3aI5HYUtBNJmzArnTRmS8JbbUeowwcIddUAo//ha21p/ZbOXpiPsq7FPWE4Jw+qAZ9AkjM+3A+DgDJJ7V8j+IfZ8eunoEwFGV5FDlTJpb/kpDrlpDQTfZVKqj1AoVdw0SsSDsuOtHM9y215VWHAK+x2qr1OczgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEyF0Eo2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6886cd07673so27462127b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584841; x=1729189641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KbunjaDKwfDzESX7bCyZnVXI4Jj60WAsli6cgjlK44o=;
        b=WEyF0Eo2XsJNPDFQCmldw4bvVns8foXPz6GhGq8QjDu8xJDPsgU2gDeg4tMkoGp7DG
         qpJiXq9ko9g1ZdHZfqLtcRYsvBPZ4zAKl/xQNiiKA25w/AQ8ybJ9Au1awx4vkn8oB+xt
         YHlrCluf/X2gZpoaDcL86BqHQoGLa8wJKT5byh7tuDXy8KhdxSaUh1uaieJMsHHoehat
         haDEfLKrjSNVFiwwnRXkhtFTP9jsOA1Q8XsG63RusobtgUY5tamyUlCGShrinJ6gi0cZ
         iOQEEssjZFClbHoFhivOJECpgHTXb0THhmZzFAYSyJ7PX3K8HOO54iWYJUfENuwbZtqd
         kRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584841; x=1729189641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbunjaDKwfDzESX7bCyZnVXI4Jj60WAsli6cgjlK44o=;
        b=rRLl7WqTcPtbsE6lt8t+cuwDcpeITeZ+BOFNQjZOw/Sz+B9umQrk4BfCHuzOpcBHnU
         CXNKwXzkQJhWGG6zcLmy/UNiUrB4Vs3mZ2NqzpuhjsYs5NklfXnPn5FDpfenp4HttZ1A
         8dofbUS2CPVv5VhymkgzUjHQzB0gXm3mfHFn6MasnFYHYaaTe7JMosKo7NNBLZBHyUlt
         ISwRpddTSXWB5CSA6jCDElQP25+4QKU5Nd9XxR3MArHvbmjA7RsE9VyL97TJ86JdE6rb
         emSqjO2/tU9dSuXtz/kOKUc+m0xr4qhJF4gwAf+CQJwsDr0GhwPUp8j8oh4zc36rOQND
         w/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2nCT7ma9uVP7wL2o4+VgIFEM8KcrnU/nFuJ1vOJ8F64Ywbdp4dN8cV3rNRjgD9OF7BuE6WobHyma021E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtbHg9CFK63yjaDq03+vum/q+m1R2e/D267gl6tPNN6ThHm6d
	ld6r4iZaKw7zJfx6gCsycU2YgUr0puD9FoiTE2YCXgn/j/WuSTbWUBTfKEBKZdoFpMtnJAOU+mk
	klw==
X-Google-Smtp-Source: AGHT+IEbamZE/KJDJ4kw63fZFZN0PThnG54xKd82AQ09AwFkx3KIodEPvEqsDBHZyT6DCHkY/GuTD4px7aQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:6c05:0:b0:e24:c3eb:ad03 with SMTP id
 3f1490d57ef6-e28fe540170mr1289276.10.1728584839383; Thu, 10 Oct 2024 11:27:19
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:24:12 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-71-seanjc@google.com>
Subject: [PATCH v13 70/85] KVM: MIPS: Mark "struct page" pfns accessed only in
 "slow" page fault path
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

Mark pages accessed only in the slow page fault path in order to remove
an unnecessary user of kvm_pfn_to_refcounted_page().  Marking pages
accessed in the primary MMU during KVM page fault handling isn't harmful,
but it's largely pointless and likely a waste of a cycles since the
primary MMU will call into KVM via mmu_notifiers when aging pages.  I.e.
KVM participates in a "pull" model, so there's no need to also "push"
updates.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/mips/kvm/mmu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 4da9ce4eb54d..f1e4b618ec6d 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -484,8 +484,6 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
 	struct kvm *kvm = vcpu->kvm;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	pte_t *ptep;
-	kvm_pfn_t pfn = 0;	/* silence bogus GCC warning */
-	bool pfn_valid = false;
 	int ret = 0;
 
 	spin_lock(&kvm->mmu_lock);
@@ -498,12 +496,9 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
 	}
 
 	/* Track access to pages marked old */
-	if (!pte_young(*ptep)) {
+	if (!pte_young(*ptep))
 		set_pte(ptep, pte_mkyoung(*ptep));
-		pfn = pte_pfn(*ptep);
-		pfn_valid = true;
-		/* call kvm_set_pfn_accessed() after unlock */
-	}
+
 	if (write_fault && !pte_dirty(*ptep)) {
 		if (!pte_write(*ptep)) {
 			ret = -EFAULT;
@@ -512,7 +507,6 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
 
 		/* Track dirtying of writeable pages */
 		set_pte(ptep, pte_mkdirty(*ptep));
-		pfn = pte_pfn(*ptep);
 		mark_page_dirty(kvm, gfn);
 	}
 
@@ -523,8 +517,6 @@ static int _kvm_mips_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
 
 out:
 	spin_unlock(&kvm->mmu_lock);
-	if (pfn_valid)
-		kvm_set_pfn_accessed(pfn);
 	return ret;
 }
 
-- 
2.47.0.rc1.288.g06298d1525-goog


