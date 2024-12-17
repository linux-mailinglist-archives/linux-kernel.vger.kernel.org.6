Return-Path: <linux-kernel+bounces-450046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74419F5A11
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2024 00:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED77188F8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B111F9415;
	Tue, 17 Dec 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2NVqcAh"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646A1F7580
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476693; cv=none; b=EPUgy5K8fePgPcxNstLCBnfPu4r850opIOpsL0fuhednwetkz45a0PbgdjTquSSFzlDnXsnPVtg6WNKovBBt8F1Hq1+PAx8HQdu8uA3jTrDokrV+swjdtrm5OYgLmF3S4DZhQoJGsyfQ4VwzVsrxLbv5eBBLkgPVNYNPaZWMooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476693; c=relaxed/simple;
	bh=XZ3lZY7YPuIT9kE7LQuxqu6ER44s/CmPJSR8dPpzXes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q/D3II89L2O22h5K0zsjdJCAhkTnkEDqkrWb1T/PJ2DIYQEBkj4noYAVYcu1KmsvC7LOkM1u3eLInKrlHp4CkdUlGWKyzlN+7tROFB8I9iv/88BdsGDJ7oW965V9/78n9kDk3WP3WTKyKcKcunUtDTc9SP5sswdy/Yd8Xdjg0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2NVqcAh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163d9a730aso1468185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734476691; x=1735081491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDLc01X2cvI8MV3ZQqF6nuUBQgYTWnDBWugUpMKW8zg=;
        b=o2NVqcAhMlS+j2Hj3NxzVAjYSgV4to9ZR+tHoo22FuhqF9FrqKRPuA1YJME1dSij9K
         A6yFUvKfRkNEcFCwITr3wLSQa6QkMpWwGbQ7xHGxeXl1sJL17otwR7oZWw+0WrAbokxn
         DMRgHWIK0YaTxVd63ubMpAKH+gY3Ngy6+FYEGMu9fHIuc0PMuhN2soaFVBecUQr1dx6v
         O9Rr53f2zAzZE7vbnQR1LNpcNHFbyQLqmy4Be+REs2TzOCEnAGLx5nvpJed8eZ3QxAzH
         8VMXTVOiG+Cybj+I/DdZMTYlcquoQ3Y0vhAG5UI2Rsg88oRmMniqyDYi84ZRUOWbIuY9
         pqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476691; x=1735081491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDLc01X2cvI8MV3ZQqF6nuUBQgYTWnDBWugUpMKW8zg=;
        b=mWobarecDL564y5cj2E+eTBZ0n/Gz5OaiHTWa4/QKW5Jp7HHiL2+po0t+q9HXZ4HUB
         nbTu+IwjlnGxxaX5/2EaYm4SQjOAdyqPt7k/EJYW8D8DQVwzMivEmj75/L2esFUunfik
         bF4Wm0y5pa+11oX0OIPzxCVoKCZJxT0mPUdWbmr2strToTb4+GmmQRxAtQJiK/8O6Pup
         5q2pkwlXjTVSw1KTPlCOwCHx7dEHtHzwXTLEm5BYn4qf3YAL7yNkFfv4s+7tFUPeqBA5
         Zx8YELgGyuu+7cqjch5hjDtQYhgD7VOQJW6F9pgo/QXlpImS6TDh6TFIXehkIpOIG8tp
         0f4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJKondd72lnNiza5dNghBMDH5LweUdKzLMVmCxX9l5rKZqqAW12h37QN/8J5+u/NkcsP1jjXFY4VOlWCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0NY24HCgd6LQYhCqaMQrlvXWH+N+66aNtGLeDXuBxcYgwuFtz
	uHHQUusxHxBOW/yJbBGOCJzAvGIQAs+l3LzKcur6jJNzoHddgYBGJI2U0rRB5+cREKPAyqDbflc
	1nw==
