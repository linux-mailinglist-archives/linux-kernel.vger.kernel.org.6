Return-Path: <linux-kernel+bounces-357723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B279974BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E2DB299BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECE1E1A30;
	Wed,  9 Oct 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayEExf5E"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BE1E0DFC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497869; cv=none; b=TXOk4wYkjduEVzbig/IwlSuc3cpLV5XK8AYuNc84u8/deowXZMUvYuyhD9xLM9MkI41OpFHjY+r0hNdiNtURyHMd9/gY+xDaoZR0kecnCQQdknajV+pmyowMhieU3Om56gTKmRck3wiypvmUuISr8kmiELZeLe7x0cXsglaX0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497869; c=relaxed/simple;
	bh=DDLfj0TQYGwpLkFazEuQUvzdkQZmzTYxm2iRMOY43rw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wo/uQBV7WHqnNco+axSUmX1iNfIDmlbEmstfW2sPfYOk4HUUrXqnLXNvBdqAxTTiSBHj9n+UkmiHiT1hvWMRmLIi9FR5PrjxZDyH3ZbBnDMTKNFzZNe8Ts9FdCcoDus0lmi7AAYt82N4MUKQ2E3NGGYu5yPG6IQ/SKUaMVfUZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ayEExf5E; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e1e989aa2so130859b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728497868; x=1729102668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2G7TjtKE6sDpC5bp0OSd5cuEOohLepXkfXg2tU0SKoY=;
        b=ayEExf5E+PPxYZ2EqowrESiE9/vonl9bHhKnQBoxjec3o0VyRLXyaOOsFUwPAZsHYJ
         b/2jPIX6BYT333jrnU6VkXvgnjd4+SJgNE0RYNhZ7HQ4qnL7O/xk2nsXgBq68Qf6Gkg8
         WteyoVnOAMvHMUeWQkjvQTngcMwvW641zrHEEokZ9lpGxnlLnS1Kg7AxetmT2LtaqH8a
         sttL1cx3wu8ECYcv1O+E1f4zF1Qz14+yVv5drGd0BpdFCd4bSiZq/Dkoc/VrC1SJWIMJ
         2uyHfcpT2msm5FzM+8AxvBPc+SbU+MZ8dRgC1hlidiI9NX/2SqZAweIKdJZxz5vXq7bL
         9B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497868; x=1729102668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G7TjtKE6sDpC5bp0OSd5cuEOohLepXkfXg2tU0SKoY=;
        b=Q2x0IwW77hANvuoxMNuIHN2RYHmJbQvs5kWtUXhhL3GAfQOkMBQPF77Tym4ZCSIXQs
         K43T5jJlAlvywjiDLscDcf/yzSTM0kcZNGwklnBbyPC7MQppywRby34HNrAzALmK6gPQ
         lbFVRQk7E58f6+qVIrlon7KcKU9cTjP6CoCyLiPeSvYFNVDP17a1a2diS/ouvwqkwUJU
         ti8fMYbBx302ZOpRjt6cXt2PwcuUMXAPdBnb14/9hAwrWXmOr5LqTgKFpKdjvqYFvmm5
         SDu8zG5fR+MlRCqPCcU4Ajlv9lli9ZknXSVL4RQ2BWlvkAQhyDaBfFV2LJeBC3meRRI9
         kQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7C0w9P/EU6oJGGsxHp3Nu8lATjQP62eXaMuEySGOLe8CIWqZmMeUWK78gi5sfxqt+wVep/x0UA/3I1Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWp0jevWRJi23W/emiakL63syV/hRdZ/R6HyIpa/Yv4njqsuWx
	iLofq1M5kN+vnYBRxfFZ1ejMgVoSIBWd+Bi8Mq+QVmWnMgO9DGn77gOb4PDyjRvxLwAumE8v6CO
	uDA==
X-Google-Smtp-Source: AGHT+IEDBDcN5R3goI4UO9P1OG6J750Ofxm36RRfmx857Ihy1BrsZNT8kpRnKzVh5TGPa8Wq9gICpJyQfxA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3e0c:b0:71e:aa:eac9 with SMTP id
 d2e1a72fcca58-71e1db7352cmr6743b3a.2.1728497867481; Wed, 09 Oct 2024 11:17:47
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 11:17:36 -0700
In-Reply-To: <20241009181742.1128779-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009181742.1128779-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009181742.1128779-3-seanjc@google.com>
Subject: [PATCH 2/7] KVM: x86: Drop superfluous kvm_lapic_set_base() call when
 setting APIC state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that kvm_lapic_set_base() does nothing if the "new" APIC base MSR is
the same as the current value, drop the kvm_lapic_set_base() call in the
KVM_SET_LAPIC flow that passes in the current value, as it too does
nothing.

Note, the purpose of invoking kvm_lapic_set_base() was purely to set
apic->base_address (see commit 5dbc8f3fed0b ("KVM: use kvm_lapic_set_base()
to change apic_base")).  And there is no evidence that explicitly setting
apic->base_address in KVM_SET_LAPIC ever had any functional impact; even
in the original commit 96ad2cc61324 ("KVM: in-kernel LAPIC save and restore
support"), all flows that set apic_base also set apic->base_address to the
same address.  E.g. svm_create_vcpu() did open code a write to apic_base,

	svm->vcpu.apic_base = 0xfee00000 | MSR_IA32_APICBASE_ENABLE;

but it also called kvm_create_lapic() when irqchip_in_kernel() is true.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ffccd6e7e5c1..fe30f465611f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3072,7 +3072,6 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 
 	kvm_x86_call(apicv_pre_state_restore)(vcpu);
 
-	kvm_lapic_set_base(vcpu, vcpu->arch.apic_base);
 	/* set SPIV separately to get count of SW disabled APICs right */
 	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
 
-- 
2.47.0.rc1.288.g06298d1525-goog


