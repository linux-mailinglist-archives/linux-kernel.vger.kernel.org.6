Return-Path: <linux-kernel+bounces-395884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA249BC471
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F58281FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F91B3928;
	Tue,  5 Nov 2024 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PpPotR1"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCF29D05
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782463; cv=none; b=MnFDbyJhRhuftAi4uY3wjzyfl8cdHWaEJkBi8/AVWWJEPIjRxxvWGcAOs88Ywn8PVQrlQurgG5Sp03mGRVGNhLiFEKLzHnd6zbzxrpLYyNuGe0LnpwCfo4vTOVxIy85D2anlcn5f541GQH1V9d3O2K5OdQT3YDeB/WEutTEwqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782463; c=relaxed/simple;
	bh=sa5u36kVEuWP8p7zcYfL7g+MYf/Q1YzLHNWBiknbHC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bt3jI6fwF1cx3yqs1jgu1ss9DJnK7Dw75fDCm0YxGocM9AK1k6I+YLtDoTtuIKi3vVFBUn7sbe2slaLZNs6EaHR29VTYh307b2wz47AEaaFtTmgHI12gO+vx6u+HH6Zzu8NwbfKTNISFqUuMpy1rRRckrRbHWYkf44n3/Ke5qtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PpPotR1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7f3d8081c5cso1329208a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 20:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730782461; x=1731387261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ8oqOdF80DzKJNpPyXZRSrJbMTHHUmvfCmvacNZPBM=;
        b=4PpPotR1hi2veqdHVopgufoGbgvc7wa4HeW2mL1/KOKvPaxuGWAxG9CrmW+CQoBhTF
         Xs2pyjb9FkAnBr07KGM4KcOuhOk+8PodeIGlJPKLJ/zrjZL2LR3QaCuiFvrdVmLSPtjo
         NMZACr/vQq7ndeNU7JeblLiKbFvnO6oz6nrYy9KDiHZAVh/HGfyKZvZnosqnx8MMxIfl
         tVoiRqXnSm3eBPld1/q03f+YpLstsQLchoRZc5GxdEyhv7RqaZYadGjEmJRDrWRBjV6J
         GVntAG0urLvvF5CTLpgrO4F3d2g6CUwx9DFCPncdEBS2NEuIHfiyQ35m7JtOyUESGqDg
         OLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730782461; x=1731387261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ8oqOdF80DzKJNpPyXZRSrJbMTHHUmvfCmvacNZPBM=;
        b=Xb8DePQh3fkQf8nyeabO+GCC9namPsxkfWs5TovrxJ6OhZ5i02thYqvJl0JUtjnnmX
         GPBwdjIwoYho2l4+pWIASnfthOnJvjR5IxnwpHCJWeNGr3BWfMmV2/NHNwM4w+BqXjPc
         DsXz5FgTOkXdj6JFhCdS4H9OZpjjfya5ZSfYDhYYa6M/k83pCnzcHj7XOMZywS0X9vqL
         uhRQKL2TZagtlN8Mx5rjr7qls0Quk54nI4wFXgMcyNUF80NvAjQjqvaiUZxzdByUvV+N
         s2IMtRc6hY34a2YsxW+LMs2oZnYkSnM2a+2aLVwGvVtFejcPDJ8aTPf2IJfJLIjDMmc0
         9Zbw==
X-Forwarded-Encrypted: i=1; AJvYcCV/fUeTHTJgpAJuOIIcI8t7bcqRrac8KSmNJQa7dSwLm+ynZVaqapi1OorQUnZsye+56n+9XIMhFp3S4Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jYBgW4RIteoZg015RdwNMmivbKpX0l60653VsDDZD7x/3aX5
	eASxf9T+Lz3lcb9xTQlBG1TaOHpNFyRh6tVWubW8i9tonjdNC28jgaWGik/FmeqpQ9TQ/EzYW8+
	Qsg==
X-Google-Smtp-Source: AGHT+IFmJXJc0gcY9bqqaeHzAKiJM4Ch3Ys6g2m+H6Cm/I8d/cnQQJkswDmSRDQq7HUeL+JuLNhhHERxTkg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2b85:b0:2e2:b937:eeb0 with SMTP id
 98e67ed59e1d1-2e93e0b7b65mr48491a91.2.1730782461403; Mon, 04 Nov 2024
 20:54:21 -0800 (PST)
Date: Mon, 4 Nov 2024 20:54:20 -0800
In-Reply-To: <20241101193532.1817004-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101193532.1817004-1-seanjc@google.com>
Message-ID: <Zymk_EaHkk7FPqru@google.com>
Subject: Re: [PATCH] KVM: x86: Update irr_pending when setting APIC state with
 APICv disabled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yong He <zhuangel570@gmail.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

+Maxim

