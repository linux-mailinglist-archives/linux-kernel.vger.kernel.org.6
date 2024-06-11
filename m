Return-Path: <linux-kernel+bounces-209126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13B902DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008FB286EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5984685;
	Tue, 11 Jun 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbGz/tM1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69EF803
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065522; cv=none; b=G5VUX3vpAr6hJeI1jcSPF3J/qLh1Wjnsx83NYfwaiR4qk18nznP7bQWg4NIxF+cMq3/LHKEFDVlta3wUxB6o+DQaDcROo0ba7gBYZnecxgyUFvOTeLj4Cn8E9J5IyFXSqakpbTzsP0u+APY5LE0Hkb61erdKo0lv/zDCDfvX7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065522; c=relaxed/simple;
	bh=d/d24Q+bKflu/5KknlLC2AysJ0+0I010aCt6LldaGog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XEKgfwRpKdLaD6f5OrQUtNHuiraFV7gcDZkpfYUdaLviT5JYLebxeoRtUtaGDOQAGJVEW7ddRKMnAOVQAIk5YqfaX/0RcVXTGnoyyBPLS0Dk9hMnKR+oDCg4Ll54nKgyp86Vrilk+wzmcwhnefedYwzRv47kvrSqfb5rAwW4iSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbGz/tM1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f302bf0c29so2258255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718065520; x=1718670320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrt7AhbsIsUqdkPpJZ1teyo5eS78zKqQ5MPohGwfyvo=;
        b=cbGz/tM16ySAvUjh4zEHSrAzkllFXOmuoPc97gcdPzymmJ2oJ2QHpjEMP7z/Vjefnv
         zrMEEy+5SKkNf9bxtQhy5ZcdjGltZNZCYFhdbT+SOQIy2XAgJNAQlcVYh59mbpACRV2z
         hhBC2wC3tlKFSOBi+argUuxbcuzjmGDihQpilnbosEYqSDjzig5QVr3tKUkct/jd6Jkn
         Q0lVzwOfk+E0T68caA7uyepWAmal79IryErvR4oq6/o4R8usRdSfe+J2RVlPt5cXNuKx
         lb6YpocoTAHUISLaHj5wBQhY3W2puRZswwXpi3XS5XQqSA6mu1JWPc5ZX6i0KaAC1hX2
         0ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718065520; x=1718670320;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrt7AhbsIsUqdkPpJZ1teyo5eS78zKqQ5MPohGwfyvo=;
        b=sHXvWuVp1W8sRsF91A7T08KlMgvlA2MDoeDVdwv6rYMhkf7dHiFx2zbrTJoHJt0786
         iFQKNWb6N1LQLZdGwhn9POze4F7rWKJS57wosERP+YOMYjSrf7n2DNcU2aVxTuNDk+5c
         s3zBdfMAiU8VqFJI7jhPamFsP+6eL2bc+Eqlm4dMm4pEOcsV0TC0M4aoOHqKtTIA6ZPt
         r0uiMdlnSpCHhA59aRGsUkZtm1nM5sB1TFcD2JvUelV3NYe2Dsz8YlViFspbMl9N1/Je
         BACaK+5BW9De8ERjU8NuoGb1jv/QCpzr/n75fRvgLlB78MzNt8LWmzqNzwduwUCWwaPo
         Ptpg==
X-Forwarded-Encrypted: i=1; AJvYcCUrbQz1iblB9omWi4S2M8CB5O4LhvgoSaFYBTzVnHTTki1nzi8WOKTHLPIRKwUds+BOByTyYEfEvjq+SqeGpWu4aVRq3vxZv1qPPd5d
X-Gm-Message-State: AOJu0YxNr5qui3fSZlhfo/GAGoArRnXYxEAHFj6qN9FBWrYySHfOdF+J
	Q4iczPu26ya9uDQwOGOeExxKyaCDSGgEN4qnYmQQsLPzyfIwOTJDunYrJYqk3FttIsCjO7Gugn/
	JFg==
X-Google-Smtp-Source: AGHT+IHw15VEd2fI2ET4qDFfYuR30QBuRtZZl+K+LtLQ9K4rIpLTLkfMOAS/jPAtUU6ahBoYko3TFIFagxs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2303:b0:1f7:13db:527c with SMTP id
 d9443c01a7336-1f713db5318mr113075ad.3.1718065519479; Mon, 10 Jun 2024
 17:25:19 -0700 (PDT)
Date: Mon, 10 Jun 2024 17:25:18 -0700
In-Reply-To: <20240506101751.3145407-3-foxywang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506101751.3145407-1-foxywang@tencent.com> <20240506101751.3145407-3-foxywang@tencent.com>
Message-ID: <ZmeZbjFi5FWxv-Mb@google.com>
Subject: Re: [v5 2/3] KVM: x86: don't setup empty irq routing when KVM_CAP_SPLIT_IRQCHIP
From: Sean Christopherson <seanjc@google.com>
To: Yi Wang <up2wing@gmail.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wanpengli@tencent.com, 
	foxywang@tencent.com, oliver.upton@linux.dev, maz@kernel.org, 
	anup@brainfault.org, atishp@atishpatra.org, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, weijiang.yang@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024, Yi Wang wrote:
> From: Yi Wang <foxywang@tencent.com>
>=20
> We found that it may cost more than 20 milliseconds very accidentally
> to enable cap of KVM_CAP_SPLIT_IRQCHIP on a host which has many vms
> already.
>=20
> The reason is that when vmm(qemu/CloudHypervisor) invokes
> KVM_CAP_SPLIT_IRQCHIP kvm will call synchronize_srcu_expedited() and
> might_sleep and kworker of srcu may cost some delay during this period.
>=20
> As we have set up empty irq routing when creating vm, so this is no
> need now.
>=20
> Signed-off-by: Yi Wang <foxywang@tencent.com>
> ---
>  arch/x86/kvm/irq.h      | 1 -
>  arch/x86/kvm/irq_comm.c | 5 -----
>  arch/x86/kvm/x86.c      | 3 ---
>  3 files changed, 9 deletions(-)
>=20
> diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
> index c2d7cfe82d00..76d46b2f41dd 100644
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -106,7 +106,6 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu);
>  int apic_has_pending_timer(struct kvm_vcpu *vcpu);
> =20
>  int kvm_setup_default_irq_routing(struct kvm *kvm);
> -int kvm_setup_empty_irq_routing(struct kvm *kvm);
>  int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
>  			     struct kvm_lapic_irq *irq,
>  			     struct dest_map *dest_map);
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index 68f3f6c26046..6ee7ca39466e 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -397,11 +397,6 @@ int kvm_setup_default_irq_routing(struct kvm *kvm)
> =20
>  static const struct kvm_irq_routing_entry empty_routing[] =3D {};

empty_routing is unused after this patch and can+should be removed, e.g.

arch/x86/kvm/irq_comm.c:398:43: error: =E2=80=98empty_routing=E2=80=99 defi=
ned but not used [-Werror=3Dunused-const-variable=3D]
  398 | static const struct kvm_irq_routing_entry empty_routing[] =3D {};

I'll fix this up when applying, too.

