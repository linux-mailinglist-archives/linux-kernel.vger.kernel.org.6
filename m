Return-Path: <linux-kernel+bounces-185666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 357088CB89E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C777AB23AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80238DF2;
	Wed, 22 May 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbL6e8Aa"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010D29422
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716342028; cv=none; b=J5GKrLQoHdYuC2Xtf05YGO0wnn2XLHLk7p36Se7+yEbFMUFysPi82iMGXwOmxd3DDVef8rE+yVLtGBjr/TabEGmhkpOBNa3QdUbF/+V/VQ2yijMc4+h9yx1LWSB/0mh8ypY+oZTCzhPDMmFNiif6JBFvpuoe+NxF+e6kqmL6mZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716342028; c=relaxed/simple;
	bh=SxCNJ06vwtbyrQkZd4xB8bnO3JXPErYFa83rg1Usdig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksf9vBgLFO1UQ/y87eEhPt9cougTvRZ9m3EiXSVflulS4wsj7OWXkwsZZQGEnpJdP/6ptDRHn4nPunE4A0OVZPA/rJRic3ekF85tS3iXHh/ZA6bQ7gBtznB774JBo8//DiBmXI2A2lqi6XIT4Q7gnT6Sl6m1I9KYkukspiGhalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbL6e8Aa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4da80ce08so603544276.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716342025; x=1716946825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9/Jh3NT05cAP4Dr5P4AOID5+N71m8JBqExCgFsAlL8M=;
        b=HbL6e8AaswHNLiWKgo6se20VDshzgLLaTNIEN+U7UssI6ZsuxZEDTbfUqQQxQ4UDna
         irXn3F65FnI03N9WVpnBoPJLPWr1c8SZ3nplMBWABmwV/ZZoH8jlLZEgZeNm6YthcXMl
         fzGJQEoFKEgYnbfLkFI4I/aKUe2sdxyICOAxbYCjIg4yeSxBBFnswVO3hyCX1uFI5tRQ
         zDq9moeNogQDg3+7jND+UBZA+EYM7Fq9IHVj7kKGO29sWTpwsEgLbN5X0RY5VrwbzSxf
         S9cBu/NDD9LyWrTv83wn02X0cNIxMB6xPXkZ9RLMpVxaEMOdYsFYz2qoQsZDI2AnVz/V
         jtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716342025; x=1716946825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/Jh3NT05cAP4Dr5P4AOID5+N71m8JBqExCgFsAlL8M=;
        b=sxRxDMWC9wQesn3rI3J21jzTGB8lSmrBKmw0g7e5qtTBzrTJwYQDtxwyXDYc2kA5pT
         StePWEyVgbC8S2TMwopAAADDjLa8vYMw4rQtGyCCvT89pVM6/j0tJ+Z1qdk0z5XOk3sS
         8bs2JSoC2+D+nDCmSaYEcjlL433+wmVOY9oVwQGO8+k7RQnA9hWOjxZ2cE0IXjjFn72/
         XC7aDEtbN280lWxCw8EX7L8GfWBN+3MqdkQGPpr+3w6xl/g+2RXKms/ak3kn653LKBJj
         EQHfBqEiijSGubqysa6ORW/TI82Z/jlhIXIDM1wUzAt4poH5psbark2ZKKg8wwaYv5J6
         1sRA==
X-Forwarded-Encrypted: i=1; AJvYcCV3VKYWy3U+v37Ubm1kvIGIWAXuz2q4DqCbCRBaYfN668f7OjBkaOvTcxXRlP05Aef+JpK1slQ8Tl68kXcqtyC/+5P7RUedLbeyRDVd
X-Gm-Message-State: AOJu0YyzmJJ3V+whNd+HPSWAWV3Srccb6pWjnFnB3y2oDsnqLcBzzY8p
	S3S/LiratqFGvuckYBkyGvbm2DsLcJkIz5Q55HUOMgZQ42cxeTCGjq6P3yPRz7Z9PP42sSMhSjk
	9Ag==
X-Google-Smtp-Source: AGHT+IFb4ojjFIBjH/g1gqSAZtGdXjScECyPQCKxtonXS1wS1/Q6Sfuh8cMohHl5GHkfuJ7096x7AKNuxdo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100f:b0:dda:c4ec:7db5 with SMTP id
 3f1490d57ef6-df4e10405f6mr210549276.4.1716342025422; Tue, 21 May 2024
 18:40:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 21 May 2024 18:40:12 -0700
In-Reply-To: <20240522014013.1672962-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522014013.1672962-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240522014013.1672962-6-seanjc@google.com>
Subject: [PATCH v2 5/6] KVM: x86: Unconditionally set l1tf_flush_l1d during
 vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Always set l1tf_flush_l1d during kvm_arch_vcpu_load() instead of setting
it only when the vCPU is being scheduled back in.  The flag is processed
only when VM-Enter is imminent, and KVM obviously needs to load the vCPU
before VM-Enter, so attempting to precisely set l1tf_flush_l1d provides no
meaningful value.  I.e. the flag _will_ be set either way, it's simply a
matter of when.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 59aa772af755..60fea297f91f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5006,12 +5006,11 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
-	if (vcpu->scheduled_out) {
-		vcpu->arch.l1tf_flush_l1d = true;
-		if (pmu->version && unlikely(pmu->event_count)) {
-			pmu->need_cleanup = true;
-			kvm_make_request(KVM_REQ_PMU, vcpu);
-		}
+	vcpu->arch.l1tf_flush_l1d = true;
+
+	if (vcpu->scheduled_out && pmu->version && pmu->event_count) {
+		pmu->need_cleanup = true;
+		kvm_make_request(KVM_REQ_PMU, vcpu);
 	}
 
 	/* Address WBINVD may be executed by guest */
-- 
2.45.0.215.g3402c0e53f-goog