On Fri, Nov 01, 2024, Sean Christopherson wrote:
> Explicitly set apic->irr_pending after stuffing the vIRR when userspace
> sets APIC state and APICv is disabled, otherwise KVM will skip scanning
> the vIRR in subsequent calls to apic_find_highest_irr(), and ultimately
> fail to inject the interrupt until another interrupt happens to be added
> to the vIRR.
> 
> Only the APICv-disabled case is flawed, as KVM forces apic->irr_pending to
> be true if APICv is enabled, because not all vIRR updates will be visible
> to KVM.
> 
> Note, irr_pending is intentionally not updated in kvm_apic_update_apicv(),
> because when APICv is being inhibited/disabled, KVM needs to keep the flag
> set until the next emulated EOI so that KVM will correctly handle any
> in-flight updates to the vIRR from hardware.  But when setting APIC state,
> neither the VM nor the VMM can assume specific ordering between an update
> from hardware and overwriting all state in kvm_apic_set_state(), thus KVM
> can safely clear irr_pending if the vIRR is empty.
> 
> Reported-by: Yong He <zhuangel570@gmail.com>
> Closes: https://lkml.kernel.org/r/20241023124527.1092810-1-alexyonghe%40tencent.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/lapic.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 65412640cfc7..deb73aea2c06 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -3086,6 +3086,15 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>  		kvm_x86_call(hwapic_irr_update)(vcpu,
>  						apic_find_highest_irr(apic));
>  		kvm_x86_call(hwapic_isr_update)(apic_find_highest_isr(apic));
> +	} else {
> +		/*
> +		 * Note, kvm_apic_update_apicv() is responsible for updating
> +		 * isr_count and highest_isr_cache.  irr_pending is somewhat
> +		 * special because it mustn't be cleared when APICv is disabled
> +		 * at runtime, and only state restore can cause an IRR bit to
> +		 * be set without also refreshing irr_pending.
> +		 */
> +		apic->irr_pending = apic_search_irr(apic) != -1;

I did a bit more archaeology in order to give this a Fixes tag (and a Cc: stable),
and found two interesting evolutions of this code.

The bug was introduced by commit 755c2bf87860 ("KVM: x86: lapic: don't touch
irr_pending in kvm_apic_update_apicv when inhibiting it"), which as the shortlog
suggests, deleted code that update irr_pending.

Before that commit, kvm_apic_update_apicv() did more or less what I am proposing
here, with the obvious difference that the proposed fix is specific to
kvm_lapic_reset().

        struct kvm_lapic *apic = vcpu->arch.apic;

        if (vcpu->arch.apicv_active) {
                /* irr_pending is always true when apicv is activated. */
                apic->irr_pending = true;
                apic->isr_count = 1;
        } else {
                apic->irr_pending = (apic_search_irr(apic) != -1);
                apic->isr_count = count_vectors(apic->regs + APIC_ISR);
        }

And _that_ bug (clearing irr_pending) was introduced by commit b26a695a1d78 ("kvm:
lapic: Introduce APICv update helper function").  Prior to 97a71c444a14, KVM
unconditionally set irr_pending to true in kvm_apic_set_state(), i.e. assumed
that the new virtual APIC state could have a pending IRQ (which isn't a terrible
assumption.

Furthermore, in addition to introducing this issue, commit 755c2bf87860 also
papered over the underlying bug: KVM doesn't ensure CPUs and devices see APICv
as disabled prior to searching the IRR.  Waiting until KVM emulates EOI to update
irr_pending works because KVM won't emulate EOI until after refresh_apicv_exec_ctrl(),
and because there are plenty of memory barries in between, but leaving irr_pending
set is basically hacking around bad ordering, which I _think_ can be fixed by:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83fe0a78146f..85d330b56c7e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10548,8 +10548,8 @@ void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
                goto out;
 
        apic->apicv_active = activate;
-       kvm_apic_update_apicv(vcpu);
        kvm_x86_call(refresh_apicv_exec_ctrl)(vcpu);
+       kvm_apic_update_apicv(vcpu);
 
        /*
         * When APICv gets disabled, we may still have injected interrupts

So, while searching the IRR is technically sufficient to fix the bug, I'm leaning
*very* strongly torward fixing this bug by unconditionally setting irr_pending
to true in kvm_apic_update_apicv(), with a FIXME to call out what KVM should be
doing.  And then address that FIXME in a future series (I have a rather massive
pile of fixes and cleanups that are closely related, so there will be ample
opportunity).

From: Sean Christopherson <seanjc@google.com>
Date: Fri, 1 Nov 2024 12:35:32 -0700
Subject: [PATCH] KVM: x86: Unconditionally set irr_pending when updating APICv
 state

TODO: writeme

Fixes: 755c2bf87860 ("KVM: x86: lapic: don't touch irr_pending in kvm_apic_update_apicv when inhibiting it")
Cc: stable@vger.kernel.org
Reported-by: Yong He <zhuangel570@gmail.com>
Closes: https://lkml.kernel.org/r/20241023124527.1092810-1-alexyonghe%40tencent.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 2098dc689088..95c6beb8ce27 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2629,19 +2629,26 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
-	if (apic->apicv_active) {
-		/* irr_pending is always true when apicv is activated. */
-		apic->irr_pending = true;
+	/*
+	 * When APICv is enabled, KVM must always search the IRR for a pending
+	 * IRQ, as other vCPUs and devices can set IRR bits even if the vCPU
+	 * isn't running.  If APICv is disabled, KVM _should_ search the IRR
+	 * for a pending IRQ.  But KVM currently doesn't ensure *all* hardware,
+	 * e.g. CPUs and IOMMUs, has seen the change in state, i.e. searching
+	 * the IRR at this time could race with IRQ delivery from hardware that
+	 * still sees APICv as being enabled.
+	 *
+	 * FIXME: Ensure other vCPUs and devices observe the change in APICv
+	 *        state prior to updating KVM's metadata caches, so that KVM
+	 *        can safely search the IRR and set irr_pending accordingly.
+	 */
+	apic->irr_pending = true;
+
+	if (apic->apicv_active)
 		apic->isr_count = 1;
-	} else {
-		/*
-		 * Don't clear irr_pending, searching the IRR can race with
-		 * updates from the CPU as APICv is still active from hardware's
-		 * perspective.  The flag will be cleared as appropriate when
-		 * KVM injects the interrupt.
-		 */
+	else
 		apic->isr_count = count_vectors(apic->regs + APIC_ISR);
-	}
+
 	apic->highest_isr_cache = -1;
 }
 

base-commit: 8fe4fefefa1b9ea01557d454699c20fdf709e890
-- 