X-Google-Smtp-Source: AGHT+IHiHp2mvJV3TolICh/BpIZ0tE3Au4sIY7AEUn4uKgyR4ubIbMfRhm4HgCqTCdFstvGDP1HrzS4etsI=
X-Received: from pgnh22.prod.google.com ([2002:a63:3856:0:b0:7fd:4bf0:25fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:216:1a59:5bbf
 with SMTP id d9443c01a7336-218c91362c8mr75348545ad.0.1734476691043; Tue, 17
 Dec 2024 15:04:51 -0800 (PST)
Date: Tue, 17 Dec 2024 15:04:49 -0800
In-Reply-To: <20241121065039.183716-1-zijie.wei@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121065039.183716-1-zijie.wei@linux.alibaba.com>
Message-ID: <Z2IDkWPz2rhDLD0P@google.com>
Subject: Re: [PATCH] KVM: x86: ioapic: Optimize EOI handling to reduce
 unnecessary VM exits
From: Sean Christopherson <seanjc@google.com>
To: weizijie <zijie.wei@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuyun <xuyun_xy.xy@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 21, 2024, weizijie wrote:
> Address performance issues caused by a vector being reused by a
> non-IOAPIC source.
> 
> commit 0fc5a36dd6b3
> ("KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race")
> addressed the issues related to EOI and IOAPIC reconfiguration races.
> However, it has introduced some performance concerns:
> 
> Configuring IOAPIC interrupts while an interrupt request (IRQ) is
> already in service can unintentionally trigger a VM exit for other
> interrupts that normally do not require one, due to the settings of
> `ioapic_handled_vectors`. If the IOAPIC is not reconfigured during
> runtime, this issue persists, continuing to adversely affect
> performance.
> 
> Simple Fix Proposal:
> A straightforward solution is to record the vector that is pending at
> the time of injection. Then, upon the next guest exit, clean up the
> ioapic_handled_vectors corresponding to the vector number that was
> pending. This ensures that interrupts are properly handled and prevents
> performance issues.
> 
> Signed-off-by: weizijie <zijie.wei@linux.alibaba.com>
> Signed-off-by: xuyun <xuyun_xy.xy@linux.alibaba.com>

Your SoB should be last, and assuming Xuyun is a co-author, they need to be
credited via Co-developed-by.  See Documentation/process/submitting-patches.rst
for details.

> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/ioapic.c           | 11 +++++++++--
>  arch/x86/kvm/vmx/vmx.c          | 10 ++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e159e44a6a1b..b008c933d2ab 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1041,6 +1041,7 @@ struct kvm_vcpu_arch {
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t hv_root_tdp;
>  #endif
> +	DECLARE_BITMAP(ioapic_pending_vectors, 256);
>  };
>  
>  struct kvm_lpage_info {
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 995eb5054360..6f5a88dc63da 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -284,6 +284,8 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, ulong *ioapic_handled_vectors)

The split IRQ chip mode should have the same enhancement.

>  	spin_lock(&ioapic->lock);
>  
> +	bitmap_zero(vcpu->arch.ioapic_pending_vectors, 256);

Rather than use a bitmap, what does performance look like if this is a single u8
that tracks the highest in-service IRQ at the time of the last scan?  And then
when that IRQ is EOI'd, do a full KVM_REQ_SCAN_IOAPIC instead of
KVM_REQ_LOAD_EOI_EXITMAP?  Having multiple interrupts in-flight at the time of
scan should be quite rare.

I like the idea, but burning 32 bytes for an edge case of an edge case seems
unnecessary.
 
> +
>  	/* Make sure we see any missing RTC EOI */
>  	if (test_bit(vcpu->vcpu_id, dest_map->map))
>  		__set_bit(dest_map->vectors[vcpu->vcpu_id],
> @@ -297,10 +299,15 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, ulong *ioapic_handled_vectors)
>  			u16 dm = kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
>  
>  			if (kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
> -						e->fields.dest_id, dm) ||
> -			    kvm_apic_pending_eoi(vcpu, e->fields.vector))
> +						e->fields.dest_id, dm))
> +				__set_bit(e->fields.vector,
> +					  ioapic_handled_vectors);
> +			else if (kvm_apic_pending_eoi(vcpu, e->fields.vector)) {
>  				__set_bit(e->fields.vector,
>  					  ioapic_handled_vectors);
> +				__set_bit(e->fields.vector,
> +					  vcpu->arch.ioapic_pending_vectors);
> +			}
>  		}
>  	}
>  	spin_unlock(&ioapic->lock);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0f008f5ef6f0..572e6f9b8602 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5710,6 +5710,16 @@ static int handle_apic_eoi_induced(struct kvm_vcpu *vcpu)
>  
>  	/* EOI-induced VM exit is trap-like and thus no need to adjust IP */
>  	kvm_apic_set_eoi_accelerated(vcpu, vector);
> +
> +	/* When there are instances where ioapic_handled_vectors is
> +	 * set due to pending interrupts, clean up the record and the
> +	 * corresponding bit after the interrupt is completed.
> +	 */
> +	if (test_bit(vector, vcpu->arch.ioapic_pending_vectors)) {

This belongs in common code, probably kvm_ioapic_send_eoi().

> +		clear_bit(vector, vcpu->arch.ioapic_pending_vectors);
> +		clear_bit(vector, vcpu->arch.ioapic_handled_vectors);
> +		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
> +	}
>  	return 1;
>  }
>  
> -- 
> 2.43.5
> 

