Return-Path: <linux-kernel+bounces-309600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF21966D50
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA92D1F2248D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF547F5B;
	Sat, 31 Aug 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x6Ud8f+Y"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224942077
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063366; cv=none; b=QSGS9ZVCUEh7BXxfhnZPr8OeinK9qfm3LCcKN5mx5p7mm1nx4Zo4lTG+B8FicqoXUXm1xnHkeo2N9k4Zh+rW52o5Rrac1vbq/Hw634r07bynvoXTUgqF+EcTCDqbWLeO2q+ioKmKb2XP8/Xp6i/ZDl7NdwO0ac9u9gpy9e2oUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063366; c=relaxed/simple;
	bh=0ugKPXm7f0Z9tkNBlydIBvCQhLXirirTmaxUHzxFYGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IPBPP2moioMe+mm1OdXIidjR1g0gw+lyxwHrAfOlBVzfM3IzLQ+rtt9zd6uSpqjld+2/9HxmUQyhtoXLdVSyTGaN4XDubfg1RxJ7LGobwi0z5g50dzoOls+mvgMBwkyNnScVCqnLn+XrShTI8BBqBcSX85qjE0CRHoqwE9fLU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x6Ud8f+Y; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-714290c2b34so2321098b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063365; x=1725668165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pFaEKpwsoQLgtn+xPOU/nmb2rgY2BlrNEgxoYJSjng0=;
        b=x6Ud8f+YfiNAppvZWkbOoTh7yNRBp/eZpMnrRSdIR8mbBUeHPL2tUDE41RtBZRqTKk
         2m4wZj4k0gWHDEMvAE+rD2Rx9ihFFJTKoO8hEsteWIAfQxbwquLVysdznBoBIPKl9XIq
         7AD9/vT/9fTg3Xp8nrZiAF5gn9l0djEkeAK9zf7xodZd8QZkgvFqhzqyFf+DnG4Q5Jn7
         Y8c4j1tx0T96EHILB77ySJgUKmMX2BMjWp0cKLpM7DyAF4+WWZM5cp4JSjNSp7nqf7Ph
         f9vIieuWR7y/+fP3h185SmIir8jt4SmGf52ctXsCU2ywgmxW0/8+ALa+BsIskzn3jBtH
         A+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063365; x=1725668165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFaEKpwsoQLgtn+xPOU/nmb2rgY2BlrNEgxoYJSjng0=;
        b=AcsOg+9KYP6PfRQGjKH9oS0C8EQU2t4+oJ+mYuHUOu8V5bExHJzpVLjtXPin2m3T1Z
         y+Mwx29jDtGvdCdtUNyygLLhrZ8Ht4A7Q4ZfQzZKfle/whZgSrwJqCFuqkHkNFG5Qamh
         Kpq6z4kP0pTUnp5725yfTs8UlL+A05YYUepCXN5z2UVmb2zUq9UvkLDusY/cYoGBkYy8
         7VOKpsMfsmVP9N1ggVRk4QFjkC4+GRlmRX0yX1GGE9KHkLekGEu7wOqaABPwrUnIMyoB
         86AisfWuaqkzGFvC0JPqEtOO9zQhuz6zpO+3nzbw4JZYj8j+2bDuBm5KcgLBzJFYIaQg
         Yp2w==
X-Forwarded-Encrypted: i=1; AJvYcCVdTGz0KRGvSMcj5bEaSCCbw+3z/c6JOizULVpvvtmp39vdlkGyWCsEiYopWl5aGXw6O8vNykPQiiY8qzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LOQcdAcjbWiHMJrkX4/1fTwR2O10603dr4kca/ooB8QimmcG
	Ks/aEZaalW6B4ZIOvNeA9/GEzdEXnJU1OgKvWHBMTkqgxt/2XLCeV7BqtMy+A2aXVGBf/Chqh2B
	i0Q==
X-Google-Smtp-Source: AGHT+IHeayohZ8P9bTfkvLJWiAXof8KEhjPXfE8aDRqDE3XirEUvuRZ9MRzo1AWngrkQZ4frV2qYEdsDGQ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:870f:b0:714:37ca:ed6e with SMTP id
 d2e1a72fcca58-715e104ad90mr24129b3a.3.1725063364507; Fri, 30 Aug 2024
 17:16:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:27 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-13-seanjc@google.com>
Subject: [PATCH v2 12/22] KVM: x86/mmu: Don't try to unprotect an INVALID_GPA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

If getting the gpa for a gva fails, e.g. because the gva isn't mapped in
the guest page tables, don't try to unprotect the invalid gfn.  This is
mostly a performance fix (avoids unnecessarily taking mmu_lock), as
for_each_gfn_valid_sp_with_gptes() won't explode on garbage input, it's
simply pointless.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dd62bd1e7657..ee288f8370de 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2729,8 +2729,11 @@ bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa)
 	if (!READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
 		return false;
 
-	if (!vcpu->arch.mmu->root_role.direct)
+	if (!vcpu->arch.mmu->root_role.direct) {
 		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
+		if (gpa == INVALID_GPA)
+			return false;
+	}
 
 	r = kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
 	if (r) {
@@ -2749,6 +2752,8 @@ static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
 		return 0;
 
 	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
+	if (gpa == INVALID_GPA)
+		return 0;
 
 	r = kvm_mmu_unprotect_page(vcpu->kvm, gpa >> PAGE_SHIFT);
 
-- 
2.46.0.469.g59c65b2a67-goog


